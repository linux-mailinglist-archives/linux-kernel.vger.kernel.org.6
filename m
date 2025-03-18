Return-Path: <linux-kernel+bounces-565769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A224CA66EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7057A2E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2747204C2A;
	Tue, 18 Mar 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RMPF6m5Y"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8411AA782;
	Tue, 18 Mar 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287663; cv=fail; b=HyHq9gLVt++qON/DyhWWR9dK2aU4z/r5ZhXf9T5khLmcuR/9c+y5Dn6eUCwjzEj71CBiDle0c0bUlIMaHX3d4DbRLLv7Lf3WyYbSUNRqiEv2htPcCjXdbUSmv8T2mR6u7EFzCfBI5P2h1ILlEOdaJKClEhXVoU/i59kelztfw2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287663; c=relaxed/simple;
	bh=LugN8dCiWzy3HKtU3Ramkv+HGin0VrRkn+MZWJGrF9E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aP89qRhF4KYas9oj0ZFcAMG7k9IGvNNctpAQCRtX7+8FbaGcybd6OYLe227MY/Xjun0At2OSswyqr83OhL8qMIrjfF5/0Jq4U8u9qC4F6Cjzwyx45H7lmEIOYUmj+6JZ4vpTj+KTp9PyRgm+W38J0OshkPrQUKIH0z5hsdI9m/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RMPF6m5Y; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr7WIQh5WA7YihlQJnphgltd6M+LdcOC10xfhK8+10+bt8kVrN4DSNqCXq7ho419MWHN8aAaswT96EBdHJ93UCXnaKJqkz/nYqrho7FBcATZCIyJc5sVoAlV3l7O4eC9OZm0M4lk3dtQXbDBgLKNI3s9+f4tkrIzlaT0iif+VHpARl3XYcfWlfvltvkKJhDGNaZy/1rgjjzJlhiHWZweMHwsp7jX95EpWXqPEr5zF2JROCmsuGIEiJgXNkaOhoIzbO5VRMkcQYUSpuPN8m4+8wwPg0U8HhNG7qAQw5V2v+skHfIsoveMiVO27vi/6j/vyTG8dei3TwtUYm4U6oNeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unYPPXWyMHNEvdCJb7JBFIHYnC9wyxbJdn86STCb9uU=;
 b=d0flrl6UL5ZQWwimJWE7DHiucXsLSOE0R3C+p6kRW45amMUh9vouo9AUVGzZHAv4/C6vn06MyXYTVKKBEkXyjayM50toHvvBvM2LtgiQSMH+kU7DWdENFjAwWUirv1OZhVpGFymF9lCrM+iBddj2wnBG0DcoYVdToLDHPyV83cSX3MSbZiOhtgLOVmvLWkbFaqFUP/WIJoeuVRbKZaLR2UuNye+UEgpctC8aJkXJkAA9D652Bk6HRenT2mMDrZC4hoCardsTTDA8qaVS7wz8N6oWi4y77keWG34qmqx7EsYVePhApY4gbA57mssvWB1vzczZWfMCmTnCNhpAoYgGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unYPPXWyMHNEvdCJb7JBFIHYnC9wyxbJdn86STCb9uU=;
 b=RMPF6m5Y4m0nX+pYVnDHCrIbdYgzNnqgO9mT3Lesy1Q7iGdQoMHkFU7S0mv1ohvK6KXuEELu3dSgShQ9TG34fVdYIGTPgZ1AlsVwUZqz2KWA1pDg+yCJXi83PQb1sjdCxg9VfMjwuoLX+o1yCA0bftAoIyMy/oFZyHLYoqHcn+I10KGCCZ6Gos2c2nV6B358hvPq9hRCNLjCQqsAKoBdWtu1QfOgtR+nOausq1L4fRWWtlcW07Hei644NOomXmm1Cf81WwwGFAeo9P5oXISbEgta6Ko74rDrOnyZIRlvJLNTLWHZAFh95ztea+lKV59WqnyPgUjgXMDIr93T29/reA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by PA4PR04MB7742.eurprd04.prod.outlook.com (2603:10a6:102:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:47:35 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:47:35 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v5 0/3] Add OF support for Microchip emc2305 fan controller
Date: Tue, 18 Mar 2025 10:54:41 +0200
Message-Id: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0060.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::15) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|PA4PR04MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f289b96-dd75-49b0-fad5-08dd65f9877e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?wIRvX/7lAdB5Tuae67OR2Jp11wuYw970GSjSbHp9Ap9TXeCUt4qRtiUGZE?=
 =?iso-8859-1?Q?Wvv+GZ7PVBkTFFMMBijByzy/L8WI77E5FW02man0JLBD1H8BwngyBlAyuZ?=
 =?iso-8859-1?Q?NnzSCw17fEZvZ5lMQDcWA5Lq72YsuwQeGrrp1UqwIX0w1lzhbK/rP0Loix?=
 =?iso-8859-1?Q?17pJEi+Cj3Ov4FyOIu9DXoDbuQ1p52g2r3fD7NDKtqjHBVd0g+ZpqHZytm?=
 =?iso-8859-1?Q?j5nxbIf5XCvjMFdRxcMZZoqRTCrjSuv1Z6q2L4aUId5t6ceAVIwskOsAKp?=
 =?iso-8859-1?Q?jxu5f93b9fmJb6OCANyJ6mHCdMex0aQYj7e2PeqpvuABJVb5rhDljFfFzc?=
 =?iso-8859-1?Q?ee+I2Cxj5B3NPKtTKFKb59lZRtR+6GJthjQJyE0K8p704buqZ/i8UIBzX9?=
 =?iso-8859-1?Q?okFcUVhAdC/k8QXGPSetfHruilSXu+GOkz9POLUAqdr2lASAjK9BEWaGNM?=
 =?iso-8859-1?Q?BI80zkZCMce7FbCsrZQ+0+Nk8ZAZ5scURVgU2hgXjS6UFweZxMJ8UK9Dls?=
 =?iso-8859-1?Q?EqcFlBr6Ex1GSNuedgwhBVKE89RmbHfaEnv/SNZFmsoCD/2WNiPH9NGNhx?=
 =?iso-8859-1?Q?pFiZ+6wPPwIOYVmFxh9cofG2iXhl+Pso5jJBWT3a36BInJTnlbNR2wlt3R?=
 =?iso-8859-1?Q?i6MsqIbBDTkRecPPJkw7PaWwon48JRBwlmgesQZQAe6CLw0IifraE4iqR4?=
 =?iso-8859-1?Q?qr1DJNpkHYosw4UDmPnAEfou4pl5T84JCOb2bKoT/i9iczB2eu+ariADoe?=
 =?iso-8859-1?Q?J4nUHE4+cHOkDra+YLdSw4FDRBRQl/e73O483zFc+Uh2Dl+ptPqi9rjUgB?=
 =?iso-8859-1?Q?ZUwuHK6+AK4oFh+cgsjO18oH0iukmhab8lnOK4y9zfs+Z+X6HqIZgjht3v?=
 =?iso-8859-1?Q?LZUHNPqwFvxYUdeS/TcZ3bSCh+OjYE7+hAnYhkrrgzyzDCkSF+x/bx1f9v?=
 =?iso-8859-1?Q?gV7uDJAH93l1usMiZRuakKg+dBd9T76CwTUmTNvHiX5jMs0YwZz5rnF8iz?=
 =?iso-8859-1?Q?DrCH5THP5OL1KZO4zrc1pcBQ51EgSPo1przaSGjYRIUZxb61pFjVwISCUg?=
 =?iso-8859-1?Q?1/656VgO1VdzFa4AL+IvpvG9sYn2UaerQj1apkqn7CQx0fR1j0lttPifPm?=
 =?iso-8859-1?Q?PyshjeqMfiMBtdq/7jqwxoGh1lTZ2FUV/RaICNMLwLZXKr2KFBgKnbV4MY?=
 =?iso-8859-1?Q?sJV11bGOw494BQ1J1BLY7mOlui79QF15nVkYbIgfcwutQfT41MpgZ66F+4?=
 =?iso-8859-1?Q?NwBpfuS2OrQGei46574EQTGRlaf9io/L/EIAJZnaIqVMsIIjdw4/PwDjK9?=
 =?iso-8859-1?Q?nGrFVPgK2NkOIwLKRWf/wZ+66tvKf8/ADa/flgpqYQelpqhpVwIxcHa/bT?=
 =?iso-8859-1?Q?mYebr+cVZ5aaxnQKF+IUP6tqdwNVOSiKsxxrIWliJgg+hz+NJMgGhfu2tC?=
 =?iso-8859-1?Q?Te7DG09ogHAUJCFEc8gimnP6Bk8khkeDqM9t4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?/rtG0jD4x/WE5O9S3LWeKcwBF4ypwWnz6kN5dyPOuahxZK1LEtr4VEoyJM?=
 =?iso-8859-1?Q?Vz0OjfRUdJX92Lc0CJ5ylKswICXVRQJp3wV567BUpurV2lSjrW3UTbPV31?=
 =?iso-8859-1?Q?B4IsNIt9waZd1MJCztSQjsLICbbarVB9jz8htgAV38NcaDaTlNwqOYwCoK?=
 =?iso-8859-1?Q?nNYHnfgISZQRjs5KH0kBkDFqqWfua9c5z3tziiYiNu8ekX0HfLiR9NDszI?=
 =?iso-8859-1?Q?MRRe1dEZPqQpSrP9IGMf1rBO+D9PTH6yWHSZ4yXw+tVubP7uEfyEYupl/n?=
 =?iso-8859-1?Q?X862hSU7dOoqK+BRVHZD0XECgOiaaD+s0ckTRDMvaGthmF5rK0r9F6mcJ7?=
 =?iso-8859-1?Q?PE0FtuwglzUVYotJ8vJ9WUDBdT/0PeyKQ+LWaFp9hjZoNHB/MhRk7Mhqbf?=
 =?iso-8859-1?Q?BkAYQiHlG+rfQ5IbEK0S+5avTgcxFF6d1M043nbeIKzECg3i+V9cvSIhtq?=
 =?iso-8859-1?Q?GDuglT+dqYX8XhZq4WXT3Q2Q6VLkQ1stMRRTkibNTthQf+0Fp+upKC0PPu?=
 =?iso-8859-1?Q?tsguE9E1vk3LeKQs1YaljmnMSN5QpmtfDjP7mF1EA7AZEvxXc5ABhOwlOg?=
 =?iso-8859-1?Q?xUJWlyA5fjjncltPQY+jrH7QzXes1LvJClK8tYLIyf3NsQj63OLO/OIYO6?=
 =?iso-8859-1?Q?aIzuxMeRmmPazKd+Yt2E2bu2PQdijbxLqe5X4Yug9aENk97r3I9WSOwXCm?=
 =?iso-8859-1?Q?lKzdvcETizLZUgir+3NVrFaAjD6VKoVSQ0xQO9yl94CG/3jLNtXVw8zimE?=
 =?iso-8859-1?Q?9F3DrLdvjWL6BquB5KCLPXEm+dMjr4xWTvryB1RZopxXqnCCSg0+o2ai9I?=
 =?iso-8859-1?Q?AwZAk0YH7Jz4XKVVNUiiEfWYRqrgViCVuuJ8QKGAuY4ZTg7CGO7fIrhwxD?=
 =?iso-8859-1?Q?6ISdrOfalreWN4YlH51QwsVQYSH18m49LCMQYUc3iTb+ydDuiYtA3hPrwA?=
 =?iso-8859-1?Q?xggX1AOGBT1RZXWPenNsAV4fL2a0SdI9dF1MpwQTcNjDy5GKF7hE9HquEm?=
 =?iso-8859-1?Q?95bD7SjUDDPAzBeErn9Rv5Aj2RIOmE7AUqrrbPJ/3vUp4PWUHjrt1b9n1W?=
 =?iso-8859-1?Q?Db0jBwUN0Dqyx8Yc+kmjBcwojxRNzSr4UfX2+Vv7tIdSXyEbPgDU6XL1WR?=
 =?iso-8859-1?Q?w2/Ffr+wc3CCW1xC3rSVlk19yJ44k9HTA0oZxQbSdp70UvciHrMJvylR8u?=
 =?iso-8859-1?Q?CLnl53p7nzl2ipfkUnyO8gIU60Mxqor7Q4eb9377Z1jKL9zYjMxlC/dK9H?=
 =?iso-8859-1?Q?L2qy/z7imq1Vg6NHOFcVkrydEKVrcjOd9yM7uOkUykp3hNqGANY0nanY97?=
 =?iso-8859-1?Q?+K8BfBvfOzug5OvvyU4c4hGU8+IbptoVHvonavRktKAHobJjgLN4xJzbBj?=
 =?iso-8859-1?Q?ES+Q6QaOwsFJqi7ZEU0wjzSS92+Q0FfbW3V5z5sIOsZMVBkm6iyUg/1r3g?=
 =?iso-8859-1?Q?jtT0rVqhiZUJ2jfsjZ1agtjj2MUI1kcyen5JcBh2Qqhr94y4CpA1T1joKD?=
 =?iso-8859-1?Q?B59sB93BOiuzuBgUgblTeH9FKcpSPM/++uOk5z/PS5mLYj13mbsFxqkK6R?=
 =?iso-8859-1?Q?OErLi/VdkFJ9RQERdhV3vxqp8R4rN1i6eFcbqoNxSTS4i//7VmTum++EEk?=
 =?iso-8859-1?Q?8VINeThKx9+OXwRSZmvCnCKZNv8zA1lEok?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f289b96-dd75-49b0-fad5-08dd65f9877e
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:47:35.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgO/9f47dm7RkSEOcOMPHuylbbiwVHMBXE6rZSkOsWNmthVgm9WnRIOEsgXLosZce6mvejY2BlxaZkmqlVNA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7742

From: Florin Leotescu <florin.leotescu@nxp.com>

This patch series add initial OF support for Microchip emc2305 fan controller.

Changes since v4:
- Corrected quotes to have a consistent definition.
- Corrected DTS coding style as recommended by Krzysztof Kozlowski.
- Updated pwms phandle to include pwm frequency, pwm polarity and pwm output,
  as recommended by Guenter Roeck and skipped the pwm channel as recommended by Krzysztof Kozlowski.
- Documented the pwms args in #pwm-cells description.
- Updated pwms phandle in dt-binding example to include pwm frequency and 
  use PWM_POLARITY_INVERTED macro to inverse the PWM polarity. 

Changes since v3:
- Removed thermal_cooling_device_register_fail label since is no longer needed
  and replaced goto with imediate return, as recommended by Guenter Roeck. 
- Redefined compatible property in dt-binding, as recommended by Frank Li.
- Updated driver of compatible list.
- Renamed node name in the dt-binding example, as recommended by Connor Dooley.
- Corrected dt-binding commit subject.
- Added dt-binding fan descriptions and $ref to fan schema, 
  as Connor Dooley & Krzysztof Kozlowski recommended.
  Used similar as on maxim,max6639 and nuvoton,nct7363. 
- Updated dt-binding example.

Changes since v2:
- Removed the introduction of new properties for now and we only 
  enable basic OF support.
- Link to previous version: 
  https://lore.kernel.org/linux-arm-kernel/20250219133221.2641041-3-florin.leotescu@oss.nxp.com/T/

Florin Leotescu (3):
  dt-bindings: hwmon: Add Microchip emc2305 support
  hwmon: emc2305: Add OF support
  hwmon: emc2305: Use devm_thermal_of_cooling_device_register

 .../bindings/hwmon/microchip,emc2305.yaml     | 113 ++++++++++++++++++
 drivers/hwmon/emc2305.c                       |  38 ++----
 2 files changed, 123 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml

-- 
2.34.1


