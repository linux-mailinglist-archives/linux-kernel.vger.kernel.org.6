Return-Path: <linux-kernel+bounces-572618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F8EA6CC3E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C026B16CFEA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3970A1FBEBE;
	Sat, 22 Mar 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="MRW+w1WV"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C9235358
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675407; cv=none; b=OndHNax3b62xPBZUFZw9xWbbPhTITw1e5cC87tPnMtZnFLoYmKeh1z5FOj6HmBQSQoOctZ64+bbaELATANMwz1SSrXuIL6oXo9QbOuGPG5a3enf1c0Z5skYdHoE9BosQixZ+o76D0Q7bywC4U8+yu/62tDvbEcpb5cGoPlSltiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675407; c=relaxed/simple;
	bh=23pANsHNneeXWCHFPR720EsnKizCIuI1/wb/1+/Tu2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWZ6p7BMN5n6AJwJXO8eYjcZUPMlTtTE7ko13hne1D6oOeTtahaGkiJlX6FqMEW+5Cd5alJjShcimMBMGM/e7SDydiRlRokqypTEzMjoyuICw+mXgo7iy2vPfSw5StABTbkAR8NbiKhWEz+T/ejWwiUH0zdPLvCZGDqR3rzn9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=MRW+w1WV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so4698944a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1742675404; x=1743280204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6cSUgatbqKhRbZTmyK9VSh/Zt9MhUeI55/TCtex2OE=;
        b=MRW+w1WVrF0Mg//g20zfB55EBGp1f4ozxaBHyq3ait8RAcWniB26tDsnxWAfmU0JRD
         i4XxkNxlkzsM3v4RKwKynvhJZ4tAroctlzfgTe5U9XNkCe6wNUf4rWBVo2mtA2r1FLcN
         RQjHPxOMD2ou7qswx7KNP531wFcMsfk/urhoab22xPCS6Mwv/IqKZaCafVrBz9pBmoTV
         +ie+bu+3MmzdTycAdLBkzmwk6DXAfJCcR85apxxRdaUqZ6aiDaamZSnNLEaknYC1qog2
         axSpdmAKaEAcUB1btcBfstjSACSJIIfAnA7Fgno0Uchj8GIrII0qseMM1AIdLxZhABm2
         Fzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675404; x=1743280204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6cSUgatbqKhRbZTmyK9VSh/Zt9MhUeI55/TCtex2OE=;
        b=eJ7W2xv1Y7F1sv6IZMzSSElSU3gvDlhVxhq4pspIATU8Io0s3N+lPtJdz55umxRxS6
         gjr0NIb4rKxbS4msXXDQoWdh1q60HZ424VPe7473XO4ujKI71FYq2uuKLBxANVNAvrvv
         qDEyUDxhTRBf7sUucDHjxijGZyl33ZxhFbGzyHKIgmX1bTu5rpB4Osiy4OhAj5/iEM9K
         R7fRDRsXzdrD19Cc9eI9pCzQBYBsfbBIaQGN2CcpqowmeHyp7kSzUVmbZs+wM2wN2afJ
         CDPoWTFwJbRIEGiTmJijxwTEmV8CfILVRFWJ+PAmtszYMDULUJciarIdsjHeLJ82ZHSA
         UcUw==
X-Forwarded-Encrypted: i=1; AJvYcCXilGX8jjuQ9gCE4tpAHsOMCQiJB6ihHRZ6nwLLaNvmC82cwSMmSnH4AVU0GAGDRBPhGOYKUMXewHwSPSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/+iOn6rhHkSkozloDjhTYZwyVtgrJ3ByC2lUkKtdMgdYtCEj
	j5NoFQmY/NDb576Xzcqb83N2ox/gJy4HXAXpNBzECDZUH5PKsqYufesOYxsxerABQHagm3yJf0g
	tk4cHnKOXUbazfcYJ7pvAtciKfNteLLLYcP2eyw==
X-Gm-Gg: ASbGncv/MrVXCSc3xA8fal1C1WX8+kDVCDC3o1K8N8+XmGptskKR9zO5X9e4abueBN8
	l1oYC/Tua8rNZeJ3CnDyuRtEpCy6et5hB+bhXvccMF7pXpq52jWyO6IDB6TwpLV2ekxZJYf3hVX
	d2oxS1/anxXsJNkiLnCLthvtxas6s=
X-Google-Smtp-Source: AGHT+IFBIVXZYDtiJpjWV/LcWygCCyM8XLLo2e1nj12IRbPwY/47eV7JcCDI5vBSVRn6rhZYRnytHKUjzgf552Rs/uQ=
X-Received: by 2002:a05:6402:524e:b0:5dc:6e27:e6e8 with SMTP id
 4fb4d7f45d1cf-5ebcd4fa24dmr7390153a12.24.1742675403691; Sat, 22 Mar 2025
 13:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321094916.19098-1-johan+linaro@kernel.org>
In-Reply-To: <20250321094916.19098-1-johan+linaro@kernel.org>
From: Steev Klimaszewski <steev@kali.org>
Date: Sat, 22 Mar 2025 15:29:52 -0500
X-Gm-Features: AQ5f1JoCXYzLr6Wcr5GEM3kx8AqnGOONhGWVUVet26agDhGD1qrhlsAqp0-B4Hs
Message-ID: <CAKXuJqjTP9Pr_AFOfNwzzi9F=qOO8zdo7Ga+6-a8x1ihsN4SpA@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: fix ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>, 
	Clayton Craft <clayton@craftyguy.net>, Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Fri, Mar 21, 2025 at 4:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> breaks and the log fills up with errors like:
>
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expec=
ted 1492
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expec=
ted 1484
>
> which based on a quick look at the driver seemed to indicate some kind
> of ring-buffer corruption.
>
> Miaoqing Pan tracked it down to the host seeing the updated destination
> ring head pointer before the updated descriptor, and the error handling
> for that in turn leaves the ring buffer in an inconsistent state.
>
> Add the missing memory barrier to make sure that the descriptor is read
> after the head pointer to address the root cause of the corruption while
> fixing up the error handling in case there are ever any (ordering) bugs
> on the device side.
>
> Note that the READ_ONCE() are only needed to avoid compiler mischief in
> case the ring-buffer helpers are ever inlined.
>
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LIT=
E-3.6510.41
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218623
> Link: https://lore.kernel.org/20250310010217.3845141-3-quic_miaoqing@quic=
inc.com
> Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Cc: stable@vger.kernel.org      # 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath11k/ce.c  | 11 +++++------
>  drivers/net/wireless/ath/ath11k/hal.c |  4 ++--
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/=
ath/ath11k/ce.c
> index e66e86bdec20..9d8efec46508 100644
> --- a/drivers/net/wireless/ath/ath11k/ce.c
> +++ b/drivers/net/wireless/ath/ath11k/ce.c
> @@ -393,11 +393,10 @@ static int ath11k_ce_completed_recv_next(struct ath=
11k_ce_pipe *pipe,
>                 goto err;
>         }
>
> +       /* Make sure descriptor is read after the head pointer. */
> +       dma_rmb();
> +
>         *nbytes =3D ath11k_hal_ce_dst_status_get_length(desc);
> -       if (*nbytes =3D=3D 0) {
> -               ret =3D -EIO;
> -               goto err;
> -       }
>
>         *skb =3D pipe->dest_ring->skb[sw_index];
>         pipe->dest_ring->skb[sw_index] =3D NULL;
> @@ -430,8 +429,8 @@ static void ath11k_ce_recv_process_cb(struct ath11k_c=
e_pipe *pipe)
>                 dma_unmap_single(ab->dev, ATH11K_SKB_RXCB(skb)->paddr,
>                                  max_nbytes, DMA_FROM_DEVICE);
>
> -               if (unlikely(max_nbytes < nbytes)) {
> -                       ath11k_warn(ab, "rxed more than expected (nbytes =
%d, max %d)",
> +               if (unlikely(max_nbytes < nbytes || nbytes =3D=3D 0)) {
> +                       ath11k_warn(ab, "unexpected rx length (nbytes %d,=
 max %d)",
>                                     nbytes, max_nbytes);
>                         dev_kfree_skb_any(skb);
>                         continue;
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless=
/ath/ath11k/hal.c
> index 61f4b6dd5380..8cb1505a5a0c 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -599,7 +599,7 @@ u32 ath11k_hal_ce_dst_status_get_length(void *buf)
>         struct hal_ce_srng_dst_status_desc *desc =3D buf;
>         u32 len;
>
> -       len =3D FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, desc->flags);
> +       len =3D FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, READ_ONCE(des=
c->flags));
>         desc->flags &=3D ~HAL_CE_DST_STATUS_DESC_FLAGS_LEN;
>
>         return len;
> @@ -829,7 +829,7 @@ void ath11k_hal_srng_access_begin(struct ath11k_base =
*ab, struct hal_srng *srng)
>                 srng->u.src_ring.cached_tp =3D
>                         *(volatile u32 *)srng->u.src_ring.tp_addr;
>         } else {
> -               srng->u.dst_ring.cached_hp =3D *srng->u.dst_ring.hp_addr;
> +               srng->u.dst_ring.cached_hp =3D READ_ONCE(*srng->u.dst_rin=
g.hp_addr);
>
>                 /* Try to prefetch the next descriptor in the ring */
>                 if (srng->flags & HAL_SRNG_FLAGS_CACHED)
> --
> 2.48.1
>

Like the others, I was seeing this message multiple times a day, and
on a not so rare occasion it would also take the wifi device offline,
with this patch applied, I do not see that at all here.

Tested-by: Steev Klimaszewski <steev@kali.org>

