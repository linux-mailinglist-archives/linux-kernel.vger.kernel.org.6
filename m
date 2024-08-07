Return-Path: <linux-kernel+bounces-277336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE8F949F67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA60728728D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328E198838;
	Wed,  7 Aug 2024 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Et5tJISm"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888B190694
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009841; cv=none; b=EFPxbDjpqr0lFf3kY3LkP3Rr5YHR8p75D9b6nGt6/I6xgDIQgKDKMx0cXc6UrX9rNn1C3ovr6WAs91znb4A4n0XJ7uSRBHQJj1G3yX8HLVkrgvlm7SQg7L50psWPh3Vy9Kbqx4Wd+LeWwDYLsgM5iBTp9X0D7336YAMjwLNQzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009841; c=relaxed/simple;
	bh=557UNLWVX/wp85JgjZpNyKLnIc/7+o4zVckBHmzIta8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSInbBwtJ7AINkY7m/vE1MaERdDJDGfdY7GDH50ajAuDlvuhkX+RGp9oKKJFtbmysnk/3a1FycpAXXueFkOhoPbnhCvjoVFRzS80l0T8t9nv7VjUfsCYcVvUxxwJILr3OgXAPelV3IHeiBZqiSwz/5os4JVscAfO6jpmFl02UWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Et5tJISm; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4775lNin682395
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 6 Aug 2024 22:47:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4775lNin682395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723009648;
	bh=wycxuEMd1j4juCR3qbKXzCQngO9gKkWRzlYDtXjUAew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Et5tJISmOBW3cotqKc9fSpTvBur1j7VgqoT2tKjWtV/KPVdS52rXdN3NP9ienot1i
	 IuxH1awNf1ho4F+zGG7L2DUYg6/7t5jiKuuFBwSwo7UIfV67zpayDEqJYyH1FAU7Yb
	 rXQCmpwTJnZBc0Jas1fC7rhf7kgxNJnbl+HDQM1/43xYVsQyNbKf1l+/Rwi2Nr7Qwr
	 xvPkcNLPZQD6Br+0nmy1ZXsibIGeWDKj6p8/eV/4QV18z9lISh4ysBe4jvNtrrCy0q
	 BIVNJzg2naue4xHh/8XNEf+jtIcscuOQHyjVWJvlzQuTLGFtY5wEftTcG5eJwJp+bK
	 X5jGVUnSS1LmA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
Subject: [PATCH v1 1/3] x86/entry: Test ti_work for zero before processing individual bits
Date: Tue,  6 Aug 2024 22:47:20 -0700
Message-ID: <20240807054722.682375-2-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807054722.682375-1-xin@zytor.com>
References: <20240807054722.682375-1-xin@zytor.com>
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
 arch/x86/include/asm/entry-common.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index fb2809b20b0a..4c78b99060b5 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -47,15 +47,17 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
 {
-	if (ti_work & _TIF_USER_RETURN_NOTIFY)
-		fire_user_return_notifiers();
+	if (unlikely(ti_work)) {
+		if (ti_work & _TIF_USER_RETURN_NOTIFY)
+			fire_user_return_notifiers();
 
-	if (unlikely(ti_work & _TIF_IO_BITMAP))
-		tss_update_io_bitmap();
+		if (unlikely(ti_work & _TIF_IO_BITMAP))
+			tss_update_io_bitmap();
 
-	fpregs_assert_state_consistent();
-	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
-		switch_fpu_return();
+		fpregs_assert_state_consistent();
+		if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
+			switch_fpu_return();
+	}
 
 #ifdef CONFIG_COMPAT
 	/*
-- 
2.45.2


