Return-Path: <linux-kernel+bounces-570350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16E0A6AF34
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C0E188A49D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B7C20E704;
	Thu, 20 Mar 2025 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyLPGMi4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49D227586
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502659; cv=none; b=brI+7V3nor94sFB3yhNmQaEKQ2ewV44kG4u4V7d0KWs5JeIn/k/zN0uBZZMQm5T7Gt/yPpBVPCYE6XaRcdc4Xlxu2ogQtH1auy0HJyv/tShFyJfCNJ2i2WPOulHUXJXpOXisswqDRlgVUu7262JM4drpe/+TeDbx19Q/gTX1RBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502659; c=relaxed/simple;
	bh=3vKVUOAvupLA0mpNKXW+Sc1D/4ps/fG+Yq+Yl5TsQc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWcQqvIAlK8Igh44RSxB9HQGF3eO8BhUzKLyDhb/stez83huXxoYE59qAx0DUrhMeDl9wBSRwvl6jNoTMP13bznPafxS3NWyMw2t+ZKw9lddEgBoiUDUigPFj+8XGLKBDsj+G0Vu2baepB4nOlT+PJtLWnPH77sL8HcUK8ELS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyLPGMi4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742502657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Vp4d4//9B8RSPZQ7UNS+PFpi1LfeyB7WXn9sDdC7J8=;
	b=GyLPGMi4Yrmel9aAkjpig6mEDcDH/vH5B22/gwD7teqD/mS1Bqz3iv6kKR48uPIARnGfe/
	nDWS2L1/6JBLVg0Muk/IsZv43LZDnHpw85Hsrq6o9KySQyZITipm7WiCvB+AnjeIjoXL48
	3OT/Rwwr+OZUwTUw7GqgdWrlSIJROeM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-1EvaqPrxOc-O1IUY13uENg-1; Thu,
 20 Mar 2025 16:30:53 -0400
X-MC-Unique: 1EvaqPrxOc-O1IUY13uENg-1
X-Mimecast-MFC-AGG-ID: 1EvaqPrxOc-O1IUY13uENg_1742502652
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F8CB19560BB;
	Thu, 20 Mar 2025 20:30:52 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.15])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3953819560AF;
	Thu, 20 Mar 2025 20:30:49 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 6.15
Date: Thu, 20 Mar 2025 21:30:46 +0100
Message-ID: <20250320203048.2483603-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Dear Linus,

please consider pulling the following gfs2 changes for 6.15.

Thanks,
Andreas

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.15

for you to fetch changes up to 8cb70b91b20a591a543394a7ee1d792b830e2dac:

  gfs2: some comment clarifications (2025-03-18 13:21:39 +0100)

----------------------------------------------------------------
gfs2 changes

- Fix two bugs related to locking request cancelation (locking request
  being retried instead of canceled; canceling the wrong locking
  request).

- Prevent a race between inode creation and deferred delete analogous
  to commit ffd1cf0443a2 from 6.13.  This now allows to further simplify
  gfs2_evict_inode() without introducing mysterious problems.

- When in inode delete should be verified / retried "later" but that
  isn't possible, skip the delete instead of carrying it out
  immediately.  This broke in 6.13.

- More folio conversions from Matthew Wilcox (plus a fix from Dan
  Carpenter).

- Various minor fixes and cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (13):
      gfs2: Decode missing glock flags in tracepoints
      gfs2: Add GLF_PENDING_REPLY flag
      gfs2: glock holder GL_NOPID fix
      gfs2: Replace GIF_DEFER_DELETE with GLF_DEFER_DELETE
      gfs2: Remove more dead code in add_to_queue
      gfs2: Check for empty queue in run_queue
      gfs2: Fix request cancelation bug
      gfs2: Fix additional unlikely request cancelation race
      gfs2: Prevent inode creation race (2)
      gfs2: minor evict fix
      gfs2: remove redundant warnings
      gfs2: skip if we cannot defer delete
      gfs2: some comment clarifications

Dan Carpenter (1):
      gfs2: Fix a NULL vs IS_ERR() bug in gfs2_find_jhead()

Matthew Wilcox (Oracle) (8):
      gfs2: Use b_folio in gfs2_log_write_bh()
      gfs2: Use b_folio in gfs2_trans_add_meta()
      gfs2: Use b_folio in gfs2_submit_bhs()
      gfs2: Use b_folio in gfs2_check_magic()
      gfs2: Convert gfs2_jhead_pg_srch() to gfs2_jhead_folio_search()
      gfs2: Convert gfs2_find_jhead() to use a folio
      gfs2: Convert gfs2_end_log_write_bh() to work on a folio
      gfs2: Convert gfs2_meta_read_endio() to use a folio

 fs/gfs2/file.c              |   8 +--
 fs/gfs2/glock.c             | 124 +++++++++++++++++++++++---------------------
 fs/gfs2/incore.h            |   4 +-
 fs/gfs2/lops.c              |  78 ++++++++++++++--------------
 fs/gfs2/meta_io.c           |  15 +++---
 fs/gfs2/super.c             |  24 +++------
 fs/gfs2/trace_gfs2.h        |  10 +++-
 fs/gfs2/trans.c             |   4 +-
 include/linux/buffer_head.h |   1 -
 9 files changed, 136 insertions(+), 132 deletions(-)


