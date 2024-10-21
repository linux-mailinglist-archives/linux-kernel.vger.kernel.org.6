Return-Path: <linux-kernel+bounces-375251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D631D9A93B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9871C2835EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6056D2003DB;
	Mon, 21 Oct 2024 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DSzGm8jV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32F1FF03C;
	Mon, 21 Oct 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551856; cv=none; b=SaMwfMCLFlWNKBSy7IBjTpE7dWd7swbsKcMu7Op1ic1onwVY/MgUq/o9njhtbi2NSFxG2kd2vMSEvZeIocyGx9kZi8GAr8Lmz5VPBFkextW3JeH0YOX5oibV7SUzpMZxWifwe/bvEBgIdqMtCWZFqi3rfVK57/hseyQysPe9Ifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551856; c=relaxed/simple;
	bh=HfBPU+AKenO+g21JEUyywg9dhKR0pJbfoRSH2E34mUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ufd6IAcpr+ZgWfPMvKJ5al7m4wO98H4QfAkc/kXytNGmvadadkhCT80uSa0gzyL9MR+CeG0ZFZFq1htY673+f9lFTUQ0p7mGoqsD0i72Mei24XNXJmzWyVM1QhsLz0/9DJrGIMdvB3qf1PFHTs17bZMQAV6RK2p9Woz3BCsz/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DSzGm8jV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJqU8O016094;
	Mon, 21 Oct 2024 23:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=p5n4PFtslhI76somfl10v/
	nHSOCNx0yJ2C/IToQY6Zs=; b=DSzGm8jV/omHCy0yNsa6gG5+1oGLZ2hRdO8OUL
	tChhkOvYHKGxoO8s79LiKG6X1gBsinnUwzMdql0EQgv/zbYmZ+zrxsRsXnEaUnFc
	PbUqkQMgzVIlB7C/GxB+Abbe7QfOHYoW6GdUswxpqDTYyn0Thu4yVIvPDmQ28aP0
	DmukJFSZ9nYhhYP99GUyGpKYKhEmPMp7NBvL/QMItl/vyH/v0fPAlCIYfdjI6meS
	/1xcj6dI+RfwZSOiBUHbmGVcv6FbIJfr82w3XrI6Awqcz1lYFhc1B8h+79z/EQXW
	HzoV4riB9+V4dOtkqb0eiut6Bs4gAxHzagKM+deyskUZqG1g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6rbe966-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:04:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LN4BnL001488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:04:11 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 16:04:11 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala --cc=linux-arm-msm
 @ vger . kernel . org" <quic_satyap@quicinc.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 0/7] clks: qcom: Introduce clks for SM8750
Date: Mon, 21 Oct 2024 16:03:52 -0700
Message-ID: <20241021230359.2632414-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6Bozmtvv6a53LIDSPL60lPy2KwqhnVKB
X-Proofpoint-GUID: 6Bozmtvv6a53LIDSPL60lPy2KwqhnVKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxlogscore=553 lowpriorityscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210163

Add GCC, RPMH, and TCSR clocks for the SM8750 SoC.

The Qualcomm Technologies, Inc. SM8750 SoC is the latest in the line of
consumer mobile device SoCs. See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/images/company/news-media/media-center/press-kits/snapdragon-summit-2024/day-1/documents/Snapdragon8EliteProductBrief.pdf

Taniya Das (7):
  dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for SM8750
  clk: qcom: rpmh: Add support for SM8750 rpmh clocks
  clk: qcom: clk-alpha-pll: Add support for controlling Taycan PLLs
  dt-bindings: clock: qcom: Add SM8750 GCC clock controller
  clk: qcom: Add support for GCC clock controller on SM8750
  dt-bindings: clock: qcom: Document the SM8750 TCSR Clock Controller
  clk: qcom: Add TCSR clock driver for SM8750

 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml      |    2 +
 .../bindings/clock/qcom,sm8750-gcc.yaml       |   65 +
 drivers/clk/qcom/Kconfig                      |   17 +
 drivers/clk/qcom/Makefile                     |    2 +
 drivers/clk/qcom/clk-alpha-pll.c              |   14 +
 drivers/clk/qcom/clk-alpha-pll.h              |    7 +
 drivers/clk/qcom/clk-rpmh.c                   |   26 +
 drivers/clk/qcom/gcc-sm8750.c                 | 3285 +++++++++++++++++
 drivers/clk/qcom/tcsrcc-sm8750.c              |  147 +
 include/dt-bindings/clock/qcom,rpmh.h         |    2 +
 include/dt-bindings/clock/qcom,sm8750-gcc.h   |  226 ++
 include/dt-bindings/clock/qcom,sm8750-tcsr.h  |   15 +
 13 files changed, 3809 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm8750.c
 create mode 100644 drivers/clk/qcom/tcsrcc-sm8750.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8750-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8750-tcsr.h


base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
-- 
2.46.1


