Return-Path: <linux-kernel+bounces-510662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8616A3201E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7E93A116F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D52204F6B;
	Wed, 12 Feb 2025 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UG+qV9Ot"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F072046B0;
	Wed, 12 Feb 2025 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346099; cv=fail; b=K+MI9wyH2+QzsoCvip1+uZO5zByQ0hqS+UlDtzWl2Nf5zBFEHRcghLhvITPuJvLel0HqgzSC1gx/a0o7WssRJ5J825AtU0ObvYtR6Xx9i/EPky+LpNGFij+73qOF+jWXcwa7/Av9zgfQKnd/A0ekfagULqqeybjmHA7415ozrIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346099; c=relaxed/simple;
	bh=dLX87BYumKCu0SJtPRaMNlWfhnYMb2NqQ34lfE6ZBy8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UC4lz+Uo28VDzmAyKbi1MrxLva2Qa2EqlTmMLayEvP8R3SdMjfAofxblQbjr+IJZ3TleBRi7nsznYVii6Z+kX23J+dIubcHItQi86z6jAzANTP/Z/kHcX/a0GmYh0E+wKx1FLQomMUXQF9NIxiEKuN3uC7+Giga0TYyM8DLPzhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UG+qV9Ot; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTUOYeQ2MfL/YrWIFzZ0JUENX++Ykw6gqGjXQB5myUZX/CabfTrMMJjTAkFG/omq1AgTyZIl/Hp3mniOEt4U382+XjfbDsvmgLF+H6d8M/qeALWKY5ygctNpnanB1z2oXFxG363yfdZKT1gtD9eASrx7o+Vr4IV3j5R4j7MZhDe3V4qCvmO18yOx+MxlaIMxtphgS1HOkjXKb3d37tPvFk7YGDxvaLq3bdWhITaAxsi8ZoiAvF34enwdXkkS1KWuiesuXEJAdBmEQ+a5dHrcCz1B25rMlTOEHxNashjWPfC1IBWUUSh+DYWFgJJTaAQ4Mu8xPQZWt63z1r2A4zHjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=801NIo4+87ARYLa5R5Iu89WiaawZopw6CsikR4i6YvI=;
 b=pjUGEfDnDIAZTT0xdx3rdGhjDEkT/L66x+9CwNi5NsHQfyhsHRJeM80ikeEM5OH+OcsGB7rwYt/KRSO3+3iEEpQm5k1JE1rbvSqHESPRQ0GQMd170+1xlszZBIYGwOoevxHMhDdTlDvBtkZLQoIyCOvABkyITKjfc9yobWUCsRDxuhsnLtiA2Doj8c1uW8mW+23erF/Ob51h5wX7I8QFU1pHEadpLNCQzl/o2EeU6ssn1n0scg94uXE7Y0tMFs+G0c7tSpykDRkL+QqWYCjCBd93uXmcSt04nCXleEGhhGw/83c098EZiPUSxq0dPpPo5ttKSMVw5sJZSzOQkLMYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=801NIo4+87ARYLa5R5Iu89WiaawZopw6CsikR4i6YvI=;
 b=UG+qV9OtNau9CpWWr/Pt1ZtE/jTXoYxM0fi0eJXUgSjfGnKdv1GWlOLemBvyqWkaWkiCJNGkj+pmyhxGNr7pACBGbpRSedyUeOXX78dBsteJ/5F/ojtDwdcEZSQs6jhuyYUl+bC2i69Fkl48ATqZ2kmulXHLlCEBUAj+drdcGA5c/pWJl1hDTD4c3u4MYU7I66aBWqS2wyylU963kiJwEfphJGswnUglxw85gHbbZpM00/72j8uig3z2dQgqxdmb1RDu7M3t/Zl9ds+UQybP+ppxIf1jy2VXhgs63bbwd89Ff3YtbRZzEGTEkjncS1B5HD4BQVoYiUEZAurH+cz0ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 07:41:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 07:41:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 12 Feb 2025 15:40:25 +0800
Subject: [PATCH v2 3/7] firmware: arm_scmi: imx: Add i.MX95 LMM protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-imx-lmm-cpu-v2-3-3aee005968c1@nxp.com>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
In-Reply-To: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739346036; l=10648;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Vvy9asaU//yZ2UynoNHoDkay3kqMP0A6OlYkMhIlOH8=;
 b=qNIcPp9070KDtvnBnIAxa0hLp/ydAYn1tKYCqL6ipxXsVGs44rayEoIqFM5C8AJ8rSFAnCnWe
 6nqJK4kbNVODLYV5OMPVYxnY5121p3pw03k151dv4D9fH70JuKTTpXp
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b72627f-b4c3-4dd2-1b3e-08dd4b38ac3d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFRHeUV4UVRsTkZkZ2lxYU5UK3R4WHZqMFZFVEx3bGdJZmhuTnUrWm9iSHcv?=
 =?utf-8?B?SmhsaHVOclM3b01ZNTl2TDM2ejkvU0NVY3RmK29GQ20wWHg2QXhNVnoxUjJa?=
 =?utf-8?B?aUNxNlVpZGVOeGZLZDJlRWNTMUdJaG1xQ2FoK2NoR2lmLzFHdnJ2cUhraFg2?=
 =?utf-8?B?SkRScWozdmx3MExIKy9XSWYxRXV6ZlY3UEpvV0ViYlJnOG0yK01yb1c0alBI?=
 =?utf-8?B?ekVzS1NORzc4THA0eHJKbHRZWHhpV0NpazBSZmNoc1ZTUkVWUmZYUzBKWGxw?=
 =?utf-8?B?QzZOWExhc0pxSWphUTJyekJqQW1lWnZZTVpzRk1wV2VHTHdXdXZKK0haN1d3?=
 =?utf-8?B?L3JkRjZZMU4rZUV0TmtjTnk4ZnQxWHdvU3F0dXNNcExway84Q3l1Rk9jOGVI?=
 =?utf-8?B?UUd3eTdaeE1PL3V3cXBtWG9wcXRDaDl1YnRuQ0U0T1Z5V0NicTkrdmFJNzZn?=
 =?utf-8?B?UWhkMWdLNnY3cGhnRUd0NXNzZys2RkxEYU43a1QzVXo1dHhFaXpNOVNuOXdr?=
 =?utf-8?B?QW54TnhSMFRpK3FPdmRmRTdFNy9zbTIxaDFJdHk0Njl5d3cwckF5dEdjdTNL?=
 =?utf-8?B?ME5UKzZkUHlCbUg1dk1rQWZYUzBaTDhOOFRTeTJnK0lFQWpRcHhaOW9EUlRu?=
 =?utf-8?B?UEtQNkF6YTcyK0I5cmZSV01wMm1rOWtkR1IzN3hXNDRyMWFFK1VxbEEweURX?=
 =?utf-8?B?WjU5YmhKSUw3OHphK201MDJRQXIyS2FJWUM0cW1SUXUwKzNRNHlFN0taQkxW?=
 =?utf-8?B?U1Jtd2xXWWNHL2dEUTE4cUtGUjRMdmJCNllUYkhWREVIL2NIZkROeUlJaHFy?=
 =?utf-8?B?N2tQUlpQYkJ2VFlYN0d3WTZ2YVNGd1ZJMlU4aUt5Um9BeENkZDM3M1FCVUZ1?=
 =?utf-8?B?MTRuZUtNeHY4Y0xQWUtiQmJBcHF0VGV5SFFud0VwcE1BNTY1VXZoMkljOEl2?=
 =?utf-8?B?aDRlMUJBTEdMZytaZ2syV0orSFlGWHVLTnBDalUyUExBT0NORVNPYWZQbVJE?=
 =?utf-8?B?V25ucXl6dzYwc05lTlliaXVwZEFKTE9FMy9YdVJXdzZrNXlERHdqbDFkbUVl?=
 =?utf-8?B?ek9zM28vY283dmIzcnpRcEt0amZnaEZOdVgrcHFoZ016ZTNpdW04QkdpOGRH?=
 =?utf-8?B?OUNPWnU5YXQ1TFUvT0haYTdvYlRtT2p0TXFDZHljNnI2Z3BmMjU3dkNKWEpu?=
 =?utf-8?B?bVVNZ2J5WmxFT2lxY3RhRUp1Y1IwdGpUektpWDhJSWdJL3BQUktiZE1PM2pR?=
 =?utf-8?B?cnhxbXIvSGRwNjArajk5MDR2VWpWMldRK2NLNHE2eG4yM3YxNS8xdSttVDgx?=
 =?utf-8?B?ZUhBV0huTzcxRW1reW9KRlFub3UraHdnTjE2M3NRblcwY2tla1RxSmJXbnA1?=
 =?utf-8?B?SjJqSWp3akREWnh2Rk0vcGZscFhBZmg5WUdwUmhzVVJVSE16eHFySFdTR1NN?=
 =?utf-8?B?VERIUlhEMDNScnY4VUxoNlIrUEgzWU5tMEZiVVV2UWlmZmNuZGFIaEtmL2FM?=
 =?utf-8?B?MXN5TUxyYk8rbmZkNmhybTVEV242cmFSZmJZK0VLMzhvc01rejIwajhtY2xp?=
 =?utf-8?B?ZVVtd2RHSzJTUjFXYVh2dUh3M3pucVc5M0JOcnA4cXlIOS8xdXU3ODFQSGlE?=
 =?utf-8?B?aDR2QkRVSk9LWUEzR2hpN2NTc3RxUnFyNXhzd1djTXVYdDVKWC9QTnFLaUJ2?=
 =?utf-8?B?SmlXenZXaEdIbDRMNHhJRmp4eDZ1SHM4eVY4bjZVMFc0YXNoOWQ2ajh3eUd2?=
 =?utf-8?B?ZHd1R1JxeVBGdGNEdnRLckxRdm1rYkVhLytBUFBkdTAwa3VYRnZzVnFlU2wr?=
 =?utf-8?B?cDBwZnZ5MFZkUVJmVEVaUHRPVDRSamFkdmppQ0Z2RlRDL3pBK0o2R0grdCti?=
 =?utf-8?B?ZWFTOHF2bkRMcTZBM01HenZRY0N2NlBrNXRqMFh4U1kxU0ZpNGNnZ0JueVVr?=
 =?utf-8?Q?13ccNzwyzAC21tZWccEHTnJeUGoBFebc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UytxME1FZHZKc2hZNmx2SFpxdEMxRWFBbm1LcHVYTVFwRlcrZjhUTGZLVnRk?=
 =?utf-8?B?RDAxMUlZLzdUZXQ4L0o3MzhvaWk3QndFRnlMaWVCWnBVNWNIVlpWOWlHeUc5?=
 =?utf-8?B?OUkxZjljeTZ5dmIyczhCU2MrejhlN1lxRitqc25MRXZOSHNSRWYrNkpPNGE1?=
 =?utf-8?B?UFNZUEdiaG0yM3I2RVNUcHhtMVZkdVNaME1ubEM3N3JqaE9WV2dtS2JDMlFR?=
 =?utf-8?B?elBkbzduVW56S3R4d3M3WUNOR0pjc0podjRCeENzanM1YXpxV2xaZzI2RllT?=
 =?utf-8?B?VmtYWHhQM0JGWkdvZ1Jjc1VIcndwSkNnYndDOHpjY0FKWG9rTmpLaE9FL0g0?=
 =?utf-8?B?OGdiWVdRVUFFam9zUy9xbGNHbUdDYzEyR09wK0ZUQmZvbGNnMWpEcVdQa1U1?=
 =?utf-8?B?Z2kwSi9sNlNWTW5HZ1Vrd1lkOS9nMC9IcExMTVJ4UVprdXhmVk9SZGhGMWFD?=
 =?utf-8?B?M0szcUVQZDg2b3JxTVI2WUw0dG5KMS9iRFZrZkJrYjdYTXVWb3JpQjFMYWUr?=
 =?utf-8?B?a2hUTDhlcTgwbTNvbVJNM1hNbHNFeHZnUGd2V3N3VFlSaWZrV1Q0MVlOcFU5?=
 =?utf-8?B?Q0pJNThXd1UvcmxnenVwbEt6OFg1N25VeWRwQ2hyOHl2anhTSTUweXRqYTZQ?=
 =?utf-8?B?VXhZQ210VXhIRTgwUW0rT0NyZFlFdVlUcmFkWjY3Tk1JOFRKalhvWEJ1dlVD?=
 =?utf-8?B?djNmSjNEOUVPT3NVQmxBTnhic1NVVFlWNzYzTWdwUlRJdUVIRUxjaXNrR3Ft?=
 =?utf-8?B?Sy8wWDRVUXEzZ01Uc1JNZjY2bkd6aGhlODZIcVl5aVVRU3NCTHR1MzZMa0pL?=
 =?utf-8?B?a213c2lIZG1HOTluUGpmQXVUc1VrT2tUV1FJZUFKektuaTYyQ2tWYzlOZ3FG?=
 =?utf-8?B?M3ZSRk9nek5ScUl5N2lqTmxDUjJOV3JGU3Zaam5oL3JWYVVja0ZWMHRDUGJq?=
 =?utf-8?B?MTdWYmlyV0RtOERlWVU4NmtoMkdUL25zZWFSNnBkbHhFSm5pbklYenAwOFo5?=
 =?utf-8?B?Q1I0MEcrYUhjRGNoZUdhZ3NQdytEM2J4Y0dzaTRvdzVqcWdwdlAyNEFpNWZT?=
 =?utf-8?B?SG1vRkMvYTk4MENZZ2M0Q1hDSWNHa2FqMUdpTkRVdkFjanlyY0Fzc3ZlTkhF?=
 =?utf-8?B?ZkhHK3RLdHZ4MXI2ek56aE5xdG40TjU1NDl4Z0FmTnAwZDFCQkk0Nks4Zmc2?=
 =?utf-8?B?VVNFdE1rYjBQd2NQdTR3RjlKYWwwMW1qZklRa09OOTlJaTJyWVQycXFCUTNj?=
 =?utf-8?B?WUg2OU5BMXdtajFFT1pZV2REdXF0OERjcVM1czFrbmRIOHdxU1VXVFlnUFdP?=
 =?utf-8?B?TWNqQXlwWnZ1WEEwcElOY3ZxMndKRDMvNWRpbHpWZGdOZDRQcTNNODkweDdu?=
 =?utf-8?B?ckVPaVNvalV1Um1aN2RQdVZsWjA5d25FM0Y3cGNRUGlRbllVWm84bkVhVWNL?=
 =?utf-8?B?WTVYOU5mVEpHdVA2MFJZRndPc2VWM1ZVMW1XYmxlejVmMWRRWTRiV1kvUXY3?=
 =?utf-8?B?MXA5MTVnbzhKVkY2ang4VnpydUJyYmN6eXVuaFRqQWNJMmErZVltVTgrekUw?=
 =?utf-8?B?U0hnQXpQQzJmbVVBeFJEdkxWamFqbWtpT01RZGZpemtSYTZmQlp2aTh0dzJi?=
 =?utf-8?B?Rmo4TkFwZ3Z0bll0QytNZXRPQzFFM0h6Qm1iZEJmR0V5NG1mckZscEFTUzBQ?=
 =?utf-8?B?bHJrWVFXa1F6UjhRb0tHM3c3d3d5eW9VallYSWZhemJvMmdob3c2dzdORktS?=
 =?utf-8?B?QlhyRnlBN1o4QTRiUktwbWIwbVh1cmlZZlhMMVFROFlSblFDS0RLZDdSOEdZ?=
 =?utf-8?B?NUFyNjcvWnNudG1nckR2MGJwTEtJZUxXWTdZY01OcnY0Z0h4MDBQN0RVM2xJ?=
 =?utf-8?B?alBmczgwQXlmbEZucEYxTG9ORDRlNCtQT2VEVm1LMktDMlNIUzJVT1J6ajVK?=
 =?utf-8?B?WC9ncWVsM1podk9XWWpTZitzc1ltZzlSQzZhMnNvMklOTzRvcFpPYXJmV25T?=
 =?utf-8?B?Ym50T2UvZ0pQNEVQOTJwekI1ZDFEdHp1aGFxa3JWVjZrQU51YlVCbC9oZWZC?=
 =?utf-8?B?QXlaeGNxblM1Mys0YzYxb0RTNFFWYXZKUVZ3aHhRRFp4d0dBZzVOTzUzMXAv?=
 =?utf-8?Q?lT2lYf7DP3H5GzKFZiwZM1eWf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b72627f-b4c3-4dd2-1b3e-08dd4b38ac3d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:41:33.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nrcWiARwi0ZHGvgU2Ef47N03yrydGnAI9TLA2cIyfpguBmZVjhHcUH1CNpWR4explNJlRnaulF3jxyZPM0LfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

From: Peng Fan <peng.fan@nxp.com>

Add Logical Machine Management(LMM) protocol which is intended for boot,
shutdown, and reset of other logical machines (LM). It is usually used to
allow one LM to manager another used as an offload or accelerator engine.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  11 +
 drivers/firmware/arm_scmi/vendors/imx/Makefile     |   1 +
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c | 270 +++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  31 +++
 4 files changed, 313 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
index a01bf5e47301d2f93c9bfc7eebc77e083ea4ed75..1a936fc87d2350e2a21bccd45dfbeebfa3b90286 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
+++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
@@ -12,6 +12,17 @@ config IMX_SCMI_BBM_EXT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx-sm-bbm.
 
+config IMX_SCMI_LMM_EXT
+	tristate "i.MX SCMI LMM EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System Logical Machine Protocol to
+	  manage Logical Machines boot, shutdown and etc.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx-sm-lmm.
+
 config IMX_SCMI_MISC_EXT
 	tristate "i.MX SCMI MISC EXTENSION"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/vendors/imx/Makefile b/drivers/firmware/arm_scmi/vendors/imx/Makefile
index d3ee6d5449244a4f5cdf6abcf1845f312c512325..f39a99ccaf9af757475e8b112d224669444d7ddc 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Makefile
+++ b/drivers/firmware/arm_scmi/vendors/imx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
+obj-$(CONFIG_IMX_SCMI_LMM_EXT) += imx-sm-lmm.o
 obj-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c
new file mode 100644
index 0000000000000000000000000000000000000000..4b9211df2329623fae0400039db91cb2b98cded1
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System control and Management Interface (SCMI) NXP LMM Protocol
+ *
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "../../protocols.h"
+#include "../../notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_lmm_protocol_cmd {
+	SCMI_IMX_LMM_ATTRIBUTES	= 0x3,
+	SCMI_IMX_LMM_BOOT = 0x4,
+	SCMI_IMX_LMM_RESET = 0x5,
+	SCMI_IMX_LMM_SHUTDOWN = 0x6,
+	SCMI_IMX_LMM_WAKE = 0x7,
+	SCMI_IMX_LMM_SUSPEND = 0x8,
+	SCMI_IMX_LMM_NOTIFY = 0x9,
+	SCMI_IMX_LMM_RESET_REASON = 0xA,
+	SCMI_IMX_LMM_POWER_ON = 0xB,
+	SCMI_IMX_LMM_RESET_VECTOR_SET = 0xC,
+};
+
+struct scmi_imx_lmm_priv {
+	u32 nr_lmm;
+};
+
+#define	SCMI_IMX_LMM_PROTO_ATTR_NUM_LM(x)	(((x) & 0xFFU))
+struct scmi_msg_imx_lmm_protocol_attributes {
+	__le32 attributes;
+};
+
+struct scmi_msg_imx_lmm_attributes_out {
+	__le32 lmid;
+	__le32 attributes;
+	__le32 state;
+	__le32 errstatus;
+	u8 name[LMM_MAX_NAME];
+};
+
+struct scmi_imx_lmm_reset_vector_set_in {
+	__le32 lmid;
+	__le32 cpuid;
+#define SCMI_LMM_VEC_FLAGS_TABLE	BIT(0)
+	__le32 flags;
+	__le32 resetvectorlow;
+	__le32 resetvectorhigh;
+};
+
+struct scmi_imx_lmm_shutdown_in {
+	__le32 lmid;
+	__le32 flags;
+};
+
+static int scmi_imx_lmm_validate_lmid(const struct scmi_protocol_handle *ph, u32 lmid)
+{
+	struct scmi_imx_lmm_priv *priv = ph->get_priv(ph);
+
+	if (lmid >= priv->nr_lmm)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_imx_lmm_attributes(const struct scmi_protocol_handle *ph,
+				   u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	struct scmi_msg_imx_lmm_attributes_out *out;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_ATTRIBUTES, sizeof(u32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(lmid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		info->lmid = le32_to_cpu(out->lmid);
+		info->state = le32_to_cpu(out->state);
+		info->errstatus = le32_to_cpu(out->errstatus);
+		strscpy(info->name, out->name);
+		dev_dbg(ph->dev, "i.MX LMM: Logical Machine(%d), name: %s\n",
+			info->lmid, out->name);
+	} else {
+		dev_err(ph->dev, "i.MX LMM: Failed to get info of Logical Machine(%u)\n", lmid);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_lmm_boot(const struct scmi_protocol_handle *ph, u32 lmid)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_lmm_validate_lmid(ph, lmid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_BOOT, sizeof(u32),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(lmid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_lmm_power_on(const struct scmi_protocol_handle *ph, u32 lmid)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_lmm_validate_lmid(ph, lmid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_POWER_ON, sizeof(u32),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(lmid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_lmm_reset_vector_set(const struct scmi_protocol_handle *ph,
+					 u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	struct scmi_imx_lmm_reset_vector_set_in *in;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_RESET_VECTOR_SET, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->lmid = cpu_to_le32(lmid);
+	in->cpuid = cpu_to_le32(cpuid);
+	in->flags = cpu_to_le32(flags);
+	in->resetvectorlow = cpu_to_le32(lower_32_bits(vector));
+	in->resetvectorhigh = cpu_to_le32(upper_32_bits(vector));
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_lmm_shutdown(const struct scmi_protocol_handle *ph, u32 lmid,
+				 u32 flags)
+{
+	struct scmi_imx_lmm_shutdown_in *in;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_lmm_validate_lmid(ph, lmid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_SHUTDOWN, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->lmid = cpu_to_le32(lmid);
+	in->flags = cpu_to_le32(flags);
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_lmm_proto_ops scmi_imx_lmm_proto_ops = {
+	.lmm_boot = scmi_imx_lmm_boot,
+	.lmm_info = scmi_imx_lmm_attributes,
+	.lmm_power_on = scmi_imx_lmm_power_on,
+	.lmm_reset_vector_set = scmi_imx_lmm_reset_vector_set,
+	.lmm_shutdown = scmi_imx_lmm_shutdown,
+};
+
+static int scmi_imx_lmm_protocol_attributes_get(const struct scmi_protocol_handle *ph,
+						struct scmi_imx_lmm_priv *priv)
+{
+	struct scmi_msg_imx_lmm_protocol_attributes *attr;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		priv->nr_lmm = SCMI_IMX_LMM_PROTO_ATTR_NUM_LM(le32_to_cpu(attr->attributes));
+		dev_info(ph->dev, "i.MX LMM: %d Logical Machines\n",
+			 priv->nr_lmm);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_lmm_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_lmm_priv *info;
+	u32 version;
+	int ret;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM LMM Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	info = devm_kzalloc(ph->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = scmi_imx_lmm_protocol_attributes_get(ph, info);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, info, version);
+}
+
+static const struct scmi_protocol scmi_imx_lmm = {
+	.id = SCMI_PROTOCOL_IMX_LMM,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_lmm_protocol_init,
+	.ops = &scmi_imx_lmm_proto_ops,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+	.vendor_id = SCMI_IMX_VENDOR,
+	.sub_vendor_id = SCMI_IMX_SUBVENDOR,
+};
+module_scmi_protocol(scmi_imx_lmm);
+
+MODULE_DESCRIPTION("i.MX SCMI LMM driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 53b356a26414279f4aaaa8287c32209ed1ad57b4..07779c36ef9a126907e26e304a8feca16fd60ab2 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -11,8 +11,10 @@
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/notifier.h>
+#include <linux/scmi_protocol.h>
 #include <linux/types.h>
 
+#define SCMI_PROTOCOL_IMX_LMM	0x80
 #define	SCMI_PROTOCOL_IMX_BBM	0x81
 #define	SCMI_PROTOCOL_IMX_MISC	0x84
 
@@ -57,4 +59,33 @@ struct scmi_imx_misc_proto_ops {
 	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
 				    u32 ctrl_id, u32 evt_id, u32 flags);
 };
+
+#define	LMM_ID_DISCOVER	0xFFFFFFFFU
+#define	LMM_MAX_NAME	16
+
+enum scmi_imx_lmm_state {
+	LMM_STATE_LM_OFF,
+	LMM_STATE_LM_ON,
+	LMM_STATE_LM_SUSPEND,
+	LMM_STATE_LM_POWERED,
+};
+
+struct scmi_imx_lmm_info {
+	u32 lmid;
+	enum scmi_imx_lmm_state state;
+	u32 errstatus;
+	u8 name[LMM_MAX_NAME];
+};
+
+struct scmi_imx_lmm_proto_ops {
+	int (*lmm_boot)(const struct scmi_protocol_handle *ph, u32 lmid);
+	int (*lmm_info)(const struct scmi_protocol_handle *ph, u32 lmid,
+			struct scmi_imx_lmm_info *info);
+	int (*lmm_power_on)(const struct scmi_protocol_handle *ph, u32 lmid);
+	int (*lmm_reset_vector_set)(const struct scmi_protocol_handle *ph,
+				    u32 lmid, u32 cpuid, u32 flags, u64 vector);
+	int (*lmm_shutdown)(const struct scmi_protocol_handle *ph, u32 lmid,
+			    u32 flags);
+};
+
 #endif

-- 
2.37.1


