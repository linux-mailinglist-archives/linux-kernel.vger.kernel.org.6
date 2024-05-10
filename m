Return-Path: <linux-kernel+bounces-175695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFEF8C23C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2792A1C23009
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C016F0C6;
	Fri, 10 May 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Acg1ltRv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AF168AFC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341413; cv=none; b=otbl8jqtLUvsejW9rblkUF0rzgOVDRYZrikOF/AVW3E6XBh/cJ97ggn3mIv6bTXkPkxgCtxPPhgJi48t6LV9jBOtlxjek4xyn/UjgPGW6MeOPRI0JoC4dsEe7jCiywauKJ2HYJIi0qBL+N67nHwH7iAjKlfWz5dSx2ga9MEPFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341413; c=relaxed/simple;
	bh=hPqJ0qWB1JrzzB5epI7Bmm1E+O0v4RZ6nKbII+Eigqo=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=aVrJfKoQQCAtcQW/Emq00BWhp25QLVUQTYNWplgF72AjQUn5htLtti1AizQbJA82vLtivK0CY0IPrMqZdcpoprvMOhEFkhL2fhHBJtYau37zBnmdxlZvilmIKarSlHx9lDD2VtwBseqtqJEl8hrcNXIsyfazurpQ/JlIpdkVdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Acg1ltRv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715341410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QVNScDt9TFIBZxl0giwTVKvKrueEMhWzAVl5bin0i/g=;
	b=Acg1ltRvbD4AYdGKa0pufbTvMgKePqUXZdn79MW23e4mCf4gTy2w9b9lQlnRi8TrewmGa1
	PQRHV53hIco3CR2w0CajBlK5HXcZfDqyreSutPyrfQqC4MaCogEXBNTFi4XwuDGpBsTFqL
	JTlbssbVsPFHr8w/Wmq5LEgHx8a+Aok=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-p0HQiy5vNrqASSEmU4cOeg-1; Fri,
 10 May 2024 07:43:27 -0400
X-MC-Unique: p0HQiy5vNrqASSEmU4cOeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B077D3C0C104;
	Fri, 10 May 2024 11:43:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9649219EFE;
	Fri, 10 May 2024 11:43:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>
cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
    Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ext4: Don't reduce symlink i_mode by umask if no ACL support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1586575.1715341405.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 May 2024 12:43:25 +0100
Message-ID: <1586576.1715341405@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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
 fs/ext4/acl.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index ef4c19e5f570..566625286442 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -71,7 +71,8 @@ ext4_init_acl(handle_t *handle, struct inode *inode, str=
uct inode *dir)
 	/* usually, the umask is applied by posix_acl_create(), but if
 	   ext4 ACL support is disabled at compile time, we need to do
 	   it here, because posix_acl_create() will never be called */
-	inode->i_mode &=3D ~current_umask();
+	if (!S_ISLNK(inode->i_mode))
+		inode->i_mode &=3D ~current_umask();
 =

 	return 0;
 }


