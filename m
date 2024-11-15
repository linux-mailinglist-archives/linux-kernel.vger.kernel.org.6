Return-Path: <linux-kernel+bounces-410318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5249CD9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10714282E53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712C18A924;
	Fri, 15 Nov 2024 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aWLNCBIz"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84D189B9C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655483; cv=fail; b=vC7GwzsTcjzPUojpgRne320Rg/tOiQHQz2cGMJ+mS/s7ju5fRGwChFZZMm4Ary/vxX7fE/ieHb0Azk7g+SGCXbsnU1UsNv7qYY7QdJhUDdj3AJS0/y+ZmzhT2Kw9wQ7V12ymh0lteAAW5nYZEBayroThjCX5f38KYeN24n2WfYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655483; c=relaxed/simple;
	bh=a6vJ2Bvq65AF7K0LEUv0zlfA9CQBbShxY9mh6pSeiH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cVbTPW4CjmuhuhVx/aysVCwJ7yRzQzKC0GOkUqvKioKRrp3MFI1m1mBPLuRlNitVs3CLqKD9GINYQhPFPSrmO5K38ur/M50lI/gM+n2Y4Avcwg4l/OL2EyRrz2o4bybadTP3FUjXZ5NGDy5rBIrpYjY6BKZEPvfsX8q2pBmkaUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aWLNCBIz; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bl6G/gMDCpdr7M0A2PcTTsLuDVxxB6eqIlPCbfj4of91Vjr1azR+yqXZ7/BAa9V1k93z5kgCm4CWYTUuXJYQ7q7AUOZJbnqhAeF5Jf7FRYxT9zTWzQdNTjSHLhGZ3nlrB31+LykuiZu+Syg2a3eozkcJ1T97dbUIFIvZ5mR+dKe7eHuYCrnGQh3FojSCStHB++WLeoCx2QMdSfnLU14T1i6VcwejM/hBLqRwtd+AhDH8ooTs/FQnr+tYmFsS3hEbhdqYssmSP+Y33XWr7zIXYk53VPajVnG+28S7cPT3afSbnokzh/R+EDgVuZvLfhloozNwgSntw2Npc+KK+UNejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6vJ2Bvq65AF7K0LEUv0zlfA9CQBbShxY9mh6pSeiH0=;
 b=bouzg8Oe4zSAmscFpMKurhsdJiRu8njP5zfaNpw8h8HyfYdLSDFDftZ9jDQub1e4KmKwHK+0m8x+D69nPi84xQkppncLuAUQXPM7zCfD2Kb23QNZaPAB3cRlw9GZdQ4vxdmtps5JQCldhDiWt8vcdtwIHMDqmgHFDfvz2z0vZ/Xm1RnY+2L2ouC4IO539lVnSMbbEdgEY0hB9CDLKepNJSgVKPY+Kn/IsIrKwFfG8Qrkm52YuyWSY+GqKD3yZiY7uLUUQkSa24x1EHwA6fPQDkSU8aFYtFxS4EIryDNZQawBobVxk8OfwqpA0zBwxvP/dGrE3hObM0T4B3hrgN8+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6vJ2Bvq65AF7K0LEUv0zlfA9CQBbShxY9mh6pSeiH0=;
 b=aWLNCBIzIelFpl20hLTshQ4cAiL/IBwaX9UArmN+tcXgLZE0hEfh1/hQ2QDGzi9LWaM0B2CZS2yo5JAzLR0lYuVhQz1zeIAG5/PsLneMYXx0+UHMxdkr9NFvJErmxIJpbEOmoHLM/EnpkIlFmbYls9YxIRKqcOx7WV6TqPASCJWorZdh7bMZ4BaYcQEczQaN03K9x2gGjDtaxxoP93oMA/+/Vc0eowm1pPVDQREh/K4fwK8lF54W0V0KnK7iSxVhQvI3NcHw6ZzBfSfkhOHaU7QQfIVT8V3qQIeiZvohk+1oGlBrnqhUJcdWoGVCYSqGy6t1PTGDLqU+q6ZCxv2PDQ==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 07:24:35 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 07:24:35 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>, "Alice Guo (OSS)"
	<alice.guo@oss.nxp.com>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHY1XSBzb2M6IGlteDogQWRkIFNv?=
 =?utf-8?Q?C_device_register_for_i.MX9?=
Thread-Topic: [EXT] Re: [PATCH v5] soc: imx: Add SoC device register for i.MX9
Thread-Index: AQHbM+k2R84jNMH3skG+yFxEMXD9c7K3EH4AgADizzA=
Date: Fri, 15 Nov 2024 07:24:35 +0000
Message-ID:
 <DU0PR04MB96364D1935D61D31176127F3E2242@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20241111032307.144733-1-alice.guo@oss.nxp.com>
 <4c157893-ceba-4a6a-a860-182af5f08c5f@gmx.net>
In-Reply-To: <4c157893-ceba-4a6a-a860-182af5f08c5f@gmx.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|AM9PR04MB8617:EE_
x-ms-office365-filtering-correlation-id: 9f4de15a-597e-45bb-48b9-08dd05468eb4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnAwRVBZVGlFYjF5aGhMZGpFK1YxaXE3bzhYVDh6dzdkZ1U3SnJVbWJ3UDE3?=
 =?utf-8?B?N3BVUjFzRklBc0pRdk5PenQ0VlZDZEd6TkF1d0lyczdHYWJpZC80ZEtnaHQ0?=
 =?utf-8?B?bk5ZckRpMzE0YWcrZ3llV0c2R2xIcmhvSzVpVzNxYUFCdFR4c1owQzZhb2hP?=
 =?utf-8?B?Qmh6SCtGaUNYK3BCOXFQMG91QW5CWUZHcStiRDNyTUhTRTkwTUcxaHZ0Tko5?=
 =?utf-8?B?eExBL2dWdUxFN011M05wK1dCUnZydTdCK0xpNWpvQlVuazA4eS8vL0ZvbTdY?=
 =?utf-8?B?M1d0eDZBczVUZXlFK0FHamJGbFgvSU9ud1JNbWJ0eDl1ZmtNUy9TcUFJRU9N?=
 =?utf-8?B?Q1YyWjVpWE1PM3Z5RGdiZTJ0ZllMbjNLVnVPTUhRM2V2OCtUakxuZXRGWVlE?=
 =?utf-8?B?c0l4ZkFFRWR2b3cyN3hZWnY1L2l5MzhzTlNRQldVS3ZHTFhkZkkySEMrY2tQ?=
 =?utf-8?B?cDE3Rm5ZVE9rRDl0dHlYcWcrUVl1SldBKzB5UlBkY3lLeEZiSzRBWC9ZbC9M?=
 =?utf-8?B?YzQxcityU0FzMUtMZm9kSklSczBXYkUxMG9zampnSFd3TUp4aVZQS2V4ZmhK?=
 =?utf-8?B?Yk1UZUJ1ODZSYWhOR0tEYUF4Y2xQUkFUc0JpWlNmdW53T3NLSDNmVUZGMEFH?=
 =?utf-8?B?ekJmZTR0aTRiaGZhanpxSmRTazZJdkZGUFlIdkdxaXBFR2RmUUg1cHpyVXhw?=
 =?utf-8?B?UDM1T2FVSlJNaisyWUpXcEg0UHVpWnd1Q0hJbjJ0QksrTmhsNGtxT0g2bS9q?=
 =?utf-8?B?NjUwN1ZsREJGVmJCaW51WFhOb0wybmI2ZFpNU1lwSlh0T1QwQ3c1eEJzYitj?=
 =?utf-8?B?V05nZ3Q4MkJxR3lNWTdPeStnV1plM3M0bVRUeWc1SFVvWXFPVG5wbTU3WTdV?=
 =?utf-8?B?SmNaKzdQSHZpMVhVQlJ2MU9xUEFCc2JHdUpVT2VQeVRMYTh5TW95aW1GQmND?=
 =?utf-8?B?emJGSTBEOHBqUUxmUEVhWjhOZityNjVPMkhOVGxiaExYSDFKTytyaXdDd1JX?=
 =?utf-8?B?TUdhT09ZKzlOZTBaV2pOMEhTSyt4WjFaWXFZTHhsUHNXNTlMTXQ2NWhRMmhT?=
 =?utf-8?B?TUZXSG1KbU8vV3dTSG1xWkJ4dFV6TzJVN2lrUWpDMHEyS1Q0NFA0bGw5RGp1?=
 =?utf-8?B?ZCtDTWhnaktHbkFzT2QzNzRSTHFmd0x2eWtYTHdxMUIwU2xNNFVJR1hYN1FO?=
 =?utf-8?B?LzIvT2hqOEd5d2c5eEV0d2pSbGxVV1NCdFFZSFE0Qk00Sk00VzFvYWh4LzVm?=
 =?utf-8?B?ZkRJRFg3Z0dSa0JNMlpRaDdZd3Z2WkdITFFCK09kMzU1MTlhdEVRa1RUYTVV?=
 =?utf-8?B?OHBTcC91NS9Ia3VRdmdsTWlPc0tYSll1anpKY2k4ZmJqVnpubTJNODUxL2VI?=
 =?utf-8?B?YjZ4UHRHKzNFMVRqa2NuTzA3LytSWWs2ZG1LNTJ2QXlTSHBMUzVOYUxmajcz?=
 =?utf-8?B?QkQ4MmJoVlozR2tMdWZnZk1qb2llbU1aUkQzWkhDNTRVK09YTE5DMUY3Nm9p?=
 =?utf-8?B?VHA3S3NoOWZ1Q0RPRGlOWTBXN28vak5rYnhHVlRJZnMxM042NmgrbWZ4blVV?=
 =?utf-8?B?aXZldFpwSWtoVnNpb1oxL2V2Z3lSYUFXYmFlQnN5S29qYU9rNFpnNzJEWGVt?=
 =?utf-8?B?WnNBNER5MTVoM2sybk1pSm8wcEJORHo0OHNTeW4xM3duY2NTbEtmQ1hteHNw?=
 =?utf-8?B?Ylp5YkZJVVlFT3Q3UUhNZXdQZDJCem1Qa2FRdDkwREhzaTQwRkRLUXlsQUtL?=
 =?utf-8?B?NGM5dnlxQ3F2V3RnWHU0eXJ2MGwxNHBTSm5GUUQ2YjcxZWxpLzdkN0RDNnBO?=
 =?utf-8?Q?2xL6i9BaC6uZ+0m5A/ofVH6mXKXT7Q+IthUlQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnlPbjBrZXp0NFMrejdJMnh2eWVHa3VQUUYxbi9SV2lPL25ZMGZHZlBac1lU?=
 =?utf-8?B?WVN1REJ3d1BVdjIyeE12ZEpFZWljd0QrWE5QWTcyWU5lbnJXM1M3ZXNhTWNM?=
 =?utf-8?B?Zkp5L1NXazJZUjJiaGxWWXJLMzlPSENVdG90ZWZJc3pPbnZPUHhXR1U4b3Z2?=
 =?utf-8?B?SmZOd3RKOWlmMmhtNGRWNWdiSkNNa3dHeFpKNUFkWW9Mb0hLcnozSnFEbUFU?=
 =?utf-8?B?OXdYVFlMWkd0bGpoaHlpaEdLNTY0QjJoaEhTYmQ2YkVsTm5PMllQbG9keG0r?=
 =?utf-8?B?Q0ZabG5KY2FueTl1V0swNm9HTWlpeGJrTEFwcDFqZ2tzWkRVbjZlNFBmbCtZ?=
 =?utf-8?B?NklCYVl0dkgrb21paGg3RGFnd3dhNGZpMGwxNUFBSjIreE1KU2ZXMlBKUitv?=
 =?utf-8?B?WmtJQmsvbWUzblArUjFlVHNDZGlNc0hKelh1QnpOQVFyY2p4bWllNUxIUjFN?=
 =?utf-8?B?ekxtMHZ2UEtMQjBUMkhxQXExOW54THpWQXZTYWh4M0pPRWtUS0RWcFlnbzlr?=
 =?utf-8?B?UGVReGtuMklLU3V1T0FmeWpuQzUvcXlSOThEUTVFd2I2dVUyMlJLUXcyYkJH?=
 =?utf-8?B?UkhhV2w1aWhRRlFuMU4wQjRNY2FKSmd3dlRvZSs4TGVxa3kyT2tQQ3RONTY2?=
 =?utf-8?B?S0p3SmFKdkxYTWxQdTd6Q3BLck9Pb3VZVHdKeGtFdEVTQ20xaDhOMWRsakEz?=
 =?utf-8?B?ZzB1V09pSFBlYnJQRVZwNVhiMHN5dFo2WEt1Tm1BdUpWYTRtSmppZkYvNXI5?=
 =?utf-8?B?Nld3WUtaQ2tpNXBmUU05T2N2TjJrLzVzSU5FaW5FS01SK2g3bFFUdlpTQnp1?=
 =?utf-8?B?REhia0VSK2pDaXBzT1ZJUmdVQjllVFJ4ZUwxUk9UNGd2Zzl5Y2NNSk5xSkR3?=
 =?utf-8?B?MkxrQ1pGTXI0OUNVQWcvbzdJdDV4Rm1hZGFzdzlzamlLVWN3QlEwNUtqaEE0?=
 =?utf-8?B?M01jYjdsRDNzUFhWNUgxUTQycU5SRGgvcVU2YjIwalA4R3VZamVyaDlHeTNE?=
 =?utf-8?B?N09TVlJNUUJLdzVQTVpodEF5YXIzNVVwWEZLNmFZc2Z2ZlRzYmFnamVub0d1?=
 =?utf-8?B?VGxpb0hrM202bGZLcGpTL09GY0Y2WlcvWjQ2ek42U0Z0T29QZ0lCR2xlRWJk?=
 =?utf-8?B?L3JPMFA0NFMrQVNGZXJMcUw3M2ozWUVvaVFZSnFzcEllMWpXbFZoUDVMbXcx?=
 =?utf-8?B?VUlCS3NGN3ZSUVBYaWI4ekJGc2lqTGlnQWRidkE4azdwN0hwK2YvbW5aQjhr?=
 =?utf-8?B?ekNlS01UbXo3OXlmN1BISUovMzg5cjdZYXNmREhGY0YweXUxSkI2bERoYjlO?=
 =?utf-8?B?c3JvRFRHcm9GZ2U1ajhuS2tEVDNUbWlOaE4zYWxEWC9ZdlFhWmwxWGc5K3Fh?=
 =?utf-8?B?YkRBcmZOVnZlSEJHVkRWeFJEWDVyNGZmbUFQNm9JcDdWODdUdjl6Q3Z3M3Za?=
 =?utf-8?B?ZmN0Yy9sTzVyV05MelJQSUZEclIza1Rkb2pxSStNWC83bUdyR2ZJS1JkQ2FT?=
 =?utf-8?B?NTFjeVFxMjQ0c25acFNNTzc2Rk8xVzNDNEhkOGorYXhsTmJYVVMwR1huenRU?=
 =?utf-8?B?SXFoUFI5N0tkVzQwUnJOVXVYUW9FVC9jWlV5U3lCcGxNWjByS2Faamc2c3Vh?=
 =?utf-8?B?WXdSNWVHQkxRbmE3aktwSUxQWXJlNVFZSzZiVW5DUENxK2RyR2kwNXJlUXJv?=
 =?utf-8?B?aW1EUHRraEpiMVlrWUUycldqMEVieTZJdWVRM0lTYVk0cDRSb2NEYWpaU1Bl?=
 =?utf-8?B?RU40ZXlqVUllZVBpSWR5NW5UZThvVUNSSjlWb2hWTytJMnJvdE9tTnBEZ1BP?=
 =?utf-8?B?c3gxSUkxMVl1eU5Za3I5V040OE9lb1AzOU42MHpMSlIzZndGOVNkWjVCYnRD?=
 =?utf-8?B?My9uWWRLUW9peVVUM29qRFRIUmtMeGhxcWZseXZVTGxDbEJ1cFIyN1hKMEFN?=
 =?utf-8?B?QUZWNmZLMkdxSW9tdE8xeE9MU3ppbVgxUm0vck85VDlmTWxYd1VuWGVtbm84?=
 =?utf-8?B?Qjd3aUpmY1lYSlBHRHN0K0REVjU5c1Bhc3l1b0xzcTJJQUxRRUNnSmtQZ3l6?=
 =?utf-8?B?T1A5Sm42T0hpMlUvZkR3MVJDUzZ1dzM5Uk1YWWhsYjZOQkdUVmkyYXFNeUxt?=
 =?utf-8?Q?uMEI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4de15a-597e-45bb-48b9-08dd05468eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 07:24:35.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRQOBUG1VKp5y7Hd0Z7AjnvveurrJv+jfcapU47jPay2shc/d/ehxfkNxJkVTcvZreSgJd98su+sOrMmBY3jTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8617

SGkgU3RlZmFuLA0KDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBTdGVm
YW4gV2FocmVuIDx3YWhyZW5zdEBnbXgubmV0Pg0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQxMeac
iDE15pelIDE6NDANCj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3Mu
bnhwLmNvbT47DQo+IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb207IHNoYXduZ3VvQGtl
cm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgZmVzdGV2YW1AZ21haWwuY29tDQo+IOaKhOmAgTogaW14QGxpc3RzLmxpbnV4LmRldjsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDkuLvpopg6IFtFWFRd
IFJlOiBbUEFUQ0ggdjVdIHNvYzogaW14OiBBZGQgU29DIGRldmljZSByZWdpc3RlciBmb3IgaS5N
WDkNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtl
IGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVu
IGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhpcw0KPiBl
bWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gSGkgQWxpY2UsDQo+IA0KPiB0aGVzZSBhcmUgdGhlIG5l
dyBjb21tZW50cw0KPiANCj4gQW0gMTEuMTEuMjQgdW0gMDQ6MjMgc2NocmllYiBhbGljZS5ndW9A
b3NzLm54cC5jb206DQo+ID4gRnJvbTogImFsaWNlLmd1byIgPGFsaWNlLmd1b0BueHAuY29tPg0K
PiA+DQo+ID4gaS5NWDkgU29DcyBoYXZlIFNvQyBJRCwgU29DIHJldmlzaW9uIG51bWJlciBhbmQg
Y2hpcCB1bmlxdWUgaWRlbnRpZmllcg0KPiA+IHdoaWNoIGFyZSBwcm92aWRlZCBieSB0aGUgY29y
cmVzcG9uZGluZyBBUk0gdHJ1c3RlZCBmaXJtd2FyZSBBUEkuIFRoaXMNCj4gPiBwYXRjaCBpbnRl
bmRzIHRvIHVzZSBTTUMgY2FsbCB0byBvYnRhaW4gdGhlc2UgaW5mb3JtYXRpb24gYW5kIHRoZW4N
Cj4gPiByZWdpc3RlciBpLk1YOSBTb0MgYXMgYSBkZXZpY2UuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IFRlc3RlZC1ieTogQWxleGFu
ZGVyIFN0ZWluIDxhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tPg0KPiA+IFJldmlld2Vk
LWJ5OiBTdGVmYW4gV2FocmVuIDx3YWhyZW5zdEBnbXgubmV0Pg0KPiA+IC0tLQ0KPiA+DQo+ID4g
Q2hhbmdlcyBmb3IgdjI6DQo+ID4gICAtIHJlZmluZSBlcnJvciBsb2cgcHJpbnQNCj4gPiBDaGFu
Z2VzIGZvciB2MzoNCj4gPiAgIC0gcmV0dXJuIC1FSU5WQUwgd2hlbiBhcm1fc21jY2Nfc21jIGZh
aWxlZA0KPiA+ICAgLSBmaXggdGhlIGJ1aWxkIHdhcm5pbmcgY2F1c2VkIGJ5IHByX2VycigiJXM6
IFNNQyBmYWlsZWQ6ICVkXG4iLCBfX2Z1bmNfXywNCj4gcmVzLmEwKTsNCj4gPiAgIC0gZHJvcCB0
aGUgcHJfZXJyIGluIGlteDlfc29jX2luaXQNCj4gPiAgIC0gZnJlZSB0aGUgbWVtb3J5IGluIHRo
ZSByZXZlcnNlIG9yZGVyIG9mIGFsbG9jYXRpb24NCj4gPiAgIC0gdXNlIG9mX21hdGNoX25vZGUg
aW5zdGVhZCBvZiBvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUgQ2hhbmdlcyBmb3INCj4gPiB2NDoN
Cj4gPiAgIC0gZml4IHRoZSBidWlsZCB3YXJuaW5nOiAnaW14OV9zb2NfbWF0Y2gnIGRlZmluZWQg
YnV0IG5vdCB1c2VkDQo+IFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dDQo+ID4gICAtIGFkZCBU
ZXN0ZWQtYnkgYW5kIFJldmlld2VkLWJ5DQo+ID4gQ2hhbmdlcyBmb3IgdjU6DQo+ID4gICAtIHBy
b2JlIGlteDkgc29jIGRyaXZlciBhcyBhIHBsYXRmb3JtIGRyaXZlcg0KPiA+DQo+ID4gICBkcml2
ZXJzL3NvYy9pbXgvTWFrZWZpbGUgICB8ICAgMiArLQ0KPiA+ICAgZHJpdmVycy9zb2MvaW14L3Nv
Yy1pbXg5LmMgfCAxMjQNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMjUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL2lteC9zb2MtaW14OS5jDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvaW14L01ha2VmaWxlIGIvZHJpdmVycy9zb2Mv
aW14L01ha2VmaWxlIGluZGV4DQo+ID4gM2FkMzIxY2E2MDhhLi5jYTZhNWZhMTYxOGYgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvaW14L01ha2VmaWxlDQo+ID4gKysrIGIvZHJpdmVycy9z
b2MvaW14L01ha2VmaWxlDQo+ID4gQEAgLTMsNCArMyw0IEBAIGlmZXEgKCQoQ09ORklHX0FSTSks
eSkNCj4gPiAgIG9iai0kKENPTkZJR19BUkNIX01YQykgKz0gc29jLWlteC5vDQo+ID4gICBlbmRp
Zg0KPiA+ICAgb2JqLSQoQ09ORklHX1NPQ19JTVg4TSkgKz0gc29jLWlteDhtLm8NCj4gPiAtb2Jq
LSQoQ09ORklHX1NPQ19JTVg5KSArPSBpbXg5My1zcmMubw0KPiA+ICtvYmotJChDT05GSUdfU09D
X0lNWDkpICs9IGlteDkzLXNyYy5vIHNvYy1pbXg5Lm8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zb2MvaW14L3NvYy1pbXg5LmMgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlteDkuYw0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uNGVmOTIyNjBlOGY5DQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OS5jDQo+ID4g
QEAgLTAsMCArMSwxMjQgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjArDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAyMDI0IE5YUA0KPiA+ICsgKi8NCj4gPiAr
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9hcm0tc21jY2MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L2luaXQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+
ICsjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc3lzX3NvYy5o
Pg0KPiA+ICsNCj4gPiArI2RlZmluZSBJTVhfU0lQX0dFVF9TT0NfSU5GTyAweGMyMDAwMDA2DQo+
ID4gKyNkZWZpbmUgU09DX0lEKHgpICAgICAgICAgICAgKCgoeCkgJiAweEZGRkYpID4+IDgpDQo+
ID4gKyNkZWZpbmUgU09DX1JFVl9NQUpPUih4KSAgICAgKCgoKHgpID4+IDI4KSAmIDB4RikgLSAw
eDkpDQo+ID4gKyNkZWZpbmUgU09DX1JFVl9NSU5PUih4KSAgICAgKCgoeCkgPj4gMjQpICYgMHhG
KQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBpbXg5X3NvY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KSB7DQo+ID4gKyAgICAgc3RydWN0IHNvY19kZXZpY2VfYXR0cmlidXRlICph
dHRyOw0KPiA+ICsgICAgIHN0cnVjdCBhcm1fc21jY2NfcmVzIHJlczsNCj4gPiArICAgICBzdHJ1
Y3Qgc29jX2RldmljZSAqc2RldjsNCj4gPiArICAgICB1MzIgc29jX2lkLCByZXZfbWFqb3IsIHJl
dl9taW5vcjsNCj4gPiArICAgICB1NjQgdWlkMTI3XzY0LCB1aWQ2M18wOw0KPiA+ICsgICAgIGlu
dCBlcnI7DQo+ID4gKw0KPiA+ICsgICAgIGF0dHIgPSBremFsbG9jKHNpemVvZigqYXR0ciksIEdG
UF9LRVJORUwpOw0KPiA+ICsgICAgIGlmICghYXR0cikNCj4gPiArICAgICAgICAgICAgIHJldHVy
biAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAgICBlcnIgPSBvZl9wcm9wZXJ0eV9yZWFkX3N0cmlu
ZyhvZl9yb290LCAibW9kZWwiLCAmYXR0ci0+bWFjaGluZSk7DQo+ID4gKyAgICAgaWYgKGVycikg
ew0KPiA+ICsgICAgICAgICAgICAgcHJfZXJyKCIlczogbWlzc2luZyBtb2RlbCBwcm9wZXJ0eTog
JWRcbiIsIF9fZnVuY19fLCBlcnIpOw0KPiA+ICsgICAgICAgICAgICAgZ290byBhdHRyOw0KPiA+
ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgYXR0ci0+ZmFtaWx5ID0ga2FzcHJpbnRmKEdGUF9L
RVJORUwsICJGcmVlc2NhbGUgaS5NWCIpOw0KPiA+ICsNCj4gPiArICAgICAvKg0KPiA+ICsgICAg
ICAqIFJldHJpZXZlIHRoZSBzb2MgaWQsIHJldiAmIHVpZCBpbmZvOg0KPiA+ICsgICAgICAqIHJl
cy5hMVszMToxNl06IHNvYyByZXZpc2lvbjsNCj4gPiArICAgICAgKiByZXMuYTFbMTU6MF06IHNv
YyBpZDsNCj4gPiArICAgICAgKiByZXMuYTI6IHVpZFsxMjc6NjRdOw0KPiA+ICsgICAgICAqIHJl
cy5hMzogdWlkWzYzOjBdOw0KPiA+ICsgICAgICAqLw0KPiA+ICsgICAgIGFybV9zbWNjY19zbWMo
SU1YX1NJUF9HRVRfU09DX0lORk8sIDAsIDAsIDAsIDAsIDAsIDAsIDAsICZyZXMpOw0KPiA+ICsg
ICAgIGlmIChyZXMuYTAgIT0gU01DQ0NfUkVUX1NVQ0NFU1MpIHsNCj4gPiArICAgICAgICAgICAg
IHByX2VycigiJXM6IFNNQyBmYWlsZWQ6IDB4JWx4XG4iLCBfX2Z1bmNfXywgcmVzLmEwKTsNCj4g
PiArICAgICAgICAgICAgIGVyciA9IC1FSU5WQUw7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGZh
bWlseTsNCj4gPiArICAgICB9DQo+IEkgbGlrZSBpdCB0aGF0IHNvYy1pbXg4bS5jIGhhbmRsZXMg
dGhlIGNvcm5lciBjYXNlDQo+IENPTkZJR19IQVZFX0FSTV9TTUNDQz1uIGluIG9yZGVyIHRvIGlu
Y3JlYXNlIGJ1aWxkIGNvdmVyYWdlLg0KPiANCj4gSXMgaXQgcG9zc2libGUgdG8gYWRhcHQgdGhp
cyBkcml2ZXIgYWNjb3JkaW5nbHk/DQoNCkN1cnJlbnRseSwgaS5NWDkzIGFuZCBpLk1YOTUgb2J0
YWluIHNvY19pZCwgcmV2aXNpb24sIGFuZCBzZXJpYWxfbnVtYmVyIHVzaW5nIFNNQyBjYWxsLiBX
ZSBkbyBub3QgcHJvdmlkZSBhIHNlY29uZCBtZXRob2QgbGlrZSBpbXg4bXEuDQoNCgkvKg0KCSAq
IFNPQyByZXZpc2lvbiBvbiBvbGRlciBpbXg4bXEgaXMgbm90IGF2YWlsYWJsZSBpbiBmdXNlcyBz
byBxdWVyeQ0KCSAqIHRoZSB2YWx1ZSBmcm9tIEFURiBpbnN0ZWFkLg0KCSAqLw0KCXJldiA9IGlt
eDhtcV9zb2NfcmV2aXNpb25fZnJvbV9hdGYoKTsNCglpZiAoIXJldikgew0KCQltYWdpYyA9IHJl
YWRsX3JlbGF4ZWQob2NvdHBfYmFzZSArIElNWDhNUV9TV19JTkZPX0IxKTsNCgkJaWYgKG1hZ2lj
ID09IElNWDhNUV9TV19NQUdJQ19CMSkNCgkJCXJldiA9IFJFVl9CMTsNCgl9DQoNCkJlc3QgUmVn
YXJkcywNCkFsaWNlIEd1bw0KDQo=

