Return-Path: <linux-kernel+bounces-563933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB142A64ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F5D3ADCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4772236FD;
	Mon, 17 Mar 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg9I2x5t"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A9235347
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208192; cv=none; b=bYTegIyq7e+uQlNEIt86us/e0nhgBxUnw1UGgAYB+HNPIRGGy6vIRKN5rkyPGQ0SdNSOPP5a2Ogz4vTYss3s6iJw4PcnniliSU22v1CGXt6U/GSZgXS6ySpbignUDnEeAarUD1MnVRx1z0m4s/jv9FrcOxbwRsBKK67pTeaUKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208192; c=relaxed/simple;
	bh=ttowJ0RwSBgYbbzKOp7L3l4PCvTt/2Q7/OlmZX6B32U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xru5cmy8aYi3UbQUMwYGavG5P6TTLiSR0xVVYZScq5cNcFcofWnkqw5aJKOzH5BVNPCOUhHOTdzA3RIM4AQP523nknlJmONsVDScDBDP/d4rAwN4IpNbcH0hOJTjGvMq6H3zjdO2A7FmwqVdVqlWHVN6/nt7YX1JwQXUfWYk6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg9I2x5t; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39727fe912cso900512f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742208189; x=1742812989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGTMnbx0Lkc4Mj7M6zPuFctTBxRo1EPEX72C6bvz4aQ=;
        b=Vg9I2x5tUacEm+lbSpew+BpPcRCDP61Q/bqdwgRgFuZBoZtORfRTi/nuaMNvmfGdMk
         t1uOcsGdPVr84OElGFtF65bJ91Iq7blxcCGSD64tSy9gP/fvDelrl54j4CWbEQ9ZKlde
         liQubagQxPIcDcZsxtd3KMTy82anbQUEgJ+0GFrNIQsYL8a6g4HYpYZ9741vXYyWLgkl
         iKAdSbUISn055h8YK70WNfMlpVRFS0l00ayqsS4cpbxWvtK40uEMBx0jxS5UyInu/TTZ
         DgokIszC1Qp+oBmLiCZm7NakMqwGsQS2a/mkOewPNFwfA6g5ES2e5RxSnVxGmCC9OGHe
         ZR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208189; x=1742812989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGTMnbx0Lkc4Mj7M6zPuFctTBxRo1EPEX72C6bvz4aQ=;
        b=l18ORZqV3uKl8pFRP73kwZ0W8DMoFU2Yxs2UxuYvT2kXJwnU8X6xmkcB5zlgFCF9hk
         DBonfMZULRZ2SUHYjVWGfNeGeRAE0qDcYxC1k4wAU2hxehzLkG+OfJmpefDs+ORabArh
         9X0XvL6JHOZBcaY1QRwg60dcHVrUBAmuF9r2LYYjOvjIQruoIyJP6Rsp09Yz4ioDxh9K
         WziUz2mUXDyhAou06ybdZgaaRGOPv8JNja0ShLinMQH2NJJ9L7byl1/ri6zpsnv9Hm8y
         0WWxxillUjplRbLuHW555tDmqJSq7bWB9rnJENLhvBiSngd0XSsRpdZiJlFO5eBgUZor
         GnFg==
X-Gm-Message-State: AOJu0YxSRGeCJlNd9M4tpfQVPw7Z7aBtp4OM4VmIC/N5Zr05BjrUj7pX
	xwMDegv6wjNZNtVbAZEU61izoP6cdwmEeeVlITX9Turb5mXN5kSe04zdC83I
X-Gm-Gg: ASbGncu5gjWt4I76hXxpCWZpbEZNHdTCtDC2UZDeUgKXfK2KsKdsY2ne0Lf6vtZIpfy
	urfOLRGka9t/R8wCDIP29KjX5f/zEJ25YwPP8Ra3Jb7WwAK57q8JqoEFLOs1LM1dwFAy7fyq2u2
	OmBQSNYZkXJQV+pSRcUguI4f8QXUQE2I0P/0ahInCz2S8Sk9dmLvKeACWvUy1CqkSpWilOtJEp8
	CRqFNQEBmh8Amy7FIjgflRrtppFjC2OerycfL3T21HaE+YiFaCBv50OmtPmf8AUqJAWhyMiHplZ
	hYplr4ZcZ1J3KZhRRJByIhBne84OABk6o2Boh8x4n/H+S79/I3WOBbvNN/s9/Ri57g==
X-Google-Smtp-Source: AGHT+IGxuKvw8uod1U5/dgfORaVxcStn0vSbX4+udaE4zEmKoNM2yKtayyk4qt8Z5OZQUJS71f6d3w==
X-Received: by 2002:a05:6000:184c:b0:38f:3073:708 with SMTP id ffacd0b85a97d-3971cf48df7mr9741939f8f.3.1742208189089;
        Mon, 17 Mar 2025 03:43:09 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3189absm14807262f8f.71.2025.03.17.03.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:43:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5/5] sched/debug: Remove CONFIG_SCHED_DEBUG
Date: Mon, 17 Mar 2025 11:42:56 +0100
Message-ID: <20250317104257.3496611-6-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317104257.3496611-1-mingo@kernel.org>
References: <20250317104257.3496611-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For more than a decade, CONFIG_SCHED_DEBUG=y has been enabled
in all the major Linux distributions:

   /boot/config-6.11.0-19-generic:CONFIG_SCHED_DEBUG=y

The reason is that while originally CONFIG_SCHED_DEBUG started
out as a debugging feature, over the years (decades ...) it has
grown various bits of statistics, instrumentation and
control knobs that are useful for sysadmin and general software
development purposes as well.

But within the kernel we still pretend that there's a choice,
and sometimes code that is seemingly 'debug only' creates overhead
that should be optimized in reality.

So make it all official and make CONFIG_SCHED_DEBUG unconditional.

Now that all uses of CONFIG_SCHED_DEBUG are removed from
the code by previous patches, remove the Kconfig option as well.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/Kconfig.debug | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..a2ab693d008d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1301,15 +1301,6 @@ endmenu # "Debug lockups and hangs"
 
 menu "Scheduler Debugging"
 
-config SCHED_DEBUG
-	bool "Collect scheduler debugging info"
-	depends on DEBUG_KERNEL && DEBUG_FS
-	default y
-	help
-	  If you say Y here, the /sys/kernel/debug/sched file will be provided
-	  that can help debug the scheduler. The runtime overhead of this
-	  option is minimal.
-
 config SCHED_INFO
 	bool
 	default n
-- 
2.45.2


