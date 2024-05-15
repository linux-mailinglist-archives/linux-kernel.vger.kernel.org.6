Return-Path: <linux-kernel+bounces-180190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FED8C6B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E6F1F25077
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC438FA0;
	Wed, 15 May 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="L/SAoOhf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCA5338C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792763; cv=none; b=Wks0fGwTfGOEk2GB7bV5CWlwcyaQZYF7eUJYrUdx98zpNlBuQwN3bukxegKhZ1ji27ytx8VCaUVjVVvdUAc11DVBRqVuxA0YkVTgK82R9WX6HkUAnHu4B1EkZPyJcPaHvQPdseZDGFCFRr3fqbKPQuseN4C4WTizM5Pm46SyLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792763; c=relaxed/simple;
	bh=dw1/uSbgCqNummnAusaarJatdbzq8Y7V3aaolPrBpPE=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=aWbn9gqwrueOChWkyeeDj7MLItpf2Anf1RzeTXAWDs9i3bDzT0qGTKTFc6JVFCrulmGoQeZ4QcBfHKHLjy54CLmUi5PvDBYO9GpdGGW+m/+gwBEHG/5nucGENESKLNJRGj6fLF4kdhL2MUOFmdhCdEbG0SW38XvafaNaBoRJh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=L/SAoOhf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eeb1a4c10aso44242075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1715792760; x=1716397560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQQzdQzBGV3DZrL9QqRIhsLoIytzbr5Nn+q/+rp6S9U=;
        b=L/SAoOhfMmEn0ODCNexG1lYDwPdJdEEVQQiDc2l6TWNQRQzaSvbv+pbedvmg5QBJ7B
         05wCerPeKFJsOijslAwZQ6ZKMY2PAvksayD/0z5vP/zKir/PekzJHf+SR6r8EPnk4KaN
         FFhgGQoTVnGpAOi3rr775+xqvni9GUrbuq5pLtecomI0tRqe+PWq/Fi7qEybblAVZlYz
         Wvdx7pHJpYRPExoD8uLtL6aauSygoRVZynYYu8QaX6szcN4eff+NZ8wLNEKIhO33PXk1
         FKB15toJStwHSTwd35K7IB0SROSjzxdU74JnND9e9RV8GzREVmWNlxjOC80Pifp+O8MU
         CuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792760; x=1716397560;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQQzdQzBGV3DZrL9QqRIhsLoIytzbr5Nn+q/+rp6S9U=;
        b=aylFf1i53bYtCYp1CgCtdw7Ju9oqYKbBeWp1jg/x4GuGvu06CPA2tGKL7KmBmZ6ihZ
         O+jKAaJXIokkcphUZf1OXCv1tuL9qZz1+eGTAGeQtXBczW7WHheE0K1uyxALh6ekrywX
         owcp6leGP9n3bpWnQCNSQNWt+QhuCLlSoSc5cF3JF1OlCa3xJiCDIC2RB6U/kransmyj
         Wl4jTcLejkMsFE8P1bns8ZmWgMhtf2ggdDfROcY7qU1GjNZKKGiwjnJWhpuyQkDPX//P
         kZ5Y7383JVXa4iHn6X7Ed1hxQmho0qZpzGIWqi3gTTDaG6uucWeajQK/ihhh+S9LZlT1
         dRHA==
X-Forwarded-Encrypted: i=1; AJvYcCUREIa21ftFCoDZO83i5FH+DSZH5Ysi8Y43t0SfR9KQJ2pDnpgMd42fPh3pBXK1Ffulj9RPRUxYTbhB4vwjubyqMwt3MesdQcF3BFAT
X-Gm-Message-State: AOJu0Yw+p0YhR9mw3/zlEmr87WXXlj/jGpmOIq06BIUbAtVltzUwt6cd
	OpBrunIVAzAYna42DENFOjaAsKEwAgHS0n3yaJwa/E0gT2fgK3+KDIt/7/dEOy4=
X-Google-Smtp-Source: AGHT+IHcHqSyEX4mzVByjYRHADLbnyHvlA3EH+pwK15IXluhS5E+pQUXzIRMTRRMFI5dY8+8yAW0/Q==
X-Received: by 2002:a17:902:744a:b0:1e5:3c5:55a5 with SMTP id d9443c01a7336-1ef43c0ceb1mr150722395ad.8.1715792759795;
        Wed, 15 May 2024 10:05:59 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf316f7sm120938135ad.164.2024.05.15.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:05:59 -0700 (PDT)
Date: Wed, 15 May 2024 10:05:59 -0700 (PDT)
X-Google-Original-Date: Wed, 15 May 2024 10:05:57 PDT (-0700)
Subject:     Re: riscv: irq-riscv-imsic-early.c:52:9: error: too many arguments to function 'riscv_ipi_set_virq_range'
In-Reply-To: <20240515-zen-calculate-289cfb90cd65@spud>
CC: naresh.kamboju@linaro.org, linux-kernel@vger.kernel.org,
  lkft-triage@lists.linaro.org, regressions@lists.linux.dev, linux-riscv@lists.infradead.org,
  apatel@ventanamicro.com, tglx@linutronix.de, anders.roxell@linaro.org, dan.carpenter@linaro.org,
  Arnd Bergmann <arnd@arndb.de>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-10b71228-cf3e-42ca-9abf-5464b15093f1@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 15 May 2024 07:36:33 PDT (-0700), Conor Dooley wrote:
> Palmer,
> This is the issue I point out to you on the call earlier:

Ya, thanks, I just hit it.  Looks like it's a semantic conflict between 
21a8f8a0eb35 ("irqchip: Add RISC-V incoming MSI controller early 
driver") and dc892fb44322 ("riscv: Use IPIs for remote cache/TLB flushes 
by default").  I think all we need is 

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 886418ec06cb..4fbb37074d29 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -49,7 +49,7 @@ static int __init imsic_ipi_domain_init(void)
                return virq < 0 ? virq : -ENOMEM;

        /* Set vIRQ range */
-       riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
+       riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI);

        /* Announce that IMSIC is providing IPIs */
        pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwnode, IMSIC_IPI_ID);

as a conflict resolution, which IIUC should happen when Linus merges my 
next PR.  So I'll try and remember to call that out.

>
> On Wed, May 15, 2024 at 04:18:58PM +0200, Naresh Kamboju wrote:
>> The riscv builds failed on Linux next-20240515 tag due to following build
>> warnings / errors with gcc-13 and clang toolchain.
>> 
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> 
>> Build Log:
>> -----
>> drivers/irqchip/irq-riscv-imsic-early.c: In function 'imsic_ipi_domain_init':
>> drivers/irqchip/irq-riscv-imsic-early.c:52:9: error: too many
>> arguments to function 'riscv_ipi_set_virq_range'
>>    52 |         riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from include/linux/smp.h:119,
>>                  from include/linux/lockdep.h:14,
>>                  from include/linux/spinlock.h:63,
>>                  from include/linux/sched.h:2142,
>>                  from include/linux/ratelimit.h:6,
>>                  from include/linux/dev_printk.h:16,
>>                  from include/linux/device.h:15,
>>                  from include/linux/node.h:18,
>>                  from include/linux/cpu.h:17,
>>                  from drivers/irqchip/irq-riscv-imsic-early.c:8:
>> arch/riscv/include/asm/smp.h:52:6: note: declared here
>>    52 | void riscv_ipi_set_virq_range(int virq, int nr);
>>       |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> 
>> metadata:
>>   git_describe: next-20240515
>>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>>   git_sha: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
>>   git_short_log: 82d92a9a1b9e ("Add linux-next specific files for 20240515")
>> 
>> Links:
>>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240515/testrun/23894295/suite/build/test/gcc-13-lkftconfig/details/
>>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2gUiKdxX7qM27ritMJT5pRyZhyi/
>>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240515/testrun/23894295/suite/build/test/gcc-13-lkftconfig/history/
>> 
>> --
>> Linaro LKFT
>> https://lkft.linaro.org
>> 

