Return-Path: <linux-kernel+bounces-232463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BE891A928
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D718E282A67
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7D195FEC;
	Thu, 27 Jun 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SHfm2Umv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE901195FC2;
	Thu, 27 Jun 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498297; cv=none; b=eN0XB8H9vmumMj7/j62sOY9kpyrGvVPxzewBJkp6Pb8B5HwyXuioV4QqdDyrTwlmWRXP+RqiePGKyYarknd0CJabEn7yMKmBTOHpoqi7Ku9317m4fUTW35mEbmyYzRg5SrfNIeLFbZr6TikyQaVAUm35sffVkUJGDaVbXP14gw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498297; c=relaxed/simple;
	bh=l8S2NLU8nN28tDau6fsqvcxbCr3OTY3zuVdmVmvCWdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwVVY+X3Hhs5g8ehg4QFQHLK1CaZfS4QS8BQQDanIENtujwknYAuX45bUnwD9+YDgALK3k+KitlSWu+dhZ/xvobRId1w5y9vKW9fNe/QkRQw5ITqD048g63rrJBuQjJJVHWRZBv2Bg8tBurrufwwqnj77tGLeR0gMsckkgoRXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SHfm2Umv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48A4C2BBFC;
	Thu, 27 Jun 2024 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719498296;
	bh=l8S2NLU8nN28tDau6fsqvcxbCr3OTY3zuVdmVmvCWdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHfm2UmvijzvcxQhVD9UP5tuHqWsPudnBQIAkmvqClaJ1+OzFyouhxXPWbTaspyju
	 ZcFzedSfNqhJIT2l334HJ4E0Cfu6NhGYtOvat+NNuHDyjdo4SVxQESZ68zgw2QTucK
	 K100CGO+pzBfeG9aMsposzVCq1iV89uUnDCFq/io=
Date: Thu, 27 Jun 2024 16:24:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ferry Toth <ftoth@exalondelft.nl>
Cc: Richard Acayan <mailingradian@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	s.hauer@pengutronix.de, jonathanh@nvidia.com, paul@crapouillou.net,
	quic_eserrao@quicinc.com, erosca@de.adit-jv.com,
	regressions@leemhuis.info
Subject: Re: [PATCH v3 0/2] usb: gadget: u_ether: revert netif_device_detach
 change
Message-ID: <2024062740-vowed-giddy-2aa7@gregkh>
References: <20240620204832.24518-1-ftoth@exalondelft.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620204832.24518-1-ftoth@exalondelft.nl>

On Thu, Jun 20, 2024 at 10:46:40PM +0200, Ferry Toth wrote:
> As agreed with the author, the netif_device_detach change is going to be reverted by
> this series, so we will collaborate on a new one in the future that
> brings no regressions.
> 
> v3:
> - Send out actual version (Ferry)

Much better, thanks, now queued up!

greg k-h

