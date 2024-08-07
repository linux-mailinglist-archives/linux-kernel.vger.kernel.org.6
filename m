Return-Path: <linux-kernel+bounces-278085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE90094AAAA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1C72822BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A94E84A27;
	Wed,  7 Aug 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j94rLl8Y"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADB824AD;
	Wed,  7 Aug 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042346; cv=fail; b=rDCLIDSTK+h+Mx5QeSMyXLe1tWUUgQXIKoQdjtlyvq3lsQUWnBJBxBKsHm6yoy0wjkG4yidkY5DBAp/D+ADztUyS1YjJIf/foXeb9+r51UWpDe5H6hPyg4L09S48xN0OG8vE9j23S7z6E6GGsbKihyfvgCUw1a/4K40xcQ3mS/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042346; c=relaxed/simple;
	bh=htQ0LnQizUluK2KF1hvCwtkkMpubZvIPFXWK49EVkd0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EsbcxLyWlaX/0kx9BWZ0USe5Nv8WW81Qnq04Dt0mK6iZotLsmKPo6nWPLItTgx+P2uBtuK30um1hopLlBztSvtcd8ilNwf+SDwyuQFrfAQhwYlYiTOXwPtzNhZvfUpCx5eNhJ7Bbm7hBNtoukCgf4CcnC5flsyXwEOlwkMgFC0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j94rLl8Y; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWDfd9XzGLUPAUo+/qoVhKY431703YJFAU7ggFL5nuNQHb+wXfF2l1+Fta6lODPOtgM/RgyYs1/wLPd4rBQ5Rvx8mFEZe2yEgLuUxXCWXjAsq5puFdJKldr0F8byRdq9E40eYGnw2LyjTeTvuJAc/5dSbsVX3Vp0vNvS9YlHOVVaOVAzFBT7FbDcwY2aOoOlShPH6GSvynQ7/TTzujp/K4hGFRnVtzW5bWgtSRxDdo0SEqlMdtnUWLVuUGihgdPbS1+DpBA8KNKjVTO3A547HHKJoPf5r3xnnM5pJi1qqBWkEdP0kF1EKwXIxB8puk6nB/QjyzZsJP27AAu5Tb5tuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2XXdKmOUStdVX0xuU1my7hKl5+UJrgBqyRsJEd8xaM=;
 b=UtJb+x1Mtn2d0PAlUjtG2V/Z4DXU9fq8gMcCTZn0JtjsIYvxEk1B+XhSqXWM/se3AmeBOQiT17OAlX1DoXpq47FfBnFRu4TQG3Nz5+rLme8IqCpZ78BJmi47XLC1iMQo6E5Jw8eK0ap3rIaPTrxS09LAW0wux++7lask01aygtGXmNYsdqqFWFFh713+HDQytd/7WpR54atO3XP920rDCvJwgxg1e/cNp2H+wn4d2N5h57wBZ9UQwF19DqGAl92EWB36eMwC/svhgvUOeM9UyFO5Tdp5SScaWku+4XKqGMWeRNZi2GbJzWu1PVb0/d1k3oQmxLq3mWepmruZjQJsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2XXdKmOUStdVX0xuU1my7hKl5+UJrgBqyRsJEd8xaM=;
 b=j94rLl8Y5jgWlf9JVUa2oFoDhDla6lcH5EWI3QDkzRktUZ4iCEgEhLfWsE2sFPIXTx1OhDVKkfT9L/ZOeifBgIBfG5Rq0HSt90hizNN05wHZ2EEx6pB+p6QI0aKICAxmTMseYqVa0V7A3yBBC1W+5daV/G9wUsZ/fcvpxpgNvmWen6QfNHNpv4vFlxjJ+KiPAcGMivVvdYnfKCbDl5+nSGiEkSlPFbWywmOODbH7zNH/hTBGNX4ENNB77eQBs5S+Ce3ScdInccLrLysNi97VZf7bgXrjUoHGgx9jgbbLMoWxzWbb6MitMZ+ld2R2Zi7O8GquPV9sRxBqXiqfwAMsXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 14:52:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:52:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 07 Aug 2024 10:52:05 -0400
Subject: [PATCH v2 2/6] arm64: dts: fsl-ls208xa: move reboot node under
 syscon
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-fsl_dts_warning-v2-2-89e08c38831a@nxp.com>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
In-Reply-To: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042332; l=1208;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=htQ0LnQizUluK2KF1hvCwtkkMpubZvIPFXWK49EVkd0=;
 b=xOrUjihMefdnOTihyI91azA5byz96b+rfCrhqL0lhtzRBHiXlKQeFH+7xHlTR/gRy57caPPfk
 HHLpXmaSx6PDmMzSiOKdx782DoCBLmy4hlFc1Hw73f8hxZM59xUv72H
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: ad550b6d-1e9d-44ac-f38d-08dcb6f08a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2RkOGROR21xRm5saG5ZVUdYL1dybDJadGpFY3NwZkN5K0JwUHcwOW1jdG1v?=
 =?utf-8?B?SnZ5eGhmWlVDNktRajNiVmVNcFVyVHFlQjJnRnMxT213WVF2cm5qMEdSSUJW?=
 =?utf-8?B?TGwwS0hvUmR4V1k5WEFnR045SlR6dHhlYUFOT1pud2NWaW1oWDVCT3NsS3pX?=
 =?utf-8?B?RHNZQmFFamtsTU5CWndsUlVHc2I5OUh4UDVQTFkzKzBHa2NybGhXT3JKZTlH?=
 =?utf-8?B?UGF5STkwWVQ2RmZnUkRBR2ZNL0c1cFJUUGRZOVZYQm12dTFEQ1QwV3BnaWxJ?=
 =?utf-8?B?Tlc5MWJ4MHQxTjA1V29oRXdxTjNMUnhScFFZb0Ftb05jenlSQStwaW1uOW1m?=
 =?utf-8?B?dUg4Y01sQlo3V2YvWk1KSmZCNTF6b0F4VGIxNU4xbHJ2UjMzMitxVDYzdlMz?=
 =?utf-8?B?RjBBUzZLNVY2Z3M5VjBpTFJiUFlSTU0xdVFVSVEvdk1aTkRkREJZN1ozUGtM?=
 =?utf-8?B?eVo1b2dMOTVuU2RJOHQzUDlmVVV1Rkc2eDRKK2s3clVwalEvREo0ZWRPWWtJ?=
 =?utf-8?B?ZDV4MHc5ZnB4ZFlubEU4Sk1iWjJlNndBT3c3SWxSRkhjbjcvZ2hnUzRYL1pN?=
 =?utf-8?B?N2ZpM2hWZE1ndGxKUHBsYnpicXdKYXU1dENQZGVjb1VxZTJkeEFlNXNvVnp6?=
 =?utf-8?B?YVRiWm5XT1F3aUZyK2tsRDdlOUg3MXozRGFQNUp6VE05WkVUVWNaN0pDWWkv?=
 =?utf-8?B?bGlSbHRMS1lOeVcxQWpXTzRXUU5oR05WYVUwVERJcm1zTDVIeWd6UnREMk8z?=
 =?utf-8?B?MDl2UGExdW5QTmZGTU5ZS3kyTEVuOCt5UExNaW1KbEF0Z3ZWa0xoc25GMnph?=
 =?utf-8?B?UWJjSjR1VC9raGUwWlhsTzlrUzBPTzMvUUtpNHJiM01LZlJ5eWQ1RFhqNDUz?=
 =?utf-8?B?aWNiOHNUMnRJMUdiZFFhVkdGeklnNUVLaG0xMXhWcmF1eEwxK2x3MkpPNkpV?=
 =?utf-8?B?U1d4cUhSZG9KWUpmM214V0tBMzZXVlQ0RjFSb1dCaytVSFNBSWpBcHZrcThv?=
 =?utf-8?B?OEpqTXVSeUVCdGtPb0dKWVJQSTFLNXRuWUJnUU1FSG93UkhYR0lCUzBIRHVC?=
 =?utf-8?B?N3VrN285M2RCTHA5eEIrUjJqQ25nSkFDdFloUXBIVHI2SmtKYTZrdzNMb3hL?=
 =?utf-8?B?MXEzMDJpN2xoN0VpWHVRYU1ReU85K3BsOG41SFQzVDN4Y09NT2ZxZEFXQyt5?=
 =?utf-8?B?UmViVURLeWhlUTRoV2JIK2c3R3JRbFRTYW4vYTdLNk4rOElCWndBMnNCalow?=
 =?utf-8?B?OEtMYjhXU0NFM2d1YTR1TU8zbVdIbXlRZkJTTDBYdTJ2VEFaamhZWUF5YWtV?=
 =?utf-8?B?OHIvZXJOSlh5T2ltNDI5dVZDTndzVVB6dlh2ZGg0QnphdFRhVWJOR1NocVNV?=
 =?utf-8?B?RUYxZmdKZ0k5UFlreUlhTnIzSUF6a1NhVjkrSE9sVktHR1NFcERNWjU4Y2Y1?=
 =?utf-8?B?QkFxaUovU0tOcmpnSmRoYnVtVTlkYUhyYjI3OStBbWprN1IwUUtzQUxudnpJ?=
 =?utf-8?B?U0UvWU12ejcweGxLa1o0M254N1VaMHd1MjQ3UHl0WWJUUGhmK0RCdG9jVmpJ?=
 =?utf-8?B?OU5wT1p6enZZeW9RMVZkSVd5TkJGZjNPdkp3R2NEdGxkNHlTR21yRExQcW9o?=
 =?utf-8?B?N3RMTUcxVStJK1plVWRSN3V3TllFU0s1dnYyaUQyenBMVjhDRS9CbjJoVDlG?=
 =?utf-8?B?NWkvMlpDczRrTTJsN1JlQkI0UmV1N3F6c0RtSXVXbWxodktRMVNUUTV3R2Ju?=
 =?utf-8?B?WnhhUmVJWHZ3cksrQ09GZTBnQUxnZW12ckVONG1WQ0wwR3dLajNEcVBBSDdi?=
 =?utf-8?B?eUNsN0l2VENIWHBDQ1I4RVNHY1RkMHpwWWZObThRdG5PTGQwYUc3eWt6TzFm?=
 =?utf-8?B?bkNaTE1HdzlLd1g3dnV1SHdIWUZaaVpOSXg2S1FWY01xQ1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THI5eXBBUFFTN1E1blFDYis2MDJid1lGcVpUcXp3Z2ZlbEpUOWhSOGhZR2xl?=
 =?utf-8?B?WE1uQ2E2YldKOHVWSytTRWdLNkU3dHk0ZStwUi9zc3hVUXZUZmFhaUd3N2VG?=
 =?utf-8?B?cDhmS2FnbkR2TExxenQ1V1pvWXh0MEVYSmk5Z0pQM0xvN0tuZVJYbEpRTEFB?=
 =?utf-8?B?VjdpbVlTK2V2czNqc3V0N3ZvbWQyOUx0a1RtUnNGMjNMczNKaDU3dEtNREdJ?=
 =?utf-8?B?Q1FPbVpBbUZvTnFLRlI5MUxJZnNPMS80a0NTUHduTkRoZ2dWRVNOek91endo?=
 =?utf-8?B?SzFDREgyWkp2ZVZRdDFBMEtIaUt0Uys2OXlvRnNaMlVuNE1KY2tFZ2ZtL2Jq?=
 =?utf-8?B?OS9ERHZselUvUUtsZWtMSXJpaURpUFNDc2xwWlhjYzJBTFJRSVA5WVRQQm1o?=
 =?utf-8?B?eWhRZ0tZZ3FaTTVMV2pOcTlPLzlieVlRRFhWSHdTcWZCakhwK2dXQjJvMDFY?=
 =?utf-8?B?YjR2ZnlabmdtV3FENGlFRW5LbFFCVUZLRnZpZm9FVDBZbkMxaSsvN2E0TkY5?=
 =?utf-8?B?TDhTdUVSdXlyNTVmQ2xQckl4ZnV3VzJGOW9uV3E4YnJvemMvRFc0SVo0dmlY?=
 =?utf-8?B?UWh4UExuWnFnQkxvdXBxRVNzSEhVc1NlQ0swSkMvNVBHbm1TTmxqMmQ2d2R2?=
 =?utf-8?B?NTFCRFhscVV1Yi9FK0Z4U3dnaG1Qc0h4dWI4VnMxZ3pTcGlzSGFzbTFQU1Rr?=
 =?utf-8?B?dStyMFQyK1NSS3NkWUhOaXRoRkpZR1QvUTNUd0VNQUhiSjI5czRZeWtJZlho?=
 =?utf-8?B?N3BLQXBYV2Myb2hEb1ZWQ2dMTGlQcVZ4WW9PZC9sSXNhbzlsK0txdlVyRlpj?=
 =?utf-8?B?V0MwV0FxQ0VpYkIyQWwvTVNSNnhvRGtZOC8rZGQrV21zakhPSXhiaitYSnRi?=
 =?utf-8?B?T2hYMGsxeE5oVWVmczdRazNOaDhNT2RwYTJsN2JvUkdlZWFOaWxDdnJISllT?=
 =?utf-8?B?Y1lxc3dQNEQrbExpNG8vdXpBcmlFdE51V2g5aTFhZlUwMDJ3MC9HOHN3Y001?=
 =?utf-8?B?OFpSMVFLc0ZIcEdMWGpDWE1wUFc1ZTFRVWlRVHhLNDJRWmtydGhCOU5wL0cv?=
 =?utf-8?B?dGxyOVI1aWpqbmtuaC9vc3hrcDZlR2dQYmxKSE0ya3UxcDYwQmgvamlDeXpl?=
 =?utf-8?B?UlNXSVh4Wjc2M25UcFlHYjhoRFcrQnA5SXpDMzdBV1ZCZnJGWEhNYzVlVzQ2?=
 =?utf-8?B?WWVNcFhEakZwVEJRQXpsSnE3dXJDNXBoUFRoWThTa1E0Z1FPTThtc0RmTnhE?=
 =?utf-8?B?ZEJKS3hsNjlNVjIwYWM1QmRhS0FGdU5qd2grTUFBcXQ2eTdDOEJYZktESmUy?=
 =?utf-8?B?Yy9JTnhORGsxdDl6UGFrSTdGem9vT3pXckJEaDVrWmJnMUVlUHR3MDZJU3Jj?=
 =?utf-8?B?R3JqbTN5YmpHQU9zcUkwUXpvcDdRZytTQ0Q2WXNqSzd3c2FiYUVLNmZTNUJt?=
 =?utf-8?B?Sk1Wak9FR3JtQU9iaE5tam03Uk9KckdtU0tSc1F4SGVQQTQxM0Z4ZkVwR3JK?=
 =?utf-8?B?aUQ0bjYwaVpNVThCeVYvRytGTnRJd3czVVVwRE4rcnJMRUYvamlUQjBITHRy?=
 =?utf-8?B?QjZFanhPaytNQjB1Wlp2U0xoQVFWN3BMcFBSVzh4N0F0a0o3K0pFeDNFcWdv?=
 =?utf-8?B?bmQzbDVGeE14eG1sQ3FBdE9aUkx6VXhHSTg4OVRIbGpCWHZUNE1WWjY3Q3Zh?=
 =?utf-8?B?ak40eXJnVDR3ekJ1RzRlMDJTU21Obm9KbHgrTVF2UWU2eFptWkJ5amlsWU8r?=
 =?utf-8?B?dUtmRVY1Q0dUVGRFeVk1eGs1V3ZBSVE2by9aT05maHR0VnFrdXgxdllQak51?=
 =?utf-8?B?ZXNsTWZFYUVTVkNaV3pvYnFMYVY3NDIzdnJ4Mkd3QUZLK1VEN1B6dnRZZWdS?=
 =?utf-8?B?UHRaUGJSSG1XeHNsOVlVVmljN2c2a2E4WGtRR1ZQcDhhemVQV3ZhVit3WVY0?=
 =?utf-8?B?aEtVMG5xVTBKMkxjeCtVcm1FaC8wUkU3eG1RWlgzQnQyWU94emhpb29ud2Z2?=
 =?utf-8?B?T3loZUY2MmJvSG1qYlZlbm5iL2h4STB3R0VRNE5wOVFJZG1FRGk1bHJLWDcz?=
 =?utf-8?B?S1ZUMkFmRG5wcmZzNkFGMmFsdC9nOVlIQ1dOU2lFY0JWZUx1RjBPdWxXV0Q4?=
 =?utf-8?Q?xehA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad550b6d-1e9d-44ac-f38d-08dcb6f08a81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:52:21.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QPw9/etfYesisOaaCf3eUIQw9rMXaVy3OkZVNerOUQmYRIxlDKPAiWO/MwrhXFRMNzEgnOFASGRVVTHHDbfPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113

Move reboot node under syscon and change compatible string to
fsl,ls1028a-rstcr because it is exactly same as ls1028a.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb:
 /syscon@1e60000: failed to match any schema with compatible: ['fsl,ls2080a-rstcr', 'syscon']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 1b306d6802ce3..214ca181e685d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -68,15 +68,14 @@ its: msi-controller@6020000 {
 	};
 
 	rstcr: syscon@1e60000 {
-		compatible = "fsl,ls2080a-rstcr", "syscon";
+		compatible = "fsl,ls1028a-reset", "syscon", "simple-mfd";
 		reg = <0x0 0x1e60000 0x0 0x4>;
-	};
 
-	reboot {
-		compatible = "syscon-reboot";
-		regmap = <&rstcr>;
-		offset = <0x0>;
-		mask = <0x2>;
+		reboot {
+			compatible = "syscon-reboot";
+			offset = <0x0>;
+			mask = <0x2>;
+		};
 	};
 
 	thermal-zones {

-- 
2.34.1


