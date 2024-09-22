Return-Path: <linux-kernel+bounces-335151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB697E1EF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4355028149F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B904A2C;
	Sun, 22 Sep 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJ5bcDg3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DED33C8
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727013657; cv=none; b=MdnB4y9uhKYcwRNmR2F62x2gu/uiMiszkqGML54DAXPdPpzMY3TRKCMOSwI56Cn2liIfQNg7H4KXzYFv7IbgTmb62N41RT3bobQoEHUuBcKab20zakmcrcwO+SGXMfbuFLRe+0okc0qrtn3t9O7+gXhSs2nULsWSxyP8KD8p/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727013657; c=relaxed/simple;
	bh=2MgBjh60/jTcVqxJi9DAm7CzsRRTTWx9s2Rl9CdWtlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNdHplt8JNeBTijKOjdzob7koxl0nHK8TCZeW1cLg5Pz4qovikQ7zDyowUjV/B+blOTRlj2bInYvw/731jimQNc0LmbVd5t2gFINykG4rMgtjmwqK/Easp85sFvzXTe8M663JRgA3T7j1PmvWnj4Cj02RsozpLE3zr5kTsP6eoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJ5bcDg3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727013653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BGRZkrAJfPSnfkrlnJKN+UoV9mMX8K/tZ5mnh589us4=;
	b=PJ5bcDg31IOXqvQGQKz4ezZpzmrAI8FszFKzuOKnP/5mn9V8wl9BuxuwEDW4aL4t8LbPai
	HVZbBm3lftImZFTuKbxq2MICkkF92+GcImJa+Og0p2rQ+VLHELRTfSw5uz5VAmeHu6yvPK
	qdv978qWq21llg8exuLXFg1McY9RcH4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-4Z_t1y4vNMiJY7nHQPCNCw-1; Sun,
 22 Sep 2024 10:00:51 -0400
X-MC-Unique: 4Z_t1y4vNMiJY7nHQPCNCw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83472190ECF1;
	Sun, 22 Sep 2024 14:00:50 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC0BC19560A3;
	Sun, 22 Sep 2024 14:00:48 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes
Date: Sun, 22 Sep 2024 16:00:46 +0200
Message-ID: <20240922140047.261100-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Dear Linus,

please consider pulling the following gfs2 fixes and cleanups:

* The first 15 of these patches rework the glock refcounting and LRU list
  handling to be more sensible.

* The following 13 patches clean up the quota code, add some missing locking,
  and work around the on-disk corruption that the reverted patch "gfs2: ignore
  negated quota changes" causes.

* The final patch cleans up the glock demote logic in glock_work_func().

Thanks,
Andreas


The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-rc1-fixes

for you to fetch changes up to f75efefb6db305b5b5c56a9b9ae2d72b54f20780:

  gfs2: Clean up glock demote logic (2024-07-09 10:40:03 +0200)

----------------------------------------------------------------
gfs2 fixes and cleanups

- Revise the glock reference counting model

- Several quota related fixes

- Clean up the glock demote logic

----------------------------------------------------------------
Andreas Gruenbacher (29):
      gfs2: Remove unnecessary function prototype
      gfs2: Remove useless return statement in run_queue
      gfs2: Rename GLF_FREEING to GLF_UNLOCKED
      gfs2: Rename GLF_REPLY_PENDING to GLF_HAVE_REPLY
      gfs2: Rename GLF_FROZEN to GLF_HAVE_FROZEN_REPLY
      gfs2: Rename handle_callback to request_demote
      gfs2: Update glocks documentation
      gfs2: Remove outdated comment in glock_work_func
      gfs2: Invert the GLF_INITIAL flag
      gfs2: gfs2_glock_get cleanup
      gfs2: Report when glocks cannot be freed for a long time
      gfs2: Switch to a per-filesystem glock workqueue
      gfs2: Revise glock reference counting model
      Revert "GFS2: Don't add all glocks to the lru"
      gfs2: Get rid of demote_ok checks
      gfs2: Minor gfs2_quota_init error path cleanup
      gfs2: Check quota consistency on mount
      gfs2: Revert "introduce qd_bh_get_or_undo"
      gfs2: qd_check_sync cleanups
      gfs2: Revert "ignore negated quota changes"
      gfs2: Revert "Add quota_change type"
      gfs2: Fix and clean up function do_qc
      gfs2: quota need_sync cleanup
      gfs2: Fold qd_fish into gfs2_quota_sync
      gfs2: Add some missing quota locking
      gfs2: Get rid of some unnecessary quota locking
      gfs2: Be more careful with the quota sync generation
      gfs2: Revert "check for no eligible quota changes"
      gfs2: Clean up glock demote logic

 Documentation/filesystems/gfs2-glocks.rst |  55 ++---
 fs/gfs2/glock.c                           | 227 ++++++++---------
 fs/gfs2/glock.h                           |   1 -
 fs/gfs2/glops.c                           |  42 +---
 fs/gfs2/incore.h                          |  12 +-
 fs/gfs2/lock_dlm.c                        |  28 ++-
 fs/gfs2/ops_fstype.c                      |  13 +-
 fs/gfs2/quota.c                           | 388 +++++++++++++++---------------
 fs/gfs2/super.c                           |   1 -
 fs/gfs2/trace_gfs2.h                      |   6 +-
 fs/gfs2/util.c                            |  12 +-
 11 files changed, 380 insertions(+), 405 deletions(-)


