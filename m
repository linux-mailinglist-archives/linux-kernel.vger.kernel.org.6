Return-Path: <linux-kernel+bounces-238286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970DA9247E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C899F1C252B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3371C9ED9;
	Tue,  2 Jul 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J3P0BP/3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20816C847;
	Tue,  2 Jul 2024 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947715; cv=none; b=HzstEl0FcmtlB1HNDNP5W9MxI064bXd4WuGKcpkzj9oVNu4XwUhJhUwcn7nsJCQwt2yCDqdAHGNMhWpWF3CiTG4F59KRonovJN2mbBM3ENKxteHiArBZ+iHJn6kVbwqA1diCa4mn1ufkNPrxMnm5TWW9vT8SpsLrRIsJ0KJKRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947715; c=relaxed/simple;
	bh=s++sO/0HefS+Fbtcq5+v2Ft+DId7YJ+42Qd1JyNZm4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TQgayE4Qe+NlQ45XgFcvql8VkXciE8b+cxvOw1jXNgukv9S2BcIsDJgmYow9wQ62bOc4qgdrEmSDrYUT4tQjDwOsbTEFslKpjaaauxhfwFuYnKG9SgG1LyuzZqyKyANiXumZ9wgoLMn4MeEVlbbq4gHzdVtAOh8UHUbqvA60GwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J3P0BP/3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HA2BK030501;
	Tue, 2 Jul 2024 19:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Xir3Uj77zxkmv8pln5o7Qg
	aaffaJDysv1DFtH3iavbw=; b=J3P0BP/3++pXahySoCJL/RmWyEqmanD3eea2bs
	jpxl4wBeFJ692NzVML9R3SpxAReK4pJJv7moc8HY7y1XBqEokxEO1NSLGCv3gajw
	J2EEAPeVqHjBLFubFLdbZpBvQr4s7qaRVTCqrtKFKUBmWX9dXe8GUbNpyIdWC7QF
	1ZUOWbKwGeP+RTWye/fWMXM1yQu+Gwtgh3ojiIbzpJxi7aGIQX7BT3aYA32cw4Sr
	IQNW94jXVosdUS+h4fZyoTxPMGksBeMh1HfI4kUX89ig+N5kJx5b9cEAc9tPFyNq
	MR/5dNCcxgYDsLQcvIOqUHQTlAzH4SK4YEKZKjaK+cszKdjQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029uxesak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 19:15:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462JF0pK030914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 19:15:00 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 12:14:55 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>
Subject: [RFC V3 0/4] arm_scmi: vendors: ARM SCMI Qualcomm Vendor Protocol
Date: Wed, 3 Jul 2024 00:44:36 +0530
Message-ID: <20240702191440.2161623-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vg1xrHgIBoO5Uc7t3GMN6O2sU1H1fyvk
X-Proofpoint-ORIG-GUID: Vg1xrHgIBoO5Uc7t3GMN6O2sU1H1fyvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_14,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020140

The SCMI QCOM vendor protocol provides a generic way of exposing a
number of Qualcomm SoC specific features (like memory bus scaling)
through a mixture of pre-determined algorithm strings and param_id
pairs hosted on the SCMI controller. Introduce a client driver that
uses the memlat algorithm string hosted on QCOM SCMI Vendor Protocol
to detect memory latency workloads and control frequency/level of
the various memory buses (DDR/LLCC/DDR_QOS).

Generic QCOM Vendor protocol background:
It was found that a lot of the vendor protocol used internally was
for debug/internal development purposes that would either be super
SoC specific or had to be disabled because of some features being
fused out during production. This lead to a large number of vendor
protocol numbers being quickly consumed and were never released
either. Using a generic vendor protocol with functionality abstracted
behind algorithm strings gave us the flexibility of allowing such
functionality exist during initial development/debugging while
still being able to expose functionality like memlat once they have
matured enough. The param-ids are certainly expected to act as ABI
for algorithms strings like MEMLAT.

Thanks in advance for taking time to review the series.

Opens:
* opp-tables are used but they don't get to be added to the scmi device (thus we
  rely on a lot of manual parsing) because the memlat client driver doesn't vote
  on these resources clocks/interconnects/power-domain from the kernel and some
  of the resources aren't modeled in the first place like DDR_QOS.

To Dos:
* More documentation [Sudeep/Dmitry/Konrad]
* Use alternate bindings instead of freq-table-Hz. [Dmitry]
* Prevent duplication of code using vendor protocol driver. [Dmitry]

V2:
* Drop container dvfs memlat container node. [Rob]
* Move scmi-memlat.yaml to protocol level given that a lot of vendors might end up
  using the same protocol number. [Rob]
* Replace qcom,cpulist with the standard "cpus" property. [Rob]
* Fix up compute-type/ipm-ceil required. [Rob]
* Make driver changes to the accommodate bindings changes. [Rob]
* Minor fixups in subjects/coverletter.
* Minor style fixes in dts.

V1:
* Add missing bindings for the protocol. [Konrad/Dmitry]
* Use alternate bindings. [Dmitry/Konrad]
* Rebase on top of Cristian's "SCMI multiple vendor protocol support" series. [Cristian]
* Add more documentation wherever possible. [Sudeep]
* Replace pr_err/info with it's dev equivalents.
* Mixed tabs and initialization cleanups in the memlat driver. [Konrad]
* Commit message update for the memlat driver. [Dmitry]
* Cleanups/Fixes suggested for the client driver. [Dmitry/Konrad/Cristian]
* Use opp-tables instead of memfreq-tbl. [Dmitry/Konrad]
* Detect physical cpu to deal with variants with reduced cpu count.
* Add support for DDR_QOS mem_type.

Sibi Sankar (4):
  dt-bindings: firmware: Document bindings for ARM SCMI QCOM Vendor
    Protocol
  firmware: arm_scmi: vendors: Add ARM SCMI QCOM vendor protocol v1.0
  soc: qcom: Introduce SCMI based Memlat (Memory Latency) governor
  arm64: dts: qcom: x1e80100: Enable LLCC/DDR/DDR_QOS dvfs

 .../bindings/firmware/arm,scmi.yaml           |  15 +
 .../bindings/soc/qcom/qcom,scmi-memlat.yaml   | 242 ++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 138 +++++
 drivers/firmware/arm_scmi/vendors/Kconfig     |  12 +
 drivers/firmware/arm_scmi/vendors/Makefile    |   2 +-
 .../arm_scmi/vendors/qcom_scmi_vendor.c       | 184 ++++++
 drivers/soc/qcom/Kconfig                      |  12 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom_scmi_client.c           | 583 ++++++++++++++++++
 include/dt-bindings/soc/qcom,scmi-vendor.h    |  22 +
 include/linux/qcom_scmi_vendor.h              |  39 ++
 11 files changed, 1249 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,scmi-memlat.yaml
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom_scmi_vendor.c
 create mode 100644 drivers/soc/qcom/qcom_scmi_client.c
 create mode 100644 include/dt-bindings/soc/qcom,scmi-vendor.h
 create mode 100644 include/linux/qcom_scmi_vendor.h

-- 
2.34.1


