Return-Path: <linux-kernel+bounces-257059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FF99374A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F7B1C21014
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CC65811A;
	Fri, 19 Jul 2024 08:00:55 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F963D0C5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376054; cv=none; b=NvtwNY+NFKOExuzALMU56bd8UbvOUJJ9z/OHV2PV+qQdMsSDqT2YXMZ03Vy6jfuPHUZS2oXsCOJzrF3Ih3gv8QMleWB9aDXyS5lhc0j/fmgYRmNvuU/3EzNOo9bxcn7bcL2dkcUqNkJmx+iJ/1fdcVA9eMkvbg1jfRtCIoYy/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376054; c=relaxed/simple;
	bh=GHk3NCYXJABeP0EV2y1ssGcX8mjL933jkBuG2PcNa54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yn06buLZm/thRNNeMW1ofoCR1tm43dPgSMSAiF4iyhI427eYc4RLTZ2GijQkoS3d9WEgmucFMz1b2HIEbAJzHxfxzmBgNujKB1TwRaLKTV6Gub9p9UZ28LDo7tRLoIYWJKXFnSPRVnJmX8k5O7YQaPJh3dHGutWmfz8reiIgBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4a9020c845a111ef93f4611109254879-20240719
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c469b185-7f90-448b-a895-3d5068216d4c,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:fbe29f63551dcafcad8314dd4c5b9e2a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4a9020c845a111ef93f4611109254879-20240719
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1551760827; Fri, 19 Jul 2024 15:34:11 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 515B6B80758A;
	Fri, 19 Jul 2024 15:34:11 +0800 (CST)
X-ns-mid: postfix-669A16F3-21356159
Received: from localhost.localdomain (unknown [10.42.12.106])
	by node2.com.cn (NSMail) with ESMTPA id A6489B80758A;
	Fri, 19 Jul 2024 07:34:10 +0000 (UTC)
From: Yufeng Wang <wangyufeng@kylinos.cn>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH] netfilter: Keep the same format in struct
Date: Fri, 19 Jul 2024 15:33:50 +0800
Message-Id: <20240719073350.116347-1-wangyufeng@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

add some tabs to keeping consistency format.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 drivers/infiniband/core/cma_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core=
/cma_priv.h
index b7354c94cf1b..261431e00820 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -99,7 +99,7 @@ struct rdma_id_private {
 	u8			afonly;
 	u8			timeout;
 	u8			min_rnr_timer;
-	u8 used_resolve_ip;
+	u8			used_resolve_ip;
 	enum ib_gid_type	gid_type;
=20
 	/*
--=20
2.34.1


