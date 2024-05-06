Return-Path: <linux-kernel+bounces-169420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CBD8BC868
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428AF1C21384
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC113774B;
	Mon,  6 May 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SSp0jwKk"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19010000.outbound.protection.outlook.com [52.103.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481E127E3B;
	Mon,  6 May 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980785; cv=fail; b=M5eZRatG2u3thIPzEU79Xv71hC3Rv7L0t2L8UgFDCw3J4WONleCCciQvsEd35XhJBsiLszxj6qEsEo6d1LFRtoxG2YTdvaOi6mgeg1+qFDVG4SzD+NzRPbg9jlgvfpJBgWGGwVFtIeV2MqWHxXzaV0DJRJkSEi8AtAhEp+CZbpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980785; c=relaxed/simple;
	bh=QWQepTr9HCBQbPnpPpOL2vIhU1/9nQ6mXKQCD+2+ft4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iuL65h6b4Jwrf61SiZ7mO1F9FBQGF3uAfcvRVcxH9i/5Z4oGLEUUPfWPF9EzE+Fkw2H2D8Xfrlpc7ol7IL6JzgTOUrzO8nGXT3wlvG2O8jooJddBv6Ocbwrwmo+fjGL7+5i8dHvQJUVw1aV399AGma6HS+gztVf2Epf4kQjlXPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SSp0jwKk; arc=fail smtp.client-ip=52.103.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUa+4ph6riv/v5qmyBol+X0kVDxEsQMhCAEJnRgWhh2YySMXktdHrcm0tg58wGeq5DDTyyez4ZioIRRhJcUhqmyt9c9pgZMiOLlEUyL4L7xH6XBdPZwBKLHE9AYDu+deUi5WWvjy0pIszUTJVwv5cW7xkOK9w9EX8oirj43aejE/EmtdL1oZNZgKicT6br8HHr5iWB4m5DwmhmbmBgw+IlWhP7m9IcpBI7fwQTCY75ynjp43+KeH8o6fDR0Qyt3bG92iH57d88+taPlA7nVKQPNFaJ4jWfozjfJDzzq3RvOXHR0167BS7Dd42c2ec/BhGZaqyen8IXc471JG9rkpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooUvmidyDfcicUqHx4t4j6+vqcGKs/pdj6DnF+bzZ1I=;
 b=lFsWcs3jsSgovLjdHmCKeIXC8r7VFg8KRF7sNX336l8Nl8WpjfN2zVnDa+zzxaqNXmYDZvTaANmYfepXaHzuRg5S+oTB+Ay76/MSk5t9WWKJAZ5Gi8aC/QqGaTR0oLD68bn79DiDjKFygB8a9JZ/M5/TnvkdLZ2kcffxEn+GazT4s2X+g1Fu73EC1up8/y1grzL/xatocJGj8RbZVDGL4m0nEMS5I1KHx6K1ehtr89Bzbb3IwKnWOh6u488n5UFa0QtfGhIIt5vYuYUntT8z6nvD/BQ/SGmYwD0B2wIIHyYcvEtgztR0Tjvfu4f62joPZycwcnG1Z8bFy+5siu7VNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooUvmidyDfcicUqHx4t4j6+vqcGKs/pdj6DnF+bzZ1I=;
 b=SSp0jwKkO0iKI/IxFFdI8PstzXS6GU6saeoDyPoHniJjBullyJ6UVmYQLgCRD6czvL/a3Aff0OUWXO8yTjS2Q7f058bS4axMINx4yj8bcUQTzfIhYo6FdZ+KJ9nGQXO7FLXD0MEliblrwlfrH2mZVNF7UdbA0PJESWUj+exKxo4UBYV/i7qBHiVolpIPIocGR+8DOgAhqxgavBH4t8YNj9X+LAiT2+rng6Pf6L/AcyPesKNQZbbjXui7vFRvrM+vrwQwfpTcEUEbIOYUFC/UD5Nz9yhVyoP/6jCmhSR+kOaNZ1tZVghN9X0Ks9mJkVwIriOFDnk2l7LiYm9D7Bc9Hw==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYYP286MB1643.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 07:33:01 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:33:01 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: tiwai@suse.de, Jaroslav Kysela <perex@perex.cz>
Cc: sbinding@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 rf@opensource.cirrus.com
Subject:
 Re: [PATCH v4 0/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X
 2022 IAH7
Date: Mon, 06 May 2024 15:32:56 +0800
Message-ID:
 <TYCP286MB2535FAD4F73A78C410CE11F0C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <05819798-2ac2-4aed-9f4f-0494c4c24159@perex.cz>
References:
 <TYCP286MB2535F8C34EB5E3D826B74C17C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <05819798-2ac2-4aed-9f4f-0494c4c24159@perex.cz>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-TMN: [h1URPMT38gAYzGf8zUtKQE/nwqfjz/a/dIOlNP54JqM=]
X-ClientProxiedBy: TY2PR06CA0036.apcprd06.prod.outlook.com
 (2603:1096:404:2e::24) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID: <2763980.mvXUDI8C0e@qlaptoparch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYYP286MB1643:EE_
X-MS-Office365-Filtering-Correlation-Id: 385501bb-6a92-4b6f-7754-08dc6d9ec21e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	SgYh9TPojyFgm1UtUrgnM+WAXJ63WRxn9yuXflXhAAMsjVY9Y4urfUlol3TGY5FDah0Yu60DB2zFGx6zVzK4YS0XDt430rzE0MINGHLCVzIL/46VTzi83RyQDnjkk/G4H9fhTaOVLZxBWGB1+Ajm8S6ol8LUFKc24kWAP47Mka36QAzvz5MVlRPTDB4GJXOkC+OHDs67sw801Ktm929Flpc9/QgbrZMMKRLh6adwTOYdh0IV0ujLM7WiSGjtlBHeq61wjK+f9vWfkKVJ6UfOufiqSKWG66YPG4U3ktTXjdWJESD/UK8kSR5SPo4Y+g/ZKT0qXSb42nF1OMgdmjOnDiFYIejneNUBSTpU4Bbp/LQgarQQ+Jl4BCYGbaG4VFui39NqQF+WzFTY8xBkdQosvJN51fR4woBV5RLgJS8WQDJyLwnv1fhsiz4rBp11JWc9m5RRUgujaK0VWaGLFrnwnYSNWpFEFmF8tu11jaq7FiXgxfAxHERypuqHm5jFpHL72+Jl/+bTzPXpe6OiAeMwo7FOrttkhdnUfirooFNJyG4MAskc2krViOr2yVi2gQXuDTHOBBt++flV5ch9Xulk+ggyXCdhmLdRAkfGyX135KsrPTI/atEdlNEfk2qPouy+3G9c/wfmy8lDaIjzHMxSZM81FfhY2ZaZQQd0hNaRn5c=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qi9lNXJ5NnhrU1Rsb3RNRTZoQU5MampsVnZjazl6TGJhTkRqOURCQW43QitI?=
 =?utf-8?B?QWNvOFF2SVFWWk4xY0cxN1NjcDI3UXkvTXY2aW1wNEJUQ28wWmJYRDJia0xa?=
 =?utf-8?B?dm5uOHNlaGgzU2RMcnVvSEtPQUNaU3VWQjhzTVBETGRNc016bnp2UDBJOXpQ?=
 =?utf-8?B?QW1SY1hnU3hDWXREbi9sbDN0bHN5S1EzbVgxMDhLTzVaRmNSUzdCdmUrMWpM?=
 =?utf-8?B?WXhqaVh3TWdxekFFc01iTUZZd3VZYlR5emV6L3V5bk9IY1JOM3pXc3gzRUN2?=
 =?utf-8?B?d2FhUDB2dmlybU1ScllIaHB6cmp3NjJuUGhDZTRvKzczUDZRRU1pcnlhZUFE?=
 =?utf-8?B?Z05Yc2R3QmltUU05bFlENkUycDV2MnZhK2t3VWlDZURlbGlOU2JJMVBOQy81?=
 =?utf-8?B?ZHNvdU1naGVuYmdKU1plWkg4QmpqMWhTSUc2RUZTUWFXNURnbmYyLzJzeXo0?=
 =?utf-8?B?NzBLRXJWdjBWSDFtdU5qSmRNUU9TU29sN1I2VFRnNERQaEJRRDFHcFBqMi9Q?=
 =?utf-8?B?OUo5Z0c4S0ZLQjlXcmF4WVh3NEVXSGhNRDF3Yld0c1FIZE92M2FYbWN6NVIr?=
 =?utf-8?B?VnRjZ0JnYytnQWVlQVQ3VlB5ZTJWT3ZWeGNyeEhzOStxZnM2NUJ0aE1hMWU3?=
 =?utf-8?B?RzZLVzlaMVBybTdXbFE0eGlqaStNMnd0NC9lS2I2R1RHOGEySVUybUI0NjZx?=
 =?utf-8?B?Nzh5ZkNoNWt3THZPZXBkVFpiNm1CaEVSTmY4MHJma29PcFBrZEpvYUJyRkp6?=
 =?utf-8?B?UHJ6SWcxUzhXQmFFb095OWpIZEFtQzlvbU95UjBFNnREWm4rOUxnTUJpbTl2?=
 =?utf-8?B?bk8raGg2a2haUVBUVm1YcjJHd2l4Qm5aY05VZWlGbldOeGRLV0JObFdzVzc2?=
 =?utf-8?B?MTh0Q21ISklMaXVDWkVNT0tYSFFUcW0wUStESm5seGRIM1YyMXhBSDlTdkhZ?=
 =?utf-8?B?MzZuRS9iQ2hCaVNoV2U2dUVwSFJUMXZMVUNkQnlYRWhSRE5MVDN5UStZbmM1?=
 =?utf-8?B?aWlWVm4vWXlxRW1SU05IdUxrMHBqdXZMd0JIR2VWKzRCbmwxMTJvelE5OXBZ?=
 =?utf-8?B?MU5TSDUwOXNZeHExSWN6eVo0Q2RzaFBIYTdWczZybldHemlMeUdUc3NERGt1?=
 =?utf-8?B?cGxOaVBiMHdOeE1aL2JIY2R2NHdNQ0F2b084RDB3TnlvRWs5eDlwZUtXRGZS?=
 =?utf-8?B?T09tRHpmRWpYN1Y5M0dCYzRLYWJ3M052NDArSnFJTHhtUmJvMzhJNDVCSXEv?=
 =?utf-8?B?dGkrQVJ0YUNjckNaS2QxdUlyaWNVaXo1eGtmd2xXZWxIUUZzZUFyajVYeXla?=
 =?utf-8?B?TDIyaWE5WWJ3VE9nOVlhUDVsTmtIT01iQXpjYnBIbjFqbUZrOURLRzR5UDVK?=
 =?utf-8?B?M0pBZHgzZGRhZXJPeVFyTkVaNXZyRDJvOVRoZ1dEdit2R1hkYlo2cE9WYWxV?=
 =?utf-8?B?SDhzNTViUWRiVVdqVlQ5bHBGUm5ZU21JWUE0T0QzSVJuV1F0YlFDa3p0UjJv?=
 =?utf-8?B?STFwZ1UrUmROVHZKQ0cvcllwbldkWnRCRHZjOHJDbkM1Rm81cklHV2E3RkND?=
 =?utf-8?B?SzAvV2lOSlBCbGNsQWdBWnJuU3BvUzZYM0NOYUk5TmtCc2VWRmp6SERpMzRj?=
 =?utf-8?B?blBrSm1FM1hjUG1Ec1p6aUhybmRpbFN1Z1JLNE43T0VRRjVSU0loOStidGoz?=
 =?utf-8?Q?wQQ6IZFNi1orBMKdZySN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385501bb-6a92-4b6f-7754-08dc6d9ec21e
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 07:33:01.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1643

> On 06. 05. 24 9:27, ArcticLampyrid wrote:
> > This fixes the sound not working from internal speakers on
> > Lenovo Legion Y9000X 2022 IAH7 models.
> > 
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218744
> > 
> > This patch depends on [PATCH v1 1/2] ALSA: hda: cs35l41: Ignore errors
> > when configuring IRQs (by Stefan Binding) See also
> > <https://lore.kernel.org/lkml/20240429154853.9393-2-sbinding@opensource.c
> > irrus.com/>
> We don't accept commits from anonymous sources. Please, follow
> Documentation/process/submitting-patches.rst .
> 
> 					Jaroslav

I've signed it off in commit message.
> Signed-off-by: Junhao Pei <ArcticLampyrid@outlook.com>




