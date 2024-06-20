Return-Path: <linux-kernel+bounces-222235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A22090FEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140A11F2145B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BFD17D368;
	Thu, 20 Jun 2024 08:20:23 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D535B05E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871622; cv=none; b=ji7WhVDABqMZc79uHOIIn99EdH1tkQJZQBhpvD/J/8grJkfE7aoUs69kE/i85/A/G/zzZW5evVuN2f9eOoduBx4XkjJdgip2VdQyEDDCU90/LdQkiM6RmR6oF1i6WQylnWrbT0AmKuHk1XOgoFO5cNa+0A2nGWCp7M8hQ9dPiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871622; c=relaxed/simple;
	bh=c/wAhG39HQIP7rKsTimE3KHvTHGY6Ujr1nmu3llTxUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=seCkuK2GqSQaKA8/nB/8mTMD4vSKo1dMP7MwF3mj8IILR1Bc7DfXa4XyOoS0xOJirhvoErsaqIKfpdyEnR46XexcQYxiScUl2SEot5MYwE7cpsJSLaVccZ+HOZgxbF3NYs+amSb8EJrCSEatugwbhOsQagHy5BtBkSDFzjUAZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAD3_uYt5nNmhTHMEQ--.23651S2;
	Thu, 20 Jun 2024 16:19:58 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: richard@nod.at,
	chengzhihao1@huawei.com,
	s.hauer@pengutronix.de
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] ubifs: add check for crypto_shash_tfm_digest
Date: Thu, 20 Jun 2024 16:19:26 +0800
Message-Id: <20240620081926.1135571-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3_uYt5nNmhTHMEQ--.23651S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry5CryxCF4fGr18tF4ktFb_yoWDJFX_Cr
	48Ar1fGrW8GF1kAF13Gw48Cw12g3yq9FWkWFW0vFZY9rW5CFykWwn3XrZ5GFWUuryxZFnr
	CayvkryUGry3XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8ZwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUY_MsUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of crypto_shash_tfm_digest() and return
the error if it fails in order to catch the error.

Fixes: 817aa094842d ("ubifs: support offline signed images")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Update fix tag.
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


