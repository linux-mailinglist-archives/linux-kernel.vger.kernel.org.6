Return-Path: <linux-kernel+bounces-317785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E9796E3C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C47281F88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFDB193400;
	Thu,  5 Sep 2024 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qwe48Cl8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE9158DC0;
	Thu,  5 Sep 2024 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567163; cv=none; b=iS237tQp57QA6tm4cmOLJA7+UuoIJByp4+sp7FJsEHdx5IsbQgtyPcQuxV0UbKc8eDPgnBxDvP1c1GFM8uzqUGUcjN1U75VdFki28RE1kXoUlkpNIDV4PZOdQJYks/r+NsOWCyLxqQcqC50mVB19v/blgMjneacDELDyeCdeNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567163; c=relaxed/simple;
	bh=w/ZWoZWSJ2oywbAuMrgFd7l5yRBfaFpUWObRn3hGLoQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZM1IIVnyj5vag0Qgggxq8mCmE2QwhI9FL2dDeHYer/00WtnCyrNgEPX7krq/3MI3fhNeRVZhXXd1/jHaiLEEkT2SJVdAXawf21soYh9XpJ4aSfMBMHheVWUMeKrQT+xpKMa+FoVhkKMMOxT9p4WP/TFk0PdxSNPS8euxqwRI9fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qwe48Cl8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IPwSt021611;
	Thu, 5 Sep 2024 20:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WdZmBG0Qn3m95qrKq0kN7i
	SjKHyqrRrZ0qphiCEjm1g=; b=Qwe48Cl8BW9yHU49Gphh6hojXTaMv73jJbyB/d
	FpQKFkBHwVr9UZMWN02rHDp3zSHHVIBJd3qSJGeOzyqj6zLi/2j3IaFXg/U1ckwm
	EJjKDy94cLZz8p7G/JVt00/csiuCOzIH85GSYiBo0jZ6Awba2cURcXnuf0YuYPgm
	Hi6/K1TKJfi41sisYaW88Eh8Hu9KhyJDNuwubaq9fCdeJKf1hPgY4EUU2EjHxvIX
	5E8VuP+Olkkh9kh5HVWRxHsctTDoLqRl1XBiXsz37nCjX9hOOayfQC9DYrU9oUoY
	25BqfTgaSUN7iS1KsVffdQ1FoedTnDRiC4tM04RAMZxiyg4w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu06rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 20:12:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 485KCWpB014182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 20:12:32 GMT
Received: from hu-nkela-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 13:12:29 -0700
From: Nikunj Kela <quic_nkela@quicinc.com>
To: <sudeep.holla@arm.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <cristian.marussi@arm.com>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_psodagud@quicinc.com>, Nikunj Kela <quic_nkela@quicinc.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple virtual instances
Date: Thu, 5 Sep 2024 13:12:17 -0700
Message-ID: <20240905201217.3815113-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4KeDDcMrcS9i_kO9O45S30M87pN3ANkh
X-Proofpoint-ORIG-GUID: 4KeDDcMrcS9i_kO9O45S30M87pN3ANkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_15,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409050149

This change extends scmi node name so as to allow multiple virtual
SCMI instances.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---

Changes in v3:
	- Added Reviewed-by tag
	- Removed the patch from original series[1]

Changes in v2:
	- Fixed scmi nodename pattern

[1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 54d7d11bfed4..5d79b15a1610 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -27,7 +27,7 @@ anyOf:
 
 properties:
   $nodename:
-    const: scmi
+    pattern: '^scmi(-[0-9]+)?$'
 
   compatible:
     oneOf:
-- 
2.34.1


