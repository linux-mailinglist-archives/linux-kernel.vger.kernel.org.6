Return-Path: <linux-kernel+bounces-228857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B399167D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063FE1F27037
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A415884D;
	Tue, 25 Jun 2024 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqL/fbgH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A8154C0E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318560; cv=none; b=MEo5xbXlT1sOE0uW0WwpVMJ98y/NkZ/78cf3StVcG3G6H89iUWU06mPZ1GXCmmdzI/XKLWYIzP6eeeF9G9pP3PTBZKMCnyMIRLCi/Q+fBDMcQctVHKkD1X8qsmBMu6CuHy4bBdeKn9LXzyx2sanrQEJ9VPwMgNvlvw83rgnruDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318560; c=relaxed/simple;
	bh=YOq9JrhIvYVPcCNNT4Vfuh45iB7NXBn0c8q168TR63Y=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=SuZ2HLiRsCDro9U2xGiMVIC264I/dbiyAaQ3yUNYqnrEqwtzyv9XtuEOeTfMCCKDPaw9FLhCrpxFNiHGCQeKcyZ2ZXMtAU3gE5BlpNQ4qCZmlRZJgVRY4Mc3jFkWKHaBh9K572f+FBWqeZaFCwVL+/gim6Hw+0kYcs1vbj/U6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqL/fbgH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719318557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kf2p5udqDpsF3HW6ICyyWXNK+Uj/DfC2j20t1IouqU=;
	b=WqL/fbgH3Lew0gB+1KPTypiigiKsCBF2UuqhtByRRtZKWPtLfoGZcJuZD+gQtu/7nuKST9
	tC8b3zwIqexP0QgTa2vAs+EOsM1e1qxmOWNUg9CC+gi9RPmPuivi4WhsWeMdktJmP/WA/X
	GrFLiUvUjaQ2tcrgLSZqBt3zbMMg4Vc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-dQ5jPXmyNFuSlLtPhDch-Q-1; Tue,
 25 Jun 2024 08:29:13 -0400
X-MC-Unique: dQ5jPXmyNFuSlLtPhDch-Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C96319560B8;
	Tue, 25 Jun 2024 12:29:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 466F31956087;
	Tue, 25 Jun 2024 12:29:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <614257.1719228181@warthog.procyon.org.uk>
References: <614257.1719228181@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <780210.1719318546.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Jun 2024 13:29:06 +0100
Message-ID: <780211.1719318546@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

    =

Fix netfs_page_mkwrite() to check that folio->mapping is valid once it has
taken the folio lock (as filemap_page_mkwrite() does).  Without this,
generic/247 occasionally oopses with something like the following:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page

    RIP: 0010:trace_event_raw_event_netfs_folio+0x61/0xc0
    ...
    Call Trace:
     <TASK>
     ? __die_body+0x1a/0x60
     ? page_fault_oops+0x6e/0xa0
     ? exc_page_fault+0xc2/0xe0
     ? asm_exc_page_fault+0x22/0x30
     ? trace_event_raw_event_netfs_folio+0x61/0xc0
     trace_netfs_folio+0x39/0x40
     netfs_page_mkwrite+0x14c/0x1d0
     do_page_mkwrite+0x50/0x90
     do_pte_missing+0x184/0x200
     __handle_mm_fault+0x42d/0x500
     handle_mm_fault+0x121/0x1f0
     do_user_addr_fault+0x23e/0x3c0
     exc_page_fault+0xc2/0xe0
     asm_exc_page_fault+0x22/0x30

This is due to the invalidate_inode_pages2_range() issued at the end of th=
e
DIO write interfering with the mmap'd writes.

Fixes: 102a7e2c598c ("netfs: Allow buffered shared-writeable mmap through =
netfs_page_mkwrite()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
Changes
=3D=3D=3D=3D=3D=3D=3D
ver #2)
 - Actually unlock the folio rather than returning VM_FAULT_LOCKED with
   VM_FAULT_NOPAGE.

 fs/netfs/buffered_write.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 07bc1fd43530..270f8ebf8328 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -523,6 +523,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, st=
ruct netfs_group *netfs_gr
 	struct netfs_group *group;
 	struct folio *folio =3D page_folio(vmf->page);
 	struct file *file =3D vmf->vma->vm_file;
+	struct address_space *mapping =3D file->f_mapping;
 	struct inode *inode =3D file_inode(file);
 	struct netfs_inode *ictx =3D netfs_inode(inode);
 	vm_fault_t ret =3D VM_FAULT_RETRY;
@@ -534,6 +535,11 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, s=
truct netfs_group *netfs_gr
 =

 	if (folio_lock_killable(folio) < 0)
 		goto out;
+	if (folio->mapping !=3D mapping) {
+		folio_unlock(folio);
+		ret =3D VM_FAULT_NOPAGE;
+		goto out;
+	}
 =

 	if (folio_wait_writeback_killable(folio)) {
 		ret =3D VM_FAULT_LOCKED;
@@ -549,7 +555,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, st=
ruct netfs_group *netfs_gr
 	group =3D netfs_folio_group(folio);
 	if (group !=3D netfs_group && group !=3D NETFS_FOLIO_COPY_TO_CACHE) {
 		folio_unlock(folio);
-		err =3D filemap_fdatawait_range(inode->i_mapping,
+		err =3D filemap_fdatawait_range(mapping,
 					      folio_pos(folio),
 					      folio_pos(folio) + folio_size(folio));
 		switch (err) {


