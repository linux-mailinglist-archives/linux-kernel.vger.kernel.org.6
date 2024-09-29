Return-Path: <linux-kernel+bounces-342827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04498935C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4061C2326E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A3135A69;
	Sun, 29 Sep 2024 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/zfXq1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0A10A0E
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727593839; cv=none; b=ZJEROwoGPronaMsMwDZLf7noRTAgISkLCWQ8BL0Vjh1QoTqp5eArlzQ9ow7A7TzxrasjCqXgB09P8AkpuoOvh987pGzJJ/R3302l9GGF7mu8xm9owhw4ux1ZPYsD67ofYuoEJeNIG/1CKYRE5Zdaa2E6I2UzWDcRawcbPyAkyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727593839; c=relaxed/simple;
	bh=FskdysbjbzPl2+Zfs0w9wco9K1Pbpe3XjdZCLLE2Wzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dPg0OGsRE9xLDkrQSqbqbdYvi13pYwTDAM18y8ugpad81r/ojWDPyPRH1DfCy3mj9QRRbkHSOPSXCVuxM+pjctmmk0gZLh8pHRRfwk0+Bn4iwswjIqdhMm2CFO0wDzDVI3TnFgjd5rLA4Jc2dpa//kA9R+LIMR3PG7UR09ccMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/zfXq1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BDDC4CEC5;
	Sun, 29 Sep 2024 07:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727593838;
	bh=FskdysbjbzPl2+Zfs0w9wco9K1Pbpe3XjdZCLLE2Wzg=;
	h=Date:From:To:Cc:Subject:From;
	b=d/zfXq1EPurF17+FbAN37rAS2GbVQxKBKFHEmFmcAzWt99tYGXcG9Gs7trD0EsL+q
	 LE2DyVl+96hRfYCyUsCJNewNOyP1Z47bWHHpywTimtZei+qGJdJFXRJH+cOTGxFCuc
	 wmagZcgmmfpWaCj17w13896Klsqz4JNd8/Ky+aYToCB5Il6gqZCV7LDZiiBl3GMqm9
	 kCk01+5m4wpmLYhmkPk1JkSvhJkMc17AI4qPwYkmi/DuBkiUxYRO7rTsmlNfNup9Ov
	 nEhXxdygPfChV2v4h/a0VW4WZU+NdLWdl/CPI0k7MECiqqAkbmoeYpNCjxk7vuh/iK
	 V0SomEzOc1bTg==
Date: Sun, 29 Sep 2024 09:10:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking changes for v6.12
Message-ID: <Zvj9aYsNdWNGJbed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest locking/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-09-29

   # HEAD: ae39e0bd150bd2739582f72ad70b5a0b15e74576 Merge branch 'locking/core' into locking/urgent, to pick up pending commits

Locking changes for v6.12:

 - lockdep:
    - Fix potential deadlock between lockdep and RCU (Zhiguo Niu)
    - Use str_plural() to address Coccinelle warning (Thorsten Blum)
    - Add debuggability enhancement (Luis Claudio R. Goncalves)

 - static keys & calls:
    - Fix static_key_slow_dec() yet again (Peter Zijlstra)
    - Handle module init failure correctly in static_call_del_module() (Thomas Gleixner)
    - Replace pointless WARN_ON() in static_call_module_notify() (Thomas Gleixner)

 - <linux/cleanup.h>:
    - Add usage and style documentation (Dan Williams)

 - rwsems:
    - Move is_rwsem_reader_owned() and rwsem_owner() under CONFIG_DEBUG_RWSEMS (Waiman Long)

 - atomic ops, x86:
    - Redeclare x86_32 arch_atomic64_{add,sub}() as void (Uros Bizjak)
    - Introduce the read64_nonatomic macro to x86_32 with cx8 (Uros Bizjak)

 Thanks,

	Ingo

------------------>
Dan Williams (1):
      cleanup: Add usage and style documentation

Luis Claudio R. Goncalves (1):
      lockdep: suggest the fix for "lockdep bfs error:-1" on print_bfs_bug

Markus Elfring (1):
      locking/lockdep: Simplify character output in seq_line()

Peter Zijlstra (1):
      jump_label: Fix static_key_slow_dec() yet again

Thomas Gleixner (2):
      static_call: Handle module init failure correctly in static_call_del_module()
      static_call: Replace pointless WARN_ON() in static_call_module_notify()

Thorsten Blum (1):
      lockdep: Use str_plural() to fix Coccinelle warning

Uros Bizjak (2):
      locking/atomic/x86: Introduce the read64_nonatomic macro to x86_32 with cx8
      locking/atomic/x86: Redeclare x86_32 arch_atomic64_{add,sub}() as void

Waiman Long (1):
      locking/rwsem: Move is_rwsem_reader_owned() and rwsem_owner() under CONFIG_DEBUG_RWSEMS

Zhiguo Niu (1):
      lockdep: fix deadlock issue between lockdep and rcu


 Documentation/core-api/cleanup.rst |   8 +++
 Documentation/core-api/index.rst   |   1 +
 arch/x86/include/asm/atomic64_32.h |   6 +-
 arch/x86/lib/atomic64_cx8_32.S     |   9 ++-
 include/linux/cleanup.h            | 136 +++++++++++++++++++++++++++++++++++++
 kernel/jump_label.c                |  34 ++++++++--
 kernel/locking/lockdep.c           |  55 ++++++++++-----
 kernel/locking/lockdep_proc.c      |   2 +-
 kernel/locking/rwsem.c             |  22 +++---
 kernel/static_call_inline.c        |  13 +++-
 10 files changed, 241 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/core-api/cleanup.rst

