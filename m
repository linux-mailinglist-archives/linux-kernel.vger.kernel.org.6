Return-Path: <linux-kernel+bounces-199213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885A38D83ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428B828B947
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81612D767;
	Mon,  3 Jun 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdtNR57P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CD12D750
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421381; cv=none; b=e+QfmUiKNsmxK8WywISGp1FkyfZ87iZ+CBZXDEztJE6OBXwtRtKq4MnhG8gog6DrfNq+LUuv/u+HE4PlJjgVUUccMNkrPihQ6QwYUeQ5IEqbuoPkP92Gz48ZG6w6+ck8VsUsEPVdvjWC1z2gYIZf341UuAb3NN/ejo9wVjr593c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421381; c=relaxed/simple;
	bh=uFRzflwr709sZknexkSG/BMqBZ1G81X1nY1ybM2bzCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzGl5akbyRoc352fFLNChTV5QHIYUcCeM6Zhc2tnQWWxZItXfJ5JfQLtdiBxAqnv4WumqzhsRlNWHGT72edT+bYrgNdz4Szr52ttEwoeqIZVHg5GNGnqrz83imjOiErm+iDmejzlg4UmKXj8fdprri3YInUJOrMB2pxcXTnV9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdtNR57P; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717421380; x=1748957380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uFRzflwr709sZknexkSG/BMqBZ1G81X1nY1ybM2bzCI=;
  b=GdtNR57PQX4j1Rebhq2GLiUDFZE4FsHUKp90lMnyUN9Nd4qiTsFJs4cS
   MBCHLmLpVO7UbwFTWnT+eSjR8vSccEO2F34OYOPhUGuzZTpugHdlfgHQN
   joOOFE5+FCkaTwR5MNI0DCflGzQ/s47DfWe+P70/YB9naAnYaibmBXMu9
   3ZdgqTLSBSTOEBA1O+fJestso7H2dKQfz0vEDoCCuZ8DWKGxZjH9OIUD+
   lFzFCgqQ+DM9NmkqkL5TN7gx/61oBNFH4PyhhYYBlqTFCiXM4w2bCWwpd
   rMcqxAgKGNJ71pqvNNLadLlqhh8ahC+iLjjlesZettuEpFArq7U/ngw3+
   Q==;
X-CSE-ConnectionGUID: dJ1yShUlQNSmTWszeUbyAg==
X-CSE-MsgGUID: ncg1HwTDTU6PB1lp+ydIJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17738497"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="17738497"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 06:29:40 -0700
X-CSE-ConnectionGUID: ib7RqXtrS4GPljRjRjHOGQ==
X-CSE-MsgGUID: TNqq2zNMShGPIh9+lpxnhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="41298215"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 06:29:37 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: me: release irq in mei_me_pci_resume error path
Date: Mon,  3 Jun 2024 16:29:28 +0300
Message-ID: <20240603132928.977787-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mei_me_pci_resume doesn't release irq on the error path,
in case mei_start() fails.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pci-me.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 7f59dd38c32f52dccf632fb4..6589635f8ba32b35fd28876d 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -385,8 +385,10 @@ static int mei_me_pci_resume(struct device *device)
 	}
 
 	err = mei_restart(dev);
-	if (err)
+	if (err) {
+		free_irq(pdev->irq, dev);
 		return err;
+	}
 
 	/* Start timer if stopped in suspend */
 	schedule_delayed_work(&dev->timer_work, HZ);
-- 
2.45.0


