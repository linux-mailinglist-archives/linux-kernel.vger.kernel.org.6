Return-Path: <linux-kernel+bounces-198331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5CE8D76D0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A866A281D28
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067450276;
	Sun,  2 Jun 2024 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N63/J8g2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9DC41C73;
	Sun,  2 Jun 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342720; cv=none; b=tnGtcMfjNLc+n92asqmgXimqdfEuT++2Km2UOpQkvQJDRTtDMhtJBUO4W4eft3Q7RsjRHzwaDojS2IhXIeNe1wT0gPgU5h6keM8lsroOHFrMULqVnjRaY0w29OeHSbAK7ntQt5GGb3t9jzUULyWwFfbOFIGL/1sruZ0apwca1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342720; c=relaxed/simple;
	bh=pwAJbNQvwEo6mxmgDhPYLNjCssIRxYFcs+epU6gjaRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=dPICDWsMK1Weyuv0ryExvzypmLPgDNyd8+Bjh2Ys4rtJT4Kj5EIEZ33DXNlH/tmjItf2CHiw7DxL6C9CcvwFDU8Ie/V8RcncMgA3/HWQNShszvJNlGaxrrNTvqVgaCR8d35eDReycx8AXgPuFYY4ldXjfv0D26NrRpvRQlkN3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N63/J8g2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452EtrQq028110;
	Sun, 2 Jun 2024 15:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WK297UvNPvF2mI8OYsa3SF
	RUH8FtRbSzi4oowt38h+M=; b=N63/J8g2G75TwDg/QS8dJbCTakEhxYm8TS7ttx
	7do6D9EZcGhpy8tnFy/FVLECWF8/Guabg2re3AAl8iHc0W+/VdOt4onX3NO+n1Kc
	YNGk+27Skq9yyZFSaDasv9+Ea9EC6I5m6Y/8o1JJ4IOfVHEhrAID9NO7YD14KLVW
	JQ/CHTRuCXb/xIJiNwQC4ZWC3Klsu32RvYXMOEihbr8VE30AfeEM+xJBbJLAsY3T
	FM8eSm2JtAR1Lti469i+6dCzSRubuNDW+/EvmmCDJcjZoySaHYJWtY2XrZkAgHUC
	Tg53dCcYz8fiRmETfDUGez4/Yim8HVTHZ1fEngNJyrRBTunw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5t24mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 15:38:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452FcYm1015353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 15:38:34 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 08:38:34 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 08:38:33 -0700
Subject: [PATCH] clk: test: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-clk-test-v1-1-a6afd4793337@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPmRXGYC/x3MTQrCQAxA4auUrA1kpqUUryIu5ifaYDtKMkqh9
 O6OLr/FezsYq7DBudtB+SMmz9LgTh2kOZQ7o+Rm8OQHGsnjmjEtD6xsFV0/DlN2kfqJoBUv5Zt
 s/9vl2hyDMUYNJc2/xyLlveEarLLCcXwBjgNMhHwAAAA=
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YGPo82ArNhEpBBykSqBvZytcBLop_roY
X-Proofpoint-GUID: YGPo82ArNhEpBBykSqBvZytcBLop_roY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_10,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=880 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020135

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk-gate_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk-fractional-divider_test.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/clk/clk-fractional-divider_test.c | 1 +
 drivers/clk/clk-gate_test.c               | 1 +
 drivers/clk/clk_test.c                    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/clk/clk-fractional-divider_test.c b/drivers/clk/clk-fractional-divider_test.c
index 929eec927548..1028e2002074 100644
--- a/drivers/clk/clk-fractional-divider_test.c
+++ b/drivers/clk/clk-fractional-divider_test.c
@@ -144,4 +144,5 @@ static struct kunit_suite clk_fd_approximation_suite = {
 kunit_test_suites(
 	&clk_fd_approximation_suite
 );
+MODULE_DESCRIPTION("Kunit test for clock fractional divider");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/clk-gate_test.c b/drivers/clk/clk-gate_test.c
index c96d93b19ddf..e4ddad532ff1 100644
--- a/drivers/clk/clk-gate_test.c
+++ b/drivers/clk/clk-gate_test.c
@@ -461,4 +461,5 @@ kunit_test_suites(
 	&clk_gate_test_hiword_suite,
 	&clk_gate_test_enabled_suite
 );
+MODULE_DESCRIPTION("Kunit test for clk gate basic type");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 39e2b5ff4f51..b17147a4a257 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2674,4 +2674,5 @@ kunit_test_suites(
 	&clk_single_parent_mux_test_suite,
 	&clk_uncached_test_suite
 );
+MODULE_DESCRIPTION("Kunit test for clk rate management");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
change-id: 20240602-md-clk-test-13648d1b0380


