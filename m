Return-Path: <linux-kernel+bounces-367822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B553E9A073D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E714E1C25A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6362076B3;
	Wed, 16 Oct 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3T47An1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD042071FA;
	Wed, 16 Oct 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074232; cv=none; b=LthNHtxAx930cCNjcDY5J5R6Ja9DqhcfQ7pA/ioXMHB2mwwb+FhsS6MFO5KYVhbEKNitL5L7xLbhUC+JbFflS3Rgcz26IHs14B+ElU8AT4iZAVDrAQBh5dv6rxE4h7dnONCa29+zk99nO8uzw+xDIwVeZQcMgwIBLSWQY7uPfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074232; c=relaxed/simple;
	bh=4jIe2xqSKVjGEWTr3xBGOmO3ircpkSEOO2331657ryA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL5EYPoecTTh6CZY9TXqxnszCWHXxCr8i/ZBr8gBT6xoCVfqcqQTRaFxtb+6hDEjC7ROOTlECuwZu/bAVlf+195zfqwWsCveTo9t3xqkHMehKn2mmcerCyevPL3Xw/uABLOv3SPNC9KGy5G2Ilxgqvk9RH6rq8qZnSgLdEcj3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3T47An1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074231; x=1760610231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4jIe2xqSKVjGEWTr3xBGOmO3ircpkSEOO2331657ryA=;
  b=D3T47An1Eb5C+UNYMP7tTgYVXlF/w1TUmtTZL/o35bZDXDmuhz0bXx53
   u0O7H87C+qpTs7MSSDhXL5k4Y/3eQRC8lF12aWuZAUrBj8FgyykRCldkc
   OSrptHt5N/f071Pmy+zmTscnINQiGVR7Xtzb2U1B8VY9PrJCEVftmpDaH
   2iXjA9dyLHqFMPo7dx+8t3L2bEktqCNI0NRk7tJ/NN3aYz9fb/dKzzFZE
   J8XMbHhfhmgdlJcvvprIXV4qi2AZ2ltAHtSj+S4uAi6+X/bldPcKi4a1j
   ohS0pd9ynoBpvWxsoyCD15bvSar6VbslsA4E8CW8J6W4UeZXEotcoQCNK
   A==;
X-CSE-ConnectionGUID: 6LhsCupHRIeWpzcU0VSDdg==
X-CSE-MsgGUID: +hGKKkyMQ8iSIFxCMKg2Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985865"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985865"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:23:51 -0700
X-CSE-ConnectionGUID: GBp4x6Q2ROGyOMMondF+Ag==
X-CSE-MsgGUID: TO/ZkeOdS/uam1yj9Qb0GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82960816"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:23:48 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 01/11] soundwire: sdw_intel: include linux/acpi.h
Date: Wed, 16 Oct 2024 18:23:23 +0800
Message-ID: <20241016102333.294448-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For the acpi_handle stuff.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 37ae69365fe2..fae345987b8c 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -4,6 +4,7 @@
 #ifndef __SDW_INTEL_H
 #define __SDW_INTEL_H
 
+#include <linux/acpi.h>
 #include <linux/irqreturn.h>
 #include <linux/soundwire/sdw.h>
 
-- 
2.43.0


