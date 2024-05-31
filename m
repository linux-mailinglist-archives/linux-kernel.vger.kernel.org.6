Return-Path: <linux-kernel+bounces-197587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33878D6CD4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749371F24B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD51F84FD8;
	Fri, 31 May 2024 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QL9THrsd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBC8C06;
	Fri, 31 May 2024 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717197979; cv=none; b=EubmyTBy2PZXfvP0Q+xPWvjsjyyeumpapm+j4FEGpwr1Vc5TRQ1iuDAnQdkM5zsPtMCL/Dhb+8vAgbcjJOBrmfXrcADQHHrvYmKb+5LqXt//Uuk2K07xUVAYxLSaYe2RxR+0RrgDMwW6miQWRc11vawjaqCfkIHuc/iYajWuvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717197979; c=relaxed/simple;
	bh=8eIUSgUTpZmqYq722IoG99bIAInjDpEbcH//vBnZ6S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=psjKj8pi+PAGx6DZ62Q5F3cWworZHJfeaY0W0PXSyIJASphpcsHRBIMQ0tJ/Dt9Dcm9twrl9nJ1dDCV7Ax1GBian7+WnKl7E2aUb14jHmjlrM9+JjAcWguwAXgJ8xenxfhSMD4tqL9c5LO/KzmSqpvonuRY+ReMYvsagbEKnu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QL9THrsd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VIQAlT019046;
	Fri, 31 May 2024 23:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=J8KiP0n7xfnq4ZO/gKJU6q
	G8ZT8uzzL+A5rT6T30XJk=; b=QL9THrsdrtOlk5FGv5Kb1qEJoPegTm3/LCwS2j
	SMMCgGcp/K5EgiDIBoMax4LgVlppqtwNci2Il5j9V04gkymG+LUKKavmt4XPACod
	Dk8kGCkB33KCWJNRu/O8lKXsdqRKx52GXkUmSu2ioXg0UwHnPxrSndsHsj6rTPTD
	L2VpoXgLHku/+exdfOR1Kjx9JrN19AyRUyI88iwKIUnliq615jPdEPKopHbJKj9K
	0apoqxb6UGTmTK0M8Y13RKVuQs5EA214tGhaaZSg8ksHYjN1tV1lRXpBUQ7t9Nyz
	dBi3L0XJuzjkWe5qFkLwThGJiR56uJyDCJruThu13B8ENpHw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yf23suauq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 23:26:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VNQ47N032655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 23:26:04 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 16:26:03 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 16:26:03 -0700
Subject: [PATCH] lib: test_hmm: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-lib-md-test_hmm-v1-1-e4aa17daa57b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIpcWmYC/x3MTQrCMBBA4auUWTvQ1EbUq0iR/EzNQBNlJkqh9
 O5Gl9/ivQ2UhEnh2m0g9GHlZ2kwhw5CcuVByLEZhn4Ye3s0uLDHHLGS1nvKGcdA9nI2do6nCK1
 6Cc28/o+3qdk7JfTiSki/z8LlvWJ2Wklg379ihst3gAAAAA==
To: =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eJtcEBkUvY9ujXX7AGgI5CqE4YvyKqOK
X-Proofpoint-GUID: eJtcEBkUvY9ujXX7AGgI5CqE4YvyKqOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310179

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hmm.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_hmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index b823ba7cb6a1..ee20e1f9bae9 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1550,4 +1550,5 @@ static void __exit hmm_dmirror_exit(void)
 
 module_init(hmm_dmirror_init);
 module_exit(hmm_dmirror_exit);
+MODULE_DESCRIPTION("HMM (Heterogeneous Memory Management) test module");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-lib-md-test_hmm-4ce59815fd6d


