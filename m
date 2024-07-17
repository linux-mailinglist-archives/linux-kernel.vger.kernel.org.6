Return-Path: <linux-kernel+bounces-254953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385729339BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647391C2151A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880BB4D8A1;
	Wed, 17 Jul 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jmk9kOWT"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C03140BE3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207788; cv=none; b=Gc+2wWqOcvsnFTArCTAqppqWCobhrvz+N/nnmTasQfFLLJybxoAvv60lJT3UMzW9RQIznKM/B3mhhN/j1RFv29C2kw4mXO/B1+7LJV2u4sopm7p0F1KYkRXL2TsRX0sP155AE/CvA5XmO3YrFetGJzTEbm+VLXxP4Vf++EhkWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207788; c=relaxed/simple;
	bh=QlYBRFMkqeKj1SrbXGYvXAXZvHVAXeV35XnaMgCh+30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJgbUxU5DGGbEjF+QntBRCv6/0NKfaoRzAA9FIAQNWPT87xRILLJP6cuqFrFZPWtJykE0oZLP5Ed0x7amG9O8eV725u31k5iNVUB6b4YNWRYFhRnjebmgmbyVJGEUoeyaaOrj6rQuYvswNzgM6tsOurnpIrvhiSa1TwdjLYpNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jmk9kOWT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iDA8D
	efekoXWbxjlJxep/Z5r+jMeXIenya8RpdthsfM=; b=jmk9kOWTKOK9LVWQ6WiXA
	j17WmzLmQMyw5ryF8r+tjkHLsiVid7GfLByd5uXIeTLRvfEs0e8jN4UoGfZhVNjs
	2vISev/5RcYdrl1K0U5Y3yCczWu4p6azuroBBsahgmHl56za+8vc+82ZcUhQnlq7
	wCRQk0xeQOgUKBECid9BME=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3Py3Ki5dmGNFmDQ--.41698S3;
	Wed, 17 Jul 2024 17:16:00 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v2 1/2] nvmet-tcp: add unbound_wq support for nvmet-tcp
Date: Wed, 17 Jul 2024 17:14:50 +0800
Message-Id: <20240717091451.111158-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717091451.111158-1-jacky_gam_2001@163.com>
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Py3Ki5dmGNFmDQ--.41698S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry3uw15urW8Ar1UJw1fJFb_yoW8GFy8pa
	n3tF15Jr43J3yDKa1rCr4DXrWrCa17Cr9rua1xGw45Ar10qFZ5AFyqqF1Y9r47Cry8ZF12
	kFyDZr1UWF1Yy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zinYFJUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBMfKWXAmTj9MQAAsF

To define a module parameter use_unbound_wq to enable unbound
workqueue to handle TCP's IO.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..f71d56843e1a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -73,6 +73,10 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
 MODULE_PARM_DESC(idle_poll_period_usecs,
 		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
 
+static bool use_unbound_wq;
+module_param(use_unbound_wq, bool, 0444);
+MODULE_PARM_DESC(use_unbound_wq, "use unbound workqueue to handle IO request: Default false");
+
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 /*
  * TLS handshake timeout
@@ -2196,9 +2200,13 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 static int __init nvmet_tcp_init(void)
 {
 	int ret;
+	unsigned int flags;
+
+	flags = WQ_MEM_RECLAIM | WQ_HIGHPRI;
+	if (use_unbound_wq)
+		flags |= (WQ_UNBOUND | WQ_SYSFS);
 
-	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", flags, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.26.2


