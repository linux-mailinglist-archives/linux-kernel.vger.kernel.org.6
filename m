Return-Path: <linux-kernel+bounces-228502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C114F9160BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EE9284F27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57E149C5B;
	Tue, 25 Jun 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epieZs/U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723B1494D7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303117; cv=none; b=mRkWZNn0ZmBdWSf43AVbd99tQSlwerTMQ68NelJJ4m+IyPwGdUE1H5/IbbI/frEVvh2Vuy1YpAZuR0SMTHD5u4r0qthm6LPalc6QcnrcbdOWPTJjCxy7ItTGQgIAYMQf7HJh5oWu2LRI8hU7uN+fRno1n+k3WKPgxQuwriif2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303117; c=relaxed/simple;
	bh=X3L9S0Yszj7A4apws7xumH3DwOyFy+hhYSlKzXL6xOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZZbuCnZEAHI7i2eSnMpkARzp9kgHgBcWS4pXIbZLztAUta3IA92lkkbahjr2s5XRZIjzvYxHu8rQmNyiLDkavtCM1MAV/Ldw9KHDXQyA0A6nLf+CXJbfMhamYCeddZVbHbAPB6Ct8oC1pSUuWnAA2vtv480EH+76MRO8wb1Dhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epieZs/U; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719303115; x=1750839115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3L9S0Yszj7A4apws7xumH3DwOyFy+hhYSlKzXL6xOY=;
  b=epieZs/Udx9CU11xwgAKvb0BEDSVeKP7cGD7WcH2EDX84WOAIwt4juaD
   EnXy7voL+rDEHmqClOph77nNpSGbti0NWX2DEPH8WdX/mcEDNlHZpwMwA
   FVjHnOXNbOiMJWO/AZxJed4lwUBmSHv6MQuWSSd4ufWf3+5yTVsIMKI9n
   lE98xokBLaS1Urvpq11phU9vohH4oI4glQ7/z6qZ+Q2V2ffUkug0MX6nC
   gb7/1uL+JgPUXpcYLL25rAV7yRKDOF8g5oedRUN/SPRBqN2zDe00bRllk
   FN0333cuztlOu+LPH9ePfboQcdIq2hMnidlZ1Lgxxjr7yxlr4jT2PGTfS
   g==;
X-CSE-ConnectionGUID: tiB7NadsQdWFqEnucKX24Q==
X-CSE-MsgGUID: rli2tTveTa+/VnySMnHCpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12232509"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="12232509"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:11:55 -0700
X-CSE-ConnectionGUID: 1DKED9BmR+KR3yPn0Z7bjA==
X-CSE-MsgGUID: S0DTKqTNT9egis4O696iBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47944916"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2024 01:11:54 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v4 5/5] mei: vsc: Fix spelling error
Date: Tue, 25 Jun 2024 16:10:47 +0800
Message-Id: <20240625081047.4178494-6-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625081047.4178494-1-wentong.wu@intel.com>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a spelling error in a comment.

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


