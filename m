Return-Path: <linux-kernel+bounces-557971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63365A5E001
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE24618955B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB8250BFA;
	Wed, 12 Mar 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lr5Goxq1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GK7aYlrX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711FC15539A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792604; cv=none; b=iIRQ28gLY6e5KdMDJyiNUIYqx73hnXougNge4BtTBTZzljZYcDD8anyrtvhTnzcOU7OX6drBQkqO/2sI6dqyCpVAUJSgpGJveG0aRvmx6+hfwkavDzN3eVXerZXNDDkcpIea03fjkeS/oZZMr8YjWFbxwML+kva4Li9NK1uUScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792604; c=relaxed/simple;
	bh=hcWZjNCxjGsr0P1tH6aZ4F1DBNY3VCi/s2YS5QlAsU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQITFC9Eug4LyNwfZ5NMf9iDtHvibwvuGBff8u62Z1QTIhTXgAG4nOi3o4khmToLCyS+PCm2dJi60BKvVSWEMQcKsO7J5pHvuaryWDxFpM60SIkGIxgL3BDnl25tYpsOY72v8SUC+jkPJr449xPn9KFkhpMtFvLsaHxBhUXt8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lr5Goxq1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GK7aYlrX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7bu4gzDDxGaac6doSvKGFnMgvLdgh2Hvzf+k6mP7CA=;
	b=lr5Goxq1/ZG96afTjZFpkHdUGK2pMjgP8kiITiULDv4SbN2MR1UMgAOZEAtYFtHnSwcVyW
	gsZu5F82BuJwGaVfdVeDSAM/dx0A8akzUTSblnyFIOW6fRSqOxXrKlkgBeUJ28EWpAvS8o
	wKbVOBGrEwIp93uhH7V6gKD93+O677vo2Z/SQiXmGaQWO/MYqtiE9zwT7ZPb3CtQ/Lt16l
	Q1oRqVPeKuPS0bop5KneI10cJ55Sj48uwPnixUOWtrWG3x00RF3sHAt0ol7ux3Agq8hOsZ
	sziyYVV9MTWprsP2bdtLIaq03ffFdNebxW2v3NKXN2GHMgyRyMXJiMSvyjjTKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7bu4gzDDxGaac6doSvKGFnMgvLdgh2Hvzf+k6mP7CA=;
	b=GK7aYlrXWSx5/vPOyzxflTAQdhq1KXapxtKvGJdZn6dxQAgiAGVBedA3DPzq9Ef1T8faUa
	g1YV8I4ZqSUf96BQ==
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
Subject: [PATCH v10 01/21] rcuref: Provide rcuref_is_dead().
Date: Wed, 12 Mar 2025 16:16:14 +0100
Message-ID: <20250312151634.2183278-2-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rcuref_read() returns the number of references that are currently held.
If 0 is returned then it is not safe to assume that the object ca be
scheduled for deconstruction because it is marked DEAD. This happens if
the return value of rcuref_put() is ignored and assumptions are made.

If 0 is returned then the counter transitioned from 0 to RCUREF_NOREF.
If rcuref_put() did not return to the caller then the counter did not
yet transition from RCUREF_NOREF to RCUREF_DEAD. This means that there
is still a chance that the counter counter will transition from
RCUREF_NOREF to 0 meaning it is still valid and must not be
deconstructed. In this brief window rcuref_read() will return 0.

Provide rcuref_is_dead() to determine if the counter is marked as
RCUREF_DEAD.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rcuref.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
index 6322d8c1c6b42..2fb2af6d98249 100644
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -30,7 +30,11 @@ static inline void rcuref_init(rcuref_t *ref, unsigned i=
nt cnt)
  * rcuref_read - Read the number of held reference counts of a rcuref
  * @ref:	Pointer to the reference count
  *
- * Return: The number of held references (0 ... N)
+ * Return: The number of held references (0 ... N). The value 0 does not
+ * indicate that it is safe to schedule the object, protected by this refe=
rence
+ * counter, for deconstruction.
+ * If you want to know if the reference counter has been marked DEAD (as
+ * signaled by rcuref_put()) please use rcuread_is_dead().
  */
 static inline unsigned int rcuref_read(rcuref_t *ref)
 {
@@ -40,6 +44,22 @@ static inline unsigned int rcuref_read(rcuref_t *ref)
 	return c >=3D RCUREF_RELEASED ? 0 : c + 1;
 }
=20
+/**
+ * rcuref_is_dead -	Check if the rcuref has been already marked dead
+ * @ref:		Pointer to the reference count
+ *
+ * Return: True if the object has been marked DEAD. This signals that a pr=
evious
+ * invocation of rcuref_put() returned true on this reference counter mean=
ing
+ * the protected object can safely be scheduled for deconstruction.
+ * Otherwise, returns false.
+ */
+static inline bool rcuref_is_dead(rcuref_t *ref)
+{
+	unsigned int c =3D atomic_read(&ref->refcnt);
+
+	return (c >=3D RCUREF_RELEASED) && (c < RCUREF_NOREF);
+}
+
 extern __must_check bool rcuref_get_slowpath(rcuref_t *ref);
=20
 /**
--=20
2.47.2


