Return-Path: <linux-kernel+bounces-352983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476189926D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603031C2231A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4D18A93F;
	Mon,  7 Oct 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TJQo5A8W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3917C203
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289438; cv=none; b=URBmBs9IlPbCG4qCj5fuOypgW8ISGv4XivOHL+47wcuumGxxnvWQFlj/LW2JOTpS8LW1nsMKEuewWIPxq2wYOY6h12kW2J7lCkyW7N78N9lad9m6navw12AeqAvJaftRzydq2+5nanp4qzthEY3fKCpxG0hnayKF5ws2j9d1v7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289438; c=relaxed/simple;
	bh=g6RCu1HPOdp+YNNhSy/NIRS3ty3JnWxsqEJFX7nVfJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JvA4gw0+tLZdtYsx4/6XVdE6mDy2MubIgRgn71fhDM1bwZa6BwAH4WXdjJh1Gp/TMi/O6h5w3V6lSPluA6Yp6/+xRjVzUvtHWCn63b1jEZrifyuMpfXBPY7pm2EZIUoWc/rT7sUKuf58p1B7iN8VKaO352Vz9UoLGitTvyvd2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TJQo5A8W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974Sk4H026816;
	Mon, 7 Oct 2024 08:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Giv9AOZbCwyuNEU4YbLYmA
	MQQIpAN/aBdZN4G9IB2yI=; b=TJQo5A8WFbckeHgLME2evA89VrH8WCHwE1Tdli
	jTOc1W7QC/SlV/4JTFmODtodbNfBs1u6z5EHAyjvU19siFer2g6sqXvPV3QGycD2
	k+Lh1UfqGi7pfG1pzxEhE03agDRSn6k7uAs9XZy/Z3UjgEYSf5FLz/0sOSRqwQre
	brYKmFZXWBBEqruPwOJ7vEIBzBjc+yDvIeQyqFTxogbhWAXHGRmF6i6mF3OR+8A2
	D2mWXcK3NgdfaFU8MxsW9Lre/lvwvHwpUv3qcbV6dvYfOX3/tzo7X7mNT7b3i0eZ
	WpDSRfbnL4Vy/i3MCnw41k7B5yaG9uPunz6/pbKlQFmZ1Gvw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xq9ueb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 08:23:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4978NkvN017097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 08:23:46 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Oct 2024 01:23:40 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <kernel@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        "Mohammad
 Rafi Shaik" <quic_mohs@quicinc.com>
Subject: [RESEND v1] arm64: defconfig: enable WCD937x driver as module
Date: Mon, 7 Oct 2024 13:53:12 +0530
Message-ID: <20241007082312.2136358-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zFa-k8R4OQTAgjfwemJ5WvO2CJ77ZtXT
X-Proofpoint-GUID: zFa-k8R4OQTAgjfwemJ5WvO2CJ77ZtXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=595
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070058

Enable the Qualcomm WCD937x codec driver as module as
is now used on the QCM6490 platform.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Rohit Kumar <quic_rohkumar@quicinc.com>
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


