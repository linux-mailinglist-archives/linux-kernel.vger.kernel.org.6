Return-Path: <linux-kernel+bounces-514454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD97EA35733
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68DC16EBED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D1020371F;
	Fri, 14 Feb 2025 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPD8SLZN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA26204C2D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514937; cv=none; b=VuC8FEb5oXb39QvT2Rg1GfYYkVOL+2dnMSSNoKLCIGzE3sfqUel3Cx4g5qLGHGHgxxAerzBstQIQ/SGnI7el0GrKarcUMtYB3K5f+G3dfFadUEB8t/nS55+JCBCYmgh463MlZQ6k1y+YOmWkq7ubwLad/KuigEFh5BfjvDJ3aZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514937; c=relaxed/simple;
	bh=UcEUSZc9OebPInQ0Al3t0iyMWevUlwFNWO9ou2IbDbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1FXVF3kXcuMo2xIF80zz/OvoqdfwbFMWrN6wiBkueep8SccB7J/CdhtFHmOoJS7PSHHeBxHNLV+Bn+/9pinW9wmkJT60Q8uJWK7D3LG/ckXYcmFF9iCRz4jk+DTWjm2q1C9qBYK+xW8+yysGEGxV6W8Nm+C2dvmHndd506u57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPD8SLZN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739514934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=De1ohsiMKU4xXRlb1xhOFvEfcarCcaBHb7jaQDpDfMc=;
	b=jPD8SLZNHx3631S/EpVg/uS6ip/uJ+Yei7DZIyW4Jzd/iWlzLh73WRiQywXL8x8k/LVNSV
	QcJjhQ3NGldAQ5GCeGyEfxzPCn5U+8lqdP5Alt0SzvjtLIaC2xwrHVGQEYKBTI5mBpIjQO
	hYTlKg/+uvPlKGvUPU9FEAMr5FtnmuQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-Yx1g52v7N--YMXUw_Ho_Dw-1; Fri,
 14 Feb 2025 01:35:29 -0500
X-MC-Unique: Yx1g52v7N--YMXUw_Ho_Dw-1
X-Mimecast-MFC-AGG-ID: Yx1g52v7N--YMXUw_Ho_Dw_1739514928
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB0A31800879;
	Fri, 14 Feb 2025 06:35:27 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF319300018D;
	Fri, 14 Feb 2025 06:35:23 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH 2/2] drivers/base/memory: Correct the field name in the header
Date: Fri, 14 Feb 2025 16:35:04 +1000
Message-ID: <20250214063504.617906-3-gshan@redhat.com>
In-Reply-To: <20250214063504.617906-1-gshan@redhat.com>
References: <20250214063504.617906-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Replace @blocks with @memory_blocks to match with the definition
of struct memory_group.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..12daa6ec7d09 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -25,7 +25,7 @@
 /**
  * struct memory_group - a logical group of memory blocks
  * @nid: The node id for all memory blocks inside the memory group.
- * @blocks: List of all memory blocks belonging to this memory group.
+ * @memory_blocks: List of all memory blocks belonging to this memory group.
  * @present_kernel_pages: Present (online) memory outside ZONE_MOVABLE of this
  *			  memory group.
  * @present_movable_pages: Present (online) memory in ZONE_MOVABLE of this
-- 
2.48.1


