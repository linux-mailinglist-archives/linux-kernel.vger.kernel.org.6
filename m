Return-Path: <linux-kernel+bounces-269899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D2F94383D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533731C21840
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BB316C875;
	Wed, 31 Jul 2024 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YpUDFfX4"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A683D1AA3CC;
	Wed, 31 Jul 2024 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462500; cv=none; b=QtTxmienGRGNIXlqHiyzeXgQkdfPnl50sEoKIuoita2cZhX/0l8WwPiK5HfCt87ptsjhlVGHmHOgXkQ8GNyodINB4FgdXdo1B170Z7wGYYak9MJuwiY0UMT14wkV1G90clKdxm2s9bFc9ATF5CmLCKPda3d/idGhociu3O4Ab7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462500; c=relaxed/simple;
	bh=vr1mIW/P/zch5hcYNAgu6dsy6kVfvRcs/Z31WWStMSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQFI2EXEbb0fxpkqon0VUfveBQRhDDs39llSkKkKeJqKP6/zryVQAZ15LVErHCbnaq5I1+Rpu8fbCcDOUy+rY2I2L3R6fZSNHGQzNd0Z9nYHzOh7guGrcES96wFw5H3FVYvIOUTMPgGMyG9BEAl4fR6BfGO9aBAOnGdoEd/8FRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YpUDFfX4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VKR9dg026323;
	Wed, 31 Jul 2024 21:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=B+3PjGiYKpJ0UVYq+Ea0wzBeuF
	NwN7n2LlEpIGeUN7M=; b=YpUDFfX4ySUaGIP3rzxx+VDpibCWTzQvDPn8rpeBgw
	JJZ0Qyyi/Jj+OhKvA3MI1Q7p/qLKuqeteac46NJsKYimSCS3O1A9lYM9x6/y1tdK
	JDl1KmKog8JeTe13eWWKDGS85khba5b7ulZ6hMjIG/LXkotC3tTfJwPwIxVgRnGr
	XQhR13LdlAsHFodM9rfbG9plVQjWNLDRWc5jBduEf//CAvHbSQhi1OV0IiUd3Znw
	IjdREcyj/q7/qpilK9xh5pARdrd2yr8YNOkmaOKhp8SwyA+CTVZ07rLsY7aLf+C8
	8O7jiCnSkJ6gpsTPIeYA7iVnrNGzDYnt4zC9Z6ovKOYQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qnbx9mrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 21:47:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46VLMSPI011295;
	Wed, 31 Jul 2024 21:47:46 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqmx53d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 21:47:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46VLlgLj39059926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 21:47:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9612158060;
	Wed, 31 Jul 2024 21:47:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFCCA58064;
	Wed, 31 Jul 2024 21:47:41 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 21:47:41 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v1 0/1] ARM: dts: aspeed: system1: IBM System1 BMC update
Date: Wed, 31 Jul 2024 16:47:28 -0500
Message-ID: <20240731214737.986010-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2hln8jMhynt7M8DSt3gWFVX9NfqkLq6a
X-Proofpoint-ORIG-GUID: 2hln8jMhynt7M8DSt3gWFVX9NfqkLq6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 mlxlogscore=720
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407310150

Hello,

This patch only applies to openbmc/linux. The max31785 pmbus driver
changes are not available in the upstream yet. I will try to send those
changes upstream.

Ninad Palsule (1):
  ARM: dts: aspeed: system1: IBM System1 BMC update

 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

-- 
2.43.0


