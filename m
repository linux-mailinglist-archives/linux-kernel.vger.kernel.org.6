Return-Path: <linux-kernel+bounces-565927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E304AA67128
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FFD19A2985
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E9207DFC;
	Tue, 18 Mar 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/D+03/Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02626207DED
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293440; cv=none; b=SPiF6LfzERJjXG8MguZktUYoT8LdfADfRyLEN5qWwrIMeS/gznLWVV+DE58gyKazuaRapOaWAamAcCQQCFyVcRBSu5nLXL3FHC2McwlVigth0/jMTyGkwAJdrcui+C4/voQBzma1s8RnjzL5R0LwbVgvkSQplSRB8VtaQOaN1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293440; c=relaxed/simple;
	bh=mPD9I6hQu0KmDuJ3W77WPkC888mfLSxKlXfDiVY9Y78=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=X+KsjOvprqkWBFHUPItJflZUCiYoAXmdAyHoDp9aKPiKJrOHvaGOPZyOV1aVUFdgkTXqU51SVCLJFNLK9F4B2yD8cbZQOQQMv5B4r1g49OlHBwjoMQoLYGQ0/aOchbBdYnMtuaJUhw/VYDp/7wZM4togiWDhTyy3MCkz2KRTXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/D+03/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742293437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7g//HMO0ysLhQGwQMzBbCL/nP/QzBKmD+KMd2//IoXA=;
	b=D/D+03/QlRfeBAOKeGZOuOOVVtUdVpUIMxwTNV0np6Tslg5Kz4Q1ohXSwKqkGLdqhsF/Jr
	gKBp9F+tRCglvR4CR7enTBVZ9e6L7sYsFQjixcySbrU35zYy9rHpt4DrMeQRWMt0xt7g4g
	04NWrahTolJGMJ/2E7jexnvZjTkDciE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-Z90SBY82OW-AFYe3wz6uXA-1; Tue,
 18 Mar 2025 06:23:52 -0400
X-MC-Unique: Z90SBY82OW-AFYe3wz6uXA-1
X-Mimecast-MFC-AGG-ID: Z90SBY82OW-AFYe3wz6uXA_1742293431
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 321641955E93;
	Tue, 18 Mar 2025 10:23:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E66DA180175B;
	Tue, 18 Mar 2025 10:23:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <67d93d58.050a0220.2ca2c6.016a.GAE@google.com>
References: <67d93d58.050a0220.2ca2c6.016a.GAE@google.com>
To: syzbot <syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, enjuk@amazon.com, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] general protection fault in afs_atcell_get_link
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2477987.1742293427.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Mar 2025 10:23:47 +0000
Message-ID: <2477988.1742293427@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

commit 3ce74c88a6708de1842dbebc10f83013718324d0
Author: David Howells <dhowells@redhat.com>
Date:   Tue Mar 18 10:18:29 2025 +0000

    afs: Fix afs_atcell_get_link() to check if ws_cell is unset first
    =

    Fix afs_atcell_get_link() to check if the workstation cell is unset be=
fore
    doing the RCU pathwalk bit where we dereference that.
    =

    Fixes: 823869e1e616 ("afs: Fix afs_atcell_get_link() to handle RCU pat=
hwalk")
    Reported-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Marc Dionne <marc.dionne@auristor.com>
    cc: linux-afs@lists.infradead.org
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 008698d706ca..7d997f7a8028 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -314,6 +314,9 @@ static const char *afs_atcell_get_link(struct dentry *=
dentry, struct inode *inod
 	const char *name;
 	bool dotted =3D vnode->fid.vnode =3D=3D 3;
 =

+	if (!rcu_access_pointer(net->ws_cell))
+		return ERR_PTR(-ENOENT);
+
 	if (!dentry) {
 		/* We're in RCU-pathwalk. */
 		cell =3D rcu_dereference(net->ws_cell);
@@ -325,9 +328,6 @@ static const char *afs_atcell_get_link(struct dentry *=
dentry, struct inode *inod
 		return name;
 	}
 =

-	if (!rcu_access_pointer(net->ws_cell))
-		return ERR_PTR(-ENOENT);
-
 	down_read(&net->cells_lock);
 =

 	cell =3D rcu_dereference_protected(net->ws_cell, lockdep_is_held(&net->c=
ells_lock));


