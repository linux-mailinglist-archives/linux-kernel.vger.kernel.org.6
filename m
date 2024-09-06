Return-Path: <linux-kernel+bounces-319332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FBD96FB36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FA428DD2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3EF1B85D3;
	Fri,  6 Sep 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YgXtPb3Q"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020104.outbound.protection.outlook.com [52.101.56.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D141B85C3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647294; cv=fail; b=CqMeKRiVzPKN4QVUoE3D3syect0puqM+4ZwL2UAiIZ1BdoF4yKjt802jPz4AsOhNKLZJpR3337E479zWlo5qoM4rzw1vEslb0M37rzdMnrNzhOCWZyZgCSZDzsvEqHehm0IRdXTVTL0FXmTqEKea/wG/qP02Fc358PHoQQ+BX+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647294; c=relaxed/simple;
	bh=MpvETF4+iFVq2YAqB7Ewgojnn6MDYUJeqwV8p3gzXEc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=Fm70hr7KTEVDzFMiYkdMR+AXYaDqg9Ygq2Cnanu4EolVzmUlRMamS7yVfY+CRyaz/Az52z1c4T+2vBBxhZJYEXSE0IwQldjJov6W5G7SzYoeScRXxT1PohS07MvMpu9pSL3zcG8oDz/yYvaCL8hvazLZn1UXpWwL5wSbaBC/0vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YgXtPb3Q; arc=fail smtp.client-ip=52.101.56.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONLuluSRM5LSGNObH0X/O0pQkM4wAhMEKCAeYet3ratW7DLs7lxXDA5M5cvFXwGD6h+jPCnS/7Kyn53LKGdz8HgMcqk+3I5RbMHOeN6SG7uX8g8SY5K6qkeWFq9t42aVxvpXSDu7Q0sGE9y7IQJ1PoPUE0757AQLr1ZgrXA+zAgpCF6RAbslghsvkIwrfv5sX9xAVglewAjElBabnN24wItBWB0ouD0lrja89Gti9fkAy/hVjSZ010b1VNvQJRG93Zy6H2FmmdkoYgRI+p/3t8r1JGClb9BJDwa/qJ4TafNIozta6H4UmyVATWt4vvXGHMNr4JRHp6GIiP0aHUGB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLfVyYO6QveaS+aR2+wnR7jfKDQgSdxCvIn1RJmkbfc=;
 b=vFxjQf5N5L4AZ6NwpfmwsKrU7fnCENRRBLNku9lodtxIsWgBBvm78cpD98Di4OpUKmax7XD+HMEYqifY02//WWnbTyca27G+tcDV6P1y/nFTz9sEKN5Xo9dgAgVrj3KeOIxf3d8FI9Oct9sL/ihmQawkOkHKpM4nN4VWQW1zVJw7IRFQZS7UE9kYtvcelNBnl/E8I7d8rNuTwb7uNhOLIJS1PDu9GjXXJnJ1EcHsTSZQFpBX+FE/JqzPHXryLr/LuCKRBBmZtl4ZZvbGVd1fwQ7zFqHjZxF1dr+sILlp39O1oJyQWcEtTZNYhNlB1XYHPy2LDsC6SAszMgaBDLvscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLfVyYO6QveaS+aR2+wnR7jfKDQgSdxCvIn1RJmkbfc=;
 b=YgXtPb3QnJdg577VJ54vo1Da1zBKaHFGZ4WvekZIhOiNrzoMlyKptPu1La62ssSrJJTHefWxiMP+EqcFpMw6OmAeLR01KTU+3DgQio0MXfVAK11CgxXZ0paEL9iFZdE19AplC8yNXYvXvakJXuQ+OziCy4hpNxvlfucJzMY8lrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SA3PR01MB8474.prod.exchangelabs.com (2603:10b6:806:395::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.18; Fri, 6 Sep 2024 18:28:09 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 18:28:09 +0000
Date: Fri, 6 Sep 2024 11:28:03 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_pmuv3: Use BR_RETIRED for HW branch event if
 enabled
In-Reply-To: <f632d5c8-93db-402c-82ec-9f3b79906458@arm.com>
Message-ID: <ea7ff9b-b91c-d158-dfde-4569784a4720@os.amperecomputing.com>
References: <20240905204732.20546-1-ilkka@os.amperecomputing.com> <f632d5c8-93db-402c-82ec-9f3b79906458@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:610:4f::40) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SA3PR01MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: f16e59ca-fccc-45ce-df4f-08dccea1a889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgWzVUq8HPH9EvJyi/kELF0R7elwWx1bbb1AxeXbzocKW8AtZxdz5qrGt0xh?=
 =?us-ascii?Q?ZQdYUypcR6cIeuNqvPhdV92GWzTr3zp8BuVz/ysKOSMYIwIB4VLPkc3qRcxF?=
 =?us-ascii?Q?D+7ocVaC7cJEKjcL7MxaLskKUq6HCe0TOkJRaQ3KgyOL5LIXRzzqV4KUk/Gk?=
 =?us-ascii?Q?0CRnk/FIqhuWIROkCb2XrMTiUJbCm2SbAD+adjMkSBRIa6YOb/wtUv/ReVS7?=
 =?us-ascii?Q?uEYuszDbJTH6fjlhNfKNWlhohQB4ISOSwY1IU6vI8CVMuTh0oyxiVNbrZ/iJ?=
 =?us-ascii?Q?cbSlC3eMhv3Hk4FGobqUJsOHsqolu2VC+Jg4aSJgnTS+UZ0aM1pw1MWZO9q1?=
 =?us-ascii?Q?olTFlVFTryCfNYzfFT6bk0tc7Ro5baLDtxGqqPUTHf1kMB8hMIqrSyLxblpu?=
 =?us-ascii?Q?B5bsVYHC4haw8BImeT1nb/eWyM84ahibAYBKaJQQc+j1wVtnM5gmgkW68JgS?=
 =?us-ascii?Q?Olksb0D3ufP96FdDoA8kAUdc2kKda0BogPphzOk33gN2Cqo/fi+kLIUM7xRF?=
 =?us-ascii?Q?GTVllN0SCjJz3zgmZKgvte4yuzV95l951GlpKUZKg8FhFcTDMFZo00IWgzKO?=
 =?us-ascii?Q?cg46+Eq+j9Thl2sULKG6jYRXC8mOCuHlgOdmaD8yhk0kKfM5laWAU/a8yKBQ?=
 =?us-ascii?Q?9xfVFShyP5XZhQaF3Je5hQW9bWBnDJJGZklEa8ZIgwcJ2sy5PztTJtvwlS1D?=
 =?us-ascii?Q?TlBWM/79kBTkAZKoES+n3mGKkH8woj+q+ErGZDyymdCgS0KlInhrYrUF7ttP?=
 =?us-ascii?Q?15gyKwCi+KsfDJg5KX/tJwWTYOdbYpC3jVGxa5hQHtS0Er7hpaiBFwNQl8Mr?=
 =?us-ascii?Q?8KkbHAbngbMw6g2+DkwBScjpPGXJ/CIMUzHHPjoag3125XMWvQUldbGVmJ/j?=
 =?us-ascii?Q?SayR62+XWuewT/uTUEMf3GXc5WyeqcP7Gd1c0bmKv7LPlEjXoiiUhbQjDEP/?=
 =?us-ascii?Q?fmOWI6EDrPO7xQxN4ZfF+TsJdbGFYDSuCRXCHCg2jHMb/KANN/93ZSyh1C4o?=
 =?us-ascii?Q?tIT9MF+ViMrbffPveDhR9ZSXW5GmEvdfaz1E34oifaq6u5XMgn3XF10Av6S5?=
 =?us-ascii?Q?h+JcwYFm3sy1m2Uv8GUrMifHUYaoO19uxvZBhk+4lK5rgyq24q5KtGs1SVvN?=
 =?us-ascii?Q?5dUQ+FAhPg+pPJzsP+a5RbS1ZpJ+KP5Y/LqWTzjMG+ibcT/KEmnpSoNwopHD?=
 =?us-ascii?Q?heePlBPtCvbhwfWMRN6CK/B4IWqUDK871U9PaeImODLK08gcD8EndNTwf/FK?=
 =?us-ascii?Q?Q5LMbvCLoA/kWjlSEPSfqWhnXtejo4u1Kqlz73qOxxRfS1FGF7EVdzPpLYUW?=
 =?us-ascii?Q?ZPDQKLbc3mT+A06hDb+nz+AnUlL9yOkQ44KWfM7EWPrjnXzvuLf9lXApp9Dt?=
 =?us-ascii?Q?WKaC3iY82VePBALHuWIxjDOWaiBIL5RIZUWJDsNcKmwMa5Hsng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?weRfN/aALDae/rPC4j2NWv0O7C0xXSy1rlw5EviS21sa9HfsChjRRMr0b+Ef?=
 =?us-ascii?Q?RkdTSKQcYvjhcG63J09txgVnv1c1U1kaGkHzNyPdGHBq4fvK6LFGpZTG/TAy?=
 =?us-ascii?Q?0r26s7laljRoHoVtG+Mh02TsSjdJxTuPzzVc2ulAO7Hr27u5jbZzuuvOTGjw?=
 =?us-ascii?Q?FmZeMGvVJTpxaLtJXQfn1HfyWiR5QGUxeiEhw85Knbc5oUG0zaNfYNHomRl3?=
 =?us-ascii?Q?bwywYfMYqQlTITTI+UmEnDHjfBz8q7PlZx7Q/J5fEdegHDVsQjrR/codH4KT?=
 =?us-ascii?Q?JwEZ3jN9A0agPs0ILUdQTR0D3udPfSbijpRs7ocO54Ww9DyyinUCgdYwddlh?=
 =?us-ascii?Q?h6GI/PouHbtojtOuh05lfEKzYL+FfnGU7QrY/DpVw6haupW5krAMfuKfDODt?=
 =?us-ascii?Q?uXqhi3dTpAbxLHp/TLZjVNS5Kq0bbn3jnXXntpl9UzvCvE91XC2KR6DoEOWY?=
 =?us-ascii?Q?Pr4cZzN3eg/e8aUAcUEuvgeQLBEHfbl46LgeBoNlc2znEFi8gAXD5+uj06P8?=
 =?us-ascii?Q?8osywpu6wbYT/2eQZHhZGr6L9WKz4bgIbXGfFR10c4sp4Bmkr6OUuoyWi9Lg?=
 =?us-ascii?Q?NyNDAuSd7fk3Cq045q6GvOMdGoxcC+ibs0f2Vm5Z6NWPYrQ+RGVnKB34CLnr?=
 =?us-ascii?Q?Yb6+xVUgFv4kbCrngYl9r7R+9z9ULmHrIxtWWdWzW2CtSebai+MV9oQjuUpV?=
 =?us-ascii?Q?vDM3OWX51KBkXLwlvCeqNB/r5OoZDvCll3v2MUlEJ+SDnuFYg6Eh1oDymH2Q?=
 =?us-ascii?Q?8Alu06pBd1TriRY2XDGy76vGWkZ3hjPzm3VutuRr0+7T8gsIGzpe7iELEt1O?=
 =?us-ascii?Q?1mi1tFMt9oAYsipajPXpelDGUFHkOxr52G4jZoEQ0HGFbQxR/QwgjOlUwO2b?=
 =?us-ascii?Q?pV1L+U3g7mPPm1uGBKUDs5Fc5A9b+1bq/WuWqDGv3Nntg+33HwXanpj9ZKAK?=
 =?us-ascii?Q?OpLDUIDHbFvKiaSm0bCfXI6S9MiQr7C7l0pINvifW36d0CcX4xE/w3jiUUH3?=
 =?us-ascii?Q?fUeBJjVUJHskIu8Q1FKBYRKipkQVUEr/9x4uksR04CeTJ6pt/J+XKZ2SN/1R?=
 =?us-ascii?Q?oWasD+ovOUSnYqj8YM3PWDechYIqee3tps5YCGg0wHmCZQ4xI1E5Du2wHmi3?=
 =?us-ascii?Q?x8pBAytGwzv3YYBgUAPW8r3s/fgyXl6P0sUxQGs9dRdBLmzGFlMS3PQVq3Ov?=
 =?us-ascii?Q?/tqjbzSYLjw8DpN2reITjBGSTItULYUOyqjN4OX5oWCTb9eC2eF8ScOQWzSp?=
 =?us-ascii?Q?/mU/R7DDDaxl8D4JyRAVTXWQycZzBoiNgnnsj7tl53j9CiKfk3OfFFqrmKBY?=
 =?us-ascii?Q?tGTHdXMFa/d1qSBI7+JHMJt5cyEITl0mFj0cKYzWMVFuvbW8dHfi59IbFEOi?=
 =?us-ascii?Q?cmwdjWJFfD/P+CpwU0PUuCoPCUVNQZLyojNDMANfqqBp+oGGMMSHcAQhDBpS?=
 =?us-ascii?Q?DNySVw8yqPmyqTI1Krs6X0cstI41ejHxs1V/s2cyxFMcFhMh8YU6VhzZ4a/W?=
 =?us-ascii?Q?z9p68fupP9GQ8zNSCBj+NxYLZrid2a4Oc3U4ivZbkMOWfxIK5RYEjtBNyIqA?=
 =?us-ascii?Q?ZLCMS99hysjaaywnH5LLwTtoObjzOg2fDTE3ZaFr8f+JMutJUndIazSrYJZ3?=
 =?us-ascii?Q?1svDHEHHip3rbUJ/XlVJSEU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16e59ca-fccc-45ce-df4f-08dccea1a889
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:28:09.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDwCDVRHOuh37yi8MMRrsbS6g3VKhZizlhxFgpsV+SxDDK762Cg+ML/DsI4+X/ML3FKtlLQzP00mnPr+DixPJn+WhTp3BOJV2Al7pmNuClEOsy8pU26eYG7TcEGgeucc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8474


On Fri, 6 Sep 2024, Anshuman Khandual wrote:
> On 9/6/24 02:17, Ilkka Koskinen wrote:
>> The PMU driver attempts to use PC_WRITE_RETIRED for the HW branch event,
>> if enabled. However, PC_WRITE_RETIRED counts only taken branches,
>> whereas BR_RETIRED counts also non-taken ones.
>>
>> Furthermore, perf uses HW branch event to calculate branch misses ratio,
>> implying BR_RETIRED is the correct event to count.
> But is the event BR_RETIRED always guaranteed to be available. Should not
> armpmu->pmceid_bitmap be checked first ?
>
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  drivers/perf/arm_pmuv3.c | 27 ++++-----------------------
>>  1 file changed, 4 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index d246840797b6..a8ed08df1411 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -46,6 +46,7 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
>>  	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
>>  	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
>>  	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
>> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_BR_RETIRED,
>>  	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
>>  	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
>>  	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
>> @@ -1083,28 +1084,6 @@ static void armv8pmu_reset(void *info)
>>  	armv8pmu_pmcr_write(pmcr);
>>  }
>>
>> -static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
>> -				      struct perf_event *event)
>> -{
>> -	if (event->attr.type == PERF_TYPE_HARDWARE &&
>> -	    event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS) {
>> -
>> -		if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
>> -			     armpmu->pmceid_bitmap))
>> -			return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
>> -
>> -		if (test_bit(ARMV8_PMUV3_PERFCTR_BR_RETIRED,
>> -			     armpmu->pmceid_bitmap))
>> -			return ARMV8_PMUV3_PERFCTR_BR_RETIRED;
>
> If BR_RETIRED event is absent on the platform, PC_WRITE_RETIRED still remains
> a good alternative to fallback on. Hence wondering if the above order could
> just be changed to use BR_RETIRED first when available.

If PC_WRITE_RETIRED is a good alternative, then I guess, it's just better 
change the order of those two. I send a new version just doing that.

Cheers, Ilkka


