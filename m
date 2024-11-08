Return-Path: <linux-kernel+bounces-401372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD379C195A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3465A283563
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10931E1C02;
	Fri,  8 Nov 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FOVPuOF6"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBA1E1302;
	Fri,  8 Nov 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058581; cv=none; b=kln6mv4jlkHlmrh5K5hcloWm0ralCSphINQGj3opRS8kBS2x42VnKiDTXPMlpT2Y0yW/hVBgyh7kKtXQcbpsjJxKk7u1SviEvlXDmKidfNJuApRScdAyaNa4X1xVzzN71g0vksYwr//7SgWyqMLV1waJo1WzOiIsExCqTTXlwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058581; c=relaxed/simple;
	bh=p5EaiMN+oZCLNawUhVoJr6ZHnsdSeb1Ljjt0OHOoY2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UgwMI6LpoKSgDtOdXum61Bq/yCM2s7wEjiUucFRDNrhsR+v0HOS1Y2VzGcdrF/LBIZMDCP78motEd5jMMnWc3sFfGMkx+fru2Q+pVYV4JdIDD4Tb3b3cR7athUW8Xmks5DQnYM66RF+2awvzvHwMmUhQKjs5vxNfO5Xwp887x8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FOVPuOF6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A84N6E0018402;
	Fri, 8 Nov 2024 04:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=nvuGOe/4xSK7HC4POviPY4c7buw
	P15xGhDavzq9HaXE=; b=FOVPuOF66mSQG/xyvG72QTdepiQx5CaeA0/0d+md77P
	Jsh4ZVJjisiejJ4fS+1HOrWMWsGBkcYCXEyIsdgA8t6ZUjAV3UV8J1X3NL28l2lo
	0ljofoScUE1Mz4ZUPY1l82zuHVyL4r3fv/fxAm1nnV0Dtjpsu3TzpciT/PtARVkK
	o9f99XdwThKly+iQ1/DmVrVyL3FZ8L6ZS0BAK0t6tUCojjBmEd//OQRxvSI3DHWT
	Wzo9YR0/hzqWy+3z6VJaWXzix5QRjwNAnhR+uMbCp4TlAIUuPWcWq5X2xGqXsp7X
	nabnuK2A1ImNjRvI950S6A2b25WNteXs+3L50Epnkqg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42s6g7jjmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 04:36:04 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A89a3dH034334
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 04:36:03 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 8 Nov 2024
 04:36:03 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 8 Nov 2024 04:36:03 -0500
Received: from RCALAM-L02.ad.analog.com (RCALAM-L02.ad.analog.com [10.117.222.43])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A89Zn5M026842;
	Fri, 8 Nov 2024 04:35:52 -0500
From: "Ramon Cristopher M. Calam" <ramoncristopher.calam@analog.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Cristopher Calam
	<ramoncristopher.calam@analog.com>
Subject: [PATCH 0/2] Add driver for LT8722 regulator
Date: Fri, 8 Nov 2024 17:35:42 +0800
Message-ID: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Iy5epaH9msa_VhjpJsiy6-OkwWE98Eeh
X-Proofpoint-GUID: Iy5epaH9msa_VhjpJsiy6-OkwWE98Eeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=854 suspectscore=0 clxscore=1011 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080078

The Analog Devices LT8722 is a high performance, high efficiency,
15V input, 4A monolithic full bridge DC/DC converter. This converter
has 92.5% efficiency with high power output of 54W for fine control
TEC driving applications.

Ramon Cristopher M. Calam (2):
  regulator: lt8722: Add driver for LT8722
  dt-bindings: regulator: Add adi,lt8722-regulator.yaml

 .../regulator/adi,lt8722-regulator.yaml       | 178 +++++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/lt8722-regulator.c          | 701 ++++++++++++++++++
 4 files changed, 890 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml
 create mode 100644 drivers/regulator/lt8722-regulator.c


base-commit: e18da71634d12a94a15138947538ef2f0ac22746
-- 
2.47.0


