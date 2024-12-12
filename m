Return-Path: <linux-kernel+bounces-442760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D222B9EE137
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9608283270
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69B120E316;
	Thu, 12 Dec 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hfDP5axP"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CB20E019;
	Thu, 12 Dec 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991916; cv=fail; b=tLkVVGMJ+toyG2BzB77c2/yj6tDWmeDDNfJ3uLW0SPyUmWKZvvVUa+n6NTNSyZCwGT/qq3tZkIaL3ZqSrzX4VSiGvtq9TCQEFb69jDCvmm3KMDKpvf4ZXytmol0ql82rY6VlD3MsSCYNNg37TgXhyTYELwCmblHgGhJcNWnan74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991916; c=relaxed/simple;
	bh=vQkgEp13+ZiMl1oyt4k1W4F91tSxG45ocpHrJGiJIcw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=V1KyZqmtSNnyDhwVgwjRY41IH6nJWPLVtta49oemoZwFGr7T1EZaW2fOUeODNchrmYAshjJiDJF6arY7Q4Od3dORJNMNRrUOV3qhV09He/t879mFVIKoyJ2zFCJ5ye51LYPwDNAfePc/aBTqQU9J4dtTnZLA2XAHf51StOl0FJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hfDP5axP; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEPsjqZfsmX3wmVFdjk45whk9ObR3zZ8DgdbMJwh7D1/iDWR1KTJpsPxaYbeg11Hku3paMTEmXAvC2cZcX7eVlGHmHVrUaTa+VDs5yZ9CNlpaVTF8+1pFD9EPhOwJDWka2eMr6Vob3rYKWm4nSbLwqqZ2CgmtDb8e9ll8P6fvtK+vtIZtFkGwq+skLsUmy2DlAtk5LXf+aDJ6nVxSxfBk6SuUPNVCYY8D3V5rjvsSaGmZ1u/tK3RldZvgDb2C7OLbBIl3hQtnrZIhh3jOVWZpVPpig2n6rcgmrBV120FYTq6ZI89NGBwvDyhCDcvcLjvNLogbl+j9LwfTpeFTdwYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLwHe2BcaWVYHFgQPJ7g3oRECUmybv1QGs5tEUQaO8U=;
 b=KLHPiIMhRDnmCKRW9UWAr/ANMho01G/HiLRnIBL6SZbCe6LdEv3ehpVU5F6Yk+/ACB+nTO6gq34cBKTr5yQz8jWZZWZY8kEKGUOyANTk39IFrR5OZWOa6q/j6qIkYaP+sPK1d7Ig7R+GXL76Jm9lMnGhKWTyZdyM24novQgoGQ2aWQoyJGbQbkXwxKbXxyMuaJPl84jhSE/b6XmatD80pCbf5UiQNCkIRS+gGA/p78+JF1ZqXx0ZUPoi2pAv5iQoaKHLjQ8WF9J5FR6YbAgFyur/Fm93fFlEOQFIcOaeRkjqM8AHrC8jq91tHY7AnztdcV7mmZ+Y4v3WHxdxsynKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLwHe2BcaWVYHFgQPJ7g3oRECUmybv1QGs5tEUQaO8U=;
 b=hfDP5axPjnBSGXdX+3/h1/2xlbrO4QF6bMMsX6/nJsN5kgeGsYZqfM0EdBki3EEk++zlVH9Er7UVyRoLOeVz5FV0DqBZJesfq5yzqno+Ulgsz5zJXxKvAyK2DGKQV9BKzg+I5A987eB09mBM4Q7zVW8wphwGttznk/hTxzdwJFqCVKK9adziz2ZY9LzR8zcJFstQ9V1E26fmeuyfm/h6Y6RLUwm/LpTAf7HTK4mT8uMRGlEsAFjM/SB/UYDGx2Wh584uSTNSWT+LgNzAYC5D8svdiQpQD6VA086VRSWCZQK7jHtgFcjWvxKjJD3qkRt00jxVHbpnPze6uJAgK0SxRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7323.eurprd04.prod.outlook.com (2603:10a6:102:88::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 08:25:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 08:25:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] Make i.MX9 OCOTP work as accessing controller
Date: Thu, 12 Dec 2024 16:24:40 +0800
Message-Id: <20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMidWmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Mj3czcCt385PySAt3kpNQ0YwMTQxODNFMloPqCotS0zAqwWdGxtbU
 A4DCv5lsAAAA=
X-Change-ID: 20241212-imx-ocotp-cbef304140f5
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733991891; l=1650;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=vQkgEp13+ZiMl1oyt4k1W4F91tSxG45ocpHrJGiJIcw=;
 b=nLr+EAxkQ+wZjAjWHrK+owR4C+RPBwq33QROJVyRsEGV69/JLDR8eKPya5uzHBCIWF0QU5mlh
 LkzK1ZL+dZlAakphKFPw5rW3mnnxaTGsO4jryHRog6woO/l8oJ+NeZ7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: ad202df3-e245-450f-bfd4-08dd1a867cb2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2JON1VpRHNKOG9MTnVPZ3V0dXp2aDNvK1FjUWhvTHlRYjZYc2VtWG9Ud2VZ?=
 =?utf-8?B?Q3hpUmFJbExTOHFzUlJmRFN5UGFFY09qbHYwVm1qSHJRUVBNdzR2M2NnSi9R?=
 =?utf-8?B?WFJ1aWlxRi9rVFRBa3N4YkpKVklFZVVTVEtlT1lJNC8wbzJEenRZcFk5TUxP?=
 =?utf-8?B?djhNc2k5bXhLU2xDYVI4eHhSODV2S01PajdHSHNBcXg4SkNUM2xJZzNaK0lQ?=
 =?utf-8?B?NmFtSE9mclU2ZzFtK1ZaaEdVcnFCN3hFcWxGRDREU0JDOEVRTG91ZlVsQisr?=
 =?utf-8?B?cE9kb25BV0RCRE9OeGtiTFRXQ1d3UnZkTmtkeFFEQk9RL1FIMVB1TTlMckti?=
 =?utf-8?B?UWN4Sm1TNVUvcXBnbzZKZ2lXdDZHMCtWbmhXV1RLeFhQTFArMlhIR0FOL3p6?=
 =?utf-8?B?bklmdVFHSXlFSDNyVW9Cc0h3SVlTWDFGaktsbFRKVWhqckpzTGVBQXA1WlNt?=
 =?utf-8?B?YXo4N2RHaTl1MGxKNFFCcTRHdThtN25aTW1PODRVUkN5UVlQdStNd0s4Y1Ur?=
 =?utf-8?B?U1ByOGFkbXZiRjBWeVEzSUo4M1lyWkJCVHFGMGo0NDBQSEZ4WEs4RDlXZTBl?=
 =?utf-8?B?T3B1UlQyOEZuZmdkeGFZT3NMaXJvTHI2NW1KOFQ4K1NjNmFnaW90UHVLTlky?=
 =?utf-8?B?MVdQMlBTaHhaMGRlVEFrSjVQenBHMnlLY0JBNUdsSjg4MURKZWwzVGhkeTFL?=
 =?utf-8?B?eENITnpZY256dFdTQ0lWeWZ6azB6V3lLK2tBQThoQ2J1eDZ4MmxHRXc0TEdU?=
 =?utf-8?B?MkVUWmM3dE5ta2VnVjZmNjJxSk9HTnVUZUZUUEZnZEpkSW96OTN3TVVXYnZ4?=
 =?utf-8?B?dmFVUVduKzR5STNqRGQ2TFlMN3JScXdPRmF0ZGxUcXB5MWZxMThyVUk5NWU1?=
 =?utf-8?B?djZUT3N5VkFab3hFV0d5SFhodUZjYzYyTStPK0VZa3BzcWh6MWp0UzF0RGk2?=
 =?utf-8?B?cWVOdjZRNGY5NlB3WGZSMmM5Rm5BVWg3WVhIbU1qNURmZGZjQzQ4V0dmZUdy?=
 =?utf-8?B?L2Q0d1ZSajBZUmFSY0ROSlp1cTVxRnhtaFROZGhHcGtERkNiNHhIdzB0OTJ1?=
 =?utf-8?B?SW1EcHE4NzR3ckNQTzduMGYvSkRELzJRUStNSE5Xa3lrbWFIRGc5UVBUUXJL?=
 =?utf-8?B?cGhsMEdzVW1hbnV4STV3RFdZdm9CUXB0RlJPcDVEcGkyeWIwTDJ1VWpxY28r?=
 =?utf-8?B?YmR3b3BVd3RxeCsyWkpRQTkxZmdGVVdLY1VSL3NMZGxlWWVPWWVSWTA2Kzcw?=
 =?utf-8?B?OGFmaW1CWDdXMEc1SWZETEpTU05HaHAxRjB4YlQwZ2ZHU0pET3pOWWhSRDFw?=
 =?utf-8?B?T2VwaDlOYjdtZ1oyaWNDN3B4Mm5UL1dRVDlReTlkZ3NYcktxOHI5UytzYVcv?=
 =?utf-8?B?MENNLzFMelRKK3Y5S2xCRDdtam5IMVpySWxFWnVzN05WeGtkdHVCR2dTZTRJ?=
 =?utf-8?B?SlI3ejBycnF4VnBFcjVrNmFQQUNHeWU1eEZLZDRVUFZTbFpVOFFJS3ZvSVlB?=
 =?utf-8?B?bVBlT292YmU2KzFrN09zclgrVU5yUEFWL094bWtzYkZTK2JyTGNmUlJOa0RR?=
 =?utf-8?B?VGtFcHY5SlNUSUpaMjllb2lVVG44QmlVWC9yTHhKbE8xZER4YWI0dktrOEcr?=
 =?utf-8?B?L3ArNmJic01aUklDcXo1WkZQVEZBWSt2ZHVoZXRIWmZhUGJPUFRTajdqTWRP?=
 =?utf-8?B?STF6dEpoWFNWRVZtN0NwWEdWZkZUYldHNi9MSlc3bkNGWWdaams3alY3bTdx?=
 =?utf-8?B?NVh2bVc4R05sampqVFp0VFhqK1JpeS9JTkRORFZBTjZCMXBZd05QNmVKTXlC?=
 =?utf-8?B?U3VWS05HSmRuTnV5RnFKeXBkZk1yN09Zd0toSDBjRnhpaElnRkRyaVVRUFlU?=
 =?utf-8?B?dm0xUFpSV2VGd2VXeGJ1T1RmcDVJcjNRL3pON3ZxejJtaXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGc3ZnJyYUxaWm9CQlJkVmNqb3p2U3htVk1INGZCQ1pSdjRnMC9Qc0lJUEF5?=
 =?utf-8?B?cGhiRVJPRzZuUVV2OTBTZGRDNThDRlgwd0FoSHcvSkdNQzFITXVjTjk1aWtt?=
 =?utf-8?B?Q2htMlE1dkhKNTljUHd1elVMcThQL2NqWWVtTFlWMXVtRk0wZlg4Q1BpbUZT?=
 =?utf-8?B?bzQ4bnQ5b1pEOFMwY3RPcHd0WkE0WXN4dHdtZmJPaVhrb0d1VmlhR3Voc0Ft?=
 =?utf-8?B?T0lZVUZaK1J4aEdaMXE3ajhFRFBiRXBFZjVyRjhaTWQ4c3JHY0RLc0gzRXFp?=
 =?utf-8?B?NmpvbzRBZlhEYjhIUzFjVVE3VmIrdStZRmY5RTlwWVRRbDRXQUQ5OUNQWVIy?=
 =?utf-8?B?dEJBa0lxSkhHQ3Qvd2RDcFVLWG1MMElTQk1xS21PNi91eWFBQnJ1d0JYdFhD?=
 =?utf-8?B?Q1pNVWk0Tkw0akliMDRWeG1xNXFwMjZ2NG9Pc3VHbTJndnlRT3Vhb3prcFJR?=
 =?utf-8?B?dmJFakRhV0F1bTgvWDlNTVZRMWtGZGNIRUR5TnhHcGJTb25HaFUyaGQwK0Nn?=
 =?utf-8?B?MXY1Z2lhamlpSzY2VU9vQTJrd0hmU0ZpUm4zS0xoUTRwS3ZXd1lTNjQ4bk92?=
 =?utf-8?B?RG51WEVOc0hiZUJTMnB6bzZDbCs2VldlKyt4Z0oySmh0cFh2NldiNVpmVHBT?=
 =?utf-8?B?K0MyNzRDRVN3N2hkUzNaVGFVYTd0SnZtSTJFNngvRUZIWEx3RzNpcTRQdEZM?=
 =?utf-8?B?Y3ZYNWxPcnh6OExyaXl5eG1YVXIzSVhlWDE0MDArZEFISlZPam51U1BiYjhK?=
 =?utf-8?B?NytpeUhWNURJdHpneFkvT1gxNEtNRWxZcGdJV0Q1YnptODJiRnE4YlpwbFZZ?=
 =?utf-8?B?V0lwSFFJaS9QOXNjbWJTRWg4OUNTRUo1SktIUGdPWUg1R0NCRHdtUnl0b2xw?=
 =?utf-8?B?ZWhIZ0taUmRFMDQ3OEV2Q3B3dWZ0OFN0VXUxUzFYTUxBb0RNNHoxOUhwRnBy?=
 =?utf-8?B?UzFzSzRub0x2LzlIRVpIbWMwc2xKcnhZMGlYNCtEVHJHUCtrSnd5SzdtL0M2?=
 =?utf-8?B?KytLU2gzVjJVT0ZDY3FoR2s0Tk9CQWF6cE0xV2Y2MDdDaUdYcjlWSWV3R3pi?=
 =?utf-8?B?d0h6bVNEeWVjTWVlV1hVVHpBUGJjYjY1enhzekoxS2NyWFkvL09SZ0NtUFhy?=
 =?utf-8?B?UjFpM1VWWXZJa2VLYjE4S3R0VWdrMlQzRkg4VGNIWS9WMW5aRWlmVldoYWpB?=
 =?utf-8?B?dmM3aE1SbGkzR3c3Qi8yQVF3cmtwY0RjUk5rWmRIRlFEWWY5bzVidWVtK0Ju?=
 =?utf-8?B?M3FCcnZWNERoM28wWTRET2F6T0JFdHN2Slk2ZExSbmJ2V1czK3ZDeEEyRVN0?=
 =?utf-8?B?eElwa1VjbmJTWTVjV2ludWdubmxESFlRbGtENmErb2FGRmRqWTVxQldDOWd2?=
 =?utf-8?B?NmZZblF3bUNldTh0K0ZkcFZaTGx4eU1EUmovdzdMV2lMZ2ViS0tZcmhlTkY2?=
 =?utf-8?B?REl1dlFLN1ZNK3dCS0pzSVd0Z1dxQlMzWXNWU0NiUUpVRWYxWWhYZEk3dzJi?=
 =?utf-8?B?bDM2dHR4M1FQTXY4eG1TODJWZ2xQYVQweUNrQ2VnYW9uTGVqTDYremJjYWVj?=
 =?utf-8?B?ZXhWekRiZy90Q0tjNTlJUXE3TzZBeEpMcGE3ZkFYQW03U20vMTFyNDQxZVFS?=
 =?utf-8?B?dVZsQWczVDZtK2Q3MzZtbzNLSzFNUVZCdjNqZ3ppeEliZERBck0vMnRkZmFW?=
 =?utf-8?B?MEk1b0ZORzhsNmZaRUZBWDJTdGQyN1VvUS9EOWtkcDFHN09BQ01sUGk5dm0r?=
 =?utf-8?B?RFg3ek04RW9WLzdmQzdGYXpRaXhiNDBRZGwyZzFHbDM0c3UxWDROUmNoWXVj?=
 =?utf-8?B?Z01JeEFYVFAxUk0zVFVLTDFZTEN6Rm5jWCs4dFdpckI2aEgxemdhdFB3V0d5?=
 =?utf-8?B?dXYrV3FUZ0ZQUmthTzNOUUJQZEhCMWVmNGdQMldQdUJHS3I0VnhoVEFHRlZ0?=
 =?utf-8?B?bThpVjIrTUZBaHhrS3MvazJmSUxHUkdVZzk4NkJTQWVMdGdRQ0xHQTl4d3F0?=
 =?utf-8?B?Rytaem1OYXZRdU1yWXd0Ykl6MUl4QXBic25UZVlJc2tjRi96cWpPdjk0ZERk?=
 =?utf-8?B?cHU3N2RoVXZISVRZSC9nd29Xc2xxMitwS2YyWlhQUW9vTjlTaHFFQmQxbC9H?=
 =?utf-8?Q?Vu7GkoaoAOge11KQYbZ0Byoyl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad202df3-e245-450f-bfd4-08dd1a867cb2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 08:25:07.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/kboJvNYO99hnCWY0XyMkQJ5zfvxK4nsGklPGEKSClhv1wEiF2QCt58smbo/kWzX+CWf4L1LfUFCBKzMLPKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323

Previously there was discussion on using "feature-controller" or
adding a specific node to group the fuse information for U-Boot to
parse and update node. But rejected by DT maintainer(Rob).

Since the STM32 engineers added access controller concept and landed
the support in Linux Kernel, reuse the concept for i.MX.

i.MX OCOTP eFuse has some bits to indicate a specific periphral or
function is avaiable for current chip, for example i.MX93 has variants
that not have NPU. So introduce '#access-controller-cells' for OCOTP,
and add "#access-controllers = <&ocotp [gate_index]>" for periphrals
that needs accessing control checking.

In OCOTP driver, the nodes under "/soc@0" will be iterated, and checked
if property "#access-controllers" exsits. If not allow access, detach
the node.

In the end, cpu nodes should still be handled by bootloader.
And I may also update i.MX8M to use same method to support variants
if this patchset is good.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      dt-bindings: nvmem: imx-ocotp: Introduce #access-controller-cells
      nvmem: imx-ocotp-ele: Support accessing controller for i.MX9

 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |   5 +
 drivers/nvmem/imx-ocotp-ele.c                      | 187 ++++++++++++++++++++-
 include/dt-bindings/nvmem/fsl,imx93-ocotp.h        |  24 +++
 include/dt-bindings/nvmem/fsl,imx95-ocotp.h        |  43 +++++
 4 files changed, 258 insertions(+), 1 deletion(-)
---
base-commit: 3e42dc9229c5950e84b1ed705f94ed75ed208228
change-id: 20241212-imx-ocotp-cbef304140f5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


