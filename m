Return-Path: <linux-kernel+bounces-346561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD898C5EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A17A2839C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7241CDA17;
	Tue,  1 Oct 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MYpZ+Xps"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9191CCEF6;
	Tue,  1 Oct 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810311; cv=none; b=YwQNDkpuBHkk90Q93od4+3jZfkswgvMLXMT4LyASBG5KJflUhqWdShrhH5I7I3Ujmcu+GkCgZvU/mJFgtUZhsZ5bavxaWWz9yo3WLEUzILBf6kFbGq5BQQAhv+KQGwi4IF6OTC6SyjMesBi6z4PnsZJntjuAIlMcNg88ndqQU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810311; c=relaxed/simple;
	bh=OO9irAEkgK1EHkt34hz+DQH0RC91+tsJeCWGkaaKiwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaHzDtYxermzVXl/tzEGVJ/MyT1mH+LCdK24iAiyqkVuker41Bqxswcyj8DUIht7m3T63zo9xMWUdhaIR1pjgLW+c0w3hFOZMJmNYwOf0O+1I8V9H6uhyiPNkh84wygiEzWtCrBv2vjfogHo3/WoQOtddxtZ85/UzKQmEwo6QZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MYpZ+Xps; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491JHBKV011701;
	Tue, 1 Oct 2024 19:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=mD/5D8Eo+dQm7
	ngs61A8LO8bCXXX9Bs+h1+t5Sfk+W0=; b=MYpZ+XpsXViBh6zZJ+2qfCJl1tb5U
	Vv1URxvUHKNDFjJ3meBygltjss0pop7dGWtZgctqFM6LgdXpRVulzHjli5vtrkya
	yxp4DYDq0T+NNWxvLfw/fvj6wB64b9Y3KEZe+3r7IZ3mVn7yudreTALydxsgB2YQ
	Jn6Uj6PgFFbWk/sllI47LidK0w0Gx1BwoZGQuFeP+Oq88bdL9uTa0AUu1gznOOVX
	98YIqD1oDpXq8jzv7KTsFPIRk7PZfZHmuX1O5SFNR1x/TihVFSM3516C4pawJrph
	y6602xy5oui8YcEqouCD6fTiqqly+Ucy5L5gk++1aP9jLmkCcdHyeWQPA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420q3p0048-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 19:18:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491HwQvc007989;
	Tue, 1 Oct 2024 19:18:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxxe41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 19:18:10 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491JI9QM21693166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 19:18:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4246C5804E;
	Tue,  1 Oct 2024 19:18:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CCF25803F;
	Tue,  1 Oct 2024 19:18:08 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 19:18:08 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, eajames@linux.ibm.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] ARM: dts: aspeed: system1: Bump up i2c busses freq
Date: Tue,  1 Oct 2024 14:17:48 -0500
Message-ID: <20241001191756.234096-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241001191756.234096-1-ninad@linux.ibm.com>
References: <20241001191756.234096-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jDzzMLugSTVAW0G0J-KeCi0oVSDN59jr
X-Proofpoint-ORIG-GUID: jDzzMLugSTVAW0G0J-KeCi0oVSDN59jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=694 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010125

Bump up i2c8 and i2c15 bus frequency so that PCIe slot and FPGA runs
faster

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index f3efecc7eb8d0..1cbf257fb0a0b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -1007,6 +1007,7 @@ i2c7mux0chn7: i2c@7 {
 
 &i2c8 {
 	status = "okay";
+	bus-frequency = <400000>;
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9548";
@@ -1468,6 +1469,7 @@ i2c14mux0chn7: i2c@7 {
 
 &i2c15 {
 	status = "okay";
+	bus-frequency = <400000>;
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9548";
-- 
2.43.0


