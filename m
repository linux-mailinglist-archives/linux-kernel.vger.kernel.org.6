Return-Path: <linux-kernel+bounces-227916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06CB91580F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E89CB23E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1911A2C1A;
	Mon, 24 Jun 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJ+WF6jG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACC1A0AFD;
	Mon, 24 Jun 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261150; cv=none; b=AYzo174ZPSNXnmCDXvlcSLWnQV2k3jsGPnx++9LTvBmtpcC/RjhxRkbYvNav2axIViylDXu2t4jKnBtZUvgM2VEEtOtTBvmCp7/vE7PoHmeYAvGvSo9n1K8Qg1XcJIs2Qc6/jxJe0IgsEhcJ+DJdpybM/dkzuLQi6GEBMXAQSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261150; c=relaxed/simple;
	bh=y+LyaD75rXaIsD2hBhkd622S/1dAD1LuJBLfNrH5Xco=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EObFRDMrBjD9Zf5+Kjw3lHg5eRftolmPXy8h5xf2Owe2o5iE0VL1ALa73Q004mdgXgp3GR06C3/b11kGk3n7BX5f9daZ037MJvz7Lj10VDnR++dPdRhS5vIIsgtzSSr0jGctijF3vEXtpoI1v6FYDqh1V3/cRxV7sTjjj96UMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJ+WF6jG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261148; x=1750797148;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=y+LyaD75rXaIsD2hBhkd622S/1dAD1LuJBLfNrH5Xco=;
  b=TJ+WF6jGtBE2WWDuECRrAGjsoVvQGyPOFlFaecU1JUGrD/AOhhDDQ1pd
   5+r1c6MBlWIW/b/M+cELN1B91/cTsydQpzttgs2P/eXKhDwL5z9p0JHfa
   0bxH2vNDdQLIZ/aBYZ83ptIKEcKTTs7B7/sLZRFlwfFd/Ns13UOuyMlyE
   9MZRhvSvaAU3BXR1Zswx7VJJrmzQRUhSbzgONZKgm3nOTxUcsfIgFkDHv
   PNBObIxECI3gXfRVrcwL8tg5hyWexowiqs5u9p6wDNcVzMOYGpXqExiq2
   5N4x3imOrKU910mBAtu2ZjmRw6+a1pImqTWQSvi+SyhaCqzuquM2bob+F
   Q==;
X-CSE-ConnectionGUID: e5Zei5veTOKWfEtdJliAtg==
X-CSE-MsgGUID: mjETAJ8CRu6lNRJzsbGbOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792350"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792350"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:25 -0700
X-CSE-ConnectionGUID: GxCdZ8F+SJ2IKwfD0beIOQ==
X-CSE-MsgGUID: wz1CUaY0Q9imst34jKG+Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949148"
Received: from ticela-or-265.amr.corp.intel.com (HELO xpardee-test1.amr.corp.intel.com) ([10.209.54.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:25 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] platform/x86:intel/pmc: Use the Elvis operator
Date: Mon, 24 Jun 2024 13:32:17 -0700
Message-Id: <20240624203218.2428475-9-xi.pardee@linux.intel.com>
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

Replace ternary operator with Elvis operator in
pmc_core_ltr_ignore_write() for better readability
of the code.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e75c56ee54e6..cfdacb04ff8d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -522,7 +522,7 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 
 	err = pmc_core_send_ltr_ignore(pmcdev, value, 1);
 
-	return err == 0 ? count : err;
+	return err ?: count;
 }
 
 static int pmc_core_ltr_ignore_show(struct seq_file *s, void *unused)
-- 
2.34.1


