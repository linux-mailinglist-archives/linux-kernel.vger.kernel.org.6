Return-Path: <linux-kernel+bounces-570649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88789A6B2FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059C48A3ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E61E5B70;
	Fri, 21 Mar 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTNzJB6k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62F1E51FF;
	Fri, 21 Mar 2025 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524248; cv=none; b=ciXemGLmCiXC7jEJXxjvhkyX+VAFiFvmkvEFAPTifJNJlb5B72lsqiID4pNAeqOwtGriibBBZDwIslzE9IagRWZe8Lcum6yDF87wGQHit5kxCTgVqHzddZzqOXaukw5MmywMnlwh3nEfEN1tWaO0NXRZCS3gjmw8TlqynEK/mN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524248; c=relaxed/simple;
	bh=RPdN3+1lbuDMogBmWweMEZIwNXOQcQp4csM0z98xu9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqXbHKnjBmxX22U4ZrVkYBCGu4mLePC2uKknanWTW/BdsgCtHY1D8SXicAGkjWj4DkWmrGL534hh5nYfV0frjH3PCKE0dFvmhwSAXdEYO7fEzl5rswfN9MXpM9Ecd+yAwyR4P108/Y0/C/YSRUnwccA4dT2Rw4K4AXT+ZbkBgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTNzJB6k; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742524247; x=1774060247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RPdN3+1lbuDMogBmWweMEZIwNXOQcQp4csM0z98xu9E=;
  b=GTNzJB6kbSJPat+DnhgNAhP/rX6n8D+9S0gRVDdqIbOhfo0ArcTnloJt
   AsUKWLsXvjxUroNoBRRY45JTFxPcbPxgnb1IHT+s846MUPG1aMtYcbpFW
   bZ3X6IOW7+uyMOCtinJzc5FNMLdL/J4e1KgQAufcWX44kKuyUGHw2AQxb
   dsVHBSOy+S06bF5Hk+s6eLe/gETG07oo+wgAkc9jwNbrp9JEnk5mJ9wt8
   YVw8ud9bSSepnW6e1aiParwI0/BOOj5WbN4KqWUvDhjiH0x1jbWx2/ir2
   yZ6eGDf4Nxn2FgXkky7Q5k5vxFcxc2DqOFX2Q3+oCtmd6uiNcMrWvjhcp
   A==;
X-CSE-ConnectionGUID: p3SWZ/rZQIKFwFiaIfXZZw==
X-CSE-MsgGUID: plGHG74eQse9rDWWlN1mog==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47557527"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="47557527"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:30:47 -0700
X-CSE-ConnectionGUID: VP/tF50mRcmzILyjdj0eTA==
X-CSE-MsgGUID: 3hvKUXJlRdm3KKU23Rcr2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123446139"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.252])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:30:43 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 1/1] ASoC: SOF: Intel: Let SND_SOF_SOF_HDA_SDW_BPT select SND_HDA_EXT_CORE
Date: Fri, 21 Mar 2025 10:30:32 +0800
Message-ID: <20250321023032.7420-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321023032.7420-1-yung-chuan.liao@linux.intel.com>
References: <20250321023032.7420-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CONFIG_SND_HDA_EXT_CORE is required for CONFIG_SND_SOF_SOF_HDA_SDW_BPT.

Fixes: 5d5cb86fb46e ("ASoC: SOF: Intel: hda-sdw-bpt: add helpers for SoundWire BPT DMA")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503170249.iPSBJSf5-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202503162042.2cNgaBmC-lkp@intel.com/
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index fae3598fd601..dc1d21de4ab7 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -345,6 +345,7 @@ endif ## SND_SOC_SOF_HDA_GENERIC
 
 config SND_SOF_SOF_HDA_SDW_BPT
 	tristate
+	select SND_HDA_EXT_CORE
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level.
-- 
2.43.0


