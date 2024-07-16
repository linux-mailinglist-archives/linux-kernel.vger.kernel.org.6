Return-Path: <linux-kernel+bounces-253369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3438932024
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EB8B22502
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66A717C91;
	Tue, 16 Jul 2024 05:44:32 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40412E556
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721108672; cv=none; b=mJI93ClAQ9gQZnVPOGW3tFs64WIyGECbR1+qMJNziSl0u473lTFhq8OJItKecU7HUVjlMRCdM/qXLBq+X/zET+Fjp6pdyW4Px8I9K4ZonMrMW5sPHGPqGBBI4zIov17xYh41pNAKMoXzKk1M6I3g2+IUeQI0m9f4wgHQd/Xm4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721108672; c=relaxed/simple;
	bh=wKAXbQ8OmmRHF0uOGS6rWQL3NdVy19uiV6RoFF9UChQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E3roTQNv+F79owpuBEhYLygeLFcBkuXzyIxQFHiCS5e9llkPOOEt2x+sYz71BThf6gDY3ULYck/iC6wLiMkbT9IOp+EPG4VDLtXvkB0pvcixETftUsdMc+sYDaNbWGzKEiXn6Ph+ORjWEO2khS9GVwD5m0bHrMheN5vtWmMvPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46G5iJYG065772;
	Tue, 16 Jul 2024 13:44:19 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WNSYD5tx3z2LB41M;
	Tue, 16 Jul 2024 13:38:56 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 16 Jul 2024 13:44:16 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu
	<huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale
	<dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] fs: fix schedule while atomic caused by gfp of erofs_allocpage
Date: Tue, 16 Jul 2024 13:44:14 +0800
Message-ID: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 46G5iJYG065772

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

scheduling while atomic was reported as below where the schedule_timeout
comes from too_many_isolated when doing direct_reclaim. Fix this by
masking GFP_DIRECT_RECLAIM from gfp.

[  175.610416][  T618] BUG: scheduling while atomic: kworker/u16:6/618/0x00000000
[  175.643480][  T618] CPU: 2 PID: 618 Comm: kworker/u16:6 Tainted: G
[  175.645791][  T618] Workqueue: loop20 loop_workfn
[  175.646394][  T618] Call trace:
[  175.646785][  T618]  dump_backtrace+0xf4/0x140
[  175.647345][  T618]  show_stack+0x20/0x2c
[  175.647846][  T618]  dump_stack_lvl+0x60/0x84
[  175.648394][  T618]  dump_stack+0x18/0x24
[  175.648895][  T618]  __schedule_bug+0x64/0x90
[  175.649445][  T618]  __schedule+0x680/0x9b8
[  175.649970][  T618]  schedule+0x130/0x1b0
[  175.650470][  T618]  schedule_timeout+0xac/0x1d0
[  175.651050][  T618]  schedule_timeout_uninterruptible+0x24/0x34
[  175.651789][  T618]  __alloc_pages_slowpath+0x8dc/0x121c
[  175.652455][  T618]  __alloc_pages+0x294/0x2fc
[  175.653011][  T618]  erofs_allocpage+0x48/0x58
[  175.653572][  T618]  z_erofs_runqueue+0x314/0x8a4
[  175.654161][  T618]  z_erofs_readahead+0x258/0x318
[  175.654761][  T618]  read_pages+0x88/0x394
[  175.655275][  T618]  page_cache_ra_unbounded+0x1cc/0x23c
[  175.655939][  T618]  page_cache_ra_order+0x27c/0x33c
[  175.656559][  T618]  ondemand_readahead+0x224/0x334
[  175.657169][  T618]  page_cache_async_ra+0x60/0x9c
[  175.657767][  T618]  filemap_get_pages+0x19c/0x7cc
[  175.658367][  T618]  filemap_read+0xf0/0x484
[  175.658901][  T618]  generic_file_read_iter+0x4c/0x15c
[  175.659543][  T618]  do_iter_read+0x224/0x348
[  175.660100][  T618]  vfs_iter_read+0x24/0x38
[  175.660635][  T618]  loop_process_work+0x408/0xa68
[  175.661236][  T618]  loop_workfn+0x28/0x34
[  175.661751][  T618]  process_scheduled_works+0x254/0x4e8
[  175.662417][  T618]  worker_thread+0x24c/0x33c
[  175.662974][  T618]  kthread+0x110/0x1b8
[  175.663465][  T618]  ret_from_fork+0x10/0x20

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d6fe002a4a71..0213c66d141b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1486,7 +1486,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	folio_unlock(zbv.folio);
 	folio_put(zbv.folio);
 out_allocfolio:
-	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
+	page = erofs_allocpage(&f->pagepool, (gfp | __GFP_NOFAIL) & ~__GFP_DIRECT_RECLAIM);
 	spin_lock(&pcl->obj.lockref.lock);
 	if (pcl->compressed_bvecs[nr].folio) {
 		erofs_pagepool_add(&f->pagepool, page);
-- 
2.25.1


