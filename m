Return-Path: <linux-kernel+bounces-429863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85069E27E2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE26F168A80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20FC1F9F71;
	Tue,  3 Dec 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiLfMQae";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fwj48aWp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9521F8ADB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244221; cv=none; b=M1+UyrQJB4vHVN049ZJhr1v4bFSyG6GCZTQsRnasurF7ptlkNPCimHqnCYOJ3HIId4FDcBuuAiXn7lvwThgjIzoAFaopcisgr3lPRCE6EchKEuv/jsZRITz3HJXjXJTUA7NmfqkknDjLWacob/3zn02ycd4ZMp72PBjMDm/KjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244221; c=relaxed/simple;
	bh=1jg7C4Hn7tl+DNFyCMZ58uFZgzsrwganhgb1pjnKjCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea6hWGAOdQLOZZxof4+TDFOlHWs5Al4J0GgoZzJWAjq0usi3kumsXwP7U6x2+95ZPY6xBXz7OS2vHugUxQ8ZaGrOkhvTgd6S786do8fbm0eZK5LhhYDmPc6ggCxSedWPu1x5zP1Z5cVwj6/TPu5noWVAXR3qCgjYYygvZYC76HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiLfMQae; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fwj48aWp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ1YXfG8xZyG1QlATAkQFmGyYAn75aCDQCDdTpLb2R8=;
	b=fiLfMQaeTXwX5dGNyPra8Hg97O74thVcC2fy8zPFrM8uWth3ZNUPkgzq9dMrG+xiezf6yS
	a17KkI4QFjkGDuNr1OHQdW+MItu9dYNCnMqxM1Eqtn9V2EO0zDibxt6APOf4nuB/dnAwJ2
	P2J+VGsxJ2JyEoIz8bHSruC8cF6XK/PrsmO7fDlv8r25hd7jYJfYwDonk3uRYo2FG4cYo5
	mqtPD6nnvnyaw7zWieCyRGbcOW7WkFH2fMOAN41amxT5wzGDHWUk80ZQbLo08Iu66vrHJw
	rONFgtAne5uereZvnq+r6Daj5ciwruOfHxAOMEWsAHLWK6e9na87qAh0EtIuYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ1YXfG8xZyG1QlATAkQFmGyYAn75aCDQCDdTpLb2R8=;
	b=Fwj48aWpDnaqEvQJgYqkNOI5wai4nHTteDqyWcouVSpbmSuce2B9NicOMoJ0fhoxsn1DWJ
	8CFUaXkZg07LuCCg==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 03/11] futex: Allow automatic allocation of process wide futex hash.
Date: Tue,  3 Dec 2024 17:42:11 +0100
Message-ID: <20241203164335.1125381-4-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allocate a default futex hash if a task forks its first thread.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index cda8886f3a1d7..6267d600af991 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2130,6 +2130,17 @@ static void rv_task_fork(struct task_struct *p)
 #define rv_task_fork(p) do {} while (0)
 #endif
=20
+static bool need_futex_hash_allocate_default(u64 clone_flags)
+{
+	if ((clone_flags & (CLONE_THREAD | CLONE_VM)) !=3D (CLONE_THREAD | CLONE_=
VM))
+		return false;
+	if (!thread_group_empty(current))
+		return false;
+	if (current->mm->futex_hash_bucket)
+		return false;
+	return true;
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2507,6 +2518,21 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cancel_cgroup;
=20
+	/*
+	 * Allocate a default futex hash for the user process once the first
+	 * thread spawns.
+	 */
+	if (need_futex_hash_allocate_default(clone_flags)) {
+		retval =3D futex_hash_allocate_default();
+		if (retval)
+			goto bad_fork_core_free;
+		/*
+		 * If we fail beyond this point we don't free the allocated
+		 * futex hash map. We assume that another thread will created
+		 * and makes use of it The hash map will be freed once the main
+		 * thread terminates.
+		 */
+	}
 	/*
 	 * From this point on we must avoid any synchronous user-space
 	 * communication until we take the tasklist-lock. In particular, we do
--=20
2.45.2


