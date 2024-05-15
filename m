Return-Path: <linux-kernel+bounces-179507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557DA8C6099
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC07283F11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C313BBC1;
	Wed, 15 May 2024 06:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F235iv+M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB153BBC0
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753123; cv=none; b=AVbFgh1jWMmXEJl6PYuw90i9rXe5XL8jNbMQAu1S8+MFGQpAMFpk8xqnHJz8tnhH1PSBMXVOJUUs+dOD13w6rL2L9ksqjMKI3dU2PRBx9iDfO2cvi+lyqZeeMvElGTvOQBrD92OkcCLN6ABD0IocmFd1neUM08QLLkQZ0jthGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753123; c=relaxed/simple;
	bh=glxZWalClhItPmKBT4mI+SpZz96hk1rNL5AL/Q5KevQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hspUvoxf1qrJdbtTusk7Xw8mNT2nEnllpAkcN8ufER22b2zRLK+4wBEGTn+LpWEgVRU9fKKgmAZQ35k3sVu/YDcVwEY74wd7Rein4IU3ahI5YGdJrRahTCqUVvawvaOS4xOqnCzNjY2k2lnJq50iwq8lKld8VmcEjegQmlDd1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F235iv+M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44EJUbXE026376;
	Wed, 15 May 2024 06:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=zOD
	MtrKyEGSQ9LSk8nTmKQU/GLmrU+rBf/+KAz6VtPM=; b=F235iv+MyOdSDthfQgC
	8WHVIKXAQkn9Q69c5YEprOrjNcSfkVW1EC8wQeSVd7bz/cH2Rs2HqNSRTb/4jWwp
	Ma3JMnP12P1bq9sgQI7WF+lFK9oDzKBJXLu34QiDvGpVM4Fcu0vQLEB/qbZ8Z2Gq
	hZS3JJiLk19HwOL9BpZqDJsdR61eQozSQf7KYt0rYviQLoyBebipfLEwTIBpUoQ/
	WPPu269wRjZcBPRZM24cXdvTjLaeQzfT0zIGadza+ZW9T/i1MHwKEYh8uKLQ/T9g
	9xq2yl8W0YSFdTdfM7188LdtP0mBjzKwNm9VUbirvhonr9+lc+7gdCxpKNSErlA4
	+Tw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y3j28mu2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 06:05:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44F65C8w006532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 06:05:12 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 May 2024 23:05:09 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Wed, 15 May 2024 11:34:50 +0530
Subject: [PATCH] mailmap: Update email address for Satya Priya
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240515-mailmap-update-v1-1-df4853f757a3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIFQRGYC/x3MQQqAIBBA0avErBNMtEVXiRZTjjWQJVoRiHdPW
 r7F/xkSRaYEQ5Mh0sOJz6OiaxtYNjxWEmyrQUmlpemM8Mi7xyDuYPEioRwqMtrZfnZQoxDJ8fs
 Px6mUD1lFkUpgAAAA
To: Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson
	<andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Taniya
 Das" <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7WbmTs4fsx_sfIiWead69OfVBLqsHV92
X-Proofpoint-GUID: 7WbmTs4fsx_sfIiWead69OfVBLqsHV92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_02,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=571
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150041

Update mailmap with my latest email ID, quic_c_skakit@quicinc.com
is no longer active.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index df56e43cb57f..43cd2995dbc2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -572,7 +572,7 @@ Sarangdhar Joshi <spjoshi@codeaurora.org>
 Sascha Hauer <s.hauer@pengutronix.de>
 Sahitya Tummala <quic_stummala@quicinc.com> <stummala@codeaurora.org>
 Sathishkumar Muruganandam <quic_murugana@quicinc.com> <murugana@codeaurora.org>
-Satya Priya <quic_c_skakit@quicinc.com> <skakit@codeaurora.org>
+Satya Priya <quic_skakitap@quicinc.com> <quic_c_skakit@quicinc.com> <skakit@codeaurora.org>
 S.Çağlar Onur <caglar@pardus.org.tr>
 Sayali Lokhande <quic_sayalil@quicinc.com> <sayalil@codeaurora.org>
 Sean Christopherson <seanjc@google.com> <sean.j.christopherson@intel.com>

---
base-commit: 26dd54d03cd94ecc035d9e1e9fd4fc0f3ab311cf
change-id: 20240515-mailmap-update-2fa2e54fd6bf

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


