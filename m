Return-Path: <linux-kernel+bounces-442188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541189ED92D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D014281F75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF591F0E22;
	Wed, 11 Dec 2024 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="MiWe/HvX"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335111E9B34
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954401; cv=none; b=ojsC1SzJIlWdISGlbI26A7dBY8OHNYV5crd+RrBKdPfah5kpb8lTAtQgI00AJiQipKF0QZYY/4JX3LKWaBfPCccSUvULg6WHn+i0w5C6mfBdpKDJW8mkAocB42DmtYiTGpvgwsxWNNZQbwcNlvAqb2C4COTqetvycfGaL0mgrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954401; c=relaxed/simple;
	bh=dgCj7JMjdVlmI5VUn43B5n1oR+8612R52EWgNeRXVkE=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=oZgcCEnvd7LC4uXz7m7FH8JHJBCVqAAFhpWCqu5+WApO/9Sab6giolw2Tj/A4J12B9xA1Duu3qQo4YwMQDNAlkSMM2CEq519P/PzWaUVTVv7b0Dwspv+V/l53lz1H2U5Co0dSRO4AD+EWQmRrmzQrqi3Jpt0tVk2EnMCcVB/vZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=MiWe/HvX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725ecc42d43so3199278b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1733954398; x=1734559198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysfEfMkRShl7ZQ6rcvjQZizTooHGsZAtmuWoKudrSMo=;
        b=MiWe/HvXzuQyfsyGJLIx4zglcYjFFPEujqJ6AG1aqd+AkWmtRH8SqV+USGWCvLTq+3
         f5YXLj8Rpo2DqO0dHOHlUD84f4hlmbPBVtV1AzdYAjh2fhDUMx1Zbb5djWpro07+KSNA
         O4nWExDpqGpyiFp77+IhKCTPqj68jAtSY7sVyKnhGgAr9xPtbwQ7638gIUbxaMf2PHVb
         8kvnuZ/HYfMB/jSbBE45Wh/1brNYsuugv85yMOLyDgwsklHJ+zzym24SofISbLsfLUoF
         rm732DH90b08hOOG09ptqsIZjtFYQ8f4ozubvIA62xWQDIPaZwOm8pcSXEufv+yXFizx
         NxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954398; x=1734559198;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysfEfMkRShl7ZQ6rcvjQZizTooHGsZAtmuWoKudrSMo=;
        b=g9CIdUVBe9dXrfpaWSGfiRGuZmJnphpUs7n3moWZ2NEgVIvR/zg6BK1F5cxB+Lgjfh
         DQpaj2CpLlLKdP20MRHIsnREUncytiuFDrcMA75whrPKsNX3GBfWR9A5RVFDuPFK1zmO
         dp9tkm+z7DYvBF2hOG3oZVUx09XpDi1vVe4vFgXJ6jf4SCzQETFcK25TnIOmrCKHqkem
         ZbDBm7zU+LdQwLJpYX7HIPZ4TmNXXefhfChUPWzOQhlxBZONmImbLHZIZgq2hohqMK1x
         MWDxdJ0554G2hhA4NQKmboULfDlW1kRqfcMCyIKSkUuM7Ilm9U41JozXnf6MpQx0E1M2
         5xOA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9Ke5SXx647l8rMK2muqDt1D3BLlNsBDKoi4bPtM4qJbi0EOooEUgxyD1I22rl7o0aAerl5SQVI2WPvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3l7eGv4uMJoEPRF0M4RMKB7EIQdjuw1/AIFXDqt0r01uWIHC
	TM5MWynt0nEFN2EUqSGOz68VpBRwdTmymaKRjV7iHuEi0vRw+WidMDkuhP0z/hg=
X-Gm-Gg: ASbGnctKRx0NEQi4HWJZWC8/NAh57y1T6Uyo9aHzBszDevRsRPIskZnirNAV5Gc5D6O
	7tQa6K7AE3rhsj1J5noPJ+FioXhsbX3z8RC2MsDUrSAHISWEdl6M/zG7KSt7ywP6bgdk+ydjYMv
	UB1ui3vfLuNsp/J4FJzTmsXp2bci1icG8A8cWm4TaFV68Ou6okEFkcKONJKpQQqyKBi0LC6fiJS
	9NVgngXMGalPc4xEGak5aO+vLwniMe0UORe3kwzCQSM9dM=
X-Google-Smtp-Source: AGHT+IEe15JJyYKtkAHuxohnoY6qiZwwCLJ+yMJNp2SXyg2ac68X6HXMty2F6N0NtFrMS07/og1DhQ==
X-Received: by 2002:a05:6a20:cc0a:b0:1e1:cd9c:3775 with SMTP id adf61e73a8af0-1e1cea981c0mr1154087637.12.1733954398333;
        Wed, 11 Dec 2024 13:59:58 -0800 (PST)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cf9f681esm8213135b3a.98.2024.12.11.13.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:59:57 -0800 (PST)
Date: Wed, 11 Dec 2024 13:59:57 -0800 (PST)
X-Google-Original-Date: Wed, 11 Dec 2024 13:59:56 PST (-0800)
Subject:     Re: [RESEND PATCH] riscv: Fixup boot failure when CONFIG_DEBUG_RT_MUTEXES=y
In-Reply-To: <7e93d7a9-caa8-40c4-997a-d96ad94dbe94@ghiti.fr>
CC: guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
  Bjorn Topel <bjorn@rivosinc.com>, Conor Dooley <conor@kernel.org>, leobras@redhat.com, peterz@infradead.org,
  parri.andrea@gmail.com, Will Deacon <will@kernel.org>, longman@redhat.com, boqun.feng@gmail.com,
  Arnd Bergmann <arnd@arndb.de>, alexghiti@rivosinc.com, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex@ghiti.fr
Message-ID: <mhng-a0dbdedc-aed2-4dc3-b556-3a81530e7ec4@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 04 Dec 2024 00:27:00 PST (-0800), alex@ghiti.fr wrote:
> Hi Guo,
>
> On 30/11/2024 16:33, guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> When CONFIG_DEBUG_RT_MUTEXES=y, mutex_lock->rt_mutex_try_acquire
>> would change from rt_mutex_cmpxchg_acquire to
>> rt_mutex_slowtrylock():
>> 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>> 	ret = __rt_mutex_slowtrylock(lock);
>> 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>>
>> Because queued_spin_#ops to ticket_#ops is changed one by one by
>> jump_label, raw_spin_lock/unlock would cause a deadlock during the
>> changing.
>>
>> That means in arch/riscv/kernel/jump_label.c:
>> 1.
>> arch_jump_label_transform_queue() ->
>> mutex_lock(&text_mutex); +-> raw_spin_lock  -> queued_spin_lock
>> 			 |-> raw_spin_unlock -> queued_spin_unlock
>> patch_insn_write -> change the raw_spin_lock to ticket_lock
>> mutex_unlock(&text_mutex);
>> ...
>>
>> 2. /* Dirty the lock value */
>> arch_jump_label_transform_queue() ->
>> mutex_lock(&text_mutex); +-> raw_spin_lock -> *ticket_lock*
>>                           |-> raw_spin_unlock -> *queued_spin_unlock*
>> 			  /* BUG: ticket_lock with queued_spin_unlock */
>> patch_insn_write  ->  change the raw_spin_unlock to ticket_unlock
>> mutex_unlock(&text_mutex);
>> ...
>>
>> 3. /* Dead lock */
>> arch_jump_label_transform_queue() ->
>> mutex_lock(&text_mutex); +-> raw_spin_lock -> ticket_lock /* deadlock! */
>>                           |-> raw_spin_unlock -> ticket_unlock
>> patch_insn_write -> change other raw_spin_#op -> ticket_#op
>> mutex_unlock(&text_mutex);
>>
>> So, the solution is to disable mutex usage of
>> arch_jump_label_transform_queue() during early_boot_irqs_disabled, just
>> like we have done for stop_machine.
>>
>> Reported-by: Conor Dooley <conor@kernel.org>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> Fixes: ab83647fadae ("riscv: Add qspinlock support")
>> Link: https://lore.kernel.org/linux-riscv/CAJF2gTQwYTGinBmCSgVUoPv0_q4EPt_+WiyfUA1HViAKgUzxAg@mail.gmail.com/T/#mf488e6347817fca03bb93a7d34df33d8615b3775
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   arch/riscv/kernel/jump_label.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
>> index 6eee6f736f68..654ed159c830 100644
>> --- a/arch/riscv/kernel/jump_label.c
>> +++ b/arch/riscv/kernel/jump_label.c
>> @@ -36,9 +36,15 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
>>   		insn = RISCV_INSN_NOP;
>>   	}
>>
>> -	mutex_lock(&text_mutex);
>> -	patch_insn_write(addr, &insn, sizeof(insn));
>> -	mutex_unlock(&text_mutex);
>> +	if (early_boot_irqs_disabled) {
>> +		riscv_patch_in_stop_machine = 1;
>> +		patch_insn_write(addr, &insn, sizeof(insn));
>> +		riscv_patch_in_stop_machine = 0;
>> +	} else {
>> +		mutex_lock(&text_mutex);
>> +		patch_insn_write(addr, &insn, sizeof(insn));
>> +		mutex_unlock(&text_mutex);
>> +	}
>>
>>   	return true;
>>   }
>
>
> Sorry for the late answer, I've been sick lately!

Ya, I was also sick -- bad timing.

> Thank you very much for looking into this and finding this not-so-bad
> solution! I remind everyone that this is a temporary solution until we
> can use an alternative instead of a static key.
>
> You can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> The revert is still on the table IMO, let's Palmer decide.

IMO it's fine to just take this as a fix.  Reverting stuff is always a 
nice big hammer to have if we don't get a fix in a reasonable timeframe, 
but with a fix avaliable in the time I was out sick anyway I think it's 
fine to just take this.

So I've got it queued up on fixes.

> Thank you again Guo, really appreciate you took the time to find this
> solution!
>
> Alex

