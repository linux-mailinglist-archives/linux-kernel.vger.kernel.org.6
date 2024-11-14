Return-Path: <linux-kernel+bounces-408861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D4E9C8468
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68785B25B35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A681F584A;
	Thu, 14 Nov 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HM9Jx6bp"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2072.outbound.protection.outlook.com [40.107.103.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E31F5834
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571104; cv=fail; b=UmPzNz4EbjWdg1TDMYXOxvEnj7WgiF1+SbodTzfBFHMECy4aLO/KoUcEp1sRuutd60zQmSk1yRe8cVGkI8+oLhtmMp87mAfQzli3bBBJnSR7w+vwFIux1zWsMSi1OS583dshBINxsYc+152NqAbtPKEyxJxtqFk1uU8YKwh3de0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571104; c=relaxed/simple;
	bh=3P/94mAkni7hCLP+BnGateg1ZgKyAP/otbM2WBqEx34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P4m33M3Br2mSy+GnwXcTsfrQdKWUcyWaKHjlo8gZaDE9AvNFmynL1csfmA72PD067RHvnpoMAr9mK2rmEfFLP/ovBa7fTjakRspfH4vuDgfj988WHwy8plYPv3Mtgv2yLGV43kj7Rm8qgwY6/unxyJ7I3jHybI5Pa1ito/H2/Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HM9Jx6bp; arc=fail smtp.client-ip=40.107.103.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H69e4svCnppcK9mA7jfNb6Nt1Dnr66H0JS301tk5r/xR6cVvmD8rKF0R92Ar7XaUP+YjNWF9G/xg2k8+4sxLlcn211NVaRYXafSdo0Jm9vJVRsJ3KqoT3J64bh39oFvc84lp+zkcAg0ycJw0Vl717gxKA3xsWb7xBEPiKpBNsFQmXYtYJi5DF9hl1O7CbuNJ1WH0fV/2rBZzkxg9o1TTnz3qyE/u9Pz59aC1VWJU4WcKUN7rVwa2yKOLx/vbBhU4hM5/VVr+H9W8GBshLFsq6TFKFqWCHsi9UuuYgql2dz5NGQ+tVqSk7M3dzpFKMgBPvfF8I+NDBs5D8/J7pi6ubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P/94mAkni7hCLP+BnGateg1ZgKyAP/otbM2WBqEx34=;
 b=R9ZcVq89zCGaUADoIUvm3V+tN8Q/sbG2LtI3El6zXkrEekuVhX4d6nSHW78H4Jmtg0HBv4RaeJ5u3mTcdnWv7I/oiRtaItcax879k5ZeBwPXh9iJNH80zPbbjwkRMoJn6pFk00lK+GxiSNsQukwOp9dk7ineIftQ0f7/mV3VWGFOMB9GjwTMd8cafkQiX4YHu2SW/fxzKbBUMjo6MKEgPIiHzUA+1+Ljo6OrvZ3pNlYf1NvJJfW1Juzx5BJJUMbJL2leIrW2ps3GRsiqlMetbeOSv7M4CvI0RE/X6gPz+KvUGEcgx8cDwSajC2P3TRB39SkYeC2uTA9IfJu1/1V4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P/94mAkni7hCLP+BnGateg1ZgKyAP/otbM2WBqEx34=;
 b=HM9Jx6bpEqC5veAjvvRA7HLAdwd1BHyGp6e0n8YiRcC2F2eaeZiF2k9swBRnmsw2L2MqDZn0Bx73oimjmAvCPS/CyHji3XJBS82yN7LP1AZl+O97/IlW9+9kEb//aH/smO/3lLiPs3+wyzwuj7tiEOI6elr5b5eg16fdSh4hYNupH/tLCUKFN4JqTqpzvVk+bT6hPJ+sKVotU/ja2zTRsCqbaX7oJM+3KCzMQytjnlfHtyz/XdKNrvDSjG9hw248YMvZsb5s8eg6gbuA0Q1islyYbfsQq9b8qm3CIQ9jt5cxv+mgUA0LFVqq4A+cEhFMG8vsEOfFGzEZSeWEKplREw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 07:58:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 07:58:15 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHY1XSBzb2M6IGlteDogQWRkIFNv?=
 =?utf-8?Q?C_device_register_for_i.MX9?=
Thread-Topic: [EXT] Re: [PATCH v5] soc: imx: Add SoC device register for i.MX9
Thread-Index: AQHbM+k2R84jNMH3skG+yFxEMXD9c7KyWR4AgAQOC/A=
Date: Thu, 14 Nov 2024 07:58:15 +0000
Message-ID:
 <PAXPR04MB9644C81E428A2AD90F7E5E6EE25B2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241111032307.144733-1-alice.guo@oss.nxp.com>
 <eed25785-7972-43ce-9903-d8350e51ff7e@gmx.net>
In-Reply-To: <eed25785-7972-43ce-9903-d8350e51ff7e@gmx.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8485:EE_
x-ms-office365-filtering-correlation-id: 2801cd09-0ed7-41eb-3c35-08dd04821879
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFpPbGZQMVBVNmx6NWdoQlBuU1Y3R2FVdWJFYUIwNWVEUGNMTVV2MlV0eUtL?=
 =?utf-8?B?MVlnSVpYUjhja0FjQk1USU9BMitLN2RaY0lWZm9Kcy8veU03TnhXczZrb3NQ?=
 =?utf-8?B?NWJpNVduNi9VRW1PMjRVYTJrYW4wVGxWNkhQMUE4b09BcWpuK0ZXMG1DTnRk?=
 =?utf-8?B?RzhNWGo5VzN3M2YxYXZTWUtPcnpvbkVteW1QcTB2TjJXRDBRcnk2KzhReXlk?=
 =?utf-8?B?NkRDUUJ4UHlBWWtXeW9tRGpGY1JJT1BJbFdHRUE0ekJkQVZNaXZuK2w4U1lo?=
 =?utf-8?B?ZDlXeWgyN05CN3l4dHVESTFkYUR2UWVpOEIwaFYwSHU0d1BHaVg4aitGbmt5?=
 =?utf-8?B?OUNDMTZtSytuM0FoSSt5YWdGdmM5eCtVNmJqOUJyQk5HQlBBMUV6MVp5Ym42?=
 =?utf-8?B?ZTUxYnJZUVpPM2piUzdBeExrN0w3dUdiZENLYUZNRmZwYU9Gd2FBMjdHbis5?=
 =?utf-8?B?ZFkzRXZHMVBGYTE5L3NlTUxxWEpoc2ErNTUzVGZxOVhnKzYzRkFXMzVXT0k4?=
 =?utf-8?B?RDZQOWVweWk3VmdhU2FWbG9aWWtlZmxnbjQva1VnNEFDTTlHRWwvc0l2ZDRm?=
 =?utf-8?B?NWZGcndvQUhZQWFsWFQ0VklFN09tWlFLaktOZEg4K21NbnlFb0hCTldxdHg3?=
 =?utf-8?B?MkxRekFPWjgxRTFiSkN2MzQwa09pRVBkRWttTnFuaHE5WWVtR0Q1RHpiQWw4?=
 =?utf-8?B?Y0NEekVvSCtPTFNCSGlNb3lSUXhOZ21xSHRuU1FTdHFrb1ZMbzVYelFRdVZk?=
 =?utf-8?B?MU84L09SVzdtcCs3UHpyMUlJN2twNmNsK1ZvYk9Ba1h6cE0zN3lnazloTnhH?=
 =?utf-8?B?Tk5QOWlVc0REWjl1TnUrT2hhY09DOTF3N2hKMkcxVlNnMWJ0N3FvbGRUTUFy?=
 =?utf-8?B?bEVyVHQySmpOT0EwRjZ4NEdMSFYwS0tMVDFUMjM0WkNXZkpWOHNxSm1zUyt0?=
 =?utf-8?B?WUk2QkFOWHY4Ymt6eTRsdEpIM0hNL28vTjFQZVhQeEpCRTlCUUJleDI3Q3Yy?=
 =?utf-8?B?OWhxc0ZUYk45dXNVV2UvRVhsMHdLS2VST1Q3UlQ3VUNlVFpSYWxHUElvUUQ4?=
 =?utf-8?B?dEROWXNpZFIxQlcwbmlWYkVrV2pFK1lrYmdUUFo2ZWlTOEwwMXRTdld6ek9B?=
 =?utf-8?B?ckQyNmRSWFlGK1VGVk1CK1E2WWFOdEx4aUpEY085djVHY2xTSXQ3bzRMUlV5?=
 =?utf-8?B?Sm1jL0lOTFBOZlJzczZrYmdGcFNKTGpTMis5RjFRV0RzT09iRGFoU3N6RnNL?=
 =?utf-8?B?SlYwSmFva250Q3NuYU9taU5UODlFS1BEaHFodUIrQXRsVi9RVHJCakVRSHEw?=
 =?utf-8?B?d1haTDhmSjlNc2RZK2dTSy95VWVDVmZNaFRxRlZJQWhsRnRLUUVXQWNMdUV5?=
 =?utf-8?B?bWJRQ0VDMmo4ZnR4eHdrNEhMeW1jUzgrU3VHcmNsc09RT3BxdE9xY2dPdGlm?=
 =?utf-8?B?UkVGV09qMDc3U0k5OTVGQ2JXcGRVM3BFUWo5ak93UWNRTDhEZVl4NUNaelU3?=
 =?utf-8?B?TGw2R3V3VXlzaGJCVU0zSzU0eXFmMzJpMHhFdHZqcDlBMWg0eUh2ODIvWnBm?=
 =?utf-8?B?dDk1cE1qanpsam1aU1gyT1RUZzJFQTNtdjIyMkplVVpoRHNLd0h1d1UvRUdX?=
 =?utf-8?B?b1p0eHEyVFJ3OVVWUm1tVUJWN3VZUENxTGw3ODlVMytWdkI3Z0RKQUh5d083?=
 =?utf-8?B?RWF3MjVMSFJiL2MzVUVmMDd1Uk1vUnl0MlgyNGpwa1IreWwwQmRzbzRiVk9R?=
 =?utf-8?B?TnJEMXdGUGxleWpGYm1YcnVJcDFHMFVMY3BzQkJzNVhIaXI5dUM3Lyt0QWdi?=
 =?utf-8?Q?d6OzOiVKR3d34GUNpdoJLpVCJ6Yp31plA5CKY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzRxZ1E5c2xjWVZjUHU0c0lNZWdveWJqcEpCUThvTlVvMWJSdU8vN2orVXVs?=
 =?utf-8?B?bFZ3VFlMaGVTVERFdjdCalBJT0xBVWZURk9aTm9uaHkxcFY1NFpNL29UcWxt?=
 =?utf-8?B?Vm1FVUVobzl4NGVWOTRmNUFiVzZzeWdIdFJIVGpaRy9JcXdsc2dZUnV0SnVG?=
 =?utf-8?B?N1ovN0VWM3BPQkE4NzExemgwdER0WGpHUzZKaHBjOFRNVmJGb0haM2JRaDk0?=
 =?utf-8?B?UGlGZ0JUdW1MRDRKUWJlOVZJU0FROWMvSy96dkowcWg5eHpVS1E2eXozQUxL?=
 =?utf-8?B?VUNvRU8ydG9rcDcxU3ZQeXdiejlPLytkc3hZQWpFM0NPTFlKN0pvSERTeW5I?=
 =?utf-8?B?NUkxUkpEaEd4NDBJOFVZSk9DK0JnNEQ1QjlGbEFCaVlQRVRJeW8zTmxVV04r?=
 =?utf-8?B?ZDlnbW1md1pHV3IydGdGbWtJNkhGc3hTcDBhaFp4N05EZldlKzdWK1FhbUF1?=
 =?utf-8?B?MXM0NVlMZ2RkOVliM1BQZmkzSEdQKzdjdmU3c1lJVzNDcGhPSXVvYlJxWjBY?=
 =?utf-8?B?UVBOczJQQnBFSHladzFoNElYN1FvM3JiYU9mSjVIclpJcTJyaS95R0thdzVh?=
 =?utf-8?B?OEM4b25KK2swSWNONko2aUdJVHhxOHBwaU5zRVU4U1kyT09CU2xzMG4rZXhR?=
 =?utf-8?B?c3Q1RmN0UGptZ2JDb053SksxdTBmR280dnhXZEorTm1tUGlGamVnYzdlbVQy?=
 =?utf-8?B?YllncFlEYTBwek16cmZLU2ptV21WWXNRdCsvRlFWalo2dWg3YWpwSUdyUFFr?=
 =?utf-8?B?eGJ6T0F1SGxQbzlncmUvbU8rbFNpWmdIaHdWMFJrQUM1VllOa1BoN3JOWXQ1?=
 =?utf-8?B?elhzbmRqcFptZDhOaU5FU3Y0T3RLem1MMzltcER2K090akJQOXhzSHEyY0xr?=
 =?utf-8?B?QU5KUGd0UXhXTWVtZ1lSRDJpWXltQmVRZzEvdDVhMFhDcmVtMjhsSld3VmE2?=
 =?utf-8?B?Nmt5a1ZSZEFtMDRIMHMxajFsVE8rWGxwc2lNUlZERUlxdzBWRXZSdzV2Vlo4?=
 =?utf-8?B?THltWVB5ZWIralZUTlB5OVN6akxzSFdRbzB3R3d4L3NEOERiR3dQazNiNXRm?=
 =?utf-8?B?QjhBanFxeVVrdjg4RS8zbTY2SnlDMTBCeGdNVlI2bmpSbjFObkpKUDZhVkNy?=
 =?utf-8?B?bkM4NmNVQXRHM05ZRVZVZWx6MVdud0ViRnRqR1BLUDBoRy9sTTNzVkxYSUZB?=
 =?utf-8?B?ei85SUR6NXpLZ09GN29rVnBDNUpjNklsSkl4bnFWcVVleTZHbFl2SzZBMzhm?=
 =?utf-8?B?WHN2ZUhwS0JhWWxSOVdmRitSYjRUVWJxSDF4a3ZXSWpiUkJvUWZsK04zUSt2?=
 =?utf-8?B?YlhVSFh4cldXOENXWDdMUTUwaGZCdkpoeFBFLy9aVndaK0pxOVFxWUt5UDE5?=
 =?utf-8?B?SXhpeHFYUlZzVlVDdFpOSVlqSWZvTVNINGRsY2VmL243aEFzdk9hTHVQU3p2?=
 =?utf-8?B?MTVZdC9zSXRmeEZ6T1dKMEhGVG1tWGZwWWVNVWxHaFc1MG5OSGdkTkZQQkdS?=
 =?utf-8?B?WWtWdU1vRTR2OExwN20za1hEdHI4NDhsTUFLQmVidTJvbHNRNEpvT0tzcGIw?=
 =?utf-8?B?K1BuemZiTm02VlR2cmlPcnBiSkovUklMSWJENi9KdWZmcWphMkRtcFFmQ1pn?=
 =?utf-8?B?NFNXMEFxTHdsaTJEdUVGblpJbUlNTklNNWViN3FINEhrM05BdGRkaWVVVFBi?=
 =?utf-8?B?TUNoYm5GUkFncjgzS1ltNVlLcGJXNjBKYnZaTGtIanNtQzJ5c1RzTjlKRm9s?=
 =?utf-8?B?Q3pYcXBzQkVSSXlKZE1nWGdYaTBRTkxQbkFZQ1hydTZSRkZBT3Vpc0RwTWRo?=
 =?utf-8?B?ZFdhS3Z5L3U5aW8vcFlIWENKQ2RIbnp3VHQ3WFpaaWFqK3d3QzFjQ0EzRlZH?=
 =?utf-8?B?T3ZZV2VOOVkrVU1BMDc1c0MzWFdhVXJCWDg2a0lETklIZGZXRU5CQ3J5MEVU?=
 =?utf-8?B?QzR6QkdKQXI0bDZhVXV5QmxDMUtpRzlZc25NbjFDaC91SERKMEtsWW9Kd1Zw?=
 =?utf-8?B?dGxoTk1LT1JzelJqSThmRGRUemdMTVpwZllKRlpUYUZCYWdVUnJvWEJoaVZv?=
 =?utf-8?B?dzBWNWY3U3VYLzVWZXpXUkcwRGxaQjEzbmtKSndjQThVZjJyWXBSZ2luMmwy?=
 =?utf-8?Q?yHXY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2801cd09-0ed7-41eb-3c35-08dd04821879
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 07:58:15.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNrym0jYQBOW1bdGhWSMApHM4vXKE/mu9FWD1hg2M/IhAiSa66ZA5bFjhVQg4JBl66cG3MeNoh7aG2x66FVYTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

SGkgU3RlZmFuLA0KDQpUaGVyZSBpcyBubyBkZXZpY2Ugbm9kZSB3aGljaCBpcyBib3VuZCB0byB0
aGlzIGRyaXZlciBpbiBEVFMgZmlsZSBzbyB0aGF0IEkgZGlkIG5vdCB1c2UgbW9kdWxlX3BsYXRm
b3JtX2RyaXZlci4gVGhpcyBtZXRob2QgaXMgdGhlIHNhbWUgd2l0aCBkcml2ZXJzL3NvYy9pbXgv
c29jLWlteDhtLmMuDQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0KDQo+IC0tLS0t6YKu5Lu2
5Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBTdGVmYW4gV2FocmVuIDx3YWhyZW5zdEBnbXgubmV0
Pg0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQxMeaciDEy5pelIDE6MzgNCj4g5pS25Lu25Lq6OiBB
bGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g5oqE6YCBOiBpbXhAbGlz
dHMubGludXguZGV2OyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQWxpY2UgR3VvIDxhbGljZS5n
dW9AbnhwLmNvbT47DQo+IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb207IGtlcm5lbEBw
ZW5ndXRyb25peC5kZQ0KPiDkuLvpopg6IFtFWFRdIFJlOiBbUEFUQ0ggdjVdIHNvYzogaW14OiBB
ZGQgU29DIGRldmljZSByZWdpc3RlciBmb3IgaS5NWDkNCj4gDQo+IENhdXRpb246IFRoaXMgaXMg
YW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBv
cg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3Nh
Z2UgdXNpbmcgdGhlICdSZXBvcnQgdGhpcw0KPiBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gSGkg
QWxpY2UsDQo+IA0KPiBBbSAxMS4xMS4yNCB1bSAwNDoyMyBzY2hyaWViIGFsaWNlLmd1b0Bvc3Mu
bnhwLmNvbToNCj4gPiBGcm9tOiAiYWxpY2UuZ3VvIiA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4N
Cj4gPiBpLk1YOSBTb0NzIGhhdmUgU29DIElELCBTb0MgcmV2aXNpb24gbnVtYmVyIGFuZCBjaGlw
IHVuaXF1ZSBpZGVudGlmaWVyDQo+ID4gd2hpY2ggYXJlIHByb3ZpZGVkIGJ5IHRoZSBjb3JyZXNw
b25kaW5nIEFSTSB0cnVzdGVkIGZpcm13YXJlIEFQSS4gVGhpcw0KPiA+IHBhdGNoIGludGVuZHMg
dG8gdXNlIFNNQyBjYWxsIHRvIG9idGFpbiB0aGVzZSBpbmZvcm1hdGlvbiBhbmQgdGhlbg0KPiA+
IHJlZ2lzdGVyIGkuTVg5IFNvQyBhcyBhIGRldmljZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBBbGV4YW5kZXIg
U3RlaW4gPGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+DQo+ID4gLS0tDQo+ID4NCj4gPiBDaGFu
Z2VzIGZvciB2MjoNCj4gPiAgIC0gcmVmaW5lIGVycm9yIGxvZyBwcmludA0KPiA+IENoYW5nZXMg
Zm9yIHYzOg0KPiA+ICAgLSByZXR1cm4gLUVJTlZBTCB3aGVuIGFybV9zbWNjY19zbWMgZmFpbGVk
DQo+ID4gICAtIGZpeCB0aGUgYnVpbGQgd2FybmluZyBjYXVzZWQgYnkgcHJfZXJyKCIlczogU01D
IGZhaWxlZDogJWRcbiIsIF9fZnVuY19fLA0KPiByZXMuYTApOw0KPiA+ICAgLSBkcm9wIHRoZSBw
cl9lcnIgaW4gaW14OV9zb2NfaW5pdA0KPiA+ICAgLSBmcmVlIHRoZSBtZW1vcnkgaW4gdGhlIHJl
dmVyc2Ugb3JkZXIgb2YgYWxsb2NhdGlvbg0KPiA+ICAgLSB1c2Ugb2ZfbWF0Y2hfbm9kZSBpbnN0
ZWFkIG9mIG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSBDaGFuZ2VzIGZvcg0KPiA+IHY0Og0KPiA+
ICAgLSBmaXggdGhlIGJ1aWxkIHdhcm5pbmc6ICdpbXg5X3NvY19tYXRjaCcgZGVmaW5lZCBidXQg
bm90IHVzZWQNCj4gWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0NCj4gPiAgIC0gYWRkIFRlc3Rl
ZC1ieSBhbmQgUmV2aWV3ZWQtYnkNCj4gPiBDaGFuZ2VzIGZvciB2NToNCj4gPiAgIC0gcHJvYmUg
aW14OSBzb2MgZHJpdmVyIGFzIGEgcGxhdGZvcm0gZHJpdmVyDQo+ID4NCj4gPiAgIGRyaXZlcnMv
c29jL2lteC9NYWtlZmlsZSAgIHwgICAyICstDQo+ID4gICBkcml2ZXJzL3NvYy9pbXgvc29jLWlt
eDkuYyB8IDEyNA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
ICAyIGZpbGVzIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvaW14L3NvYy1pbXg5LmMNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9pbXgvTWFrZWZpbGUgYi9kcml2ZXJzL3NvYy9pbXgv
TWFrZWZpbGUgaW5kZXgNCj4gPiAzYWQzMjFjYTYwOGEuLmNhNmE1ZmExNjE4ZiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL3NvYy9pbXgvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9p
bXgvTWFrZWZpbGUNCj4gPiBAQCAtMyw0ICszLDQgQEAgaWZlcSAoJChDT05GSUdfQVJNKSx5KQ0K
PiA+ICAgb2JqLSQoQ09ORklHX0FSQ0hfTVhDKSArPSBzb2MtaW14Lm8NCj4gPiAgIGVuZGlmDQo+
ID4gICBvYmotJChDT05GSUdfU09DX0lNWDhNKSArPSBzb2MtaW14OG0ubw0KPiA+IC1vYmotJChD
T05GSUdfU09DX0lNWDkpICs9IGlteDkzLXNyYy5vDQo+ID4gK29iai0kKENPTkZJR19TT0NfSU1Y
OSkgKz0gaW14OTMtc3JjLm8gc29jLWlteDkubw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Nv
Yy9pbXgvc29jLWlteDkuYyBiL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OS5jDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMDAwMDAwLi40ZWY5MjI2MGU4ZjkNCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvaW14L3NvYy1pbXg5LmMNCj4gPiBAQCAt
MCwwICsxLDEyNCBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsN
Cj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IDIwMjQgTlhQDQo+ID4gKyAqLw0KPiA+ICsNCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2FybS1zbWNjYy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW5p
dC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9vZi5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zeXNfc29jLmg+DQo+
ID4gKw0KPiA+ICsjZGVmaW5lIElNWF9TSVBfR0VUX1NPQ19JTkZPIDB4YzIwMDAwMDYNCj4gPiAr
I2RlZmluZSBTT0NfSUQoeCkgICAgICAgICAgICAoKCh4KSAmIDB4RkZGRikgPj4gOCkNCj4gPiAr
I2RlZmluZSBTT0NfUkVWX01BSk9SKHgpICAgICAoKCgoeCkgPj4gMjgpICYgMHhGKSAtIDB4OSkN
Cj4gPiArI2RlZmluZSBTT0NfUkVWX01JTk9SKHgpICAgICAoKCh4KSA+PiAyNCkgJiAweEYpDQo+
ID4gKw0KPiA+ICtzdGF0aWMgaW50IGlteDlfc29jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpIHsNCj4gPiArICAgICBzdHJ1Y3Qgc29jX2RldmljZV9hdHRyaWJ1dGUgKmF0dHI7
DQo+ID4gKyAgICAgc3RydWN0IGFybV9zbWNjY19yZXMgcmVzOw0KPiA+ICsgICAgIHN0cnVjdCBz
b2NfZGV2aWNlICpzZGV2Ow0KPiA+ICsgICAgIHUzMiBzb2NfaWQsIHJldl9tYWpvciwgcmV2X21p
bm9yOw0KPiA+ICsgICAgIHU2NCB1aWQxMjdfNjQsIHVpZDYzXzA7DQo+ID4gKyAgICAgaW50IGVy
cjsNCj4gPiArDQo+ID4gKyAgICAgYXR0ciA9IGt6YWxsb2Moc2l6ZW9mKCphdHRyKSwgR0ZQX0tF
Uk5FTCk7DQo+ID4gKyAgICAgaWYgKCFhdHRyKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9NRU07DQo+ID4gKw0KPiA+ICsgICAgIGVyciA9IG9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nKG9m
X3Jvb3QsICJtb2RlbCIsICZhdHRyLT5tYWNoaW5lKTsNCj4gPiArICAgICBpZiAoZXJyKSB7DQo+
ID4gKyAgICAgICAgICAgICBwcl9lcnIoIiVzOiBtaXNzaW5nIG1vZGVsIHByb3BlcnR5OiAlZFxu
IiwgX19mdW5jX18sIGVycik7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGF0dHI7DQo+ID4gKyAg
ICAgfQ0KPiA+ICsNCj4gPiArICAgICBhdHRyLT5mYW1pbHkgPSBrYXNwcmludGYoR0ZQX0tFUk5F
TCwgIkZyZWVzY2FsZSBpLk1YIik7DQo+ID4gKw0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAgICog
UmV0cmlldmUgdGhlIHNvYyBpZCwgcmV2ICYgdWlkIGluZm86DQo+ID4gKyAgICAgICogcmVzLmEx
WzMxOjE2XTogc29jIHJldmlzaW9uOw0KPiA+ICsgICAgICAqIHJlcy5hMVsxNTowXTogc29jIGlk
Ow0KPiA+ICsgICAgICAqIHJlcy5hMjogdWlkWzEyNzo2NF07DQo+ID4gKyAgICAgICogcmVzLmEz
OiB1aWRbNjM6MF07DQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAgYXJtX3NtY2NjX3NtYyhJTVhf
U0lQX0dFVF9TT0NfSU5GTywgMCwgMCwgMCwgMCwgMCwgMCwgMCwgJnJlcyk7DQo+ID4gKyAgICAg
aWYgKHJlcy5hMCAhPSBTTUNDQ19SRVRfU1VDQ0VTUykgew0KPiA+ICsgICAgICAgICAgICAgcHJf
ZXJyKCIlczogU01DIGZhaWxlZDogMHglbHhcbiIsIF9fZnVuY19fLCByZXMuYTApOw0KPiA+ICsg
ICAgICAgICAgICAgZXJyID0gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAgIGdvdG8gZmFtaWx5
Ow0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgc29jX2lkID0gU09DX0lEKHJlcy5hMSk7
DQo+ID4gKyAgICAgcmV2X21ham9yID0gU09DX1JFVl9NQUpPUihyZXMuYTEpOw0KPiA+ICsgICAg
IHJldl9taW5vciA9IFNPQ19SRVZfTUlOT1IocmVzLmExKTsNCj4gPiArDQo+ID4gKyAgICAgYXR0
ci0+c29jX2lkID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICJpLk1YJTJ4Iiwgc29jX2lkKTsNCj4g
PiArICAgICBhdHRyLT5yZXZpc2lvbiA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiJWQuJWQiLCBy
ZXZfbWFqb3IsDQo+ID4gKyByZXZfbWlub3IpOw0KPiA+ICsNCj4gPiArICAgICB1aWQxMjdfNjQg
PSByZXMuYTI7DQo+ID4gKyAgICAgdWlkNjNfMCA9IHJlcy5hMzsNCj4gPiArICAgICBhdHRyLT5z
ZXJpYWxfbnVtYmVyID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICIlMDE2bGx4JTAxNmxseCIsDQo+
ID4gKyB1aWQxMjdfNjQsIHVpZDYzXzApOw0KPiA+ICsNCj4gPiArICAgICBzZGV2ID0gc29jX2Rl
dmljZV9yZWdpc3RlcihhdHRyKTsNCj4gPiArICAgICBpZiAoSVNfRVJSKHNkZXYpKSB7DQo+ID4g
KyAgICAgICAgICAgICBlcnIgPSBQVFJfRVJSKHNkZXYpOw0KPiA+ICsgICAgICAgICAgICAgcHJf
ZXJyKCIlcyBmYWlsZWQgdG8gcmVnaXN0ZXIgU29DIGFzIGEgZGV2aWNlOiAlZFxuIiwNCj4gX19m
dW5jX18sIGVycik7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIHNlcmlhbF9udW1iZXI7DQo+ID4g
KyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiArDQo+ID4gK3NlcmlhbF9u
dW1iZXI6DQo+ID4gKyAgICAga2ZyZWUoYXR0ci0+c2VyaWFsX251bWJlcik7DQo+ID4gKyAgICAg
a2ZyZWUoYXR0ci0+cmV2aXNpb24pOw0KPiA+ICsgICAgIGtmcmVlKGF0dHItPnNvY19pZCk7DQo+
ID4gK2ZhbWlseToNCj4gPiArICAgICBrZnJlZShhdHRyLT5mYW1pbHkpOw0KPiA+ICthdHRyOg0K
PiA+ICsgICAgIGtmcmVlKGF0dHIpOw0KPiA+ICsgICAgIHJldHVybiBlcnI7DQo+ID4gK30NCj4g
PiArDQo+ID4gK3N0YXRpYyBfX21heWJlX3VudXNlZCBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IGlteDlfc29jX21hdGNoW10gPSB7DQo+IEluIGNhc2UgZXZlcnl0aGluZyBpcyBjb3JyZWN0LCAi
X19tYXliZV91bnVzZWQiIGNhbiBiZSBkcm9wcGVkDQo+ID4gKyAgICAgeyAuY29tcGF0aWJsZSA9
ICJmc2wsaW14OTMiLCB9LA0KPiA+ICsgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDk1Iiwg
fSwNCj4gPiArICAgICB7IH0NCj4gPiArfTsNCj4gTU9EVUxFX0RFVklDRV9UQUJMRSBpcyBtaXNz
aW5nDQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbXg5X3NvY19k
cml2ZXIgPSB7DQo+ID4gKyAgICAgLnByb2JlID0gaW14OV9zb2NfcHJvYmUsDQo+ID4gKyAgICAg
LmRyaXZlci5uYW1lID0gImlteDktc29jIiwNCj4gLm9mX21hdGNoX3RhYmxlIGlzIG1pc3NpbmcN
Cj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgX19pbml0IGlteDlfc29jX2luaXQodm9p
ZCkgew0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKyAgICAgc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldjsNCj4gPiArDQo+ID4gKyAgICAgLyogTm8gbWF0Y2ggbWVhbnMgaXQgaXMgbm90IGFu
IGkuTVggOSBzZXJpZXMgU29DLCBkbyBub3RoaW5nLiAqLw0KPiA+ICsgICAgIGlmICghb2ZfbWF0
Y2hfbm9kZShpbXg5X3NvY19tYXRjaCwgb2Zfcm9vdCkpDQo+ID4gKyAgICAgICAgICAgICByZXR1
cm4gMDsNCj4gPiArDQo+ID4gKyAgICAgcmV0ID0gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZp
bXg5X3NvY19kcml2ZXIpOw0KPiA+ICsgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAg
IHByX2VycigiZmFpbGVkIHRvIHJlZ2lzdGVyIGlteDlfc29jIHBsYXRmb3JtIGRyaXZlcjogJWRc
biIsDQo+IHJldCk7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgIH0N
Cj4gPiArDQo+ID4gKyAgICAgcGRldiA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9zaW1wbGUo
ImlteDktc29jIiwgLTEsIE5VTEwsIDApOw0KPiA+ICsgICAgIGlmIChJU19FUlIocGRldikpIHsN
Cj4gPiArICAgICAgICAgICAgIHByX2VycigiZmFpbGVkIHRvIHJlZ2lzdGVyIGlteDlfc29jIHBs
YXRmb3JtIGRldmljZTogJWxkXG4iLA0KPiBQVFJfRVJSKHBkZXYpKTsNCj4gPiArICAgICAgICAg
ICAgIHBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZpbXg5X3NvY19kcml2ZXIpOw0KPiA+ICsg
ICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIocGRldik7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4g
PiArICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiAgRnJvbSBteSB1bmRlcnN0YW5kIGFsbCB0aGVz
ZSBzdHVmZiBiZWxvbmdzIGluIHRoZSBwcm9iZSBmdW5jdGlvbiBub3csIHNvDQo+IG1heWJlIHRo
ZSBleGlzdGluZyBvbmUgc2hvdWxkIGJlIHJlbmFtZWQuDQo+ID4gK2RldmljZV9pbml0Y2FsbChp
bXg5X3NvY19pbml0KTsNCj4gSSB0aGluayB0aGlzIHNob3VsZCBiZSByZXBsYWNlIGJ5DQo+IA0K
PiBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGlteDlfc29jX2RyaXZlcik7DQo+IA0KPiBSZWdhcmRz
DQo+ID4gKw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJOWFAiKTsNCj4gPiArTU9EVUxFX0RFU0NSSVBU
SU9OKCJOWFAgaS5NWDkgU29DIik7DQo+ID4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCg0K

