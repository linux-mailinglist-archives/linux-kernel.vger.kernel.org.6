Return-Path: <linux-kernel+bounces-296818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4195AF77
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD1A283BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7E916F0DC;
	Thu, 22 Aug 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uZwpleLd"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3BA933
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312411; cv=none; b=PCOyyd0Y97hZ7kRMIPGpe/JBFiI3xSIhkWMiOLiCRRe167ygxSDgNnDGY9KnUxMo6ig6Glg2wG4EbHnFgj9icL7VsGK0tP203pj7OMKEsOgfTZI8DD2yGt1UYflzOkXsmlOvjav+vbKDjGEn55acICrwnx5dRGq+bLPiHspDsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312411; c=relaxed/simple;
	bh=XEMrGp/hJElB/rBq0I5kW6pqL+b6/Ysam0r70alkjtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbLivnKkdUjnPsxMjR9pgM8YfiE6kCsN3y/xe6cnsfGOUrpxgi15ARqjPz8a3hcKqE2D3OTku4JS2WzdXB197UcNOqLaNq0dk6yB5lTUqgm5HBgWkDvdMbaMyMYC1PwxpuiQm2onVdtqGmE01eYd1gYQvNLOqWcPGIS0H9SoOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=uZwpleLd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47M7d7s62176365
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 22 Aug 2024 00:39:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47M7d7s62176365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1724312352;
	bh=p2ysv/OVc0XonUsdqfQCe5lPlcqRKnShtxUnJ8YFWxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZwpleLdx2BxmefnaartaDug1Ne5hkEjo+epKjpwjxAsdVw1qDltDyfmUkV0Jdvtg
	 RexcTlquj/29+8sdbYM6EJBrpEywPV0eAWOmp6DM7m5Udk0JTvFStb/xIZOg34Qanc
	 oVifEAMCQ80RH47YCRLVAvxknWt1PIY4G+4GkTfbR6RxWMPI8z7tzhrxfDdVQgPyyl
	 0NtPETJHf6qNpA0iSWFFdZ0b27QHbRaT99rsOIGHkHvwm9tp8qxpIoaj0R4ZdHIrlh
	 vFEDkm2FoYLZxUh+L7aWym5RJp+wg2BQMvNLLEMkYjhIGdnlkGnQfPY+d59Yzb69nh
	 Cz9g/VEugqW9w==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
Subject: [PATCH v2 1/3] x86/entry: Test ti_work for zero before processing individual bits
Date: Thu, 22 Aug 2024 00:39:04 -0700
Message-ID: <20240822073906.2176342-2-xin@zytor.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822073906.2176342-1-xin@zytor.com>
References: <20240822073906.2176342-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In most cases, ti_work values passed to arch_exit_to_user_mode_prepare()
are zeros, e.g., 99% in kernel build tests.  So an obvious optimization
is to test ti_work for zero before processing individual bits in it.

In addition, Intel 0day tests find no perf regression with this change.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change since v1:
* Leave fpregs_assert_state_consistent() unconditional and independent
  of ti_work. (Brian Gerst and Thomas Gleixner)
* Add arch_exit_work() to spare an extra indentation level. (Thomas Gleixner)
---
 arch/x86/include/asm/entry-common.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index fb2809b20b0a..db970828f385 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -44,8 +44,7 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 }
 #define arch_enter_from_user_mode arch_enter_from_user_mode
 
-static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
-						  unsigned long ti_work)
+static inline void arch_exit_work(unsigned long ti_work)
 {
 	if (ti_work & _TIF_USER_RETURN_NOTIFY)
 		fire_user_return_notifiers();
@@ -56,6 +55,13 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	fpregs_assert_state_consistent();
 	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
 		switch_fpu_return();
+}
+
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) || unlikely(ti_work))
+		arch_exit_work(ti_work);
 
 #ifdef CONFIG_COMPAT
 	/*
-- 
2.46.0


