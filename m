Return-Path: <linux-kernel+bounces-246479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C209D92C279
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F821C23009
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E647180046;
	Tue,  9 Jul 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="jSB9N77b"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB917B044;
	Tue,  9 Jul 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546136; cv=none; b=i6qc3dRZkFOkdVZ6DCMCnE8WQUwZi2VYa56dAD/wWZlBxGg5nhsETvTYdjTGYsy70g2Kvp6uca+AFD8lO6dSs8H6aNpRf6ruk3ZpSfCgjSvXzCBqsii31rrP3Jxpyx6UQtLV3k5gOl0/M8DzKTBH4ZdqmwVwKYyYKiQtPJ6KRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546136; c=relaxed/simple;
	bh=Nb/C2sk02GSMvbKTWJKrZMO+vuRrdDvY+sxl315ffZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdHq3SrjAl8LeHCmUicFKE5XXSvcy6cOrBxswgqyJxt2Z4cB2/JRZNKCodNd2CYzFeefXoMvMSJW57WSuNcMznxmvh0rTjFqRwSTdbsMMH6tDyo0CL3i02enWagXyFZLJSd2xslXekf742K/FjYOKB4yz8ve0lORf7W1cWCV7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=jSB9N77b; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 926F2120006;
	Tue,  9 Jul 2024 20:28:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 926F2120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720546130;
	bh=usQACoAHQhJNBLt0R8E376ov5H4FLdFKTkqn7dzBpds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jSB9N77bZoIncMEJtCoLhmJHpbyHpWtRklk3uM4Ov/zPWIrwyMllYluPZLLOKraMm
	 tCamWRFIy1Njd/rvB50evxA7FXFbQNruPSkbL2JfFK0ZwK+AZWlBiBFaEBoYImfOr8
	 8KcLoZKgZMT2GIH6gZxtlsC04Yi5OPZEGJpBEcS5jVYCCI64xA2Lshx81aYMPV6/sv
	 h4QOCxM5/11u7lbMkDgnyoEJEmwZbVKKNPu166/B321H1CJKRZlc6v86xyL4FKpIGz
	 4C1DU8F0X5jpSHaBdk2WceNfZqqlawAwZAKu+dfYXY0fr24LcAc46WeifIwEmNMTQp
	 uBRpo2gL79J3g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Jul 2024 20:28:50 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jul 2024 20:28:49 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Igor Prusov
	<ivprusov@salutedevices.com>
CC: <prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] dt-bindings: vendor-prefixes: Add NeoFidelity, Inc
Date: Tue, 9 Jul 2024 20:28:29 +0300
Message-ID: <20240709172834.9785-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709172834.9785-1-ivprusov@salutedevices.com>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186398 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 15:25:00 #25923573
X-KSMG-AntiVirus-Status: Clean, skipped

Add vendor prefix for NeoFidelity, Inc

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..be62a59788b5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -997,6 +997,8 @@ patternProperties:
     description: National Semiconductor
   "^nec,.*":
     description: NEC LCD Technologies, Ltd.
+  "^neofidelity,.*":
+    description: Neofidelity Inc.
   "^neonode,.*":
     description: Neonode Inc.
   "^netgear,.*":
-- 
2.34.1


