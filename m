Return-Path: <linux-kernel+bounces-532005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9CFA447BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABAC880A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F0D198A19;
	Tue, 25 Feb 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W12HrqQr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pod54X5q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01801990AB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503369; cv=none; b=fG1CZsBr0vU7Hi82lBTFPtt/UqELrhr4W0QYMXtkAiOMto7UcN++LySLsTxN0BBHwZSct8ubJUwC2QjPu5Bx/tbMsR+BpMK+jg/YC/7ggCLUL6WEFpGKaLVxKdCosMYGHE22y70jB9Qmz7OmwOxCpp6b0O2s2MSkPc2eqjx1c5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503369; c=relaxed/simple;
	bh=IfjiC76so8IkRI8wAlSWb7PGkO+WuJzx3KfFVBB0Mrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XCSdNMaZ/ahoRto1plZ2ofHcluZIdSSthxUv3pioEEizNV67S5LmY13hffp7qdGYWLFeEl+0Zcp5baVUVpmvD43wlz6Sd0mztKUHxJsvzLP6AtHag3kFZLYJFONPG9EBhjt94ECt7c5R2JLZZZ2ra7wEOE2PbEoUrX/vZX6aEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W12HrqQr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pod54X5q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740503360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LIkGtwE5ahJXcw1zOp3+tp04BQ7WHOOUrIirI70klUM=;
	b=W12HrqQr7Bx6M++LBtjrkEfzx1sugfzeYILQmwXpNXhiLhinG3PBxrOLJguL7ydmjnyrr7
	0eUNKzfZ/fpaoD9POOK/i6NRCWqen2+N5Bq1dzjbBQHRNzIO1jtU+u77URnH2XYKZOvb12
	jLytmXKu71T1hP4IywesRxAQGcloNyUkDl3QZyIElZZXpwuBAnfcHp+QK8C4Fzg/bgLnxl
	jVX2MNhh/LGII9MPTF/ZpE22e5FPeFnJkbbNQQ1QMxvZ8LMsHUMtDH94tJX9FaF722Rr22
	WwWUB8bRjx6RrbwA59xarO7l3QgYbTltONpHiMhMvfuq264sP2V9uk39StoBGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740503360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LIkGtwE5ahJXcw1zOp3+tp04BQ7WHOOUrIirI70klUM=;
	b=pod54X5qkZFH9pG7bOCzAgZbV16Q9i85qa+egI4AkjW06AAiPaefUCkBeSHR0+htL44uz0
	bxCGF6vdOGtt4YAw==
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
Subject: [PATCH v9 00/11] futex: Add support task local hash maps.
Date: Tue, 25 Feb 2025 18:09:03 +0100
Message-ID: <20250225170914.289358-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

this is a follow up on
        https://lore.kernel.org/ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.rem=
ote.csb

and adds support for task local futex_hash_bucket.

This is rebased of v8 ontop of PeterZ's futex_class. The complete tree
is at
	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git/log/?h=
=3Dfutex_local_v9
	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git futex_=
local_v9

v8=E2=80=A6v9 https://lore.kernel.org/all/20250203135935.440018-1-bigeasy@l=
inutronix.de
  - Rebase on top PeterZ futex_class
  - A few patches vanished due to class rework.
  - struct futex_hash_bucket has now pointer to futex_private_hash
    instead of slot number
  - CONFIG_BASE_SMALL now removes support for the "futex local hash"
    instead of restricting it to to 2 slots.
  - Number of threads, used to determine the number of slots, is capped
    at num_online_cpus.

v7=E2=80=A6v8 https://lore.kernel.org/all/20250123202446.610203-1-bigeasy@l=
inutronix.de/
  - Rebase on v6.14-rc1

Sebastian Andrzej Siewior (11):
  futex: fixup futex_wait_setup [fold futex: Move futex_queue() into
    futex_wait_setup()]
  futex: Create helper function to initialize a hash slot.
  futex: Add basic infrastructure for local task local hash.
  futex: Hash only the address for private futexes.
  futex: Allow automatic allocation of process wide futex hash.
  futex: Decrease the waiter count before the unlock operation.
  futex: Introduce futex_q_lockptr_lock().
  futex: Acquire a hash reference in futex_wait_multiple_setup().
  futex: Allow to re-allocate the private local hash.
  futex: Resize local futex hash table based on number of threads.
  futex: Use a hashmask instead of hashsize.

 include/linux/futex.h      |  32 ++-
 include/linux/mm_types.h   |   7 +-
 include/uapi/linux/prctl.h |   5 +
 kernel/fork.c              |  24 ++
 kernel/futex/core.c        | 450 +++++++++++++++++++++++++++++++++++--
 kernel/futex/futex.h       |  15 +-
 kernel/futex/pi.c          |  15 +-
 kernel/futex/requeue.c     |  29 ++-
 kernel/futex/waitwake.c    |  31 ++-
 kernel/sys.c               |   4 +
 10 files changed, 574 insertions(+), 38 deletions(-)

--=20
2.47.2


