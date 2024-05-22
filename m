Return-Path: <linux-kernel+bounces-185760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD38CBA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D32282CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED775817;
	Wed, 22 May 2024 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GiF5Sfso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675482F52;
	Wed, 22 May 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716352562; cv=none; b=e+hYFG7rhibSIWZiNGWhhaBtOFXOD4/rpDXgMmiljSY9cseh7+dDa9X7Icbfrc46ggPK2H/BGYsD7PwVPkgTucgizcj5MwHMzdPTLfAM0JldqXIEhmKy6hXoSJx+LaIXd49eYE7HboN3ZNIe2YVj35KD2lC3em1lo6f6jEI168M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716352562; c=relaxed/simple;
	bh=+Ui859yHA7et8e6IQkqiHGsxSTRX1Ecehbrq71kQQRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=te9JESSiTM5/vE6+gLjAkRnPLms/YODT1b8i/Ui7UUvrB+lvYrUk0kXrK2lzZuNmg8tZCtfYfoSQ9FSlnpYheKJ1MvF24X2oEzP9zsSIIdlUH6XGs1saO9xtfmiM0FwHKjfi5trSKCZdfTSrUEmm426GWUix4Ffbs6Bfdu47Emk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GiF5Sfso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834A6C2BD11;
	Wed, 22 May 2024 04:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716352562;
	bh=+Ui859yHA7et8e6IQkqiHGsxSTRX1Ecehbrq71kQQRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GiF5SfsoXOAu3TRiMiElPFRtSnWmjmqHYLEO+ZeOBlX3MxSKybdeAHTFO0dJuJRVd
	 l4PgMr3Or3Qq5GYRwspWizj59dFbydJL/o+LKlfZzR0ZJTc74YZ9pKxdoHPPI/1RvW
	 OtI7qY8ROscvE8iB7/xWdICgm38A83uFFSqrONzc=
Date: Wed, 22 May 2024 06:35:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] xhci: Apply broken streams quirk to Etron EJ188 xHCI
 host
Message-ID: <2024052244-gallantly-attic-a020@gregkh>
References: <20240522023918.7613-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522023918.7613-1-ki.chiang65@gmail.com>

On Wed, May 22, 2024 at 10:39:17AM +0800, Kuangyi Chiang wrote:
> As described in commit 8f873c1ff4ca ("xhci: Blacklist using streams on the
> Etron EJ168 controller"), EJ188 have the same issue as EJ168, where Streams
> do not work reliable on EJ188. So apply XHCI_BROKEN_STREAMS quirk to EJ188
> as well.
> 
> Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> ---
>  drivers/usb/host/xhci-pci.c | 1 +
>  1 file changed, 1 insertion(+)

Should this go to stable kernels, if so, how far back?

thanks,

greg k-h

