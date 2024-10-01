Return-Path: <linux-kernel+bounces-346605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE9998C696
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA85284798
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F81CDFB6;
	Tue,  1 Oct 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TkkmKc3A"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F031C7B83
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813723; cv=none; b=HpY8lQ8SPvVxCCFS7oBC6rgM1kmxD4b8XoL2LkRV2D1+ODtQGurWCui8m2WtO7wU86pzVaAIBVGUaTGgyI45Bof6UPIvsGVDURHbs9HYeVaEJEXg1G4v9G9YIspvHufwSP0oXaiw6DVJEM8RCc60mu9iQYA4zIkJkqFozfuQtuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813723; c=relaxed/simple;
	bh=ClRUkUeUojv7NVZJNhAM1y9ZnjIkXjwjDTMvzl96td8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOMGZgPOAlpdhJv8Xu/zxkBBdY6hSwHQLMHXWRcOhbaz7VfXgBYHhZfaUEXQ9PptoX6oIrYJ6PCj9dRX77upQd+A7BfJ+Qp/5NU9/vEcS+by9dq9TtibeHg2cZ51CZ1BU+JxWoiK0npQTZFZxKurBH9iLr+IBH0KtIHJaawKvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TkkmKc3A; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E617A60003;
	Tue,  1 Oct 2024 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727813713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQJpm4VO4nXgcGNm9i9gLOY8aV30KkAXa+C6ebyrRxY=;
	b=TkkmKc3AAoYxmKBplahY0/NL007XhBTzr+zYuf4cpbr6A/nAQmGwSSqwJJ95BgIt6jyNtX
	bHcxU1tulTsjkWiJc2Uzq2Nmv8OIHP7V+xbGy1kE6gN2pb1/hni2no+Qe0LZgqqrspf1BJ
	tErhj7aJkqwbX0XTlfXEsU5ZZ9gucj4h3Jp2sMG2iyx5cNxcSRjhEifeqXF4Q2kfm4Rqyu
	lirN4gVLciU2lowjVhQu9mMIQUE4GdGSZjV09U/rdwLnioihZq2lSD0MDNXOEBcdXe7mD+
	AJ56Q297sIldkvwyk5xPgusCh9Gm52trA2afq+PYU+XgYddLczGGvzni2jXeiA==
Date: Tue, 1 Oct 2024 22:15:09 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v5 4/6] i3c: master: svc: use spin_lock_irqsave at
 svc_i3c_master_ibi_work()
Message-ID: <20241001221509.7d418d15@xps-13>
In-Reply-To: <20241001-svc-i3c-hj-v5-4-480ab8aed849@nxp.com>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
	<20241001-svc-i3c-hj-v5-4-480ab8aed849@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Tue, 01 Oct 2024 12:02:53 -0400:

> According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:
>=20
> The I3C Controller shall hold SCL low while the Bus is in ACK/NACK Phase =
of
> I3C/I2C transfer. But maximum stall time is 100us. The IRQs have to be
> disabled to prevent schedule during the whole I3C transaction, otherwise,
> the I3C bus timeout may happen if any irq or schedule happen during
> transaction.
>=20
> Replace mutex with spin_lock_irqsave() to avoid stalling SCL more than
> 100us.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3-v4
> - improve commit message
> - needn't mutex here, other place already use spin_lock_saveirq to protent
> i3c transfer.
> ---
>  drivers/i3c/master/svc-i3c-master.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 5df0ec02d73ce..1ee6ce186195c 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -436,7 +436,16 @@ static void svc_i3c_master_ibi_work(struct work_stru=
ct *work)
>  	u32 status, val;
>  	int ret;
> =20
> -	mutex_lock(&master->lock);
> +	/*
> +	 * According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:
> +	 *
> +	 * The I3C Controller shall hold SCL low while the Bus is in ACK/NACK P=
hase of I3C/I2C
> +	 * transfer. But maximum stall time is 100us. The IRQs have to be disab=
led to prevent
> +	 * schedule during the whole I3C transaction, otherwise, the I3C bus ti=
meout may happen if
> +	 * any irq or schedule happen during transaction.
> +	 */
> +	guard(spinlock_irqsave)(&master->xferqueue.lock);
> +
>  	/*
>  	 * IBIWON may be set before SVC_I3C_MCTRL_REQUEST_AUTO_IBI, causing
>  	 * readl_relaxed_poll_timeout() to return immediately. Consequently,
> @@ -456,7 +465,7 @@ static void svc_i3c_master_ibi_work(struct work_struc=
t *work)
>  	       master->regs + SVC_I3C_MCTRL);
> =20
>  	/* Wait for IBIWON, should take approximately 100us */
> -	ret =3D readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
> +	ret =3D readl_relaxed_poll_timeout_atomic(master->regs + SVC_I3C_MSTATU=
S, val,
>  					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);

If we now are holding a spinlock and expect this to happen within
100us, then I guess the timeout should be reduced?

>  	if (ret) {
>  		dev_err(master->dev, "Timeout when polling for IBIWON\n");
> @@ -529,7 +538,6 @@ static void svc_i3c_master_ibi_work(struct work_struc=
t *work)
> =20
>  reenable_ibis:
>  	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
> -	mutex_unlock(&master->lock);
>  }
> =20
>  static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
>=20

Otherwise,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l

