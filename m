Return-Path: <linux-kernel+bounces-294167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC0958A35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2F7288D70
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4C192B6F;
	Tue, 20 Aug 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OS2R/LMT"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00121922DC;
	Tue, 20 Aug 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165639; cv=fail; b=LCtyY2jP2WJ5atg4FyoPTV6sv/JM4pnW6mxwlEk9yd3AKmckkqZtehtEJpqNFhZ1M2arCpkJGQcicPokcn96ZoEWnZDR2cC+pbCLT6CI93hGzB3GkoI9bYvIBXUU00fsIKNWXSeDDWGQZIrFivHvSG4H2P8W5dPR7F9wLjz5WtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165639; c=relaxed/simple;
	bh=bzJZM3/5FPa+BlyqSgImAHNJf4KmGvohBiOqnYw6edM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sbOuycj/0OAEr98FCnXD6ZfOkaojwD01et94SNSFVq6jAG6HzzKGV48SEHbxDrdHATEsXN+86XVdKDuJXQiEMyUBtC+j/4+W5897T4WObE9hZFfUulr2sfIJBEfTlPiVs11jYqOrD2ZgAMwWdRE3OKJGbi5cFGgLRwMF6HkRWO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OS2R/LMT; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjAu44d19IVi174AvRGReGv6WJHjEXXEJM9ZTUBcLf+k7VWzIcFtBfwlsUny2TKJN7jp77MLOOvtnCUEE8n/zgtIOH0iqcU0J/BPkBccx7FiWHOBcVbsBCD8+3rtT0sUCchm/3IYPrmKkLApU7X3ZP0+acPiBdSiPCt6nL4eP4rSgv950z9hQNSTqB2GTdJvveoporRZXHI/StIlt/ehgM77RdSko93ULB7wSGPB+YfOQFTjsjBP9JOGOE8SuOMRob1aExF19wK6LN3uhEGff1lhZ+kBKnk/ZHSOSEcGOJ8zXuHD2FwZPmo8MOy01/V9co1Q7kcwrls2urqiWPmWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUprQEw8HyKc8G+9qAwrMCDGs2n9/TqxDLy+BQA4hIo=;
 b=alxP3qaFih7IBkVOocNdGmE9P5lJvPd28WntsEnA9CbqsqdPWjOQxZ/iHy9ypu2wdYN0GypDlmgAyurNIh5Yla3hEUeiKMKHBT5Lpor/D+K7nSTjCRsd0lHIEJnpDqwgWYVwr/a5Yyz2MuhJfRjzyf06SWBV6GHPAai0YHImtBfXycsmDDNh6BPPr0/fY6oPZuaMFDz77Xv4zoWorg/U/K6yTUs3+xAl9hkpg2PByoIpXUl3+HR+MLLEasHkNTMzl2FnntEoMCc1VrudKr3BDXdli5u8E5E1Ij2nwfrxLksFojHodR84NoE6ViiU0Lrdx5kawGF4X6ir8JpYNEPmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUprQEw8HyKc8G+9qAwrMCDGs2n9/TqxDLy+BQA4hIo=;
 b=OS2R/LMT5XpWgw+QJfkAW9COVV5KjiKSWxCtgNPiFdwZIWQVvidkh4IlfTBV3VC+EmlknYA2hQ3rokaJ/DhGBX390O/VGxnKTGkMYR+F/bHZF9i6EGj0eJjv38uIXblVR+fWIIEmSbAkuyUumK1Qy6akwkQXAuGkNFrOlNIx46y7MgGfX+xlhi5c0krVOlZQSoztHnYCmsEfoE1KhXOLI33aaRy7x0SHIZUmTOtUEtqnPf44a7+mxUX6VNOBpQnJsm/UQSoWEQPsH++uwLUrZfuuWT23WqgMgCiljBpXwwLR/7OnPPj2lA4Fc565TbyfA/JzJPP3eofztUImzuN7vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:53:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:53:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 20 Aug 2024 23:02:40 +0800
Subject: [PATCH 2/3] arm64: dts: freescale: imx93-14x14-evk: enable
 fsl,ext-reset-output for wdog3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-imx93-wdog-v1-2-5dafda0d4319@nxp.com>
References: <20240820-imx93-wdog-v1-0-5dafda0d4319@nxp.com>
In-Reply-To: <20240820-imx93-wdog-v1-0-5dafda0d4319@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724166168; l=640;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=wMAWxMr/4n926+9Ywl9mQr4iPhZCbzUGFsa/Ni4BxI4=;
 b=URZ5yJR3KpXNCW522GkTcE/N5ST1OkVA5wck3XtZvGvv/N7sIhtpe6o0vSf4PenoyUY5V+w0B
 Q3HJLipNe+aB37hJ/t+u1NQ2dhCA2HzFJZCsdOtVTDLA7L7M03l+snj
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 434a8b68-e861-4619-03fb-08dcc127e9b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGJuR2MwZlp2NTdzdHRCREcyM0VrMUNYZmYvUFh6MVQzL2Z6YVhWZStCSU5N?=
 =?utf-8?B?b1NHWWNPVlRXdzFiTVUya3h4YWh1UG15ZzBGMEdMYXk5UTVVVjF5dXBFTSs0?=
 =?utf-8?B?Q1hSSzRmT3NaQWc0WGhndENCdEgrcGlXMUhvWVhGNVZuZnFOWUhRWWR4Ukkw?=
 =?utf-8?B?OThTSlJXU3JxN2l4WHVsSFdZK05haEVVU3ZjVHB4aXpCMmNGZ2dlNitwaC9y?=
 =?utf-8?B?MXZ1bHcwdFREdjZDMTd5Q3Q5UGFYMk1xMFUzSy9xdE5JVG9Gb0pnY2trUTZt?=
 =?utf-8?B?QkllZ0ZvU29xSTRyNVVva0FaT211azBiM3p4RnhiZFVFbnVYMitpTlBJRkhF?=
 =?utf-8?B?RnpRMkVHUVVtZGhZck5MelVxTSt2ckhIdjd3cEZDRXc4UzdWZHJTVENROGVN?=
 =?utf-8?B?ekhhK2dQQmMxREJGL0NWTGNjbkF6dUNLcGkzRXJlM0UyR3prQTFUVVhDUEF3?=
 =?utf-8?B?MlUzZExoY1BLdnkyK1BNNElmYkNTdGZiYUZQQUU5UUtsLzV2S0RxKzc1aVBX?=
 =?utf-8?B?bm9TSk5RL3JmMnJUWkRHcnJ6MDduUmpwSGZWTS9sNW1sSmMrZ1BHTXplRTVC?=
 =?utf-8?B?dHMwaHA3ZTdiNnltbjMyUmxsbGhGWjIydFBZU0RYdm5hd2ViSWw1ZkcwbDBM?=
 =?utf-8?B?TnZXN0RxWnRhSC9UWEpKb0wzUVhOOGdoR2xzTG1vWUZ4YTNvNFhtSEZlclVt?=
 =?utf-8?B?T3FnL1RoVzBnREFlc05UZjVrRG9iOVhkUXpKcmFGNFJOanRXQ0o4N2xNR2cx?=
 =?utf-8?B?ZWlMZm5HVkFGbHlBU2hPNWpXNk5CemxYT3pDU2I5YlA5YUpxcGpuSlg0K2JR?=
 =?utf-8?B?OG1xR0hwbXQ2WGtLUlY4bkRWZzlMa3BiRUJDYTYrdThNZmk1RmNYaHE1dkJp?=
 =?utf-8?B?cjhHK0gwMVNReHZ6QUE0aUE4UEJXSFI0VWdza0Fac2VJS2NMTVM5V2c5bUVk?=
 =?utf-8?B?aytkNkFxMC9wT0Z6dElqNUFHak85aXNzNGlvb2t1dXQvK0lZNTIxSEkxMndB?=
 =?utf-8?B?L3lJeC85WU9wb2U4Wm1VMXBINmR3alZRaVY5SWVLSjMrY1dud2FjQzVxMDZL?=
 =?utf-8?B?L1dxN1Y0NlJ5TndYK2xJZmozM0Fkd3RtVXZEMmdyeGc3YStGSE11Zkpvc2Ns?=
 =?utf-8?B?eGxuMC9pd2J0L0Vwd015SHAxaGI0aTRPZHhOcTZqZDBiQUpPU29MWk4rM0Fa?=
 =?utf-8?B?bzB0TXk0SWN6ekNKM0czV0FuTm9zekxwSnVPekFvOGxTVXVjSlF2QTNEVGxS?=
 =?utf-8?B?MkpYS1pTRGJ5TW9wRnQ3Tk5kZUNCMnBCbDJSeFFOeVVlNnNVdmlLMVpSMy84?=
 =?utf-8?B?QkI1L0YwbnFhWXY0RjJXNXlERHkrNnV4RzdLWU9JWm53THl1bkdnYWxOdFFK?=
 =?utf-8?B?OVRXUE9xaEkySHJRcjlUQXo2dWduRDU3VDI3ODJ6ZHc4RkFEVGRZTHZyWmsv?=
 =?utf-8?B?c2lkcGozMjVjSzNlb1k2bmVrOEtPNVNiYkx4NFh6OEdOaFVJS1F3eVJMM0hC?=
 =?utf-8?B?SVdHN1VMejYrU0NMbkhpTHlwRzFFYWkvZWkwRmR5RmpGYmxua2VOejVwSmNQ?=
 =?utf-8?B?QkNLZldaUlBTOFRhSHA2SndWaDNzcml0eWtBY2RXWWE1RG1qQXo0dWE3S1Zl?=
 =?utf-8?B?T1BZbWZhRmZlVER6UFdzWmh2ZHR4SlVONGdXaEdsQXg3dHF0YmpWN3V4eTVm?=
 =?utf-8?B?NW5oZ3l3NWNGeG0wVmRZYnNKUzk1bkF1MkhXMVlCcldrQUNBUzAyVzkyTGgz?=
 =?utf-8?B?bkNOVHV0QjcvdUdHR1RoZE1Md0lpR3VnWVNoVGNoSlJMQWxsZ01BZHcrSTYv?=
 =?utf-8?B?K2FvZTFZTlJjbkV4S1k5ejJyVWd6Mm0yN3E3bkpPZFVoTk9Oak9DNXo5cWNV?=
 =?utf-8?B?UlRTNGxMR09FKzJ5blJYV3FKWGNXSHB5aFIraGI4M01Kbmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGhHL1lBN3dzMXk1S00vcVNtaEttVUt6ejk3dkptb1dBK0lYUWVGREpJNHNS?=
 =?utf-8?B?QzFSVnRtNWhCWFB0QkNoczB6NVpOMDVPcTVDTVE2aWVsNnhOQ1BSdGE3Ymly?=
 =?utf-8?B?RXpDZHYzczJqc09qK2NjbVZ1WGJiMndXN09kaGhDSi9ydGVOM3I4QnRzeXpM?=
 =?utf-8?B?ZmgxWTZjVW1hKzVEL3NqRWZDZXBBaURucm11RDdrUFlYaytTUGJYeWdORUJa?=
 =?utf-8?B?QUNwZkIzb3hPci9FVWNzM1d3dkp0eWltNHZ4dmdZaE5rVVEvc0NwZUhoYkRJ?=
 =?utf-8?B?b04ybHBuMzBic3RTd2RWZTRMdHVxZVd3WTE0RnF4LzVxSUZQRzR4UTBFd0Ru?=
 =?utf-8?B?d1ZkN1l5SWt1bTJiVUZJbExWQmhuTGFNeUp2dzZrYmdTK29KVDVHc1BFRS9h?=
 =?utf-8?B?NkpGa0lKYU16MldvTnU1b01CdEp4Q1NMcC9UU1ZrT0ZyamdocjRGVzAvQ05z?=
 =?utf-8?B?RitKeld1TGRNdmtNdklQaTJiN2lmNllHOXJXN0JYemgrcDBNS1dCcklGZmR4?=
 =?utf-8?B?amcxOFhsOWlzdXd5N1hIVndNcm0wa1l2MnJvRWxSbkI5V1JOOUFYWHJPejJs?=
 =?utf-8?B?dkRFSXBXSW90eUJkRENTUjlETE9vMVZOTlBDS1ZSWTRLZCtSaXFwNHFhVUxJ?=
 =?utf-8?B?MjlzWEZFNm1tRDhENkRDakF6Z05RNnZUWmMxbGloWmhTbkFYUWRFU0dDWjY4?=
 =?utf-8?B?V29seVFpRFRWa2dTZ1ZyQ2h6SG1xcjVuMXFmUmNWSjNQMXNkM2FndHVuNTdj?=
 =?utf-8?B?WUZ0MUhIMjlkd1VGWHNUZEloVnBzdFovT1hyaFJXRzN4L1ZhcWQxcWJDQjhV?=
 =?utf-8?B?dW5yTm9YWjFPRFhzRUM5ZnJ3elpBY1dDeW8wajhsMUNqVjVUNnN0UVRMWmE4?=
 =?utf-8?B?d2d6R2xPSHdITFFGM1N5ZW9iYjdjT1E0bUcrTTU2VTh4T1p6TVVCdUxkZXJr?=
 =?utf-8?B?ODNIQytpVEIxQjRCV091dmtkejlDdXczbncxUkk0WUpsd3BDZHArRE04UUkw?=
 =?utf-8?B?UjdJUUsrS1dsQnJRN3dsTlEwQ3RTWFdNMGwzWDAxZHhwMEZHczZhQ0xtSVVv?=
 =?utf-8?B?SUFsQzY5QkdObk1SWUNjaVkxa0toYmtYaFkySzNTMzJSSVRKZTFjTWp1WDds?=
 =?utf-8?B?a09tSktXRzk1Z0dGZDA3TGpUWHhsR0p3eXRXZXFYSlVpTFVjRnkwZmxRbmJH?=
 =?utf-8?B?RFFZSW5xNjhyN1lSUHNway92dnFFa3U4NTdVSDAzaFRqR3ZPcVIyZ3pmMGU4?=
 =?utf-8?B?VHBldEVNajY5NUpFc1ppSEJ4N2tDL3BwYnNKSnVFbnk5eXhib3hLY0ViTUdW?=
 =?utf-8?B?VHkvNDNkMFE5aExzRW5EUVpTR3ZHTFZmUTV0Y1hXUnBHMWU4azZaUWQ4dEk0?=
 =?utf-8?B?RnRlQk40Vll5eEZYbnZKZ3dLK3E0ZFFRTm4rLzFDQmUrcW54NFozNlUySlBq?=
 =?utf-8?B?anFvVVdwL0xsYXBpZG5RR2xJN0FrbXhSMVpNSjBRMHJsT1ppSVo3OWZjQkhx?=
 =?utf-8?B?anBtQVRqMUNEQUcxRjBDdTBmQmlzeHJNQ0txcUdwQUtkaFlZMVFmb2pSekVn?=
 =?utf-8?B?bllZR2lOV2t1TTQxRHFkUENWQmZ2RlBUb1k5WXE1MXJSNEIvSWpJK24yS29u?=
 =?utf-8?B?N0hHbDNLbk5tWlViQVhOeUJmUlZvV21TTWdHTkVKV2VGNFdIaVFiVkY5bWxr?=
 =?utf-8?B?eC9CK0MwUEIycEdwQm9KSnMrY0w4bjFOZW0vSE56amVhTmNjME9xcW9GUkZS?=
 =?utf-8?B?NzB1R1BpcCtBT3dpUDE2QTVFYXFFQ0Q0cno3NFhXVkVNL0VzMUhmbStoY1g5?=
 =?utf-8?B?dDNrVFhnOXBPWTVIdnU4Wk9zaEd0Z2lySDRUS3VrbW1MUERjcVR0c0NGS0tv?=
 =?utf-8?B?NFZBUnBVRjlxUWd0NG81WDRmMWc4c2dHYTJYSDRJYmZjR2pGQjllRVZaQlF6?=
 =?utf-8?B?Wlp0bEs4ZC83aTBJM1JicjI4djNuN1lwUFhsQ01Wem04dEIrTVZrMDBXUlZz?=
 =?utf-8?B?UWxqcGw2SXZWV3NBZE51UllVcWVxdVN0c0hxU2d5YXRhbDRldTdYSUllclFk?=
 =?utf-8?B?ZnY0Mk9xZVpVc0pxa29UUWZOVThvNHVuTitjbkdWYy9WeEdaRjFOYWhYdGxq?=
 =?utf-8?Q?1G2ADRdlfLba3w9lY7XvOoMmu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434a8b68-e861-4619-03fb-08dcc127e9b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:53:54.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eiICFrq/ExdIc4PhloCOF+sVvw6oVFtMTf9eIVxL25C80sXxQceIDs0874I8GACMB7hOTaqN9K67n0yuzFckQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415

From: Peng Fan <peng.fan@nxp.com>

The WDOG_B is connected to external PMIC, so set "fsl,ext-reset-output"
to enable triggering PMIC reset.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
index 236a44c1782a..b8b5ca57902e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
@@ -284,6 +284,7 @@ &usdhc2 {
 };
 
 &wdog3 {
+	fsl,ext-reset-output;
 	status = "okay";
 };
 

-- 
2.37.1


