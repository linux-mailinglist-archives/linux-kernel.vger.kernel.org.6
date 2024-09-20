Return-Path: <linux-kernel+bounces-334020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDF497D171
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51801F21F18
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE593BBCB;
	Fri, 20 Sep 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Sx6HEyvw"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011017.outbound.protection.outlook.com [52.101.129.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69AD33985;
	Fri, 20 Sep 2024 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815902; cv=fail; b=JKL/vMWz2SeJWG1jykVbv9E34ZbNHGdaDso2j+DGJP281xNJjqs+xNpC5cGQNrdD60h3cLALHcKrnstJ7IgkyaEFmVjSkbQI1+s1oA57op7D1ovLTAhsY4BbcGpz00/G602OLXl06bQPO0XY6XkhPZiBf0CfJo30rlLZ+Ignyok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815902; c=relaxed/simple;
	bh=nodMhpNaWezXq4hwY+Og5O/RHaaytlKkTMoxbkxnAqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ULX+VBc8opvWBnwrpZtFGJjZYLi9TzQMRSoM4cWHTW7zhvqsvDq7y1dI4P8vjkoW9wdt6YozBWlO5GCmZB2BrGpLceGpnTHdz3YewSYmwj/Ql1y97x9t4Xl1SpE+ISEkD6RCednUdHJOXu46AS+2TApD4vr/1Y5pZ+nswwDIILg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Sx6HEyvw; arc=fail smtp.client-ip=52.101.129.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvgGXe9jKu7QsPON3Xg+uyzCiVW6651cLFAohD8PY4c9golVR/uj70eY6iCAQDpgke9t9ydbY9z69f+4VCf19lO0S+oT9aa9uPDvfHESHHkMqhlJQnllHXhImsnCmPvkNMS9mQAZUguPxYJ5ysZzJAzemLHeKSGTZRLHiI/2mY9VKd7JQX+QivtF/PpUEBKiuyiNUjscmGlw3y7ipnTkUSywbTGY4qjOP/XSq1XUOTzSVJoZSpugyNs1JU3VrOtNrAd/H/gDs8MqWE42KAA9OVqEjzVgNoxesMWBe8eNJEKu46hH/LfH2NhQnkWZkKaA6CbHIyxNbFAUEtMuddKoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT+f0MdKiNzFohUOdCExpotvyfFFXiCvGtQ8RdiwNs4=;
 b=N8LFFK7YS5NYQiyRib8WJbxzmOepH/eHHJyuWm9Jfm3i9lHy7ji8qBBBbSEwD8SMJuTxwOehpVHj5XgwvXbSV556WsWMrl9Xn6twUdTpBXKzqHLLeEr1WEivJ2VSH07S2jTbgPoMHEwdAvh5lqxz3fW5odmkOK3Gi+B95Z22wxnUZQn3ZfzEhhElmknjReelUBozoVJqDs/K+hZWRLMEC9V5cyOfIG9MaxePUZ6jD7DurfT9VGLYWsSBxwsZweg53C12eZMbFq+bsTBg+IiNiRAHNHtJquORWnPBZmwlheTY/4zQaNXfR70b51QHlEcQe0PV+HZ0/vfUw5RY2/hVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT+f0MdKiNzFohUOdCExpotvyfFFXiCvGtQ8RdiwNs4=;
 b=Sx6HEyvw799sJShM/8uQU1xi8ppyHhlwzjb+Lk18VSSXsaUtA+j6liyiJ9gz0ANbr+4RTNGIH1uVR+nL1VCYHdpJ+SuR3j9UZR4P72tJlMdo8OvkmITsDc9p1IHorarD2fuX2o6O5yurHd2fv+pMUDHebmG1eJkkwxkOaGa0uGUwrctuCfj835ud1k3UW1X/+fv/yV322ruaT0ff60KYiLQqK71JCuw1YqtrWIuRysRXaTPPg0ox7qRcpZ0PngX2ocqc7BHL53q99mS96zgeX/HzThsY7Ti3yQZl8PWG1SxSZVvkcw5CUHDtz9d7fdylPET1QtGFjYt+yBj/TCemsg==
Received: from SG2PR02CA0099.apcprd02.prod.outlook.com (2603:1096:4:92::15) by
 SG2PR04MB5614.apcprd04.prod.outlook.com (2603:1096:4:1c1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.22; Fri, 20 Sep 2024 07:04:53 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:92:cafe::ab) by SG2PR02CA0099.outlook.office365.com
 (2603:1096:4:92::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Fri, 20 Sep 2024 07:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024
 07:04:51 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v19 0/2] Add i2c-mux and eeprom devices for Meta Yosemite4
Date: Fri, 20 Sep 2024 15:04:47 +0800
Message-Id: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SG2PR04MB5614:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3049a03c-c096-440f-91cf-08dcd942866d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SfXPjOJBJiCq8jYlKYapLarktRfX2/NA99bgwgZ4yy+XSLAEpz6/FMPvi3+v?=
 =?us-ascii?Q?I5ohAoRHK87u4Z9gaUCThEVPFgJp8/OZP/EBd8O+pMHaPkQvkonFaiu7lyYO?=
 =?us-ascii?Q?LVlWjmh2UHzUeMedNxfivShEcNQx02RksoM+7i9cvI9O28m6bwpQg58tKba6?=
 =?us-ascii?Q?nvt6iThpDAbnRWYoAHVWPfnp9rU63wr1Cm9A3Rkt7mIpvSD0iNY9/SeY+nRM?=
 =?us-ascii?Q?2NOJnn85ML/wwRdY8vI5eUO1+B1XFkJAjGRgAU+hZctS0FmUxgtGOzaAZEaj?=
 =?us-ascii?Q?rKV3nqtJYWboAxj8DFj8cBqpUJ4fSNHoQx1wWfHvW30fyfC5czBGHv5t1fns?=
 =?us-ascii?Q?SXcHZRMkkbhditckjgRsoilJjjUfWAk0q6O/b/XnGBxfPub5pPvr/9R2FBAz?=
 =?us-ascii?Q?1Qg5Pyu5ho+sE9ktbYAGCgdE0eI5vLIZg0lEwS0hkjABFHMv2+qGWKEkIKQd?=
 =?us-ascii?Q?Dg4MxFkGquZstKZ80aWxxy5AsdZE46v6bzYtITlXIJqGHWdfzYKgPFLujM2U?=
 =?us-ascii?Q?GJyqw1dD4JC8zv+Hk6LmTzPizJqrH0i41lfMSwTvJwc4rDxSndmbp3l0FJv0?=
 =?us-ascii?Q?oZ8cqQvH5A4Y0r2glgsRicF317tTAJ+4RrNPjemFye59uPDiZ0QunMAtoil4?=
 =?us-ascii?Q?ECT34Eni/qU7J0D6/0nw++ZN6lRbQmESEprN/e9VEfeg3qThJJ6gfCkEK4/V?=
 =?us-ascii?Q?3NOKpvMzr6KVjCRqi4P/smlHdCFJq9ZdPp9ZwNIcmOBodAz4Tb5H3MbTRRsy?=
 =?us-ascii?Q?9HcLhVKKvcIWESkpd2OvM8A9wruCT363XOE43KMrpArVxj4yo5PYB7SH7bE6?=
 =?us-ascii?Q?XASHcfNxLtYgMgG+CiOd1/Kuxp2GZn/wQ20rjmUAQc5xETOCFL9ho9eMhbjG?=
 =?us-ascii?Q?IWWHWVJMhvLxCZC6DPUpPGbbBvEKqj6fYoNXUu5DtYIVaE3yH58wX/Ji4S7o?=
 =?us-ascii?Q?/RJMWsJPK6FsHhBI6BbGZOsLzCfzTp7o28RPAk3vFoithmdZuf9eGGT0ELbN?=
 =?us-ascii?Q?QTVHAfkFVLEldL4mPdQUF17MizIMbGi65nIyHrTV4/NUFRyiHXDTMVDWi6oJ?=
 =?us-ascii?Q?ES5EOFsMg2GneZesc7gWOCgUjRk9xgP9UUsxEgjHZLrkh3vhfkIUe+rvuezK?=
 =?us-ascii?Q?i70dQfaU80a1ulexMs0SJZB8jbsBrH/ofBmp+GGFhc9ifvq5k+M6AuBlPLmN?=
 =?us-ascii?Q?4S6FhE1o99NZ26TCJRwGZPf4t5KNvWuyR043FhnHL294/dMTzmk5J7R/ro7R?=
 =?us-ascii?Q?G3sWQWU/SVmDxKExg7v+B+4qtVoeA4k8LwuDSkhgE2Oe4A3JqY7D6GiOXYSH?=
 =?us-ascii?Q?qTR9AHDUktxlCoM7l2KKYy7YNyTUgtEZlrGR3PbMBW5cvfR4y7LYz1Kf1rCF?=
 =?us-ascii?Q?0J1aVY3ajRE7uoe9NsMaO79xByb31unHJD1sBHu56n69VCYy3mPmHvNMAlR1?=
 =?us-ascii?Q?UH/WFURVx1ika6BHnJMUCq3TMqPTD95w?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 07:04:51.9914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3049a03c-c096-440f-91cf-08dcd942866d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5614

Changelog:
  - v19
    - Remove led_gpio pca9552 since there is no binding document.
    - Add gpio devices on i2c mux 34.
  - v18
    - Fix warnings for reg_format reporting by dts checking tool.
  - v17
    - Add SoB for the patches.
  - v16
    - Reorganized the patches.
    - Add i2c-mux and resolve the dt-validate errors.
    - Revise Yosemite 4 devicetree for devices behind i2c-mux.
    - Add mctp config and sensors for NIC after i2c-mux on bus 15.
    - Add fan led config for BMC to control according the status of fan.
  - v15
    - Add ISL28022 support
  - v14
    - Add SQ52205 support
    - Add GPIO I6 pin
  - v13
    - Add RTQ6056-support-on-bus-11 
  - v12
    - Fix GPIO linename typo and add missing GPIO pin initial state.
  - v11
    - Revise all GPIO line name with bottom line
  - v10
    - adjust mgm cpld ioexp bus
    - add GPIOO7 name
    - remove mctp driver
  - v9
    - add XDP710 support
    - add RTQ6056 support
    - add MP5990 support
  - v8
    - add fan led config
  - v7
    - Revise pca9506 i2c address
  - v6
    - Revise i2c duty-cycle for meeting 400khz spec
  - v5
    - Support medusa board adc sensors
    - support NIC eeprom
  - v4
    - Re-format gpio linename
    - Revise i2c device node names
    - Split patches by logic changes
  - v3
    - Correct patch for revising gpio name
  - v2
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name
  - v1
    - Add gpio and eeprom behind i2c-mux
    - Remove redundant idle-state setting for i2c-mux
    - Enable adc 15, wdt2,spi gpio for yosemite4 use
    - Revise quad mode to dual mode to avoid WP pin influnece the SPI
    - Revise power sensor adm1281 for yosemite4 schematic change
    - Add gpio pca9506 I/O expander for yosemite4 use
    - remove space for adm1272 compatible
    - enable interrupt setting for pca9555
    - add eeprom for yosemite4 medusa board/BSM use
    - remove temperature sensor for yosemite4 schematic change
    - add power sensor for power module reading
    - Revise adc128d818 adc mode for yosemite4 schematic change
    - Revise ina233 for yosemite4 schematic change
    - Remove idle state setting for yosemite4 NIC connection
    - Initialize bmc gpio state
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name

Ricky CX Wu (2):
  ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
  ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 567 +++++++++++++++---
 1 file changed, 493 insertions(+), 74 deletions(-)

-- 
2.25.1


