Return-Path: <linux-kernel+bounces-318754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C669496F2AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F290F1C21B07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB28A1CB321;
	Fri,  6 Sep 2024 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VfZkbxfe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="657UDvKx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A681C9DD3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621532; cv=none; b=GMDLZsH03gRct5EG5Wu3YmKTVbhv78UkJdrRZXjm5gWxj949i+vNbFU/IIrK1PW4nVNCmgIib9tSE9cQ4GFXMch2NR5kdyWCd8v3awz+sXdCxKdJZQqkp+kJ4hCuEseXeRkregNNduIXy2azYNVM+SdMBvy8h4sE5a+Sc68QNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621532; c=relaxed/simple;
	bh=y/SuSjBGFEMIpvxmwkBWM7w3rFRkIz5EzKmdf54Gbug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUZJRUep/68hiSaExRuUjFn0ul8oNiZqVcN/02PPDryd3MKJVZ3KZSs6sA0QYg3cUl/wRfohl+MMf6nQQ6WKjsKf5qIl/at5N8N0vvCY80QLSPAZ7YkyB6fLwRSs2y2bEyE65ksknpwhtmkTjMCGRuS+ljzlq+7uV7mWK0B0vt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VfZkbxfe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=657UDvKx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725621528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x24fAVGIJ6RuBG9Lhr8zLFLnY6PVtiQ+egHDc5imzTY=;
	b=VfZkbxfeVSYo8CDDMZ35DzkLGbAxtXEqxJTTahK9OPPE95/ZrgARouXC6xlRFXgZ1Dq6HE
	QShB7PFR1C31xUDFfHcIiQQf5x0QK7zgjFbQYs7suIrcIAcicX+Go12o+iNNtRsD18wHCu
	L+laTOp9PbG28VcUtAPlHLSppTvAwCNzu2oHFYqnhA3ZJ/MKNzm0+BlSqf+qjPkT6ouCfZ
	dHoOWMX8G1pgXaFe6C6dusln/bluwbGsUfHmqsev0Tb7JsVHvyRiGCXf0etdNSXx38bqFp
	rSe43qa44M31mcTkeHgCtC2oGWhF52cj0P9c5dzqlFJvVPjJrdGbnBd1FdXiQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725621528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x24fAVGIJ6RuBG9Lhr8zLFLnY6PVtiQ+egHDc5imzTY=;
	b=657UDvKx20erci7Np8vEKYB6HMqB3iipyMUZV54Cb6fGMLLEfvZ9ZjVPbpu1CL2mjJ//nq
	ORnCt1D4PHWLWjCg==
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
Subject: [PATCH 1/3] x86: Allow to enable PREEMPT_RT.
Date: Fri,  6 Sep 2024 12:59:04 +0200
Message-ID: <20240906111841.562402-2-bigeasy@linutronix.de>
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

x86 has all the required architecture related changes, that have been
identified over time, in order to enable PREEMPT_RT. With the recent
printk changes, the last known road block has been addressed.

Allow to enable PREEMPT_RT on x86.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 28401c16b0c3f..a8cf61c52b063 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -125,6 +125,7 @@ config X86
 	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST
--=20
2.45.2


