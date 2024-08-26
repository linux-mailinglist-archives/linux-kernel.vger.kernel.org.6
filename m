Return-Path: <linux-kernel+bounces-301911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E923595F741
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742C1B20DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB8E197A97;
	Mon, 26 Aug 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="O0aELbgw"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA6194AEB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691521; cv=none; b=DiY+zYO3guJTIGDZVM1oxlE2/SxtBwFmgKH4cmf6Q/68HMr6XjFj6O5J4jBtRFqYCP91CgDhoy6BpKF0KrA5EvnEPlMWAiiE+Dw25DeXbN9SnMC3ne+A8miu7WPiKn0BKv2foi6hPe1kZAqhudsN/+e+m+iBuQ/VMeW90/HsVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691521; c=relaxed/simple;
	bh=y3TaPpdNJQOQWX3KXvoGdOCh5EFz/w/FwE4Yn9mHTwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7VjUt6ZCGCbJXlgr6HacCdZ/GYQ2KVMCVKRZ69Zyq3/n6y8i8l9Pa6EOr9+peVSyR+qFL7UnNindKRmN0Y3ROJsIgL6Ic51YgxoZF9R5vm2wY9ovTHWhk809C+9JI6oNQjDTyRiuwW6izwpufCk5YonFzP7Z5sLjtSHB5rIqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=O0aELbgw; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d30f0f831so14477355ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1724691518; x=1725296318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhXfyj2KvujK2JosxSUi62CACNBRQWFA93L81bGY5QM=;
        b=O0aELbgwAueumz5BAQ5GdCXjXvqv7EZ+dkCPavlua2PZhrESFAqm/aLkYINwZuxwul
         DuikgR9PPbKtE8suHxCVgS/hPK7VJtzfmf55CyDErrAD4WCwEoyotZFnP2+iqHhaxaxb
         THtmrRzu5apKfl2bP1hCaW3ZE28yR93MDyc0wECKeu+oi3qUP3VZZrNhMWRSmCQ2ZFvk
         JWJJqhtdFBQ5nSaWrPFPTQ3QTMmwkHhiyZD52BeKcff3wTK3Ur8pFONezIvj7TPSoICg
         SbQkc+Yl2P8IRoau3mgY8ilXUmbyJtvp+LSCwrPkUb/3kbv3htxpV5po7d9fbHGvsDBE
         RwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691518; x=1725296318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhXfyj2KvujK2JosxSUi62CACNBRQWFA93L81bGY5QM=;
        b=QIq4DoTZ1JM7qO0wQGQ4Pp/WVpb3H9lJiX2g+bmhHdQlVUj9G5j8LFJavAzr+UQixq
         hPvpaWp825cXZzEGcQP+WfDtVz6JfZnLoQMLny4ltQn5WS0hAn/1rqnUA3GHE3JVdKjv
         q3z2NHMtoF+3B5IyDnyws/LimrF8Vw3qEToCxJAE79IVshoJz8DCQPxSvslVQsoBVjQw
         0dZVR5WyI/uHtRaAsu2wqMpOet4Ba4tWQObSazdH4FJ2QUjvMjW2gfSIBrWoW2TJl08d
         lHA46CXFfrhBpSaRGaWDrUhXL3EQYNEGEPaXqbUzQ+bKd6CMUx2aBHvR2uH2TkSjZ25e
         +4aw==
X-Forwarded-Encrypted: i=1; AJvYcCWpcuLxcLfPpCI6d1VxQj7uvzDO0fBvImsMqmemmGMxcWAPcwcVnJ3jbhx5poTDQ5JRq4EIOfq5Tu1NZTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyevEAljudB/00SKnsspK2wmzC7lixT0Fm++gfHr9VK7w6FRN8A
	5yPx3RVap5UTkihCwTX6+EVzwbMCZ9PMZ/Ist/2SZ1SSIL3kP3lERRc0M+BWT/wKGiFu/puyXJN
	sqQSpmRWDpbeNYSIDyAtErdhriYyEFle+eCO38g==
X-Google-Smtp-Source: AGHT+IH4bICu5Y2Tz+c4eaKlhmDoXJzs6Lw7o9SzL4rNxEFKuKRRO791TsZARgRDm/pcGEbgtFsnpTsWbDhZmJahDBg=
X-Received: by 2002:a05:6e02:1a68:b0:39b:25dc:7bd6 with SMTP id
 e9e14a558f8ab-39e3c976b3bmr120851375ab.4.1724691518066; Mon, 26 Aug 2024
 09:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826165210.124696-1-alexghiti@rivosinc.com>
In-Reply-To: <20240826165210.124696-1-alexghiti@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 26 Aug 2024 22:28:24 +0530
Message-ID: <CAAhSdy2WxN54ee0xWa=CZJvW6insfh_4Q_HBp4o+T-djLOFP1w@mail.gmail.com>
Subject: Re: [PATCH -fixes] drivers: perf: Fix smp_processor_id() use in
 preemptible code
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:22=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
>
> As reported in [1], the use of smp_processor_id() in
> pmu_sbi_device_probe() must be protected by disabling the preemption, so
> simple use get_cpu()/put_cpu() instead.
>
> Reported-by: Nam Cao <namcao@linutronix.de>
> Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linut=
ronix.de/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/perf/riscv_pmu_sbi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 31a17a56eb3b..25b1b699b3e2 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1373,11 +1373,15 @@ static int pmu_sbi_device_probe(struct platform_d=
evice *pdev)
>
>         /* SBI PMU Snapsphot is only available in SBI v2.0 */
>         if (sbi_v2_available) {
> +               int cpu;
> +
>                 ret =3D pmu_sbi_snapshot_alloc(pmu);
>                 if (ret)
>                         goto out_unregister;
>
> -               ret =3D pmu_sbi_snapshot_setup(pmu, smp_processor_id());
> +               cpu =3D get_cpu();
> +
> +               ret =3D pmu_sbi_snapshot_setup(pmu, cpu);
>                 if (ret) {
>                         /* Snapshot is an optional feature. Continue if n=
ot available */
>                         pmu_sbi_snapshot_free(pmu);
> @@ -1391,6 +1395,7 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>                          */
>                         static_branch_enable(&sbi_pmu_snapshot_available)=
;
>                 }
> +               put_cpu();
>         }
>
>         register_sysctl("kernel", sbi_pmu_sysctl_table);
> --
> 2.39.2
>

