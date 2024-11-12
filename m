Return-Path: <linux-kernel+bounces-406582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49509C63CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93327B2A1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2581B21832A;
	Tue, 12 Nov 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="k6Y+UXBc"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B17230994
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438428; cv=none; b=BP31UAv59q1H6VbPvfDtkr2TUAhkXYmASQojFnKP7tm0bftMO0PmuvCo0oihCgC3O0L5LHSe1+PFR/QdVnD21043avFA7/PGLO4QISz4u4qySeIUYf/NV7YmDzOb+ALmM6Yz4T8MCTn2zsIyP1KaQe/07rHTpfNsg236Crx5oSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438428; c=relaxed/simple;
	bh=J/Yu6vpBU2NGlS8faMi21+g1+8AXNbbd6j08RCBCylE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRK+6ReM+hdtFWAPuQFdK5FYvM3R1aP1jWJaorfLHBT/W7BYrTEDbIaZ076NnWQ2HJ0+chQumyl7R7DZ0APNSWtQJjuUFplpQXSdrnMqGdAfOYudW7bf8lQVMBZeDZANeUqwVNMqRh6z9mIoXB44KX2R5pWVqxWKisYdXClGqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=k6Y+UXBc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-720be27db74so46651b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731438426; x=1732043226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsDwXecVIrAlSTQ6V1mobheD8FZMwXU4s1gVF5Uq0Iw=;
        b=k6Y+UXBcbP8GJE7G0F5joWDFJEISQL1GZLnipw8Vvi/4BjHHBOtmRYzKZl/Dzu/bQX
         vb1RgAkTLTy7pLrnaQFl0/r2053ZRswx4Qz0ZuN26M3DgyAEO5GnBPsAxcEErbWC/fzz
         Im7yrOHqyV717GctmXxS/NwoZ6BTctbyEq0i3zPRTUndU5NncQrCDL63B5nDcN+wHveI
         lLG+XsFDlpHXlA4VVk/D6vSRCqznh68RnGlbCUH3ElxbXugJK82LjD9+gp1Fi2PLY8wK
         54r/MEx6qNZ57fAceKZGLNPGgE4IzNemQSv7KJ/34rhLRIqxkzXr249clf2+093FP61y
         O96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731438426; x=1732043226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsDwXecVIrAlSTQ6V1mobheD8FZMwXU4s1gVF5Uq0Iw=;
        b=LqrAsO/R9B+HV2oa+5qin9e0DcaM3awfmScH4JGNYUu6lSzfFsGqxMbiMRwrBMluTm
         8cQ5gYXTKNtOliqUbM38xSqaZ8tpNMmpRSaDX4EqFs40N+zhg1C5v+aT+jFOkAV/sepd
         AhOmobcHhohpxCjSRsBuoku1a5HWA4BZoqxldZqckydJuBbHf0pqAwzOt0mkuY5P2qhS
         9UU793wajOIciB63G3vLn2DbCtQMGGFbWiLCVRwyHjXYkWXUH1OvRCYr0Y+deGJPVzKA
         Bqd3UvpGG1Bu9uztHdBBOJCXjnxkQDg9vp2a/0UyPg+MabKHr8sFkEuA4QhDepcvl+WQ
         IIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRiaWEeURQhZ63qsSkgL1jfX3B48ZKBAGGN1yRFnQ1hZtT0cMFFTgz0OfTxe3IHukicWoFiDLD/rGgvQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkstqGc6EbXD0eLMPbrVQveoKtuTf9ew9Zx7hWzyfudtM1vgK
	egWTVP93789BCVIJnprqKcLH0uFQACSWPyXpL/xdBOWh12+3D8WZG3cOeaB+XyjWxn0K8Bzqg4E
	QZW+dvooRIjfcxAhtA68nSJB3HwmtM1FYmAHQbw==
X-Google-Smtp-Source: AGHT+IHB097GZ6fVk/rpRwAIUQNKKHv7J0PFUbREBu/PTKn/4UbitylkvuPDjSzAmny8aHcHd88vY6+lORGpbC6yPhs=
X-Received: by 2002:a05:6a00:841:b0:71e:6a99:4732 with SMTP id
 d2e1a72fcca58-724140a67d7mr26723911b3a.11.1731438425637; Tue, 12 Nov 2024
 11:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112113422.617954-1-alexghiti@rivosinc.com>
In-Reply-To: <20241112113422.617954-1-alexghiti@rivosinc.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 12 Nov 2024 11:06:54 -0800
Message-ID: <CAHBxVyFUoiBNbJUCieS1cnVyTwUOModNL6b70wbMV4-z3GJEzQ@mail.gmail.com>
Subject: Re: [PATCH -fixes] drivers: perf: Fix wrong put_cpu() placement
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:34=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Unfortunately, the wrong patch version was merged which places the
> put_cpu() after enabling a static key, which is not safe as pointed by
> Will [1], so move put_cpu() before to avoid this.
>
> Fixes: 2840dadf0dde ("drivers: perf: Fix smp_processor_id() use in preemp=
tible code")
> Reported-by: Atish Patra <atishp@rivosinc.com>
> Link: https://lore.kernel.org/all/20240827125335.GD4772@willie-the-truck/=
 [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 391ca1422cae..1aa303f76cc7 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1393,8 +1393,9 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>                         goto out_unregister;
>
>                 cpu =3D get_cpu();
> -
>                 ret =3D pmu_sbi_snapshot_setup(pmu, cpu);
> +               put_cpu();
> +
>                 if (ret) {
>                         /* Snapshot is an optional feature. Continue if n=
ot available */
>                         pmu_sbi_snapshot_free(pmu);
> @@ -1408,7 +1409,6 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>                          */
>                         static_branch_enable(&sbi_pmu_snapshot_available)=
;
>                 }
> -               put_cpu();
>         }
>
>         register_sysctl("kernel", sbi_pmu_sysctl_table);
> --
> 2.39.2
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Tested-by: Atish Patra <atishp@rivosinc.com>

