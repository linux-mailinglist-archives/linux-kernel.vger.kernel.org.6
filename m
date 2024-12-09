Return-Path: <linux-kernel+bounces-437983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16599E9B43
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FF41884740
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D25139579;
	Mon,  9 Dec 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSduGQB6"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A415136358
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760591; cv=none; b=X2UIlYnLPvPlOYtlGNrxjbzr7QOzI2Ws514ffLoyPExP0CyGxL0XTC92fe5HLUg6LSAIYCQr1v6D2WLG4RzACmG8qlDAaRC89zqtpw+2FtSOFt2a37laIn6HBndUm+rdv0xFV0oYJSEGwZw9sRoRfGQgiN7v422oSmMYWylHghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760591; c=relaxed/simple;
	bh=C36zNPc/jbnuBcAYithGaYsubdt6UiWPUDVuWScR/bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N01bX0r8/AglSkN9nKcqfQfb7jsIgmE6PuR1w5vXxReKVJlNf55urBNgQz7F5A6M6hb2jQhnD2S6CEr8NGnIj2tZrkPIuOhXhE20pdl4VIeUQCxNlOko1RAzlMqgzbNeBUD/i6kY8XH0yeiUQ0YP4XPXjkrs4Pgf3I7wvjl5wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSduGQB6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725abf74334so3806453b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733760588; x=1734365388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNzOfGzLAseJibdxxhcMGoyOqJHa9JTOySWRlkmre7s=;
        b=lSduGQB61KejtBVDmGUm+Qpa6cQZ7Z4ttrOW2sUTOsSJlJNROjmm88wGa4WnQeM0A4
         +JNqPwZGfoZNOmtarAzToC0bdYLSoHuIYl8usMG3v1JjtrSfExV2GfLfRQxoqAr/Vn2Q
         G4OwEGDZVZJoWWWhxQG9i6Q7uCdD3GCuTDXTwRbtk11sRv1f4s1Dw1dz6G5qVDewUiLn
         bRuLUk0/WTlyp+4heAqK18lVD/2xWPYFArvAtraRcUqne0QABmHVi1apgx28bs9A5jBX
         E4mQ6qUJXIUy/BCzk/SjI+GA8ntnZmF0sX1/CwaGDuVKb8tajHt/PqfafyDuxd1xnvO0
         Pz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760588; x=1734365388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNzOfGzLAseJibdxxhcMGoyOqJHa9JTOySWRlkmre7s=;
        b=K5b0qZJkel/Ra72AukiG+gdbGHW41dP0HvA2cDtiNamyKYlyaEsSFdO96DQvzKTZT8
         LlEI+7+S11unCuj0fwSgXMmCjecdHexgHuoSS14UysPtc7NpDQie+aZ2CF9dBpOIv9mn
         Dvz6GvJ2wXZO9aPATxDnZ/Oy/Gw2rTf93PFnXMFjc/CVTOA15GUwydocsA2JKuU5RXyk
         1AsAp6EWWDEAedTM6XJmnT7RvaQQZtTDunzgF9EeODDzHfuaqGzvda9oAOC9S6ccDmYV
         b2bsPtB4WkKc5BkB9xlnqQAzvYmxDcAGX9ot/zKFcChIfflcu12fUCGZIRRNS1G9obby
         O5fw==
X-Forwarded-Encrypted: i=1; AJvYcCWnZmXKXkTT/PULnzJe/MVAZbptKf9oVLN0BUKu3SJdWDpD9REfZmqWCkeGFfXZ748hMUxe+8vBBKoNPfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYaUTyRCJ8H05mpdnCBXFqFjRyhfrxyk9y7sE5J/7EO70n+D3
	FiJgC4eOEkTJneHdW9h3QQH6I6v0a4lyC55AsC5aUoco14B0POs1
X-Gm-Gg: ASbGncuNF1ZVMLOOih1KMjCOq2xYGw2fhrLD1vs+vTxC+ctXEhcocdT/na8sO1eyHWr
	deYvwmZtt88xQ87paX0gCEursAhlz2/CVtqf0UwVLbftMnMpKacsnmg9Xz3xVCwjMhqrX2tfF+2
	yHiDg3Bk5kdqCuHLNH0WxLmTU1wiBOtdEB5z1ZF61L0sujLbvFIUxKn8+ddLv2Vre0eTBURarSH
	ncFIhYtQN59RzmXrkGF4wWWGhk2suLwmg+KGgMb+/5Z3m+Kx7v3jmfhVmOL8Mdya7CaLAZ5wxO2
	mJieB9z0kkpIKuiOFMmGRdskmGcQMDWB6+SCqtimdbbvSzQ90cWk
X-Google-Smtp-Source: AGHT+IGDgARAQ3C8rJb1gmNnhbeSqhembKboC+9YMymczxSCAjuRCR37JTa75SJFHELFYuLorlVsjA==
X-Received: by 2002:a05:6a00:1708:b0:725:f1ca:fd76 with SMTP id d2e1a72fcca58-725f1caffb6mr3781567b3a.0.1733760588406;
        Mon, 09 Dec 2024 08:09:48 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d3fc95fasm4207124b3a.177.2024.12.09.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:09:48 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: boqun.feng@gmail.com,
	peterz@infradead.org
Cc: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	longman@redhat.com,
	mingo@redhat.com,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com,
	tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Tue, 10 Dec 2024 01:09:43 +0900
Message-Id: <20241209160943.254299-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z064BAsxrEe5zQV7@boqun-archlinux>
References: <Z064BAsxrEe5zQV7@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Sorry for being late on reply. I was trying to understand some 
of the selftest reports that came across...

On Mon, 2 Dec 2024 23:49:24 -0800, Boqun Feng wrote:
>Maybe the right way to fix this is adding a conceptual local_lock for
>BH disable like below.
>
>Regards,
>Boqun
>
>------------------------->8
>diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
>index fc53e0ad56d9..d5b898588277 100644
>--- a/include/linux/bottom_half.h
>+++ b/include/linux/bottom_half.h
>@@ -4,6 +4,7 @@
> 
> #include <linux/instruction_pointer.h>
> #include <linux/preempt.h>
>+#include <linux/lockdep.h>
> 
> #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
> extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
>@@ -15,9 +16,12 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
> }
> #endif
> 
>+extern struct lockdep_map bh_lock_map;
>+
> static inline void local_bh_disable(void)
> {
> 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>+	lock_map_acquire(&bh_lock_map);
> }
> 
> extern void _local_bh_enable(void);
>@@ -25,6 +29,7 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
> 
> static inline void local_bh_enable_ip(unsigned long ip)
> {
>+	lock_map_release(&bh_lock_map);
> 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
> }

Maybe &bh_lock_map should be acquired at local_bh_enable()?

 static inline void local_bh_enable(void)
 {
+       lock_map_release(&bh_lock_map);
        __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }

On !CONFIG_PREEMPT_RT, I noticed that softirq related selftests
(e.g. lock-inversion) fails with recursive locking error

[    0.741422] ============================================
[    0.741447] WARNING: possible recursive locking detected
[    0.741471] 6.12.0-rc1-v8+ #25 Not tainted
[    0.741495] --------------------------------------------
[    0.741519] swapper/0/0 is trying to acquire lock:
[    0.741544] ffffffecd02e0160 (local_bh){+.+.}-{1:3}, at: irq_inversion_soft_spin_123+0x0/0x178
[    0.741621]
               but task is already holding lock:
[    0.741648] ffffffecd02e0160 (local_bh){+.+.}-{1:3}, at: irq_inversion_soft_spin_123+0x0/0x178
[    0.741721]
               other info that might help us debug this:
[    0.741750]  Possible unsafe locking scenario:

[    0.741776]        CPU0
[    0.741793]        ----
[    0.741810]   lock(local_bh);
[    0.741840]   lock(local_bh);
[    0.741868]
                *** DEADLOCK ***

where it does SOFTIRQ_ENTER()/EXIT() and SOFTIRQ_DISABLE()/ENABLE() 
as each enables BH with local_bh_enable().

But I was little confused that isn't recursively disabling BH allowed, 
especially if PREEMPT_RT doesn't disable preemption? (I was also 
wondering if disabling BH recursively is something that can happen 
on !PREEMPT_RT if it disables preemption...)
If so, wouldn't report for such case be false?

>diff --git a/kernel/softirq.c b/kernel/softirq.c
>index 8b41bd13cc3d..17d9bf6e0caf 100644
>--- a/kernel/softirq.c
>+++ b/kernel/softirq.c
>@@ -1066,3 +1066,13 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
> {
> 	return from;
> }
>+
>+static struct lock_class_key bh_lock_key;
>+struct lockdep_map bh_lock_map = {
>+	.name = "local_bh",
>+	.key = &bh_lock_key,
>+	.wait_type_outer = LD_WAIT_FREE,
>+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
>+	.lock_type = LD_LOCK_PERCPU,
>+};
>+EXPORT_SYMBOL_GPL(bh_lock_map);

Sincerely,
Ryo Takakura

