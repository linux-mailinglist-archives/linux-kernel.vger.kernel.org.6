Return-Path: <linux-kernel+bounces-245272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349192B083
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD760282DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FEB13C819;
	Tue,  9 Jul 2024 06:48:11 +0000 (UTC)
Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96813213A;
	Tue,  9 Jul 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507690; cv=none; b=O7ZLy86QikSLjdU/ldkyoCkX0hP2X21ijg2BmO0518IurL3FP30attz/JHltfCRbW8J35XFIhAieIJnL26ys5/QI1En+rPxl7rJWXw0MfmurQkEgGbxz7aj67/PxwmvZbgEBYVXLYE2HLp8AsIsYRuzX+2FExCAv5xJ6Xd+ovHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507690; c=relaxed/simple;
	bh=OQvb9CZbdmX9E0d9iBJGKerkjF+Vly6dcszw03VebUo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQaKAuzbAeX0VMCOkeb0hXEM+yD+6sTpaGqWcov2Ed4qayNqkFlPEzVvYcRXfdT8Oh8Ep6lS5yHGZBlCvcgvU4NlEqV1DIROG6fv/JLvlX43hSBusKi6fuyu5Aa4Z1ps0NFuFBfhdUSfRRmiAzjrh3HleM6Va4ED651PtkEBDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4692tkD2022971;
	Tue, 9 Jul 2024 06:28:37 GMT
Received: from usgdcecpmsgae02.extemr.org ([144.191.128.198])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 408s364ewq-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 06:28:37 +0000 (GMT)
Received: from usgdcecpmsgap04.emrsn.org (10.16.75.145) by mail.emerson.com
 (10.16.11.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Jul
 2024 06:28:49 +0000
Received: from usgdcecpmsgap05.emrsn.org (10.16.75.137) by
 usgdcecpmsgap04.emrsn.org (10.16.75.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jul 2024 06:27:41 +0000
Received: from aug-swlinux1c.aug (10.19.249.15) by Inetmail.emrsn.net
 (10.16.75.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11 via Frontend
 Transport; Tue, 9 Jul 2024 06:27:41 +0000
Received: from Inetmail.emrsn.net (unknown [10.70.41.16])
	by aug-swlinux1c.aug (Postfix) with ESMTP id 426EDB0B0017;
	Tue,  9 Jul 2024 08:27:40 +0200 (CEST)
From: Philipp Hortmann <philipp.hortmann@emerson.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Philipp Hortmann <philipp.hortmann@emerson.com>
Subject: [PATCH] staging: rtl8723bs: Remove constant result function CheckNegative()
Date: Tue, 9 Jul 2024 08:26:34 +0200
Message-ID: <20240709062634.9454-1-philipp.hortmann@emerson.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cFmUnU8ehzE1BMmzNw-kVnDvI_HUDQao
X-Proofpoint-GUID: cFmUnU8ehzE1BMmzNw-kVnDvI_HUDQao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090041

Remove function CheckNegative() that returns always true to shorten code.

Signed-off-by: Philipp Hortmann <philipp.hortmann@emerson.com>
---
Tested with rtl8723bs in ODYS Trendbook Next 14
---
 .../staging/rtl8723bs/hal/HalHWImg8723B_BB.c    | 17 ++---------------
 .../staging/rtl8723bs/hal/HalHWImg8723B_MAC.c   | 12 +-----------
 .../staging/rtl8723bs/hal/HalHWImg8723B_RF.c    | 12 +-----------
 3 files changed, 4 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
index dd0f74b0cf0d..4da2487f6750 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
@@ -70,13 +70,6 @@ static bool CheckPositive(
 	return false;
 }
 
-static bool CheckNegative(
-	struct dm_odm_t *pDM_Odm, const u32  Condition1, const u32 Condition2
-)
-{
-	return true;
-}
-
 /******************************************************************************
 *                           AGC_TAB.TXT
 ******************************************************************************/
@@ -244,10 +237,7 @@ void ODM_ReadAndConfig_MP_8723B_AGC_TAB(struct dm_odm_t *pDM_Odm)
 				READ_NEXT_PAIR(v1, v2, i);
 			} else {
 				READ_NEXT_PAIR(v1, v2, i);
-				if (!CheckNegative(pDM_Odm, v1, v2))
-					bMatched = false;
-				else
-					bMatched = true;
+				bMatched = true;
 				READ_NEXT_PAIR(v1, v2, i);
 			}
 
@@ -506,10 +496,7 @@ void ODM_ReadAndConfig_MP_8723B_PHY_REG(struct dm_odm_t *pDM_Odm)
 				READ_NEXT_PAIR(v1, v2, i);
 			} else {
 				READ_NEXT_PAIR(v1, v2, i);
-				if (!CheckNegative(pDM_Odm, v1, v2))
-					bMatched = false;
-				else
-					bMatched = true;
+				bMatched = true;
 				READ_NEXT_PAIR(v1, v2, i);
 			}
 
diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c
index 47e66f4ad9d1..1f0cc8d58df3 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c
@@ -68,13 +68,6 @@ static bool CheckPositive(
 	return false;
 }
 
-static bool CheckNegative(
-	struct dm_odm_t *pDM_Odm, const u32 Condition1, const u32 Condition2
-)
-{
-	return true;
-}
-
 /******************************************************************************
 *                           MAC_REG.TXT
 ******************************************************************************/
@@ -214,10 +207,7 @@ void ODM_ReadAndConfig_MP_8723B_MAC_REG(struct dm_odm_t *pDM_Odm)
 				READ_NEXT_PAIR(v1, v2, i);
 			} else {
 				READ_NEXT_PAIR(v1, v2, i);
-				if (!CheckNegative(pDM_Odm, v1, v2))
-					bMatched = false;
-				else
-					bMatched = true;
+				bMatched = true;
 				READ_NEXT_PAIR(v1, v2, i);
 			}
 
diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
index efc68c17b126..155ec311a52e 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
@@ -78,13 +78,6 @@ static bool CheckPositive(
 	return false;
 }
 
-static bool CheckNegative(
-	struct dm_odm_t *pDM_Odm, const u32  Condition1, const u32 Condition2
-)
-{
-	return true;
-}
-
 /******************************************************************************
 *                           RadioA.TXT
 ******************************************************************************/
@@ -245,10 +238,7 @@ void ODM_ReadAndConfig_MP_8723B_RadioA(struct dm_odm_t *pDM_Odm)
 				READ_NEXT_PAIR(v1, v2, i);
 			} else {
 				READ_NEXT_PAIR(v1, v2, i);
-				if (!CheckNegative(pDM_Odm, v1, v2))
-					bMatched = false;
-				else
-					bMatched = true;
+				bMatched = true;
 				READ_NEXT_PAIR(v1, v2, i);
 			}
 
-- 
2.45.2


