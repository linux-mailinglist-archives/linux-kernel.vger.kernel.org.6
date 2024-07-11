Return-Path: <linux-kernel+bounces-249815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 985BB92F048
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74F9B22A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BF119EEB3;
	Thu, 11 Jul 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kZIcqYJ7"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03A16DC1E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729521; cv=none; b=fuUsEosUKR+DcXcXqe1gQl1iy7S+N8EQvyTslBKMywFVFrGXBjbnZfdpxLPmnr4Jn0KAadRvbLwWRf3VKaGL2xFnOiXDxnfth2a6DHCN0YAEY1/5wJh+p0CsEpM415QEwl6iQR6bYsMx6mXs9w4MBwUWAxSF7l/0URJJroZ/bdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729521; c=relaxed/simple;
	bh=8bclKTm0mQjAtWAC6LCIUWGn+6C2ewID31E27vLw+5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKLjh8rt4FWkjT6oPkFJGAxkgS5NY1Tk5eqmoYRYKCyuD9uj486adwlcW4lXx35w8covbYVqK1ZQyNMP59HAYkEuqzLW+ePQuRsdCgENXUXCNSZBCjC8Pz2L6FHx7vMcl4uJhRZk4/LPLxudldr6K5kH7li9Tcxed6c7Fp1l0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kZIcqYJ7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-75e7e110e89so831062a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720729520; x=1721334320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMO3QJaNwKPEg2fkW9ocZ2ZzNc4qbi0eB4IVGf7OvXg=;
        b=kZIcqYJ7b/9cyKAWeBRIyVZIhogyPJn8VDyodMfD2HELSbV08Tu+Q7tbPuSFGUrhzc
         rz8pduoj3KReGbpNaAHHy5tJ12s3N5lZsGOk1tTxoYSHx6WBgi5VQYGubna81BPclV1E
         gOxIMmJe6QVt2RTnpYY+fPHo/t7TvhZOm3iJ6iuLWLuqKygFYhIltmJcGTDugrIzR3e0
         UoZ+ciLmDuTpLhAo7bArPSAlC6AIX0RF4PzdrMnSE5qkXJXupAntI0qeHY4PF1VSee18
         mcVA4qPU6ovg8yY/4PThpcBdig3Nc1IedfTaBScqOfy2tDqoopdABkO1PXHB/A8kvoG6
         xOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720729520; x=1721334320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMO3QJaNwKPEg2fkW9ocZ2ZzNc4qbi0eB4IVGf7OvXg=;
        b=EpioF6PEFCj81EWNCCZvBvNCyidZY8qB0rz8UC/sbaQi1ddEZmlHWljUGCiVsCLhbW
         nJ1GZPBlcR4SlFW7kBgSG5whTcVw3H2Sw6/Z5eou+F3d82qXQKGUtP3Y06wHhaotu+1g
         bWNJXURDc3MNMttbYKWtQBrXunDcBAVjnRcxd1pPJdZVpaKq01xxhPOlAvWrUaDPeSoq
         jnu2+fr17So8vNxh8oh7Ff+ojGHXaW954XZVfzVmhWOyNDonx7uL08Bhfy/+sdEMdetu
         IB5duT8+HjIPQ3z/mwoiQsRSQlLUOUjNFtFoz+sZwWmKX/lPjWqDSaCcI+aF4A45b2RA
         A8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWyB746paFhBx+PbwW5SArwtIGuJ/UWJO+x1reo7VqFpZf3zbk3wgcuDCxjuV/QzJMoUd2XFHoJUU8HbW6vrRifFYsLDjvQqhbo1zU+
X-Gm-Message-State: AOJu0YwXlmVlLrqv8ichpfnpSDHS3P0cBnXZVsA9MCJJksU3i69jznAz
	fv4xUk0XsffTCiQEa4akGmpr7chYB4FKOoPTTvtxsNylPdH4sQjUHHigc+62SAA=
X-Google-Smtp-Source: AGHT+IGd8D3/XoSU3Ju/bMAEpeWWMsStCF3C8xFRAptThUUyXilcXDIM/pIU++epptacQ5dkqr485g==
X-Received: by 2002:a05:6a21:1690:b0:1c0:e322:e8c5 with SMTP id adf61e73a8af0-1c29821b544mr9879373637.26.1720729519712;
        Thu, 11 Jul 2024 13:25:19 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad3460sm54408745ad.295.2024.07.11.13.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 13:25:19 -0700 (PDT)
Message-ID: <ed410b0f-0062-4fbb-97e0-86fd492fb5ca@rivosinc.com>
Date: Thu, 11 Jul 2024 16:25:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] RISC-V: Check scalar unaligned access on all CPUs
To: Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Andy Chiu <andy.chiu@sifive.com>, Eric Biggers <ebiggers@google.com>,
 Greentime Hu <greentime.hu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20240625005001.37901-1-jesse@rivosinc.com>
 <20240625005001.37901-4-jesse@rivosinc.com>
 <CALs-HsvE9PzTrhVO0umh3KaJuLQLdk-h8sYKBg7XA4a-MXAmOg@mail.gmail.com>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <CALs-HsvE9PzTrhVO0umh3KaJuLQLdk-h8sYKBg7XA4a-MXAmOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/10/24 11:55, Evan Green wrote:
> On Mon, Jun 24, 2024 at 5:51 PM Jesse Taube <jesse@rivosinc.com> wrote:
>>
>> Originally, the check_unaligned_access_emulated_all_cpus function
>> only checked the boot hart. This fixes the function to check all
>> harts.
>>
>> Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>> Cc: stable@vger.kernel.org
>> ---
>> V1 -> V2:
>>   - New patch
>> V2 -> V3:
>>   - Split patch
>> ---
>>   arch/riscv/kernel/traps_misaligned.c | 23 ++++++-----------------
>>   1 file changed, 6 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index b62d5a2f4541..8fadbe00dd62 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -526,31 +526,17 @@ int handle_misaligned_store(struct pt_regs *regs)
>>          return 0;
>>   }
>>
>> -static bool check_unaligned_access_emulated(int cpu)
>> +static void check_unaligned_access_emulated(struct work_struct *unused)
>>   {
>> +       int cpu = smp_processor_id();
>>          long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
>>          unsigned long tmp_var, tmp_val;
>> -       bool misaligned_emu_detected;
>>
>>          *mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
>>
>>          __asm__ __volatile__ (
>>                  "       "REG_L" %[tmp], 1(%[ptr])\n"
>>                  : [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
>> -
>> -       misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
>> -       /*
>> -        * If unaligned_ctl is already set, this means that we detected that all
>> -        * CPUS uses emulated misaligned access at boot time. If that changed
>> -        * when hotplugging the new cpu, this is something we don't handle.
>> -        */
>> -       if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
>> -               pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
>> -               while (true)
>> -                       cpu_relax();
>> -       }
> 
> This chunk was meant to detect and refuse to run on a system where a
> heterogeneous CPU is hotplugged into a previously homogenous system.
> The commit message doesn't mention this change, how come you
> deleted it?

Sorry for the long wait.
I do not remember why I removed this.
Your right it shouldn't be removed, I added it back.

Thanks,
Jesse Taube
> 
> 
>> -
>> -       return misaligned_emu_detected;
>>   }
>>
>>   bool check_unaligned_access_emulated_all_cpus(void)
>> @@ -562,8 +548,11 @@ bool check_unaligned_access_emulated_all_cpus(void)
>>           * accesses emulated since tasks requesting such control can run on any
>>           * CPU.
>>           */
>> +       schedule_on_each_cpu(check_unaligned_access_emulated);
>> +
>>          for_each_online_cpu(cpu)
>> -               if (!check_unaligned_access_emulated(cpu))
>> +               if (per_cpu(misaligned_access_speed, cpu)
>> +                   != RISCV_HWPROBE_MISALIGNED_EMULATED)
>>                          return false;
>>
>>          unaligned_ctl = true;
>> --
>> 2.45.2
>>

