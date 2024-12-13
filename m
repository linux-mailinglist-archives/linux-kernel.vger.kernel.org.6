Return-Path: <linux-kernel+bounces-444986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D39F0F91
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F102836F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742EE1E22E2;
	Fri, 13 Dec 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZwHM5D8H"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD638F5E;
	Fri, 13 Dec 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101460; cv=none; b=KLo2wDhN+Jq3twVxpvoOEgJDtc+W3FKj7HnsKBZK+xIskvIe+yCdCzplBO2QnoT3S6sy5drS9X4n+cEszXQBHYyb3nuc0g1S12qeupID+XYv8JhsmScgGUeue5xiKiDwuu8VukT3AKIfok0FOM2uf0yN9quQ3i3EbLGG5BntYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101460; c=relaxed/simple;
	bh=5lwQbSH38wZaBBNVJpvu8A3peHeptmxZiQ7/+fD3jWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maDbij1PgpN0Q5rYpXeKDtWANYwk2JwlmzBiAXVaCME4zVh9SM2AUHh78oxLlxdT+ltzkXivun4nKnMdzKBjB1l7zHZ4Rmz9xzk+OLwb6GKfUHb7YCBNAg7N+GSwCPc5oOPN9eeNbQ5bcIA44Qjj+qZF8JngVjH/4IADfA2Lo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZwHM5D8H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIvoh022063;
	Fri, 13 Dec 2024 14:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1A4o9TJk57MA+9zwL
	E6hTD2yisDJsgIjNaPzNrZQc3g=; b=ZwHM5D8HRQ4PKG7Szss0SzWQ5KYiVCfcW
	1mfm6sFO6/AdDWM9nHhjWHwS2HNOfPsJf6q34dRP++MYyaZzVRoN/jnjW9Rm2Wu4
	Je7uB8+0ERCwouuWcGulSLQeYFy3EiURmkpj+lowH7EcoVtiVBq9w/t0NIuh+Xs4
	gONTNgvxmPUAHtHiRLGYeNSlhvQd1zk3KQon+agCYxSytihL3AkteHhdPHoK3eEb
	lDns8pxyFX1ywx6pwaXP9wk2l3uZEzIfttpTCZUX9hj4sr5wSy6Pt8NvBxEHHhD6
	eaeE/fNMXtCrhAIoonxzg3pH/Jnb71npmhL5BMcBV8pDcw2saPp5w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhkm5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDC5lK1016926;
	Fri, 13 Dec 2024 14:50:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yphgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEofnc37159360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:50:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 106275805E;
	Fri, 13 Dec 2024 14:50:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E50E58050;
	Fri, 13 Dec 2024 14:50:40 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:50:40 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, ninad@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: NINAD PALSULE <ninadpalsule@us.ibm.com>
Subject: [PATCH v1 1/8] ARM: dts: aspeed: system1: Add IPMB device
Date: Fri, 13 Dec 2024 08:50:27 -0600
Message-ID: <20241213145037.3784931-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213145037.3784931-1-ninad@linux.ibm.com>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fKRPsI_CUA403YpcABO9Wt2nvZdUH5no
X-Proofpoint-ORIG-GUID: fKRPsI_CUA403YpcABO9Wt2nvZdUH5no
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=758
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130103

From: NINAD PALSULE <ninadpalsule@us.ibm.com>

Add IPMB device sitting behind PCH module

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 8f77bc9e860c..51a116d7041a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -763,6 +763,16 @@ i2c3mux0chn7: i2c@7 {
 
 &i2c4 {
 	status = "okay";
+	multi-master;
+	bus-frequency = <1000000>;
+
+	//Set bmc' slave address;
+	bmc_slave@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+
+		i2c-protocol;
+	};
 };
 
 &i2c5 {
-- 
2.43.0


