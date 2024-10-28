Return-Path: <linux-kernel+bounces-384248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F489B28C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DBE1F2144B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424DF198836;
	Mon, 28 Oct 2024 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BcBTeNw1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7z9s6Zxr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C58191F91
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100634; cv=none; b=hAw/scY6eveQmOVnTHZUHMeu9lovUhnSjbaow2cB5iJ7rj+jxRaanfA+NYhOrZbN+cQ2s1tamQi5xMkXC0gk9ENNs7NtzroRS/zPEFdG9Neih2HUeQeWQEeBmrHElPMW1Q1rVhRLlIdiqocDqLs1TaB/fWGcli30Jcc1I7VaXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100634; c=relaxed/simple;
	bh=Hj3C6EZ8cwxl6BeA5KWcnO9yDSQ7xz0TVN71quWr8uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7JQJIMFkYQZRi6CNWWuni/A93RqxL5r7Cki+tj5GOSMAxrEa/yk4d5/87Ch9QLT0fyzsZU+Fcju+a9SnTU+9DOVOVvCEIkm7h2Wah5iD0AZpbFSz9AznHYB3aSEyAalA88ibSocZL/WDzw8rVNrYUWiXb2agR2+1EGlUaSphWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BcBTeNw1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7z9s6Zxr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3cxdO1hcAE4AUoe+zcWrRKQNPwx3jps5mImQ9N2A+0=;
	b=BcBTeNw1KY2OLf1xEQ1ThpTDYu7NefFRpWh2S7SyxixqNtPA5gko6lp0z+3bB1NuS0fObn
	N2/DXxpkDavx8Sf1zjD6RMYcLBmK/yIhvVzVn+VAyI4HoqjoQdABm2PHA5PSSfGuk1oGDb
	3zC5fT5eXjIixt8hGtLcoG3zc8mbyp0B8o2gEg6nMzqyKywWKR7EmNyVx0rbmSbEan1WIG
	FLLrrAxEcvoWHG4QKhLuSt23kw8TBxuCOO6IoLp95/N/B46hBH4EZHCblIsVCjhwa6N8Tm
	igAevF/ZgGk0nm9lKJ0z/MdFtsXOlgNr8rAq2VHOTJlflszXcoq2EKJrfRk/yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3cxdO1hcAE4AUoe+zcWrRKQNPwx3jps5mImQ9N2A+0=;
	b=7z9s6ZxrvfoRX7xh952MQAHFoO/xERI/UAEEKr+JmmwhKHRwwPMom/b5lCcyxHe7IYELzn
	66a5UirBkNLKZ1Bw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 08/21] hrtimers: Introduce hrtimer_setup() to replace hrtimer_init()
Date: Mon, 28 Oct 2024 08:29:27 +0100
Message-Id: <2159c09badceec667d800005ac98824105ba8dc6.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To initialize hrtimer, hrtimer_init() needs to be called and also struct
hrtimer::function must be set. Introduce hrtimer_setup() which does both of
these things, so that users of hrtimer can be simplified.

The new function also does sanity check on the callback function pointer
from user. If the function pointer is invalid, initialize 'function' with a
dummy callback, so that the kernel doesn't blow up later on.

hrtimer_init() will be removed as soon as all of its users have been
converted to the new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  2 ++
 kernel/time/hrtimer.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 5aa9d57528c4..bcc0715c59a8 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -228,6 +228,8 @@ static inline void hrtimer_cancel_wait_running(struct h=
rtimer *timer)
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
+extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fu=
nction)(struct hrtimer *),
+			  clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_c=
lock,
 				  enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4b0507cf38ea..a5ef67edcda9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1535,6 +1535,11 @@ static inline int hrtimer_clockid_to_base(clockid_t =
clock_id)
 	return HRTIMER_BASE_MONOTONIC;
 }
=20
+static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
+{
+	return HRTIMER_NORESTART;
+}
+
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
@@ -1571,6 +1576,18 @@ static void __hrtimer_init(struct hrtimer *timer, cl=
ockid_t clock_id,
 	timerqueue_init(&timer->node);
 }
=20
+static void __hrtimer_setup(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	__hrtimer_init(timer, clock_id, mode);
+
+	if (WARN_ON_ONCE(!function))
+		timer->function =3D hrtimer_dummy_timeout;
+	else
+		timer->function =3D function;
+}
+
 /**
  * hrtimer_init - initialize a timer to the given clock
  * @timer:	the timer to be initialized
@@ -1591,6 +1608,27 @@ void hrtimer_init(struct hrtimer *timer, clockid_t c=
lock_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
=20
+/**
+ * hrtimer_setup - initialize a timer to the given clock
+ * @timer:	the timer to be initialized
+ * @function:	the callback function
+ * @clock_id:	the clock to be used
+ * @mode:       The modes which are relevant for initialization:
+ *              HRTIMER_MODE_ABS, HRTIMER_MODE_REL, HRTIMER_MODE_ABS_SOFT,
+ *              HRTIMER_MODE_REL_SOFT
+ *
+ *              The PINNED variants of the above can be handed in,
+ *              but the PINNED bit is ignored as pinning happens
+ *              when the hrtimer is started
+ */
+void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)=
(struct hrtimer *),
+		   clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init(timer, clock_id, mode);
+	__hrtimer_setup(timer, function, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup);
+
 /**
  * hrtimer_init_on_stack - initialize a timer in stack memory
  * @timer:	The timer to be initialized
--=20
2.39.5


