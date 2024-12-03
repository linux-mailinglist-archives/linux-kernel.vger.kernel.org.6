Return-Path: <linux-kernel+bounces-429526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EBD9E1F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFA5B3CD65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8871F473D;
	Tue,  3 Dec 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw2G7zZp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBB1F12EB;
	Tue,  3 Dec 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231919; cv=none; b=h8/UAa4iQ5Yae2wfjvyzH/GjQIjoGPwwi95FkMiSqpT8Nen7NJ0ojOzIBk9KK7i2FHBYCwyNVm1JYiw1Pxlj2mFAGZO87P1xmB/UI/3Q0/YiRa3SRQ06GAJUCp6tj4pTgL3Zo9nQdE+ZBxuJ9i6VRyVbDBzWQDFH99bJy/xFRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231919; c=relaxed/simple;
	bh=se+FfrNG/tHWlG8AVTeklUrIz3IoOVpmdCto8xshgKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8vFtSiwd3vHtF68smeFpJu1qKz2NWwY7KU3OWov380PCuqpqi9DGczb7eROlvYkjDVMwlBeNZEMENyr8ALSRiCQ/gZmJZjsXFzk/zD+A3SAi9EDQpNgkBcfzitE2wVgQ2cR3mBri90jOX5UOc8pBPotPakuR4CTAY/9QcDo2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw2G7zZp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231918; x=1764767918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=se+FfrNG/tHWlG8AVTeklUrIz3IoOVpmdCto8xshgKg=;
  b=Iw2G7zZpA4DbPIGBrFV99n0PKxXVSqRGYuD0PzXN/8iXh3yqoYi1JnE3
   vTUNeuGClnuh1BJxwsClhdq8ylsn/e70+ymqnxRy2jeofULgrmGThPumE
   AhVmvEFoXTiPtLHJgK8FP4GCNCZfPjrWauIvqhoxZCnvvTDKbRTEduxvY
   Pxp+d7s9pXokZU6NQm4eJXutB8ZomDqdTT93k37OdpKRVlGxUa0EAwrB7
   mpVjHhlOEUcAcBpYL3NajI3iD8zYEcoj1hugcBs2iKMHlJT0X4zBsbbyR
   ZR4mw1kvrIskAbuEXWUkvU16fIwATHk8+CL69DKLphZvizQOmdy5aamvl
   g==;
X-CSE-ConnectionGUID: KKXv62mqRG+h6BtAiH6uUg==
X-CSE-MsgGUID: Lj366tzUSrKRr5XFlY7zGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500738"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500738"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:36 -0800
X-CSE-ConnectionGUID: z7Zo98ORRbyh3IZfQemKWQ==
X-CSE-MsgGUID: 4DS6sD0kQa+AIBe46Y/z0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896087"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:34 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 05/14] soundwire: generic_bandwidth_allocation: skip DEPREPARED streams
Date: Tue,  3 Dec 2024 21:18:04 +0800
Message-ID: <20241203131813.58454-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

We should not blindly walk through all the m_rt list, since it will
have the side effect of accounting for deprepared streams.

This behavior is the result of the split implementation where the
dailink hw_free() handles the stream state change and the bit
allocation, and the dai hw_free() modifies the m_rt list. The bit
allocation ends-up using m_rt entries in zombie state, no longer
relevant but still used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index abf9b85daa52..2950a3d002ce 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -238,6 +238,9 @@ static int sdw_get_group_count(struct sdw_bus *bus,
 		return -ENOMEM;
 
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+		if (m_rt->stream->state == SDW_STREAM_DEPREPARED)
+			continue;
+
 		rate = m_rt->stream->params.rate;
 		if (m_rt == list_first_entry(&bus->m_rt_list,
 					     struct sdw_master_runtime,
-- 
2.43.0


