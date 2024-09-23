Return-Path: <linux-kernel+bounces-336172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7C97F018
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCF01C215F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90019E98E;
	Mon, 23 Sep 2024 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVKpdzI2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759F18052
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114681; cv=none; b=ox7TeKv9AO00P13kawsPixZJGtYRp8Z/ZhAWOXz/DIGCPagWO/6PineYPxxbbG9ysr61rY6HdOAO4QUMLKyj9aE0mEZefhHLHOzE0Wxl+k3gxs4JhkRJk8XuqIddTPfnn7aVunlz5okwiAl1r1yvoZZ0c23BVtEwd6SnXhgvVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114681; c=relaxed/simple;
	bh=EZHCrKzxbPNEXtJuwznFWUbHe1GuS0ZswjOMle0CaFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiN8QxhETmRyA07h1NgX8/LHqyJyS6mjc7HqmAC6p3ieUdV43ys6ELvkjRvnHcxd8w0v4v44O3a5IkJs42eemXcO3fWTfOK8n921U9U/29Vd7z+UpLlJy2aqSZ5Ffmr2E83Q7f81Lyb1av3dU3VPUvMfxDrOjdEr9ILfs+zoilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVKpdzI2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727114678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4zk2H1hCENikiPreGuVpe9tmODe6t3h9N4bM5aN33PM=;
	b=LVKpdzI2rf01THFZYxGezsWDGC46RoV4OJkRLFgqfHPVSvOxjHz0OsvIlPUJMl/mgpKv9o
	Ff3hjm+LDqX9w6/yMtYCndAbWUEH7yGR1Y/lvVWwuS3+7cO77ZK2JoA8o8Vlhqhsrxo640
	j9UDyb9TtzV3e8XizlChStGmEhCuNHc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-swlbcMiON5ef1CIK3F8CtA-1; Mon,
 23 Sep 2024 14:04:36 -0400
X-MC-Unique: swlbcMiON5ef1CIK3F8CtA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF4EF1911B0E;
	Mon, 23 Sep 2024 18:04:35 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33C9919560A3;
	Mon, 23 Sep 2024 18:04:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 changes
Date: Mon, 23 Sep 2024 20:04:30 +0200
Message-ID: <20240923180432.270779-1-agruenba@redhat.com>
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

Thank you very much,
Andreas


The following changes since commit 6706415bf9f3dcb425f4b60a08a3a6f1d94ec0e0:

  Merge tag 'gfs2-v6.10-rc1-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2024-07-17 12:23:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-fixes

for you to fetch changes up to 6888c1e85f5db129e6ddcff879bb127bbfdb5c64:

  gfs2: Remove gfs2_aspace_writepage() (2024-09-02 14:46:37 +0200)

----------------------------------------------------------------
gfs2 changes

- Eliminate the writepage address space operation (by Matthew Wilcox).

- A syzkaller fix (by Julian Sun) and a minor cleanup (by Andreas
  Gruenbacher).

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Minor gfs2_glock_cb cleanup

Julian Sun (1):
      gfs2: fix double destroy_workqueue error

Matthew Wilcox (Oracle) (4):
      gfs2: Add gfs2_aspace_writepages()
      gfs2: Remove __gfs2_writepage()
      gfs2: Remove gfs2_jdata_writepage()
      gfs2: Remove gfs2_aspace_writepage()

 fs/gfs2/aops.c       | 30 ------------------------------
 fs/gfs2/glock.c      |  9 ++++++---
 fs/gfs2/log.c        | 12 ++----------
 fs/gfs2/meta_io.c    | 24 +++++++++++++++++-------
 fs/gfs2/ops_fstype.c |  3 ++-
 5 files changed, 27 insertions(+), 51 deletions(-)


