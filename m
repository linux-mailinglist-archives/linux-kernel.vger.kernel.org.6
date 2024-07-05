Return-Path: <linux-kernel+bounces-242383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A6E928762
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19D1B260CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1E148840;
	Fri,  5 Jul 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="CiogtQ+j"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021130.outbound.protection.outlook.com [52.101.65.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3511148FE3;
	Fri,  5 Jul 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177198; cv=fail; b=ZkqoUfbh/MWoQKLW+iXak16UUcaTnCBq4OTnmHTF6TMqBqBH/o+bDHiq8cAmqY2Z2evAiy90gQZicfWSDfVaddA/SeyeZ1jmqJI05s24+9ZQGwsHe2a6lUfTM48oy/Yze/i/nkkg9X5caANJBhI5oRfnhZlse5S+f/dqlnv1GMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177198; c=relaxed/simple;
	bh=WL7VcALPnUvBV6CyRFgCqYxWzmtDeDK27IzsrQ2o4ts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WILcwOS9JZ8nnQDvfXnxHJc85MQfagT4FJcSR3dB89Rzm8AtK9ad8m3eoMkt2aDewxPaMUvZxrqdheKzgRQ7FqGjByCPGncFhJc4o5N4rjpT8EU2yoD7EkRijozvr95JiQXJEws6gkeeGKTLTI/fJ1odQxLgvSM76fVz5mrBNEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=CiogtQ+j; arc=fail smtp.client-ip=52.101.65.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0HMXnKjXjkeH4aPIyEGqazWVQYtTjbZLQxkfgFDtHcqoP7NnElyyvUHrkMthKhAj9nsvlHKIqyJ1pY4HQ8XBp69bfBKJamB/UBC9zQm5xrfN0cWqXoHHt28vaOdDgbOsYOJjZgInX7Ox9oSb9YesbeA0sus0Cj8x6as8Je1Uf12mqJbpRM1rwbc+3Ll52SfZ5SIpgpolLT3kFrqLacYA0kImBID+eHRRZDnXQG3Kj6A4c9AqDfBCdelA6oAB5oKWl4Qbrfqb74nlqpzsGkx9V6KjUeBbvKcZV1NzTzZJiTldQsJRtMXWFxxcJtb0w1rJXIhqmm71/PueY1CK+NbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUB1cxR0TxqHZZC60UPV1wcGjqbkoUSZMf5UW5c1edA=;
 b=QJ4/WlIG1ZVNn0Cb/zQ5jn1bGYlHSTbhNAnfOP3A+fLKX6xt+/5oJo6SLA5bSYHMfaxycQ57LhhOhRtoXGggo7FDJNSPYLAH/15qDwchupc19sv1my0r/uP0x0LWUhZPXtSizlq79xTR+yGhJ4YZJ9HHc+n3+pyov3qJBolqcSzWSlfBvVaLB78dH5twsSGFYwbaYQG9CFfxea5tPCCfnp9rNSyegeOyAu92MzF0InHxX+skM2Yhnoi86JDvC/+vGDkIyXS0k+Dw2bX+VW7PuZAJgAEylRtRZOaVOuY6bhTeixqr4A++aziJS1FGShOWvAR3B+/HC491a0jHoAuB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUB1cxR0TxqHZZC60UPV1wcGjqbkoUSZMf5UW5c1edA=;
 b=CiogtQ+jJDHcBdcbrFq/Av1q2dc32YDzwJ/33NsUQPY4PGwvhdfF9rD4fswkEi+Ol2gHNDxvLul/B0ZfHN2FZoB1vs6kP7x7lG5scDHVwDMNRutDN/fSBcSvsxDDghpAGpm9/id+GqQRKjPXGC/Lk/MNKm0mW2ZPlYERexLgBw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI0PR04MB10300.eurprd04.prod.outlook.com (2603:10a6:800:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 10:59:47 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 10:59:47 +0000
Message-ID: <773d8bea-7ddb-4138-b75c-219a52c82fc6@cherry.de>
Date: Fri, 5 Jul 2024 12:59:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] hwmon: (amc6821) Convert to use regmap
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240704175207.2684012-1-linux@roeck-us.net>
 <20240704175207.2684012-10-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240704175207.2684012-10-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::17) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI0PR04MB10300:EE_
X-MS-Office365-Filtering-Correlation-Id: 113b4949-276c-4a84-a5a4-08dc9ce195b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTZDbGd6c3pZamZHNnlCcXdTMGZFSWpGQXEwVks0SGw2eW5SeEwwR29iWk9W?=
 =?utf-8?B?Z2hYQjhmbXREbGxPcHl2Q05lZlVBNyt6QzlZZ1hhSC80YTBBaEdsK1NrbU9G?=
 =?utf-8?B?a3Ivb3ZJcTFuaHV1NjEwODlJL1hNc2lMbUQ0OXlBc2dkRG5EQVl5OE5OMFlE?=
 =?utf-8?B?V1orZFRJRllIRkUxUzdXVWR1b2VxZGMwejJpSDZDNjVUSERMYW8vMlh2SkJk?=
 =?utf-8?B?eDFQUHVFeE9LWmE0aFBZK1dJbzBwS243TGIyQ1NCczZSSGd2ajJFcEw5VlRE?=
 =?utf-8?B?bXdpTjM4N2svVzhGM3dCVWh3Nm9NMUJ0SVMxWXEwT0w2WElMR0tMMDJ2Z1Nm?=
 =?utf-8?B?WTNNbnRnQmNxRHRwSk40UGlEZ0V0ejI5U1V5d2NjZWwyUW5jSnhGTWVjQlpO?=
 =?utf-8?B?QjM1ZzRWeFRvUWg0TVdXbHR2WEg2NkduK1pvcFFycTBHQTRjT1gzenRNckRG?=
 =?utf-8?B?NkZZZHZ3eHpZbU13NHNSbTk1MUdNRjdpd3Nqbk1iWGVSRU40elYxUUxGSllh?=
 =?utf-8?B?Y2xBMXRLT0U4ckJXZEpwSFZLdFNnTWZrRm1rSUFQUlgxQjQ0a1NwN0drOXFW?=
 =?utf-8?B?Q05BUnVIbjRxZHFQRnVwM093UjhEUTVrYnp6U3ZNSjFrUDlTdmlKWFY2S0pz?=
 =?utf-8?B?aTR1Zzk0K2VnNkV6VUtrYlNkc0RsOHIwWmZFRGhpRzNoLzc4OTltNkx5Q2ZK?=
 =?utf-8?B?K0FJODZBSm9Rak9jYy9VU3o2dCtzSWtzdG1udjlwc1FnU3Y4aE1ETXJZZ0tQ?=
 =?utf-8?B?bTVERHFjd21qWk5LY003d0Y1MGlCckorcWU3WFpGNk5lY0dEY1dkSEE1ZFFs?=
 =?utf-8?B?ODNkQVgvM3JRamxtTUNuTXVrRHB4Um81OUF5VmZldUwvc2pBMDhJNytOb0Fi?=
 =?utf-8?B?WDMxWThTN01FT2RLOXgzVEFXY2FHQWxIMkNWcVhpa0JRZC91ZTlRV3pSWEpz?=
 =?utf-8?B?S2xIeU9wRllJK3FyWmZHcEN6eUQ1Z24zZ0x0aGNCWHE1YU5FZEUxZENrYStH?=
 =?utf-8?B?MkZoMVI3NnlzY3EyUU1XSE9mWm5aNEwzUmQrMS9kU0d6UGxnNUxlVG9kRHJ3?=
 =?utf-8?B?TzFMWHdDZ1JIa1dpbW1oRTM4MlA5Y05mYWhSS1ZUSTl0emlwQjM2cFZjZ0Nz?=
 =?utf-8?B?R01zUHFWVUR3RGo0YXNKMzcwbkRscGwwVHpiNDh6REF6MHFZY1FodWtHTkZK?=
 =?utf-8?B?Q2ppaVU1NmVMamJPQklieDUxeTl5MU14bVZqU1VRdDJUOU02S3M1OGRrWTZG?=
 =?utf-8?B?OUM2aXMrMUFCQXNYOGt2SFdGV1EvKzVBTjJ6cGhCQjJ1OUwxdXVQVG90eWpq?=
 =?utf-8?B?ZTY1OW1oQmpVS2RTckFQRnd3Lzl3ZWhTbXhoajVqNEc3LzZZNE8wMGtUS2FF?=
 =?utf-8?B?NnRNRTcwdVdVcTlLeWExcFRpWGZ2dmlQY3dJNjZqSlJzOFF6VHczWlhjM3V6?=
 =?utf-8?B?VE5SOVRIa0FxcDdrQ3c1ZzZRbTBZWFhQVngzK2RaelZUL0NVdEJyMnJrS3Nt?=
 =?utf-8?B?WlorRWh4cVJLNDF4ZWcyY29zZnV5dVIwQ3hobklVSXhUSXo2dTZsUHVUOTJl?=
 =?utf-8?B?RnBRNmdCQVRES3VBNHNrL3owbko4QmZkWldKbmFUMjdRS2c5bFdqck9GT2xy?=
 =?utf-8?B?VnVtNWxEZU8xVFNYRXpueXA0ckg1QXFuOS9DczBEd1c2OUVGTE5ybC9mWEVO?=
 =?utf-8?B?SWIxeXdaNDBVc0dhdnNZRm1tUjNzbHJBR1Mzektaa1NYditLeS94THpiTGJV?=
 =?utf-8?B?ODVURXhyVmNwTlZxUllOaW0wWnREV3E1cmFOM053QTVpUHhPZTZqcC92UlVU?=
 =?utf-8?B?MitneklzbnlpMmU0U1Awdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0l0Q2VDbnRYNEQ0VXhFZnVoN2RjbmlOWGEvYXhXY1I2T2JIMDgxVEVJbys1?=
 =?utf-8?B?blJ6ZGRkR2xtenNOL1gzcXYxdnptZ1huUHV6VGZId3Z6Y2l5eWRJTll6Zm5B?=
 =?utf-8?B?aU5XQmlrZ1RZVlcxa2FhUmVYQ21VY0ZhMWkrTnVqbTh6VWRUWUpuTW1WRk42?=
 =?utf-8?B?T3RxY0JNTkd5TitSN0tYUE5zWVhBanpJbkd3ZkkwN3l0ZjVRY3dtVFdMTkJP?=
 =?utf-8?B?czVEa2JpUEZBRjV3dEp6a2xEVFBQZkpPNjZtUTU2K0dYS3REMjdCSVQ1b2Jq?=
 =?utf-8?B?NUlPaVkyS1FTNjBYeEtyQm9jdDhYdUxQTlMvV1Zhck5KY09yUWtLeU1ITDh0?=
 =?utf-8?B?bW5jc001UGhYMjJ3dVdFeDB6YXIzUFQ5RzYwWEF0V1UxTkpqYlZwd0drK3VC?=
 =?utf-8?B?VkxKSC9Wb2NsU3dxYzQzQzJRRmgxWXA3TXZYTTdQd0lHclBSYzQ5b0Zqb01G?=
 =?utf-8?B?MlFHeVdneHpKTGlaVkg2L0drdzlxVngzRmlES0xvUHpFbTVwc2RUL21aa3pJ?=
 =?utf-8?B?OGpETHQ2K1k0Tm50bzdOYkdPNEE0ZVlKM3ppL3BPT2pLeE5tbkI1VHJ3Z3di?=
 =?utf-8?B?RU9nOUZrbE5tTS9RajR2c1YxTzYyNHlOdXBKMFVEaVZiMWExV29lS0gzVGlW?=
 =?utf-8?B?SmZkc240eHlORzQ0MXM1U0dTQjBiOUpuZnlFcStZV2NqYUFwS3BGY2xQVzNq?=
 =?utf-8?B?d014Mk4ycHIvQnhQNzFjTjhTY2JqU2JQY2NmS29BOUdCWHAzNmFjMGJPU1dz?=
 =?utf-8?B?cFU2M3VLTUhyN0o5eCt5anJaNWV2ckRNZHVBcGZ1ZStxTGh1bHRNMDVqRUJX?=
 =?utf-8?B?a0d5MnlmOFlsVzhyV3oxOEYwejNKaVJTRVdXb1U3VEZBRExMdnVKMHVwODRu?=
 =?utf-8?B?R29NWHNkMGgvOEdDL0Q0R2dleXR3d2xwOXBwVWxJOWRUK1l5eVhBNUMvaEJX?=
 =?utf-8?B?eHRxZm5NKzNiZ2g5SHdzcGxHdmIwak83K3JkbXAyS3NqeUI3eGZKbllTNVpH?=
 =?utf-8?B?alNHNzFOa0ZpN3NyK3NUMVUyZFRYbzhEdXFETGpFVjBybHp1K29XWm8xVWFy?=
 =?utf-8?B?Z0FrYmQwbFdqbnk4bFFZQUFueGxBU28yQnNyZE5BdWttOWxRTXFSVmt6eHJT?=
 =?utf-8?B?dWJFM2dIcThwV0k5QU0wL0dnMzQwTFpYWTJpbW9TV2ZJU0hJYi9qUnJDZFJC?=
 =?utf-8?B?dWtsVnBJZlJnWUpHdzNUV1JzWTBvOUJLQnN0SVZ4ajE0ZlVMV051ZHJsZStD?=
 =?utf-8?B?cTJDdkZWRjJiUi94VzRaL3RWaE5sMmNqaXdyUm5mNzlIUDQybHNQVThYOUts?=
 =?utf-8?B?NnVsV2xxUFlRVXZpSGpZNnJ3ZFJuVTZSbStEelg0UGc3ZGRQZGEyQkpyZGN4?=
 =?utf-8?B?RzBqYVZiS3AxRklQYnkxN0lONjF1M09CRTl4Mk5oSGFYOWdiNnNUSUlmWHdS?=
 =?utf-8?B?OTR6MnZybFJQT2hyaXFESDdLTityZkdHMVJnQmp0emREY1o2RTlla1M5MzVD?=
 =?utf-8?B?NWZ1STN5Y2NNL2hXMUxQcFQvbHBEeFBTY2dqcklUK29JWUJ6cnpUV3VWalNC?=
 =?utf-8?B?Sjl3Vnd2OHQrR1R3MlRBSGpRbGJpYjhhL0ljRGk1VEo2U2ZZR2pOOW1sSmhV?=
 =?utf-8?B?SmpkSGZGQUtFM0I3UlllamxLZkpOWnZ6aFU2aGZFVnB4TFM3S1FKV2hUeGpa?=
 =?utf-8?B?YkNTc2hFbTlRZUJrSENGaG9IWi9VMm9ZSmxWQW0zTjBmdnZLK0t1VXptYVhn?=
 =?utf-8?B?bmhlRnNNc1RFQ1AyVkFkamJzZHEwSXlkWWpENjVvMjRrK0Q3TkdLbFpkMTh0?=
 =?utf-8?B?WGNFSXRqcXFma1lDcHFQczlyc1RENWk4SlZiVTJTTHNRVjVhZEJqUUZodWdC?=
 =?utf-8?B?Q0pTTGdLYnRNc0JUUW5mTGFJUTNlZzdmUWtCaHhxN09ueGZUSldJUzBGamE5?=
 =?utf-8?B?SktDUVdpMjFVWGhGR2lqU3hPM1JzaXNMRzJJSjc1TUgwK0ttNy9PL2VVVG03?=
 =?utf-8?B?UlVKWm9ySlYvVkI2UklrRVNGbjRhMWFteEtlU0lBdXlFUElOdzVvblpyUzls?=
 =?utf-8?B?eTBoNVV0Um5iaWxXeENGVnRHMDlqaXRubUNNeE5SU3dOaFM1WTdVUDZCRCtu?=
 =?utf-8?B?UGNCazdjQnBZZHU0TFBSUnhMdFNDOUV4NXNlTWZKNnpSenkwTlV0WlBjUXB6?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 113b4949-276c-4a84-a5a4-08dc9ce195b9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 10:59:47.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsqIuoEEEMWxo16EUQ2VtvJa8kR/pnOLgnW4bbvOJVYSUKe9hbjpDwCpfMTK6TcsFew7C+Tz3lAMCudcvTp4iCc68eLO+YKYxJAXBI98aPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10300

Hi Guenter,

On 7/4/24 7:52 PM, Guenter Roeck wrote:
> Use regmap for register accesses and caching.
> 
> While at it, use sysfs_emit() instead of sprintf() to write sysfs
> attribute data, and remove spurious debug messages which would only
> be seen as result of a bug in the code. Also make sure that error
> codes are propagated and not replaced with -EIO.
> 
> While at it, introduce rounding of written temperature values and for
> internal calculations to reduce deviation from written values and as
> much as possible.
> 
> No functional change intended except for differences introduced by
> rounding.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Add more details to patch description
>      Cache all attributes
>      Introduce rounding when writing attributes and for some calculations
>      Always return error codes from regmap operations; never replace with
>      -EIO
> 
> v2: Drop another spurious debug message in this patch instead of patch 10
>      Add missing "select REGMAP_I2C" to Kconfig
>      Change misleading variable name from 'mask' to 'mode'.
>      Use sysfs_emit instead of sprintf everywhere
> 
> 
>   drivers/hwmon/Kconfig   |   1 +
>   drivers/hwmon/amc6821.c | 812 ++++++++++++++++++----------------------
>   2 files changed, 373 insertions(+), 440 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e14ae18a973b..a8fa87a96e8f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2127,6 +2127,7 @@ config SENSORS_ADS7871
>   config SENSORS_AMC6821
>   	tristate "Texas Instruments AMC6821"
>   	depends on I2C
> +	select REGMAP_I2C
>   	help
>   	  If you say yes here you get support for the Texas Instruments
>   	  AMC6821 hardware monitoring chips.
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 295a9148779d..a5abd36a1430 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -8,15 +8,18 @@
>    * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
>    */
>   
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
>   #include <linux/bits.h>
>   #include <linux/err.h>
>   #include <linux/hwmon.h>
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/i2c.h>
>   #include <linux/init.h>
> -#include <linux/jiffies.h>
> +#include <linux/minmax.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/regmap.h>
>   #include <linux/slab.h>
>   
>   /*
> @@ -44,6 +47,7 @@ module_param(init, int, 0444);
>   #define AMC6821_REG_CONF4		0x04
>   #define AMC6821_REG_STAT1		0x02
>   #define AMC6821_REG_STAT2		0x03
> +#define AMC6821_REG_TEMP_LO		0x06
>   #define AMC6821_REG_TDATA_LOW		0x08
>   #define AMC6821_REG_TDATA_HI		0x09
>   #define AMC6821_REG_LTEMP_HI		0x0A
> @@ -61,11 +65,8 @@ module_param(init, int, 0444);
>   #define AMC6821_REG_DCY_LOW_TEMP	0x21
>   
>   #define AMC6821_REG_TACH_LLIMITL	0x10
> -#define AMC6821_REG_TACH_LLIMITH	0x11
>   #define AMC6821_REG_TACH_HLIMITL	0x12
> -#define AMC6821_REG_TACH_HLIMITH	0x13
>   #define AMC6821_REG_TACH_SETTINGL	0x1e
> -#define AMC6821_REG_TACH_SETTINGH	0x1f
>   
>   #define AMC6821_CONF1_START		BIT(0)
>   #define AMC6821_CONF1_FAN_INT_EN	BIT(1)
> @@ -108,6 +109,9 @@ module_param(init, int, 0444);
>   #define AMC6821_STAT2_L_THERM		BIT(6)
>   #define AMC6821_STAT2_THERM_IN		BIT(7)
>   
> +#define AMC6821_TEMP_SLOPE_MASK		GENMASK(2, 0)
> +#define AMC6821_TEMP_LIMIT_MASK		GENMASK(7, 3)
> +
>   enum {IDX_TEMP1_INPUT = 0, IDX_TEMP1_MIN, IDX_TEMP1_MAX,
>   	IDX_TEMP1_CRIT, IDX_TEMP2_INPUT, IDX_TEMP2_MIN,
>   	IDX_TEMP2_MAX, IDX_TEMP2_CRIT,
> @@ -130,224 +134,155 @@ static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
>   			AMC6821_REG_TACH_HLIMITL,
>   			AMC6821_REG_TACH_SETTINGL, };
>   
> -static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
> -			AMC6821_REG_TACH_LLIMITH,
> -			AMC6821_REG_TACH_HLIMITH,
> -			AMC6821_REG_TACH_SETTINGH, };
> -
>   /*
>    * Client data (each client gets its own)
>    */
>   
>   struct amc6821_data {
> -	struct i2c_client *client;
> +	struct regmap *regmap;
>   	struct mutex update_lock;
> -	bool valid; /* false until following fields are valid */
> -	unsigned long last_updated; /* in jiffies */
> -
> -	/* register values */
> -	int temp[TEMP_IDX_LEN];
> -
> -	u16 fan[FAN1_IDX_LEN];
> -	u8 fan1_pulses;
> -
> -	u8 pwm1;
> -	u8 temp1_auto_point_temp[3];
> -	u8 temp2_auto_point_temp[3];
> -	u8 pwm1_auto_point_pwm[3];
> -	u8 pwm1_enable;
> -	u8 pwm1_auto_channels_temp;
> -
> -	u8 stat1;
> -	u8 stat2;
>   };
>   
> -static struct amc6821_data *amc6821_update_device(struct device *dev)
> +/*
> + * Return set of three temperatures:

It actually returns 0 if successful, negative errno otherwise (matches 
regmap_* return values).

But it does write to temps array with those values.

Would be nice to say what we're expecting in channel, i.e. 0 for Remote 
and 1 for Local.

> + * temps[0]: Passive cooling temperature, applies to both channels
> + * temps[1]: Low temperature, start slope calculations
> + * temps[2]: High temperature
> + */

IIUC, we have different units there, >> 3 (/4) °C for 0 and 2, but °C 
for temps[1] ? If I didn't misunderstand, I think it's worth making it 
explicit in the docs (or make them have the same unit).

> +static int amc6821_get_auto_point_temps(struct regmap *regmap, int channel, u8 *temps)
>   {
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	int timeout = HZ;
> -	u8 reg;
> -	int i;
> +	u32 pwm, regval;
> +	int err;
>   
> -	mutex_lock(&data->update_lock);
> +	err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
> +	if (err)
> +		return err;
>   
> -	if (time_after(jiffies, data->last_updated + timeout) ||
> -			!data->valid) {
> +	err = regmap_read(regmap, AMC6821_REG_PSV_TEMP, &regval);
> +	if (err)
> +		return err;
> +	temps[0] = regval;
>   
> -		for (i = 0; i < TEMP_IDX_LEN; i++)
> -			data->temp[i] = (int8_t)i2c_smbus_read_byte_data(
> -				client, temp_reg[i]);
> +	err = regmap_read(regmap,
> +			  channel ? AMC6821_REG_RTEMP_FAN_CTRL : AMC6821_REG_LTEMP_FAN_CTRL,
> +			  &regval);
> +	if (err)
> +		return err;
> +	temps[1] = (regval & 0xF8) >> 1;

I think we want to use AMC6821_TEMP_LIMIT_MASK here instead of 0xF8?

I guess we could also use FIELD_GET?

>   
> -		data->stat1 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_STAT1);
> -		data->stat2 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_STAT2);
> +	regval &= 0x07;

I think we want to use AMC6821_TEMP_SLOPE_MASK instead of 0x07 here?

I guess we could also use FIELD_GET?

[...]

>   static ssize_t temp_auto_point_temp_store(struct device *dev,
>   					  struct device_attribute *attr,
>   					  const char *buf, size_t count)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	struct i2c_client *client = data->client;
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr_2(attr)->index;
>   	int nr = to_sensor_dev_attr_2(attr)->nr;
> -	u8 *ptemp;
> -	u8 reg;
> -	int dpwm;
> +	struct regmap *regmap = data->regmap;
> +	u8 temps[3], otemps[3];
>   	long val;
> -	int ret = kstrtol(buf, 10, &val);
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   
> -	switch (nr) {
> -	case 1:
> -		ptemp = data->temp1_auto_point_temp;
> -		reg = AMC6821_REG_LTEMP_FAN_CTRL;
> -		break;
> -	case 2:
> -		ptemp = data->temp2_auto_point_temp;
> -		reg = AMC6821_REG_RTEMP_FAN_CTRL;
> -		break;
> -	default:
> -		dev_dbg(dev, "Unknown attr->nr (%d).\n", nr);
> -		return -EINVAL;
> -	}
> -
>   	mutex_lock(&data->update_lock);
> -	data->valid = false;
> +
> +	ret = amc6821_get_auto_point_temps(data->regmap, nr, temps);
> +	if (ret)
> +		goto unlock;
> +	ret = amc6821_get_auto_point_temps(data->regmap, 1 - nr, otemps);
> +	if (ret)
> +		goto unlock;
>   

We could reduce the scope of otemps since it's only used in the ix==0 
case below.

>   	switch (ix) {
>   	case 0:
> -		ptemp[0] = clamp_val(val / 1000, 0,
> -				     data->temp1_auto_point_temp[1]);
> -		ptemp[0] = clamp_val(ptemp[0], 0,
> -				     data->temp2_auto_point_temp[1]);
> -		ptemp[0] = clamp_val(ptemp[0], 0, 63);
> -		if (i2c_smbus_write_byte_data(
> -					client,
> -					AMC6821_REG_PSV_TEMP,
> -					ptemp[0])) {
> -				dev_err(&client->dev,
> -					"Register write error, aborting.\n");
> -				count = -EIO;
> -		}
> -		goto EXIT;
> +		/*
> +		 * Passive cooling temperature. Range limit against low limit
> +		 * of both channels.
> +		 */
> +		val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 63000), 1000);

This was already in the original code, but I think 64°C should be doable 
as well? The datasheet says:

"""
The PSV ranges from 0°C to +64°C.
"""

And there's a PSV8 bit we can write, meaning we can do (1 << 8) with a 
step of 4°C which gives us 64°C? In a separate commit though, to not mix 
too many fixes into one, making it easier for people to identify and 
possibly revert them if necessary.

> +		val = clamp_val(val, 0, min(temps[1], otemps[1]));
> +		ret = regmap_write(regmap, AMC6821_REG_PSV_TEMP, val);
> +		break;
>   	case 1:
> -		ptemp[1] = clamp_val(val / 1000, (ptemp[0] & 0x7C) + 4, 124);
> -		ptemp[1] &= 0x7C;
> -		ptemp[2] = clamp_val(ptemp[2], ptemp[1] + 1, 255);
> +		/*
> +		 * Low limit; must be between passive and high limit,
> +		 * and not exceed 124. Step size is 4 degrees C.
> +		 */
> +		val = clamp_val(val, DIV_ROUND_UP(temps[0], 4) * 4000, 124000);

Oof. I think the issue is that we have different units for temps[0], 
temps[1] and temps[2]?

temps[1] is in °C, while temps[0] is in °C >> 3 (so / 4) because we read 
from PSV-Temp register directly, which only exposes PSV[8:3] and 
PSV[2:0] are 0. I'm wondering if we shouldn't just have the same unit 
when filled by amc6821_get_auto_point_temps?

temps[2] is also °C >> 3 (4°C step in the register). I think we would 
benefit from having the same unit here to make it easier to do maths 
with temps[1] and temps[0/2]. What do you think?

If we didn't have this °C >> 3 formula, we could simply divide by 1000 
to get the value and then do the same maths for writing to the registers 
(except a different offset for temps[0] than temps[1/2]).


> +		temps[1] = DIV_ROUND_CLOSEST(val, 4000) * 4;
> +		val = temps[1] / 4;
> +		/* Auto-adjust high limit if necessary */
> +		temps[2] = clamp_val(temps[2], temps[1] + 1, 255);

Is this why we didn't want 255 for temps[1]? Because then we could have 
256 here?

> +		ret = regmap_update_bits(regmap,
> +					 nr ? AMC6821_REG_RTEMP_FAN_CTRL
> +					    : AMC6821_REG_LTEMP_FAN_CTRL,
> +					 AMC6821_TEMP_LIMIT_MASK,
> +					 FIELD_PREP(AMC6821_TEMP_LIMIT_MASK, val));
> +		if (ret)
> +			break;
> +		ret = set_slope_register(regmap, nr, temps);

I'm wondering if we shouldn't put the writes to the TEMP_LIMIT_MASK and 
AMC6821_TEMP_SLOPE_MASK into the same regmap write, otherwise there's a 
small timeframe during which the slope is not matching the TEMP_LIMIT. I 
guess it's probably not that big of a deal but still bringing this up.

Cheers,
Quentin

