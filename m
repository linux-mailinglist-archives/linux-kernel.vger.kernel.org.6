Return-Path: <linux-kernel+bounces-222023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0004A90FBC2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21D728352B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188641CD2B;
	Thu, 20 Jun 2024 03:46:32 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81340639
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855191; cv=none; b=It35yjKocOLO9jaDP3T1XyoHFKg13Fos7AFCEt4vmfwriQr5NwLTjFTpn6MjBvvmFiP/aSglcS2+ueAZ4LgDbWGpgJSjWJlCoP05N3hQErgU4wzGlJy1jc1bWKedf+W16AmQ1uLN0+vSLbCUbb0JNd0w5UHcnlbeX61Ra+HKYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855191; c=relaxed/simple;
	bh=29WlvOM8QR8Wz5yC80WkeBsMUSMw91ypMOiwUVjcEgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ML3CsyqAax3l1a6deq6eToIfE/2MiGVsb33VujRxOnv0LD9mTPF4bcXIotFFv/jGypI4QBDC9U3kMc8L6Th6phP1mYTqKeXvrjXHOAAdPsBNe+qcRHsJUwV3kNrKmkQn6qjNRu08r6QQqFWM0YlWr0GVlssO7z5kbGWskgqBBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAB3mSb1pXNmrMV9EQ--.59099S2;
	Thu, 20 Jun 2024 11:45:57 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: richard@nod.at,
	chengzhihao1@huawei.com,
	ebiggers@google.com,
	herbert@gondor.apana.org.au
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ubifs: add check for crypto_shash_tfm_digest
Date: Thu, 20 Jun 2024 11:45:33 +0800
Message-Id: <20240620034533.569099-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3mSb1pXNmrMV9EQ--.59099S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWrJw48GF17AF4kGFy8Zrb_yoWfuFb_Cr
	48ZF1fGrW8GFykAFW3Cw4fCw12grZF9FykWF40vFW09rW5GFykWrnxXrZ8GFWDZry8ZF1D
	Ca1vkry5Cr1aqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r48
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYnYwUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of crypto_shash_tfm_digest() and return
the error if it fails in order to catch the error.

Fixes: f80df3851246 ("ubifs: use crypto_shash_tfm_digest()")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 fs/ubifs/master.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
index 7adc37c10b6a..a148760fa49e 100644
--- a/fs/ubifs/master.c
+++ b/fs/ubifs/master.c
@@ -67,10 +67,13 @@ static int mst_node_check_hash(const struct ubifs_info *c,
 {
 	u8 calc[UBIFS_MAX_HASH_LEN];
 	const void *node = mst;
+	int ret;
 
-	crypto_shash_tfm_digest(c->hash_tfm, node + sizeof(struct ubifs_ch),
+	ret = crypto_shash_tfm_digest(c->hash_tfm, node + sizeof(struct ubifs_ch),
 				UBIFS_MST_NODE_SZ - sizeof(struct ubifs_ch),
 				calc);
+	if (ret)
+		return ret;
 
 	if (ubifs_check_hash(c, expected, calc))
 		return -EPERM;
-- 
2.25.1


