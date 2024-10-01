Return-Path: <linux-kernel+bounces-346563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE398C5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2665A1F22D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AF1CDFDD;
	Tue,  1 Oct 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B0mZyIWG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D71CDA15;
	Tue,  1 Oct 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810314; cv=none; b=gH6D8s+1xwRFhI7TSQa473Em4BYFq+ONwofq3sUcUPtNLHSfL5cyvPa33Mo1x+tWX+JkqWKCXVKYhuTw8D0AGWPHFQeq+73/Xf/tJsq/0chJgtFwExS8fc5Wp3pDmGI1oJwkAiXacbjH7ESPuSg1CAuN8FNgHuc+HiPH0lqNM4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810314; c=relaxed/simple;
	bh=sJh0pZAWahhBxueYaHF1Ta1B7FtNkrCqIjHpu2E1YsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLXFaIURclphTdsn57nWej2sqxyyd+REaCAhtw8i239bOB46jItTHsc973a285x92G3CNJ1q7Olj0+eYyi7AfF+Sf/v5OjtjgrLuU9agwCjuFXkXGj0FtAQzRvCRng+Lal9Luy66LxFealTpUt38wurOMBtHapfllSVlcLpiYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B0mZyIWG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491GLoNj019766;
	Tue, 1 Oct 2024 19:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=jCNt0CizZjZ00
	jxp4ELdZxLVqqIWl3GZ609i6rIQxbs=; b=B0mZyIWG9lYJW7Ly2MvtJRBsBAK9l
	O/FrkdmaTA44Cyz+aZaOc71HC7kJapfvkLqCNweV47nwPqSIi9YY9socdt/hFwnz
	MO9xNSGxVX2ag4RcIPrsN9beQgouBff47ZuUc/9qWxb2S7/or4ZlQ1i6k9Cc8GYv
	BqBhAsSAa1mquz74/kYVR++yX4FcEHiKne5U5sQ+bVU/jRpD7vNG26PUIhXwnt2G
	5hg22AEtKs+Kd4BGOsIvTdWXxw4wYoYIC5ef1V2+BRXZruY2FsiiY/QPPY23MOcQ
	+Cwj53t1cmWlTC4DMll6lEGvKEpWPdhR2fZjzGqOXX7wPoaxz5bL4Qqmg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420mhdrue4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 19:18:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491I9ZZr007994;
	Tue, 1 Oct 2024 19:18:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxxe45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 19:18:11 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491JIAuX11207248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 19:18:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 195275804E;
	Tue,  1 Oct 2024 19:18:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7461E5803F;
	Tue,  1 Oct 2024 19:18:09 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 19:18:09 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, eajames@linux.ibm.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] ARM: dts: aspeed: system1: Enable serial gpio0
Date: Tue,  1 Oct 2024 14:17:49 -0500
Message-ID: <20241001191756.234096-3-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: Oi2ttzEgZtQnkTKh85OYLwQWJHCri57Y
X-Proofpoint-ORIG-GUID: Oi2ttzEgZtQnkTKh85OYLwQWJHCri57Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=675
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010125

Enable serial GPIO0. Set number of GPIO lines to 128 and bus frequency
to 1MHz.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 1cbf257fb0a0b..c0219167a337a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -398,6 +398,12 @@ &emmc {
 	clk-phase-mmc-hs200 = <180>, <180>;
 };
 
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+	bus-frequency = <1000000>;
+};
+
 &ibt {
 	status = "okay";
 };
-- 
2.43.0


