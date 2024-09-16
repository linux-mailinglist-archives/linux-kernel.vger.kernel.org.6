Return-Path: <linux-kernel+bounces-330191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5D1979AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC225B2212E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9A9282FA;
	Mon, 16 Sep 2024 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DCjgtWhY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413923A9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464309; cv=none; b=dao9L9CvAdYxG79HxMxTvq2VGLg/TJo0vWPwbxGhM9DeX0wur50RBNj+PYHn+OA4wpsQGFNtz57Ysb1MGr3fKoMa1i+gqBs0dBJ0qfTLF7Yx645f5cTZDLDT2RiZbZgr4XqQ6HMQtZ9jx5VhoAz82N2dSZxoweDVaIMwOvZHb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464309; c=relaxed/simple;
	bh=BUSFThMO3Mu+TcoBwbC8zVaB94l5qpU6Mt8QaG4WyeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C0fW0+kvyhyhk8tWDE4jue25OC9QDST3dQQTpQTSgIDdXgQiubgHtUkGru0T1QoqDFp2b2VAl82GRUx9yvUna2DigDET23M5chBp+RYVG6KTATJmT6nhP5BIpUHmCSVxfLRFG3p/XvHDUVwCkfdOyWzPJrjwq+NfbtLfGsw5DkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DCjgtWhY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FNRlaw021652;
	Mon, 16 Sep 2024 05:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qPIKHtCATPFfayOVL2cKvL
	YvGOFDgdbb/LAn4LZ4h1Q=; b=DCjgtWhYbuzOhtHei3mpBoMhamSMrFakYf3rmM
	daLBlXR2tzm3BP6xMpOERu3ti0jiLuZXhtJFcxjqQxC1X7c+ck7UKHogQcBqjV7T
	UPwD0aTo4SXAmM2vLYnpc82W9I9keNOeglQiY1WVdO8eoZRmiqv/+2y91vvZiG9E
	YkCjrXAYsAckYOVeTn8zr/d/JMaMmXfoCLKiSUPK02BuJpxCO/KoQXSpdFAdqwCu
	vabmpqNPohdpc9lKq5udIGHHiBxZaYvqCdhb8ja1ZNjS4DkeyCaEjStLDkJ+zxMa
	yMQeoqmDS8h42bvwDiWSq93lYLCAOM02suvpwEGnyYJoJBbw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4k0jvrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 05:24:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48G5OkLF023019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 05:24:46 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 15 Sep 2024 22:24:40 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <kernel@quicinc.com>,
        Mohammad Rafi Shaik
	<quic_mohs@quicinc.com>
Subject: [PATCH v1] arm64: defconfig: enable WCD937x driver as module
Date: Mon, 16 Sep 2024 10:53:52 +0530
Message-ID: <20240916052352.1819088-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XvIb2t79OSkhBrHnTV_mEBpVVS2zFiR5
X-Proofpoint-GUID: XvIb2t79OSkhBrHnTV_mEBpVVS2zFiR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 mlxlogscore=614 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160032

Enable the Qualcomm WCD937x codec driver as module as
is now used on the QCM6490 platform.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..c4746e3412f8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1036,6 +1036,8 @@ CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
 CONFIG_SND_SOC_TLV320AIC3X_I2C=m
 CONFIG_SND_SOC_WCD9335=m
 CONFIG_SND_SOC_WCD934X=m
+CONFIG_SND_SOC_WCD937X=m
+CONFIG_SND_SOC_WCD937X_SDW=m
 CONFIG_SND_SOC_WCD939X=m
 CONFIG_SND_SOC_WCD939X_SDW=m
 CONFIG_SND_SOC_WM8524=m
-- 
2.25.1


