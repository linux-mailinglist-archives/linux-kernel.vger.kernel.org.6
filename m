Return-Path: <linux-kernel+bounces-569152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05728A69F37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DA43A8C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD871DF25A;
	Thu, 20 Mar 2025 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zm2s+/o8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A81805A;
	Thu, 20 Mar 2025 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742447841; cv=none; b=kmDgNpN93+NJRAvDSwvEQIJpeFqpt8t3erllnkpWccAzgljw7JjCRnXhLcNmw+ZvcaVliVTa0WE/Kr7F6ySopC0KSDmhJVA1vOBUD5yBkJ4hsw4C985UpQr5ujvwIXjh88U6N1xxWi6WP/kqAhLmtyOSQTurEqqXbNbAdO5eCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742447841; c=relaxed/simple;
	bh=tz1q2DBFc/OMbS5SGpxiEK7DVk8rk7tkjVbN0E+1JdI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=srHb6C3j0sv5tH1Hx2Ml2xSCEJ9Mz9L26tPBXL3r3dXHsSQ/+gNDXI9Yu9T2u6BgVTCzoQQCURMkeM2Qp5iJp2D1i1rqf+7vM8UPBwIyEs/touDPCf5PWY2MjZaMSwXz2PtoQxcNBivBgyRCBU/MezJPmi8ivkRn1U+YGitzAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zm2s+/o8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JJ5nNP023374;
	Thu, 20 Mar 2025 05:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gErWp/wF1Wj0f+V3oiP/9N
	AkZLnvUOMTTEDGf3DxA9o=; b=Zm2s+/o8nFtKLRagldLndzuYZn+Hx+K62+H2ZE
	TDfsOYcgfXIy+rMeN8tXhcts59l17apmZOwcD7Bjbh/5soADofKP9udpb4/q72s9
	cxGj80vK8D6KrhJhTooTME2OHEyt3bC+YwJx7TnND+aIe8FBI6sJna2aunAT0CZt
	SdGQMEzyK/43BbcIk9pN8QxLmcICmxGa5cXwAnzKB7zxzRxlUP7z76oCg0zV5E6P
	b6XK8/ephpNUCzFeSlf6rQWJs6DZFSs9svPonW2dW1j+yFzasiOI5H2AKjJdXAmS
	oX5Azt3M2wpAPR2ozM851REkDfVIsjo/cd6+63wnms2l4CRw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g3sf16gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 05:17:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52K5H78n011934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 05:17:07 GMT
Received: from hu-lxu5-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Mar 2025 22:17:03 -0700
From: Ling Xu <quic_lxu5@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <amahesh@qti.qualcomm.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <quic_kuiw@quicinc.com>, <quic_ekangupt@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Ling Xu
	<quic_lxu5@quicinc.com>
Subject: [PATCH 0/2] Add support for gpdsp remoteproc on sa8775p
Date: Thu, 20 Mar 2025 10:46:43 +0530
Message-ID: <20250320051645.2254904-1-quic_lxu5@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kYPLtpP1ZG_GsT6jSpwn_KIeNfFwmk_N
X-Proofpoint-ORIG-GUID: kYPLtpP1ZG_GsT6jSpwn_KIeNfFwmk_N
X-Authority-Analysis: v=2.4 cv=R9IDGcRX c=1 sm=1 tr=0 ts=67dba4d4 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=mVQdYIaDE-e1hwXU0PQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=734 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200030

The fastrpc driver has support for 5 types of remoteprocs. There are
some products which support GPDSP remoteprocs. GPDSPs are General
Purpose DSPs where tasks can be offloaded. Add changes to support GPDSP
remoteprocs and also add GPDSP fastrpc nodes.

Ling Xu (2):
  arm64: dts: qcom: sa8775p: add GPDSP fastrpc-compute-cb nodes
  misc: fastrpc: add support for gpdsp remoteproc

 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 58 +++++++++++++++++++++++++++
 drivers/misc/fastrpc.c                | 10 ++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

-- 
2.34.1


