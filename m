Return-Path: <linux-kernel+bounces-215116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC76908E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B3A28A39E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058D19EEBB;
	Fri, 14 Jun 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e3CN7JbM"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22FE1A0AF8;
	Fri, 14 Jun 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377633; cv=fail; b=iSzT7gI9mSTwOKkih6mKLbYfMZcfoANxLuq3XUGY/UbaEP0yy9BuhkyFpde3Ady5jLtnJE4pa0bQzjwLqFCoWg08td13W0rHdf09mPhn7tyyH5eXhuhzUFXPGEqVQEX+qLNtVGMVcxaF4COsy4I5DVbYNgP0w9Y6sCGw1U9vT8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377633; c=relaxed/simple;
	bh=CtkKNHUAo2fAzwGqCbTf9SwseCYd1w8VFFilR35ifTc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Li0Bc/yxQb9WvCMbGI8g/XuceDYKy0FdCKo402rdrhy1T4bbWUYoS5MG8Pc7cR07MeF30fRb1R05VJ8IbelxAY05W0DYuKMPtgysbp4sxdfTsqrxrA95oghGLVuVcWdsyqaBl8cw+cNkyvHjGoBSJYxiBg8ougez3xvpaNqPIPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e3CN7JbM; arc=fail smtp.client-ip=40.107.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esQVn/X8nb4CP5P0JKIkk2iYK5YoonYSINiDaTfWWpxCBtR+Sc7Ok1cLySG7AuTxCefbqGiRYiCuT7tRALEriGRUmOeFjldxtbBARDN4sLJXjRgD84MhVWogQRgSeL6aRSO3EHmHauPBOgh0Na3xjrreFKVjzp7upKe828FPRVUbPGMxhJuHM0Aq5aR5hnryS+taAuWV4Hb5EQjIpdQInI1Nw9EImewNR1u5OXeeraGuLufdIbcFUSIHvUC8L1vDOzrU02bPAznMwJPxVFqHwrJO3JdBPUWfh+slstAspsYkHzYYg/YjPpBimkyQbXxQDzo4i8ssXFoUCYQYd4PwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KELo4iICDdoq75xZlnxNbKYIHquYeUyms8sM9HSKKKs=;
 b=e3rpRWBM7t+ixJWrxNXOd+IQsQdTcN1zisVmWOWovzDbVgvcQ8yEjGszydJ/TWuicn0ihUOtv5zahhJoKw4pl3fU0XLrXhmAW39ugkhucDgOaHlNRVxGRiUlBaOicDZjpDgLNvqosR5U7fiJSNl6A9gJAx8wobGFpzok2HMa6j0B7rn/pzbodIY3X00n1el9ei68Io8KZxFd2TxwMrGk2T0uNmpkx1kZ7jAQG3PTfVMw5XyJbVUWMir/KSD+DEByl74eV+IwekSR+XgRas0tdvmt66dTUGxoXUPr+/I9HlHCqtWU6r6umMEETIoJJ80BocQHT9Xfm8No5vnZp83mwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KELo4iICDdoq75xZlnxNbKYIHquYeUyms8sM9HSKKKs=;
 b=e3CN7JbMxJ8XYjvKVDlXXcgVccDV4RJidy2GSPgdj38vJpfQszZO/obNlFXlsSruzIpzKb+22hJHy0QJJlPkhuJPZsjT89l+bOb02bMvKENFc/POO4NFtUF+2pL6ZKjvpMWRX3VF/tq3zrUlQHQ581yb7talXrqQO3F6ga+hqCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:07:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:07:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 11:06:30 -0400
Subject: [PATCH v3 6/9] arm64: dts: imx8qm-mek: add pwm and i2c in lvds
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-imx8qm-dts-usb-v3-6-8ecc30678e1c@nxp.com>
References: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
In-Reply-To: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=2711;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CtkKNHUAo2fAzwGqCbTf9SwseCYd1w8VFFilR35ifTc=;
 b=t0TM9Q6g+eCkyAUjYKJQ5VRZvdmtFGQ6nmSim2X6RsidCTsoMHqx71E1tS1Z8szKQYA8u0yAA
 OInzyND/ZRJCZpC2k2cB68WSIkI1vzgqsKH2DC7E/lIoKyKj9kgVwpd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 80053fbd-043a-44d2-3203-08dc8c83a936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3BBeG56cWJ5VUF0SXVnak9LT0ZTN1J6cGk0am54WFlyWUgwRFY2UVVGU245?=
 =?utf-8?B?dFd5UmJ5eEdGRXpCb00wV1pmK2IvQ05pbzl3RG5vbzM4cVh6UndvbG9iNjhP?=
 =?utf-8?B?a3kxZ3N2Um9nWmFrQkdIVG5VSUh6b3N1ZUNLME12bDlzdlJZZXVSUk9PT2lS?=
 =?utf-8?B?REtEdy91WGF5NUdWRXJJcW9NSmovQ0ZzRWxBL21BR3NNTVgyM29qSkdscVhk?=
 =?utf-8?B?RnVDbEt6TzI5VWQ3eS9KSWVKdnplZFEwZmp6UDJDa2J0TmQrMlhCRGdTVGM3?=
 =?utf-8?B?ZER2Z3U0SVc0NWZLVFBVdlZScGgwelFqQ2U2MzRDZWFWVFhubk5rM0dhbmQ3?=
 =?utf-8?B?eHlQN2pWMUsvQ2hmaER2Z3lwaTVyYm9iZ1NMdFp6U2krandjdDRWaXZKb2tG?=
 =?utf-8?B?SHFZRytHT0F5UWdzaWJVenZvM2gzWnZ6dk9RTGM4T04yU2ZaanNaTDlvTXJZ?=
 =?utf-8?B?My9zZFQyaSt2VWp3UGpMaUV5SEZBcnU3czhRNm1VSlJZQXdhalBWQjhacGlZ?=
 =?utf-8?B?c2ZjajUvT01FYWx6MG1XczVUSVBTTWNQUWYwdzk3Y3ZQeGlsL2FNd05wMG1W?=
 =?utf-8?B?VkVjMU1IN2RmRC84UXlxZm4vTjZ4MGFWT3lTMFNSWVJrNjlEbFFzTERVKytt?=
 =?utf-8?B?NjdsWTVnbUVERWlob3UzaGR2S3YybkZxR3VkVHluUHM0eU1CZjAvY2lEd0Ev?=
 =?utf-8?B?RE01MnRFYzg5dDRibHpDWCt3VFZSdy9nalFHRnhHTzdCcHVwV1huWnhESWFG?=
 =?utf-8?B?NUY0OFV5U0hCV2hET1ZtVWoweVlMVWFpT29tb1MwTy9pNDkrS3JrSHg4Zi9J?=
 =?utf-8?B?REpwMGZyL2ZJZzMwRldyRldMTXN6RVZCM0c2VUQyWHZpWTdEMy9udEFyNmxE?=
 =?utf-8?B?Ni9uRjYxaHJDU2ZrN1ZvaVRaeG9CYjcxeEN4QjRiK1FTQ3NMRW9TaGVNS3o3?=
 =?utf-8?B?OU9Rbm10MTkvdlRobGxNWXE0QUJkVHpwMjUzdnRITm5adW0rS1NyR3o4NlNL?=
 =?utf-8?B?RkR5RDcySTc0T0FUbTdZeVlyMk1hRXI0dit5NmlnbUxLUkRud3lUbGNVYnpV?=
 =?utf-8?B?OWZVQVVPSUx5Wk91YksxSUxMK01BZjE3enRleXpjNEppdjlIQm5KM3ZrS0Jj?=
 =?utf-8?B?dkJ4SG44MGtXcTNEaEhKYnlVQlJYYXRhTDVseENBeXNBd1E3b2UvV0hYUHow?=
 =?utf-8?B?L2NyazUyUHhEbTdCUkFIbmlYNGIzdW5mbThNTkhiMlNDL3VIUU5rdHIrbFJt?=
 =?utf-8?B?K2c3QzZqcjdGQUxENTJSWGZpRkVmOWlnUGpJMUxSQXZNN1JVZjYrbDZnMEZJ?=
 =?utf-8?B?Qk8yOW02VUJOaXNHY2hjUjc2WTdHOWEvMHhCN1VoMFRZUTVxN0lHZXlOcENE?=
 =?utf-8?B?WGx4KzVwWkRxZ3UwZFJFWERmSW1XQWcvb1RWZnM3VG1sa0dNZ1ZJQ29FaCtU?=
 =?utf-8?B?a2ZYbVZlQ3hmejNVakNYYnhmbERFbzVRSHNOSGQwOE15eTNXMlZnSzlKa3Z3?=
 =?utf-8?B?NnNvUENnQk9ncVlqZk5BWmJJQ3I3d0F3VUJWK2wyWityUjJiTWxQa1NQeE9M?=
 =?utf-8?B?Y0tuSWIvNDkrSU9hMVJUUGYyRGwzODN3a3ptOUxEcnpHeXRuZTFtcTlSRUpm?=
 =?utf-8?B?ZWk5WUhlWWFNMXlTU3dYd0p0aFFGZk5BMXlrWWp5aWhZQVVGNGthMFRaYXJW?=
 =?utf-8?B?MzgzNm55NEhIWkV0ZlZibVVOWkMrUzZnNE03ZU0wRmhFVUVndTBpRHRacWZ2?=
 =?utf-8?B?U2x3amRpTHJKN3Zlbm5RdWZ1SGVBNDcxdEVleDFFY1BlVEwwNUpyUzM3Nmh1?=
 =?utf-8?Q?vjS+N9rSQjl2MY4LTZO+8RKSz7QHqy0teX1HI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHNMM1Jad2FWZmFjYk5FeWpIQ25PRCtLUDZDdnQ4dXZ1ekVEb2NBRVh2UDN6?=
 =?utf-8?B?c3NVL2FXVk5aUVNIUlRybGlrS09lNjV3Si93L1Q4c1lpeVBvRFpHZnJ0UThT?=
 =?utf-8?B?ZTVVZktnQWZ0eHFVOU9UMjJCTnA1SDArVmRrdm1jQ3lRWTRLMzlIZkVQM0lp?=
 =?utf-8?B?K2NEMUlwN2pFSnNMQklGME5BWURoeURicEVOTjB6QjZiYXcxZ1loZDB6dEVz?=
 =?utf-8?B?WG84MmR2VHZqOWE3VlJpYjUvYlpmeWUyNWJuTnZYcEd2WVhneThJUUxRMXpP?=
 =?utf-8?B?alQxcFFCejdtRXpEVjJmZ1l3ODhFTVpQdXRaWEUzZlBWVGp3VEtzY3FqU3c3?=
 =?utf-8?B?WlZpTFJka0diaVFNeG9obCtmM0kvQW1YdzFRQkxZUXhuRUxkVTV3S0E1Y2ZX?=
 =?utf-8?B?UjNpQnU2SzJ3alV5bHcwa2o2MGV3RkwyckNyQzlkekV3Y01QTldXY1ZXSk9k?=
 =?utf-8?B?eTdld0dvdzFlYWdaNE9xblRZK3dkLzRIemxrZ3ZURnBvS055cHNFS2llL1NO?=
 =?utf-8?B?ZTZWSVlNeXNJQUsrS0lINUczYkJ0ams1YkkwY01OWDcwWjlHdnJnWWdKaWcz?=
 =?utf-8?B?V2FUay9aOXFwb2VFem1BZHJlM3dUS01seWlGK014VEs3YlZySGU3Uy81RVJy?=
 =?utf-8?B?M2tHaEtvVG1STm5yTWJxRU54bnAwUjNNME5VYzFCc1VHQTBValF6b2dFSlEr?=
 =?utf-8?B?TFBxNWQ1bnlTbGU1SzRGV1JWZmxvaW1wd1dCYkFiekQyQnF6SGpteEpNSk9W?=
 =?utf-8?B?V1N6UEJEQWtRMThoQXk2MzRtVHJQNXFsbFU4T1lELzRuQVdPZGVJL1FyaGR3?=
 =?utf-8?B?N0J6aTlVTllaZzN1SVZQbkNYRDZUZkd6b21VZGR4ZzJ2TGtyT1ROMTZ5cG1B?=
 =?utf-8?B?ZWFCbmEydWlXY3Q4cXZEL1JLYWpGcmRWR283OGNFRDMzdGtOM1pnaTRkVmFR?=
 =?utf-8?B?OUFDQmp3ZVMyMHhidnVhYUNGV1pvVzAxMk93R09mMkNXcjd3TWxOdlZyREpi?=
 =?utf-8?B?SDhqamM5ZFA0TVI1dktkNytncEFEU2pXTm1UU0lXVmtzb0cya2ViVXpUKzhi?=
 =?utf-8?B?aWphVmMxd21FSHpRblBuMy90K2FaNHhyaUd6SU9FVG1JTFQxSVlKRHdDS0xB?=
 =?utf-8?B?djJCVkNsQTZLQ0xnZnEvbVZiY2dVYjhTZ3ZhYnJVd0xaTEl6Zk5RMmZkQXVo?=
 =?utf-8?B?bklQY25YWEc1QWJ4bVJON1FBT04vMnNhWmg2aHhnRHo0dFZ0VEs0dnVhNG15?=
 =?utf-8?B?bzMwU1BKVGdMNm5HakNxVi8xdXFacGJJRzVSMlRDT0ZiSWoxOU53MDVrK08x?=
 =?utf-8?B?ZnVEalhJbXI1UVhLSXdjWjdkaFVuVU5kSWM5R2NtT3kycEVqSWpKRGo3MnAr?=
 =?utf-8?B?cFI0akFxRHluNkpkTjhtdnVxK1JGTWxPcDhNTlNhaUpQenhDcUNWMFI0Tm9G?=
 =?utf-8?B?N21sRnhQSUpBL2RpN0Q1NmRpMWZYOWZBa3luSm50c1g0dUJXZU8vd2dtcm9P?=
 =?utf-8?B?WHY1MEJ0RlczTXBKQTFPcFFaRjYwbktBRU5aeXpGdlRCdjA4dHNqekZyK2hH?=
 =?utf-8?B?VEpQUlhnZXlhN3BYN29TWE9CcmRwUnc5TnhSUEprVStyMTNOcFl3eEF0N2d3?=
 =?utf-8?B?R0pybjlVMXZ0a2cxaHBkcUFsRW9YbUZEb2F5T2MxU2Rlck9pYzltSm1FSTJT?=
 =?utf-8?B?Z0wxaW5Femc5djFPWXFLbkpCR3dvMHpLWkhRUzJLUTd3TkJIellkOXd5Z0JX?=
 =?utf-8?B?Zk5Xa05FdmtickdOYWtzeTFHZ1RWbkl1bWloWmV4aUZtRmN6dXJjZ0grQVhX?=
 =?utf-8?B?dkJaREY5OXFabEJuSjJHRmVZU3hEdmJpSmhOOTBhVDNIckwrQnJUeXRLOFRF?=
 =?utf-8?B?bUs5K0hCdy9rZk55OXhlaEpOd2QrK3BxZUxDL0YvL2ZSMDM4Vk55RVdkVEVh?=
 =?utf-8?B?MGE4VzBpVTlrK0p1Y1RuU0IrTE0wR01hQXVMRGZPcGJxa1dVL2R1ekY4Rmhu?=
 =?utf-8?B?aVlSa3R0VUFrNmlVbXcvaFQ4cGh6R3Fid01KYjBQb1h1TS9raXRnT055L0sv?=
 =?utf-8?B?M2xhZnF2R0dzdEU0WGE1L2RBNUUwekc4Q3N1dUIxbGNVZkMyVUNNbU5HU3RF?=
 =?utf-8?Q?9+SkIIfGTtGnqOYkM3+LYFRPM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80053fbd-043a-44d2-3203-08dc8c83a936
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:07:08.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fa2u8PhI/35WxsptgTvxmTlNCWwHSn6QvkPe3d6hnrSPsu/kXpO+CEKm+A7rJvmixD3xSgG+SScunEggP7h8Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

Add pwm[0,1] and i2c[0,1] in lvds subsystem.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 68 ++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dbd478af2e474..3cf39c868e752 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -93,6 +93,22 @@ rsc_table1: memory@901ff000 {
 		};
 	};
 
+	lvds_backlight0: backlight-lvds0 {
+		compatible = "pwm-backlight";
+		pwms = <&qm_pwm_lvds0 0 100000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <80>;
+	};
+
+	lvds_backlight1: backlight-lvds1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm_lvds1 0 100000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <80>;
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -334,6 +350,20 @@ wm8960: audio-codec@1a {
 	};
 };
 
+&i2c1_lvds0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds0_lpi2c1>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c1_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds1_lpi2c1>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
@@ -449,6 +479,18 @@ &fec2 {
 	status = "okay";
 };
 
+&qm_pwm_lvds0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_lvds0>;
+	status = "okay";
+};
+
+&pwm_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_lvds1>;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -675,6 +717,32 @@ IMX8QM_M41_GPIO0_01_DMA_UART3_TX			0x06000020
 		>;
 	};
 
+	pinctrl_lvds0_lpi2c1: lvds0lpi2c1grp {
+		fsl,pins = <
+			IMX8QM_LVDS0_I2C1_SCL_LVDS0_I2C1_SCL	0xc600004c
+			IMX8QM_LVDS0_I2C1_SDA_LVDS0_I2C1_SDA	0xc600004c
+		>;
+	};
+
+	pinctrl_lvds1_lpi2c1: lvds1lpi2c1grp {
+		fsl,pins = <
+			IMX8QM_LVDS1_I2C1_SCL_LVDS1_I2C1_SCL	0xc600004c
+			IMX8QM_LVDS1_I2C1_SDA_LVDS1_I2C1_SDA	0xc600004c
+		>;
+	};
+
+	pinctrl_pwm_lvds0: pwmlvds0grp {
+		fsl,pins = <
+			IMX8QM_LVDS0_GPIO00_LVDS0_PWM0_OUT		0x00000020
+		>;
+	};
+
+	pinctrl_pwm_lvds1: pwmlvds1grp {
+		fsl,pins = <
+			IMX8QM_LVDS1_GPIO00_LVDS1_PWM0_OUT		0x00000020
+		>;
+	};
+
 	pinctrl_sai0: sai0grp {
 		fsl,pins = <
 			IMX8QM_SPI0_CS1_AUD_SAI0_TXC				0x0600004c

-- 
2.34.1


