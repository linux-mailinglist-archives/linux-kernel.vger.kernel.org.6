Return-Path: <linux-kernel+bounces-188922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA42D8CE88E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EEB1C20C15
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC312EBD2;
	Fri, 24 May 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1P/oKeC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A1C12E1CA
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567486; cv=none; b=ovoL2LwD5xSEmtp+3uhgGdmfOuZbzduThwfhJkpEkwkueRX3ykUjaB8BWnm2EyyrPqVC9rU8WuKicdOqjyPSi6jscZjuRWdfHip/gyM653/9U+/vDRH5BrpIj4mq9shd0UK7CtN+GzFSL6wo/YZ0MmekAOkiEItIsqulfmhlc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567486; c=relaxed/simple;
	bh=omAssB6I02yj+x+pz+EEXEalHt+q5NCe67eht1huW5c=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=bMz4NTH31VVf/e2SeGhmey6FKoAtA0TCta1MmbBtrvsfuSdCHRHBMaTk39fhps8kRgYdL6aUfKI+Ko/nd+TPhXWVAuVqxKq7DlimQ5s3OMOFtbWPub5DvITPcnqbaSmtTP/7HsEMImJxHq1ifkQJXd57s78X+Don4XqMEYrvbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1P/oKeC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716567483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vHjClk8E6ZL5CAwbbjUXeTWTpXpzXKPzMEFy1g+hdPs=;
	b=B1P/oKeCE3ZUiTX85+M6cqNtd5BWp65xF5d10saHWsAuMtg+Z6CBTw8kQO2cFrPXhLLVw1
	TUaqLq/b4UyZnk1t0PxBfMKR+jUzeU6eyw+PZD4VmiH3P79IViD3nNoZVTHvRqrUBFzeqB
	jLobxrONmgfPCQ+uJh40mxY6fx3Bg/A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-Y4ybQU0dP5WtwdLUCHbt2Q-1; Fri, 24 May 2024 12:17:58 -0400
X-MC-Unique: Y4ybQU0dP5WtwdLUCHbt2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73C5C101A52C;
	Fri, 24 May 2024 16:17:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D22F2026D68;
	Fri, 24 May 2024 16:17:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com,
    Jan Henrik Sylvester <jan.henrik.sylvester@uni-hamburg.de>,
    Markus Suvanto <markus.suvanto@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jeffrey Altman <jaltman@auristor.com>, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Don't cross .backup mountpoint from backup volume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <768759.1716567475.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2024 17:17:55 +0100
Message-ID: <768760.1716567475@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi Christian,

Can you pick this up, please?

Thanks,
David
---
From: Marc Dionne <marc.dionne@auristor.com>

afs: Don't cross .backup mountpoint from backup volume

Don't cross a mountpoint that explicitly specifies a backup volume
(target is <vol>.backup) when starting from a backup volume.

It it not uncommon to mount a volume's backup directly in the volume
itself.  This can cause tools that are not paying attention to get
into a loop mounting the volume onto itself as they attempt to
traverse the tree, leading to a variety of problems.

This doesn't prevent the general case of loops in a sequence of
mountpoints, but addresses a common special case in the same way
as other afs clients.

Reported-by: Jan Henrik Sylvester <jan.henrik.sylvester@uni-hamburg.de>
Link: http://lists.infradead.org/pipermail/linux-afs/2024-May/008454.html
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: http://lists.infradead.org/pipermail/linux-afs/2024-February/008074.=
html
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/mntpt.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 97f50e9fd9eb..297487ee8323 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -140,6 +140,11 @@ static int afs_mntpt_set_params(struct fs_context *fc=
, struct dentry *mntpt)
 		put_page(page);
 		if (ret < 0)
 			return ret;
+
+		/* Don't cross a backup volume mountpoint from a backup volume */
+		if (src_as->volume && src_as->volume->type =3D=3D AFSVL_BACKVOL &&
+		    ctx->type =3D=3D AFSVL_BACKVOL)
+			return -ENODEV;
 	}
 =

 	return 0;


