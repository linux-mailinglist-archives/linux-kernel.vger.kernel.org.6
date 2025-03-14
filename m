Return-Path: <linux-kernel+bounces-561639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A052CA61472
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D564A46303B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA412010E3;
	Fri, 14 Mar 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sto4V+UI"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B637D3B7A8;
	Fri, 14 Mar 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964570; cv=fail; b=KBXsKtyzKhShoktth7Sk4ufTtIv9c9MZ/V3gnEqMfC299K7s1lexea4Z/RRP2NnK/of2q9bgveWGVqaHsiNnGWNyPd90xv5WEcYt3RlpVlIJfVLSxZyVxuwnr3gr7tbqeK+ons2S0hGP5BLQ+6PldLwibjZExQ1Kw5csFtB7uXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964570; c=relaxed/simple;
	bh=hDzqQQN0ZDZ9mEZIt+2caUKm6QIf/XkMgB4Lwxdz5uY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s6aol1+ispOfl+XxRmMcnuNvsZu7crzNd8P8CCncaUeqWTmXBb78YvIQYYp4vHlDWW5PpipWsb9saAMNIajsIjOujZUWjfGWqajXQAncwa7mr7TQcMS4+gVwQECl0kE0Yj8Y9qSBRblODhYdFIzlCIOAHT6Hj5XlV00p02OqAI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sto4V+UI; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veZQTOk0uvHsMKHxPdjYaeLNSWAMYMMbnvIhjGsyPAU/WUT2fZ0epP56YGLdGeOiqBXMZA9R5X7zOtt0u+9tnkm76+tOAg0ia4pWmvfBwomBA4vbqpI9VaYXMKtnYyHvnZ7Tyu7yNV4veWOEW+75M+0YEhE3GxZxIWX7G5Y8PNzCLdOzyUvd52aK6VXfwLiisDN6yVGj4WQDMCq2fS8CSY+8SYDfbZE9yGGVP3aL6X97r793z/FFiN07cQdoi8Rk4mCIpwrqdizHGc/5AsqJt1/a5BsefvdvPKttQKIDGF7L4ySBxiPQxENV8lY05WBwMoUVHo+NJSXzF22KROEwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDzqQQN0ZDZ9mEZIt+2caUKm6QIf/XkMgB4Lwxdz5uY=;
 b=XBwOuugrnq/XlVRt25uSk/HyHwWd2FlO8RGgCHKtvR3b4jbm+2H9ZhmUQej1701CuTgTip19MVC3GrocpuDcu9lzNz2aK1K+13e/WNJJ7+/Q4Y0ZVETb74HgY9Y6emn8tTiK5GfuKylBS86PJqeF8k5FwgXlWSytg0fdOlqJ9GAnNtTPuAbI9YmfyXlK8d/Xd7LK8L2zL7ChB+uyeEo86uA89kU1BU6zw8jsY9WvxOtEZrjuZLbmeW7xptTUlXTYdGc3vUTJIdTd6VvRv8pRaonib4sD5olGKsFnYh9dXNQ+VIJM6AQR3syjEv1niZtwGLHiXjyDQfiDMBl2swVnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDzqQQN0ZDZ9mEZIt+2caUKm6QIf/XkMgB4Lwxdz5uY=;
 b=sto4V+UIcSOypF5rq98/0lYPzDyWDu1xuEutN92AqASocdhUEwyjPWQxKmJFcKxULAeCX3uqZRHg7b66dEoGO69yyzTk5OSxk4TQXKWz6omtnekpqfOH8usnQAldaSb1hRx9L4gPnOTIhQcq9/WkG722XnS09/PDt0lOsZz5PJSh5ppwVYH090gtHoo/y5FWSZg/DxwVpSWJ6/ayXf5uxqSkvN0ro0a/yhYWhJeDcYbTjLT2cuDr+1Bazvyzak/h9mH/+i3MNLTxAStOcF0nlU0JHwN6DYivOTgjZz5abxgd0mWooyBTe0gVf6iVhWBpws0A3taAiu8yln/ConAlKA==
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by VI1PR04MB7198.eurprd04.prod.outlook.com (2603:10a6:800:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 15:02:43 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 15:02:43 +0000
From: "Florin Leotescu (OSS)" <florin.leotescu@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Florin Leotescu (OSS)"
	<florin.leotescu@oss.nxp.com>
CC: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viorel Suman
	<viorel.suman@nxp.com>, Carlos Song <carlos.song@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "festevam@gmail.com" <festevam@gmail.com>, Florin
 Leotescu <florin.leotescu@nxp.com>
Subject: RE: [PATCH v4 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Thread-Topic: [PATCH v4 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Thread-Index: AQHblPIj94Hm8KGvsEeFw951zf2SHA==
Date: Fri, 14 Mar 2025 15:02:43 +0000
Message-ID:
 <DU7PR04MB11163B2B2D8D429B2667DAA65FFD22@DU7PR04MB11163.eurprd04.prod.outlook.com>
References: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
 <20250313125746.2901904-2-florin.leotescu@oss.nxp.com>
 <20250314-encouraging-fabulous-ant-e1f7b0@krzk-bin>
In-Reply-To: <20250314-encouraging-fabulous-ant-e1f7b0@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU7PR04MB11163:EE_|VI1PR04MB7198:EE_
x-ms-office365-filtering-correlation-id: 829d97ce-be90-41da-4c9a-08dd630945ea
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0pmcGJRL20yWWtDVnZRcU5haXVYeWVhcmsxV3I5Vno2Y0FWeStnc1FXQnQy?=
 =?utf-8?B?YXM4TXlDL2d5YXhhdEI2UFRBdHdQK0hvNGcvZW85RkhwaW90dmpibFF2YXNS?=
 =?utf-8?B?RU5DYnoxVlZzZW1vMzF1czVRSlovTkZneFB4Z21UTlZSQVd6WE5ubTVzTEdu?=
 =?utf-8?B?d3RpKytsWG05VTFzSmNPUjRNUE5heFZXZE02U3JxSWxzWGVDc29aVjM0ZTJV?=
 =?utf-8?B?SHpIN25yUDJkZWh2SEdiOWtFaWsyeU9oa0phU3lhbW5sYnlyWk1HTEJtNGZ6?=
 =?utf-8?B?ZGN3bEE3MjJmVnF3QkdXc29ZcTdaK2RZa3lYdVFJVm9POXU2TFNXSTBtNVox?=
 =?utf-8?B?cGRXN0lua3VwQjYrMW9aWUJSMjU2dzVhM2FYU2tVSXMweVpScUEvRGFEMWlp?=
 =?utf-8?B?eEdmUkE4Rll6WGhnNnkzS2R3dkF4NUgzNndYWUlHdlZEVFpodm5BTHVoeXR3?=
 =?utf-8?B?NEowdFJ2eUxsOG1xVUE3b1JraUpINFdpVEswbU05VUtkaDdxRi9lV1AxWEQ5?=
 =?utf-8?B?NXo5YkN3V3pwNzFDeVFpNEJTUVhkMFNGZWRlcVpaTUd1Z1A3TW9UUzJ4bmxL?=
 =?utf-8?B?cW14TURTdUNjODVDSjJIWWEzY3VWWVY0Z2k3M3NCd2NVS1dkZ2FETUdHdVV6?=
 =?utf-8?B?ZFU4bzNVdHBvUkpvbmpRa0dxR2RnMGE1N2RxTU4zekZ6ekRlTnVZNXc2VFRa?=
 =?utf-8?B?Qnk1QUtBV2ZGSElGM3RPbFpCYWpLZDBwN2xhczZidEFCRTVjd0FmUmxBREVn?=
 =?utf-8?B?c0FHNk9PQmRQTjQvelBuZU9iVnphRmJoRWJvTHdobGlTM2VpT0ZHL1RHRVVY?=
 =?utf-8?B?YjRtWnFFSHpsVnFRdS9YVG9oc0M0SjR4aHZTVlZROG5vckVIZk1nL1hsdTdT?=
 =?utf-8?B?WXkweUVaVWEzOERSMWY3YlE5aDJidmx2ZlJhSnlmd1NWZnVKb1RtTVQ3Z0RS?=
 =?utf-8?B?T2pYM3QxcTFDaS9USkhna2RzQWhjMWQzeitkeGozN0RIVTBpMDgxck5neEt1?=
 =?utf-8?B?S3ZhRXNkd3NFT3k4SGxKV0E0dmZoeXZFV0pYa2I2NHl4VjZ3alEwRWo4ckxY?=
 =?utf-8?B?bVE0VStmL0NPa2EybGsvWDY2UzNLR1VhS094SlNyV2JxRUc5ZjZhMnlFd1Bo?=
 =?utf-8?B?NHVpdzdPNkladTFGa1dpT004c09PRkJZYzNwMzF4RFMwQTNWL05oZ2VIL0ZE?=
 =?utf-8?B?bmQxamU3OVFQYjRCMmc0UWtGcURHYW92QzA1c2tNY292azd0UFdHTzEycVVQ?=
 =?utf-8?B?b1J4UlJ0b3BwWG15MmNQK054N0l0eFBFUGgxWFJCWDB2cjUvL0hlU3ltRFV4?=
 =?utf-8?B?UTBJSFQvampkUUlEWXllVy81dWlpdTBKSVFqYWE4MTU3T3BDbzBQNU91VWhR?=
 =?utf-8?B?YmFvR1F3UEs0RXE1Y3lLK3NJZXNTUjlsTnFmWlJpN1d0QWlhWWV3Y1RTQ3lk?=
 =?utf-8?B?c0xXYTEycTdlQnJEbXhJMnFtNW1mdjlDTlM0aXFUTlNJbTVxY1AweGlXTTNM?=
 =?utf-8?B?Y1lSTkNzclozRFBWSlpyQitpMjJseGNjemQ4d21VdThoUmswVWZFUWwyRStJ?=
 =?utf-8?B?ei9peVUvL1FHakFleisyK2xYT3IyNlZ4MXdqVVNMZUVSdlh4Q21NU292OVBj?=
 =?utf-8?B?bmxhVWlpSStMY0ZmWVYzd3JCeXVnM0cxQ1dQR3k3WWVNZWFGaGxRd3hOb2NB?=
 =?utf-8?B?SmtJZW9pT3QzaWVIVVp3RzlvSHJYamlZd3g2LzBrN21BZCtkbGFEczQ0c3dl?=
 =?utf-8?B?cC80UDhoZ0JpeWlPNkh4dkl2aFVZY282d1hJSlBDMlpERDJ1UXBBeGFOS0tv?=
 =?utf-8?B?Rm5QdjREQXRtczdUV21WcGg5dFdHRXVMKzE3QWRSbzNXcmFsMEdGN09RYmpK?=
 =?utf-8?B?TUZmMmg1bW9ETzl0dUg5bWUrdW9pZldvRitWV0N6VW9iWE1XR3d3SFZ3eFd5?=
 =?utf-8?Q?t5bbdgY6TLwtVguzsByyiDO/H4QsIJlh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHVUNllyczgrZmRxMG9lM3JOakJjekZDSnZaRXd5TDVlcFJjSllxYVFJc3lk?=
 =?utf-8?B?TXQvWGFoSUxxYU9FVW0xMldzaFcvRkZiOHFEU3kzSmhlNm5DNTUvVmhWYldu?=
 =?utf-8?B?VHdJWVZMY0VSdnZFUm5nWHBFM2h2VVJGd3FmTlVEWnFOR05oTkY5ZnBia1o1?=
 =?utf-8?B?bWp6MGF5ZFgwOHpZT3hmUmRVUGlnaFpUZlRWc09KNVBwYjdsQ2xSVEozSWw2?=
 =?utf-8?B?Mis2QmVXNS96WkV1VUs5OVRmYnhrZ2hBdDNobm9kTFdqYk1odzBrNUhaK3NK?=
 =?utf-8?B?UTMyUllVc3piUlEyc3d2ei85eEdtckhNTm9zQkFzZElNbGVaS2ZtQVByS3RO?=
 =?utf-8?B?WWNLQmhzWDI5NjlydWIwOGU0eVcyenhRQ0FUeGt0QUdrQ2lKaWNWV1FlU2hC?=
 =?utf-8?B?RW5CK1UzSzhmTU9GYjBXY2R4N2JjbHpEc084VlJQMHNGaUhJdS8zM3ppSHpu?=
 =?utf-8?B?VGdEdEljQTg4WUZSWlJUUjM1YkQ4cVhTeHVsYWJacFdVU1ZTUlVYS1k4WXRX?=
 =?utf-8?B?K2RTSVVjSDlRM1VUeXhyZTduWVlqa3crOTNDZ3pNMnhoOVNieVhRTDVMdEtv?=
 =?utf-8?B?ZUFPWXI0MEltMXJ1cTdlMW1QRThJczBPSlRla0plcmEyRDh0djhoZE1YTngz?=
 =?utf-8?B?OHcrdFh5QlZHaDlacTRvSWZsM0svTFBBbWE4S1FKdk9iUTBlWlRJU1ZwSnBQ?=
 =?utf-8?B?ZjNXUytMOXkyQ0FTRHJ1QlJ0bGc2dVYrZjY5OVJ3blpSZEcrbzRBemZaRVhS?=
 =?utf-8?B?OGwvNHpLbEErS1ZIMStRU3hOSWN0S3RkSlNTQmV4dWErT2syaUZ4My9qNTRq?=
 =?utf-8?B?YmxsQldjdklMOFRvM1FpY3ltNDA2UzdjWncxVXN3R0tCaEc2ZTNmc0dpUFBK?=
 =?utf-8?B?cmExdzRHY3dqWXg1K1pCNkRkR01VdXJwV3Nqa0Vnem1WY1ZHRU9WL21nM3pZ?=
 =?utf-8?B?MytweENqOGp6LzFhTXJ1cXgvL3J5d1JsQmdjcURmS2FHM0hRNFZveUdYSnFV?=
 =?utf-8?B?T2NpcGFwam91RFRrdmtZckxObjVZd01RUk1ydytXMndKVFg4RnMyZy9BZ0Nn?=
 =?utf-8?B?THhyQmNnRkEwWFFjd1lGL3Z1K2dqR3hwZEoyNHQ0cUdmM0UzdTlYL0twYTl5?=
 =?utf-8?B?YTVoTTUyeXFMcXA3NFpsZHcwbXR5c2xHN24xZGszZHVNdVhVMjZvQzhFUzQ0?=
 =?utf-8?B?cnRPb3NSYWZPL3VZeGNQVHFxUnlDRnQwVmQ2akVSSmJITGhaT3FBV3VaYXQw?=
 =?utf-8?B?a0cyb1pHcVp5MlM3dkNpaTlFVEZhZEdWSXVUMmUzSXcyT05wL1JDZUdBTXhX?=
 =?utf-8?B?Vm5sWXpDd053SXkxeGsxMllhQ0ZuaXJSQzcyL3pZMitHWXpmQ3JTYjAralJJ?=
 =?utf-8?B?Q01DaUxkeDlVanhQVXc5VHNHWWpYNE9iaUViRkt5UXkvT2FvVmUyTUNkblB5?=
 =?utf-8?B?dXFja1BvcS9hTHcvbkpnK1hDSmUwdTYyQVZFK2RBSU91aVRKd2ZabDJ0RUQ5?=
 =?utf-8?B?ajRUYmZpWE9RMGlBYmJwZjdOTDB4YXJxeWhoU2wxeEFhMHFTVjh2Z0p2TFFM?=
 =?utf-8?B?UjdnRmNMZ1hNUGU3UlFlUEo2WllGcGs1ZmFocW9jdXZSaXJEVlRCTEMvQWIy?=
 =?utf-8?B?Rk41RUZabzAxd01YZS8rVFBqKzZLZmRrL0dTd2RwSW1IZWl1TDhGV0RNcWpK?=
 =?utf-8?B?MitYYVlkdzNvMVBMWHpqdXJralJrMno0ZnNZN0FyV25TSHZtdXdHTjdCaWE2?=
 =?utf-8?B?WWlVckZqb3NraUU5Z0tTT1MyNzJBOTBZQTBzNHA0U0g0aGhzWlcvbGJSQW1q?=
 =?utf-8?B?TlN4MjNtajhEc2h2TEdidlBja2lIR0FldWVPUVp5RFd5R2hBNm9jK1lxL3Ft?=
 =?utf-8?B?ZXVxTXVnTVdMS2NObGVlNTFya1NUTlNONWNlYnk5K3VEdE5SRW1Mald1Vy84?=
 =?utf-8?B?by9DcmNPZm1leFpWZ2p3MWNGbWxpTXZCMnBrRnNySEdoZ0dJK3lES1lyN3E0?=
 =?utf-8?B?eWE2eXNWYkUrbkVQUWVPWG85VnJxMHNGeG1QMzdrUUdzdUxHdGNFVTFqRytW?=
 =?utf-8?B?ZDZ4Q0tVOTdVWGh3Z0pzTjNMbnZPanZiVmJiSGJUZVU2cGdBWHI5Rml6VUFz?=
 =?utf-8?Q?TyHsm7qrplAYx1rKXOlT+emMH?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829d97ce-be90-41da-4c9a-08dd630945ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 15:02:43.5061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYxKlUL8Zl98yOuwHh2tCNd9FaAUHWK5kUdlwCLA1asttNFfdBlwc+HBwIJVwBqDre3a7vuWjqk/fHWNMZydUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7198

Pj4gKyAgJyNzaXplLWNlbGxzJzoNCj4+ICsgICAgY29uc3Q6IDANCj4+ICsNCj4+ICsgICcjcHdt
LWNlbGxzJzoNCj4+ICsgICAgY29uc3Q6IDINCj4+ICsNCj4+ICtwYXR0ZXJuUHJvcGVydGllczoN
Cj4+ICsgICJeZmFuQFswLTRdJCI6DQo+IA0KPiBLZWVwIGNvbnNpc3RlbnQgcXVvdGVzLCBlaXRo
ZXIgJyBvciAiDQo+DQoNClRoYW5rIHlvdSEgSSB3aWxsIGNvcnJlY3QgdGhhdC4NCg0KPj4gKyAg
ICAkcmVmOiBmYW4tY29tbW9uLnlhbWwjDQo+PiArICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczog
ZmFsc2UNCj4+ICsgICAgcHJvcGVydGllczoNCj4+ICsgICAgICByZWc6DQo+PiArICAgICAgICBk
ZXNjcmlwdGlvbjoNCj4+ICsgICAgICAgICAgVGhlIGZhbiBudW1iZXIuDQo+PiArDQo+PiArICAg
IHJlcXVpcmVkOg0KPj4gKyAgICAgIC0gcmVnDQo+PiArICAgICAgLSBwd21zDQo+PiArDQo+PiAr
cmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+PiArDQo+PiArYWRk
aXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwN
Cj4+ICsgICAgaTJjIHsNCj4+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAg
ICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+PiArDQo+PiArICAgICAgICBmYW5fY29udHJvbGxl
cjogZmFuLWNvbnRyb2xsZXJAMmYgew0KPj4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWlj
cm9jaGlwLGVtYzIzMDUiOw0KPj4gKyAgICAgICAgICAgIHJlZyA9IDwweDJmPjsNCj4+ICsgICAg
ICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsgICAgICAgICAgICAjc2l6ZS1jZWxs
cyA9IDwwPjsNCj4+ICsgICAgICAgICAgICAjcHdtLWNlbGxzID0gPDI+Ow0KPj4gKw0KPj4gKyAg
ICAgICAgICAgIGZhbkAwIHsNCj4+ICsgICAgICAgICAgICAgICAgI2Nvb2xpbmctY2VsbHMgPSA8
Mj47DQo+PiArICAgICAgICAgICAgICAgIHJlZyA9IDwweDA+Ow0KPg0KPiBQbGVhc2UgZm9sbG93
IERUUyBjb2Rpbmcgc3R5bGUsIHNvIHJlZyBpcyBoZXJlIHRoZSBmaXJzdCBwcm9wZXJ0eS4NCj4N
Cg0KT2ssIEkgd2lsbCBjb3JyZWN0IGl0LiBUaGFua3MhDQoNCj4+ICsgICAgICAgICAgICAgICAg
cHdtcyA9IDwmZmFuX2NvbnRyb2xsZXIgMSAxPjsNCj4NCj4gSXQncyB0aGUgc2FtZSBQV00gZm9y
IGFsbCBmYW5zPyBTbyBpc24ndCBpdCBiYXNpY2FsbHkgb25lIGZhbj8gSG93IGRvIHlvdSBleGFj
dGx5IGNvbnRyb2wgdGhlbSBpbmRlcGVuZGVudGx5LCBpZiB0aGUgc2FtZSBQV00gY2hhbm5lbCBp
cyB1c2VkPw0KPg0KDQpJdCBpcyB0aGUgc2FtZSBQV00gY29udHJvbGxlciwgYnV0IGVhY2ggZmFu
IGhhcyBhIGRpZmZlcmVudCBQV00gY2hhbm5lbC4gQWNjb3JkaW5nIHRvIGRhdGFzaGVldCwgdGhl
IEVNQzIzMDUgY291bGQgY29udHJvbCB1cCB0byBmaXZlIHByb2dyYW1tYWJsZSBmYW4gY29udHJv
bCBjaXJjdWl0cy4NClRoZSBkcml2ZXIgd2lsbCBwYXJzZSBhbGwgZmFuIGNoaWxkIG5vZGVzIGR1
cmluZyBwcm9iZSBhbmQgdXNlIHJlZyB0byBkaWZmZXJlbnRpYXRlIHRoZSBjaGFubmVscywgc2lt
aWxhciBhcyBpdCBpcyBkb25lIG9uIG1heDY2MzkgaHdtb24gZHJpdmVyLiANClRoZSAncHdtcycg
YXJndW1lbnRzIGluIHRoZSBleGFtcGxlIGFyZSB1c2VkIHRvIHNlbGVjdCB0aGUgcG9sYXJpdHkg
YW5kIHB3bSBvdXRwdXQsIHdoaWNoIHdpbGwgYmUgcGFyc2VkIGluIHRoZSBkcml2ZXIgdG8gZ2Vu
ZXJhdGUgdGhlIGJpdHMgZm9yIHRoZSByZWdpc3RlcnMgdXNlZCB0byBzZWxlY3QgcHdtIG91dHB1
dCBhbmQgcHdtIHBvbGFyaXR5LiANCiguLi4gPCZmYW5fY29udHJvbGxlciBbcHdtX3BvbGFyaXR5
XSBbcHdtX291dHB1dF0+IC4uLikuICBOb3csIEkgcmVhbGl6ZWQgdGhhdCBJIHNob3VsZCB1c2U6
IDwmZmFuX2NvbnRyb2xsZXIgW3B3bV9jaGFubmVsXSBbcHdtX2ZyZXF1ZW5jeV0gW3B3bV9wb2xh
cml0eV0gW3B3bV9vdXRwdXRdPi4gSSB3aWxsIGFsc28gZG9jdW1lbnQgdGhlIGFyZ3VtZW50cyBp
biAjcHdtLWNlbGxzIGRlc2NyaXB0aW9uLiANClRoYW5rcyENCg0KPj4gKyAgICAgICAgICAgIH07
DQo+PiArDQo+PiArICAgICAgICAgICAgZmFuQDEgew0KPj4gKyAgICAgICAgICAgICAgICAjY29v
bGluZy1jZWxscyA9IDwyPjsNCj4+ICsgICAgICAgICAgICAgICAgcmVnID0gPDB4MT47DQo+PiAr
ICAgICAgICAgICAgICAgIHB3bXMgPSA8JmZhbl9jb250cm9sbGVyIDEgMT47DQoNCkJlc3QgcmVn
YXJkcywNCkZsb3Jpbg0K

