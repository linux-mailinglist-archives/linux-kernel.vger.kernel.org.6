Return-Path: <linux-kernel+bounces-434214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754529E635D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B7A168193
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633F13BAC3;
	Fri,  6 Dec 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC25vmus"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C343ABD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448336; cv=none; b=Yrry13MYmKcX/TkiVqh8aV6chxvLJqYjyswEX2H4Ti/f4yoJtqEwRBtXk18U3aPYC4cd2HenYWjra36jnPP1+8mgFQrb+VnPX6AgDPFFSW86Ky2ghtBlFeu5h/wqlj4PKSqzntg4dXeIvZqizA5QFN6OnZy52MVL2VdxTsmL9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448336; c=relaxed/simple;
	bh=zLAmk+CSNIIfq3xOOA6LXUW1i0SFDfq8y16QqT7+pwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KigyMnEObCA/6ALRJztUhXeZayi8aOn4wYClTO8afbBhIMbbGT5LgCNSVxYPPw6U6ADhUTXiBRvzdxFHWYdO18HaPtDW4u0ytnBH81zLYYZqRtt0evxH2hf0JdagMu3QsaccTeHHQx8QdDaajSOUfgr8QtyMX0Rtnk7OqxsdkaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC25vmus; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733448333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMJdMfEVxUjzOv6vViRajs+c2usHfla48Mpk2GLYF8c=;
	b=OC25vmuskMLpIaKr+61oYCBTq7Rw9WfDJrqgfKOdR/+GuvjH5YI63PZgIXpWiHLotfEfd7
	2TSJuzURdgJYe6k9DpUnSlJsd5vfocZJz48l5Iqa0gSv2bHqQE7rCaHI2+0JwkgYrLYUKr
	oTkO4IsBnlYA8uQQHX8p0upstcxoYIE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-IpDSTHS6OHSdhlu8A6wVXA-1; Thu, 05 Dec 2024 20:25:32 -0500
X-MC-Unique: IpDSTHS6OHSdhlu8A6wVXA-1
X-Mimecast-MFC-AGG-ID: IpDSTHS6OHSdhlu8A6wVXA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso1578914a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733448331; x=1734053131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMJdMfEVxUjzOv6vViRajs+c2usHfla48Mpk2GLYF8c=;
        b=uPocE+EB68XP9zxQg+2DG/goRBrzWWzGNAY/NwMPtGfRV0e7VYDWbna4PhD4wt/x6f
         eXojrAf/ds/0hSbsG1IE9Y55leqaXVwMxyEKlngdPIC/ki9XEc7/5tR2PrNHZwZtmZ4R
         3qZ20iFDEirtL1bn/86SQpXyBMcBd0r+dEpYnn6RdHuUNSO/BT1USOc3WNYyFtfh+wTu
         Xws5KjbfJLoklm97haWi3pzlnq+E9rdui3VSUn7NYrSfsbWv28GMhoK9sd3ZEgA1aBNB
         JNDxSsIbMNjRw8oC4RlH2NwoAvU7T/nPEwTMKjY3Ip57VvnOIdGiHRPgECtPXIrqXQ6R
         PNTw==
X-Forwarded-Encrypted: i=1; AJvYcCWPCEoEVYZMkfEU55muGpQ9Y8Z6nottWQ84ijK7AacUoEBx1HZxK9bKNVRJWA4S+LKoGY8Tfhemvxm9ut4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4CKSKPUrLLdBKZxW6HJiXQySQ/ZQ2/7eEnM8w2UnZngyDFau
	1YWXvguR9SJA9zuHTm31ibaGMtesN2EE48exZbF5kwBATGwFKCTfjS947Zok98ZAlGKDGrrIVvv
	i2NyOdHeiou+obrMVxkAxYGLpxtzCIbW8BOQ04BWpGSBQaPlDk8d8AQhgQOXJpnEfgcJVnTdApd
	sDCVR8xhBOAdHk8aK+ZIK+0rT9EZCI41PcZJIb
X-Gm-Gg: ASbGncu0n2XiItiUp79yvmp8ag5IvD27KZi3mdL3Bj5UVtBYOyvw8q8kN//0ETgGyiu
	fhP/G6tuel/KpUAZSOGTcuinDZGKpwq1I2Q==
X-Received: by 2002:a17:90b:37c3:b0:2ee:aa95:6de9 with SMTP id 98e67ed59e1d1-2ef6ab29c33mr1941757a91.33.1733448331212;
        Thu, 05 Dec 2024 17:25:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBZdBWi/TRlcNmYZAEPvPbMydw1ulYuSuDmflFbW1IxATFoyHqvnEz+Poaku7S/hXpVfQTK1d5HluUjYC1DRM=
X-Received: by 2002:a17:90b:37c3:b0:2ee:aa95:6de9 with SMTP id
 98e67ed59e1d1-2ef6ab29c33mr1941722a91.33.1733448330793; Thu, 05 Dec 2024
 17:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121134002.990285-1-sthotton@marvell.com>
In-Reply-To: <20241121134002.990285-1-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 09:25:19 +0800
Message-ID: <CACGkMEueyPOfgA4W72CMCZHP06fHw07PxbpvKzxm=O2udhRLxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:45=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Updated the driver to utilize all the MSI-X interrupt vectors supported
> by each OCTEON endpoint VF, instead of relying on a single vector.
> Enabling more interrupts allows packets from multiple rings to be
> distributed across multiple cores, improving parallelism and
> performance.
>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
> v1:
> - https://lore.kernel.org/virtualization/20241120070508.789508-1-sthotton=
@marvell.com
>
> Changes in v2:
> - Handle reset getting called twice.
> - Use devm_kcalloc to allocate irq array.
> - IRQ is never zero. Adjusted code accordingly.
>
>  drivers/vdpa/octeon_ep/octep_vdpa.h      | 10 +--
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   |  2 -
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 90 ++++++++++++++++--------
>  3 files changed, 64 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep=
/octep_vdpa.h
> index 046710ec4d42..2d4bb07f91b3 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa.h
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> @@ -29,12 +29,12 @@
>  #define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25))
>  #define OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17))
>  #define OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
> -
> -#define OCTEP_EPF_RINFO_RPVF(val) (((val) >> 32) & 0xF)
> -#define OCTEP_EPF_RINFO_NVFS(val) (((val) >> 48) & 0x7F)
> +#define OCTEP_VF_IN_CTRL(x)        (0x00010000 | ((x) << 17))
> +#define OCTEP_VF_IN_CTRL_RPVF(val) (((val) >> 48) & 0xF)
>
>  #define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED
>  #define OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
> +#define OCTEP_MAX_CB_INTR          8
>
>  enum octep_vdpa_dev_status {
>         OCTEP_VDPA_DEV_STATUS_INVALID,
> @@ -50,7 +50,6 @@ struct octep_vring_info {
>         void __iomem *notify_addr;
>         u32 __iomem *cb_notify_addr;
>         phys_addr_t notify_pa;
> -       char msix_name[256];
>  };
>
>  struct octep_hw {
> @@ -68,7 +67,8 @@ struct octep_hw {
>         u64 features;
>         u16 nr_vring;
>         u32 config_size;
> -       int irq;
> +       int nb_irqs;
> +       int *irqs;
>  };
>
>  u8 octep_hw_get_status(struct octep_hw *oct_hw);
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon=
_ep/octep_vdpa_hw.c
> index 1d4767b33315..d5a599f87e18 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> @@ -495,8 +495,6 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struc=
t pci_dev *pdev)
>         if (!oct_hw->vqs)
>                 return -ENOMEM;
>
> -       oct_hw->irq =3D -1;
> -
>         dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->features=
);
>         dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw->nr_vring);
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_main.c
> index cd55b1aac151..e10cb26a3206 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -47,13 +47,30 @@ static struct octep_hw *vdpa_to_octep_hw(struct vdpa_=
device *vdpa_dev)
>  static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
>  {
>         struct octep_hw *oct_hw =3D data;
> -       int i;
> +       int i, ring_start, ring_stride;
> +
> +       /* Each device has multiple interrupts (nb_irqs) shared among rec=
eive
> +        * rings (nr_vring). Device interrupts are mapped to specific rec=
eive
> +        * rings in a round-robin fashion. Only rings handling receive
> +        * operations require interrupts, and these are at even indices.
> +        *
> +        * For example, if nb_irqs =3D 8 and nr_vring =3D 64:
> +        * 0 -> 0, 16, 32, 48;
> +        * 1 -> 2, 18, 34, 50;
> +        * ...
> +        * 7 -> 14, 30, 46, 62;
> +        */
> +       ring_start =3D (irq - oct_hw->irqs[0]) * 2;
> +       ring_stride =3D oct_hw->nb_irqs * 2;
>
> -       for (i =3D 0; i < oct_hw->nr_vring; i++) {
> -               if (oct_hw->vqs[i].cb.callback && ioread32(oct_hw->vqs[i]=
.cb_notify_addr)) {
> -                       /* Acknowledge the per queue notification to the =
device */
> +       for (i =3D ring_start; i < oct_hw->nr_vring; i +=3D ring_stride) =
{
> +               if (ioread32(oct_hw->vqs[i].cb_notify_addr)) {

Could oct_hw->vqs[i].cb_notify_addr change? If not, maybe we can cache
it somewhere to avoid the read here.

> +                       /* Acknowledge the per ring notification to the d=
evice */
>                         iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
> -                       oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.priv=
ate);

Thanks


