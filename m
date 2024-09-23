Return-Path: <linux-kernel+bounces-335991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA84A97EDC3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB8E281C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E04619FA98;
	Mon, 23 Sep 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc6i0D6f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0D19F49E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104141; cv=none; b=IVr4dLOAQWmvQ2xGMLGoX1yrWQ3yVf7vK2an4cxNE+AMpGaiZwR8LhnMYfXOUtAG5n1AJtoxNRRUmGXhCmTZTxrGD0xNGsqPEBGPm+G8Oq+sf2vlW5u4YtlV9bB7aFI3RUkp4CzmS9z+QYapjHvvIcgwiI8VY91RwEhkWoak4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104141; c=relaxed/simple;
	bh=0IYAdn8eY46RygPutjDmNaD9LRl4RSbhlUdXbOFZlss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxVSuYHqujKBT97BUD8sXG6NIi7sw01rC4MhPc+jxC9yYWXwJxSwlCM4Z4aN/RNu2Ej326CUQMNl1D5nFOj84FcMFYE7xGoAbu14IkwyrRII7+BpGFMwcNlv9TORlSUXW/LTujA+Kvh8amsB/YTxNmogg6us9pD4BmcHpXGxqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tc6i0D6f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8v23aDW/AqUoLZapyyeRQboTKixFXScSQEzJQ0mhVc=;
	b=Tc6i0D6fmvustL66frg53LvbW7Z4gky+jOGR55GwhxYFhAF9hjX1hrsAfxyjRe/6F0v7Ki
	k5FKgz3Fgtm5H3DZrUnCmmXpyLCfK9C3zbJXP8hJvSdu2MBu4atXP2rRd14NOXWf9Bo8nA
	UwxsUXwmIrzaHL9L7KhL0g6y/s0stTs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-DYyLGeXsPkSx-Jt_v0ORCQ-1; Mon,
 23 Sep 2024 11:08:53 -0400
X-MC-Unique: DYyLGeXsPkSx-Jt_v0ORCQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAD5618B63DB;
	Mon, 23 Sep 2024 15:08:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C923A1934989;
	Mon, 23 Sep 2024 15:08:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] afs: Fix the setting of the server responding flag
Date: Mon, 23 Sep 2024 16:07:50 +0100
Message-ID: <20240923150756.902363-7-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In afs_wait_for_operation(), we set transcribe the call responded flag to
the server record that we used after doing the fileserver iteration loop -
but it's possible to exit the loop having had a response from the server
that we've discarded (e.g. it returned an abort or we started receiving
data, but the call didn't complete).

This means that op->server might be NULL, but we don't check that before
attempting to set the server flag.

Fixes: 98f9fda2057b ("afs: Fold the afs_addr_cursor struct in")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 3546b087e791..428721bbe4f6 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -201,7 +201,7 @@ void afs_wait_for_operation(struct afs_operation *op)
 		}
 	}
 
-	if (op->call_responded)
+	if (op->call_responded && op->server)
 		set_bit(AFS_SERVER_FL_RESPONDING, &op->server->flags);
 
 	if (!afs_op_error(op)) {


