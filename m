Return-Path: <linux-kernel+bounces-388457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A599F9B5FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F8DB22BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DF81E7C17;
	Wed, 30 Oct 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qa6YdFXq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E91E767D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283528; cv=none; b=j4oQfcSSr6mrb++QYU1FKUP4LIfE4HYKjO7bJge4rYpNGFvhdkPs80ygjYWCYrv6HPtgDer1QXDSVeo7eN4YinkPVXftZeSTyRxWXBhxoCNympBNHjPgwixawWFfgZFveE0f8/L0CQRhUsUN4ctS3xqu+pkckWNUkEAnSGBCk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283528; c=relaxed/simple;
	bh=S+G/Yv5YgDgUTqdKH9qo+7slviVHh2xnvJChaq4GoyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QiCMdljx+napsFWNITnUi2DdGyHgCc6LUNkL+JsOahHRcUaDV76p0MWrdKi0RxDD9lukXM7rT8aK5pJFJ9S1Rg52Sg6Di/bHwIQS5uHrTu5UU1RIneC8RQOctY/T/7C0xbSNlM8Tvc9G7JyA3I15LSUzSTxf7tlL5U8mjz8AZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qa6YdFXq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea258fe4b6so43500117b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730283526; x=1730888326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PPRGspoCFMLa/ML1zQGAdf+RPV3kEKo7CdywG6YAezg=;
        b=Qa6YdFXqfQ9xQHdi11kcxdku+S/XbRvT2j0Apf+VfOVam24VOB8ogLL/c9oNKsxzYl
         8TILJIjoIWXwhTlJzzk3AppmbeimS9y11/fOiaOOjkiCuk12SLWqm8hSiMyv2mq4XW7i
         uEomQbvj204URDOHVK2RbcV4TArCWoijlODouY1qEN3zWDY8SPF8JgCmo+VscpSOVwV4
         4XruZ9vkr9HzWrwW2CqdOfXPuERsjsmkZu/QgspeiZeauTsWKC2EN5t+ZwAEn+MxoQ5l
         yK+pfsrDn+6k54YnMBZD+YhFQMf6Ax8sIxxAcxy+COEit4EEBvJ1evy2cCk6xsP/W2dp
         23OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283526; x=1730888326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPRGspoCFMLa/ML1zQGAdf+RPV3kEKo7CdywG6YAezg=;
        b=AkEKySC2Ft3XfbNmwFmTSp/rM2imdEi7P0Hhz+P7vkJelpSs6K89p3o384zk2kJW2p
         1OJ9b7aNKRfJSLSjUZFeSa2P9Cv3s79hKuNKZEm/u0zMyXXJ8cBHnj2kyCm34hkANUHI
         cA9hcDA+2uIDvM3nISh1jDRC4nt3iU3F3I1foPVCOyl1RLPZO20b4QeWygLUMB/Lo9zv
         3ZeQ6vT7Hbc0F1KS0QmT6TMK5G9Ts7+HebRXuQZLelnc/T9IDfzdFsT+WE8NFAXxlXkc
         bXjiFc+GTkin6Sh29pe8AYAskzBFDpUJib6Tn7zkYjaE0LnQZW2HMGHKbXyiTxDhw8ZM
         1wKA==
X-Gm-Message-State: AOJu0Yw1WUq3eqo2IkVGe2m7zDEUhwNhuz9shcPconOO8eZfwx6mMMXW
	4pU8wtxiZrOEmHliNCf+bkY15fe0KsHoebuNWkTfDvOMwnhS2JTz4+JT6ylxaSLE/eW3Iw==
X-Google-Smtp-Source: AGHT+IGuD4l1ccYFqEeRi/42ggdhN+cT+EfjhCRmyQyLIYZ8jOto7EuAD2t5GeGk27eitJwFt3iyIp5y
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:9682:b0:69b:c01:82a5 with SMTP id
 00721157ae682-6e9d8b89f8amr11429747b3.7.1730283525807; Wed, 30 Oct 2024
 03:18:45 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:18:12 +0100
In-Reply-To: <20241030101803.2037606-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030101803.2037606-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=ardb@kernel.org;
 h=from:subject; bh=GbwFno5F+PIqgoDy9QYiqnwQa9iDjNg0VPN0fHtr9z0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV2J/bnIwZZp+slTLQy8f8f5P/x5vHqBnEsh84JFAesdK
 oVPFW7pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZ18zwh3uvrHbGsTnTw8Kd
 eL2fT+9I1a/sTPre9WrnoXWnT7ZMvMXI0B+71t/0riuPF8Mui5eb8/8n6fqZlytwe745kmOzbLk rEwA=
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030101803.2037606-18-ardb+git@google.com>
Subject: [RFC PATCH 8/8] arm64/mm: Account for reduced VA sizes in T0SZ and
 skip the levels
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that a smaller value for TASK_SIZE is used when running with a
reduced virtual address space for userland, it is guaranteed that only
the first entry of each root level page table is populated. This means
that we can reduce the number of levels of translation performed by the
MMU by programming this entry into TTBR0_EL1 directly, and updating T0SZ
accordingly.

This is a quick and dirty hack, but should reap all the benefits in
terms of MMU performance and reduced TLB pressure, at the cost of one
wasted page per process (or 2 on 52-bit VA capable hardware).

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 48b3d9553b67..99777da39228 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -57,7 +57,13 @@ void cpu_do_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm);
 
 static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
 {
+	int advance = (vabits_actual - CONFIG_TASK_SIZE_BITS) / (PAGE_SHIFT - 3);
+
 	BUG_ON(pgd == swapper_pg_dir);
+
+	while (advance-- > 0)
+		pgd = __va(__pgd_to_phys(*pgd));
+
 	cpu_do_switch_mm(virt_to_phys(pgd),mm);
 }
 
@@ -82,7 +88,8 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 	isb();
 }
 
-#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(vabits_actual))
+#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(MIN(vabits_actual, \
+									CONFIG_TASK_SIZE_BITS)))
 #define cpu_set_idmap_tcr_t0sz()	__cpu_set_tcr_t0sz(idmap_t0sz)
 
 /*
-- 
2.47.0.163.g1226f6d8fa-goog


