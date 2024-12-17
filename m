Return-Path: <linux-kernel+bounces-449586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C69F5113
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE27169B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4F14A609;
	Tue, 17 Dec 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScZyn5/S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3921386BF
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453130; cv=none; b=POUANgKZbv+KS2EkGB+CtVMpWpLwdB3Muas+ggenzQ42nn4W2s6VjBYtGnUVdHLLpLgVGRAWAZXOXHB2wExYhcn5ltifWqQuIfSILsEcMsR1Q33VjFjrc+kMti0DHfyxOZuGS/nB5nK0/XYI5yqdKVheB0q1YCCAhTJsoN2EBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453130; c=relaxed/simple;
	bh=AzYqycXinGWcdaLz7RHQ7T4u2K49gpeMyor7Vit9yuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZYmQHC3jneU8UQaYpMBZHjEg9GIjWtkQLG1OS4ikmX/ZxoDTbwCBYoZvU5IOzgqrb32PSR1B7XWPs4p2vVTuWW6VOgjh8emDJvzzHH+W1rPBPxhidVjOZbuR86mBJafvOZZ+bzrodmOLUEd0Ma9ZwGmpJzvIcFb17SqtIU8sM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScZyn5/S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734453127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v4a78Nrl6r5YnvCCV5tI8Jed2xDlkXGLKzm9cenTmJA=;
	b=ScZyn5/S9dTHcz6YX4Hfh0J+vZSWnFIv0rz6KnmRhmZqguvM8Rz89mDfFCsvNLpO279AxB
	hYC0RA4XIfRfBerMDkvOrAyHcZ2cfdhqZCEG+NxS9zSSVb0gUODdl6oc/p6ekBae73my1O
	oMBSG+NcyHWz5UqNCmLUXi5oqa9w3tY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-irORv65YNUaa8NIP11YVcA-1; Tue,
 17 Dec 2024 11:32:02 -0500
X-MC-Unique: irORv65YNUaa8NIP11YVcA-1
X-Mimecast-MFC-AGG-ID: irORv65YNUaa8NIP11YVcA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33F211955F44;
	Tue, 17 Dec 2024 16:32:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6610A30044C1;
	Tue, 17 Dec 2024 16:31:58 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: linux-mm@kvack.org,
	mgorman@techsingularity.net,
	willy@infradead.org
Cc: david@redhat.com,
	linux-kernel@vger.kernel.org,
	lcapitulino@gmail.com
Subject: [PATCH 0/2] mm: alloc_pages_bulk: small API refactor
Date: Tue, 17 Dec 2024 11:31:26 -0500
Message-ID: <cover.1734453061.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,

Today, alloc_pages_bulk_noprof() supports two arguments to return allocated
pages: a linked list and an array. There are also higher level APIs for both.

However, the linked list API has apparently never been used. So, this series
removes it along with the list API and also refactors the remaining API naming
for consistency.

I've boot-tested this series on arm64 and built-tested it on x86.

PS: Matthew, it was easier to keep my patch instead of fixing up Mel's but I
included the API refactoring patch as well.

PPS: It's probably good to have a free_pages_bulk() function, but I'll leave
this for another day.

Luiz Capitulino (2):
  mm: alloc_pages_bulk_noprof: drop page_list argument
  mm: alloc_pages_bulk: rename API

 .../staging/media/atomisp/pci/hmm/hmm_bo.c    | 12 +++---
 drivers/vfio/pci/mlx5/cmd.c                   | 14 +++----
 drivers/vfio/pci/virtio/migrate.c             |  6 +--
 fs/btrfs/extent_io.c                          |  2 +-
 fs/erofs/zutil.c                              |  4 +-
 fs/splice.c                                   |  2 +-
 fs/xfs/xfs_buf.c                              |  4 +-
 include/linux/gfp.h                           | 22 +++++------
 kernel/bpf/arena.c                            |  2 +-
 lib/alloc_tag.c                               |  4 +-
 lib/kunit_iov_iter.c                          |  2 +-
 lib/test_vmalloc.c                            |  2 +-
 mm/mempolicy.c                                | 28 ++++++-------
 mm/page_alloc.c                               | 39 ++++++-------------
 mm/vmalloc.c                                  |  4 +-
 net/core/page_pool.c                          |  7 ++--
 net/sunrpc/svc.c                              |  4 +-
 net/sunrpc/svc_xprt.c                         |  3 +-
 18 files changed, 70 insertions(+), 91 deletions(-)

-- 
2.47.1


