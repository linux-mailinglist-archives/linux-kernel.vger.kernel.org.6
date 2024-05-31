Return-Path: <linux-kernel+bounces-196449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D8D8D5C72
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684BCB254FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFA9823A3;
	Fri, 31 May 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqzOHD4S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C067C6DF
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143180; cv=none; b=RPSs/DLP6EicUxB1DjQy1TF9hUwWMyCMWSlsLYQ/5z7f2FBX+btb6xVCqllUvEvvLSH5xrspPKnETgpn2xysqjYpPd3/VeBE6e4ZQmsl2VIbmcKrlDQ3ZPGquTJyqgXd3bG2TPqtPVR5lyrfyOB5k+v4GuYm79bBre7VlLnZavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143180; c=relaxed/simple;
	bh=ikiPA1J5OkAmYTlYwym2P+F42MJMV8ZnlTu7TRlEtOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McpuFcSr+yJgv6tytFQ1nEY5FmY1g/JOLe5byWtOKeTYuaGIRCg0QmF9Xj+V93F+FWDfnq76mDxF/Nsb4xfQC181tjX1D7TABSUBEgyqelGcHO89qp+G3QjFZRxw7rWgug2S48wMWhJj5F5hDj70Hi/LfDAsjEKvQerATQFeHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqzOHD4S; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717143179; x=1748679179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ikiPA1J5OkAmYTlYwym2P+F42MJMV8ZnlTu7TRlEtOg=;
  b=YqzOHD4S8jOZtNZE5eZuwDL1BdYwFYnekC0/vCh8Vr/kppIWDELLmIWO
   2LZxKLjJFbueil/r0XZULahdomkqk0PpOGRHn6BcgnZDJZKr2yKmCXZxu
   9vR27ZCKqkQrWEXwpeeg7zE9MbBvC58weXnC4eIHTmenqBn1PFl8AgMVs
   Ojt3Ubwg2uDq3sR/Qa5E/i+5OBTBYfk8RoUA5ppnp2cvwdaVDIHPSHXpZ
   W2bdt6kby4FVUCP1VeK/ht32KhrUtOmqCDrgToFhzugUpdglXpqdYNnEo
   AXFSBptwoDAaz8fjsV46XeP2MwN2OaBgsOWA2Q6C2PwPCNpUUcJenTc8L
   A==;
X-CSE-ConnectionGUID: G20DW+vaSHK8GslEQQPWTg==
X-CSE-MsgGUID: fysvJCoVS0Gc29Dowu6BlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25079745"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25079745"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:12:58 -0700
X-CSE-ConnectionGUID: paWjvUcmRbmdg62OQ/tn+g==
X-CSE-MsgGUID: RxkDEidERZauFldGWycaVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="59270933"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.30.35])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:12:54 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Minchan Kim <minchan@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <shy828301@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH 1/3] mm,swap: fix a theoretical underflow in readahead window calculation
Date: Fri, 31 May 2024 16:12:28 +0800
Message-Id: <20240531081230.310128-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531081230.310128-1-ying.huang@intel.com>
References: <20240531081230.310128-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In swap readahead window calculation, if the fault PFN is smaller than
the readahead window size, underflow may occurs.  This is only
possible in theory, because the start of the virtual address space
will not be used for anonymous pages in practice.  Even if underflow
occurs, there will be no functional bugs.  In the worst cases, some
swap entries may be swapped in incorrectly and some pages may be
allocate on the wrong nodes.

Anyway, we still needs to fix the issue via some underflow checking.

Fixes: ec560175c0b6 ("mm, swap: VMA based swap readahead")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
---
 mm/swap_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 642c30d8376c..848c167df530 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -787,6 +787,8 @@ static void swap_ra_info(struct vm_fault *vmf,
 		lpfn = fpfn - left;
 		rpfn = fpfn + win - left;
 	}
+	if ((long)lpfn < 0)
+		lpfn = 0;
 	start = max3(lpfn, PFN_DOWN(vma->vm_start),
 		     PFN_DOWN(faddr & PMD_MASK));
 	end = min3(rpfn, PFN_DOWN(vma->vm_end),
-- 
2.39.2


