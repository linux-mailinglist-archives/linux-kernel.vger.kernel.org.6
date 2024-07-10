Return-Path: <linux-kernel+bounces-246907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE392C8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A6EB21537
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CED7182D2;
	Wed, 10 Jul 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="oPf17QgK"
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978E17FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580240; cv=none; b=AUxykLG7SWz0fUVIPjodxFHRVpMopUCCI8O+XSy2RN/CD/9HtXnaUywm2qYBEeHo46kRLbFb6xlOoTym6V/et+349fwFpdp1A/jpPrkUR+IFKZ7VGq6T5kjPDW2NpBpvyQ/IN5F9TCzPhZzh8GS7ZCUlig+AnFoY5wLI6hOU0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580240; c=relaxed/simple;
	bh=HSTBQSbOGGtPU3/jjTsgH7DrCswUcEWcGQJaMqUO1oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWqUHwOCDR91ftAWzyFlRX3FT49ZEQtxkbXGu8bsfE3a+4LCVH0CTwg6ma8pJB5NtO//poEWNZt17nkApXv4OBxgjzOOHg8AXwCzuJG7pgQsrhk+0vKg+VCMaQqbQqcLAEx1ybNuAeJ11SWK2IjeZO8rLnChh3ZA3L20WGV9NT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=oPf17QgK; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1720580238; bh=pJ6Ajt+MksFhKCPRYw8veVKr78QxV/bF+Nxdgrh6pWU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=oPf17QgKALR4KAZPyE8gSJ2mhG2dQx4gfh9UgR8qWr6eYqQ8DZuL1WhNr1VzgPEQ8
	 fvnNrZNNKklUeO3hYEm6Iov8OjrTo9fTXlQgYVV1MnH6R3A6X4qY2i97gdByikeB19
	 /ZIEEDUCwNZf9H6D7gu2X3wOkeJ8TrrSPyPv86VJY8sYB1EaUsWfsC7WalLmTjasf5
	 j9X5+eDeMxbZqEUt0wJqM4nkfVB+HCtMimaI4dOFrHu4hZmy6GT2p3QSH5EbaJREpe
	 RstksE6W23Djt8PXXXblNCjEzsYyVjpt66NUF2ceHzU4sZfDXIHPUaHaAsy5YA0EE5
	 Qf2KK/+2GyUeQ==
Received: from xiongwei.song (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id E473E1805D3;
	Wed, 10 Jul 2024 02:57:07 +0000 (UTC)
From: sxwjean@me.com
To: vbabka@suse.cz,
	surenb@google.com
Cc: cl@linux.co,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	xiongwei.song@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] mm/slub: quiet the clang warning with -Wunused-function enabled
Date: Wed, 10 Jul 2024 10:54:18 +0800
Message-Id: <20240710025418.394321-1-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2KoMrt1mWH5Uf_Zu-T9I7T3XB7CQnUJd
X-Proofpoint-ORIG-GUID: 2KoMrt1mWH5Uf_Zu-T9I7T3XB7CQnUJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_12,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1011 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407100022

From: Xiongwei Song <xiongwei.song@linux.dev>

The only user of prepare_slab_obj_exts_hook() is
alloc_tagging_slab_alloc_hook(), which can build with
CONFIG_MEM_ALLOC_PROFILING enabled. So, the warning was triggerred
when disabling CONFIG_MEM_ALLOC_PROFILING. Let's add "__maybe_unused"
for prepare_slab_obj_exts_hook().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-lkp@intel.com/
Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
---
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ce39544acf7c..2e26f20759c0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2027,7 +2027,7 @@ static inline bool need_slab_obj_ext(void)
 	return false;
 }
 
-static inline struct slabobj_ext *
+static inline struct slabobj_ext * __maybe_unused
 prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 {
 	struct slab *slab;
@@ -2068,7 +2068,7 @@ static inline bool need_slab_obj_ext(void)
 	return false;
 }
 
-static inline struct slabobj_ext *
+static inline struct slabobj_ext * __maybe_unused
 prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 {
 	return NULL;
-- 
2.34.1


