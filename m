Return-Path: <linux-kernel+bounces-199538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E117C8D884D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B2A1F22CDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3931613776F;
	Mon,  3 Jun 2024 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="MHLg6vkn"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402F137924
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437448; cv=none; b=Fau3kTAhdo2CQB3GTX1EywIQbFaBHUvxOI/iGEZ0WM+BKSxZ9jTLXZIpAE2gtsTHhb2dbvlFqnMb11+oS5gV0tXLy5WvvajQqQD43p847Rn3QxV7BperEYc+fUC8XVxi6zXx/mC9PiUumR/KVQc0f1+50Wt1zSZfIyZzTW7GfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437448; c=relaxed/simple;
	bh=IOml9WT8uavvIk08cwcmipO2sY5IUWBji+R/SgtEHBI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=oyul0Deuu47OM4kHk51YfddrXvQSN95uZpnqGiDcjcFZASvv29JTh3W3Co/0SDvceM7t9/FAN75duy5EkapeRAFYIelCOBnhMWszcyr+1bMSWPff48TqlCKFA38Pe9ACrg73wCPRZdmB+m3HTZ1Oj799HsBZCGSASrRIHLDLjyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=MHLg6vkn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70249c5fb36so2525854b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1717437445; x=1718042245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AfdW5qoP/0PIY+SC/1psi3LxiYm3n/ljuaAM9YxX4M=;
        b=MHLg6vknHH6HV+Hs7qK3Yh9DaA3fG0xVXQaRGVY+oMKVOEpxUY0wGmdRHyCwyFWdVb
         T8eERG3aSrMRiPtHoFaM/AuR34tDJfx8rc2xZbyUDUOU73G/+tsQTwoB948nqya0q3Hr
         4x6u+TRiK8n0tErr6df1s5xbTO/U2d8AgskplFfu7XhVZCx7WZ7C8QlxMQNX1uqiLc1M
         8yESeEOsuAbHlFGxq210N0mr/doaMwii6fZqb+rtWpydOGzK+ekPqeOoa2qC41hfXi+t
         9WxZTinRWNwWW/UR3vhPGWuq5vheBC8sXWtQJprDjHEDcgNsTcBq7v/+JkVeHOWcwbYq
         jcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437445; x=1718042245;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AfdW5qoP/0PIY+SC/1psi3LxiYm3n/ljuaAM9YxX4M=;
        b=NKQ39EH+tyEK9//b36Dqtp2/sqQZPKCCLvmf7WRTVvmGHuArajbh3NtxjXA10izL4n
         H96gWxRWOX+o8hhknC4M9fC+cHaFvsulReEbb9KxDnCTO5rjP5RWuiBNTLQZv3ZlydZV
         Y8WOxogPSYnhr4gzRLzw+f+wnsDdeya/X0/mzkcvqpxU+jkI6hnf0zEMh4px+uALnxsd
         VmFqAwL1pAMyiBC43sdXUr76QsJkEdXNG/PMXm7W1LX5i3Sh7Ol0MJsFQG7ucM+mxF3P
         T3PpG0n6+uUk50CHmeeSnK2O5l/GBm302uX2kAQ2bbwTY2bIoyNv/yRH2z5JZ3mJ+q2M
         ia3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyHxTumTdcRY4tX7y3sq4x8nxDU1dyDPJ4K8ZFtHyMu7BxXpDUMNKO9TnKefuE++XhUwz586MnbnasHpxh7ep5ZgjwKi8KKLEP5wq2
X-Gm-Message-State: AOJu0YyJBJZQ3U6ZeoLm7RAI3ruRsr2S7zGYj4fWRQCyDF4eq6yGrykz
	hbEsvG0buaSpciDdPiLRdn1dxaqeE+NpIiFBkLKnuAV/hqa3GPy0IW9BMULGGYI=
X-Google-Smtp-Source: AGHT+IHjqwamL2Li7UNo0vbbf3pvHjHTMgtLxIt2g57XM15Bv2yYajt08yUZOGxWAa5WYK73aQGQ+A==
X-Received: by 2002:a05:6a20:320d:b0:1b1:f7a1:df91 with SMTP id adf61e73a8af0-1b26f296e46mr8189210637.61.1717437445325;
        Mon, 03 Jun 2024 10:57:25 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cb712sm5756476b3a.22.2024.06.03.10.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:57:21 -0700 (PDT)
Date: Mon, 03 Jun 2024 10:57:21 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2024 10:57:19 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: hwprobe: Add MISALIGNED_PERF key
In-Reply-To: <tencent_C5BBD6F106D73F662084BD91904F54504805@qq.com>
CC: Evan Green <evan@rivosinc.com>, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
  andy.chiu@sifive.com, cleger@rivosinc.com, Conor Dooley <conor.dooley@microchip.com>,
  costa.shul@redhat.com, corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
  samitolvanen@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: cyy@cyyself.name
Message-ID: <mhng-d3cf0bb4-4881-4f71-b1d1-6bb756d5c4ef@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 29 May 2024 20:36:45 PDT (-0700), cyy@cyyself.name wrote:
> On 2024/5/30 02:26, Evan Green wrote:
>> RISCV_HWPROBE_KEY_CPUPERF_0 was mistakenly flagged as a bitmask in
>> hwprobe_key_is_bitmask(), when in reality it was an enum value. This
>> causes problems when used in conjunction with RISCV_HWPROBE_WHICH_CPUS,
>> since SLOW, FAST, and EMULATED have values whose bits overlap with
>> each other. If the caller asked for the set of CPUs that was SLOW or
>> EMULATED, the returned set would also include CPUs that were FAST.
>> 
>> Introduce a new hwprobe key, RISCV_HWPROBE_KEY_MISALIGNED_PERF, which
>> returns the same values in response to a direct query (with no flags),
>> but is properly handled as an enumerated value. As a result, SLOW,
>> FAST, and EMULATED are all correctly treated as distinct values under
>> the new key when queried with the WHICH_CPUS flag.
>> 
>> Leave the old key in place to avoid disturbing applications which may
>> have already come to rely on the broken behavior.
>> 
>> Fixes: e178bf146e4b ("RISC-V: hwprobe: Introduce which-cpus flag")
>> Signed-off-by: Evan Green <evan@rivosinc.com>
>> 
>> ---
>> 
>> 
>> Note: Yangyu also has a fix out for this issue at [1]. That fix is much
>> tidier, but comes with the slight risk that some very broken userspace
>> application may break now that FAST cpus are not included for the query
>> of which cpus are SLOW or EMULATED.
>
> Indeed. Since the value of FAST is 0b11, the SLOW and EMULATED are 0b10 and
> 0b01 respectively.
>
> When this key is treated as a bitmask and query with
> RISCV_HWPROBE_WHICH_CPUS if a CPU has a superset bitmask of the requested
> value on the requested key, it will remain in the CPU mask. Otherwise, the
> CPU will be clear in the CPU mask. But when a key is treated as a value, we
> will just do a comparison. if it is not equal, then the CPU will be clear
> in the CPU. That's why FAST cpus are included when querying with SLOW or
> EMULATED with RISCV_HWPROBE_KEY_CPUPERF_0 key now.
>
> For me, deprecating the original hwprobe key and introducing a new key
> would be a better solution than changing the behavior as my patch did.

OK.  I don't have a strong feeling either way: if someone has code that 
tries to read this as a btimask then it'd be broken, but it would 
technically be following the docs.

That said, we're relying on this as a pretty core userspace portability 
construct.  So maybe the right answer here is to just be really strict 
about compatibility and eat the pain when we make a mistake, just to 
make sure we set the right example about not breaking stuff.

So unless anyone's opposed, I'll pick this up for 6.11.

>> I wanted to get this fix out so that
>> we have both as options, and can discuss. These fixes are mutually
>> exclusive, don't take both.
>
> It's better to note this strange behavior on
> Documentation/arch/riscv/hwprobe.rst so users can quickly understand the
> differences on the behavior of these two keys.
>
> The C code part looks good to me.
>
>> 
>> [1] https://lore.kernel.org/linux-riscv/tencent_01F8E0050FB4B11CC170C3639E43F41A1709@qq.com/
>> 
>> ---
>> Documentation/arch/riscv/hwprobe.rst | 8 ++++++--
>> arch/riscv/include/asm/hwprobe.h | 2 +-
>> arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>> arch/riscv/kernel/sys_hwprobe.c | 1 +
>> 4 files changed, 9 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
>> index 204cd4433af5..616ee372adaf 100644
>> --- a/Documentation/arch/riscv/hwprobe.rst
>> +++ b/Documentation/arch/riscv/hwprobe.rst
>> @@ -192,8 +192,12 @@ The following keys are defined:
>> supported as defined in the RISC-V ISA manual starting from commit
>> d8ab5c78c207 ("Zihintpause is ratified").
>> 
>> -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
>> - information about the selected set of processors.
>> +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated. Returns similar values to
>> + :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`, but the key was mistakenly
>> + classified as a bitmask rather than a value.
>> +
>> +* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`: An enum value describing the
>> + performance of misaligned scalar accesses on the selected set of processors.
>> 
>> * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
>> accesses is unknown.
>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
>> index 630507dff5ea..150a9877b0af 100644
>> --- a/arch/riscv/include/asm/hwprobe.h
>> +++ b/arch/riscv/include/asm/hwprobe.h
>> @@ -8,7 +8,7 @@
>> 
>> #include <uapi/asm/hwprobe.h>
>> 
>> -#define RISCV_HWPROBE_MAX_KEY 6
>> +#define RISCV_HWPROBE_MAX_KEY 7
>> 
>> static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>> {
>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
>> index dda76a05420b..bc34e33fef23 100644
>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> @@ -68,6 +68,7 @@ struct riscv_hwprobe {
>> #define RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
>> #define RISCV_HWPROBE_MISALIGNED_MASK (7 << 0)
>> #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
>> +#define RISCV_HWPROBE_KEY_MISALIGNED_PERF 7
>> /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>> 
>> /* Flags */
>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>> index 969ef3d59dbe..c8b7d57eb55e 100644
>> --- a/arch/riscv/kernel/sys_hwprobe.c
>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>> @@ -208,6 +208,7 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>> break;
>> 
>> case RISCV_HWPROBE_KEY_CPUPERF_0:
>> + case RISCV_HWPROBE_KEY_MISALIGNED_PERF:
>> pair->value = hwprobe_misaligned(cpus);
>> break;
>> 

