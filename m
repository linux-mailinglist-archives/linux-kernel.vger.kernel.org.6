Return-Path: <linux-kernel+bounces-300345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CEF95E2A0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA2DB20B81
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB10D5FBBA;
	Sun, 25 Aug 2024 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUIR/bnt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91FEAD2
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724573899; cv=none; b=tujjIrpmKNQ6aVaXOnS8z2gW9FMtB3V8jPH6PY6HEEGuD/KNbWG5THY8l5YVFNbIn0eGldnM0ZPeE6M7db2Mk8SZ/mXF7ddQohsaErRNrjVe5dkBP7gWTkVweJTq9WWG0yAe0H5KC8GwKS3QQxY7WNf271ZoP31+WHcgGvpItMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724573899; c=relaxed/simple;
	bh=wF8losfJndWVHuf38eSXLMRB4D0NVFWP1R6GEWiLL/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwgfI3SL4D8x6p3xoL3WO+7A71BOMJzxD7i2YGwyxes0Tj40+yhWbEDId+dN9DTzCGuNgAJSOkCF9AmAcCioXCu8AT8wQZAXYNH1QgFI4MpM2MbPmjYEdtXeSxNdue8ouCnztgYnLJwMj4WPzUVlA6dp8bC9P/NWNR+Xliy3fvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUIR/bnt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724573897; x=1756109897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wF8losfJndWVHuf38eSXLMRB4D0NVFWP1R6GEWiLL/s=;
  b=WUIR/bntkLcGgUjMx71pGrraAycLHF3ar6+lF7iWqypHtl8iOBI3i1z2
   /R/smyYbcyss5Nyf1lV1uTZL17fO7y8njTHJ1QR9uNQ4YUpwB9hb5rbZ0
   7/KxFk/UMp9p2Yg0GIKZJnqINGFnAMdVq1qLUh0h7ajQcLE+38/faGtiy
   Xfm/B0+VOjEqSMyQkabWlNvVQKmDJnPw8EUf8zK8yIjqpGi6MyLTGhQHT
   RZX5HYbekWp9M36cmNEmgokwsg+l7e3hVCBHF5mmrp9838pPVcB/T+n+m
   XqkAAcFL7R7nE+qmXYjXQF+jXdmN5123iIlArVwtcz7KsI86XjFsMBOUX
   g==;
X-CSE-ConnectionGUID: Gn5lLO7cRYurT8GijXz1KA==
X-CSE-MsgGUID: fKmBjdwBTv2f7p6jofgZug==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="23186603"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="23186603"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 01:18:17 -0700
X-CSE-ConnectionGUID: vap24edkTp6ORMt305zOqQ==
X-CSE-MsgGUID: /SJl8KWMQHmq63rh3+8HCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="67014939"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.222.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 01:18:15 -0700
From: Kai Huang <kai.huang@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	peterz@infradead.org
Cc: kirill.shutemov@linux.intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	nik.borisov@suse.com
Subject: [PATCH v2 0/2] Misc comments fixup in relocate_kernel_64.S
Date: Sun, 25 Aug 2024 20:18:04 +1200
Message-ID: <cover.1724573384.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assembly code of relcocate_kernel() takes some time to follow for
newbies like me.  This series adds some comments to try to improve the
readability hoping they could be helpful to others too.  Also fix an
error (IIUC) in one comment.

v1 -> v2:
  - Add Kirill's tag.

  v1: https://lore.kernel.org/lkml/q2y5vte3wwn5qde5p4nfmjfqtzxfen3nhjdyafc7nbirfidpvr@ro3djjz3pub4/T/

Kai Huang (2):
  x86/kexec: Fix a comment of swap_pages() assembly
  x86/kexec: Add comments around swap_pages() assembly to improve
    readability

 arch/x86/kernel/relocate_kernel_64.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)


base-commit: e77f8f275278886d05ce6dfe9e3bc854e7bf0713
-- 
2.46.0


