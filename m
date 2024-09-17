Return-Path: <linux-kernel+bounces-331958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E297B371
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6DD1C23D62
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8351891C6;
	Tue, 17 Sep 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kkVbzZ4H"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706417C990
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593423; cv=none; b=CXywNwrcfAg+eE+uM3YjqvUlRetD8xCTQdwbe7n8cQAflBAWXdKF35ugWD2/HwKNBwLKdGZfIbD4WN9I3tc5x9mRAwlb2nDtYu+t6oS/1IXs+xTZSYEyicMQ50QKYDKsAhnkyCC/tZeM+UjCRF80/TYeXSSxWeHhCsKDm2o1ww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593423; c=relaxed/simple;
	bh=1FBUfSTRFuIYcIz20ZV+CA40A8SSn7fVyJHHIUcqmN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwPCmJkqZysWrA495zy4AHEztjd2vERabT1ROaUHpacaZqOzydMBYlx5MsA3rX2uprJbIyVwVeHUnlXF2dVh8LOUh3vPpFK/uB9e4enZ/99eOec68wzVGKee2UtDV8RU4m/ffAlFN05s2X+ZLeumn6zdjPunE1j3R2nheTwvHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kkVbzZ4H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H8i76L007562;
	Tue, 17 Sep 2024 17:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=lT2Rd3p9atLYr
	Vb3Pbl+bWcgfVo3Dh6J68otSjumcF4=; b=kkVbzZ4HN/xfLiTU6GJtyodwxFMac
	cbtN5tNYrddF8HfQLacfDWLt2bJ/dY1Nh7tNErzWkkSPD5o26VrRrPAJgvXxzfw9
	6P00FGLGoFwbgejE9eBTOktnNK5HXEagkauTsy9+CnyJrHaYx9I/lEmAmcGBHpKz
	czTsajWcM9qa2s3krTEHqkc2yiKKg1XysVVSd/x9RNJdVEDUcG+ax6fljz9hCTLs
	fXDjzmyf+dp74hp1gLoXMuk2zeZh/G0f2thkoFu42qVYTvJkLTRUJev3Wy08BV9C
	E5C4AjUpZgrF2ph2CGSlEQM/VcmvauFfyZ0WtORpEJXKOM6zHvxRs6oHA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdhjrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HF9XOE001918;
	Tue, 17 Sep 2024 17:16:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nmtupq78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGoqf52756764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3B8C5805D;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E39E58061;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 13/15] fsi: occ: Find next available child rather than node name match
Date: Tue, 17 Sep 2024 12:16:45 -0500
Message-ID: <20240917171647.1403910-14-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917171647.1403910-1-eajames@linux.ibm.com>
References: <20240917171647.1403910-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CfJoqX0oFJjTMocOaOjFpp9pcJgDuwK2
X-Proofpoint-GUID: CfJoqX0oFJjTMocOaOjFpp9pcJgDuwK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=723 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170122

There's no reason to restrict the creation of the hwmon device to
a matching child node name. Just get the first available one. There
should only be one child node anyway.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 11e090da0590..d3feba43c029 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -669,7 +669,7 @@ static int occ_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	hwmon_node = of_get_child_by_name(dev->of_node, hwmon_dev_info.name);
+	hwmon_node = of_get_next_available_child(dev->of_node, NULL);
 	if (hwmon_node) {
 		snprintf(child_name, sizeof(child_name), "%s.%d", hwmon_dev_info.name, occ->idx);
 		hwmon_dev = of_platform_device_create(hwmon_node, child_name, dev);
-- 
2.43.0


