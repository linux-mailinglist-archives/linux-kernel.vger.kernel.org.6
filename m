Return-Path: <linux-kernel+bounces-394158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687959BAB3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4843B22495
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62429CE5;
	Mon,  4 Nov 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qxuo/+QE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE718CBF8;
	Mon,  4 Nov 2024 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690644; cv=none; b=gdLKNLaSZeZ68aInhy/VUHkyMRU8ln5yrAwn7HSYHTkGyej9HIDeBT6WRqFl0cCnbxicfYa4VphWmlpekhidc1AY9DH6CnN57Pua6+PpdOh42pTO063MZhjJAWE0M5f1KjBrAVYmDw9FlqcwXKIJiGj/lnguGLwHQY1PKkkfIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690644; c=relaxed/simple;
	bh=GWTcXryd8vSLGfgO+TfhLzbUy81GbHz+WxF71vk9Bng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRelgP7v5JhpQM1yomcScHRgA0B+xDP2AZ+3QXrFzOmzTvdEYnOri5nGRQQqRvl4mdqQNvDywSu5DprybAx97H4eCTXybY4c31iPo9fp+7CWflZRrPIfpAj7hAy/pErLJUvhm8A5CknzpTJleHQwcZAhHMT0qaGIRGCNwSGIIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qxuo/+QE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690643; x=1762226643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GWTcXryd8vSLGfgO+TfhLzbUy81GbHz+WxF71vk9Bng=;
  b=Qxuo/+QEifCK3MrH3g+5WCcD0rSKWNKla1lz5aYmReQ58a3pYHx6YK42
   yvU4LrMZFh9AQ2ZwKG9w5qzIpD8F9hIFMeMuCubiEvSoeFGhqh0Lcmrxr
   jqjIpkp9TX3RHp4LOiAfTc54vpHo7lZktz9N0zUamyoCuYzMtAaibhCQy
   QS0m6N7quGf6KpVK/VeypaXMlsp9i4y8VmMRVRcQsuVnbCMnfUZ7yyN06
   BROJOn/2kfOpy+hBpWlPM6I0ept7iU52KRfpfkuGsyvqnH8uJDsP0/kvf
   oVTx7XFiB426iwzqJZm7xFLLd+AMlj7JUVrC+HKyfPYwcYfA8Bp0XAsCW
   Q==;
X-CSE-ConnectionGUID: dWiDFzbKRCCjz8/7CLEIDw==
X-CSE-MsgGUID: DNLA8y/UTMmer7JkMSWqWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594305"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594305"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:57 -0800
X-CSE-ConnectionGUID: I46TKKblSIOerpv1FEoN5w==
X-CSE-MsgGUID: 6iLKqTs+S92RmVXd6812Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331831"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:57 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 10/12] soundwire: generic_bandwidth_allocation: check required freq accurately
Date: Mon,  4 Nov 2024 03:23:56 +0000
Message-Id: <20241104032358.669705-11-yung-chuan.liao@linux.intel.com>
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

Currently, we check curr_dr_freq roughly by "if (curr_dr_freq <=
bus->params.bandwidth)" in sdw_compute_bus_params() and check it
accurately in sdw_select_row_col(). It works if we only support one
freq. But, we need to check it accurately in sdw_select_row_col() to
give it a chance to use a higher freq or use multi-lane.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 5c4dac36ad1a..d2632af9c8af 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -373,7 +373,8 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
 				(bus->params.max_dr_freq >>  clk_buf[i]) :
 				clk_buf[i] * SDW_DOUBLE_RATE_FACTOR;
 
-		if (curr_dr_freq <= bus->params.bandwidth)
+		if (curr_dr_freq * (mstr_prop->default_col - 1) <
+		    bus->params.bandwidth * mstr_prop->default_col)
 			continue;
 
 		break;
-- 
2.34.1


