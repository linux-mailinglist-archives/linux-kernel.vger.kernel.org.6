Return-Path: <linux-kernel+bounces-302907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB919604DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B866280D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D1176FD3;
	Tue, 27 Aug 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cPSRAULn"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2331990CF;
	Tue, 27 Aug 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748506; cv=fail; b=RBXUhezfGJF+W7lhIuNF353eZjKKZKcYpTKzhZKi+YhPSBy6Mg/0/T8Gn1hm9cOCAbb5AjG8bmY9HIukDZLXoR2AjyOZGmBo2SBDuoPFcxzBYjpQVzdjzroMALPQn/9AQjyr6O1dGnDCLF/ovlRGfBNDfci0HEBtXyXPsTgOiGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748506; c=relaxed/simple;
	bh=k/CZEQCZeuOz8W/R1Mcj5DsTtSkXAvg/SK3LTSiLHcM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hJ80PLjzyeHjcaot17QPGaOsI+h6SnMW/c+K9PoWGeKMwF1imyfnCRfosN1yQbKW0ron8iriaksJQJ+Ot5PkeKjT5FxopR0t3ZasGnEJ6DOvrwkGrfiuLd85rMDilikh4Dh/eUIgk+B4dl400nN3eSEioqrqREwMilCsXCvqyMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cPSRAULn; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M35gduQU6CryEGbNRrL2Z+d5Qhmf2geaPf6Dn/gXZPFafTYfsTaLvXKu+QNnW6fycYRQi3mUPdIZmnNtTJ5N7N4YtqmP23G7UCyVi/Y5oMxnlfaHSOJjvlfe0EX1i+kaavy5z1MzZBdpB9qvbnK5waPOaErPZykjhT1+rY31kjae0BvZIgInzrGYJir71V1zXswXeB85lpD70zOMqWWjXRAzVWYgz3fuxcC5YWlWjPTQByspgwaRC9OdwIEE3U7hyN95QKbVHmHZL56eRnmWhS28C2Drd9oyaklXG+RAjCW2slG/tqJ2GPMhN5J4d1ZWjGXR4zab1hm6y57VNW5ZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBywNm9rCx8O1nhpFZBty3IRaL/1NgDpLT3TMOPaOVk=;
 b=lIq8XvWigL+Jo/P10L2qulbeupPPwAATds6gti/OEK1Hmp/ZiwdqABAtSFGystugpaD1F0NZ7fjNfi0jD3vGW+Brc7acfG4UatVd4KODzVc759LLF9TO5P330HQ4bqYN6jbTWhYzwCR76287SSEInT0rPeUuzRLgfeYjMatkyzASRVtMn8tD0AQedTu5HjQOq6KxFn0AJvJ+FxtMbrrpoEnR3UdXjGyrbw922ijoKzsqzTyU5Yobe7oZEt/PCCUBMhVqbVC4uaHeQ1woW0pP1f0BHBptPl3eCJ1ySHxdtG8Q2yEXobFKuoIxAn/Cnqkh2FXMNRpLzc2gqBk1KPMvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBywNm9rCx8O1nhpFZBty3IRaL/1NgDpLT3TMOPaOVk=;
 b=cPSRAULnh0/RsXl21UJjQJWp02avr9YUxGf5vuE7YZNnw0etGIAIS+3fIrkHD+F04AMptHmfPJVHxq0OAufpiGah3Zb+xaJdBdvz6ABtRnoGRqHzMmAYX9xghZ6BJ5jbXaFjGF1j8nAWbyf7WZjmWZNf/yAH6Z+h35zwd9NEjhhzrlLqbzniZ/UV51EGwhQ/XHw5nnElTaCVHVv+4pPuneYkrtQUH6yy75J1kVhY0zal8GYnmp7MZ4p2oPyH47tjDivLhdDNoAiXF2+irn6yChK99plNKEJz9c15sTDAXrWE+dsgYIhWdskEo8kpb/kfMUSW58C4JDZCDfIgJ+ozAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 08:48:20 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 08:48:20 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH] arm64: dts: s32g: Add S32G2/S32G3 uSDHC pinmux
Date: Tue, 27 Aug 2024 11:48:15 +0300
Message-ID: <20240827084815.1931169-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0052.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: deb35a01-8cfb-4d45-b9aa-08dcc675008b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWl1YzBpRWdzVHBUbDlkUldOc3pHbnVMT01TSk9wMCs4ekxKOHBZbDNXdFlI?=
 =?utf-8?B?dFozL01Xb2V6RXNwNEZ1KzdxRzVGdWxsZHVhUWpNbGg3NkEydXh3dnJjN0o5?=
 =?utf-8?B?WTBJM1BPRmVYbGoxc2JSQ1FrcFhHcHovWVdBV2lrV0VOVmVmbCsyU0h0OTIw?=
 =?utf-8?B?UzVQUE80UVI5RURITCtrRGdZSEl2aXVsbFRiN3JsYWJKS0VGT0pGZzVlMUQv?=
 =?utf-8?B?VXg0SEs3KzZLY1ozbUVyKzVQUzZNajVPNCtqMHB4ZFpPM1ZJdHJaZ0VaYldD?=
 =?utf-8?B?VGVzQ081Ujh2MEh5VnNaeFhRSXIxWTkzYWpzT1hZSVVKZlpFdk5nK25kcFp1?=
 =?utf-8?B?bERTeDVSTWFDdGZoYTdBWEp2cVdLd21MU1J2cTJ0TU5RWWZiZjBXazU1NU51?=
 =?utf-8?B?ZHc3UVQxcm85SU1DS21ZczdabXNmcENVMy91ZVphMzdTYUZaNUwyK2xJQkhj?=
 =?utf-8?B?RzJlQlVXb2FwbURYcmlzcTNKU0c1RmdZZFhpY0ZCNnVBamtwR3JRcWFFYWtn?=
 =?utf-8?B?NDl6a1VMK3p1NGlqWW5JanZVMGRaWEpUSFhPdHNzSFpCMlNQR0lBZDhuSkQ4?=
 =?utf-8?B?Vi9yMzJNMlJJcndmNXlqWjJtSms5REh5YW1NSHFLTm5Cd1g0VHRrV2lUdDJW?=
 =?utf-8?B?S2dKdjQzNndOVlhtYUhvNlhqWjNHUmU4ZXpNWW9xVElqbFl2SXFPd3UvcVZG?=
 =?utf-8?B?THZ2RWpJYzRaRkNRaTZKZUppVWVLWUZBdm5zb2ZFTkZ2b1V4Ti9HYVZCVXFh?=
 =?utf-8?B?WElNbUNQYVNRc1dHYmZ6K3ZKUFJHekVOK1AwNGhFQVJWaVpsaDRYZFFVODJu?=
 =?utf-8?B?RVdaSGs2U2lnRVlCZHk3dEZ3YUloenpsT24wZEpVQTVWUy82K3QxMS95aFhV?=
 =?utf-8?B?YUhLVEViczhjZTZmKy9qeG5qYWRBOGtIQWZyRDhiSXk5RjFFWGFiQlJMKy9k?=
 =?utf-8?B?VlNTVTREVm1XUFdpVG1ERGE5ZkFQMFU5QlcvWWJlOTAyRjl4SXREWmpiT2VU?=
 =?utf-8?B?M1dtVElLWGp5OG1ZeUM0aE5sbGE1VUpIcHVqRUFsMmVSK1hJS3pLc1J4U04y?=
 =?utf-8?B?aytGQXRsMmpTVGtUTkdLazVJSnE1akoyTkpXZGZNWCsrWllEREcyYXFRczNa?=
 =?utf-8?B?Z1c4RGYxaWJpVCtXYm9OZ0lWekM5M08rSzY2TnlicEFLeVlkN244YTU5Mk5w?=
 =?utf-8?B?NVFxelBqWGtldks4M0xwUjZ3RUlra2xjQ0Q2SVBjYlQ5aU9BS3R0RGVlUENy?=
 =?utf-8?B?ZC8rd0Q2bkxadWhnNER5MGdHaTBXZWxRR1VHeEM5cllnaWdzcE1YUXM0K1lQ?=
 =?utf-8?B?VmhkUjBYeXFHYzhjU0lpRXZYZzhCd3dha2J6UVBteENLL3owZjlrZ3lsL0Jz?=
 =?utf-8?B?MmRrRmFjTUsySTlyaW9uSkhNczF3RHZVR1FTOFdNUGYyUnpLV2M5VE9nM2dS?=
 =?utf-8?B?N2JDeDZHeC91ejNaalcrcjFVUGZiK0xlTmVFaW9OOGhTUm9sMFpheWhweU9x?=
 =?utf-8?B?dkxxVkdCdTZIR1NnQlFWTzFyVDlKT0gvaFVBSEJ5bU1yVGI3SklRNVRRTVdi?=
 =?utf-8?B?eDFpZnE5K3dBdXhCZU9RMllYOHgyL1AxQ3k3ZDlZRi9MYXRjTWd2Vit0YTRu?=
 =?utf-8?B?N3JUdlFzWWtLYkJpaFhoSEdrQ3pWNFZuYlZVZCtnWWEzNXZnallHenJhajZK?=
 =?utf-8?B?NDl5V3J4cFl3YmoxTERaanBHMDFjWXZVaVZRMEUwTFVRR1JCMnVOclFBYVpv?=
 =?utf-8?B?TWNLdmw4NEJBOThGWVJrNkk0TlRFanY1Uy9BNy9FdlZIeXhHNmNXZm1ydnNq?=
 =?utf-8?B?MkI1ZjRRVHJUR01LS1EyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUNwMDhjUFpvaDE2RHpuclI1ZnZaaWFadi9PbUg4eC9XL3o3c0hVSjhVRWM4?=
 =?utf-8?B?Z0x1UXFKMVBzRzkwUjBxSFErRnlxREZFTUdZNVVxSEZES0NFa0FUM1daWito?=
 =?utf-8?B?ZTlEZEEvQzJxRHJWb3MxYUJmY0N3TUJXb2hoeGJQVnJKbGFWbldqS2N3Nnpn?=
 =?utf-8?B?UjFydndJZldhZ2NzZjVsV1l6WlA1b0hyaCtpc0lrQ2VOME1IS3YrYjVwRXBv?=
 =?utf-8?B?OWRMdnlCTzUvVUdjcnVnakJlQkdLQlIrVXVwZkNPS3pTK2ZmdVlTRStnejhX?=
 =?utf-8?B?eDF6SmRPTGhkY2tUSzNLNnpXYnE3VksraHpkTU15MmpWVzkvQTd5V211TEZr?=
 =?utf-8?B?YXJSRjU4Q1Z6bDBIMzYxT1FMYVB4SS9FU1FwYWhFR29pazNwR1ZZek1nVXdQ?=
 =?utf-8?B?Yi83aHA5TFJxT29VeWNpN2Z3MVlJeVhPdHl0bUhwSFNJWCtVTFBXbXU2UDR6?=
 =?utf-8?B?WUljQWR5T2RsTmFDc0dLREJDZEdqaWE2eFd5YlRDS2xkbExaUmUwWURObmRq?=
 =?utf-8?B?T0RKSlBXclFMOGw5dnE0TENzTWZ4VlppOUkvVkwrSVVkck8rd3RlQ3MrNUFq?=
 =?utf-8?B?ekxwMzNEeEZldTllQnduOEJFSFlJRkdINHRjOHI5YlhqT205aTM2Sk1PWDRI?=
 =?utf-8?B?dVhVekFjSXlwZFN4ZVkrYytqK3oxR2ZHSE9makNmcGpSMFFCY0tQQTdYaGg0?=
 =?utf-8?B?L1J2Mi9wd3JUN2k1OVdaOExScW5LZGFxdFI3bzBjZCs0ZG9heWV1VGRHSmxS?=
 =?utf-8?B?YUJHWGNURHR6aVdieTZMcWJKcWptUXpCVTd2TGNKSkw4ZUZOUjRHK2luSkxC?=
 =?utf-8?B?OVdIS2trZlFJQVRBY2hnVTdtQU1pR2V6bFNDUW9uc0xDWUVpL05XcVMveVpZ?=
 =?utf-8?B?dHc1ZE5zdFFSaGtpV3JtR3hhTVI3UnVRd2F3NWZFNmUvbnF1TVFMVWJGYWh6?=
 =?utf-8?B?WWI1Nlg0bnNoVktPa3B3NENONjlPMzBqR0hMY3dUeUxhbUZCc1hFSXNEejNo?=
 =?utf-8?B?R2xoTXU1KzdEUHVHTDVnVlVzY1VuQWFjYzJjc2d4cXBzaVR3dHE2VkJGZW9l?=
 =?utf-8?B?cjBYT2FqS3BXWCtaQUtPdGlHSlFkTWdqUnFMbEVha0FnUzF0ZkZNcEV2T1Fu?=
 =?utf-8?B?ZHdTbnFoanVONjRqQjFlZ2xSeWtGU0gwWHpJbERuakl3L1JSanRjYTZjZytn?=
 =?utf-8?B?NkNTMEdVSnJML0xaVEVrSm9XeWFSWERPRW9uQ2hwbGFqOGFDNHVFb0J4Mnhl?=
 =?utf-8?B?NEdWdmpZdllRa1FpRkw4UUJFVnNTSE5wM25oZGVIUXl4WHVxMjAwUWl3bDdS?=
 =?utf-8?B?cmMrV2hQUURmTWJaMXEwSkxNcEtFNngwOGVaakN6VW9iSSszY0JQbWluODJM?=
 =?utf-8?B?dDl3VHlzTWlUNy9FdmxWOFFaWDNiaFVaOVJVNXh0Z0ZMNnRac0l1RGZ2bDFD?=
 =?utf-8?B?QVl0UXVLL2hXc2NQd0IvbUgva2UvOXVmM1ZsNVZTN2M5SU5rUjN3RndPMEtU?=
 =?utf-8?B?ZmlnVDVnYTVyczA0UzNvRmhGNmEwdUg5NXlXNXFMdStXN1FkbGliZGxiS3dN?=
 =?utf-8?B?bXlyODdBYTNGT1IzdXRUT2xpa2cxYmpvNFVJSTExVi9ITVQ4T21HdHk1YUYr?=
 =?utf-8?B?SnVBMzlRKzl2OEtGWGcrQkVzdVFSSVcyZFhOcUFDS2JpTU82bHRlSGk4S3pi?=
 =?utf-8?B?SWxVNG44VjJUeXZpZ2NuSHdLVmh6ekhGWTl0MzhUQ3JXcHo2NVZWTWwwelp1?=
 =?utf-8?B?T1FGZ25CVnh6azhhWnM3Y0F1aDdEeWJIa0pkbXYzcHpNK0JIYkd4am5lWmxz?=
 =?utf-8?B?Z1c2bzZxL0xodFlkZHVxYmhmb3RJVU85ZS80VTZJZXc0c2xOWVI2MS9kWTdK?=
 =?utf-8?B?ZVZ4NDBybFZISk9Nd3NpSkV4WXhLckV6elNKaVMyam9PM2lNL1dSd0xPYVE4?=
 =?utf-8?B?eUNZdk1YdU4zaVUyajV3NzlML0s2bWtxbFpsVzdkTGsreWlQOHpVSWlScWJQ?=
 =?utf-8?B?aUI5U1NNZ2JOV2lTT0I3a2tNVU5ZMEoxUk9QT00raXlIcjE1U2pNMzZqenAy?=
 =?utf-8?B?QnJBQ2ZhZlI4R016S0xWRnJYTU5VRWhyd0NHVExIa0twc1ByRUVWTjlkOXpq?=
 =?utf-8?B?eW9xWFJ6aUpZZGc3NlFobGpNeEhqQXNCWmRRSGRpcG1wcEZqMTlCNlJWVUdw?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb35a01-8cfb-4d45-b9aa-08dcc675008b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 08:48:20.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqvi+v4W++6xmZmxfLBO0R0ejNmHpSvCTPZj8ZB+cjXqMK6OmzN/KYCF3SBYd3A3OP7wjunNDv2TJ+MhpkkYKsmJbRghH8W2IiW0nam3rTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Adding 100mhz & 200mhz pinmux support for uSDHC helps to support
higher speed modes for SD (SDR50, DDR50, SDR104) and
eMMC (such as HS200, HS400/HS400ES).

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 153 ++++++++++++++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |   4 +
 .../boot/dts/freescale/s32g274a-rdb2.dts      |   4 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 153 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |   4 +
 5 files changed, 318 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index fa054bfe7d5c..303be64399b5 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -162,6 +162,159 @@ jtag-grp4 {
 					slew-rate = <166>;
 				};
 			};
+
+			pinctrl_usdhc0: usdhc0grp {
+				usdhc0-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
+
+			pinctrl_usdhc0_100mhz: usdhc0-100mhzgrp {
+				usdhc0-100mhz-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
+
+			pinctrl_usdhc0_200mhz: usdhc0-200mhzgrp {
+				usdhc0-200mhz-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
 		};
 
 		uart0: serial@401c8000 {
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index dbe498798bd9..7ab917f547ef 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -34,6 +34,10 @@ &uart0 {
 };
 
 &usdhc0 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc0>;
+	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
 	disable-wp;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index ab1e5caaeae7..8739f63771bc 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -40,6 +40,10 @@ &uart1 {
 };
 
 &usdhc0 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc0>;
+	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
 	disable-wp;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index b4226a9143c8..0d6f077b1eb9 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -219,6 +219,159 @@ jtag-grp4 {
 					slew-rate = <166>;
 				};
 			};
+
+			pinctrl_usdhc0: usdhc0grp {
+				usdhc0-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
+
+			pinctrl_usdhc0_100mhz: usdhc0-100mhzgrp {
+				usdhc0-100mhz-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <150>;
+				};
+
+				usdhc0-100mhz-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
+
+			pinctrl_usdhc0_200mhz: usdhc0-200mhzgrp {
+				usdhc0-200mhz-grp0 {
+					pinmux = <0x2e1>,
+						 <0x381>;
+					output-enable;
+					bias-pull-down;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp1 {
+					pinmux = <0x2f1>,
+						 <0x301>,
+						 <0x311>,
+						 <0x321>,
+						 <0x331>,
+						 <0x341>,
+						 <0x351>,
+						 <0x361>,
+						 <0x371>;
+					output-enable;
+					input-enable;
+					bias-pull-up;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp2 {
+					pinmux = <0x391>;
+					output-enable;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp3 {
+					pinmux = <0x3a0>;
+					input-enable;
+					slew-rate = <208>;
+				};
+
+				usdhc0-200mhz-grp4 {
+					pinmux = <0x2032>,
+						 <0x2042>,
+						 <0x2052>,
+						 <0x2062>,
+						 <0x2072>,
+						 <0x2082>,
+						 <0x2092>,
+						 <0x20a2>,
+						 <0x20b2>,
+						 <0x20c2>;
+				};
+			};
 		};
 
 		uart0: serial@401c8000 {
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index 176e5af191c8..828e353455b5 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -40,6 +40,10 @@ &uart1 {
 };
 
 &usdhc0 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc0>;
+	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
 	bus-width = <8>;
 	disable-wp;
 	status = "okay";
-- 
2.45.2


