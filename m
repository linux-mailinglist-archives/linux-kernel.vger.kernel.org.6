Return-Path: <linux-kernel+bounces-278083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997394AAA6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D691F21855
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA181741;
	Wed,  7 Aug 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pqi0XG3D"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E87BB0A;
	Wed,  7 Aug 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042340; cv=fail; b=UvZWPXwLbqSdKBvFXfUUZHs7+YP9EaZkqEy58I3nL0HL+R82BuuArzzhGLe8h54CGrQ4TS7/9zNOVvoS8CjKFqH/zFL+t4oyidgFCI7aNOTp3G8aSTV3320bVyuYyE1qgw8drhrXjgJ++7laxTxK2pyHuYHJhqtbAyE2H8rtIpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042340; c=relaxed/simple;
	bh=IJ8F/xw1w2cPvCeV+7wkU5NPZKdkCSqR8tXEUnBI9+Y=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=XIZPTh11rDJ+lQF5IjLdyslXXF7q2oJgw5BEJdqeSRwXUrRO/mxIDGWc6WHkGIbQXYyFHzVk5p/LnOXG8/cREMUYLotaSycvfqgs5TuqPhnZLGgGcGBQ82eIH6R3V898KYgtaacyOZ2bJ4fe3nJfx9Q7hs28p2kZdDUp3gbl2ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pqi0XG3D; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYKmFemjIhjWa7KONssLdb4k6MuYEuWjQUYcLoaB0Hwiq/3Y1OpS2Vj5sXTz7Og/acw8nDpQgBcTkmwNdGA+wKiwJNZ/EyGjTIEHKvKndpX/hdWwZE4MZJCiGc30OCsbFso8H3EJz+6D0qSik91OJJJk9cncFBPsP13XsuIsRlqetbNCe2CP7etWtVEZ3zMSzO+ZqsysNclXukX650eZWV5oJ4NZ4+fXTRISpv/52RI6dGAr5xGUD61Flex579/HBiysauAFLs4kgt0Bvs48uwbU9e5cYR9Jxpe6vN6bZeegGDTG7RWDhC49l0AnCY2ZvO9P4ye33amEY8e0tx+KXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rK8UOOgtGpu2TZpit2RuOjlJPWN3rYMFn2faUtzZws=;
 b=lWmvBbRkUNLx124AhiVedLJHfuhz2G7rfLirofIkXiPyn52hRJPl/L9FI/uyDTeD3mQ0YtOQStpyFiUdK83r/ds9MqnigrX9Skow58RQqSgHpt3fawn3R10aYE8uy8PlMs4pZmyyZ7Fn84N5jnBLWDa1EDmX0gfkPuucLJK84mzCZRA1/f+l3r+ChUY2SinSdBCE97+lnczjTQvRjMLUmUkbPR0HvCSFclinaLFCLanZ02xgKTPFupAomZRa6oQOtXg8OoJ+l+1Wgi+J2StepRagjF0jn4cXaxcuYcCAaaHO24HZVLd5lOQs8knCzl+n1SBmigHKzUuxHn2FuhoFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rK8UOOgtGpu2TZpit2RuOjlJPWN3rYMFn2faUtzZws=;
 b=Pqi0XG3DyV3F/0kLm8YIMRNZYw4RUSIN+P78uYYum7a5dCulHIF6P4T7ZLMXJzInzAYC9gSSkiFoeBqY9WftmD+zBw4NTkf8f5dXUI8r48rrqDhG7EqNpNpwJTbGuIjNrCt7X2VU0LYXXvVhvLktpVPE+NqB4O9ZRjOliJ+XEwNzdtvZ2lmlEzNpZws5DLLvQaHGzBxtkAaMuRoTOt6vyJYH4nrQ3QblYBpr1MoenXIcqMvnekfYOL+tJEkhqeB5wmMefpc0Z5eEgXii/Yamthv2y1TB9zBRdq+KuZ3375zigwEw0EC0YMg/H1tVhKJ092LLf7XNUV3MU0GCGJ9e6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7926.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 14:52:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:52:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/6] arm64: dts: freescale: 2nrd clean up dtb warning
 under freescale
Date: Wed, 07 Aug 2024 10:52:03 -0400
Message-Id: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOKs2YC/3WNwQ6DIBAFf8XsuTRAi1VP/Y/GGAKom7RgWENtD
 P9e6r3HmeTN24FcREfQVTtEl5Aw+ALyVIGZtZ8cQ1sYJJdX3nDFRnoOdqXhraNHP7HGaS600bf
 WWiirJboRt6P46AvPSGuIn+MgiZ/930qCccaVqtXFWmXa+u635WzCC/qc8xd41q6trAAAAA==
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Teresa Remmet <t.remmet@phytec.de>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042332; l=1488;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IJ8F/xw1w2cPvCeV+7wkU5NPZKdkCSqR8tXEUnBI9+Y=;
 b=rzyYhqxn98TdplW+BSubtQd3KLDn3QEGmqszyNjD5KuDcdp9SHC+soKveDa3/4mJdE/t/NYym
 a/ZIMq6Pt6KCF78XsBMrBPJJe0FOdSAv6a2aNbFOHWX+UB0fmnPVtEg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fdce03-4812-4f61-5b9e-08dcb6f086d7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cTczcmpjM2RBcmpOZ1hXdVRvNTd5aWVxRHM4eXNEWEJqMC94QWhRamRseGxT?=
 =?utf-8?B?N2xXOXlnQU9RQ213cmNDdHBnaU52VzJISWlZeDdobDFuZDZrbTdrZDQ5d0JD?=
 =?utf-8?B?enhYY2FQSE0vVU1VT05CcXBERGlDa2ZGRFhTZU9ac2c4U3VsRExwZFFiM0hu?=
 =?utf-8?B?eWpnZDdYd0c2L3B4Y1NIS2dJbkRwVlMrTEp3bk0vSFV4SEhubmVwbkFpQlQ4?=
 =?utf-8?B?OEdGblQ0WXZldFNxbGd1MHU3SHI5cXlyNGxSbGp1Q2g2WEtaTm9Oa2pvdlgy?=
 =?utf-8?B?emZ5eEhLNFFwYWxEcnc5ZDRRcWEvSEhMYnZTK0crc3BPS0t5WnRRUVgzVU0v?=
 =?utf-8?B?dG5STHdZZzdwOHBRenV3K3ZEaVpZTDl2WVJpRWRtMHBJai9lbktPZmU3Vll0?=
 =?utf-8?B?K2RPd3dYajlTVEprM1VQV1JNcnh3Y0dOWWpKUk9aaWZOR1RqSXNweVBTbnN5?=
 =?utf-8?B?WTJRcWxsQUg2OXE1c2tjSUp4a1hiTEo5OXkzQnJZS2hHb1JyVDFxMnJJTDNy?=
 =?utf-8?B?clJoSURFdEc2MGJWY2J4UUd2OHFyVjJnL3dqT3VwZ1pJSUpnSEpQcWRjVHdt?=
 =?utf-8?B?SmYreC93WnFNaEJvOC9ybmluZERzcDFja3FyU1FjMDViTGY0QzBzQmlXc05U?=
 =?utf-8?B?MXMwWldkUnF1VXRPUDNUMmJzZmxuSUhuR3NaRS9UT2dUN0hSdlhWMWoyZ1ph?=
 =?utf-8?B?NS9YcXEzWTFsQm9wT1ZiNTQxQmwxV3NhbzNWNnFDWTh0N092b2Q3QlkybzVa?=
 =?utf-8?B?UXp4QUJsbHBoOU43UWMyRkg2VEtmSDZtMVNSRFhCbTB1akZnbVlJb3hFVXJv?=
 =?utf-8?B?QkZkSi9OWUM2NVpDN0U1U3VoZzJUaHdLUzRDYmRMR0dYenFGWTFQYmw0bGFv?=
 =?utf-8?B?VFQxNHh4ZHp3REV4RU1QMmZLS3B6cEVzTzJUVkI1S2NMaEFDUlp3a080SHNJ?=
 =?utf-8?B?WWtpaWtFM3hsZjJBREJqYU45dEZDSWFNQVN2anNCT0Nta3VNenRyU3JwWTVQ?=
 =?utf-8?B?eE1pN3pLa3hMK0l4aS8rd3dwZ1daSWV5UVlvUVpNVjMxcmQ5WUNxSENRL3Nm?=
 =?utf-8?B?MWdPM1lXeDNNZEk3ZVladTNFRnpHS0VITTkvMGQ3S1dmVnZUME1vaFpBYjQ0?=
 =?utf-8?B?aWVwODg4ZGFtRk52OFpwVFExVWRheGhqU2ZqbUpQNkpMZGdlc3dZeCtoYmpp?=
 =?utf-8?B?Y3ZHVS9xcThycThza0phL1Q2MElhSHJkVlkrZXgrZG9YcFdJVit5elhFVnVh?=
 =?utf-8?B?ZElsZExRNndKZ2k0dk82RTZoQk5RdlFVenZxblQxRDVOaW8wZEtJN0xWM2lT?=
 =?utf-8?B?TnBXeVVNSXp6cjI1dnoramtuWDN3MDV5VkJSUzJZSXl4YWFCazRsb1RSN1Ay?=
 =?utf-8?B?Um00L2JTNnQzOE5NVjY2WHI0RkhWV1lUK0NKZVZqM1FOSXRTWXlKdFRWOWhV?=
 =?utf-8?B?NkpGNVpLZUI5VTJJK3NrcHpXNDNDQzNKeVZ6aDVqemRPYzhkQm1Uem83WXk0?=
 =?utf-8?B?NGtRVXpXZm1ydDFPb29yQjVzaXFSV3ZzaUZsLzRtWHlYbWRIcDhvdnNBNXo2?=
 =?utf-8?B?Q1MwTERMTFFEL1NTNk9JWG1SZDVua0RDSmc0UTkzK28yd3VPSWQrVXljczNP?=
 =?utf-8?B?cndEUlpHSXB3em8wdm4rZE5qQXdaTlpnMEFoRTlBbUc0TTFQamM0RFhncXll?=
 =?utf-8?B?OUg4SllIYzlJa3EvYlIyeXZXWnhWMlBIQW93eXFjVnFOUDUvbDVuZURZa2V4?=
 =?utf-8?B?TzhqRFZ6clN2SFkzMzJhVGVCOVU4ZktyS245NVdQT2hNR09DNk9jcWR5aTZJ?=
 =?utf-8?Q?7oMPE+O0hiG8W5V1X1IiwHMRJtEfQlcDn26iQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VVRUdW1hWk9iMXJlU282R3N2b1BnT1h5OE94WGtiVnR4R2E0WDlHeEpEY3Zj?=
 =?utf-8?B?WEc2Ukk3T1JoS0gxbUFZOExUYUFEYUE4dm85SXlZRTZKelJCSzFNcTgvdDRL?=
 =?utf-8?B?YzhtUTlwanUvbDJRVDhtTGw0eGxySkpZczhaS1Z3enJpU08zMzVPWTdYekkx?=
 =?utf-8?B?TkRGL2hVVWdjV0czUFR2VHZhY3B5NmNXNEZVMGZ0Y09BeW9WTnlkUjVJblpC?=
 =?utf-8?B?UndIeUVuejRvSFZjL1diTmE3WW4rZTljVTR6cEJXYzk4VXM1Sm5LV2lFSnFS?=
 =?utf-8?B?ZWc2ZE5mSzI0T1dDSVN5RW9GYndxY3NMd0wyL1Aya0srTGJSMEpwN2w5WE0x?=
 =?utf-8?B?ZVc2TEtWaDVsbTRiQ005eUsxWGduQzk4eFpXOVphZ2g4amd0SVJuUEJaMUc2?=
 =?utf-8?B?UzBiS1phcGw0UXA4S3E0Szd5RXk3WFNYRGpvM0hSOXFPemhzMDBtM0RBdHhj?=
 =?utf-8?B?ZThPeW9qNmNZR2ovL1JOQUQveVJPVHFham5QOHF2cTVVdVRZbWwyN3hBanEy?=
 =?utf-8?B?bHBTNkszcFIyM09QVWNaZmNkZ285N0duQlVnWnVKYlJ0Z0RlNjN4NFFLZXIx?=
 =?utf-8?B?d3A2eHZBL1FYYmRrVE9zejBHRGRaZGJoeDhlcHpvSUR3TTdtY1VyMVJ2WW0w?=
 =?utf-8?B?aU01WnRnR1R6dTg4NGpDaGovV1lHMTlTV0wvbkR2MkpkL1FIM2loT201VVlB?=
 =?utf-8?B?cXhMTnNVZFdBaUM5TG5CTkRrRDRaM2xuWFkwOTFFblpLSjNTcFZDNHVIWEdt?=
 =?utf-8?B?RjZ2dWNhT0p0NXY2THNsOFgyQm81TngrNUNHcEV4c0ZnS08zcExhc3VsbzJB?=
 =?utf-8?B?Nmc5VzVsRkNBa0c4UWdscGd0cXJ1clJOOFA3RjlOOTlyUTk4c0FRNzk1VDR3?=
 =?utf-8?B?blovUE9DUlpOTUh6UFA2K2hJbU9zS2MvZU1YTTNFaFg3ckJxaEE5K0toRENw?=
 =?utf-8?B?UE5RV2xCemR5MTJGWTBXUnJhZHlMcXJWMW9hR3Vwd2Z0ZXBJNjBMRDVGZmo0?=
 =?utf-8?B?T0RxOTZBOWx5ZzB1TDVCMWdxclBObUF2Q1Y5MGE0RWc3OXhPbVFTWXg4R25P?=
 =?utf-8?B?bGdqb3lQd29HWDlyV08zQmE1SGhtbVZlaGFVVUtaeHZCMzQrR3lQcG1pQmJS?=
 =?utf-8?B?VWZmZmRHSkM5TGlweDRSZjd5SEVBMHBJMVB6aVA4c2UvVGplOXdCMldoVEtK?=
 =?utf-8?B?Q3hLWmN4cDBZa0Z3bWJhV0VJUWloVTVRSlRVRE5OVmdYSnZvU1FicGNrTnY5?=
 =?utf-8?B?NVpGQStlOUpBcHRYS25HVUk3MnN6VWx4RXJXMDJ2VlZmZzY0T09UNHZFY1k5?=
 =?utf-8?B?YWdFcWFaM05VZzdRWGZtcENCeTJBMzArY3FHUzV6M291bWZPbHkrd2NIL2s2?=
 =?utf-8?B?YmpKSkhTTkpDT2lORXJkQ1RaZlJTSW9jQytabHQ1TW5RRDF3SXFUNENLbVVu?=
 =?utf-8?B?VUE2Z29VWUdHSjAzeFdreGtrbDlNbHVvWWZQQ1VRbGlQRk5Nb3BtV3RNN2RD?=
 =?utf-8?B?b3dWbU9QN3BYbFhOemxSVXl6b1RCblNrSFdUZndKdDJGSytvd0ZEenVPQk1k?=
 =?utf-8?B?L0IzSi9xM0ZrZmwrZENUdURiQ3RjaURRak1Nb1I0MEE2dmRGb3Nha1Yzdmsx?=
 =?utf-8?B?aWN0MGdIekg5MCszdnNzV0ZoUWVyYjhpVlVXV2xPbzU5ZTNZMDFIOHcxdk5m?=
 =?utf-8?B?OTl0WVI2UHYvVUtIZGVYYnFkeDcvVVJHemFVaFMxeGZPME55TnhzZWI2d3R2?=
 =?utf-8?B?TTM5QUZVaHBXcUZRYWJCdkxid1JHVVJvSFVkajd5eHRnUVRLT3RlRnRKVjc5?=
 =?utf-8?B?MUFJeHhia28rbzlwL2dLQUVxbEVDTDlYbmIreHV5aWJzOUpJR1hLSFNKYUdE?=
 =?utf-8?B?aW9wUXE5WXVtUmpVbnhNLzZKdVg2Y05OWjRVcXJ1WTk3YjFFNnNIMWJ4Wk1G?=
 =?utf-8?B?YXlQbFRiT0QxY2VVQ2JieXNkK21uQmpwaWdVaDRmNFE2VXRWaHBIay9kYmE2?=
 =?utf-8?B?b2lWVFhrbUc4NzdGeE90WHJpZDJOcnR5cWlQUitkN0ovQ0ZWbU9mNjJveGkx?=
 =?utf-8?B?NWRhaWZJLzRYdkRIclZBMGhaOU5WRndmRUJCNzlQZzlBb3h1SlZOdk4rWXdx?=
 =?utf-8?Q?diIY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fdce03-4812-4f61-5b9e-08dcb6f086d7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:52:15.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jtDDLpzZfVQIRMygSPB5PLM2cLF/VcntkCpeOZh5AR2B5tY19X9Zgd2wVhssUVLV+dDUHWkynZn5p1Y6yrp5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7926

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- added fixed tag for arm64: dts: imx8mm-phygate: fix typo pinctrcl-0 .
- remove compatible string for dto file
- drop patches, which already in mainstream
- Link to v1: https://lore.kernel.org/r/20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com

---
Frank Li (6):
      arm64: dts: fsl-ls1028a: remove undocumented 'little-endian' for dspi node
      arm64: dts: fsl-ls208xa: move reboot node under syscon
      arm64: dts: imx8mm-venice-gw7901: add #address(size)-cells for gsc@20
      arm64: dts: imx8mp-data-modul-edm-sbc: remove #clock-cells for sai3
      arm64: dts: imx8mp-venice-gw74xx-imx219: remove compatible in overlay file
      arm64: dts: imx8mm-phygate: fix typo pinctrcl-0

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi              |  3 ---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi              | 13 ++++++-------
 .../dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso   |  2 +-
 .../dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso   |  2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts      |  2 ++
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts |  1 -
 .../boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso     |  2 --
 7 files changed, 10 insertions(+), 15 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240805-fsl_dts_warning-8ea01aca79dd

Best regards,
---
Frank Li <Frank.Li@nxp.com>


