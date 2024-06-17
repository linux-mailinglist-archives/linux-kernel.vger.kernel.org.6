Return-Path: <linux-kernel+bounces-217367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987BC90AECB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5647E1F27917
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD27197A62;
	Mon, 17 Jun 2024 13:13:42 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93520194AC7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630022; cv=none; b=ISqg39EN1f9NG190uoBiNyuJ5sQ4RUZZdc9TjHbEE+HL9PTzFLZ3yTd0nLZBuydfI44Ug6Kmy2FhwAtp43az244se3H5GvnDwtX2K/5p+bpw7QTi13GfEc0xmNuGCFzo2U+DTF3oKMmzjhN5W55+/moYlSqEcCI5aFaM1nmH8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630022; c=relaxed/simple;
	bh=JSvHKg6TQXAX+y915eIRoWzB8BseBrcjuluWTcq/bPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZLaKv8K36lWZduaI92cvcCbtoSchi9JNhXSpltIUrUmU6gWBtEQ1jENGVxkc4bELAKbKRA+sP51BlZbAicNbNVZIYtFPMtrXL/78RgJb4eAYy0hn4GKrW2g5bu9CYZK9is7ygfSsEh5DLzp/jffnxSXA+o++W27ClaL8vy/b0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dapustor.com; spf=pass smtp.mailfrom=dapustor.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dapustor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dapustor.com
X-QQ-mid: bizesmtpsz9t1718629912t5494vo
X-QQ-Originating-IP: ofoZGaY66B9E0Bp1eAiohtnrFFlyHG0pri1WEVYLtFM=
Received: from localhost.localdomain ( [14.154.190.47])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Jun 2024 21:11:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 103092901695252679
From: Boyang Yu <yuboyang@dapustor.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Boyang Yu <yuboyang@dapustor.com>
Subject: [PATCH] nvme: fix NVME_NS_DEAC may incorrectly identifying the disk as EXT_LBA.
Date: Mon, 17 Jun 2024 21:11:44 +0800
Message-Id: <20240617131144.48955-1-yuboyang@dapustor.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:dapustor.com:qybglogicsvrgz:qybglogicsvrgz6a-1

The value of NVME_NS_DEAC is 3,
which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS.

Signed-off-by: Boyang Yu <yuboyang@dapustor.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3a41133ac3f..68b400f9c42d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -502,7 +502,7 @@ static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
-	NVME_NS_DEAC,		/* DEAC bit in Write Zeores supported */
+	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeores supported */
 };
 
 struct nvme_ns {
-- 
2.27.0


