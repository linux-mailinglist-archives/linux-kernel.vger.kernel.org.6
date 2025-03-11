Return-Path: <linux-kernel+bounces-556337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC5A5C42A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2384189A24A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D3B25C6F4;
	Tue, 11 Mar 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZ29h8RY"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614C25C6F1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704190; cv=none; b=jyXDY/MebCaFZy3VestEzeMt5hifuQEF83us51AAFoeijaUNu4qyCZXJSQu+TfFbJ9S+wcf1e5HvZU3o49KPb8exvAhf9X7MsgFIAAcHCmKku9Rl8sWPbr8mYVanFBquAGQ6xVhWvzBztG++1dEkqjp68ljKZEgZgRgsJCfD960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704190; c=relaxed/simple;
	bh=VkUyoAyyCmW63H5OQPvbiafh/ZxBkE7JGT7ZH6ENAKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMll/XcKSym6Mc2QHDw6WmXJFs9nAGwLi6hYEcHla22bNF0QXdagLpYINJlW2K2c9ER+0yUxzOiMA/9EMeTt8PARrH7HfsYNI7BnFzSP7eL2Opd5zi4+dJV1KbpzIt9VBqXIqW/20OhFs03J6Lh6C/D68H25N+rMDKAGbZtFQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZ29h8RY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fef1d35589so21676647b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741704187; x=1742308987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8eN7PsSljamLFmL3eAZGuj/XK8vFI8v0YSA3pxuzua8=;
        b=uZ29h8RYQH1WGelKC+7tTn+5F+tlCEi7O93CLE0VsxHTo8RRSNJKY4A5FKJpLikNEH
         4FKkd4MpoZKEL2GAHc+vZoYG4w3NAs2OvwlvD5iTBPu6KKXxH34MjPI14moUPSU0J2WP
         gjbsLurLtbiZNHqcxNJ1/vMccINBSlTSBPvNc3pxBK3u45/ZF3dxJzYGwWa6C9gz3UBs
         bU3rF4/jfzkJD7fwmhPflRcuuHFjylg1EUhjQJA/UoqlDJKXYX4Yv4XqwWxxl/Qnfov6
         Q9WfMDr905YoZJLb+vGiag4sEPGIX0WAror3eTlrHJ9FejO5DvAI4TGdXUYVRt0q1TGn
         B4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704187; x=1742308987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eN7PsSljamLFmL3eAZGuj/XK8vFI8v0YSA3pxuzua8=;
        b=WUnfYOZ3NwCvKkw4E+waALb0rQlHJjJF4a1rtxGhMHfZYSXgjF0FjoAPyyr0nGKpU7
         E0k4rrlV6DugbKvgSNWtdVfHvSQUgVr3+CGqor9GNJmBAva6xV+tYJgR4b56QFXU6IZ1
         bj6+19TtQcLis34thVoixqnwgr2htuAUFp9TMGBBO3kjXcY5sk11bFmxTaPLPXzpbwMR
         xuYMzKEjBVwkRVrkEYx3NsGFlnvgYtSKYMkLzTp4StCI1nJRTaKs/49guZk2D9LPqkfg
         EbaftT1m4KGWrhpFzW7KodXb5tDwfPXuzcrkhcmQP/NRKnKgp7KZKLuJoeoZftY98Bkh
         k8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5TCKI6SOtmbhXsaJQlusWSTnNzfAnpYSYCrt8FLiGjYr+efof/ssAVWs/mlrvLTbpvN5tsnrCxpj/pRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XJU5iAujL4OgsoDqFodbHeFTsBUTBqMr6NPmUt1ANmVHAsBT
	qd0HViMelDxD/KmNLuVljicCIQryy5pob0H/C+uOPXSrLP1kye+TPXwlBqgOkMs8vej85C/xiT/
	EkpLC8MxcWQchNq4b777D0bfKYNQq99D8XjR4vA==
X-Gm-Gg: ASbGncuGcuDBuvUffUbwKEWRWI9pOVT2pQkzScganwOdsZ1AhP9tIWB/bt03I0raZlE
	wcGhq7AvndOdqEh3zkydbRtRcCtrMUPH0aNucOPOw8staxBfwVr2d5RfYjsy/6GNPcgS6lMXeet
	cMG2tVq6AB2O9gwQWbyw5nr+nCiCI=
X-Google-Smtp-Source: AGHT+IG/Nkb2MMo911BY6LZyKSsboklHqls3Mfm0CSui2XrmwBdOBouV0yL+jXkPDlFtJivejjAsU40tXjhf+7Ul5/s=
X-Received: by 2002:a05:690c:3706:b0:6fb:a696:b23b with SMTP id
 00721157ae682-6febf3c519dmr225655647b3.33.1741704187487; Tue, 11 Mar 2025
 07:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307145547.2784821-1-ping.bai@nxp.com>
In-Reply-To: <20250307145547.2784821-1-ping.bai@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Mar 2025 15:42:31 +0100
X-Gm-Features: AQ5f1JpuVnMxrQT-gRgqkxyP6H2nzFhKukp5aY_RBibf6JhIgaCor4IM8qvGE-0
Message-ID: <CAPDyKFqsE4nArB+Qn5gH5P7vVePpZ6Z7ruas2-EGYsctGV-=4w@mail.gmail.com>
Subject: Re: [PATCH v5] cpuidle: Init cpuidle only for present CPUs
To: rafael@kernel.org, Jacky Bai <ping.bai@nxp.com>
Cc: daniel.lezcano@linaro.org, lpieralisi@kernel.org, sudeep.holla@arm.com, 
	james.morse@arm.com, d-gole@ti.com, anup@brainfault.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	imx@lists.linux.dev, khilman@baylibre.com, quic_tingweiz@quicinc.com, 
	quic_yuanjiey@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 15:54, Jacky Bai <ping.bai@nxp.com> wrote:
>
> for_each_possible_cpu() is currently used to initialize cpuidle
> in below cpuidle drivers:
>   drivers/cpuidle/cpuidle-arm.c
>   drivers/cpuidle/cpuidle-big_little.c
>   drivers/cpuidle/cpuidle-psci.c
>   drivers/cpuidle/cpuidle-qcom-spm.c
>   drivers/cpuidle/cpuidle-riscv-sbi.c
>
> However, in cpu_dev_register_generic(), for_each_present_cpu()
> is used to register CPU devices which means the CPU devices are
> only registered for present CPUs and not all possible CPUs.
>
> With nosmp or maxcpus=0, only the boot CPU is present, lead
> to the failure:
>
>   |  Failed to register cpuidle device for cpu1
>
> Then rollback to cancel all CPUs' cpuidle registration.
>
> Change for_each_possible_cpu() to for_each_present_cpu() in the
> above cpuidle drivers to ensure it only registers cpuidle devices
> for CPUs that are actually present.
>
> Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Rafael, I assume you will pick these up? Or let me know if you want me
to take them via my pmdomain tree.

Kind regards
Uffe

> ---
>  - v5 changes:
>    - add changes for cpuidle-qcom-spm
>
>  - v4 changes:
>   - add changes for other cpuidle driver that has the similar issue
>     as cpuidle-pcsi driver.
>
>  - v3 changes:
>   - improve the changelog as suggested by Sudeep
> ---
>  drivers/cpuidle/cpuidle-arm.c        | 8 ++++----
>  drivers/cpuidle/cpuidle-big_little.c | 2 +-
>  drivers/cpuidle/cpuidle-psci.c       | 4 ++--
>  drivers/cpuidle/cpuidle-qcom-spm.c   | 2 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c  | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index caba6f4bb1b7..e044fefdb816 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -137,9 +137,9 @@ static int __init arm_idle_init_cpu(int cpu)
>  /*
>   * arm_idle_init - Initializes arm cpuidle driver
>   *
> - * Initializes arm cpuidle driver for all CPUs, if any CPU fails
> - * to register cpuidle driver then rollback to cancel all CPUs
> - * registration.
> + * Initializes arm cpuidle driver for all present CPUs, if any
> + * CPU fails to register cpuidle driver then rollback to cancel
> + * all CPUs registration.
>   */
>  static int __init arm_idle_init(void)
>  {
> @@ -147,7 +147,7 @@ static int __init arm_idle_init(void)
>         struct cpuidle_driver *drv;
>         struct cpuidle_device *dev;
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_present_cpu(cpu) {
>                 ret = arm_idle_init_cpu(cpu);
>                 if (ret)
>                         goto out_fail;
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index 74972deda0ea..4abba42fcc31 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -148,7 +148,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int part_id)
>         if (!cpumask)
>                 return -ENOMEM;
>
> -       for_each_possible_cpu(cpu)
> +       for_each_present_cpu(cpu)
>                 if (smp_cpuid_part(cpu) == part_id)
>                         cpumask_set_cpu(cpu, cpumask);
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index dd8d776d6e39..b46a83f5ffe4 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -403,7 +403,7 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
>  /*
>   * psci_idle_probe - Initializes PSCI cpuidle driver
>   *
> - * Initializes PSCI cpuidle driver for all CPUs, if any CPU fails
> + * Initializes PSCI cpuidle driver for all present CPUs, if any CPU fails
>   * to register cpuidle driver then rollback to cancel all CPUs
>   * registration.
>   */
> @@ -413,7 +413,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
>         struct cpuidle_driver *drv;
>         struct cpuidle_device *dev;
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_present_cpu(cpu) {
>                 ret = psci_idle_init_cpu(&pdev->dev, cpu);
>                 if (ret)
>                         goto out_fail;
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index 3ab240e0e122..5f386761b156 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -135,7 +135,7 @@ static int spm_cpuidle_drv_probe(struct platform_device *pdev)
>         if (ret)
>                 return dev_err_probe(&pdev->dev, ret, "set warm boot addr failed");
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_present_cpu(cpu) {
>                 ret = spm_cpuidle_register(&pdev->dev, cpu);
>                 if (ret && ret != -ENODEV) {
>                         dev_err(&pdev->dev,
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index 0c92a628bbd4..0fe1ece9fbdc 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -529,8 +529,8 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
>                         return ret;
>         }
>
> -       /* Initialize CPU idle driver for each CPU */
> -       for_each_possible_cpu(cpu) {
> +       /* Initialize CPU idle driver for each present CPU */
> +       for_each_present_cpu(cpu) {
>                 ret = sbi_cpuidle_init_cpu(&pdev->dev, cpu);
>                 if (ret) {
>                         pr_debug("HART%ld: idle driver init failed\n",
> --
> 2.34.1
>

