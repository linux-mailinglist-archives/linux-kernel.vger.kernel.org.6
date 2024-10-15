Return-Path: <linux-kernel+bounces-365094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA399DD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E071C2203C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC0A16EBE8;
	Tue, 15 Oct 2024 05:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lad+gZkT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364B3D69
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969373; cv=none; b=X/m/Mf3sX78zZdeEt1LtYUwuGxO1KyEFp8XWXxIwAVAXYh6Wla0lXgUMYIRZSOdyrU8XAUXQLQk3RtEx1PtBXkyBTxYztEk6B07TSSrGUxXOtq37bWxQP4OPKcFxq/TXoT9SUN1MxDGUZKmGEDsvtuOszeE1/adIksgYvyH5cFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969373; c=relaxed/simple;
	bh=r+ohFbZ+3OT4yZB1iRHQ2xYn1IwOo35YuWlS7r/hjN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aJ6yFWQgmrrKh3KcHUH/IthtAWlgNZjidydmxEXuoxnhbpfBl32EOTpUmwOgcoLj0X8tHmYNaPeeT0fXT7IpN3vaeAOycOhfEYF0vpnoYrmch1Tc5eNPuQrBs37J9yJtXNMOhm2g27waxjtbUwsPhfBhd0naki+X6889Y8Bhj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lad+gZkT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728969372; x=1760505372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r+ohFbZ+3OT4yZB1iRHQ2xYn1IwOo35YuWlS7r/hjN8=;
  b=lad+gZkTCWLhM2lrgAqOuJHj1OMAztL7W1jW99+ZAANMNRAaHFjYmmtK
   WfGgN6nout7UIYRM3ebJUguyIEhIxvg1u0qyRts+O21e/sobyyhl5fJC6
   dd2uC4P1ZeBVKwsdEHv5jGawRwupi6fywwtL9O6ruV2Bfxt7wQ5mBGfnW
   7SrYOBgwlsobCYKiDnzZnbjOWdKRZADmpXJEgHVXPwuEF2uePWgdxnaen
   0cMEWK86xz00DEPXXNup27vyGmxcLSkhnqlV69sYhOKndxNRN4FqKiQ9Q
   cR70dShzFHNROyFBsxvTyoAcyK/UZH21U2pZFcJrs+E5ejMcVjAz9xE1T
   Q==;
X-CSE-ConnectionGUID: v8e3iZgAT7yGZRYXe6btgg==
X-CSE-MsgGUID: b4XvdZBDQ1iuIlnnkVb0aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28532692"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28532692"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 22:16:11 -0700
X-CSE-ConnectionGUID: k2vFIqMGRRWlHs3opiqN3w==
X-CSE-MsgGUID: bd2Axd9TRtmrJVUpNER2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="78121845"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 22:16:08 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH] resource: Remove dependency on SPARSEMEM from GET_FREE_REGION
Date: Tue, 15 Oct 2024 13:15:54 +0800
Message-Id: <20241015051554.294734-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to use the functions configured via GET_FREE_REGION in
resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
This makes resource kunit tests cannot be built on some architectures
lacking SPARSEMEM.  In fact, these functions doesn't depend on
SPARSEMEM now.  So, remove dependency on SPARSEMEM from
GET_FREE_REGION.

Link: https://lore.kernel.org/lkml/20240922225041.603186-1-linux@roeck-us.net/
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 mm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 4c9f5ea13271..33fa51d608dc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1085,7 +1085,6 @@ config HMM_MIRROR
 	depends on MMU
 
 config GET_FREE_REGION
-	depends on SPARSEMEM
 	bool
 
 config DEVICE_PRIVATE
-- 
2.39.2


