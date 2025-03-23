Return-Path: <linux-kernel+bounces-572848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05155A6CF57
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D1C16ECE0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAB7DF60;
	Sun, 23 Mar 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aWL/Mcsn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7555CB8;
	Sun, 23 Mar 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742734166; cv=none; b=LAs7hxobPv+t091CJwyjP0DUC9M1BhLSAMJ7nz7CDXdIZ+TuimvJzUp2yvdfZZcB3U1RtVgiev7LSx2YfU/Z+M6RvPmbsjVilc379DS5fS6hYxcIyTuVWVznVU1w1g1NrWSdXZbGs/cBv097gVpctFivV6Sgfjz6O6o8C/Dk8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742734166; c=relaxed/simple;
	bh=2QFijmRecsDr/RNljq0t529cnNwNrJ3nfMyjHsviz8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaJVmInPw6Ev2dd8s0s9i5Qi+dWsVovI+UX21ftdaDWSXY49BHu7+m7ZRIunqoNjm61mzyRQqflvYCAB55a+aITV0a/VzFdGfbHlz6fBokzUYDWN6OVI+zBytz/EIx5CHFciQ4x5HVKOcWOM+hmOyuH10RczuIsVihusexuctBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aWL/Mcsn; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N6wa7x025718;
	Sun, 23 Mar 2025 12:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=y1p8efBTlVkGZuPqovRJRIEED8k9c
	61FVODzJx6N494=; b=aWL/McsnxrCM9uobUxcWd1nwQJUWHW9CSwuMnZnjj0X3d
	7JOMuVzDQTzRBPvSIMSvQPN+ly0NNddmuCtqN13fePOO+2Awk+hD42cEDfS6/O+E
	ISyYgtjL5jzq3ERb6V4aj24yX+IagtugI7VSRodQXY6403kfh5R6kKPtCH/gdFXs
	pEItFa4MPgqkS+btX6n88PSXCyt0d2i7o4ycTcb2o20cP+FnZZIk5fjwqigHtV0o
	nYfQQ9QVfNdv8JTxRiVWNOudgyXT//EXgJzD0sWxiIDB2xCWV/nIr1JU2nLoAjOS
	uld6c9CPpasWb7AP5yLWIg60cYP00qmhYXUMW5+tA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn7dj3rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Mar 2025 12:49:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52NCU31q029893;
	Sun, 23 Mar 2025 12:49:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjbx89d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Mar 2025 12:49:10 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52NCnAqp026147;
	Sun, 23 Mar 2025 12:49:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45jjbx89cu-1;
	Sun, 23 Mar 2025 12:49:10 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Matthew Brost <matthew.brost@intel.com>,
        intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] drm/xe/svm: fix dereferencing error pointer in drm_gpusvm_range_alloc()
Date: Sun, 23 Mar 2025 05:49:06 -0700
Message-ID: <20250323124907.3946370-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503230093
X-Proofpoint-GUID: cvCcg96ARbVDUoAZZm1Bw8SDjUXEjOoc
X-Proofpoint-ORIG-GUID: cvCcg96ARbVDUoAZZm1Bw8SDjUXEjOoc

xe_svm_range_alloc() returns ERR_PTR(-ENOMEM) on failure and there is a
dereference of "range" after that:

	-->     range->gpusvm = gpusvm;

In xe_svm_range_alloc(), when memory allocation fails return NULL
instead to handle this situation.

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/adaef4dd-5866-48ca-bc22-4a1ddef20381@stanley.mountain/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis and only compile tested.
---
 drivers/gpu/drm/xe/xe_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 52e04e7e343f..a79df8cf1f36 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -80,7 +80,7 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
 
 	range = kzalloc(sizeof(*range), GFP_KERNEL);
 	if (!range)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	INIT_LIST_HEAD(&range->garbage_collector_link);
 	xe_vm_get(gpusvm_to_vm(gpusvm));
-- 
2.39.3


