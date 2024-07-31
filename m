Return-Path: <linux-kernel+bounces-269776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6389436C3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C5F1F231A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF45214831F;
	Wed, 31 Jul 2024 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyltcaDf"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8A39FD6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455649; cv=none; b=d/jEybZc65esfJhX64zLPqvDtIL11GR3a5EjdR4d+CH8ViLBz51iMrJ+kTsWIbNDFwbSnb5m1iFfZ7pLdPd2O6h8WwNWQBAnML+rMhil3whzOOyAAutTBSjNxfBlEEx9VgNpE67LdFM7j5pIRnPRkkGe+AReOxz0HGWLnHV0ib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455649; c=relaxed/simple;
	bh=IAcz2Wv61+aRNxAaXQ9mljMXJKAP5vVhgDY/pmUTYbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkkRy5Tj0JmYxKDz6zYZbPPA3TJkxN+SPjZ8TA9TbTDYj3teFh6odQ50ZVMX3320ecUpMUAT2O6Q8K4AdAMgT5Z/SBB7v97k7KmFmMQi4DotHFYWi/RZk840O+M+p4ZuKMhiGJ0OSYHKUBx0KsHg+S2RH7Vn7/BTt3ihw8OUeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyltcaDf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fec34f94abso46558855ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722455647; x=1723060447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cTd6ZUEKI0K5FwC0UZmoEYNNh1a3wBYwKN3A31jyHM=;
        b=jyltcaDfh49wqtlE74ZIkT4Yley+atBUWDoIbAZ162nLUqDOWR3bWxjitSaqrMPgsy
         cJoW09rrw3ErSV0OhY3LV14eC/+qCV6hFuVONV5ovY3nco37ou3da85bvdeCElzsob0b
         mAhbRecYwS4yM0bftw8l0IQdOC1fSShKPdF54oXkIP1RrZ3X/iXYBZU7hESjlDO8VUrg
         HVNAKI1fWT0GFW/CjtSJMU982REuWpQiU4XJv0Ayhe+hRfCGI77bhJBKdzVJLqgqw9MO
         YCoOO5BKxE9cIw1YF/aGvWjx2Y9Zfg0di04/YX9/mJ8mWgJ6rr4DeAv9aRxofHTyHl+f
         TC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455647; x=1723060447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cTd6ZUEKI0K5FwC0UZmoEYNNh1a3wBYwKN3A31jyHM=;
        b=j7buoqCP6Sc2oDf9pX8JPuQ6x7/U7/PoKeno7p2vIFN2toT+ypzvoY2jFIOq5R3P8s
         tMq5jJomgrOOM5+qIlCJdru0lkGe9hOMYZbLrkATOdCiGc6e+9OOmRChnOCYuPdM+IwL
         S+xH1d0dMaNiTAzKRtf2I78c8RrdAacOzT2OwsPcQ6HMXLty+/J7WtDVXTcsRX6p0GbK
         5S8INlj7I3rnXrSWnG/pXg67ney4AL5r+p+70pQtLDmwhOj38WstzoRSssxPiI2MLYRa
         2JlqnydhHbsvKMgQLZpOd9BjvV0GUuLuzErXpzfJm8V05+sNkR3/lAv15lG1pLSi5w72
         thEg==
X-Gm-Message-State: AOJu0YylK0Wxn8e2NU4LsjgLY8A+82wc+Xgzz6mJSEDm+cv8bvBLIVJg
	qRK6XTq/Ck1op1wBBXxJKIlJ1h8DNyfFrMqviBH1kp9fRqB2dUCj5wSfWGiI
X-Google-Smtp-Source: AGHT+IHX3N++3mRwHioPQRvEg3ehAUj2ckiXrOUBBfwUEkGVAeWEfuL65Ft+bMObHK+8K9wf3ZAe8g==
X-Received: by 2002:a17:903:1108:b0:1fc:5b41:baff with SMTP id d9443c01a7336-1ff4ce47ce3mr4268925ad.3.1722455647095;
        Wed, 31 Jul 2024 12:54:07 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ef238dsm123895195ad.180.2024.07.31.12.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:54:06 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH] cpumask: de-duplicate assign_cpu() API
Date: Wed, 31 Jul 2024 12:53:54 -0700
Message-ID: <20240731195355.97488-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've got cpumask_assign_cpu() function and assign_cpu() macro, both
doing the same thing. We need to drop one to avoid unneeded duplicatioon.

Now that underlying assign_bit() implemented as a macro, it would make
sense to keep assign_cpu() which is also implemented as a macro, in sake
of unification.

This patch also removes __cpumask_assign_cpu() as the function is
unused.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/riscv/mm/cacheflush.c |  2 +-
 include/linux/cpumask.h    | 16 ----------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index a03c994eed3b..fa136627ccaa 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -171,7 +171,7 @@ static void set_icache_stale_mask(void)
 	stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
 
 	cpumask_setall(mask);
-	cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
+	assign_cpu(smp_processor_id(), mask, stale_cpu);
 }
 #endif
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 801a7e524113..f896c6ffa78e 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -534,22 +534,6 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
 	__clear_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
 
-/**
- * cpumask_assign_cpu - assign a cpu in a cpumask
- * @cpu: cpu number (< nr_cpu_ids)
- * @dstp: the cpumask pointer
- * @bool: the value to assign
- */
-static __always_inline void cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
-{
-	assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
-}
-
-static __always_inline void __cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
-{
-	__assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
-}
-
 /**
  * cpumask_test_cpu - test for a cpu in a cpumask
  * @cpu: cpu number (< nr_cpu_ids)
-- 
2.43.0


