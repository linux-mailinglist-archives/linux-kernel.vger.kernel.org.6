Return-Path: <linux-kernel+bounces-421083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39EB9D866A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA5169ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041F1AA78E;
	Mon, 25 Nov 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="Xwanjh2M"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E51ABEA0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541378; cv=none; b=aA19iBvev97y136zViaunFDc8hXMX3K/hA73Rp5o7bNJTr3K1lVa/pUOjXE++nSxMzIoYUDyrB2nOcKN04dbmQaw58JuSRUFAZccLqL0Qd2103jxjaLtWtF178Ydfupu9j8TDyCF9uOMES7XsPZpoCPQ3ZHaqf5IY5SedfO6lm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541378; c=relaxed/simple;
	bh=OOsD9fBJjMu50Pmv0cpFdii5Yj62JWSSNcTfASK5nI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bUHaFfwyx7ek1yrvCV60l/j55G4UE31NARel4+Bu5MID8TtYomcSCzK4/W6WaBi+MMvbhsrVo2zCBEppuKU3tssHySzG7B9jO1UKQp9tM68LXv8u/L0Fdm9UOI9h6E93/0my9t2WRsgkcy7dCbPn1BftdqXWh5T//POdWuN/xV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=Xwanjh2M; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1732541034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LFKDfOJD5MtsvM9qPgyBIcDPWdEyT/n1xOdmdxQMH/U=;
	b=Xwanjh2Mf1uPIgyu0Y6ffQ2pqj3KN5z1ZCDYAYmYyxCZtRFN9HK5ZD56PUJqYP/hHPDDsu
	qtSb0ebngnhjyLHLGgwlnPKvrmTRtf2L28UPw3RcR3DfJnXHN2z6+VA0IOiYUlqM1DNwvD
	z7I4etOQIJHpqBA6/lLcHLx+9k6n84M=
To: Richard Weinberger <richard@nod.at>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: ubi: Added a check for ubi_num
Date: Mon, 25 Nov 2024 16:23:54 +0300
Message-Id: <20241125132354.16188-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a check for ubi_num for negative numbers
If the variable ubi_num takes negative values then we get:

qemu-system-arm ... -append "ubi.mtd=0,0,0,-22222345" ...
[    0.745065]  ubi_attach_mtd_dev from ubi_init+0x178/0x218
[    0.745230]  ubi_init from do_one_initcall+0x70/0x1ac
[    0.745344]  do_one_initcall from kernel_init_freeable+0x198/0x224
[    0.745474]  kernel_init_freeable from kernel_init+0x18/0x134
[    0.745600]  kernel_init from ret_from_fork+0x14/0x28
[    0.745727] Exception stack(0x90015fb0 to 0x90015ff8)

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 897a316c9e6f ("UBI: handle attach ioctl")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/mtd/ubi/build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 30be4ed68fad..dae569f48b87 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -920,7 +920,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 			return -ENFILE;
 		}
 	} else {
-		if (ubi_num >= UBI_MAX_DEVICES)
+		if (ubi_num < UBI_DEV_NUM_AUTO || ubi_num >= UBI_MAX_DEVICES)
 			return -EINVAL;
 
 		/* Make sure ubi_num is not busy */
-- 
2.25.1


