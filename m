Return-Path: <linux-kernel+bounces-202884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1AB8FD277
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC20D283438
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD6314E2FD;
	Wed,  5 Jun 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lyht5d96"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064A19D885;
	Wed,  5 Jun 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603589; cv=none; b=GIRyti3ppnHY9hBS/+6x1WxliFTf1e2dG9KVYQpnzh5nyTJ+7hALmz/gwQb5rnVocnSrMklDLjDbQurKgP84usSwbrl+vpak69BhD99hUF7YCTYS2Gan4XsKbkuS+VQSV8SfPaPeccp9sjs6peMSqTwgw4BN0hJhr29OUWkLeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603589; c=relaxed/simple;
	bh=c6vNyBQnYsxch4NsLDDxIrLHn3q0jsFIoVqhAcP61JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tA/DsTYyynQvjeeE+C2FrIh7KLJmIevG5E+KsOaq4Hg88oJWddcyLVECadO2QLsH0cFZheQwyXb5lOy5BNz1pxgTRwWWN7HK2RVfXs8H98xxOYaxFljLcKK7FZBUmm+OrAxZ5Dc+yZii8HXtFT3cKRL4UTtL8V/i9pwABaBNnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lyht5d96; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455FLLtb001160;
	Wed, 5 Jun 2024 16:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pp1; bh=v+Cqnls3yUZrDxsNB2rWFncZXsXnB7uHdf9VD8hEsY0=;
 b=lyht5d96JASQPfISXc+mnGdxkM0CUCo3xOeooBfLIk9yEw2hAQUxesQ+hGZ2JQl8/Qm0
 K1RhBosoHbYLtNIPRimhunmlC0KFaa2tyArmuXebAlIy/fswZjSh/Tdi5uyIRoz6qBKy
 w6wijkffTFur2A5kTUgYvebCaoLkxXdEVrKcEQ0GA04vLpYE0ZGSFJTBOPkOsJKpvd9x
 jUaFXGtjWjBzZZKCD7eugv8g7D5aYOsK1IKnG8RudaTy8Bys2KmY7d+2cIjuqQerbAmB
 gdR0LRz0RPWZ7fg8JTPBcPZIYm4mYuGXkT2YkR1x5T6ahTczbFMmQFBve+kx3BpvJ5RE ng== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yjrdw8m5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 16:06:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 455Ew2SN026588;
	Wed, 5 Jun 2024 16:06:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yggp34mg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 16:06:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 455G669q26673716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 16:06:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFDDA5805D;
	Wed,  5 Jun 2024 16:06:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F262A58053;
	Wed,  5 Jun 2024 16:06:05 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Jun 2024 16:06:05 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au
Cc: Ninad Palsule <ninad@linux.ibm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, eajames@linux.ibm.com
Subject: [PATCH v2] ARM: dts: aspeed: System1: Updates to BMC board
Date: Wed,  5 Jun 2024 11:06:03 -0500
Message-Id: <20240605160604.2135840-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hM30ZomYcFZDZdrHlvxUQsvKPqP2flZC
X-Proofpoint-ORIG-GUID: hM30ZomYcFZDZdrHlvxUQsvKPqP2flZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=682 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406050121

- Changed temperature sensor monitor chip from tmp423 to tmp432

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index dcbc16308ab50..f3efecc7eb8d0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -1138,7 +1138,7 @@ i2c8mux0chn6: i2c@6 {
 			reg = <6>;
 
 			temperature-sensor@4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
@@ -1599,7 +1599,7 @@ i2c15mux0chn6: i2c@6 {
 			reg = <6>;
 
 			temperature-sensor@4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
@@ -1615,7 +1615,7 @@ regulator@40 {
 			};
 
 			temperature-sensor@4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
-- 
2.40.1


