Return-Path: <linux-kernel+bounces-537687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372ACA48F17
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B023B3AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604F18C008;
	Fri, 28 Feb 2025 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwAHtvMk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6414A4DF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713167; cv=none; b=HzUoVha8T10HGaqVJef/oPuT9QUKqxQIxODMZen1bNarHZvMsGkxZgRoU0AlXKw5WJaRkMfMUXZ7nJF9C9gIUVYcfMhuGhur9CQxuP5Q2q6omLl/pQJlHks7MUeBEgU2zZaeLoNXMDLkYkou0PDf20Xd2oCFMnyx6aON9gmabgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713167; c=relaxed/simple;
	bh=MrAX5gf3asz7d67qP34+Mdon0sRLA6xUv9Sut1h/bwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=M1L7SQyu8fSJB0Gkg+uMD+elAVCwTVho2lO2WRyagRAJBcujCnrLyoPqDna92ewTGiiRHtcIiKYjGNBWvpley8c/KTzhfcqjDX1jyFIZN+JqoX0Pdfj7ke8HD5gtW339bHOy/ez/I+yIxtYjMl/rk42a9eon8rQd44GlVlFdTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SwAHtvMk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740713165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IP0rVGLccAQop086ZZXP2hGbaZD9tbaXKoP4vlHgFdg=;
	b=SwAHtvMkdHaPBldrAf84v44EJG9DKDWP5qAcjh2w5hz7nlktmTvxN4SvmMEEJ36Xd+ftEZ
	WjTDI3uUDTF4E+HcQgJ2m9ARp8rt0k6ATAAKtOOWmnOo/+pRcCEEVrKGkde2GTnR+kE1IQ
	rr84v0Uf6JEhzGlzN4vwr3fpvS4sRLw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-H7aDcUvoO2-qvES-9l8rIg-1; Thu,
 27 Feb 2025 22:26:00 -0500
X-MC-Unique: H7aDcUvoO2-qvES-9l8rIg-1
X-Mimecast-MFC-AGG-ID: H7aDcUvoO2-qvES-9l8rIg_1740713159
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F1A5191815F;
	Fri, 28 Feb 2025 03:25:59 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.88.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DA6C180035E;
	Fri, 28 Feb 2025 03:25:57 +0000 (UTC)
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
Subject: [PATCH 3/4] nvme: update the multipath warning in nvme_init_ns_head
Date: Thu, 27 Feb 2025 22:25:40 -0500
Message-ID: <20250228032541.369804-4-jmeneghi@redhat.com>
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

The new NVME_MULTIPATH_PARAM config option requires updates
to the warning message in nvme_init_ns_head(). Remove
the old warning message and add new ones.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 818d4e49aab5..c2b7e6834535 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3823,8 +3823,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 			dev_warn(ctrl->device,
 				"Found shared namespace %d, but multipathing not supported.\n",
 				info->nsid);
+#ifdef CONFIG_NVME_MULTIPATH
+#ifdef CONFIG_NVME_MULTIPATH_PARAM
+			dev_warn_once(ctrl->device,
+				"Shared namespace support requires core.nvme_multipath=Y.\n");
+
+#endif
+#else
 			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
+				"Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
+#endif
 		}
 	}
 
-- 
2.48.1


