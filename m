Return-Path: <linux-kernel+bounces-320500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA8C970B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F0A1C21827
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107310A1C;
	Mon,  9 Sep 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO+ZlE/N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED2BA42
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845764; cv=none; b=NKjGtUx8l6coPGVFGPHtc3glbApNum7kK4yLPUuawGAQdz1lnQn1sJx0WDnwBb0n6A83TtQKhrtjmC0F1DSPa220XPuYEQg6vGy6pZjTgpY93P9h4zyTklzW38CVzbtxFaYju9J1uZMThd2Cjn6nBK6iJ8c037pHJCuyRvs1rRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845764; c=relaxed/simple;
	bh=b1TL6VfkMSGelSbZuz3i/ovmXnm6fRU5ZpQUCeqKGzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uF/ivlNzvXyF8MDhCZvAMiUC+B+jR7a5qE4F3F9QPqmnCm2w69PDLaWvmlYQjEw46fG0Kfhwde0bLkDO0+kbTFCl3GsCJzIx/DQoH2qh57+FGYpml3WNOHKyUA+2eK1dplYUKDIFtNUd0RNfoJp8CPHemvFr2APP746/c9R6fS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO+ZlE/N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725845757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78yJ0rrxnE6exhPYiyoiwtUEzl2VKCruczkggBJ6zeM=;
	b=YO+ZlE/NTbr+FdpRN3DBm9asus44ylQDRqhc16HcseU98pFeV1+D8+blLbJaew0XUVYVHC
	1X6ncxE0PO4mLuKmOpwaUI/X36SRg3eL3QK6zKJtvrREojGgdYj+ql6nPbsMNwsJTwTTgP
	KvV11N675g926+ewJV8CLypD2uaPThM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-pq-bCRioPZSzoE9Y_jFsBw-1; Sun,
 08 Sep 2024 21:35:54 -0400
X-MC-Unique: pq-bCRioPZSzoE9Y_jFsBw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3027E1955DC3;
	Mon,  9 Sep 2024 01:35:51 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EA871956086;
	Mon,  9 Sep 2024 01:35:46 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v1 1/7] vhost: Add a new module_param for enable kthread
Date: Mon,  9 Sep 2024 09:33:40 +0800
Message-ID: <20240909013531.1243525-2-lulu@redhat.com>
In-Reply-To: <20240909013531.1243525-1-lulu@redhat.com>
References: <20240909013531.1243525-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add a new module parameter to enable kthread while loading modules.
This parameter will identify if the vhost will use kthread or a task.
The default value will be true.

Signed-off-by: Cindy Lu <lulu@redhat.com>

module_param
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473..be43181af659 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,9 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+bool enforce_kthread = true;
+module_param(enforce_kthread, bool, 0444);
+MODULE_PARM_DESC(enforce_kthread, "enable vhost to use kthread (default: Y)");
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
-- 
2.45.0


