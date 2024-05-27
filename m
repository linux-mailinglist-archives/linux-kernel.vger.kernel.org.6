Return-Path: <linux-kernel+bounces-190732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB868D0217
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56BEB28DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E6016C876;
	Mon, 27 May 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCcEuM12"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847215F3E1;
	Mon, 27 May 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816869; cv=none; b=PPaX0tg1rBE/9AAgw0HKmkL5HyuMZX6ZtHSWDcSSPmB/G31NfZaODPJJY0qiL+OBMy3uQYiCMRrOp75Phh6FWHMvv6mDPUVz60Rg8twSN/4fufu6io3dyEjHqJrNgK57eb4Pd5n43sJJe7oz8vP2N4BxzPhvGESlh5n2hOYoT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816869; c=relaxed/simple;
	bh=iTlDdyiKhoyna/uHFGje4GTY2u++2TAwP7nva17NFYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmJIlBv+ECHhyk3trsgGjn/Bl2VhwMECNjY1jJchOBNCBie9P1J9KSKLw/q8m9BnnNDSvlougchxsbkpMG9R/OcN9pr0ePK/c2q2ze6RgXTQMf8rg9DdSCklE/1GEIKroS8/LFNDU9IyhD5GomZcATsoh/jPELgZWQAUgfMoBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCcEuM12; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816868; x=1748352868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iTlDdyiKhoyna/uHFGje4GTY2u++2TAwP7nva17NFYM=;
  b=gCcEuM1283zoAbAOI97KCtsABGXjeUHO//bRP8tx9M9hLHZz52aJH4cx
   6+szpU2YyVMzxza3hSTyzueG1zpdVLvh2Ka306guWFW70VF8zqWKN7yVg
   JQkgiMpyjbDU4hf9c590Za+YTto1TRC1BfQ4UZ1/z5VV/cgpu4s9YWXsT
   +dF0ZhiXUJgB+X9Ss8z0FEkwfjFwXsdsark/uJajVKhJuXjZC7IUpRtOJ
   PodpEJFgX5/EW49RebbYI5YNzsZo/Pu5FpmmAAqyu+lb+1C1WSplxxUgM
   bvqbPrn3xIu/Yj0HAW6uDqWp+WDuEwfP1yWmJb7PP2fm2NtbJ5j7GFwjR
   Q==;
X-CSE-ConnectionGUID: uj1OQ02fT8OSwW80lXabbw==
X-CSE-MsgGUID: dpsjCCY+Sn+TF0iwGDdDTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="11714389"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="11714389"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:27 -0700
X-CSE-ConnectionGUID: axpFrTVRQO+EGYwBLLktFg==
X-CSE-MsgGUID: j5S16x/hRLKZwKmmk3XM1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34848010"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.180])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:25 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6/6] doc: TPMI: Add entry for Performance Limit Reasons
Date: Mon, 27 May 2024 16:29:38 +0300
Message-ID: <20240527133400.483634-7-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527133400.483634-1-tero.kristo@linux.intel.com>
References: <20240527133400.483634-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe the new 'plr' (Performance Limit Reasons) directory contents under
the main TPMI debugfs folder.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 Documentation/ABI/testing/debugfs-tpmi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-tpmi b/Documentation/ABI/testing/debugfs-tpmi
index 597f0475fe6e..4daa9ecd7918 100644
--- a/Documentation/ABI/testing/debugfs-tpmi
+++ b/Documentation/ABI/testing/debugfs-tpmi
@@ -29,3 +29,12 @@ Example:
 echo 0,0x20,0xff > mem_write
 echo 1,64,64 > mem_write
 Users:		Debugging, any user space test suite
+
+What:		/sys/kernel/debug/tpmi-<n>/plr/domain<n>/status
+Date:		Aug 2024
+KernelVersion:	6.11
+Contact:	Tero Kristo <tero.kristo@linux.intel.com>
+Description:
+Shows the currently active Performance Limit Reasons for die level and the
+individual CPUs under the die. The contents of this file are sticky, and
+clearing all the statuses can be done by writing "0\n" to this file.
-- 
2.43.1


