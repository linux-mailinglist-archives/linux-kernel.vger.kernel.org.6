Return-Path: <linux-kernel+bounces-563414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF67A64150
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AC018919A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808A219A71;
	Mon, 17 Mar 2025 06:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="SYSIHYGQ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2104.outbound.protection.outlook.com [40.107.241.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D7219A97;
	Mon, 17 Mar 2025 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192494; cv=fail; b=gt1hnDgGI72GyF+F1ZHFxiS1RaNxn4XG/7NQPOewiB+tsikC3Q3iY73SJQty8ZFCVW8ZzFsIPapA6iZ3/eopDn0TR+KgNUOop9QBLYOMjwPETK8giDk8g2qiZcRoZKPlQJExGt21zjCZlKGBDXPVta/ENF5c5okCYHz9qXnh5yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192494; c=relaxed/simple;
	bh=bebS+W3IzQbFV9w9Nsvb9xuShspcIzjMhAgC2ybRc8s=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQMx/f8BmFHC7GarutzTPjh9oFxZnq7IrVgEXh3dXXAYDmAZnFHu1fNhytHTkUGHqxR2iUP675CEcwiPJj3UedxlJeWAYzp48dKj5nPz2XgZ+zboI+vSOJPOqiULYediVtKVTEczoi9ln1FZ3t8VlzM1MD2ufKCDql1Gn6SOo+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=SYSIHYGQ; arc=fail smtp.client-ip=40.107.241.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvrSsxizLpNKZ67s5R0mBdOjgSbYxOSRvzqsVVINxm4+LhSxWx2SQNo69+ZyqOx+NGoB/rugtxj/FvKisr88tjmJU04ty3eYIHH658EtBvhGGhAy7wRhDkKBtQTPfOuOTUJjzPmKVEmXEt34aSbs1veD5zkctOZviJntoLpiNDaqmlh7XhGggdqjsDVF+gkwtrA8+d47191OgwiTaPO3+y1D+uLSbtJpwc4NYoJdzDrHwtWgb7bkG6MRdDYXIKFYYo03Svs2c0INweCwnJhd73tuo22cC5WAdzRzUfBDJuolcD3T+i1Uaf864n+pKj89IuAWNPEnJZ4c3jLuPX4oOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8FyBc79WHIE8WRpjgsEMQ6AtEcYFohelBsiriGVRgQ=;
 b=kcAqeTWRd4gpiWrK0p6m37vl8CGrHj3el+b2+IcwkRbx7rGbLZbEe3ntQXL4j1V2hT6qOb7x67hzfRu/LyinLOFx8NiKtCiHxiIIRMMD5wik8ypChUl2Xfb7oQVZqKpAMV2FUNgFFdm+cYKGSRgH+7gG1FPyihjlZnrvia1dpQoesEEruaAQEe6jLbKc/Z3+iiBFxd0iVFOtb4EqOh4k0ZDj9fwJlXnHvv4KOllUBs/uLS+858tKeb6EREUEZ0rilcV7hc4n6z7RdsoM4JEoaQ73bIusCi2Vdsu/VWuvgepZg4QtHhe1STBlNeWDJLPEY7GJsfGfJUl4G7EwVGig9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=synopsys.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8FyBc79WHIE8WRpjgsEMQ6AtEcYFohelBsiriGVRgQ=;
 b=SYSIHYGQeLkB7rOPNigEd+lyfd3Sf1t6IXLWqgUfNl6bKql8druWuhN6udHixTX8wDPCNN8YqA8JXqjgm+Sa7HrCG5Q1cSw583eSDGCROxResBX+Da/qXdvKe1yNEXZimVoSqpCUCjrQzgDeVgtkrW87kzcpnj3go1aCbVk/9EhwmnThNX8wMSa2miOUMwbaCjQepKYY67/wA7IaJ99EVFLcrhXwrX/oqY+ambCDwDQq5G666u90gcD0Xkh3DCSXYuNzV7ewQELDT97iYjpUKs1LXhwMtPp1q4+l+9XnrfR4Q2s7tDJ55YS5N0RmDuNqgY1lfm3penEsDSaXLkLMyQ==
Received: from AM8P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::35)
 by VI2PR04MB10619.eurprd04.prod.outlook.com (2603:10a6:800:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 06:21:26 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::aa) by AM8P189CA0030.outlook.office365.com
 (2603:10a6:20b:218::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 06:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 06:21:25 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.171) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 17 Mar 2025 06:21:24 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PA2PR04MB10336.eurprd04.prod.outlook.com (2603:10a6:102:41c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 06:21:22 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 06:21:22 +0000
Message-ID: <8ee2ce74-dc6b-463a-ba95-ad25669a1179@topic.nl>
Date: Mon, 17 Mar 2025 07:21:21 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.323aeebd-1577-4c21-85a6-ff9262fb6cb7@emailsignatures365.codetwo.com>
 <20250314155706.31058-1-mike.looijmans@topic.nl>
 <20250314211411.l5taj5nysvcalfyz@synopsys.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20250314211411.l5taj5nysvcalfyz@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR08CA0015.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::28) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PA2PR04MB10336:EE_|AMS0EPF000001A4:EE_|VI2PR04MB10619:EE_
X-MS-Office365-Filtering-Correlation-Id: efc3a47e-aeb8-44c6-3b0a-08dd651bf202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?c01SU2tSTnYxK1c1S25HM201Qi80UC95Wnl2U3E1Nkh1OVBTQ0NjWTN4dUhT?=
 =?utf-8?B?ZUxhM0htQ0txMWgza3lLUngraG40aUVVTE82VkJhcXdndEhPNm1rSUhLcmMr?=
 =?utf-8?B?UTYyN2Jxc3E0S0hvVm14aEFYOEw4ZURwdjZLOGRRT3dkY1habGM5Z2pHaDkx?=
 =?utf-8?B?M2FjS1ZtSVZKOE93UEl5bkZSSUJpME52QUhuVGJlOE9IMWxKU2VxMzUwSHlp?=
 =?utf-8?B?WUhwYVhaNGE4MjByU1ljc2IwSWJIUUtRaWNFcktpSVJweWlRRlpYSTRVZ05K?=
 =?utf-8?B?bGZ6STROZ1BudVloMEFzWkZoRmpib2hEeWJ0QnUxY2FlMTFJUFJKM2RxRkNM?=
 =?utf-8?B?Smx2UGNLa1I1V3FyOVlqS2NmVHBKMG9PTmtWM1FOeUpMVTRVenF5S2NwV3hi?=
 =?utf-8?B?eHZ2MWhNZDFrU2liN1R3NXlWaXpPT3NKelFFZUNrVDVLamFIN1NhVDlxZUdJ?=
 =?utf-8?B?d2RHTTB4K2l0OHF0T2tLb0ZMVDV6NzZzOFZsb0ptSURFVkFhdENtTEpLNDVl?=
 =?utf-8?B?SEg3QnM2TmIvT2JXUHJVZ0xKY3VSWjRZVndqTjdyTGhPRGg0Y3JmOUhyVFZp?=
 =?utf-8?B?OU5hSTkxMy9vREdIM1VyYkVxTjVTSXhOa0NqVDMveU1FY2d2NEhZNllmdHFy?=
 =?utf-8?B?WmdtUXdDMVRDNnBuYTB0SGJVZzQvUkRLb2VWS3NDalRYa0VIM2RWTXhKNUJu?=
 =?utf-8?B?NzB4TFRsbEEwVFF0UzE0cmlaTzNRWlU2dC9xN2xXWGZrWGdrSVBUeUw0Nm05?=
 =?utf-8?B?UVd0ZzVEbml3VDVjRTFXeVBiMnBYMVlRS1FaVTk0UUV4VmptekhGQ0E4anFS?=
 =?utf-8?B?UUpFVzRaREd5d2NHNG1EVkJ2bXlGUFRrMWdUTWpmRXB2aWRKK1RVRWlEaWg4?=
 =?utf-8?B?Rll4K2grRk0zdWljOGhpNDZncTltbUtBcEtkWjNsSklwalQwNCtCMHdFdExx?=
 =?utf-8?B?b3JNSWdDdW9BWGFNbU5aUWR6MXVKUC9pdWtEQ1NvT3ZFaEVJZWhxY21xZnYw?=
 =?utf-8?B?eFBKN2V4SitzYzR3R0UzcHczaXNLU0dETVIwL21tTzBtalQ4SHBVUUUvcElN?=
 =?utf-8?B?NzFneWp3MmpOR1BRZXFpQ01od1UvREtCZ2QwTFlHcTB3ZFZnOGxQTXB4S29z?=
 =?utf-8?B?RXVkTzBvbCt6UU01bDRoQ3lDNVpPMVFPd3NzUjFPNmJJM0dqRGNXZ0lQank5?=
 =?utf-8?B?dVB6MmxMOHY2b3FlTG0zenRudjByMUpadDN0Ykx6U1Q0NEJSb2NOUlJmNWZP?=
 =?utf-8?B?MUhPVFNGeHhBVDROVFBCc0swZ2ZjZURRbDVCZkJpeEdYRmdxNk1EVjJ0TjFh?=
 =?utf-8?B?TFNFMFRFZVcxc2kzRmlGdDVEcksyNHNnWXFEeFNPbkk5QkxieGZJSXIxb2Jj?=
 =?utf-8?B?VHJKMk9neGd3ZTNWMjhqMXdNU1MwbGNvQzJnZ1JjM1R3bktSL3JUamphZnFl?=
 =?utf-8?B?SEo1bGJoVnJyZkVSbDFqNHk0cjVod1QzSGFtWGpLMTIvMk01NUx5aDhyc3V2?=
 =?utf-8?B?MXJXMVpqVmdObjRuTkJzL2hIeGljbzZGS2U0N2dTTGVSeU1BNFpCWmlXNS9X?=
 =?utf-8?B?dHVFK2YxSE5lbDdObVlvVGZIRDZpS3NsanJFYUhWdGRPTDhROUtkZzV3eFFQ?=
 =?utf-8?B?L0VJUm10VHMvQ09nQVRWNUtSZDhOUmlEZWJWbHVyOVVqbHZRazlVeGJpd0ds?=
 =?utf-8?B?NzNmdW5lT21SZXR6T0hwWVZ0OWhXcThkSy9sS3Vnb0xrSGVMZzFpU0hBcGNu?=
 =?utf-8?B?bGFtU2Qxd3dBOEZzVlZIQlRBaDErK1VWS2lsYVQrc1FOaU55QjFrd0tQR0Rj?=
 =?utf-8?B?WExGSENhK0tOajlBNG5FSGJDam9MNkJVV0pNbVM0T3J3QWY3N0cyNk56UUFH?=
 =?utf-8?Q?4sW4dGAQa+lA5?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10336
X-CodeTwo-MessageID: 65fbc353-f6c8-4a52-93c0-ec28f7724d14.20250317062124@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2e55f105-2612-4eeb-3b14-08dd651bf022
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|1800799024|36860700013|14060799003|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ykl2SVZvSlh3SXBwOWVrWUZCZnJqbXpiN21yT0lRL2FCNFJJOUxiZnpuUTZr?=
 =?utf-8?B?N21ES3UzK3QvZjJQUEhtbTAyRU1TWlZub0F6aWpEQWtwczhZRnBZSFUyWmtI?=
 =?utf-8?B?YURRY2NZY3NVQnRJbHRXZGxQeklTeWgwVFdoUGVNSDRINUtrR1Z4TjhjamE0?=
 =?utf-8?B?U1ZKT3RQSHMyVmhocEc2eG45ZlhSa0R0aExwdVFoUHVUa3ZBWnFURzZJNHh6?=
 =?utf-8?B?THh4aXpxbmlVUmw2R0VsbW5CVzcrOSsvNUFoTkhkOTd3N21qRWVFWjV2UTcx?=
 =?utf-8?B?R052WjdhaVk0VUhTUThXYmhDbEYwZ0QrVnlGMFNybURMSytMYy9zTk5STnJn?=
 =?utf-8?B?dklySUZpYVd3bXdVSkxKSERpL2hpakR3aXhLbG5XYm55QWpjV1AyeWdqZTNU?=
 =?utf-8?B?dXRxR1BPNU1waUNoSHVOVG9BMWJjVmFLQng1R1pqb013ZzhQYkZPekVwMm1O?=
 =?utf-8?B?RUZVZWZaaEMzUUpHcEhGOTNlWktiMEZlN2o2czZYRlMxWll1RDFtTmtRLzJz?=
 =?utf-8?B?aUJKcHBkT0gxd05pbHJyRTQ1dEVGTWpqaWVJT1ZZVTI5bFh4eHVvTUVaWkhE?=
 =?utf-8?B?MjJKa0llR3VGZGxmbDB4VFlGM3VtbHk0OHhkUkdmVGNNVlVjMUZnTlJ0ZmlD?=
 =?utf-8?B?dldLQnVQMFB6UWNNZjFNUmZCV1k1V29DSDRVK2VtZ1BUSGNpOUpZejNpNXky?=
 =?utf-8?B?eGdrTkJWM0NQckNNRG1HcldpRXVzenFlbmU5VzV4MkQ4dWRsOUR1YVFXeitC?=
 =?utf-8?B?NDdYUnI3c29icm9SK3pqek5hQWhEL2dLQ0pTbitHdFNQLy90SUNIbm9iMGR1?=
 =?utf-8?B?MVZJNldwQUY1aDQvbGFrcTdUYlFIZGdOaDdnZEJ6TFNUc3hpV1pTNWxCSUtu?=
 =?utf-8?B?WGhKR01DaG9LcDQvemRYYlZtakJYMmFpdXFGVFBoTHJkancrcEJNdmdub1Nq?=
 =?utf-8?B?YjQ0ZGdwRDBXR0ZPbm9XSEpNQ0dTVTdRaXZwQjQwRXdrR0JOdFE1WTFoRFFm?=
 =?utf-8?B?ZmVMSVhCQWI0bklvQ2Z5YnVGeEVsUTVHMDVGSi80YWk2enMzSW80YjZ6ekZT?=
 =?utf-8?B?NFBaaVNZUkNUM3JpZkpqUlhycFhJcVRsUk1oRWlKNnQ1QkZqdGVRWi9TZVFD?=
 =?utf-8?B?L1oxdlBucy9RckdXSS9kZGdHL1JaM3pmVFdnZkVCQUVvK3JJVUtHN05SWFNa?=
 =?utf-8?B?eWNYd2ZVdTJZUmpYMXpQZGNpYzNHVnViL1ZhN3NqL3U4MEwvS1JOQWF0NWc0?=
 =?utf-8?B?NzBNcXpZOUxxS1k2NUF0MFRsM1k2cEM2eVQyVFgxT1FTYkdHK25sNm5OSzlx?=
 =?utf-8?B?L0hnc0Jsayt6QlI2WEhBcVBPeVNVTmlkd3dLZDJ0ZzVJRlI3eHNDMUM1Zkdj?=
 =?utf-8?B?L1ZnSWQweXdiTXgwVVNWSC9xanJuRlNaUDR2Z1JhalNUNXl1VWZZakJIa2Zu?=
 =?utf-8?B?d2t4VW5BRGlpd1VoeVZpUlRvMWJYVUNVTThKVUF4OUtmTlRvOEV1ajdNaGhy?=
 =?utf-8?B?UGdhYjh0ZHlBN2g1V1VBTmY0bzl0UTFCN01wZE91Zll3NVFYOFpVSTB6NHhi?=
 =?utf-8?B?UEhVTS9HdlR4NXJBbUlpTmxON05FdTZNRlZUYVFSNlB3cTVwcEw2TzJEbVFP?=
 =?utf-8?B?V3F2bUhiS1ZzdkxLZEgrMVZRNnlBTWRZQUx5Mk1UME42RkRsU3hGQlE2amU1?=
 =?utf-8?B?WmdVeUZDQ0lBS3JBOXdIMUNVMkY3OFlIV0RDdkhzR0k5cFVOcUNONVdMWmxV?=
 =?utf-8?B?RHllVDEyK2VzcVBMcFZPTnRpcWY0THh6bHlIRDE4VFNpRkFLOEliRDhVRjJE?=
 =?utf-8?B?ajRnYzVLamcwNEpIUGV6VXZDa0pBOVA1YjRuTkVyUTdWTG9tR1BxeWM0SGM5?=
 =?utf-8?B?Q1ZTN0daQ0hqemFUL3diekMweW9EZC9JekxWcXB1UTZPcmNjTG5hN3pteWZH?=
 =?utf-8?Q?Ybxd7pcO88Y=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(1800799024)(36860700013)(14060799003)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 06:21:25.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc3a47e-aeb8-44c6-3b0a-08dd651bf202
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10619

On 14-03-2025 22:14, Thinh Nguyen wrote:
> On Fri, Mar 14, 2025, Mike Looijmans wrote:
>> Set the gpio to "high" on acquisition, instead of acquiring it in low
>> state and then immediately setting it high again. This prevents a
>> short "spike" on the reset signal.
> How does this affect the current programming flow beside preventing a
> spike to the reset signal?

I don't understand your question. What "programming flow" are you=20
referring to?

The reset sequence was just plain wrong, the issue is almost the same as=20
the one described in this commit:
e0183b974d30 "net: mdiobus: Prevent spike on MDIO bus reset signal"

Note that I see this high-low-high-low double reset toggle in many=20
Xilinx software drivers, they seem to teach that at the Xilinx academy=20
or so.


>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>
>>   drivers/usb/dwc3/dwc3-xilinx.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xili=
nx.c
>> index a33a42ba0249..a159a511483b 100644
>> --- a/drivers/usb/dwc3/dwc3-xilinx.c
>> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
>> @@ -207,7 +207,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *p=
riv_data)
>>  =20
>>   skip_usb3_phy:
>>   	/* ulpi reset via gpio-modepin or gpio-framework driver */
>> -	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>> +	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(reset_gpio)) {
>>   		return dev_err_probe(dev, PTR_ERR(reset_gpio),
>>   				     "Failed to request reset GPIO\n");
>> @@ -215,7 +215,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *p=
riv_data)
>>  =20
>>   	if (reset_gpio) {
>>   		/* Toggle ulpi to reset the phy. */
> Does the comment above still apply?
Now you mention it, the comment never made any sense anyway.


>> -		gpiod_set_value_cansleep(reset_gpio, 1);
>>   		usleep_range(5000, 10000);
> Do we still need this usleep_range here?

Yes, this is the "reset active" time.



>
> BR,
> Thinh
>
>>   		gpiod_set_value_cansleep(reset_gpio, 0);
>>   		usleep_range(5000, 10000);
>> --=20
>> 2.43.0
>>
>>
>> Met vriendelijke groet / kind regards,
>>
>> Mike Looijmans
>>
>>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




