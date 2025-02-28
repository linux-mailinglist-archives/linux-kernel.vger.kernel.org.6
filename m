Return-Path: <linux-kernel+bounces-537689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7B2A48F19
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD56116E89E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C921192D87;
	Fri, 28 Feb 2025 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDXfyGX7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608B192B76
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713174; cv=none; b=A3/4CAKN3Z/XptfS58F6bbfJRxEUl1MhgDeVwBNAuF+Z6C7tPr2OY85xVF8Uqr9ZkA9iPA+JoKB9LF97QLrgcTEYFEsOB3yU35rkLgYhQ5iKt0RhhUrwlUWtqD99lP1E6FLrueCYxXKW5SHlYjSoYmSaoWuPbD9Dl8/Yap2UnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713174; c=relaxed/simple;
	bh=azTGRMn5Yx6O4wwQUJFHoxAJafiE4E1uJ0hsOBjUNHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=O10K02rr0s1gCyTMmd5i/yMwwYEGM2NsbhB5K6uYyEORPBEVbaPfEkZbclQhh3m7C1RDDwQzPbKpzT/tY+uUPT3WXFQb9ZDoo0ae/7miwLhM0rHJb9JVPF7G26Fs3fD08iBDjFh0p0oMx+SCsTaM+PmnC2OPQ7uHbR4MBmNok5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDXfyGX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740713172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKStR8dsG/OBwzMqbeiTBAwfOm05XDTOH4bItz+QaXw=;
	b=eDXfyGX7AD5JYX2NYPuJv43UIJyG8I3kY+/N8vpkNzVkGAhoJz8i8Bz4jOAMpfao2pHfXA
	64aYwEilLflN2Nkur9vBcv0HmopnIvk/YE+6sidTI25/BiEyCXYOYbwbszn1T1Vp6/09bQ
	54at6igumwvRFWTnWPuuk6WuB9aZCUE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-QhSVW3QPPf6pyUxRakNLZg-1; Thu,
 27 Feb 2025 22:26:07 -0500
X-MC-Unique: QhSVW3QPPf6pyUxRakNLZg-1
X-Mimecast-MFC-AGG-ID: QhSVW3QPPf6pyUxRakNLZg_1740713166
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B27D41800570;
	Fri, 28 Feb 2025 03:26:06 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.88.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C37D91800988;
	Fri, 28 Feb 2025 03:25:59 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: loberman@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	bgurney@redhat.com
Subject: [PATCH 4/4] nvme: add mulitipath warning to nvme_alloc_ns
Date: Thu, 27 Feb 2025 22:25:41 -0500
Message-ID: <20250228032541.369804-5-jmeneghi@redhat.com>
In-Reply-To: <20250228032541.369804-1-jmeneghi@redhat.com>
References: <20250228032541.369804-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When CONFIG_NVME_MULTIPATH is disabled, add a warning if
we discover a multipath enabled controller with an attached
shared namespace.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2b7e6834535..465069c0f6a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3938,6 +3938,15 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	} else {
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
 			ns->head->instance);
+#ifndef CONFIG_NVME_MULTIPATH
+		if ((ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) && info->is_shared) {
+			dev_warn(ctrl->device,
+				"Found shared namespace %d but multipathing not supported.\n",
+				info->nsid);
+			dev_warn_once(ctrl->device,
+				"Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
+		}
+#endif
 	}
 
 	if (nvme_update_ns_info(ns, info))
-- 
2.48.1


