Return-Path: <linux-kernel+bounces-318756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E08E96F2B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9394284A81
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44C1CB525;
	Fri,  6 Sep 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFn5vSuk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K2lwu6K3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511291C9ED9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621532; cv=none; b=sCwnyrQc6ibA8nwPivqzRwl2nOHGGBV8jvjaOq29K1LaQOudNblKC5Fl0SPCDw5cDo2/Zs7TRY2HqOiu4JDm0WhhKIVb0FqX1NU35oFnS39RiW8uVsbPtAUxDFnE/taxWXZnKpC8PXM928lgA+LYG6nQncurBrDTCTL+l5AlZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621532; c=relaxed/simple;
	bh=PixY/hXMUnWrcFWMx1n/xLyxmqyJUqSoW2XZS1FvIIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWFwFrcShaWll5tKXJBYM2dW55P7yZmrLRyuihINoaFU0lJIIPiSR+Qh4LXYOSxja5GJQKuDD4mPSkpPkND9FA9A5MbN/SB+qgx+hKHENlVF7nJ7ywLVfuUdZPFXHIRty5pANycnRHNBafqsVEIdhgI27qN8v2w7Q/YFLZE3U2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFn5vSuk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K2lwu6K3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725621529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOMw6yKC0dEl8fkVPj+ZP9/y4lvZ127Nc38gQlPELzQ=;
	b=zFn5vSuk9/Mh+EIJBImR+DDDiyG+NB/rc2dvSBqbqpTfw5VUOjP1GVMcmMaWBixMOssmi2
	mH0AZ2o7d9I8gsApxr6fYTV8wKSTpcDJhGIEHbsfKJYXPKvK9uFssU3KW+ytwxKcKvgg8y
	pW25LuqZtBgzgZl9gB47ELcrHxBYqN4hlLW20VfcjnkAKiLO76GyiQJK9/idDMKXNJhSOQ
	2RfzLWvxjf82kidLd7iZLZ1cS2/iyA3NnJDoQUK/jYip2OqwagrqEoBEorjP/c/ik0GIuC
	JTBecfgOZUneOlySrio8ET/pKHZPYsW55wuQHQCAnpSZkWhAUPt9o7ON8E9ACA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725621529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOMw6yKC0dEl8fkVPj+ZP9/y4lvZ127Nc38gQlPELzQ=;
	b=K2lwu6K3Xj3KtwUoxxC/CTmka++ZUOKZEHv9tD5Rsq5a09OBghiqtEJEqJs+X5N4FFqrWU
	nwktQFPm/Jwh+RBA==
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Clark Williams <williams@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] arm64: Allow to enable PREEMPT_RT.
Date: Fri,  6 Sep 2024 12:59:05 +0200
Message-ID: <20240906111841.562402-3-bigeasy@linutronix.de>
In-Reply-To: <20240906111841.562402-1-bigeasy@linutronix.de>
References: <20240906111841.562402-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is really time.

arm64 has all the required architecture related changes, that have been
identified over time, in order to enable PREEMPT_RT. With the recent
printk changes, the last known road block has been addressed.

Allow to enable PREEMPT_RT on arm64.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0e5bd38633936..2cce9cb44c31e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -101,6 +101,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
--=20
2.45.2


