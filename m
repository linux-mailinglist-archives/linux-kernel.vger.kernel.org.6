Return-Path: <linux-kernel+bounces-196283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD498D59B3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49350B2281D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8A79B84;
	Fri, 31 May 2024 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yb6GaNAz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75D36AEF;
	Fri, 31 May 2024 04:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717131342; cv=none; b=R1glJ0nhN28Kw795GjhebAGXNiib25f53nJTIQISqQT74gOOFIFvTVdVmRnsueskBrpYO4YJwoVeM6JYyJh7+hJPS1XL1qRWfzhmeIyFkWt0t435DJDAi28dSz5Ex3VBxP8YLdedK9Eus0BMN6qBN/3pZpJDZKdzSygGRIxMi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717131342; c=relaxed/simple;
	bh=jruFbjeLwi5gzunY1kCfVsAyhAsfUAjXxkz6//R84v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=G7cbbfIve1TTfFvDXm1RjG6bujfymEqAH+vGquwSELzxBPkqST7Vvn7CvlO+NHbY7+WvVT5QxS3amVytitG91eobwcCQaLbX/tMqf64Y7ItK7gSpmbsFVYsqSQKq2zzD4+0U4lsS/5W9q1AanzhoZ+Cw564wJzre4zQmv8/tLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yb6GaNAz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UGsnwa001099;
	Fri, 31 May 2024 04:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eyb07Mj282ja+9iwaBTaMR
	f2T377XDF4HIwuTEVQOI4=; b=Yb6GaNAzdLPgmAnGJK7l2KceInFnVgO1BwnCWZ
	NcE4ytA5jHME/3h7aw0//1r6WaRne+UmLPRna/+1k9fniSVWchBYJ3UrVjS7RS+Z
	WZTQqrLkGPOCtKfHm1s8JbJjjb8X59iVjpeGKnwOUBlF8GuZb2obpTAwldU7yUh+
	V96Age7WSC0YE9N4L6Y7w3lyLUQU672qjjiXx5ekaYB2TmS/H95m4eP6p9oKHkyD
	DOQo+km98Rl43b6oqmOsc+/zCK3bM/uIOYMptGa+dPSxoMmMisp5rruqN18flvX5
	UfR07FbbZvdsYLmfzDGsEyXECrOhWidj1FlA4zz3WYSEX9Sw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yjdyj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 04:55:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V4tZr4018938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 04:55:35 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 21:55:35 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 21:55:33 -0700
Subject: [PATCH] intel_th: msu-sink: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-intel_th_msu_sink-v1-1-ae796336e7b9@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAERYWWYC/x3MTQrCMBBA4auUWRtI0xaqVxEJ+RnNYDNKJpVC6
 d2NLr/FezsIFkKBS7dDwQ8JvbihP3UQkuMHKorNYLQZ9TRolaMirrjYmmyW1QrxU/Um+vPop6D
 nGVr6Lnin7b+93pq9E1S+OA7pN1uI101lJxULHMcXM1q+QoUAAAA=
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ozhjk8mBTVVxE3EI9dSeqhAkd-Vs3sMs
X-Proofpoint-ORIG-GUID: ozhjk8mBTVVxE3EI9dSeqhAkd-Vs3sMs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310035

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwtracing/intel_th/intel_th_msu_sink.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/hwtracing/intel_th/msu-sink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/intel_th/msu-sink.c b/drivers/hwtracing/intel_th/msu-sink.c
index 891b28ea25fe..256ce3260ad9 100644
--- a/drivers/hwtracing/intel_th/msu-sink.c
+++ b/drivers/hwtracing/intel_th/msu-sink.c
@@ -116,4 +116,5 @@ static const struct msu_buffer sink_mbuf = {
 
 module_intel_th_msu_buffer(sink_mbuf);
 
+MODULE_DESCRIPTION("example software sink buffer for Intel TH MSU");
 MODULE_LICENSE("GPL v2");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-md-intel_th_msu_sink-12db94b5c088


