Return-Path: <linux-kernel+bounces-569211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10067A69FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83C11725FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550011EE004;
	Thu, 20 Mar 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BHDkWBRZ"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD381E231D;
	Thu, 20 Mar 2025 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453676; cv=none; b=F8Mgkmpq7Iz7aoFg4QLo1tZ+fbweZzDgAy19DUrXn3iQuVQxzJWX9/RizDtq+QGtrjBjOI7l4Yu+80wrkMBlUUbKh6gCuUnoPyPciSHTSIr4rU0hLB73hSvzSzR+6EkkTlrQtWPs6a/KWHvMYve3tUSo1l0qR/HdOBgcQYtjkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453676; c=relaxed/simple;
	bh=zDC5ZRV3yHjjcZpr5FNPmLE2KEyDAiWOjTtrUcZ56Bw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=N7XmD35DXq/b/TMhz45SSYqH4sG+/MY8EQWRHhDZZptYVrYWxaE3tSUzoTnfEXrgPu5PKHivOPAWof7jWqBbOjwPKDjdMGxnejRw6R22nZkjbi2T+MmOHc0km5x5fYYY5pOkbmwZGipQEnMl0PFHVHFyyHHs8OMKpXxQMe16E98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BHDkWBRZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K3TYgV003609;
	Thu, 20 Mar 2025 02:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=4Qm2J/OaM2Gsz4IL67t6+iu81Wt
	/t0U8DU3qdhuK8nY=; b=BHDkWBRZGzhGH9zC9+Emb5WLPdIr5auC3gvzklscnn2
	6MKSDueTWof+I8hGbY+dQK+fp82ltlAC+tuN9gHVvO0qPHBUjPUtSuIPF4oKFdYy
	GDSXplW2tftVRtCZswEC+g7+1fjCmcwRhJd6PaWPFaOS8drY9GvHtFlLbuDljQy0
	eg1XdZmcxqwEUJsz+JmmHWHEV8rivLJNSqOTcbyGoImeaSnDqlMj0d0hmu0ot/IQ
	XqRjBOy9Ne3ST9/UJyJabdvPC7vgoxM2uHwchKSHVRm7rilqWx/vW+YS8fTxzKSY
	BqI6vHss+RWKh9dXH+rhTfJZjcDiM0BqW22Xgmu7M7Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45ftbrwxr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:54:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52K6sHdE060167
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Mar 2025 02:54:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Mar
 2025 02:54:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Mar 2025 02:54:17 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.117.223.3])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52K6s5en006548;
	Thu, 20 Mar 2025 02:54:08 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH v2 0/2] Add support for ADP5055 triple buck regulator.
Date: Thu, 20 Mar 2025 14:53:53 +0800
Message-ID: <20250320-upstream-adp5055-v2-0-aac2d3705802@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIG722cC/32NQQ6CMBBFr0JmbU2Z0AquvIdhMcIAkwhtWiQa0
 rtbOYCrn/eT//4OkYNwhGuxQ+BNorglA54K6CZaRlbSZwbUaDSiUS8f18A0K+q90cbkfLBFi0N
 TV5BnPvAg70N5bzNPElcXPsfDVv7aP7KtVFqRoctQc2Wb2t5ooacbz52boU0pfQGXIafmsQAAA
 A==
X-Change-ID: 20250225-upstream-adp5055-adbe6262f984
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Alexis
 Czezar Torreno <alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742453645; l=2382;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=zDC5ZRV3yHjjcZpr5FNPmLE2KEyDAiWOjTtrUcZ56Bw=;
 b=4uR5gwDechs0QNAMPgBtsVcE5u2iLNX16U8H7CkVullkKGrgxo6qZukxQJ7L4G734P9idKKMo
 oufK2yoxrhnB7YyUDIM3G7PYuHU8tzLEW+Rd/JvdOao6vxMXH2SBfyq
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vKNNeXqOCkre6SZ_I9gk3ItWW5Kx5L29
X-Proofpoint-GUID: vKNNeXqOCkre6SZ_I9gk3ItWW5Kx5L29
X-Authority-Analysis: v=2.4 cv=Qs5e3Uyd c=1 sm=1 tr=0 ts=67dbbba1 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=lAPpY2re-nV465j7mocA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_02,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200042

Introduce a regulator driver support for ADP5055. The device combines 3
high performance buck regulators in a 43-termminal land grid array
package. The device enables direct connection to high input voltages up
to 18V with no preregulator. Channel 1 and 2 deliver a programmable
output current of 3.5A or 7.5A or provide a single output with up to 14A
in parallel operation. Channel 3 has a programmable output current of
1.5A or 3A.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
Changes in v2:
- Kconfig - fixed indention problem, occured due to using spaces rather tabs
- adp5055-regulator.c
  - Turned initial comment block into c++ style, using // per line
  - Merged the similar read/write ranges variable called access_ranges_table
  - Set max_register value correctly to 0xE0 instead of 0xFF
  - Fixed issue where ndescs was an error code. replaced with -EINVAL
  - Enable/disable ops functions, now use helpers like regulator_enable_regmap
  - Added config.ena_gpiod for the regulator config  
  - Used of_parse_cb to do per regulator properties, new function added
  - Migrated some yaml properties to the core regulator function
-adi,adp5055-regulator.yaml
  - Moved property power_saving_mode to set/get mode under 'IDLE' mode
  - Moved property output-discharge-func to core func set_active_discharge
  - Moved property enable-delay-us to core function set_ramp_delay.
  - Removed property disable-delay-us, as suggested to not worry about
  - adjusted sample device tree to match changes due to use of of_parse_cb
- Link to v1: https://lore.kernel.org/r/20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com

---
Alexis Czezar Torreno (2):
      dt-bindings: regulator: add adi,adp5055-regulator
      regulator: adp5055: Add driver for adp5055

 .../bindings/regulator/adi,adp5055-regulator.yaml  | 161 +++++++
 MAINTAINERS                                        |   7 +
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/adp5055-regulator.c              | 480 +++++++++++++++++++++
 5 files changed, 660 insertions(+)
---
base-commit: 7fef39f0e82ff02282797d9ae2589b39b16ab614
change-id: 20250225-upstream-adp5055-adbe6262f984

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>


