Return-Path: <linux-kernel+bounces-390753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C7E9B7E23
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBDA282215
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F6A1CB316;
	Thu, 31 Oct 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qHhcXMRk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Fmlh67N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60F1C460B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387713; cv=none; b=ZeymK0GSNQgerpsYfZyp/7Q/7xj81gQ/TjflGHE9o4qbt2LCDoKjAt1+G9/5e/CPhh+WByv0ByT+Sq5Nir5sA+LLJKq58RRnQgusiGCLO3W6CM0WsBhN4OMhBKegk5/HkIAbG5E/huRxXnk2xUPUCCZIfOl4TBUa7TYb8VyiuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387713; c=relaxed/simple;
	bh=TooQOfPvH3C/Gh+3WhKo93UPT5gW3SF+TS9t69UO4Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o9/+7v9m93UY/x6uouxureYigVaqE3QKN+h5dMRucmICrpsBlj/4nt35vG9HHn+BSUIoqsew/oR2wj2hX+00yhTmoP+THF7aPZo6yT4dA+VSjvhK5SthgZqSQ+8oLleT0Pm/Zc5TfsnlDnhgwDX1QgKqqCogM7i0yUYAjblESoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qHhcXMRk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Fmlh67N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkFsH9K81US68VRXDR1e7Cociox8KLveGt3Rudv18T4=;
	b=qHhcXMRkGIAVyyYdpuUyV+ZuG8WrCSNqGWopsYCuAIm1TtkxmfDoWcuyB94PlTPjwloSfK
	eYml+IzgdGAlHfOHVGgsmv2l/cJKvxZ23vPD76Tm2hTBNqwwg+RS8/lttQAIRwJJPJPkSH
	YKBEtY+jbdODgyRX43Yv6bLkC9WL0OCRd3iHOg2qFykuRRT6HbKuAevJmqW+FDLK+C7gBL
	Uh9yT7Ym796dzkQOWoSfVb9IbhngEisrIRjoWNte1Zp/ggcR6g/cNPmXeTelBz3ItWwfs/
	rlTCk0nXejYlqWKz+F9oxId8RlxuU7PMLqyO1rRtc4y5WXUyjNfCBTeCdDqkLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkFsH9K81US68VRXDR1e7Cociox8KLveGt3Rudv18T4=;
	b=6Fmlh67NHEOJR2ay79hOqF/tawJTHiYh26fzHue7ZDegkIeesR5omRrGKuaLci+qRX1kcG
	Hdia48zJrioC0lAQ==
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
Subject: [RESEND PATCH v2 14/19] wait: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Thu, 31 Oct 2024 16:14:28 +0100
Message-Id: <fc91182375df81120a88dbe0263267e24d1bf19e.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_setup_sleeper_on_stack() replaces hrtimer_init_sleeper_on_stack()
to keep the naming convention consistent.

Convert the usage site over to it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/wait.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..643b7c7bf376 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -541,8 +541,8 @@ do {										\
 	int __ret =3D 0;								\
 	struct hrtimer_sleeper __t;						\
 										\
-	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
-				      HRTIMER_MODE_REL);			\
+	hrtimer_setup_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
+				       HRTIMER_MODE_REL);			\
 	if ((timeout) !=3D KTIME_MAX) {						\
 		hrtimer_set_expires_range_ns(&__t.timer, timeout,		\
 					current->timer_slack_ns);		\
--=20
2.39.5


