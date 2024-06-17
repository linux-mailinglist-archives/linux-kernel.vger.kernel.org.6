Return-Path: <linux-kernel+bounces-217591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19CA90B1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120331C22DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E761AC25D;
	Mon, 17 Jun 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FWxiEHO3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192F1AC247
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631704; cv=none; b=XJcDYNo02P/Ep3d7pSr7PagpZRotkxoX9BDlSHnzbQCtvIVSWh4cA5J2OTNIIdRsfg0fk0TZKYBzx4Dg6nmIgZXM2MLYHZEq0ftsCqqafb002bmxnsaQLEsG3Savfv5jOKeYVAZnm3u+O4pafnw/mFXkRxT9+DkrTfoZtHJ5M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631704; c=relaxed/simple;
	bh=m3M5WHjlP+HN1VMQC3VBTAlmTLeffcj6WZ3BmqinNnc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDSUEl8dNzb7qusgyhyAesCStx64ENHZ5NXHuRL5GSJvEw+7Ur7G6YtVyaw0xeLfxKQQ+u3jHJZwTXWu8tzrGWBMU/+U2FIIW7011mIdblLl2V9hiscIkjNI5B8RRdjeQUMpprHiZhfwhVHkkY3nUH6RvOvEk/Pn3BaHPvIC5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FWxiEHO3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAhwSI000466;
	Mon, 17 Jun 2024 13:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=PnMnhUv17hGThiVtLIi1GmYfdDXVZD6mEkENnjqDw08=; b=FW
	xiEHO3xXlpK88ax0PNelo8twt1KFU5dSdxGShbCnknjuJb2wMf1ny2ZwOx9nBI14
	dbwIBfZgPbak7IuQNn8pkpvlgMNm98hWqhNZbjRSvEz4A1dGBecjaBg0ptQjJuLt
	dZXmnnsrg/O+voU3yEDbf3TeFxA5dpTJE1WOlICQacwkAJPZnt5XJizbbO3OekYq
	nHqJDRf55+R47e5PM/L6GGABlCildHuZXKintdnEm1PYT+bBoERQ3WdTBkw9vKbC
	RnkmvA640mvD4XcmzZM+EaScIdcyHbffBWHTxVwh6TTajnhQleANzj2AJF6UB9xs
	dpmF71Zh76gKCkZtKlaA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys29gutsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:41:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HDfYaq029848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:41:34 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Jun 2024 06:41:33 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] devres: Correct code style for functions that return a pointer type
Date: Mon, 17 Jun 2024 21:41:29 +0800
Message-ID: <1718631689-11929-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SAf1SyhLZHZiRP5YaF5sUNTH8yFhaBpA
X-Proofpoint-ORIG-GUID: SAf1SyhLZHZiRP5YaF5sUNTH8yFhaBpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=891
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170104

Correct code style for several functions that return a pointer type.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/devres.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 3df0025d12aa..564c114079b5 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -85,7 +85,7 @@ static void group_close_release(struct device *dev, void *res)
 	/* noop */
 }
 
-static struct devres_group * node_to_group(struct devres_node *node)
+static struct devres_group *node_to_group(struct devres_node *node)
 {
 	if (node->release == &group_open_release)
 		return container_of(node, struct devres_group, node[0]);
@@ -107,8 +107,8 @@ static bool check_dr_size(size_t size, size_t *tot_size)
 	return true;
 }
 
-static __always_inline struct devres * alloc_dr(dr_release_t release,
-						size_t size, gfp_t gfp, int nid)
+static __always_inline struct devres *alloc_dr(dr_release_t release,
+					       size_t size, gfp_t gfp, int nid)
 {
 	size_t tot_size;
 	struct devres *dr;
@@ -283,8 +283,8 @@ static struct devres *find_dr(struct device *dev, dr_release_t release,
  * RETURNS:
  * Pointer to found devres, NULL if not found.
  */
-void * devres_find(struct device *dev, dr_release_t release,
-		   dr_match_t match, void *match_data)
+void *devres_find(struct device *dev, dr_release_t release,
+		  dr_match_t match, void *match_data)
 {
 	struct devres *dr;
 	unsigned long flags;
@@ -313,8 +313,8 @@ EXPORT_SYMBOL_GPL(devres_find);
  * RETURNS:
  * Pointer to found or added devres.
  */
-void * devres_get(struct device *dev, void *new_res,
-		  dr_match_t match, void *match_data)
+void *devres_get(struct device *dev, void *new_res,
+		 dr_match_t match, void *match_data)
 {
 	struct devres *new_dr = container_of(new_res, struct devres, data);
 	struct devres *dr;
@@ -349,8 +349,8 @@ EXPORT_SYMBOL_GPL(devres_get);
  * RETURNS:
  * Pointer to removed devres on success, NULL if not found.
  */
-void * devres_remove(struct device *dev, dr_release_t release,
-		     dr_match_t match, void *match_data)
+void *devres_remove(struct device *dev, dr_release_t release,
+		    dr_match_t match, void *match_data)
 {
 	struct devres *dr;
 	unsigned long flags;
@@ -549,7 +549,7 @@ int devres_release_all(struct device *dev)
  * RETURNS:
  * ID of the new group, NULL on failure.
  */
-void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
+void *devres_open_group(struct device *dev, void *id, gfp_t gfp)
 {
 	struct devres_group *grp;
 	unsigned long flags;
@@ -576,7 +576,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 EXPORT_SYMBOL_GPL(devres_open_group);
 
 /* Find devres group with ID @id.  If @id is NULL, look for the latest. */
-static struct devres_group * find_group(struct device *dev, void *id)
+static struct devres_group *find_group(struct device *dev, void *id)
 {
 	struct devres_node *node;
 
-- 
2.7.4


