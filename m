Return-Path: <linux-kernel+bounces-362299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD999B349
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A471C210CD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9F155743;
	Sat, 12 Oct 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WID7oJy5"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CB14D2A7;
	Sat, 12 Oct 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731439; cv=fail; b=jEoM5GE1xdGFdzU4RmmAPmDoV+IeDwPNsNiNAXO1tDR2rJQjxvoCLvnTuhIkwCO9IvoFYw4o7qur74KpIZnsk60gcbVyprGexZlo2v7lsmngFc1nebDjLbjK2GgRkKCu9UNSjEVJiXKlxAorL1BDGf3DaPVKUJ3/fDiiXTxxiNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731439; c=relaxed/simple;
	bh=uItr+G6d6wMF7OcvJCf6Ia60b7f0xcDrF5BV51xn2Y8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mEnM/bD5Typ6j5pdgpUigJvgAmOGtfetTsvnxLU6rvaFEdRGvO3Z3JF8J1U0elsS11z1Xst2O/DkdW1U4RyuFicpSme/++uXm0sLacMVQ9oAZ0EI6H12wSoSFD6UK31e317MwR8nyYCCBUnViYndIaHFlOG1DheT8ZenMKKCmaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WID7oJy5; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhnahHJBj9CfhkKTqhtoYY/xty9ejbGI2ueX/GdMY3VixEinZg/IYq9NtyOvvvmSCMCFvpOfW238WT2y38Yl1DlEeyDqT8TwfL4NEMi+1SJKaqMukh3NUav/sSfmptEs4hGwuBpU0hYQ3NAoxszcU39eyL0wf4mleiiKgbFAKDtLMJUg2Q00vlnjegxg/gMnly75ecrlaNgFkNSi5K/JmWv1TzINl0ck0zqlEK5qU0zMD88HbretvZDHhC6yY/eJU0esScdFaAS2A6SPVZ2t5av4HM2o0ScKQTEsqtivPwOTRS7D25sRAi5YgW+4B3JdCAIUrvY9UQYKRnUy0HEE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/4MhYr6X3GUxf52X5VUm+bI/w8ffPy1ndC6bYAJ81U=;
 b=PO1Va+Dshac0xloDxGYqf+Amp920h5mdodMkJAICaFf5EX72KZxxBAUlbKRewTdXUxcUSujw5HGkOB8/PBbtN/Zu5PS+jXt9MCqRzugTVz1pUgzejbuc7Ax7S2smjpvSuJ38hHaACJzxqDj4QGZTjV6gYFZU3xEdJdy83kFsvK82nY9snk5UOb075bO/sNA+rtdNnAHFd03N2f35jh0lKGqR9/2NM0vs6xRDG43fmvPLNF+W/OOvr1Q2d/5M8tS+M9EIs0AOvVnpITVFErK1pHrdvKfy+ettaGsIopHMecv+uemamttin1TuNIPPeZq57EIwnjKkE5KiUObVYnc55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/4MhYr6X3GUxf52X5VUm+bI/w8ffPy1ndC6bYAJ81U=;
 b=WID7oJy5FNL2PmxswNC3fR9kSdVa+Yj7Xns2GTnzwnS5dyE9YfRM6xmz+UjTfzLh6MVGr/EJIenCW6mHD6aF1WBIDCkAUuWhXHE4cK6jyh3yY0uVMCnP+vv2PYfg+hmUGYqvfjqYQV+ZPkjwQO9t5jbMIooSh9nkMqrev8vElXXAisDlSMpnJX5LIqo+zVYvoZK+fB3trPYJHydydZp0vW+zKwF1IMIxwtpdGXMPFkzn/kpYazDoBZacm+wSZVKTsAyaZFK8tDBTGYjwi4Uwu1P4NnNa2xozZPmrtFpQj+oLvgeJ+iOOLfM5k/q4bYQpCG4MeYeJi8L13mylDDlyhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sat, 12 Oct
 2024 11:10:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 11:10:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/7] arm64: dts: imx95: add various nodes
Date: Sat, 12 Oct 2024 19:19:07 +0800
Message-Id: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACtbCmcC/3XMSw7CIBSF4a00dywG6AscuQ/jgMLFMihtoMGap
 nuXdqIxcXhO8v0rRAwOI1yKFQImF93o8yhPBehe+QcSZ/IGTnlFJeXEDYusiZkj8fgktuuE0tJ
 qxQRkMwW0bjl6t3vevYvzGF5HPrH9/VdKjFCimG2lsJVtq+bql+msxwH2TuLftvy1PFuBppW1a
 VhZi4/dtu0NrpnIluQAAAA=
X-Change-ID: 20240902-imx95-dts-new-fbb8ac9fca18
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728731962; l=1490;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=uItr+G6d6wMF7OcvJCf6Ia60b7f0xcDrF5BV51xn2Y8=;
 b=9Ny3x+4XZ4xzVO5WAcHCBYqBnNkiWW7tVbP4rtV2dHhWPPiLGo4GXFRPsqI9AdCvyixV2on/3
 bNoN6eX2fJGD7vglPdRsIoLBo800p+y/ub3pNSo9ntgYoJ1IGigKkyh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0cc3f1-6898-4b5b-b9bf-08dceaae7db6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmMrSWxwVXBmbWg3Y3p5UVR5Q1huRkUxWXJNRzdHcmhDU0hCN2syOCtNWUh6?=
 =?utf-8?B?blBYVWd2RXZsakJXMUhHWTgvNDJlcHUzYnVZdGQ5TFo1eTB2aURTVHZ1SS9P?=
 =?utf-8?B?L2dLS0pSNUYrVXFzcHEzelMyYmt6Y3J1NURaRmx1OVlKNW9COVloZ2Z1SlVx?=
 =?utf-8?B?cTJOYnBsNEFPZDZTN1VvWWZBampXZnhFNWUxVW9xMzZpT2loUENPU1Nwb2tX?=
 =?utf-8?B?Tmw0SW9xcTE4K2w2ZFRFd3lyUWNRc3FGYk9SVTQ5dFo4dHkySHB6eW1OaE9y?=
 =?utf-8?B?aHI3a1hZeEljNGRPQ21IMFFEUU5JT29Jc1VlVEdpTzd6V3Y3NmxEblhhSjB4?=
 =?utf-8?B?a29OejBBVEFkSlNiRlBCSkRYbjlzZFdzRnJLdlk2R1pXNVFkVndXNDBRZzhE?=
 =?utf-8?B?bU51T2poUGJVcDJxN09ZcURmMjhZZE15SWRZbGQ1RzVuTHZqanRYTnJvVWpI?=
 =?utf-8?B?ZUlkK0JnanJRN0NEVW9OTzR2eHg5S0J2STdkUm1tTGlqekd0MGI4a1RZQ2Fx?=
 =?utf-8?B?Sk5ueHhtWnIvaWh6OTByRnBtUWxVRHU0dDV0cm9TcW4yK3FkQnVhNStXdXpl?=
 =?utf-8?B?ZFFaSmZ3a1NzMS90NVhmTFJURkZsYXdkdzQ0UFNZSWhCb2R3NWRUNW9nMG91?=
 =?utf-8?B?OS9ERG1oWjVEcTkxcnM0VmdFQTBkOExSaTJIY1FJOXduUmZjeXVmOEp4QXV5?=
 =?utf-8?B?b1BJdENwT2xNbDJ4WGFRVHpnUkNKRTVCMFJUUkRVQWJMcnV0RUZqWWhrSkh6?=
 =?utf-8?B?NzlyaVFqQXVFV25YUWRlVU5Md1BWYUg2MnVBNlY2WHBwYnJjUEJ2cWRxVGNP?=
 =?utf-8?B?L3lPMGVrN2Zyb0NrRXNNZ1AyZUcrd25obDU0TnJFZzJ3SmtXMHhJNjNHeWVv?=
 =?utf-8?B?cVJ6NmFsWDk1ZTBGd01CZmUxKys2eE9wbm5YTkVSdmhpRlR3YVAvMitCOWlj?=
 =?utf-8?B?ZWRWdTkyWkZEWGgvNWRlMTVQYTM4aWVhM2d4Q2NQeWQreDhKU0RhV3V3RndK?=
 =?utf-8?B?MDZML2hGSDJRN3lGVVNEbm0weWRsSjZiR1dxdk15VnZtZTNEcWlsc1ptT0l1?=
 =?utf-8?B?T29ZV1ZyVnk0SHhnZlNvemVickU2MEtNMmhpNExoZUdvc0d0aHlhdWttR3Ny?=
 =?utf-8?B?TzBLY0Q1RGU0elJMWHV3Uk1TQmlhZm81QjAyVVpFWkVsN0Ric01nN1VId3lF?=
 =?utf-8?B?NmoyeUZRYWNPK1UzSGZTVTVjeWIvOU0wRldwamx2TmpQZ1JvSmlMOVVaeFA0?=
 =?utf-8?B?TERvMmVXVUx2empFZlVrV0dBNGFNNy8xQXpja2FISm5vWHhCQ0dJN1M3bEdy?=
 =?utf-8?B?a2RPVEhpVFUxSGUyTHRnV0p0RThua1FrKzQzT0ZPZGhuK3I2Z0pYcVRZMjlZ?=
 =?utf-8?B?QnRpUDdsdmJZTjdWeFRqcHQxa3lsS3h5S21UeStRQVB2bU43MXloMzdLQXdo?=
 =?utf-8?B?NlpPcHZHV0hDRnVTZndwWHFiRjJFNmtVNkhjcEVDRWlBZnJ2c0JzYUJJWW1W?=
 =?utf-8?B?RFlOZ2FuS0E2R2JwS1hxbzFUZC8zOUl1cm8zMUFuRnZORjE4MjdQUlRUaWhB?=
 =?utf-8?B?Tjd1bzd0RnZuRzZmRnNWcmxINTdOK2prajR3dzJoSUNCMTFNRUxyTm1EUE9R?=
 =?utf-8?B?aEhnZ294bXFqdk96T2hOc0pNYkFBVmltLzRsTEtRRVJoZ24zcko0QS9FN2lT?=
 =?utf-8?B?QXlkUlBZVnlQaDZLVUV2TlVKaWpmOURkZ0NaRW9DbU1PQ3BLN0dsMmY3Snlv?=
 =?utf-8?B?eTVaZXo2TUNmUlh3VEcyRXRyMmR3RSt0V1RCL2IwTk41eVFHcVhqakk2dGxR?=
 =?utf-8?Q?5rgSU8esPsXZs5i2BYIlJIRGJQDXsNFd4crgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUdIZ2g3VTg2ckZpTXA0dUNLRENHT0tnZjJ4RmJ6b0E5WWxOS0UzQ1BZa0kr?=
 =?utf-8?B?MzYzVzV3NHN6NmQxYVNHN1VxOS9BWmd1azQ1amIxaTdadHZOYzlQcFRKRmQ2?=
 =?utf-8?B?cm5hV1BFc2ZvUGVneWs1YWVtbnNTTVArcHhyYUtFT0hzWFd2UVJ3VHNMUkNW?=
 =?utf-8?B?OHVpVDlRQXNkRXg1S0J5WTAxYWZBUlZCNm11VnQ1cVViU2s5RGlwOVI4ZmJv?=
 =?utf-8?B?cHJ5RmpTR0FRYXMxRXlFL1VDN3pYWGt5aGs4L0IrajlvUEUzb0VSWUc1QnpC?=
 =?utf-8?B?R2VrUkdTQWNxd3VSdHUvRlBERVRLaUhmc0RxRVNSSHBBUTdoQ1Q2NjFGYzdK?=
 =?utf-8?B?NnVCUmxrOWxiNmZqVEowVm1XVGt6d1V5c0hBOUpUTm9VM3RIRWJ5emcrVDhN?=
 =?utf-8?B?amZpZHgwK2J4MWkzRHNUZ2txdGh3dFNhb3JuUFF0Tzg2RmN1YW1rSUZxc2tP?=
 =?utf-8?B?dlhhTHBoMkRWaDBaYWt1d1VsT24wdnlCOWw0RENPTjloelhTaTlSZFpwMEw3?=
 =?utf-8?B?RHZPL3pJQjVlZDFOOHczM2RMNGliU3krTmRLN0RhNVFkMXYvMStNcUxUS1N1?=
 =?utf-8?B?QjZqV3hIWEE1Ti95c2JoTlphQTR3RFBRQzhLbzcxZTQ1YmNtRWFjWmFvQjFR?=
 =?utf-8?B?aGl6RHRaQjd0TGFiMEZDU0FVL2N2Smt6S04vU3lCQzJ5bWRyTTViS05KRlg0?=
 =?utf-8?B?NldSV1BPQ0p3R1pVRG9tVVRENTVXRjJ4Z3o3SUNBU0l2SGtxTll2RFBRQUts?=
 =?utf-8?B?UTE3QUVUT0pEVHN2RVI1SFFia1Qzc2VQZXBxc2Fua0xXQ3VMY21OREtURzFi?=
 =?utf-8?B?Wi9mVzVkWWtQeEJHRXBnOTJ4Rk5NSUhqVEEybXhaYkxJYTBsZ3NTSjFuR05L?=
 =?utf-8?B?MHVnV3BTK2dVVXJXL2dkVGo2OXBwODJhTFNwdExxQTJpdTJzc2xoREJtU3pK?=
 =?utf-8?B?QjNUcHZMdGFZMjMzUTdqVE51OEVieVJzaXFCTVZLMy9zWXJrOWtPVnJXV2pN?=
 =?utf-8?B?YTF1NldFWFhGRnN4V0U5eStKWVNyKzZHT0hSaG9BRTJGNUM4SEJKQUJ0NnpI?=
 =?utf-8?B?R3BrK1dIbE95WDliaGVWRHhNT3pSNG5MOGoxK2FNeDdiWkdQNWhkU2JpOUUz?=
 =?utf-8?B?MVFYTWdBUWxORVp1bmpCYUUyaEROU1o1VVR4ZEYrV0FnTk5saGxtVkNCNXhn?=
 =?utf-8?B?NjE5Wk96VHNld1pTVS9HWnZrQ0gwbXJvNVA4VUs5TGFabVJyVURyekdiSVlk?=
 =?utf-8?B?dkU0dDF0dUVvd3lQcTVKSzVTYUo5cHBzSUVseXlLS2xiMkp4WDlxb0ZDcUZz?=
 =?utf-8?B?eEM0OEErTFBYdmFKYkJ3dEZlZmJhbU9ZTmtPQzd2SUJIVmFHcFI3SUtrM0w3?=
 =?utf-8?B?MEdUUE1sRmxxODM3UmRnSG1LaXpXa3puWjFkU3BhNldwc0ExcTd6d3NKYTFo?=
 =?utf-8?B?bDhSR0JWZmJFcVdZL0JsVmRobGVRKzZsMWdjTkxmRmhES3d5c3JVbWxuUUZm?=
 =?utf-8?B?RkhlUFRuMGhVZU9oR25mMStEc1BSWVFXbURVcVRIV0ZzK0JzUndIME8vNUJj?=
 =?utf-8?B?NXZhR2ZNcjF6Qm1mMHREc2htaDNrQmMwU0VvUytOalVVc1N1SGtKRUxTVXlh?=
 =?utf-8?B?YUdsaXhzbzJzYWpOV2R3bUFNVkNoVkIvbG9oaFg3MEdYTWswdnBwSHVCZUY2?=
 =?utf-8?B?czRRZUVDSHdIb2lLam4vSGpTbFJrSFYrbkJYcEcyeE5WbE80SGlmWXRNY2dk?=
 =?utf-8?B?WmRRNUJKS0U4RndyYkgreTV3VGkwZmI1ZUk0NG0vL3B0UmxHY2V5OEpYNVl1?=
 =?utf-8?B?SjhXQXdQb1p5bHBiaUg4ZDErNVFZa2Q3bVk0eXAwK0Y4RzMwamhPbEp0UnJJ?=
 =?utf-8?B?UkFXQW1DTDNBdHkwRVZDVnZUVnRyaUdKWkJQNUd4VHoxWDRESlU1S3R2VEJw?=
 =?utf-8?B?RlNDVlRHOU9hbjk5Y3puSzR4dFc1YVltamxFUThranJpYkVXbmRBM3ROdTBH?=
 =?utf-8?B?RjRENjk4S1NESjN0Z1VRakFQZE5vTnVYRXNxTW9YQ0g1ejJkeVFmbmR2MlBU?=
 =?utf-8?B?emsxZHhWSitOcWJ2Yk1tektxZkVtVmhqYW9KNDlEWVlaeHRxYTZldlB1QlVx?=
 =?utf-8?Q?1ypXpwMxkXn1WNAQ7iSx4Jjlu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0cc3f1-6898-4b5b-b9bf-08dceaae7db6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 11:10:33.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqYLIqag7LoBRf0xAJ/rZJNxM7a2M63MP8XZYFEHQRQ+/+4iYPAarSUyY6ekB+dmKQ+UxZzN8F/9+2ODs/sWUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771

Per scmi binding doc update and i.MX extenstion supported, add the nodes
in imx95.dtsi.
Enable cpuidle for A55
Add anamix temperature thermal zone
Add lpi2c[5,6] i2c nodes and sub-nodes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Rebased to linux-next next-20241011
- Drop newline in patch 1
- Add R-b for patch 2
- Typo fix in patch 6 commit log
- Drop "freescale" in all patch title.
- Link to v2: https://lore.kernel.org/r/20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com

Changes in v2:
- Use generic node name "gpio" for gpio controller in patch 7
- Link to v1: https://lore.kernel.org/r/20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com

---
Peng Fan (7):
      arm64: dts: imx95: set max-rx-timeout-ms
      arm64: dts: imx95: add bbm/misc/syspower scmi nodes
      arm64: dts: imx95: update a55 thermal trip points
      arm64: dts: imx95: add anamix temperature thermal zone and cooling node
      arm64: dts: imx95: enable A55 cpuidle
      arm64: dts: imx95-19x19-evk: add nxp,ctrl-ids property
      arm64: dts: imx95-19x19-evk: add lpi2c[5,6] and sub-nodes

 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 86 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 68 +++++++++++++++++-
 2 files changed, 152 insertions(+), 2 deletions(-)
---
base-commit: 60a03dd365b421d0ddf2d8ae873701f90f9642b7
change-id: 20240902-imx95-dts-new-fbb8ac9fca18

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


