Return-Path: <linux-kernel+bounces-321397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62239719FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BC61C20445
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA971B86CB;
	Mon,  9 Sep 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fBDTs2tV"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF41B81C7;
	Mon,  9 Sep 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886356; cv=fail; b=WNcqr/JiMyXEF5uqRGuhnlfKrXa7l3fAk58jSYODM6M1xyPf6oFvdQ3pc23hKfTq21WJqdC2/tR4alNXVUlsXAsEIWjKYDPT0xTVOGO6Jdo6T9lVhlozIMAZj3R67VKQHE+L6NRfULXtFOrBtlRtxcWjEKiH/2qMXROsu1y4hqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886356; c=relaxed/simple;
	bh=qAzwm5MiSqLy+LDGhOWO/xpM4miBmuP4v7KHaoaxxqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l/1+04fQmm2DP1s65Tdph2aMwLIBvtHllpRr2lLEnKuFrUmhhBAJKSgjDLNDb6z5pUH8Hd3iSWDnfBSf+3A3quH1VgrVwrYG8AHrvTFbH77aKt89FglNrbyGjFXYoNmL9hw9B59SzNpMPf17y8TED3pxt1pXwbdy8wnyqcG0Unw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fBDTs2tV; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvAThO9O7TUgkHndIjiYOQPyao+OxFpXdz/G09RiJSx/MX+UjIkbGBLkmoh8SARbC+qMdO3SXQmIBGdx98T42acPz7MrtWt9cIvPv8BpKtOpIao+nv3zAzNNgBdl1BsNUWVwgVCG61qIW3NOrR6//aKGG3NTUqPQb+eROXUlfE0fJC8r1J36L1aQGmY3PS1/LCV4ma69//knmK7+LQd4P2N42M7TRc/sLDRRN93wqFXzzgbUcjtH1/2HGB2OOleApP6r47j1WySsjOg0oCZWCSkUJ59Q+SFp20D2i/CPu6qUJttHbki4RnZ6OjnLuOt41UDr6eCZ0YIF2CxOhL0D4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Pgt76962MoUIacObbvbMqUyr8UZOaUYpLg+isyqKY=;
 b=ASF/FeFiXgrUuY2EBGKQiaVfart3OLfHYc6CWTyQqRdE/riR9WIoLxXtfVHri+iwxvmtYp/fn+ndWJ8kXzwga+18l58utM1SgS7uVXoqEYzjR9oq4ApUoZvrwDxOrszo5+0AWOqI1P28siq90ucdKLem977HBW0L1ktgqeiYqyqGagSCJRUBHCk+8a+orG3IQOLH/mpT7zT0+HuiKk/MG1H2Fuif1rPWl8wf+tjPDdW8a2NlN/kNToh5BcjzSVPpgm9QV702lafjVTZTpgMb/5CrVvn/2Q+8q9R530p/c+xAPyzQnf90JbkjBPqXw0zaliPkxtJYOrHOT/Z7XUMpgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Pgt76962MoUIacObbvbMqUyr8UZOaUYpLg+isyqKY=;
 b=fBDTs2tVPY6MntewfMQ+KZXGpDSmZzMK0qRPZ9XjTHcr6nOUKIjBvNQy4dZdRtexai/S0Vl+iLYyTdlob65eaEzxo6rAJhjFyYw55pLY/1dV3QNNRFguV5X8fx1OvHPYXM++Qe9qK0MpzTo6qwLY48YltqnAmDTqNvN+yF0dP8CP/jKSZ4lbcF5TqpY6K0SEsvTDHAcoG8jowliv70RjrTd/H9CvK+1aJYxywtH8CP8+XZGnNLghXYtmOCoN5OLaf1ufdZOSPgN8tJqIvjI+5Q7Mpl9WNB/x3lZYN9Q80Cn/bHza/PxEr09gNEkLcpxgBqfdY4CKc3DqrQKv5dEOwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 12:52:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 12:52:30 +0000
Message-ID: <5ed9df75-c45b-44fd-8eb1-3cc9c6b0001e@siemens.com>
Date: Mon, 9 Sep 2024 14:52:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: pl2303: account for deficits of clones
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a07922bd-4550-41d8-a7cd-8943baf6f8fb@siemens.com>
 <Zt7q-5kk5SPgE7P4@hovoldconsulting.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Zt7q-5kk5SPgE7P4@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:610:e4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: c7460164-4200-47a3-566e-08dcd0ce4431
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWxqemRDMjJIUUFINklSTk1pWUVycUlJV0k3TG1KdUJkNGNkNzlvOHN1R0s3?=
 =?utf-8?B?QmVmb296Mk9aM2UrYTBFZXRONDBDTjNtSkJPc2xIMC9CbGtVR2VIMTNyOTl1?=
 =?utf-8?B?VUJUVVBod2RjN2JBRFUvUm5RR3JjbXhONE1WbWpockw5Z1VUZ3g1cWJRZVZS?=
 =?utf-8?B?T3lEVHpCZmRUemkvM2dXcGtyNHZlU1hTekFhSTVSbG9zNmJkMDdUYnA4U3hV?=
 =?utf-8?B?dGprZ241dFRwb1JXRzg1WVk1RDAvVmRXWWNqdlBoSkVjK1JicldGUnR6ZE00?=
 =?utf-8?B?MzNiZ0lUUTdvRDFCYkh2N1NSbHNBWE15RkhKQTJCZkJQTGlpeGxuOEVJcytR?=
 =?utf-8?B?bnd4YzVJZzF2eTFHalFRd2w3cUJXMjgzV0xJZG5vdVJLcFJ0UjB4Tm9kK0Jz?=
 =?utf-8?B?dDREamhVdVlqd3ovcXMvWkdkYnNhUlBqY2ZkTVVZalVVZkFwTjhFU0FkVkMr?=
 =?utf-8?B?SjZkREc0K3hSRXpzZ2ZIcmpEQU8xWlRBSWZZM040aXVoSXN1a1N4cHdBQ2VU?=
 =?utf-8?B?aUpyaENGcktpak1VWjJxdnoyMzdwQXFNMVcvOHB2RzRWNldUSHNKRmpTTUlp?=
 =?utf-8?B?Z1VaQzNkbzlnVkErc3krYThRZUczNXNKQlVYaExBK2JaalgzNGVwdWRsNkVG?=
 =?utf-8?B?bXJsQmhScjVqbjBubXpPcStBeUQ0ZmYrMUhoaVZQOXBEOG5pMSsrM1pOR2ZD?=
 =?utf-8?B?SSt3WFVvWGh0T1JhK1Nsa0NUU25iS2Y2Y21nTmdlZFNvYnQ2cGd6bGdFTTNP?=
 =?utf-8?B?bm1pZ3Z5VXVFMmtHQm5BM1dTVGEwZXlMckYwRWIranVXYUlySlhaYm9CVVJh?=
 =?utf-8?B?SEs2SkxNZGtINUtMbUpwWUxSVTVrVSs1VDFtZzFVaVljTHU0bkM4OWt1ZG5n?=
 =?utf-8?B?K2ZiOFQ4RW01eUtYcy8zeEVaN09JL3l6SGs3Z2V6ZVFabHdDYXk2T1IwNzVT?=
 =?utf-8?B?akUzQ1pIVjBkNU9NSHdFWjRTcEx6QUdVNSt4NS9YSWNKS2VwdnZjVTdZMm13?=
 =?utf-8?B?dGVXTXFYNzZyVWhiRFlpK2xGRGxEUVBYK0ZTbENycFF5b2VSOUdabkxySWxH?=
 =?utf-8?B?SzFhdGgxb2taMFRvZE5HaWhsczkvaVhhcmRNMWdKV3hFWDhQK1ZTeWllb0Zv?=
 =?utf-8?B?ZUtjUUtWU2ZsOTRwdWtWL0I2aGUydnlHdTFXNUloNGI3bUhsRVpqUkZIWWlD?=
 =?utf-8?B?NXRuSUx1dFFFZ2dzSklaRng2VzBmS2FiallOVUhGaklNdmFEN2FRK2hwOGpr?=
 =?utf-8?B?UTZ4ZmEzZmFOa1RCN2VkZDNJVUFUMHdNYnZYTzRiN2hBZ3FQRUVFVFQwdlRi?=
 =?utf-8?B?cHVPTXhvQk9TNncxVjJHSFFmemVmWFI2dXlhRmRTUXVXMGJXcUh5cWtzQkx2?=
 =?utf-8?B?OWpxMEY2SU15cmg2dmptcUxMVzU0ZGJqUUtsMmdlUkRwSWt1UGwwNnlYbzRI?=
 =?utf-8?B?SGNlUDNtVEpuSDFWWW4wMlhOWFNhM3dXbTBEQkhTNk9CamZPVnZhNTFmMHNV?=
 =?utf-8?B?enJRdExUejVwM0Q2anB4Z3JRRWZaRkUwc2EzSmQrMUhXR0cvNGpqMFIrQlVn?=
 =?utf-8?B?N201Nko5TFFCU21aTFdJamJMaEZMMDJFaGpsWXJ0Zk5FeG1RWUZmTzExUjJR?=
 =?utf-8?B?NVZpTmk5Vkg2ZXhVVXFKTU4vS0dTM3dGeTBIZmllNC9UMDd5QW5Ld1dGUHdj?=
 =?utf-8?B?SHdqMTlDMCszZlJqSVQzY0UwZE5FWThtRnhJRDZHTUZMNHJQWTZRNTdVMERv?=
 =?utf-8?B?WC9qTytOM216c0lRSXJ2aGFMNUkvZUQwb3VQR2FDcDMyd0Q0U1NlNkxVaDUz?=
 =?utf-8?B?S2R5UlBNeWhxSExyRlhJQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGkxRVBORWlPckpCbldqMFVReVdBa0xiNUFTcUgyNGVVemlXYlBZTXpXNEpL?=
 =?utf-8?B?MjVjbFpOcTB3ZkRGV3NWYWIxalVyRC9QdjlkeG9KMm5XY3Z4NldoSnpLUkJn?=
 =?utf-8?B?Zmh1S25USU1xNkN0bHFlRGtaajBueDVlTGxNejRzUmE1M05veHl2UnVtclZG?=
 =?utf-8?B?SS9aWFJUekJxSlJiODRPb1VjcHdJSXBIVnZUdEMwOFEwQ1hTaXpzMk1lYVRL?=
 =?utf-8?B?Nk15bzRSUGJBSjRsajlwNjhGNCtwYjJvZFdOYVdQdHBabFg2bmM3WlVaV3FW?=
 =?utf-8?B?NmVwUHRuT0dNcFhIcnkvdlNManl3VUw5VjNsd3cwMWlLZEhGcG1oUzJKcU0w?=
 =?utf-8?B?VjBCQVV4Rm9NS0lROVVoYWZOVk9MZkloMHZvM0dMeHp0cmUraFZubmNDZVdk?=
 =?utf-8?B?cThQd1k4UlQ3amZFSksxVmpoU3g1TTc1K2ZMdFNBVVQ3cENpV1N2VDJhUWhz?=
 =?utf-8?B?c2dQRlVHYXRZeTNCbmltSmpjb3VRQnpmVnZXR3REam1yMzlOKzhTNTE3Ulpo?=
 =?utf-8?B?bnNSTllMdlBndS94U1BDSCtiY1hGNEdnUC9MSUV0SkJjZ2s2V1ZNOTVwTzJR?=
 =?utf-8?B?V0k1aC9EN2hjRkhqRkdoUFJ2RHQwOFo3QStvOTE4ckM3dDh2NW12M0Rwa2lm?=
 =?utf-8?B?RVdoaFlmaXlYTzAyOElYT253cnVMWnE1OCtHdEZubTNyUXp5THdKTDVPV3Nx?=
 =?utf-8?B?ZUlsRzVLZERRM2ZDRllSQ09iRlVYTTBMSnFYV0NEV2gyK01LYzRlQ2RDY3Fi?=
 =?utf-8?B?V3lZTngwOWg5ZEdUR05xenhsSmhURFpsZFpsYVF6NDRmWkdMTWtpN0RTT3ZW?=
 =?utf-8?B?Qk90YzRodVpCNVM5Q1UxbE5rdjZpWkhjY043RHlLd3ZmcWQ4eWNZY05LSDF0?=
 =?utf-8?B?azJ0bXhXbFErTUhRaUNHbE5DazdsajBtbzM4dkZqcjBpdTZBZFNxLytvZXJw?=
 =?utf-8?B?ZHlRYVNEVUpVMGhSVnVYZG5ZQ1RIVjVjLzhjVUZzMHcvcEQxMmszdTduNXg4?=
 =?utf-8?B?Rkg1OTdxRFI5V05UenNaNHlhbEdiS0RlSks0UlNGRGpWUEpoSTdWWWFuN2RQ?=
 =?utf-8?B?RGQ0cUZKQUlmT0sydmR3WUhuYTd1UjF1Q3orTUg3Sk9zaFJBd2RZWHhxVE43?=
 =?utf-8?B?R3JveVYrWWV2Q0Rab3Z0cHBkOGs5WnJWWkdPTlIreS9nT0E5ZnRkMVRabFJ5?=
 =?utf-8?B?elJqb0JYQlpKVGZ1V0NPVmh6RG85d3k1a2xwTjVkVWRDb1VvNUtTUDZLVk0v?=
 =?utf-8?B?WjdxS3hpOVFBT28vcWdjK0dKYktQVUZGSHc2aDgzUG9XZnhXeFlMeEFaWVVD?=
 =?utf-8?B?eWl1bnR5ODMrOWdCazN2bjFKMlNFMTUzOUhiVE10K1ViU0E5S2gySyt5eEpm?=
 =?utf-8?B?QkllenhQK3ZuWGlYNDQ5WUVrNFZiM2hMd3dibk4vTjZpQlBuSlJmTDg5UUE0?=
 =?utf-8?B?RGFZaVlmdVFNeG8reHpqQlQwYmdGZ0YxZnNJM1AwdFJNQ2Zwa21uR0crS1Zk?=
 =?utf-8?B?ZzEzZ2lpRlR3TW92dXdKb0xWNGlZdXczMWpLMjBGMFNab1g2aXc0SW80Z0tm?=
 =?utf-8?B?alRlVElKRmlOUHZQYmd5NGdYUm00YjIvS085TWR4K0gvZHJ1UzQ2Q0syS0R6?=
 =?utf-8?B?QmtBWHRRaHpNb0YvTFo3QzRxcVovc3N0UnV2R3Nxd2JJWm5TRG5mdkI3Y3FW?=
 =?utf-8?B?clQ0R3N5c21aZUJYV1lKYVlTMlExWXhiQnFEYVB5empKcVJEZkhKQ3ByT1ZY?=
 =?utf-8?B?WXJWbjFleVM1QmNZTFlwQ201SjNKUFBsejZHWFBqd3pVb1MrV25RY2FaUGQy?=
 =?utf-8?B?MTd3bkNzUUpKZDNRQlRudUZTazdnM0Rqb3RBYnN6NDBqdG8xcHJTS21adTFz?=
 =?utf-8?B?Y0lTelQ2bXBIcFRycitJaUwxWGFiWG5wUCtzbHJha1BlTkU0dUl0bE1xNzdK?=
 =?utf-8?B?dnpncHplM29DVStLVFFvbDFBcElkNFpjc1l0YXdqeTJwUXM2TXcrendSK1BQ?=
 =?utf-8?B?V2pxM1VZOElqTzRiVk1MaDNqRVg0Skg5UzJsL09teitCQzNIaTRGYkF1bUJV?=
 =?utf-8?B?MnMvWC91bmVqeFN5SWJ2a1I1bFdidDU0MmxqOHF6SExEYW1aTHVNc2J2Njlz?=
 =?utf-8?B?VHhVQ1p2SEI5L1VNc0w0cHcvQmJ1UEg2T2lJK2t2ZlNDcU5mcVdXbi9DWVQx?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7460164-4200-47a3-566e-08dcd0ce4431
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:52:30.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jb33I0rkUb5NE1b+mSyYyipyByN5ICERQAaT9lGspo3s4z1yRpfhuWhftbTHgpDantHpMyKB2ddXt+HNjjx4og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7839

On 09.09.24 14:32, Johan Hovold wrote:
> On Sun, Sep 01, 2024 at 11:11:29PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> There are apparently incomplete clones of the HXD type chip in use.
>> Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
>> flooding the kernel log with those errors. Rather use the
>> line_settings cache for GET_LINE_REQUEST and signal missing support by
>> returning -ENOTTY from pl2303_set_break.
> 
> This looks mostly fine to me, but could you please try to make these
> changes only apply to the clones or, since those probably cannot be
> detected reliably, HXD?
> 

OK. Is there a way to switch between dev_err and dev_dbg without
duplicating the line?

> What is the 'lsusb -v' for these devices?

Bus 001 Device 019: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial
Port / Mobile Action MA-8910P
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x067b Prolific Technology, Inc.
  idProduct          0x2303 PL2303 Serial Port / Mobile Action MA-8910P
  bcdDevice            4.00
  iManufacturer           1 Prolific Technology Inc.
  iProduct                2 USB-Serial Controller D
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0027
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0


Unfortunately, I don't have a HXD device around that behaves and is
likely no clone, thus have no reference.

>  
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  drivers/usb/serial/pl2303.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
>> index d93f5d584557..04cafa819390 100644
>> --- a/drivers/usb/serial/pl2303.c
>> +++ b/drivers/usb/serial/pl2303.c
>> @@ -731,12 +731,13 @@ static int pl2303_get_line_request(struct usb_serial_port *port,
>>  				GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
>>  				0, 0, buf, 7, 100);
>>  	if (ret != 7) {
>> -		dev_err(&port->dev, "%s - failed: %d\n", __func__, ret);
>> +		struct pl2303_private *priv = usb_get_serial_port_data(port);
>>  
>> -		if (ret >= 0)
>> -			ret = -EIO;
>> +		dev_dbg(&port->dev, "%s - failed, falling back on cache: %d\n",
>> +			__func__, ret);
>> +		memcpy(buf, priv->line_settings, 7);
>>  
>> -		return ret;
>> +		return 0;
>>  	}
> 
> Looking at the driver, it seems like we could move the only call to this
> function to probe, and perhaps then an error message for cloned devices

Nope, this is called on every pl2303_set_termios, thus is even under
user control.

> is not such a big deal. But even that could be suppressed based on the
> type.
> 
> Or we could use this call failing to flag the device as a likely clone
> and use that flag to also skip break signalling completely.

Oh, you meant the function below? But that is also in user hands (as well).

Flagging after the first call is theoretically possible - but is it
worth the related effort? I doubt that a bit.

Jan

> 
>>  	dev_dbg(&port->dev, "%s - %7ph\n", __func__, buf);
>> @@ -1078,8 +1079,8 @@ static int pl2303_set_break(struct usb_serial_port *port, bool enable)
>>  				 BREAK_REQUEST, BREAK_REQUEST_TYPE, state,
>>  				 0, NULL, 0, 100);
>>  	if (result) {
>> -		dev_err(&port->dev, "error sending break = %d\n", result);
>> -		return result;
>> +		dev_dbg(&port->dev, "error sending break = %d\n", result);
>> +		return -ENOTTY;
>>  	}
> 
> And similar here, the log level could depend on the type, unless the
> function should just bail out early for clones.
> 
>>  
>>  	return 0;
> 
> Johan

-- 
Siemens AG, Technology
Linux Expert Center


