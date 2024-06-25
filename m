Return-Path: <linux-kernel+bounces-229253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD724916D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E3A1F21612
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1716FF31;
	Tue, 25 Jun 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="UxCp0fxH"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007116F29C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330312; cv=none; b=qx09znQNg07uiM6WywE2HQrOS7L4kMk7zpZ4QM8naUWwILrtALUsOS5ABTcjcT1iSBXfy4jTRs64bF2PuyUZbUftDUFsWqTCP3JX4XE6YXC2boOKP/3AdV3YJ6v5mJdORzkzf1tO99cMdaAMiS7rCQVUSqZen7CVGhaamh6m+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330312; c=relaxed/simple;
	bh=hf5eUmooJC7dWoChVFFPsyBXOKh1NM93BaxyD/i/B2Y=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=bpozkzHTOPgZ3TtFOTW2evjS7/UhLJJagiCJFpkSltnovK2DGO92/H8lqq6lBgDcjFL1exrTMuNXfUynrtW944z/Q0P5229z4rQ9jcm/UjOVVMO8nM/6lv9F9QWwYmVnk/pze4L998E0FWXtQO3pBj+4pxubA1SY8kgQkHGVMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=UxCp0fxH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70670188420so2354765b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1719330309; x=1719935109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tZOMKcRfzsOTLcaI6P+nurFJ1oFQE37Rn/GemYRQhk=;
        b=UxCp0fxHEqZmwtgUKLRf2Ye8esSEOv7F3/gtGn+v6gDJcBDBhN6DEjIA/7++GtfvLf
         GOSGRQ46Exm3dqhsdYG/wGpObpNob9D/aQGbtE0M2AplTHuHey9hbu65vxzthZ2B1CXS
         sw03VAbR9/SRYIz1Rj5Isv+LQGg/9CZvHZSroQoKd30LB+yS6SCOHjLaxK8Xl7umkNx1
         vuafFbmiZp9h/Qb6SGV55VAoXwuv/NXSDELdUFesP9Jv53DsW1ZzJU/fNK6CTvBRlGv8
         3jWwt26GWE3D56vbAyMqGc6+xzUyUR6tgWG9FwWo8qPMexGPPdJBa05x27vhtnqjS+1M
         gOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719330309; x=1719935109;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tZOMKcRfzsOTLcaI6P+nurFJ1oFQE37Rn/GemYRQhk=;
        b=C4LXx//qIfKLQHnKQ4OsI2xnVAxx5b2lnBlt2ewhHiTT8wS1Nu4YyNK89m7Bf2roQA
         AN9k3TO5ll9BjwvQcaPxnjMb/ZHUItpAQgieS3RWxLBF0a9ccbr4iD13vmUnZlOpQLf6
         EH8mhihB00FFh67skadAh1sXkLHG2ufEmnVcPCyg/6GcsMxGthGv/Tf7/YGY3eXE618q
         0JgeFAMaG+rxCMz6KzOTnXng76z4KyBV+XD2zTFxRKvlvquhb+USzP6/TVL37GRBI5cz
         X82ql2MtcDGkjJvLc27SkQf6KxG8t0rUZ9dOii4bGmawkmAVG1gBnd4yOwXUf4/F+okj
         Hx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWNvXemaN5tbBuymMaC5Ow5mA2ADKj30Xm95I0yra7PBmlPLSEyfYl7OYiluyobaV4TwBxZbghwsXl0NzI/kvoe4JKGPiJhqWu6hD9
X-Gm-Message-State: AOJu0YzgYWutcciKNGIp+mLG0S9S657SCo0eZBT7Vr3m1xv8R8RVgELh
	AkrO3h0OaWVsaYaWZ//UPYya+ZO/nN4Ndd6ZdlCBTw0bp1Pmx5eYRZRD3p0D29g=
X-Google-Smtp-Source: AGHT+IGSYCPwWhLTCA7tsdYi2n2YERYEuj0Bk7h22FlWi9B1mlJhhHz/QYqnR8FLA80DAw08tCIl9Q==
X-Received: by 2002:a05:6a20:b918:b0:1bc:ed85:3920 with SMTP id adf61e73a8af0-1bcee9893f4mr7574816637.52.1719330307012;
        Tue, 25 Jun 2024 08:45:07 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70677235b41sm4843347b3a.24.2024.06.25.08.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:45:06 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:45:06 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2024 08:45:05 PDT (-0700)
Subject:     Re: [PATCH 1/8] riscv: stacktrace: convert arch_stack_walk() to noinstr
In-Reply-To: <cb71a5e9-aafe-48af-9f16-baae407d467b@ghiti.fr>
CC: andy.chiu@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, alexghiti@rivosinc.com, zong.li@sifive.com, rostedt@goodmis.org,
  mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>, nathan@kernel.org,
  ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, puranjay@kernel.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
  llvm@lists.linux.dev
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex@ghiti.fr
Message-ID: <mhng-37c10407-3c40-4045-9627-0b53f770cb4e@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 18 Jun 2024 02:55:32 PDT (-0700), alex@ghiti.fr wrote:
> Hi Andy,
>
> On 13/06/2024 09:11, Andy Chiu wrote:
>> arch_stack_walk() is called intensively in function_graph when the
>> kernel is compiled with CONFIG_TRACE_IRQFLAGS. As a result, the kernel
>> logs a lot of arch_stack_walk and its sub-functions into the ftrace
>> buffer. However, these functions should not appear on the trace log
>> because they are part of the ftrace itself. This patch references what
>> arm64 does for the smae function. So it further prevent the re-enter
>> kprobe issue, which is also possible on riscv.
>>
>> Related-to: commit 0fbcd8abf337 ("arm64: Prohibit instrumentation on arch_stack_walk()")
>> Fixes: 680341382da5 ("riscv: add CALLER_ADDRx support")
>> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
>> ---
>>   arch/riscv/kernel/stacktrace.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
>> index 528ec7cc9a62..0d3f00eb0bae 100644
>> --- a/arch/riscv/kernel/stacktrace.c
>> +++ b/arch/riscv/kernel/stacktrace.c
>> @@ -156,7 +156,7 @@ unsigned long __get_wchan(struct task_struct *task)
>>   	return pc;
>>   }
>>
>> -noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>> +noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>>   		     struct task_struct *task, struct pt_regs *regs)
>>   {
>>   	walk_stackframe(task, regs, consume_entry, cookie);
>>
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> I'll try to make this go into -fixes, this is in my fixes branch at least.

Looks like there's some comments on the rest of the patch set.

Andy: aree you going to send a v2, or do you want me to just pick this 
one up onto fixes now and then handle the rest later?

>
> Thanks,
>
> Alex

