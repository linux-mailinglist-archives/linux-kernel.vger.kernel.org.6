Return-Path: <linux-kernel+bounces-390746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C69B7E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA10281335
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24F1BC068;
	Thu, 31 Oct 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHyloqVr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ywC5R17G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D41B86D5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387710; cv=none; b=UaAg6kacH6vksq99tnt94Vkbfdl02r44wT7627Ov17rxJ1xLkWdW/3fQbjzTSP+ROMqlemXIRTZFQvwBeuU5UZxCoeCXqFgweFBzUjeNYby3m/EaDkr+tjWTBt8t/5zrsY1ZuA9WN7ZrN5KaoDeR8Cweg88NEReVT0pgd68a0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387710; c=relaxed/simple;
	bh=rOgJoI5pNJFyNAVwdETx/k1ZKruBs2HuZdgKOn2HJqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7MISyHYZ+qZqe8CcISFgLqppItmVUlk34WcDG8lg2pl2B+T8/C6Iux9FxYoW/1i7/N+qqB0LJLSXS4fIkTduEtnUIAe/5tMpEiKTM3ryIaMuhBMC3QOEuGgfmv+pENw478Jzc7KWZ5Zc1hehuJPQg6rwbu8fX6Wo5K58+b1shE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHyloqVr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ywC5R17G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mzDkHhgj8rt6gZnZO44C9ll+sOEso58V5R/ieU+5hI=;
	b=AHyloqVryNyQXmmoEY9l0xxiwzVfLvZ1JoPcAKuJyS7wklsurIJy6gHNYUqq0e8eUu3xqo
	JVfWHig+8ANFENDntF9EuZoVnfuevKsLyMyeSihfVANhkBJYu/U/kPBfVmpJXJLA9Y3UZS
	8BIbPnug0bwLAHc7G1YW54yPNOfi0uknToblDRZswRBjpXw1oxJnDHqvqup2f9TOBM8H5+
	5/MJ8AfmBKOndd9Gq9mLWCAVLuTUgEUhlYPwG4p9/M9j0JItrW7PS4InRBHg08PLH3wE7K
	hItd2P8Y0gCilYyGMSmFJ73tydfIcbDsVjJUybHhSxve1in4lZpr+gujn6E9qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mzDkHhgj8rt6gZnZO44C9ll+sOEso58V5R/ieU+5hI=;
	b=ywC5R17GJElzyGjv6HcpGX2sAp0W/8joA0T9jLDp7flM+OIJwi0gAAtSngIrpubHijfOkF
	Cq6FkebKFwjOulDg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RESEND PATCH v2 07/19] hrtimers: Introduce hrtimer_setup_on_stack()
Date: Thu, 31 Oct 2024 16:14:21 +0100
Message-Id: <4b05e2ab3a82c517adf67fabc0f0cd8fe118b97c.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To initialize hrtimer on stack, hrtimer_init_on_stack() needs to be called
and also hrtimer::function must be set. This is error-prone and awkward to
use.

Introduce hrtimer_setup_on_stack() which does both of these things, so that
users of hrtimer can be simplified.

The new setup function also has a sanity check for the provided function
pointer. If NULL, a warning is emitted and a dummy callback installed.

hrtimer_init_on_stack() will be removed as soon as all of its users have
been converted to the new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  3 +++
 kernel/time/hrtimer.c   | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bcc0715c59a8..2da513f8d66a 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -232,6 +232,9 @@ extern void hrtimer_setup(struct hrtimer *timer, enum h=
rtimer_restart (*function
 			  clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_c=
lock,
 				  enum hrtimer_mode mode);
+extern void hrtimer_setup_on_stack(struct hrtimer *timer,
+				   enum hrtimer_restart (*function)(struct hrtimer *),
+				   clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
 					  clockid_t clock_id,
 					  enum hrtimer_mode mode);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index a5ef67edcda9..daee4e27f839 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1646,6 +1646,25 @@ void hrtimer_init_on_stack(struct hrtimer *timer, cl=
ockid_t clock_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
=20
+/**
+ * hrtimer_setup_on_stack - initialize a timer on stack memory
+ * @timer:	The timer to be initialized
+ * @function:	the callback function
+ * @clock_id:	The clock to be used
+ * @mode:       The timer mode
+ *
+ * Similar to hrtimer_setup(), except that this one must be used if struct=
 hrtimer is in stack
+ * memory.
+ */
+void hrtimer_setup_on_stack(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init_on_stack(timer, clock_id, mode);
+	__hrtimer_setup(timer, function, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup_on_stack);
+
 /*
  * A timer is active, when it is enqueued into the rbtree or the
  * callback function is running or it's in the state of being migrated
--=20
2.39.5


