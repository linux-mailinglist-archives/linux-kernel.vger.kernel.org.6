Return-Path: <linux-kernel+bounces-309177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C513966713
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B6FAB21631
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9E61B3B2D;
	Fri, 30 Aug 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yyD0j5Vr"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A173135417
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035995; cv=none; b=gbwnynj9GhuF7QsvVa5WQZBHAC9coBdimPIZnC20QeEfvDnhQo3sEmdBuHnmvUsT3JjI18v4BhEaIxujdufYDjTZC4mEe/V/tnVOxDw4/30cL67GLtpRYRmoWREwk170RrSXhYpgZL63L6tWjgPDm/biVUSWWt+j6fOgkRVIeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035995; c=relaxed/simple;
	bh=mNk1q95ziIK2Nfaj6ga3SQb9NzwZwIGIB/Ab8hvB5h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeGn572J/lnqlsm4bM+rxsSLM0VOE/TGoDE78gl0/+HCzr1p14SHEe8xSAMRIxFImCrNXt4vVFPX0dyMvoWhOYnzOgxT0mjQjZNLsR51aQblyw7+iu7CvSNdLNLgJ1EvTZ2UKOQk01K2O1rLCdIMYXT7E48qNPA2/w5OUaPIfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yyD0j5Vr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20543fdb7acso405195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725035993; x=1725640793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXhOuqL854STd5ZQr5fPKbzs5ZNb8IMCUFzcuK2IV04=;
        b=yyD0j5Vr+wCAPdzJ2sr7mopSn+S/kDxkpxUOLs0JuTPmrDMBB8uunNlqjyWmQr341q
         RZ6NbWU0WsM23/VtiXvY5Zw9Tyq/h7CrxN+U8kRPFYOi3uGVXRcHyhPJg98G6TosE+AH
         cty7QjDca4lhlmXvRhlpRd7bafb75FOIAcr947qq2RKFWO+mS1ddTkx4DWmNpCNetgA5
         Z16+7y1VtMLwoCIkEpz1BYncBRdlcJadMzeUlFdInLu9LBmuIfd6KXeb2rDuAHONS5k5
         l7DLW+ZcHeJo/38Gjh2sP+6J8L2i4C82rHjf9+Sp+rBNredn6jFNa9Z1LS5Ii3d+BPtU
         XuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035993; x=1725640793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXhOuqL854STd5ZQr5fPKbzs5ZNb8IMCUFzcuK2IV04=;
        b=D2eDJjoZwKxSXiaYewmboMZoGciCkuoqeb9ghvuc+wG/JnNgAEXmESlg+uEOkd4ksd
         TEOyg4Snvgm+Qh8CD5bIkzBBixuP4vNaN+IkXdnrjkzyxfcxr1JqWlDzH1XV/TyqpEbI
         GCJmk4o0PEB3fyy9fQZzxIce/CHqLHHAATbrU9MwvGzOSuj6VppnSomyVfLO6ivquFFP
         CWfors2ue7km5eRNuzesgxPfEUQdQT8SNaR4jtjzsaU4JzgW9OhvzMul5V3bLC5o7BcA
         9eSjy347b6W+xlRQILWUUtbxsMjJfBe46KAQT3YiB3Pa+TAM4Ap9fme79RFRVRrp9JiL
         ykuA==
X-Forwarded-Encrypted: i=1; AJvYcCUMUcmZ2Wqw/7yPCa1s7eWRPSvCvhe0OLovdCYKcEg4rrEC3qnuxCneXM6XBG1M58I/TGZE9bafo0kzkq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3xeMQi+q4XpElJvYsCmWThILZpGfHRA3v0c9Ad5TGm3fbqKH
	hQs1IU1pwYjTia72Ui+w22DnjBQxtF64tX4xR1CfY0VlggOLZMBVqkFRwubDlcM=
X-Google-Smtp-Source: AGHT+IE6GEuuQ85tAdiCIrokN5B0H73Fw9Bwv0gUTFG6J9Bx1NclPQDdKmLH2RPFx4280oZ27e7nwQ==
X-Received: by 2002:a17:902:c402:b0:205:157d:cfe2 with SMTP id d9443c01a7336-205157dd273mr60806055ad.42.1725035992749;
        Fri, 30 Aug 2024 09:39:52 -0700 (PDT)
Received: from [192.168.1.78] (c-73-42-218-101.hsd1.wa.comcast.net. [73.42.218.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205345089aesm10748605ad.149.2024.08.30.09.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 09:39:52 -0700 (PDT)
Message-ID: <6d20b21d-7e88-4072-b33d-dbb45d2f0965@rivosinc.com>
Date: Fri, 30 Aug 2024 09:39:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes v2] drivers: perf: Fix smp_processor_id() use in
 preemptible code
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>, Nam Cao <namcao@linutronix.de>
References: <20240829090034.15777-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240829090034.15777-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 2:00 AM, Alexandre Ghiti wrote:
> As reported in [1], the use of smp_processor_id() in
> pmu_sbi_device_probe() must be protected by disabling the preemption, so
> simply use get_cpu()/put_cpu() instead.
> 
> Reported-by: Andrea Parri <parri.andrea@gmail.com>
> Reported-by: Nam Cao <namcao@linutronix.de>
> Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linutronix.de/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> 
> Changes in v2:
> - Do not disable the preemption in static_key_enable() (Will)
> 
>   drivers/perf/riscv_pmu_sbi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 31a17a56eb3b..febd8e74a72f 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1373,11 +1373,16 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>   
>   	/* SBI PMU Snapsphot is only available in SBI v2.0 */
>   	if (sbi_v2_available) {
> +		int cpu;
> +
>   		ret = pmu_sbi_snapshot_alloc(pmu);
>   		if (ret)
>   			goto out_unregister;
>   
> -		ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
> +		cpu = get_cpu();
> +		ret = pmu_sbi_snapshot_setup(pmu, cpu);
> +		put_cpu();
> +
>   		if (ret) {
>   			/* Snapshot is an optional feature. Continue if not available */
>   			pmu_sbi_snapshot_free(pmu);

Reviewed-by: Atish Patra <atishp@rivosinc.com>

