Return-Path: <linux-kernel+bounces-178094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0858C489C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA7B1C22972
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D1823DE;
	Mon, 13 May 2024 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnXgKESc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D71DA24
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634224; cv=none; b=rheV33gAlGQpumCZ95fgyWPtC9Fgnc4DHUUGrcLAd5LaFr1xf3I0fYrx7f8Q+tBe8POIedrRHtGkfInkgScvz6CgUQPyrx4WICfw5AcaatqyjYRbCK93phmHaeV3OU/hp558SEAcWZO6c9GhPou6MrJ9tGNs78DwOnaFkZbc7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634224; c=relaxed/simple;
	bh=HiwC2bKxB/U/6um4ESDuKUD7lh7rgfVXd6Bl+3V41gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u88jGFCNLTnUDyFwyLbzFIJtTvu1Hg/rk9/8cVtvJJ5779ujUHqOInUOsUPaP9MAZai13jyKjI/HTi8bfFkL4J8wX4VClrCWxCz38QXro32ixVeGLj+dsp8Ho5tzLt/ML4/9WdfWWT+G9SdSVFl2z2v0wHnEMHozIHvLs4Ab/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnXgKESc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715634221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9AkGGxHIWYuxso5CESSirZUJ8cTJaRF5x1BvBc0yg7M=;
	b=RnXgKEScdVW/cySx7vzDvmvhuY7hPpVkfJKdNIHYCi/Oj/NA8gNCXU/XD3pgVRtcZPdoWY
	XTtpRmBK3UoV104W7Hcdz3ekZzu+w/0cA+HwvQD8yNwbAMsjU6vDbh94eu5ct9hfo7n8Da
	0rcRNm9ILL8pivIgOGXoy2cQSVfEbHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-qnMNJoKLMmmCcD6sxC-egw-1; Mon, 13 May 2024 17:03:40 -0400
X-MC-Unique: qnMNJoKLMmmCcD6sxC-egw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB8AE101A525;
	Mon, 13 May 2024 21:03:39 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 096231BA2;
	Mon, 13 May 2024 21:03:38 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes
Date: Mon, 13 May 2024 23:03:36 +0200
Message-ID: <20240513210338.267167-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hello Linus,

please consider pulling the following gfs2 changes.

Thank you very much,
Andreas

The following changes since commit c95346ac918c5badf51b9a7ac58a26d3bd5bb224:

  gfs2: Fix invalid metadata access in punch_hole (2024-03-11 17:11:18 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-v6.10

for you to fetch changes up to c1c53c26e3380a79b65e6b53dac6c3c797a7e8f1:

  gfs2: make timeout values more explicit (2024-05-07 12:42:48 +0200)

----------------------------------------------------------------
gfs2 updates

- Properly fix the glock shrinker this time: it broke in commit "gfs2:
  Make glock lru list scanning safer" and commit "gfs2: fix glock
  shrinker ref issues" wasn't actually enough to fix it.

- On unmount, keep glocks around long enough that no more dlm callbacks
  can occur on them.

- Some more folio conversion patches from Matthew Wilcox.

- Lots of other smaller fixes and cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (21):
      gfs2: Get rid of newlines in log messages
      gfs2: Remove unnecessary gfs2_meta_check_ii argument
      gfs2: Follow-up to flag rename in sysfs status file
      gfs2: Use [NO_]CREATE consistently for gfs2_glock_get
      gfs2: Don't forget to complete delayed withdraw
      gfs2: Fix NULL pointer dereference in gfs2_log_flush
      gfs2: Get rid of gfs2_glock_queue_put in signal_our_withdraw
      gfs2: Replace gfs2_glock_queue_put with gfs2_glock_put_async
      gfs2: Don't set GLF_LOCK in gfs2_dispose_glock_lru
      gfs2: Get rid of unnecessary test_and_set_bit
      gfs2: Fix "ignore unlock failures after withdraw"
      Revert "gfs2: fix glock shrinker ref issues"
      gfs2: Fix "Make glock lru list scanning safer"
      gfs2: Fix lru_count accounting
      gfs2: Remove ill-placed consistency check
      gfs2: Fix potential glock use-after-free on unmount
      gfs2: Unlock fewer glocks on unmount
      gfs2: finish_xmote cleanup
      gfs2: do_xmote fixes
      gfs2: Remove and replace gfs2_glock_queue_work
      gfs2: gfs2_freeze_unlock cleanup

Andrew Price (1):
      gfs2: Improve gfs2_consist_inode() usage

Matthew Wilcox (Oracle) (4):
      gfs2: Convert gfs2_page_mkwrite() to use a folio
      gfs2: Simplify gfs2_read_super
      gfs2: Add a migrate_folio operation for journalled files
      gfs2: Convert gfs2_aspace_writepage() to use a folio

Wolfram Sang (1):
      gfs2: make timeout values more explicit

 fs/gfs2/aops.c       |   4 +-
 fs/gfs2/bmap.c       |   2 +-
 fs/gfs2/dir.c        |  31 +++++----
 fs/gfs2/file.c       |  59 ++++++++--------
 fs/gfs2/glock.c      | 192 +++++++++++++++++++++++++++++++--------------------
 fs/gfs2/glock.h      |   3 +-
 fs/gfs2/glops.c      |  37 ++++++----
 fs/gfs2/incore.h     |   1 +
 fs/gfs2/lock_dlm.c   |  40 ++++++++---
 fs/gfs2/log.c        |   5 +-
 fs/gfs2/meta_io.c    |  16 ++---
 fs/gfs2/ops_fstype.c |  49 ++++---------
 fs/gfs2/rgrp.c       |  10 +--
 fs/gfs2/super.c      |  28 ++++----
 fs/gfs2/sys.c        |   4 +-
 fs/gfs2/util.c       |  63 ++++++++---------
 fs/gfs2/util.h       |   6 +-
 fs/gfs2/xattr.c      |  28 ++++----
 18 files changed, 320 insertions(+), 258 deletions(-)


