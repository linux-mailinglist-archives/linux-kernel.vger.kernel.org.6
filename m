Return-Path: <linux-kernel+bounces-394153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D779BAB37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E195D1C2126F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F0618C342;
	Mon,  4 Nov 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ct1+3zWK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6375187321;
	Mon,  4 Nov 2024 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690642; cv=none; b=QioeswpJUWJfFMr6Vg6oZTnbiNXW58COGvegMhtp1XiT4/OXw4trbVUhA2n/HN5+bzuxinoNGI73wJW4aZttI+os7OCe+MDOjZ4j7Em4BT2OpupM48orJqk3xRMx/KZsn48u6WC+I5aZ+lYfIBYZnb9rm9qPKo7vTDnUevJaz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690642; c=relaxed/simple;
	bh=hOzi0qeY+i0tz40iO99t25BcDusKrLQ25SgZWwa2zUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ij1FHJVbHpGZ+w8ZDUUVgH8QXbXkpJkZIGEC5NjEx8UvrH15FIl3S9CFKF8kaKNHJ0MoGc/lCUAO5u7Jfo30k/G43CnU57UZaEpWY6HwSlKcdW38QaEJAKTC5HwbrjZ1Tj7qgbsALkJqCpIQQeY303FXWjtsKzk+m94yDGSdxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ct1+3zWK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690640; x=1762226640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOzi0qeY+i0tz40iO99t25BcDusKrLQ25SgZWwa2zUM=;
  b=Ct1+3zWKym/VgxhqnwknSP3hpA24Wghu/HIEoMYx6/KhY4qQEUh3lcPt
   rK+IjOoHBz++SXRmsuc4rGZwwLtBvlRkYBXhpnNR8OTqdhbwv1cH895LV
   cq3BLxtAjvlbFnuoe7qk78rEw9CzkDipslyuL5VoXBcrxNfSor50x7BNH
   QuHyX/0snP1J8fjMfzejWt7FKPBLXzm6wFDY3WjyPMp0m9U1klXMCZ4f2
   2Op1Vf8qVxg6ZDuKhuJBGbOZODuHL+W3IsQaPw1lqgIQfF9dvSyita4/S
   fgiHIVD9bY/iJTepEYMexMjifxXnvYOch+AEMfnJU8IX/3+huOhoDQsXD
   g==;
X-CSE-ConnectionGUID: HJE2oPjVRXG9GAerqUH0uA==
X-CSE-MsgGUID: vE0u6P5DT/CR3li64zsijw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594285"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594285"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
X-CSE-ConnectionGUID: tdQGZ4pSRKC+szql4SooYg==
X-CSE-MsgGUID: /nG7txuJSOWsqfgzfUVl/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331808"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 05/12] soundwire: generic_bandwidth_allocation: skip DEPREPARED streams
Date: Mon,  4 Nov 2024 03:23:51 +0000
Message-Id: <20241104032358.669705-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
References: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
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
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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
2.34.1


