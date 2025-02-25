Return-Path: <linux-kernel+bounces-530849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C3A4394A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF4219C268F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5892266573;
	Tue, 25 Feb 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1xsRNF2J"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DB265CDD;
	Tue, 25 Feb 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474924; cv=none; b=FM+aH3Jmr9Wc8NZH+IK1MUBSNQ06LMww7hnvVVQjZ17WyHZDdN0xsIiv+wJg67isva5MSm5A7MMQbPJJLIeXlUGDrhfbmr6B5tR9+jLU9AMruRunx1CVmamFA/I9vSNs9RR/AvZZPeQ1aGEoWtE8UO4NtdozgqXa0Xx7qVwoP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474924; c=relaxed/simple;
	bh=7WcjelV31lrY8G6I07VmlKtcD76/c/2s50z0eMD/3vo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QeJKV4UH8zl1TlLzbEiK/hHrlWgHmRA4MJVjDZQekAEvXyuMtcAG52Vom3f68TAHqpQfOi1FyZaqYHNorgMmOoKj0ll5yh7kPOqt7dwS++O6Fwmkyr3SfF3dCY4G6EQZdSBGUiVmJlGIu/OE/DuLCCrWH4NSYAr45sACkQ3+aRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1xsRNF2J; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P68E9B032103;
	Tue, 25 Feb 2025 04:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=NdbmMSBSFj7Txm2ujfxK89J7NWZ
	VgZ9A3lxLDEClkFY=; b=1xsRNF2JFLOLieWIgGvkjJkufSZQYPtlHo5l+RdEUNb
	cKWIRSwwLIVTyw9alEKqLEqi2qC5XQCpEyuYeVgPUmrH9hMUjY+IZDjo3MuOjeRO
	3cv/VM+A6pVj0I+PHj9qedrYkKXmiKAualalNW38McC6T71E7+TAPzkWpw1747Mx
	jrrp/eHTZtN/0+mbYfvlvsbiOxkcb+PpJ1Lw61NieJN/uii3Axt9EhP0BhNKyumA
	mbI25p0s7eMnL37ldbrhWc4uk47p0R/ezqhTKR3yURZGyhEriLEmBwxZMBYd8jbQ
	GP/xJtb7jiwo5MpAUAdDWZnP4D5jDcadTCBktZcNwaA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44yccanu28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 04:15:08 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51P9F7x7003897
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Feb 2025 04:15:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 25 Feb
 2025 04:15:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 25 Feb 2025 04:15:07 -0500
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.116.45.25])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51P9Eof8011564;
	Tue, 25 Feb 2025 04:14:53 -0500
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH 0/2] Add support for ADP5055 triple buck regulator.
Date: Tue, 25 Feb 2025 17:08:32 +0800
Message-ID: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCIvWcC/x2MQQ5AMBAAvyJ71qQ2VvAVcShd7EE1LSJp/F3jN
 JnDTILIQThCXyQIfEuUw2WpygLmzbiVldjsgBpJI5K6fDwDm10Z60kTZU7cYINL19aQMx94ked
 fDuP7flGHlwdiAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740474891; l=1217;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=7WcjelV31lrY8G6I07VmlKtcD76/c/2s50z0eMD/3vo=;
 b=naQrGPODQ4Bge+/jRmNft5q8qlTsAtkBTUwXLov1NZGkOKIHuAkLYSrSGYjGCELSOEJsTn5xl
 1glTV3rSiR6DFnsXSgJCYXfRxIge85l4gZvNos6K9ztHvOwk4/Fzhr+
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: F0JV4oo9XMbONpf_yyXvwkPgqzluIzCh
X-Authority-Analysis: v=2.4 cv=SPa4VPvH c=1 sm=1 tr=0 ts=67bd8a1c cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=pX8K7AMcFWmkIJv9s54A:9 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: F0JV4oo9XMbONpf_yyXvwkPgqzluIzCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=983
 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250063

Introduce a regulator driver support for ADP5055. The device combines 3
high performance buck regulators in a 43-termminal land grid array
package. The device enables direct connection to high input voltages up
to 18V with no preregulator. Channel 1 and 2 deliver a programmable
output current of 3.5A or 7.5A or provide a single output with up to 14A
in parallel operation. Channel 3 has a programmable output current of
1.5A or 3A.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
Alexis Czezar Torreno (2):
      dt-bindings: regulator: add adi,adp5055-regulator
      regulator: adp5055: Add driver for adp5055

 .../bindings/regulator/adi,adp5055-regulator.yaml  | 214 +++++++++
 MAINTAINERS                                        |   7 +
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/adp5055-regulator.c              | 490 +++++++++++++++++++++
 5 files changed, 723 insertions(+)
---
base-commit: 7fef39f0e82ff02282797d9ae2589b39b16ab614
change-id: 20250225-upstream-adp5055-adbe6262f984

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>


