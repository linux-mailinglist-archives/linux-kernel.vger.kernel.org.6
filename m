Return-Path: <linux-kernel+bounces-291303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD695609F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED563281FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208F38DEC;
	Mon, 19 Aug 2024 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTImcdPM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D5D225D6;
	Mon, 19 Aug 2024 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724028972; cv=none; b=ZS/fhQ/NhK5eTX8Q4isYKJhsZgSIhA6AFWXsfiaxQrQQGGtNuY3hUcVSqS4IU5UsRtoC1NMt7CeDj5oB9NYz1UyX2hF3QT1zhMSu/i51y5jNq8i4RfIDiXo6GVI1nBEX+ayZpiDclcyeuiYuR8YMEXO6cMnQxvoB/4fFmXc4OqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724028972; c=relaxed/simple;
	bh=Bymm5J+Hxa+nIa5r7opFxivt3HytlDOiUogU+IsQOZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kg5jo1RSSQJMNjc2jQYxWPH07f+UAOzE5kw5Cni64XPLUHgVnWoIfb6HXegsBTjlS178/5g33zT+AVP/buULMScngzzA37br3/j8Q6HGKk/TULYoIGFYq6FhBzQA/Naqqy4j70vnl8ZOYWGf6FdIVSfQ2t5nRvChTuxpPDUgcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTImcdPM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724028971; x=1755564971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bymm5J+Hxa+nIa5r7opFxivt3HytlDOiUogU+IsQOZ0=;
  b=bTImcdPMAghKteIbecwhWt49AjsgMxv1TPcmduX3E/sNt3/1VZYWrUEl
   u5Dp37U/sieT1N6lDz+khL0zZ/2dn4ydRjCWn5aU2zbbcc2Koe7b6BqBh
   sKqGFllpDCdhUaojRlKztTaSYUKXZqqx2zmG1KRYoa+1Q3f+iI5Gf3qiE
   IL5bmnkZNGjIVYeWHdbul6H4NBcmvIZDizQrZWZmANnLd4Tfcmi6yjJBI
   gHNAssiN0QX8zsQoFSQuF8zXIPZDix+RjJBCIi7GTJDmvO3+WT71SSFBZ
   BAYIE+7FU5CdKaetsvB/4M1UuU/Pt8bxGdhB3vm5F8ngzALwX0SmPR2n0
   A==;
X-CSE-ConnectionGUID: gNJsgjw5RuORkq12bPrOKA==
X-CSE-MsgGUID: zIKkrtjlTuWn2DiPPZndOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22400174"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22400174"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 17:56:11 -0700
X-CSE-ConnectionGUID: BP0+2g6UR/CvXDaB7mwWOg==
X-CSE-MsgGUID: hvsor1fNRHuAV1YxE8/Ing==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60771426"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.197])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 17:56:08 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 3/3] soundwire: intel: increase maximum number of links
Date: Mon, 19 Aug 2024 08:55:48 +0800
Message-ID: <20240819005548.5867-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819005548.5867-1-yung-chuan.liao@linux.intel.com>
References: <20240819005548.5867-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Intel platforms have enabled 4 links since the beginning, newer
platforms now have 5 links. Update the definition accordingly.

This patch will have no effect on older platforms where the number of
links was hard-coded. A follow-up patch will add a dynamic check that
the ACPI-reported information is aligned with hardware capabilities on
newer platforms.

Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index cb8e7396b4db..37ae69365fe2 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -453,6 +453,6 @@ extern const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops;
 /*
  * Max number of links supported in hardware
  */
-#define SDW_INTEL_MAX_LINKS                4
+#define SDW_INTEL_MAX_LINKS                5
 
 #endif
-- 
2.43.0


