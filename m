Return-Path: <linux-kernel+bounces-330272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AED0979BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB79282BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847364F5FB;
	Mon, 16 Sep 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="SbJjOXOd"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12847781
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470979; cv=fail; b=eISp2N4Ol3sT8LPploBRO2ys0TsNg9pJQ2VRozg6B6Jt9Q9TCMnuslnFp/g25+MCQP2K85QXbZzHn8I66+dAhl5dxEsp+5Fvp6DTNzvsrTLN1HBcGv6LyrU6MqEybi2+l7+HB7Ew2ihjkp7GYq5Bzh2ghvnULWbRSQOtVPXZ0ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470979; c=relaxed/simple;
	bh=O290X91nleUJJo1eAzQ51vMgXIVvkReKy7lNOdau6OA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IrDX6MAphjUX5OCl0vTCR6tKs6jGJirQSs7eRQk0h9xXtRuHxXP3SZApF4Sy3bv85c7BuDjI8yGZFPZGU9NYo8Tdo8Gv0T1IXozqVqWmY8BI/PqVCIwD3XdhZyKUZq/oinXAXXjOouVG4W5tM7mimesi22sH0W9c84DJIACaNic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=SbJjOXOd; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvIBY6B2JKGi6BAkVD8e5e6y5aQrZFfVJmNDqCsUhcsrXJgXfIgUWonFKmdaZdM2hD9Bek6IAjPz946dTTPbdxg4VySQENwkttQZYTwJSetqgavwehlvYiybp9T713qo7+iG8iTxUaBpr4xIX9XcEgX6ZAPLzd7hpcHd2pYTU5L3AMeNhdyP3nqQzFW1UORZq4uGwYOIhWIrvg/PYP64t8BJDbxbpI1x3HCEat0SPW5rO1L1m+IAG/hsJrAIsC3hbRCENUvLdxdNmP6VBRfSTvdx8guYBqLENNo89IhL+/bDCrJoj7QbImpTRFHrc8XOU8QBR7wGP/yr4ckfO0RoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51SeA1ikXWU75ADDrb1v+u2K3gZmXe6Mfk0HHinRB/8=;
 b=WJnDjZLDSp8cKOtMz1F87PukABTLnIXYxa96AxI9h2csAP3sJnzgZZb08o8yY8dd+xCFjXUVGqWolEnnjyIY/CT3KTJBFnXL9LyvSBru7v9GSIfxL+Vr/lB5z3mzb/GY1vV9pCHuehDnUXCnA2H6V60dhDL4RKeSvhq+BPZVcqWefKac0OnyHSPvM53YQBoS6vTBqajAnOyXmkufQCcEhoL4KsTmCkB2sZzX8PkjJgrp0zPz5dVI37l/aELNx9xwlCZd3A9FhsDwapzK/FfjJ/kbjEhs8YiVUSictRZpU4SNB9txZnDBjQYgBCvqSLkwOcjWVvs8zvgNrg8/2RIi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51SeA1ikXWU75ADDrb1v+u2K3gZmXe6Mfk0HHinRB/8=;
 b=SbJjOXOddcgGM4zsOerjt2dpfAwj1vQk3eQiFfY7BzMbTYl6vtRxzPU0cQj4Fg720QLGtutDiOxMRYBy9xF4VVONKorQNVsW6HKNDzA/AuM8ak5eXSH9O1qJzt673/yaBQI9tMZg5xWsdmHKRpWJRU7IfQEU+P6NGAYjtTzI+YY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA2PR10MB9114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 07:16:15 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 07:16:15 +0000
Message-ID: <c655e745-0289-4d12-9d91-612c18d6e607@kontron.de>
Date: Mon, 16 Sep 2024 09:16:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 neil.armstrong@linaro.org, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240914112816.520224-1-aford173@gmail.com>
 <20240914112816.520224-5-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240914112816.520224-5-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA2PR10MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: a587428a-821c-4e83-557a-08dcd61f73a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3RmdHFnaloyY3AraFdxNUkwUWJuU21xenZMeE1kTWtjRW9hbjBtWExTeUZC?=
 =?utf-8?B?N2gyNmtyOHE2UXpDNjhvNERXTUJHVS9HYVltOU9LWENHR3RxaXNCZS9ldlhi?=
 =?utf-8?B?TFFYTzI3VFFVZUcxbGhhUkl1WWNtNnNwbmhVNFhZZlgxVjZ0NlQyZE4yY0VH?=
 =?utf-8?B?NlF0Ymd6eUwzd2JvYittcFNUaTBhdVZVMlFZcldVdW83bXc3SVlzLzUwc1gy?=
 =?utf-8?B?dnZKYXNWcVlRd0FvSjhmNnpnN2FLZEJkcDJaSVl1ZUxjaG9MU1cyVGZGMUVU?=
 =?utf-8?B?WWlMK2YwdkF6ZzJsWERPVDViNmoyRlRsRFYzdkpSVjhnbjIvRXFKWXZrQm9s?=
 =?utf-8?B?MWVqaG9RSWhTNHV1UWErSVdKRDgvWXduVE81QmZTd25jaG9xcm1rMkUxSWRv?=
 =?utf-8?B?NWdDVGZVLzBKYm9LN2dhSWRUUGhjcXhiL0V2eGwzbzlhL3BVOHZ0UFp6ZGs2?=
 =?utf-8?B?T28rcGp1YldMdDYrazZtbStPY0I5eEJWL2tVNHNXZ1FtQ0dadHlHcjg5ZXpr?=
 =?utf-8?B?MDJyVjlsdko5MlJaZ2FYTVhSQVFlZzcxVW1YdzZyNFZQYzN6blk0a0VFWWJq?=
 =?utf-8?B?b1JSUHpTQ1VXczNDSHVMdWQzRWhQcXhMVHBlTUVMZjl1Y1Q5TUo5TGVVYnpK?=
 =?utf-8?B?KzlZd3EwZXpDVDFtakx0SFQyNWRNNHJjUE1CRWFFdm1GaDlIVnpmVjE1NVZC?=
 =?utf-8?B?MDNTRFVJWFdpSW5NYWw1bVBiMWZKUUJHMjY5dmI0cUU1R25LSHBGckY0ODVt?=
 =?utf-8?B?djZSaC9tMlJWaGJINWp2QTZlbWlFLzNFVFNrV0pkWVkyVUJzL3NwNnFaYUl3?=
 =?utf-8?B?UUh1UDdEK21Hc2g5V0k1K2pGNjZGaERTTHJ4QStIOVpJb3N3OUVpUjc5Tm1y?=
 =?utf-8?B?bWlhSjREM1lXWTd3RmVVUXlGanhrRWZNWlgrUWxvQll5MGJONDIwTzBUMVU4?=
 =?utf-8?B?dU1NbFFpSU9jMzFMclJWVEloMyttTU5SRUNXRVdzTlc4VGlmdWJsUXh6R1Yr?=
 =?utf-8?B?by9GMDcrdndGZjNuYXdaUlhjUnVSN21oWUJhTVpucVFWRGdVclBLbEcvY3BQ?=
 =?utf-8?B?RkM4aGpoRk1UMlFHSmpTSkdTT3prV0JJcUdIQlY5T0daVGVvVnBFSndNZC9L?=
 =?utf-8?B?alZ4L3p2aFJHSUIxSy9DR0xRMTV5cGRKbFVFanJoNjBNV1g5aFRidk5VMHV3?=
 =?utf-8?B?NVVpOVY3dnZrN2JMdEF2Rkd1b2pQNGpHc3JaT2ZacUFsRFBzQndDQ0pHZlk5?=
 =?utf-8?B?MHQ1Qmp5ZzBjbFQzczBaUGgrODVhNnF5M3RWd1o2d3JCN1FFQXBZM0JTNmUw?=
 =?utf-8?B?dllYcC9OUHZxYmlUSWNHcDFjWDFoUWhjbDJGODY4YmxWdXBMd216WnFaQ3gv?=
 =?utf-8?B?c3ZkUm8yeXI3bjN2SXRKNE9FQTByb05wZHp5UGF1U2locmpPQmFlU2NHY1Va?=
 =?utf-8?B?T0JPaVNwQzFMN01Yem91RGxrTm9vdmViejV6d1BHVVRHcnJLVlpkRWNsd0hz?=
 =?utf-8?B?YlpBbWl4a29QVFl4ODN2aGhDcnFDYjk0SVlJSkZUdW82UkpTWml6ZmZFaHdW?=
 =?utf-8?B?ZjA0QW5PZUVIdW5LVXNIRjhFZ1NURlBlMTlwVlZsRkdFU3NsdDQrdGIybk85?=
 =?utf-8?B?Yk1NVHFoT0lmNnZMNXVpN3h3ZGF5MkNhaFZlNGZTeW40UVBqNlNDTXovY2VX?=
 =?utf-8?B?SHYyM0twTi9oeU03Vi9ZTVFiQ0k4R0FYamVpbjU2ZnlQZDdub0VuZHBTU3BY?=
 =?utf-8?B?YXFOaktiRFlmcExkVHV5MElldmNBSlZ3RGpISDE3MHFGWmpKdDZDS0d3cGM4?=
 =?utf-8?B?UnFYenMxc3RXZWZ1WW1yQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1RBOGVhWVc1dWp3QVZUSVVyYjdNVDkyamthYnkwbDZWYWlMT2hXTDU2VTh2?=
 =?utf-8?B?dnZZeGRsLzIyTnQ5OUd3L2lsdDllV3ZnNmdzWkJieVMxcTNJdEMxUzA1QUN2?=
 =?utf-8?B?bXVDbUF3Sy9kZDN1VGxJTmg5TjZlWTNxb1lyUXV5T3MzNGtjMmFFQnNNYTR6?=
 =?utf-8?B?SkhxUVJZR0kxV0tIeWlZUVQ1bGsrUG9QYmpUQlo0bW02TmtrNkRMQlZQZFZm?=
 =?utf-8?B?cE1EN3ZvbEI5VUtNVUJwQzR5bzRrSXEzMXh1akdLSmZSSWJvWEJFcTQxNFZW?=
 =?utf-8?B?akFtbG1CajlEN3l3RUphd2ZQMFhGamFTeXdhR2M5M255S2xteVpubDJYczlz?=
 =?utf-8?B?bWw0TVpHbXpLZ1lkTDZjRDNRNEZNdUx4VFVONkhjdk9JM2t5eGtHaEtDRTRD?=
 =?utf-8?B?UXVyVEs1RHJ4RUptaGFTUDF0UEFFejlGQ2VGbkoydEVaOGtzRC9lV3BJVHBH?=
 =?utf-8?B?WTRZK2xWNEt4TCs0VmpsZFAxYXIwOGVrVUZndDZRV1ZteFM5SmJkbGhvQVpO?=
 =?utf-8?B?SUlHNFRYdTNnQWZNNy9FbHpid3QwNytkdUE3VXZFZlJiNlJxSXFvL1RZTERQ?=
 =?utf-8?B?c05XNTNlb2UvY3VVODRBeHgyaS9zd0hyKzc0QlRUQi9CNkZBQ2lkbys2Zzln?=
 =?utf-8?B?TXkxdXJyOUU4YUwzaUdFYzVjYkppK2hOdkhUTWlvZ2hyUE1UbXp1UTh1VUFV?=
 =?utf-8?B?NlRIMEJDR0dUOG85bHRDRjcxNGNSaXVVci9HdEIySkFocGpIOUgyMDRJMnBn?=
 =?utf-8?B?QnFyTGh3K29NL1JYeDBQSUgxcVU2TnpzR01QWnNTRVhuRjZxSzNzMmxRcm5m?=
 =?utf-8?B?dldDUXc3OEo5S1FCYmVKNCtwNS96djJHcm9mQjltZkh2VXhrNWdpZXpwZWw0?=
 =?utf-8?B?alFQbmMyRlVLNE8rWFJISnlhcUdSUWEvUGI0Q3Q2N25SOGw0TFAzSmhNeWE2?=
 =?utf-8?B?YlN5WXZYSUVKQzYxY3JhclNqYzkwRnlPMFpVTGRFSWVBcnlvNTI5V1cya0h4?=
 =?utf-8?B?YkQyb1A5dkNFeUVpWm1mbXZYMWl1Um1HRzZRRWQvT2IzMTVpUElwRzYvRXJ2?=
 =?utf-8?B?dUdmWkxUZFN1aHNMTGVOUElzZ1RDdWx0K0c5UUFvejJ1TWxxaTF5aEFTME9r?=
 =?utf-8?B?RTBKZ2w0MFZJcnlyWGJTRUo1amFHVWFaQ0RoSEhvb01NRG9FZVZ6dTQ5bWdq?=
 =?utf-8?B?YUwvQTFhVEdPNWVtRFFFNlNrUEtaUHFLdDRaUFg1YmZwUmFxUjBhM0NET2NU?=
 =?utf-8?B?VWt5S1oreS9Vb0d0NGdpTFdEZWhsTkladTRUUTBIZ3NoZng2Q1VpU1ExZGxK?=
 =?utf-8?B?VFMxNEZUcFhEdkcvRnBTb21uZ3JwcC9oWkd3TW8veHEzb0VjNlhOZDhXWFp4?=
 =?utf-8?B?bHJUNTBxOFpDQmFxMko0b2hEeVk2cEJyL1cyT1R4L0RjcVZUbVpvcmJ1T2xW?=
 =?utf-8?B?VXNlZFIyWnVlVUVPUHplWUhTM3RUWGIwQTRGdkF2enBlOWFiMys2bGR6Y1pJ?=
 =?utf-8?B?RHIycFFQMnJydks3QzBYUHlzZTRQTmFtNXgvZ2xPZ2M5djlyRzc4VGgvd2h5?=
 =?utf-8?B?WXB2TVFBRlZQTkUxbFdMdmkyNkZONlVzT3hNbEduekpGSE5vMmZ6aGgvcXBw?=
 =?utf-8?B?Ky9XcHdGWElMMkZoTTdZbGlWZHFNNTlPQmxid2wvc0tDRER4ZzE2VFN0dEVH?=
 =?utf-8?B?bnZ0bTdlUGhlWG5LNVBEUGVqRWVSZDIwL0xISFFOVE5LL1BFQ1VaeERrUnFk?=
 =?utf-8?B?NXUybG9US1Axd0F1N2tza0RmSWZ2bDAzQkJvR2krbUJYT0FveFFSR2NTMzdp?=
 =?utf-8?B?YU1Ma0ZpL21jVkk5VUJmblFiVUl4Q09TckwyRUV6MFlBOFl1Ly9EKzd1Q2Fx?=
 =?utf-8?B?aklTOUsrOU1MTSttYjJOUUs3UWhZcFpoR1lIQlVuVlZ1SXo3bDl4Qlk1dHE5?=
 =?utf-8?B?MHVvV3NxTXlmaGxtL3czWHNsbjZTdGVCU05rQUk1RGxGbGhkdTViOWlhUWVs?=
 =?utf-8?B?bGNMcHl6Z3AxU0hjVDlwY3d3bjJkdEJMZkdrUEZ1Y2w3WTZvait3dnFrUUg1?=
 =?utf-8?B?T3FZaUl0cnJZVU41NHlkQzhyaUNWK3REeVgxK1ZUelRQTW9IY1JaSVgyV3Uz?=
 =?utf-8?B?bmszd0hybDZiNnlHY0VhR016OVE0Q0JqSUN3aEVBZEtrMFRXaGxGdDlGaDVQ?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a587428a-821c-4e83-557a-08dcd61f73a9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 07:16:15.3855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMMAKps0V53VZ3thwYF7LEYPKKGbNk7jFNJEfELjkXKM9Q/ypK1iECa1W/7edgyQQ/ZOs1ZawBkT9LxEP25+UoWRvlO+aiuYYnB7UbiIXMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9114

On 14.09.24 1:27 PM, Adam Ford wrote:
> Currently, if the clock values cannot be set to the exact rate,
> the round_rate and set_rate functions use the closest value found in
> the look-up-table.  In preparation of removing values from the LUT
> that can be calculated evenly with the integer calculator, it's
> necessary to ensure to check both the look-up-table and the integer
> divider clock values to get the closest values to the requested
> value.  It does this by measuring the difference between the
> requested clock value and the closest value in both integer divider
> calucator and the fractional clock look-up-table.
> 
> Which ever has the smallest difference between them is returned as
> the closest rate.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

