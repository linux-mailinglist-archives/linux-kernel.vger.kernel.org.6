Return-Path: <linux-kernel+bounces-407068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF229C6829
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172081F22E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3961714B0;
	Wed, 13 Nov 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ImYhTv1T"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832731632D5;
	Wed, 13 Nov 2024 04:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472760; cv=none; b=tcCASaRJ3rmD4QABQU4rfl+UxDcGSJZl9/3kGiozYZS9sLH/0ZYQNMX6h5FXgM5MN5pFvxdrfXrZSwJzCv3PQz/D47aBDNUCWe0oaVe5qj43MAFvVoDVVT2LIDwaul/HlmAKFYvgca/02GDeyOJ9vr9vh0ERVQXBmwBOFw9v/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472760; c=relaxed/simple;
	bh=36HWdfA6rpdsSgcWFGGWjNfbKGoi1Kqb1CetwRxafLg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KUHe8yWyg3WkrhHL5SoqdeuCg7jfD0NwgXw20E1ZZtMV8RkzGFAMo2PQzGtFWmc5v/1kjaJ9S2RAUGPotNn214a85bUBS8xhxbX7ZoJae4A1vRW7Rzg4mXtltqEPeFjdoA5uePoSatrBob0dXbyJmI6USyQbxM87g/3rKWNs0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ImYhTv1T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRkip003749;
	Wed, 13 Nov 2024 04:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gitpLMpgky0G1vCtfZnSee
	vbgIYWeVgh+yWqlBdefjc=; b=ImYhTv1TGc8Q5pRaqTsfbKjvg/t55tlmkBCDZl
	B28rQhR5MGbW9IHjhGE2oAJrQnd8fTUlYMSTA3359Uh481Lj2mL3Njf9hrl+EQA6
	HWyZCKI2aKnQ3KD7xYi7X8BHzU8RTCsQuwHuCBM/rU3xma019l7PyUEhLUTCu3tP
	L7RlbnsDEFSh/A2z4zXeZ2suzDc3lsq3GuCtZg9OZQeuEf/QZlGH0+1Y24arH4wH
	EzO59LadfMtn/YWZ1ewNCedR+DiQvZaXvPisGEm9NRq7ermzGyMNne3Xfo4LHywc
	vpG2hPWj3XTSVRqKc5KZ3J1TQimdwhidyHKmjv1qy7jSHreA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t0gm1fb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 04:34:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD4Y83x021354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 04:34:08 GMT
Received: from hu-yrangana-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 20:34:05 -0800
From: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller"
	<davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_yrangana@quicinc.com>
Subject: [PATCH 0/2] Enable Inline crypto engine for QCS8300
Date: Wed, 13 Nov 2024 10:03:49 +0530
Message-ID: <20241113043351.2889027-1-quic_yrangana@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IHJV86a54COcMOpCJVQ16oQ18YHv9EZz
X-Proofpoint-GUID: IHJV86a54COcMOpCJVQ16oQ18YHv9EZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=601 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130039

Document and add device-tree node to enable Inline crypto engine for QCS8300

This series depends on below patch series:
https://lore.kernel.org/all/20240925-qcs8300_initial_dtsi-v2-0-494c40fa2a42@quicinc.com/ - Reviewed

Signed-off-by: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
---
Yuvaraj Ranganathan (2):
  dt-bindings: crypto: ice: document the qcs8300 inline crypto engine
  arm64: dts: qcom: qcs8300: enable the inline crypto engine

 .../bindings/crypto/qcom,inline-crypto-engine.yaml        | 1 +
 arch/arm64/boot/dts/qcom/qcs8300.dtsi                     | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.34.1


