Return-Path: <linux-kernel+bounces-174545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 775E78C1084
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036DBB211B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D55157A41;
	Thu,  9 May 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaRyqVh4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD2152785
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262085; cv=none; b=sj51X9ZduxPdnlb9Xg/XT6at/oqAGXUNm+hMyiKttRiuTUSxrXDeaeOtInnozPokoy3WIQqEoJ4W6ffPtWZCzaY6mXtUBLRvlMFIHLq7ZGT5wBwSaqVnEtvB1UXqDUQWsZ1DJjozRXZ7e6M5k4eX4exHv3uIq2u5FhHfIN4HbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262085; c=relaxed/simple;
	bh=vY9i+evApO63hkDWccFZxgOb//cUZG1X+nOWjYtYIO4=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=K5QXt6AFFzFO5ZXnfGCDft+qClS+WRwzoDQP1S31IgY4McwjKihi/WZyc+E0QW6hhRZUKXX5fQeShn2AjWQMkVX5xeWLPiVYYvzVHS4d47y0i8biDXET10YYRctoIsNC8uGl7mwid9zDGbQ+O/Y/EAcTKLnjoWE4APBSZEq2tYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaRyqVh4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715262082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sjo+IhXcSXsH1FGysWSOqgI3mPHUJyrP5qGIrqAgaJM=;
	b=DaRyqVh4+SiI5PBY17CFusgqoY10YhtWbsc5e3R2egd52u6SPQY/ZUKRZmzBgYzsRoTDAm
	x8P9w4YF1i7Iz5HYgGXPCSCuAJKYJT/niMbSOa/GyTCrP2iUVMiSV9bdltxwyxafvK+clA
	nhkEw4DIatwVY+XlFuI1U+tSAYKquXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-SGW5cwOyM7GL8KaooEBPcA-1; Thu, 09 May 2024 09:41:16 -0400
X-MC-Unique: SGW5cwOyM7GL8KaooEBPcA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFABF8030C1;
	Thu,  9 May 2024 13:41:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5D236464C58;
	Thu,  9 May 2024 13:41:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>
cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Don't reduce symlink i_mode by umask if no ACL support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1553598.1715262072.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 May 2024 14:41:12 +0100
Message-ID: <1553599.1715262072@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

If CONFIG_EXT4_FS_POSIX_ACL=3Dn then the fallback version of ext4_init_acl=
()
will mask off the umask bits from the new inode's i_mode.  This should not
be done if the inode is a symlink.  If CONFIG_EXT4_FS_POSIX_ACL=3Dy, then =
we
go through posix_acl_create() instead which does the right thing with
symlinks.

Fix this by making the fallback version of ext4_init_acl() do nothing if
inode is a symlink.

Fixes: 484fd6c1de13 ("ext4: apply umask if ACL support is disabled")
Signed-off-by: David Howells <dhowells@redhat.com>
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


