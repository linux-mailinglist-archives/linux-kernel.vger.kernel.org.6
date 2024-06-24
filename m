Return-Path: <linux-kernel+bounces-226545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7791402D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938341C21FED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 01:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D33DDC1;
	Mon, 24 Jun 2024 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdU+6lT+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA04C8D1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719193430; cv=none; b=utypvDvpS+X6Lbide2jhDo63TkNbS7U9Md/I76/bAYHf0oBH88mlZjEa2ydnr52lj09G/VM1fcJkmiYOSbOg7PvISgPtNWn/tan7lxE95EJi6HniMspz2WgtEB8RUSBK20yxJdr0G4tZTPLs2cmdrMsahSBt5yFkKiK3qifG3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719193430; c=relaxed/simple;
	bh=3PGXukhXUhbCCLDkatC+1Lrz46ffQiiXYfae+u3zvRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FxSITIuZiELoHEFef8AmmwuVWX11V0+CkWdEva2jTocZzCNqrMtF8C8+JDu722njNKJO8Oo+xRBTM0zCwZ87KT4jKJhsuW45Rj7i+Td0n1x6FXoyYnGNEk4bsgegp2tlkNgPPxfBKIywwHLSogTiUXHI/ggvVW7cnlsmbZH2rx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdU+6lT+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719193429; x=1750729429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3PGXukhXUhbCCLDkatC+1Lrz46ffQiiXYfae+u3zvRI=;
  b=TdU+6lT+dudMX/iLJe6y4nR3pW+q9Eq0VSR4TCIwTKHqB5gAWSOMqYC1
   P6K588rpX/X6aw/XeKiyCI2gOhZnwYQ/fgd2qGZMeSDt1pqZz5pOBjdBC
   mlVME6k3H8dpqPfNWyDPCR3aa3cdEmuAVb3D9emsTz3clQ71fesTQhmN9
   qb2c1zNAqT0qrlpfj9kOzIrfEvBG8DADUPtaHEi+wZ0cjq6lVJO7w2p6l
   INDHDz0cg+8B8kwNXEaQDuW1iK2YbAy5+yp1JhWrO3TSxBmjm4QtHVWaS
   szZVAW1CwM+TfEPVc9lDZdUsxTEaueozy0oKPdinLGYdp5+nvQDyulDZv
   Q==;
X-CSE-ConnectionGUID: +Vum4D0nSP6UCILSFcbvWA==
X-CSE-MsgGUID: YcCVKpjJR8GGInqno2bMlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="12202794"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="12202794"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 18:43:49 -0700
X-CSE-ConnectionGUID: hUcK0I8mRYmcF5kD+s68TA==
X-CSE-MsgGUID: 1jIlMDLTRM2355BMVgTyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43821442"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2024 18:43:48 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v2 5/5] mei: vsc: Fix spelling error
Date: Mon, 24 Jun 2024 09:42:23 +0800
Message-Id: <20240624014223.4171341-6-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624014223.4171341-1-wentong.wu@intel.com>
References: <20240624014223.4171341-1-wentong.wu@intel.com>
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


