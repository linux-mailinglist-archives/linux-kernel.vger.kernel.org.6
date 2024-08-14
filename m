Return-Path: <linux-kernel+bounces-286180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958579517A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AFA1F24408
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1622149DE8;
	Wed, 14 Aug 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="fh5R4q0u"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B9148312
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627607; cv=none; b=Tbm9OQNBqwMnXu99qLSRigNV6aolslTazw80ksIX5ijc+oVemKQoSKA02yrd4ZyzSOLJUXE1/4m4p9mUPXYwoRPTLy5rwTmedj3K8mDb9ZLLVKIaCY8MImEhMR0hS3lLEDRhqJ1nF4hT3DTEdiBbHADFd3GG+jrbV7+E6MA85U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627607; c=relaxed/simple;
	bh=du3T0NbhpWxdJIqDk4B2apIvrigUhtDvY/L1kMGtLvs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gcREaHEe8YO+nVgR1YIefpQv95JTXksJKORo7Sks3A+pr9I4OxY3zjO2bbCRtJO2ovcHXOkkTbcdq+grBbLIVQOL1tzvP6uPWPjRZ3GpcjqvHgMKNfxXwYhFwkPAqHa5bLjK2KWme5K74wBFoFuIxKKgrryWhV3h6yD4tDCorC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=fh5R4q0u; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723627599; x=1726219599;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=du3T0NbhpWxdJIqDk4B2apIvrigUhtDvY/L1kMGtLvs=;
	b=fh5R4q0uyt+w6TdzwgKolme9mObFOmP621bggGUSsJ1EZ2y0kPbnZV613ADm0EnV
	93JkXOsybQ27sV/CQfbMuUgx7vsq/2Cz5/nCZ8eILCL8OIPPIASWD51xIRmaM9JT
	IkazQCahnzbiV0miIJIsNMDGwTLN/CwrM4mAsaCWXUU=;
X-AuditID: ac14000a-03e52700000021bc-b8-66bc784f7bdd
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B5.54.08636.F487CB66; Wed, 14 Aug 2024 11:26:39 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 14 Aug
 2024 11:26:38 +0200
From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 0/6] arm64: dts phyBOARD-Pollux: Update regulator nodes
Date: Wed, 14 Aug 2024 11:26:07 +0200
Message-ID: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC94vGYC/x3NQQ7CIBBG4as0s3YSKBipVzHG0PJrZ0ElgFrT9
 O4Sl9/mvY0KsqDQudso4y1FnkuDPnQ0zX55gCU0U696q5w2PFr+SOLKGTGicpq/FRMH8FiSxNV
 FNmbob69UaoaPPBh3hA8nq5Wmlk0Zd1n/y8t1339Q88ENggAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <b.hahn@phytec.de>,
	Yashwanth Varakala <y.varakala@phytec.de>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWyRpKBR9e/Yk+awYZJIhZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CVsXRvB2vB
	D/aKux8mMDYwnmXrYuTkkBAwkdg/9SkLiC0ksIRJ4tCski5GLiD7MaNE49sbrCAJNgENiacr
	TjN1MXJwCAu4S/xutQMJswioStyf28YCEuYVSJY4sCAOJMwrIChxcuYTsDCzgKbE+l36IGFm
	AXmJ7W/nMINMlxC4wChx/v8cRhBHRGASk8TRayfAHGaBPiaJzmnn2SGOE5b4vHsNG8Rx8hK7
	Lp1khIjLS0w795oZwg6VOLJpNdMERsFZSJbPQlg+C8nyBYzMqxiFcjOTs1OLMrP1CjIqS1KT
	9VJSNzGCIkaEgWsHY98cj0OMTByMhxglOJiVRHgDTXalCfGmJFZWpRblxxeV5qQWH2KU5mBR
	Eudd3RGcKiSQnliSmp2aWpBaBJNl4uCUamBc1f7nw94Vly5f+Wp5vf/4ZInfPR5ntjYwq/ic
	vRkhNW+mSkTL3Dthl8Im13/e+Mctgfnvj5eNOsr/p1Q5/Ds0WWqj/46AoydmrV9fyBhuNn/K
	tUXXsrhU5WvY/Zkbg/X9s0xFk06fqjv4VfPO4/xvP88dmR+/vVtiesabTf/flkVvr06pWz8t
	R4mlOCPRUIu5qDgRAALzY0aGAgAA

Add some fixed regulators based on the phyCORE-i.MX8MP and
phyBOARD-Pollux-i.MX8MP schematics. Reference existing or new ones
to the correct nodes.

---
Teresa Remmet (1):
      arm64: dts: imx8mp-phyboard-pollux: Add SD-Card vqmmc supply

Yashwanth Varakala (5):
      arm64: dts: imx8mp-phycore: Add VDD_IO regulator
      arm64: dts: imx8mp-phycore: Assign regulator to EEPROM node
      arm64: dts: imx8mp-phyboard-pollux: Assign regulator to EEPROM node
      arm64: dts: imx8mp-phyboard-pollux: Add VCC_5V_SW regulator
      arm64: dts: imx8mp-phyboard-pollux: Add usb3_phy1 regulator reference

 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 12 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi        | 10 ++++++++++
 2 files changed, 22 insertions(+)
---
base-commit: 1d43464566cd7dc2f3f078e2ef46b55a5bab6c70
change-id: 20240813-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-9385ead74101

Best regards,
-- 
Teresa Remmet <t.remmet@phytec.de>


