Return-Path: <linux-kernel+bounces-429534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ACC9E1FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E189B4544F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8C1F759E;
	Tue,  3 Dec 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKVMfjU/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E01F7578;
	Tue,  3 Dec 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231930; cv=none; b=j1IRLB17kwhWRdIUSnFHulTal3q0iYvckjxbvvsQ4cWNpCs983Y6bIelHG6zkvE6DoATJG8hV8+mqpXSYJu+LDe2NR9jELA4DGc3R4vurUaUKRYTX7ztH6QoXSmvEUmLZ0vf6jPV77AcNBdMtAhKs8+apS2WjKJVlXS2qCsHOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231930; c=relaxed/simple;
	bh=IWIIWEXMP+HgRrUppmGaLdX5pqFywKT4BBaDK/Fe0tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAXJ2D014DYMcbNEap8ZUwUcS9ykXiKimsjiFnpOERUhqc5L7Z8Xaoo7P5/CRjhDikWWB/o+xKlb95z/I4QEdbG8WtbGAtrd4NYZE4LwbnGdpaVN4czxwzbB+fJOekTDZzjGvMmn/6ebEJfDgoIEs/hbxDVBY5GWs/2ft4xxQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKVMfjU/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231929; x=1764767929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IWIIWEXMP+HgRrUppmGaLdX5pqFywKT4BBaDK/Fe0tk=;
  b=QKVMfjU/mQle6f3uxKhguruAYVt3m2T55OnX2TJ+hKOCA07r2FRDwNbd
   bJLfVAaQfAbXU1J2JZwuePnXspJiITovklP5sbHwM5u90dZkDCVdtQOIv
   iWB5uxEAe09sl+hmsLQYfSCay9eqIO0YbvQAZQSFks5azAkbiJcmIztno
   0xhFVBLcbexL5vT4xl+OkVA3IDfxP2ZpKGnb6etxF5ANDol9COu7eowIO
   5sji8IBjHu1mt7KCCX6ANWz6wV7ZFf2id/2jA8u8UQbJh61szO9SIBe5X
   XmFhpcqKIqsf7oDswbmNg+vLYbDW/fC/4FtY3PXyVmFSNPlK7uoA9ybIN
   w==;
X-CSE-ConnectionGUID: ChhYF89SQnmGxBbRSgoZGA==
X-CSE-MsgGUID: grSIBw6yRrir8X7wiL75fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500796"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500796"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:49 -0800
X-CSE-ConnectionGUID: ssiUt1JoQb2bPjqbgyZdMA==
X-CSE-MsgGUID: EzzhuerLRhWW1D6QHlYndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896155"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:48 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 14/14] soundwire: generic_bandwidth_allocation: count the bandwidth of active streams only
Date: Tue,  3 Dec 2024 21:18:13 +0800
Message-ID: <20241203131813.58454-15-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sdw_compute_group_params() should only count payload bandwidth of the
active streams which is in the ENABLED and DISABLED state in the bus.
And add the payload bandwidth of the stream that calls
sdw_compute_group_params() in sdw_prepare_stream().

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 062e7488b226..59965f43c2fb 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -188,6 +188,19 @@ static int sdw_compute_group_params(struct sdw_bus *bus,
 	}
 
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+		if (m_rt->stream == stream) {
+			/* Only runtime during prepare should be added */
+			if (stream->state != SDW_STREAM_CONFIGURED)
+				continue;
+		} else {
+			/*
+			 * Include runtimes with running (ENABLED state) and paused (DISABLED state)
+			 * streams
+			 */
+			if (m_rt->stream->state != SDW_STREAM_ENABLED &&
+			    m_rt->stream->state != SDW_STREAM_DISABLED)
+				continue;
+		}
 		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
 			rate = m_rt->stream->params.rate;
 			bps = m_rt->stream->params.bps;
-- 
2.43.0


