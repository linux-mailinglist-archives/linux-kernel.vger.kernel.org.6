Return-Path: <linux-kernel+bounces-405874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B919C591D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C2BB32C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252581ADA;
	Tue, 12 Nov 2024 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oaaHNvcj"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDF70817;
	Tue, 12 Nov 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416227; cv=none; b=HisYwpx2+RzT257dRPLk13XmsrkF2zvtiRsVJGD1fjVb4JQ9MQxYb5jzaPmNwHgCcM+zYR19xCw6KP2Pdt15SejCy/F3mKVnwA89UvoQddxv2baSInEfAq8oyXSZpwm39iO1yImTZ9fH5Vy/Ut/4FrqQereSaExHGGMdzpqO0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416227; c=relaxed/simple;
	bh=Jmqk02nyjaltgiC9zC29E10A1M1BvP5B4YA43Rd/OIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hq7//CPv/84p27/QzGpeQ2Ur0RZOXrz+2A46xQEIn+OLKFv4jsnzqCNyEyE4eYarNRBU9yUJeWN0mPOPUuNE00dTgG2s515P4w/ju8kFEBNkg7BePMITUpEfFERpxbXFG39WsB7RrpRLtD0CVfn/8CEtkc4DeoKo63iePDUxjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=oaaHNvcj; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC5j6NE023683;
	Tue, 12 Nov 2024 06:56:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=NAFpzXZ94pscwZW0
	OECzSGbrmKMCzgnrnp9XZPYldM8=; b=oaaHNvcjT4x8TG1Q71wYokf2hx80Z9pI
	ommM2+Cf5Pf8TsWirqir20P8iLKTiTujD6iuIcjSEt6kmDvUq02OVAXKgtv2QVCB
	XAEHjtGhmDKupChcUOSi0pugLLEiwAUdKUsqCkRF6bdaEjiTxi+iTP7PHa4NQT2l
	Kyw497eVnoK3BkY3FxxrMLp1yF/KwdkndtXJZDoajymt/2mVHLg3RLcl02IfALGs
	XLvHDfSAneJxWSnW07fwqcVD3Rnl8d6UwoD0TjY93PA/eO5Bh+U1/+w6hQso4hZ5
	AAFjUApkN1cuU4RUdgW6VG2HS3+j/pRaMxdfKX66jXuj1cXTd7MKTQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42t51p35at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 06:56:48 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 12:56:47 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 12 Nov 2024 12:56:47 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E30E0820257;
	Tue, 12 Nov 2024 12:56:46 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <sanyog.r.kale@intel.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH RESEND 1/2] soundwire: Update the includes on the sdw.h header
Date: Tue, 12 Nov 2024 12:56:45 +0000
Message-ID: <20241112125646.590240-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j9iMwuPkK4Dts9VogHfzN-1JJn2ApNif
X-Proofpoint-ORIG-GUID: j9iMwuPkK4Dts9VogHfzN-1JJn2ApNif
X-Proofpoint-Spam-Reason: safe

There are quite a few things used in the sdw.h header that it relies on
the consumer to include. If something is used directly in the header it
should be included by the header. Update the includes to cover the
missing items, or add forward declarations for things that are only used
as pointers. Whilst making the change also alphabetise the list of
includes.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/linux/soundwire/sdw.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 73f655334fe9c..1fd4b126287f2 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -4,12 +4,19 @@
 #ifndef __SOUNDWIRE_H
 #define __SOUNDWIRE_H
 
+#include <linux/bitfield.h>
 #include <linux/bug.h>
-#include <linux/lockdep_types.h>
+#include <linux/completion.h>
+#include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/lockdep_types.h>
 #include <linux/mod_devicetable.h>
-#include <linux/bitfield.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct dentry;
+struct fwnode_handle;
 
 struct sdw_bus;
 struct sdw_slave;
-- 
2.39.5


