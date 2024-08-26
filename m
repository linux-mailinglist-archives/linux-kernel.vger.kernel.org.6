Return-Path: <linux-kernel+bounces-300821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B247A95E8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B9FB22535
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9369B1487E3;
	Mon, 26 Aug 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="to3bXmx6"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2048.outbound.protection.outlook.com [40.107.117.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC5AE56C;
	Mon, 26 Aug 2024 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653616; cv=fail; b=eqzE5D1YW0qod7g7J/vcUR/h+0GROqhn7Yfu7aaJctdNHkd+XXjF3sCAMjX6mMIDlFiv1zuNuSoNixjGBMtzsVGIhObrZsDhnNrW6/ux0Yrs6ndlOz5giWMaR62qBN8+7N7GTzfXgHL7PC6jpRxGPck9XpMjGUtXd0XHQRlwGBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653616; c=relaxed/simple;
	bh=cS/9YApVsf8gaHDPQckZ73C8KOJ6xtxMgWUJvm6ZD9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTY3RpVIRS/q8qn6uQZivOM7KthjNHunm+CqG7xK+Fxt8s1f/0o3gHajRUPxp9pD46OMsVfEae93ankhhYsVSRPFD6nh3KI89bKLXyPm/DhkU9T+3/qlcmSbMhhZPlcvypfqcrQ/20r29rgNMUZ7+Hffk5sDjDlsExUmLmdp3ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=to3bXmx6; arc=fail smtp.client-ip=40.107.117.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsobvSQ8or81WXOqiiqQPZMmcZboLMiG+Y8TiJ4wag5zHKnLKv7t8V3bxZjF2ePU1NReZ002N2rVxQOL0m93+Ggpdm/SC6tquRHYT5m7UEsbeSH3ws2Lx1lVuVcs3Mm1BnFlT2MPBvzTpLwWeTqu4ehX+pcQTB8SmWrIepRS6tvgk9xznUiMPzWCFp0SJnPxQyxCwY0RIDHRN3i35sS6KKNv6KVCl/xG8enaFKjf0sMXLJCRjqvOZhffo8VfIJ544ufcakUHMwPRnBRPbNu1U6YBWbmhFjMKT782X9MSznpJtd+Wf/M3HZW+AuTs31IRsNqUshRIXJSPVTzfPcFUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJty/Sn8NpSzsj8QpXuqGnw99pNMtTMnmTt569eZCKk=;
 b=ZcDt+sZVxy5+NkPGvs2d+g1IocorJKg7F/Uqe/5vIQZGt/VTLLingAC6xE8loxQjAEERkEsZcnm0xCVDmTVDDRJZ3sKr5xse1RDhLfYSbw0kImPGktoOqZEMmnnuS5wsbw49CCB8bb4TXg3NHiGX94gEI5WEtXSDJgQG+sinen9k3OjUB1zysPV43ELVEZSzEr39g3/+nZUs+epsjloilqVv5ItzUFn0ioLeLUlVEb0s2UuC/sn1JftvIO/U5vlE+TF3sZ7+zPmo/H04ANGa8ZMW8EvVXccPmgwcS+TbCmYqVEFpoRBjRuhsP6q4shxfb3NvvnAgb2UryE2/psEfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJty/Sn8NpSzsj8QpXuqGnw99pNMtTMnmTt569eZCKk=;
 b=to3bXmx68dDazJQXjvNf0HoY9vOlT4dFDghkOTTeMihfgr7wBhRdK5/3mrvtUH92un4QMaGIVsMiGrUoJ4d34c4Syw5yYbHNcPov0lYwT2HVcaB4hxTEmEwp6uvCMdr9XNkX2TeK+G3FMNo3JEb1L0kDXTrzB1rm4e94DlV1b/O0ZzVX0mBEd2PwVLGP08LR5ub2kZQ83giCZFuNZdPzPOl9oBvMh/u81VX/nY3EQn3f+DpgMwlQuqPsAGhrx8Tvd/FR4wpxSDhFuj5RGuyNRFDzCVgV8ArA7PH8R/pxDHEnhScmMOFBTDW1rHe5TI7zhqnRGsmLAkQrX+i73iHSiw==
Received: from PS1PR03CA0008.apcprd03.prod.outlook.com (2603:1096:803:3d::20)
 by PUZPR04MB6769.apcprd04.prod.outlook.com (2603:1096:301:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Mon, 26 Aug
 2024 06:26:47 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::18) by PS1PR03CA0008.outlook.office365.com
 (2603:1096:803:3d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:47
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ian-I-Chien <Ian_Chien@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 29/31] ARM: dts: aspeed: yosemitet4: add RTQ6056 support on 11 (0x41).
Date: Mon, 26 Aug 2024 14:24:03 +0800
Message-Id: <20240826062408.2885174-30-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|PUZPR04MB6769:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2f29d36c-9f92-4c68-9132-08dcc598101a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xns2KPaqpVnbhaTFz8HNaBvISBcpcL29Z56oFdcopjOyXRBZW6gl3gslxGQf?=
 =?us-ascii?Q?pwxkQeW1MgDRtaOViQi5BlbViwnCK1f1aKjVS2NH2nXkygI0XPIVxcGAsbql?=
 =?us-ascii?Q?bhD1eqjiImBRSzZvCBiETE/QaDz3vIPw5Jq1cz0Ok993CacneW0yNj++3xsg?=
 =?us-ascii?Q?h8IvPcFomvF5ihjBEmcCsgb83xkQ5WDvlu+ZuC736Eo8vqoTdz83kwFTBWiU?=
 =?us-ascii?Q?2A3/EteMbAnm/4apiFokKHzdxsgdZlumtEVxLpsq0YsECSKvnLT1uR0JTGxW?=
 =?us-ascii?Q?GHwsTDqoeDVIYx/duxkSXEnpO+HpdIS++xv/5jE+ETw6h22QM4nxMmjk27qw?=
 =?us-ascii?Q?IgkQSfHcQuSjSuoPgdkphPheYEl33499sA0UD2aVLJX/vsIrEk8jqcVhyWxV?=
 =?us-ascii?Q?M4cHHVQIM66yA7he9pJgslIQMiDNI2JnR0Dt/WmGaJmnf5J8Pq/9+GkE5CvH?=
 =?us-ascii?Q?EE8Vfuijrn4GadTcgD+Rs5zWs4MmP5QPLt1eBIkGc1kT3yrvIDlerD/O89G/?=
 =?us-ascii?Q?WnEE9EVfV+Up3uZrEaQdOPxcRaKdKgOUhIyPJ7FDzX3l8iAP0/7WH+1yFdxu?=
 =?us-ascii?Q?orSKsU77KEGS5Cc4V+i7zhljYmHl61hPKnl5uYkMkjbaPloh9YrE5CXLIt/1?=
 =?us-ascii?Q?BvmNDApmBxwkYlu0RCU5u0wjFgPi7W1IzBDbKgQb6knYSlscmLy0YAMTuYh1?=
 =?us-ascii?Q?iYESmBNqGkvu1eK2OEiRsNZcy7xO6QDB0EPf8POHEjYYV6VBjj2p2pW/kdwL?=
 =?us-ascii?Q?x6FHvs3d0RLW9ETtvEq8zaT2WGB9mcFNH4KkqnhBA7G+FCnTYms/Nq97HY5i?=
 =?us-ascii?Q?mA6+4Tm/4VQYZNOa3ZFhQnaAH6D5XdRrrRpaWO39n0JtfZkzBELyQ7VRiZ3M?=
 =?us-ascii?Q?1XGPtYwPJwjnMaB8NVuHyHtFV5JZpzYC5yaqd5fGh3t5OepeIN+Eaznrik2g?=
 =?us-ascii?Q?pCZSYnmOhqC1gtGpe61csWLUV9bxZn8AiC4Efrg0c7dAKIZUMgbrjXtxagmR?=
 =?us-ascii?Q?wceAjTLKmdZNWya/UUoxw5XtbbKqHZP5fH280eAzjHTgHL70H4qELoHNm2aj?=
 =?us-ascii?Q?JySs4eXEdt2mvVT97erEnuLW++RCjk1WXQRbz7F3sQBCxgb6zb2bAD//QdkQ?=
 =?us-ascii?Q?vL8EgZl3LL+tFI+MBlgOh7VKy6WdptCDo3/3u22ZQIFqUcipob4qXCBYa/N4?=
 =?us-ascii?Q?/wSBrztBu+6D0ij4UrQJK6jC+AcL4JdyHpfldDiRp1VBNsmm2ixY9Ol5z4at?=
 =?us-ascii?Q?qE+val6uRuZrVxA9oP3ufOLLLXLVxA21aXn2tbF3fqOnvgQg+/bGVc3uVLiR?=
 =?us-ascii?Q?QYvTkrzllsJEwi1mR4PTZkQlw9AUOyhXrnJctim/K3HM399BROXRuJ+54d2R?=
 =?us-ascii?Q?A5mtWo/DypSu2mY7FhNYw5SmyipuixLvzjtBzIptlWyE/gMo4ZgobiO46HJz?=
 =?us-ascii?Q?iflbNklzNdFN+YgoXLKwSoYUuoFbIMi2?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:47.3145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f29d36c-9f92-4c68-9132-08dcc598101a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6769

From: Ian-I-Chien <Ian_Chien@wiwynn.com>

---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 4090725160f9..d056f6d5ff6e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1081,7 +1081,7 @@ power-sensor@40 {
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 		reg = <0x41>;
-- 
2.25.1


