Return-Path: <linux-kernel+bounces-238616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D58924CE4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C761F22537
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D231DA313;
	Wed,  3 Jul 2024 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/vvZ1hO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C04683
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967932; cv=none; b=RZQqflWQ31Vq5a1a9Pn0to3OP9TwvS+ZuxDJWBqNAo6F4NJBcW/w1dLQFfhJfP3Y0FtgtP85dkY07m6SlFE7E3cSMqtgN913lqBf2Epi3clJnB7SfldhKga79lRY91kB0ax4BxUt+ATlEvHx3SiGfemnQC208P6Xh/ASvbqiDoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967932; c=relaxed/simple;
	bh=SbJ5jH7HTCaPQ29C934mRKx80B8YiJkDdAkEVCksC+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I4LkVyRZNeB56LC57EJ7kgaItFnblYQomr2BCLHp3tgOIiBAXWZsXljbi8T3/q85YCdMSbrgmqxJK3PiMZAgrEnkVJMW2ba8ad4if/3MpEm62i7ff9etqGLkvMw+DomzHyy/NicJs/oErvs8EM/1ovpLoWsBk1pvZeNAi+whRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/vvZ1hO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e9380add2so1432699e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 17:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719967928; x=1720572728; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hlxAVPd+z/4aF6F4fWIjQzN+IGGbLzBgd/ODx938I10=;
        b=T/vvZ1hO9W2njOKIJH8TAszQw3seHA2nXurf2KflDEw+jxoqNK/xLgc69j4dRPBfip
         6OhpKLECqraaEwM0CFXvLVCdKbBfsDp0ltK9b6WnI63wcJfvz01y9wTitz7sJBTSZg9F
         luFfreaaMBGxyPOcEDHuK6bffSjBuvrTCqHODkjG2qK9wNEzO2Mb8fNnE6IqjvDBcPR/
         kJtrqcB1fBPSbSh40VJx6t8M5RZOU3zs50UoJGg00cuUsK7XpF4s33jk54rX2tycjxdE
         RP84eao3Syic72RhGRsiHioB0jlNl2M2rVZlY6NyXZDOpQPYh9b/xz2FaeD9neBFUz3y
         nQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719967928; x=1720572728;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlxAVPd+z/4aF6F4fWIjQzN+IGGbLzBgd/ODx938I10=;
        b=YNorNm369G9wG8szqXC61ohGHgBowE7h5Hq5irwQpzNQ7WHI4atrZeB7rSrmCqwaKr
         K8Kj0D0L/b4ApOWxWjZg7+2ha59ijT0uaSBcYBe8KW1OU1SAtRm1+MW/FXxeKAGecb/A
         m1PGtcJdIAYpkOni9PMklC+zr69IzS7yEh4xCYxEorkn5pdX2Jbf5d9wFhRTOODpcu+a
         ytoctHzPsMJL8a0X+Am+1npRsxh9oe/6/Azqz/PgbpNt1eLAesFeTs1VCTo/WuW9c+s7
         CyH5YBt/sYfRN5avVGbJKs2tCN/57T/gxdRcHK5XIsR1k5QfftmXCKHr5NQFQoJ5PNgG
         DsNg==
X-Forwarded-Encrypted: i=1; AJvYcCUunZundr6KrBuNYwxxlsDHBcyAKRKnEup2viFcnB0xrne/1iwYfOtI696V/Dx1+Kw9MWHpTPOdIzij2Fn83Ikt4rGkAQQMa4jrGMyw
X-Gm-Message-State: AOJu0YwY7w8CyLsUsKUKF7nnj8v2m4pTP9eaxyZ7mVfiRz0+V1WieTli
	QN+mfO0g4/mL20Zk3LAR7ezO1+UmYy30dU8r1zXZL6zbvaQiRWGV
X-Google-Smtp-Source: AGHT+IFunxU3aCA2igMV0VDSihUIRl9wR+hXTq/LJHY8uSNSWMts/3OWUtAEdbp1a66ut6KDvzvC+A==
X-Received: by 2002:a05:6512:b15:b0:52c:8b69:e039 with SMTP id 2adb3069b0e04-52e8264b68cmr9439738e87.4.1719967927546;
        Tue, 02 Jul 2024 17:52:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a779bcb94a4sm36144666b.117.2024.07.02.17.52.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2024 17:52:06 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	tandersen@netflix.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 2/3] kernel/fork.c: get totalram_pages from memblock to calculate max_threads
Date: Wed,  3 Jul 2024 00:51:50 +0000
Message-Id: <20240703005151.28712-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240703005151.28712-1-richard.weiyang@gmail.com>
References: <20240703005151.28712-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Since we plan to move the accounting into __free_pages_core(),
totalram_pages may not represent the total usable pages on system
at this point when defer_init is enabled.

Instead we can get the total estimated pages from memblock directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport (IBM) <rppt@kernel.org>
CC: David Hildenbrand <david@redhat.com>
CC: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..e80e889543f3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -44,6 +44,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/memblock.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -999,7 +1000,7 @@ void __init __weak arch_task_cache_init(void) { }
 static void set_max_threads(unsigned int max_threads_suggested)
 {
 	u64 threads;
-	unsigned long nr_pages = totalram_pages();
+	unsigned long nr_pages = memblock_estimated_nr_pages();
 
 	/*
 	 * The number of threads shall be limited such that the thread
-- 
2.34.1


