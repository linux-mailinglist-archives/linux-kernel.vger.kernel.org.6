Return-Path: <linux-kernel+bounces-227911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D3915807
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AAD288624
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB91A0AFC;
	Mon, 24 Jun 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQGm5Nbn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C57D1A0732;
	Mon, 24 Jun 2024 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261147; cv=none; b=E1ND6JfDKo6w0g29VboA8GAm7hXKyXVqlp3siggUWXLCBxsw0fxbBqNXROxz0oNQdbpyFrEKZWUtsCW6LebUUuWpthor9cYJ3gZ0r23cCjpS51hG0b3vNSOdC4EVCMhjEeyxDQYsy6+TwbffPWb0CT7m0+QS/WYMjojdiPPRa1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261147; c=relaxed/simple;
	bh=nDxznFVgGNRPZdqXMGV8YCzsudKESeRiSXoAejLcYqI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5aLejVkmZoKxRFxCBqnKoL3PJXDrtoUwT8jew/n5VUFJEUm3dV9ySgjNzpUKW4Zc8nQrKlAPcggb0uRN0ShIg08HB8M8LPPub+JY5TMqkATGMe1qGgkpYJjwBgN01fiHM+H3BBt02UwwWYlXoKE7nYY/6ddJ3l3khMPXmBYDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQGm5Nbn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261146; x=1750797146;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nDxznFVgGNRPZdqXMGV8YCzsudKESeRiSXoAejLcYqI=;
  b=NQGm5NbnsS0JAnBofFBxqTEYmL8gkGLTmRzuLBo5sFk2b5vzt9lJkvxF
   Ccva4F99SimNDj4ux8AXcAgKz5kRTMnR4cYHWDpTfF4qLlN52NF6ZgYIP
   n/ALYQtQlhLi4mc5TWXrrCXMHrAxZ9GnGXa8kVkK8M0OF4GmzmOSpmuCo
   ISX6j8W7aMw6Xv7DEPX1sr6Vpo/s3DsfcWIZ5no87pBZZUHV2Zi0b6tcm
   Q5D7iBHIoFeT2g81uz9396GkyZZAVq1Of9TC70UH1vbnmemqyCY8pkZ9X
   jxSagluQXS0r7UpRQAiTIhbinZ2t0eBv7ebNKU8pBcYAszunGHNeN+Q+u
   w==;
X-CSE-ConnectionGUID: pHNl4iVZSKCp8Dfxlko93g==
X-CSE-MsgGUID: POrSZmJrQiO6p2WxlbmS7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792336"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792336"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:24 -0700
X-CSE-ConnectionGUID: 8usnIpCbTLGx+i+KZbvvvw==
X-CSE-MsgGUID: aF+L+NpTSb+g54l7vderzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949140"
Received: from ticela-or-265.amr.corp.intel.com (HELO xpardee-test1.amr.corp.intel.com) ([10.209.54.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:23 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] platform/x86:intel/pmc: Move pmc assignment closer to first usage
Date: Mon, 24 Jun 2024 13:32:13 -0700
Message-Id: <20240624203218.2428475-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624203218.2428475-1-xi.pardee@linux.intel.com>
References: <20240624203218.2428475-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pmc variable assignment closer to the conditional statement of
its first use for better readability.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index cbdcbf288f67..cb7dd22e7406 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -621,9 +621,10 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 	unsigned int i, index, ltr_index = 0;
 
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		struct pmc *pmc = pmcdev->pmcs[i];
+		struct pmc *pmc;
 		const struct pmc_bit_map *map;
 
+		pmc = pmcdev->pmcs[i];
 		if (!pmc)
 			continue;
 
-- 
2.34.1


