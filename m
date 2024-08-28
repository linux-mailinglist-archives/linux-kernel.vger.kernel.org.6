Return-Path: <linux-kernel+bounces-305725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D596337A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8451F216B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685341AE84D;
	Wed, 28 Aug 2024 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtD67Plb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A161AD3F6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879020; cv=none; b=FIy3JPpD6Hy4peashXMOOS6ZdLr3VTftAuiNu4Nt2RFm76jTUFxQmwkfgME65nJQkS5UVOmX5mNo1SRljAcwCtl0bWJ2NFMT7W3/KsA8DnlL1blFwA4TwGkRKm1++BOoAyIf1OO8Wru8x8vtp2AeruReT/NvEyTinSR7prAixiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879020; c=relaxed/simple;
	bh=aqaDKpwuTC/MvE1xR7KFhnIq1GcibxXik/Q4KKUdRL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHVRhzCNqIed1+0JU8XgmS7s03p1CbtY/sYe47lpl04upfso00SzbWercHEqbmOABMFTIFGwtlZv7XonJ6DUo2ZT0l/oY+zHmTeE+Dkal8X9jrr2fPFOPYoOcmVcjQtFJX9LyuMa2ZWEdwiaYkhK7ZzIAOhVwmmZNBm1mduWAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtD67Plb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gafgwUBwZzk/cup16/E12xqM5SQfOL2Vg1E23SCR1HY=;
	b=DtD67PlbQo9ebJ6xIlK8ueZ+YmfBDtyTv6bHjHEYBwpcPGDLjW4BtjkJOy1sqdRYhB78UP
	zwhbSTHGP/8JW+oxGYwL6RDKcku0MusGNuLbCoXPvlqRkgYHsDcZeXKG6UQ5+iBsbCq6aY
	yAiuHz+2iyrMVlsb1L9P3EINtyptTPk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-nlBAerB_MSuc8tJsU0uD8A-1; Wed,
 28 Aug 2024 17:03:34 -0400
X-MC-Unique: nlBAerB_MSuc8tJsU0uD8A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 060FE1955BEE;
	Wed, 28 Aug 2024 21:03:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74A7019560A3;
	Wed, 28 Aug 2024 21:03:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH 4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
Date: Wed, 28 Aug 2024 22:02:45 +0100
Message-ID: <20240828210249.1078637-5-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
rather than truncate_inode_pages_range().  The latter clears the
invalidated bit of a partial pages rather than discarding it entirely.
This causes copy_file_range() to fail on cifs because the partial pages at
either end of the destination range aren't evicted and reread, but rather
just partly cleared.

This causes generic/075 and generic/112 xfstests to fail.

Fixes: 74e797d79cf1 ("mm: Provide a means of invalidation without using launder_folio")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: devel@lists.orangefs.org
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..0ca9c1377b68 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4231,7 +4231,7 @@ int filemap_invalidate_inode(struct inode *inode, bool flush,
 	}
 
 	/* Wait for writeback to complete on all folios and discard. */
-	truncate_inode_pages_range(mapping, start, end);
+	invalidate_inode_pages2_range(mapping, start / PAGE_SIZE, end / PAGE_SIZE);
 
 unlock:
 	filemap_invalidate_unlock(mapping);


