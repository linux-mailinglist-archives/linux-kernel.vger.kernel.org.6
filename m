Return-Path: <linux-kernel+bounces-347518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE39D98D3C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3E2281196
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2235F1D015D;
	Wed,  2 Oct 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bGL0pEDX"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020079.outbound.protection.outlook.com [52.101.69.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C561D0142;
	Wed,  2 Oct 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873731; cv=fail; b=eNnNDx9I9M1EKYf7iJGjO6LB53mWH12MM71KlUy0MtJa3Y63F27auvcc5xJs3uqFLYvoCeJUjrCc5/xE5+CUPFSoQK9zvM/ZS2oYdw7s16mvYcmglnnrHPAwfK8uGzmBwTtWzCPoVCle120g/qG5bi3ach7O0MLzg12WZeLiB3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873731; c=relaxed/simple;
	bh=YEDEIrehqtLw7LCjKKy5eTjHaqvT7qGgsSiTO82Krog=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=gIvsZv9FVfvTwpr4KNE/Pbz4Dn8v4r8nkd9pd0/o7kD2OJFiVBcbk9QOD3n9hYfDbXsTgH9kSPg0l32YdhOl/POIlaK/VF5WsJ/fRhUQyM47oH2o4E5fY7aY9pMt21KxXKpSegNoyfEhm7tqgVznaVTeUMjPLfVZG4zMnDa3JIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bGL0pEDX; arc=fail smtp.client-ip=52.101.69.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vibx0IdBZkOyaXS5/lLow8jMgRuCPWhy6TMshFufIEabxRngHt0LObkRi5eOMM5/9HVQ/Te2IbS4O19iRMLBheFcgxWyZ59X9evFu8C2PJI7HALaE3Qy7yyGR5F4mXNGwwvWsQzGNLlbymbul1LY1lERvbv8C51doGHfoKG5hEIuxhWD88/7MN+VS8uab5Jvns50CiYsHPu3rAYzJ05YLsb+UfFU91ea5wzkDOGAWZlZ4OVVx+eNPFY1O3tqon9uiM02hf4vJeibzkLjoPuJMYq91311fy1p+Jj81zLW3FzQDIAdOhw9nWYC54fQMbfhvfTOrsGLIZ03gPNwJ6Ua2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bfaslda9snSSSgtgG65KP2rN/Y101F5gl5xETq9CAM=;
 b=hTQL0+VvIku80CcEWiOHfwWXeNU7tDsMVLFMB3uG3pLTls6a0QxRLdXPnovwPD2MyxMHSFnJAh7yOtDWfLi2CZKPADbsdw9L4+r5UdQ/yQAjynT4AdpG6tEKtOB9JeKmcbSwmcALEykDZtwUPt5dLsxuIcbpz+TT6UMhgOseftEtLyPzv07V82hMD5sfCcNVz72cNcii2KJbe0JC66vc0qC4T7KWMpU+dkTH/Lycg8VAHBKrVIF1dgPkJZoqBc5iOyD52+jKFUUv4tGdQy+K5PAU546NgbsToN+Vg7LkxbJCOflH9Iyvr/gCoxWYUTgYugbNJatufwhDf9POjWkJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bfaslda9snSSSgtgG65KP2rN/Y101F5gl5xETq9CAM=;
 b=bGL0pEDXhSJkaUdx0TZQk0ivlsPXGnOm9whjUD2mhmw5JmTkc5PC/fCEPltqpQ3K7+J8wDNxOB6udafXZV5iDXb2jzEj4ZWleWJBeJtJSAYgbsFDOEVa4y2ZPHnzkQ5p82wMVUcZ7OP1yGv8vfxZKfnw0ARByTz/8XUobyapDQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 12:55:25 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 12:55:25 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 02 Oct 2024 14:55:20 +0200
Subject: [PATCH] arm64: dts: marvell: cn9130-sr-som: fix cp0 mdio0 mdio pin
 numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-cn9130-som-mdio-v1-1-0942be4dc550@solid-run.com>
X-B4-Tracking: v=1; b=H4sIALdC/WYC/x3MQQqAIBBA0avErBtQs6KuEi1Cx5qFGgoRiHdPW
 r7F/wUyJaYMa1cg0cOZY2iQfQfmOsJJyLYZlFBaCqHQhEUOAnP06C1H1McoF5qsma2DVt2JHL/
 /cdtr/QCkxPjjYQAAAA==
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8eede7-4ee9-4026-a3aa-08dce2e17bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW4xYW5UVFRQWC9ORVQycWd4a1BPMUNNb2NuZnFoR2hwa28rSjcxV1NXYmQr?=
 =?utf-8?B?dmNTVkU1RmE2WVowaWpqaHR4bVI4cE8yMVNnQjRYemI0S0hZUjFMMjRqZHhl?=
 =?utf-8?B?M29mZnhoTE5jYnROWis0dWZoOE5pUWYyem56c3R2ZFlvakkzWHBaN2x4Mmcw?=
 =?utf-8?B?QW9LS0lpb28zZnloKzhFY0o3NkNhTW56T1VtVkhIWWtuOGFUb3g1bjZJd2dL?=
 =?utf-8?B?cjBSVWlKclBpNmFPQTM5WXJHbkw1MWl3eUJyL0M2LzkwS0xDcGQvUWt5emVi?=
 =?utf-8?B?Wm1oOGVnbE5LSU9paFEvenVXNkFFdUZ1WVYzd1RSRGxNSUVqR25CZzNyUjBI?=
 =?utf-8?B?KzNEQURLU2NHeW96QitYeXRoRStNeU50K3F1cUEvdnlIMkNvUUoydG9HTXZV?=
 =?utf-8?B?UkoreTdzWGxTVEZDcUdhM29ieXRSQVVHRGVTRzlYekZpUGtRRzg2SkJiT2dK?=
 =?utf-8?B?VThDL0Mvek81bUpvQ045ZWxtd2ZEOFdZU3c1M3kwWmw3T0Q2aWpSTEtHOHpS?=
 =?utf-8?B?WXJrME9IbXQrK3ZDRHUxWWZzbzZscHJxaE8xYjNDajJjSmQzSGNwS2xId3FI?=
 =?utf-8?B?VktlUTdGQytzUEFoSFd4akhJTk44Y3VqMUgrNXFkMzZNTjl3S3krKzkvZkRm?=
 =?utf-8?B?cHUrRU9zMmpOUXhXejZXcm9qMm5URGhvb09mNDFOSHVQaytPMGxLSFhPeWVN?=
 =?utf-8?B?Y1cwZ2xVNWZpTjJFdWRNNjNFQkFOY0NDaW9EdXFGYW5FQ0N1K1VReHkydUFN?=
 =?utf-8?B?RWxDdWhWYmlkeENJdnZxMU1MdXJGY1NFVFBMR1JmNlBFQjA0U0k0WVZwc29E?=
 =?utf-8?B?SWJCaWFmTDBvQTNHQ0NMbDVSQWNYSzdpdTdzN0ZlbkRyOTEwRlNjQU9QNUxm?=
 =?utf-8?B?eVpRQkEvdVhQOVllbUZFQjJtNC9pNVBDakdsMUJseWxsaS9yQUY4Snl0Si9P?=
 =?utf-8?B?NjZyaU0wYlRhZU44eXprOEprdEtSOUo0ZCtmNXFnY2JwRWU0RlZBVjBUa1hO?=
 =?utf-8?B?ZW00MzNwTit4QWQ2d3cxdVlnbWhsZmMwTnpRWTkrQy83bDBTUWFlT29pRXU5?=
 =?utf-8?B?dy9jakdMcnNOZmhsenBSRmNvTVBEcVpBWWswbEFoUlV5QnNsWVJjM2trTkVR?=
 =?utf-8?B?d3IzUCtMTGc0RWxHVmJUcW9YZkdaZXpHMlJpazlmbHRZL1NacVBWalpqSnNH?=
 =?utf-8?B?Q0NFcWpyOUpWdk5IbnQ1Ui84S1BsZkkxSmU5dHhCcEpTUzVHMmVGcjFUV1VK?=
 =?utf-8?B?dlAzRk96aVJtTGJLLzRyOUJiM3VOb2lvMGZaSnNhc2ZuMlIrcVlhWVVVQk5E?=
 =?utf-8?B?cVdjWGl5UU9tQnV1Y1ArSVJhNi80THNtQlRGUVlpZW0wNlZuRWFiNnVZL050?=
 =?utf-8?B?M1J0SnpycGhPeG5rQWoxWS9aNVozZmpvSVNzNVRmclJQSmxCMm5VV2k3Q3Fk?=
 =?utf-8?B?ZGR0RWFTaU9HcnZwUmlGcE4yalBBSHBJNTNrTThnMlZzUFQvUEdGT0tWQjVv?=
 =?utf-8?B?UVlnRFlPaTdIL1E5UjFETmhCVkJMQ09rL3dHdmZGWTRWWjZodVlwYjNPVEJT?=
 =?utf-8?B?UldSd0k2cWxQZWpmTWJoRVBSWHJxTEtlTTQ2RWxjMEFsdjBzSGlkN1dCYStL?=
 =?utf-8?B?bU5ESXJ5a25DNnNaN3VFZEJhNU9IMkxqcGJtbmhuNFhFTzgwdW5GMUdjRHhI?=
 =?utf-8?B?WTByUCtUbjFDOXJ5RE0rU0xSY1lJTHRnZmR5VnZTek9SUERiSlhQK04vNXhT?=
 =?utf-8?B?bjVGVVBUZ3FCaWxBdElGMnRuZS9kVUs3RWpwTFMrTjkwU010Sk1ERWpvMFJK?=
 =?utf-8?B?MExVeUUySGZZeE5QbGk5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWRsY3IvcWo1bE5hRU9YMGFJUjd0WDBqY1BLaEpwaTduMGhRSTBEUTh1Y0F4?=
 =?utf-8?B?VDZPWkxXdENMZVBlbHB0Ym51OTdBSlNwcEloUHBkWEtTYUUvMUxMY1JSTkVS?=
 =?utf-8?B?dE9jWUMxbjhybDJHNTYzblpubWlqeTYyMUFkcWJZMmZNV2tWbEdtVm1UYUlT?=
 =?utf-8?B?TkdVdThFSlFwNk5ZajN5TnA0d0RSQ1JCME9LTHJmSHg5cUo4QUk3ZG5pdzdV?=
 =?utf-8?B?NUtkclVvQllDaUlFdE5MbElkVExqbFVjQU5xMlA1d1lQUURpY3J5OTRjd0ht?=
 =?utf-8?B?U2RiK0dGTCtRRVREZUJPeHUyK3B2QlJkZXNmQjd6TzhnVHdHcEtDeGdrK0RB?=
 =?utf-8?B?cGI5Q01JN0Mxb2RkeXoxSTJKYStKUWxIa0FpR2phdTVnZXRaVkhTemN5NUlt?=
 =?utf-8?B?NXFJS1NZWlNya3M1TE5JSllSdTVMUnFmUDJlVzF5d1lwQ2ZXVnM2VThCVzVl?=
 =?utf-8?B?RUwwWENYMDc2TmtSYnYwTHpLckJQNEVudjVCeUJwdHRmdjY0bk1yZU1TMTU0?=
 =?utf-8?B?Q2xnUTlJTjk5T25WNjkzR2MzVWUwT2oxYzFvaW4zVlo1aENuZFNBTlNnVXMz?=
 =?utf-8?B?b1VZaXc3L1M3VmVDbzVXbExrcFFoa2xuRzMrS3NHTndRRUlOU3AxZzVCbFl3?=
 =?utf-8?B?MnIwa3Z1V09rd3NVbkJZVnZtNGtUSkZDWDg0NmtWYnVLOXIrclBFWW5IL0NB?=
 =?utf-8?B?SmdpaVQ1b1lGSjlUMWlkTytCbk1QcWUxZm03OTNGOVVmeXBmcGJqMGdnUVdy?=
 =?utf-8?B?SmVxV2JmeDhQcTk1ME44Y1JRV3BDWjVOSndxTWZCZ0czRTF0RVU3cnRUYlUv?=
 =?utf-8?B?Q2ZNSjM1YWxBY3NsMkl6dTRUWU9KMjNuTko5L3psUU1oTzV2NHZ0cWpPM1Ni?=
 =?utf-8?B?WTZUb09oMTM5NkFEQUwrYTY5K1FILzNXUXlvbUpnNDdzNHVsRmRoT3Q5bXgv?=
 =?utf-8?B?U2RYZ21ETXE4MXRxQklFQXRsaEpsTU90bitzcmxGQzhlVjlEem5SdVFhdzB3?=
 =?utf-8?B?M3FxTWZpbCtoNnFrVFNuTEkxWHJrU1YzU1l0ejVYV2h5RVppOXlQUVIxNG1L?=
 =?utf-8?B?RUZMRUdFVzlzWFlsRXN2cWRic1dXTjBTNTFNQXEzb3VMNFA4Z1AzdUNnWmtq?=
 =?utf-8?B?ZVpla3JlQzU2Nis2Q21jRStPSFpZdE11TTBxUWtCYWlqcWorZzVvZU1KYW9o?=
 =?utf-8?B?bGtiZXd1L05wcTRpWG1oNUNFbGM3MHd0eVEzczVXRDJHMUNBVFdibDIxenY5?=
 =?utf-8?B?Z3R5ZE8zaDc2VEhuQjBFSU5vd05VdUlGSGYyNzc2cFJwNk1TK0taREFlNlgy?=
 =?utf-8?B?c0IvOXJ5T05NS0Z0dEV6QXRJYnFtbHN2NzBCTmRmZVhTVHEweFJsbU44WHZY?=
 =?utf-8?B?S0dIdmt2Tm44UjA3R29YamFTVlFqT0x1NHpPV2FINHJRV2xSK3JYSE8xT1Z5?=
 =?utf-8?B?c1g0T0VVQmR0eUZBWjJ0blBMS1hzbmhqQTBjNjhMT0crSTNYMFFjdWptQThw?=
 =?utf-8?B?aGpOYXVFYWJQaTVpQjdmR2NMRlFUdHVWaU51WWZGSVNldjBGRkRZWG1HdUJj?=
 =?utf-8?B?b0lMREJtNXRWcEk1NDlKekh3MDRURmlvMHM3VDAxYUhFRWVFZjlRVTVZVTdW?=
 =?utf-8?B?QnMxeURDRTAyQlNWN2tNUWJSL3lxVnZhakQxUUxnTW5UbVZaVCtIcDN0TnFs?=
 =?utf-8?B?bGlvZSsrcHBjcDU0dHRtOVBkNkpYY21EeXlxSGY3ZmQ1VFl6cXI3Y3pUNFJs?=
 =?utf-8?B?RzlMMDdQM015aGQ0Sks3WDNVWEZRd0dyZ1g3dXlUOW1qdzlUd3Y1Z1g0emRL?=
 =?utf-8?B?Um51M3dTU0o2VXJydTFYL0RqekJLaExvSWdjOFc4d2NFWi9mUTF5dDdqdUZa?=
 =?utf-8?B?RHFMUFRtcUd2cngzTTVqS3NkYldJVkhvT0I2di9QRmNUUUMyTlp2Z1k1VVBO?=
 =?utf-8?B?MlExYW1SYXFYdkVnb0g1WitDOWc2RE01R21BV2pWS0xtcS9UdlBhZ3k4Q2Za?=
 =?utf-8?B?bGdabWhSZVVGVVlTbWExRnJxcDVGWDVUd0VFMU5LV2tiL0Z0dzRKVWRib1kw?=
 =?utf-8?B?V1piR0orV2loZ1RSK0VieFlaMUNqLzUzR2dCMzRjeTFNZ012R0lObEZQaWNh?=
 =?utf-8?Q?/Irb3KYvjEbQCRts7Ms7/R8dK?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8eede7-4ee9-4026-a3aa-08dce2e17bf0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 12:55:25.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVbpxAAuUSTLSlNt3qepcTD/XPCnyY5hxGHe+N+u7/Nld65/EUtUkCfBT72prnJHKFyYsabhDOPjVl/+PwJKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8418

SolidRun CN9130 SoM actually uses CP_MPP[0:1] for mdio. CP_MPP[40]
provides reference clock for dsa switch and ethernet phy on Clearfog
Pro, wheras MPP[41] controls efuse programming voltage "VHV".

Update the cp0 mdio pinctrl node to specify mpp0, mpp1.

Cc:  <linux-stable@vger.kernel.org>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
index 4676e3488f54d..cb8d54895a777 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
@@ -136,7 +136,7 @@ cp0_i2c0_pins: cp0-i2c0-pins {
 		};
 
 		cp0_mdio_pins: cp0-mdio-pins {
-			marvell,pins = "mpp40", "mpp41";
+			marvell,pins = "mpp0", "mpp1";
 			marvell,function = "ge";
 		};
 

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241002-cn9130-som-mdio-4a519e6dc7df

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


