Return-Path: <linux-kernel+bounces-257367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AC5937918
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903C01F213DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FBC13AD22;
	Fri, 19 Jul 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwNFe0TS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472201DFCF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398751; cv=none; b=YFuB2igcwvibASWDjdw8NSC6lvB5cSIeHM8FUJ/Izq0yClM/FympTZIkkc1Ls/ja9G4ETA2NX6UuC5c7bDZPNSgIneZXgp4wgpjmtr9hMNUy8xbsKnydx6apIwaAVjjmIurXBS/2V4jf9lxwY9IjbkEvzbBCKh5etYdjFypSeFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398751; c=relaxed/simple;
	bh=CJIPhlfBlUMDMV/89sEaAGXBrDUW7QE7vTBzAfcnh6g=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=ALDRgyajHEtd7Am8Whfkh06v8cpfWOy0fjrxyFi5vtBsEdrpaY7y4diQW6Hm/9QJjr4RhBNfnedb+CXwpow1wONo03thXbNFDVQCacMaAx/aJphU32ee8hxbqa8WsnAeUr4lCRVOX4Kp1swHnDYrBuJTIJdQdsXc3qgqAZyYIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwNFe0TS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721398748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bPugR8XUkKZD2tPr8gb175R01ID5DlxXZDQPfCbn+k4=;
	b=DwNFe0TSyCJhjhVOkYlf8BS3inYUCr+BClgZhGWf/8xKw/ym+IoDCFZRTEsHKqJE9dcVla
	snBx6j/5eImZNvNHTn1/7m47pd7vbBB71lzmBveQCqtl6hj/0l+HlRRjG5dtyxPiuWeFG5
	LaVxfqd5mSOXiG6WyEIE8+mmCMiGx9s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-FG8ETpPDNfOok-FZM7qJXA-1; Fri,
 19 Jul 2024 10:19:06 -0400
X-MC-Unique: FG8ETpPDNfOok-FZM7qJXA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DD6D1955D44;
	Fri, 19 Jul 2024 14:19:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F6453000188;
	Fri, 19 Jul 2024 14:19:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: Set the max subreq size for cache writes to MAX_RW_COUNT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1599004.1721398742.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jul 2024 15:19:02 +0100
Message-ID: <1599005.1721398742@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Set the maximum size of a subrequest that writes to cachefiles to be
MAX_RW_COUNT so that we don't overrun the maximum write we can make to the
backing filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index e667dbcd20e8..a91acd03ee12 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -630,7 +630,7 @@ static void cachefiles_prepare_write_subreq(struct net=
fs_io_subrequest *subreq)
 =

 	_enter("W=3D%x[%x] %llx", wreq->debug_id, subreq->debug_index, subreq->s=
tart);
 =

-	subreq->max_len =3D ULONG_MAX;
+	subreq->max_len =3D MAX_RW_COUNT;
 	subreq->max_nr_segs =3D BIO_MAX_VECS;
 =

 	if (!cachefiles_cres_file(cres)) {


