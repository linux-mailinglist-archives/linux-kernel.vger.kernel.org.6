Return-Path: <linux-kernel+bounces-189213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8068CED37
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 02:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE381F21978
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 00:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAF310F2;
	Sat, 25 May 2024 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YsvWdc31"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90B23A6;
	Sat, 25 May 2024 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716596314; cv=none; b=oWOroC+hCxJUelVOHLyvO92BTODZl8MmD2n1OLYcRfhT11V7GrPJbsukw+aHXe6GJO6brb25doTfI9NnG/80pLkt04fFmkNzrsqXpH764oiQonyqOFHCNRs3jXhRFB/x2kJb4jRGwdk44w4rHjuukBZT/QwjYgtwNdhkutLConA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716596314; c=relaxed/simple;
	bh=Jyn4jAbRuGdM44eiA9NtkmXAWbafGmI0Ts8NoXoCfeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=MCfkDSWdq9vPbG0SiLZm6owwc9beNFHIbOADR1veeLu/k39c5+bUBE9nW+g88Cr1JZscBUn3aHE6zzjRf81G4s6shOiGGgJj5ywhOOabZbisgcvf/mZs034TGmMuBHFufmco/szrJuYj/jC3ACzEGoAmuIPtv1y1TePfv2nDJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YsvWdc31; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44ONbljH012387;
	Sat, 25 May 2024 00:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FGQ8MrW01xyesdBHaxcRfq
	h4doWeQc0kXoJl20ZTBT4=; b=YsvWdc31wDp8H9RDNukvHnTgC8eStqVVEkkKtm
	nLTE41z9mIGLnCrkl3elEigTAKalUp59EJnYIT6OKhT5s2YlOCyPPzpEBOlxaQsP
	1XMoW3k5DtiZqXPsbRFLjWatsKSfU7HHMIReLfgyviSUB1xzWiC5YnUTqVrv+kjj
	3itwV1tz7rvfd74JsDFPBkx5W3nbXTAg9t/ANSsX7gCIJ7P9vzWlliVwtfZuIOfl
	ZNlJSntsjkTIKjaIxTAO1HwQFpu1NuPXUXwghrgTO0X1xM6Td/b+lLCPKpHHxzF1
	/5FV3hkuAgEL2HEF4er2Tlg1vgjY5OVZhmVfMQV+0OSComIw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8hup0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 00:18:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44P0ICaU024223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 00:18:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 17:18:11 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 24 May 2024 17:18:11 -0700
Subject: [PATCH] locking/ww_mutex/test: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240524-md-test-ww_mutex-v1-1-4fb8c106fe21@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEIuUWYC/x3M0QrCMAyF4VcZuTawdVWGryIibRddwNbRdK4y9
 u5GLz84599AKDMJnJsNMr1Z+JUU3aGBMLn0IORRDaY1tj0ai3HEQlJwXW9xKVQxdEMwp94HO/S
 gtznTnes/ebmqvRNCn10K0y/05LRUjE4KZZw/OoV9/wKpaj0khwAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        Boqun Feng
	<boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GkuCSJeifeMtFpNxsLR7WNpGQ77_Nizf
X-Proofpoint-GUID: GkuCSJeifeMtFpNxsLR7WNpGQ77_Nizf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 suspectscore=0 mlxlogscore=925 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405250000

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/locking/test-ww_mutex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 78719e1ef1b1..0fab96137ddb 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -695,5 +695,6 @@ static void __exit test_ww_mutex_exit(void)
 module_init(test_ww_mutex_init);
 module_exit(test_ww_mutex_exit);
 
+MODULE_DESCRIPTION("API test facility for ww_mutexes");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Intel Corporation");

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240524-md-test-ww_mutex-c18c263bc483


