Return-Path: <linux-kernel+bounces-271070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465F894491D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BE31C21A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6E4183CAD;
	Thu,  1 Aug 2024 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m3uOx0Ni";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C+tOSijK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681A17B40A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507102; cv=fail; b=J/mWih5q4T/lOIm7nISV9sgR3z+KCl2KSvr3lf0R0CD35tFrVajgYCtFQcB4H+xSa0Z3QukqgXC/yzuXSciaQnu0ez6ah1eLSxHQslrRYRniyNrmLs2KOge58plyd/GxIQkIeXqvd78l0bXlGSiWO9LD3UGHIm4aD9/p/D5bd6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507102; c=relaxed/simple;
	bh=Mp6+YgdSE8hG0t6eCltvxdfazHN+nbGIpVFKFxb46Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MGAOttIZw2g0H/yfuQ2GSZHzFTTCYA58g7Y/GwCNlIh6rxgHtfbl2a5p0Nm9rr+/BiAedMAnk1LdsAiIfgdzVkKrwDZQ5oBJALnOjmDClB8CvLf9kEt8+lIQ5DTemRONAAxJMk+u0EqMEAuHTV0ZXeLDPftwgpTKd1rbI9j4c0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m3uOx0Ni; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C+tOSijK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717trwK024816;
	Thu, 1 Aug 2024 10:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ksnjACnoOTd9hs9
	CSYso2lzuyyH0inUmC99aJIruPNs=; b=m3uOx0Nip/48NTQ7bk6cAT2SuEziEFm
	zjNTbXV2zP0a6qVyt16KyTPbch3/VpAcvyew5qnIRgLw1HHQH1YeyboJ3xUvYQMo
	D1xYD6oijXG2bOoRQd3Heja1+DlraMZNg+ZaGYOboVGjmN3SpWhsSw4avsVClNKU
	1XZEaJmNYxASbpHMdwN6UkgLfYp1L/7jW6coZovak4Lmm2SHQO0l3pV6RAU3HRmh
	8vubbBC9TYkca566I1Fvnrn3CtoEoFWfG1bh6T1CtKVTCcyzOAl2fLLSpzzDM2rA
	unvfhBfHdDJ//fYcKHkSLZ7ECkwSpfhXJqieIG0U7tbcWmea34a5Shg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqacsdyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 10:11:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47196543003839;
	Thu, 1 Aug 2024 10:11:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4c2njvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 10:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pITmr6EmubkvkU0+RbFNIdZ/YT/yweCW61gsdWvIEj6UwSBacS2drHH+0tvug/f3lCfWMDIMcxaG181Mq2aVvMZHzVIQh2f+2ptnXe4ndKemXQSG7OxdhfxLPfirUFTOjGLfdMtXim6uYub1kI3n7mH9jttaA9rzd51OF0zuUSit8JA5+3o6lh0khRZ+eGPz7a1P4SCeLjcd23NBRvab/s29yfpvhb77oQAy/mgL4jHjmOholkDlRQZvpCV+YNwfQD+yU2fS6qeRp5P2QmESV70KCHdRzUY5KVCalcj+FkZI1nKW/kRZPnAFryF+KMxb8B6kBShhVRX1dkZL7pn9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksnjACnoOTd9hs9CSYso2lzuyyH0inUmC99aJIruPNs=;
 b=lP4wZG6HP9jTthFOBWXr6dM+e2qK7/+Tl+EyVRHTUEAn7bH3uQ/QtTNoPM88ab3zL6fy1Ytphd/ojzOiqfvDTy7SF1lDXlKlmIBXFvfQSNPbh9ooibKaOrYzGcpoFQp3qQjNkUZ0oYoa8K0t0aUn6aaBiuGSybZriHb9i114DJREVoqOibgoRyvKE2uyyh1UZdb4mEofTAH9FmvoTM9yEOslJdF++l+FCC9FrEhy6YDrVWMPnP/5fkJ7JWyWw0w3K1g6i4Y9dnyx222kuSfcUGkgVmEEQo4Q+30Dh4yIV1TgjdD5SfrzT8SEiOhh3AF4alBMD1tJHPicQ2a2A52GVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksnjACnoOTd9hs9CSYso2lzuyyH0inUmC99aJIruPNs=;
 b=C+tOSijKCYKKRGZglcSla1tW2P/w3JW0TSgYQCeHQPXNl2ImbPjwe+S2V4/wweKa7gwYi/8t4f0FMbqnDbKDjNUBbCx7GtxL3YKnZj+IBVacrd4erd/347tpzvoxN7O0cAS9UDVPL3GGt7M6GEBJhnNNf3SGXz6ZX+t9SxDUtvY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB5140.namprd10.prod.outlook.com (2603:10b6:208:320::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 10:11:13 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 10:11:13 +0000
Date: Thu, 1 Aug 2024 11:11:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Donet Tom <donettom@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 6/9] mm: Make hugetlb mappings go through
 mm_get_unmapped_area_vmflags
Message-ID: <3278a4ca-dfdb-461f-b5bc-50550326d04d@lucifer.local>
References: <20240729091018.2152-1-osalvador@suse.de>
 <20240729091018.2152-7-osalvador@suse.de>
 <8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
 <ZqpTaKHdrYt61HYy@localhost.localdomain>
 <354e4db4-e257-48a4-9e05-7f0595728ec6@lucifer.local>
 <ZqpgdBk-3Bcl3Mvr@localhost.localdomain>
 <47de87e4-47df-4024-a313-03cc14b8e248@lucifer.local>
 <ZqtD4idp0IyHgSp5@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqtD4idp0IyHgSp5@localhost.localdomain>
X-ClientProxiedBy: LO6P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: deb337d2-a375-41b1-de95-08dcb21245ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYKDmru8YpiuP27X2+8xxSQIf1Smt9lAaP9fGsGsJvQxdqiMAMKCs/pXIyJ7?=
 =?us-ascii?Q?XOU043nWjK0IgocqGZVfhywv0FagYQSH2HRdStiM5+KluZPb2nXWAFqAzXL+?=
 =?us-ascii?Q?TBROY1qy6TDi5KeMd8kv1PYRk3ojsVpyRaf+sZl/pPQuskxT09Od23RPjgRC?=
 =?us-ascii?Q?ewxEImuqC7oN5j9bQ/XnJUIs2p1G+gk2jGrvL/gPMM4VDbDnKyxkokbEZCTA?=
 =?us-ascii?Q?mJ4/XHcDQoUfuLY0weJkaguUioZ+ibj6vZEKXUffyiXfYnn0YOM/OdEO5mtx?=
 =?us-ascii?Q?dkY+EXmJHL5nwaTwsrHbpeHBfpUoo2Rikd1vp1P207NhcE7Cbm4cqrmu/CBy?=
 =?us-ascii?Q?qQJvVzpCxrMXGJQrcb/B+CpmTwpxd/MLsgW8d5M7Xmjmz3YGR6Pojte70mix?=
 =?us-ascii?Q?XW3BVKiij3aCmRMn2ypBcv+5E/Z4zW1CfzUGPR/8M5r8LcLtrZgcPypsSNmO?=
 =?us-ascii?Q?c4mjV2BA0GnsApNIDsYy2uU87fMcZUtmdkeThwVsA2Jt7NeOIAeInoClSck4?=
 =?us-ascii?Q?HiqRVoZ1JFsTRkaRKXBkzrbkVqj3bc7N4uDExmvN/tsR06jTd+bMmQdLK8SG?=
 =?us-ascii?Q?up6t1wTN6uQIKDV8dHd5yWZNW1DaKkXWGOhu/N7ZcHsyAyVtl6vG7XA5Wa5o?=
 =?us-ascii?Q?Vt+Z4tSGRdby1km3GeHSnPraOuwY1Fma+9BwMK0JkQYCHOgzkgGlq0IT+cnK?=
 =?us-ascii?Q?Hv6wRTvt/3zUSxFGBtzdJ3fs5sNYhER/ehD56RFHzLV/r3Z5Dm46BJbgLRQr?=
 =?us-ascii?Q?YaojN/VC4ftizPgRshXO0R8y4/iKwyJQVjaizko0Xyi/604xPIx5M7fw/zYj?=
 =?us-ascii?Q?VYvh/zsU5LWHEuIOvUIjttVW76JQiZri2J3P4KT3iX4UoCMnwmdY2jqx0Pj/?=
 =?us-ascii?Q?+C8QFD9dqZi/bRIygU3PKkM466YoQV9MLu5nMo+qGo1hFXKMOOdvsxJnHi9V?=
 =?us-ascii?Q?PYYeYoSBevec5FdQosqkvz7yPPn9FCA5TnRJU+jHn3fS76gICcUbqe/+OM4+?=
 =?us-ascii?Q?6wFrivx11/xMziijm7SHwx8tRPf2J1viHDXwj4wYAtpncxv0+GSTo9+U75iR?=
 =?us-ascii?Q?VPvsH93rWhVhhhzBA7uin2Ad1gMd8kICdxZmLbrguQwphOsau1PnL9A/eXjf?=
 =?us-ascii?Q?8nb+Ze1PHlRhxDKK1ce5KpjsDdPRtx8vnTWmSDw1dwfIeZLEO1Q2AFjPoYX/?=
 =?us-ascii?Q?53aL7Ez6JCTlVeGn/xbPtejYmHHa+CTtQ43pAKeofUiTkaoyfSixIz3K9OIA?=
 =?us-ascii?Q?4omn4QrSFSqzyYChHb692p5SCy73HPOiXy1VprrtN/dKJyGJAwU/tWdFpMXa?=
 =?us-ascii?Q?mHGPCkJnoSgOyv+z1yu/QIbXgZInV7VsUCsfnhRCWfue0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/UsiIWDuOqFr9j5eOWx9joqCV8F5b9Z4Ldv8TrCN0FhjhKtEhGKKs2Ay3Lw?=
 =?us-ascii?Q?dcWxpYBy4Y/Wi079snepXCT38+/Y/5u7j6xbxNvtonYluXeE+SkElf17H5+F?=
 =?us-ascii?Q?4tmBb6Y0NOYRZ3CSwIWrXAbHfLrIsDQgvfkjZ8/PDj/Fa4vjBA3KtTON5Qfo?=
 =?us-ascii?Q?00pY000N3E+IOcmzgHGNGfsbVdGylORUwZ8Ff5Odr7CpV6OkgHSnAdJ/WufI?=
 =?us-ascii?Q?HwzS0Ae/wuvGKNTxIamjNPjeLSG2GJ7SwZTecqqNRUT7G+sq+KJNYdeZJXOW?=
 =?us-ascii?Q?zflDzokiwH0CbDFenzdo9Na5xe9u/KFAqkKRhHPTdi8sBlk+2lD5ukjt5wor?=
 =?us-ascii?Q?WIumJE3IzBosEIqQ/atBoidd6pUMuq4l8pbQbI/dH2xA04gGqsNau/lksIk+?=
 =?us-ascii?Q?bqVU0PYQ+72PIZmgEwFiozfXz1XOxu/xGGhhmmVci4tyAXrS6Gt4zJfsnUVa?=
 =?us-ascii?Q?gZxcDpqP8es8W+JHkVtxrzEFd2GO+JiJe1b1iQZKODZmvIAcLa6Gye0UP+sG?=
 =?us-ascii?Q?rmSgjykvkN7i7Eo348+rnDHVIMUXt9lRjsFhm0UrOdi4bRWHH05Rn/lpP2+k?=
 =?us-ascii?Q?bMeiiozFwcX7kIS9nxyAg3Op8wENbRF2bFxI4kp9pqZmDvR1i5CrRih7MnFT?=
 =?us-ascii?Q?jF2dCs5kzNdvz7zD3X5XFfKAq+EODOA1hi+UiWK5ZdrJhTZHwmwJ8So+cOGI?=
 =?us-ascii?Q?BLrgcgosaHRogadkWUAKAN0BQPjCxfd49eZ3wbpYO7SN2inJ+GawM0MEXDq3?=
 =?us-ascii?Q?Oz6Vnn+o3moaaXwSt1/tgdXuJgDqIGjzZVofgVkMosTxI/S8jFzGvLffh/V5?=
 =?us-ascii?Q?L//4aiVvNG3KUpBbqVa4Zktnc2wk2BveNOwxhFua2Hqxc4abSVxxQg8e8IX3?=
 =?us-ascii?Q?1d1S8Ns/1LmlSAMEFxuOip1RNamwFNb14RmP1uvzlFUAJ/+S54JMdhLr/+Js?=
 =?us-ascii?Q?ruoquyzNAWUQ0BTngczPG2NsK9paLtBjXSY5CYGYV3SxHBxoPNcLDOeljQbE?=
 =?us-ascii?Q?p4Ne2tq+JVlD8nM7C/QjnG7aO3nvfOAnLWS/9nkQ+0w//cjEJC9aWB83VqbJ?=
 =?us-ascii?Q?F5eORBnwnd1/mu7JU2m2lumSHRzDIGCAv0mgkwa4SnCsPT3wKOwMAGC/hKSh?=
 =?us-ascii?Q?V2dbh9lPxNIKFN7WeRc0L+Uap5Ekq9Dt5EDmPdAEZMX9+1bofH7rAiD6zulK?=
 =?us-ascii?Q?XogcmnwYH5NEvmGg2A+Y1lZpsu4tRO9vYgSVqnD5BFtEmWoGLJfy7qo6SV9O?=
 =?us-ascii?Q?3KjudMUrVJPR2w8v7QCH3wyksz5OSqD74tcd8oWAQq+izZhhyrw1PdqTT1m4?=
 =?us-ascii?Q?Rv4IrSZZxJJYZvhXt/tZtwBUtIkYbok585v7ozsGGNet3SGlSf2wj305cXJC?=
 =?us-ascii?Q?+YgXxo5NkeEOOjSihLN5pXk5gSrScPIQ1Hk+ih+UhqofrTGKVRrzphIJO6GS?=
 =?us-ascii?Q?TwrONOR4YRi5OX60rjNW5Nl/zuFbFJWrtyrw1I4FGc6Vpd/xotHkZoNgl24Q?=
 =?us-ascii?Q?9SM2lNIhd4yhVmr6PrOM2fwQCUflHXA4ItyEKxO7auxhuR3f1kOaEsZebITe?=
 =?us-ascii?Q?JC5AtSm9liXdS5qqOGEC1pju/zOlhlkqg9ChUZFBIoFJDkqH8PfMAsWGkUrQ?=
 =?us-ascii?Q?GzUNSrfQV816vEhZ242tnbHrHUmcW4N9zYxTOCW4vRXpcfzJ8F42nBkflRje?=
 =?us-ascii?Q?+vMIPw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7rT/xxcMpTfuPBVhr7cT5GD/LCA3tC5mYuxGbOsbHnPqfF31CurLLhdAdlLGYfsg0ErZ9rJK4qkP2n+CxouWbOQm7oSUXcZEW6bDU/dbhf9384ypaMjnWmQX3jZji4pSoscVoh+S5zr79BQWNkbHK/YQvWEnuhda92PrVl5XhyrqlcEIvYavh1i1KIikPfHFDWR5hHtAJYmwaoRvB66AWTaNm6lE/1fxBEFxIdX0gFzGeCpODRHCUKAQVY0Y/sLNH9UX+R0V8rYoB++BDfhEEHXuALXAhGE0CORou7h0LpIU/rq0362SuF4Xrc/2VC4k6H7iSWoaWQxmgB5fFDgWPCVaYyT3P8C5q44mR2aZPW6VK/+9xrLToPho60y6aTga+kv0gHmfClZY5t9m3J7MWrpBpKqO2BN+kqZEsntpF/3xDEX7vFcF2fA08J95xrKFwwX2ukHR8gh0tOdBWDJweRrJcYyYrVcMXcu2311lY9fO1CLSTzW5FBVsyt4wjFmAtEwmjJ+Yy8aqxyDhi4J59eRpPHJmEHg3gHMBiDDpP7YzHlvVPgE+hAbfxzjc/vYHV+KdNxXH0MlyQJ2V+Bc2msS+MY+1vyv432gibqpgriw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb337d2-a375-41b1-de95-08dcb21245ce
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:11:13.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MJHKLYkptKYwtsCi2XLt14AKzdrOTsnHoiDNSbmxfCMIjTH8Z2rFXvrKH6XPF/1he7tTK7/VXx0r4b60Crx2AxHGc0kTeqn7JHNrnbiWFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_07,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010063
X-Proofpoint-ORIG-GUID: _90vBrj1XnyK0QdURVu-lAujGMmTQZ2D
X-Proofpoint-GUID: _90vBrj1XnyK0QdURVu-lAujGMmTQZ2D

On Thu, Aug 01, 2024 at 10:14:26AM GMT, Oscar Salvador wrote:
> On Wed, Jul 31, 2024 at 05:15:41PM +0100, Lorenzo Stoakes wrote:
> > I've not got the vm debug on in my build, so it's blowing up here for me:
> >
> > static unsigned long shm_get_unmapped_area(struct file *file,
> > 	unsigned long addr, unsigned long len, unsigned long pgoff,
> > 	unsigned long flags)
> > {
> > 	struct shm_file_data *sfd = shm_file_data(file);
> >
> > 	return sfd->file->f_op->get_unmapped_area(sfd->file, addr, len,
> > 						pgoff, flags);
> > }
> >
> > Notice that that doesn't check whether sfd->file->f_op->get_unmapped_area
> > is NULL.
>
> I see now, thanks.
>
> > So since you remove this from the f_ops, it causes a NULL pointer deref.
> ...
> > static const struct file_operations shm_file_operations = {
> > ..
> > 	.get_unmapped_area	= shm_get_unmapped_area,
> > ...
> > };
> >
> > Then this get_area() is invoked, which calls shm_get_unmapped_area(), which
> > calls f_op->get_unmapped_area() on your hugetlbfs_file_operations object
> > which you just deleted and it's NULL.
> >
> > This is why you have to be super careful here, there's clearly stuff out
> > there that assumes that this can't happen, which you need to track down.
> >
> > A quick grep however _suggests_ this might be the one landmine place. But
> > you need to find a smart way to deal with this.
>
> Probably, the most straightforward way to fix this is to instead of
> setting .get_unmapped_area to NULL for hugetlbfs_file_operations, would
> be to have it re-defined like:
>
>  .get_unmapped_area = mm_get_unmapped_area_vmflags

I prefer this at a glance.

>
> Which is what we call after this patchset.
> So no more things have to tweaked.
>
> On a more correct way, __maybe__ have something like:
>
>
>  diff --git a/ipc/shm.c b/ipc/shm.c
>  index 3e3071252dac..222dca8a3716 100644
>  --- a/ipc/shm.c
>  +++ b/ipc/shm.c
>  @@ -648,8 +648,11 @@ static unsigned long shm_get_unmapped_area(struct file *file,
>   {
>   	struct shm_file_data *sfd = shm_file_data(file);
>
>  -	return sfd->file->f_op->get_unmapped_area(sfd->file, addr, len,
>  +	if (sfd->file->f_op->get_unmapped_area)
>  +		return sfd->file->f_op->get_unmapped_area(sfd->file, addr, len,
>   						pgoff, flags);
>  +
>  +	return mm_get_unmapped_area_vmflags(sfd->file, addr, len, pgoff, flags);
>   }
>
>   static const struct file_operations shm_file_operations = {
>

I hate this to be honest, it's another 'we just have to remember to call an
arbitrary function' situation (why here and not elsewhere?) and
perpetuating the horrible if (hugetlb) { ... } approach to things.

I mean the shm code is _hateful_ anyway, but yeah I really really don't
like this.

I'd quite like us to add a check here for that function being NULL though,
I was mistaken in my previous reply saying we can't do anything here,
actually you can return an error, and so I'd prefer for us to return an
error in that case.

>
> Still unsure about which approach looks more correct though.

I think I've made my point of view clear fwiw at least ;)

>
> --
> Oscar Salvador
> SUSE Labs

