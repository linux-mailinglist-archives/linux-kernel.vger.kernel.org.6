Return-Path: <linux-kernel+bounces-227914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD54C91580C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0821E1C230F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD11A256A;
	Mon, 24 Jun 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjE+RST1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23491A08DF;
	Mon, 24 Jun 2024 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261149; cv=none; b=KdUO2+TtOlFqfz43mnyS2LdKIsgT+v9RjPgt+cxARRzjjggwwVe9bg+rAKSizyMgKvzoQvQfMsph3Z5+pQy2tDJQcM7VexZ9QlF746zN7woi1m4EFmXYF1whgIRZdCG6sBIPXesW+h5ifcP4ER1LBJvOm3I64lXzSGQmP5Tc6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261149; c=relaxed/simple;
	bh=pt1iApTIQNthj5gXBnuo+1qTGtwZiQtlZFNYjKNh1/c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNzHf+BKrX58uJx+fkNr09ArLA5kkXhWXM9p+MpBe1staJ4wh9DnrOBUuvgeaqJ5KjN1rSo0hRvljfGoKX/KZe3Xj65APWlABRsDBUP/nX4Jw6XLb1Xtg3IcpVeqcGekl4gl34jvkzGIwPLKhLp+Xy9X8RxQgYeTI1mHluLcnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjE+RST1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261148; x=1750797148;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pt1iApTIQNthj5gXBnuo+1qTGtwZiQtlZFNYjKNh1/c=;
  b=HjE+RST1d94HJmmAFem8qpv5a8yCDz6IU3FVG+s6EW9OFNY8WFgd4RyX
   e1IyEersV42Xkfz7gSacPM520yejZWnBdREFJaUN7sdNEXUDkuDDxA8Z9
   SzjdqI23Z41UX0Op4NFeNwN6iqn+IjxJMm25j0UWtM1QtX55DUt03T/BS
   nrweH/TpwBFAwYFGj89KihpBzKljZshKNF8nSp4ZmHwV1p/CLG2CTmvUM
   QZrc/11D+9ldd9lq/U6NmkV3bgilXNPDPmJnM6Iz28OBuqhkWw9oxIdP/
   /ppcCHAtr1ITpGw1ssBKd3+nTKvMUBEcEIubYGBv0QOBW5YlmXU0R2vMj
   g==;
X-CSE-ConnectionGUID: p4QdP/5hRBq96/e44elykw==
X-CSE-MsgGUID: 1b2wDX4aRFGh+OTmC0Aamg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792343"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792343"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:24 -0700
X-CSE-ConnectionGUID: CbeKWuujRZWZbe85iO6WFw==
X-CSE-MsgGUID: Ky4fuNk6RlWMllY85DmfaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949144"
Received: from ticela-or-265.amr.corp.intel.com (HELO xpardee-test1.amr.corp.intel.com) ([10.209.54.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:24 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] platform/x86:intel/pmc: Remove unneeded min_t check
Date: Mon, 24 Jun 2024 13:32:15 -0700
Message-Id: <20240624203218.2428475-7-xi.pardee@linux.intel.com>
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

min_t() check is not needed in pmc_core_ltr_ignore_write().
kstrtox() has a built-in overflow check.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3f271ca48164..99adef28b6d0 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -513,12 +513,10 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 {
 	struct seq_file *s = file->private_data;
 	struct pmc_dev *pmcdev = s->private;
-	u32 buf_size, value;
+	u32 value;
 	int err;
 
-	buf_size = min_t(u32, count, 64);
-
-	err = kstrtou32_from_user(userbuf, buf_size, 10, &value);
+	err = kstrtou32_from_user(userbuf, count, 10, &value);
 	if (err)
 		return err;
 
-- 
2.34.1


