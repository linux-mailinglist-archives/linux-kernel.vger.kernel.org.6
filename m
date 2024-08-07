Return-Path: <linux-kernel+bounces-277461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2494A1C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5412E1F21E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9122EE5;
	Wed,  7 Aug 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lt6x7LCI"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D21B4C55
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015893; cv=none; b=s/IcdpNLS9FcljHnRytr4e45NY95CfwPBHmODKrbx6HIRtNKgWQs4QnAPyTc7Cz80QRPAZa66DBMBSbcMDIyZon/p1UdywU8PY6lPLvl72NMfg60ygW+uDcpTNUrqRBpbjoE/QILsjai0a0Ta6iApyv4eNRWs1Uxq65FqYJa/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015893; c=relaxed/simple;
	bh=iAUJUbk94tdVgsfiPoEAQ8BuD4PdGJSS1b81vVUZgFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsiwwifiveVWHRRnnttn/I7x3AmGWKXEDcwcVtbcYXGLthH/W8RxVRk5XN5V950wfoJC7qAP08jPUxJzF73C3km0NYdFkprNxEegnuBnL6Qu8RpInKRQdE+pqMZqgMoxbOzQSBTae9bx7TWfx6sMAixXmvJKp7rcJBvnjWwOs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lt6x7LCI; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723015889; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=baUyHpWJi3h7hiLswYNGAzxo3B0Fb9qYpwzVeNW2e1M=;
	b=lt6x7LCIZRp9uyI67cVPbEK9yfO/29nYne868xtBHpsbbU+AeYJpDVztCazx08V3QVQhWJDaqsxiaGnpgRPODHZp+Xn92mN9mcAMdW1+Ab3Eg2WK75bnfBH1dazdZZ6ImO9HoSmKBJhAxrN8PHtMBPWa4QYd2hyqI5+s4VgACPA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0WCI3ged_1723015887;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCI3ged_1723015887)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:31:28 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/10] mm: vmscan: add validation before spliting shmem large folio
Date: Wed,  7 Aug 2024 15:31:06 +0800
Message-Id: <8a8c6dc9df0bc9f6f7f937bea446062be19611b3.1723012159.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page reclaim will not scan anon LRU if no swap space, however MADV_PAGEOUT
can still split shmem large folios even without a swap device. Thus add
swap available space validation before spliting shmem large folio to
avoid redundant split.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 31d13462571e..796f65781f4f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1259,6 +1259,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			}
 		} else if (folio_test_swapbacked(folio) &&
 			   folio_test_large(folio)) {
+
+			/*
+			 * Do not split shmem folio if no swap memory
+			 * available.
+			 */
+			if (!total_swap_pages)
+				goto activate_locked;
+
 			/* Split shmem folio */
 			if (split_folio_to_list(folio, folio_list))
 				goto keep_locked;
-- 
2.39.3


