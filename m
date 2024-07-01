Return-Path: <linux-kernel+bounces-236520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292191E356
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815E3B23B17
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DF316E89C;
	Mon,  1 Jul 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cz1TbZ8H"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0616E876;
	Mon,  1 Jul 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846255; cv=fail; b=fTcmS3ZJoGdXohgnVLKwHCNJc1s2eNLH7tXX1xlIGg908f10TbRAnUz9CCSVu+ryLKcdGU6o6w3CTzzbaJa0mDStdH0xqoGNXv5Wr51DQx8XG6lK+1VWBzdl+acmfshWzzC62bTQwI40kAF5EYfZUEMwcTeX+DwnqRXSRO4lDac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846255; c=relaxed/simple;
	bh=CF7UwqduZwpqhY3U/N5j8+mDXzD0QcABhAyez8uQB3c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NGbCKC4WSXKKLPZPzvPuVSQd/2cjnX6gOAbqFo31H95uNjB+MDLVzGigi8y6tPE6ZWusk8RrLectCW5AqXq258KtMWdNstowsRnplZ3vvh73yv3j02D6sGbbfHfrWGw1roGq+G9Q7ASzDkCgV1J71laps7uvSiaPW6NYvpNUEEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cz1TbZ8H; arc=fail smtp.client-ip=40.107.249.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIeIn3LH7j3dHRIP13FnXq9T78h++isJVbsffwIlH/98UhOB2zr8qUID7gJ4/AdL4RKCx4j8fvm4xVx12kiiTid93P504CXjib5LPbs6+lfqriv4vh1Tbtvi9h+YqZPGNx4wmB5yrMj+kNDQzQyVwfGSR73o6ADTmaNWKQ36VFHvWRf5SZ9BxctTzSNTHSKRflo98ArtNke2EDIYzwBAFeRpYqUlaDZ2VfAClRPDY/UHWH0znk+cwE7vrvQbU62RBS9afyhdZz+eg+zBnbvyhEadYOapfQ3mTI2VdQkI53HUHHM1uW+Cq0pqSy3TitHlnQjUq8UKDWn80BOQ6veaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/VY76zRjnaqS4fCQBz6agVqIF8SpFrTPbVKoIq0duM=;
 b=mGJBlN6pdvI5mngJrFTA6JCQKMXUVJYVSgJ5ZTRQ4vlCbwsscO/lY+daU7y8r/plkjfPaTa7p9W8vktVy4BV04Zz/VCNdUKdLpXksDHNhwNdNJSW55/9m1IT4/1ipvyiwLGN0XLxSCdWabogEHu13kx/NfurcwP1dJllQxm3YJB1eUIIjwR+HOCSqTTls84ndRexqvq0Euw5QdQA2Mka88D2CXOB99qgl3r9RBbzxvGy1MrPo4/FwSGxKNjuMu6t9CYzHua15vzihdk2Jvr0UIL5pArJY9GefJ/EdkjSMXEoLeX6WNdocD6CYICDIFiplXrFKiaCOqRlHPh54T31zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/VY76zRjnaqS4fCQBz6agVqIF8SpFrTPbVKoIq0duM=;
 b=cz1TbZ8Hx/S7Wk/Q0oyPWJeqMJTO2vCvXeb4fE9XAC/9qrURwGMaSObvkfvporF69IAKf1VFScpbBZd55gbAtEwajvo/AkSSpRZx6yH39kuwwIaVd7bXhYOV8wy6arHZwN0dv9EaQw/cqEj8MFqhMEdUIdOSlB7AYWwiSArR24k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:04:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:04:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Jul 2024 11:03:33 -0400
Subject: [PATCH v4 7/8] arm64: dts: imx8qm-mek: add i2c in mipi[0,1]
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-imx8qm-dts-usb-v4-7-03cdbc8c44b6@nxp.com>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
In-Reply-To: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719846224; l=1699;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CF7UwqduZwpqhY3U/N5j8+mDXzD0QcABhAyez8uQB3c=;
 b=qBE/fOnIH/CjUfJzRRifvP9rJel11QtcQQnER4md+RRu9oclW96Ujnd+uoie5UxqGlVRHwjcf
 /n6GydRpEIvDjwbPBYRfgKfvwha5qtF029rtf8iQcXxln+HOhTVcQ0G
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 15358153-776d-471d-46db-08dc99df1118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTZ0Nkg3QU9lV0JIREZHWEFQSGU0WTB1Q1h5TkFTdDNwZlkzK3dSdHVKRjZv?=
 =?utf-8?B?UlNGajBDZ3lObG5nZzduU0hyeU9IUzZyaHJZVnUvMDQxRWIyK3dyd0swK0RH?=
 =?utf-8?B?NENvUlBobWlkaW4ybGZMc1psK0hnWTRpQzFncnpWYXROYVlMT2RacjVWcUNz?=
 =?utf-8?B?WE95aUkyWkxEZTFkR2Y5UkpoSHFuODJyZ3RzU0tkaTlkTzZXMGIxN1o0aVh6?=
 =?utf-8?B?ZEVZM0pUK1QzRXlDVDNwckVmWUhnVGR0WUQvMnFmVWdmNEVNT1BWK1hTRHNV?=
 =?utf-8?B?dTloclAzcitObm5uWDh6MnFQOTgyQXVkMFZZM3dnbm1oU3lZOVIrUktEUkdT?=
 =?utf-8?B?eFNPMFRWTXI5b3dCV3FhWXlOOXZLV3JjK3BVaXY2SGpJSG1aZW9CRXZpRWpt?=
 =?utf-8?B?aC9qSEhnUmRSMXVrSFIrR1dwYWVQdE1TckJMNzZxSXNQSVBWekRKSFI5dGwv?=
 =?utf-8?B?L1ROT0luNUxQdDZZL3htVHVjQmVZQms1aVR1RVpNNWFmTW53eTJMSnk3T1Er?=
 =?utf-8?B?bkdpRXppYjZGYlp0dHpIcU0vVTBQU3h3eC9heWIxNVZiVEhLUXJoRUVJM2ht?=
 =?utf-8?B?ODFJQUxVSTE5Q0ZnTVF3QlIySEtmUU5vTThESXlYZlZZR3RVTXM4dXJJRitw?=
 =?utf-8?B?RVlvM0IxSmlCNk1hTkxLQ3F4WGZqRzhSSDF0Y0pIVjZhVDVQODZhL0RMS0l5?=
 =?utf-8?B?QmpCTGJBVzIrZVdyeldXM2d6ZHR1SGJZYW1PSU01ZEtUWGQ0RzJnM2FMZU9h?=
 =?utf-8?B?eU9Zb1ZONEFuLzFzSFdTSHdOYkVYQUJLZnJQZDR5RkJ2ZFJJSU41am1qcEFY?=
 =?utf-8?B?VFR2UGxSd0NsWUwxcytCaW1xN1Q3OVlkTFNoMU80azdZN3FtTXBtaDJheVVE?=
 =?utf-8?B?TzB4SDF5bytEdTFuM0FBN09GUGdwTDZkVDJVUkVMTWJPZGhUa1lWb3NwR2ZC?=
 =?utf-8?B?ZjlReHJPMzVOZmN0M0NhUExJN24wd1ZlaWFYbXRjR2hoN2lSWEFrKzJSc1lE?=
 =?utf-8?B?ODY2REZIN1BLamJVZk10MkRiNE54a2ZGTEM3TU5IZmV3WGpPaVF1K2JXcEYr?=
 =?utf-8?B?WGxDbk1XeGhEdXNvUFhVQjI1YVErWkJ2Q1pTckVYTWZIN3MzVFp5ZmxPbHh0?=
 =?utf-8?B?WUtZZGhSNjFUeWY3NlZhT2t6SE1meFJ4b01IK0Q2T1h0VUI2aDVWN2plZ1gw?=
 =?utf-8?B?dDlXcWVqa2Q3OXMwQWsrbGNEVWFUbzlRVzNlZE5CQmtnVEZIQk1DYnVTcTBS?=
 =?utf-8?B?TnVaalBhNDlMa2JnaUlPd29VWWU2ZnpEdmE2ejU2QUhYK0ZuK1NBZXF2WmMw?=
 =?utf-8?B?S2g0YkZsc3Q2b0F6dnB5RGxoOUc4OEJ2eEhpM2xzZ2gvemE0MndvR1lQKytn?=
 =?utf-8?B?aXlmbk1FMVgvVmduK2NCRFBLNUpIMmV1RURKK1dGa0licjhkYUY4NkNuZ3B3?=
 =?utf-8?B?VGJDMWNMWDlMWkpOa25uUGVYeUFSWDF4SFg4dUMvRVZ1UDhWWDgya2R2SURF?=
 =?utf-8?B?ajdVeDVvWW0vK0szS1pldndtTFAzTFNQT0pUVzdBNVF3RlFvYjE4WTZkR2E0?=
 =?utf-8?B?Lzg5U0czd0tLbHRUczdqRU92dVg0OFdlVklRdExCRlZsK2xDaFJ0UEsyTEdY?=
 =?utf-8?B?UWptamtqUGtkRExtL0twK09QNTZjZWFkcVgxclZUNHZTRkxEc2l3REZveXpJ?=
 =?utf-8?B?MTFDR2dpNGttR3kzU0VUcktFVUpXRHV0QWtXS1BzSVZBV3VKZitpcm0zalFn?=
 =?utf-8?B?N0ZhSHVJQUdyd1hWWXlxSWxuME9nWnk3ZVhsNlMxclJqRkVUTU1vdDkxTWVv?=
 =?utf-8?B?ZFhqYzlMQjdyNkxCRHorTlNtYjdzWUQzck5RODlXZGVCVER1NzZOMUVraDkw?=
 =?utf-8?B?ZXNxV3N2OWRzYmZtVmxMQ2pzK3Vsbzl4MCtBRDZQVW1pRkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3NmaG9WT01FK0JxNFFDcGJpRm50dVV1WEVVR1dnQlRFWURNTWhFTjd5Yko0?=
 =?utf-8?B?aE9TSWRmTkdLVG85aDRiM0I2blJ0Vm0rLzgrOUVBa1RWWFJyaGVUQjRuem16?=
 =?utf-8?B?R1VyMVQrc3lmcnlhdUw5NlI0eWkzUkhOZnhMeStrWnd1QzlKYWtGcW5LZm9U?=
 =?utf-8?B?dkJjSFRScEZlQ2RNVmM2RDlwbHU4cjNJL29KOFQyOFpMdlR1RWJXdUU2RUpT?=
 =?utf-8?B?MDlLd0p0dlE3SlpDZVRhdVVnbnF0b3lsZ3FBa2VPVVhGM1BVam1GQlM3bHVS?=
 =?utf-8?B?VllBQmd1bnFtem0vUTBwTVpGQmNrM25jd0tINFZoWnRYQ3hJYitMYU5ydUIv?=
 =?utf-8?B?bk5ZTjVQMk1xY21LcFpvcUcwMmNndEdnNGdkYUhubVBKN2Vyc05HeG9JdERV?=
 =?utf-8?B?cmZOSVBwcE5pUWdXeU1uakIrR09NV2ZhOW9MNGhMTDlYd2JBOUhuTy9vaXF6?=
 =?utf-8?B?c0IweFMzSW5HNUp1U3JZd00rYnUzRXR6bkwyZ0toK2p1aEltSUFIcHRqeXhj?=
 =?utf-8?B?OWtnd3VVK1o0bklLMDNuZ3hFY1lCditSVGZJRVUrVkJnU0F5RmgrYmFmekRa?=
 =?utf-8?B?a3dyT3VBNkJJdDRKeURIMXFxa3ZvbCtiRDNackhScGVFSEx3YXRuYzdYT28w?=
 =?utf-8?B?YmpJd3U3UEZvb2ROTVV0RnpVOVlZMVhORkpRb0VPT1dFWDl1cnVidHk5L0c1?=
 =?utf-8?B?L3FJQmxFeHJFMGxGV0ZOck9nZDNBZWFpakw5Y05SOE44YTJhemJIWDNMc0Jz?=
 =?utf-8?B?SnJLRjcrMi8ycDNxNHFCNXkxMmdvYmExcGZiL0ttTzFZMEJuMGtubGp6RUE1?=
 =?utf-8?B?amNyOHI2aEJ4MVhibEROYUdlYXZyK2lhV0NTcisxc0dtRU9pd2hjTzg3UkZj?=
 =?utf-8?B?M0toTlB3YTRsenBqSFI4akV1bXlEc2t4WEVNRjJTOEJXNS9WcWpwbTlWN1ln?=
 =?utf-8?B?Q2YwWStrVzJjMGF0ME95ZzlnbDg2cENIaGdJbURRZkNhY2ZPVkZwTldwR0pa?=
 =?utf-8?B?MHVmS2tkN2dnR2NuYmw2dnBaQTNTajFnd3ZYYkZGbmFYWWVKK1M4ZkhFZFFm?=
 =?utf-8?B?QVpXSEZjLzZFbU1ieXMwdzdiaTgxU0RVamM0VjR5YUtHTFYyRWhBTXYwWXUy?=
 =?utf-8?B?NTNyRHNTWWZLNDFvR2VXbVB2TDFnVlNBZWZPUG56WHcwNXNPZW1YcVlsNEFU?=
 =?utf-8?B?OVF5SEE1RGhYK1FOWE05aUh5cDhSaS94bnhqeW56emk4VXNQSVgzbzlhSlNl?=
 =?utf-8?B?Y2pUWG5QUXNtMkhNSFZPRmxNN2FvUm5xbUZGL3RaMXVuVG0vRzlHRVM3QTZK?=
 =?utf-8?B?dGQ4Z2c3azlvWVdzakp1QlFrTUFha01YZHNMbFczVXB3SXB3K01NeVREblRy?=
 =?utf-8?B?UDJRY2lIcUxoelo5ekMwMS9xV1RMR0VLWkI1R0RYRlYyRlI1eUNLaGE0Ty9h?=
 =?utf-8?B?YkVKdU9nR1lsTHJnU05yL2FmWjRsUjh3bkZndkJ1VzUrWklJTVNDMDk5Mkd2?=
 =?utf-8?B?STVST2YxT1pjYWRrWk1zUkdBNTFnRm50WjlmOTFhbXNmUDByeFROSVlhcnBz?=
 =?utf-8?B?R0pKVGVVSUVxSVhYWlA1a0NYSXlib3l1c0NiRi94T0J4TW8wY1dOc2lQeEFC?=
 =?utf-8?B?bzRTdkg3R0ZCc2xiYWcvVG5IZ2VEaWI4ZU5MYzk0MW40b21MK0ZDQzRITmNM?=
 =?utf-8?B?ZWQzU09XTHVnZGNiYkR2RGhYQ0F5aDZvcENDek5kVzgydzBpa2VnbFJiTG4r?=
 =?utf-8?B?R05ZLzFvaHVKS2h1SGIwdGsvRXM1ZU9KYkxmRzMwQm9WU2VPS2FVMXZ3NzRI?=
 =?utf-8?B?eWtpRnVXVko0bHFrMlRDd3lHYVl3MTJEMXBMc2YrSGpiUVoxTG5vNGk1SGs4?=
 =?utf-8?B?U0xjU09zdVNLRlgzaisxTzExRHZyd3BieUJ2bFRYZmh4U0pmMTd2KzgvY1lD?=
 =?utf-8?B?SGhvWHBPVFlKUzAxbEVRckkrZ3I1L05rRjVrUER1UlUxbFNMNzN2dklTVnJK?=
 =?utf-8?B?TStSdUN2MC9SaVc0ZG9FTTFldmxPK1dRRS90UTg3YlA0R29vYkd4aHJXUDdF?=
 =?utf-8?B?N0xqanRNK1NaajU1Q3RvaGdvVHVIejlFWkFpSE9GdWV6NWVpb3l6UXpEQy8y?=
 =?utf-8?Q?Upxs/OJawp7P50RsMxCU2pEfS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15358153-776d-471d-46db-08dc99df1118
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:04:12.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CCfdJbTEC9l4CpOvlbz4XXqtqrHHKWD6lsy6FjN9L50EILnA8aGrSUmKqNjYnwvnN+yDYIyeWkvxIcru6zm9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169

Add i2c node in mipi[0,1] subystem for imx8qm-mek.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index fc79ac0d57a1f..7ceea79f658db 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -364,6 +364,20 @@ &i2c1_lvds1 {
 	status = "okay";
 };
 
+&i2c0_mipi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mipi0_lpi2c0>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c0_mipi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mipi1_lpi2c0>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
@@ -636,6 +650,22 @@ IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
 		>;
 	};
 
+	pinctrl_mipi0_lpi2c0: mipi0_lpi2c0grp {
+		fsl,pins = <
+			IMX8QM_MIPI_DSI0_I2C0_SCL_MIPI_DSI0_I2C0_SCL      0xc6000020
+			IMX8QM_MIPI_DSI0_I2C0_SDA_MIPI_DSI0_I2C0_SDA      0xc6000020
+			IMX8QM_MIPI_DSI0_GPIO0_01_LSIO_GPIO1_IO19         0x00000020
+		>;
+	};
+
+	pinctrl_mipi1_lpi2c0: mipi1_lpi2c0grp {
+		fsl,pins = <
+			IMX8QM_MIPI_DSI1_I2C0_SCL_MIPI_DSI1_I2C0_SCL      0xc6000020
+			IMX8QM_MIPI_DSI1_I2C0_SDA_MIPI_DSI1_I2C0_SDA      0xc6000020
+			IMX8QM_MIPI_DSI1_GPIO0_01_LSIO_GPIO1_IO23         0x00000020
+		>;
+	};
+
 	pinctrl_flexspi0: flexspi0grp {
 		fsl,pins = <
 			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021

-- 
2.34.1


