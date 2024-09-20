Return-Path: <linux-kernel+bounces-334132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC9A97D2F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4681F24B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E54136658;
	Fri, 20 Sep 2024 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dBlF3NUK"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7422EEF;
	Fri, 20 Sep 2024 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821930; cv=fail; b=dX2T9KLuK0vouhTUIYzqLmp4vVzjmUc+yRMLak8ZZT0a73A8XLQ6S8BBYwgI+eC8Cz03zbVPOnFJ0w7Yqs7T4dbrbT/Tk98pkZk/bKY1nKp5YG3ucY54W53Pi0TfHCPon3AJjYO60Tr4KyILzw6e5TVWNxaExju39BN5h9IBjyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821930; c=relaxed/simple;
	bh=mM5YWdGMlyFIZvU+TMavK2zjucp6BFrroGS5l3VCGD4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KdjDiqY82BVvLOBcb+KvZBQajvm/wcfsltI0I0ET43TP8FhUZgZXpNQQ+dWgdx8lrt3Q1nSGYalQc2Xsj7V/1fwau8slI83OK7ePVgGvQjs8Iq+/wOp1lrRz4f62//hRjgvwDGwAF6cLvh6nTpPVOa09AowSXCNB6h+9efoRx1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dBlF3NUK; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcYpqVNGQKXnTxYki7Pd/3DETWfGRlbBUt1fT2dcahRr+m8OjESQSCuviIoEoa4sbC4rlipM382P17XKtRf86j6c3fcX4ljWE6o/jSTepjmMEAmyZELrK6bZTkUNLEuh8I3ynZYGf8bI0McC//Ymm6jcvAa0LK3t9RiJaIYvEU9kuYUP9Cd9qJ0fAi5LQJc5586QP5F262+NzoiyWZQVL3lobSCYJV5N5/qqVKWW4dMJyDNqIa9Iqs27M/80yxbufjts/QRy1IGhMZ8WPdG2xbGipuVJi1A6LgY//gMBtC7h5Y6Q4Ssm8XZWIXbodCTl71ySwHqZ3FZCGOCl8r45eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nJEkCeS2b7IRxJPmMwnoBaCyhIZ1vwplkGfyE+XmT8=;
 b=TfVts324y5F0OOeGuJaoGdxmhBG7/HFCUdPOWHxapPVKgaxn5TKCu8q3afP/BlOj9GcDeONZDs50xoef2GPuiRou6rT+VlSxl4qq1hlbgqZdy+FSka3kLNDmwbtdAnkoH6KoC8oG8mD1IsIKHrn5wuVK3HDriSjqQ3NXurKovaAHsfwTqHDJEBGC8R4QOfi4AIUoYf+zIicy446ve2GnDiEMtDL9avo6hVIkcUEsBeMOPgqd7J+GV9IcUHUvweRAYchtoAKyRQwbWSMzYBf9f/aj5U0ioc/mfNryBE2eraaU59UNHYciqujipMN+cj9xAYmCs/N8VDXR3aRzvSGgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nJEkCeS2b7IRxJPmMwnoBaCyhIZ1vwplkGfyE+XmT8=;
 b=dBlF3NUKGxYW8YrhEKi9+AqVQkhbxM7cnFuUg4UuHd8DVWav4qPLgskB+9Q4sPxq5Jc0WHXa5QNacXGLeZ8TkQQ8xayrUiipYi3V9U3N4udckwZfOYFPLPCIz79wTkD6FN6bDWVrKdx+BoPjvK56Nnc1uTRkDPl6f3wqixoyNpeAwwYrAjovQ7UoK7jXXc0IcKsAwyGVukYAN/hkG0qE0GjT3WFOEHnznrSBboa7l+hO0K0HTz99j9k1sFZL+sptskaCmnizh6ygp0C3nwWnWqFWSOqOQIegf8AoCiumHq1D8KeWHa8LA21k3L4+e4CuzJCbToQ5cY+TKM0PUv72CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 08:45:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 08:45:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] spi-nor: add optional vcc-supply and enable it for
 i.MX93
Date: Fri, 20 Sep 2024 16:54:05 +0800
Message-Id: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC047WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyMD3eKCTF1jEyNjw9REcxNzM0MloMqCotS0zAqwKdGxtbUAKe47vVU
 AAAA=
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726822454; l=1006;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=mM5YWdGMlyFIZvU+TMavK2zjucp6BFrroGS5l3VCGD4=;
 b=9RxxfhMd6/Z4GruYDmDf8phCfAWzMb1boB6c5Fi63NRF/JWgpZtmE3HHt6g4eqdSURbpC5JH2
 Du8XaY5D9p1CcsyL1tEVuOySjWR75OEi2ZkjCdjgG+hincGEwFC0N8L
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d975751-d6b6-4cfe-27e0-08dcd9508fbb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emhOUEMyZTJFTXUvUmROZFZIVU9mOTgwTTA3bThOeVhGd1dmTzVXOEc2bUM1?=
 =?utf-8?B?eEdEeHI0d2ZRSm8wOWpNeFl3TS8veFUydk5oTzFZMkpJSE1lclhPL2oyRzVZ?=
 =?utf-8?B?Rm1kdHB4bDBrK3VESUV0dk05ZlpuaDcrcjV6Yzdqc2pueFBCdXhyUmdLaHBv?=
 =?utf-8?B?WDN3cVBWUTh5dkdoV2hWaEJMOTNuS3lNRERsZG1UWWVxRW54cUUrZmppVW42?=
 =?utf-8?B?czRMNXhNVUlKb0NhU1lXVGdIOXp2eWpMZnBNcjA0N0RqU0dYNE9HWDNxM0s2?=
 =?utf-8?B?UFZoZkFOSzdsQ3pKaDlCamY0SGZIVC9ESU1TSTFsck8zQW9MYkVWSVA5NHVn?=
 =?utf-8?B?SEhrRmNRRjQ5TUlzanBuU29NLzFSdGxiRXhvRG14aHdqSjFXNUhjSXJUZ2tB?=
 =?utf-8?B?a3V4MW1xclNnL0ZnRHJZRkx1N1hGZXV6ZXVyRTZFSmEvTU91ZTZuU2ZibHpH?=
 =?utf-8?B?WWlyVXBpVEZWa09MdTYwUHBNYzBDVXJldDNweWhaczZ2V0FDc1A2UFFPbGE0?=
 =?utf-8?B?Rm9md2s5UjJ1U0pSN084RXpoUFFxNmxwSExLSWFrbE40ZkxwZm9oem9FcDFw?=
 =?utf-8?B?OGR5UXVGRk1rK1FQQkp2Qi9mNEh0ZFRROHlhQTdwSktEZ29QendUcGVIWmxz?=
 =?utf-8?B?RVRZaEUxSnNNdFFKdmdRMkM1NC9tTXFFbW83blZQSjBmQzZLeXllYkRRZjFy?=
 =?utf-8?B?dkFpTHcvamN1UENLalV5Q0FsbmR6WVVrZ1BvMjRyWEdHM2tPWVZLcjl6bGNC?=
 =?utf-8?B?cVRaQTZGcldUeTdzMWM0KzZxQk9kMUhYR2pPcnRpcTZ4VVM4RzEzM25RVTVl?=
 =?utf-8?B?YkpmMFhzLzdTaTR0TFpnVEh5ZTdrNFpjUHBFRjFYbHNIOXlsOTZ1WVpURVQz?=
 =?utf-8?B?TVJYOXpLVVIrQjNpbnFuQzVjREVXTlF6aGpNK2J5RGpqYTFEcVpmVktiUi9m?=
 =?utf-8?B?K0FRR0xUYTRvZjFuRE1jeVRTWjNqVEZycjNqa3hGbGRZT0dnZVA0UXQreTFR?=
 =?utf-8?B?c0Vtd01HbWIyUjN6aWFMM0lERkd5RFZPQWhha3ZtM3BpOTNjVnRpYllCMFNn?=
 =?utf-8?B?cmtFR0pwbXZSM2hSejBybFh6SHlaRW1GclMzdSs5WUtJZVNaOFdMSkw2NFlW?=
 =?utf-8?B?N0FXVEJlQmNEamlqMXNUQzY5eENLeWtlYWZoRE5SNkFvTjNKM1VrTzFCY0JS?=
 =?utf-8?B?UGpZWTZTM0JwdHNBQllVYXRFZ281RkZaLzZxVk4xUnc2RUZKOTNyUEdsY0FT?=
 =?utf-8?B?Rkd3MVFYZHVHeUVVTkg3MHZWUHFZeFU5a0haQUZLSFozRlBQakF2cDUyUkg3?=
 =?utf-8?B?SDZ3NHRBdU9WQ2FOQWRZWHZVOTI4L1VaV0lpaXF0OEJOOVlzNWE5Z2lDMkpq?=
 =?utf-8?B?R2pmSHFQamFPZ1VJMS9DV0xnQlllWG9JVzI3QUQxSXJWVFpsb0h0UDA4emMv?=
 =?utf-8?B?VW1UVUUrUzBxdWI3KzU2ZXd0UVFERjhRQWVCTGpUK1NZYjZ0WEtObUhZajJu?=
 =?utf-8?B?dTlsQnZkaUJxZXM2OXExcHA2OGxtRDdTRElYU1d5dTlMYTNWOURxMW05Y1RW?=
 =?utf-8?B?TVNhNG5wZmdKY3J0cFdhU2J5RWw1OVRINFpRbTVyTjcwZEhKeXdCN1lENThF?=
 =?utf-8?B?UkFDeEFUcnpaK3pYa3l0dFk5aFRkdHBQVWd1SlFWRmllMHZOdTRCUDBBNUUy?=
 =?utf-8?B?c2h2Y2dISDZOL29pMU5XSGRNUHpFN0hTL2VXbXdaTkVZeVAwV1ZDV3BiaXhH?=
 =?utf-8?B?QnJaUU1Db280SG5QU3BxT2dBemxQa1ZKUlh2SzQ0b3ZUcGs0ZE9VVzdITWU5?=
 =?utf-8?B?UG1NMTUyNWNVVEp1bm1uYlVaLzA5WCt0U2tNWmJ0QUk1WnBLckt4SmhCWHhx?=
 =?utf-8?B?NWVFNFYyUTZBY1k0RzZ6cmNDcmxaaDVVT3VtVlBEdzlKeFFESFJmN29pVmhp?=
 =?utf-8?Q?J21SqN533m4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXJpdWNFSjFUa2RjeFRwMEZHemcxVTJ0cGt5OUNRNUFFQWJUdnd2YkRsREhI?=
 =?utf-8?B?YjFRcnRmVWl5Y3c3YXE1VVFIU2V0eVRueEZPZXR4RzYxbDJlQnVYa3ZjMUJj?=
 =?utf-8?B?SElNaVBobEk0aWpmMTRYRlpJUCtxcnkxbUxYcERRU0J6Q3JuTUE3MWRaUEdq?=
 =?utf-8?B?NWk1YjFnK2JKSkNML2ROeU85WkRNRm1MUVV1WVZPRlRXSitYbVhGUjdLcnF0?=
 =?utf-8?B?VEVsTmdldXZTcEIvT2p6MFI1d3dBcnRyd2NXQTlkNjYzeEErN2VqNGp5T3hl?=
 =?utf-8?B?aVlkVlhXSm5mTGR3Q3QxZnZYenBxY1ZRN2l2aGRNRVR6aU5HL1U2dnVBdnBW?=
 =?utf-8?B?QVhKZHNNK1lOcUZSeDd5ZXZPSG40VkhKSkFFV25KQXNTb3k3R3BHN1IrVE5l?=
 =?utf-8?B?NlNFNmhOVmRlMFVabHF6N3dPY2lUZVUrRnN1TEFOVkZkKzhqcEZjcGRuMkxS?=
 =?utf-8?B?Z3llb3JPL1FPQ1ZnT2xOTkJ0WVY4aVdvUkcrSGw2UU93SFR2eFQ1YzZpM0pt?=
 =?utf-8?B?RHQzelJZK2RIeWxxZ2VtcDFNZmwra21Oa0pqbVNha0J0TEZ6b25POE1oS1BB?=
 =?utf-8?B?Zm5YcUxmRUJNeEtlZGt3ZTc3VHJoek5yZGRmQ09laVZDMFhFb0N2TjdpV1hq?=
 =?utf-8?B?Q3Q2L0Jsa2xsQUxwcU5zV2dVbGlFWHFPMlJlOStWUklwcWZ2T2RkemI1aFE5?=
 =?utf-8?B?c04vcjN5Z2FscmVuRWFDMnFBeUNlc3g5UStWY0ora1FSVjBjTjNBejd4SSt5?=
 =?utf-8?B?WWR0bVB4c2ZnRk9US2tZMEhkLzY5MHA5R2tXblNqZ0EzeVpaSGxIRWh5WjZ5?=
 =?utf-8?B?SjBXNFZXYnZ5cmkvOEtWNHpua3lmUHBYYWJuNllGWDFHS2puZStOQ3NFMm93?=
 =?utf-8?B?K1lHbHR2VklWTzY3M3V1RUR0VnF2eWt4a3FwbmRrMzk2ZE16NFNxNlNhZHpK?=
 =?utf-8?B?NHU0Zkk2QUdPOHNyb0dCN3pVZWJ1TzFYdnIvbkdYdUIwRkw5T1VmMGVDSkdi?=
 =?utf-8?B?dUY3NW9LOGxtcHR4N0ZEQktCWEoyV3VRMlBXVjVNSFJQai9FOTJiUllFL09F?=
 =?utf-8?B?RGxBanM2TUk0eFFKZ1hhZ0xSa09xNHdPSWFzMTh2NE90ZFV0d3VxQmgxMmEw?=
 =?utf-8?B?WEpVSnpOVkhhS3lzallpT1hJTGh0RkY3aUlZVE1jOW1KMjUwYklZaE9jZzEv?=
 =?utf-8?B?OEdrcWFtQ0xjU2I3aUtSZW55bXBKODlZVDJVNlJhUzlsdDNJTkc2QS9VcXl1?=
 =?utf-8?B?ZmgzcnRTUUpVQnYvN3EzM3VsaHhxVmFIb2NSMFNZVEpvSGN1cmZrcmJWM29E?=
 =?utf-8?B?ZEFHbXVjNHQyRUVLeTY3c25PU2hmRjJUaVVtMDVidzdwL3hIMmc0QzVpdUky?=
 =?utf-8?B?MGNMdC92THdiWEpIR053eUlCSUhkcWVhOU1hTStrWVlDWUNYanNTUVBQOFVa?=
 =?utf-8?B?dDF0RjBFZ1NEakdNSmJZZGpmR1NhaXVBT1FrcFo3aG91WHFvSTJwTU43QkxJ?=
 =?utf-8?B?RkpuNFlPc2l3NktVTmxCL1FjY21BZzkxQUdhcyt1OUo3OUpERnkraXNsRzJj?=
 =?utf-8?B?TWZUdmwzc2FvL2dydVNPOE1UWmF5dlVlYXNCaVFwODAyOEJQSDRtTDd4djBQ?=
 =?utf-8?B?RktlWGRGRjFidzg5cHpNd1hYUGJhS1MzZFFqamFldHIzSk9ZdVBRZXJTUDZN?=
 =?utf-8?B?aXJ0NGt4ZWplS04yOGl3RVo0YUFWZlVKWUljcWJQcC9GUFNYcTkvTFlGUDFn?=
 =?utf-8?B?M2VFRi9seDYycjl3UWJULzA0ekpUdzErY0Erd0NLcnBTYXBsZDJYNldxeTFO?=
 =?utf-8?B?b0dXVFVrdUNDOWZkYmdtdCtJMnM4MnNNbklWTU44cmJCKytWZFV6QjZWZWly?=
 =?utf-8?B?akdDQStXc2VFUlRvb3A5NExCTGNmNnByVjhCNSttS1FIZVJDcU41RDlPbVZO?=
 =?utf-8?B?aGJzK3ovNlRSUFhkNHdoS3NoMTRGTy94Zk5WZS91SDNnTXd0OElVQ3BJd1E5?=
 =?utf-8?B?VlhWUzVHYTI2QWUxU25QZmNUMWRvTWpObUkrOGdsclNmK2hFUEFGRDZVNUJZ?=
 =?utf-8?B?cFlmbm5wdkhWb0toemsvWFB3eFFqUU5GVHFjbTZHOTRRYmtWZWhJaDNFNmJl?=
 =?utf-8?Q?/a7WKpz7QuseB6P1b9K7Nie7n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d975751-d6b6-4cfe-27e0-08dcd9508fbb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:45:21.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFsBJ5QtkCuSJaxWfewGlsDnVH8ELaH6QxEw+a0dl+M1HKU9S8QbcSThobbDeK4U3ExEvsr9ld1QzyaiNtAsWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

spi-nor flash needs power supply to work properly, the power supply
could be software controlled. So need enable the power before using the
flash.

Patch 1,2 is to add vcc-supply for spi-nor
Patch 3 is to add overlays for i.MX93-11x11-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      dt-bindings: mtd: jedec,spi-nor: add optional vcc-supply
      mtd: spi-nor: support vcc-supply regulator
      arm64: dts: imx93-11x11-evk: add overlays for flexspi flash

 .../devicetree/bindings/mtd/jedec,spi-nor.yaml     |  4 ++
 arch/arm64/boot/dts/freescale/Makefile             |  3 ++
 .../dts/freescale/imx93-11x11-evk-flexspi-m2.dtso  | 59 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  | 10 ++++
 drivers/mtd/spi-nor/core.c                         |  5 ++
 5 files changed, 81 insertions(+)
---
base-commit: 3621a2c9142bd490af0666c0c02d52d60ce0d2a5
change-id: 20240920-spi-34231ea74761

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


