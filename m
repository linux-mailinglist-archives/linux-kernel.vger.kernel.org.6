Return-Path: <linux-kernel+bounces-447200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1F9F2ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51E51885202
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34382204594;
	Mon, 16 Dec 2024 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q04egcso"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DD203D46;
	Mon, 16 Dec 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347060; cv=none; b=uOo4e799A/RldXh/aZWquaTyCK3dwZJfXMMVMemgvkhOmq6jgEVPMoOBmvcRk8COLmpeUpzX8DdjGRxs9cWqKX/g+UYJm2A0C4XDlAOSGNtgrjroTpAfZR0nq+9DWLvpsmJyk3yHjbqD4r/1Piz/hQozMO1ss5Pa3r24xa3hLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347060; c=relaxed/simple;
	bh=Ep6BfWXQ0mWEw/aoKmfPQubW1X/Ku/4ClR9igDvt6YU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FSGYHJNCr1iEn4Sh+Snqm5qrfJkVjYAil0233GtBZZ0zE+IWKe97Kca/dSLwi7dM/EP0eTX2WPh5Z+FeVlEvTr/GO0MXJNM40B5i4XCXydpokXrRUIAc1ZFo3zX7krnJnJVH+i74ZkLXSEdgNuaNct4phDgQofdu2t52Z2T4ar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q04egcso; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6YC1q023472;
	Mon, 16 Dec 2024 11:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=8PiEzheEavzz
	E7dCdu3xhWm3MuqOMS7yXV2tZZ4F48k=; b=Q04egcsouFf3HHxBR5PP7SCpDh2y
	PZMke3f5szgq+EvEw9Dzf3Zkp4Dz9fN7xCY2fOessFB8DcEOLZchM0VLxsct4j+r
	8K20Uux3oA4jOP/GkmOtYS94UoF/znQkC00fYrtDLVoEmDiQqO7C+59luYM4kkqF
	J4tUKt/wvsZX36zP9REfpIzANb894QLG1GULrU5cWs4LQnln61V0voWMCJQ5jde4
	Pv66WVzJ/fzSY1czT8aI66DMcCUrXGlffbk6bUXXhWnooe+wirrvF5250I0jBQZv
	G8MBIcoLbff7VHJng0SYQAdO/J3pqRYrn6kGI3fHoXUGw4sXtgzxTLVMOQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jf1w8ssu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 11:04:05 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGB41HX011378;
	Mon, 16 Dec 2024 11:04:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 43h33kna2y-1;
	Mon, 16 Dec 2024 11:04:01 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BGB41Uw011356;
	Mon, 16 Dec 2024 11:04:01 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-pkumpatl-hyd.qualcomm.com [10.213.109.81])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4BGB41Fe011353;
	Mon, 16 Dec 2024 11:04:01 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3914174)
	id A09315000A7; Mon, 16 Dec 2024 16:34:00 +0530 (+0530)
From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
To: Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mohsquicinc.com@qualcomm.com,
        kernel@quicinc.com, Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Subject: [PATCH v1 0/2] ASoC: sgtl5000: Introduce "mclk-rate" Property for Device Tree Configuration
Date: Mon, 16 Dec 2024 16:33:39 +0530
Message-Id: <20241216110341.3707-1-quic_pkumpatl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NwwY13TfEmrP_4csCfK-BxeN4R0LEHGd
X-Proofpoint-ORIG-GUID: NwwY13TfEmrP_4csCfK-BxeN4R0LEHGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160093
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduce the "mclk-rate" property, enabling the configuration of the
Master Clock (MCLK) via the device tree. The Codec Slave supports
a defined range of frequencies, and users can request the desired rate
from the Master using `clk_set_rate()`. If the property is not specified,
the default MCLK frequency will be applied.

Prasad Kumpatla (2):
  ASoC: dt-bindings: Add support for master clock frequency
  ASoC: sgtl5000: Introduce "mclk-rate" Property for Device Tree
    Configuration

 .../devicetree/bindings/sound/fsl,sgtl5000.yaml | 17 +++++++++++++----
 sound/soc/codecs/sgtl5000.c                     | 10 ++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)


base-commit: 5757b31666277e2b177b406e48878dc48d587a46
-- 
2.17.1


