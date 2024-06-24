Return-Path: <linux-kernel+bounces-227279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8E914EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61213B2033E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F841411D9;
	Mon, 24 Jun 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bqnin3LW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244421448E6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235798; cv=none; b=aPL4pU55YJWUbZw0L/drqe9Kdro2gXyeiM8hzqG3LMiNl4uW/D3/pK3Tk9XJOa9FxDrHaSwsc5m+qisjtPtwEQrwssOECJuA098XVP63he7+bVuBp/JWPeL5cDGZNe5k1QYUxhWI049AlQ+ohffbzjMG0WCIwhjJ0HHTj7Sx3+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235798; c=relaxed/simple;
	bh=3PGXukhXUhbCCLDkatC+1Lrz46ffQiiXYfae+u3zvRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZY1AyHY0L/B5gtcKxV+2zsuW9DGWL+t+144Zgti8kLoLAoT2gFu72GrTpDueoB7EcUr1HvMEemjb+wdPsn9+ETJZuqOmdpBRLQTnP8K20PbdWociMBy7QQWmQEJv+Yg7miQLyCztHXlelscpb/9KBt+mSZvUnq4oY7CJGg1kEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bqnin3LW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719235797; x=1750771797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3PGXukhXUhbCCLDkatC+1Lrz46ffQiiXYfae+u3zvRI=;
  b=Bqnin3LWWqpcCuTEPnuBroiOg/QSTpc8MFbfpQMWjuiR3pd/l8WNWDD6
   lPEKt1X6jOuEqVmCdLK0HziJzT0dyKn+1QCxdoD+upPbQACLrsxTNcGaY
   WduIvC5GtRka2D25QWDkGYOBf0dKan475kVrliVcZDS4dnUUUKTXmul+P
   +kf3FCHvZWfzBIHPLBuR3VA8Ftzt6SqKauxwAhnEOHfTcpj4VLzCTi2sw
   wTPd3AwCiA1DL3AO4Abr/6TqUTQvmotuEu9PxQuDXG4Ya0azJnCfZ2ggY
   Jul4iUvD0noGPxyZyGptSIUVD1Axtu1Vhm/H6HMtWIfLGqp0Fby6GqaAY
   A==;
X-CSE-ConnectionGUID: waJx9Gf3S+CU2rkNQkzZGQ==
X-CSE-MsgGUID: vqrLLYoSSceALRIVVtWsHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="26830765"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="26830765"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 06:29:57 -0700
X-CSE-ConnectionGUID: oKe1HYZvT+S8MwYyY4xhEw==
X-CSE-MsgGUID: MIiWP/QmQAavtxj3/rYqUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47746775"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2024 06:29:55 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v3 5/5] mei: vsc: Fix spelling error
Date: Mon, 24 Jun 2024 21:28:49 +0800
Message-Id: <20240624132849.4174494-6-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624132849.4174494-1-wentong.wu@intel.com>
References: <20240624132849.4174494-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a spelling error in a comment.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-fw-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
index 596a9d695dfc..084d0205f97d 100644
--- a/drivers/misc/mei/vsc-fw-loader.c
+++ b/drivers/misc/mei/vsc-fw-loader.c
@@ -204,7 +204,7 @@ struct vsc_img_frag {
 
 /**
  * struct vsc_fw_loader - represent vsc firmware loader
- * @dev: device used to request fimware
+ * @dev: device used to request firmware
  * @tp: transport layer used with the firmware loader
  * @csi: CSI image
  * @ace: ACE image
-- 
2.34.1


