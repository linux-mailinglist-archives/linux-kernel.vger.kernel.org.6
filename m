Return-Path: <linux-kernel+bounces-235494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B265991D5CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16CE1C20DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1274C6B;
	Mon,  1 Jul 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3LDso3k"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF27184D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719797663; cv=none; b=ezcGvMnKNjGEzZKO5z6eQK1r0929+4JAXLw4sJe7hBvUJiLsBop8nCDTZer2eC+HYb8ZhUlKcNnpa2tD0sufdqsAH+hSopamJ2sBR8FmYOUiQYs/ySxCcrPdqfmw+AuC47g0wW8OzfVo9MR430BvxfRC9hyMS2l+3zJFCxIFNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719797663; c=relaxed/simple;
	bh=jjhrnQDmUjl1AcsBFzRy6Plcst/4lJUx2h8tPh7mmYQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KKTC/VxGG+/tOivSiZ+HaYYnmoQEKEbQOKeR1yH5Dt+UVINOmVGXU9pm7mktXws9102lphVjUP+9/O7e28NaEnC0ImY4e18IZ0hqHE1R2x1uQ786lOJAI3/LcpdX2tGmsj1Zpzdf9hImrt7WoapKePfNqE/BxJ3iXgqLvgLAC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3LDso3k; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ce6a9fd5cso2844920e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719797660; x=1720402460; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXwXuyjTk2oo7RfOQdPNAJzNU5JG8Zom0Ea7hT/TXvM=;
        b=J3LDso3kx7S0HKjgjS8CVd4mxqKvk3BMH4bmByfnmBnJubwvVp9Cl83iDhqswo60eH
         lPwNC1fljdBVown9t0o/6x0fj6tiZ6wA+NYW6yhjBIZ6jBX/t17qjgD4uu8jEyDTYHGT
         c0srkeicLKZbtegOJt3qQ7Pbp1hTgykvcRksaqS7VY0p3Oz73VUpnZ58VA9XeLNq6HMD
         60UGibi5aP5gg1vqJ1cP+qgb1engNOvgGhscorsmlAKQbYCw+y2+6lMdb5noZVgOsvVH
         4O8bCCl6HV8L6tZioCnTcTqHr2bJQTgp4sR1JZcoEnOTpsERZWI9G2AjRh8a9wizhk1m
         gYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719797660; x=1720402460;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXwXuyjTk2oo7RfOQdPNAJzNU5JG8Zom0Ea7hT/TXvM=;
        b=WHrwgA7s1X7wGzlWEmdsvxUo28vixFwLCiJH2bJosJQVwKeQ9o7sYrVio0pIQV1Il+
         i9ZaIXMkIClxl/tZAlaXiJlmRHVoxFrHNNW/90EdyI6lQC3YCwZeHSBuJ9Yf/A8sTOdd
         hVuqufOEvoBwHBDlnoO5hy2nPOmOrrqLbHid0nqVAGmAwq3TgC6XANmnKPUpd49YdFHB
         pnXuGevvSsF+3jg4pWSiPKXML/ECxtPlw1AA8kbgn0esvO4bpOpNWfhtB4+WUYY0MCni
         qNI7PfHAUCLo3Eh+O7wRg/+RBzIauwgA9lDdMN3KUeS0zaDZwu2qixfG4taVM0EmnbZI
         oDxA==
X-Gm-Message-State: AOJu0YxEjNHAkEsfDXZzPLauDvMjA3vj7wowO9hJcvalK86+398gzrRu
	ALUaLeyw5bHX3Y6C0p7gkYNOBArpFPfpUBxR3DlSSFIrBbgJmaZJ
X-Google-Smtp-Source: AGHT+IHvnPyVLt/3fH/vtMEtT8OgV0Z/mBR6H/Nl9N3YU4lhYDDfAHUku/q3i0PKE+xfA0QOWTnMcQ==
X-Received: by 2002:a05:6512:3a88:b0:52c:e112:4b0c with SMTP id 2adb3069b0e04-52e826520d1mr3206581e87.9.1719797660268;
        Sun, 30 Jun 2024 18:34:20 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b4d69sm283664766b.198.2024.06.30.18.34.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2024 18:34:19 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	tandersen@netflix.com
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/2] kernel/fork.c: get totalram_pages from memblock to calculate max_threads
Date: Mon,  1 Jul 2024 01:34:09 +0000
Message-Id: <20240701013410.17260-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Since we plan to move the accounting into __free_pages_core(),
totalram_pages may not represent the total usable pages on system
at this point when defer_init is enabled.

Instead we can get the total usable pages from memblock directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport (IBM) <rppt@kernel.org>
CC: David Hildenbrand <david@redhat.com>
CC: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..eb2b5f96aa61 100644
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
+	unsigned long nr_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
 
 	/*
 	 * The number of threads shall be limited such that the thread
-- 
2.34.1


