Return-Path: <linux-kernel+bounces-347834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BD98DF6A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E78F1C20B7A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC21D0B9B;
	Wed,  2 Oct 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QCclcFP8"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC91D0B8B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883535; cv=fail; b=NrPa3HGoqcGCbo1OqeZi+PKaoUJdEk1YJHMQSNnyGy6Xkd/7atTIxDMXTjK9hk0ueiuLlhh4TY4kP0/MCB2Kl+eo6amYW6yzosd0qMVP8nCzRI99CRlRegBrQP+6lzqUYrcb6SZleTkxcDp2JvDzU0NSdf0WEOaO/67a5L1lFag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883535; c=relaxed/simple;
	bh=GkTj7TNjW6R4tg0nyYgeVViStxchvzoe49PzZwzQnsE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hA0IWXL7doFuSROGgB+8Axtivl49snA/D7FpAQVOiAUI5g6xjxxP/Te4YupbTGo9oL1tgvMsfEN8cKL24/LsyhGaodfdG7MUn0mAk9WdBLwpW4f/t//q3narV5Krd8GnBaMtovQzDUokC2utnISkuvFzqmIvnh0iuUt7vQAha8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QCclcFP8; arc=fail smtp.client-ip=52.101.85.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMbF3zR6ljwOhWbzoLdVck1NN10kgstt/YJh67HFiwd1yIQD/9XTDHVVmvxnfA/QxL2dqCjB2niOZnSBqCqWlqGHlIs86P7pEpOuucXrmlG8720fOGJdosO7G/N/SZ6NkUjvha/ThTqyIMV8ypAjL/0spz8BFSyZXaA+oeJT+0cSXiikeSJmsBJGlChN+h9tytXW4uDH/0Jq5Aw8jjV3h+xo4OPas7w3vJio0YKU51ebJRxrY5x/bHA3dvgOFWDiQBnHm3ogzLv91C5JGartkwkJ1mJ7PAUNapwL8y4vpreHLXnx+2DJrNJkEj4/gLDav1DRHMiK7Gk01ccr5ydNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtNxJ6qGAp65o76LuhcEc8gnk0Lhby4JccKMfODppjs=;
 b=YrjEl5dhQMAQxDoAyO75lU/i4UwvwWfgNBMl1o/9zf3OXSB39q4GvUJUcXjfwRUuboi2gobjUP9b+iuR/WlMCM8tvNOal9l7pOTpVF3ajv9Hb1URCBq0ybtTLXyU+BN9bo6lXXw8jM5HATxkQj9PR3ataMrIrqT/Lav3QqV9f5cXwLN/kZSAPXrNLGFgzwbmg65fg95vnCdf0E/boHPUNwsW15Mv/dOq5SWR+75hjC6YVihb9GO5D+wE16Yk26lVRhvFlYdnqyHkrB86kBav60I6ofnTTLKqM2csINEkRizLGAVO7eTy33nchYTr6QZSgQzN8oEldhdPgEuDYuOQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtNxJ6qGAp65o76LuhcEc8gnk0Lhby4JccKMfODppjs=;
 b=QCclcFP8LPNuMoSiF4BThJGcegybm6f13bzy/NJWO3vbOmxsDqrF5o2QVWJrmqzbw6pGApQg4kQ/Hc0GV5OZyAFaZDsUlG+DF+6i7Wh+qdY0aYteCK1oKnlgWtJimVU66fCviy9tmIBMjN7qGSxlgnQEJ3+nbew/qfvx8A8sQ1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB7228.prod.exchangelabs.com (2603:10b6:303:163::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Wed, 2 Oct 2024 15:38:39 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Wed, 2 Oct 2024
 15:38:37 +0000
Message-ID: <2f1cc274-74dd-4ac6-bc7b-6e378635ba67@os.amperecomputing.com>
Date: Wed, 2 Oct 2024 08:38:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
To: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@ziepe.ca, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <ZvxNo8ZWeyBOBU8b@Asurada-Nvidia>
 <742bd6d6-9d25-4f8c-9574-3d39a91c89cb@os.amperecomputing.com>
 <99cee26b-351e-4bc3-81a8-ec8ced373770@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <99cee26b-351e-4bc3-81a8-ec8ced373770@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4e3c6e-64d1-4acd-25ca-08dce2f84807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXhDMitCQnhOMUZPdldsa3NZT3hweGNvOFZidEw1QXFUUjNnc1JFYTNoMGI4?=
 =?utf-8?B?MGQ5bnhrdHVrQWtUUzVrdVdHMVY5eXhJdXNSQXVReUo3Z05OYlFOZWxGZ3NP?=
 =?utf-8?B?aEJMMlhjdkxWemZkbmRMU1FaZjdUSnE4bEYzclA4Uzl1dUlvQmt1Q0FTc0Ir?=
 =?utf-8?B?M0loalR5bEFmMU1Odk16VlhTTFNkOSs1V1BqY2FOMklSaVYvWE45SVZ5RjR4?=
 =?utf-8?B?aVZVR21RMXV0Sm1lVGpkMWRUVTIzT2RmK3FoN3hKWkdRSUdpNC9hcTdCc1lh?=
 =?utf-8?B?cDJzNVVlbUkzanZmbS9JZElNNytiZDdFWjUrbVdWRTdpV3FubitpbkhzcmFj?=
 =?utf-8?B?N1RHV3pCYXpPNnpPY2pXL3A5Tmp2MEI0RlFmcVVnbDJ4Yzl6dkU1ZzhNQ1NT?=
 =?utf-8?B?TGVydWxQend2ZzVIaXVrMTFKNXc3bUlaS3VFeHlNbm9kTmhOT3BkQlBadS9H?=
 =?utf-8?B?VkQreUZBaURJMEpjeS9rMlcyV3dlZE82SXVmeGRBYmFkRTZKZW9xa3BLL09p?=
 =?utf-8?B?TnJmblQvSHN6dTh1eEdPRm1ZU0xmTGZLVmpxT0JMa2hKZzVmcDBOMFl2Z2pQ?=
 =?utf-8?B?cFlwUWwyUHdVdTdiaUNaR29tSGR0YUo3aTJXVmJKMnVxdndsY25SVTJoTTdJ?=
 =?utf-8?B?Y0ZuL3IxSVRLbHBzaGxLWmtCcFg1dHZLdWhCOTBGZzlXUkk5YVE5YkRpYTAr?=
 =?utf-8?B?NldicGlBb0ozNmplTHZzYnJUdDlaZlJVdUlYeHU3ZktBRU1leXNDQUtWVUNk?=
 =?utf-8?B?aVE3eHNLV3ArMHQyWTRLTHBsSE4zUVV6SUIvVngrSGlvSmdka1dLaTBVY2l2?=
 =?utf-8?B?T2YyS0xPYmFCelJDcFhYWFhKbGRyaERkSmhPekRTS0VTdG9jSGhqUGx2aFFC?=
 =?utf-8?B?RVF6OGhSMHNDdXVHZ1NUMTVUdUo5YUViWVF0Q0pKY0dTcnpyakJWUklBaVZ1?=
 =?utf-8?B?eFJBNEdDTndlTHVGVytWOUFPbnppNlJXNVI4aFFTWTBNTFVVQ2NZbUs4RlBZ?=
 =?utf-8?B?Sk1vN29rdjJZWGNxRXlWQ3Q1bi9vVkdUcXU1djhqczc4RDlmSndFRzlsTEpZ?=
 =?utf-8?B?TEtVQSthS2tqTDQ5ZDByUllaQzEzb0ZNOUhqcEtqcWlCa0QxeVZwOU9mejhs?=
 =?utf-8?B?c2szd2tud3I1Wkg1QXdSRjJSTlhuY2RKa2sxbkRjTUVGeHloWmJMbkgvd2hP?=
 =?utf-8?B?S0o2OUs5eTJiVGFLS09KR08vdlc3djFrb09UZGxxMGRhcjV2elJNN01uY3Vi?=
 =?utf-8?B?WjNoVDJsanVGWlVwaXRFZ25KeG54YkloTlQzZkQzeU9sUWR2ekNjWm9qRjZB?=
 =?utf-8?B?NzlHQXU1eHB5d1JPY2VsWkhSZm0yU3VQMEhDK1dzdTExRUw3VnFrYjlqN0Fr?=
 =?utf-8?B?QWF4bFdHbXNzMGkrRnBQLzJ5WEJESHRtWThNQy9jWnNxZFFKL2FGUVMzVU9r?=
 =?utf-8?B?Zi95ay9VbHM4OU92emQ1TWNHK0JKOUluak9sRWh4Q0t6d1N2S2cvYTU4am9M?=
 =?utf-8?B?U3hBbXBUM1BHdjJNemJOcWEyYyt3U25YQ3ZXd2U4VjdRMXU5ZUN2QkkvOVJ0?=
 =?utf-8?B?VW1TdU95STU5dGxBTVdXUGZuQVp1VFRFR3hJVmxVNTZOVmxnaWNKZHZFRkdy?=
 =?utf-8?B?VUFYSENYQSttUE0yMytGVlBTU1k0bEd3UXBRZEZzbFp1NWUva3FmMER4ZkRI?=
 =?utf-8?B?NmM2WHA4RUZFYjI4UkdqME4wNXNDSEt1NTlNSExVUUhQN2pFNFNBZTNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2ZJZWkwTEMxOVB4UXk3REVxYytCWVUzY0U4cHlZYVNqVUZGanRDU2ZjTktj?=
 =?utf-8?B?UTVZZjliMkNabGsvMWJoMlAxNWpRR3FlUWNtelVoRUVkUit6NjBWMkFvUWZX?=
 =?utf-8?B?NUtoZVRQOGswSndscGJZUEdpM1VYa3I5SXM5WXVuUTlCUkx1ekY0bWtUQTVW?=
 =?utf-8?B?TjJRdUxDWCtlclJYU28waHpkV1QzR2p2QW1kRUxOVUJCbTFQUGhEc1J5LzRW?=
 =?utf-8?B?Z1poRW1HZklwOEJtZVJVZE9pSFZvR3NXVDQvQy9rdldhZ01lRjVnVWdJRXEx?=
 =?utf-8?B?bUd6MHBRYUF6eEllaFU5OWw1eDlBRXAvdHdZVmJ0L1dwbEthdmFOaUg3LzVJ?=
 =?utf-8?B?SjNPWDZMN1JDMkZ4V3ZaM2pkRERjMHBFVWpjbDZ5bHpiaThwRi9CL0E2emtY?=
 =?utf-8?B?Zlk4blUrajg0SzZGL0NKQ3UxWTRhYjFvVk8rZmh1VzFTdy80dENwYzhqUEQ2?=
 =?utf-8?B?bzk1c3VoeDhuZHBxZEk0NklIbVA5MldOZTQ0SlZCVkpzZDJmcEJFSGJKYXNP?=
 =?utf-8?B?eFp2bHBWVWNTTXo2NW4vNEFzd1h5N1BRVU95dlYrYjlCR0J2TTg0MzllbllR?=
 =?utf-8?B?L0h1K2pKR1plcGx0VDRhSTdQOGhKc00wRHZmK3BVa0JsVkxNckw0OVgwRmRQ?=
 =?utf-8?B?SHlYRDRsTzdmdmxqSHVIVWVKWXZ5Z1BieHdjNHJiNWsvWGhkNFA5dFcyUjhh?=
 =?utf-8?B?RVlBNHNpc0R5ei9pWHA4U3YvV09lQTRNZ3ZMKzAyV2JQYnQ1ZVNJZEYyOHVQ?=
 =?utf-8?B?UEdudlpMc2JXSEpjQWIvVHhjaC9aRkJldkhXaS94SWVlSXN2MGxZeUc4dTJQ?=
 =?utf-8?B?UkEydDlXQkJrRVdxZDZjUXhPQlJWSHUwS0lFRGMvT0VsRDFYNDF4YzRHb0JZ?=
 =?utf-8?B?Rll3d1FrWkk3S3FUOWpKQzFkVGNUVWNjdHN6RjFBbHZwSjRwME1oSzFXT3Zp?=
 =?utf-8?B?SGJKNDN3NnlBVG1SK2g0aEFFYmU4K051THh3OVlPYUM1VTJCTUhobjU1bHBV?=
 =?utf-8?B?NmtEMDlsQWd0aTFzRm5uWU5JZHVpTnZCZFRZUVByaGd4MzNBaUFvK25LTU1n?=
 =?utf-8?B?S1R4MDMzZmhXTmtsaGVXMmJrU2FoVmE5dlpKNXowR05sYTdJU2YvMzFMdHJK?=
 =?utf-8?B?K2Foa0Y3QXlHRUtodWdPSXFiaUVRKzB0WTllQ25IYkdKVnpid01EWkw2VEdV?=
 =?utf-8?B?RGNGNXk1QktpbHpPRDhHZHk1TEFzQldDV0NKWnZ1U2RzMlp4VmhKZ1RxNG8w?=
 =?utf-8?B?R2psZksvTWN6eFlLTmljQ2djaFBUWnF6amRVajV1NUFVSEtockJFTmJscEE5?=
 =?utf-8?B?UmpzdnhRTEIvN1hsWEY2dG9JUDZLU3ZsYm94UnhDRVgzKytFRExYcThMNmh1?=
 =?utf-8?B?dmtNQ2t0OFlJejVtUy9VWVZCcGVjd1ByVHNLblZrNXd2cnFIS3ZxN0ZQaVhV?=
 =?utf-8?B?RGk3a2Jqd3R3UnZ1MW5HVXA5ZlQzTitza0RPdGloc00xNExCTEhQZTdYMUhB?=
 =?utf-8?B?T1VDMGxhUnNQRUVmejgyczBHZ1BOWmhiVXlBOWRWYTJtRHl1SjFtTW5IYU5D?=
 =?utf-8?B?TzdCeWRhemwyTTVORmttaVdxUVNCb3NBNU1IL1hKM25ONFVVRW51dDlDdDFz?=
 =?utf-8?B?TnVlb1l4MXdWNmlzVFlFSTVpeUJBczRPWnhDU2NGQnRHVE42U1l5dEV3a2Ni?=
 =?utf-8?B?NHpSRXJHWlRadUludE1mT3hVcGVGdzQya1VXVnVMcmhVdVVISWZVblhvVEwy?=
 =?utf-8?B?a0h3dGJZb3RZeWhnMGczWDhHckxiNUtoaHdwSGhZdHAyckk3bHlXQW1tRWdt?=
 =?utf-8?B?WjZOY2hEaGt1WnJMZzRja202SHltVnZCeEV3eWNnWitZaEkrSE5LVkJHcWxJ?=
 =?utf-8?B?MEUrV3BwSEIzUWp5VHc3Y0lmQWVYSm5yWjlTUStRS3RBZHFPa1plUDFsSmpQ?=
 =?utf-8?B?SGdxY2tLWjZNZFZKNWEzeWUxb2grUWg1REpYRUlYeDlIK3V1V2FGVEUrd3p3?=
 =?utf-8?B?QUV1VTdQOHh1YXY1T1U2UnE3dDFsUHF2Ym41b25uMnRUNUsyMklaMUQycmpm?=
 =?utf-8?B?cEkzSitWM3FLejJpSXlYVU9oajFTZnE1aGV6NVpoMWdrV0pndjlhWEh0YVlr?=
 =?utf-8?B?NFRMRTRvQXp3c3hvVXRtcHFUb0xidXVCR2tRM25VN0dWMGcrY0Q0VnBYdUFN?=
 =?utf-8?Q?3fSHW2troohsJ1GxNu590aU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4e3c6e-64d1-4acd-25ca-08dce2f84807
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 15:38:37.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UA2HTVI4e7E9mempbnNeQHE+HXko906obSALuFJC0KhuCPmxo6fFjEeg+Aq39KdY+5LZv+Ry+RxEJuGooSuR9EqgLcZt34EFmvX29nV4RgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7228



On 10/2/24 2:59 AM, Robin Murphy wrote:
> On 2024-10-01 8:48 pm, Yang Shi wrote:
>>
>>
>> On 10/1/24 12:29 PM, Nicolin Chen wrote:
>>> On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
>>>> On 10/1/24 11:27 AM, Nicolin Chen wrote:
>>>>> On Tue, Oct 01, 2024 at 11:03:46AM -0700, Yang Shi wrote:
>>>>>> Using 64 bit immediate when doing shift can solve the problem.  The
>>>>>> disssembly after the fix looks like:
>>>>> [...]
>>>>>
>>>>>>           unsigned int last_sid_idx =
>>>>>> -               arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
>>>>>> +               arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
>>>>> Could a 32-bit build be a corner case where UL is no longer a
>>>>> "64 bit" stated in the commit message?
>>>> It shouldn't. Because smmu v3 depends on ARM64.
>>>>
>>>> config ARM_SMMU_V3
>>>>          tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>>>>          depends on ARM64
>>> ARM64 can have aarch32 support. I am not sure if ARM64 running a
>>> 32-bit OS can be a case though, (and not confined to AmpereOne).
>>
>> I don't think ARM64 runs 32-bit kernel, at least for newer kernel.
>
> Just use ULL - if the point is that it must be a 64-bit shift for 
> correctness, then being clear about that intent is far more valuable 
> than saving one character of source code.

Yeah, it must be 64 bit. Will fix in v2.

>
> Thanks,
> Robin.
>
>>
>>>
>>>>> Then, can ssid_bits/s1cdmax be a concern similarly?
>>>> IIUC, ssid_bits is determined by IDR1_SSIDSIZE. It is GENMASK(10, 
>>>> 6). So
>>>> it shouldn't be 32. IDR1_SIDSIZE is GENMASK(5, 0).
>>> Rechecked the RM. Yea, max sid can be 32 but max ssid is 20 at
>>> this moment, so we should be safe.
>>>
>>> Thanks
>>> Nicolin
>>


