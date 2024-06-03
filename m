Return-Path: <linux-kernel+bounces-199570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29F8D88A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0051C2348B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C6139D09;
	Mon,  3 Jun 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lGEtJFo+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203F13791A;
	Mon,  3 Jun 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439595; cv=none; b=Li7rn1V2PUTAR2qHLblcI13rf0SzQCc7vdP8VgrJFVTy6R7DK5JrebpUf0tEu/IoEfX/z9Y2GMpNjEvDPdf/gNL7H8B8W69bN3TZI5/SnBUh19icjvOQpaPqjjP4/4CHKBCADk7Prj4fmetREZIsUsBPG8+y72sZyhGaNiTAzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439595; c=relaxed/simple;
	bh=z9OG0rGlDMMNgbj7ZWonTU7Gl7/Rke3ruI8BwO2c/Fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=rhMzIcAWRJcaSyhDNvyd1rg3yv6OfftxSjnIZnfQAgo5Hd6STGyK+khaZcJaUig53BLjXzAK/BgugKzXea3GLvmywYqL2b3yXxmXk9ss4gtS8+Wb8ieQVZy3jsjhXlQ7mI1y1PcT8o+FUDhUkeIJ9fwIN7HAunUBmC5e3VhSmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lGEtJFo+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453CUN2T029983;
	Mon, 3 Jun 2024 18:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=H893BLcXtVS2grWRtE4rl+
	b6Y75bt8k59HC6jwbX5Zo=; b=lGEtJFo+MqyLAd5E29hBYUKP3OBkqTwipSRqkL
	WdixfPWTZu2fT98Plixhe5yX8lAQGNiVDQ4HsIwDT25XPmgYFqBNQH7ANDKA8Li6
	yVFoL8n0rb/EV5Pkf+Lu8gaNVlWlgE3CHEFgVoMFHHfM3buCOvjqHJ4uFXgGWXUY
	Y4Go8b4jEQH6qLgGJC9QWEfif9h/Ir28myWM+kpPG68jd7pKiwbQArRSD63b30Yn
	gnqZ+ulfSpT65C4VGkIqdUlO8aQIu3JUd+NHDz+IY1/KqvqvHqJQdZ99Q4TjCUK7
	oHVO2N05+gPgw+gt5kXzL5iieYK+gprraE6EGZpeD2/MGiJA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw7dmphf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 18:33:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453IX5cS013087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 18:33:06 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 11:33:05 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 11:33:05 -0700
Subject: [PATCH] tlclk: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-char-tlclk-v1-1-d395aa93da86@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGAMXmYC/x3M0QqDMAyF4VeRXC/QqTjZq4xdpG2cYbUbqQ5Bf
 PdFLz8O59+gsAoXuFcbKP+kyCcbrpcKwkj5xSjRDLWrW9e5BqeINijOKaQ3Dn3nomuovfke7PN
 VHmQ9e4+n2VNh9Eo5jEclSV5WnKjMrLDvfxce9C5+AAAA
To: Mark Gross <markgross@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lxz82xNcl4tshzdlpPe2tHTNSD0mdjqv
X-Proofpoint-GUID: Lxz82xNcl4tshzdlpPe2tHTNSD0mdjqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030151

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/tlclk.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/char/tlclk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
index 896a3550fba9..377bebf6c925 100644
--- a/drivers/char/tlclk.c
+++ b/drivers/char/tlclk.c
@@ -47,6 +47,7 @@
 #include <linux/uaccess.h>
 
 MODULE_AUTHOR("Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>");
+MODULE_DESCRIPTION("Telecom Clock driver for Intel NetStructure(tm) MPCBL0010");
 MODULE_LICENSE("GPL");
 
 /*Hardware Reset of the PLL */

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-char-tlclk-f860d03a47b8


