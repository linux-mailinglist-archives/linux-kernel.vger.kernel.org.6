Return-Path: <linux-kernel+bounces-397877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2199BE1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62719B221C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078CE1DE4E9;
	Wed,  6 Nov 2024 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="db4YKDwC"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408B1DE3D2;
	Wed,  6 Nov 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883841; cv=none; b=iTcRW4E1bIkAgXVqKGzWziw9grMDI3O3IE+C2YBYextDMg9cfh45gJuTfoTz6VIzbD7VdQjYGIlP1q6nvIbwojaHxFMS5QE4ogDtkftqXclc6CQJK2pb7ImAoIFJC6rMrjP0KD+z3Hn2dPq+hwUkaolP1y3b+i7xTbgKkd0+Kls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883841; c=relaxed/simple;
	bh=Bpy069ACzgc7e7Moyha828kZ71GmAEXp8ONHRxpvlag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dc3DcAFVaIOoH2mTWBTf3K936xBi+i/DjCa0mpkHgRA6wm+tegfXIV127v3NwMkV9afFIgU4+hh89PuLpyr7wnyFAMlAJewUy6BaZ5ZERfhXWuD8BfcM9pVC4FBTI8eIRdrfpcfHVjJGK5CxJdvZbY5qjLPD2kBeVwv1EJh0Z6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=db4YKDwC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A67q3sG006663;
	Wed, 6 Nov 2024 04:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SO/j1
	7HAPPvNkemEtM6dBfKDRozRSFU0Ql1OyvSW1Zw=; b=db4YKDwCBSMYZN4FWjteR
	tIwM2SMEaXGBB4JOOtDtovYUHsyr/+NaT9vnPzGjFV68V6DNxw/uGW7cJ+wzvEk5
	svycm4LSxs7UiZpFBKNs88w3DX9XjLPSTCe0Vf1BVmCtYLi8Pq4X5r/c3GBHewSi
	qSfaD+8uCre3xvjzPg0YmsXwiHsRs0/Cr47gqqUR+PcLMBHp3oYfP82+S2Ekv0vK
	HzZlPjsY8p/6sAfclvSdqT01v9bnCdhFlJAymROFtnY8Cwfb7aw5OAtyEf6feSul
	wVFIgoes4QD7jZA8tmWZTG/BLNwZAllyXpvP8Ggusd+noLRfzq+FT/XbYkCMG8xp
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42r4eq89hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 04:03:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A693eN4025336
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 04:03:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 6 Nov 2024
 04:03:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 6 Nov 2024 04:03:40 -0500
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.116.44.137])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A693GTD006260;
	Wed, 6 Nov 2024 04:03:32 -0500
From: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        Alexis Cezar Torreno
	<alexisczezar.torreno@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] dt-bindings: hwmon: (pmbus/adp1050): Support adp1051 and adp1055: add bindings.
Date: Wed, 6 Nov 2024 17:03:10 +0800
Message-ID: <20241106090311.17536-2-alexisczezar.torreno@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: NHAQiB_jUTGrv5vKSkAZ1P2w2_7grV-P
X-Proofpoint-GUID: NHAQiB_jUTGrv5vKSkAZ1P2w2_7grV-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060073

Add dt-bindings for adp1051 and adp1055 pmbus.
ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature

Signed-off-by: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
---
 .../devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
index 10c2204bc3df..88aaa29b3bd1 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
@@ -10,16 +10,24 @@ maintainers:
   - Radu Sabau <radu.sabau@analog.com>
 
 description: |
-   The ADP1050 is used to monitor system voltages, currents and temperatures.
+   The ADP1050 and similar devices are used to monitor system voltages,
+   currents, power, and temperatures.
+
    Through the PMBus interface, the ADP1050 targets isolated power supplies
    and has four individual monitors for input/output voltage, input current
    and temperature.
    Datasheet:
      https://www.analog.com/en/products/adp1050.html
+     https://www.analog.com/en/products/adp1051.html
+     https://www.analog.com/en/products/adp1055.html
 
 properties:
+
   compatible:
-    const: adi,adp1050
+    enum:
+      - adi,adp1050
+      - adi,adp1051
+      - adi,adp1055
 
   reg:
     maxItems: 1
-- 
2.34.1


