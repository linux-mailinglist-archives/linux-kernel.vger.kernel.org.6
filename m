Return-Path: <linux-kernel+bounces-227432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E559391511A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A167D2824C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56B19D8A7;
	Mon, 24 Jun 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yqbeOPlP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j5EHRPt8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826919D06B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240862; cv=none; b=MzNdAnZLZ7Iny/v6bVuUtmG2KsadAN9jTotGvRRF3pw8FcJW5Hiy6wyK8LEIUBJJEApJnQQRWBtSqdvcs7Hvyj/u9dq+aoTwm+3ea5ZhYRJA3HKlJu08aAlsEYgA3PYA9AX2liEtw25UgCss5B7SKizIoilqqRchCl9uiVbU1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240862; c=relaxed/simple;
	bh=4yBjlfA0tuIAEuVSIqkRa/8T70pDH/sbNUKs5SlgSHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/6KoaPjFkA5owUK9/Nsr6sLbP9PDY5peNLJrhDRUatsxQKD4fxt+5mKCM/M9Y3ZUr7s4BJcaKnILOYh9KlZ+LomqGH3xK7zkpNqgWhi9ea4dlOLrBH27d4gCETPDT9jqpMK7jGJncqY4LO1tmPsj+SRvtuy8F2LpzQJ7Ge3Yes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yqbeOPlP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j5EHRPt8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719240858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQfLpd4KsucHQv4vv56t9DwxntT2d0zNXi6vClOfi/4=;
	b=yqbeOPlP88EL8vhlLsfiDaJH8OX/MfrZTt0M457CTvKY/8ZfECuFjTPYOGFIJNOmQcS/iE
	K8PrWfN/rvtzEaYcJrBgxFWy7VRiX1LmFUHIpC8ZHm/NjtXvBZxlBjzQH0rHdqXkM+In9v
	iNNTAix2bnGedV7SOavx88ARayQPNyVOJdsFjGVBWvhDKiAOCpH3hw6EWBCWxqcxGI3b18
	Z4RkX5RXY82zKRsiuuTYaHWHr03a/tvVyBwaYy/saXemXXT8/258Ef3jouF4Sll9yFCL0N
	zHmKRETKIkpOT+ujG7XIGMVhzSL5JwlhALGjLYwxMyOrkBG2h7ZHDPiOZxadYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719240858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQfLpd4KsucHQv4vv56t9DwxntT2d0zNXi6vClOfi/4=;
	b=j5EHRPt8ry18cHOtg2ynonAvD7DWnKhC8XRuOrve8z0V6hqf5LgcOUw1yPeN6rwVEJQ5xL
	vkvMW6mznYS6vnBQ==
Date: Mon, 24 Jun 2024 16:53:55 +0200
Subject: [PATCH v2 3/5] timer_migration: Split out state update of
 tmigr_active_up()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-tmigr-fixes-v2-3-3eb4c0604790@linutronix.de>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
In-Reply-To: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

The functionality of the state update is split into __tmigr_active_up() to
be reusable by other callsites.

This is a preparation for a fix of a potential race when a CPU comes online
the first time and creates a new top level.

No functional change.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 47 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 600c9e866fae..0e1c53dac390 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -623,12 +623,38 @@ static u64 tmigr_next_groupevt_expires(struct tmigr_group *group)
 		return evt->nextevt.expires;
 }
 
+static bool __tmigr_active_up(struct tmigr_group *group, bool *walk_done,
+			      union tmigr_state *curstate, u8 childmask)
+{
+	union tmigr_state newstate;
+
+	newstate = *curstate;
+	*walk_done = true;
+
+	if (newstate.migrator == TMIGR_NONE) {
+		newstate.migrator = childmask;
+
+		/* Changes need to be propagated */
+		*walk_done = false;
+	}
+
+	newstate.active |= childmask;
+	newstate.seq++;
+
+	if (atomic_try_cmpxchg(&group->migr_state, &curstate->state, newstate.state)) {
+		trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+		return true;
+	}
+
+	return false;
+}
+
 static bool tmigr_active_up(struct tmigr_group *group,
 			    struct tmigr_group *child,
 			    void *ptr)
 {
-	union tmigr_state curstate, newstate;
 	struct tmigr_walk *data = ptr;
+	union tmigr_state curstate;
 	bool walk_done;
 	u8 childmask;
 
@@ -640,23 +666,8 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	curstate.state = atomic_read(&group->migr_state);
 
-	do {
-		newstate = curstate;
-		walk_done = true;
-
-		if (newstate.migrator == TMIGR_NONE) {
-			newstate.migrator = childmask;
-
-			/* Changes need to be propagated */
-			walk_done = false;
-		}
-
-		newstate.active |= childmask;
-		newstate.seq++;
-
-	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));
-
-	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+	while (!__tmigr_active_up(group, &walk_done, &curstate, childmask))
+		;
 
 	if (walk_done == false)
 		data->childmask = group->childmask;

-- 
2.39.2


