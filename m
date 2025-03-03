Return-Path: <linux-kernel+bounces-540909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F1A4B655
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D3A7A400E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21E61D5177;
	Mon,  3 Mar 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T3V3uWqR"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A219CCFA;
	Mon,  3 Mar 2025 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970500; cv=fail; b=ox2NY3OXVijNsLMPLwI3dS5RrYVwOZZIuCQj6s+Fj2Nr391jORucnTHEOKuM3IcyVhSjUf/dQJlnp68vnFPoWpIAafTf3BJ+brBJgeFhweo4b2YID0D5kLada5TF99N10Agyq8lG0zHgunuXylEC3x+6KZV1PY/hLCLXFAMU2tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970500; c=relaxed/simple;
	bh=jWzSMbbw/V/IvQlEKNz5imWYW++iVwi3sKNU6k9Sy9k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g3lg2cD2+j75avlmquKYy+ZlrINS2+RtURO+xZBH2KgYkn9/EZ1OwkWthr57Aq2khoXwKL7DY5+BZk6DGn2qEai1Ntg3YsXI7m2/5JBRlUWEszwCJVEw4IERWiGV75Hws4AfQRnzkkLtRwg2oLuy2LK0HFOQb7OBJcOO5dRh8xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T3V3uWqR; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ON24BxB9TBdCT4G7KV6/oZMqTmTR99H+Yj/NeEq7axiLL6qtxNynqUi/OdHxIdLEEjXBPGkep9CXKkdC/szhpsxHIP+bWTu/znCafcIsgtceu374nln4llbxJUWfIl1lyiZz3QkOcXppgto4495oexqLioMeFgAn/HELoY/2uWe1DCEbbGnk17A0x57kWw0ypLJ5a9+Tgwey7JC6Kpgf/GSj3fxY10qgizzZNTxYKRx2SfZEbJybpDrJ0cojpNrr2PIiZykpeo3wzOqR+5DndUd9pQFz0n55wVp3DQiampVF31pcYkQGf0QRfidvPGmiiVAnYeiAMPiiEsEboB4zlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac+LIaNTlRnQqO1fU67vqU8uKOx5t1BpaaxTUT0XLLs=;
 b=ihlospK0l7zvbBi3fOkOeYgRwNjq/oKp7Pbft5IbF5jlm6sadL4Q3wUwfbBRBiegmI8TK0LKl4UPcCtlIzCNA82hxnH/eewgOQm6vS6dwAf2CbI3jfULFrWq2npAAwVRnwG4vnL/vp+mhlijjPsx8iTZv6gZT9UziE+TlKrjW3KU9K9xjR+77XKYPRUDvk0EhOy9mA26BHwhvJ5Rg7B8i/RYC2f+kjn2txSvnugFfGYFc/L2emd7XBxPcqzvV0rZtu+nIHnXXAgbFCEYKS0zt3R4Ht/VKWpGgzaBlAUTIvEBFfVvRAeOr81g5a0SRp6o5SMAu22hcbpPVUy9uK4T4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac+LIaNTlRnQqO1fU67vqU8uKOx5t1BpaaxTUT0XLLs=;
 b=T3V3uWqRey3ITO84VuZEOswCKhXrsBGr+jAAMDtydLT50/IFKlCweyYg28r6sWobbUZtvDh21mykzQkXzTJ2Hk9e/72wjOn7SVcWaPnjrYV2QLGlcjnlLaKkQ/J9suzU/iXpIBdQub6wa9HtownAyKHm1kuAq8nUYd3QKGtayW0BsbyU3856EzIXJYKahB14dpNBi0gZd9oeaUG6sGtfANfxRMGtJHPUyGLD1pPxLjIcRm5Wroz/Sap1HUmn50GSLrHcNl1DLq+RxHx4KWutDytSJkBR/BCeuIB79HnN0dvLo32/e/o7wuypoSAcexLUchVeP2KZ8x61DrNJ18/7mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:54:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:54:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 03 Mar 2025 10:53:27 +0800
Subject: [PATCH v3 6/7] firmware: imx: Add i.MX95 SCMI CPU driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-imx-lmm-cpu-v3-6-7695f6f61cfc@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740970413; l=5763;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=RAeXl59ykXx6Jn2tPWjZDrCKA+vTZRM1MrRBDtexg3o=;
 b=AA6tZi7HOz4uVs706iC3g+8mc6Jlu24JZybviujp5ee3T4PZ60fnbwhp73eun4Avi46/pLfK4
 blW5e7xZbBkD2UvpXHcOJBFlsRi3wmdfEVxqwpdZCGYF8iLFBIcqvmn
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
X-MS-Office365-Filtering-Correlation-Id: 1284dac1-84a5-4d37-357e-08dd59fec565
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGlaYUxSbkFFYkVudFc5UFA3aXU5OXVOY0NncTVpdkxGMWZjK3hTYU9DWlZq?=
 =?utf-8?B?M3FEem04M3BzcDFaN3hmV3FHS0JWQ2FhbkxOQTMya21hZXAvM0ZLODNvc0x0?=
 =?utf-8?B?Mm91QzFkYnNSOTRlZ0NZTzZyVkp1VlJ0a1FQQVNrdENiZ1Z6VEpyNlR5UVRy?=
 =?utf-8?B?TkwyWUpEMTlzSVozZE1hMC90RHg5TjRBZXBhRUJGeUY5cHNYU1dhLzUzYWpu?=
 =?utf-8?B?aVV2UWJZUFEzVHprMjhVV0VjaGFDR2E1NDZRWGZUUnhydXl1anEzUGNOQk51?=
 =?utf-8?B?OUFBZDRPeXIzdEdHSzB6Q1c2NHNvcHpnQnpWTlJXNU11M003MUJpM2U5UWNs?=
 =?utf-8?B?Mk9lUlJDSDRwVlZUZlo0akFvQVZ1M0FyZEdUdEtrRHFYZUt2RVNZMDNmOHBl?=
 =?utf-8?B?aGI5N0srWWZDTWVKQ2VXRjlMcjZaOVl5cU5GdGVQNS9LNjZFK1BWRnpqRit6?=
 =?utf-8?B?NWxlTkgzZkptb2VxZGxJc094T1J2TG9sQkVzQWMyc1gzZkQrS2hXejlDMkcv?=
 =?utf-8?B?eEFYbFM4TEZ4cWZSWmQ1aGdRSytGaWhXZ2pYdzlSdHMxNm43ak1IdnhuTmpw?=
 =?utf-8?B?L2FKV2cwdU9adFFlYkVBOHlFZ2dyaG1OWUpZZ1lQN0VBRXg3Z1c4bU1uNnMr?=
 =?utf-8?B?U2pzZVRTRlFCUlpTL0o4Q0l6UXlOQTBsMzN0UkJOb2JEbFlFQWpla1dkWmdO?=
 =?utf-8?B?Yi9ZS3d3bnoxL1hBUmtOY2luclRkNnR2b21DViszS3pkU0IvdzEvWXQzZFBH?=
 =?utf-8?B?VGpzdC9EeW81dE9aRHpndFcwT2xna2tZT0poQThCTDN5TzRYUHNid2VIbzBT?=
 =?utf-8?B?dDByWlE4UHptVy9DSWQzNktPc2tCQlVvQklQclM2b2gxcjNuTkZkVk1aL0xj?=
 =?utf-8?B?cW1uakZxR2R5cTJ0R1MrdUt4TDhmcWt0M0VIZ2VIZkMrdnNhVEFuV1RUWG5R?=
 =?utf-8?B?Y0QxWEZibVNIMlp5UXVSSm9RaDBSa20zYVNWd3dxaFdtdklpK1Jwa3JCU3Ay?=
 =?utf-8?B?dHRnRk5OOFJEUUVZT1VtZDFHNnlFOWxHMkg2V3ZBQXp0RE52UWZTTzlWQ2ZX?=
 =?utf-8?B?QWlLM3hYaVUwaCtzYUFIais2dWR0SjBVbGVkYzh3V0FoR2J1aTZ5WkVXWUJ3?=
 =?utf-8?B?aWlMMjVMSzNMU0EzSlVnWFNJdnd0ZmdxdjNGMU9Tc3dEKzljNXVYU3NUd29D?=
 =?utf-8?B?VE5STUFJLzZSeGZsdGU4akttN2NNdVdaZUljS0tIS3JEWWdNVFljZmhBOWtj?=
 =?utf-8?B?bVRKeDFKU2loY1NpT2tqVUIwcExnN09tTFIxMTNyUDhuR2V2UDMzR3FKTStm?=
 =?utf-8?B?WE50aWhPUElUbWxYRm5qRDkwSU9nRVFXaEdyR1RKTzBTSHd1OVdHZHR3SkxG?=
 =?utf-8?B?MHJkWmNROTF6Ti8xbmZXUnJLNkJkbVlEblhpTjVpT1VwWTJYdUVYbXFlMXN2?=
 =?utf-8?B?T1JsOExQdVdycml0dmJLWlZRc1ByWTU3K1RRSW55Tys5SURMWTRkL09HeHVz?=
 =?utf-8?B?UW80ODN3YTBjRVJGUUpIT0NoRWlEczZOdDJFejA5VVMvNWxvWjU4dHdVMnBK?=
 =?utf-8?B?NndOQ1J3KzdkR3BrKyswYkFEY01DS00zYXczWjFaWURBOGNDenJvUlRYN0gx?=
 =?utf-8?B?T2hRV2xod2dtcTJKRG0xVUlDWW13UHpsYVJJTlBlM0RndHR3WXdYSlJNU0tN?=
 =?utf-8?B?bHJHNHFNcFhsbXpaSWd0c1IzSXNwaWhKdkk4ZkxNYXlvOVlKMkhMZUdTM1BC?=
 =?utf-8?B?cXNPYzhEVlo3LzZKS2I4b2NWTlp0V0JnSGEyUjNpYkMvSDNCNDdHZk1WT2RP?=
 =?utf-8?B?ai81TElwS3VLZWQvaW8vaGxLZjRkNGk0clFRUVUzV1FSYmJVM0pUS0xrZ01K?=
 =?utf-8?B?dVpXSkoreWpQL1ZpaUtlai9qVDdaQzlkQitra0p3TmJuVXowRHAweElMTVdU?=
 =?utf-8?Q?TZGDs+DBNuCoi74mOji5IMjG/RysTjc5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFowUCtKUWd1TGRmZDVwenQ0WkNQNkRMbm5pNFJxaml5Z1FEVHRIbnE5ZlNL?=
 =?utf-8?B?ZUtQbHdxc2tTNzkrU2ZzdW9ORmt5UjRhaVU4cGhzR1g5alMwNFlPdWV0c2Jr?=
 =?utf-8?B?a3kxK3FhTkt3SXc3K21udnVPbUhzNVlLV0lyMEYveWlRYUJaNHkwYks2ck1S?=
 =?utf-8?B?VzYxcEFhT0h2ZVhQY09ORVAyYUhVVGRLcncxaDY5MVZQdHUxaG41a0RLM3Q3?=
 =?utf-8?B?ZkdTc2RPQU9KeHBlaVFWaFJxZkg3aytQQjF1ckZRWVArTTNKbEFTL2xWOC9S?=
 =?utf-8?B?N2RTem52SFFyRWRIVjJOZ3pROGQ2TUhQNVV0bmZCaWMxMFBNWmUvclFFSmxJ?=
 =?utf-8?B?S3FBeXBSVDNMWFYvNmhCMDlpUHpuSElRYVNqM216OU95WU5Gb0lDWSt1OEhX?=
 =?utf-8?B?WjJjcCtDSm5LV0pZRWxvSUs3SkhTN290L3FyYUdPK09CQnRDZzNiUlhFV2tl?=
 =?utf-8?B?TDBxdE5HNGgzZmpjaFkwTmNiYmYyVUkrV3FVTFF1d3BhY0h0UHMxYXo0OTVy?=
 =?utf-8?B?clBuVEdSQVFUcThxdnNaMzhENkdMMUtpVE5EejgzY3pHcHFvTlZKMmppb0k2?=
 =?utf-8?B?U0R3enZRLzN0YlVidzFIWk5xNlNUMUJDMlpoaENKNnp5TDk2RXFkUVB2ZTYr?=
 =?utf-8?B?Y29xM29Wb0F4Z2dhVHhkTTQ3R3ZPVWFNR0JYeXY0ZldEeThKU1BZaDR3UVpF?=
 =?utf-8?B?UXNBTVd1WlVNZFRkU01xbmZDdFBqRlRsNnB4QVEycXIzQlpwRUp6dXU1WHVP?=
 =?utf-8?B?M3BUVFB3ajgxYWVMWWF0eDNqQkI5ZEJzVUZDMW42YWtGT3ZrOTBTNmh2dlR2?=
 =?utf-8?B?Y1VubE8vRzRjR1c1UWprRGtWTnVyc1ZMaHFMYzM2UnhzR09md0lBNmZ1NjQ3?=
 =?utf-8?B?UFVzZmdOVy9GYUVQY3YvR2F5RUh6Qi9NelZUZHdsNXJZcEJ3OXVEZjc4b0lv?=
 =?utf-8?B?aUN4M1RiNnFGTEM1cStMUFpGMkhadmI4T25nUkdRL2kvSURERHBERER5UVZr?=
 =?utf-8?B?NTdUUEpWNkUxNWdDL0cvem5HUGs1WFZCS0pjNjVZSi8yakpVWUNEMm5VRXgy?=
 =?utf-8?B?WjdML09PT01MVGMyWk9pOEVzS0RwaUNDSnhORTN3VUtGeHJ5VnJtU3pLNlR4?=
 =?utf-8?B?Qmk3dVFCeW12SjZoUWttOFRqWFRQaHY3bkVBL1BkSHBzNExHWmpjSmNKZGlI?=
 =?utf-8?B?MGdIZ1IyaXJIV2VxMVZ4UVZ5V0d1ZnhDaVM3MFlkdk9SaHVlRzdNVTJWUFZX?=
 =?utf-8?B?bEhtc0trWkdZYXoraE9TU0tMbXVhWXhGRnNlQUJUV3UrS0RndHU5UStSV01z?=
 =?utf-8?B?MTZUZVBndnJ0WFpMb0hMUUVyS3UvcnNQTXcyMWU2M1Mzd1dLMDNQcnBPR1do?=
 =?utf-8?B?Q1c5Mm02TVJQZy9xWGdRTEJ4RmhBRHdRUHk0VUd1SkNkNDE5RERickU2S2Yr?=
 =?utf-8?B?NGJwUURaT01hRzY2bmJHUkZmN0EzU04yMmlpaVRyZlhaTm1WOG1KYTZTTmFs?=
 =?utf-8?B?bmMrYUl6aG5vcENJeGlvR0ZWeFpMOE54QldNMFpUQkdlUXRTcGdwM2x6YVNY?=
 =?utf-8?B?Tm5FaW9SSHpBdjc1MjQrc2JOVWRkM3R0dHFsVWZXTEpDQkxyMWJ5VDJ6bVRO?=
 =?utf-8?B?WTlobzI0dnZGMllGUUZrSUhRYzA1cFYyMjRSTDY3eTJDczdsTTJIdWRtREZo?=
 =?utf-8?B?eUNFTmNEMDJMYjgyWUtGQVB4TGZmZlh2a3B5OUxCNDU4TEFybHpXWVRrYWx3?=
 =?utf-8?B?K2xFV3lCWVo4bForQlZ0SjAzUXlDOHFBV2Jna0t2aEUrODF5OCtxK0pJN0pZ?=
 =?utf-8?B?SGpKM2ZZZi94c2pKRnBPcTQrY0JsSE5PVi9Rc2sxdDZqbUFmcE90MzdKTHNn?=
 =?utf-8?B?amZZaFRSU05IU3FjeDRmMXF0NWJZeXczcWFoTVkzR2xZR1RwV2QxWXFsdDZ2?=
 =?utf-8?B?bU1xVG9qY2RTdEo4ZXNrYzZNbkU2QmJVRVlYTUhRZW9oQjNlN0Zmd1dpNDNC?=
 =?utf-8?B?eW0zQXU2TFhTTENvWUViUmFDS1J0K2NtZldoVzJMdTB2M0RUc2ZlcHpEYTVz?=
 =?utf-8?B?bFh3dkEwWnFCWDJib3VaUzZBc3poV3hPbXlsM0VaNGtrdHp0TXR1YzRnMG5v?=
 =?utf-8?Q?2mGF1x9sZwUHBqdDvtB0u+Y6Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1284dac1-84a5-4d37-357e-08dd59fec565
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:54:52.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdHYy0Y9gD+Wj4kRl0a0vb3vFnd57qE29+c3RqwAVxxirp/0Jz9FQvSjbBsyQ/y8qiT7RnwbaRlyrD6NRNeVdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 System manager exports SCMI CPU protocol for linux to manage
cpu cores. The driver is to use the cpu Protocol interface to
start, stop a cpu cores (eg, M7).

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/Kconfig |  3 +-
 drivers/firmware/imx/Kconfig                  | 11 ++++
 drivers/firmware/imx/Makefile                 |  1 +
 drivers/firmware/imx/sm-cpu.c                 | 85 +++++++++++++++++++++++++++
 include/linux/firmware/imx/sm.h               |  5 ++
 5 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
index 4c24e17425f830810f8ba376ece9db93c8cded6d..9b4339b93826804599371f2e3a2e79f27449582b 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
+++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
@@ -15,7 +15,8 @@ config IMX_SCMI_BBM_EXT
 config IMX_SCMI_CPU_EXT
 	tristate "i.MX SCMI CPU EXTENSION"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
-	default y if ARCH_MXC
+	depends on IMX_SCMI_CPU_DRV
+	default y if ARCH_MXC && ARM64
 	help
 	  This enables i.MX System CPU Protocol to manage cpu
 	  start, stop and etc.
diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 70c092424328067ea6b946cee59f072661e27e47..8236f81e054ff43c5fbc660a67c53ea9324ab402 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -23,6 +23,17 @@ config IMX_SCU
 	  This driver manages the IPC interface between host CPU and the
 	  SCU firmware running on M4.
 
+config IMX_SCMI_CPU_DRV
+	tristate "IMX SCMI CPU Protocol driver"
+	depends on ARCH_MXC && ARM64 || COMPILE_TEST
+	default y if ARCH_MXC && ARM64
+	help
+	  The System Controller Management Interface firmware (SCMI FW) is
+	  a low-level system function which runs on a dedicated Cortex-M
+	  core that could provide cpu management features.
+
+	  This driver can also be built as a module.
+
 config IMX_SCMI_LMM_DRV
 	tristate "IMX SCMI LMM Protocol driver"
 	depends on ARCH_MXC && ARM64 || COMPILE_TEST
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 7762855d2a771169d4f1867d27e0d51be7c9ad03..3bbaffa6e3478112638ed031375602389f18ef09 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-${CONFIG_IMX_SCMI_CPU_DRV}	+= sm-cpu.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
 obj-${CONFIG_IMX_SCMI_LMM_DRV}	+= sm-lmm.o
diff --git a/drivers/firmware/imx/sm-cpu.c b/drivers/firmware/imx/sm-cpu.c
new file mode 100644
index 0000000000000000000000000000000000000000..091b014f739f68d815d71f9b53a2a7eaf0bd607b
--- /dev/null
+++ b/drivers/firmware/imx/sm-cpu.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/firmware/imx/sm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+static const struct scmi_imx_cpu_proto_ops *imx_cpu_ops;
+static struct scmi_protocol_handle *ph;
+
+int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
+				  bool resume)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_cpu_ops->cpu_reset_vector_set(ph, cpuid, vector, start,
+						 boot, resume);
+}
+EXPORT_SYMBOL(scmi_imx_cpu_reset_vector_set);
+
+int scmi_imx_cpu_start(u32 cpuid, bool start)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	if (start)
+		return imx_cpu_ops->cpu_start(ph, cpuid, true);
+
+	return imx_cpu_ops->cpu_start(ph, cpuid, false);
+};
+EXPORT_SYMBOL(scmi_imx_cpu_start);
+
+int scmi_imx_cpu_started(u32 cpuid, bool *started)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	if (!started)
+		return -EINVAL;
+
+	return imx_cpu_ops->cpu_started(ph, cpuid, started);
+};
+EXPORT_SYMBOL(scmi_imx_cpu_started);
+
+static int scmi_imx_cpu_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+
+	if (!handle)
+		return -ENODEV;
+
+	if (imx_cpu_ops) {
+		dev_err(&sdev->dev, "sm cpu already initialized\n");
+		return -EEXIST;
+	}
+
+	imx_cpu_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_CPU, &ph);
+	if (IS_ERR(imx_cpu_ops))
+		return PTR_ERR(imx_cpu_ops);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_CPU, "imx-cpu" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_cpu_driver = {
+	.name = "scmi-imx-cpu",
+	.probe = scmi_imx_cpu_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_cpu_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM CPU driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index bc27b04afb2f68b048955f51c07a106f4c7e5852..a8a17eeb7d907ef8ac074c4ed1d3ac83f1104627 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -21,6 +21,11 @@
 int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
 int scmi_imx_misc_ctrl_set(u32 id, u32 val);
 
+int scmi_imx_cpu_start(u32 cpuid, bool start);
+int scmi_imx_cpu_started(u32 cpuid, bool *started);
+int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
+				  bool resume);
+
 enum scmi_imx_lmm_op {
 	SCMI_IMX_LMM_BOOT,
 	SCMI_IMX_LMM_POWER_ON,

-- 
2.37.1


