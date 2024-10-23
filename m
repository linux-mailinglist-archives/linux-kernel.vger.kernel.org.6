Return-Path: <linux-kernel+bounces-378154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF439ACC23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDBC281860
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34251BC9EB;
	Wed, 23 Oct 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cooIOEA2"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958A1AA787
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693238; cv=none; b=gZyFKmig1UGfRHZ5dx5wyPPc3MGGKbtAiRyHcD4He2Z9js/DDWZ+/Suh3nSdoi1S07A/bMRD2RY2FdrgosoycnhhgQ/euu/CMzU9G635TZoUE5t0XFkjOFYq+RNo9S68zCg8V50cbtZxLX3rR5hAYfXd5RagBLbkOggfmqY9h80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693238; c=relaxed/simple;
	bh=Xp74AfCJ9mcYmGZEx+1354soVXppvVymKqxr3OsJX8M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RvaZwBPoBr+SKuGN/Eei9h8skJ/6/f3o9Fyi2V9FybCfRlhkNsGcx2aoGvQl6KIEQYzkal163BrPAa7fCawTAARgVTSvz3LbfnHsouJsXReZP5eDMDjbN+tfDnRJZ0xXevBYVTFxfYEf2Xz2TkiYl/mtSJ/lE5kgrekJECRTZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cooIOEA2; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N2bpSD023824;
	Wed, 23 Oct 2024 09:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=cPDa+ujxwy6nOSQy
	EihqjpjDHa0YdriBf9HgK3+XAgA=; b=cooIOEA2PwY1tcKO7kJw0R9UGmVQu7+n
	k4cswzlp8AD/QPzFjjn/SQ6RQ8cnyQ0pwn5d7nvveiqeM4ZHhZzNWTeMSPAFPyAR
	VKLqOlkiDMx4Rsg8/hFul1sUyYL/bl8MOHAEF9ycjLWrwi9yFviQMtvLayhYlCSz
	QR7/Gri9W6CVSoQ7MPNNoydLgwVUx+7N27kASlig6fJkm/FHKb48xQ2E0nw6HO6J
	hmqVdPHTfytyAlkIkUk4If+w/s1MwNv+K8AHLUEZf6pAJDSs5yqSycEcRoZSJW/2
	FSKIyiRBUATxcMf1RbLi8e2BcqCKQ3JhBeOR6aqxOkPwPnGpMVpQpQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42c96jcy2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 09:20:22 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 15:20:20 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 23 Oct 2024 15:20:20 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 66302822562;
	Wed, 23 Oct 2024 14:20:20 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <sanyog.r.kale@intel.com>, <linux-sound@vger.kernel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] soundwire: Update the includes on the sdw.h header
Date: Wed, 23 Oct 2024 15:20:19 +0100
Message-ID: <20241023142020.3612551-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2DvpRwy0cvx0RRCLT4QGZk9ZmXRu5vdm
X-Proofpoint-ORIG-GUID: 2DvpRwy0cvx0RRCLT4QGZk9ZmXRu5vdm
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


