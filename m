Return-Path: <linux-kernel+bounces-218702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1F90C417
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9533D28243C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC26B77104;
	Tue, 18 Jun 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yRYct/UF"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA173477
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693677; cv=none; b=UZFM2hIctg+W4Ah/w6+z3kQCOKtEzSJuH6N3igEso7nS447RxEZtpum3HZlFCEf+F0Y2rdVukvw0k5FXeAHXVyKEfpZ4Y/CTly0lfTMWMwiM9Ckp1jlgfE8CfzzDbMVVnLqWrgufOVoYYaYjRtn56iQ6+wAA0JxgXy/K+mEMuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693677; c=relaxed/simple;
	bh=9w3+BGqMOeVAeOQIAOTwGksYjI6niZWaad8y/5Mil1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCDITY1T9yYaeQ52ozNqaXBbyumjTwGKEBNqAM+TKp4TI+296f21VEi/PTmnyO5ifI26CAxPLUgVu+Iy6ax3vnnqsJjsHbN/BMBJlJtxDm6dSOi8pU0qvT9047t//jLHGBSwuXp9N2uIhJKCMuNC6025+d79vieIpRwstA/oUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yRYct/UF; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718693673; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eA6kyRQ9XEpy05GdpwvXfCDvN4imeajWIAzdeARsgKo=;
	b=yRYct/UFaYNmmeZK5qcyA8QOZ3CAsn+smy8uqjBqePugsHlZ44p8OjReZj4Xu5pUhK+XvsQ9P7e4q6fPIbCx5rSgGPfU09vJUsnvUnFKZLhPFiI6aTOcuv7WAFYnecuylPRwEOqP8w9uuiH0IHfX+QYLZI9M0w3GKBDi/+BSEMg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W8jH7ld_1718693670;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8jH7ld_1718693670)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 14:54:30 +0800
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
Subject: [PATCH v2 3/9] mm: shmem: extend shmem_partial_swap_usage() to support large folio swap
Date: Tue, 18 Jun 2024 14:54:15 +0800
Message-Id: <61c49050a8aeffecade8c2c407280bf6b92f359e.1718690645.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support shmem large folio swapout in the following patches, using
xa_get_order() to get the order of the swap entry to calculate the swap
usage of shmem.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b90965486631..012a06ef39aa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -870,7 +870,7 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 		if (xas_retry(&xas, page))
 			continue;
 		if (xa_is_value(page))
-			swapped++;
+			swapped += 1 << xa_get_order(xas.xa, xas.xa_index);
 		if (xas.xa_index == max)
 			break;
 		if (need_resched()) {
-- 
2.39.3


