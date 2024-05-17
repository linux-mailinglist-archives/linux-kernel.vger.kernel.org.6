Return-Path: <linux-kernel+bounces-182234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9518C886E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBCC2860F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D2E64CE1;
	Fri, 17 May 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TSyIPQqa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793368F5D;
	Fri, 17 May 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957398; cv=none; b=hPQ19XybFRr8tDPI28iyjLIkVndB9snRnM4OoGGR4Q59AvR1+sCPVNTfpw7mHT0VFnD7fIMrDsz72nonyTm2q6OSHAdSupULxqmqCDOBJH6RE2ZR8nLohPLJrqPU0ji//XzLavNu2+HVobAar57/xH2uezTYQTZ3YM8xnkje2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957398; c=relaxed/simple;
	bh=uEP6bXRLC9q12FEscst8/uN+p2kIkISUr6VerTGNwpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGxz/e6FKAuDonv0jZS8t42eBBnPwf2lqWvaH9csYCPq8oegyzpfIE54ky9VRLvwo8dVJOdGQ4rizZ6OmFvkwHhwVZ0iNrSMk70SJZXzoPnjlYMFoJbHKi3dLcALYUpkChjELiOq27LF6gPByk/dM0DrF2kL7dtnuriMiti8fzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TSyIPQqa; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44HEIEvm017164;
	Fri, 17 May 2024 14:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=7qz+qAuahyAyYpbecn6fNefqgMPIWZYlNiXJm0v6E2k=;
 b=TSyIPQqar7lMPL8t8y7pL2ELNXy59EXnAsCvrSkZNIosxpyGEf5or24JN25TTUtdlM8b
 C6AxP2iSUtHstYzM+N/eemQTWCWaqmp1YT3wlElQQ+qhQ5MiBcL4JcpCXmpa1N65+bKQ
 /7bJ92io4+/3KtX///xB5oNgCRSqVMgQ+tErBmMo5PdWA+pxDxNRhXZ7oqVuMn7cAZvo
 XYOUXDTSxTg+O/u6ycUGwX6ss/f7ljQtOgt7EDKzQfu4sp5xZK6ruWgg66vAgNmb5x0S
 JnusmGldUG6E7VOzh2uqtPV50Gi2+FGaz9sLwx++cI5QvkptbNzacQ8oW9eJOzgEAoVZ 4g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx39snx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 14:49:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44HEdYAE038282;
	Fri, 17 May 2024 14:49:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24q1emg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 14:49:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HEnnRQ001723;
	Fri, 17 May 2024 14:49:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y24q1emfh-1;
	Fri, 17 May 2024 14:49:49 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH v2] platform/x86: ISST: fix use-after-free in tpmi_sst_dev_remove()
Date: Fri, 17 May 2024 07:49:46 -0700
Message-ID: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-05-17_06,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405170117
X-Proofpoint-GUID: yZy3wlnQfHYtgSl2ettVygdbmE3T5hw8
X-Proofpoint-ORIG-GUID: yZy3wlnQfHYtgSl2ettVygdbmE3T5hw8

In tpmi_sst_dev_remove(), tpmi_sst is dereferenced after being freed.
Fix this by reordering the kfree() post the dereference.

Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned systems")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v1->v2: Add R.B from Hans and fix commit message wrapping to 75 chars.
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


