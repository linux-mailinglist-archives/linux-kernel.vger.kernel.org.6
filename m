Return-Path: <linux-kernel+bounces-380022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A59AE783
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE5528A727
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E511EBFED;
	Thu, 24 Oct 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BB2wRZ5Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8EA1E8835
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778772; cv=none; b=ObyS9BtKrHtrubAwGmvS8Il9JyIlDvT01rozoMtUgcBGRpLaZbushPkOAKuMcKL2ekQNyuNED9Gh4BXDRtB8433gmRTRqSmBHjSGRjHcHIqay/2iP3/zW07n3i/X+jm8a+CEM7aUFezXaMIPad1Truin4Q/3bUELYc+F3O7r13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778772; c=relaxed/simple;
	bh=PkZy5Bm2Mgnujb/0DqtZnvhh4LaJYhfynDFVUZ+zO5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKOJ81XV8yH6kKRZxdQ1OJ/McNpZNnXBloBL2Lfr7KIRFx6Dx+YJGa6CNGOl2f+SBxCJM2RMJsn+ueH7UAZXKzUGPuRMYl2zBX0rd4a53BBH6Eu4p9JsyORmh5dLxk8fJ/FOYjRTQG8v3N/cpYaljbw4eevTfhMbzeOjrEqfLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BB2wRZ5Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SueMPOdHep9t3PCuklU6bVWhougpE6WyFc4wdjmYJYc=;
	b=BB2wRZ5Zvw2YtpBOtpwFwhGTndTUpUrFRuuufNMsEctY7GmDIedLIadfTGYG5Syg9qGQUn
	FBTGFeWCCJmS0NUtSj0Kih2R33AcHNIuOOPzGSv8fTS3t/LkhlMrH6+++vNgf0T4Z7EPLr
	p3rcwG5hm8Y0uYPYxIeWnKUi3BgjY68=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-69oGyEVANHudqYkVi238wQ-1; Thu,
 24 Oct 2024 10:06:07 -0400
X-MC-Unique: 69oGyEVANHudqYkVi238wQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0886E1955E75;
	Thu, 24 Oct 2024 14:06:03 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2CAC30001A7;
	Thu, 24 Oct 2024 14:05:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 01/27] netfs: Remove call to folio_index()
Date: Thu, 24 Oct 2024 15:04:59 +0100
Message-ID: <20241024140539.3828093-2-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Calling folio_index() is pointless overhead; directly dereferencing
folio->index is fine.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20241005182307.3190401-2-willy@infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/trace/events/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 69975c9c6823..bf511bca896e 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -450,7 +450,7 @@ TRACE_EVENT(netfs_folio,
 		    struct address_space *__m = READ_ONCE(folio->mapping);
 		    __entry->ino = __m ? __m->host->i_ino : 0;
 		    __entry->why = why;
-		    __entry->index = folio_index(folio);
+		    __entry->index = folio->index;
 		    __entry->nr = folio_nr_pages(folio);
 			   ),
 


