Return-Path: <linux-kernel+bounces-378275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0750A9ACD78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB461F22579
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC131C9ED1;
	Wed, 23 Oct 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kONNABTK"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AA1C8306;
	Wed, 23 Oct 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694238; cv=none; b=AaKLZ+IDpix6ngI9/YqpqduETLcUVaFp0vVO6pprfTADxSh8Mk8tYSyfGLJhAIj2x4FGX7Y7nM4GY3ICe38ufJz3PlGUjpPMKdQ1g4IyhPEMd9nVbnlicD4MRkkA9ZbmRMohQ7QOZiNCeNWqXGORMpDOoUbVaNfN0pheriMfq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694238; c=relaxed/simple;
	bh=Xp74AfCJ9mcYmGZEx+1354soVXppvVymKqxr3OsJX8M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uNnG+5eyVMldaDI0MS/VcP/ahwylXNnbPEh+drhL3nUqvEF/as9raSEwXBV7GkURx8+xlddgvw8BjRPkb+4CcohL0y3EiKfFc9QYREgTuqv/qHYBptEEYXjv5Z/3IYrZ8ogIskMxIcah8u8Nj9h/Dc6Dg4lgy958V033B8xmqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kONNABTK; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N4ToPI026682;
	Wed, 23 Oct 2024 09:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=cPDa+ujxwy6nOSQy
	EihqjpjDHa0YdriBf9HgK3+XAgA=; b=kONNABTKRM7MiDCPkpheEMa66j8YfoxZ
	zZP6BoljtohLUc/FcVei8PQu/9r7uhjr5uSda7XWdkHe9N0kqwjEyXWSM1lZLLEI
	TCYIS3saKkctYL/qLbjB+i0JHCo+qwI3F66irmIUn5r6kgAiPLcUcd2kp+3BObYM
	yPGss+/rNfNG/WEEYwDMARkHjHxXpDqY5JCCVKBrsKLIwNOOLU/AVom0SOZJ6uux
	X4xQo3/tHFa9oRFt7qhDciW/dWNUWPi2NLc0pHmqyx0hgFtXjJL5X1z0ErBJKLQC
	kxjQmFpat7tIpJa4ykIz+mQxBLIXU3YblQLeNW5VpMaOD90ySFjNHg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 42ca5x56st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 09:37:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 15:37:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 23 Oct 2024 15:37:01 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BA284822562;
	Wed, 23 Oct 2024 14:37:01 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <sanyog.r.kale@intel.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] soundwire: Update the includes on the sdw.h header
Date: Wed, 23 Oct 2024 15:37:00 +0100
Message-ID: <20241023143701.3700714-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YA8MHKYNw0Gng7YatA5Np3oTQPovqy8Z
X-Proofpoint-ORIG-GUID: YA8MHKYNw0Gng7YatA5Np3oTQPovqy8Z
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
index 73f655334fe9..1fd4b126287f 100644
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


