Return-Path: <linux-kernel+bounces-567338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF6FA684B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB3519C33E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09720E00B;
	Wed, 19 Mar 2025 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxEkje+T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8901598F4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364083; cv=none; b=eDZnduTFeBYEA94Y5SyFsWhlHfH69NvCwa6dFs45DqPPfxN4SFy/SLjAxik880KzUoGTfdbDU1F8BPTiBSHdcHVGrf6YixEZstZIiuSoB4qqBNy4U7DTRdUcxCdL1wrumge6FhLBhQAY/WnLmeCn1UkjEz7+XsiceAIxq5x8/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364083; c=relaxed/simple;
	bh=EgjeXFnN35HPLuvAYLr4queKOH/42c7H38lpSPMpij0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMal5CPqNJHJn8U30Rg6ue9LuW4hHNuRZdJUiL+G1Bl/hhac0pMOy6xNUvmQzsRrO7SgvJwPXusmkVzNa2d1+9YvxxiIzSP5yWrNiLH57wTkJlhAiPhVweF1xVm5WQAKM1rSlGsPrcDcXoS4nmyn6r3EJg+YekWYFUcYDsWqslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxEkje+T; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742364082; x=1773900082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EgjeXFnN35HPLuvAYLr4queKOH/42c7H38lpSPMpij0=;
  b=LxEkje+Tp2BPD50LbtQ73BdcbEEtRsJ+FGcDxldE9XEKIyhgamJvY38x
   BlflZzqz4a5wNiOZtw8ZkRdxpZbNqGara4I71FCpbMxLvWatO1+Yshgkn
   txTjS3nl6/DjvVZexnTrqKNJ3Jo+FzjUu3TAybKO0phJIKWCHAwTgVVg8
   J/OkEWrmgH1k95PEhDi2PrjpQnJgXYxgmjpmOC59nCE5+No5BTB+ocTq3
   g6vM6mQxzzx5Ay97N3lcIAr0ZoVL/4EecTU2rM+Pap9fZjUkEaieGjqrD
   ETxMwQjX3rZvZIcp8yjaBfl9JYFRTP+97bUUcaO1FDTnB+QVd9MDWRdLL
   w==;
X-CSE-ConnectionGUID: azMe62jBSqCGoBTMmjyfxg==
X-CSE-MsgGUID: RwpfJt63TbG+6kTupl+Odw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="61063648"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="61063648"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:01:21 -0700
X-CSE-ConnectionGUID: Nxkcny6KT5OmjPAHbQJ1+A==
X-CSE-MsgGUID: nX44F7XsTBS2aftHttSqbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="123411135"
Received: from unknown (HELO hyperion.jf.intel.com) ([10.243.61.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:01:21 -0700
From: marc.herbert@linux.intel.com
To: marc.herbert@linux.intel.com
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Marc Herbert <Marc.Herbert@linux.intel.com>
Subject: [PATCH] mm/hugetlb: move hugetlb_sysctl_init() to the __init section
Date: Wed, 19 Mar 2025 06:00:30 +0000
Message-ID: <20250319060041.2737320-1-marc.herbert@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Herbert <Marc.Herbert@linux.intel.com>

hugetlb_sysctl_init() is only invoked once by an __init function and is
merely a wrapper around another __init function so there is not reason
to keep it.

Fixes the following warning when toning down some GCC inline options:

 WARNING: modpost: vmlinux: section mismatch in reference:
   hugetlb_sysctl_init+0x1b (section: .text) ->
     __register_sysctl_init (section: .init.text)

Signed-off-by: Marc Herbert <Marc.Herbert@linux.intel.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 65068671e460..a2850b26aed9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4900,7 +4900,7 @@ static const struct ctl_table hugetlb_table[] = {
 	},
 };
 
-static void hugetlb_sysctl_init(void)
+static void __init hugetlb_sysctl_init(void)
 {
 	register_sysctl_init("vm", hugetlb_table);
 }
-- 
2.48.1


