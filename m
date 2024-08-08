Return-Path: <linux-kernel+bounces-279882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8194C2F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8C11C21D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EEA18FDD1;
	Thu,  8 Aug 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxCPXSj5"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA1118E764
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135559; cv=none; b=QksxgaX0zPbYQilv9C/jO2EUbx/VUr5CRN9gWr/0UsNB/eRnknFaMvBJhNFcyXxwWswfNSyv4Bd+8toKyAGWAMeKfXEQRg35HKupFc9rUC0bYwBhCNIoJup6Itvs6omq6shDuFjkHJ3Gyiy9H4iyQXDokoMg0FsSvhsohzK+MfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135559; c=relaxed/simple;
	bh=kHu5rUKPLyX/YM6NaEw7wFu32zR+5JVICXfDH4msB0k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pPhc01hc9kswnm5FYkHxn2yDLLea6F6DTVFeOnIb86B9dbZybYAeu2NLkZrTelGjPfd95rqu9I8/ROj2wc91DWWdnOWtVaYGakfRyz7NPsWzJdB4kWezyFOryzurO4ASVuE1bV7ZvwdhGc4UCfoR4LOwtvrZ3Kg7ZdTPSYWojL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxCPXSj5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc5296e214so12512215ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723135557; x=1723740357; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iS4FMchnREFWPCXR0AfnXAqNGlHQ0vvYX58exUAZSyo=;
        b=JxCPXSj5vSE1EOjCPEKSX1O49BIEI709bdaKHA8bb7hznjTT6bb3UORTsZDNf81+g4
         COsq4wmKrQH2OLxEgYC5L6GvRfN8D4/fejqaLScl8aCQQYNhVqoxE7PwkSq6oVFOn3xT
         0L6/zQNt26KAD0IURFeGxgfjhQNTuVioykA66WFR4YG2Y+ipBirPrSs1VZmOR5jko6T6
         UbiTLA8n6KQFftYdza3/KumUnhDQxb4IwNAbL7cCSOMkx9qw3o8UXzq3Nkw7Lf92VNsU
         0OYpJ8FrTLcnKjblybei9Z6agJXIXTeqOg7fj2LDssNd+DZPos6NfE6mQhXe0StdDjkh
         LgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723135557; x=1723740357;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS4FMchnREFWPCXR0AfnXAqNGlHQ0vvYX58exUAZSyo=;
        b=HY/VOvLtQ1BuyhO2Tl67oypfGj5IeQyU4H1gOJBPAo/asbyGbGpLK7gvpYb9RzTLz+
         +t2exte1ZDLvL/z4Q7s1ofXMxm9d7qfc1A1O4r0yQ+yUcTAbxlflor3rC61rI2VpWBX1
         GKdPEwdhpvA9SpBju+t0CB8q8ckaRKk0xUaQu540gdXHvlnEMrsMELIvXXIDiqDOuRHe
         SrPzXQB4EFdkh9gUN8vDVhjDGcDY4KaHBwHWonon+ulfxVidAH3oHG0+MGeIpN6RTTV4
         /bQQnFYF1hdJG3XAtqBei62PU+ubbY3CFbPiSFujI/LEOC8v1sa4w65DTUWVYnXtncr/
         j6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWdvztwDGwNtGNjI6HWGJIznZBjdxh6lSQJrv1x0f4w/TP0tAIYim/yVxzygAox7NHuVbhLiyCID5vYDal/KnwQMbH7/f6bw+NiIa5r
X-Gm-Message-State: AOJu0YzoY5zU05YHJXEzxfrqdlWAoOeS8YQDDK5NqtD3H+Q4Ne0OQonw
	g/qVuxlcFSgykVYaFO/Wra0r2KVqEL04DDta9keU98xyL9Lo3Zgd2j/m3A==
X-Google-Smtp-Source: AGHT+IHI1dkfiHvwjRjvRVTgtFNrN4Mxb1bCTsgW5AxeEL0/shuTRi5+0pgviMfnnLQwQwhw83rMuQ==
X-Received: by 2002:a17:902:db0d:b0:1fc:3daf:8a0f with SMTP id d9443c01a7336-200952274a5mr28788425ad.7.1723135556500;
        Thu, 08 Aug 2024 09:45:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59179793sm126793415ad.200.2024.08.08.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:45:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 8 Aug 2024 09:45:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Backtrace in ppc SMP code after enabling security modules
Message-ID: <506a1b59-8680-44ae-9cc5-e2cccb32da78@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I recently enabled several security module options in my test system.

CONFIG_SECURITY=y
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_KUNIT_TEST=y
CONFIG_SECURITY_LANDLOCK=y
CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_SAFESETID=y
CONFIG_BPF_LSM=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"

When running ppc tests in qemu with the above enabled on top of SMP
configuratins such as corenet32_smp_defconfig or mpc85xx_smp_defconfig,
I get the following runtime warning.

...
LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/smp.c:779 smp_call_function_many_cond+0x518/0x9d4
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc2-00127-g2e3e7093e9c8 #1
Hardware name: MPC8544DS e500v2 0x80210030 MPC8544 DS
NIP:  c0172ca8 LR: c01731b0 CTR: 00000000
REGS: c2669d60 TRAP: 0700   Not tainted  (6.11.0-rc2-00127-g2e3e7093e9c8)
MSR:  00021000 <CE,ME>  CR: 24004288  XER: 20000000
GPR00: c002255c c2669e50 c253b5c0 c267b484 00000000 00000000 00000001 c2680000
GPR08: 00000000 00000003 c2680000 00000000 44004288 020a1e18 00000000 00000000
GPR16: 00000000 00000000 00000001 00000000 c0000000 c01731b0 00000000 c267b484
GPR24: c00224fc c0773760 c0770b50 00000000 00000000 00029000 00000000 00000000
NIP [c0172ca8] smp_call_function_many_cond+0x518/0x9d4
LR [c01731b0] smp_call_function+0x3c/0x58
Call Trace:
[c2669eb0] [84000282] 0x84000282
[c2669ec0] [c002255c] flush_tlb_kernel_range+0x2c/0x50
[c2669ed0] [c0023b8c] patch_instruction+0x108/0x1b0
[c2669ef0] [c00188a4] arch_static_call_transform+0x104/0x148
[c2669f10] [c2033ebc] security_add_hooks+0x138/0x24c
[c2669f40] [c2032e24] capability_init+0x24/0x38
[c2669f50] [c203322c] initialize_lsm+0x48/0x90
[c2669f70] [c2033b68] security_init+0x31c/0x538
[c2669fa0] [c2001154] start_kernel+0x5d4/0x81c
[c2669ff0] [c0000478] set_ivor+0x150/0x18c
Code: 91220000 81620004 3d20c209 3929e478 556b103a 7c84582e 7c89202e 81220000 2c040000 3929ffff 91220000 40a2fbb8 <0fe00000> 4bfffbb0 80e20000 2c070000
irq event stamp: 1204
hardirqs last  enabled at (1203): [<c11d85f8>] _raw_spin_unlock_irqrestore+0x70/0xa8
hardirqs last disabled at (1204): [<c0023bcc>] patch_instruction+0x148/0x1b0
softirqs last  enabled at (50): [<c0064b4c>] handle_softirqs+0x348/0x508
softirqs last disabled at (43): [<c0006fd0>] do_softirq_own_stack+0x34/0x4c
---[ end trace 0000000000000000 ]---
landlock: Up and running.
Yama: becoming mindful.
LoadPin: ready to pin (currently not enforcing)
...

Any idea how that can be fixed ?

Thanks,
Guenter

