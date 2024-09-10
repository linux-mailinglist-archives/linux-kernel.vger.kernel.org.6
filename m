Return-Path: <linux-kernel+bounces-323463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D32973D74
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C7AB23C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74BA1A2871;
	Tue, 10 Sep 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cU3A0hKA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D11A2570;
	Tue, 10 Sep 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986123; cv=none; b=dvU3VVCAucVmk9ivdUoWsc7sQJPedmjnIHIC8kzaRy862ynofUvJx0Iq437/1L4sjjy59iuhXulFeBVUe9iHmXcy/obusIq1eNw7Dw8NP0HaiyvCcXOlmjlfB8CxsQ3ZDjJldHV/jbs6j6EEDFwRKuH3992OWZVLg8DxafDyFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986123; c=relaxed/simple;
	bh=mCw4BGHkgI9vhVw/evjxNUaveRE0Q7NA48nPy6fWNxQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ITNqs3JISfWjAM2P92pBkt57su0rsk6enQGcjmHSDiiC3cCzphBxBv3qNtpceG1wexv1KWe41rchR4Uc2u0CLWZKL7rHGZlg5f+QBRAH3cI3z3loTJnos77re3affQPl6stJjofP0jsiepUnZzXUbR6hZFtNKA++rxwx5oCvxmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cU3A0hKA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AFLeHv031388;
	Tue, 10 Sep 2024 16:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2wt+TwLxR/x9sKCWZJkKDH
	T7621HRrrlF83DinozNmI=; b=cU3A0hKA/Kjwri55OzeVKbOewotT0UwjTEKX2k
	ztgcxeRSO4mbQvDPVcQw0ceppRT6JNpo7WmQYAGlsxrMvCFce9MGZC4sNmAPBNLu
	C05x5fgOoQQjESbDwLO8HiSF/s4gDuqPuvh3R/HSUuZP7gSWYZorwKpuq2ZzSEhw
	Eo6Fqx2NB/pApVlLhH/XeIk5MuiB9q9V8fVPfYW5cK38yb80TUggmcAjMJOlp4WJ
	xQwWMPdhF23VyixTArrRpaoJJjGbtyaqjYeqvEMjqjY+jE/TY2xSrIUjXsRIOxPf
	gTO8DB6h3B98gMUoJAtQBhCSs9/JT3gVWeAOp1ZaZcX/00+A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy516kth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 16:35:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48AGZA2h011762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 16:35:10 GMT
Received: from hu-nkela-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Sep 2024 09:35:07 -0700
From: Nikunj Kela <quic_nkela@quicinc.com>
To: <sudeep.holla@arm.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <cristian.marussi@arm.com>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_psodagud@quicinc.com>, Nikunj Kela <quic_nkela@quicinc.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4] dt-bindings: firmware: arm,scmi: allow multiple instances
Date: Tue, 10 Sep 2024 09:34:56 -0700
Message-ID: <20240910163456.2383372-1-quic_nkela@quicinc.com>
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
X-Proofpoint-ORIG-GUID: m0cvlDOZiHGc5ybHOIAOfJ5JJjyKw9jq
X-Proofpoint-GUID: m0cvlDOZiHGc5ybHOIAOfJ5JJjyKw9jq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409100123

This change extends scmi node name so as to allow multiple
SCMI instances.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---

Changes in v4:
	- Dropped 'virtual' from subject and description

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


