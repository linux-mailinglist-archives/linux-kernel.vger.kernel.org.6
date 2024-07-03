Return-Path: <linux-kernel+bounces-238595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF10924C94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26181C2183A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D5B624;
	Wed,  3 Jul 2024 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UBSlFX3+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2102.outbound.protection.outlook.com [40.107.244.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B8621
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965097; cv=fail; b=aRvp3/fTcsgCysStY5+33MjFew2Xasj5qoQSBz6WW58OsT0JSQzMdESQ2A7TleUefGR/bJHt4hndQFZ8c3Wk9DafaWkvxJotM9KiLV/UQFJDZPa9wCf7DvP9KQl0I25r8uEqkBqJrKvjh+2mKUCRTV4QTtpRuHwntVMlLOmdwyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965097; c=relaxed/simple;
	bh=HPp25H7y8SpHaex2csxZWzyeBhYAR2u4D9ewnOx4Vh0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtKASBc5QN4TVB8lwB8VvEb/MKOIdtkfJ4iG9Uj/cdUTUtTJJ4/9/pdabHXoFAPxrQqGhtuPhGr4CC2QHOHmoNCUNymtVq34ibFqtTqwim5G+qNm3YhTMFv3ozR10ORL6WuItxBfTlVITuwdscm04/jXUpbg+VghFs/JgJCwYnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UBSlFX3+; arc=fail smtp.client-ip=40.107.244.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ8z5aHbippSJAic5aEXD0ZtqHQUInOSMcyqwigcAwTGQCb87VVRZyVTfSseqg0ynamq2QeEFzIiiLN/8unHCf+5f8x5bN1USR0GxQisdEM4StVHTJNg47EwD+oYRqbw52yhiajSvsqbp97/imDblM9tD+TpP4Lr8Ppk5DaKijxt6iuBNrYlJJff7IDM9Lg+oUi2geZe3nU0ASXxEPYtb1Zt6pJ6legqoDe8YQelterFq5XXRM6/nBlbBRaZa4q+z5s/Hsz/yNbSK1nX2LzVToIqMhEMVFNK2Nzofye4CDBpRSLxv5HRB7WbC6ghsJqXA/Z4qxNXsL30EuHjlGVpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDTjmauHgFhzWq93XLXeQtj/jhSUWrUM496gpNXQjD8=;
 b=K55jdDmkofI9w+0mdnJ2j96AGuf/cv6oqdm0/l7kiblWIz2lM/J2LVegyvk5NYiIhQQEdhNMlrF6vzmLPi6gTN9wqzfieektYnXWZl9D9wcJViSxCQBO8ooZCvQzRyFWqCiTU8/D4VPq3fJBn6tlVsMfxgrX2KXKxMaVVORbaKDyUSpFuxdQL3xc0yi41++9Ba3KiAkH0cgb8V+HqCwOWBfkMx9Rctx8nb8TcnG/v+PYUhuqXvAF4SiVBLfZhiAJ4HCiTlcEJHxJljYVc6mE7/sLdpcv/uFvMgOYrhuo+qisuWkrOD+kJeQhxIw+77HNaUSH/QSk5zwwWEUYjQIoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDTjmauHgFhzWq93XLXeQtj/jhSUWrUM496gpNXQjD8=;
 b=UBSlFX3+VKUxoflxQwn/E7zobMY/m6PVUnKGr/aKa80f4Dj1nSQNfjuhQ1q+wTTHiiSjJ0SKcJh33iWVMOVwzdDUz/Cwr9yT/EnilpNbmoofr1vpnsm0uFGWI8eMhvYak0dj0OZ7mYAzWqeUCAoJvROu28HEe7GaYc5dsB/R0XE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SA1PR01MB6640.prod.exchangelabs.com (2603:10b6:806:1a4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Wed, 3 Jul 2024 00:04:52 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 00:04:52 +0000
Message-ID: <7a4a60af-e471-484b-a4a3-ed31daaca30b@os.amperecomputing.com>
Date: Tue, 2 Jul 2024 17:04:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlbfs: add MTE support
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZoPz14fYSqVyvRTw@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:610:e7::18) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SA1PR01MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a77d9ab-9b7e-4296-b9d6-08dc9af3c355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhMK0l1Mk84UWZ4MW5HNk1KOGtBaTEvM3p4MURJbFhLU0g5bEViYm1ZZ1pX?=
 =?utf-8?B?WHlpam1JY0hWa1QxMENsYXNxTTdFWVIxdHU2K1RJNys2ckYwQVNudEJkUFRP?=
 =?utf-8?B?cHBqU3JMSm9PK3R3STVwNHplWXdOSVZUVGpIN0lZQjZ5dCtmNjljQkZqcDNi?=
 =?utf-8?B?QjFMdEZQTjU0L2VrUHRpby84LzRCOFVJejNTMjB2TDhXTzV5U3dkTGp3SzhI?=
 =?utf-8?B?Wnp4ZGhDb0N2MDNQYTNwUVNRQVVFMnhQUWJnVVh2NVpXdEljSjZ0NkNKY3gy?=
 =?utf-8?B?NHdwZjQzMWY5bTU3TmFXSnZIaXh3ZkhiTkpXMmJISmIwNEcyellRb1FuRmxw?=
 =?utf-8?B?bnQ1QzBjTG9oWFJDMEtZK2swc0JQcXJOeUI3Q0lqVFNnOHk0bGtBR2F2eGpY?=
 =?utf-8?B?RitiNEpBQmtPTEVKMFl3NGxlcHI5R0pKcDQ5N3MvUWtQNGxIREdBSnJLNW04?=
 =?utf-8?B?TjZtVkNBOE5CcTZpdXpRZUo2Sm5lZzhnZVNLTXBJd2kzTzFhYTN6ZnR0amo4?=
 =?utf-8?B?Z3VBcnJwdElRY2toS0x6RmFPSlk3THN5Ri9CTStISk96aUlFdWV0dFVPejh3?=
 =?utf-8?B?TlZrcStWZUM5NHVqbk5RdGZveDViV1VTTkN0ZE1RU05XelNyRzR2ZFZaQ25t?=
 =?utf-8?B?YS9aY3ZKcEo5dTF3cjV1bitCQVJNVkFyNUZlbDBTdHBaUFRucnpXdUNDQmRZ?=
 =?utf-8?B?RmQ3WlNXVGhjRk9yM21KSkJ3ZitkM1VET1ZHVDNram83ZXJUUDhUMkRHc0RI?=
 =?utf-8?B?QUt1dWdJNWgyNm1YcGpBOFFEVmRvOVVmbktlcGhkd2ZOV3BxTWltNENIVGdM?=
 =?utf-8?B?TFZXaVQxNXhuQTNnSVBobUJPNnNSSGRoSmdNa0pJdThMa3hiQXNiNkk0S1Iw?=
 =?utf-8?B?Sjk4d1V0ZEJDUGNnV0JEdFJHQVcrdW1ZM2RSc3NhenlhQm43THhUd3NtS0o5?=
 =?utf-8?B?M0pxZmNhaTNzWHBvL0RTSHlmUm41TEpJaUd6OW5idVV2TmQ3THBDVk53WnZa?=
 =?utf-8?B?TGhwQVo3bm5qTk1pRU5VemNJNEFVOE1DRGt5SWgrdC9LN3JUVnRQM1A5NGkz?=
 =?utf-8?B?R25qbEx1TEVYcjUrS2xnM3g4ZE9neENIdzhLa21YYTNTZ2xDSE1GeHZzUzZP?=
 =?utf-8?B?NENwVmJ4Y0ZXUFNJclRxRW00bFkrT3pEZFRZMWVjNnl1MSs4UmxPMDNaVmty?=
 =?utf-8?B?M2xvK2xXTTl1WmF4TjlqSnVtRE1XaFQzc0FoSUllVU9POGl4dmtsV0tScmJt?=
 =?utf-8?B?RDFreWR1cVREU3JPUHJjM1F5TTNpRnA4Z3lJRllMZDBuLzdybzczaU1wSWlW?=
 =?utf-8?B?SXR0bWd5NERDMVUwN3dLT1RZMG5DMHNmaTNoYlNuREh1M1pNSnJ6b0dxeWtB?=
 =?utf-8?B?SmFqMmhIOEpGdVdqV01QWG0vOGFhc1l0Y2N5UFp4QmtoQlR2Tjg2dEE1Rmtl?=
 =?utf-8?B?alBoVW9sdmQ1K05iNG1RMWpvWVhTSzQ1Tk5rSGdVOXJJMUVsbFJnUGIzOFdn?=
 =?utf-8?B?am5jR0RyRzgzSXVML3h4NHYraERIQ2Fpa0lTbGh5NTNNKzBuRHFOVDM5c3Aw?=
 =?utf-8?B?cDNiaUtoamRDTFIyd3dQZlhtaTNRdDlTeDl5TEg4MGluV0dDbkIzdXA5dTIx?=
 =?utf-8?B?THhOeHlobVRvWFNNYzhucFhpMHpwRUdDbjRUam5iNG84T2VCUFlhYlhMbDVt?=
 =?utf-8?B?NjQza3paV3J6d0U0bjUvOWFWNDZ2TG1hbkdBRWtDUmlEY0UvZG1MeStQejdm?=
 =?utf-8?B?b25tMTROZ2d1b2FRcXQ1Z21KcVMxZFBwSE5CaGV2TXM0SkVib3hXL2VKZjZ0?=
 =?utf-8?B?Yit0bFBpTkdHQ2xOemttQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ni9OSlduQU54RXFra0NnY1VKc3RlQTFtemFjUHdHV2FOQklkay9uUmdzWWMw?=
 =?utf-8?B?b2pIbkZTUElsUUdZSUg5TFRadHFxZytNbHZiQXkzNENidFNxUms4MFVFakRG?=
 =?utf-8?B?Y2lMTDVBZGNYYVlKbjNobUVJYmVLY1JBcytwTnVRalA0S2hNRGgwcDVEM010?=
 =?utf-8?B?OUFBcFp5VnhhYWJkZ2Y3YkRITXBpdnphMjlmMXV4THVOTUY5a3BUZWVkeXFQ?=
 =?utf-8?B?Wnl5Z0JWWWZib2plZDZxZERuWTVIcVFpbUk5UTVlSHZBb3NIcHZ0S2hWUkVW?=
 =?utf-8?B?NklkU04yWm9sSEhoOW9WWFUyNk96RlVtbDZaZUp2ekRFOHNxcGFOc3hQUzdG?=
 =?utf-8?B?YTVJUVI3eVhrcHNWVCtQMTR3V1RNN3Q5b2ZDeXM1UithWVJQYUgxbTdOaEdC?=
 =?utf-8?B?WGlRMEQzTi9RU1A5SnN0anlXN0RzY1p5ZVVWekl5Sno1djZNWmN5WUphTEMy?=
 =?utf-8?B?cy9KaHdnLzJ1VXhxRGY4OEFmbFlMUU1tb1loSlBnVE9PczBCTFZjTkFDRGg1?=
 =?utf-8?B?aWFjYllwTmNZMVBEZnZaWTQ5SUdadkF6QVdOSGorQS81THpsQUluYnVxaWhq?=
 =?utf-8?B?WXdLOWFLRkNIYXpid291YXgrTHR3RlpoS0Mzc25YWjNWNnZSSUZya1pEc215?=
 =?utf-8?B?Z1Z1aGRGYnVjUHl5cy9KbDk1UzRvTUZiUFNQWGJOWUFaRHRXNkdkakFMdzN5?=
 =?utf-8?B?UE9aWVpJSXJCWlAxTVBIdXREb2FJVE96NkVWTFRQY09zdm9CaXNZY0JIWTZp?=
 =?utf-8?B?angzQ0g4ZkFMbGN6WlNlSUUyTnpiVmxleHpwcE9iL3lDWURMcUdhQzFCakpD?=
 =?utf-8?B?Q00renNVZWpqL0JYNEVrK0JTTVZTdDZ6dUFVRGp6V2lPODZqU3ZWenhlaXlr?=
 =?utf-8?B?bnphcktTSU5FY2NDVkYvK3RsODFhSWxHa3RTYXFhQjZqWWZxbXQyek9xaW5V?=
 =?utf-8?B?UVBOd3gwMGtQQVlnMlBuS0ZCdHpFZitNL01VcnNBUkJCV3BSdnh2ZDd5RFA5?=
 =?utf-8?B?dERib1oyTXZZeCtiWmVUczNTUVRHbFhGRVc0ZEpMbGp3WmlYc3F6ZEgrRXhB?=
 =?utf-8?B?dFYxc0Q1R2Y2QmhXVng0RWdjWWlkV0lzMUFjUHBNUjlxaDZOajJOa1E3aUQ3?=
 =?utf-8?B?RGpDVDE0cTNVSUlhelNkR2lJZk5STE4zaVBlVWhQY1RqejdNd0QySlZLUEJP?=
 =?utf-8?B?UGNMbFhjU2w1R3RuSEN3YmVZcWIrMnJ3b3dSL2lBaEhoYXBtSjF6T3BZYnlV?=
 =?utf-8?B?TW40d2R2KzJjZFVsUjlPeFFqSEI5WHUzT080cGxaZjFTZkpIUHVHNHRaV3ZC?=
 =?utf-8?B?bnAveUJqTkpoQnpjNW5hOFFZaXpVaHhocnlhR2hrNm0zWlRuUWcyYlZWYjky?=
 =?utf-8?B?K0g0OE1ERnhiQzRHUUh3R2IwcE8vWHVqYzlMdUhwU0g0VFphb0V3RVcyZ1A3?=
 =?utf-8?B?RVZPMzhncmhxT1ZQS1lVSE1kUFJNSGtPU1BOT0RHYnhjM3JlVlAvMDNwcFpZ?=
 =?utf-8?B?WTE5aTZBbGFvejJaNkdqd1pvQ0w4K2NUQWdRMWU0eFJqYzk0TUZFNk94dDFT?=
 =?utf-8?B?eXNsYnRIVnlEV0dpd2cxOFBteEZMNFltdTNsK1BGcC9FVFltM3NvUXhaUURP?=
 =?utf-8?B?K2trY1pqUmNyUUNYMzVEVUI1dnFhRUlXbUh3UHFOUUUrdHhuVHAxOXlXNElG?=
 =?utf-8?B?QkNQbE5TQkhtVG93SWgyRThSUVRHekIvQXBVYXJzd0NIT0d6cDdqeC9MN094?=
 =?utf-8?B?eCs4RDlSbVV3b25VeDBYakJ5ZVprYmNhdFBDZ3A1L2RzMmxkaWdscUk1eTZL?=
 =?utf-8?B?K3BQaWROZjkyOFlWdnVtTWo3WU9aYndESysyRUE0bzZHdlRmL0FkYi9mWU1z?=
 =?utf-8?B?ZHRFZTlySXR0aWlhNkZUOHFqMTBWa2p5WDdZODRrWmRmeWRCeUlaSzZJWHR1?=
 =?utf-8?B?SmRURE5yNUZIWndic3pSMWxTanFBMlRSK2QzbXJaNUdVaG9XUlAzRnVBQm42?=
 =?utf-8?B?dU9HWXBESHNKbEZNN1QvZUpab2pkZ2JoQ0hkbWxhOGl1UVV1ZWllWWRrdm5k?=
 =?utf-8?B?WldRQ3hJSnRlTWIvMmVhTUx0azB1czR2VzVGUTlqNzhJS3k4OThPcjhvV3lN?=
 =?utf-8?B?S0t0YVdPVUduZnUzSEUrUHE5RG5ZMjljNFlHQ0hhTUorRjFHWFg1dHFxWGZt?=
 =?utf-8?Q?EUCk2aUYVq7h4FJPEAwlFHo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a77d9ab-9b7e-4296-b9d6-08dc9af3c355
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 00:04:52.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/mpiUU5/+xrqPieqXoVqUIRfqmySSUdJ/C7h8R2O7XcfgNILfDpyg6PtoqojhKJu7xkUDYNauGPpGEeoulBt7DfTuhH+TuITGw1T2l2p60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6640



On 7/2/24 5:34 AM, Catalin Marinas wrote:
> On Tue, Jun 25, 2024 at 04:37:17PM -0700, Yang Shi wrote:
>> MTE can be supported on ram based filesystem. It is supported on tmpfs.
>> There is use case to use MTE on hugetlbfs as well, adding MTE support.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   fs/hugetlbfs/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index ecad73a4f713..c34faef62daf 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>>   	 * way when do_mmap unwinds (may be important on powerpc
>>   	 * and ia64).
>>   	 */
>> -	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
>> +	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
>>   	vma->vm_ops = &hugetlb_vm_ops;
> Last time I checked, about a year ago, this was not sufficient. One
> issue is that there's no arch_clear_hugetlb_flags() implemented by your
> patch, leaving PG_arch_{2,3} set on a page. The other issue was that I
> initially tried to do this only on the head page but this did not go
> well with the folio_copy() -> copy_highpage() which expects the
> PG_arch_* flags on each individual page. The alternative was for
> arch_clear_hugetlb_flags() to iterate over all the pages in a folio.

Thanks for pointing this out. I did miss this point. I took a quick look 
at when the PG_ flags are set. IIUC, it is set by post_alloc_hook() for 
order-0 anonymous folio (clearing page and tags) and set_ptes() for 
others (just clear tags), for example, THP and hugetlb.

I can see THP does set the PG_mte_tagged flag for each sub pages. But it 
seems it does not do it for hugetlb if I read the code correctly. The 
call path is:

hugetlb_fault() ->
   hugetlb_no_page->
     set_huge_pte_at ->
       __set_ptes() ->
         __sync_cache_and_tags() ->


The __set_ptes() is called in a loop:

if (!pte_present(pte)) {
         for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
             __set_ptes(mm, addr, ptep, pte, 1);
         return;
     }

The ncontig and pgsize are returned by num_contig_ptes(). For example, 
2M hugetlb, ncontig is 1 and pgsize is 2M IIUC. So it means actually 
just the head page has PG_mte_tagged set. If so the copy_highpage() will 
just copy the old head page's flag to the new head page, and the tag. 
All the sub pages don't have PG_mte_tagged set.


Is it expected behavior? I'm supposed we need tags for every sub pages 
too, right?

>
> I'd also like to see some tests added to
> tools/testing/selftest/arm64/mte to exercise MAP_HUGETLB with PROT_MTE:
> write/read tags, a series of mman+munmap (mostly to check if old page
> flags are still around), force some copy on write. I don't think we
> should merge the patch without proper tests.
>
> An untested hunk on top of your changes:
>
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 3954cbd2ff56..5357b00b9087 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -20,7 +20,19 @@ extern bool arch_hugetlb_migration_supported(struct hstate *h);
>   
>   static inline void arch_clear_hugetlb_flags(struct folio *folio)
>   {
> -	clear_bit(PG_dcache_clean, &folio->flags);
> +	unsigned long i, nr_pages = folio_nr_pages(folio);
> +	const unsigned long clear_flags = BIT(PG_dcache_clean) |
> +		BIT(PG_arch_2) | BIT(PG_arch_3);
> +
> +	if (!system_supports_mte()) {
> +		clear_bit(PG_dcache_clean, &folio->flags);
> +		return;
> +	}
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		struct page *page = folio_page(folio, i);
> +		page->flags &= ~clear_flags;
> +	}
>   }
>   #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>   
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 5966ee4a6154..304dfc499e68 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -28,7 +28,8 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>   	 * backed by tags-capable memory. The vm_flags may be overridden by a
>   	 * filesystem supporting MTE (RAM-based).
>   	 */
> -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> +	if (system_supports_mte() &&
> +	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
>   		return VM_MTE_ALLOWED;

Do we really need this change? IIRC, the mmap_region() will call 
hugetlbfs's mmap and set VM_MTE_ALLOWED in vma->vm_flags, then update 
vma->vm_page_prot with the new vma->vm_flags.

If this is needed, MTE for tmpfs won't work, right?

>   
>   	return 0;
>


