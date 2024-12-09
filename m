Return-Path: <linux-kernel+bounces-437084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342D9E8EE8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D1F163ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1F215F69;
	Mon,  9 Dec 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJ1o2Vj+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993EF374EA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737282; cv=none; b=el340uFQZ3WFQqRLz3TNEp2w62DvYzNQLwXZUBwfdN9ZnKF21wt6n8OQsOC7+gzicPUxSPrJ/laaRnePYpURjQQe/3YD9QypybPqwHrJ3V/wYdfYEmjcmxeFuGYAobJ8IcyKkG08F18INaDuhderlZU/Ne7u9Sy9jHZzs7BAmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737282; c=relaxed/simple;
	bh=qih9/dhh+VmMQCwBtHvv0Ixmxd9/nUqqBNa/m3XJgTQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GAQ6Yt6do/DB3xMh4KDaV67geFLn3iMyvVh2StBXhJAnAuU9iev4fVwpI2FOPR5c+y727eW4AHTeLZ7Y8KMaiQ6nuKeYZcKj8pSqZwzltQd8KmsCpQBsXi9y4683CSM7WuBaU6DKn6HqNvOeOfgW8d/NuD5mSKzUWdknv4zHfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJ1o2Vj+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434f3fcc891so8085815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733737279; x=1734342079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NlOB8Iq7YEdDdHkH3u9oITRP5dsN5I3ZPe3WYkxy37I=;
        b=oJ1o2Vj+eFfxt3EMmoph4wE8RYmyFxn30Ryl9QGC2X2YzsnEnsE4e57NQsW549QUuJ
         9UjJXhUqIApqSoqQl4I3mWqAAvBVVBfnjJ2HwDO79MGUscgEdrmKkQ/mAf2eRJAztp4u
         9TEMR7Kh7tnhls3VSt0jcg+TexdplsAnVkeKojyiHMl2loKEPGmA3uiFZP++4/5HbTfL
         9GJ2gLW1KQ7HFuUMA9LVYA31tJdfkDN8mi2zVP/vo2CU8kiFYw4rU8K/kSBoSJRYKM5t
         mlUNB2CP01hJ37OXtdSdINVZ1WAVtHtGzzl1W+udoIk0xeuJD1xpeapuHd+11NVGvc+y
         3rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737279; x=1734342079;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NlOB8Iq7YEdDdHkH3u9oITRP5dsN5I3ZPe3WYkxy37I=;
        b=eiCAgRGYiw7cvMGMVOEOjueLuOFJ5Zq3I1UTgPW8BaleQfvpdvtBvI8Q8GxKLHt5nN
         DI7ygGg+bnvWbBjmjA6Z1xH1zYEkvo6akONdYLTCQYeAyEytqHjYwjX0kCgjwwZ0hhea
         UYB5HeMfuz8XiFtt4gWcflHGG86VAdzveneXSLIyzrgoX94TZL3N4ahmnLyzj3jiJr9K
         4P3u/voCYzHwaL9j0C4y4kJaatO1OHXbdAABfcyk8DLl1b7q2X2NqcPVzMUUKQzAXNLb
         LYDbPRBTv5rlFZIW6sxaiJF0nBQaFJkMdzOFbWG+5bqIyUHlySfXBNnGTUSzOuFhvvJJ
         RURA==
X-Gm-Message-State: AOJu0YxnNYb0Q4P5A3i9XERo82LDJA+NpAdtZkgpwMagatpGjJ5uSZ0R
	mt8iUg7kb5enrYmIeVmeY19JGPa9dWX8NNe7gk7BIFMq0IHBpdOwuv/0k97qbXu1WDAkC0vZTV+
	s3g5yrTawU4kYu9MQSeypWwqTPgzEiLVhLgZjQMTJR+JYr0tFZ25hiJ8LSrTscGbizx0JbxyH7U
	/nvkcjWZvy7jFSdCcwAUbxOLbLE+iqNA==
X-Google-Smtp-Source: AGHT+IHbxx9z2e920n3O7WTIV9r1MVCZek13925rkZsUjBoqcCTwZ36ZXGu95HKP2JEpW0UW/yJaPxSJ
X-Received: from wmbje2.prod.google.com ([2002:a05:600c:1f82:b0:434:a15f:e7ea])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3589:b0:434:ff45:cbbe
 with SMTP id 5b1f17b1804b1-434ff45d12amr1034855e9.18.1733737279158; Mon, 09
 Dec 2024 01:41:19 -0800 (PST)
Date: Mon,  9 Dec 2024 10:41:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573; i=ardb@kernel.org;
 h=from:subject; bh=9e6qySuMrp17XUKjtUf1eDq547E7b9JrA79tU8Ibtog=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT1st5HpojkHPq4v2XOu2i2n+PGp6e9zr/S+6r3v59nDc
 Ofcio39HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiorIMfzhcXY5ILJr4ydrr
 0r5D81e5yP3949136s/KHo+1iQ8kNfczMrwTmHh/u2VOfUnBmq1/TI3sWjf3LZ/aMZnDcmqElpn 5ES4A
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209094105.762857-2-ardb+git@google.com>
Subject: [PATCH] x86/boot/64: Fix spurious undefined reference when CONFIG_X86_5LEVEL=n
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In __startup_64(), the bool 'la57' can only assume the 'true' value if
CONFIG_X86_5LEVEL is enabled in the build, and generally, the compiler
can make this inference at build time, and elide any references to the
symbol 'level4_kernel_pgt', which may be undefined if 'la57' is false.

As it turns out, GCC 12 gets this wrong sometimes, and gives up with a
build error

   ld: arch/x86/kernel/head64.o: in function `__startup_64':
   head64.c:(.head.text+0xbd): undefined reference to `level4_kernel_pgt'

even though the reference is in unreachable code. Fix this by
duplicating the IS_ENABLED(CONFIG_X86_5LEVEL) in the conditional that
tests the value of 'la57'.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412060403.efD8Kgb7-lkp@intel.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 54f9a8faf212..22c9ba305ac1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -186,7 +186,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pgd = &RIP_REL_REF(early_top_pgt)->pgd;
 	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
 
-	if (la57) {
+	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
 		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
 		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
 
-- 
2.47.0.338.g60cca15819-goog


