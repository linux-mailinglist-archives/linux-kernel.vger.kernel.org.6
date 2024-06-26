Return-Path: <linux-kernel+bounces-230830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3CA91826D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C54282A28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B67317C7CD;
	Wed, 26 Jun 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SuTuGxI+"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD618E10
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408667; cv=none; b=DKNrnMLuZ3BnssVU7/60sZ4aANknQQSQ4F+a0M+jLwm8Utsr+hmJw5/2/VFbEmerEPc/xHjH8gnIiFFP7CpUprDyuRyPShXB8+h9o/W1J1TxmkX/H/KAwkcubJM2432Iurw/m6WN+zQzS5MRdop2YJCI4iuOPe6VYRddbqgG0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408667; c=relaxed/simple;
	bh=IHg55qFuHA+0B6vLiSvs3mwz6IgQY/MIqs+bSunEisQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHjvVTpAVC/PNmkPS0SDfQk97sZ+W10betDg+DkP0mI9+rgJUptdI2FeJEVtIz0gXVetftm/wWkhaXvj1VAK7UVpzHzU9EpC9/A0JHc508ByiZAB+w9JBVFLrM1SR+kssXWhxhu+YKD5C2LaOxXltwyCdK7DexnJoacCzhe5rI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SuTuGxI+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7955c585af0so360075285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719408664; x=1720013464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31CtUhxAl/Gr01Cj/jne/zVewsAXqFP8hO2/EQIAniM=;
        b=SuTuGxI+rwow1EdAVgS3E7A0fAYAn2YiaPNK0CRDgxlnODlI9vLwinpUmpPhqVrABO
         BS8tPuXUVJrVvf5TfSTOCs0FMyeK2O4iYOFUXecerrWMtOfL/9UrqM7cDuurfZ6WEliI
         zMarghW50mBktCcL9LbHFau0h0B6Mcy6FR8fMR9pq0cWqzsYAZ3TGLm4CqRrXLmSh/Vk
         Xxg1SUBtR8l1MDWcUSps7YhBbOctrX6SLJ0D21AuqRec/kURWiczAkhLyOvoA2k/RGTJ
         fjsxr0oE8y6uboMMMnG5UaUW+Azvd0+AJio88jZFCywpY8Gdsj0sbjllMsOOAHMeHc+I
         pWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719408664; x=1720013464;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31CtUhxAl/Gr01Cj/jne/zVewsAXqFP8hO2/EQIAniM=;
        b=OgwI9UiBaachh3okXNrPwAmjRIQfDkrIQj2Gn4WwXHmn+jWoXEMjlB6cV7M2nU8RYH
         rVkwYQM/vBv9f0VjVMc+OBaq4iUHLG0JRtgDX8w3CJx5AWNDOcJsHDNly8E5H9lQneKj
         SOzBUuwMXxJ5JiK3S0/xEziuTV+YLh22MRZOJ2VryeIL1TeZgeU50QrAwiJXWkYojrph
         s0EoIem4ZngDy5dzgDqinWWjR5ISGiYs/WdRq/BqYzTmcIj9b3PfI8v5cyARk8vBT05L
         fKP8s5Lib0u4NxQbJro8IjhvMAd5n0pVrgSAhibrGpeVwyUcleqaVGjiw6PEThvvLCiX
         p7zA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Nc8djAervkx+ZfEQDqWwMCPe3Raaag4WgpoT+2my3fU/OJaGJ7iLazgn75LBMsJvS3MGMwMl7fqDcMVm6F26SSkB/JXG8Gc/wBt/
X-Gm-Message-State: AOJu0YyzrvGAdbjFvKKHb5rnyuNYn1Gw8bGhtKhiBu0/3Sd/1gTTt1Wi
	c4pjAVTRxGBrhgrbj1H0o4/5L5t+4N4uUf5+GgSOhef4bL3wPlXlnMdlVzXLO1E=
X-Google-Smtp-Source: AGHT+IFgp9Jeg188P/jxp6SHl3VB59LvoFKORF1/KDDSv5eD1wGOmlU336p5Rxs4YfGjVL1AtWV2gg==
X-Received: by 2002:a05:620a:44c2:b0:795:5440:f872 with SMTP id af79cd13be357-79be6d4fea3mr1104570685a.28.1719408664408;
        Wed, 26 Jun 2024 06:31:04 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89a369sm502329085a.20.2024.06.26.06.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:31:04 -0700 (PDT)
Message-ID: <50c85e1a-c2ea-4c9f-b91b-97040665c40e@sifive.com>
Date: Wed, 26 Jun 2024 08:31:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Assorted fixes in RISC-V PMU driver
To: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
 kvm-riscv@lists.infradead.org
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, garthlei@pku.edu.cn
References: <20240626-misc_perf_fixes-v3-0-de3f8ed88dab@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240626-misc_perf_fixes-v3-0-de3f8ed88dab@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Atish,

On 2024-06-26 2:23 AM, Atish Patra wrote:
> This series contains 3 fixes out of which the first one is a new fix
> for invalid event data reported in lkml[2]. The last two are v3 of Samuel's
> patch[1]. I added the RB/TB/Fixes tag and moved 1 unrelated change
> to its own patch. I also changed a error message in kvm vcpu_pmu from
> pr_err to pr_debug to avoid redundant failure error messages generated
> due to the boot time quering of events implemented in the patch[1]

Thanks for picking this up! The change in patch 2 isn't quite unrelated.
pmu_sbi_check_std_events() depends on pmu_sbi_stop_all() to ensure all counters
are free at the beginning of the function. Compare v1 of the patch where the
function contains an additional call to SBI_EXT_PMU_COUNTER_STOP. With the
current patch ordering, everything works out, so it all looks good to me.

Regards,
Samuel

> Here is the original cover letter for the patch[1]
> 
> Before this patch:
> $ perf list hw
> 
> List of pre-defined events (to be used in -e or -M):
> 
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
>   bus-cycles                                         [Hardware event]
>   cache-misses                                       [Hardware event]
>   cache-references                                   [Hardware event]
>   cpu-cycles OR cycles                               [Hardware event]
>   instructions                                       [Hardware event]
>   ref-cycles                                         [Hardware event]
>   stalled-cycles-backend OR idle-cycles-backend      [Hardware event]
>   stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event]
> 
> $ perf stat -ddd true
> 
>  Performance counter stats for 'true':
> 
>               4.36 msec task-clock                       #    0.744 CPUs utilized
>                  1      context-switches                 #  229.325 /sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 38      page-faults                      #    8.714 K/sec
>          4,375,694      cycles                           #    1.003 GHz                         (60.64%)
>            728,945      instructions                     #    0.17  insn per cycle
>             79,199      branches                         #   18.162 M/sec
>             17,709      branch-misses                    #   22.36% of all branches
>            181,734      L1-dcache-loads                  #   41.676 M/sec
>              5,547      L1-dcache-load-misses            #    3.05% of all L1-dcache accesses
>      <not counted>      LLC-loads                                                               (0.00%)
>      <not counted>      LLC-load-misses                                                         (0.00%)
>      <not counted>      L1-icache-loads                                                         (0.00%)
>      <not counted>      L1-icache-load-misses                                                   (0.00%)
>      <not counted>      dTLB-loads                                                              (0.00%)
>      <not counted>      dTLB-load-misses                                                        (0.00%)
>      <not counted>      iTLB-loads                                                              (0.00%)
>      <not counted>      iTLB-load-misses                                                        (0.00%)
>      <not counted>      L1-dcache-prefetches                                                    (0.00%)
>      <not counted>      L1-dcache-prefetch-misses                                               (0.00%)
> 
>        0.005860375 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.010383000 seconds sys
> 
> After this patch:
> $ perf list hw
> 
> List of pre-defined events (to be used in -e or -M):
> 
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
>   cache-misses                                       [Hardware event]
>   cache-references                                   [Hardware event]
>   cpu-cycles OR cycles                               [Hardware event]
>   instructions                                       [Hardware event]
> 
> $ perf stat -ddd true
> 
>  Performance counter stats for 'true':
> 
>               5.16 msec task-clock                       #    0.848 CPUs utilized
>                  1      context-switches                 #  193.817 /sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 37      page-faults                      #    7.171 K/sec
>          5,183,625      cycles                           #    1.005 GHz
>            961,696      instructions                     #    0.19  insn per cycle
>             85,853      branches                         #   16.640 M/sec
>             20,462      branch-misses                    #   23.83% of all branches
>            243,545      L1-dcache-loads                  #   47.203 M/sec
>              5,974      L1-dcache-load-misses            #    2.45% of all L1-dcache accesses
>    <not supported>      LLC-loads
>    <not supported>      LLC-load-misses
>    <not supported>      L1-icache-loads
>    <not supported>      L1-icache-load-misses
>    <not supported>      dTLB-loads
>             19,619      dTLB-load-misses
>    <not supported>      iTLB-loads
>              6,831      iTLB-load-misses
>    <not supported>      L1-dcache-prefetches
>    <not supported>      L1-dcache-prefetch-misses
> 
>        0.006085625 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.013022000 seconds sys
> 
> Changes in v3:
>  - Added one more fix
>  - Separated an unrelated change to its own patch.
>  - Rebase and Added RB/TB/Fixes tag.
>  - Changed a error message in kvm code to avoid unnecessary failures
>    at guest booting.
> Changes in v2:
>  - Move the event checking to a workqueue to make it asynchronous
>  - Add more details to the commit message based on the v1 discussion
> 
> [1] https://lore.kernel.org/linux-riscv/20240418014652.1143466-1-samuel.holland@sifive.com/
> [2] https://lore.kernel.org/all/CC51D53B-846C-4D81-86FC-FBF969D0A0D6@pku.edu.cn/
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> Atish Patra (1):
>       drivers/perf: riscv: Do not update the event data if uptodate
> 
> Samuel Holland (2):
>       drivers/perf: riscv: Reset the counter to hpmevent mapping while starting cpus
>       perf: RISC-V: Check standard event availability
> 
>  arch/riscv/kvm/vcpu_pmu.c    |  2 +-
>  drivers/perf/riscv_pmu.c     |  2 +-
>  drivers/perf/riscv_pmu_sbi.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 43 insertions(+), 5 deletions(-)
> ---
> base-commit: 55027e689933ba2e64f3d245fb1ff185b3e7fc81
> change-id: 20240625-misc_perf_fixes-5c57f555d828
> --
> Regards,
> Atish patra
> 


