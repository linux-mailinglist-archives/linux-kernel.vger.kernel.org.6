Return-Path: <linux-kernel+bounces-334995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1534797DF7F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E26FB2135E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCC7154434;
	Sat, 21 Sep 2024 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9KlDLf6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631723D7
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726958960; cv=none; b=Qc0/xV/qDJY5or2qpByrRxS1eMv1OOOS90xgX7++aA1swhWAxaKqkBMw+OCW0CJkp45yl0VQdoWGhddIRA19/LdgSEJ1vekHG6f5zRNgouRNQSFL2hKHs+iIG6o7HFd1gXetDZS5Wzsh9GulNdTgaTPLTNh59FxN9DQsQEy2vIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726958960; c=relaxed/simple;
	bh=1TPucVPoSvEG52yByj8PyoROIGhT4Lou8OVQClwVVUE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8+RcwTL3jI1bGAhgyNQ3rNH6sUU2mJ3s1ficUHEesHnRi63TtsEKdppI1SsYRUqZKyb5KiS/xPQoN9j7G34jB5H/jWEDvw5osp0D0GsQZ2gTOiD3IsmsQyqnRIZDnbJKkboLBd6dUg7CVSR5h7dUqs9CWdbHtxT0Qv+N5prOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9KlDLf6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so27693085e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726958957; x=1727563757; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2Re9xR031LHZafhr3mewtyenLgEBV6+MsBXtzbFkLE=;
        b=c9KlDLf6nDoIV1WRNJgkblNhW2PMJMFepq4YLtw+/QRWMlCLGcJNZVJAP1gqZF8+9K
         Gf2SVhAMDpMA/4IkZK1h9Ge/u2pbNKdq67z8QG4JywVLOfJBafKiBGjnNgifS4P1uEZN
         UiunpRBy+czrrxoxqA1We9TONBKQxQrmi10I9KLUdybWoXWn1p6Q6XfTl85OT13iYbXp
         zOoLL94lBPg4ZQpXHmnMWihBpW4ov88rm1SxSx80kBY57q1rAdzCD9xiZS/AEffigPeP
         iBvq3HoHAZQpjpH9y2mzAnVcF6VF99+LYndsqpCjLgH2c4W39ZTx8vst/p8qAfBL0GTB
         yBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726958957; x=1727563757;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2Re9xR031LHZafhr3mewtyenLgEBV6+MsBXtzbFkLE=;
        b=BLcxet+XUNpTiK6y3T89UKTj7mOeuKNu7pJ2NGT7LNeszJWG/DbFBgnxNITeSAez7d
         9WcBHjQR2OLjCz3tJABf/laPEApukIfc3HDew8LEIa6AgNSx9RH66ttiUPQ/UjKznKtY
         BzA55WkOz1Z5ojtxYw/LTpMt0jzc5eJuzdWOt3V5+uHk3NdsLa79N2HXC/1PwR3ztCj9
         JqKlgFaKfGf31JZ4AqBOCDBQEN7vx+SRsDyfc2b3tLfl5kDFiw9HJY4H7il1ibQJYzbq
         dJiNBxhmCcrta1epgWQS18YYPoTuCZgCcLBKpDPWpOA/Pw/VDXyjOv++FEQE+v8SBDuU
         tIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYdQK6cpBgJl4Q48SXOd08IpKbrfxOkboXrD55cNsjY9fBCOOqjSwLRr8XGCfUPdoBraXSfxfrER02lyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqaTnIku2nuFSd2i7a/xwMsyhv2zfczX4uwaVAPRmG2dgMiYR
	/FdZT4qrEajI5BLG1ckt+vkim9P6DrqQJU6EJbhyzjZcHzXY0moM
X-Google-Smtp-Source: AGHT+IENoESqUg51vOUO5Jqs55cztwsnS31Wlhx5yNxUnd5wxahEMPAAAliHYVBiHwDXVwKbKTFqbg==
X-Received: by 2002:a05:600c:4f47:b0:42c:aeaa:6aff with SMTP id 5b1f17b1804b1-42e7adc52admr51213715e9.10.1726958956793;
        Sat, 21 Sep 2024 15:49:16 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e4f9sm87419395e9.1.2024.09.21.15.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 15:49:16 -0700 (PDT)
Message-ID: <8f3c9f97d2de59ba73bf3c50f16d262d68ef4b2d.camel@gmail.com>
Subject: Re: [PATCH 4/4] soc: marvell: rvu-pf: Handle function level reset
 (FLR) IRQs for VFs
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Anshumali Gaur <agaur@marvell.com>, conor.dooley@microchip.com, 
	ulf.hansson@linaro.org, arnd@arndb.de, linus.walleij@linaro.org, 
	nikita.shubin@maquefel.me, vkoul@kernel.org, cyy@cyyself.name, 
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com
Date: Sun, 22 Sep 2024 00:49:38 +0200
In-Reply-To: <20240920112318.2722488-5-agaur@marvell.com>
References: <20240920112318.2722488-1-agaur@marvell.com>
	 <20240920112318.2722488-5-agaur@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Anshumali!

On Fri, 2024-09-20 at 16:53 +0530, Anshumali Gaur wrote:
> Added PCIe FLR interrupt handler for VFs. When FLR is triggered for VFs,
> parent PF gets an interrupt. PF creates a mbox message and sends it to
> RVU Admin function (AF). AF cleans up all the resources attached to that
> specific VF and acks the PF that FLR is handled.
>=20
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> ---

[]

> diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c b/drivers/soc/marvel=
l/rvu_gen_pf/gen_pf.c
> index 624c55123a19..e2e7c11dd85d 100644
> --- a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
> +++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
> @@ -691,6 +700,211 @@ static int rvu_gen_pf_register_pfvf_mbox_intr(struc=
t gen_pf_dev *pfdev, int numv
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static void rvu_gen_pf_flr_handler(struct work_struct *work)
> +{
> +	struct flr_work *flrwork =3D container_of(work, struct flr_work, work);
> +	struct gen_pf_dev *pfdev =3D flrwork->pfdev;
> +	struct mbox *mbox =3D &pfdev->mbox;
> +	struct msg_req *req;
> +	int vf, reg =3D 0;
> +
> +	vf =3D flrwork - pfdev->flr_wrk;
> +
> +	mutex_lock(&mbox->lock);
> +	req =3D gen_pf_mbox_alloc_msg_vf_flr(mbox);

So this function want's to be a product of "M" macro from patch 2?
But does it really happen?

> +	if (!req) {
> +		mutex_unlock(&mbox->lock);
> +		return;
> +	}
> +	req->hdr.pcifunc &=3D RVU_PFVF_FUNC_MASK;

Did you mean "req->hdr.pcifunc &=3D ~RVU_PFVF_FUNC_MASK;"?

> +	req->hdr.pcifunc |=3D (vf + 1) & RVU_PFVF_FUNC_MASK;
> +
> +	if (!rvu_gen_pf_sync_mbox_msg(&pfdev->mbox)) {
> +		if (vf >=3D 64) {
> +			reg =3D 1;
> +			vf =3D vf - 64;
> +		}
> +		/* clear transcation pending bit */
> +		writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFTRPENDX(reg));
> +		writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFFLR_INT_ENA_W1SX(reg));
> +	}
> +
> +	mutex_unlock(&mbox->lock);
> +}
> +
> +static irqreturn_t rvu_gen_pf_me_intr_handler(int irq, void *pf_irq)
> +{
> +	struct gen_pf_dev *pfdev =3D (struct gen_pf_dev *)pf_irq;
> +	int vf, reg, num_reg =3D 1;
> +	u64 intr;
> +
> +	if (pfdev->total_vfs > 64)
> +		num_reg =3D 2;
> +
> +	for (reg =3D 0; reg < num_reg; reg++) {
> +		intr =3D readq(pfdev->reg_base + RVU_PF_VFME_INTX(reg));
> +		if (!intr)
> +			continue;
> +		for (vf =3D 0; vf < 64; vf++) {
> +			if (!(intr & BIT_ULL(vf)))
> +				continue;
> +			/* clear trpend bit */
> +			writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFTRPENDX(reg));
> +			/* clear interrupt */
> +			writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFME_INTX(reg));
> +		}
> +	}

Should anything else have been performed in the IRQ handler besides acknowl=
edging the
IRQ request?

> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rvu_gen_pf_flr_intr_handler(int irq, void *pf_irq)
> +{
> +	struct gen_pf_dev *pfdev =3D (struct gen_pf_dev *)pf_irq;
> +	int reg, dev, vf, start_vf, num_reg =3D 1;
> +	u64 intr;
> +
> +	if (pfdev->total_vfs > 64)
> +		num_reg =3D 2;
> +
> +	for (reg =3D 0; reg < num_reg; reg++) {
> +		intr =3D readq(pfdev->reg_base + RVU_PF_VFFLR_INTX(reg));
> +		if (!intr)
> +			continue;
> +		start_vf =3D 64 * reg;
> +		for (vf =3D 0; vf < 64; vf++) {
> +			if (!(intr & BIT_ULL(vf)))
> +				continue;
> +			dev =3D vf + start_vf;
> +			queue_work(pfdev->flr_wq, &pfdev->flr_wrk[dev].work);
> +			/* Clear interrupt */
> +			writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFFLR_INTX(reg));
> +			/* Disable the interrupt */
> +			writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFFLR_INT_ENA_W1CX(reg))=
;
> +		}
> +	}
> +	return IRQ_HANDLED;
> +}

[]

--=20
Alexander Sverdlin.


