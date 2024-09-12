Return-Path: <linux-kernel+bounces-326435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 494FD97684A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2AB1F21B97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD52E1A4F0A;
	Thu, 12 Sep 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhzGVysH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE001A42AC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141817; cv=none; b=GUugM/KtAPktndLs57KhFepKTeylEgcjIHNnFxjAHf8erO9dizBJloG4Tma4kKePWTCwMAuw6uivLWTBoPCjUs6R5qG9TqBfjoUM81Gg9MudOqPHiJ5lmMP8Wdz2z8R5qhu20O5vWKfVfOk4jwmYx4m+Fuga2Xlzd2IQyF33Xmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141817; c=relaxed/simple;
	bh=Xl6nNLBK8GTBKxLIKD61vE0uvYByirFE263h76WjaRM=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=Ki0gqYAKaSneEQA+uk3w5QFwxoKsun9fXTSEdr6ZbJpQPiizQiK64x2jMpjqBU0FgNNfh4s0pfGQv+xZ1u0YE7Odrz5pVfewAqDC7eiofwDjJRMRsErBDiN1OLt459M9PYIK2egdEo5W+v0I/M1x1DPeGFOPimZLMab5Cg8217g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhzGVysH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726141814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jLN3U1yZ7TMderZrIcQLdov+Z22mdFuW5sMvjEe338o=;
	b=PhzGVysHpzbF0X83ZaR/BnmDU4+JTXmGUmdMze73dB8LlCLEsLkhsqf7/rqX/NbQZrbjIh
	6aN3Rn6QUn11A+igbJO/yHwk4tea1teRRX1p9yDgfeddqDzfd0Zby7kj+jHlC1HMvNJDO2
	NmxkSErI3nkuhZK3QSyDOHJFM+TCP7Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-FdrR9fltPha0VMOFb_6fTA-1; Thu,
 12 Sep 2024 07:50:13 -0400
X-MC-Unique: FdrR9fltPha0VMOFb_6fTA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3217197702F;
	Thu, 12 Sep 2024 11:50:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FA4519560AA;
	Thu, 12 Sep 2024 11:50:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
    Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Jeff Layton <jlayton@kernel.org>,
    Stephen Rothwell <sfr@canb.auug.org.au>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix up netfs-writeback vs cifs fixes merge conflicts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1131387.1726141806.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 12:50:06 +0100
Message-ID: <1131388.1726141806@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

    =

Fix up the conflicts between the netfslib development patches and cifs fix
commits due to:

        a68c74865f517e26728735aba0ae05055eaff76c
        cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3

conflicting with:

        ee4cdf7ba857
        netfs: Speed up buffered reading"

This will need to be applied if/when Christian's vfs.netfs branch is merge=
d.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifssmb.c |   14 +++++++-------
 fs/smb/client/smb2pdu.c |    2 --
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6ad22732c25c..d0df0c17b18f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1266,9 +1266,7 @@ static void cifs_readv_worker(struct work_struct *wo=
rk)
 	struct cifs_io_subrequest *rdata =3D
 		container_of(work, struct cifs_io_subrequest, subreq.work);
 =

-	netfs_subreq_terminated(&rdata->subreq,
-				(rdata->result =3D=3D 0 || rdata->result =3D=3D -EAGAIN) ?
-				rdata->got_bytes : rdata->result, true);
+	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
 }
 =

 static void
@@ -1327,9 +1325,9 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 		rdata->result =3D 0;
 	} else {
-		if (rdata->got_bytes < rdata->actual_len &&
-		    rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes =
=3D=3D
-		    ictx->remote_i_size) {
+		size_t trans =3D rdata->subreq.transferred + rdata->got_bytes;
+		if (trans < rdata->subreq.len &&
+		    rdata->subreq.start + trans =3D=3D ictx->remote_i_size) {
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result =3D 0;
 		}
@@ -1337,7 +1335,9 @@ cifs_readv_callback(struct mid_q_entry *mid)
 =

 	rdata->credits.value =3D 0;
 	rdata->subreq.transferred +=3D rdata->got_bytes;
-	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
+	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
+	INIT_WORK(&rdata->subreq.work, cifs_readv_worker);
+	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 95377bb91950..bb8ecbbe78af 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4614,8 +4614,6 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			      0, cifs_trace_rw_credits_read_response_clear);
 	rdata->credits.value =3D 0;
 	rdata->subreq.transferred +=3D rdata->got_bytes;
-	if (rdata->subreq.start + rdata->subreq.transferred >=3D rdata->subreq.r=
req->i_size)
-		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);


