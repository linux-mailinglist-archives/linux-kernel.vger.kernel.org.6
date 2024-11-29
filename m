Return-Path: <linux-kernel+bounces-418391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A29D6120
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1213160344
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A991DED45;
	Fri, 22 Nov 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mau/O6Ae"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7961DED5A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288288; cv=none; b=e6ipmfuWbfD3SUsPqZ01EhaEJ3+R//ISw/HiR5Fp23Dd2Zxum8MNh7qeRLLgPZ007kjg1JCfSB02YvljW1YJ+dmcoCyGzgMkzxpE1uzaqPphyXNGkENssccmRKw0xAgkiIu8fV4KFURO/Ex9rTbgKKP+tTy/8AuZ5kl4sw7AXHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288288; c=relaxed/simple;
	bh=Pn9mI/dQRJTaJqS3r4xCnRL05yuMMT3XBgLbATZWtGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnlP7zBRY5nhQTqH4RSoxyFuT83NXMfBMwTtxuyBnn1kiYswrSKEJjp+uUwTo0ZUzx9ueJM3xSsDYMY3s4mSdjf8cbY+j2xc7/ttzRMAHaR7GctH+FVOK9RBYLsno8EkjLpjTAGZb7gHuxjERFaH+/v9AyzW00CqNih7NUBFV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mau/O6Ae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732288286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNb3xWwgY1tmNqWYiqE8zMLxs0w6BlPv0Y++bDq5l+E=;
	b=Mau/O6AeG10qkLzGSmNA3CxK35pwtUorGohOJTx5cOomjzG0FpcjTR4vXBKT8bjYshOaL0
	R2x/O042kX0YvuAfMsj7Uf2IVgu2yty+rI6yWtzBeBCp95Fg/kaOqNq6umAdtAQ+fkjFYN
	gi/r2ttNKU/3cZshOV4lVBISqG/UnYQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-4gHOWNWnMuKkjr1N8XK0oQ-1; Fri,
 22 Nov 2024 10:11:22 -0500
X-MC-Unique: 4gHOWNWnMuKkjr1N8XK0oQ-1
X-Mimecast-MFC-AGG-ID: 4gHOWNWnMuKkjr1N8XK0oQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 111071955E91;
	Fri, 22 Nov 2024 15:11:18 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4905195E481;
	Fri, 22 Nov 2024 15:11:16 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 2/2] nfs/blocklayout: Limit repeat device registration on failure
Date: Fri, 22 Nov 2024 10:11:12 -0500
Message-ID: <015eaf84cc15050f8ef461777c59753ef5deb521.1732288202.git.bcodding@redhat.com>
In-Reply-To: <cover.1732288202.git.bcodding@redhat.com>
References: <cover.1732288202.git.bcodding@redhat.com>
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


