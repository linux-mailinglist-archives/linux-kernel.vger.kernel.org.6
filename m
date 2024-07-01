Return-Path: <linux-kernel+bounces-235848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E091DA6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0830CB24274
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815B84E16;
	Mon,  1 Jul 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GAl6i1Bs"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FF84D34
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823655; cv=none; b=hOgnkgHa3y7wryOpH1AmilMiZJWegZOugdVp2OoSRueB8DnpD2KkG37DEPmU4Ne9vOs+3R5r++8SsjGT+cXVaPrSDfScjtDEurmx/3R7LYo4jtFkhfUWcw8D4oMPhHXRyxkIVDj/LKzv/zLKZMHSSg/oJUDWiPg1s6oRomHbxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823655; c=relaxed/simple;
	bh=ZXOdW4pto5OLdzPfn/Y/DqZDFGN+EvE0zNqkNrOGiqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8F2LW8/D79sHGKmhafXCaAJYXd2gruFKNI34cDpU/yARtgLneBEbiSVmiHtZV3I6VlF6McdUuP5qF+gGKscbIgKWjBAFxE3WJeSUfb7Uh3N0LS3dc19JCj7xZJaLpEVzjuQFIOYNJ6/my42RsAWxBkVlD/WgmcaD+HxsE+sjbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GAl6i1Bs; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d55ed47cc6so1869522b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719823651; x=1720428451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT4FjvsO28ftxFn/D0RiQIRX4ThKgWSSkQhgt2BnXRM=;
        b=GAl6i1BsqXgDAxwqjtei4EudLQhSnJWiVkqgBTy/3AqmNsv5L/jKCsQTfWa89swBLu
         8TwwLQ45PB1fZDmB2N2oeKJeyyIFv1Ly2nhLaHCveO8saMwtRUBrm6HRFviQ6U+q7Bia
         Ya4Nay9Jd8lUIQrCqILCsn/4KU51FYD7SRtfpZNd47uc0GDk4ieREImxjyPKTXeQ9Nx4
         GsXPpWUeF4q+nduteY6Hqyk2k8cr8qk1IJD4nqxW9XcOjQjrT9jDaOvaQ+bbg7AoL7Qc
         WdY0efaYJHtLQM/sHfEXRM/m2HSZKxhZZRLIJYP7nj9QPxzkNLx9Po5SuJ+R5k3YM5ZU
         Py8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823651; x=1720428451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT4FjvsO28ftxFn/D0RiQIRX4ThKgWSSkQhgt2BnXRM=;
        b=mjLtpZE80Rx845+ZaTvcE8Yy1s+pHdkpMRp9Du5LdyEp2MO5uCvB0ZpFau5a4iqlkC
         qNGSUvftx2qOU2/SGHGAL2sux7xTUZKlkZ18q7n/J2r+UgOn2yYBx+FRNJjB5mUSsiAP
         MXdhOVKoxzyuOluS0zKpaYO07UrsAKPttNy1mh1Q1LTb9lfLTJ4BDxhAwcT+ex7PIb9+
         RnVcLa/bPOcEtLw0inNhP/ZkibziWsKd3okBu1N7BEmd0r/MHqTaS9u3ZHPxqr8w/KKF
         A6+w0XlQnzI4Xn1OQzmhyPyfWuw1pYzo7LagWOaNZ4h/cHuh/UxhUa7GtsAkafUnN5nq
         /mCA==
X-Forwarded-Encrypted: i=1; AJvYcCVYQWKGQzKPAXzvFvEvWcDH/Brlovzvu48mUopJ+y3EFQIq+J79MELgt6/x3UchoqNIesBXvrhUgL4Vd3F+bByBZ8CRX3YPyTb2Y2MF
X-Gm-Message-State: AOJu0YxqdQoY1iUeWitrNgAk46IYy8Ft0KREzPB0QqRzDTmHKuGOP57r
	762MIN86obcOtFv4DZsF6K6OatyitC02QRnR+bUlFhNZowPFhL01T4K6IRVY6tn74iqbxnzRjQU
	ArIKYhPqSu4dc/529WPMjzvutUZ8vtskM6B9NxA==
X-Google-Smtp-Source: AGHT+IEo9sl2VFAmozT72Mcd/Sum+ljFVLZGY4TYZg/jdAg5+RMJL9U3ru88WJ7pMksr0TPVKgSFdnKEZYRME4FZgyE=
X-Received: by 2002:a05:6808:2288:b0:3d6:331d:b52d with SMTP id
 5614622812f47-3d6b2f07e53mr7562751b6e.4.1719823651207; Mon, 01 Jul 2024
 01:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701072908.25503-1-luxu.kernel@bytedance.com> <20240701072908.25503-2-luxu.kernel@bytedance.com>
In-Reply-To: <20240701072908.25503-2-luxu.kernel@bytedance.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 1 Jul 2024 10:47:18 +0200
Message-ID: <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/riscv: Support sharing irq lines between iommu queues
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	apatel@ventanamicro.com, sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:29=E2=80=AFAM 'Xu Lu' via linux <linux@rivosinc.co=
m> wrote:
>
> When the number of wired interrupt lines is less than the number of
> iommu queues, we should assign one irq line for several queues and
> configure csr icvec accordingly.
>

Is this case not already covered by the code in function
riscv_iommu_init_check(), assigning cause to vector register (ICVEC)
based on available interrupt vectors? Interrupt vector selection is
based on accepted ICVEC configuration (see riscv_iommu_queue_vec()).

Relevant code (patch 'Command and fault queue support'):
iommu->icvec =3D FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1 % iommu->irqs_count) |
       FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2 % iommu->irqs_count) |
       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);

Values in iommu->irqs[] should represent actual interrupts allocated
for the device.

Best,
- Tomasz

> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/i=
ommu-platform.c
> index da336863f152..1d0af1260d5b 100644
> --- a/drivers/iommu/riscv/iommu-platform.c
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -60,6 +60,10 @@ static int riscv_iommu_platform_probe(struct platform_=
device *pdev)
>         for (vec =3D 0; vec < iommu->irqs_count; vec++)
>                 iommu->irqs[vec] =3D platform_get_irq(pdev, vec);
>
> +       for (vec =3D iommu->irqs_count; vec < RISCV_IOMMU_INTR_COUNT; vec=
++)
> +               iommu->irqs[vec] =3D platform_get_irq(pdev,
> +                                                   (vec % iommu->irqs_co=
unt));
> +
>         /* Enable wire-signaled interrupts, fctl.WSI */
>         if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
>                 iommu->fctl |=3D RISCV_IOMMU_FCTL_WSI;
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux+unsubscribe@rivosinc.com.
> To view this discussion on the web visit https://groups.google.com/a/rivo=
sinc.com/d/msgid/linux/20240701072908.25503-2-luxu.kernel%40bytedance.com.
> For more options, visit https://groups.google.com/a/rivosinc.com/d/optout=
.

