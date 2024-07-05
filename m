Return-Path: <linux-kernel+bounces-242444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AB292881E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5B91C228CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9C0149C70;
	Fri,  5 Jul 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I73glsRO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717813AD2A;
	Fri,  5 Jul 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179795; cv=none; b=UCYVaBjhM2hd42vTxVmFbX+TPDFTe+I8JlypY3RRfSd/p5htTkgBVEf0LWstoQ6Vcs+I82mRrl2jPUIK4Q6oKkZvKIi5UnO4Zfxa4p7OtteAMS9uxBfxiAe+IOM4q3pOy+tqDUZgUr4tmTPI3XMtT+fUJALMizrhtfzfvcx/gpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179795; c=relaxed/simple;
	bh=P+7yXIIhUOy+8tz2+1GN5lDVmuvRf94bbop276nc9fE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hc/MLrO+urivzHzHL5r1GSgK00BaHLLcJV7jJ42p8HhcGHoUFNmJ+sulLWBNEYSx++ZEG7fD+1tW37wXTKnOTKiwAqFlQnk57S/bOzJidC7XCOA6l5BvAlBJ9/2xCrqtn9y6b+Xlso4K4jhJkA97SKa53oatq80LYTsYnF5GXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I73glsRO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720179794; x=1751715794;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P+7yXIIhUOy+8tz2+1GN5lDVmuvRf94bbop276nc9fE=;
  b=I73glsRO+kHEOQK1IvmIZFw3YNE+xZPFvxtV4xg28B3ES5B/IjhIFQn2
   NDNYu0CQrodqP0+2lFpLdBGV2P19Ff4Q67HR58eF/KMpYrRfwte3bT4Te
   SfzI8NdlyA1BwWNLpTmSd35wHXFYLw/Ow64S+AFA4xwUJPzoWXpdeM+DS
   czrzymJzpWcfbKLSV++/EnEKYXydYwuNIHmrNJ5ZKDodl3K2kQp5yYM6X
   JqpvsTIzJbDQIMN4RfdEgTTU4ACDhi5nWvi1r1Oc51v3Ej7rN4+ANa2q+
   24RByIrnfW+lx11nvShYrEuhJZccPv4bqzHb1jkWlcmVtrZ9Vi67Wsqbj
   g==;
X-CSE-ConnectionGUID: yD2TE5VRTHeDkuY0lIuZdg==
X-CSE-MsgGUID: cKZH8EOITq+N6b4g8lWTcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28625259"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="28625259"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 04:43:14 -0700
X-CSE-ConnectionGUID: CjA6xvw3QMGN1rNTU3RJtg==
X-CSE-MsgGUID: ewpAom1STfakukYPC1eXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51804537"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 04:43:14 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: intel_auxdevice: add cs42l43 codec to wake_capable_list
Date: Fri,  5 Jul 2024 11:43:05 +0000
Message-Id: <20240705114305.160233-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cs42l43 has wake capability. Add it to the wake_capable_list.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 54cb455ed870..b109fa84d754 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -47,6 +47,7 @@ struct wake_capable_part {
 };
 
 static struct wake_capable_part wake_capable_list[] = {
+	{0x01fa, 0x4243},
 	{0x025d, 0x5682},
 	{0x025d, 0x700},
 	{0x025d, 0x711},
-- 
2.34.1


