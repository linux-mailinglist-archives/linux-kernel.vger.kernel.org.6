Return-Path: <linux-kernel+bounces-553765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D9A58E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB0A1612A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3C911CBA;
	Mon, 10 Mar 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DmHzJSxA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="izQSuu5Y"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9F224229
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596517; cv=fail; b=EiA6dG6LAh4fWzpML1BTCy4tu2H7cnabjtpXET3aCBq4F9OJqqvYv2XNFY4DIkJ+vEl8HkkclRh+MgXPxK+vgf0jKWcWNmj3+ETiGSAfN4F3gXq6PuXVwz6cIg/7qFWEDpkmAtmocuTo5nXlsO2wldw7Gul737djqpd1DL7TWiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596517; c=relaxed/simple;
	bh=8Z7V+aAIzJwJQEoN3B5ri9/LwOVQonQ1vsKqm0RDuf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tM4iuaCcYkGy3NsQU5VHr1jHWq8fRPymniErqQG9Xn2agiI46a6xqwJi4wdpbGoOUPdEdcrcohhDpHyIu/PDnKidX/Ln3MPZFvJXNn5OZjOtfVvabbzrxs1LBNAqIuxZsXTph4uV1VylBi/7gSrAxLr+g8cabo4lKcDBdN9qcdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DmHzJSxA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=izQSuu5Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A6fgqq014130;
	Mon, 10 Mar 2025 08:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GBkuiEs0tTb83+F7CPMBN2nA88WDsXQnyBCX9o8oK8I=; b=
	DmHzJSxAhg00CrdM5Egh35TPoKMOs5pFIi/1e/q2AYhDf8bAW1TGYwqdTFS4NQU0
	vk8hnhMpO6blcukyK1RP+Lek+L7XeA6FZa7mUk9obRl/CF0vhR/P7SJCcMBPNwDP
	MywRSEyrKu8FOGbXAFc5vY7QmY2ylTaAaKJAeWdnSv9CFSjzR0O295CLD/uhv08d
	tlGDJzeKJ/sPwKzWSKayot347igF6gNw+8hn4Xzb0s4101bdz9AYpGqGni5u/D9d
	Yl/ffXZrX+eu8kR5ZeDHd4lXwou62RYgG1ZQoU92cNuVTGAm4loctN/7O2wnLC7b
	L8C4bMnYc7bJxZ/P1Gm9aA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458caca37h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 08:48:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52A8ik5r021733;
	Mon, 10 Mar 2025 08:48:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmmrp5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 08:48:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6bZ2Jw89TXvVSzDWBjRF8W1ELQhjq5CeThVgFPtyzey0LFB1VyyFBuhafBPBmKAmOxpv5LezC7JicwKEAOvyyKhtz0CuFGdevbsNBCN1N8QGXT2kKHmwwpoTIu/qoA+7q0wYkcf0a+PauIFrqPn2qtKwiyp/fOXnpTOOYlNCNEs4vL+aTFkBDCXnHDYngXVOio8lw6VcN+TIywTRfCHoGBI7wKNTBUjQwiTrhQh1zSLpoRWAXNgDaU2fbELpB9plqGyW8rSHH3fQu1rCvYuiAuLE1nDPrZgoJDoy/bYZeBz7kXfAF+qcs63/vUGu0F2ORA413TNdh3faMlvNGKsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBkuiEs0tTb83+F7CPMBN2nA88WDsXQnyBCX9o8oK8I=;
 b=fWh8ASUerNJw/DArRAvkBFeZe/nAQdaq1oq3b4il73OjI8JI+k+X6Zg1c8BjIsjeARYFb5AFiqvZA+zQgQ1lBJ0+qPXAxQ7evLItlseVkiwr5DVnEEv9dssKjUdBBBtJ5fdd3arC6L+41Z6XFlfPONKskSaIOYV/rRophGGMoN/DVdOUHYKSs6GkKE9W7JoqfxVtQTMBqZNLTVU4LJrT0N3U1rAXf71ngCPotE0JfjbZsA9jgcz86ew6jUCK9fQaJq/MtmNrMdInmTqGsifA4mX9oEWjAgj77SOuLIl5vByREcB0o1AeNPGWrTDa/6g33c/rSGUiM90h+/SZRKMmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBkuiEs0tTb83+F7CPMBN2nA88WDsXQnyBCX9o8oK8I=;
 b=izQSuu5Y8AR0leAO95YmMEEsWCirAI+HaRInanWO2uy4WONtnF6NpYwN+GPt/TJ9j2M8qTFCLG5v0cWVOOQHNuHaZgDjusjy+XwJcnPvykF8amEmt1IjM8QOp8OSemVEA4NJ9nVGWl0YjI6oeNB50ksk8UhtQjSGIEJjUOksX0Y=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:48:10 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 08:48:10 +0000
Message-ID: <2045efe8-9e32-4a38-a7a7-799cca1dca89@oracle.com>
Date: Mon, 10 Mar 2025 14:18:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add vulnerable commits for few CVEs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, andypma@tencent.com, Jesse.Zhang@amd.com, forst@pen.gy,
        adobriyan@gmail.com, vegard.nossum@oracle.com,
        linux-kernel@vger.kernel.org
References: <20250310062349.206687-1-harshit.m.mogalapalli@oracle.com>
 <2025031043-parcel-uncharted-0d8c@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2025031043-parcel-uncharted-0d8c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0062.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::13) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1b7107-e81a-4f20-b56b-08dd5fb04918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTduNXRURDR4VldEMi9OdGFiclhYb0hGS0RaSy9TMWJ6dnJTTW1VcGRYeEN6?=
 =?utf-8?B?QVdwVlFBb3ZhRmsvRStsM2ZNQUM1ZXJKUEpydmV0T1hDYjNTTGtCOVE1R0ZX?=
 =?utf-8?B?U0dvL1FSU0pRN3FpcmZmOUI5TnhCSXlyS2IrVmZGVFRhTjU2YkJWK3ZaYnVX?=
 =?utf-8?B?M0RYb1MwMFdhOUR3K2xzaXdZQVdnMTV2UHZpTWxpaUdXNFhiNjZlMFNNdFlr?=
 =?utf-8?B?UXBQT3ZQNS9rcmJtQ2R3WnN4UHMzZmprZ3VFVWVaVmhUNTE2MU5aRzRJSWdK?=
 =?utf-8?B?aE5zNTdqM0JhNks4N3lkblo2U3R5QktURkNYMDI1QWE2aXYwQUVQTE1KNmRH?=
 =?utf-8?B?ajltZVgzTUFaY244Y2h2OFV0NHlTU1ZsYzE2NzNWaCs0SDVsM3BIY2xML2VK?=
 =?utf-8?B?QnB2WDR0RkhvUDZaYU5OYUlkaFdKdDk0NUl6Z1UvZzJLN0ZhUVhTQWFpaW5U?=
 =?utf-8?B?UVI0bnhtaWhFMHpEU2p2UU9oV3RsazNuQzB0N3JhTmFyYnkrVm1VS3FMeE5o?=
 =?utf-8?B?TnVLWkp1TWZveWMxMEZST05HaUhwWmtuZXgxSk4rM3VWWmsrMnBORTBKbSsz?=
 =?utf-8?B?VC9Ld25QSHNlK3Z2ZmNRTWdXTlhUQUpjRUxhRDErNHVoV1BScVRyODh5cHkx?=
 =?utf-8?B?UTFjYk42bE1JVVRueWJkemJBTlVjdkVOQlQrN3JIdEl1SDVRTE9VbmNmOWEw?=
 =?utf-8?B?OHp2TVBnQStIb0RMZllBWklJcmNFbHpsaDFTVWNWVWJPOTNTWmk2d0djV3hh?=
 =?utf-8?B?dW4yazVYZkR0enphZUxaMkllTTJvc0ExWEVzMzdydDJPRmdxNjZZNVUzQ0ht?=
 =?utf-8?B?ZDg3NU5qN3NFWFFKK1gwSDZib1d0THNORDA4ZUo4YmdQa3VKMG95M09pbFE1?=
 =?utf-8?B?RzNhbDhwYUsrSDRYTVdSdkl6OTUxR1RBZ2FjTm5TTjhwL1BMTmxiMU9tb2Ez?=
 =?utf-8?B?OW1aanVwMWJKcXk0SGlXUUZtbXBzdkRnMHJVRWpHeE5JTG8rRDhKaklTVkdw?=
 =?utf-8?B?RngwQWtuV24vZkdZcjBnak1XNllxdEpEY1BYSlMvSndUMEZpdW9LakptSGIw?=
 =?utf-8?B?aHNlT3ArOXNJRVloVlRkQkNncUd6ekpldExQVFJqRWFtVm1EelBPMSt0clpZ?=
 =?utf-8?B?WjM1eGZxK0liT1JQQmVMLzhTZGYzL0doMEE4Qm9kNjMzM0cxU0lrU25wS1pH?=
 =?utf-8?B?TmN2bmRKcFpSTWFUZGxoRjllVUs4UGlzY0M1K2dRTFhxTFlQQlAwYWZSMkZm?=
 =?utf-8?B?cnZ1aFRaYjdzRk1xcG5YOHVnQ2t1N1Y0MFAvZ3hjMEc3NUZvVUc0cXlCVitJ?=
 =?utf-8?B?d0Y3eENqdFNZanV5cHhmNUJWN1gyeU9lUkVHT2Q4NFd4TWN2ZGlpMjRFbmRp?=
 =?utf-8?B?ckk0QU1TUW1JRjJTeDZPcTNsMWpDMkpKZTlyK2VBNHF2dUprQ2FuMEVBcldP?=
 =?utf-8?B?L2NFemxQTHVwLysyUGI4aDJzUWd6MkJ4R1huYUViaExoUHE5bEpESWg3K0Z0?=
 =?utf-8?B?T1dwN3dnSFlQWUZxTVJsNGhUei9kQVFZbUFLQjBwZmFTMnh3cStLQitnR09W?=
 =?utf-8?B?NjdMUlRVazBieDZTY0tzK3pkMjZjOTVWOUVZUlRaU2tQQjhYQUNKTm1UMzdZ?=
 =?utf-8?B?S1FJNzJ5VUpUNlUxSVhVQTBkbWxZblBmUnN4TXhRQ1JOQlFQWCtJcjF5R3JW?=
 =?utf-8?B?NGs1ZEdMT1ZkVmgwSXdTMDF1UzYxRHFzaDhSNVJwSExCN25nWGZ0alNNQUZX?=
 =?utf-8?B?VmdyOUh5NytOa1pVM3d3RGVaVXFXQlFqZHMzUnNJWmJsbGgvVTNJQVE1RVhs?=
 =?utf-8?B?ejlrUFNwTU9NTTdNUUQ2U1BOYm9iTmZxZzQ1SjQwWW1LTmh4R1NrdzUrQk54?=
 =?utf-8?Q?Z5gaZBTSNaE71?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE1sbzlrdmtSVFhTbFEvbUUvN3dDRjBJMjR3bk82SkN0RmRWSE9ObjRIWVVF?=
 =?utf-8?B?OUpJeExML2ViMUk3cG12K25tYVhvbitJdXRRQlF3MVkvQVJtdDh3Q3VSaFU2?=
 =?utf-8?B?NFFwVi8wLzdPeHphaGxpaER4K0puTzhWMVJvSjdpakx1c2xkSEYwVENYTEpy?=
 =?utf-8?B?SlhIbjZZQVhLV2NKZkFjODhYS1B0RWtESCtGL3hraC92bE15a3h2bElVTzZp?=
 =?utf-8?B?V3FyNkdmS2tNUExSbDlvNEJmcVRSTHRtM2ZnekFtZmQvbWQ0OEEyNlR5OVU1?=
 =?utf-8?B?eWpodTdQWFJWUnMvYjc2UUFRSEEwaEdsV1FBNXBMYlVST1FWOStMdCtUcnVq?=
 =?utf-8?B?UDI1ZUdDTFkyeU5Bc2F1S01YL3loS3JUVmhKVVFuT2N4RWt3VU4wUDNobEpV?=
 =?utf-8?B?bkg5MWxESkZqZ1FRa3l4NWRlajBpMlRJcHZ3ZVlFZjVFK25SR0tndUJiMFJG?=
 =?utf-8?B?WWEzb1JEWDlFblgyN2ppUitmMUZpNUhzSEhnVjZUMjh6RHFRYVYyT0lNclhn?=
 =?utf-8?B?RlJUVWpaWGZ0SlArQ0REaXEyWWcyKzM5cHRDaFhoVUJTMDdaRzJ4VG5mS3JL?=
 =?utf-8?B?UkhuNm55cjZRNzExSHk3b0wrODVabU5IaVVZUDNQaEg1NThZSkl1MG9mTXcz?=
 =?utf-8?B?V1dYN1ZwN1Q4UlZYMHMxRUF1ekRhY0RvMjRvaHJDMVhvS29hb25mYVRWMktM?=
 =?utf-8?B?M3pXaTR3N0tIamNrYWtKNCtZa0VkUDl0ck04aUkvN2lnWW15Q0M1TnBRMEVI?=
 =?utf-8?B?dGtiSHVUTUlPT0Iyc2JqeVdDSk92emJRNHNDZU4wZFhYSzljWXpwclEzYkRD?=
 =?utf-8?B?OXZmUEtza1hJbmtIQmxtNEI0QmJXTW5STEhnbUlPYllDemk5YkY1TUFCUnp5?=
 =?utf-8?B?MytkNGNNMWplSFN2dWl3SUMzNDQ1alYrOUVtV2Y3ZmJvK3ZRNjJ3eDdIa2JC?=
 =?utf-8?B?aFh6clhOTDlNcllkdEtWalNzVVF6VmttT2luT3hJd1dYUHNiSFZCNWtRZGZG?=
 =?utf-8?B?ckRxczdaWmZMNHduWUo0UnFiTkZtVkFmT3Nxd0JnanlXNjFOb2NIQWJ0cDlj?=
 =?utf-8?B?YndiZ2hMZ0pHSEFMcWRkekF2VnY3UFNEcVVmenUxalhVd3JCZXVNdnViYUQ4?=
 =?utf-8?B?OTFGSVBKQ1YzMWVSZXFhQVlrNzZ3bG1qenkrMHc2Y21rckZLYmxvbXkrUXdN?=
 =?utf-8?B?ZFBGdFh4NjdEYm1wRWFIU2lKMzI5WWJnMFJwVVl5UUwvc2RDWG9NV1drTXNO?=
 =?utf-8?B?OElhRnIvZDJhdEVqUGdjOVlMaGQwQVhZWEJOZFNhSFZnZEdwZ2pCUE9vMG5Z?=
 =?utf-8?B?amZLZ1o4dVB1ck1aeldySnJYNVNlWDZ6bmYrcG42L1c4alM5QVJPWkVucnda?=
 =?utf-8?B?SVg3MFpmSytOU1NsaThDM0xleElpeHBRUk9icm8ybXhtcUY3bWd2dkJ3YVh3?=
 =?utf-8?B?STBWd1hQNWNWaDhEZFVWS0J3blpMQmZuSm00eWdwRWppM24vZ0hqcUw0MmFa?=
 =?utf-8?B?NUFtdmtGUERVZ1l2b3U2R2VlZ1ZmbjY3Z2l1ZERPeEd6Y0RYWDkrem5BN2dT?=
 =?utf-8?B?QUl0QjhYekhOaTRSSm12ditEak54cWx5R1RCVUtMOVBlQXE0MXVCUFVUSUxX?=
 =?utf-8?B?eEMxb0ZFMFk1VGlGdExRZkVDQUo3QTNzNEZESkhEcXVGVlRjU25DdGNXSHM5?=
 =?utf-8?B?azQ2Vk1SUFU0RkNoN3J0d2l2cDMwSm92YnpJS3VVL0E0Undwb21lSUNyd29n?=
 =?utf-8?B?akt5WW56TGE2ZkFFS2N5K3hrdldRRXpuN3F0RXZMMUZrS1BEckxxVTNpY1hT?=
 =?utf-8?B?NnMyUlR2TFdRc3VnOXdkZk5uUDVmMFpWb0NBYUozZjZ4ZzVVRThVdTlJNDNu?=
 =?utf-8?B?TlNPeWU0VFBHblByQUhoTk5LNWt6bFJyY0ZyaFVJR01XZDNOM3IvMkpxN204?=
 =?utf-8?B?dUFKZVVkQUthK3NLd1M1OWlDV3dFYTdLWjhCeUxiYm5idkZ1SnRaM2dYdzVa?=
 =?utf-8?B?MlByUEhZMHFEVWZudWVTTjJVaUZjaWJsSTMrWURLVmNBdEtUcklOdzdNUE1P?=
 =?utf-8?B?OGNBWUgrVmNlTWRMVUhkUHloK0lrZW04UnQ3Wm1LYVdMTFREN2JOaE5pbzUy?=
 =?utf-8?B?c0ZuZ04xTEdzZ0FvOSs5SGY3OU15SUNFSXNDSnlRR3lJZVV6aDFGdmFneFVx?=
 =?utf-8?Q?oVPcl05Fe3438VkTRp1nDF4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lHlnGu0m/+QFFNUdK/TpdwJwjSfP3T1n8PRfGmKPF49BQ1s9UWSAL13+K1otv53vHkVW+S+OinpHrgUXoHW0l1Zd2DkcjbO0nlFn3vTjkQ8AV4Vc+x65X9+mOusqDk7j1ntlQEt2cSyD8iZE3laTpn6VZKSFOeFJgt0AwBR9+D5XCTXRyoloAc2J1MT9Z0X2Rpw5zn6KXHRqQYCWNBvtf0OWTkDSGfcqF3MypTSukQzSqaXj0CIVXhBibJ6afgpPXKLbcY19UAHWsHAL5GPfvkgz7ctJRnQW6OFdYBXAAhoNEFdYsdcNnuSbr49UKH9dy46g2e/RHYrECIgW5he8duqJ+4lWRmq7EfGPHGTA05nQb6R8IFNYJ3DZr9SVxoeU5MptKGVm2Z2+gXGYRK7qMn/E+BzSfl/Wr18ek1c5X8G2hgDMaLKpln8z3xrMEO4v2Zy2z+yWiaxKt/thqQ0AFWAG77N5R1BqMuyymGVMUoNB47FreNwpWSXBOkIjdcAGs4IiNQ3bt9lERlpruEYhmua+1i5LlDkwDXKc8aNUNsEhlOj0tPEkhTQOa7IcEyDHDvt0ZTNYZ+FBwyzM90Cn2nfIgWbda0avSrCBzhc2P44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1b7107-e81a-4f20-b56b-08dd5fb04918
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:48:10.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jVVZL4GLxWQrgEV6x21K6/Y6eMsdu3osyTjWVFj6PwYG8rYUaSLIS0FCNfXyH1YoG1QZ+APgG4g/XDccIBg+87oRzRks1zfR5TrkyXnsDf+vjxc+2gGW6KRuvklTrvL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_03,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100069
X-Proofpoint-ORIG-GUID: 6TLnmCN-2Zsi-zTCpwPUF57B5rDReekA
X-Proofpoint-GUID: 6TLnmCN-2Zsi-zTCpwPUF57B5rDReekA

Hi Greg,

On 10/03/25 13:07, Greg KH wrote:
...
>> CVE-2024-46861 kernel: usbnet: ipheth: do not stop RX on failing RX callback
>>   — Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
>> Reason: dev->rcvbulk_callback() was added in the broken commit, and the
>> CVE fix is to remove the return statement on failure.
>> Note: The CVE fix is preventing driver to stop on non-critical failures
>> -- I think this shouldn't be a CVE
> 
> It's it a denial of service if the driver does not work for normal
> issues that can be triggered?
> 

Ah yes, I agree, thanks for explaining.

...
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> Thanks for all of these, I'll go apply this now and update the database
> entries.
>

Thanks a lot!


Regards,
Harshit

> greg k-h


