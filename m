Return-Path: <linux-kernel+bounces-413208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3009D152A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FDAB283A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC1F1BD007;
	Mon, 18 Nov 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYG/Jt+4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F8199EBB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946199; cv=none; b=Wtf4UfDwhhuHRQkT4GpoYsngbqjuePSuiZJ+RSy0GTsQp01+8LPB5zjpHn0dvEMel8+ubv8aiER4lfxwn18+/3Vd54OytyfaTfQB0mKpp+BYNzk3Tuglu+a5DPi9RZutrnjlLLIMMvOGkGsDGgQwQjNwuwuQye48oBtQ7gFE3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946199; c=relaxed/simple;
	bh=DLvHUotzpmttcD6tHVYEnLh8kXfBOyP/7m4vrpMG/iw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=D+auNe2R5gCfi9DyLkqcATVHr3aCUMb9QaM7rdxtRr2IVOc3WXsJu4YqgfbZT3y/8OxPLdneP/LlMLKC1YEu8QQ5s22zn1TPofS6H223CHYZsXMRh+VT/4GqQSRswUL9OT4pwc0/i7Godmb5JMeQWI1kSaMm4ajl4mBi4omu4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYG/Jt+4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731946196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxgyzSzp9bOGvYcyn/XTaZdPQQNIJ/nIXicWlYUyU/Q=;
	b=ZYG/Jt+4MUE77dvR7UDJS6izGr5QMqwlvAJIGBDSmlusAVIRQEZoAHM/4ujHk7dLy03GiM
	Vl7XAjCiRkh39D4Y9/ToFreO8MpJDqPPPggtuxj7o5+ANu/ILxfdl+j1omXS9TJt1Y3Sey
	COqFCusS6pgyY/hB+W2Ef3T/alY6qGU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-DgPAg4D7M8KyoDjP_tsN0w-1; Mon,
 18 Nov 2024 11:09:53 -0500
X-MC-Unique: DgPAg4D7M8KyoDjP_tsN0w-1
X-Mimecast-MFC-AGG-ID: DgPAg4D7M8KyoDjP_tsN0w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B90841955F2F;
	Mon, 18 Nov 2024 16:09:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C2F91955F3C;
	Mon, 18 Nov 2024 16:09:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <883923.1731943099@warthog.procyon.org.uk>
References: <883923.1731943099@warthog.procyon.org.uk> <20241116063613.15120-1-advaitdhamorikar@gmail.com>
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next] afs: Remove logically dead code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <940272.1731946188.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Nov 2024 16:09:48 +0000
Message-ID: <940273.1731946188@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

I think the attached change is what I want.

David
---
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b6a202fd9926..2adc034603f2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -499,11 +499,11 @@ static int afs_dir_iterate_contents(struct inode *di=
r, struct dir_context *ctx)
 	iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size=
);
 	iov_iter_advance(&iter, round_down(ctx->pos, AFS_DIR_BLOCK_SIZE));
 =

-	iterate_folioq(&iter, iov_iter_count(&iter), dvnode, ctx,
-		       afs_dir_iterate_step);
-
-	if (ret =3D=3D -ESTALE)
+	if (!iterate_folioq(&iter, iov_iter_count(&iter), dvnode, ctx,
+			    afs_dir_iterate_step)) {
 		afs_invalidate_dir(dvnode, afs_dir_invalid_iter_stale);
+		ret =3D -ESTALE;
+	}
 	return ret;
 }
 =


