Return-Path: <linux-kernel+bounces-560497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4FBA6058C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4658618895BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED91FF1D9;
	Thu, 13 Mar 2025 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVK4D7K3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AD1FF1BB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908872; cv=none; b=a6MKRHvRTKGJsUA9dGE0Q1XzwADjqOp+FGijs7va2eTsIOUosZ8EYPIEJYN7NgW+1TRyVYwhmJpIbNj6ofKperm2wvYHPvYCMY2tFCGyvSGGaJI2Ct2tZdtGFJCUCHgyNnY8VpFEc2W2ju7GoTeTpudt0QA+wEkZZSuGNqNIaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908872; c=relaxed/simple;
	bh=Q9soLd2gAe8fV27/2nYtXayub2OpW4/N73rjy8kjx90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Us1GwuVtxuZQqLJj0xOxOTBHDSzGBnX3BNDLBIdg8/QvYIGIy4gDTfThy045fFlEUzH1s7NelQoOc6jR5oNH7g5jVP3GYNL5qJhfcBjCLaA//r2sFBnwiHqxXvSMpIyT2EqzBo3jeCAVMpSh1YdFUaIkSBcM6+aYdXfdvU+gOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVK4D7K3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SV4UUXX2sAfU6Pjn2rOfZC7Y+xeVVFMspmAQi4dcP3Y=;
	b=LVK4D7K3qQeFDg+OaEXDs4Y9D5spC3rBrTWOcJs1nAWn/dGilX1+zBuz8J7iAcbHZAsBMz
	kK3CMb/3RtmhDc8XS4qOAbFWgt2Y3Sz1+cfEv8nFguBM7S4M2i6UvPCmxPVK5Hwy1GkbRj
	p7FCmm8jBp18N3CPROaF93lJrSZwX20=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-nBsrPFlQOiWFKoi4vVyX-Q-1; Thu,
 13 Mar 2025 19:34:26 -0400
X-MC-Unique: nBsrPFlQOiWFKoi4vVyX-Q-1
X-Mimecast-MFC-AGG-ID: nBsrPFlQOiWFKoi4vVyX-Q_1741908864
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A68F11955DDD;
	Thu, 13 Mar 2025 23:34:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6553F300376F;
	Thu, 13 Mar 2025 23:34:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/35] libceph: Remove osd_req_op_cls_response_data_pages()
Date: Thu, 13 Mar 2025 23:33:01 +0000
Message-ID: <20250313233341.1675324-10-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Remove osd_req_op_cls_response_data_pages() as it's no longer used.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/ceph/osd_client.h |  5 -----
 net/ceph/osd_client.c           | 12 ------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 60f28fc0238b..fe51c6ed23af 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -528,11 +528,6 @@ void osd_req_op_cls_request_data_bvecs(struct ceph_osd_request *osd_req,
 void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 				     unsigned int which,
 				     struct ceph_databuf *dbuf);
-extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
-					unsigned int which,
-					struct page **pages, u64 length,
-					u32 offset, bool pages_from_pool,
-					bool own_pages);
 int osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
 			const char *class, const char *method);
 extern int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 10827b1227e4..e1dbde4bf2b9 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -391,18 +391,6 @@ void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_databuf);
 
-void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
-			unsigned int which, struct page **pages, u64 length,
-			u32 offset, bool pages_from_pool, bool own_pages)
-{
-	struct ceph_osd_data *osd_data;
-
-	osd_data = osd_req_op_data(osd_req, which, cls, response_data);
-	ceph_osd_data_pages_init(osd_data, pages, length, offset,
-				pages_from_pool, own_pages);
-}
-EXPORT_SYMBOL(osd_req_op_cls_response_data_pages);
-
 static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 {
 	switch (osd_data->type) {


