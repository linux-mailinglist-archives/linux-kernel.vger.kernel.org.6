Return-Path: <linux-kernel+bounces-227116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9991488B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E1D1C2146D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715EA13AA45;
	Mon, 24 Jun 2024 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hg7Pa1QZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065C13A894
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228255; cv=none; b=Q9DmjTKaZyXKCroHo3wORPX+9h8QWNIGmiSuTShMJ9iWjO0H6R0YYttI4SpogBjHJMjQWtYJpsAyViYtCG7lWTqJfkJQt1tawTRAwjaiQ66BcGg81MVoso34Zg6Jk5pNx2/aA9kY5uQ9Vqm9C51CZu9z9UH5R9TV+uIlmwbpF3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228255; c=relaxed/simple;
	bh=bGbOgZ7/GsB8UBgf0LqnNlTJgNKN+fPQoD9ErB4i4UQ=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=S+4Oqvdme/rzGhn5QFwiWE2M/iA2Mk07KXTm4sf81qek5YPl+EzSbZEklL2+Fpcuu9HoKvi6IzMpEdllYm7TOEn8o8Ea4FE9xC9tY3PLyqBCPtweyirMdBMUyqilV9ldEky3bue35aNi/pqWrXOi8yvg81EyY2G77DwKzVSS8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hg7Pa1QZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1MZhBdhakyXXyis3UviwdkIkQ/9gObuVjuoXkcPA6zY=;
	b=Hg7Pa1QZAsPc87fCjsq6ba9K2BaOZkwSazul3hk+V9gYJVapW9mGSBGnyM3elY7ErNSBa7
	V+aLEWSSZoEAaUq+Fx9DRllekXOYuQTJZLlzaK+NmscAbibW+WRa8W+tUjH8flmHKYQg+P
	SKVy93pP99TxPwTTLo0FXgD7Uvg27iw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-O_GMqFPHO-OqoLHMuqV_Ew-1; Mon,
 24 Jun 2024 07:24:10 -0400
X-MC-Unique: O_GMqFPHO-OqoLHMuqV_Ew-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24006195608C;
	Mon, 24 Jun 2024 11:24:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.111])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D0541956051;
	Mon, 24 Jun 2024 11:24:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, v9fs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix netfs_page_mkwrite() to flush conflicting data, not wait
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <614299.1719228243.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jun 2024 12:24:03 +0100
Message-ID: <614300.1719228243@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix netfs_page_mkwrite() to use filemap_fdatawrite_range(), not
filemap_fdatawait_range() to flush conflicting data.

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
 fs/netfs/buffered_write.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 05745bcc54c6..9cbbeeee6170 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -554,9 +554,9 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, st=
ruct netfs_group *netfs_gr
 	group =3D netfs_folio_group(folio);
 	if (group !=3D netfs_group && group !=3D NETFS_FOLIO_COPY_TO_CACHE) {
 		folio_unlock(folio);
-		err =3D filemap_fdatawait_range(mapping,
-					      folio_pos(folio),
-					      folio_pos(folio) + folio_size(folio));
+		err =3D filemap_fdatawrite_range(mapping,
+					       folio_pos(folio),
+					       folio_pos(folio) + folio_size(folio));
 		switch (err) {
 		case 0:
 			ret =3D VM_FAULT_RETRY;


