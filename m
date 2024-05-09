Return-Path: <linux-kernel+bounces-174427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D7F8C0E86
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48129B21EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBB31311B5;
	Thu,  9 May 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="H3SfgVMH"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2139.outbound.protection.outlook.com [40.107.6.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98012EBC8;
	Thu,  9 May 2024 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251759; cv=fail; b=Za1RuZvzS5fR9GINH3zNYlVJHGUpiOa7Kfv7XhB8712zD20OvUteyVnCoTpXl65M6YrqYa3rcUMrKSLxKfd68CHn4pb82qorEdL4PmBMmQeUVaERCDwEpdQI534E1ypPIGWxPda8DNJLfjGOG5nFD9kA24JNgb7IQs4OxcMbYq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251759; c=relaxed/simple;
	bh=BP9MTIY013ZlJH/HYm58SUBjvUIpmeBXGDQGTUBEGL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFhrk9U3LmU39HS6dCi/WdEzKYdR0DeVkM0aCrRahcUL2K2pWVotIYHDd2TZDSwMV7SoJL5vOC8Locv6qHANYHbOMBcyFnZXO6wZBBel0mP51YeAhIMZs+WFOA0pVJq9NbmoA6SWJtY2sKCjsIu0G34/sk5joLjnc7TNXdKCSFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=H3SfgVMH; arc=fail smtp.client-ip=40.107.6.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZGgg/N4gJeHm6tUB2Im7lhYiVpjpZZ10p94XMwCqxzuIih1/qTDbFJ/7lF8W7zJwNSwDW/W/PBc7cCRLKFk7NnbT+z4IJ8nNvm6psax5P/E5ZBXlDT5d4l+U3YEYOcMauBPwXl6W5f6Drbm0b16j7p3PcRzoAXuFbagwehSqgi2gaYxfeL3WviQedhkCS2uBhsjIFGqTViEVdycivVwMoFJDAR9xzemkYzLeDq58Gs7vcgQxvfwPYpcNQGCAaDr2PBX7lbeuynAD9lJaG0vyHxne9RyMXisSlFBjIqYsmnL31xrG0aJZufTTXurJhsfSATFc9A9kWi/Pwwe4DnXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP9MTIY013ZlJH/HYm58SUBjvUIpmeBXGDQGTUBEGL8=;
 b=e3btGNyNxM3zmZHwW9xduOos+hc997Wv8tj9JRMMRCQv+bvuqwW+jIdUGdYJ0vT6s0OkfnUySyeUCyK6Inf+sgSVEjeGhOFj/PRGT4y5Oo46C5MIZ2EqM4+cVe9pVD+sReGIUozCuiUSNs0WBrhfw3Xr9Jm019C5YTy2Ha0wLGKksW7moCcBdz6pyVW10n4ZdyjADtAkGh63BBMZbjGAzzVFvKD+cgElZzUGhe4m3Z5bybFUH63joNZP1YaPblzyojrEJNMH2+rCMUV192iv+2QIVjZ1frAIDp7X3kJe7Xzi6+GvER8KANjedm1LMGlt3SeGF5gZ3kIBItPWXWu3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP9MTIY013ZlJH/HYm58SUBjvUIpmeBXGDQGTUBEGL8=;
 b=H3SfgVMHaLtGV4f2DK5sdJs1wP4b/wb5Dx3I8Z11RrJOZ7k4OCg9dneTzf/g01izaal8xiQlueXPi/FYJToVGGBnI5rf90EAhOOn+phMayqtW1MfmRsbqkuVN1+tJH1v+xWYjCyKHxSNqn7MN3IK/kyWDoR4psECZJs8FzGpBc4=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VE1PR04MB7407.eurprd04.prod.outlook.com (2603:10a6:800:1ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 10:49:13 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 10:49:13 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Thread-Topic: [PATCH v5 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Thread-Index: AQHaof4bfE9Ueli+tk+h7rTggD3oW7GOuREA
Date: Thu, 9 May 2024 10:49:13 +0000
Message-ID: <5da207e2-1579-4056-9e3f-c25f5b14e225@solid-run.com>
References: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
 <20240509-cn9130-som-v5-2-95493eb5c79d@solid-run.com>
In-Reply-To: <20240509-cn9130-som-v5-2-95493eb5c79d@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|VE1PR04MB7407:EE_
x-ms-office365-filtering-correlation-id: 3855a3cc-5567-4e25-24fd-08dc7015aa37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejM3QkhseFpKWm4xcmN3c2RQV1pYbVNjVnZnUFA2MUduV1JYRkYzNXdYNCtJ?=
 =?utf-8?B?RFM3M0l2elNPVmtYS2Q3U2dnSnhBdUk4aTlDS25FaExFcGtHWUQ0NEwrcmpn?=
 =?utf-8?B?d2UwTkVyQTVYUlZCYlAxL0FyV09qYjIyTDcrWGx3aFBNTnJPM3FLQm5zV1dY?=
 =?utf-8?B?MWNtbllzMVNNQ2djSDhXMHJpMmNNWTAzQWdNam9mZVdlQzhoN29Ia0lyaWpV?=
 =?utf-8?B?N0ovZExYSDd5Z3Zoa1FVbjFIN1p2cyszdkUzeTFIMUZPWW5uNnZRYjREWlZq?=
 =?utf-8?B?Q3VJNnYyTGt6MlRKZCtMY0tLeDF5OHlUYUVpTVlqb2RJbkpzcEVkSlRlKysx?=
 =?utf-8?B?NXExMWt5Ukl4N0VqcWpyWXNCaTJvZHlZNHh2S1prbzB6bE9JNE5OalVIeFNM?=
 =?utf-8?B?SXNEZ3FhTlpJS3FKSUZhOWJuYXpLTjdyai84amV6VCt4cnVORTNPdlBxOXhv?=
 =?utf-8?B?ZHRsRTJOdVVOclhZTjk4Tlk1cGg2SElWWXRDb05KaVBxcU8wWEl4Q2Ryb294?=
 =?utf-8?B?RklrQm03TGtoc29uRjJ0U1pjcDJJak8xZktpbjRWVEE2aGM5N1hwdXY2cXc5?=
 =?utf-8?B?OWwxajJ1NlpIbU8zUWtmYllXaVlZbkZEZGlGVFRELzYvRndHRmFwRHJXR1Bt?=
 =?utf-8?B?K2ttTXhHS01FeXZlT2lKcXpQTGZNUE9uTE9ROE94cDY2TjN1WU9VRi9rcW8v?=
 =?utf-8?B?d3dZWGRhbjRweXZkOVo4UFhPcUp5a1J0NUhEOTJReVRVU1NWZk1kZ2VUU0Ny?=
 =?utf-8?B?MkpiNnlQWmdRd1JqYkhFT2JKakZHakN5MjV4QjFMOHNranB0ZkI4OTM1RlF5?=
 =?utf-8?B?R3pCdm53WG5CbGlBMkJVN2ZCb0xkemtOQ29RQ3ZOMEt4SVA4MjROT1dTemF4?=
 =?utf-8?B?RHI1UEpvNkM3LzdkSENWalRWb1RkRXYwN1BaMXNCQXRWc2haQS9VY3FsTEVa?=
 =?utf-8?B?UU9pQnlpb0lYcFU3OXYvWVd5eVR1eTRVQ3BCQ3h5SXNGYmtBMkZyL0dHdGRE?=
 =?utf-8?B?MmtsQVhhZ3QxVTZaU0UzR1NIelpLVXlJOUtWRXJlWmpoYUxPaiswL2ZWZjk2?=
 =?utf-8?B?UitOZmZ4Y3F6aUxXVkU4ZnJrdzUyaEc4N1pNSC9jb2Q4OTljdFhFcjBxeEdm?=
 =?utf-8?B?S3R2WmFPUzVRdFJONEVvaHZmaWw1a0NwTnplMFlLc3hpRFF2bXYzNGg1aStZ?=
 =?utf-8?B?NC9jOGtPdmJ4Mk5LOVkveExlbnh6bTZNZ3pOemNxLzJZd0xtUUNYWWRLR3dX?=
 =?utf-8?B?QldSeXZucFhLaEtRRkFuNDBsL1JET1VYS1I0c09MZW9PSWxlNGdwakZhc1hu?=
 =?utf-8?B?WUFZU1hWczBDOEl4dGc1enhXTUpLakI2Y0htS1NVOFM4UnhTZ205dDJQYVRm?=
 =?utf-8?B?QW9LK1gzb3FtbkRma29leHp5R3JuaTIyNzJ6cVpQeDhpVjdwZVgzVCsxaFhs?=
 =?utf-8?B?TUVKUHROU2VDMytWNTI4cXVob0tYMERHeUJrSlJpK3dkMllMcDAyMlFjdDZx?=
 =?utf-8?B?REFOMi92UWpmZkFuZ1M1di9lT280R2pvVzZ0Z21FN2QzbW5HWndlOGpuVngz?=
 =?utf-8?B?U09hNTIwRUVaM0UxMEpQdkNPNHFpckJpclFZa29wRjgzb1FLQnNkVGlGNkx4?=
 =?utf-8?B?dTNlYWI0OVplbGwxczYzOER1VjNBWXVYcEZ6TjU3SCtsdlNteHk3ajdSU0RF?=
 =?utf-8?B?WG1sNGRzTDVPcW10NXB0azFpUmQ5WE5wTytxQmRmaTRuUmd0K1N1dTZtWlBV?=
 =?utf-8?B?MWUrSUlKU3J5bURBZTl3VkVGMW1nZFlyVmRPSU96ZTQxWklLMzg0VzZpNkZV?=
 =?utf-8?B?ZUUrYVhGcmZSV1BXNTNHdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjJ1M1E1SEZQbm1Jb3N1ZWJzNUR3T0RUOWdObzJETVJXMy83UGhsSWhxWlpB?=
 =?utf-8?B?SG9iYm1nZFFXTFhiek9INE5NVmhsejJ4dlhvdGYrejZ2b3AxNk1ra214Q1g3?=
 =?utf-8?B?aFhLWWh4T2dhVXFLUTd3dlNWNU52REdkTFdVZnovR2M5UUZjb1VtTzZmVnYy?=
 =?utf-8?B?c3o3TFBHUWpvcjFNTENNTzVlSzdBRFYxaFREaG9rc3dlTXhrY3VKK0cwT21z?=
 =?utf-8?B?Tm00SWRIOFI1b0JDODA3b1hjZGE5bVprYkk0WU5ZVDZsOFZCNVVXR3hXaFAv?=
 =?utf-8?B?dk9xR1VoRlFGL1FPQUpKNUowQnozTitrK3JJVThBV0pMQlZKVzJSKzRsdjJZ?=
 =?utf-8?B?aWRQM2FDTXR4REZGNEZUUURkeXNMUUc3NnI5aHlHZkFkVDg2MWtsZC8ySkNq?=
 =?utf-8?B?QllZWGc3UWFXV1dvK04xeUJHbG5STWgxMllWcDYzdnBZS3NiL05sRnZnUm82?=
 =?utf-8?B?TzFHYWxHcWYvK0hxejk2Qk5WMStLeTdIUHJoUGh5UGYwUUczVmZ3UitXczNo?=
 =?utf-8?B?UjhZa3pHdnNlek1LV3BqbHdQT2Jxc05FczcwUGVtNzExWTVSdFhYVkhEdm5t?=
 =?utf-8?B?bGZick5lbXhkNDZhK3BuWmNyQ3JtOTZyUTM4YWc5WnRwbjFRL1RDWm5qVm42?=
 =?utf-8?B?cEFIc1piZk9GYi9selE4MFVRNlhja1N6ZFdKdWZNYUlhTjc3bms1bFppZGw5?=
 =?utf-8?B?bXFPaTYzdVdLN1hmU3drM2dGRjVyNWVqMXlmUGcyTzRJU1gvRlY3djBZUitu?=
 =?utf-8?B?MVpZQi9RUWI0bW9pZis3Z092VDFzYllPVnpxK0VWTmVvVXhYTG9FMzk3TVZV?=
 =?utf-8?B?OWN6b0R1Y016U1RzWEEzalBCdzNFamo2OHBvTmlsV0JXb1ZTclBxd2RxSUhL?=
 =?utf-8?B?MVY4VjZ3MU9PQjRmc0Y3Q1RDaVNhL1Z1K3RocDJ2d2FoV2dnMDRlczFabkdu?=
 =?utf-8?B?Qkk5T0U3dHliZ1VCYjZZVUVpbi8xWS9FVDN0U3BjVkZwNDk4Y0ViWkY3bjFK?=
 =?utf-8?B?MThGRmRUcUlNdkNjdmNZTHJJZGNxRGM0a29kN25iRHFQYnk0Kys3VU9aclJE?=
 =?utf-8?B?S2xVNGtvV3U1c1lxcmc4S2wxeE1FaEM4ZHNoQjdReTFGVDRJdU5lQ1Q1cFI4?=
 =?utf-8?B?N0pTT0dVM3d5UjdMY2lpL1h4ZVNRYVVwOXZRUnNyQ0lGZlplWWFJR1hsVnZQ?=
 =?utf-8?B?dlBieVRma1lkNjBtc0xzS2hmeXI2K2ZndVRLTUJ6MnYwOFpnaDhSRzQ5eVJU?=
 =?utf-8?B?SUZYR0NxcmRZbnFQWXNWcXZYbXZOa0ltZ0lvdkRPOEYwWFdyd1ZoaGhMeDlQ?=
 =?utf-8?B?QUQ2aDlTUHFmaWp1M2xvUHlVVDBSOUp0MEptSGliTXNpV3NjSm5rbTR5V0pS?=
 =?utf-8?B?d1M2bzN2UGxwR1p1bStNMVVDc1pSVFFuUjJKc252NWFKeU12dE1Mdk5nMnBz?=
 =?utf-8?B?SDZMSUpvSXZzaWk5cmtVSlM4VThpaVYxWHcxS2IzRnVESENDaCtEQlFFQ3Jr?=
 =?utf-8?B?b2IzSkk5anNXQkZkdUU3V1JoTmpCQkdrWWkzK01iVU9qTzBFMFJteEd6eWJX?=
 =?utf-8?B?eng5dTRBUUJvb2ZMMWVYTG5kWXc1OTN3TXpJTEU2UzlSN2grMTNtYmRrbWQ5?=
 =?utf-8?B?aFJJdHh4WFV1aWdxT29xUHdCaDJIU1NwNkxVazgxUERZYmhyNnJLL0JNT0V0?=
 =?utf-8?B?czd5NUZ0bUZPSlNBUURBK1VodGpKcGtwVnhxNEVKTWRHU1F3aGJraVAxNjZ3?=
 =?utf-8?B?akFFbXhQNW5mcmZ4Qzh1R005Q1JJRHNZcWNvcjJnYWIwOHYyaTV0YW1ad2tM?=
 =?utf-8?B?TnFKN1MvN2pxaWxmL0Vpdyt2dHUxMlV4K3RmcWdHVk9xMDlnZFIrRFZRRVpN?=
 =?utf-8?B?c1ZyRjZ3ZkVFbGt4MWpQUThCKzlHME5VOGdUNmJZSWE4eUdRSlZSbXhPd3p4?=
 =?utf-8?B?NmZtdHVFZVloK1A2MHgvZDRWNzdNakhQUVY5R01DTVpGVXZRSG94ZjE4NnFk?=
 =?utf-8?B?ZEREK29PUjhGd0x2T0RxNFJUSUhPTmlodkphL1Z5QytrK3NxTVAwRnYrcitC?=
 =?utf-8?B?c3BaU1ExeFpUU0N4SlVqamdUbjRkMW81bXBQMFh4clN2NENNcFhTcUd3bGx4?=
 =?utf-8?Q?Orgs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28C160BA890C3445B5733170DA0EBFEA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3855a3cc-5567-4e25-24fd-08dc7015aa37
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 10:49:13.1729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /E85jQ9t4WomxhGAuFWu8RZ7okQgO7TIZFHNznXuM6MhYd1RL9xV5ueIaBQMfeGuOsTNsBNWVocwh5WP+Cyocw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7407

QW0gMDkuMDUuMjQgdW0gMTI6NDYgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gQWRkIGJpbmRpbmdz
IGZvciB0aGUgU29saWRSdW4gQ045MTMyIENPTS1FeHByZXNzIFR5cGUgNyBldmFsdWF0aW9uIGJv
YXJkLg0KPiBUaGUgQ0VYIGlzIGJhc2VkIG9uIENOOTEzMCBTb0MgYW5kIGluY2x1ZGVzIHR3byBz
b3V0aGJyaWRnZXMuDQo+DQo+IEJlY2F1c2UgQ045MTMyIGFuZCA5MTMxIGFyZSBqdXN0IG5hbWVz
IGZvciBkaWZmZXJlbnQgZGVzaWducyBhcm91bmQgdGhlDQo+IHNhbWUgU29DLCBubyBzb2MgY29t
cGF0aWJsZXMgYmVzaWRlIG1hcnZlbGwsY245MTMwIGFyZSBuZWVkZWQuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPiBBY2tlZC1ieTogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBSZXZp
ZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiAtLS0NCj4gIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1hZGEtN2stOGsueWFtbCB8
IDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9h
cm1hZGEtN2stOGsueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
bWFydmVsbC9hcm1hZGEtN2stOGsueWFtbA0KPiBpbmRleCA3NGQ5MzVlYTI3OWMuLjUzOGQ5MWJl
ODg1NyAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9tYXJ2ZWxsL2FybWFkYS03ay04ay55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1hZGEtN2stOGsueWFtbA0KPiBAQCAtOTIsNCAr
OTIsMTIgQEAgcHJvcGVydGllczoNCj4gICAgICAgICAgICAtIGNvbnN0OiBzb2xpZHJ1bixjbjkx
MzAtc3Itc29tDQo+ICAgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxjbjkxMzANCj4gIA0KPiAr
ICAgICAgLSBkZXNjcmlwdGlvbjoNCj4gKyAgICAgICAgICBTb2xpZFJ1biBDTjkxMzIgQ09NLUV4
cHJlc3MgVHlwZSA3IGJhc2VkIHNpbmdsZS1ib2FyZCBjb21wdXRlcnMNCj4gKyAgICAgICAgaXRl
bXM6DQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiArICAgICAgICAgICAgICAtIHNvbGlkcnVuLGNu
OTEzMi1jbGVhcmZvZw0KPiArICAgICAgICAgIC0gY29uc3Q6IHNvbGlkcnVuLGNuOTEzMi1zci1j
ZXg3DQo+ICsgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxjbjkxMzANCj4gKw0KPiAgYWRkaXRp
b25hbFByb3BlcnRpZXM6IHRydWUNCj4NCkl0IGFwcGVhcnMgSSB3aWxsIG5vdCBiZSBhYmxlIHRv
IHN1Ym1pdCBhY3R1YWwgZGV2aWNlLXRyZWUgZm9yIHRoaXMNCmJvYXJkLiBUaGVyZWZvcmUgd2hl
biBhcHBseWluZyB0aGlzIHBhdGNoLXNldCwgaXQgbWF5IGJlIHNraXBwZWQuDQoNCkkgYW0gbm90
IHN1cmUgYWJvdXQgdGhlIHBvbGljeSBpbiB0aGlzIGNhc2UsDQppZiBpdCBpcyBiZXR0ZXIgdG8g
cGljayBvciBza2lwLg0K

