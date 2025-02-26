Return-Path: <linux-kernel+bounces-533431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E437A45A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F9516D4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D5F224255;
	Wed, 26 Feb 2025 09:29:02 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E282135C8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562142; cv=none; b=H6RFugQQevRs4RkVMloFMWAg8pYI3wotxHWtF++posBd9En6CXfGcIXzyK3B5NEXAcixVKs72XZGuSj9JghY1TeyUgbRLYPqtx/xtO1KbVcXztYaz1Ignau1gCn5AToLAUHXIvwo4WOsNlwSd/oocVq95F8+sf1dSckXTVHMa+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562142; c=relaxed/simple;
	bh=a+F458GU1I94B8Pd1fiZZSFktaTFIM7f8pqraQhH+8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X+YTntUTApqsgolvW+ruPFZKQkCiSKJIkKOkHRT+MfAGLCol8sLMEQe+MN4F6qDldjZhARlfpCWaqEx+uwzEl5JUIwvy0xzM1sy1osqX40PzaGiFIJisKf0rtAm0huntMD+vZaW6SlFCT/S6kuDN5X1NAug0tkeZxWZN+OASQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z2q0Q5GHWz4f3jqj
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:28:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 414CE1A0847
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:28:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCXU2bV3r5naYetEw--.50393S2;
	Wed, 26 Feb 2025 17:28:55 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: swap: fix build warning when CONFIG_SWAP is not set
Date: Thu, 27 Feb 2025 02:25:11 +0800
Message-Id: <20250226182511.592796-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXU2bV3r5naYetEw--.50393S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW5JF48Xr1xGF4rArW3GFg_yoW3Grc_u3
	s3JayrWr4kGF1xuwn2kas2qFyaga4xWr1DuFn5GF12vF15Aan5twn2gryfXry7W3Z7CrW8
	J3W8ur4fZrnFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Fix build warning that folio_alloc_swap is defined but not used when
CONFIG_SWAP is not set.

Fixes: b79768ab943cf ("mm, swap: simplify folio swap allocation")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 include/linux/swap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3a68da686c4e..d1f5414ea537 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -587,7 +587,7 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
-static int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
+static inline int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
 {
 	return -EINVAL;
 }
-- 
2.30.0


