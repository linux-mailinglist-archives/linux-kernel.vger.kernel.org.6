Return-Path: <linux-kernel+bounces-350304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F42799032A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF23B2366C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCEB1D359D;
	Fri,  4 Oct 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Vo6JWqkI"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B31D362F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045562; cv=none; b=qvSsShumVFfeS+6MSd6CRk54CZGfR3+pNZt24BRTAugX/fhvDmPaK8UK7hiYVbC5YBAudpBkZ879JZ0/nKCwbnV+Q6xV5DAbo9uLyF7lDuoy+6iBeR0LKs+SCmQVM4Q7mbNLQPHGzXUeiL7X70omheBURQuBL6VXCgLwV6UKw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045562; c=relaxed/simple;
	bh=X2mGDVX2E9KlO65D6ugG0PaUXCCsl/kzQRawbka/fKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OM2fLy9Jq9p315kBboA6br1WUyCzm154DPlJ8GCheX3nUhjwTLjLzuV+k86jPiGqc4QMesTYMu5CuvRCBCk1QIx/G8GQ586JcFG9ibKSkPenUZVQVV2q/yHkhOTw1zZ647sZV4CpgAf+jBgEVlXW3EErhr5p/gqnNPdnNZkJZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Vo6JWqkI; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a363706905so6542745ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1728045560; x=1728650360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrR+z/iOWphYqWkj8zj/mNFQmOZdBilN97SXK8kmVvA=;
        b=Vo6JWqkIzVrE7ixCel+zlbp2wiRS+qnsKgzDoogeesGKy3GfNpri2ge4F9Q/PKk4Yq
         wquxUJazvBW9P9x4QLAoCXoTwHQgrV2DLY1/KLugEXvB9TmXzoxMzDB8eYIxaQZ2GqBm
         tEvdOVyfGLbO961K2tfDTsXnRX0lUeUqXuXLfUHeSjcC+1pDvr6JfQFF/YWcMxxidTtz
         +uBNexwYG5CMFjuFrxBM+9GfKzgvT7N55jfwOnMDLybLrbPzeQsG4x81QHwXdkRbHR9B
         hEuUHe8pt/aeFRNyWma6eG7DvkLW72OrfgFFYQjg5FLL3tFpEnQFPqmcl70kJtxE8Iri
         QC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728045560; x=1728650360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrR+z/iOWphYqWkj8zj/mNFQmOZdBilN97SXK8kmVvA=;
        b=lhBB92PgfDHfD0rNpp2XTVdbZN8Azz8mXV+52lOA5DVLbr3paFa1kUAtFOoUZV052q
         XQWzg01as51FYM+QOwm/Z2fjmlLyUkC9GcURw3oJVxbwuNOQf6w/vej8+1VOsAu3rBGi
         jwhsFOoysyf6StYdPXEsNVQ2WUnXc/kdMQhAGoCM0VWTlanPYntAwERGB47qxzkv2dR2
         5qTWzVddglnXAebQWb+k84l25qHMq1FXeEvOhBmqvLfD8WD2FIRaefuN2UQVIUANga/P
         +42bNXxJy2eZS3Dw5GTJv0grnYCbu7LsNg2kiG+HfhsNmsj0q7vHRXtLHmK3LhbKRHyn
         2zZw==
X-Gm-Message-State: AOJu0YyFTuKHrcLrRj//vVd3d0fO9CkVvyf6u8DDCQe6ogXpe+Zerr1k
	nT4gUvXUJiKdhmcjB4/i+LFkB5dKOA0YO6B41iOKItROIV1P93vwXnFy+qE1LqG4e6KidxVszFj
	lCMeBXsVM2u20DRZO3fx7BvI0N/2/42a7KWYzBQ==
X-Google-Smtp-Source: AGHT+IERttoYjRNGdgoaAQ88VzrKxhKUIyjVinnKzTvAvFXZVff+YX6a4gsUWvibRQguSUrLvPreBNI4l6WqAmGFfdQ=
X-Received: by 2002:a05:6e02:13a6:b0:3a0:a385:911d with SMTP id
 e9e14a558f8ab-3a3757d92e5mr22058205ab.0.1728045559512; Fri, 04 Oct 2024
 05:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808081439.24661-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240808081439.24661-1-yongxuan.wang@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 4 Oct 2024 18:09:06 +0530
Message-ID: <CAAhSdy3NmwbHY9Qef9LUeXfr0iE7wC-u0d_fHzC47PXk-MzmRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: KVM: Fix APLIC in_clrip and clripnum write emulation
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:44=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> In the section "4.7 Precise effects on interrupt-pending bits"
> of the RISC-V AIA specification defines that:
>
> If the source mode is Level1 or Level0 and the interrupt domain
> is configured in MSI delivery mode (domaincfg.DM =3D 1):
> The pending bit is cleared whenever the rectified input value is
> low, when the interrupt is forwarded by MSI, or by a relevant
> write to an in_clrip register or to clripnum.
>
> Update the aplic_write_pending() to match the spec.
>

Fixes tag ?

> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  arch/riscv/kvm/aia_aplic.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
> index da6ff1bade0d..97c6dbcabf47 100644
> --- a/arch/riscv/kvm/aia_aplic.c
> +++ b/arch/riscv/kvm/aia_aplic.c
> @@ -142,8 +142,6 @@ static void aplic_write_pending(struct aplic *aplic, =
u32 irq, bool pending)
>
>         if (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_HIGH ||
>             sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW) {
> -               if (!pending)
> -                       goto skip_write_pending;

I agree that aplic_write_pending() is not handling the case
where it is called for in_clrip or clripnum writes but this still
looks incomplete.

The below two if() should be checked only when pending =3D=3D true.

>                 if ((irqd->state & APLIC_IRQ_STATE_INPUT) &&
>                     sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)
>                         goto skip_write_pending;

How about this ?

diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
index da6ff1bade0d..93ccc2a49f2b 100644
--- a/arch/riscv/kvm/aia_aplic.c
+++ b/arch/riscv/kvm/aia_aplic.c
@@ -143,7 +143,7 @@ static void aplic_write_pending(struct aplic
*aplic, u32 irq, bool pending)
        if (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_HIGH ||
            sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW) {
                if (!pending)
-                       goto skip_write_pending;
+                       goto noskip_write_pending;
                if ((irqd->state & APLIC_IRQ_STATE_INPUT) &&
                    sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)
                        goto skip_write_pending;
@@ -151,6 +151,7 @@ static void aplic_write_pending(struct aplic
*aplic, u32 irq, bool pending)
                    sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_HIGH)
                        goto skip_write_pending;
        }
+noskip_write_pending:

        if (pending)
                irqd->state |=3D APLIC_IRQ_STATE_PENDING;

Regards,
Anup

