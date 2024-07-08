Return-Path: <linux-kernel+bounces-243840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE894929B60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EFB28145F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 04:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349FAD31;
	Mon,  8 Jul 2024 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iTIqDQjr"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB712E48
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720414332; cv=fail; b=CYZJwIv+vgjQbpiQ2UPKulKK8nB1txFlYFmVXBtfYzRF2ei2S1cn1PY7fsVeliOlemwpiJkOlSi/M67Z6jonmnV2Dbf98y1moRBT7Vdu2ade2v9wq1AewT40D1juzyLgfn3OHlK1Oy/ZK6Z9skqVNUGaU8WjCC8iG4ko5zbW1Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720414332; c=relaxed/simple;
	bh=O0YmSyQ0dh8i49PJuZLaiuUDnlzokAWj5VMd25WbDKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gupQG2ishRQJpS3tGwY+vuMna6QGwALkiTJs4c4KymeAK6XQO7ooi8OiEjNUs5CF/SUNvNwfAXGq5fq1QzJmlQW+DtMxpfMW/6lLL05QLKVSNX/ZCCQEVPnzQXhbWoFewA2C+nVbd3R/pN/DiS4mom7Sh5BC7WYE7z8uR97EQao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iTIqDQjr; arc=fail smtp.client-ip=40.107.215.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWBRevkq165Rpn+X7K/DJEOH0TK88RPSaUsUWutuS/iX648LI0DCzjZ7M3gskI2NeAXME9L5ZAtu6dIY6HmJW8LYNCfXIDUOW2otfZwCCDyZcKrmExvWVaSjonHoE5xsbEewwii7Ydm1lR+kk1NOTdAdRSnF5r9NWTK8VKaM7LE6y+aXLyF/AZVcpweQ0R7ZcqWVfQfGuu253Bwl0HIRceDNHZl3UTM3iZVrOcSg5kG6AA2+q8vBJh49JCWgOgeWsAn6cpXhCDPGbQ24+cO9NNc0jUZoHuzWITiOxzxiKbmjluK+5JWtnC69y2nuEf1KAv/WhoBx94kg5wThYEtDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f47ZYs0kJ1UjXWJ3bOaa1Yv43GAbRg3Guv5PDD+tPm0=;
 b=H0hyd4dl59D5oZaylbae9574j3mF0hhDlYsUQkATVDqJSUG6KbFnRjJkI5hXroizJn8l7Gcmxk28yiL3sja+rDdN5kh7l/5kUM+MvyuR0j4G0bhQPpdMantgS3Q1sFUoIUKcUFl+qF0ONLxi9IyTBdsYNMZqCBJ+lgOJ7fYTbQMxpgY02xtyFjUtTmRI3+B2rfGq3LqrHhJVxUJNdsIoo5GH53Uuqr2j885lZQDqyIX7nbeo8ZOw7fy8n2mgxZMfVA3ZETxolEDlLcRTYxHywgDHC7rdQ/4pdFZGzLLYhw8OiQ1wLrzq6TKks+OZiC0Yo/8Cyt/bpGQ8IvX9manFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f47ZYs0kJ1UjXWJ3bOaa1Yv43GAbRg3Guv5PDD+tPm0=;
 b=iTIqDQjrwEjAFmjMId9oHeWll6afAx5jmuT31pbGLQrYWuRf9XmN3eTysWuUxllePvXEBHj6AMQUEXeusNzToIpMK2fMyNOngE+McfKJInbzKUEFkX/mWc7Y6NV2D+82r6UfpoJNyGIJSwDG24YyoWEuUTqmp2gnqFYxhK26mgLV9x4hUu2eWnrXTx5sH/uVNBcsD1IkH2MIngaWkOLGwFMklMbTsMQOVpJ04gAMCUaBXeOE04BexIh+pg06qI9/efOWXPeV7Xtu8FHBl5aZmhg/awMb1Gskp2Kt09JE0XslBX/o/d729y300xvKYI7pPgUwUV4JEjQVs150zc77iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB5299.apcprd06.prod.outlook.com (2603:1096:400:1f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Mon, 8 Jul
 2024 04:52:05 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 04:52:04 +0000
Message-ID: <3260552e-7ecb-45df-ad18-71c10e8a8152@vivo.com>
Date: Mon, 8 Jul 2024 12:52:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: shrink skip folio mapped by an exiting task
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>,
 opensource.kernel@vivo.com,
 Qianfeng Rong <rongqianfeng@vivo.corp-partner.google.com>
References: <20240708031517.856-1-justinjiang@vivo.com>
 <ZoteOYap1M4kxWV8@casper.infradead.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZoteOYap1M4kxWV8@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe7773f-1752-49da-0af7-08dc9f09b69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEF0eG5qSVJad0l4ZXU2cG1CUXh0RUpPK3hJZUJjSjVTK0ZoSXhyYUpKYmpP?=
 =?utf-8?B?UmdoSjRBc2gvdyttUHRhVURFaFhYOGJMWnJZbjdjTVJjck9nOVdLa2ErTzhT?=
 =?utf-8?B?Q2Z3REJORVhST0tDUitwMU45alJtNlNJZTQ3SmJmWWQ5dTBQOHlHV3pYOFBQ?=
 =?utf-8?B?QlNrOHNiSkxNU2NkRVlsVFQ0TUE2QmxJSUQ5OEZhNEp6bTdEWG5PRDVPU2t1?=
 =?utf-8?B?QkdxRit4bnl2ZzNpdUJ5QWlSakt3Z0dpWnNhSFRiY3FMUllYMW1KeTdqa3R3?=
 =?utf-8?B?RTlSelpwV1pUWitjcDhubS9xUGdBckhxRkNxWTZBRmxjYTh2UmxwL0Nxd29J?=
 =?utf-8?B?Skswc3RSZGpJZDFlSjN1L25heXljbXpHZkJkQUhBOUxvK2tsV25lb1h0aHVV?=
 =?utf-8?B?TWFYaTZHbE05YUduMm5yWW1iRDN1bm9uWVRVT0h1SzFaNnUwcVpiTXRpV2NN?=
 =?utf-8?B?MkFzZERGV0c1KzlkeS9GMitpTDlaYzY1Y2RSMExvai9UaGdEc2dQalBNa3Q3?=
 =?utf-8?B?TkhlaEYzUkcyaGQyczB4dlowMy8wZDFKWkk5a2pFQ1FJbkF0OEo1NXg4RHR0?=
 =?utf-8?B?c0hYVGNqaVN0OXJLcW1OckdKRUFuMDdhZkVnd2YzUHllUUNZd0VocmRMNU52?=
 =?utf-8?B?bWNnT2k2MlMvOHU0NTZ5ZjNUTTBaaGRkcFcxWnlkemNPREJaUVl0bEJwY2pi?=
 =?utf-8?B?SGdSTDd5V21LZ00xQUNTTEVtQ0gxd1RiODZ5czZacmVEREh0dXRlZ2R3b2Nx?=
 =?utf-8?B?Z1ltY1FNZGtEVUhVTzAxSVhObVFSemJtYTJpU3JuWW5uT1lvU1g1a1Q4V0RR?=
 =?utf-8?B?cjZPdnNsK3IyOTFTK3JId09KUVZLK0plZURZNW1vODlxMnE5dWg2bjU0TmVJ?=
 =?utf-8?B?RmszNHlxSlBmbTRiMXZHMlhkVE9mTWxxRjZWb1BSalhHZnN3aTJON1BQS3do?=
 =?utf-8?B?TmdySzdMTzFwMUFyNGh1Y3Z5aFI3b1JKMFkwSVNZNG15SkpSd1ZJOXAyeHhi?=
 =?utf-8?B?M3VZWFFUUzM3b0VmZkJDUElKaktDQWFXMTUxdExCOFNLV2J1UmdPQmlpQ1NJ?=
 =?utf-8?B?dVBzVjRvc3lzd2NLUnVMN24zVE4yUVdIbmw2OXowTUxETWZpa2ZydjhNaDcy?=
 =?utf-8?B?VXltRGlsK3NRK3phczBuQnlFMXNLTm9UQnBNU0x2Vk14bGJ5eVE3MXRGNmx1?=
 =?utf-8?B?WmNKNit2T0I4RTUxSEF4NzRnUENkaUFOa2c5cVE4L2hrT3BxSE01UkRlb2F0?=
 =?utf-8?B?V2FhYVhsUlk1bVdxS0pBK3hoQWpiZTdEZS92bHpEbmFXWWwvYmlNUjF5TGpS?=
 =?utf-8?B?WjdwSERBNks4OFJDRVBJaHlqU2JNV1lqeXpsbmx5RUU2SnQzc0lhTzVXYlJr?=
 =?utf-8?B?N2VLWUUwQUZPWUpBOEhEOE5jLzJSVDBJWkwyUnUwcENnaUZZcTFJNnQ2eXcy?=
 =?utf-8?B?QThVWlpJMlpoR3ltVXVLOG9sdWlDMUtNdFVCZ0NKUnlzWkQxaVpaNGNudm4r?=
 =?utf-8?B?Vm1tL1Rvc1RZdGQ4OEdUVWJyZ3JTRkxXZGJYUXBpUVFBcnBuL0hPSzFaZFhW?=
 =?utf-8?B?dWZYcGJZeWI0N0IyMno2Y2x3cHJqamJ0YmhkRXFJcnlQUnBvT3FoTUFoTDZo?=
 =?utf-8?B?UHlvQVkzSzhlcVFMd2VkSDRJaDcydmZYTitGNDVMcVpONG1ObUVuNUpzK1BH?=
 =?utf-8?B?Y3NoZWR6bE9GeDRqWit3UFpoT0wzR1VGdlhEUkZ3bGVkVHE3V0tvQWQ3SlUr?=
 =?utf-8?B?MXBacDY1dllUUWg1akJlZS9XZklaei9ZSDFFY1RNNkpsT1VPRlU5dkFSUXpq?=
 =?utf-8?B?eHBTU2FoU1lPUGdER1kzWE5Lb1JKUk1tN1pWS0JZbzQ3SzBNc3ZkbEo4cnFy?=
 =?utf-8?B?anJCYlZ3YXpsWXZhVTFRdnp2dnZGRzRKZkYwNVBhMk5CTGtJZHFVSHJrV0JJ?=
 =?utf-8?Q?XWa8ahvkeCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enBmZXRkU3R2N3YwVkkzazM1MVNPTkZFNWg0Z1JPMkl6M29kdmZpZFNSczJo?=
 =?utf-8?B?OTc4RUhHQml6UlluajAySkJLeVFZaWZReEV3Rm1FbFJrVGh4ZW5GTkZMRTdw?=
 =?utf-8?B?djR5dWs5cXByOU9HRjRxWTB3R0FhWUc4RmxYZkdzZ25qM3ppV1c5cVZtTUU5?=
 =?utf-8?B?UmRZWU1DRCtnOUtYV3c1Z05QeEhjQm9CZXV6a2ZlQStBTllXOGtyd3Z0TU9l?=
 =?utf-8?B?czZjdk1ZT3ZlWkZrdlNWZEVUSzRtbHpWK1M5M0RXZ2JaWldBTUZvRTY2S0p3?=
 =?utf-8?B?UjNBd0NoeEx4TWh2WWJkdnRjS1h0cjYvaW0rSElTWTErSkVQMFQ0ejFmNmhY?=
 =?utf-8?B?eTYxalFaL3BwN1dYWG43Y0pMakdBTXZPUjBOV3hmd1hyNDcwcWhWaDNUMGVu?=
 =?utf-8?B?cWl4bWlUMWdoQUZXMWJvWkphRFNtOWUxQnZiMllRK055SXMxaEtlaHNwMHNx?=
 =?utf-8?B?bzllbDRETXJsWHZQaDJqWk56WWtDWjM2WjdEZ21HbkR2MUkxdXp2L3hHUFdZ?=
 =?utf-8?B?VmhCU1ZIRDFSNkhseDdDZE16ck1nOVZjMXBoMnpta2NIWGpsd0NBVkxtd1pP?=
 =?utf-8?B?ZmdCMFRqcFFjT3FqcEFrWTF6MG8zbmR3YlZOMFBsYncrVERzdmVHRHYraVdN?=
 =?utf-8?B?dDZ6Ty92NXZNRVYrV0ZKaGFuTEZHaU5MTVloK3V6bE4yNnBCQ2o4NWM0NE1z?=
 =?utf-8?B?b3owWG1GR2xxSVFKdHhidThoM1J2UUlWNTlGT2N0N3lwa3J1K3lzTzJQREtB?=
 =?utf-8?B?akpCb2NBeTZnNXdZRFQyOXNTKzFTRXNTbjJuclZwZGlsTUpCWVV3cXEzc0w4?=
 =?utf-8?B?aG5UTXIxK05qR1FrY1ZNOEFQbFMvQnFqcFdlNG9UUDlzd1BiZTlyWGtUTC9R?=
 =?utf-8?B?MHZNRjVhYUp4S3VZaE41cmpHd1Q5MGhMYzZDU0ZsM2VhQnZMMktsUnIrZW5X?=
 =?utf-8?B?RWozdXZUc0psUW5jMG5HTWdPcHJIdVlOM3B2WDNnZi9LdzBUcElucnllVXJK?=
 =?utf-8?B?VkhZYVJxRFRxUUNGWUdncnJ3cTNud2t0NHRMWjdVQndNZllqTm1qdEliY29z?=
 =?utf-8?B?TjdSeGtYT2tPSkJONXJOS3VyVnBwSVZySmVUempVMWt3S1h3a1p4NEMzN1FO?=
 =?utf-8?B?b1VwOVk4dnFVeW9JOHM2SkRubzJHMllLVlMvb1owdVZiZEsxNW1nclNIZHJn?=
 =?utf-8?B?K29nYk9rS1ZERFRoQ2lzNEJCUzdPclZ4ZzBLOVRzUFYrdmhTd0lZbUI4RGRw?=
 =?utf-8?B?RjhRNStDM0wwZUI1cjBWbkIxU3RPZThzbWhCK0E4Zy9CTklZdGNqN2dnSnd6?=
 =?utf-8?B?cnpFazVEUW04YmRSSzNpcHRaZ0ZHRE12QWNuWUx2ZFdrSG1nZ2x3UkpOL2Nt?=
 =?utf-8?B?anRmYXFyRU1XcjJ0Y0IrbkNic0lCSVEvQWxHa0RvWjhUU3krWnFHWEFlT0h2?=
 =?utf-8?B?bU5PaElJMEs0TUxaWXNJZUE4RVl6TDhmQWNFWEMzUEE2a0ZuU2JUdU9tRnFZ?=
 =?utf-8?B?UjBsOWpLQWVxZFRqbDJ1c1I3WWE1b1NQSlNLaHBWNTVmZDZuUkpJNHhjbXhy?=
 =?utf-8?B?Smprc1oyMUluWVNuNUpzUHNWUXZsczFCR1MvVTRTOGJHZXhVL2ZRTWlCNFFr?=
 =?utf-8?B?eTdWYVB5NU4wTkhUN2ptWlkwa2taM3FLemZYOFYzL3I0clVjdEVOR0xzOFBv?=
 =?utf-8?B?TE5NenBUTWRHaThNcGtoMEJ6amlKQ1BLL3U0Z05qTHoxSGVGY2NXeXVzNXVX?=
 =?utf-8?B?bEkrM2ZTNGV3YW9FZU8vMUZLUC93QzFlTTZHbEtDY2FrOHl2UGJPRVp0UHhl?=
 =?utf-8?B?RHBReFI1RTZtUEJEcU8zOFpBNHhHRmxsNGl0ZSsyL1JodFJFdzh4am1qNVdW?=
 =?utf-8?B?Ry9EVnZ3bS92VnlpR1JzWUkrcHV1ZHZnRStuQ0JBYytiWENuQkNZbmJJNHFK?=
 =?utf-8?B?Ti9UY1N1WVFpK1VZeWVHczdQQXlWRjh6UDJJWjZLNmlSazhnRFlLWkRrSUpC?=
 =?utf-8?B?Q3V4S1YrZDduaitLb0E4VklpdElaTmpLbk9UNkhOaHZKSVEwblhldlFrMU51?=
 =?utf-8?B?V3ZSUDlpVkN3d21HeGNZbEFzZVFIN0FsME1iRXNiZnVHN0ZuTVMvZHRrTkJv?=
 =?utf-8?Q?jSmEb1apZqv7IcHI48aXW+1QZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe7773f-1752-49da-0af7-08dc9f09b69d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 04:52:04.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1E5mBjSPiVEsorlzQxgql9oxaSZPCg7+3GAn3T/X/zLeeMqFuqqZvQlk2gTugGt/GDSFy/PW5jDsAkjpj2ZrZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5299



在 2024/7/8 11:34, Matthew Wilcox 写道:
> On Mon, Jul 08, 2024 at 11:15:17AM +0800, Zhiguo Jiang wrote:
>> If an anon folio reclaimed by shrink_inactive_list is mapped by an
>> exiting task, this anon folio will be firstly swaped-out into
>> swapspace in shrink flow and then this swap folio is freed in task
>> exit flow. But if this folio mapped by an exiting task can skip
>> shrink and be freed directly in task exiting flow, which will save
>> swap-out time and alleviate the load of the tasks exiting process.
>> The file folio is also similar.
> How is the file folio similar?  File folios are never written to swap,
> and they'll be written back from the page cache whenever the filesystem
> decides it's a good time to do so.
Hi Matthew Wilcox,

What do you mean is that the file folio will not have any relevant 
identifier left
in memory after it is reclamed in the shrink flow, and it will not be 
released
again during an exiting process? If that's the case, I think we only 
need the
anon folio is skipped here.

Thanks
Zhiguo
>
>>   mm/rmap.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>   mode change 100644 => 100755 mm/rmap.c
> Uh, what?  Why would you make this file executable?
>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 26806b49a86f..16b7ed04bcbe
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -843,6 +843,16 @@ static bool folio_referenced_one(struct folio *folio,
>>   	int referenced = 0;
>>   	unsigned long start = address, ptes = 0;
>>   
>> +	/* Skip the unshared folios mapped only by the single
>> +	 * exiting process.
>> +	 */
> Comments start with a /* on a line by itself.
>
>> +	if ((!atomic_read(&vma->vm_mm->mm_users) ||
>> +		test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
>> +		!test_bit(VM_SHARED, &vma->vm_flags)) {
>> +		pra->referenced = -1;
>> +		return false;
> This indentation is unreadable.  Follow the style used in the rest of
> the file.
Ok, thanks.
>


