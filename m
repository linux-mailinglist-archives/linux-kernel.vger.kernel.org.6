Return-Path: <linux-kernel+bounces-530259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D853DA43122
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE98F7AB02D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109AF20CCD3;
	Mon, 24 Feb 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzKOaDv+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551420E6FD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440552; cv=none; b=HLZjx48gp3dD+W5yygSFXTUVEWA8luZxREv+y4k1O68E6iKCe9cs7ijue9R1IRwHBbXqybC7+ZPobrM0xVhwjppMjbhCnqao9N6tzjDkhHYykzMRnNAOSn6A627gShrzMs4DZmL2+VbPv4stntjXKvzKCxKKXfeLard0vAYp9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440552; c=relaxed/simple;
	bh=U5l0j4YtFyzUAgf2XpWLt95eq0hDVZnNbYuPslcwWvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEy0S1t1fSTBF+zAHkFg0N4EyW2rIAKk4GKZC/ZnSC9VYB6mbS8QB5EJJqLfLns4EEiq93PHSs0OnsMq26tqC3w1OhmAFiRZqoh4Ei7GbLACZFxR5JuAVnx5lmcJDfCSLid3Es9LsSq9MLIx9wHRQeDSTYGiD64qNoKP/FFLTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzKOaDv+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740440550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sOyOEyWoaoUiEdZIH8OlV8/GrITSd01ztjRDINYAAk=;
	b=VzKOaDv+XuX8k2bR42TOxLhp57cIwaMN0jObL9ozAHE3/mWn0M9SgntI+3CqF7ifwLywbd
	F9G+0CtuRM49bZK9sM2PMYOFTU0/NjfoPTHC1RCtmHkqnGEY+My8PBPDwC8WKR2SzvbmfY
	02lorbmYm3Jh3aslamOvOafO6sXjoOc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-ZPhTii-dMiCqLtsQbcNkQA-1; Mon,
 24 Feb 2025 18:42:25 -0500
X-MC-Unique: ZPhTii-dMiCqLtsQbcNkQA-1
X-Mimecast-MFC-AGG-ID: ZPhTii-dMiCqLtsQbcNkQA_1740440544
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18C1C19783B4;
	Mon, 24 Feb 2025 23:42:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3613C19560AA;
	Mon, 24 Feb 2025 23:42:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 05/15] afs: Give an afs_server object a ref on the afs_cell object it points to
Date: Mon, 24 Feb 2025 23:41:42 +0000
Message-ID: <20250224234154.2014840-6-dhowells@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
References: <20250224234154.2014840-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Give an afs_server object a ref on the afs_cell object it points to so that
the cell doesn't get deleted before the server record.

Whilst this is circular (cell -> vol -> server_list -> server -> cell), the
ref only pins the memory, not the lifetime as that's controlled by the
activity counter.  When the volume's activity counter reaches 0, it
detaches from the cell and discards its server list; when a cell's activity
counter reaches 0, it discards its root volume.  At that point, the
circularity is broken.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 fs/afs/server.c            | 3 +++
 include/trace/events/afs.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index 038f9d0ae3af..4504e16b458c 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -163,6 +163,8 @@ static struct afs_server *afs_install_server(struct afs_cell *cell,
 	rb_insert_color(&server->uuid_rb, &net->fs_servers);
 	hlist_add_head_rcu(&server->proc_link, &net->fs_proc);
 
+	afs_get_cell(cell, afs_cell_trace_get_server);
+
 added_dup:
 	write_seqlock(&net->fs_addr_lock);
 	estate = rcu_dereference_protected(server->endpoint_state,
@@ -442,6 +444,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 			 atomic_read(&server->active), afs_server_trace_free);
 	afs_put_endpoint_state(rcu_access_pointer(server->endpoint_state),
 			       afs_estate_trace_put_server);
+	afs_put_cell(server->cell, afs_cell_trace_put_server);
 	kfree(server);
 }
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index b0db89058c91..958a2460330c 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -174,6 +174,7 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_get_queue_dns,	"GET q-dns ") \
 	EM(afs_cell_trace_get_queue_manage,	"GET q-mng ") \
 	EM(afs_cell_trace_get_queue_new,	"GET q-new ") \
+	EM(afs_cell_trace_get_server,		"GET server") \
 	EM(afs_cell_trace_get_vol,		"GET vol   ") \
 	EM(afs_cell_trace_insert,		"INSERT    ") \
 	EM(afs_cell_trace_manage,		"MANAGE    ") \
@@ -182,6 +183,7 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_put_destroy,		"PUT destry") \
 	EM(afs_cell_trace_put_queue_work,	"PUT q-work") \
 	EM(afs_cell_trace_put_queue_fail,	"PUT q-fail") \
+	EM(afs_cell_trace_put_server,		"PUT server") \
 	EM(afs_cell_trace_put_vol,		"PUT vol   ") \
 	EM(afs_cell_trace_see_source,		"SEE source") \
 	EM(afs_cell_trace_see_ws,		"SEE ws    ") \


