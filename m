Return-Path: <linux-kernel+bounces-383407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0279B1B5A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41791F21B15
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A7E1D8E10;
	Sat, 26 Oct 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18p4+/gC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="enpw0AzO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C651D7E26
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729982599; cv=none; b=Z7kOpXHDdQndfcUa4duTf9C2SmryqUeSkJMyM/I2b+bjapi7KqUTk6UZD6xR49eTTGrqSGHalhvDJ+QuhzgbdFI0PrWbU2+hBicOc740YLG2hfxB5uWF2vmmBHzZ5V3phdpivwdaf41ireaxsAwjg26vELAVPcC00Wt4qoHhJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729982599; c=relaxed/simple;
	bh=OSVA7A+BPHHttEi6S/dg8M8WlMd37++hEg0fCjbjlvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpxPrwvPr5okVl09Lfb/4mOZ0nvqAgqe0TZn6i9q+oJziD4Xl/AgCBGHjkVpoOnOLFQ5BQTp5K31RCY7Ijz2JnWH/8GL5I8nury7qAYJaWMUkP5t8RWrCld9gxPDHN1NEgD9R0P7X1zTwPZUi4ECdlRgEo7VitbBH5QPj4CL+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18p4+/gC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=enpw0AzO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729982595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02mSu6rshCk1Mwn63Bz1qY8iE8iPAdeZEeCxOh2Pe+8=;
	b=18p4+/gCdeHYWw8TkTzm3e0gLZC3BKdfVndLo7q3JTGyb5sAf+0LunssBzOaUz+9woLM4/
	VYrRTlihosSyuFDCZ5NIWEhSAq0bSUhL02ZD5vTs9+njRZ2oD0E+FgPOw+JjKbdxx3lANp
	3u1vJu1+A79c4pqVKwNsPoesF7I3bhZtfFjuAAJiM/lE/zE4IQMZFcSJqS+VnZt8CP/KE7
	orEttAt89kd3va3g/SmHrykvqyX2A/fskG4U4/1QWcE/3y8smr1pyto0M4x6vw7UxLjoSV
	WEkO26F3bf9gG6Hh0QQrDPODdTuWTjO8WLFaqauKwpT8mhgKoHIC0C0FgVyICw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729982595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02mSu6rshCk1Mwn63Bz1qY8iE8iPAdeZEeCxOh2Pe+8=;
	b=enpw0AzO3/66KxLrvYJ8Hjlg1Zar1TDBuCkaQ/hZQOoNbuAVrz5exYwYhMJxU5Fv+E3Bui
	CHCR75/R0JfDK8DQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 3/3] futex: Use the task local hashmap.
Date: Sun, 27 Oct 2024 00:34:52 +0200
Message-ID: <20241026224306.982896-4-bigeasy@linutronix.de>
In-Reply-To: <20241026224306.982896-1-bigeasy@linutronix.de>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the hashlocal hashmap if provided.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 7c97fc96f84a3..ee5a6902154c5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -119,13 +119,18 @@ late_initcall(fail_futex_debugfs);
  * @key:	Pointer to the futex key for which the hash is calculated
  *
  * We hash on the keys returned from get_futex_key (see below) and return =
the
- * corresponding hash bucket in the global hash.
+ * corresponding hash bucket in the global hash. If the FUTEX is private a=
nd
+ * a local hash table is privated then this one is used.
  */
 struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
+	struct futex_hash_table *fht;
 	u32 hash =3D jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
=20
+	fht =3D current->futex_hash_table;
+	if (fht && (key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED)) =3D=3D=
 0)
+		return &fht->queues[hash & (fht->slots - 1)];
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }
=20
--=20
2.45.2


