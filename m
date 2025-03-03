Return-Path: <linux-kernel+bounces-540907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA615A4B651
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609DF3ADB53
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FDD1D798E;
	Mon,  3 Mar 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f/7+yzj9"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E21CEACB;
	Mon,  3 Mar 2025 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970479; cv=fail; b=feW1uGbaZGol4LWx9QwJGuJeYQtAcAeSQtmTu/ezFbcHUYfml0X9rny+uTOh2pVjeDiQ4p90dqGzbW6r0ixhz37ozR7abj6TaozaCZDwGBbRBRzaKroQMv0tByRs3joI4GxIMny+wsof5tcKjsy62U7B6bx6iuJWuykx26j+zcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970479; c=relaxed/simple;
	bh=t4Ww+OqYx8fGy7BMuAgi5pPYWim11K8vV+94uX7mSaY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N7MCLrZYYqgHdsUnVrI+VOVhagfe/hvzQusP90nh/BL89n/3Ufet6NWd3TzDUz4ThKQUAqx0deFMuL6aZuifJ15/xPpT7miwQXNSzxDeC36zjL1HQqLC8PuLOO1Tj0KGZWNxzRaial60Y+zZ6JZubINuNTcBB/w+geSIKEKF6bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=f/7+yzj9; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM/q+Aefspgj7pb3EspBITw4bmzwYAf9PaATiIX2pJNySbRaCmpdJZDEriJD9BO6FJnHfSn7Z0XI/z1blFRtylqlFnj1pQKjzhqPwBpaXNosvjeGquGTzeSRZ7Q7KIeLDdaGtU8sh9Hij3DcrYC1MYuPNkglBoJ3/QQKR7qurI/9yt/UM31g/LtM/HgOStQliNVwh/Gbtx1EhZ15s20nDcQw1ZmCbLUyFZ3Sn3NmevjKNL6p2Zu6Xj5Raog6KY8QVWRpjMETOOM3+SfLeYPmMkPSa7/9TK5EduKNPUTKJZBwjiGOpUQJ+754kGJLn7Z/bEDfSLmYQkLfbizrd/XVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7kZuCfYSrlijWa7UOfAdz8dGJfsn09eUbXmu9wOoi0=;
 b=xDByaw/RkoVccxgUpVEHKMHb+Dr99hj5sD6bt/u4x/423BGPJ3HjW9/yoIbLj4zr2ZYu1Q6zAZz6AWq8BpWOc+MVVxtv2qRqWlbeg1yaWDiuNvOjKzH7U0DcoNmQvqg1xP8StnD4xSS36vh6SGHlNrXwhiBzvrNRfb+ng68a9IDF5T15qI32m0QNSqSaEWmBl+FyqqMs824Y7vwwu18v3LGmTnx6TQwloJnF5gAzYa1YbMoANJV/xmYJkH20QqxB8IoyBZcwgXl6nQMBzRCsXnH6aeZ5+SCzGDzH6Sre/nsWNlxjOF5t3ZlAz3IeaiPCMUfM4wIm9d3T+4X5kJh3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7kZuCfYSrlijWa7UOfAdz8dGJfsn09eUbXmu9wOoi0=;
 b=f/7+yzj9j3fDqPF6mvWtuF2oeWi93pjmrOGXompcSigtvMqGoIJkFyKePIStmn9wsl8iY4regjX0pCafzussNgYZ/RtUYTW9w72M0rteOsNZjobL/YI8I8uhFmvAl7OS4RXB/KSUr/MoPmtjsBAjks4Jd5w5JcAqVOQgibhvgPhvJxfgEcvdDRO/yuK7o/RtNI63s9E3qf66srY1OzTGLGZTEpAvtTTJd8Ptgy46OL4heaH4MAugIWcbGC40fYDsxuJYvBJgtO2Gzm2Yox+DP6CcOk8RTwtXzTdxpVvFRsj3WYC4WFEdLMQrfjKqhrKo+NKKsBbJyGpid5u0H1UeXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:54:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:54:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 03 Mar 2025 10:53:23 +0800
Subject: [PATCH v3 2/7] dt-bindings: firmware: Add i.MX95 SCMI LMM and CPU
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-imx-lmm-cpu-v3-2-7695f6f61cfc@nxp.com>
References: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
In-Reply-To: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740970413; l=2100;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NGLUlTy6WG0ISNLJLGwXsqGezWvUDcYDoEeFMqi3050=;
 b=z6tjBdV5kkiiUCiwOsuzsdH0dd6WoqMhAC+gUi4jsW6cXssOIMFJultuLjRBQne5ZfWdwx0/7
 hDjYOq5R9MhAqH1woNG2HYpgYljCu0S+vNxwvRJL7kD/Bv4jzdtqtMj
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cc6ab1-3183-4429-81de-08dd59feba04
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0tSdlR1ZUJZbVRoUzk0d25QbVlRSFB5TFBNUEpTaVB6Y282RVRTdWVQVndn?=
 =?utf-8?B?VG9hN2NxYkdZcE14cFhmTlVLYXBNc3RmWlluNTBCUFE0VW1JWjdiRTFpOFhB?=
 =?utf-8?B?dFJ0VGhGdmFqMzdKb0I5Q2hMU2lZdmFiNVd3TEhOeDVXYUVjZFFsNWFobTlv?=
 =?utf-8?B?emNjdUFPdGxHSUVMNjBNNVVoZXRnMnpnMkNNb2MxRHJRMGh3WHQ1VVcySXBX?=
 =?utf-8?B?Nm1MWXdhdVZLd0ZJWi9LbEg2MExWTkdBcDBrTzAwaExwMmdqNUZxMHVWVzFu?=
 =?utf-8?B?cCtYZDZUNk5aQjdDRzliRFRFQWRSSkJNcGJOQUE2VStRZk52YzBmalBxWGxX?=
 =?utf-8?B?b3NGc3h1VW5jR1JncmxmT3RZVzlkb1oyQUM3RTF6NkxoUDFFOVlQK3Z0cGRV?=
 =?utf-8?B?Y0FTdkxPcHFQb292NEVDVVFxNDAxdW9NaExPcUwxQXd4UTZaZTJxWU10eUl2?=
 =?utf-8?B?SkN3Rk52WUN0K2VqQ1NOeG9tTm45QXhFRVhnaWpXSzF2ejNVYXRxMEpRN2d4?=
 =?utf-8?B?VHF4WFEzdFQwYk5RZGllMkF5UXhvd1lTOGFRYWdqdUVkdGNHZFUrREFWcDQz?=
 =?utf-8?B?SXI0cEg3WjZJUzZwS1JTWjRFMzBhaG5HMHNyczdnTDNESkNUa3o2RE1GeThM?=
 =?utf-8?B?MnlrZzloakQyK2RpKzlWY3QrcDdrNkphSkp6aVZ3QkQvdzJ3TGE0Wmd0RjFu?=
 =?utf-8?B?SGN0dDNkQTZRSHp1ajg0RkFvYS9Zci9PRXRrdDFUcyt0SEt3TGg3bElISzJk?=
 =?utf-8?B?eExOZ3Bubmd0Z1l6TklSaXV5MVFnc1pINTFIamJla2lBWEo1Y1cxVjNnZC9a?=
 =?utf-8?B?bzM5V1lYZ1RBVHZZU2trdHczcXpNaEFFMUdyclVoNUdiaUIzY1hzcnp3RURU?=
 =?utf-8?B?MmZiVGZvYnJ4V3F3Z1prSERPbjl0ekNlbWU0VzRVWVh0V0M5Sy90T2JVeWlQ?=
 =?utf-8?B?MWNZSWVDemNEcWh1ZnNVcEJWcjR3Snp5RCtkcHQxbkVQcjFSWjJpZE1Ga0xr?=
 =?utf-8?B?ZjFQZU9uZ0JjSXZXZy9FUHA2MU8yTm9sdlNSNWlOWUNrZzRVUkZHWlMxQ1NU?=
 =?utf-8?B?Y1IwbWNlUkMySFY0WVZnOHRINWs3RUYwOW9WZHBqVTlTREtxRmtQWlpzaXo3?=
 =?utf-8?B?MjJYN0x1VW9uSjlhbzdDQW9ObHpNWUcwSDF6STgvOTdLNmZSMmtla0NzdDRM?=
 =?utf-8?B?aHprekp6M3N0ODY5dEFsS3I1RjZtQVdVRVh1ckd0MGFWS2JodWh6akVvcFp2?=
 =?utf-8?B?RUFPc1J2U3VIMDA5LzlycTgvRU5ZNGhBU3hwbnZIMzdHMktQWWcvQ2tzenk1?=
 =?utf-8?B?ZzBzeFhhdEM0TjVJZzR5RnNkWlNId0VaY2tpa2lEMms4eDlYMW52S0JyN1lT?=
 =?utf-8?B?UzFSTTU2eWg0bVYwV3UwK2U1dVd6YkZ3Wm12ZmtNL2Rqd1dydkgxaGMrUHdx?=
 =?utf-8?B?VGJzMWNuU2hqUGZQMHA1S1VlR0tac25FVnBPMjZUK0FIc29xa2tsVzdHNS9x?=
 =?utf-8?B?b3lkUyttN2NsdDRTNWdVTU5GNnVsK2VRckN0aXdTcHdqVHZtVWhIQ0xSVzRV?=
 =?utf-8?B?aU9HOTFLK05zOG9zejA1TDRub1MrMVBVdkN4Y05EaFU2ZEMwY3pvdTZFOHk1?=
 =?utf-8?B?VmdzYUREWXBRUUc3QkJrMUFzR3FsVnZQS1BrbFFXSG52TFlYdkQvMEsxMWZG?=
 =?utf-8?B?S0RoL3ZlM1F1bHVqWVJjSjBvOVNoWmNzWjRGYWlxejV4NTFYTC9NcUJJNERN?=
 =?utf-8?B?ZnVHc3d5YTZZOHltdzRXWmFCSnNqcjMwK0ovVzNZTGM2bXhlN3VzRGtQd3dV?=
 =?utf-8?B?SndKWFJDSGVWYlA1L0g4MDN5SE5GUjlyTEx3dWE5Z1A0ZUpNbk5SVlJTRkZz?=
 =?utf-8?B?SVU0WUpyS29oYWs4dHczVE5aaXdTUkdxOEZKZXgyZm1XWDZ4VUVBV3l6SkxE?=
 =?utf-8?Q?GkzczGuF76SkZRenMYQw2UvWIVtyiJ61?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVpBSWF6VkFSSnJEYlFKZlFHaUd6bURuazhMUDl0Z3RTditXd1krclF0aTFD?=
 =?utf-8?B?ZjdTWnVIUjlJQXRFSm9ZcUU2YmE0bmFQSW4wMEtzRFprdWg1aDhtQ3IvR1B3?=
 =?utf-8?B?TGl1M2tBNjJNeEtsd1JZNGk1TFpySGtHUFZCMGQ2Mm1IajdHQnZTeDRacjZq?=
 =?utf-8?B?WkpQUUF3VitHZmc4c2k4blFLT0licDVHc1lnTThjbkJIcEhJQ3BNb0hocFkr?=
 =?utf-8?B?QVNWTTRMTkpudThYT2JMU0VidlRUNU1oVU42b1FTTzhyWU1HMHJWRWE5V3A0?=
 =?utf-8?B?ZzcrUHZ1b3A4RVZPRTlFM2JkTUd6ZDVuQ1pIdHpvMGFjWFpHTlVmVkE0dkhP?=
 =?utf-8?B?VWpXaUFxdXZYVk13VEJOT2p5cWZJck5CNmU3ZndmTlpGWWxXWWJUV1BzUlBD?=
 =?utf-8?B?U0JDTEMrV1RPeGsweUdMWEwvdXVrRTBXOGJkMi9uOG9BNmhUVFkwMmQ4aTcz?=
 =?utf-8?B?UVJlTi8yOXNwREt6WGNzUEJtYjF5SlpYNkNsZ01OcGsydCt3V0ZuQXc3eHBz?=
 =?utf-8?B?YmlPaFd4TG1uRHlhS0JCNHYrSUVONG50UDRNdlBVNjJiNkNDdzJYZjJ5clJG?=
 =?utf-8?B?VDFYWkdCQktRcEtFdlVqODNNY29UR0c1ZnJBelRJUFVUWUwwUHBBdGVDdHFZ?=
 =?utf-8?B?bTFiMVl0SkZ1U3BRZlNyaktuS1BGTjVIZXRuN09aSFRFb2NPVGlHblVlMkl6?=
 =?utf-8?B?S0NUcC85S2w4dWtQbVJQQVBWUHNDd1g3d2ZRNnhQL1pIc1AvSWJMTHMyZmNy?=
 =?utf-8?B?WlUwaURUdFhndC9nRkhOdmxtbUZ4QXZCYXl0S3hvRjZ6ckFRNUpEV3dJanFN?=
 =?utf-8?B?OXFFZWt3eTdjUUFyWC9BRXR5ZVEzb25BdkFrUUdrR01PNG5OYVM3cXRLWlcw?=
 =?utf-8?B?ejgwZStjc0lFdTlCNC8xU1NwQTJYWk9wTkNnUDMyY05UcjAwYmJXbndmcVky?=
 =?utf-8?B?SUpzekU3am1ZNy9kSEpINDhNdnB1bU1OeDgyK0RRem5pTWw4L0lJRkE3aldp?=
 =?utf-8?B?Z2NsT0FQbTI0MWJZNDhIVTRicHI1UnlHVjI2T1B4Y0dRN3RhWFM0ektQcFo3?=
 =?utf-8?B?Q1kvS0pYay9hM2c1MUNtQ084dldPZzZQL0U2YnpmdlFFeWZYem4rMnNXbUpI?=
 =?utf-8?B?RFdHdTQ3WHB1dkt4bDVjUC9mY1FIeFRRM1FmaDRza0xoRWFCODlqKzZMRUVB?=
 =?utf-8?B?eXR3d28xYTNTQUV0NTlHdjM1ZU9RWVpqNTI5ZURaemZPaGloaWpUUWNQaTR3?=
 =?utf-8?B?a2dDYUhadXlNeC91NXhiNWtOUHl2bkhuSk9QQ0pnWllKZ0tUT3BWNmdGTUJr?=
 =?utf-8?B?TWJZNzJLOXZjdU0yVG42MVlOVFhSb0x0ZUJPYy9RWTdqaS96MDdBK0lhSXBn?=
 =?utf-8?B?Wm0xamRzVHZnWGlwWXNtRlJESTNWNExLTkEwU1lscUxDQVZ0b0R5am54VEts?=
 =?utf-8?B?eHFZWWhOMXdzaWxteUE3VDRnd0lMcFQwS2tqcmN3b2VvQ0pVc3VsQ0NPdzRo?=
 =?utf-8?B?bXFzaXhhT0RDYkdubHdFOXZnS21MTGJ3SndNWVpac3pLVVdBclNSTUhqZXRt?=
 =?utf-8?B?Qmo0ZjhCZkVIQXVjeUdUUzNUdHZyY2F2Z0FkdlUwWkJMeWM5Ynlvblp0dXM2?=
 =?utf-8?B?bHV4bGhXYit0Z3RhY1NXakR3SGZnamZhZElrQS95dVQyV0J1UFcwNnA4NmpX?=
 =?utf-8?B?TllhQ1NkSzVDUWFXMDRVZTd0SWlJNjY0eGVzM3VTaERVS2lON2QvT3JYcndY?=
 =?utf-8?B?RDIvUU1jMjhmSmp2dVZJMWpTajVLVmFRVFgybnNsNlhsV2JIbzVKa2xlT25X?=
 =?utf-8?B?aXkyOVNuQ0hiaFVYbFJxY05XSGw1UGRidzVjbnE5dm91SDF6eGlFQVR4UUs1?=
 =?utf-8?B?QUNlZDA5NmVDdnI3LzlzRXNud2Ixa2xzWmIwN1NmS2xFRitFS0IydGhZaDZ2?=
 =?utf-8?B?bkF4YlpQM1BsaDhKc2NNNVQ5cU1NaE5pQzYwbFFLOG4rZE1IeDcxYVB0M2k3?=
 =?utf-8?B?WVgzUzlVeVdId2svMmFISWZPaXpjOXZxeG10OTZkR2VZNW02N254L1ovZ2JQ?=
 =?utf-8?B?MnRPS28rM1BWYVhqZ2d2UVljRVhTTXZBYnpxelJVVXhhdVJ0SUhtcW02MUhL?=
 =?utf-8?Q?n4d4xWZyras4M+fNIXxisPq3h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cc6ab1-3183-4429-81de-08dd59feba04
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:54:33.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThrjfJAX1J5gNZV6TBncED2zusdWMmYiZ9A78PKew3KrLfEMzdT2Jdza7tVHAbGYbgT0l9JhcAEjZ2EniaU9ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308

From: Peng Fan <peng.fan@nxp.com>

Add i.MX SCMI Extension protocols bindings for:
- Logic Machine Management(LMM) Protocol
  intended for boot, shutdown, and reset of other logical machines (LM).
  It is usually used to allow one LM to manager another used as an offload
  or accelerator engine..
- CPU Protocol.
  allows an agent to start or stop a CPU. It is used to manage auxiliary
  CPUs in an LM (e.g. additional cores in an AP cluster).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/firmware/nxp,imx95-scmi.yaml          | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
index 1a95010a546b14b1d3d97aa990c0305a551f2620..2bda2e0e13693f12816762137e07dc308d2c49e4 100644
--- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
@@ -11,6 +11,18 @@ maintainers:
   - Peng Fan <peng.fan@nxp.com>
 
 properties:
+  protocol@80:
+    description:
+      SCMI LMM protocol which is for boot, shutdown, and reset of other logical
+      machines (LM). It is usually used to allow one LM to manage another used
+      as an offload or accelerator engine.
+    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x80
+
   protocol@81:
     $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
     unevaluatedProperties: false
@@ -19,6 +31,17 @@ properties:
       reg:
         const: 0x81
 
+  protocol@82:
+    description:
+      SCMI CPU Protocol which allows an agent to start or stop a CPU. It is
+      used to manage auxiliary CPUs in a LM.
+    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x82
+
   protocol@84:
     $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
     unevaluatedProperties: false

-- 
2.37.1


