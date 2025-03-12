Return-Path: <linux-kernel+bounces-557508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A076A5DA20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0844C3A9542
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AD023C8B9;
	Wed, 12 Mar 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PHpXNVJq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352FA1DF735
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773960; cv=none; b=BSE9yNQUKNyOYLW1+YHMMaFiieHCXVFtAANaaLlWAPbiVoghhccfxPvhdYcjQfA6N7CY9Ze6iOCM84pJnfDfzXG9uy8ay8tYAnt0U+hvIIGIRkfPK+MNalurFMHEXj85UelWoiQoUVXZKu5XdCQCJs9sFsZomej4nYbrxSLo9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773960; c=relaxed/simple;
	bh=TnV6haB5juXzLwYsnjfTeCliML9Uw7ciBtpPk7YGTJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmOpKnxmQcIgYBvUsYdqsOWGdT0V/wUzKhKDPbniO9w01O4qiWcieAnFcQ1TL447aFbzmvDarLZ2wuBvzUjOzeU6iXbOJ0R9hlYNtkE8C5SlvzZUz9x3YFA7ME1RFh9fGe8Tl7wQOeWj+9I+eLwdgA8oGzfnnJeqq1UbP3M9g3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PHpXNVJq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMHFws015808
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HgeWIhIMEhGODE3pVk6y8mTvnaewamGCGvX
	6pDQJFHY=; b=PHpXNVJqqXprA0Vgw+XM7nNbkr16NUZ+BKsPkeG9YOZpBPZoLmh
	M6NqRi800CD44xs1N4FNnjqZV21nFa7j5kEIFw8UwlE5IWyZKVxtpjN1ucAgszsj
	VwIX459kY7yrj4vc4g+v15XxIX7xi0Y2MZZeu9lQGTCsAsQTap4jewJfVLJYt2D1
	5f0XTyFciR1FbJZ0xWUgIVU03rauVX4xdZpDuySP+ERG7KtUCKtDhZ7U5DD0DHtx
	KrFkv4J2UEhrJTyXjy72yHWDRLybP8uLy4AU97FFuBkqqckxiz+RMmdgMNIZ+mlf
	Mml0HD/76/yh8RHBn+6Ny5W9PcIbhSzd61A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nt09a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:05:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225505d1ca5so64239455ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741773956; x=1742378756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgeWIhIMEhGODE3pVk6y8mTvnaewamGCGvX6pDQJFHY=;
        b=sIenRR32tpWT2mFA+cLTUPgDm7eMkFJ6fomZYrNlMZeYjqDb1k+L3n0TsU4kZWIqVd
         rpQkIM9fFWvdVstBJo8P+25+eRoCgnyiJol+XXsjW/OBVujbMlprWdfoY2iHDq0s+0qM
         UitjzsqGFxiOj4KXmbRNbTixvZ67NPj+03aloa+f5dQHXkr4MqWkwnXeeiM2AQa6KOyl
         rktmS/YUYoNNAA8MBhmEkZNJuAoaGaIfYH7WdBGrzcgfcpksk5V0blsFWKJra2YvrrdB
         +2IX5zSjLMYkfUscgWZA29a8WfyOgq5ekQHOSFFSfvKaJPff4+EwTVJeoC2AVzyb7q6b
         Cn6A==
X-Gm-Message-State: AOJu0YwRtQOu7gDo3+PeDdkMWzRoQWnOxD5NqNOQNbTmGqkmhhmsTrEr
	srUti/zSjfmNbt/DCOVJtA7REOucU0Zk0dPsapE+HTMEqGAmrbjqRaSNmS5RjPFlsViCdwzRaCu
	9X2vxMjtApwvmqBtZzOPUgJ+/W+QMSWktVWpCXzZXe/dQqv+Jas6g7AqVuxq22OI=
X-Gm-Gg: ASbGnctAoc/vwSMu3D87Fdsfh06QPt45lCCOCwZCSbfWrAwAnQ0Rhz9Pb4y5xxWuP60
	8dniNN2bimzdXhU9P8wA5mrHaQ8TvUojA2TZ8Raal8wxoa7p73n7Dh6d+eXaZ1FVIAvsLesxyuj
	SOltYkbANA7/We21XSe7ojLJZL/VZ+fJA8VIdCJCWjat+rs+vNc5rdMQBq1DEocn/+KURaoluCq
	InujSct6TEreER5S86dgtZM324XYtqTl/I5y8M39iVm2ZK/OHoYn3599O5tE7zBsENcktG/InGO
	AuYJoiOtzrKHOSed5veOb1gS79kluwwjqA3ikRXREjupPekfnexO6Q==
X-Received: by 2002:a05:6a00:6c96:b0:737:9b:582a with SMTP id d2e1a72fcca58-737009b5927mr2847416b3a.24.1741773956423;
        Wed, 12 Mar 2025 03:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrpFM9aC2Ybs7x0lcdpTYriXhI+a8LEqu97S/o5XlAYzlpGRhYyyTMTdxU6ktmIfaIwEj/Wg==
X-Received: by 2002:a05:6a00:6c96:b0:737:9b:582a with SMTP id d2e1a72fcca58-737009b5927mr2847376b3a.24.1741773956090;
        Wed, 12 Mar 2025 03:05:56 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ae7d24ccsm10023993b3a.48.2025.03.12.03.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:05:55 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add orientation gpio
Date: Wed, 12 Mar 2025 15:35:44 +0530
Message-Id: <20250312100544.1510190-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 559Z0RtCSeJg7KWdlZfIBooUOiXCz1nX
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d15c85 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=76Bs7J6LVpVJVXfC1mgA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 559Z0RtCSeJg7KWdlZfIBooUOiXCz1nX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=888 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120069

Specify orientation GPIO to the PMIC GLINK node.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index fa7c54f882a4..e6811a094332 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -177,6 +177,7 @@ pmic-glink {
 
 		#address-cells = <1>;
 		#size-cells = <0>;
+		orientation-gpios = <&tlmm 140 GPIO_ACTIVE_HIGH>;
 
 		connector@0 {
 			compatible = "usb-c-connector";
-- 
2.34.1


