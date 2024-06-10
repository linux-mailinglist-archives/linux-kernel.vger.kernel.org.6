Return-Path: <linux-kernel+bounces-208174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB619021DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A543828464D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7CB7FBA1;
	Mon, 10 Jun 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W6jTctGx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOTQN9Ei"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5881211
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023601; cv=none; b=alivhNN09EQj1PYffUDsN4WZJacBiilX8BhRHJRF4I8lthFepTy0OYzYJQImIz2lMSAn9dhzpCheFvWHs6nBZINz2RUB8cNC4ga076W0cEAb8lGQITHjGBAf0CnauAgReOAFK7401S3Cgd+Gnzxw6hM+b9i7O7IkGL7kBilEhmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023601; c=relaxed/simple;
	bh=3f/P+yKfDD1JJ3JmMZTVY0zvYt/RZf6q4FDQnJb9lfI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=eXnp8LeyHeyKiqbBmHs7H0/vVUKhEhXRGuq9Skemv98FjSrlgWfHtKJKF3IEahHPcm2RNtsoQWnD+vJZXi3lsjY8feJ7drUIy50PrUnY9BOdKBTTHd9nF9/4jG3pzEmcbsy/ltS6klhG+pZngiKHvQ5fbNyD4Vg6qrAUc9dm6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W6jTctGx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOTQN9Ei; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610124406.484973160@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718023598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VC6lH3dC9sC0pTK2Lu8vCn78JTXMe8396fISayi/2Vc=;
	b=W6jTctGxznSs+d0Vc0T3v2pyTyX8ZeWi4ZJPm4e3cz2qxlCRGnZITUy+rnTqy7u8XDyHru
	AT5yh1xlA5MrDfaCaK1cZEpMnrqrdyupPA8JTmk+AjsWYuBsyW6bRBHHouDlRdWeRoIcwF
	sn1SUxVdUfj2JIPDWEjpWIsF5nvvFHuctnRUfOGJl6czNPWRsl8fujGWgbOMom/Mlf+9MU
	I+Dq5r71wVKDZe+8ujBURIC3JGBzC47Yfb3eYv16dWJRpu9LLNGSF5/TwuTYXQMc14kJdO
	kNQViAEoFMl0eVRCFY1DhMjpEg5pYi41nljNGip2aQsezJK1Gr0ITIK7xTdMsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718023598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VC6lH3dC9sC0pTK2Lu8vCn78JTXMe8396fISayi/2Vc=;
	b=pOTQN9EifyeiNBTLQTvhWd26e5r9OUy2JFMVMc4M7N9XpACKLeQv/vSC43WmwKZC14Q+xj
	HBWpnM94Bw7tuJBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Sam Sun <samsun1006219@gmail.com>,
 x86@kernel.org,
 syzkaller-bugs@googlegroups.com,
 xrivendell7@gmail.com
Subject: [patch 3/4] jump_label: Clarify condition in
 static_key_fast_inc_not_disabled()
References: <87bk49xf15.ffs@tglx>
 <20240610124258.109097511@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 14:46:37 +0200 (CEST)

The second part of

      if (v <= 0 || (v + 1) < 0)

is not immediately obvious that it acts as overflow protection.

Check explicitely for v == INT_MAX instead and add a proper comment how
this is used at the call sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/jump_label.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -132,12 +132,15 @@ bool static_key_fast_inc_not_disabled(st
 	/*
 	 * Negative key->enabled has a special meaning: it sends
 	 * static_key_slow_inc/dec() down the slow path, and it is non-zero
-	 * so it counts as "enabled" in jump_label_update().  Note that
-	 * atomic_inc_unless_negative() checks >= 0, so roll our own.
+	 * so it counts as "enabled" in jump_label_update().
+	 *
+	 * The INT_MAX overflow condition is either used by the networking
+	 * code to reset or detected in the slow path of
+	 * static_key_slow_inc_cpuslocked().
 	 */
 	v = atomic_read(&key->enabled);
 	do {
-		if (v <= 0 || (v + 1) < 0)
+		if (v <= 0 || v == INT_MAX)
 			return false;
 	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v + 1)));
 


