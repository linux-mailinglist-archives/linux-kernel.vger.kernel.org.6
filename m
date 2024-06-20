Return-Path: <linux-kernel+bounces-223243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88E5911023
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0C32873D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E421CE9F7;
	Thu, 20 Jun 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMz0MKJW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DD1CE0AC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906319; cv=none; b=cESe2ySE4on080E9dqwUVfUyvOkeUPm0+5LNoc49s+HdOH7NjrlOeGdBO0BrS/JY6uoIsObiodz96U+PgYPE6DM04l+ii3e+pYyPfZ59rToNyat17Hyab23o1PsnPb71NeITjKVm+AAnYMue8m0lJcKW1CYuUCxsqZgnKMY6t1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906319; c=relaxed/simple;
	bh=qDgzpvKMzB33HuJtkLcNWCvXNPeJ2JXa19MfPLKu4GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STvJMXMFfzrcueApUKgvAs5yp/n6nsxRK+rQwX0cIGCEnQl+0fJisEorr6eGQ2j0RcdNEuAgijhK4e76mnU9ApGfNF9BYHTjloUrjALSjuTTRmmayv2szUqvTqWJgPGL62TmPoXjHH5veJIetxwg395ZTBS0dWehOp4i+ws2sMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMz0MKJW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70623ec42c2so958526b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906317; x=1719511117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UeGLEmgFCwB7SfnnVFN7CY07bSxQRD2zzo6uHvh98Y=;
        b=dMz0MKJWC7pw+IARzAWJI7MjHg7MRSha1zXy7e8SiKNE7EOpaDtudJZL0r6PbbhuX4
         TAyYj3KKCRpPRx4fBmrQOucfkvcygV/WTROxo3gc2wl4LisRChz9BJPS1Pb43WOdqsTu
         roRATb4kV5pB0pt9LbVR2fZZqNMTG9eIxIfQyL/uPALE1fBcQ5kgGSfxEyrN2RuQLYSc
         UOqu+M9ZTCu4VjDzZFpJNhHfMgib2sU+7djzBTNs8goXhmshTQ7aqkfUGw2TX0UddDMQ
         Wm0K0Hm4+md++uEuXD+aPiAnCI7vWwgwGKL9IcRjyeKCw4kY7TYS/2vnc5L/nnUEH6pt
         4tUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906317; x=1719511117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UeGLEmgFCwB7SfnnVFN7CY07bSxQRD2zzo6uHvh98Y=;
        b=hBNenJC7NPfcEci5YRzR01jEJ+G6fDZ/z+Z66K7EhpUD/7qv96w3Gj7PIH20DxTYgU
         aLbTBP5MYGtBpcU13XxUeGbaOxWL7e+6KvPN0g6yV4FvKUjSxMsHT8SX/PJneAhXASs1
         cL+8n5PtvRUuuv/MSwkdsDwR++YSE8JnXjopVeF81UeUgC1XW0qmeD6oruu+QYInrscc
         OnLKM9VEKc2Xpj/9dMM3hipHeG9fw6cgbtpyCXYKSBmSr5VxeJ6K0RFYkMrAPyy7yMkB
         i9MSSqzJ7YjAgfMxjasD4WwX4NG1PJkkBmMcsLbv0M7LmmrGojGCbTQA62QRVONufGlJ
         3f8A==
X-Gm-Message-State: AOJu0YyijWHryUfeyLg88spLPVjsW52vmSuP15E9mpptkb4eGb7XQgBk
	KSjCJU12V1W+kPkTIXbmHOjVk2H8CaP8Ndmy5IHnM49wdv90k0I/wyKHUQSkg+s=
X-Google-Smtp-Source: AGHT+IF2582ElUzYGc8sFWyeezew6KYJJtZelHSbtcwZADymS9B/iS/gSLgFlcKPRR5Z3cyEALz5Xw==
X-Received: by 2002:a05:6a20:a51b:b0:1ac:3b81:2b5a with SMTP id adf61e73a8af0-1bcba15b47bmr7898847637.8.1718906317030;
        Thu, 20 Jun 2024 10:58:37 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705e5fbe103sm9526573b3a.72.2024.06.20.10.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:36 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	linux-m68k@lists.linux-m68k.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH v4 31/40] m68k: optimize get_mmu_context()
Date: Thu, 20 Jun 2024 10:56:54 -0700
Message-ID: <20240620175703.605111-32-yury.norov@gmail.com>
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

get_mmu_context() opencodes atomic find_and_set_bit_wrap(). Simplify
it by using find_and_set_bit_wrap().

CC: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/include/asm/mmu_context.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index 141bbdfad960..2e61063aa621 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -3,6 +3,7 @@
 #define __M68K_MMU_CONTEXT_H
 
 #include <asm-generic/mm_hooks.h>
+#include <linux/find_atomic.h>
 #include <linux/mm_types.h>
 
 #ifdef CONFIG_MMU
@@ -35,12 +36,11 @@ static inline void get_mmu_context(struct mm_struct *mm)
 		atomic_inc(&nr_free_contexts);
 		steal_context();
 	}
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


