Return-Path: <linux-kernel+bounces-246757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F8D92C63E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CE01F23654
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE15185623;
	Tue,  9 Jul 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HZKOWLxv"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020142.outbound.protection.outlook.com [52.101.51.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91C14F9C5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720564211; cv=fail; b=SSTkgTY9v4H9EXPaOsWehfZBBPDKLBmXEBMM07CoopBqk7SNfleSsajONEZViyqNGL+bD69UUST8lxJWMPsCYR6qj5djAqubE1WiKY9P7qSZMB1QRCil5Aqgh5mHxgv76LNYimcO7QSgTWbt3c126OURwanRSpwjZ3ERLO/z86E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720564211; c=relaxed/simple;
	bh=8+Dbj+G/JflBlBI8F5gCOl1XxyNoVrl5vpYD5JZV1Pk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vDit/4fIV1ZPG6W07bR7bxfbKzSWG6OlIzekK4301XtV6ZuuV2qx5xiyZmPodP1tJSXg2BAZ5NWczpJKQEGIV8j+CtLBPaB0Z+9R9lbl6mTeYCu+Ob2DU/Vw8RB617qBdHrn9GNXyAnn8Z4TRNY8BBqtDU+ts00Ua7sSYAxJEME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HZKOWLxv; arc=fail smtp.client-ip=52.101.51.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNUTkX2wzkbncTRtui3DZ+7Qci0WqY/ummxar74aCJyKhAG1pTiRXcXz02jeUOFbihhp2ph2Srm4pnSaHty1I2haVLI1h8Z3DN0IOD4TwO+tvfF9yrw6Do6xxW3no8dwlpFxND5p6kvL2nGqhvhpWogm1Y0AuUgFKyYzwmBRa0g7Le7fiU/IXUEcjPyozezyOmmTlQlGR1z5aueIG4zzmwzkYPHxeu3Qb15WKejpXIdetIdPxNwAeqPG4Am7qQnIaIyh0tFBs2ATmbfnOAKnM+PspHd/YlaymUH1h9MZV35XaTmLHdbZzrAX02chq57PX5ZO75tduojI7e5HxgkPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vVWwHdA1siAl85Om5D0yuWv8t9KHd+lfgc34ftp07Q=;
 b=GyWaFK7DzZcuZ5su6jsf6y9+rUoX/VwovB0lNrZl1/q8ZcW7Q6+oRiVVESqZqCDzFXXUMPwzW5fPpB42HThWYRg2P+k491HZ8XnC8yOS8e9/1YGHyJjQMv93PP1cZVxpebkI88hWFgFF2bizvyP7J+Lem3Wm+D/eEhj5THOwOb5wn8FF2n2ArhR/97q7PJFTENm4RUvBbM+n6fhIcFZmcXcYKJUoOYb7ESR7vF1CyHId+ylttUNWKGTkgvTQWdvsrp/roY8fqwdzwX4W3a/ZhBbP2Lk0sjNRbs6Hv1NAY6AF+gOXtnn6qdEElOQWkrA7aew53+QzoNDC4IvCZDRa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vVWwHdA1siAl85Om5D0yuWv8t9KHd+lfgc34ftp07Q=;
 b=HZKOWLxvtz9xfjuUo5Awdi+HjxiuNOvNKgCOMK5qQ1yFBXN39GVhW5tQ8D0YYWLScJOE2ASi2NxrE2hlDmW4s6x8nHEhIHI7RmDBqwxjuCX+zrVuAZ0Lm1/PxqQdk/nbHs7I6ToDC68EFHdWF1ICOtyWdHpGDEJRRF2T4cs59KU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 CH5PR01MB8886.prod.exchangelabs.com (2603:10b6:610:20f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.33; Tue, 9 Jul 2024 22:30:02 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 22:30:02 +0000
Message-ID: <cb0bd817-6948-4944-ab09-4ec2aba41cfa@os.amperecomputing.com>
Date: Tue, 9 Jul 2024 15:29:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
 <Zo2C4eXr5_9kifyO@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zo2C4eXr5_9kifyO@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|CH5PR01MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fb1027-2f53-445a-e15c-08dca066ac26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmF4VjlBRkg3R2YyeGxWaUpaaU5LRXNVd1VobWdGekdTVFRKOHlIYmlTS3l4?=
 =?utf-8?B?Y2M3MzlWOE9FTzVXYU5MUm0xWTFjUnNGb0Vrd3d4M2grZzhXY2FWVnRiQ01H?=
 =?utf-8?B?dHlvTnVFYS9Ka09ValZUTDduOVJHV3FXQjhkaW5POGNqajU2ejhtdWhJMDRX?=
 =?utf-8?B?eU9UbzFWT09lVVVQcmtxWlQ2bUxqRHdYUUl0TVlDY3FDa1ZscDZTNjVaSWQz?=
 =?utf-8?B?anNCUi9ZaGVNVFo0dHd6eVhmR0dmQkt1bDZ1eEx4VE9iRmVQck01b2w4dTdm?=
 =?utf-8?B?MWNRd3NDdmhVandacjM2NkdPNGg3ajR5Y2k1L2xlaUhBdTB4UlZNUnpqSTZN?=
 =?utf-8?B?MVkyQmVXMEJoc2lSaHRjMENlZkNHbHJzSmRaQytQY2lBZEhDeG8zVUNRTVQz?=
 =?utf-8?B?SzJWUU01MHlOWHZuWGVYcjQ3dDhvWXBaZUcwMjBQUEZRK3R5cVBxUTZOcWNP?=
 =?utf-8?B?YkRHeHhsV1JiYmNTNXJJUUwycy9Ma2lrTDJQT1J0K3U3SFhySm82VTg5cmIr?=
 =?utf-8?B?ckh0QjY0VU13bUpSNGJibGs5Sk5LVWdlOXhLeDFYU0JJL0Ywa2tGL0lrOGM3?=
 =?utf-8?B?bHpsbWI0RmFZZXhscmRTYU5UTVpjNkMvZ2RmM2FMQ0RSZnRXazZNdTVNZTNS?=
 =?utf-8?B?YzlrMjh4R2I5Z0RLYURpc2tJcFNYemphRVF1cm55Z2tsSzZRSUpTMmRRMUwz?=
 =?utf-8?B?ZEIvWlZRRmFra05wMHRpZjFoamh0K2pHZ296OEpmd0hHVmRQdGdLdlhrWnpm?=
 =?utf-8?B?allSdWdaaCt5aHlWek5xOWJxQWZoZHoxQkNrTytpdm1MVm51L2QyNVZqWnVJ?=
 =?utf-8?B?NDNNc0hKZ3F1NzlpcDRBQStXK3o4ekYwaTRWMkVCbXRYTjdzVnpuWkdTWDBI?=
 =?utf-8?B?ZUxJQXFOZ0VoZlZJcUVpcDJMT3JUWVNjd0oreWVYN3R0bkZXUjRjd2lQeU0y?=
 =?utf-8?B?M1hSWFRhNmNkblhYNllpMDlhZnphQ2JZVG16QUZhaVIxM3hVM0UyRk4yb1ZE?=
 =?utf-8?B?bmIrdWFLaUgyeTRjMk5qMzcreDhYYTRsUzc5MGhCYjIweDlQcHNTYmU0Mmww?=
 =?utf-8?B?ZWdCd1RGTVVTV21oblRCMVV4bm1nNVNmMzBlYms4SVNjdTN0alR1bGppZUQ5?=
 =?utf-8?B?WWVtMWtiTnpxbzViOWdFOXR0eWt5M3lZQzZxRmUwb2IrUEJTeVVrQUZua05V?=
 =?utf-8?B?bjJXeEw0UW1ERTQ0SFJWODFaRUZGYkJxbHJHOVFJdVY1OVJ3SndCNE5ERkJh?=
 =?utf-8?B?OFdlMEMvL0d3NGtPZFpKNzZQOXJaR1RvUktvdDY5MnpWTldVMDFZOWVPaWdr?=
 =?utf-8?B?VzViU281TzN5QmxzT2ZFYUY5UnZXNjRXZ0tROERKOERDY0VpWk9PMWROYzAx?=
 =?utf-8?B?SlZqRmpvVmpnZXdvcjB1c3JXYk9CT09Xd1FvOFNqSSt3d1ZYTE5aWk5pbGlF?=
 =?utf-8?B?am9BRS9wL1ZRWlY4dTRVM1V6bFo5cWtQMUYrSSs4NzRYa2dCZ21mbGZZNXU0?=
 =?utf-8?B?VXJNcE40bTUrSnVCNlpuaXhZakVsOHZpb0k5VmdvK3NTZHhNS1pGdzVTZ1ha?=
 =?utf-8?B?bFBxVG5RMDhJME1TV0IzVTBxSzU2eFl4UDFmUDhWQ0lCcHI0ZHFqZjJRYURU?=
 =?utf-8?B?K0tqVEw4bjYzcDNMRUZ3TjFCTHV4VWhHL296ZDZyWTJOWW5KUC9vS3ZlSjZl?=
 =?utf-8?B?cDJ2ZzhsRlRSWXNqZWZaK1Y5dzFtODg0SHQrMDNObFowS3NYTVkycXFnQ3lX?=
 =?utf-8?B?NGp3dTY1NW53cGpzakx4alk4ZlRMSWp2NFpIcE5qVnNJUC9GaERBUWxnQzZE?=
 =?utf-8?B?SkhObVArS2FwdDA3QmlrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzdVRGlFWlFpZ2NvY2M1VXI2bE03Ym1MRTZSbERtc0s5VVhZVHN0RHRQRmtq?=
 =?utf-8?B?b3piZDBiT3B0cHBENWpOYVFsM2ZsR1BGbElUV2M2bGlZOE1zQTdPVFVKZ05u?=
 =?utf-8?B?bmNyeDVlL1VEVW9ReFZLT2dlQ1VwcGpSNEo3b2pSdGhiOXBnKzArRnVSazRB?=
 =?utf-8?B?ZUhMa2xzemw4aGhyTFNsdDNreUVicGdIQ1lwVFdlbmRZWDhFdzZ0TWNBWmNL?=
 =?utf-8?B?aGNMSk94SFFIdEN0cUVPWGdxV3g5R2l0QVVPWERzZlhhbGpObDBxbVY2Nlcr?=
 =?utf-8?B?NHkzK0swelZmeXUzeUp2MEdRUjNkVVA5SWt2MGIzR3Mxek12N29hYm55b2xJ?=
 =?utf-8?B?NGoyZmhBak1Fd2lRRWFYcWNJb0tXQVdtdFVMdko5MGQxRHhvM0YyZTNtaCtW?=
 =?utf-8?B?WWRkWGNzTU1NRUhjZnJLdk40T2VVZnFjcUU2Y1NDUDJlSUV6dzdFNGdPMndl?=
 =?utf-8?B?SjU2UHMzeHE2eHo3VUhoSHhKUmhWN0dHelg3Mk9YcTIvR1hDNHNmQlZZSGww?=
 =?utf-8?B?cTR5V3dKKzlsbGQzK1J5SW1nZTc2SVFtUmtQcVcyc09VWlN0Mm5vMllkd0hV?=
 =?utf-8?B?d1JMeTh1SDFzQmJxZkNTcmp2Nko5eWdDVWNxd1JqbGt5Rmdhd1FxMU5rN0RE?=
 =?utf-8?B?b1d1NE41TnRSc2hVMzBWYlA2dkJZcUYvK1p5Mmtac0d5MG9GeDRGdDJ3dU93?=
 =?utf-8?B?ZERlZXhqcnUrVlVnZDFxd3NTMzd0NFBJY1BwV3ZLNzNMSEtEUnl2anR1c3pU?=
 =?utf-8?B?NXZlK0poSWJybTRzenMydzJGUktGM0ZMNkIyM0dqS3o3VDMxUm9lblR3T3Nv?=
 =?utf-8?B?SlBya2tsQTVuK2pxNE1Wa0Q2cmI3MkFYSUw1ZTFhaElvNG40dzJGclhiMFhv?=
 =?utf-8?B?QktuUTNZZ0RwMGZTS3k5b1BwclBDeERhOWptanVVMDhTNmk2NHR6WlQyS0or?=
 =?utf-8?B?djEwcURjcTdyZ0g3OUgrakJ6aUxWbGcvOHBSMlZZRGFTUld5cnpTalJEYWhh?=
 =?utf-8?B?cTlqb0lVOENMRU8rcDNZeThRWWdRU2c4ZE5ycnlqamV3bFpYRW5TQlIrYVYz?=
 =?utf-8?B?eXBhTUczOGszRGpua1ZnYno4ZVA3U0tzK1Yxa0lNaXdKY05EWmhndno5dkFM?=
 =?utf-8?B?eGZUSTdGZ3NEYnY1Umd3Zi80dUpJdXpnK3BUaVJmQ2JtNXNlTEdOeko1a0Fx?=
 =?utf-8?B?ckk3YW45em5UcW9TWHE4SndZOVRrWmdkS05HN25vbGtFMDMvQjB5TE1nTGgx?=
 =?utf-8?B?UVpydnNtcUlYK0tPRFlMd2U0UjBWSXpnK0FsRXZrVGl1UFN3ZmxDZEttcVh4?=
 =?utf-8?B?eU5MaXpGT0NYY29Za3E4c2paNkpLZklLZzVXejRQTk1zM1BBN0pXckU1WWF3?=
 =?utf-8?B?anJab0J0dkxLNmw2L0tvMWdrZjJYVlNmOFpxcExqbjd1YnFGeVVlY3prSThK?=
 =?utf-8?B?eWNzVWhnUjZUZ09VdFlzbmVYZGZEc3FaNW1HZlF0RVg3UHEzdE8waFNodEY2?=
 =?utf-8?B?ajFpZktNUk9pL3VQcEVPVHJzdkkrMnFIclpwakVWbnRhQzk5UHNOSHBEMk8r?=
 =?utf-8?B?ckQzaW1GS05tcEtaR1FodURHODN6WThWd0VjMVRBWnJxekwrbGJ5b1BSU1BO?=
 =?utf-8?B?d2tSTkxpMC9EOFVWMXVrK2dZZEZKYjFaTEpaZHRVWlBJaC9vL3YyNlZtV0RF?=
 =?utf-8?B?UWZsQlY5NHRqaDFUaFNYeXFZcEk4bGVYRDROK0pWalZGc0o4MjZYNElTTzFO?=
 =?utf-8?B?Q0d5UDl1b1FBVUwwNmFlT2YrQnZiMVNQTGVzRWg2ZGN5NjFlU0E4blVGWXBK?=
 =?utf-8?B?SHE0b3czSlRtdFBCYVBUSFhsdU80aStqb3VmQlNRR0o5eGplVUNxTTY4Qmhs?=
 =?utf-8?B?VHNNN2hSZkJkaWVnWXZrM0M3OEEyVm0wNk4yTGsyRGpLeWxjZWpQMHZvUk5E?=
 =?utf-8?B?bHJLbS9tNjUyQnl1YTV0U3JzaDh0djZZSFVXVnpUUHhmalZkVW9WYmFudFlX?=
 =?utf-8?B?U09RbG1UakNHYWRSRWhuYVN1RGgzVExnbkUxNm5ONVZiaGdEWFlWbjk3c3JV?=
 =?utf-8?B?b2FFS0d6ZEluMGxtc2FoNDZqY1AyWkNPSnlhVTBwbEN1Mkk4K05Ndmx3NnlY?=
 =?utf-8?B?M0NVOFR0bEVOMXM5MlZMd2MveVZsbERKZW1NbStXdDdZUmRPNEQwaDdwMWlV?=
 =?utf-8?Q?bv3Fue8BStmcbRZsBybIOS8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fb1027-2f53-445a-e15c-08dca066ac26
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 22:30:01.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13tqBBJ2tSWZItuunm/W9gcaL909Ljy3YM3d0Fbh7WIZqdN5LyjCWe1PP/uo4Owi4xGPDruF1cDi/w1JYM2gVefyRwsAy0SyNndSEtTWf20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8886



On 7/9/24 11:35 AM, Catalin Marinas wrote:
> On Tue, Jul 09, 2024 at 10:56:55AM -0700, Yang Shi wrote:
>> On 7/4/24 3:03 AM, Catalin Marinas wrote:
>>> I haven't figured out what the +24% case is in there, it seems pretty
>>> large.
>> I think I ran the test much more iterations and I didn't see such outlier
>> anymore.
> That's good, thanks for confirming.
>
>>> What you haven't benchmarked (I think) is the case where the instruction
>>> is in an exec-only mapping. The subsequent instruction read will fault
>>> and it adds to the overhead. Currently exec-only mappings are not
>>> widespread but I heard some people planning to move in this direction as
>>> a default build configuration.
>> I tested exec-only on QEMU tcg, but I don't have a hardware supported EPAN.
>> I don't think performance benchmark on QEMU tcg makes sense since it is
>> quite slow, such small overhead is unlikely measurable on it.
> Yeah, benchmarking under qemu is pointless. I think you can remove some
> of the ARM64_HAS_EPAN checks (or replaced them with ARM64_HAS_PAN) just
> for testing. For security reason, we removed this behaviour in commit
> 24cecc377463 ("arm64: Revert support for execute-only user mappings")
> but it's good enough for testing. This should give you PROT_EXEC-only
> mappings on your hardware.

Thanks for the suggestion. IIUC, I still can emulate exec-only even 
though hardware doesn't support EPAN? So it means reading exec-only area 
in kernel still can trigger fault, right?

And 24cecc377463 ("arm64: Revert support for execute-only user 
mappings") can't be reverted cleanly by git revert, so I did it manually 
as below.

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 6a8b71917e3b..0bdedd415e56 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -573,8 +573,8 @@ static int __kprobes do_page_fault(unsigned long 
far, unsigned long esr,
                 /* Write implies read */
                 vm_flags |= VM_WRITE;
                 /* If EPAN is absent then exec implies read */
-               if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
-                       vm_flags |= VM_EXEC;
+               //if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
+               //      vm_flags |= VM_EXEC;
         }

         if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, 
regs)) {
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 642bdf908b22..d30265d424e4 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -19,7 +19,7 @@ static pgprot_t protection_map[16] __ro_after_init = {
         [VM_WRITE]                                      = PAGE_READONLY,
         [VM_WRITE | VM_READ]                            = PAGE_READONLY,
         /* PAGE_EXECONLY if Enhanced PAN */
-       [VM_EXEC]                                       = 
PAGE_READONLY_EXEC,
+       [VM_EXEC]                                       = PAGE_EXECONLY,
         [VM_EXEC | VM_READ]                             = 
PAGE_READONLY_EXEC,
         [VM_EXEC | VM_WRITE]                            = 
PAGE_READONLY_EXEC,
         [VM_EXEC | VM_WRITE | VM_READ]                  = 
PAGE_READONLY_EXEC,


Is it correct? Just wanted to make sure I did the right thing before 
running test.

>


