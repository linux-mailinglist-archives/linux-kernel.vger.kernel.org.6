Return-Path: <linux-kernel+bounces-288861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D827C953FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172EF1C22273
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C41E74E26;
	Fri, 16 Aug 2024 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnovtYyx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE016F077;
	Fri, 16 Aug 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775633; cv=none; b=jBhmWRBzuqbsRBQ/RVir+Ta/gZDWtSioif+LiOZrcCgEbUCvLjwPhcOll1D1llRhzJEAZfnVsYfVgQ2d9zqkFrbCeMnayWQVOjR+5eqARytLu1E4rb+S9Zvi6z+r/hLqslV2Ye7nsZbbY6Jh+S6/R/nQjfnQGZgXimSLyU9am3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775633; c=relaxed/simple;
	bh=or0XB+/dgJu4KGVOM0mhWGDl51cpwO3IM2pUWBpH75E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t56VxuMNQV7lghP9+yqdB2TH2jePmml5C9DL/s7ouZ9lDEJVmu4rNvrYH3+tnKQ5WbkbkdlX4q5tj4St4TXukfrqwwZQ+IT6mNW3NReoXDhQMQTsUlBS8G5tARoR3NWeIjgsbOf6KEJmg3RzZ/Rp4A7gX97kLySnKiTshHETKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnovtYyx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723775632; x=1755311632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=or0XB+/dgJu4KGVOM0mhWGDl51cpwO3IM2pUWBpH75E=;
  b=BnovtYyxDHVGzWO9MXTBpWWkgiOGZrnLgSDj0heILCOc0MmvpA4PhLYx
   wMqAHdY/OlO9NMxQVxvi2ayPF15JhfVmfowYtiCoi1ydl43te+PCUNB7K
   eXRjLKfGUD3wUISBT8Y/f/uvW0aoDm7SNakc7nNFzdthFjBzFrwJYpOaw
   sSJKBvA6CuegD34yQlMKNbuwViiZFpj/hvhB3zHxa8H9sHoqpqYH/J4yC
   f7Vprx8DosWJNY/mdYieUX4LCMhncB3pc20bsTTxwwD0LwW0AfaUtI8Va
   uD6AQ8A1koQcVPCcaOnqOUqQMF/nibYX8C1Ckvi6INpwjmxFheWfxky7Z
   Q==;
X-CSE-ConnectionGUID: F8EXW4IoQYu4slVMSSkrgQ==
X-CSE-MsgGUID: soJTht3XSSKIbNNH3pcqCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22203573"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22203573"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:33:51 -0700
X-CSE-ConnectionGUID: k7RIgxYlQuSiUiJgj5BBcQ==
X-CSE-MsgGUID: F4FC6WNzRLCQOjTyWNH8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="63949207"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.176])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:33:48 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 2/3] soundwire: intel: increase maximum number of links
Date: Fri, 16 Aug 2024 10:33:30 +0800
Message-ID: <20240816023331.6565-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
References: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
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

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 87d82ea9a13a..edbe1d4af8f8 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -450,6 +450,6 @@ extern const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops;
 /*
  * Max number of links supported in hardware
  */
-#define SDW_INTEL_MAX_LINKS                4
+#define SDW_INTEL_MAX_LINKS                5
 
 #endif
-- 
2.43.0


