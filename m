Return-Path: <linux-kernel+bounces-236469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5137E91E2B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060131F225F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E316C844;
	Mon,  1 Jul 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HNJWveJo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2kN4qlaW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DE1607BC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845297; cv=none; b=R81AjPB8dcbUuYUOX7jZdZkAwa5iH9cn2CA8MmtnDSI+UcZgzjb7AawvwbMdoPGLme7/XkXUl4/eOWEzqAu5ZTRAqa6WNNVyaylcYeKzov37FXjFBr/Jz1K02zSZMcuc15zS19PdlvdRMmyFtniFxXIJcTzDAn4UQDPmPI2pwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845297; c=relaxed/simple;
	bh=Fp8EPeDN52tg3Jcl/xJwedAigY0E86q8zRKt6DtFLvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJlOa9OAKohJtJuWX9b9uuLxOVIA2ZjcXT41cPAfPGi/Xm0zOxSa3CbHvMJXGrzRJQZP/sqgkkueaFMbIRx0ngd5ZUnd2I/xE2PtbAkcR3MJK5ReF4oFyku45jmwSW/mColBYLW//4NMuftSFmEFK8AVZn5lH9jK2K+nuux4D2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HNJWveJo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2kN4qlaW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719845291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nYd93wvJq3D1U+iwnOFvX6unDdKeJUIZ3e8ELsAkKY=;
	b=HNJWveJowzrrmmsE610z/8fExc9ltGjqcG7gvd24K5QyRWqB1GQBOoF0xm+t7jMMpzX60s
	wP1MeSG6TdWotDhgmKFUZAFcxYGr1UhCUb87gbWE1cSacQqaCwKhKD4WkkkFkkG6zlnTjp
	rdeEFgx9m+9k7djBO9eeIFHhYxHlo/zwkVxvvmkANVChlCiKw5GeGE3uINqjHbrXadRjqn
	zHr3kB/a41UYHANfSBFGVgQMETktPN6NoHa6y4cIZLmbh62AJK+lv1ZTSu/XwZIGmUFkSu
	uWa9CzzHjkdcWlesuTJ0cISjFoN4jHUbjcMEzfCHY10TIms1ESyIndJhc7HuQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719845291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nYd93wvJq3D1U+iwnOFvX6unDdKeJUIZ3e8ELsAkKY=;
	b=2kN4qlaWJ8PQLY4Dn9psAnmBaz17X4129ztlD7hqx4kTss/ZRdEPeNJW3UV4Wm9ELvpbpu
	FQBQXmWvatmhX0Dw==
Date: Mon, 01 Jul 2024 16:47:54 +0200
Subject: [PATCH 1/5] vdso/gettimeofday: Clarify comment about open coded
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-vdso-cleanup-v1-1-36eb64e7ece2@linutronix.de>
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
In-Reply-To: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

The two comments state, that the following code open codes something but
they lack to specify what exactly is open coded.

Expand comments by mentioning the reference to the open coded function.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 lib/vdso/gettimeofday.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 899850bd6f0b..c01eaafd8041 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -140,14 +140,14 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 
 	do {
 		/*
-		 * Open coded to handle VDSO_CLOCKMODE_TIMENS. Time namespace
-		 * enabled tasks have a special VVAR page installed which
-		 * has vd->seq set to 1 and vd->clock_mode set to
-		 * VDSO_CLOCKMODE_TIMENS. For non time namespace affected tasks
-		 * this does not affect performance because if vd->seq is
-		 * odd, i.e. a concurrent update is in progress the extra
-		 * check for vd->clock_mode is just a few extra
-		 * instructions while spin waiting for vd->seq to become
+		 * Open coded function vdso_read_begin() to handle
+		 * VDSO_CLOCKMODE_TIMENS. Time namespace enabled tasks have a
+		 * special VVAR page installed which has vd->seq set to 1 and
+		 * vd->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
+		 * namespace affected tasks this does not affect performance
+		 * because if vd->seq is odd, i.e. a concurrent update is in
+		 * progress the extra check for vd->clock_mode is just a few
+		 * extra instructions while spin waiting for vd->seq to become
 		 * even again.
 		 */
 		while (unlikely((seq = READ_ONCE(vd->seq)) & 1)) {
@@ -223,8 +223,8 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 
 	do {
 		/*
-		 * Open coded to handle VDSO_CLOCK_TIMENS. See comment in
-		 * do_hres().
+		 * Open coded function vdso_read_begin() to handle
+		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
 		 */
 		while ((seq = READ_ONCE(vd->seq)) & 1) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&

-- 
2.39.2


