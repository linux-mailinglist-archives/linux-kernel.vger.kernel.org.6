Return-Path: <linux-kernel+bounces-175703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94BB8C23DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3A51C23EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399B16F828;
	Fri, 10 May 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxJnHiKH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988E16F84A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341649; cv=none; b=XlRy3Or4JogiMosCK2DlsA3um2hb02Es5agg+VQ9TlS6K5dQfILE1Y4J1FhZMspeNSxm+3abbaUdgZR9JVi0Ei+rTF7mPmGQxtIzWjPXa/bvKpa+Q+ULaTb8OJTiPUcIxY38a6tO3pJgNdQpePQoZoxo72eNVtoz8aivpAo2zKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341649; c=relaxed/simple;
	bh=JKHp4Rh5kiRcj7JDKcLq7wL0HdW0ZmOA3PpfklMf1Ns=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=R/NeynBmOg9SOymdn0TRHwUkIPPsSsfTBnhXOK3YNvyhnSEwA5QeYETUNb7qInsZV8kJUKpchJAcz7iJlpXNSQumTmQxum6rNocEXDoLoZm8Ss/lvcUdYesj6ZfuS+2+ljA5ADe5SttfvqDSEwfFm8LfroY98XnyE1mHEAwLz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxJnHiKH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715341647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sd8WPC6FQ4+Bcwqy340NHitlPtCAliqE6vEb39UhEp8=;
	b=NxJnHiKHQnvOtONJ0juibzoB6kFkbeY+wmnxVga5G+udt7+qaWP0LHk2OcMo8TI2rj0hFZ
	owCGWHb47coyLgsBMm5huClAf2NVFAZD+umV7raBM8ZcaKUik5Y8wBIKro2KUqX0Bzt7J9
	7BddoZudxdNV3/5159FZNBfOZsu57Y4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-T2OoUr2rMW2tuHOYkkqepg-1; Fri,
 10 May 2024 07:47:23 -0400
X-MC-Unique: T2OoUr2rMW2tuHOYkkqepg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E00429AC02C;
	Fri, 10 May 2024 11:47:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 574FAC54BBC;
	Fri, 10 May 2024 11:47:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>
cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
    Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ext4: Don't reduce symlink i_mode by umask if no ACL support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1586867.1715341641.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 May 2024 12:47:21 +0100
Message-ID: <1586868.1715341641@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

    =

If CONFIG_EXT4_FS_POSIX_ACL=3Dn then the fallback version of ext4_init_acl=
()
will mask off the umask bits from the new inode's i_mode.  This should not
be done if the inode is a symlink.  If CONFIG_EXT4_FS_POSIX_ACL=3Dy, then =
we
go through posix_acl_create() instead which does the right thing with
symlinks.

However, this is actually unnecessary now as vfs_prepare_mode() has alread=
y
done this where appropriate, so fix this by making the fallback version of
ext4_init_acl() do nothing.

Fixes: 484fd6c1de13 ("ext4: apply umask if ACL support is disabled")
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Max Kellermann <max.kellermann@ionos.com>
cc: Jan Kara <jack@suse.com>
cc: Christian Brauner <brauner@kernel.org>
cc: linux-ext4@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ext4/acl.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index ef4c19e5f570..0c5a79c3b5d4 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,11 +68,6 @@ extern int ext4_init_acl(handle_t *, struct inode *, st=
ruct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
-	/* usually, the umask is applied by posix_acl_create(), but if
-	   ext4 ACL support is disabled at compile time, we need to do
-	   it here, because posix_acl_create() will never be called */
-	inode->i_mode &=3D ~current_umask();
-
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */


