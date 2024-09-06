Return-Path: <linux-kernel+bounces-318755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E18096F2AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E71028554D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454641CB50F;
	Fri,  6 Sep 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b3qlaebI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9Fl/fZu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CC1C9EC2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621532; cv=none; b=JHMkwZdA5ctLwlT7kW9vWVIl7MbVU8kIjmtl8f7w+zy8qiV9TUSHqJhrQ8WRwuOL4WISks0uuMcYzvsMcyL5OeeD4S+xIh1237TSMZXVT1D9YRUW/zPcDr3ZreAGpSkX0a/84I8XDmhVhaIQqbO5Zw5SPEXdQrKR/yk8bGxA9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621532; c=relaxed/simple;
	bh=Q33IKyUw7Z8JqGycfTh+wpKPq+3eBXr/ZeCrvMYuNiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7jzP2UZOymV2NezGjgCzigfObMeBr7haOUFgf267r/4RC3hqSktwkyLlCqc77NshlHFsg+FO+EB0w2DQlITTGFUGezqboQAJqpkz1Zn0MLT5qWZnanpN7kCHPUc60oRvvVnDV7JasrjdhECZxgdvZZQZGl688EcFZJpX0gqmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b3qlaebI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9Fl/fZu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725621529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ov9ALPJuo44ifDiLKTc8jETenwwiDMG5WR5RiB1FXc=;
	b=b3qlaebI69J++Ip9iWlHX1oKT9b5lb5LXwZrqwaIHuSJ+HmF6V+5ctSA8G6jvwf/Y5vLan
	7H5ztePuaiblx1PpZXV2DyBn72MWj9IXkzHI5j7QddMzTwwbo/V/nE4YfKA3uOlQ2ZTAmt
	6mlL6CgqNRJYRdK1zR5gGWeb90IZWNR4HHQCDhRYGKeOCHiyOagvixGvb7H7LZGLwrWypN
	ZetNtzvs5mXfVZjMPnpGyTHoqB1Wt5eBwiJ5nej5tkuSGmglifZr1I9kvEvi25JJCy7Vy+
	lNEThV4fnDqoUcq9uQSgPziFMcmMaeE8jGg4e6/84l0moqrw7afbFR5SXiYpXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725621529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ov9ALPJuo44ifDiLKTc8jETenwwiDMG5WR5RiB1FXc=;
	b=k9Fl/fZu4R4YaQ75y+xQgYG61hhbuFdl/8yIjSC67o5UM1UWJ6bdDeX3Hrrh1XYtjYm8dU
	nJ59tZApDdHxo7Bg==
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
Subject: [PATCH 3/3] riscv: Allow to enable PREEMPT_RT.
Date: Fri,  6 Sep 2024 12:59:06 +0200
Message-ID: <20240906111841.562402-4-bigeasy@linutronix.de>
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

riscv has all the required architecture related changes, that have been
identified over time, in order to enable PREEMPT_RT. With the recent
printk changes, the last known road block has been addressed.

Allow to enable PREEMPT_RT on riscv.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 801ee681059ca..a9be4dca380dc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -65,6 +65,7 @@ config RISCV
 	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >=3D 140000
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
+	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST
--=20
2.45.2


