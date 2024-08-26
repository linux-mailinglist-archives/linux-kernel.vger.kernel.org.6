Return-Path: <linux-kernel+bounces-301788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38295F59A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D8FB20CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5566194A64;
	Mon, 26 Aug 2024 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q339g23G"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B9192D6F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687529; cv=fail; b=tvAbuP2q+M5NbORNhOHEMV+cuaf+jdL7K5uLIt1RXAx6gcH78ju/JvK2ZBZ5KZVdZqpnvdJ3iKUv+LUJW/Yjh72H1JA3HCtt96WN0YW51nUoOoydsA+Zs7Rk6VW0FxU94LuwseYX/qdwHauJQmBbh8NsY3iaRQfe95jNq258nqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687529; c=relaxed/simple;
	bh=xlCdf8gpR44bK5deKcO1zBX9aGepeD8UGkzyjPz235M=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=HkKErkbNbu1y3AEdvD1WVI1uAW17RJHHbQA+YCuF0gG78PJSP9fmDxcd1zNZpQoP6RlChJTrI/HhmRrIVFjN3nKKh9tGIc2mIn1Cl36pF4xPEciAghAH19D4XcJ6KoU+A9V1+Kb6QAlArhT9c0HJ1OxFYUsc3n82f6E4zf+yr0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q339g23G; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4rgCtpLXfBOSN07D6LsbdqFQ6eacgSTDfjJ071+Q9muFqvfRmhJPqTzKg9UGhcPndV13jOW4YSPU+xNdfIhKFp+yb+uPhHEkzrh3e5YgF1gRk747U6GmKNwlQQLDbvD+a5rJ3MHD7xqgIwDaSB2PljA4fQgINbIR89ekHuwOQaGzaJRF3w7DXvh8QFjs4gk/iFg6in7BqRekBfP5ST3VjO9IU3Z1O5UyuNLscZMz9WVbdZD7Qkut9KelWYsju2IXgxAmT172UxTlox9w2YYuH9QNXitPEOUnD/VE9lcNDebZ6tC6nTjaIAZYild42AeGIJ8rN4GnBXZI3mYKGnXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xahrw2KPiUc3YCZH1ll4frEVJmkTpdVvQ6I8DoWdGU=;
 b=gCRmiKd5i6RjeoHgdEVUx02H3syV9NJ9Lq6Gxh86UIitUkx5MFgLh6G1Mtwxn1CZMUgGSsrPZCdFb4qL/5V8Wr5ZNi470IG6Ay/mragSEkI/Ff/k1x6fdW9mgrwMpJsG+H4GKqvJOSbHez9KcRCT1dnnpIwgojmYRu/5+mUYMjdu2LFZpy3/6VFeX6XuN/SVNXbmI2h9UuLk+Ok8eQcOe3W4ckx3lu4oUEFDNPkPoBPogW5tPlHmUG/GRS54l7CUTO6TR3gGpwUbOV2TelyjhCtz88yUeGp9yuvJDKITx0h/P6JQQDcVdN0IL/j11JPRNttYqoW48gazWX7Mbm7RNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xahrw2KPiUc3YCZH1ll4frEVJmkTpdVvQ6I8DoWdGU=;
 b=q339g23GhOS5L6nYp8VSaOCxCRk3UziEmWAVQpWi0CziJ5EC81y4r37YI/5QZ2HZyH8UIKimKbSAupaN3z8/c9Ccuo0p8vOXXXsB3DcmxeDIFaijYwzSMCrq7tnbbKBi7LmGZ4GARImVRM7YD1Q2/qZ0HrPJoZJOfO035IS5PgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 15:52:04 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:52:04 +0000
Message-ID: <c2ef105b-c42c-e0f4-6bf3-761dafc8e92e@amd.com>
Date: Mon, 26 Aug 2024 10:52:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Ashish Kalra <ashish.kalra@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
References: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>
 <g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
In-Reply-To: <g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::13) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 85249b30-bda6-4732-a360-08dcc5e70821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFZCT0xUWjJOb2JMNXRibXFTZXJOT2pWUUc4ZWVONkZlZDJ2UnJVeE15QURW?=
 =?utf-8?B?dzdEUE50ZTlsYldiZ3B1U0tWZmNJc1BIT2taTEd6R3ZERDlHQ0lBdU4vZlVJ?=
 =?utf-8?B?RHA3Mmd6UFdRYUJ5WXBKY09RU1VqTEZEbGRVekdWeWJ0L0syWkVFR3hxYkdZ?=
 =?utf-8?B?dnRsOTd1MjlRYUNHcm43Z2Y4RW5HZXpzaTBYWGJWb2ZVOHZFWndobXk0SjBr?=
 =?utf-8?B?VnlZcUIrMW81WVM3Q2pjeFRSeE82MWp3a1kyeHZYQmRyVTlNc0hHalI0M0VW?=
 =?utf-8?B?UytOZzlPd2x0Z25GQTFVQUhsdVVKRGJRbXIzcVgwYzNmTUUza2YzekNCdTNI?=
 =?utf-8?B?aUNlcHZ4NnNZeU0ycWZjNUUzdUE5SXVHZ2RUMGdqVDFYdnFWZ2dpdVBKZW9k?=
 =?utf-8?B?SWowbW9jbFVsZmhySWRGOWFUdmJ6WnFtWE43UkJJRHhoQjBTRVNlNVkxb3ZU?=
 =?utf-8?B?NEd5WllpUklTR2xIdk43TjNvcmI5RDMramVxZnU4NlV3N2N4K3NPSmhWZVh5?=
 =?utf-8?B?cjV1dW1SeVRFMEYvZEUyMjRxT1Z2YkhnTjhhemhPTHhQcmgrb3lTRzQxTnNT?=
 =?utf-8?B?ZmJHS29OTjlYU1ZLRnFzcXJ2MnBjY2ZEeFpDS2JaUkliS2owbTdpOVM1VTZC?=
 =?utf-8?B?Q0RtOXZYZU1ib3JOTEozR1g5OHV5TUdsTHB2MUNmclpQM0dXNk1VQUF0YXdw?=
 =?utf-8?B?Y1dDYU4zbzJaYjQwelBQaDNjajgwSG9YVWxja24xUEkrTXlJajBobDd2Mk9o?=
 =?utf-8?B?ZVZDY3lXdW9ZZHMrbHN5aEZVNXNCeVRiZklpaGNOSVhOVzZmdU5yNjZwTjY3?=
 =?utf-8?B?Z3RyVW5IdHgySHJON2dVdXFsaXhFa3Vhd3NqMHNkQ0kxNDZUR0tFVCtrN2tH?=
 =?utf-8?B?UDl2MFpPdW9KeW1aOGhjcURFOGh1NkZXTnJxc2MxaytnYlVPQ2Rqd2w3c1JW?=
 =?utf-8?B?VFE0Z2lsMDh5SkwwbFhqekVZRElLQTE3RHAxc0lXZmhwOWZrck9BQWFqT3Vr?=
 =?utf-8?B?MXdjMnY3RzI1MlNRZC9xcnlzWW8yNTdpM1RreVBsbjdDTmNNQ1FhcHJlWlRG?=
 =?utf-8?B?THVoRDUxOVA4WE8zY25WTVF4ZzBrSUJhNFRzVEg3ZnBGSnRUb0R5d0FtS1Nv?=
 =?utf-8?B?S3FpeDREQkRIS0ZqY0c1bDZPOXcvMDR3aHlhQy82bVlrVnRIMXpHUXRqR0cy?=
 =?utf-8?B?eFhwaEJHN0lPRFFLbXZxSytXZ1JrclROQ28wQUJmZE4rK2JZZTM5czBPcndt?=
 =?utf-8?B?OTlPRlNEQkNIOTlsZ3RjcDhtVitMYVprK3hZcXVhV2wvQTlwV2JIczZhQVVl?=
 =?utf-8?B?bUtvVllkQ0FURnBqNEtNWVJSaGtaeGg3OFk5WnpCQk9oaVl0c0l0UW5wWDZm?=
 =?utf-8?B?TFg1SUNZNVVNanNweUxPSG9oQTNYSjRRYVA3M09yVUZnbEVBNy9YOWFJZitO?=
 =?utf-8?B?MnBUcHEvZ213aUlBWXVDWldMOGdBMEpBdzdFY3hRVGIxMGxaNmd6UjY5VE9I?=
 =?utf-8?B?eDExbTdXeHcydTFFbXJsRmRrY003cDZaUmVxeUF3bnhOdFNGeE11RENDL1Fy?=
 =?utf-8?B?ZGhkc0RmUTFsMytaS3Z2cnRoajRKNzBMdlZrWTczM010N2RsbmZHZCtqSVNv?=
 =?utf-8?B?WlBVWTVEdVVNRldJUC9yaVZ5QjQ4NHlHSnljdHlibnRMb1Z2YzJJaDM5K05W?=
 =?utf-8?B?U3NaRXo3c1EwcUFvbFpKMEZxWloxZU9hb2tyREY3RUFSSUkrbXF4dzFWWHNY?=
 =?utf-8?Q?t4zwec+UV9QI6nOTtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZNTzNpMG1pSDROQnFzblMvRkZ2bWsvL3QxTWJicEtQYldjSzVJTUtqU3E3?=
 =?utf-8?B?MVFqbnBoYkU1N20vUi9qWU15eW5YMDhvUHJwQzRabXhQQWVJVFpoWFJjK3Zw?=
 =?utf-8?B?dm84S3M3TWFBdm5XM1lWbk9aMG5NaFpLbytncVdKQ2RnaTdZRHR1NU9Vb3g4?=
 =?utf-8?B?R0FUcDdTTHp0UHQxQlR1K1NkVTEreXNFL21NNTc4RGlrSHJ4Y2cybFhneHA0?=
 =?utf-8?B?LzBoN3ZqanFQbHZmMk52V0NKNk1DdDUyTzl1bzdva2dvS0NrTUxDM2g1bDh1?=
 =?utf-8?B?aTBEa1g2RGxCb29tdVBySk1PMU5mbmx1WjNrS1dCNUNFY3BwQUlPazdBemRJ?=
 =?utf-8?B?R0s3UlVKQWNuVUNRbDNnaGZSRkZQaExIaGlLaHpLV0RKSk1ybEdxaVNnOWJD?=
 =?utf-8?B?ZFEycUhSTVVqNXZrSGNiVVM1czNSS20rWkhDSi82K2NWTlNYVDgvL1JIMzVq?=
 =?utf-8?B?QnQ3aDF4aGd2b2xiTTBUOXVuc09mdmdxT0VmNWY1eFpBZURha1JnZjY1Y3RJ?=
 =?utf-8?B?S1Z2M2x0L3pCZ282R0FIUEE3bk9GOW5Jbkx1QXlCUVhjUHpLMm9CNUwza3Jj?=
 =?utf-8?B?N1hrQ2ZDMm5jRmhTanE5enNmZndieVRZU2czT0c5bXNLK0lSZmZIWFhLKzJT?=
 =?utf-8?B?YWdZNUhRSGZOdmF1UmhUaUNuVFpRbXRCVVh4Uk9WL3Uyd3hjM1ZGaEx3RjlG?=
 =?utf-8?B?bG9BR0lyZTVYaEREWFQ0bzFOckhRZ3c3UzE0Mi81eXlSVi8yOEpyTndBcXBL?=
 =?utf-8?B?NFNnMkN4VU5zQXNGdDliZDVKU2ljRnZ0OUM2NDlaUkJwSk1pTG1MWDhPVjJX?=
 =?utf-8?B?N1lhN0dRNm9LQzZoMEkvSHZBNmJDYzM2VVlJbWM1Wnl5QlpMdldMVmFWcDRM?=
 =?utf-8?B?a1I0bHNSdGN5cHc5WWJtNWVDZHp3dmxkb3JPWHpCVjBHTnR2TGg4MmlwY2Q5?=
 =?utf-8?B?S2NDSk80NzgrVzVlKzRESmpFVVVjaVdWdi9Qa3lkN1JNak41S0laYy9HdU9i?=
 =?utf-8?B?QU5ickU4WFpyMjY0MEZ2T0NBM3pMTDc0U20wRHhzSmVNbGcrTWVORkZUd2lk?=
 =?utf-8?B?dXkwSlJJb0ZqS1dPSDVXaCtvUFd6U2w3ekh0TFo3eGJqSVNuMFIveVgxd1pj?=
 =?utf-8?B?QjlQUWQ4ZkM1eVBwdzFxR0hPUi9CdncxOVlRNmhtOTd5MjBTaWNLaVZnNDdL?=
 =?utf-8?B?L1FTOGtKZGhuNlZmM0U2KzhkVnk5Y2VqMFZKcGVBTVVDOXcrTUgwOG42VEl1?=
 =?utf-8?B?WWZvTUtpZmpiZXRtSzIyWTk5by9sTzMySWNIRGtHWUpzUk1KYTVsNXZLMysy?=
 =?utf-8?B?eG9WY3lXNEpDR0Yya3BXRHI5TitsQ1JMTG1uZEkwdzVQNE1GTG83VUxIdDE3?=
 =?utf-8?B?YTUrd0FPTG5jQTdYOEg2ZWJ4c215UFJDNlRsVFUzZlk3ZEs1ZjRtRmhGL2VX?=
 =?utf-8?B?QkRVcE9GbFB3dU52bEtibWd3Q0pKZlJ1RFdCSEF2MW1SRkU4QnJoakxVU2gx?=
 =?utf-8?B?Nm13MDlic2Z3eTdpUjh0TE1waVp6WXB1eFl6Yy9xUlJkYy9EYnFJcVgrd1Ro?=
 =?utf-8?B?RjBRdEd2c3h4MWtVM1JlSk0zSERjKzM4Rm01Z1VBcjNaek1TSGFBOUYrTWNo?=
 =?utf-8?B?WDNIc2xwRVBSYm1KQjFVS2N4UXV2MENNRFJGTTU2ZDNMNzhObjRhR3M1NGoy?=
 =?utf-8?B?NWR2Y0lLNVVtdXBPMXM3bjNJODZyekNhTGxlQUlld3VHb0FTeFBxQ3hRbldL?=
 =?utf-8?B?V3Q4QTU2NHRyZjVkYXdqUGQ5cS9VRUtxcG9YNUxBQmJCOHBGWXdlU1RZTVNX?=
 =?utf-8?B?OWZFRmgrVG4wMWhnbU9Dcm5YUVdka1hLUWNzRzIxV0RZckR0eEQ4SWRKVXFz?=
 =?utf-8?B?M0lMWWJoSXlCZGJxUFVJNlJzYmN0aGhEeWQ1Qnh6SVg2Q1FNQmxLYTZ1ZjEr?=
 =?utf-8?B?dk9NbVQrSGtQVm8ycmdjRUo1MURlL1NxSnIyOWNSQ3dKdjYrNng3Uit3N1Va?=
 =?utf-8?B?OEdrZU9BRmRFUTFTcDJaTzZOb05uYTh4RE1JeXNGM2NMN3ZPM0VWTU9xOXU0?=
 =?utf-8?B?ZE9kQkZ0bW1FQk1YYTlxRi9rN1NDMTFKN2hNRElzSW51M0dMbGNqTTRVamp1?=
 =?utf-8?Q?ue4kOVLIR2hRBntZvy3S+GU4l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85249b30-bda6-4732-a360-08dcc5e70821
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:52:04.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ybj3dcYSfHqm7oLA1cs8ISuKaLSkpxMywTkKx23ec1TJieUvdBAUfdcIZ0aDkqN9wlpwILnolbaxI9dz5B7hpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

On 8/26/24 07:25, Kirill A. Shutemov wrote:
> On Sat, Aug 24, 2024 at 11:29:39PM +0100, Maciej W. Rozycki wrote:
>> On Thu, 22 Aug 2024, Kirill A. Shutemov wrote:
>>
>>> This issue causes real problems:
>>>
>>> 1. If the kernel is compiled with EISA support, it will attempt to probe
>>>    EISA by reading 4 bytes from the 0x0FFFD9 address (see eisa_bus_probe()).
>>>    The kernel treats this read as MMIO and accesses this memory via
>>>    shared mapping as we do for MMIO.
>>>
>>>    KVM converts memory to shared upon such access.
>>>
>>> 2. The same memory range (0xF0000-0x100000) is scanned to look for the MP
>>>    table (see mpparse_find_mptable()). However, this is not MMIO and it
>>>    is accessed via private mapping.
>>>
>>>    This will cause a crash if the memory is not private.
>>>
>>> During normal boot, the kernel scans for SMP information before probing
>>> for EISA, and it boots fine. However, the memory becomes shared and causes
>>> issues on kexec when the second kernel attempts to scan for SMP information.
>>
>>  ISTM that `eisa_bus_probe' has to be updated to `memremap' analogously to 
>> `mpparse_find_mptable', complementing changes such as commit f7750a795687 
>> ("x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI: Use memremap() for RAM 
>> mappings") or commit 5997efb96756 ("x86/boot: Use memremap() to map the 
>> MPF and MPC data").  Both just access BIOS memory.
>>
>>  Can you please try and verify if my proposed change at: 
>> <https://lore.kernel.org/r/alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk> 
>> has fixed the problem for you?
> 
> I like the direction your patch took. I hate sprinkling
> X86_FEATURE_TDX_GUEST checks over the kernel.
> 
> Unfortunately, it is not enough to fix the issue. memremap() in this case
> will still boil down to ioremap() that would set shared bit:
> 
> memremap()
>   arch_memremap_wb()
>     ioremap_cache()
>       __ioremap_caller(.encrytped = false)
> 
> I think arch_memremap_wb() should be mapped ioremap_encrypted() in x86
> case. See the patch below.
> 
> It seems to be working fine on TDX, but I am not sure about SEV.
> 
> Tom, any comments?

I haven't dug through the code that thoroughly, but I don't think making
arch_memremap_wb() be ioremap_encrypted() will work for SME, where some
data, e.g. setup data, is unencrypted and needs to be mapped shared.

Let me add @Ashish to the thread and have him investigate this since he
has been working on the kexec support under SNP. Can someone provide the
specific kernel options that need to be in place?

Thanks,
Tom

> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 1d60427379c9..ef79cbef1ef8 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -180,6 +180,8 @@ extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, un
>  extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
>  #define ioremap_encrypted ioremap_encrypted
>  
> +#define arch_memremap_wb ioremap_encrypted
> +
>  /**
>   * ioremap     -   map bus memory into CPU space
>   * @offset:    bus address of the memory

