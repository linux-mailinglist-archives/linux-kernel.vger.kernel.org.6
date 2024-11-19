Return-Path: <linux-kernel+bounces-414618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6E9D2B02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6158E1F2387C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179A31D1F67;
	Tue, 19 Nov 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g63RtYFx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F614A614
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033928; cv=none; b=GYBDQQHg6cYZ5/NjeUI2hGclbP/qbEOC92u4obH1sQnAR92920OHODJZ9J+lXcxtgyyFrqakMBTZpL8GzWYwUegyougS8DArk3ZHJcf/+78sJlgt1u4eTo0oBxjbZcm/HAxSBHGhIAe/82c4+0nwTVUMu0S6vTNqxnCZEWkGHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033928; c=relaxed/simple;
	bh=mBPldd3yUicxrETCRUqOLGqOQNV9i/fAUwpKaw1SsI0=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=T5BOwKIo4SaOqd5xCzxn36zz5VI5xtVYEnLhkGIr4LQjiIET4qKvhaHtw2vTcCzAobhnPZtIbKlvfGyc+BDzpLiZMzRdwKCrlkrI7B8yq5Wo3S9HLFAhGUqQDajCGAasqP0kkEevyoujGmItS3+DivMygQyCbeaMQztktMXeT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g63RtYFx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=bkFLe1usrwLIzhTY/+ijYnFXLDpAk9FZvP9TcIkqIHg=; b=g63RtYFxb944hivfZKh41nEC2y
	DgGWs/i0ec7s/51lPeONyDj2FryFVYYSmlq4R70Kt65MNS5RYNzalrFG6hDfXAxvj/hfjmEbH4R/4
	LTI4HTMz8nmsM5HSkJPy1qKA/IyXLg5iK9EqPkbZ9+NfomSoqAL5KpqPl228F578B0YjGOfU/4AQg
	5z11iRUuNQjwXsAPynmlshm630pFL2gNadFywh0XM8tL7rU+Gdnuyvp7R/zGOtpdDx3OFTP6xHBYx
	bOdSlSlfqEmQnWZcN3qs32FNhMMaccFmDa0sLsq6UpOKQChBT6uwa+jdANXDhTmJI4YVI5XO5KcvA
	Vx06WNQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDR92-00000000MTV-1Mfw;
	Tue, 19 Nov 2024 16:32:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F28533021DA; Tue, 19 Nov 2024 17:32:02 +0100 (CET)
Message-Id: <20241119163035.985203915@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 19 Nov 2024 17:25:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "To:riel"@surriel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 7/7] x86/mm: Opt in to IRQs-off activate_mm()
References: <20241119162527.952745944@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andy Lutomirski <luto@kernel.org>

We gain nothing by having the core code enable IRQs right before calling
activate_mm() only for us to turn them right back off again in switch_mm().

This will save a few cycles, so execve() should be blazingly fast with this
patch applied!

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/69c7d711f240cfec23e6024e940d31af2990db36.1641659630.git.luto@kernel.org
---
 arch/x86/Kconfig                   |    1 +
 arch/x86/include/asm/mmu_context.h |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/x86/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86/Kconfig
+++ linux-2.6/arch/x86/Kconfig
@@ -133,6 +133,7 @@ config X86
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
+	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
Index: linux-2.6/arch/x86/include/asm/mmu_context.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/mmu_context.h
+++ linux-2.6/arch/x86/include/asm/mmu_context.h
@@ -175,7 +175,7 @@ extern void switch_mm_irqs_off(struct mm
 #define activate_mm(prev, next)			\
 do {						\
 	paravirt_enter_mmap(next);		\
-	switch_mm((prev), (next), NULL);	\
+	switch_mm_irqs_off((prev), (next), NULL);	\
 } while (0);
 
 #ifdef CONFIG_X86_32



