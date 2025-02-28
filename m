Return-Path: <linux-kernel+bounces-538225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7546A4960B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C653B8AED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBA325B698;
	Fri, 28 Feb 2025 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dCUu4f7Y"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2065.outbound.protection.outlook.com [40.92.89.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB172257ACF;
	Fri, 28 Feb 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736496; cv=fail; b=NFbrIFRKwLYPZt28L1tKWI5Cwcny+gcab8Cus1p2cNXgYlyTOey9sWxSicKPu4YhGG6q48Ufj2Iid97JkOGDhSRXBdAHezHWcX98+9k1EcBE8esgm1mynxlwj07mPgo4hOm47/0tyu7V9hU6POM8A6X/4uyscDzlf2Bo1xDH/eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736496; c=relaxed/simple;
	bh=xdccipkyoRmCUb/bh/NcrwtfIxlG/rNk57amqf3M7Vg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jaG+daKnN5Y0k6PaW1sa44xu1A4B161GZiIduCxTEagHZFtn3ovopJNpvBM2vuEkBDw/z19eu7/HgjCPe2R9YaUwyxb3hfofPd+1MFkGs4kzhIihXGNJZYx6bYQvIp/4ik1oKL84jX2oCWHgOPjKdV1Dq8PjONCUhY0UzS+4DnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=dCUu4f7Y; arc=fail smtp.client-ip=40.92.89.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkFuiRa0IULaka9jVpC8jnhbyw74FBRf7EStGZQC1vodqy0b0nHmQFQVlK0ZdD0nQYjPgwADTjkrNJ5hFru6bC/ucA+pInWNeqM5bRfRXIBwx2sTy4FNBG5kCvUyYpUcr4dmQkbu3sl+VEvzpPqh18mtarq5lV2MJvwEWmasBuLmZx+B+AXD8oOD7hVc0V71HmrR/9IGua2UqTT0GJUKvCmEal1ekv81aGB8TOvs8zPVsSJNio1ZrvwsUYUcOHy4cd01jSeLUhisPouWvrTRIyMZFqU6Q1SvEnuj1eFxcbJw1Dq2ErZEwCQ0LXku2q4cQWxM4lq7d8gymy002Lk8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI9+3Tb+UpEMC+ABKac5nymhYqBfVX8/0sTPa8Nv+hs=;
 b=zOpMucyanfXCQjtQAktszrZo0bIXDJ/7wbRtmO91GmuqM0AgBcGcJCc2M64ly27JlwS5pQ8aJopzv99PY+ODnKXtQIQjjrIKMsB/tK3v4n+wIUvlFoMDm6zETn7O3D3YG7xtIpwH3DVX3umplpqryAfJpqqRbc3cheZLoE/JfwxLk4psdxgyc7BqKwU5+wJjppGvfIS8Yye+MXERzx/hzfnJYqKUqfj1cjmoAJliJrdmVYjuvsNyWiU3YL70Kqzcs5p3Gq2/l2VIgIyWcSibfIWoT5BVVMOoZc2FIIJV7hGptLVv03RUjm/KdxlJFkn3C0sJm0z6xcF2dCukwHU6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI9+3Tb+UpEMC+ABKac5nymhYqBfVX8/0sTPa8Nv+hs=;
 b=dCUu4f7YWksh4+2RFGqPVYT6eLCD5dBEMrjU9S51Th37ViafQ/yphtYrVEOoPhX2BAuHW6Cx6t9dCuFlAj8sHyxKkXg03oA3MF6dWl2H6+gAn4UOBFFCyoL5HD/6tWvTZiYwxii6WjVgCu10iMz9T8FWRKentz3u2P3gv9NDc6Nprh8lN+85lVx8/XhP7bom3j0s4TCdi280pwfzx3dqvT25cci70+id7Ih9XOBKAh/jDFBp57/rR/RW0OmeF556ljp3JQsJkjX0FbF5Jx60ScQW1eJUgGQkWErbJ9bsVqaXbayoyDoij7lQlWq48LS4SUc1pT8OPixQJEX4Rx1JeQ==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by DB4P189MB2414.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 09:54:49 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%2]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 09:54:49 +0000
Message-ID:
 <AM7P189MB10099481BDC2CADF476EB755E3CC2@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Fri, 28 Feb 2025 10:54:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] riscv: dts: starfive: jh7110-common:
 bootph-pre-ram hinting needed by boot loader
To: E Shattow <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>,
 Hal Feng <hal.feng@linux.starfivetech.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20250203013730.269558-1-e@freeshell.de>
 <20250203013730.269558-6-e@freeshell.de>
 <25B3D8909DBCC21B+43663a76-4afa-44ae-95e2-3a8792de614c@linux.starfivetech.com>
 <206a6ada-1ef9-47f3-b1cf-fb1a1540e95c@canonical.com>
 <62D89163A60680E7+f0f5a4d4-42f1-454d-9dfe-cf53e2aca4ac@linux.starfivetech.com>
 <cba21857-7eb2-4f10-a1bd-6743ce63dfa6@freeshell.de>
 <ZQ2PR01MB1307ECDF175D20547AC69287E6F1A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <8b0f7b4f-e58a-45ae-931f-2b2853918ab4@freeshell.de>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <8b0f7b4f-e58a-45ae-931f-2b2853918ab4@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::10) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <8b9244a4-444e-481f-9f80-d11065c48247@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|DB4P189MB2414:EE_
X-MS-Office365-Filtering-Correlation-Id: ea43dc2c-dada-4808-f9be-08dd57ddf059
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|8060799006|5072599009|461199028|6090799003|440099028|3412199025|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXJJbW5pTWMrZXM1a2duTk5uYXVQTFJxZlB6VGFhbzk4bnlMSGZkVmt1YU1U?=
 =?utf-8?B?TDVDMVZpS05leVViSGNqZm5DNlZ3NlJpM0tVL1NSOUY1T2N1WkRyRTNsNEtn?=
 =?utf-8?B?cmxqQkFQMmVWM2N2cVNpMGM3QnF3a0ZTNnhudElhNkwxV2QrdGxFV0d3RENu?=
 =?utf-8?B?STFQWDAvYU9DR1ZKaDVoNitJMVBrQ0NiTFR4SVJtR2diQmw5QmsrNnJMQ2RE?=
 =?utf-8?B?K0s2REFERTZGd3ZpMWFvdFBVdVpOdjNaNVZrS3BSUWlJb1k2VWp4M3FlcVNo?=
 =?utf-8?B?MHFDYTMrQ1EvbVNuZWZPWk9rUng0S3dUMjVPTHpEL2ZCM1BBWE8vTldja2hn?=
 =?utf-8?B?WGx0NjNoWUhyVFVXbFhLZ0sxS0tRWHJFYmlNZ2N3d0ZUVWFUbUNxRjBPT0hI?=
 =?utf-8?B?VEJPNVh5dmJ3b3NVczN1YnAwU25HRGZJS05uTWhKRXhyV2NGRXF3QmlYK3Fq?=
 =?utf-8?B?REcva1Y1K0hwOHRnZ0FuaU1qbWs3SGowNnQvR01ucjNiclRUMGhxbkZWRTJM?=
 =?utf-8?B?ditsdzcvd2tqTjAya1pPMmFJdW5DQzBVb1Z4Y21ySHQyR1RBekp3OGxUYlVm?=
 =?utf-8?B?UjVrNFV1Wm1HZlp2K2laVzk1bFppWmRZcWhmdDdKd0hwMXF3RXVJcVROZnNT?=
 =?utf-8?B?UFo4Rnd6OEVGYjlPVUJHaHRwZllrMGZIN3R4RUJuc3BHTUowQWY2YzlDSDBz?=
 =?utf-8?B?M3JtUWNSaVFKazVkaW9zL3FyMUtlZ05ib04zZUF3TE5jOUNPOG5haHJ6b0N2?=
 =?utf-8?B?Sk02c1NPSGZkSkp6WnY2dDNOczBYMitON2ZlZUtBMWprbVZzRlJRMEJBWDEv?=
 =?utf-8?B?UEdqQjRwM1RBWnJNeUNaM1ZVdHYzdGgxc0xnbmhxendhREUxSnYyem1FQzlv?=
 =?utf-8?B?SElucDB3ZjR2RkdKcUJtcVBJVTFoUVp1YXozd3Rsby84NTVjQmVSWkNuRlJQ?=
 =?utf-8?B?VTJwK09YazVZb0xrMXJySy92L3U0K1JsQ0ZMdHRtSUpVT0RTUVdSRmxoZFpp?=
 =?utf-8?B?TlBBc05XcjZ0Q3E5ZmhTbUV2TWppMWRVL3hyRndhZ2lQb3paTldRV2VlbFFF?=
 =?utf-8?B?TVBiM1NZbW5nVDJUYjU2R29SYzU5SEFSbG96blh3WTQ0TjZyblpFdHJyWW16?=
 =?utf-8?B?bkQ2cXIzZUpGSUplSkhPSTdEaXNCK0dXTng5Y0NJOVpRaHRQRzQyakRyZkNU?=
 =?utf-8?B?TjNtT1k2SW9xdmtxZ2FaTjRkcElPN2szd2luZ2dKRGxrSXNIdmszb2J6MWs4?=
 =?utf-8?B?VWRuUGZnTzVZakVSYWNIckR0eVo3OHhVWjhDSFkzRFhyYnBJWS9wbWZWY3JI?=
 =?utf-8?B?akhYdnFOblBjMGtyWFVTc3EvbjhyWi90Z2tuT2lJWmNPamZxc0tUSzVCamlq?=
 =?utf-8?B?aVZpMkpBWDNPV2lIQ3V3dmJObi9vZ0QxdzVGeTk3ODh2VC8xV3JmM2huZ09y?=
 =?utf-8?B?WUUxd1Z4WjBPUktMcHhLUHZ2d1VnZkFVVDY1NDR4WDhRMFVubEQ1dEx4QWk5?=
 =?utf-8?Q?Cl6CoppXB1fvAI/gPdf2xrPJ4Lm?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWZENGwvbGIyZmsyWkZPWDcwVlo0QjJDLzczakFtQVh1RisrcEJMclN3UTRE?=
 =?utf-8?B?VkdBUXJhRW9HWGN0TTdBUkNnYjZPdVREUkI3SjFXTDVISGJiazRwTUZpYTR3?=
 =?utf-8?B?b0huMHIvNGF4MDJKbm5SaTNZUUpSUGhKKzZmTDZBM2ZZQW16a09QQ01FNDVE?=
 =?utf-8?B?WlpiNXNVMWo5WVJHaTNZa2JuSEZMZnhJc21URmxjZHlmOTNkOWR6cDBoWmVC?=
 =?utf-8?B?eG9KS3FNdjgrNTE0b0Rmb1RZVXE1OGxSWkhidFVaRVRiTG5EV1N2SUtjVzZU?=
 =?utf-8?B?b1Vkc0NOWkxYV0cxcXZ0cEpjL1ptcXlGMDM1S1ZwSXNEc0RZNGNJRDhOLzdu?=
 =?utf-8?B?MGFsQ3p0YmFLQ0JuV1ROOWVSblpmV2pDdE1FeVJweWlwYjVreG0zY0VMNTNL?=
 =?utf-8?B?djJ1a1pZMDNtd3F2ZTJ6MmcrY0gyeUdRYjEwTld6Y0RVbzNhMFpxODQ1OGZr?=
 =?utf-8?B?eE5oMXZ6U1RwNTFqQkxVQlprOGFHQjRCUmdjbGVKSEVzNnpWZ1lXNUZHTEw2?=
 =?utf-8?B?b3RSeGd2TXVjdjRiSEpDY1FzTE5CdXArc3FVc0pLSE0zNE45STJwczZydjlV?=
 =?utf-8?B?L1p0WExjUTJvOHpJOFVmeWQySE02dGZGQTdNRUx5N2RoQjQvWkpKUWdyVG5I?=
 =?utf-8?B?WXVLQyt6WFJnai92cnFiYmpYMVN0eURlVkFYTnAzUUNzZElPckxlSzNIWWoy?=
 =?utf-8?B?M0R1elI3Vm9wa0xNaVZzc3NyT0pMTTc5QWJkL2ZBeXc2S1o1d0hXZEp2U1lL?=
 =?utf-8?B?VU51a05mdDh3dERxQjFMdHc5R3QrLzBZUTVxMGJPTHk1NERKZHRpZWxLQytQ?=
 =?utf-8?B?WEY1TUh3ZEh0aG5QQ3NDaEQwOVBPVVFkMXlaQUJzelRiaUFPODNzaW9wQUc3?=
 =?utf-8?B?V3VLQkM5RXE4MUhTY2dKQkNNNnI0K1Z3WC9lZmZldlVWVnpwSFpOSDhrTVQv?=
 =?utf-8?B?UTcyd2c5VzFVUTltcklveEpPL2Z5MGRHU2tEQnNUeHp1VXJPMjdvZzJOL2hR?=
 =?utf-8?B?RzBXM2FZZE4wNGZaWEFLUG9RZVVUNk1PS3JGdTZDclpITytVSnQzYlB0NVp5?=
 =?utf-8?B?T0k4Rnl0NHhSZm9tdEFJTnlpK2JMOFNLQkZUZExDSDhYanY2ZUUwdW5YaU45?=
 =?utf-8?B?L09KV2JISXl4MU8rZThoMm1hSG5iSUhKSTRPWU1lTFdCMkloNktIWDNTSjZF?=
 =?utf-8?B?cTA3MzFZSmlVdWZtQ05nVDZUaDVCV2JUTHM1b1FnMWtPL0xncjZ5QTExUU1C?=
 =?utf-8?B?ZHloL2xkOVVPS2EwLzFGRy9GYWtJWkpUWTROcldSaG0yOWZkMTJ3N3hsMFRv?=
 =?utf-8?B?UUw1Q2x4VjBHMTZRcnZONG5XeDM0bFBaTU4vKzd3bHVhUlNDN3E3Vk1NY0do?=
 =?utf-8?B?NkV3Q0JKWmFqSjQxNUpFVjF4TEI5cHlhZEQ4bzk3dS9iaE54cUpzcTkvSEhB?=
 =?utf-8?B?bnN5Um5VU3NWSGw4SUMrUUhsZW1jMFRyVkhvZmZMUTRNdDF3S1BKSFZmOVlq?=
 =?utf-8?B?NGdPT3ZFVnRVUStTVU5EUDNhNnozdUdVOGpBekdydHd0M2xjc2dQRjQveVAy?=
 =?utf-8?B?NVBOVzRyUGdUb1lqKzFldDMvbHdEbkMyVmRUMGw5TEdySnYvL2pobGM3bHRT?=
 =?utf-8?B?aCtLbkg4RllaMmlnNk1wZXZoSWhwQ2JmMVhEU1BZNUJRV2lSZ0VwSXErdE1v?=
 =?utf-8?B?WG5ORHk2L2l6K2ZtMWJlQy93Tm1PemJSSTIxV2JTK0d5YVJEZnVMM1ViQUYy?=
 =?utf-8?Q?dlEqyvS7aDFz6B9t28WzwouTYTqoQ/oKMmT0Tbf?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ea43dc2c-dada-4808-f9be-08dd57ddf059
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:54:49.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P189MB2414


On 2/28/25 8:53 AM, E Shattow wrote:
>
> On 2/6/25 19:01, Hal Feng wrote:
>>> On 06.02.25 19:17, E Shattow wrote:
>>> On 2/5/25 18:59, Hal Feng wrote:
>>>> On 2/5/2025 6:01 PM, Heinrich Schuchardt wrote:
>>>>> On 2/5/25 08:57, Hal Feng wrote:
>>>>>> On 2/3/2025 9:37 AM, E Shattow wrote:
>>>>>>> Add bootph-pre-ram hinting to jh7110-common.dtsi:
>>>>>>>     - i2c5_pins and i2c-pins subnode for connection to eeprom
>>>>>>>     - eeprom node
>>>>>>>     - qspi flash configuration subnode
>>>>>>>     - memory node
>>>>>>>     - uart0 for serial console
>>>>>>>
>>>>>>>     With this the U-Boot SPL secondary program loader may drop such
>>>>>>>     overrides when using dt-rebasing with JH7110 OF_UPSTREAM board
>>> targets.
>>>>>>> Signed-off-by: E Shattow <e@freeshell.de>
>>>>>>> ---
>>>>>>>    arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 6 ++++++
>>>>>>>    1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>>> b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>>> index 30c5f3487c8b..c9e7ae59ee7c 100644
>>>>>>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>>> @@ -28,6 +28,7 @@ chosen {
>>>>>>>        memory@40000000 {
>>>>>>>            device_type = "memory";
>>>>>>>            reg = <0x0 0x40000000 0x1 0x0>;
>>>>>>> +        bootph-pre-ram;
>>>>>>>        };
>>>>>>>          gpio-restart {
>>>>>>> @@ -247,6 +248,7 @@ emmc_vdd: aldo4 {
>>>>>>>        };
>>>>>>>          eeprom@50 {
>>>>>>> +        bootph-pre-ram;
>>>>>>>            compatible = "atmel,24c04";
>>>>>>>            reg = <0x50>;
>>>>>>>            pagesize = <16>;
>>>>>>> @@ -323,6 +325,7 @@ &qspi {
>>>>>>>        nor_flash: flash@0 {
>>>>>>>            compatible = "jedec,spi-nor";
>>>>>>>            reg = <0>;
>>>>>>> +        bootph-pre-ram;
>>>>>>>            cdns,read-delay = <2>;
>>>>>>>            spi-max-frequency = <100000000>;
>>>>>>>            cdns,tshsl-ns = <1>;
>>>>>>> @@ -405,6 +408,7 @@ GPOEN_SYS_I2C2_DATA,
>>>>>>>        };
>>>>>>>          i2c5_pins: i2c5-0 {
>>>>>>> +        bootph-pre-ram;
>>>>>>>            i2c-pins {
>>>>>>>                pinmux = <GPIOMUX(19, GPOUT_LOW,
>>>>>>>                              GPOEN_SYS_I2C5_CLK, @@ -413,6 +417,7 @@
>>>>>>> GPI_SYS_I2C5_CLK)>,
>>>>>>>                              GPOEN_SYS_I2C5_DATA,
>>>>>>>                              GPI_SYS_I2C5_DATA)>;
>>>>>>>                bias-disable; /* external pull-up */
>>>>>>> +            bootph-pre-ram;
>>>>>>>                input-enable;
>>>>>>>                input-schmitt-enable;
>>>>>>>            };
>>>>>>> @@ -641,6 +646,7 @@ GPOEN_DISABLE,
>>>>>>>    };
>>>>>>>      &uart0 {
>>>>>>> +    bootph-pre-ram;
>>>>>>>        clock-frequency = <24000000>;
>>>>>>>        pinctrl-names = "default";
>>>>>>>        pinctrl-0 = <&uart0_pins>;
>>>>>> What about &mmc0, &mmc1, &qspi, &sysgpio, &mmc0_pins,
>>> &mmc1_pins, &i2c5?
>>>>>> Why not add "bootph-pre-ram;" for them?
>>>>> Would they be needed before relocation of U-Boot to DRAM?
>>>> Yeah, they are needed by SPL and they are set in U-Boot
>>>> arch/riscv/dts/jh7110-common-u-boot.dtsi.
>>>>
>>>> Best regards,
>>>> Hal
>>>>
>>> When I tested on Star64 there was none of those needed to boot. We can add
>>> more bootph-pre-ram as needed but I want to know how to test (because I
>>> did not see any need for these).
>>>
>>> How do you test that these are needed?
>> In my opinion, SPL need to read U-Boot from EMMC (mmc0) or SDcard (mmc1) or
>> QSPI flash (qspi). Also it need to choose the correct DTB by reading EEPROM
>> mounted on i2c5. To run mmc / i2c drivers, the pin configurations (sysgpio, mmc0/1_pins)
>> are also needed.
>>
>> Best regards,
>> Hal
> EMMC or SDcard are not possible to boot (via JH7110 boot ROM, distinct
> from QSPI boot of U-Boot and later EMMC or SDcard capability) in this
> way on some of the boards where transistor logic pairs GPIO0 and GPIO1
> both-off or both-on. SDcard boot is officially recommended against as
> "not supported" by the StarFive reference documentation, and I suppose
> what remains is EMMC boot as valid though I have not heard of any users
> for this.


I tend to use SDcard boot on my deepcomputing fml13v01 board to test

before I flash the firmware to spi flash. I've not encountered issues. I
have not tried eMMC but I assume it is the same.

> What is the test procedure for EMMC boot, can you explain and I will try
> it on the Star64?


I believe this page contains enough info to use it:

https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html

> -E

