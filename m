Return-Path: <linux-kernel+bounces-223244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 272DC911025
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EE41F21374
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4414C1CE0AC;
	Thu, 20 Jun 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxlWiXVl"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839D1CE9FA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906321; cv=none; b=XUrjSv16Sm3JB93wEhI1wqrEw1I9aqm4DbN5rL16MYIdqof968ONn8C81Z634HCSAIXzRzcWxa3jXD6H1YJAY9sQAgAgqPebjXz8WPhPEc6ubGV01Grd3h9yQ8dfcx8aGKBdK1q8YEsQA5lFuyq9Ww2hFD2Q59900dRz0o/LHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906321; c=relaxed/simple;
	bh=/JBXGQMRau5wgpYf7SSlSW4t8HpQ8h/PbonGYBClZP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0OGZ9WE/rlxXbTPVVT14qytF12Huvse9IYLgrv5LyK/MdNzLQCAw2vRoygtYcFQo7TpNr8QQYjkt1BWTkZwLnG68sryP0+3hih/BmjBtmt47ouuOYWKpEsxEJ3jxpEBMG/srn3jOBx0CdUJUJUdQrRsGbo6yuzFBfdhVoamAPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxlWiXVl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70436048c25so1202320b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906319; x=1719511119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBsNta2Mqn95L/6yjm5XyoZC72SdhB72JzDL0b/aOFc=;
        b=cxlWiXVl+b0GQO4flulpwxN/2DqwpsWSznsHrxlEojUeu4VTH2oQBPTh6e5v3QHYJA
         /ibB4sR+JbFuh+nIVBdqejedGQI6RpLnDZ7gZQzda2uQcsbr85ZfviT1iCqM6bgtxoCZ
         ZtCLot0n4z0jIrpRV5trS4ryly87Fns2osxjM+341PafOCElsnnQGrJkV1EbMVQuf9+Q
         39nbplWiCCPT7Fo3nrnahY2H72enaTA9qCqoG+B0q2z94uEdYcZY41+gYsl9KzJk7edU
         3T++n7msQ5dnQXaTPR0oS4o/3rza/RVNUrQxbob66ex3YD+9r/0yAG3+XPbO9x1mJEZL
         n5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906319; x=1719511119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBsNta2Mqn95L/6yjm5XyoZC72SdhB72JzDL0b/aOFc=;
        b=uSfM2lkj5BAU9AckFwo16hBS3ilnEmeYhpBqZ/P2aVJXROL5+7KWzILbaClllTc/od
         tsuwwfePXTipcBLx2LAE8OyqydWFkE2CRLyO5QpFlB4Kd2zi27NnPImunIDUFpfrs1z4
         JS6NkhVOe32Meev6V52ulnHn3ebW5LTglHR8lxYuRPNGV3mrvqu/idXWIVMA/LodYJur
         3GvhEmK2qKYV/SKbXxVueCWv7BrCGGpALdSdY81+dP1aWr+tJNOP7XG0l8uWqaUx8tPy
         oEB2Cl+EluB08Y29Dd0aGIRBYrgWCegXOAYXdRYMtdQQuTe0cA51V2HzBPmBQt69aNyJ
         7PmA==
X-Gm-Message-State: AOJu0YxhyU9DJPFbwTYCQ9z17KwEg4Z6vMt6fmlalf2Tw5dxy/sY2uvz
	PIJHO64BNxO7KpsEAM538fpX0H4YAQ4UFSIq98awT1Pw/YvwGP58PnQPLo5cSy8=
X-Google-Smtp-Source: AGHT+IEZAZcqG95Z4B86VBJvTYjBRxBlyXTqG2gWLuzcon07F6oQ2VyYd3V1qJeznfngffLajTsd/Q==
X-Received: by 2002:a05:6a20:3399:b0:1b5:5ee0:378a with SMTP id adf61e73a8af0-1bcbb5a3936mr5878131637.36.1718906319680;
        Thu, 20 Jun 2024 10:58:39 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-70f885e9dd3sm3972155a12.79.2024.06.20.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:39 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Yury Norov <yury.norov@gmail.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 32/40] microblaze: optimize get_mmu_context()
Date: Thu, 20 Jun 2024 10:56:55 -0700
Message-ID: <20240620175703.605111-33-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify get_mmu_context() by using find_and_set_bit_wrap().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/microblaze/include/asm/mmu_context_mm.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microblaze/include/asm/mmu_context_mm.h
index c2c77f708455..d4d1e80b3b66 100644
--- a/arch/microblaze/include/asm/mmu_context_mm.h
+++ b/arch/microblaze/include/asm/mmu_context_mm.h
@@ -9,6 +9,7 @@
 #define _ASM_MICROBLAZE_MMU_CONTEXT_H
 
 #include <linux/atomic.h>
+#include <linux/find_atomic.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 
@@ -82,12 +83,11 @@ static inline void get_mmu_context(struct mm_struct *mm)
 		return;
 	while (atomic_dec_if_positive(&nr_free_contexts) < 0)
 		steal_context();
-	ctx = next_mmu_context;
-	while (test_and_set_bit(ctx, context_map)) {
-		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
-		if (ctx > LAST_CONTEXT)
-			ctx = 0;
-	}
+
+	do {
+		ctx = find_and_set_bit_wrap(context_map, LAST_CONTEXT + 1, next_mmu_context);
+	} while (ctx > LAST_CONTEXT);
+
 	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
 	mm->context = ctx;
 	context_mm[ctx] = mm;
-- 
2.43.0


