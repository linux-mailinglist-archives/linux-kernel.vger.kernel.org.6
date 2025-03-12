Return-Path: <linux-kernel+bounces-557970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B7A5E000
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A568A3AA183
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A81F24E01B;
	Wed, 12 Mar 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8xa5w2S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8lA2TPT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161E139579
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792603; cv=none; b=unGkesRASnj6ukLe2rLWgprwIXMcNC3hX9iAChVF0IuEHwwrbF8nyK9GHbOJUE9uSLBvMT5fBMjVokXSYklrfK44r44xUGhqtubM+qYnsJpgYwqlsAJ+VtfkR/x+RcZXAcYcHOy+0982AqipEsA+2/5aVorkUG2kUtljoeYU5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792603; c=relaxed/simple;
	bh=DqF2qBWPmXl3h0/Vw8cSzVe+J068SL8tj2Gm3P5KphI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lTEBECbVuw02iBcx9Kumu2hOdvggvrwp+8SIO+Bdt7U7In9riIDxS7ezPmmxfbe3sHeN7XSn2SMWkTNP6/ych2QyD4NMbESMJHXSfRG/QrkKSm2ynl6ppKPOjAr+n1uWXWoDRkubPSFGxlXoT5C8rwJKRjkhhQKZLS6iuMXcB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8xa5w2S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N8lA2TPT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rNJDVzdEQR1XApdNl2anre1c4jIQklDJ/w+w9BbSv4M=;
	b=b8xa5w2SyZYKqb0t/uyRnxL5cUdIdo9lP0/99q4r9psy8QGtg8dzccdiQ3FlitVRpYZc0Y
	dBqes64R2Z6fRl2PRpaZp72Cdyqri98JE3rQl07VakvabBK9ssAFlt7U/pTzZ1r7zJn6FC
	eg7KnD2kgESTZLeAokdakFYj1SvsqOw9cqH8IN7B0htHScWmjCsWtOPo+JNo04tK9F9RSk
	HV2sL9sz4TLNhWJMZUtxAVfFSzniHI7N8s7Hw+CTqfhrvWTR/I6cV6OJDs6irdXlfYXU5d
	g64P2A9sWXZ+agtqSp1qobz1vriOtTkkdh55cEuDaLRl6tWBL/nruSsvkCSqtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rNJDVzdEQR1XApdNl2anre1c4jIQklDJ/w+w9BbSv4M=;
	b=N8lA2TPT9N+n3Mn9hVLz4u3/BDGj5l9AiEfbkLTh1O/Hf3jLNtcL15PlpWnO5j7Fxk0u3w
	SGWlX2GSj+F0/8Bg==
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
Subject: [PATCH v10 00/21] futex: Add support task local hash maps, FUTEX2_NUMA and FUTEX2_MPOL
Date: Wed, 12 Mar 2025 16:16:13 +0100
Message-ID: <20250312151634.2183278-1-bigeasy@linutronix.de>
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

This is the local hash map series based on v9 extended with PeterZ
FUTEX2_NUMA and FUTEX2_MPOL plus a few fixes on top.

The complete tree is at
	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git/log/?h=
=3Dfutex_local_v10
	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git futex_=
local_v10

v9=E2=80=A6v10: https://lore.kernel.org/all/20250225170914.289358-1-bigeasy=
@linutronix.de/
  - The rcuref_read() check in __futex_hash_private() has been replaced
    with rcuref_is_dead() which is added as part of the series.

  - The local hash support depended on !CONFIG_BASE_SMALL which has been
    replaced with CONFIG_FUTEX_PRIVATE_HASH. This is defined as
    "!BASE_SMALL && MMU" because as part of the rework
    futex_key::private::mm is used which is not set on !CONFIG_MMU builds

  - Added CONFIG_FUTEX_MPOL to build on !NUMA configs.

  - Replaced direct access of mm_struct::futex_phash with a RCU
    accessor.
=20
  - futex_hash_allocate() for !CONFIG_FUTEX_PRIVATE_HASH returns an
    error. This does not affect fork() but is noticed by
    PR_FUTEX_HASH_SET_SLOTS.

  - futex_init() ensures the computed hashsize is not less than 4 after
    the divide by num_possible_nodes().

  - futex_init() added info output about used hash table entries (in the
    global hash) and occupied memory, allocation method. This vanished
    after the removal of alloc_large_system_hash().

  - There is a WARN_ON again in futex_hash_free() path if the task
    failed to free all references (that would be a leak).

  - vmalloc_huge_node_noprof():
    - Replced __vmalloc_node_range() with __vmalloc_node_range_noprof()
      to skip the alloc_hooks() layer which is already part of
      vmalloc_huge_node().
    - Added vmalloc_huge_node_noprof for !MMU.

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

Peter Zijlstra (11):
  futex: Move futex_queue() into futex_wait_setup()
  futex: Pull futex_hash() out of futex_q_lock()
  futex: Create hb scopes
  futex: Create futex_hash() get/put class
  futex: s/hb_p/fph/
  futex: Remove superfluous state
  futex: Untangle and naming
  futex: Rework SET_SLOTS
  mm: Add vmalloc_huge_node()
  futex: Implement FUTEX2_NUMA
  futex: Implement FUTEX2_MPOL

Sebastian Andrzej Siewior (10):
  rcuref: Provide rcuref_is_dead().
  futex: Create helper function to initialize a hash slot.
  futex: Add basic infrastructure for local task local hash.
  futex: Hash only the address for private futexes.
  futex: Allow automatic allocation of process wide futex hash.
  futex: Decrease the waiter count before the unlock operation.
  futex: Introduce futex_q_lockptr_lock().
  futex: Acquire a hash reference in futex_wait_multiple_setup().
  futex: Allow to re-allocate the private local hash.
  futex: Resize local futex hash table based on number of threads.

 include/linux/futex.h      |  34 +-
 include/linux/mm_types.h   |   7 +-
 include/linux/mmap_lock.h  |   4 +
 include/linux/rcuref.h     |  22 +-
 include/linux/vmalloc.h    |   3 +
 include/uapi/linux/futex.h |  10 +-
 include/uapi/linux/prctl.h |   5 +
 init/Kconfig               |  10 +
 io_uring/futex.c           |   4 +-
 kernel/fork.c              |  24 ++
 kernel/futex/core.c        | 746 +++++++++++++++++++++++++++++++++----
 kernel/futex/futex.h       |  81 +++-
 kernel/futex/pi.c          | 300 ++++++++-------
 kernel/futex/requeue.c     | 480 ++++++++++++------------
 kernel/futex/waitwake.c    | 203 +++++-----
 kernel/sys.c               |   4 +
 mm/nommu.c                 |   5 +
 mm/vmalloc.c               |   7 +
 18 files changed, 1396 insertions(+), 553 deletions(-)

--=20
2.47.2


