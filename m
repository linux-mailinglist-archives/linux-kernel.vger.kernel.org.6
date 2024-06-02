Return-Path: <linux-kernel+bounces-198133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F08D73DD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 06:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA33281D50
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 04:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530CB17573;
	Sun,  2 Jun 2024 04:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EJu4CtrY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D674171A5;
	Sun,  2 Jun 2024 04:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717303474; cv=none; b=kIpUwGL0JtoLPcmskRWdR8ewFQ4pGZ4g5ck+M3gUJtQtpzKEBn9FmLabNnlYlsSCzz1pyGi/TBY7cjH9hnmsTKNuisGVzCbgOfwc24KtqsSLpMwFdc4Lc+89Ao+j15/FMAfjlOYaAPhtRUKh3My9js8eeCiTcwCxXMRhYqHPW08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717303474; c=relaxed/simple;
	bh=tcFWKldo0RI0JL1/1dQ+E5e/BJuI3bIOoLoqyG6veIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=SmT2/Ovenmb+5uTIHFZw6fnAj9lV0GSOxT9pPuVjRmeTq7L6hHFwYPQuZCOPZjETPp+c6hzyfRRHpO859JGaJswRTBEIYjfvYqW2yfBs/m/xTd58U80ETDelmx9+05JTzRBcbJWsOi3cq0Wc9Bi7lNSg7hghaKDcgV5hwy83Mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EJu4CtrY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4524VraK025385;
	Sun, 2 Jun 2024 04:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6tcUcaGv7JGo2XBUVsbn9R
	w9/Ef8KQb6jKCpkZinco8=; b=EJu4CtrYkWcdcy86yCv7AK7BXYxGZkuho0Tl4H
	pjUcOOUaPSUNJXdnpdFhYXYi8lyfsu3ekM5ZeDfitlZYdGFHxUcJETnUfLOi/LHZ
	ad0/eayrCIc2Dqoke5JuAM58mEATNC7B+g4c3sdHo5KBz+aV67QDHjnVbJHM7RCO
	/lrWTs2m+GnzX7rGbn07K0qszmcL1DID6U3oXm6NclU41O/ticHB0h6JcUZMkeNZ
	onXrpdJPVQNcr8sHP2w9biMjzCLu4Lth2GcJHb2vFo7ubdDL1M2r6Fq/nkHMeHhc
	Yh9pLg9CmmWlqCUcixwVo66+FejKsGYdY+tYEC41ZlzYwymQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw42sq14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 04:44:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4524iNsT010117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 04:44:23 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 21:44:22 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 21:44:22 -0700
Subject: [PATCH] clk: sophgo: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-drivers-clk-sophgo-clk-sophgo-cv1800-v1-1-8e00d8c3a87b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKX4W2YC/1XNQQqDMBCF4avIrDuQSJC2VyldxGQ0QzXKjA2Ce
 Pem3XX3vs3/DlASJoV7c4BQYeUlV9hLAyH5PBJyrIbWtM50xuIcMQoXEsUwvVCXNY3L3yz2agw
 6N9y6GK03LkKtrUID77+nx7O690rYi88hffsT5/eOs9eNBM7zA/9NjiKYAAAA
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto
	<inochiama@outlook.com>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gp0o1UD4mX-ExkFxHSvd6uZEXqbBmQTC
X-Proofpoint-ORIG-GUID: Gp0o1UD4mX-ExkFxHSvd6uZEXqbBmQTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_19,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=947 clxscore=1011 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020036

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sophgo/clk-sophgo-cv1800.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/clk/sophgo/clk-cv1800.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
index 2da4c24621cf..e0c4dc347579 100644
--- a/drivers/clk/sophgo/clk-cv1800.c
+++ b/drivers/clk/sophgo/clk-cv1800.c
@@ -1534,4 +1534,5 @@ static struct platform_driver cv1800_clk_driver = {
 	},
 };
 module_platform_driver(cv1800_clk_driver);
+MODULE_DESCRIPTION("Sophgo CV1800 series SoCs clock controller");
 MODULE_LICENSE("GPL");

---
base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
change-id: 20240601-md-drivers-clk-sophgo-clk-sophgo-cv1800-44f96dd1a04d


