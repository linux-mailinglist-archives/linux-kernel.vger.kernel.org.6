Return-Path: <linux-kernel+bounces-186233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E164A8CC164
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDED1C20F62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090B013D88F;
	Wed, 22 May 2024 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xFGJOtVJ"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26031E86A;
	Wed, 22 May 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381640; cv=none; b=aPABygZanlsB3w7JtAqReBaozKztEoIRqXfwCdl4aB92qZfV7L6WznNMcIALrW6kvDbC1asaVJmygi0Al0gjEX192ZlPQaIFbFnskGEMbj57ZG7SSxV9o9xvtN3LL7XEY2XxrcJqj7kahyYSLyMiSu4lF3c1o6nN/VLgRWhq3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381640; c=relaxed/simple;
	bh=IfG3RHXkW4JSPOanJyMBO2lrbHRFR6VeuhTp2u5hy1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cAhoioMiA6SXLvmRMVsokmLcuxsby1axGshZH3lPERu7oGCkJ28pPLKAtUte3oiOE6rZw1jK6ljqfACPCfxaIhcwlZfy79P4be+Tb8uyqsofAamhvNJkmeKplbGMTAf3SyMgwnViWsOxbzP2EN34y3DnnD5ocA9KZjoo7WvOurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xFGJOtVJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M8dZH1002026;
	Wed, 22 May 2024 08:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=S0Ia/65eDrvO
	FQmfhXwtzZNwxc3xiApTo4g/E+SYWxg=; b=xFGJOtVJeXM10Zhn12f6styiyYb5
	bGbWywmnJDRzWVBXyzRIeYEPXl1tqr50fCpOovHGpSqUHXkC1QEOUugtzpqHLffV
	TKvmQnnkX5fdMf2cBLAomYpSm/aoJJJ5/8QGptV6MIcCL4Ou6iVLVPNjPeRCQHZe
	Kx6lR9Xumjvniy5U95gxSxVapKIvwb0f2aSozap5bkopn7epUqkF6HyeXyHvWATs
	2efQlDY0fV9OMWb1Xe7/opBsXvyWXvZHB7USD/qkjEPIU0owsgqTZlhVxkeso+as
	rdwxua4oioFax2FF3J8wU4mzhvZargJyfkkpLhhXhsDZBbMEyDYqMggO6w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3y9dd00qhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 08:40:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 44MCeNLx013940
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 08:40:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 22 May
 2024 08:40:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 May 2024 08:40:22 -0400
Received: from radu.ad.analog.com ([10.48.65.150])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44MCe7Ia005879;
	Wed, 22 May 2024 08:40:13 -0400
From: Radu Sabau <radu.sabau@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>
Subject: [PATCH 0/2] Update MAX31827 driver
Date: Wed, 22 May 2024 15:39:21 +0300
Message-ID: <20240522123923.22320-1-radu.sabau@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: r6Hu_xdtcKgTA-tU_ONXQLnX0KTJO8AI
X-Proofpoint-GUID: r6Hu_xdtcKgTA-tU_ONXQLnX0KTJO8AI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=870 suspectscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220085

Add PEC support for MAX31827 by inspiring from lm90.c driver, hence
creating "pec" file and attaching it to the i2c device.

Add debugfs support for MAX31827 by creating max31827 directory in
/sys/kernel/debug/ folder that includes debugfs files specific
for configuration bits in the configuration register that one may
want to use in order to configure the chip in a specific way.

Radu Sabau (2):
  drivers: hwmon: max31827: Add PEC support
  drivers: hwmon: max31827: Add debugfs support

 Documentation/hwmon/max31827.rst |  38 +++-
 drivers/hwmon/max31827.c         | 297 +++++++++++++++++++++++++++++--
 2 files changed, 317 insertions(+), 18 deletions(-)

-- 
2.34.1


