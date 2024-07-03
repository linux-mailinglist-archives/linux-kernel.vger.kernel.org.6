Return-Path: <linux-kernel+bounces-239647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3FB926387
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83C7B2654C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D3617BB01;
	Wed,  3 Jul 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="VhaLmfw0"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021074.outbound.protection.outlook.com [52.101.70.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72B179965;
	Wed,  3 Jul 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017352; cv=fail; b=VSd/sm85oqqzMccKoxnW8Uj1x9QcojjXSaccGH/6/+IG2XHqLM4OeAQI361zh7vR7JQOBGlmG50A+YcIBSMqb/RJEhYQabmWqoxEcH49YvcyOldb7UvBUbScwpNoHX+4RhS30Krh0ufIk26JWoxYfF7Ej5JcQ3IRY+P1R26d3wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017352; c=relaxed/simple;
	bh=hCDIdI9tqzcCcFpxhwT4l3IHCXfRjwBWh18TXb+5Omk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=exSCO5fkQPudiC1BK/E3AlppSdd+lK1A8KdVjPteeacCtxqa/AaeIrNf7smIrGGjMu/o+gEQRs90Rrv3vnSKLIj3xztsdiarqY4h30OjyiaETNkiOB3+sySBZW6HbnP1Bm3zy4Gk1m/UIAw6jgFkQ1A359Vp8XQ4htrJNBtwNpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=VhaLmfw0; arc=fail smtp.client-ip=52.101.70.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtyCuPP89t/2n5CJHc7r86n3/Viu+ibdbXoZDv1zujaXI7KPZ+jLvK+FvyiU0OtCQYqZ6BEkXJeV3zsNSKjjt1Y2dURo0TS8fEJQ+DutIEz9idzu9BixyODNMO/m0hWNsmd25jdgBGYLgWjr40N0QIfALkUbBdy9QDwDo8ZVUtD9Fhrj3K7pdlwhfNUTfNbW0Kqt50obg33QuV3Y2OQ6M3CJnrcrIdZZAI/40WnIXCByGDgH+jlo9V19Nf8OOF4rMERSTbR5FsaON8ZyI0w2ws4XPURBKEqJaHkejf6vik342Cc0+MYuJ3ceL+2ifjbOn1MG0ul5Q6tyeX1oqpn9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0ZC+cWBQUT53JG/uBnYv5E+GnYgubeCmDqiTt/bQxU=;
 b=Mq1VOBNiERdAhcyP2SqZyr3WTN8y/HSr08McjgH2ba0opBtPsxyqz+sCm/i24w+GhJ8iTGRGFKNrADLMdKr3sqwpDNytQN1Z2Ul3l2Hi4rV7iwiLjQoTySrhTjkXR4n+611e4FB8cLjrPz1k5OM0kvnZI21epkmK7Z2xq+0ke/s5KzlKQantOSE/tdxEnlCMiyAz3oXmQZeDCMyy7xjoTcgRTxw8MYZzEHVrJItUWqWIleXFoIRJ86agU9qmGqEYqHjlIYfgTE/G4LpjwCSP7KoZXIBJLZBBVNNsPblKFURX35INwIfCa3Y+2Sn85q2wfwGN/FaZ9GU2HSY6vUB0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0ZC+cWBQUT53JG/uBnYv5E+GnYgubeCmDqiTt/bQxU=;
 b=VhaLmfw0MwP6McJkBfEOHlpeW/bNhKxY/BX1h/c7GHwVryVGDFHW84YndZjVNYjxWpWWpCp4sZ4xPAbtBUWJS697+W63Z8VVf9NbS+T5pqI17Scl1y0xk8WrEW7JaI1G3NT0AJpcw8zcPYHg1Up5yzmov/uiX611wloBxsi/VnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA4PR04MB9344.eurprd04.prod.outlook.com (2603:10a6:102:2a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 14:35:46 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 14:35:46 +0000
Message-ID: <750d28c7-4d90-4bd6-a910-4d5e73828e55@cherry.de>
Date: Wed, 3 Jul 2024 16:35:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] hwmon: (amc6821) Make reading and writing fan
 speed limits consistent
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-3-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240701212348.1670617-3-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA4PR04MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4f4f66-b9f3-4622-2ad5-08dc9b6d6ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW1IODhmQ0NvaEtVY0wvWUdkc0NiamNUajNoUUNVSVR0UGlOTVA0RkNyNGpa?=
 =?utf-8?B?ZS9scTViMmZYL1N4RFdHQ1BPUmJ3TTJpN0lmdFlqQVRuTU1rdTl2WWZnZUs5?=
 =?utf-8?B?cFM3RVNZTk5PMjZ6RmJSWTc1dnRVWVJuKzMycUZzK250eVAxU1pnRHlhcEw2?=
 =?utf-8?B?YU0zcmo4U2NOdC9qUWMwRmZpNnhscFFxYVJuYjVZV2ZkeTFVR1lhYlM1V21x?=
 =?utf-8?B?cXdRUHUxYklNS1pvSlM2Q2s5N1djT3hSazh6L1NiYzFpMEZ3UzF0UFJKNVBI?=
 =?utf-8?B?UiswOTRKdzdTVnZScDdEUUoyUDlleDB5aExCWmpZQkxxdG9lRFpkOSs2VVlO?=
 =?utf-8?B?dlJkZDZXVGdlMkJ3ajc2OWFlOXJmcGNPTjNtencyNkV3UkFzdnVQdXAzQ3dn?=
 =?utf-8?B?dFhhTG9aSU5aYzMyd1E4bDg2UEFwK3NFbi9IZS9qVzZCdXlyZVdMWThBRERF?=
 =?utf-8?B?SnBmUjR5OTA1U3JJY1N0dXBLSHJPUHlCb3JCck1sSlZlT0pkUURWWGVseStx?=
 =?utf-8?B?NnB3bFBvS29BY2oyWjNDZFpDRHFMWGx1R25HdmVudDBlUW5rQTFUdlE3dVdX?=
 =?utf-8?B?SjBEVVZmM05vMVB1L3lkaVcrcVcvRTdRMGtXK1MvdGRWRmxGaSt2UXc2QXVQ?=
 =?utf-8?B?S0s2RmlweVJ6UnVkZDRwZXhiSzZTbmdBc0tOVFpKRnNaalNvZ0xHOFl3V1By?=
 =?utf-8?B?NW5QMG4weHo5N2trSFR5cXU2NGhDTlRZSTF4aGxEVkhSQ3RmOTg4b25DM1pJ?=
 =?utf-8?B?ckhlcWNxbExzRGt6Q2NoTWVlMFpOZXFLMFFBb0VsYWZkbjVROTdNUVFOUGQ1?=
 =?utf-8?B?TDFWK0dxMGVRR0J4UjNtOFNXUzRjVjdPVGFHQXdzUklIYkMwOTRrSzZLZklz?=
 =?utf-8?B?WDAxTG9BM05MQ1hYWFZ4NWJ0MlRVUnVrZ0lrdXhYNGh4ZWxxSFc0clM3UThh?=
 =?utf-8?B?NUtYTHMxTk1hWVU4c09ZY0xKdlNtZVQycDZLeS9UVVMyVEU3TlVDTWU5V1pS?=
 =?utf-8?B?VUw1VXA0MWJSMzBKMTNVNlhaTXhIeVdKbXh4NUs5cGt5RmFDZUU0dkFvaU8r?=
 =?utf-8?B?d3JEK01UVVZ0RVRQTU9Ra3Y5YTRLNk0xdTFpaUxLL0JuRHU1MzFGSHdwWkEw?=
 =?utf-8?B?S0ovLzJJU2FIVm5na243RzlnK20vZDNPQmE3ejlUV293cUFzaVVSakJvTFpL?=
 =?utf-8?B?eSt6ZG5FcHpzbXRRbEZaRHZWdTJOQVVEdkRkaDg4S2NUTGl4anNYQXY5REpH?=
 =?utf-8?B?MHBoTUNlNFR2N2RkUWt6MHNyTStTZTM0UTdwWVl4TEx6bzRNRkVhR2dKb3ZI?=
 =?utf-8?B?NEUxY0RUdHh2T0VIQ0VCUEUya1o1OUFVUEd2U1VNYUo5WVhZTXR0eHN5aEsv?=
 =?utf-8?B?Z1hwaHI0akRRUHlaSTFvaU1qMGNPS2RvUTdBY0FjcUNlcXlCOG95L1VDNU9G?=
 =?utf-8?B?OWhXaW1tYnFYOVFDY1BJOFVHWGR4dUd4RXZDRklYbWsxeThLZVNIQjNKWjQ0?=
 =?utf-8?B?dHNEMnVFMlgzWGtiSGlZYitDMWhrK2VLMWJ3cnhwclNKaGdEaWFHUk9jTzZv?=
 =?utf-8?B?VHJkcnhJRnczNTJZMERNRk9WenZqdDBDYWp5alhRL3VCLy9uY3Y1UVQwT282?=
 =?utf-8?B?UFpSRUFxVEkrUGo0ckU2eW9aV1RrQngvVUM0a2ZtL2Z5VlF3MTMySWRGdHp2?=
 =?utf-8?B?d1Z2b1BrYVlFYUo4Rmp3M3ZFTWZ2alVONHZZWVNQU0c5V2JCMW4zK3VYNldV?=
 =?utf-8?B?a2xuM1o1TUozMGpGQkM2R2dFOFhDWnVEMkVPazZ5dU1YOUltRExFVGFDTjY0?=
 =?utf-8?B?cVVRaHE2OCsrUlZtNGVMZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkFzNFZCeHg2b2RyeVFzZzYreDZ2b3BHVnM5dkhjK1IzTjAzazk0SnlEMXhs?=
 =?utf-8?B?UEs0TENBTnNCbVRQU29MU1BKM0lvNmdKaG1jV0hzTXpSamc4cDhQTTlhajM2?=
 =?utf-8?B?NldlazhUbnQzTHNKUWRIbWcvVW1VaW5QQkwvVzF2ODZZMDVpdFd6SWhTdUc5?=
 =?utf-8?B?bG1EUkNFUzM0VXR4bEV3N01XSDZLVW0vcmM0MmR4ZjBxR1NIcTVEbGVBNkNq?=
 =?utf-8?B?aWxlQWpnTE5uNGlXcWFSTTlOc3JCVnZUK0VQNzZSNEpsS0tmOXZQdjBLb3dU?=
 =?utf-8?B?U0twU0g3RitPazd4SlRSZGNUMmtpUE1rRzF3eG9FZE5meWZoY0U5aWJjanJM?=
 =?utf-8?B?U1ZVNUR2Wm9UaTlud0tRQU5LRHl2b09Fd3orTFd5ZkxISWJXSDd4c0J6RHcy?=
 =?utf-8?B?ZUk4MXk2Mmg0TVRmNG1DeGdrZm9XeFJTVm51ZEc2NlBONTRvdVBvSFptSVNM?=
 =?utf-8?B?ZkdPRUViN2tDUlpIMHExcTVWNm1leE9XZUNWcVRVRUJjNVlBNmtScFdJRUgz?=
 =?utf-8?B?K0szU3pXQnFjZmFtNFhJRmpvc2Q4QWtPellzYi9nclJDOCt2dE5ZTVp0eTRw?=
 =?utf-8?B?bWYybitIMUhJUTlkYTY4bzBKazZTK1RINUV3YlNkNnNkNkxJakpzZ3ljdmI1?=
 =?utf-8?B?bjNsdXgvTlZCU3g0ZG9iVUFsRTEwbzd2L2NWbHFVZ0xRemdJS1h6NjRhTS9o?=
 =?utf-8?B?WVlEcWw0V1VaeDc5VGUwYW1tcWtCL29rZkxTamZwNUVkL09YZVVyYnNwd0My?=
 =?utf-8?B?emdYVjJKdWlmaUtJdENDQzdtZjR1UXJoTHE2MmhzU3VvVHQxVlcrWnNBWkFM?=
 =?utf-8?B?SEwyOUt1ckl3NUJmR2hnbHBKY0hSZm5nWmhibVdHRkxXWHcrQlZWSlJYVUJk?=
 =?utf-8?B?bUJJRDZuZGZMRWJEWDJMQ2wzVmoxZ1VFUHFpRlVGVlNkeG9qNXFhSkdKMEZq?=
 =?utf-8?B?NmtBRldjNHQ5WTJpYnJHdk1hcXdwTGI3TmNndFlVYjZXQmdsekhQWUMzck9U?=
 =?utf-8?B?SGI1bjArWmUyYitlMVk0TU92RFlnS3AvUmkzcXJ5WWhsV29VMXJLak0xL09l?=
 =?utf-8?B?d3djZmVrNmlja0tkR29UQjYzRU5Kbkl6eGtzL2tOTXRDTEZYSm05TnNQZDRL?=
 =?utf-8?B?amxLak42c0VRYlJtMlFVblVaZjVvaHRKeXVDcmpVMExZWkVVUU5rak5wZnpy?=
 =?utf-8?B?d1l2eEFmNEw3a1lYV1dYWnQwUHp6WXpPM3pqNEhJa285cHQwYTZjQmw1MnBk?=
 =?utf-8?B?K0k0WDZaUWVndHRkWnFmamRqTFc1OHQxNjkxOUQ4WVlYblp1RHVBR282L2JS?=
 =?utf-8?B?T3JUN0NpNzYwMVcrVURoN0M3TytHd25qaVlVSjM3enVJeis4R3E1UG8rTlVU?=
 =?utf-8?B?TFEwU2xCVjZnM2NtUDlFYUhwU1FCRjdqRXdjRHdhRkdSSU1xcXpEdm9QQ1VE?=
 =?utf-8?B?YndrUldMZGNHYmJzS3VuWXRDZTc5UHBXYWx1VmhSakdKSXJ6NWVseXpPQXVJ?=
 =?utf-8?B?SWhIL1J2V3JYWlA0WVNaTjN1VzlUZGhFQTA5amdaei8zVWJUb1NURm8rSFNP?=
 =?utf-8?B?eFdtY1JhZDlnNzZtQzV2dzNSMkNpbVRiWms2VkdkbmFhWGlOeFVNYWgraURs?=
 =?utf-8?B?K2lMQnorcGk0SEdJYTZpbzh1SmNTMTFmSllFaFNpMFc0WjNwQ3RUc3ZkVWFx?=
 =?utf-8?B?eHpBanZJOW81dHBxcSt5c25qd1ZESnB2R0ExTnZaZ0ZRekxuTjE5Y1VGZGtq?=
 =?utf-8?B?NFlhMTQvSENwZUZUWWhMUjJ1ODJEQ3gyY0FhdE1HZGlielFPU0RKRnh5QlNR?=
 =?utf-8?B?bjkvQXc1bFYzNnFqOXhKWkRhZU1yVFc4dENzWHl4Rjl3RHJob0MrY2xQSkR3?=
 =?utf-8?B?b1ZQWE82Y3Y5TkVQNGdIUFZHYmNWdWp1YzN6cVEvMzZmYmdEdSs0TWFLeU5a?=
 =?utf-8?B?YnZLajFFcHhtZEI2ZkljT0ZGOXowMHAwcXl3SjZCMGhwQXVoV201QkJLdUJ6?=
 =?utf-8?B?MTFhRDd2QTYwbk1QNHYrcGRWemRiNTd3ZTFQRFFXMTNUb29yK2s5amN5UHhS?=
 =?utf-8?B?UEFvR1hMajkzWER6ZEhpZEo4VjVxWmIxcWJLMmZqVVJCTjRWYU5VOUJyUmlO?=
 =?utf-8?B?eVNob3dVSU8wWmx0RnlEQWRmdlZSbUpyVVhOWkNvOTl5aG9yWktvWHQzS2Nr?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4f4f66-b9f3-4622-2ad5-08dc9b6d6ce3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:35:46.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xICs5XcbyLBCAQpxrylmWbhSYh+6W4ImUuHvwgCgu+o2UoGhDh2su2AkW8bN3MKy1l2Xp8jQvHgQSgSqmhF1BODF6gJDzn72wIiORHiXs0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9344

Hi Guenter,

On 7/1/24 11:23 PM, Guenter Roeck wrote:
> The default value of the maximum fan speed limit register is 0,
> essentially translating to an unlimited fan speed. When reading
> the limit, a value of 0 is reported in this case. However, writing
> a value of 0 results in writing a value of 0xffff into the register,
> which is inconsistent.
> 
> To solve the problem, permit writing a limit of 0 for the maximim fan
> speed, effectively translating to "no limit". Write 0 into the register
> if a limit value of 0 is written. Otherwise limit the range to
> <1..6000000> and write 1..0xffff into the register. This ensures that
> reading and writing from and to a limit register return the same value
> while at the same time not changing reported values when reading the
> speed or limits.
> 
> While at it, restrict fan limit writes to non-negative numbers; writing
> a negative limit does not make sense and should be reported instead of
> being corrected.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Do not accept negative fan speed values
>      Display fan speed and speed limit as 0 if register value is 0
>      (instead of 6000000), as in original code.
>      Only permit writing 0 (unlimited) for the maximum fan speed.
> 
>   drivers/hwmon/amc6821.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index eb2d5592a41a..9c19d4d278ec 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -617,15 +617,20 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
>   	struct i2c_client *client = data->client;
> -	long val;
> +	unsigned long val;
>   	int ix = to_sensor_dev_attr(attr)->index;
> -	int ret = kstrtol(buf, 10, &val);
> +	int ret = kstrtoul(buf, 10, &val);
>   	if (ret)
>   		return ret;
> -	val = 1 > val ? 0xFFFF : 6000000/val;
> +
> +	/* The minimum fan speed must not be unlimited (0) */
> +	if (ix == IDX_FAN1_MIN && !val)
> +		return -EINVAL;
> +
> +	val = val > 0 ? 6000000 / clamp_val(val, 1, 6000000) : 0;
>   

I'm wondering if we shouldn't check !val for min after this line 
instead? Otherwise we allow 6000001+RPM speeds... which is technically 
unlimited.

Nitpicking though, therefore:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

