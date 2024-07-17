Return-Path: <linux-kernel+bounces-254839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9493385C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AF43B21E07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79CE249F9;
	Wed, 17 Jul 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K25G2YbH"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B371CA80
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202817; cv=none; b=h7+kcAJj4RtcGSaS2o5eM5guEEAm3HvIneKfrNJzH3YjfEL9k1iBCMRiGVjCS29ScOmR10pCFYJOLeD4QAdITDAq2Tl0Edve+Uj+sjAgRNyavanBmk7QRyM2lL8Mw7My4WY2RjJHQKhtScer8LH2n972EgAdYe6UI/qGk0E7eyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202817; c=relaxed/simple;
	bh=8oyO9EzSTeS1mN1RBQpt2fmbrJfUKWkg3WXEAVWW8X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHhZHmuiD+t86jrCYmBfSZ5KuUdYTjwx7nIHtlyt0lh81/fz17uxujHvtpFfXIenEmJTHnXXy11L4L/fqcRut3xgE5UpkHvMbyiXgUx8JHlpGPokSpBXRGyC38bAPA6UQbkcHw+XZk1W/6LZHTBieKSKKwtb2jIpKIC1POH5Seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K25G2YbH; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wQxVK
	OZRWZH4KWipiQnJFFf46L7FDmYSv688Dpn970w=; b=K25G2YbHuJS9M3WyLTE0V
	XJD8u0v6WMTYuT48wNm/EgbQqZMWYI2edYTZxtnbnEmC/M7asDbRhjjLciM4OGh9
	AU6x81b1Eumfy+YWqn/aemAFebLikHU5SeRM8fmd6IFaHbg5Oh51/ollczPsqb4T
	0Yxw2XAhJ8Hxi47UGZ+Kbw=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3f3ddeJdmTsbxAA--.36565S3;
	Wed, 17 Jul 2024 15:53:08 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 1/2] nvmet-tcp: add unbound_wq support for nvmet-tcp
Date: Wed, 17 Jul 2024 15:52:07 +0800
Message-Id: <20240717075208.87324-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717075208.87324-1-jacky_gam_2001@163.com>
References: <20240717075208.87324-1-jacky_gam_2001@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3ddeJdmTsbxAA--.36565S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry3uw15urW8Ar1UJw1fJFb_yoW8Gry3pa
	nxtF15Jr43J3yDKa1rCr4DXrWfCa17C3srua1xCw45Aw1FqFZ5AFyqqF1Y9r47ury8Zr12
	kFyDZr1UWF1jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zinYFJUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBgfKWXAmTHxfwADsm

To define a module parameter use_unbound_wq to enable unbound
workqueue to handle TCP's IO.

Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>
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


