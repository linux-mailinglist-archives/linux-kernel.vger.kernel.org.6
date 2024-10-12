Return-Path: <linux-kernel+bounces-362303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF2B99B351
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F211F243E1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3AC15623B;
	Sat, 12 Oct 2024 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KkLqg1Ac"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC718453F;
	Sat, 12 Oct 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731452; cv=fail; b=ompm2kYOks0o+rGNQ2YOx0y6FHFVGrXtvipC6yLVXZUeWT8tc3Z8mA05zU1iRjjEz2EHyvG0tp3wRUn8bI+FTah5axCQsMfXyxDe2PjoM+0hIS4hOqD7uiUsaAKxgJ8NmOlMVFf9+Hml9/2r3O9u/gkTvI7JTfGTaoRwGbVp2RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731452; c=relaxed/simple;
	bh=RuwwulEoiz8La8igWI6Sb89WohZRoLrKtHVpmorvEDI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QIjxFrA7zGZNifu28+ZvEjLzr6ZXrjR4ZooAEG8qaZ1CttvMAdrjqqA39UjRB5qM/AWABFyqrH8QfyHWkR7p4pUKTY/r12wmVrfaWFQxnalYhouvlux4itiEjgMR3lJFCykgmD0FTrtZvM9GZvGBXRO144N8bJm4XAZos9Iuw4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KkLqg1Ac; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxNiMUsDvGNFdJFa+vyWUwMfoYHeaMBFefnvPEK7EDoLYk0Ox1QuY4BEbUM72Z6FmWzJMUEv62N8WC22evMCmbPRtjKdIU7oVJYdGdbVVA/Y2jDVS0e3XZHqQsVjgr4Bg/LvD7h55E9icVaW1o730WB9SHMZoR7RkX/1lSrL58MBdoPGECws8f1yIEJhoTPG+74RlBITQZe6bX+CCpCyqMwVLwEAGjGpLTPwaExi63Yr7yS+yeUD9ySoQ/5N7ye+fI2DCyAmzfYYIi8EgRlxE0bZ9xAsH3TsYXZ2kqOp7tFzilXuq63ZFlHyLwZPL4hj+K5yWkAGKSwVlVcB3DI89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrQ6jKU0AJLDfllKE2ZgYAATDSvxAHyoSqY/Z6rqkBc=;
 b=HjWZrr31qOgrwOzKBZ/fCeE+P9L4nxVUIFlge8mir8vkRNZSWDjpFGIHX7fSao9Rs6mSoaKlTH+0ZvzZ6bPoxjApBYde/qO0RmXuVkg7nOQQ9qFI6kIDiFbN6S+KnjlmQUVqBahQTlqw9TC+T3B/H4cGOpkdX1pu8rzSB+c30dbSeXEpDv1ONIMvfskQyVN09k0Aue+y0dJ+KBUoc13fLVeYhg3+3Gy/Fw3UAh5kJFAGi3C2M3GtcPo8Vb9aXuJesZkDJLYQAdKVCPhxIlXaeF3FLK7mVfg49AHh/ex/PI4RjzSrsavCFJ195TxCxl2QaNOIHu5KcD7i20wj9MCkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrQ6jKU0AJLDfllKE2ZgYAATDSvxAHyoSqY/Z6rqkBc=;
 b=KkLqg1Ac2ozylg2RlE3hW4IfltHh3V3VkOF2JPTXPkfO54YLHBTy3aCpOAUvquPVPNwjo7Y1hFilOSpLjg54UdQ2sI52jpvZWNprYHNJkGyDzfVyotI//hOkh/gfyF76iO5C4+XSRuLTSf/sDngVPXAHpQRXlk0Jm1jparDXJVR1kEq3Iiafzhtsr6gUUzZ16Q1/2M2F9QGBIxxyzojO68eEOLASDSKM09fsStr2xhCRs9CLN5tbmFWTbMO2OVBOx0TsAtbXHhALAHCUC1AWUSkIwEqnB3eFyUed6wfDIrJqDq4FsZGSjrhpeL4IDjJk3pHqynIpMb44h2MwJO7JmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sat, 12 Oct
 2024 11:10:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 11:10:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 12 Oct 2024 19:19:11 +0800
Subject: [PATCH v3 4/7] arm64: dts: imx95: add anamix temperature thermal
 zone and cooling node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-imx95-dts-new-v3-4-edfab0054c71@nxp.com>
References: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
In-Reply-To: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728731962; l=1509;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=nCRcwJhSRqLnt+OnvdUbCBk2WTYPwx4bH32IgXyfYu4=;
 b=j+PJsxnztcqFmCMuDAFilBRFzaSIUFlNdeQpJVr50T//ffts3VYz5p1LoWSy3Xjw993bm7esW
 yFpMx0Pu5MtDYt+MBn6QJIhGpVvcUHPga8qGdXghUeW33UYl6NYrLX3
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
X-MS-Office365-Filtering-Correlation-Id: 61ca1bff-d045-4654-0d31-08dceaae86ad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFFvWWhVR2xkSyt2clB1S3d6ZytKTUM4bnBCSVRmOHpjUkVOQnM0Q2JSNFI3?=
 =?utf-8?B?WHJXODgyeEdES3JBU3hpaDdNRkxiOVpGalBadERqNEVhU2d3OFZQbWdoNWs1?=
 =?utf-8?B?eGNHd3dzK1pZTUt1QXpjYXhxUWdCd3IrTVZ6MThFeUdCc01hMTBnWVIrWmow?=
 =?utf-8?B?U1VHbnRJcnlJblpQSnRkRU9CTnA0NlBHVlh2MnhHTzdXMUR1T2doZFcvSUM3?=
 =?utf-8?B?YmNEdzc0am9vQlZTTFhMY291c2RpNEtVTnZMZUxxSDRHcUF4THNZZnhMWFJx?=
 =?utf-8?B?WnJmY2xiWjcrd2JHRGVmbGt3S2krNUZ1d2xPRmN6TVJJMW1iSjA0a1ZEWjhB?=
 =?utf-8?B?bTRZN0ZxZ2dzTjFQNFhWWmVnZjB3d2FidU55UkJWYWxqRWR6QktPdGF0R2dv?=
 =?utf-8?B?U215bUhVU2xzYS9xaW9qT1JDY3d3T2pYbWZRNWhwR3QyU1pTSmVrL2FWMitH?=
 =?utf-8?B?bkxJRlFXWVE4TGY3SXlpZ0k0SG8xWWlOcDJlNEVHYk45WWNVOHZubXNvVXN6?=
 =?utf-8?B?Y3l1L0FLWVZhcVRYNUxYVldxMFpSOEt6WHVpWkRCcm5JSjlYMUNLeFIrZTNT?=
 =?utf-8?B?WHdTbkRucTJ0Y2hQUTNta1NZeDlMUWt4bFI5cHJMS214QWpTbW5XVSt4TUVw?=
 =?utf-8?B?dFNFVG1OVkRSbWdSMGIvVDhtQnlJU3ljQ1gxSjloMGd5OVV5S0VTWFdhR3lU?=
 =?utf-8?B?STY1a0kySjNCTkRmN1hjUER4M2dkUlRZUU90bUhzVnRpTUZFL1Y3dFdRVWt6?=
 =?utf-8?B?RHo5OHRncHJFZkhMTVZaZ203c2VNVS91S1N6bmM1b1I2dGhza3Yyai8rSVJw?=
 =?utf-8?B?c1dZQ2dYNnpVNWtVSnVDa21RNUVTRno4cXJZM0JIbml6d2dtc3cwMXQwOG5D?=
 =?utf-8?B?cVdNNkt6YzVBSzZxMW5RZ0R2aTMwUjE2SFYrQ1dGamxmaC82YjV6eTQwSi9L?=
 =?utf-8?B?THRqR3BvcUt6Y0VlcmRBSlJjSWs2bGJ6THlvN2FPZ0x2QjYySnBCZkQvTTNW?=
 =?utf-8?B?bkdEUm50Nk9walphc1MveGE3VTlQS2tabWxEZlAwWkxyb1J5ODhmWS9QL2tH?=
 =?utf-8?B?LzdVcXdWYlhQaUkxOXJzYUYvZStxRGdobjZRQ2hvYTR3cE95NlhKcjNiTENl?=
 =?utf-8?B?SjBTVVEyL1dhbjJoK1F4M0t0ZjhSOTJ0RTljeENUOWF6MXA0Z0NEUmpSVGhV?=
 =?utf-8?B?N3p3eThXQXh4M1VOb3liS3JFbjBqQzN1cHllR0JIcHVGRGkzNWp1QjZ3Uk8x?=
 =?utf-8?B?MXgvamc2bjNKUStmV1kvN0FKNGFVVHlCWHpDTDNPR2tYR05ORjE5UzR4cllp?=
 =?utf-8?B?TlR2aGc3dG1ia0VQcnp2bnRpTmkzbHdpNHBHeVVLaklHZFppWGdHaHBmbUdL?=
 =?utf-8?B?dUc0RnBFb2NyaG5FSHI3SmlHdEdEZVBmNnRyemhOTEZFRk01L1Q1aXp2TzVj?=
 =?utf-8?B?ZU5UR01RMmVOanc2eGdUaXROMHJrTXNNc204SDJLeGpaRk9xWnJmQWFzcEVh?=
 =?utf-8?B?MytrdHR1SFVqYTBRSGN1eDREN0RndzZzSUM4WlArMkxmblU0TDAzQUZ4UWlT?=
 =?utf-8?B?ZitEVjBYQ0Z2MEFSNnJWK2lIKzFacFFUaFlNSXB0ZGVVSFNBM003a0JjWmww?=
 =?utf-8?B?ZnZzeFFSWjZMeDBFR0VtWjFTWm5ZbTNiVjJkdUF6Rk5FclpiamcvTDJQVkJD?=
 =?utf-8?B?S2E0aDR0UG9LK3p6ZWJLT1BDVDMrY09PNWM5K2xYN0pwZzNILzlVdG1LTk1y?=
 =?utf-8?B?ZXUwMldCMnFvTGhBUzkvL3lnbHdSQXR5eTh1aGNBS0RFQmF2cXNlVWpPR0ly?=
 =?utf-8?B?cXFWRzVFc3V0NXQxdHEzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXovSVlNQWM3NFdoMHZQT3NmL0RhR0ZtL1RRTGxRWjJucEFBd013SWl4UVR1?=
 =?utf-8?B?Z044QmREV3k5Nm9kTVNTREh1SlYxVFJLVGxCMkEyYVcrTkJLZGxsWXEzakp6?=
 =?utf-8?B?amtsTUxDY1VycE5NY1ZxZVAwbGtJL3hDVkNSbHlnOVF5YWNYSEJVbktuRVNy?=
 =?utf-8?B?eFRrKzVXY1kvTjkwRGJUR05UMTR0ZGhaM3AzMTRGVkVxRHF4R2tLNU9hVWZP?=
 =?utf-8?B?VVZpUWFVZmtISjhHQXF3T2lNMGtOU2VXUytxWkYwL1ZWb2NjdnlGT04xcGov?=
 =?utf-8?B?dXJCV3pkcUloSHg0VzhPRjVzY3VQQVZsaVowMDhYWkhvczZTVlVLSlY0WXV4?=
 =?utf-8?B?bnV1eHFYc2pWQlRVVldaeEd3amd1eDdUQ0FpQVU1Q3JIVlFTclZOT2FMRnc3?=
 =?utf-8?B?RUlJclkxMjhhVG93SGZWQThTdG9qREw3S0k1NnVNUlF6NUQyRFUzazZ2Vkpa?=
 =?utf-8?B?RTdsM1RJYnVlRzRTZm1CaVFhWHdkOUJkSjdYSzVQZElNblJUaTNTUUphRFRJ?=
 =?utf-8?B?V1JMTVVjdzBqZWNkSE1zclIrdGJJdnIralZDOHh1YkhLUjU3TEtuMGhmV0xw?=
 =?utf-8?B?MUxjQ3diSW9XN1RQWTVmME9BS0NvcmJXRWxOUTIyQ0lDMEdQYnJNRTh0RTNw?=
 =?utf-8?B?MmZaTEFhVUp6aWU1dGZobjlja01veDZIOXNUOWJhelMrR09DR3k4TUlaSlhQ?=
 =?utf-8?B?aXQrWEJkVy9ueGc0WVZsd3Vvb1FlZmNCdGc1eE5MUmp5dldBaE9xbVdyRURI?=
 =?utf-8?B?cWxHUFh3RldnVklaUE42a3d1Qkpyc1hERkFpUDdkRXpYQWJEcDZvUFA3OGg5?=
 =?utf-8?B?TG1kRnl4NzFzNjNIZ016U1NLWU90a3IvMU1iVDlFaTA5bElMbXlIK1dXTjZZ?=
 =?utf-8?B?U1hEQUFobGZmZ1J5VWJpZ1Y2QlFTdWRsNW55aVp5aWY0MkE4QTdJcmhhY0ds?=
 =?utf-8?B?YzdBWVJ4U05TNGw4TWlqUDZmd2l3ZHhHMk53bmFpWDNQUGNJbFBieFcxSWc3?=
 =?utf-8?B?R0lENGFHT3VEVzFFcWFxSXNKZDBLWE1kTWZhR0JiQ0tHaXZON0RzTGhPNkEr?=
 =?utf-8?B?UUk5R2hFNmVLaDVVR2RndURmamdRS2ZJR3ViZGwvS0xhVHQ4VWFNcWRqNU4v?=
 =?utf-8?B?NzdYQy96cXExNXh6Z2tEbFh4aU9NR1gzV1Y3TEo5WTZ0NEppQlE0TTZoZEJO?=
 =?utf-8?B?TlVhQWhNc3JyWjQ0WXRGL2s0eWRWUmhnS0U1RkZsblg5UGNkZTR3Nzd3dmhD?=
 =?utf-8?B?b1RWdG83YXRnbG53a2hXUmNWSk9NRGt0THpNc0x5NE5DL3RDUDIvY3RwVWNl?=
 =?utf-8?B?SzNkbC92ZDAyV09zUWNzckh2eC92RUplTTJTWlFOWUlyL2pwWFVXbjFObHh3?=
 =?utf-8?B?THVmeThTbXFsc1lEbFpqUDV5RWMrZlNIczl2MzY3MXZwamJSa2tpbzNqRDNx?=
 =?utf-8?B?WjQ5Ly9lWENWbVREQ0p3b1JFQkxoMmpScmF6QlVGVTVRS3lUODJ6REpYQXpq?=
 =?utf-8?B?clNsVGJEYWQ2QXk1QXRqemQwU0RQaHhHMTBOT0Q0RWRmV1Z1dk9xQ0MxRlVH?=
 =?utf-8?B?NEk5T0RmT0Nvd1pxQ041RkdmVGZjMHVuOWcrWUVzTXBGdTZoUlZEM3Jrc3pp?=
 =?utf-8?B?SWVPTlpNOGNqYVoySUlGZGtNd0c4Qld5Tmt5dXlxZXYyREVTM3UwbnczWFN3?=
 =?utf-8?B?ZWp6RlV3SlhxM2NBMEFHc1FnZ0JqLzVtTGNEbUZZRWFISkN0QTlTcWJHeXR5?=
 =?utf-8?B?Zzhaa1RveldGdE96OVpaTjRsNXo1QXhxSExlSitvTFR6T0diWVRkOW0vSmth?=
 =?utf-8?B?YWZGSkJZYnFoT2ltVGVubmtuQkdYVms3cW9xU3o3ckNXdWRUUkJtaFlTbFBZ?=
 =?utf-8?B?YVNjOElpcEtLQjRyWitibFJQd1FsZHE2UEdZS1E3KzRvY1haWjJOYnNzS054?=
 =?utf-8?B?eU9xUXFZWkFOQ29lS2pVdlhFY2dnWm5zYjdML21welYzT3h2SzAxdWZCZE94?=
 =?utf-8?B?WnU1dkNidWdDcjdsWmxDeTJSaWVCcExlQkNkRHJZY21qRE96dnliaTRtdmxB?=
 =?utf-8?B?UCtqOXBJaGQxeGxYMjd6NWtvam8xRk81dVdBUjdxZDY2eWFhanBOb1kwTlB2?=
 =?utf-8?Q?FSzEyIZkS5xx8x8dYFqhRX0tH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ca1bff-d045-4654-0d31-08dceaae86ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 11:10:48.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqulKtWHQOmxaKkRsAlUFysGkbgSW6ZFw3yx6/jLDGVrgHKt8y8UmlmtjK1VSAR/SP0lJnfCmoyNjMZd4gEM4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has two on-chip temperature sensors, one is inside anamix block.
This is to add the anamix temperature thermal zone and its cooling
device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index a96bf8e6a1a29f06741cdf5ac20e414ce71b5c03..ae8e09203ef431d8869fdce79df9f31a3e55971c 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -371,6 +371,38 @@ map0 {
 				};
 			};
 		};
+
+		ana-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&scmi_sensor 0>;
+			trips {
+				ana_alert: trip0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				ana_crit0: trip1 {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&ana_alert>;
+					cooling-device =
+						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
 	};
 
 	psci {

-- 
2.37.1


