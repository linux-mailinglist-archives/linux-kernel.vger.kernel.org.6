Return-Path: <linux-kernel+bounces-348838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024198EC6F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC91B2842D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE11474B2;
	Thu,  3 Oct 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2CzSQ1z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4F13211C;
	Thu,  3 Oct 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948923; cv=none; b=ZitUh3CG/n0GlAIji4/YCmwLwywe0ti6CGXc94JVBoxB+CC1y9HSdpfe79fv6CYt+3kEYAphByy2Y4Ojc1+wg/W8h2Nf/JVG7QqYbPV09oJIMEBpQ5AGXEsSdEmI3h1+7UEqhA+Od67vQl2XQAb45GFlWPlJDFbnMxVmZ20oZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948923; c=relaxed/simple;
	bh=9yRti53di49PLCNBZ7VmGsLC9c5SyiDzMBYw6RkzpMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aBdW0PMFi0eFriOp/A5/qIr7RPg0OTByN5Y6BLu73q5RiG6bNm1txbbwA35G6ML86hq2hKvq4nvIwVg2tVRv4wxpPXGlHGNWwzYaE2YEcgA0tlGJTjbpepO4W5gmqyhCWNs8teBwH/EO1xa+KWEZGntRD+AbENu4DoKR1wPYP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2CzSQ1z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727948922; x=1759484922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9yRti53di49PLCNBZ7VmGsLC9c5SyiDzMBYw6RkzpMs=;
  b=f2CzSQ1zbt1XG+OeptLD0cnBG81gG9iYiB7jiH5KdTOvol85jIH1Xrki
   qTjpeDGf/DkEmTBN2Gqa2mHFKGlKuT4/ZDCb/lqQ3keCPuOty8ZAI7PNC
   FHgTCTDI4eeVvLzAn3KRTARhYw9fcD5MvgGZ9O5yLsECPTC8ODzQJSj1r
   WM7RpT+CBRW8lwkcybQU/QGfFOZNTOQlASDRvVSAPYpACemdCAjVQN9Yo
   ha1YF0Nmcpp9+tCFekgMjmCE2PrjJ9U9pVuvo9CdR4/dK9sYAvc1k3xvY
   ivbn1E+GLI1lx15ogqgLhuxOLrXOyCUWdpWNtG0R/nzlF71vqy11pSrNy
   A==;
X-CSE-ConnectionGUID: /nVuf4GoROSvHJOzdNTs3g==
X-CSE-MsgGUID: V+HsyZkLRV2l4/8aufpvRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27022059"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="27022059"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:48:41 -0700
X-CSE-ConnectionGUID: C92sbyi8TzG+UtnA8AfirQ==
X-CSE-MsgGUID: V9515bIJQUqmxgpANg3EMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="105065633"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:48:38 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: cadence: programming flow corrections
Date: Thu,  3 Oct 2024 17:48:28 +0800
Message-ID: <20241003094830.119673-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To follow the recommended programming flows.

Pierre-Louis Bossart (2):
  soundwire: cadence: add soft-reset on startup
  soundwire: cadence: clear MCP BLOCK_WAKEUP in init

 drivers/soundwire/cadence_master.c   | 30 ++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h   |  1 +
 drivers/soundwire/intel_bus_common.c |  6 ++++++
 3 files changed, 37 insertions(+)

-- 
2.43.0


