Return-Path: <linux-kernel+bounces-434915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9B9E6CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1E7282732
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FFA1FC0E1;
	Fri,  6 Dec 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deIKya1w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265E155C94
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483201; cv=none; b=aI8UaXHIwoQjtIHeA3+7WWWnl1lmu0K1AUecuJJ/WoMUZzfzEtB6RcBv6Vkh7n9M8yvBQ9u+EBlh11yJjxwc0JYT5fzv/D8mLPLBwjhhKcX7YPUlzqhi27vnu+F5YjXEHkXd97WeODR137hf1I0at5XcPgMfsCaYBrHx430WNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483201; c=relaxed/simple;
	bh=yWtcrzdgAvBrgae7cwVH2ss7Um0+y6Eu2IYvB+sSKbM=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=ja9fi7Zji8mD2mMQgB3iMyERMesf/XeJwi+bFAIYBQv7FfTnvK7lmnX31nsO9ctqNLsDSm/e87DHYd+8VqhCEmKvUYUkmUqSzRB1wYGqi04p5SUCURcsZDaQ4Bx4IXpOiA1OgJQEYvDfLr9uP143QzB4ZSQHh8n7OLWAgiOO1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=deIKya1w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733483198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9r+6fMgClRllhmJ7Eb5OJfXb8Cftj0qgZEdtU6wnqxA=;
	b=deIKya1w3LqbPFqlYuXDl0zGknSKdUdNo7ydUE3x7i4xC0i/B9dJp9iz+/qLPtdmjTNyl/
	LeWSDLWrfQpe1TL9mvTY9QbTdcx8rYqeVVBPDKvT1VjMzEkI/7OvHn0OhM+wnl1jKPMBgz
	tBaGht/Iq4g06pTK2TkHjVts99yH9AE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-PlVf5XUbPaii21V9hMiYWQ-1; Fri,
 06 Dec 2024 06:06:37 -0500
X-MC-Unique: PlVf5XUbPaii21V9hMiYWQ-1
X-Mimecast-MFC-AGG-ID: PlVf5XUbPaii21V9hMiYWQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5E5B19560AB;
	Fri,  6 Dec 2024 11:06:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AADF300019E;
	Fri,  6 Dec 2024 11:06:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix rmdir failure due to ongoing I/O on deleted file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1978206.1733483192.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Dec 2024 11:06:32 +0000
Message-ID: <1978207.1733483192@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

    =

The cifs_io_request struct (a wrapper around netfs_io_request) holds open
the file on the server, even beyond the local Linux file being closed.
This can cause problems with Windows-based filesystems as the file's name
still exists after deletion until the file is closed, preventing the paren=
t
directory from being removed and causing spurious test failures in xfstest=
s
due to inability to remove a directory.  The symptom looks something like
this in the test output:

   rm: cannot remove '/mnt/scratch/test/p0/d3': Directory not empty
   rm: cannot remove '/mnt/scratch/test/p1/dc/dae': Directory not empty

Fix this by waiting in unlink and rename for any outstanding I/O requests
to be completed on the target file before removing that file.

Note that this doesn't prevent Linux from trying to start new requests
after deletion if it still has the file open locally - something that's
perfectly acceptable on a UNIX system.

Note also that whilst I've marked this as fixing the commit to make cifs
use netfslib, I don't know that it won't occur before that.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 42c030687918..3df53d51f646 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1871,6 +1871,7 @@ int cifs_unlink(struct inode *dir, struct dentry *de=
ntry)
 		goto unlink_out;
 	}
 =

+	netfs_wait_for_outstanding_io(inode);
 	cifs_close_deferred_file_under_dentry(tcon, full_path);
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	if (cap_unix(tcon->ses) && (CIFS_UNIX_POSIX_PATH_OPS_CAP &
@@ -2388,8 +2389,10 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode =
*source_dir,
 	}
 =

 	cifs_close_deferred_file_under_dentry(tcon, from_name);
-	if (d_inode(target_dentry) !=3D NULL)
+	if (d_inode(target_dentry) !=3D NULL) {
+		netfs_wait_for_outstanding_io(d_inode(target_dentry));
 		cifs_close_deferred_file_under_dentry(tcon, to_name);
+	}
 =

 	rc =3D cifs_do_rename(xid, source_dentry, from_name, target_dentry,
 			    to_name);


