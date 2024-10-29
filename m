Return-Path: <linux-kernel+bounces-386935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89E9B49E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A170B23249
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE91DE3B7;
	Tue, 29 Oct 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ERmAKZqO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gJb1867Z"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F51DFCB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205692; cv=fail; b=WTBTHxSf73KY/PGIp7G9Xy/1TuZlfOtnp9FvvqTE2m7pQUk2bw6TTVq6i36X+ZFYfRcz6yvspat5Xm/wFQIrmi/aXAijhLP5+ohK/xDis9YiwbWdCwlObmKMf2tEs5/OkQa1oE/Nqix6R5dFQzSrDo04/SmnbeNOyDG793IQ6WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205692; c=relaxed/simple;
	bh=plnL+5mTrSEq/jBVKEG24oZwK+2AAA/YOzZWkT7Pq8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XpRi+AVbQZaDdHFoHiRan6XnSxhjskYpHuWmFm3Wf6X9mv1pZKrPc3Rwfb/QROlfr7qUFtzlWmXjdtwfKnjIX0Q+nV92Dw2WFFEyUeVSk1ef1uncj7SFxXbQVw8Fzu+79oSImkuLAf5Fd5N4L7LcJfqmpooUUi5hy2y7UGypkeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ERmAKZqO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gJb1867Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCbo3A007758;
	Tue, 29 Oct 2024 12:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=plnL+5mTrSEq/jBVKE
	G24oZwK+2AAA/YOzZWkT7Pq8Y=; b=ERmAKZqOmc1Zk/6ENAL36JnFHCiVHF3tvp
	hBW4c7sE/6wtDoqMVFDhg9H+HbgJsbjU7FglvDgpWAwCPRvYwMvBHWKNrXSVROiL
	M02oZMge0u5hoGSDP4SCZbMCeNlMjgcSLGPLSeIQ0EpcFQ8eoF/leMeZ9GQoe6XU
	fkiVROqEwQ58EVtNxiRCr+KemTm1JHlQJaApfapmGhZUOrpV8p6CrweMGlN5awOe
	BgDNy0518Ogt6iXy3rq9wYxI1KNzlzHcVUHZ6dza56G8WXqpwsvkDp6yr7uYpRl8
	pHk/fJ6FDl4j9TE6+dMwFkMpHt6lsbqaSUmjMhWneMM2MRN1FRuw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqd8jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:41:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TAu1Ge011811;
	Tue, 29 Oct 2024 12:41:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaceub4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQHzTIVn4vaoVW3ia8G/9/lPOI0BnCf59xoSBCDGnuZM06VSh8l0oQneHxMhXa8iLi8chFZEZ3SDQM7064avMEQgqwIbAbBgA28izwzRnqTJvbmlte99YjQYjWZoZavzx5u3xLqb+UKfuLibhXOl2SUWmqii5wY7cF7szJdUaEykGGnHnC8u0MKcv5ufrZeK+JFlZFOG3OynepEh786Cmi3b5LriccfN2+PS5WnIELdvKE1TQcwJUUgT+e0yPtPUvB5rDYNpHC7y3iW868Wv57KozIWJfPxm/q/RvU0iFiNYaNgaSBUpgsMqCzxbrhxRxPJFsKrE2a4QbVMfcFqeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plnL+5mTrSEq/jBVKEG24oZwK+2AAA/YOzZWkT7Pq8Y=;
 b=kyIgJzQesPSNmdipUO2wKQVilNf4aY6yP07PE7ib9vYldrxvryLGZdfyt7iNQuN4mlH6ph4EXg9pP5G3ypbh0/quihV07NMpqCHUoJV7qIQqO/NdItd5c9X9B5nju6t5fPQtClAsFJGGxvMK22Dlr/kWqeLAxSyFtemLx2ekBkd69iYo76jDALCyM/yzNOjmD/8ipeBWB21vEHfSQI4TKOdUHK3L6YOIUBGnszIM8ndHDclWaPk/VwXdqUj0y7LleG5i7WeNJXM5gqgcK/Bkc0NxmgrT/B7TAGYRkLJSCkM1ngf1fU8arioNMcs1Kr6ojh1lN876QdvOP2qyE74f2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plnL+5mTrSEq/jBVKEG24oZwK+2AAA/YOzZWkT7Pq8Y=;
 b=gJb1867Z4kkOpIvsSiJLGlE9iCA8pd6MeQKV9lIliihrSpTJ1TzwIGwtpHIA/2nQnXJf5rjQHAH30iA3EIQh4qOau1ptLKDkJcfVYj8q5V6jXYraySl9G3unCBp3YkJ2V3G4FH/eaapGRU+74pSpErwhRTcZpj45uOJQ8duDg7k=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB4881.namprd10.prod.outlook.com (2603:10b6:208:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 12:41:06 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 12:41:06 +0000
Date: Tue, 29 Oct 2024 12:41:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <83938e00-ab62-466f-b08f-99eab36117f5@lucifer.local>
References: <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
 <0d3237d7-cb70-4979-b262-29ffe7d7a608@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3237d7-cb70-4979-b262-29ffe7d7a608@sirena.org.uk>
X-ClientProxiedBy: LO2P265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::33) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: eee226e9-8454-4bcb-8141-08dcf816f53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QVB96Zn5rAlpmIcYKU6WJm96gIe+T08ZEeDsEd9MLLwKU8V5E983jUcq6lmx?=
 =?us-ascii?Q?/nm6K1N50Vp/n+vL1e8hc3XXnnF2aXigzsW7BKZHTZloYeDgL3aNrRfC/d4a?=
 =?us-ascii?Q?AKrreT/SdUjoKuYScAE82g+vmpXOXmI4lccQjsivAu58YW+FE2ulgagen/Kv?=
 =?us-ascii?Q?hTil/lVZwnNPUT0pecAgj2K1LzUDlj5F+H3E+kj8U7bNy6KHXjWiqpvMMfSI?=
 =?us-ascii?Q?pHChQ0XQT11j91rXl9j4gjYafNzbrOR9wSWJil4OWf1sTPQshLImsvqLdlZS?=
 =?us-ascii?Q?YITJ4QM06sZcfOMU1lisvrv5QLXKU/MZ/XPL4ke/ihlaP9GUFQwIWhTXYO92?=
 =?us-ascii?Q?73WgA4HsAP2YJ6D41yEgcOtHMddjHWAgIMGT3klNQe3uCubefY5HCVjAscmi?=
 =?us-ascii?Q?xHGlx77gaSyR092L8DVvV59K+DZd0ol51/N/u/iaVmMe4XpEyjJApWB5UhRn?=
 =?us-ascii?Q?AyJhRqOQm1jSlvgK1cHtOPfUQGrjbNT2p1818MBMWZ4Kaq1W6csjba4t8Cgy?=
 =?us-ascii?Q?Cq8VDTNhWIU8QOj7s9VtYcMIMT+wWyR7G0w5BZjlu+o2liPvFiluAoIYRf8P?=
 =?us-ascii?Q?Wqqg3rIEC+9xlpPR5rspdOVL7jt/wUxLrLtonvGYXi0AF+g3D/M+VBo2cREr?=
 =?us-ascii?Q?HyxNDfoQRFeSevtnwwXFzpEN8p6QkWKHMcKVHb05IHhsgLebSLXy0AHj+hVU?=
 =?us-ascii?Q?hgmbohplq6+XMbBqVM4aypwZ/It6yQ1hl3ttL62qcOFf773z82l+NHSNZk9B?=
 =?us-ascii?Q?2GY2t4bxzvmsrFnAf9emk+Vcp/ceSNZo/u6JJokkds7ZBEixpFBjAmkDBxKp?=
 =?us-ascii?Q?j4J8nIUuBQ67eSk2qAyDmTWN/JExxwEHs57J5oXp2tOQb9TavJdFyUlFMyBl?=
 =?us-ascii?Q?azpeN4jGe022gH5H7G/LAtO56Esk19m5Ndbpqcr5kHFSxwt5NvyQBjR7g9fG?=
 =?us-ascii?Q?2wa7RCZZCl7ysrjl8FHUYYEkP5Ca8duKFx300//amFe70kqf2neZqNbsw8X5?=
 =?us-ascii?Q?8nmGNxxBSCRebHiHnRA7DSfCx3JlOQXU5SvQmwqUzDGJ2FFmWcOiLXU2ZCnz?=
 =?us-ascii?Q?AYAX5COBi1H/AcHHc8n4BD3lBOPiaD8ObLPxofJD7Tbqrv/nYYOPdLIsgD3A?=
 =?us-ascii?Q?V7FW2Yjlp/BqGOQfJ7hcIigV3DgwmtvWxev1lllEZLJ5O2kJ9Xz8RV0ZDs6q?=
 =?us-ascii?Q?G3695Ewt516YatbrqiUlznAq3aXpmdPaxD1atewpi/assdGW14zHw/c+tw7q?=
 =?us-ascii?Q?lTcoZ5gZfB63NQlCA6T9yQHPWtclx4pkCgRXvR5nAIw1sYfR8w2ArvJYyrVA?=
 =?us-ascii?Q?EKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UzKY9fSBZPGUFuPWRYFQXiEEbZZS8uG/qHgB6C+sMcCcMw3yEhhd9HfctPoX?=
 =?us-ascii?Q?63B2OhgQfDhzh/V4Nuy7xdc1JQL1EcNib9pSPY7EBdLfFL8olIKTbtIAK4sx?=
 =?us-ascii?Q?7NwwQU8Dm2FKdXBv+F6VGpKC252DpgQqSCgBfrymX396xRxPEEviyEgCxJAT?=
 =?us-ascii?Q?QFSfdyAGmSfnQ+e4lmhltxfyYjHusa3bAmZPLNkPqoRLA8sbBHwO3Cybx+92?=
 =?us-ascii?Q?cbQ5dtxkrkm2dZuMkTDDbFUHw6sLSnQLH81k2sNn1s3Y1s1o8r9igrYzKg9f?=
 =?us-ascii?Q?Dda8Qshf1fKWaYrMChotlJtmiMVbE0/ajxeqZ+Eo58qBBOI4/3N2R+L0p7dH?=
 =?us-ascii?Q?j240pRY3RG08UFfFpuTJVfqnzWAUIhpvJlELHlD0zS7v9Iuwh5uf0gyRkF2/?=
 =?us-ascii?Q?Kgx7tAfrDZ3l3atxrB/WtjMWIw75hTiVmME096gC88m9467tSiZrTDjg0BB0?=
 =?us-ascii?Q?OrawZwB8HJl174B451eeAbjZ2VI5DE7B9AwY55KMU148i1Nk5OJLrLzr1ayq?=
 =?us-ascii?Q?yXhKgjSILpLo0+niUzgApS97BNr8W/e2zlCMWI8DwFzbK/O8Vj6JroQCF4yp?=
 =?us-ascii?Q?MelsRlScxC/ps5WI48rrPRclYbe7wZImXMCW7k+ti6ROsG7FYGPIYbeA5uSh?=
 =?us-ascii?Q?rsnoAOSidyCVqkBMxIZDcBYC+sji+RNWiX1djh1jyF88vSTTyIcKyZyRAyVw?=
 =?us-ascii?Q?UC4ugEzUJZ9GO9Z714azRpETNe9sazM0aNu3BgghQjCJV5aMWjF5GCWqbmKw?=
 =?us-ascii?Q?8dQTS65didSBeNYeCoOuqwhQ43gw1nIyOnu87CTbYXaTDliYZm3yz1o8yPLa?=
 =?us-ascii?Q?/8EUIR1vVwsLCBFT78k2ZFnqUHvELmCYHKasd39FufYFYyv6VE4yem83ZfEK?=
 =?us-ascii?Q?pEnNEc3/A693/an2+UHIiTgd5Ki9f0VZZF4Yvx3V1lBMuEq6zvq2C5Bu3Ecq?=
 =?us-ascii?Q?GfAJGMeMHSgjufzv5+teQvNZ5yTtrsUgCGYTXpEEE2jTmBXFxrXzyKdmmT9n?=
 =?us-ascii?Q?/Foe19tYgSXUDwHvBhfFMb/2wEGK2kGwtrm2tCm3guPc491DcjgZ7CELQbsy?=
 =?us-ascii?Q?61k1Iiw+hj1L7HWJcRcagk0jtQKYAvhNInRc2pcOC1seiXZ1iqyI2jTYSBin?=
 =?us-ascii?Q?EiAvXAuNgTjlGcnDFdf9S2cTCUVDJQGOAtawdbNaXVo7XFdfhnX2WHFaFUUh?=
 =?us-ascii?Q?bufUdpm0a9D5z3CqjPQuE9lnRdKEa7w3Zo3Lt1FGoqIuGkI/PfJX8/7eHbX1?=
 =?us-ascii?Q?6nLMLfm3pVuUafb3sBLzeK20vGvopqPZ+XyRH2CkQsPZVcHCqo2TyxAmhcF7?=
 =?us-ascii?Q?JMuCsFOwULzvj5eHGPiBDbQt1IIf8OR0lYiEKnab+LmxQaqwx/+bhaqnoRny?=
 =?us-ascii?Q?IS+mnB4kyXsAfnlU0itOhvfjsQU5BhanSMhmlNERHpuR+331UXLymGL2fDA8?=
 =?us-ascii?Q?M6lcPfNcAsGYhLSvThHsA7v1vcXyzWVqDHYr05Oz7LmkB4Wj8FFEfhOE9I6R?=
 =?us-ascii?Q?3faMuR8v5H5vkDbkGPf36qrF3c70dqZSVdhPL8mPp9jmFNZxRb+5uxMqogy3?=
 =?us-ascii?Q?4k9fwPOQnriGjMJNvm1TvwemXSrGxZ+TCy56ULHYO7YUdFsMLNl53V1OicUj?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qA8zUc9C3cMx4QAeYgBXmbEFfUX1nbzNaQZko+Y1giMYE5jY/IG5zjrigbkED8c7PT6T0ks6FRsswtKh3WPa+4lF/BKKkV2s0GEJrXvGAL0703ORGpFDwVPnW80NxSdGO26KRV7hr8ISBtTcWDLjYmYG1Hs46uYaNvfB/w1qAiuo3heg8kThnxrdlf1vZb3cWj5W9YxRK0Rj2nJWp02FRLgplTdyTKNI+qh2LgeJYP27k+ZN9AEBgYvn9Po6wAhQBUOME8DMQBU9YKiTNhsRChAmUM51/yDdISNsYEF7QXwc65SQnDHCaSdy1zGWtslj9FX7f8hM32kpHN2gmpYNb5OyMLRz3wSPaPc9cTO3IliBmksujU4UwyJP0dqo6FC0EZFxwq0LpeW9jaq2KsWdZ3DrLkQqiRto6Gev9YMKJc8OYuc8A+zCx/d84gWdo3lTHvIsBfsWU/AmVxA16nneFht50CwAnRLzRKY0HGp0kYNL3gynSf1bvBR/7vx6UNUr2PVDI0w2bIijGF+PoNzG7c/Rs94Cj8EINODGgTSD31YYAY2ZcZ3i1UeH7uEdhkAwx3Gzxn8GxzqrdkqR8OfxF52v5kMNSUtzux9kiygHOsw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee226e9-8454-4bcb-8141-08dcf816f53c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 12:41:06.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUO7S8lo5fPlFZmwTTfaz+XKWwfmZ0TxWfJaXdXALpaqNFoIcH55pI71JlKlsWnAxh8Jjc7jIztDGZ5EyCylP61ZmhpGY55/Z4JxOAx7Vn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=631 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290097
X-Proofpoint-GUID: EVSSSQWhtTH19V-3e3V3_hKrZ1w_dz85
X-Proofpoint-ORIG-GUID: EVSSSQWhtTH19V-3e3V3_hKrZ1w_dz85

On Tue, Oct 29, 2024 at 12:33:13PM +0000, Mark Brown wrote:
> On Mon, Oct 28, 2024 at 10:14:50PM +0000, Lorenzo Stoakes wrote:
>
> > It doesn't make sense to have shmem explicitly check this one arch-specific
> > case, it is arch-specific, so the arch should handle it. We know shmem is a
> > case in which we want to permit MTE, so simply check for this directly.
> >
> > This also fixes the issue with checking arch_validate_flags() early, which
> > would otherwise break mmap_region().
>
> The relevant tests all pass with this on today's pending-fixes.

Thanks, am respinning series now, will add your tag!

>
> Tested-by: Mark Brown <broonie@kernel.org>

