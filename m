Return-Path: <linux-kernel+bounces-248713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A092E102
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40A51C21084
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9F14AD3A;
	Thu, 11 Jul 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rPKjaLOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADBC1474D3;
	Thu, 11 Jul 2024 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683709; cv=none; b=Evao0qJH1UqzqvrLFGYQNJ/eizWCfVn4gBcNrQJCw1Ze3/zCTui4asJ1r8VYoHBKo+bbNkMbgT8Ody/oQp6t48h/iudGtIXSLUmqK8yMbwxac/F7wbgxh32s39yxiBEAZRbqdoaixiDMrYtSF+MiinGDCc/UCsbaZE/2ZcuGtB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683709; c=relaxed/simple;
	bh=/VryOXJPCZMkmZNtKvVFMLdICO254DnaenyxLgQZB28=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REblSg9GOBRTME4JQoUhsmLz0Vz9aexdFBz9X1IluXeLSLnKxhik9M8+RUPywBddDcfYIJ/LCV8DoxIeFnouEA81+SjNpzBOY7SZv+Uy9RPW1kMBS1A2gEbScKvc4Mm4yuYQUtNX1vRD5VyS1SgEDXJdCWJ1HTvlyn050phuB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rPKjaLOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347C2C116B1;
	Thu, 11 Jul 2024 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720683708;
	bh=/VryOXJPCZMkmZNtKvVFMLdICO254DnaenyxLgQZB28=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=rPKjaLOkuNjkEs1KUQ0nAjpD/SDRQRy039lXVwX7agX6OKhbpsatUTs3+hus5juGI
	 5j50h8TUNvss09HEFoGctjv7Uf/ufwz7QFWeC0xbhOfURMMNE6+HgnpqkJCBicZkVN
	 5eF+UoLZG6wnoypir2Vx2/+My3FJPmIbQlkOL+Ow=
Date: Thu, 11 Jul 2024 09:41:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>, ryan <ryanzhou54@gmail.com>,
	jikos@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: usbhid: Enable remote wake-up based on device
 configuration
Message-ID: <2024071104-rental-bleak-b273@gregkh>
References: <20240710231606.3029-1-ryanzhou54@gmail.com>
 <f0c789d8-8ae0-4a46-a5b3-aa9a5a758915@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c789d8-8ae0-4a46-a5b3-aa9a5a758915@rowland.harvard.edu>

On Wed, Jul 10, 2024 at 09:47:39PM -0400, Alan Stern wrote:
> On Thu, Jul 11, 2024 at 07:16:06AM +0800, ryan wrote:
> > According to the USB protocol, the host should automatically
> > adapt the remote wake-up function based on the configuration
> > descriptor reported by the device, rather than only the default
> > keyboard support. Therefore, it's necessary to support other hid
> > devices, such as digital headsets,mice,etc.
> 
> It's true that the host shouldn't try to enable remote wakeup if the 
> configuration descriptor shows that the device doesn't support it.
> 
> However, it's not true that the host should try to enable remote wakeup 
> for devices other than keyboards with boot-protocol support.  History 
> has shown that quite a few HID devices don't handle remote wakeup 
> properly; the decision about whether to enable it should be left to the 
> user.

I agree, this patch isn't acceptable.  Ryan, why do you want this
applied?  What userspace control is missing to allow you to do this
today on your systems with no kernel changes for devices that you know
will work properly?

thanks,

greg k-h

