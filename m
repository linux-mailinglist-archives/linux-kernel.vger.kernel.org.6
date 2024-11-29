Return-Path: <linux-kernel+bounces-418244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2479D5F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2DA1F23842
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31971DE8A5;
	Fri, 22 Nov 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1H01eL3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE711DEFCF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279686; cv=none; b=TSFt5/du2RyF3jDw4MuJue4sA5iA+wMt0SSfnr6l1UhtOCNGt/hdY+LfBu8KLfPDJdw1n5w4MAZTAH3irxoe97PiucHScdXceYa1liq2x0iDnwySknMAVBzhRTfg25lf8y+sgFn9olk3r/1T568RDoO3iIYWuZIYjF6ZIqOLsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279686; c=relaxed/simple;
	bh=Pn9mI/dQRJTaJqS3r4xCnRL05yuMMT3XBgLbATZWtGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuZi1Kn5oeRkz95GJkvVTI0vmNhG65asDY7sjKLfg7zeFTVFS6e4sNjY0kwJD6xnqkwiTKo+t6XmIkQyod8u5yprLVaROJM4GPSUWnZSYqyNxfB4cT7Qi3HzAKWARK6yYwZBjoWEOJT3lrXy5p0K+s8NE/WiQnfwALkA0Qr0mgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1H01eL3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732279683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNb3xWwgY1tmNqWYiqE8zMLxs0w6BlPv0Y++bDq5l+E=;
	b=D1H01eL33mB0yPOKd7sfHDP+2+82IgXL56VsU65Kvn89s8zvPigAQunkLlJkyGjo2ix+QD
	rOQoJOWUOcOUO3dH4UTVMRSrhpg6DOAxYNpLt41djnVKTLd5B6YLGZ1eWc/Q0H+q5fmAa9
	x81rBS72AG/+hMFyO9RivtHcxyS8KVg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-hztCC2EUO-CgUAaN05eGZg-1; Fri,
 22 Nov 2024 07:48:00 -0500
X-MC-Unique: hztCC2EUO-CgUAaN05eGZg-1
X-Mimecast-MFC-AGG-ID: hztCC2EUO-CgUAaN05eGZg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDA571955EE8;
	Fri, 22 Nov 2024 12:47:58 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44A2B19560A3;
	Fri, 22 Nov 2024 12:47:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/2] nfs/blocklayout: Limit repeat device registration on failure
Date: Fri, 22 Nov 2024 07:47:53 -0500
Message-ID: <b7ec971b37e41c82c38f7dbb860d5e7009567db9.1732279560.git.bcodding@redhat.com>
In-Reply-To: <cover.1732279560.git.bcodding@redhat.com>
References: <cover.1732279560.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Every pNFS SCSI IO wants to do LAYOUTGET, then within the layout find the
device which can drive GETDEVINFO, then finally may need to prep the device
with a reservation.  This slow work makes a mess of IO latencies if one of
the later steps is going to fail for awhile.

If we're unable to register a SCSI device, ensure we mark the device as
unavailable so that it will timeout and be re-added via GETDEVINFO.  This
avoids repeated doomed attempts to register a device in the IO path.

Add some clarifying comments as well.

Fixes: d869da91cccb ("nfs/blocklayout: Fix premature PR key unregistration")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/blocklayout.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 0becdec12970..47189476b553 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -571,19 +571,32 @@ bl_find_get_deviceid(struct nfs_server *server,
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * Devices that are marked unavailable are left in the cache with a
+	 * timeout to avoid sending GETDEVINFO after every LAYOUTGET, or
+	 * constantly attempting to register the device.  Once marked as
+	 * unavailable they must be deleted and never reused.
+	 */
 	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
 		unsigned long end = jiffies;
 		unsigned long start = end - PNFS_DEVICE_RETRY_TIMEOUT;
 
 		if (!time_in_range(node->timestamp_unavailable, start, end)) {
+			/* Uncork subsequent GETDEVINFO operations for this device */
 			nfs4_delete_deviceid(node->ld, node->nfs_client, id);
 			goto retry;
 		}
 		goto out_put;
 	}
 
-	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node)))
+	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node))) {
+		/*
+		 * If we cannot register, treat this device as transient:
+		 * Make a negative cache entry for the device
+		 */
+		nfs4_mark_deviceid_unavailable(node);
 		goto out_put;
+	}
 
 	return node;
 
-- 
2.47.0


