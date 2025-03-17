Return-Path: <linux-kernel+bounces-565115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE995A66130
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79D33B9303
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DC31F5852;
	Mon, 17 Mar 2025 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSpNf1Q9"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F72F30
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248887; cv=none; b=tLNJGbRNU+AyUGCcK9m8gwODHnFJisJgCbYL0dNDa4NzHugzN1gGQqEXjqav8GP6qTS88dsk1+y+qVbg7kycjQqfdLhElpOL8wPPpSarbjYNXBcTvb8VTvOFXoaLhCXroALKIl+vZmIT5wdPQ8af2BnQzAIes4pLFpzo5ieBxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248887; c=relaxed/simple;
	bh=08v62g5PHCZUOUMn79W898y8a5/lZvOSsjhHHaY0zI0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nCYb73yo9DXaxrXmbWOHlwC5JugzwjYzC/VvUmBBwoNy9lQ3J69LVde5BBaZwSG6AeV8sYaOksuAKYRVsc1i5H5AqrvsnBckLxpKrkA9ByOL6VDl4QderX5nRSMcao/tL3kLFsfK4qLzKaJOyMvoPE1YQvHIZhSG/SG5HJ1AkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSpNf1Q9; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72be60c1d7dso148133a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742248884; x=1742853684; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJZa+Jfm1tEK2sj3i4Ro7PoGIvJQKz3Mvm3/szkGGRg=;
        b=VSpNf1Q9pBUhexZEP+bLBcxvHUaljzIepzwjte30zqzDPUP3QqEsS74PbC4JHrSATw
         blNPDAja93JRp25FZotsTSCMNCPNLHrlgKShbi/uMM+/U6vcebZO+L08W6sx5i3pcztq
         FhMLWpjxrGoUpeI+G/mTJhxGyGDpvFLj2hVnhmN59t3xnlDoubVKde2Wd7uY1Ce+7n3F
         aiKP9AvZKkkVXJ0peQWO7FNuxClFHg8iiXS3uv5goQJbCe4U+gFLswSRCI5/CIS5xWA1
         qGJYXY82YL4rEGBJZQ7lgPY9pUrE9huPyLbIleXqG+f59RPLo99upiQ/mkx1dmTpCdVW
         BN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742248884; x=1742853684;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CJZa+Jfm1tEK2sj3i4Ro7PoGIvJQKz3Mvm3/szkGGRg=;
        b=pAQC3Mv07q8YIxB+4rkrcoIX2isEhzCNzlG/8bJg9K0gAii98npD1cfj09gd/rGGix
         gHHCZJr3rUOfarqh6hSMDm4A+jg5kHRsVLz++IRnH/KvUcnFGYyckZsllaUc062u5ghF
         skWKkpMV2xvcLCkpXCb7RZu42B+WE4DNF5O8dqysJj7wja/4QjnkO7NAe2uWUV5HopPb
         RWrKp7MiEBCqmm//a4akJx36ICbV9tf554gVY8nY0acSQgv5JfUaZr6F/678jOOhAIo0
         AEJx6k3pSLcvRRWy4dX0H/4FiuT9B2Exbk0Je2G82slmRcgvSe3LZrzC9gLR5oRA7y2e
         X+ww==
X-Forwarded-Encrypted: i=1; AJvYcCWXIeI3f0L9PGhlMzgo31gCgSKztLNRrMILyLzHLXmRr5GnpFcPh4nY8L5HAoH6AS/rkYO/pKbIdahQvW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRmSr1+wAFVVCY9D+s+I8iJLqkr42L7R9cLu+mHKQT3y3yDCz
	v2csfyUZ83Xz7YMcnT83uV8hvvu1BpBzxs8mbH++4T99qNuXfVM4
X-Gm-Gg: ASbGncsZ4mZd0zGWJZ80xxdNfivLg87QB8A+FBSLGRs0X7jZDlcd0VsXiOJM0LyHP+r
	cZy7Vm1DvB1Pv2c6EWD8i9RO23CUueIUrs83jtOShSxMg8Z7ECDIf1XrTew5ez6RQLYk3/c6Pq7
	r3QV1/WpEK1tedWTliBb+VMjEZJGxFYElhs3jci5ssMvKUvAdH3WBFvLwCTMSrFJ+hPOuOIp3y8
	XsC5Wu8XBY4YarxuWkpPOK/gwBtOTifEWa+Ji/EZ6iYYEH5/68Oqs2IEM1YYkefZuMbKpglp/yx
	fBihHo2xTb76v0w6pJvi15iaHlOd23ij3uNJ13mhXwqIP51o1IgWmZVJ97erRLK/R9Tmh/12gUT
	JiLsVDOn75LwCR1mMQsja7Q+rqdc/GTqy
X-Google-Smtp-Source: AGHT+IGnXMK+9wKvbegCSLADO7Vj3cqpV0b/XLNyaioKtEKv3ELFkBPa1tdO0SL18tY1ddpCqc9YlA==
X-Received: by 2002:a05:6830:4117:b0:727:372e:600e with SMTP id 46e09a7af769-72bee68a4f9mr742359a34.14.1742248884662;
        Mon, 17 Mar 2025 15:01:24 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb269dfbesm1765657a34.22.2025.03.17.15.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 15:01:23 -0700 (PDT)
Message-ID: <f2272f04-510e-4c92-be5e-fedcbb445eb0@gmail.com>
Date: Mon, 17 Mar 2025 17:01:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: pmladek@suse.com, Andrew Morton <akpm@linux-foundation.org>,
 jani.nikula@intel.com, open list <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, takakura@valinux.co.jp,
 john.ogness@linutronix.de
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [RFC] panic: reduce CPU consumption when finished handling panic
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After the kernel has finished handling a panic, it enters a busy-wait loop.
But, this unnecessarily consumes CPU power and electricity. Plus, in VMs,
this negatively impacts the throughput of other VM guests running on the
same hypervisor.

I propose introducing a function cpu_halt_end_panic() to halt the CPU
during this state while still allowing interrupts to be processed. See my
commit below.

Thanks in advance!

Signed-off-by: Carlos Bilbao <carlos.bilbao@kernel.org>
---
 kernel/panic.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index fbc59b3b64d0..c00ccaa698d5 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -276,6 +276,21 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
         crash_smp_send_stop();
 }
 
+static void cpu_halt_end_panic(void)
+{
+#ifdef CONFIG_X86
+    native_safe_halt();
+#elif defined(CONFIG_ARM)
+    cpu_do_idle();
+#else
+    /*
+     * Default to a simple busy-wait if no architecture-specific halt is
+     * defined above
+     */
+    mdelay(PANIC_TIMER_STEP);
+#endif
+}
+
 /**
  *    panic - halt the system
  *    @fmt: The text string to print
@@ -474,7 +489,7 @@ void panic(const char *fmt, ...)
             i += panic_blink(state ^= 1);
             i_next = i + 3600 / PANIC_BLINK_SPD;
         }
-        mdelay(PANIC_TIMER_STEP);
+        cpu_halt_end_panic();
     }
 }
 
-- 
2.47.1


