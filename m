Return-Path: <linux-kernel+bounces-436105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CED9E8131
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBEC1881872
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6741494DC;
	Sat,  7 Dec 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XBJPic9J"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020138.outbound.protection.outlook.com [52.101.189.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7B2E628
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591595; cv=fail; b=BZkadQVRMcPy3RmOHvc6M7q/q7uga6qrG4uOJ7Gf+n9nFbXvlubkfX04Wyu9FBd6BB0y9yRl2yM3JlJhWUvBr7LqrZ45MpIGAQvmoHhhsUs7q6U2/AhjdRm61BAHegnjZUFgMzs2rM8RI+8d5u1rDGCha026UtTXTZ5h2EnwVt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591595; c=relaxed/simple;
	bh=06maBGGXx2XBQQ0alCEJXxGsqIGIizX+X0hV4p1DsBE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hjfuuQ+OQtC9rNs+O9Tj5yLhoRRJ7gg2guCQrWhfj0Xbuaf/9hOwUWiYz/hTtnxSVDqDPZ4TU2+oFwghlPbwyjD+597BMUVyn1REmdGIEcTtjcnW1C+wtfEEOd5ZiGNC2phrYjTxOATflWve25Gwf0fg86CKdZM/s7OHsz4z2kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XBJPic9J; arc=fail smtp.client-ip=52.101.189.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmuf7NeOIovWELKWxn0/p1T4TSwNV5CJbHAA0tJZNRUDGR4ijgsm8eas7ooPMCP9jSEU4BnKS1C7cUrVmMyqXwE6TULoYux2QnWK+SaxRJ86Ek0D+25645YCx9kC85kVztrQkxmTWZqoKJyuefwyTMmODWmxgUIOF92sIK5TRgM0QXd+IxdOz2UjWplNJlO6ZakOlw3VFRcobIkRuwjhdm7B+k9bByNdAfQJ8bSRGhWVRpkEdBgdZsRcMZhXvQJVl8mhKPwm6XLdGqRagaWI8DYe4SBa80YohN3x/LeMcMBOCpZu3Us/OtK/fbhiryRG0wdZXaoDwuzbuQZo/tXJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/sKx9Q+yDjMhcVtkhuEYWiq/mV2zI6KB35NtJI+/tQ=;
 b=UauULn6aBvaeBckEKN5r41XovEkpNzy/bcGqjYLOXjfUS/6zgSfnHtXgMmOKW8iLJQw25KOegfmhRU/K8BT3JOy+GO63Iw18koktg6tc0X9SdsC1SXF/+Qm3AfunoPAkr40imEE6zv/d/JPVOo5Bn+r+3ydkQV+anlUWv4HxrRV99QXiB2I9yMmlSHpg1TyDkaB3oHOxTPEYomvN+iBsiuvOlxul1pj8WmdYcQyiJk7fBk1SUljnb6lPn4l9u+oWGkYMbR+eUHWtts1qmZAK050788Kk0wYwS3FOujZ9mb/Rj29hbaMvsZnZY6iLFkLP74oib+sgJDlnlMV+kLL1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/sKx9Q+yDjMhcVtkhuEYWiq/mV2zI6KB35NtJI+/tQ=;
 b=XBJPic9J9DjZaql53PhirVqL64yGd+wUXJHzlDc/zMdSugCjh47YICFerhV+Owwr2dvCO2OXcrSJA+w5ie4YydW0PoAeBpIsa566DXrtvfm9AqNoU1XbPUDXnAsCLwC2pTr9z8H5DlhC0fTZEqvzmAPn9ITNw25a5QJv2HykxLXNx77kcGJhZ0GB3wa2yjzjfRvEElMpv65nfRK0GPhbEw2NG1EhIiNIc5Hmz8NwZrrJiGQcImk6OTDV4/eeb6FofP6E9s7c8nNLI5jbtuTvz900aXAC9chWVFwfjWE6JAwzXcXFsXybUIUatIfbCiQJ/Oipfz1IwCBj+EL6u8OWYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPF8B8ED9C2F.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sat, 7 Dec
 2024 17:13:10 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 17:13:10 +0000
Message-ID: <dd3a1bed-e428-4ab7-8157-cca22db5067c@efficios.com>
Date: Sat, 7 Dec 2024 12:13:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Introduce cpu_icache_is_aliasing() across all
 architectures
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20241207165504.2852058-1-ziy@nvidia.com>
 <a3fd2a24-16ff-4fa5-9510-148f66c19ca9@efficios.com>
Content-Language: en-US
In-Reply-To: <a3fd2a24-16ff-4fa5-9510-148f66c19ca9@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPF8B8ED9C2F:EE_
X-MS-Office365-Filtering-Correlation-Id: d957b07d-d323-41aa-59fa-08dd16e26cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDgxRHdWcVRnMzdIN2hMRGNWeEZ0ZUxFTGxFWm8wcmw2Y1JhSkI5UXdLcWRr?=
 =?utf-8?B?bWJlS2Y2enlTcGJZeHhYNTc3aDFCT0lBMExWdzBXUFpDQzlzRThvVDhNUTgw?=
 =?utf-8?B?amlEU2ZrMFNCdFNXYU1wWkF6ZDBvdjVEWnYza0JVYWJmOUwyUUV3RFdwMHNa?=
 =?utf-8?B?TmRJWWMrT0NobUJ1bzRSdys2aGo1eHhjTWJycW50dDZhUDRDVzBkKzFMMU4v?=
 =?utf-8?B?YXl0MUZQUURtQjRwbE9RZGlSVTVTUVlaeWFTckdTWmh4allpbHdicjlyYnJO?=
 =?utf-8?B?VmhUcExRYzNNcHBBVVVGbTJSQ3Y4aVFCSnFSM2tadVF1WFZtMTk3TDBpUFBL?=
 =?utf-8?B?cEQ2eitsT2ttZXVyZU1yK2tnWjU0MFh6MXdEcHFJbVBXcVhmSXY3L01IQVVl?=
 =?utf-8?B?aUFTQWdDYStzMkVkbXA5WDhyUXhnQUo0RnYrWi9CYVo4dDVEc1ZEZFpScHAv?=
 =?utf-8?B?dk90d0xtbnAxclZGNi9zSDFXdmxzUVl5My83OWprekovS1g3aDZ6MmE1MmVX?=
 =?utf-8?B?aTRwdUZwS0ErV2V0YkVwTEZYMUZlYkMxMVMycjR6OFAwaUVweElSWG9LcXU4?=
 =?utf-8?B?eFZ0OUJZb0cwby9FVHZtRlM1R2hjT3dFelQxRW05VzlPTkticStxREM1TGVw?=
 =?utf-8?B?WUxMaEpyNThrSWIwQXEwYlZycC8vL1l0eUhVZGpRVGY2ZldYdkdxYWNsdkNJ?=
 =?utf-8?B?RityNTdIVDZocFhmYkRsWWh1dXI3UXZuc3djNVFlVXFmakJqYWtkL1RMZ1Zv?=
 =?utf-8?B?ajJ4RURMQ3VSZkdqNG84TXBOdU1ESSs4VXBvVTNZWmZocUFrVG5mWHNpVEpt?=
 =?utf-8?B?MFZ5YTJ5U2NNUFhHeXRYL1RtMnVCdUhlaFNocUY2QUhqNmsxVXZpS3QxTWVU?=
 =?utf-8?B?MC8vMkRMVmFLQzlydEM0dHJ4MHJMcjNTdDZ5WW5EeDBMTEp5dkRNMHc4SmhW?=
 =?utf-8?B?VFJZU1RZcktPcTRoUzFsNkxnZUIzTlZNNGdCT0FPcTFEOW1EUUVDYlNORnp3?=
 =?utf-8?B?eTBkUWdhWjQrWThtNjcreXRBU2dUc21uM1AwcThkZU1ZMHlpQkRHTmdoNmJJ?=
 =?utf-8?B?UHM4b2JQczl3UjZzM3pzZG9LYWZRckQ2OUdGK3o0OVNvMnhFdUcvM2pnVlQ3?=
 =?utf-8?B?OUpYQVdmNXhCTFluY2d6TFBzR29ENDBGQUdEWWlleTNSbStqaVBHOXdySmtS?=
 =?utf-8?B?UzgzSGxPY1dTZXZtVFZ2K1VoY0JIOFZRbkFOVlltd1BMem1NWS9NMkh4WlVG?=
 =?utf-8?B?UFNMNjFhbXlROHJ4UUdkbUlTNklHTFJ3cEtjSTlCeGJVWFcrYzVRaEtOOENB?=
 =?utf-8?B?cHNIQmg0YXlQcTEzRnFtQ3lOYy9VYzg3UGVXRkt3clFWc0lxTklHRlBEZHJL?=
 =?utf-8?B?RWZIbWNtdm5iL2NLazFOOS80R2RjdW12YjNlbFJ1eG91Zm9Td0xHZnM0QUNj?=
 =?utf-8?B?WWRlN0h2bzc5UTRCRUVabGFJaEF3bzdtek1XV1VXSk0rNE5sZndOTVBjSnk2?=
 =?utf-8?B?TTJNU3B5cmFuem12a21HUS9YMk9Pa3kraWNhQm41ck9LcExwbUtMc1pCbjFS?=
 =?utf-8?B?U0RSQXNLRlVHQlZwM1k0ckFrUTZYdXQwZVYxdUFPUGNYYk5NSXkvMklsTnRT?=
 =?utf-8?B?VjdITFRRUGZjamdoczlVblV2QVY1Q1RjVmJWMmRhaGwxT0E0NVRkdWJQK2VR?=
 =?utf-8?B?TGZGT21kZDRlTkhpcDJRb3ZVVk5zTjhzOW04Q3AwM3U2Rjc0MVNBR1IrOStZ?=
 =?utf-8?Q?VYjwh0rL+uS+puaOPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlJ6R0dEQ1N1V3BBS0hkek8vUzh2Vks1aGRJOHhqeWFGYkR5SGNRWGY4eG5k?=
 =?utf-8?B?a0Zxa3F6bkpGYUZ3NHZaUjJqNFEvd3V4Y3IwQ2VGS1BzcGFCQXZUUUlHM1pj?=
 =?utf-8?B?emErZ2xQSDFCcVNwSlIxMVFsUyt3RVJjdlUyRUo1Tk95OSttQi9OZkt6QmVQ?=
 =?utf-8?B?REF2OU16Wi9xK2tXa1lJWUgzS2xVMVFDNWpIRnBBS0xJUHJsaWkwOWhydTFH?=
 =?utf-8?B?cmhuZ2lScVdqMFBmbGJHUDFCZXBXY2cyc0pGc25VOUdlSitLYS8wbHFGcE90?=
 =?utf-8?B?RkJkTjZ5QXNHcFY2ZWxHdGxUZE5uKzdjVE9HNkxmbys3SVJqNXVMUVJiNjZ0?=
 =?utf-8?B?N3hvMDQzNFJYUEhXQS9Ma1dzUEZrMzJ5TDZ1SUwza0FyZWc3dUkvVHBxd3Ax?=
 =?utf-8?B?amtSenVSb1JSOE9IUWZwNEZRbmc4MDBvVnl3KzdMaWhERUhhUTh6NFNobytJ?=
 =?utf-8?B?RFpsaEpIUEk4bG15cmJIV1Mxc21PVktwK00yTzc4NGkrc2xIeUhFUjhHSVpR?=
 =?utf-8?B?aXVPekIxWnNKQUJzWjk3TUY3WlhzbHBRTmp3RWNDc2RTdURORm4zOFdMbHVu?=
 =?utf-8?B?VnpwNnkwSHdPMmthN29tc0xTZ3QrSU9JTzdwMk9sbjB1TUhYT3BRYUM3SCtr?=
 =?utf-8?B?L0pXS3l0K1FvbHJVQlQvNVNnVTk0Zkp5bEhEWHhnZkszZzFTN29PY3o4ek9F?=
 =?utf-8?B?OElkZ1ZrcnFzZnJENkJHMWtkTFlQSWlpamphWlFWZVZ6K1BwUXJTNGZVb3JW?=
 =?utf-8?B?VlY1TjFGdzFwMHJKaFFrb1pIS3ZJUVNqNUNTVDR0ZG83ZnZqR2RtYVc1TXpP?=
 =?utf-8?B?cEhzTWx3SVYvTGNpc292UGpTd25jSmdpLzkrdkNhaUFQQnZmQjZPeGFlWjN2?=
 =?utf-8?B?Y2cwQzJHbS9lTnRaWTlJRCtEWWVEMVZOU2lEK0N0ZnIvMUdrc252M2NYRnJn?=
 =?utf-8?B?SENhSE5tZGtPQ3Z1M2t1RjdDeFdnTG5iS09IZTh4Qmw5S3cya0NSRldPeEVX?=
 =?utf-8?B?WVEzSEZOWHVjL1VEeWtGL3NsTkJZNnJaZmpYYmtDdmFBUE8wUTRvdnp5RWZy?=
 =?utf-8?B?KzZXMHV6UUdTdzc0Vk9icG5KdEE1QVVWbjZhS3MyZDcxNFpDVTJ2Ylc5N2tY?=
 =?utf-8?B?cWllMFBobXAyS1ozVWx2TGlLcTVqVUt5c0lMclJZRlRYRzJyN0dFazZaTGhp?=
 =?utf-8?B?M2g1b0hjcXlpRHNGWERKMWR0Z3lISE5JL2RXRlczSisrWURkaVJGTS9jSkM5?=
 =?utf-8?B?dHZOaFZWcHNjRFhpNUZzTUNUUG9KWGRwV2kyZGVUN1dkWUdBZ05OQjZ0M1cx?=
 =?utf-8?B?TnUxWlJ3SG9mbW5RQWFiU1pGOGw2RGJ3OU1uY2x0LzZiSTZMYXdncmlzYk9D?=
 =?utf-8?B?b29ybjlOWTRVYXJKdEJ1K0FuTTI3aWlQVWF5WW81UExiV29aWkFYYjY5V290?=
 =?utf-8?B?ZERZVk1NNzd5ZGYwaHpDbTZvcDFQMG1oNUJkMTNkOWdETU8zU1pLcGdNdjdo?=
 =?utf-8?B?YmFWcmlJWVRQRzVmSFl4OWR5N3pjQlBxdmxkN29OY3IwRmMyMVk2TlBmcDlT?=
 =?utf-8?B?ZGhwVTlLUEZQRDZXMEg0cTVaYTRxV1h3eUZoREVWeVgwMjFwSFYxTmxvdHhX?=
 =?utf-8?B?L3M1amo2a1JRRThtaDM5aVArVmNNcW1UMHY3bzc2VFhxclNBNTUrbXJiYUlt?=
 =?utf-8?B?bEFvejFQNWNnYUpnRkVqQXh6OXpmbEFZckUyUzZ3bjltMng4WjlOVmo5ZXVL?=
 =?utf-8?B?QUVsM2ZpMDVvYmZzY3JNTlpCV1dnMmlRdmRKRXpHSjVWYjFQWWxsbVJsZEts?=
 =?utf-8?B?NS95ZGg4czQrUUVDY2xSSkt6TEpaWmV3TWpTSFhQQzVWME5rNmtCS2tmaVZs?=
 =?utf-8?B?REVBdkQxdEtUTVAvMGkxaTN3Q1J0SnU1MFRLVVh3S3BSRjJBU1lWMHIzWHJx?=
 =?utf-8?B?MHhVTmU0MXN2QTk3US9KS2tEMmpkM0lBTEtLdm9TZDlnYzIzMzhOazlwelVZ?=
 =?utf-8?B?S1A5SmRnUWRHWTN4c3Y2QTlJZ2NlbUFDT2kzZVRKd3luMThEYTZWZWJpNGov?=
 =?utf-8?B?bVhYQTRmdXppc2dKT051b2RiczgyWngySUtKQ2NUOFFJR05LRys2dmlBQ0g5?=
 =?utf-8?B?MlM0YUg0ai9xa3FBd2NZb2t1eDF6QnpEMnAremlRdTdSTWVxYlQrYUtKb2tE?=
 =?utf-8?Q?WnE5OIL/Vp+dU28XXkkOc8w=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d957b07d-d323-41aa-59fa-08dd16e26cf8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 17:13:10.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Nq+dJiTgcoEFh9+kBynA/Uw6OwcQmX3yU9jQYY/F2VTxEPtLhu4/KSmeR5V2/PmmIW7eDWZMut0OVurOpbM6hgEDHxyNqeEaJp2VKQjmGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF8B8ED9C2F

On 2024-12-07 12:01, Mathieu Desnoyers wrote:
> On 2024-12-07 11:55, Zi Yan wrote:
>> In commit eacd0e950dc2 ("ARC: [mm] Lazy D-cache flush (non aliasing
>> VIPT)"), arc adds the need to flush dcache to make icache see the code
>> page change. This also requires special handling for
>> clear_user_(high)page(). Introduce cpu_icache_is_aliasing() to make
>> MM code query special clear_user_(high)page() easier. This will be used
>> by the following commit.
>>
>> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
We should probably use this new cpu_icache_is_aliasing() to gate
availability of DAX XIP, as described in the commit message here:

commit 8690bbcf3b ("Introduce cpu_dcache_is_aliasing() across all architectures)"

     Note that this leaves "cpu_icache_is_aliasing()" to be implemented as future
     work. This would be useful to gate features like XIP on architectures
     which have aliasing CPU dcache-icache but not CPU dcache-dcache.

Thanks,

Mathieu

>> ---
>>   arch/arc/Kconfig                 | 1 +
>>   arch/arc/include/asm/cachetype.h | 8 ++++++++
>>   include/linux/cacheinfo.h        | 6 ++++++
>>   3 files changed, 15 insertions(+)
>>   create mode 100644 arch/arc/include/asm/cachetype.h
>>
>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>> index 5b2488142041..e96935373796 100644
>> --- a/arch/arc/Kconfig
>> +++ b/arch/arc/Kconfig
>> @@ -6,6 +6,7 @@
>>   config ARC
>>       def_bool y
>>       select ARC_TIMERS
>> +    select ARCH_HAS_CPU_CACHE_ALIASING
>>       select ARCH_HAS_CACHE_LINE_SIZE
>>       select ARCH_HAS_DEBUG_VM_PGTABLE
>>       select ARCH_HAS_DMA_PREP_COHERENT
>> diff --git a/arch/arc/include/asm/cachetype.h 
>> b/arch/arc/include/asm/cachetype.h
>> new file mode 100644
>> index 000000000000..acd3b6cb4bf5
>> --- /dev/null
>> +++ b/arch/arc/include/asm/cachetype.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_ARC_CACHETYPE_H
>> +#define __ASM_ARC_CACHETYPE_H
>> +
>> +#define cpu_dcache_is_aliasing()    false
>> +#define cpu_icache_is_aliasing()    true
>> +
>> +#endif
>> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
>> index 108060612bb8..7ad736538649 100644
>> --- a/include/linux/cacheinfo.h
>> +++ b/include/linux/cacheinfo.h
>> @@ -155,8 +155,14 @@ static inline int get_cpu_cacheinfo_id(int cpu, 
>> int level)
>>   #ifndef CONFIG_ARCH_HAS_CPU_CACHE_ALIASING
>>   #define cpu_dcache_is_aliasing()    false
>> +#define cpu_icache_is_aliasing()    cpu_dcache_is_aliasing()
>>   #else
>>   #include <asm/cachetype.h>
>> +
>> +#ifndef cpu_icache_is_aliasing
>> +#define cpu_icache_is_aliasing()    cpu_dcache_is_aliasing()
>> +#endif
>> +
>>   #endif
>>   #endif /* _LINUX_CACHEINFO_H */
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


