Return-Path: <linux-kernel+bounces-237974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A6924173
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9681C2407E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04BB15B547;
	Tue,  2 Jul 2024 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CNoV1nIX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF11BB6BA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932018; cv=none; b=kJTsADBBDGg/xiJNa37Zlpe90SjJ71sUN2MYWjnlBbqjlQ8cLkpleQXQgSR5Et6KBqtSPjERG00L7irNo5vvKyZpytdbBeI2MkhLOn8fYlrRWhUPqxZP6v/ZcTf4+KDd9ISO3xf0hqYEIiRUHRyh/PiwG9jKL7S6ywu8323sNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932018; c=relaxed/simple;
	bh=VhEiRl4fKMKCqBZE6aT51QUjJ2GiFpe1+YbrH7G0LCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlEYT8Mc3/7kJwvo18KZHoDhaGCeFPQJwPey8GFGak4q4mL/cwNLqXgth80ImerXFwUyZ1GB4DZMphevI4l5w6Pz68Iwxbhay/Wn9wf/ROKs7h6GwBEb2GOhEpvWFF7CLes3+ndg2YZ7BgZq/8PdqORFhwBEQYRlTlZ3h+C4LMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CNoV1nIX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462BJtKS007913;
	Tue, 2 Jul 2024 14:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3TAnMpQEW3ealwIXvjyJriqo
	+ARF2Q/tb7yNcaLVCio=; b=CNoV1nIXW5WqZ/1/PP0rboDCAV67ZMt82Bre4nCe
	JFyZP+3iLgR8A/m3+rPVGM3gdHtLkV+TwSVjXikZCrZMKiPx6h6E20Fh4rVcb8+X
	nkHY7Wd7hS8fbODe0eINpgALwMi9FOs79u174IliPaBnsJV4muVkTzE6+kO1UAVN
	ZQNstjv/93j5E9yRO3ud+yEuDNN3RDXUtf1/lCFK7osZTPXfppvuOZQKewy66kxW
	Dcq25ZSLE/BUOLkQAQkoJfyTSNnHV1tSkr/uBPcuRlqXupoKv+4+9OITeB6MfTcc
	KXHTgD/VMbF1Rqu/WjRBJtKmLkIgQv84Qp5yePYxxLR3QA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402bj88de8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 14:53:29 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462ErSnS007113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 14:53:28 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 07:53:26 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <brgl@bgdev.pl>,
        <madalin.bucur@nxp.com>, <davem@davemloft.net>,
        <andriy.shevchenko@linux.intel.com>,
        Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 5/5] devres: Correct code style for functions that return a pointer type
Date: Tue, 2 Jul 2024 22:51:54 +0800
Message-ID: <1719931914-19035-6-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -nTW5lZfpQm6s81Qt7UMr9PRuCFwuSp8
X-Proofpoint-GUID: -nTW5lZfpQm6s81Qt7UMr9PRuCFwuSp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_10,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 mlxlogscore=865 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407020110

Correct code style for several functions that return a pointer type.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/devres.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 2ad6dacb3472..be82d2d71544 100644
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
@@ -577,7 +577,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 EXPORT_SYMBOL_GPL(devres_open_group);
 
 /* Find devres group with ID @id.  If @id is NULL, look for the latest. */
-static struct devres_group * find_group(struct device *dev, void *id)
+static struct devres_group *find_group(struct device *dev, void *id)
 {
 	struct devres_node *node;
 
-- 
2.34.1


