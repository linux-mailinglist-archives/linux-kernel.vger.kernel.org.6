Return-Path: <linux-kernel+bounces-434487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C09E676B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB77E161B97
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B411BC9F6;
	Fri,  6 Dec 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="epVvd6vm"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2132.outbound.protection.outlook.com [40.107.101.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5FF28684
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467667; cv=fail; b=kG6aEPuVVObAMxfnfBQ/GpnNOR7vFdH713pNh1iQZ1z1k6thQuWdj/S0yyRbSxcbkYjDq5+OqOgF9rCeI1mhtUlpTRgvruXiJlX6DtEkecfhmDqF1AgkrgwdZ3Js3SYZ15KWEMTx4InB0X+hSCNvtugrjfWgI/t65WFWOf48N+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467667; c=relaxed/simple;
	bh=N9t8p0mq4TrK2AlyRggqcy4D9QXClrQVtRr+Pc/+T+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQyHqqZqZWyx745KDf4n7nSbajsjr0b+scTvg+SDXXdJr0IFmLcByRzL/jQjP81pkrWEou1S4qvGfkIGCTEZbyzNPZkJdMokOIZPDpBUjlbRDgntGCDbR/9wR2/Tg8ze2LVykLh35Qfans7ISZzE5JBnXpobcT79aYX+k7cHDnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=epVvd6vm; arc=fail smtp.client-ip=40.107.101.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTeYQJ/3mIgPU/X8pTozx0xFToCtjip/K9sSTSiuvvFUTa7cC4XN6/Y7u7K5s8KSLLuAbMe4AN2gw67S8zOwLWOQ5ic/lu59dU3ytFRNrxnPnwfdvNHgArb2Pc4pKGCO1GSVLL4o36miukxLa0hpzYg3w/MRzWpALadtszqT39QVU2+negOigjpGrbH9ejOnItdMMxJkXXrDPE98hRDLJFH5O3AoJW8yFdqkFTp2TmZeoxnITbvuCMBqDfZzYV1fNdWwHf7AMU2FrVS+bpzRfp22kdE0E1A2dFPnGPhoUBruFhVY0x/GQ0wmHJktsT/s1ItDTx7aYxiMbVoyh2DXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3gn9/IecRN2sPSj+DWH4K50qIyLCrTsE16lXjzNhfA=;
 b=D8uFvBFgfTn9osGVeT5ap5tff7L5VrXgAs0FI3sUpy9sSl/XOBklrj0Bw7algG3+LbP7mPs3a90wkmPntOggpV86alhB47ck/7YSjhbGr2bGN9fHRC1BaGSfVzjL9eispBPl+4QTvX9cw/JmA7ExMx8+LSNnuLZszHVzkYirAj/0U+a6/xwIHjzkBK/GawCzSmwqm8qR3cCOrQ4TKO110MTuivjxYBJl/taf70Vad6/Y2Y+aom/+4TOSSSho6fp3Tb5TItcXYQcg3rXT9H9qraRHCc+T8MRsPzca645xbaDaGATihBC4JfQOEW2CP5dwnUXjyk8e7biWfQ96uX8T/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3gn9/IecRN2sPSj+DWH4K50qIyLCrTsE16lXjzNhfA=;
 b=epVvd6vm8m5o8iUItuO1utT9z5DJqtisf4orNqAldnRpMIiCWmob354yIKiwMCJX2ocEi9QChjehsC2EnDLE0btucz818ThS+ymPAC4sNe7BptXd9eVapgSbjXoWfU0pmGfigCF+X1e38WvmqgScaL7MnFibgeFFPQ/iXkolkak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 SJ2PR01MB8531.prod.exchangelabs.com (2603:10b6:a03:55a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.8; Fri, 6 Dec 2024 06:47:42 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.8251.007; Fri, 6 Dec 2024
 06:47:41 +0000
Message-ID: <8e8bdc77-d834-4f9f-ba8e-fe055a476cfe@os.amperecomputing.com>
Date: Fri, 6 Dec 2024 14:47:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Untangle NEXT_BUDDY and pick_next_task()
To: Peter Zijlstra <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
 vineethr@linux.ibm.com
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
 <20241129095500.GD15382@noisy.programming.kicks-ass.net>
 <20241129101541.GA33464@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <20241129101541.GA33464@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|SJ2PR01MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: ee24a725-1880-4961-cf34-08dd15c1e1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWNnSWZNYTNKWkk3bHNlV0Q2NU95QisxbUFQU2wwYVVDUFA1cHdQTWRXZFRS?=
 =?utf-8?B?Nlpyc0FzN1JLalp6RWhLcHBRKzdmMkM0bTFkcFoyeWgzTmhCTkxpSzVYZVli?=
 =?utf-8?B?STZMZlNFMGcyd2c5M0h1bWFyRU5jaWhkbXo4UUVORkRuRVh2elBuZ3R3Q1dk?=
 =?utf-8?B?UkJzUUsvRFJHekdzMUtXa2c5WW5IOEl0anNYYjVoTlM3M2gzWWRiK0gxR3Ju?=
 =?utf-8?B?TjlpWlAvLy9wRUxiSWJVeWsrYkpmcmtKd1RpdGtWOFhDaExwUTJDR3FNbnZX?=
 =?utf-8?B?ZncybTFydUdVKzdlQ21GWk1OYWRPL0dQb2lwc3ZEWGdjY0toUlJ2RENyVEV0?=
 =?utf-8?B?Q2craVQrTDBVSEl2bU5xWGFEQlF4M25WWng1d2dlVGIrbE5UbWYya1Z4VENn?=
 =?utf-8?B?ZWFTQTY1UmYrd1hQQWQzdUp3bTh1NEZMWHVJVm14OCtIU0JXMFd0VW81MnN6?=
 =?utf-8?B?NXcvc1laamhtUHo0MGtTb0lrYlhIdjFSZ2NYRFZYYkVKRjMwSHdpOEZ6UCtY?=
 =?utf-8?B?WVQ4WXoxMTlZNFRZVHErNWVna3pud0xISC9LcjBUeW1CUlYwYjR2WGd4ajlB?=
 =?utf-8?B?N3c2MjZTeFR4cHJDclkzTzVlY1lmcUg5T1hGV3ZXK3pxMDhMSGlybExjc1N5?=
 =?utf-8?B?amVERnA2SzRodjNjMkJWRE1CY0xIYTBRTVM1L1BZT2RqQThBMXlSRTZOUElx?=
 =?utf-8?B?M1pVdFJEWWx0MWNIbzlaeC9vSGpLRUpmUmtua1BFN2FsaEdMVzI0ME5iUGh2?=
 =?utf-8?B?OVNxN2xObGdsZGpxRTIzMXluYnJaNktwcUIrVjN3NS92VkdDK3ZLaGovNENq?=
 =?utf-8?B?cXZ4a1h2ZXRSM2djeVNqb0lzMFRzODFuY3lHWlBsTjkrUFg3dDhsMGpiTUpZ?=
 =?utf-8?B?ZExqK3pxdVFqblA1OTNtc2xwUCsxOHlSbDNTQkZjVFNUZWFrMFFacnRiOFZm?=
 =?utf-8?B?TnFZb2Z3MHo4Y0JPMnBtemRvMzZ2RXppR3lqWTg5TU55NkFHMUs0d1NVTlJO?=
 =?utf-8?B?bktNR1E1VHdJTEdYQTFYRzhhU1Y0YjhBalloOVBUSGtBV0JLeHZUSmhsZEQw?=
 =?utf-8?B?Y0xTdnR0T2s2VzNUTEhsNUUwL1NETlhSR2ZodjdBVGNnTlVWY09zOFBGOURI?=
 =?utf-8?B?M3pNQXI1ay8wV1kweXU2ZzVpd29Oa20yN0lwNW9nRVhVODJJRXRDOTJrbzhC?=
 =?utf-8?B?R1V5SzVOWk5FUEVLT1luYjQxRFp4eldJQTJRK1FaTWZZN3hNanFiZm9nVFRu?=
 =?utf-8?B?cThHSzFIc2pJVW00UGtLdjVubkw3Mk9XMlRDeWt4YjQ1d3RJVUYwbmpMM3ly?=
 =?utf-8?B?c2tUbDduQVg1eUIyU1dmZ0F2MmJscVQ4U2ExSERlWlp3UXBmYUF1emY5SzNa?=
 =?utf-8?B?d3lQbHd6OGdhOGptaUxnVVhiaWdSbk9qc0IxNzRpbWRSak1LRDFnVTljMWp2?=
 =?utf-8?B?UmZYcUtVellSNjVCeW5hRWZjdkNraUFDbFZROXBobENKaHFEZXlRNGJQMWQx?=
 =?utf-8?B?a3BBUVRwc0NkWDlGdXBaT0ZJUVJtSUZyMjIyekpPREFHa0ZpTmRqRTkrU3hz?=
 =?utf-8?B?d21yRUxTQ1diazdGaENZR1BUNEE2d2ZNS05FRzA4elZvMVJqd3R6b0pUZDY5?=
 =?utf-8?B?cHoza3NhZW1NaDdrN1I0TU1DcFBhQTh3d1hhd0NrN3EwellMd0tyWUd5b3gw?=
 =?utf-8?B?UlRKVzdyNEp6enFUVjF2dW8xRlhOV3NBbVRodFNkbE1YMTRoa2UxZDk2SlJo?=
 =?utf-8?B?cmNHYVpNa3hhd2xWdkg3VVFBNm44aEh2S2NCeWt1THBtUWlhck8zUmhLWDJR?=
 =?utf-8?Q?lbMIGD6B2/GoOX85ZhFfL9XT4Ds4V1YB1N9XU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azBZZjRzaHdVbkJjcm91bm8vL2x4dzViZHRkN2ZvTEFwaG91SG92blJVcFpm?=
 =?utf-8?B?V1duektRS1RuMk4xbFI5YkI5bXJwRzlhMmFiMXJrWHBab2dCRVk4dEdHdnVX?=
 =?utf-8?B?dUxSYmtVUnd5UWFaV1JxSTJjMW9URnVJb0ZVQS9pWHY5c1daUE9oWk1YdFox?=
 =?utf-8?B?MTBvenp3eW05UTNVTVZpVitROUFBL2N6azhOTHBCQnF1UWJWVGc2TG1SSTEr?=
 =?utf-8?B?ZTI2dDd2TGRKMFV5enR3TDNqTDRXNy9EcWZyNGZEL2ozUy9ycGNNWkVzNkNP?=
 =?utf-8?B?VzZQRzE3d0hMUkloYzhrdVNOVXlieTh6Y2tHeCtiSXFPaFhDYmRmZUZvNDd6?=
 =?utf-8?B?Uk5UNjduRGdRVzVGSEx2dElxR01pOXJVTnFNcThlVUdKNTZVZEx0SjFyVzN2?=
 =?utf-8?B?VTFwOFhBazE5ZnVaT0NCcTJzWDVveE5tTTVUK2M0V1hubHpBZkhNS2R1SnFy?=
 =?utf-8?B?L21peWRacndIbmYyUkdvL3ZBN1pvUWZNNm9ZZVhVMWd4OTB3N2VLVnJ6NUhC?=
 =?utf-8?B?SGtkaEhxRmpiang3WGk3bFFFWS9QOFlkNFlpeTVMR2RJUU80Q1d3UWdYOFE0?=
 =?utf-8?B?Qk5Ta25RWjFET052ZThxaU53OGY3c2w2eWFKencrT3EvVXMrdVhSNEEyUEhu?=
 =?utf-8?B?VWMwRWc3VGs1c2gyb2lra3VrNy9YNlE4bDBjZnZwc0I1UXBUald0cWVTTVBP?=
 =?utf-8?B?UWNQUW1xSVpRUjRuampzK2RZQnlSekhXN04zdCtqWkUwSm96TmwxKytlcE1N?=
 =?utf-8?B?VTBkcEVsd2xjT0szaWt6bC9MbHlLMVVlZ3NJLy9lajd6cnpBbGpOcmRhTUZD?=
 =?utf-8?B?N0ZaZDRUVGRtQnZvK0dDYjJiUEJ1c2x5TDFxVXpDMUppR2x5Ym1xOHFTTnhB?=
 =?utf-8?B?SWF3TDI5dmdwYm4wa09sRTFoMENraGxBSTM0UDVWNGNBV1czNUwwZ2x6T25O?=
 =?utf-8?B?b3VkMzVQZ2hvQllZdG5lcEsvbFgwRzg4aFU1VTJWTjVPcUE3WFRQejN5eTIz?=
 =?utf-8?B?VysrUFNIaUE0S3VPUklva2x5VkpmY1BDc29scXQ2cGtrNDBrVGxheGhaNXB3?=
 =?utf-8?B?SEEzQlJCdVM5NnBRbWNnWXV5UWh1dStRRTJJQWltL2NFNUxoWEptdHRSSFJH?=
 =?utf-8?B?Z3g5enNUSUhrTnFWK3kraFJZVHV0dmJyOC92SE5RakRSOGxBckhQVHBRd0RB?=
 =?utf-8?B?VzdDRWJtdFhXMUhuUkxWb3czQlFWRFZnOVB6OENWR05uUkxRVHJrQUpzcS9v?=
 =?utf-8?B?cWcrM29OZGdYa09GNllUTzNXRlN0QjMyQmRPVGR2TW50eVp0YlZCQ2sxR0J6?=
 =?utf-8?B?OXlMOHM3ck81RkZJRi9jdHVNdHRvdU5pQlgyUEpCOFJBQU9JY09DaS8zSG0w?=
 =?utf-8?B?R2lySThZLzU2bGI4a3podUJ5akp4L1hoaGk0enFTZUhtMmRpZ3YvRlcvTlk0?=
 =?utf-8?B?SExvL2ZxNnJka1B3Z0xwMmlTaFJPckx2RGNka0FtWE00RmRkcjRQUUk1STQx?=
 =?utf-8?B?TGlLazlHbnZHaFdLWkQyUWNDZi94b1gzS1p1ODRxWmhLaHNqR3drbEdMeFY0?=
 =?utf-8?B?V1NkM0VsWmhQNG9NMHVzOW1jS2JlZ3RTQy96Z05IU2MyYzFIWjdqRDF1WTJ5?=
 =?utf-8?B?eEdEaG1NMUtiZ1N1Z1Q3YnNBLzlsc1N1RVJFT2dUWTBJREE0LzZTQWJqUHpH?=
 =?utf-8?B?ZVNMYUxSbVYydHhWY1NueDgzNkFTM2MzVXg1aGc4OEtneFZyODRiMFhhQm9X?=
 =?utf-8?B?UFJyK3FUYmlsL25WemphNkhKakh6SUFHVlJwNzJzamdheFNwUlhudFJTTUJp?=
 =?utf-8?B?UlpObkQyS0VuV0YzY1pyVUdiTUt6TTJLZUlIRlNCMlhFTUhzYk5YaC9jWlJn?=
 =?utf-8?B?OXVTVGladXNNd0NWUUd4dUZWYTZ0SWpQc1pQZ0tiaHhkRk92b1cxQW12dWJx?=
 =?utf-8?B?ZWhONm9nR3ZqUlpQeHlyRHY0MkV4WWsxRHY1Mi9oRVM3dld1WTN3YlNLNDhL?=
 =?utf-8?B?ZVhnZFhCNTJtakwva3YrcVVZVjFOUG5hZ0hwOGl2eno4djBvZGJLTml6OVFu?=
 =?utf-8?B?Z3lyTGdIbEpScXBuMmRZaW8zZFhsWjgvcWVmVU9FYVFvczhKRkFqdmJIcU1U?=
 =?utf-8?B?cU1MeFp4TmZnYmw1cmJGVERSME82N3dxWVJoM0svOXcrNHluQzZwOGFQMXdx?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee24a725-1880-4961-cf34-08dd15c1e1c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:47:41.9104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kROh8JI89jIW2j+NnMemp8lxYJ407abkIPZCVNR5wTywO83s/jj6OdR+K0ulgpu/3cWcat271OsxbcI3k4R4xrzgLCkVeVtulHAmwLwvUVj/6LYXJzwO0T8UyQ6hWT7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8531

On 11/29/2024 6:15 PM, Peter Zijlstra wrote:
> On Fri, Nov 29, 2024 at 10:55:00AM +0100, Peter Zijlstra wrote:
> 
>> Anyway..  I'm sure I started a patch series cleaning up the whole next
>> buddy thing months ago (there's more problems here), but I can't seem to
>> find it in a hurry :/
> 
> There was this..
> 
Hi Peter and Prateek,

I tested the two patches on 6.13-rc1 + patch "sched/fair: Fix NEXT_BUDDY"
(https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/urgent&id=d1139307fe97ffefcf90212772f7516732a11034)
 
1) sched/fair: Untangle NEXT_BUDDY and pick_next_task()
2) sched/fair: Add CGROUP_BUDDY feature

With all 2^3=8 combinations: (NO_)NEXT_BUDDY, (NO_)CGROUP_BUDDY, (NO_)PICK_BUDDY,
there is no warning or panic. There is no significant performance difference for
Specjbb workload.

And there is no much performance difference before and after the two patches.

Before the patches, I think the default setting 'NO_NEXT_BUDDY' logically
equals to 'NO_PICK_BUDDY && CGROUP_BUDDY && NO_NEXT_BUDDY'.
After the patches, the default becomes 'PICK_BUDDY && CGROUP_BUDDY && NO_NEXT_BUDDY'.

Thanks,
-adam
> ---
> Subject: sched/fair: Untangle NEXT_BUDDY and pick_next_task()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Nov 29 10:36:59 CET 2024
> 
> There are 3 sites using set_next_buddy() and only one is conditional
> on NEXT_BUDDY, the other two sites are unconditional; to note:
> 
>   - yield_to_task()
>   - cgroup dequeue / pick optimization
> 
> However, having NEXT_BUDDY control both the wakeup-preemption and the
> picking side of things means its near useless.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c     |    4 ++--
>  kernel/sched/features.h |    9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5613,9 +5613,9 @@ static struct sched_entity *
>  pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>  {
>  	/*
> -	 * Enabling NEXT_BUDDY will affect latency but not fairness.
> +	 * Picking the ->next buddy will affect latency but not fairness.
>  	 */
> -	if (sched_feat(NEXT_BUDDY) &&
> +	if (sched_feat(PICK_BUDDY) &&
>  	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
>  		/* ->next will never be delayed */
>  		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -32,6 +32,15 @@ SCHED_FEAT(PREEMPT_SHORT, true)
>  SCHED_FEAT(NEXT_BUDDY, false)
>  
>  /*
> + * Allow completely ignoring cfs_rq->next; which can be set from various
> + * places:
> + *   - NEXT_BUDDY (wakeup preemption)
> + *   - yield_to_task()
> + *   - cgroup dequeue / pick
> + */
> +SCHED_FEAT(PICK_BUDDY, true)
> +
> +/*
>   * Consider buddies to be cache hot, decreases the likeliness of a
>   * cache buddy being migrated away, increases cache locality.
>   */
>>
>>


