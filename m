Return-Path: <linux-kernel+bounces-553656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58FA58D06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B67916A504
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44009221542;
	Mon, 10 Mar 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRt9FMkj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1221ABDC;
	Mon, 10 Mar 2025 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592228; cv=none; b=gBZjQYWAid+CnosgiUMXa4ni9CaotJDtJwJ1Bb4yGfonWnJn+wC6RjbopYWQly3S/0hxH6c7yOQTSJ1UhHYL1+lws5vNdq29pZuKX7FON+g+UDC+/GCUTQMj/LNE4EJPFvBjJYH1Rb493MgeLoq5LtdDmY8WWJPNzF0Uknri1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592228; c=relaxed/simple;
	bh=i4JT+JxMsfFpLvV5/cZxorXR5Kc03qscufvEXCGCJ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsV1vTM1Qr84h/m1VMroM7XuF6f7ETUtlvhJgPNravtb9xYIZBWonVZAkipVLmhxCC5VSAREfz2v51jvypYTQPiJcamshSMAuFIDJqCyieEzVd8a+DhlwXm202Sad/n+2dx7JXEWQBXiPRrwIrEWxdjBlzHeZ46+DXTDPerPtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRt9FMkj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741592227; x=1773128227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i4JT+JxMsfFpLvV5/cZxorXR5Kc03qscufvEXCGCJ2k=;
  b=kRt9FMkjJmJkPsZFNy93oYbS4pM9XsF2UxZHocO+5pQTwRmGDh995NG0
   OtDGMU6S+jPvxsYn9U1qCpXjXAqJeYmGRh5OmdbhSZwz/Vpua4xjWLRQU
   maTNph7mz5EEWrQJtiPQfhZO89QwJmPnGgrzkqLVUVqNyndsed/URG2D/
   CLQieYBtVluOajVRzKu871Ut5xHX8vUJMd5bDvK9orfS5lGKNJIVA7vsI
   uOjXLcXoWQdzwemfGQt75Z50QZQ5tYv4Vz+LbmvQJtqZUrtL+5i9E+IFF
   lQoWNIxqfxAXogRxbVIpBhp4fIHByhNKkZ21QASjzAmZOUCUiEtw8FM9X
   A==;
X-CSE-ConnectionGUID: bjlnjDCRQiOBrVXW+XMaEg==
X-CSE-MsgGUID: zp3mW6viSO+nveXi4VZ30A==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="46220593"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="46220593"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:37:04 -0700
X-CSE-ConnectionGUID: KaUImN8HS9G1enupEYM9kw==
X-CSE-MsgGUID: olnjqPugR2eckjRbMJ0M6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="125159669"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.85])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:37:02 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH] soundwire: take in count the bandwidth of a prepared stream
Date: Mon, 10 Mar 2025 15:36:53 +0800
Message-ID: <20250310073653.56476-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a stream's state is marked as prepared, it is ready for
playback/capture. Therefore, we need to include the stream's bandwidth
when we calculate the required bandwidth of a bus.

Fixes: 25befdf32aa40 ("soundwire: generic_bandwidth_allocation: count the bandwidth of active streams only")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://github.com/thesofproject/linux/issues/5334
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index b646c2ffe84a..1cfaccf43eac 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -237,10 +237,11 @@ static int sdw_compute_group_params(struct sdw_bus *bus,
 				continue;
 		} else {
 			/*
-			 * Include runtimes with running (ENABLED state) and paused (DISABLED state)
-			 * streams
+			 * Include runtimes with running (ENABLED/PREPARED state) and
+			 * paused (DISABLED state) streams
 			 */
 			if (m_rt->stream->state != SDW_STREAM_ENABLED &&
+			    m_rt->stream->state != SDW_STREAM_PREPARED &&
 			    m_rt->stream->state != SDW_STREAM_DISABLED)
 				continue;
 		}
-- 
2.43.0


