Return-Path: <linux-kernel+bounces-437444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85A39E9353
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6D21640CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C52236F4;
	Mon,  9 Dec 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JS0f5jcX"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FF1EB2E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746113; cv=none; b=NTxau16UN3/RN1gIiq20N4/8JkTTAX5GNuNyoxgWKoGUWAwbyNwc4K1e60vvZDNVey0ryG8BbdkYnWTXVTVHfzYr74LYZXugfp7qwpHhGa6Ecd5yvClMfE9p5cizMBau707S3B564m5VeUwRnL8YfveGO9f0OtEc2W0gENC83w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746113; c=relaxed/simple;
	bh=wkMAPu6pVsIJyxNBUAniG1KG3qIMQAaDvRb5yVKgZ1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKvxMIFEprxtVmpKBSSTWvdgDOe1QVLj1XeuqIC3psKPouzxF4+m0Kgn/dA3u4LOz8MoOAPP2MpTLGibMPtYz+TNEWpsn2MbMFOja6rKtURqMeVFN9jPjLEF+L45xatOtuworMm/5Ih4t5+7/yw5hhJudfasV8gFh44hahladYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JS0f5jcX; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso51396291fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733746110; x=1734350910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6gzkDAhzXovMDqEI+9lRYWllf8EEHxno6K1iEAuLoM=;
        b=JS0f5jcXNR/0/zVxVSbk7ECmVbV3wVrBTT6P1T/1t7I0NzMZS+6PXaJvQQSxla15qp
         /2LSPtnYE0drb/hTy/3fk237AL5LHL5pGeVV9WQmigAvnZ2r9QLmz318wQODUqwvSecT
         5Rt3bfOPPdS+zIUbuea0FoJVQtKCYID/2M62Ls1F/wELxIQNHxDYfY5qj7NXcrrO0WP2
         KUHwDTDWVU6Z2YeOtnNFlScgeEXmNYr/ZOka1t4qb+BilGgqU0jzrGgZhkhhv2XCoAqo
         HDADkVjMn1YTv9NBqTu+7/T98vVvl1GoJRnX7PDoMlpadKde3a3XmKD3RDLV07SifZXU
         2nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733746110; x=1734350910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6gzkDAhzXovMDqEI+9lRYWllf8EEHxno6K1iEAuLoM=;
        b=izbYhs2bxbQCnKSKiH4esA1iJnZGU/qLdDLQQByFVX+w1zAeEBPnlIIxV03EnTipG2
         T0b2T4wRRZGDKLoGxrS90qWutD7YdmPsihZ/CwTM6Bo53SafLdG5GBkwgQycFBSeJZNm
         utDs0U8ALSOOMSUki+W7Zo7G0AHVS0YSF+vPdxcUsKsQVAbNUjWf5lgsvWjLgVh5xIEo
         Rv3NS9KqTweiDxXN7yoI3pHUKiMHTWYk7058wxjuLqr7hbacQXK1UsTj4hXosQ/4AanM
         YG0WXj/7gjEBR5KJmGjBXTCPIIaQ75+cEDBh16FwILmZwPKvmIOdH65BOmxgduqy/kjZ
         wXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsfOE4w5RKYyhjxU2EzCUn/fYlADX2zKGqhHjtvNfHrvph6zjGWzrAcfvctp/ue3uNSGRiwZpblgkPPXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ikdeFOe53BwwRyNRBv3kqfFh4YAVyDBIYyzlzqRRSyeerBta
	tlHf0ENcLl7GjX3vhKrkH09H6tmY7ZhcKhHOjaNzrUuca+ELf35Fo627DXYwPViEmi2ITKK0V7g
	6Dz1VirFs/VwOaBqbNCxwTAGLLFatHypNMQHGOg==
X-Gm-Gg: ASbGncttf+fczXJa5JcQFUStsBxyLTC5p+C11OM832FGs+f+CUjJbYdIUzvWKtec6Xz
	FS6dvYOGWOSomokQB2qd0UWN0xjtxsryCzw==
X-Google-Smtp-Source: AGHT+IE7s57c5CX5EN+0VrV/XwVhMQsRyEe4E1tm7jFdZ3xrCHKp5MnSIFcNY2K88pwSkR5p5gRdx23gp0eZz8tJNGY=
X-Received: by 2002:a2e:b013:0:b0:300:33b1:f0cc with SMTP id
 38308e7fff4ca-30033b1f3femr48347421fa.34.1733746109558; Mon, 09 Dec 2024
 04:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208150711.297624-1-apatel@ventanamicro.com>
 <20241208150711.297624-2-apatel@ventanamicro.com> <875xnuq6dc.ffs@tglx>
In-Reply-To: <875xnuq6dc.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 9 Dec 2024 17:38:18 +0530
Message-ID: <CAK9=C2VqU2mdLL-R20bdgvDHi0WcuNyUSqRo7Pztsu-8X1wVvw@mail.gmail.com>
Subject: Re: [PATCH 1/4] irqchip/riscv-imsic: Handle non-atomic MSI updates
 for device
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Dec 9, 2024 at 1:44=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Sun, Dec 08 2024 at 20:37, Anup Patel wrote:
> > +
> > +                     tvec =3D vec->local_id =3D=3D mvec->local_id ?
> > +                            NULL : &lpriv->vectors[mvec->local_id];
> > +                     if (tvec && __imsic_id_read_clear_pending(tvec->l=
ocal_id)) {
>
> As I told you before:
>
> I don't see a way how that can work remote with the IMSIC either even if
> you can easily access the pending state of the remote CPU:

For RISC-V IMSIC, a remote CPU cannot access the pending state
of interrupts on some other CPU.

>
> CPU0                            CPU1                   Device
> set_affinity()
>   write_msg(tmp)
>     write(addr); // CPU1
>     write(data); // vector 0x20
>                                                         raise IRQ (CPU1, =
vector 0x20)
>                                 handle vector 0x20
>                                 (other device)
>
>     check_pending(CPU1, 0x20) =3D=3D false -> Interrupt is lost
>
> There is no guarantee that set_affinity() runs on the original target
> CPU (CPU 1). Your scheme only works, when CPU1 vector 0x20 is not used
> by some other device. If it's used, you lost as CPU1 will consume the
> vector and your pending check is not seeing anything.
>
> x86 ensures CPU locality by deferring the affinity move to the next
> device interrupt on the original target CPU (CPU1 in the above
> example). See CONFIG_GENERIC_IRQ_PENDING.

I agree with you.

The IMSIC driver must do the affinity move upon the next device
interrupt on the old CPU. I will update this patch in the next revision.

BTW, I did not find CONFIG_GENERIC_IRQ_PENDING. Is the
name correct ?

>
> The interrupt domains which are not affected (remap) set the
> IRQ_MOVE_PCNTXT flag to avoid that dance and don't use that affinity
> setter code path at all.

Yes, setting the IRQ_MOVE_PCNTXT flag in the remap domain
makes perfect sense.

I suggest adding IRQ_MOVE_PCNTXT usage as part of Drew's
irqbypass series which adds a remap domain in the IOMMU
driver. Unless you insist on having it as part of this series ?

Regards,
Anup

