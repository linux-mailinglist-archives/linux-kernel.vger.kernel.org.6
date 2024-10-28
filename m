Return-Path: <linux-kernel+bounces-384250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B579B28CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4211F211E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F6A1CC8B0;
	Mon, 28 Oct 2024 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CrNm3WSv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oBJUaiF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE94685
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100635; cv=none; b=qCb7OkQioHWIPAsuNw4D0xzVCHXcgzAG5t30XTtat62+mxShNnIpq6ADsf1OrH4Vd/22wqXAP8O9kJ48UztuHQKq0hrGiIEDidIssog/Ws29yMQ5VoWJQO4aYwrRz+nO1iCanbcnJ6+qrsstR33i/IOUWHoVAbi4s0opMgboIlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100635; c=relaxed/simple;
	bh=m95rj/Pg7jxnHdOd2G91tOu5rlRz/g+shSHe+A0RntA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDgsEkzBRu4dEWsC0pUbD0FfgyzYlWWjXZfwqGluwuJvb8J4cpsRtdGXk9xUIKBdygQPrTSZz3adiGyvBL3ahDRonfW0C1r88/xu5LtNFQ/wXZyFYyJnqt8EmD5XnoiyzF8GCZgO0sy9qj7ojzhb71eUmK/mtAa+lpXbb0iCP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CrNm3WSv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oBJUaiF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nItAbF4ba+O/4+a1zT7+rDPb5gC8aLbVN70IhsEWi5o=;
	b=CrNm3WSvd/eXu96nMLarF3jc/5M6TRPlAdCMyJc6Gv40XtHR7pg2Kqiw00fkaRRJY4ebXQ
	5UwOQJdOf45IWV01hw7ObZqDG21tjvv/CrZiXhxT2JENijW1LfUFhklu13vh8VeNdp6d/r
	Oy/OF4SE0XigbvfeevCntWgtuL405aEz7hDyOD5r/2xjLEj6MNeYQeEcaNmZOtqxZy6o9N
	y6neix1MsdNXiknlAEkp95o+TozADJfDv6nKrq2gf0xgpyT9o+mRXEX521gpTmf5fzJ+33
	ARCLajaOELT7FzUe6k78Gd3jq52nCh3cytF1X3oShXjtqttAABhSoZz2kmSu9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nItAbF4ba+O/4+a1zT7+rDPb5gC8aLbVN70IhsEWi5o=;
	b=0oBJUaiFQQiKU3UoUcH8Jh1kDJalFcN+5fErzKyoN0PD17CC/Sdxy7ZCSzt2Gy8MQBEfFO
	FLlgKVPfeUwK9gAg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 10/21] hrtimers: Introduce hrtimer_setup_sleeper_on_stack()
Date: Mon, 28 Oct 2024 08:29:29 +0100
Message-Id: <77c7c39cc8ae350c14a2116f8b827f71c41bcacb.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_setup() and hrtimer_setup_on_stack() have been introduced to
replace hrtimer_init() and hrtimer_init_on_stack(). To keep the names
consistent, also introduce hrtimer_setup_sleeper_on_stack(). The old name
hrtimer_init_sleeper_on_stack() will be removed as soon as all of its users
have been updated.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  2 ++
 kernel/time/hrtimer.c   | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2da513f8d66a..48872a2b4071 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -238,6 +238,8 @@ extern void hrtimer_setup_on_stack(struct hrtimer *time=
r,
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
 					  clockid_t clock_id,
 					  enum hrtimer_mode mode);
+extern void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl, clo=
ckid_t clock_id,
+					   enum hrtimer_mode mode);
=20
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index daee4e27f839..1d1f5c03673c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2065,6 +2065,20 @@ void hrtimer_init_sleeper_on_stack(struct hrtimer_sl=
eeper *sl,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
=20
+/**
+ * hrtimer_setup_sleeper_on_stack - initialize a sleeper in stack memory
+ * @sl:		sleeper to be initialized
+ * @clock_id:	the clock to be used
+ * @mode:	timer mode abs/rel
+ */
+void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init_on_stack(&sl->timer, clock_id, mode);
+	__hrtimer_init_sleeper(sl, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);
+
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
 	switch(restart->nanosleep.type) {
--=20
2.39.5


