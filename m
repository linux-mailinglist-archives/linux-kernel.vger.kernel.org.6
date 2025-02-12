Return-Path: <linux-kernel+bounces-510940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42C5A323D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6213A7CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE9209F53;
	Wed, 12 Feb 2025 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TMR5XmCv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C72209677;
	Wed, 12 Feb 2025 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357308; cv=none; b=tGpOfvS8EThon7pzV+kTONUDAdwA2FZp9T2JjvrK1Jz8O73OTXRx7uD/SOiyrIFtv26QgI3eiyhIHN9leRZ5ooR70cTJ6UJlAgei/tL+55s86ppiT/b1/6Io9hFmWF9NVcZ6Cizgc7kEP0r5kzE+yM1fqhIPP+xuqee6rm4/vvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357308; c=relaxed/simple;
	bh=MDzi94+7DXP8gki44yU/WMmcUnnz896qVa5iXKJmYdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itplnomg+e+69AdlxZRdgUa8B/G8f7/3eb3O7b86Z0HEs9Ghg2f8vLAczA2uPT2xU07PfuM/iEVSzIr4z838du7ZbgVKFWrI6L+DLOCsrmK5DQwHGFQ8cq6uMhTluRgKiPZLIk1DeX+b0Bi+ASZxAi8Wn8Ef1SK3SW6fsRL8iW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TMR5XmCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B85C4CEDF;
	Wed, 12 Feb 2025 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739357307;
	bh=MDzi94+7DXP8gki44yU/WMmcUnnz896qVa5iXKJmYdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMR5XmCv03tfHX7I53UpQYNvbhR6rOKNvq589jk8YUun8HdFzzdq/KL3Ah5GHyImH
	 XL06WiLcWYnr2QVip5Fc+bFM0rDwJARBf8hGikiCPSRjoVFxqZDwuRMD24I+ywQXOr
	 PJHdZipeEf3CzAjLCPztGHcG5YN0Vrg1ZB68njx0=
Date: Wed, 12 Feb 2025 11:47:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: heikki.krogerus@linux.intel.com, andre.draszik@linaro.org,
	linux@roeck-us.net, shufan_lee@richtek.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, pablo.sun@mediatek.com
Subject: Re: [PATCH] usb: typec: tcpci_rt1711h: Unmask alert interrupts to
 fix functionality
Message-ID: <2025021214-snowshoe-shortly-602d@gregkh>
References: <20250212104040.38723-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212104040.38723-1-angelogioacchino.delregno@collabora.com>

On Wed, Feb 12, 2025 at 11:40:40AM +0100, AngeloGioacchino Del Regno wrote:
> During probe, the TCPC alert interrupts are getting masked to
> avoid unwanted interrupts during chip setup: this is ok to do
> but there is no unmasking happening at any later time, which
> means that the chip will not raise any interrupt, essentially
> making it not functional as, while internally it does perform
> all of the intended functions, it won't signal anything to the
> outside.
> 
> Unmask the alert interrupts to fix functionality.
> 
> Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 64f6dd0dc660..c71b213b2441 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -334,6 +334,11 @@ static int rt1711h_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct rt1711h_chip *chip;
> +	const u16 alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
> +			       TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
> +			       TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
> +			       TCPC_ALERT_CC_STATUS | TCPC_ALERT_RX_BUF_OVF |
> +			       TCPC_ALERT_FAULT;
>  
>  	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
> @@ -384,6 +389,11 @@ static int rt1711h_probe(struct i2c_client *client)
>  		return ret;
>  	enable_irq_wake(client->irq);
>  
> +	/* Enable alert interrupts */
> +	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
>  
> -- 
> 2.48.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

