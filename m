Return-Path: <linux-kernel+bounces-357436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8899712D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5471628738F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB531EF08C;
	Wed,  9 Oct 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VvUTdTGR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rlXelPQm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80B1E3780
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490247; cv=none; b=ujG2f3f6KOzeCEo2hRjV3Qf7TnhOiDLXqj9aHBfgmc8e9qozdolAHQoE8iMvSaLJZzFtvNghE9IA0piNZrClHoLFCXCtfE5PSy7DkJfPm5M69aVtDrJAQ7Zg9wYmQxC3FSeTQ1JPpqea3e5/lpeHSGEhhUDMaisf+ZbHwwjFnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490247; c=relaxed/simple;
	bh=HgYLHXFAmxCyQeAXeKz2amJ5M2ml3UKe5yaixlABasU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UF2VoKwRDMaqURod/BQkMhkLSb/NQRaTNUjeoCOr/e18FKL6ggE6+ybXYacFDSOv1zQ+d1t4AQtl9VpyVseqZZg2cDApXNjfORGtPb0MzJL2P/PGOVxZyumKgHrQp0QPi5uGnMbievbcj9m8yQOliKp9WHNAp1OhqMFOYsm2pRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VvUTdTGR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rlXelPQm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728490244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etQOuVXtSrNDCs1F1n1fkiDnWt+9VqJgYCxrLnDj/XM=;
	b=VvUTdTGRyc3ut8r9oEd54TTMcfmbNRf1hLxK5Cgyk/Cs1chA5yS7N2RpHFzJ3yZqOsf/BI
	8ucVyy/oHZAsCTOetQPXkeBTFVcJ26xCy2zQwwTgrPbHIABBvvo+FzFtniEjJOJlqFdNmT
	8OmtVKhL3mpEpUDpDCzBXBddNoeijPwMNQVB95Mijq2qB+w3WRpY5m0tdf32UyUzyqXHtT
	uJrP2J3wk/sZfNQQgV7kcGxjpgIZlgsK37+rutIMqrFBwpFeQoBm2hRK8Vlf2jVG7HAldV
	pbFXE9k7LQ9W/6vcdUvDtRnRkT7IFA4jYHEZ5/Ig5jCQA7SBN1uqpvyxJJV9WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728490244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etQOuVXtSrNDCs1F1n1fkiDnWt+9VqJgYCxrLnDj/XM=;
	b=rlXelPQmKzWJ5nc6AfeIMPjamYwpmGsXKx2hMOrlsIVLqBQfAuYCA45SwSqcYQjUI9YMK4
	CG9zNsoNvyuy6MAQ==
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/1] lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.
Date: Wed,  9 Oct 2024 17:45:03 +0200
Message-ID: <20241009161041.1018375-2-bigeasy@linutronix.de>
In-Reply-To: <20241009161041.1018375-1-bigeasy@linutronix.de>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the printk issues solved, the last known splat created by
PROVE_RAW_LOCK_NESTING is gone.

Enable PROVE_RAW_LOCK_NESTING by default as part of PROVE_LOCKING. Keep
the defines around in case something serious pops up and it needs to be
disabled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/Kconfig.debug | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817ae..5b67816f4a62f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1409,22 +1409,14 @@ config PROVE_LOCKING
 	 For more details, see Documentation/locking/lockdep-design.rst.
=20
 config PROVE_RAW_LOCK_NESTING
-	bool "Enable raw_spinlock - spinlock nesting checks"
+	bool
 	depends on PROVE_LOCKING
-	default n
+	default y
 	help
 	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
 	 that the lock nesting rules for PREEMPT_RT enabled kernels are
 	 not violated.
=20
-	 NOTE: There are known nesting problems. So if you enable this
-	 option expect lockdep splats until these problems have been fully
-	 addressed which is work in progress. This config switch allows to
-	 identify and analyze these problems. It will be removed and the
-	 check permanently enabled once the main issues have been fixed.
-
-	 If unsure, select N.
-
 config LOCK_STAT
 	bool "Lock usage statistics"
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
--=20
2.45.2


