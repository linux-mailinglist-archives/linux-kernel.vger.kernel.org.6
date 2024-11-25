Return-Path: <linux-kernel+bounces-420811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D839D8358
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA918B23697
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80F01917F9;
	Mon, 25 Nov 2024 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MifKZJkE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77314375C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530068; cv=none; b=ZD/snoIg1uMENcxIez+UJ9Nq1BXZ11fCiFMa5y39WuANmnhqNQzEm6n9jfSHiUMovp1qAzJiGYEH1e/N9SiJ+D0qC2bTvGGs+xilyWt40SvffC8Z8qbyoTvD/r6XJWMKEp3VLP4OMIFCeeF1r4TiDBCpXMdo8uEUhLi+vDbSuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530068; c=relaxed/simple;
	bh=xpvBYbkskz9nfzZeBeLFJGvW3z7Q9Lc5XNvoSkh4TFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kP6rxvuQkdlOBYkiPSGw1GxkMzDsJqwrhgYmmwMcWnXKkVokPSEOTHU9PfwBmYR4TG1tC9l6JtofsEeH6821fnpXwn+ZQMk0qqoMOcjakAYNEyqkZ9CpCPrtBkioCXAB8z0S83WP8Mtd71cd7c1OXUbIfjF59D1YQkW2QVcL5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MifKZJkE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732530065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n67Q0KoljJvBSt9cf1LGCKowbJla5BRsh7Nzu+TSZUQ=;
	b=MifKZJkEV17oDxzYALKNMwPNmT1EAcOAL1epwACmksWK/C+96vASp7po9RRAhp+0BF6PZx
	aWsGfz/nld5QVWEzUoly8eUNp/SWg+PEP6ruyFVfJLarT1gUYehN7mpQYyc3jh5u2s0MYc
	RwNDkII3y334MlXkKJqoMaXi18UHNj0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-nenB_5tyPBenD1nLgp1IkQ-1; Mon,
 25 Nov 2024 05:21:01 -0500
X-MC-Unique: nenB_5tyPBenD1nLgp1IkQ-1
X-Mimecast-MFC-AGG-ID: nenB_5tyPBenD1nLgp1IkQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29BCC19560A1;
	Mon, 25 Nov 2024 10:21:00 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8907E1956052;
	Mon, 25 Nov 2024 10:20:58 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes for 6.13
Date: Mon, 25 Nov 2024 11:20:56 +0100
Message-ID: <20241125102057.1505150-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Dear Linus,

please consider pulling the following gfs2 changes.

The top two commits have only been added to for-next a couple of days ago; they
fix a NULL pointer dereference in a previous patch in this pull request and an
unlikely race in the same code.  These fixes have passed several days of heavy
testing, so I hope you can agree to including them.

Thanks,
Andreas

The following changes since commit 721068dec4ec3cc625d8737d4dfa0ff0aa795cd1:

  Merge tag 'gfs2-v6.10-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2024-09-23 11:55:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.13

for you to fetch changes up to ffd1cf0443a208b80e40100ed02892d2ec74c7e9:

  gfs2: Prevent inode creation race (2024-11-19 13:05:41 +0100)

----------------------------------------------------------------
gfs2 changes

- Fix the code that cleans up left-over unlinked files.  Various fixes
  and minor improvements in deleting files cached or held open remotely.

- Simplify the use of dlm's DLM_LKF_QUECVT flag.

- A few other minor cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (20):
      gfs2: Rename GLF_VERIFY_EVICT to GLF_VERIFY_DELETE
      gfs2: Initialize gl_no_formal_ino earlier
      gfs2: Allow immediate GLF_VERIFY_DELETE work
      gfs2: Fix unlinked inode cleanup
      gfs2: Faster gfs2_upgrade_iopen_glock wakeups
      gfs2: Rename GIF_{DEFERRED -> DEFER}_DELETE
      gfs2: Rename dinode_demise to evict_behavior
      gfs2: Return enum evict_behavior from gfs2_upgrade_iopen_glock
      gfs2: Minor delete_work_func cleanup
      gfs2: Clean up delete work processing
      gfs2: Call gfs2_queue_verify_delete from gfs2_evict_inode
      gfs2: Update to the evict / remote delete documentation
      gfs2: Use mod_delayed_work in gfs2_queue_try_to_evict
      gfs2: Randomize GLF_VERIFY_DELETE work delay
      gfs2: Use get_random_u32 in gfs2_orlov_skip
      gfs2: Make gfs2_inode_refresh static
      gfs2: gfs2_evict_inode clarification
      gfs2: Simplify DLM_LKF_QUECVT use
      gfs2: Only defer deletes when we have an iopen glock
      gfs2: Prevent inode creation race

Qianqiang Liu (1):
      KMSAN: uninit-value in inode_go_dump (5)

 fs/gfs2/glock.c    | 107 ++++++++++++++++++++---------------------------------
 fs/gfs2/glock.h    |   7 ++++
 fs/gfs2/glops.c    |  11 +++++-
 fs/gfs2/incore.h   |   4 +-
 fs/gfs2/inode.c    |   1 +
 fs/gfs2/inode.h    |   2 -
 fs/gfs2/lock_dlm.c |  29 +++++++++++++--
 fs/gfs2/rgrp.c     |   6 +--
 fs/gfs2/super.c    |  89 +++++++++++++++++++++++++++-----------------
 9 files changed, 142 insertions(+), 114 deletions(-)


