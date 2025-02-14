Return-Path: <linux-kernel+bounces-514560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC6A3588A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364243A9A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CD3221D9B;
	Fri, 14 Feb 2025 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BKpybcMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA484037;
	Fri, 14 Feb 2025 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520649; cv=none; b=pbu4lDsqhVja/0qohclAP9zyk/PbCXKYoTbQOvGMgz/Zg2P2IsPO7imqC1artssaXbdnwFKWlqgG//64pa+2aDbAYk3Jedp3YBpcHJLBfYd77tIpURMPA/IgV5I5O3hEw4r7jP0zcx1Opq3t/KY6U7PGIsBTeNUYJ8yLHO9Odxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520649; c=relaxed/simple;
	bh=L1tWijiBafi2wIa+FkUtmkhwmnQFgOwBS4iKLKfor+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbXSbbuITfQ65HoowftGqR6780MhPklSjBsJ/La5kjsC2twJ6YfMDU7axHgrMaWAm0cfTgvdqOKCcq4zsqJInZ7EQiWQu1j6O7C9nyvxmbACGdw5oKsG4sP19+U+Df5PTdvW1l9gRCQZjzQCUYP2Zvh3K5VK2sq9fHVDldQwz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BKpybcMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66330C4CED1;
	Fri, 14 Feb 2025 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739520648;
	bh=L1tWijiBafi2wIa+FkUtmkhwmnQFgOwBS4iKLKfor+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKpybcMJ4Q6Ld5g5K1Ez4lk5/EulPqk8UPXtgP68Xytej8KeWDb0Xue75M55kUliB
	 hmWu8uklNFDnsDyZq/oE1QbmkVlqzhYuOt4M5+jViyasX6ZDC43x/uzScGNCHwpaqy
	 T1TJg3UHA4cmSbSq+NtjmVBpVitJLJ4OjsTzHdVs=
Date: Fri, 14 Feb 2025 09:10:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: heikki.krogerus@linux.intel.com, andre.draszik@linaro.org,
	linux@roeck-us.net, shufan_lee@richtek.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, pablo.sun@mediatek.com
Subject: Re: [PATCH] usb: typec: tcpci_rt1711h: Unmask alert interrupts to
 fix functionality
Message-ID: <2025021424-uncurious-slicer-b35f@gregkh>
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

If this fails, don't you then need to disable the wake irq you just
enabled?  If not, why not?

thanks,

greg k-h

