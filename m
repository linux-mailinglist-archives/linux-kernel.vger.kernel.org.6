Return-Path: <linux-kernel+bounces-339845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91007986B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1B81F23338
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C717A5B5;
	Thu, 26 Sep 2024 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="PPtdETgC"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2074.outbound.protection.outlook.com [40.107.215.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A213C3F2;
	Thu, 26 Sep 2024 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321314; cv=fail; b=PUjCcVnQyWMJZ+8LFDkC/yG2JGN2lNzHp7G9l1U3jpKrAlISpkjaDOYqz/kZNOJlbbqGF+I1V7NyyjDt0S+D/OV+C3F1JyH7eAZ1GsKEyToz5vYFuD/PYqEDCuyCa87HNNK5ZoasJAluulouyqtPSwH5emF7id5xKuxMvve/Olk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321314; c=relaxed/simple;
	bh=Ccyqe1+l+DqGR+47ibU9ZG0xz/qodtz+zn5t5N0hzJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=seBjgSkaXDAgXwAudryW20DINNFUnF7321ay4jGHQeK/OcTglWNsl96yFil8Gu+JwFO4W3wK48sRIjzMkFoDUfKdMZJLWgEvIs4mei3zF6v5vGLOwiDRQh/KjSU8OMG2nub3OYI5I5lVTLm0etlT7WwnynIlAr86+kOSRznT/9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=PPtdETgC; arc=fail smtp.client-ip=40.107.215.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1Gyv3X7EDw3VoaMckEdO6SgFvivOX/t9WGnTjONfmywfKjPvtUcdQI+6vJ/KwHG1R2LiPWdIiGBuKdMk7XldwsRFpo3l2yUFNk7sBI9EfePok7gkQDZ3+mKg5Q+gdDxU/6VBT8wW29Nd3o8aEq5rJHXzkGZjkOh2XY3N7DonfIDIU9udrNCQZUgwg1/5brogppIbcPLpSYZHAqlTyjpTUfjNMNpStIrB1wvOe784Ucnrs4uAo0XvzdAf5uKNhrKmYzLXUxkH4bX44myD7YEFk9zu61e/9385z2VqG+Sd/nCbVd5D/8l+sEtm97vnAW2ytL3r4MgsHrMrBn44DP0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5viLAlCTwazaKNUv1ok0UHyIQfjtp3M/XawChSHY4U=;
 b=uDfJ9fkhToIk/Uc2l3Jw+zFruDBfNDgiIbCmMpk3qW5FPk5tuOdiJo+QW+qCnoiq16ChyB7ktO5Kyv3fIB+mcu3RKgnqkfgRMLw6DMp5JDD1dbILnV+6/xRL/jr7xA/8HIPmS/O5BxZeTkgbc0jX9uMm5SASbhKSC/dsf7oyWhRCyw/c67GkvBZOD0fSQlJso5zU5nfZdog4CdfnBaaE6b9pyhARGpGrAbn69uy5ltpPVBDirU/eWFbAjbvFolpNTCxmv0/aB3SXcRBaRLUo3xNCP8PUZiUm0tkiwTBmTzkX7vvLxpY0i0mbeYI+pfJYifl9sSJG3KTUdm4qbA02jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5viLAlCTwazaKNUv1ok0UHyIQfjtp3M/XawChSHY4U=;
 b=PPtdETgCww+qtMedg2zO7/C502w9H75sofGOzAlkT3TWUjaw1zby1V8en9P4hOGQauddtsCli5UTz6CHxAi/AwPUqqEmnwiSs9E+yfT7hVw0mM8J5XlshKwOorRn8av+oz5a8PvbTCOvLbw6zLTiGjJGW/1FMKWqIBS1+aPGk+NxMohC0t1MkiPLXDIcusrdb0Q9MYbRoFgEoOQ+ogw+Mkb1r/geVl7o0nGCyCsWJWiFRkIQeUC8KucW38cBQ6ji4hh5ZedUNOuFcgJHTIXy4Uns31ZM8Cus79Os06LyN/Ka6xYQjIvYNNn+5mF9NynwJ5RvTjOPxRuIK/O3QXaPNw==
Received: from SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) by
 TYUPR04MB6790.apcprd04.prod.outlook.com (2603:1096:400:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Thu, 26 Sep
 2024 03:28:24 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:93) by SG2P153CA0002.outlook.office365.com
 (2603:1096::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.5 via Frontend
 Transport; Thu, 26 Sep 2024 03:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server id 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024
 03:28:23 +0000
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
Subject: [PATCH v1 0/5] Add I2C mux on BUS 14 for yosemite4
Date: Thu, 26 Sep 2024 11:28:16 +0800
Message-Id: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|TYUPR04MB6790:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 346b5d2d-5352-4b7c-56ee-08dcdddb4729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2bDJTAnj9feRRsEtjY6f4IyTWZq4HGYp8qWV/mE0F6Br4KYfu5QOXYFnc8/6?=
 =?us-ascii?Q?+TaRBxgGcYhrHY+kChRz1C7WZT3gPhOMD7123xZvwzNZcVx2P2rttRVgFpU9?=
 =?us-ascii?Q?tCjRUoX1aOmp8pHqCp2OuYdtM5WQhynt3MOaS0STF4vsL7Y17LUozYx+v4MS?=
 =?us-ascii?Q?JfNLLdKx7ZdfqW/oWOPnYy+oipj6xlM8Ir55Yc4Ld8/RgrqAW2MlC2HEj02O?=
 =?us-ascii?Q?ZKzRWFdgmToW4jSoK6uGPaclN3bDlP7mu0RoIZOnzNE/3LW+AiRTKXCsMIZg?=
 =?us-ascii?Q?Wdf6cH5k0ml2Uj5c/sPnJ52zytxuhAc7xp62t7P3TWx23oS3TC3OTa8ixE8n?=
 =?us-ascii?Q?F7S4y7ONBc31vLddUvUL4ZXNRP9Wa66+Wu+0YEoGoiVsoNIn/yWuAiIxuini?=
 =?us-ascii?Q?Fc0aHRB2XF4PvbcdJdiU8AurBs8cDNHnMzW6DHxQM0h3wL+ilWpLnsPRSWxK?=
 =?us-ascii?Q?h71XJ19OxFOhplS7x5rTTDUQcnnt0xIdF272Gwr0XjOpdhtAWECzQ2WBOpv4?=
 =?us-ascii?Q?5uXXxxhS7T9dzOaq01PRrq5kGRzd7rbJraMRiSd1KvRuMHckmaSof0aSrOWI?=
 =?us-ascii?Q?TptorMDsAjR6zoXUZK7istS3HKhNbKx8F8evKVguzgD7K3DU1yGIYQHHfL4t?=
 =?us-ascii?Q?sPBUNZTdXXWrK/KcIyXlZ7829XOArG/QTVwyclDPjRHyp+bz10tl8L4EFTR8?=
 =?us-ascii?Q?UHXsplXeUrvcznbfhm/TtchQEwLStePOUJ4YooCPF72MgrKY48zQVLf2Bk15?=
 =?us-ascii?Q?C4QR9883NRd6u1HqMyxtK5mTWWKF0GAo1DQKpMpueF7Q6Sqodue58OPd7fgA?=
 =?us-ascii?Q?p6Vn7EknhzpTid7eIrszMRT1/490LHPYNUMnIiirIskSAarF5ZfC+xldb+UO?=
 =?us-ascii?Q?/s8zl09jkLqENHYXYJMLkUAQOMeNp1ufjiHr6eX+7K30VkP0KEkwkUIMpTK5?=
 =?us-ascii?Q?dCUCagQ73SDxD+E+R8mgVFxiZCGx5mmhACHuyRFFd5uGN6Z2klli0LdUDLFw?=
 =?us-ascii?Q?WyV0aKFtP2kUdA90+Ea+8JRKVj5nVZPuU90RZmmcNM5MEF49onGsWjlK/I6T?=
 =?us-ascii?Q?bGiY30lDId1Xv+7yq1NIc9RRL0yTUR94XtW0gy7A35yDWQARrVeZI59B/NFQ?=
 =?us-ascii?Q?7UgBWlp71yPAWfSmXKo7/TWLD4B0mucCgB7WzjrkQjzAaYtjAIuhOZHcu9+U?=
 =?us-ascii?Q?7xmTMKKxSjEVwVG/q4I4gpWFvFpsuW/tdfEvso91mEXKFoIKHGu9z96dOOoW?=
 =?us-ascii?Q?JKeb37FHHUjPSLZUCa861pku9luKIQoKCIKvAjbIZ7lQaekbHWBJmcr/Q4w8?=
 =?us-ascii?Q?7zskWCaXhoXor/guKJhs9NrCzTJA/IYOxOkg98VzWQFFS7U/JRuxuLuTmg2S?=
 =?us-ascii?Q?HYvnDrf+jP4iVSvLmJjqIMndPaTh?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 03:28:23.4673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 346b5d2d-5352-4b7c-56ee-08dcdddb4729
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6790

- v1
  - Add i2c-mux for ADC monitor on Spider Board.
  - Revise adc128d818 adc mode on Fan Boards.
  - Change the address of Fan IC on fan boards.
  - Remove led gpio pca9552 on fan boards.
  - Add i2c mux for for two fan boards.

Ricky CX Wu (5):
  ARM: dts: aspeed: yosemite4: Add i2c-mux for two fan boards
  ARM: dts: aspeed: yosemite4: remove led gpio pca9552 on fan boards
  ARM: dts: aspeed: yosemite4: Change the address of Fan IC on fan
    boards
  ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Fan Boards
  ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider
    Board

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 131 ++++++++----------
 1 file changed, 55 insertions(+), 76 deletions(-)

-- 
2.25.1


