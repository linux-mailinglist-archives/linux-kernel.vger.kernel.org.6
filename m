Return-Path: <linux-kernel+bounces-257125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1811C9375A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4365A1C20A38
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9B81AB4;
	Fri, 19 Jul 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B20CM3Xe"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8E55769
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380900; cv=none; b=BO2OfCX++bR86P8npxZjgwWwuOhZZqne8rRT2/QfQuExGmX5Zo1dEkyR0g6ORK3qP0GMyaF9X/qGoweoUyH0c46+S70/wMZ9xBvly6qjJ3alM45Axpks5eXnn1sYArR0Ahx/QZUloWY5uGoyFxZg6J96ZHbpyzqwa+VDs59xZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380900; c=relaxed/simple;
	bh=cXsqOgV1+RWublgGnrH5XcTfDg7utqck/b7P+P/DMe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h/uFon3mR5/uEbZXWkXXZ6WQbjagPhmfJcLbwmPIc8a9hgRW5+LH1xsB7+9Tjd/GIHylTGVdtuF6hlnGKwO9RgmhqZYXg+gxVKL6aykSbuwhXzmeqQaxQfp6r9SBftXfw0oPPoLMvrSbKe5QZgv5oKRaLbDa5N6eKtk8QHnFcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B20CM3Xe; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3vPSe
	Dl9n8z+pPPisPVMQCbT+t7gDo4bPrvBM8+Mcq4=; b=B20CM3XesBrphotd7hjQl
	MiBn42YKDZ9pImFMsY7DbImDydknR+wo9yKYo9igP0rearoyEMre3re83I+UkstU
	XMBJDkPbmYE8JJ44OBkhvlzP1veY0OQm1wflkPSn9K69izS8yJOCWa9aRNvYgSqe
	EaUY7WZmGSEVrovKKO398Q=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3T3X7L5pmYK8DAg--.13202S3;
	Fri, 19 Jul 2024 17:21:09 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v3 1/2] nvmet-tcp: use unbound_wq for nvmet-tcp by default
Date: Fri, 19 Jul 2024 17:19:58 +0800
Message-Id: <20240719091959.17163-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240719091959.17163-1-jacky_gam_2001@163.com>
References: <20240719091959.17163-1-jacky_gam_2001@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3T3X7L5pmYK8DAg--.13202S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4rZw1rur4xWry3tF1UWrg_yoW3CrX_Ca
	48Jr1DGF1v9F1qyrW8Cry3uryIkw1rX3Z2yan3Kry7JryfZF45ZwnYvFn3Z3s3Zr4rAF9r
	ZrnrJrn0yrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtHUqUUUUUU==
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSAkhKWXAmWHsaQADsS

To use unbounded workqueue to handle TCP's IO by default, which
was discussed in below session.

https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..35713472e395 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2198,7 +2198,7 @@ static int __init nvmet_tcp_init(void)
 	int ret;
 
 	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.26.2


