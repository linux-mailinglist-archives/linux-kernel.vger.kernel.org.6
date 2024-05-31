Return-Path: <linux-kernel+bounces-196447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A7F8D5C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A621C22AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853F578281;
	Fri, 31 May 2024 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGy07DBt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3315E89
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143176; cv=none; b=qkYQtbqOan7ZHOk5HsSy7E8eRg1Zo8XahoGMNmsDQ118DuIpSBoukTrBQlhPn6XAphB+oqrusYs/UxyKZ/gYEEjYwfrjTBqrDGYtfVf9HaCX3IklPlEvb6qfrvGA73gYkCOVILhKhobj485KX+2mDCCNpegYo2EQNKegCgNd6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143176; c=relaxed/simple;
	bh=+HL84eWGAxnOcQGlr/4MbeLb2An0y1RSJRklCBfMaL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hDwYyiFfvHjOdgmI1Pji7ratflSxKTYtycgdIuufTiWlyhAVIAF3ytDZl7r7/KM0CLlxSr5IoQ+mx/VMyoAq61qAL1D+sS5NcdrqkzNC9WwozdLm2BaNMZELGOf378A+7zoN/iHPJKOMjYI5LyjqYGlqe8WaXFKnNVvnsm+5PQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGy07DBt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717143175; x=1748679175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+HL84eWGAxnOcQGlr/4MbeLb2An0y1RSJRklCBfMaL8=;
  b=IGy07DBtlj6Z2l6N/9Ea3fjkSqnc2aRLUqBlL6Tv+pbRYaweU4GVINjq
   A3yoJ9AkhizxIBhnb1K9pdSW7mXZSgGY0lRTX9u1G3OfaIbw5h5ov2zHr
   X1odU1Q1bb4Ksx72cuIuEPstJZxjQ13I2gYRnLrAxGjaUB8MnmlZDfM6t
   nTfQSnjHZDzEynlQOpbh35YFoyRorVa8mT54C2WdoM3ZK45nmICdA5QFu
   0SR9RxzqWVrY1Q2OQi1A5J10OIQas7InkElq/CiG3MawEFRepeibEorAP
   KSWHsoYui1Xdv63/NXSv0GrWPkW4TdXzhmjqbKotQwsBycGWn1gYExvdk
   g==;
X-CSE-ConnectionGUID: tYW88OJXRmGAqLcbkzV89w==
X-CSE-MsgGUID: lBXf4L2rSjaYJGcAZFoGaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25079730"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25079730"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:12:54 -0700
X-CSE-ConnectionGUID: GDugZUomRcCClg2XooWNuA==
X-CSE-MsgGUID: r3kK+LwIRb+g4NR6Ws7B1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="59270914"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.30.35])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:12:50 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Huang Ying" <ying.huang@intel.com>,
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
Subject: [PATCH 0/3] mm,swap: cleanup VMA based swap readahead window calculation
Date: Fri, 31 May 2024 16:12:27 +0800
Message-Id: <20240531081230.310128-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Huang Ying" <ying.huang@intel.com>

When VMA based swap readahead is introduced in commit ec560175c0b6
("mm, swap: VMA based swap readahead"), "struct vma_swap_readahead" is
defined to describe the readahead window.  Because we wanted to save
the PTE entries in the struct at that time.  But after commit
4f8fcf4ced0b ("mm/swap: swap_vma_readahead() do the
pte_offset_map()"), we no longer save PTE entries in the struct.  The
size of the struct becomes so small, that it's better to use the
fields of the struct directly.  This can simplify the code to improve
the code readability.  The line number of source code reduces too.

A theoretical underflow issue and some related code cleanup is done in
the series too.

Best Regards,
Huang, Ying

