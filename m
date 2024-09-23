Return-Path: <linux-kernel+bounces-335989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7726D97EDBC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1887F1F21C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D94B19F41A;
	Mon, 23 Sep 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTVKvKy/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FBE19F136
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104129; cv=none; b=NbCR/iZpQk2RUupAoVal4BwkA27DUa3MT5ZYlp3FmJH642LhMDNvwISa6d62wTpA2tFnD9kiloKmHtSfk10ATu5GgQ4/rFRel3yGgtOppgTfMr9B9uZL53KQOQduYaspPkd3uQxS17rZZvbPDtXN6AzTda/2bIOzSaYnLg+kIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104129; c=relaxed/simple;
	bh=piXuVnAJq0Ja06sMKcORgtwIhID/qYO+WgQAvFaFwqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFjiL+Rv//hLKnPsJ87g3SC9odsGooBLwd4yBr9596/BFy3MiUhL1o1Exd6nSEOXq7vZ8u/NsbwaoCan5vCeN1z142lq1IfmtkkEBsxr8LAn8+lSKMv9+kXQTlbU05Cug2+krbH3BDSUeAIUZ1X4vU6R9Os6q+KvV5ntfATk5G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTVKvKy/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHIPIQ0jqmx06tKWg5zwKCYYjtifDx3/S1TSTB/jDJ4=;
	b=PTVKvKy/OpXZy1JmwaKJStZ5BwY/sgZfb9V5qjumC+l/bNLmBbgBAkdVKz9VIzLjiCG7da
	EgzBXUsFJGG3m1X4aiXC8RQHwOIxUbrLHha6iwbdNQSMkSA1wmC2H4Si+DPfvghtQ43fek
	JyrpA5JpW8LP4ZPolkB0F3uoCrO5mGk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-n60o72YoO8em_juxYjNDxw-1; Mon,
 23 Sep 2024 11:08:42 -0400
X-MC-Unique: n60o72YoO8em_juxYjNDxw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 633B218B6A33;
	Mon, 23 Sep 2024 15:08:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2387B190AABA;
	Mon, 23 Sep 2024 15:08:24 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 4/8] afs: Remove unused struct and function prototype
Date: Mon, 23 Sep 2024 16:07:48 +0100
Message-ID: <20240923150756.902363-5-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Thorsten Blum <thorsten.blum@toblux.com>

The struct afs_address_list and the function prototype
afs_put_address_list() are not used anymore and can be removed. Remove
them.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240911095046.3749-2-thorsten.blum@toblux.com/
---
 fs/afs/afs_vl.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/afs/afs_vl.h b/fs/afs/afs_vl.h
index 9c65ffb8a523..a06296c8827d 100644
--- a/fs/afs/afs_vl.h
+++ b/fs/afs/afs_vl.h
@@ -134,13 +134,4 @@ struct afs_uvldbentry__xdr {
 	__be32			spares9;
 };
 
-struct afs_address_list {
-	refcount_t		usage;
-	unsigned int		version;
-	unsigned int		nr_addrs;
-	struct sockaddr_rxrpc	addrs[];
-};
-
-extern void afs_put_address_list(struct afs_address_list *alist);
-
 #endif /* AFS_VL_H */


