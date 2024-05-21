Return-Path: <linux-kernel+bounces-185184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F68CB1AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E241F234DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3A148820;
	Tue, 21 May 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+xEGeeE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65AC142E72
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306598; cv=none; b=LcMR5+TCK3TERy1pqgqkyrUXWQnJF1VnPvhYDLl9b0bvgN1X33UdqQ20bGfOKM/fSGkIoHYF3Fw1YN8KcSN+xbihxMBRb4hssV+loFKjIrkNBDr76i8Yz5h2INCI7UAMeDNDIxshVVIuMIZ8SJuPi4Mdm8yCTD/DNk43UwBI3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306598; c=relaxed/simple;
	bh=EsNjHQD8onwzJqeFZmAIuXFOW2blNrOa1Rp4vndUGRU=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=M0IJ1o3PJC4jhjivh9D60uvzKB/tJ8RUrnZWKw/XhTyjtrfD/eIefDNwy0ND98AK6akvq9IP4dxZcKKfOw4PNdAcr2NfRpHnblReE/psoulyJ/+IFXYgRgiC8dqnYG+Qs/0rq66mZnljB5TROgLRGKJY5InI51OONsqVqoVyQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+xEGeeE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716306595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3JK4qzqYYZMoo+8Y+hbMdVVgqmEeOKBQ3rxyZn96arA=;
	b=L+xEGeeEPbXLhXsNh6NDv1B5qmFMl9avC6U0MCOrLOR8uu7l3cfLc/+EH+YFW3qCEarlW0
	wEX5ybnQggCab81rMqsMyTJp0SYt0aPjsiSf6hau/qEvmkG2+FEjtoVYdThuyowzOYdvei
	lQyFfG+X9oqgLG4dGTevEyXpk8J05dM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-q3c8SPE5M_WT51A7n4paVw-1; Tue,
 21 May 2024 11:49:50 -0400
X-MC-Unique: q3c8SPE5M_WT51A7n4paVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3CE41C05129;
	Tue, 21 May 2024 15:49:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97E4F21EE56B;
	Tue, 21 May 2024 15:49:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Enzo Matsumiya <ematsumiya@suse.de>, Jens Axboe <axboe@kernel.dk>,
    Matthew Wilcox <willy@infradead.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <316305.1716306586.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 May 2024 16:49:46 +0100
Message-ID: <316306.1716306586@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Fix netfs_perform_write() to set BDP_ASYNC if IOCB_NOWAIT is set rather
than if IOCB_SYNC is not set.  It reflects asynchronicity in the sense of
not waiting rather than synchronicity in the sense of not returning until
the op is complete.

Without this, generic/590 fails on cifs in strict caching mode with a
complaint that one of the writes fails with EAGAIN.  The test can be
distilled down to:

        mount -t cifs /my/share /mnt -ostuff
        xfs_io -i -c 'falloc 0 8191M -c fsync -f /mnt/file
        xfs_io -i -c 'pwrite -b 1M -W 0 8191M' /mnt/file

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for bu=
ffered write")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 1121601536d1..07bc1fd43530 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -181,7 +181,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct=
 iov_iter *iter,
 	struct folio *folio, *writethrough =3D NULL;
 	enum netfs_how_to_modify howto;
 	enum netfs_folio_trace trace;
-	unsigned int bdp_flags =3D (iocb->ki_flags & IOCB_SYNC) ? 0: BDP_ASYNC;
+	unsigned int bdp_flags =3D (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : =
0;
 	ssize_t written =3D 0, ret, ret2;
 	loff_t i_size, pos =3D iocb->ki_pos, from, to;
 	size_t max_chunk =3D PAGE_SIZE << MAX_PAGECACHE_ORDER;


