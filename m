Return-Path: <linux-kernel+bounces-253872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390FF93281F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0529B2382C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77819B593;
	Tue, 16 Jul 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OaOpBJ33";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vrdbqVSa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78431DFD0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139604; cv=none; b=cTubMZZ6z/nZppo50KTzMdhRqud0aQkYg/3cSDrwOCyBwWohu7K8RUN5IFqUgYbYh9dOg0zX1y4cTwy/u2PccK8As1b9/ggvfAV7xKGs8CU5c4GawsoxUyu3DgHwEHZDZqM7vMqFUdxc4GXYOBo4sgDrB0YJ5a22TQ5KgURGT5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139604; c=relaxed/simple;
	bh=NOyrcK+jPKs6RTi+GoGFILQ1SLSVeT8ntJjF8tcjqKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bWXK2lDo7P2y2ZSggZfiAr2x55h8PdVlk1bcR56yEh1FNxXFdpihP/1C05/GP6OknDz5oFwa22GoHbFnyCt4B8CDuVeISMYqwuqTCAVR452JrwqwNKS/VUdt1+DJzmZUGgykiRALwVGMGZnX53WGpQevITnZZIktdspHeFvTlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OaOpBJ33; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vrdbqVSa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721139597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x3DfrBgycvL7yQA8Ei9DqIEzapg+DerhoCG4UjvLmXI=;
	b=OaOpBJ33s8xvB3qdMQIrPj7cP9AcQGymUJhUE9s733Xrcn7/jr0T5cVvD3BLn21WWCJs0M
	0Xu4tF85goOtei52pFSoTItMxrAlyNlDvZump0bqfpcxgB9Us6rrtMp4YtwztCzrEHF2m8
	kgcFJ+779UXAnCrv/VD2j5Pw+58WAuHWkQBC8F4eg/GAwJucKbvX1ufPrCm7iGsJ7VUJz6
	nJUH/Q2Ez2PjQ12NOHnX9f+Hu2YsfCYUQfoRLA6bFNui5w9tOgHVs5y+UVKcAj5ySX6klp
	HwC4/BOlxKcDKAAsoRAvuqhYFAYKBzvR+6Y0IMFUFeCH1Pphel0wNfSyFK0UIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721139597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x3DfrBgycvL7yQA8Ei9DqIEzapg+DerhoCG4UjvLmXI=;
	b=vrdbqVSakwRf+kAoFMWgRT5QsuMNYlfOp3HqoFvNlvRIkT4UwD631SxzOj+QPvvtDPc0C/
	78nn55NMtThU23BA==
Subject: [PATCH v4 0/8] timers/migration: Fix three possible races and some
 improvements
Date: Tue, 16 Jul 2024 16:19:18 +0200
Message-Id: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGaBlmYC/23NQQ6CMBAF0KuQrq1ppwWqK+9hXEA7wCQKpkWCI
 dzdwkYlLP+fvD8TC+gJAzsnE/M4UKCujUEfEmaboq2Rk4uZgQAtMpC8f1DteUUjBu7AprICLU/
 asiieHtdDBNdbzA2FvvPvdXyQS7u/M0guuLGmAGfQuDy/3Kl99b5raTw6ZMvWAL9e/3uIXmGpr
 ciEzk9iz6uvz8Xmv4oeUutSh0qaqtz6eZ4/882seCoBAAA=
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

Borislav reported a warning in timer migration deactive path

  https://lore.kernel.org/r/20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local

Sadly it doesn't reproduce directly. But with the change of timing (by
adding a trace prinkt before the warning), it is possible to trigger the
warning reliable at least in my test setup. The problem here is a racy
check agains group->parent pointer. This is also used in other places in
the code and fixing this racy usage is adressed by the first patch.

There were two other races reported by Frederic in setup path:

  https://lore.kernel.org/r/ZnWOswTMML6ShzYO@localhost.localdomain

  https://lore.kernel.org/r/ZnoIlO22habOyQRe@lothringen

Those races are both is addressed by the change of patch 2.

Some updates/cleanups are provided by patch 3-8. ("timers/migration:
Improve tracing" and "timers/migration: Spare write when nothing changed"
are the same as provided by v2).

Patches are available here:

  https://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/misc

---
Changes in v4:
- Update Patch 2: Fix broken cpuhp_setup_state() call for prepare
- Update Patch 2: Activate child during setup only when it is an already
  existing group
- Update Patch 2: Change init into early_initcall() to make usage of
  preparation by an already active CPU.
- Update Patch 2: Move initialization of tmc in tmigr_cpu_prepare() before
  using data of tmc (e.g. by a tracepoint)
- Update Patch 5: Use proper childmask for tmigr_walk in __walk_groups()
- Update Patch 6: Fix missing update of s/childmask/groupmask in
  connect_[cpu|child]_parent tracepoint and update to change of Patch 5
- Link to v3: https://lore.kernel.org/r/20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de

Changes in v3:
- Address the new reported possible race (childmask and parent pointer)
  together with the existing race (both reported by Frederic).
- New cleanup: Two patches to access childmask and parent pointer only in
  one place
- New cleanup: Rename childmask to parentmask as during discussions there
  was some kind of confusion because of the naming
- New cleanup: Fix typo
- Fix prefix in all patches (s$timer_migration$timers/migration$)
- Link to v2: https://lore.kernel.org/r/20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de

Changes in v2:
- Address another possible race in setup code (reported by Frederic) and
  recycle therefore one improvement patch
- Change order and move the already existing improvement patch to the end
  of the queue
- Existing patches didn't change
- Link to v1: https://lore.kernel.org/r/20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de

Thanks,

        Anna-Maria

---
Anna-Maria Behnsen (8):
      timers/migration: Do not rely always on group->parent
      timers/migration: Move hierarchy setup into cpuhotplug prepare callback
      timers/migration: Improve tracing
      timers/migration: Use a single struct for hierarchy walk data
      timers/migration: Read childmask and parent pointer in a single place
      timers/migration: Rename childmask by groupmask to make naming more obvious
      timers/migration: Spare write when nothing changed
      timers/migration: Fix grammar in comment

 include/linux/cpuhotplug.h             |   1 +
 include/trace/events/timer_migration.h |  16 +-
 kernel/time/timer_migration.c          | 383 ++++++++++++++++-----------------
 kernel/time/timer_migration.h          |  27 ++-
 4 files changed, 214 insertions(+), 213 deletions(-)


