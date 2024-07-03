Return-Path: <linux-kernel+bounces-239745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529F09264D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F275F282B24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0F17FAB8;
	Wed,  3 Jul 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="Vu1fZdWl"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2109.outbound.protection.outlook.com [40.107.241.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0017B42D;
	Wed,  3 Jul 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020523; cv=fail; b=btr8xknseQfpo3MDOwfqYBcLuw5ze1b5WYZqxXbhTpOwwyi4KoGQMTMyLXuZkh+OlYF8/qEM/iwmpt4PFXEH3H5xet/qtyRs33iVnrevkTiraS3aJNOX5+00u7IakLTzpi/DuMrISswNK4mrXmLa5OhyYZZjPujFBO2KQhNB2c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020523; c=relaxed/simple;
	bh=fESbX5o/WJURQF2shC2IA8Gdt0YEhouiizqRVKiptoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HaJyk48eEoMAImQDn9lsBUeKus/Z+JxKDUkUYSZ9iHo+Z8WWx9+WBvlde4VsBk4Zmk8KnIGGAAqDzJuJufvEo+IGToYWsla2V8WDY56b5TImJvhmfKIL3GY/XGOy37ViSUtZUbmLGeX4ZUPqRfLz8VlKxIRuNKQrvf7MN41+xuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=Vu1fZdWl; arc=fail smtp.client-ip=40.107.241.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj6z2fEt2pwzFatUa0F/Qnh+3w37AB02lXtNH9mVbIjLjAc6WLkix4F+XsIsIPMPVAyf6OQQPU2GXseOSgYhe0GPTPlwBPDVyULf8rw5APpotpe5X6Md+QxGPkQZr3jtn3bqOAXWlCyR8qjwNQ25nrPNmE5fcc9AtOT+eLPqBCS6C3DN6d3B3cnmLxKMS0n5naEXsk/MXi+yEHsHQJPtokcvck1Je8TH9sXRcn0X9F6Hi78rsuTyn3DLHa4dZ4/h2P0kyTsfWqrP3LD9tmDx0lAxCx07+G6BrZtr0kS4BUr9Z8cVHMyhYZMSlAqRAbGhigSgzAd34mwl4XdiP5cPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXYHCAe/7FKRGYpVSHwPKATKWS1L+q6K7mM+kzn6G3w=;
 b=JOAcD65BvA2wAyMcaEyp8h0nj/xeDjPOWXYLQh8KVtsoP2kfpyAtAaZX4qPqrGgxqGxWBdiL2GgLkLbyJW9rACm3WgGZ3pzYEyTTGUaXpSbccvUYt2ZZeXPG7mwaT1lIWniNmqb36Y0qQ4HcmaKWcgIF+vAQYyv+O29quggVIn/wHQNT9tQKqKKeucH9uEGcBgllFrCRyExoGDBI2S48EbMafy8vbAaHhxhi2tYOX1zPLqedsQmeAyU3vJe3Ai7Oe29PLYLG5gtVJupR8o+xdf3M2Hx0Abi2TON6RmaOurPTzFoEVW7a/gM6kWKkZMX/Cz7f5iWURhVNfuVC1l27wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXYHCAe/7FKRGYpVSHwPKATKWS1L+q6K7mM+kzn6G3w=;
 b=Vu1fZdWleEnAEFVxTWWhuK/xu2pVigPb8VvrDK0Xxrmnj28w1f+AUrNqX/U410gDw3ouwV4zxnGR84H1gutJXclvfbJ74+7kIrCqloTNhincVFkcjpADWE1lqI0cqJudZkh9zfyWnlSlmKgn0PpYccLXPqiTHLzIBh2F62WE5ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA2PR04MB10123.eurprd04.prod.outlook.com (2603:10a6:102:403::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 15:28:37 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 15:28:37 +0000
Message-ID: <135535d2-f400-4ca8-8362-526b47ae8362@cherry.de>
Date: Wed, 3 Jul 2024 17:28:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] hwmon: (amc6821) Add support for pwm1_mode
 attribute
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-12-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240701212348.1670617-12-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA2PR04MB10123:EE_
X-MS-Office365-Filtering-Correlation-Id: a10e1f7e-c17c-42e6-b616-08dc9b74ceea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHNJeUFDa1p2cHdwemVnbFg0ZHVDdUl2SFpkbzltU3QyRTRYUmJrT2VkL3VU?=
 =?utf-8?B?WjZZcDhSL3lQVzN3anMySDhYWUlhejBhN3BLc0QvWWsrT0p2ZG9abUxFdmsr?=
 =?utf-8?B?YW1HU29ybCtJemlxb0JJWklpWithNk15bWpWOUdkVmNGakxNMlRha1NKcmV2?=
 =?utf-8?B?aTdSblZiZndCL0FiOVJnS3V3VGFFU2N2cys3T2VtNTZIdXR3VzNvalpEMEo3?=
 =?utf-8?B?aXZsNFJ1dDgrWjVtdTJVcEFkdzc2ZUY3elRXLzVFb0tvYUtMYkt4VlN4eURF?=
 =?utf-8?B?Q01wdlQwR29hMWpvOFFSMW01T2tiZ3ZicG1Dd3lOQ0RiN1BwR3VHSWRYL2hM?=
 =?utf-8?B?U0Y0UW5VV1FDNHJidTBiZ0dyZ01JQTZqSGg2c0xYZ2EwSkRDS0NFeWZXYy94?=
 =?utf-8?B?VDNpYUFlcUZKdFUwU0JKd0xKTDIzVDU4RTMyUjg5dHVSejZZdzIrcW1jR2RZ?=
 =?utf-8?B?Rk1XUk9lOW1nT3hESXpZeHNaTGc1NHEyblVVSHE5ZTRHdEIxdi8xTmlGZnNl?=
 =?utf-8?B?M2NNZHg2dHI0S2oxb2lCV3ZxSXhKbnVHSS9TRXRPbldtc0N4VngyRVFHbGh2?=
 =?utf-8?B?S1pzL2lFRWZGc2hrM1hwVmVmYkNGSG81eU0vUThCeVN5Zjk4dlp4RG9GUEla?=
 =?utf-8?B?TWNPekp4azc0NTE5R2R0VHdmbjZQUU9EMjl6QS9GUFhTUloxbXUwU2tkZ0Rh?=
 =?utf-8?B?N05yQ2w0bHdqUjVHTi9OZ3RSNnlsT2M2ZWZKUTRtODVkWklWRHplU3EvSnRz?=
 =?utf-8?B?dWM4RU1QYzladTVpVzlTZ2tqa0dLWUc1VXJkNHhXVW5NSVdhc3Q3WkZEaFNp?=
 =?utf-8?B?N1k2ajVNZmhQN3RQZXJSY3lFZmw0Slk1b1pkS1pEU2VPMHp3UnFZMkZ3c2Qx?=
 =?utf-8?B?WXZRN05oUFZveUlKM05NNXhaZGMrRDBsSllvdEZrdzdQeXU2NUdBbFRrU1ds?=
 =?utf-8?B?dkNYUlU3dzluUnhQTHNCblBNbjBrblVyV0pNWUJ6SnMxckRLeDhqa3dlOXZW?=
 =?utf-8?B?bVc2YTNJTlJZOVJvcEZRMDB4Y1hCYnpHWC90WHRNUVdiV2w2SVFpb0xWVTkw?=
 =?utf-8?B?Mm9Cek45c1djOGN6SnVoTEg3QklsYWFnM1Bod01tYUlzejNhVVFtV1N6NEFK?=
 =?utf-8?B?Tzg3YUwwVDd2bHQ1R0VyaUNiMXZNS2pNMW9ZT0FFTnFnV3dncCtCUGErcm14?=
 =?utf-8?B?cy9jeS9xdWtGZVpObE10cGxUVjliaGNnQS9mdDVkK0lvZjhmTlJINnNSb0Yz?=
 =?utf-8?B?bEpaVzU2dHkxditOaTN3WG9aSmRjaHUyU3R0NUZwb0Mvam02d0FsTklyVGFq?=
 =?utf-8?B?am02aEV2ZTNoUEtodHJnODFYM1FIcUd6aG5ZUytRR2NPR2I5Y1VRZWFrbita?=
 =?utf-8?B?b1FsKzV3NkNqcm1xc1QyWXR0Y20wRXR4aFg3Y2lNOHBzOStJT2dxWjZlM0px?=
 =?utf-8?B?Y0hwODc5Y0w0R2Q4WjQrY3QxckJKR3hzUW9oa3VsbVdocWFMRnZzME15bWYw?=
 =?utf-8?B?QkJ6NHdoSndaQ0xOamR5SHVyWVBUc2hVcnpRZnBZSXk4S091Z2V6bmxoK2VT?=
 =?utf-8?B?QU14cFNzY0NsZ1ZHd1V5TDdsTktPQ00vN0NyNlRHQnBKQWxVMjdMNCtwY3Er?=
 =?utf-8?B?MmJaZ2YwNW9vc1JMNkJMNDhHZXFsZXBkakdWS2FVNG1sZnJxRVhCM0VXblAy?=
 =?utf-8?B?RVNSa0FzeFM0cU13MkpWcTBTZ1NMeUp1bHlBekNESzAvKytIN3BwZ0tJZ004?=
 =?utf-8?B?cEM3YktGS1preVB2SlpBV0RuR1AzeWJYMjJGS2hOZkpWb29IZW8wVHNzVHVH?=
 =?utf-8?B?U1FNSlhzR3cxOFU4UDBGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHFZdzUzU1h5NUJGcWR5eDhNUHYvWWI4dE5JVFpPZzJDb2FJZWNsZ25POEhp?=
 =?utf-8?B?MGovVkJvaTNtTGtsSXhBOG1ySWJMUysrKytQaEJoSVdlMUVHYXdPa2NJbU9y?=
 =?utf-8?B?TytRaEtxOHkzTGM3RnlrNCs0K3BzcWFmZHVkdG9HOU5NY3JXWEFJei9PTVll?=
 =?utf-8?B?QldXSmg5YVV1cXF1YjBGRUx2Z1pEZnpCMlg3dERISUhxSDZEenFpRkEzdlk4?=
 =?utf-8?B?eGVGUnBzRG4vSndOSHR1bDloSTRJUHp0TUZkK1JOdTVNOTA1Ty9MLzErK0RE?=
 =?utf-8?B?bHFuT3dGWlcvUjY0b3ZqYy94NjZGNW1PT1NjVTAyYnF1UDZCWTRLLzJRUlFF?=
 =?utf-8?B?M1ZnbkdhSDcxZ3FlckJwYXdyRFVVcmZqYVludnJKY1g3eXE2NGh0aURhNmd0?=
 =?utf-8?B?NUE1WHQvQ0hoclptbmVzMTMwQmliR01wYUxEUnJ6dGFQRUJZZUdEaWxqMnlk?=
 =?utf-8?B?RkRRRVpGRHBiY3RRVWJObGFwUlQ4eHNkbm12bHRvcDd4QWJMUjVaeHY1YkxN?=
 =?utf-8?B?Q0VkWTdwMGxDY2pjS0tsT3FFK3FYTVl4enZnUUYzcGpSblR1N3Vna3JjNE1X?=
 =?utf-8?B?OWFSKzBwYkQwYlAxRHlEd2U2MTdDQlZHTXFlU2RXR3VGTHdnSHAyWGRFa0JO?=
 =?utf-8?B?cGJXVW9mZGg1NXNDSjArMnI0YXUwZFZBUHd5K1Njak4wdGNBUlBrMlRIbE90?=
 =?utf-8?B?Y1g4UFUvNlZ1K1ZqSnArd0tNRjc5djZYRVFQSDh4WXZDOTA0NWpRV0FoZnhL?=
 =?utf-8?B?UnQrTUlzbE9Pc3VUNGE2SERPMFZsQ014Z0hQVGxnZjk3UmtJYnBqTmZLbDJX?=
 =?utf-8?B?QW5XUDkzZWY4RHp2QWpMQTZkTDZ5R0o0WnZwVDN4YUsxbmhHRVh3OW1PWjh1?=
 =?utf-8?B?ZkRnamJwWkVTQVRoODZCSkMxalJlY3VwWGpiM2FsOTRXTzZHWlFGNGJTV0N4?=
 =?utf-8?B?UmR6c012VFhROVV4SmtLa0ZKTC92elVBMzh0NGZBalYvSDRXbFlzOEJYSXBs?=
 =?utf-8?B?QmxKQUx6S2x2S3JER090OG14Z0ozeVlEZGxxYXorTFpwNWV3b08yODZFbkZM?=
 =?utf-8?B?QXRNcm56b2lqb05LQW1EY0hHLzJRcjRIK0VBUzBud1RORjlyN3lyL2JiVGRv?=
 =?utf-8?B?M0hlb0N2QTJrZ1dGdDYxYkZsOWlZS1Jnd1cyM0oyV3NYV2UySmNFaDRRWVFt?=
 =?utf-8?B?YUU1WDRWTGRRMlRyQjNHMEJnaGkrekRleTBlR2Y2VjUyUnc0aEFhczBRSDVG?=
 =?utf-8?B?OGJVemF1VVJQSGVYbFlqaGZEV3pNNHJsOTdlNVBkZXZFdHl2cS9WOHlNMGtv?=
 =?utf-8?B?UUN0QU5SZ3RHS1YrRU1pbHRHVisrdXg0clFBWFNwWjd4QUVsTmhxeXgwbEpa?=
 =?utf-8?B?VFU1VHJaOXlxd3dZYkhQNHFPc2dQMElVREdnWEd4eGpTcFJab3BKQm9wTk54?=
 =?utf-8?B?dGlyekRCZDlqWVV6VldUeWZvM3hpTTJEM1pTMzI3NVFRd05ZTWdxdk5PWU5E?=
 =?utf-8?B?K1o0SnRtelAwUjMyVmxjVmNDS2VPUlZ4MW9panpTai9TNVNDaWxjbVhOZEZF?=
 =?utf-8?B?SkkyVkdKVzhSeGh3b3JhcUtqTmI2QnU2YWU0T29RYk9JdzlkVWdvU2J5YXRi?=
 =?utf-8?B?MnZESzY2M05XZ1R0VGJuWk55Yjl5OXZBOSt0aXVjeUJBSWRJR2ZCeTltMDlE?=
 =?utf-8?B?WEVJYWZFYm1ZTDNxdDVla0dZMFVBd2YxOTJoT0hIVWEyYkhzdkxpTFp4aVVR?=
 =?utf-8?B?Z1RKZ3B1eGZoYzdvU3dpTjVYQW5TM3R1M0t4dXdvb1FvUndqeGxFZXArbUpt?=
 =?utf-8?B?aFVVUG1LRXVxZVJHZUNPMUh5cVRDME15ajZDbGRHVjRWMGRIeWxKZ2pzYXRF?=
 =?utf-8?B?emlMZUxJQ1RzUHdHZkw2TFd3Tk5BQy9vMU5LVjcxMGpZK0tKT1RHNjRIUlIz?=
 =?utf-8?B?bkVjVzVoVjIycU0vVnVrTVZwVnpRZVJ2cE1xR2lSMlA4S2ROalZOcUIvZm12?=
 =?utf-8?B?U2RqN2crMjIvTkk2Q2lLWnpGQjRDV2lVZDNSV1pLWEpTM1dKazFRbUp3OUpw?=
 =?utf-8?B?Z0l0ZE1EbHFEeDhXQ0pNbHNDb3N0NjY2a3plWkkrZGk5aTRvVDhKY0lucXZJ?=
 =?utf-8?B?cWIwT1Y5U1BTb21NVGR1WjRFNXloWTFGZzJlT2picG9vMGk2WnZOOUJ6TXdN?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a10e1f7e-c17c-42e6-b616-08dc9b74ceea
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 15:28:37.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LANNpyIQTO/jwzmNPv8YOrhSCTStTvRAllzujG3NQLYqZ8BBvU/vnNbXaokYfgOm06syNRsbb0x+gPTlcl03+5YIylo41S5KSwCdyN+Xc00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10123

Hi Guenter,

On 7/1/24 11:23 PM, Guenter Roeck wrote:
> AMC6821 supports configuring if a fan is DC or PWM controlled.
> Add support for the pwm1_mode attribute to make it runtime configurable.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: New patch
> 
>   Documentation/hwmon/amc6821.rst |  1 +
>   drivers/hwmon/amc6821.c         | 16 +++++++++++++++-
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/amc6821.rst b/Documentation/hwmon/amc6821.rst
> index 96e604c5ea8e..dbd544cd1160 100644
> --- a/Documentation/hwmon/amc6821.rst
> +++ b/Documentation/hwmon/amc6821.rst
> @@ -58,6 +58,7 @@ pwm1_enable		rw	regulator mode, 1=open loop, 2=fan controlled
>   				remote-sensor temperature,
>   				4=fan controlled by target rpm set with
>   				fan1_target attribute.
> +pwm1_mode		rw	Fan duty control mode (0=DC, 1=PWM)
>   pwm1_auto_channels_temp ro	1 if pwm_enable==2, 3 if pwm_enable==3
>   pwm1_auto_point1_pwm	ro	Hardwired to 0, shared for both
>   				temperature channels.
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 5a3c089ae06f..98a45fe529e0 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -317,6 +317,12 @@ static int amc6821_pwm_read(struct device *dev, u32 attr, long *val)
>   			break;
>   		}
>   		return 0;
> +	case hwmon_pwm_mode:
> +		err = regmap_read(regmap, AMC6821_REG_CONF2, &regval);
> +		if (err)
> +			return err;
> +		*val = !!(regval & AMC6821_CONF2_TACH_MODE);
> +		return 0;
>   	case hwmon_pwm_auto_channels_temp:
>   		err = regmap_read(regmap, AMC6821_REG_CONF1, &regval);
>   		if (err)
> @@ -372,6 +378,13 @@ static int amc6821_pwm_write(struct device *dev, u32 attr, long val)
>   		return regmap_update_bits(regmap, AMC6821_REG_CONF1,
>   					  AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
>   					  mode);
> +	case hwmon_pwm_mode:
> +		if (val < 0 || val > 1)
> +			return -EINVAL;
> +		return regmap_update_bits(regmap, AMC6821_REG_CONF1,

Wrong register here, should be AMC6821_REG_CONF2.

Otherwise, looks good to me.

Cheers,
Quentin

