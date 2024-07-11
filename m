Return-Path: <linux-kernel+bounces-249696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAAB92EEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734D6288651
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DFF16DC1E;
	Thu, 11 Jul 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="r+uF+EJi"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020094.outbound.protection.outlook.com [52.101.85.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A014C5A4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721882; cv=fail; b=cvxQ4a50GI5nKCCGlSmaBedihcxbVcgNulVy2NRPYEQc/zD0cipA4MEIcXXrD4Jg04myknAqvmbj18bPUopOXuIeiFbBBW4RH+lnGF1r09rtrw2Uo5x47uFOtM8N0F11gFqrutCoavxHPuv5RPeU6WlZSFVQ74QN0Zg2I1aN44Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721882; c=relaxed/simple;
	bh=IsZJphwtEssz7ZJyrZyiHW8G4nhmXHYunwMXyQ4j6H4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QRcHNZALNHeuug1RlTPdcOt/exibLIHF6pFSMQiOvD7GjxYbbGn7Y86WDhWkQpCDVK9N6vjNBEXc/zcjM3c2JwZ5QR7cY1iQPakbrIXyaseoDprYI9gTj+Q+cjrkIpqoSiGs+QaidSC7gBeCF9Gug4OrD+sgc6W3CMCxtiyBoKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=r+uF+EJi; arc=fail smtp.client-ip=52.101.85.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSxuhT7oRlVrvQ+dp2sW03DLmx0RyiMxqF6CShDL8oHOMslDqDlDdiRCG4sI1o0YMBYERx4JkkZiXzbrnVZN+0vP8KIZKtdBzsi+8k+mhMM1yJi6nyPHEAU5e+0PmPA9wyM4VOTMMdMjp2NC0rvXV15ulvLo6Wy57vTB2lt8m8GyebC3LGOTXl1I3h/PzpCcWCSKVJXq2y9Jbhys2ny0hNIUKu+LLBcVbg+UE0ZzJF5YNTo0MtPnGkZskMG0Kb645kZ3dnXKeW3QKE0cXu8JKBkCK9nQNBnWgfQsuYnMGH/5C5Om+NaDVCsc7IDfWE5xnofgTmCOrQyajNSrtY5k9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5KcZbw1D+2lsmejal+etc10O2k9AbebFhcL9MpOTEM=;
 b=FT3CTHVpxcUURtT12VLVUIpWczQlHaRVoW6Xy5MjxGc3OM/qb2HzriP1RFqA7Z0aCqjbWDTUkXX7bPiVYGBYNkWLouLHSd31YUU8bhig1DgyUMgybm9YY8KEuUDFp11yIQDFofYtcoa+tsY1CLpSRmqkAsuGBzt9XjJiSAUo0ZSNsGrjSMonSFs1kbxn5ufkuOm24zD+RU3ot8qeH0S6i7x/dhU166vs5JVeQVeUU8JJwDve5VRKpKgI3mPQDPqCEFHWBtpC/O6v4EetxEKgS2fNeRWpBxAyOoCcoifcVvNmHN8Q1moDWfRzN8zGRaeNDp1QNOVhhaz29adVC9QerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5KcZbw1D+2lsmejal+etc10O2k9AbebFhcL9MpOTEM=;
 b=r+uF+EJiGF/Q2dhTiJeS12n2S4X9ef78lHVVtdnpNW11PB3BEnpU0a9ZjbHpmllNmhWWVo1uWT/bBqc3H1V2grDFHLNH4jasyfHzQ3l/gHAfKAo8PO0w6LRk8Idetl/RxxUPGR3GwGTz7f4pOTzkWe1HKIIz6fmHta2pusexrjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 CYYPR01MB8568.prod.exchangelabs.com (2603:10b6:930:c4::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.19; Thu, 11 Jul 2024 18:17:56 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 18:17:55 +0000
Message-ID: <cf0777ce-52ed-46e4-b666-50a04d5025e0@os.amperecomputing.com>
Date: Thu, 11 Jul 2024 11:17:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
 <Zo2C4eXr5_9kifyO@arm.com>
 <cb0bd817-6948-4944-ab09-4ec2aba41cfa@os.amperecomputing.com>
 <Zo5S1JE8B912SHya@arm.com>
 <6167c4ce-fef0-4af4-a6a1-9fe7b2eb023d@os.amperecomputing.com>
 <ZpAZ39VQhxfNepWT@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZpAZ39VQhxfNepWT@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::48) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|CYYPR01MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a611e1-d5dc-4480-1978-08dca1d5c87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1hoVmF4a2E3UndGbDV5NUs3QWxMd09VTUV0Q3cwRXpFckNDUlRuYVkybjcw?=
 =?utf-8?B?TDg0TWNud2N0MThyWFBxL09Dc3dOckhDdkhBa09pNGlKek1lc01YT0ZORjZS?=
 =?utf-8?B?OUFxbFY1eVBYNCtPNE4wYWgzcTRJcncvREJwcEo3NFJoVkRwTWpRVVBjblow?=
 =?utf-8?B?c1drUTg1UTZ3Q0oxTmJYQzJWS2xaREdKelExN1lYUE81VzZkVUp4UlNOUHJI?=
 =?utf-8?B?YW1CRHdVRk5lemtWbXBrUzlYUUNNSERnZGkxZnRYemh4Q3pDcW1mRGM0NFJL?=
 =?utf-8?B?S0szWSs1Ymo1NDhOUzBQRFNZRmNhZ0Z4ak5IdVNIcXE1Zk1xVGNhVmxVV3Ey?=
 =?utf-8?B?SzA4Rjk4ZkpEeFJESkJ2N1ZyMFVQWENiV0tSYkhESittYzduV2U2bDBhNENp?=
 =?utf-8?B?Y2dUZDJMLzJvb21jZjFDei8xbkxHREZ4aE1PcXdldlhWNUpmVzd6Q1ZVRkp0?=
 =?utf-8?B?ZGNLRVhCNTIyS2ZyZEJyZTgwbk40NkZjTkNqS0NQSThWTitBSEUvRTE0SURB?=
 =?utf-8?B?SGFySnlPM2xnU0VMWk5tNnNFR2svbnE4WCtkWC9Vbm1MN3VkRTBHR1cwK1lH?=
 =?utf-8?B?aU5RUS8yV2JReVozMk1FT3YzNTc1TkVTM1A3LzA2NFZBNVpyMFd1b3ZOQk1z?=
 =?utf-8?B?b00yeXRheFNXRnNsRUxZMDBIUmlaL0RFb1U4MWpnQnVjU1I4cW5xVm92SDBK?=
 =?utf-8?B?QzNoeXEvc1RyM04wZHBzQmt3SE5HNzUrT0N3bjd0bFFrYVdxQ05ZZnBucEhG?=
 =?utf-8?B?WmtPSk5RcmhjTG1PWnNhSXFXK2FqM1FJaHZsRjExK2JTMHdzWllLUXlhQmVD?=
 =?utf-8?B?N0RPdFQzQXBKL3JJRlA1M3hwSHlLOHFXeGl5c1dSNGdKRzJoNXgvUE5zc1Vq?=
 =?utf-8?B?MWt5dzhLblg0OTVCeGtWZEdLcTZDTFM0Z2M0bzA4bUk5elA5OW1hOC9KbDF6?=
 =?utf-8?B?RGJpdTN1RHMwSm1xeEswZ1gwQXI3ZVd5OG5CK1ViaWhZc20wd3RrZ0o3RmhG?=
 =?utf-8?B?VzNUQURYNWRvVFl1Mmo3K0tuSCtmcEJoREJnRzJ6bytWOUtVbFJxWDRrWUNY?=
 =?utf-8?B?VTlLeUFqVUdYSFR3a0lIM3RJRERDK2ZSWnArQVZKS1BITUJhNTFoV1NadUcw?=
 =?utf-8?B?bEFzYTZZeW9JTkoxTGw4dURsVFF2MGtIOHVpQzlDUC9JRVJlMnZkZXVVM0RU?=
 =?utf-8?B?SHNMRFZWZXR6eXZjLy83V08yYVVSTkNwZ1FxdjVBand0Z0dQS290R1lxYS9r?=
 =?utf-8?B?Tm9IN3VXUEkxYXl1THlLdE53MHowT2ozRjVlWGdSZ0ZXUFVjUEpQZXg1NWlq?=
 =?utf-8?B?TDdjQmVHb1JTWDhPeFN4QThJU0FmUktiOUR4WldpNjRyYURtVWM3TUxpVDBO?=
 =?utf-8?B?a0JONXNpRFI2OURLK0FvQkJkYWdSeUZORGlrbFJRYjFSM05JVUFNSm82dS9U?=
 =?utf-8?B?aitMV3YxOTV4UXRJS3ljNXJTd3lsYlFkRUJwbm93SG9HSkk5TUV4Qy9IOTVF?=
 =?utf-8?B?RHRiem5sNTdpS1JBUzUrd01BZEoybkVVemViVE5RZnhyc2JYTkk4dEd2VzVD?=
 =?utf-8?B?QlB1NWhGcjJ6WWthRG9nWVZNRWdSbVRKMW11UDMzSG9MRmNNbG5UUjNrZlRu?=
 =?utf-8?B?TU1RaGZKNitoUFdVM3JnVTdYbzR1eDhBZExyQmRrMGwwdGJLWndBdDQ4ZTRq?=
 =?utf-8?B?Q1dxRi9PZ1lkR1V0My94S2ljR3hUbURNaVBseEdBMkUxdUtvVXQ0UTArSE9K?=
 =?utf-8?Q?r5fx3m/Vg8OdvZsnr8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHBQZ3hZUVBDNGhrS0UyMjJtQU5jTnJreHR6b3dOMnkwdkVYVlRWcXVCYjFR?=
 =?utf-8?B?c0ZqM3ZZdU4vY2VFNk5KQ0VQWFVxdTJZcjM2RXZJdndCcWpSWVViNlhpTnJ1?=
 =?utf-8?B?QVhmc0tQaDUweVB5c1pPbE95U0txWWExQ2lFeUZBakhMZXJUbGdHaWY5Wndw?=
 =?utf-8?B?emMzZ2pnYXI4ZFZ6bEczQW83WDk4Ry94SGdEQ0dCNlRkUGMrSlJjM3k5Wmsw?=
 =?utf-8?B?RW1ZL0c0TTl4YkpqcjR3N2UxMkhyVGpoSXN6ZzdCM2RXSEcwT1RDTEs4ZkRB?=
 =?utf-8?B?RlpYNEpSQVMrNFdHam5RMkIvckl5WWt6R09vVW9taWtsRnhYQndEdkszRkFR?=
 =?utf-8?B?Z0wvUmdNa3kvaUdqUkt6blNsc1lTd0l0aW9qc1c5MjZ3UmpGY0pETmlEN3NM?=
 =?utf-8?B?WFNRZkZlUnBMckRWTDRZaU9uaUZjSFlvOXo3OUtGYkZOWitxNFM0N21pR0tB?=
 =?utf-8?B?QjZCU3VoV0dIclJ2Zzdya2J6MHZ0KzhrR1BaMXltd1dib2ZyTCtkODh0Um9N?=
 =?utf-8?B?Nnd2R3BYZ3orajRVeDgwa3YyVUNHZURHbzlGR05MQ0h3N2NqSGtyWWR1U2xq?=
 =?utf-8?B?dDF4enVMUGlxbTZac3EyMVB1bHhIUXlNQUdkdWNvSjBlZERWSkJseTk1VnRm?=
 =?utf-8?B?SXBsVkt2RjZscUJrZEF1ZmVzMnBJRk5ObEVRWnU0WHNDVWFEdHpVck9McElX?=
 =?utf-8?B?ZHJEaWZKeDNHR3BvM00ySTBla2pNbmFqbFRjQ0RyNmo4c1R4bHBWaGhrKysy?=
 =?utf-8?B?ODBCT1pEWG0yd0cyNSs5TTMzdXF4bDR0OWdzUVY2L2QySjRwbmtHZWdSbHZZ?=
 =?utf-8?B?Nm0xTU5QSUgrK3dYMWdzcWFSTkRvcmNQelYyVkJYenJKT3ZRdVpBV0dWNGli?=
 =?utf-8?B?SjVXTEJDelR0QjBVU0pCZStCMzE5S3FwdkFPbmM2OFowUXlLQW1jOFhnQU04?=
 =?utf-8?B?czVYMGRsUG1rYVZCWTMvR1g0SHIrSXIvY09qS0hoaFBYaWpTSFRSUFM2YTRv?=
 =?utf-8?B?bUcrTEgxWmhPQ21sbDhZbXdPekNoc1Q2S2VRVXNDMlRhTTR2bWF3VGhVQ2J0?=
 =?utf-8?B?TStad2VNcFRUWGpXQ2RqK0pQNDJNS2xaSU9KejdBL0dSVnRzSzcvR1ZORVFm?=
 =?utf-8?B?SzlzQ2RqZGxCWXk1M1BySjhObGZCd0JvbmkxRTVkbkdSbFF5TEJWQlNMR1RV?=
 =?utf-8?B?cXJQVnkvQ05aNEJOMThOdjI0S2FXZldwSzBMbUlua05qUFJ5RE5DYTZ1Y0hN?=
 =?utf-8?B?TnFycmcybyt1TlN3eTVIMWU0YVdGRXRwOCs4WXkya3VtL1B1bFRCalExS1ZS?=
 =?utf-8?B?OWh3NFdTWUxQWjlhSmFMejI4MWZZOU5LMEFpT1JvdnlkSkRZc1FPQzVuRk8y?=
 =?utf-8?B?SVk2aG9KRmJESVVxaU0xRHJiaU80WnNEUFNvUSsxZjZrRndOaGVlVWlkZW5G?=
 =?utf-8?B?eUUyK0lFQ0NsNjNGWnNCcjFuRkRaZDZuT1M1M1lHQlBXRmpYVHdTWld6QTZT?=
 =?utf-8?B?eEMwVmxCOWVianJYR2pWTDNYVEJrSUIzdGt6QThoRkZPa2xrSkZ2anUySjda?=
 =?utf-8?B?VmlYOTJvalVsOW1lWFphVzBQZDZ0ajdHOHZaVmtDU29IRkNaL0o1dGFtVGVM?=
 =?utf-8?B?UlJWbmx1aSthcWVRQnFSbWhsaUJ5eXJ6NmVpOGJoRENpeGpPVVJnSERUeUVx?=
 =?utf-8?B?QU1TWkRPY3JQZDJUdnZILzVOM0R2dm80R0MybDA0OFBwUmdwNEVyNzFiaWlF?=
 =?utf-8?B?OWR4b3daZUtKZkRyMDMrMWJQbFQ2UCtIN3A3Y1hrTTNLZkFQaS9MWnhJYVZY?=
 =?utf-8?B?SE5NeXdicSs3TnNoNHQ5ZlhobkdxQmlKWWJOeUxMMkhkRnJDRzNObnlzMjZy?=
 =?utf-8?B?MThIMWxEWHMzWEltajBRVSsvZSswSDFTdVNseFg4VnpFcnYvV3JQTmdCVWZJ?=
 =?utf-8?B?TEYrM2RvaVNLa2lsNTc1bGJIb1l1RkJ6d3B3Mk1tSEVvaFpQUWplZ1Y4RUVG?=
 =?utf-8?B?TkNXeTFTZ2JZamYxdTNJZVBHUy9qYXJoQ1lyL09jMnN6azViMjRpdEU4djRz?=
 =?utf-8?B?TE8yYmtJWC9SUitlMFRqUm1mcmRiNk43VGppSjkyam5aY016c25pamtXL3pE?=
 =?utf-8?B?NGNybjU1NWxMVTJrUHNvUU1EbDM1R1UwVG9HK1NQRjNkL3g5bHpCWXJxY29I?=
 =?utf-8?Q?0oItTnqVM1GdRAVl7Qfg+Bc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a611e1-d5dc-4480-1978-08dca1d5c87b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:17:54.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRdD+KflOEEA7Ls9ArSDM5yxitnDunXbAj5khhqnkfNa/yylUCJ5lKkrl21LiIBmPC9WRbigJKASreNAuW9Dn5+ci/IqJXomlBFUyDfFQBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8568



On 7/11/24 10:43 AM, Catalin Marinas wrote:
> On Wed, Jul 10, 2024 at 11:43:18AM -0700, Yang Shi wrote:
>> On 7/10/24 2:22 AM, Catalin Marinas wrote:
>>>> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
>>>> index 642bdf908b22..d30265d424e4 100644
>>>> --- a/arch/arm64/mm/mmap.c
>>>> +++ b/arch/arm64/mm/mmap.c
>>>> @@ -19,7 +19,7 @@ static pgprot_t protection_map[16] __ro_after_init = {
>>>>           [VM_WRITE]                                      = PAGE_READONLY,
>>>>           [VM_WRITE | VM_READ]                            = PAGE_READONLY,
>>>>           /* PAGE_EXECONLY if Enhanced PAN */
>>>> -        [VM_EXEC]                                       = PAGE_READONLY_EXEC,
>>>> +        [VM_EXEC]                                       = PAGE_EXECONLY,
>>>>           [VM_EXEC | VM_READ]                             = PAGE_READONLY_EXEC,
>>>>           [VM_EXEC | VM_WRITE]                            = PAGE_READONLY_EXEC,
>>>>           [VM_EXEC | VM_WRITE | VM_READ]                  = PAGE_READONLY_EXEC,
>>> In theory you'd need to change the VM_SHARED | VM_EXEC entry as well.
>>> Otherwise it looks fine.
>> Thanks. I just ran the same benchmark. Ran the modified page_fault1_thread
>> (trigger read fault) in 100 iterations with 160 threads on 160 cores. This
>> should be the worst contention case and collected the max data (worst
>> latency). It shows the patch may incur ~30% overhead for exec-only case. The
>> overhead should just come from the permission fault.
>>
>>      N           Min           Max        Median           Avg Stddev
>> x 100        163840        219083        184471        183262 12593.229
>> + 100        211198        285947        233608     238819.98 15253.967
>> Difference at 95.0% confidence
>>      55558 +/- 3877
>>      30.3161% +/- 2.11555%
>>
>> This is a very extreme benchmark, I don't think any real life workload will
>> spend that much time (sys vs user) in page fault, particularly read fault.
>>
>> With my atomic fault benchmark (populate 1G memory with atomic instruction
>> then manipulate the value stored in the memory in 100 iterations so the user
>> time is much longer than sys time), I saw around 13% overhead on sys time
>> due to the permission fault, but no noticeable change for user and real
>> time.
> Thanks for running these tests.
>
>> So the permission fault does incur noticeable overhead for read fault on
>> exec-only, but it may be not that bad for real life workloads.
> So you are saying 3 faults is not that bad for real life workloads but
> the 2 faults behaviour we have currently is problematic for OpenJDK. For
> the OpenJDK case, I don't think the faulting is the main issue affecting
> run-time performance but, over a longer run (or with more iterations in
> this benchmark after the faulting in), you'd notice the breaking up of
> the initial THP pages.

I meant the extra permission fault for exec-only should be ok since the 
current implementation can't force write fault for exec-only anyway. It 
does incur noticeable overhead for read fault, but I'm not aware of any 
real life workloads are sensitive to read fault. The benchmark is for a 
very extreme worst case.

>
> Do you have any OpenJDK benchmarks that show the problem? It might be
> worth running them with this patch:
>
> https://lore.kernel.org/r/rjudrmg7nkkwfgviqeqluuww6wu6fdrgdsfimtmpjee7lkz2ej@iosd2f6pk4f7
>
> Or, if not, do you see any difference in the user time in your benchmark
> with the above mm patch? In subsequent iterations, linear accesses are
> not ideal for testing. Better to have some random accesses this 1GB of
> memory (after the initial touching). That would mimic heap accesses a
> bit better.

I didn't try that patch. I think we discussed this before. This patch 
can remove the THP shattering, we should be able to see some 
improvement, but TBLI is still needed and its cost should be still 
noticeable because the write protection fault still happens.

>
> Anyway, as it stands, I don't think we should merge this patch since it
> does incur an additional penalty with exec-only mappings and it would
> make things even worse for OpenJDK if distros change their default
> toolchain flags at some point to generate exec-only ELF text sections.
> While we could work around this by allowing the kernel to read the
> exec-only user mapping with a new flavour of get_user() (toggling PAN as
> well), I don't think it's worth it. Especially with the above mm change,
> I think the benefits of this patch aren't justified. Longer term, I hope
> that customers upgrade to OpenJDK v22 or, for proprietary tools, they
> either follow the madvise() approach or wait for the Arm architects to
> change the hardware behaviour.

If the overhead for exec-only is a concern, I think we can just skip 
exec-only segment for now, right? The exec-only is not that popular yet. 
And if the users prefer security, typically they may be not that 
sensitive to performance.

>


