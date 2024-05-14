Return-Path: <linux-kernel+bounces-178508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B78C4ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAF21C2123F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CD41272D5;
	Tue, 14 May 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lteb3vDU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E548594C;
	Tue, 14 May 2024 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678831; cv=none; b=RiczRvfUPZlW9p4khkEwgb62jhi7VTSzRvYaT3GI8JjRqF26rW1rSLZKfORUmg0I9zJGLmeOaTKf/EcrAFJ47O/zuPfwWSg60PT4sqnSSC3lLCzLVv9vGKIcCByB9ygr799hPcG6xfabnnO4pUit2Ch9EtPxJfQ3tqrzDOwV7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678831; c=relaxed/simple;
	bh=f0vhqTJlo3GrNwq7oMCL69kDglVDcDSeIiyOh+f1hAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrptMCEl0aWI2P9+9HSH2TyV2z648vECpME5doJMIEbOGJ8yGSIUn5TcCKrI6VWxOULfalYk5lt5aeUXMJBH4aetqERL+zOSjIfMZ6NwS0FN6/X/V/fIlevpNebvrlL2bHxpPM33om5nSttPCz52pmT7I6yYtyyF/Q8NWNBfvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lteb3vDU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DNhrf3009080;
	Tue, 14 May 2024 09:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=EOnvSakafw7ICIBOPK7or2yl1cJGUDOAxJowGa/hfiQ=;
 b=lteb3vDUxsowy0i/tsak+CV8DzhTWvaAoyEP2EnyntQM+LkrGd9yaqWQA08W69ys6CyL
 Vhfn9ggn1nns3cmGt6v7ukwAr1r9xPMz+B0Mt19Bb5ccHJpncVZwgcs4Nge1GbECIFWF
 wDKYLLC5JOllc3GywxBngxNj77uHmkRgufc8n2N4g01/HmX+0MDOPhq9xdnaA8vEwrp1
 X88pcUazdWd6Fl9sdrFwYTTTn654ZyGRaSMoyc5F44BiRC9ZFQzcc9b4tdTw2Jb6w6W3
 KL4q9WHknRp1yl9iNM4UpPYK0oXODymTvtvxyMHA5Kan23u03tIkiyF/g2UOaTGiwsOD 6A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh798wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 09:27:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44E9PtJB019149;
	Tue, 14 May 2024 09:27:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r84h92w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 09:26:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44E9QxLt019297;
	Tue, 14 May 2024 09:26:59 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y3r84h928-1;
	Tue, 14 May 2024 09:26:59 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] platform/x86: ISST: fix use-after-free in tpmi_sst_dev_remove()
Date: Tue, 14 May 2024 02:26:55 -0700
Message-ID: <20240514092656.3462832-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_03,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140065
X-Proofpoint-ORIG-GUID: JZmlLvsklTuzA2lkYH56v9AXtcTyUbu9
X-Proofpoint-GUID: JZmlLvsklTuzA2lkYH56v9AXtcTyUbu9

In tpmi_sst_dev_remove(), tpmi_sst is dereferenced after being freed. Fix this by reordering the kfree() post the dereference.

Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned systems")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is found by smatch and only compile tested.
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 7bac7841ff0a..7fa360073f6e 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1610,8 +1610,8 @@ void tpmi_sst_dev_remove(struct auxiliary_device *auxdev)
 	tpmi_sst->partition_mask_current &= ~BIT(plat_info->partition);
 	/* Free the package instance when the all partitions are removed */
 	if (!tpmi_sst->partition_mask_current) {
-		kfree(tpmi_sst);
 		isst_common.sst_inst[tpmi_sst->package_id] = NULL;
+		kfree(tpmi_sst);
 	}
 	mutex_unlock(&isst_tpmi_dev_lock);
 }
-- 
2.39.3


