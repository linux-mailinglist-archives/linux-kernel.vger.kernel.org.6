Return-Path: <linux-kernel+bounces-430386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38EF9E303F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944D6281FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948C3207;
	Wed,  4 Dec 2024 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8PWrcRN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ebtFDAEq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C32F22
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270827; cv=fail; b=MWtv02jotp5hL+TJVWsQ6yDJ9g+AwzWc9MQoW8FMdY7czK1YVAnB+iej64feeS1fVIb/S9ZwO6/7m2g1OBqhU+Py6YPE2l/u8/+yviLnru9ULI0GXdWleGnt4JRsC3COo99oq04EHfVyr50YIPiaLrA2ZclvgkvNmAtW8CWJPy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270827; c=relaxed/simple;
	bh=6aRH7ehyP4QlSg/GsgvWAUFfEII6bX5HZm/xNft8TdQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=hY3DxSiGxn/q9ibbl5tHch6/n/8sAe8cI8TR6ObRoBW571v/re8H+dmc0IvPkcyO++nOqYCARg4GDFNOFchtSNVV5k0jYkYNJyDud8OK73ozbBQSJDSY/x8xvjxCm1CGFfNyi/8vtk1Nu16iqJaLGVFGXxJ0Gjudp2RbnwqQKEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G8PWrcRN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ebtFDAEq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3M3FJm029562;
	Wed, 4 Dec 2024 00:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6aRH7ehyP4QlSg/Gsg
	vWAUFfEII6bX5HZm/xNft8TdQ=; b=G8PWrcRN/8oAvy9SjnTZSKgab5h8TXJUR7
	UvHUVf0Rg8KhcMnxj/9Qv55yg/Hmy26KoIa1mvNHOYVbhTa4DoGD9gbFggwjT5jR
	JyNIqoCb+gZKy1Q2TeJ731DKorNkfklhPN0YpNgTc8ghvFe7Lni2HmQWZo2VRZZw
	IF2SxsNyGAGZEXC1GKmlRB4tsCDtv0dAcE6KEyFGAqPrePHweegdFJdjk/1JMvwf
	POXYozi11Ctcxy8JU8ERt5POQlRyGFaaytzdGcLKh3TCZX95pG015x9mSgtcdazg
	Yqjs4nw+diIOP5d3FccpizqhPszFNPKr3cNfU5ZjV1AlDlbuu99w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg27a21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 00:06:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3MOkgo038066;
	Wed, 4 Dec 2024 00:06:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s59518u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 00:06:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX18Xza77mNFcx0LTz+TuuVWWh4RbzK1BFcC2R5jBev+Kw/CRhatx4NAyk/CwXuSiv4HEmAJ72OGbpbjWHxoABJ7QyLobrpPFokcPCMAyD9HlP3rLD8JXRVwSNQBX5j4VsfEXpxTxG0xhlIFNPJaCQXpifg/yBTly7iPB4rFuEnr2xL4D1v451KElbEoXLnl3jYNQ7sNG1QxezKTBHpTlfOTCTiK8hT/HSx4A3e0TXcDCU/w8clR0cyiXFUQQKvAxXF3POEz1PdkdZ0rUHeD9kcOWKlzkEj2rJpDzhv149B/SAropGC8jas62YBHu0MFa9w/KtMG/6R/x2VWieiiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aRH7ehyP4QlSg/GsgvWAUFfEII6bX5HZm/xNft8TdQ=;
 b=bysVYPCoqlD+waz5BpLrTUM4cZ3JBrkxzPYhG8w3+NY3RzMMXOKXcrGrwKJnZpzVHZ6V47bm20791eolY5cQMPNxZWjgEdlC8ik5CWqAFLfmLY2cTP/pKI2vzMAoo3cv4oUpCFBekZw6VM8VTEn0CCcY2RR/CzHbGGbHFCOAIwA79Xtk9nO/OZIdHehIpjAN0ufaD2MqVg6XlwQ/VhU1jLRZVT6RKKG2IcirURQ4CGN6DPeavgVyH5KwFQHvHUPj6ifIPFjii1Jz3wWdnwtg2oqUUnOy3lw0KWYbM9aJ+BQ+DRACr74PeR+hZjr1w/hJfXPqRng29inEKqn60fWdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aRH7ehyP4QlSg/GsgvWAUFfEII6bX5HZm/xNft8TdQ=;
 b=ebtFDAEqcGcfjB2y6ird/KrO3AW/g5yomIwjS8CmCqzHjUZe3ucsJPYImxKdWWJO4vrahJDstiaInkDb8ZD8J4GBADbPOKroqg1cJhdR/T44sIHMaTx+LGh88fZV3IZntqV5KrpwIo6ErlE++4tICTioX/uY/6+c3FOOnbq2za8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Wed, 4 Dec
 2024 00:06:42 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 00:06:42 +0000
References: <20241202202058.3249628-1-fvdl@google.com>
 <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <4d5c9ad7-6898-4f14-8974-126306e62db7@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Frank van der Linden
 <fvdl@google.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Muchun
 Song <muchun.song@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>, Oscar
 Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, Peter
 Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, Ankur Arora
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
In-reply-to: <4d5c9ad7-6898-4f14-8974-126306e62db7@oracle.com>
Date: Tue, 03 Dec 2024 16:06:41 -0800
Message-ID: <87iks0cnvy.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: e19bfbc4-b1cd-4a36-4c64-08dd13f788aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BxoRdVxh82XLcI/1opgwxDe5whM5tusUAlUT4RCUHqwK8ZaxgzPLKAJjPrXC?=
 =?us-ascii?Q?+RqxbuulpdVwFrRYLsxPZUAxMn1j7Qgqsq6XvV0A12Vgqj5kC7QyS2slgMXx?=
 =?us-ascii?Q?JFUIjNrAWr40UwsCkrm01kFyWPXJHq2BLVdZNH318OWBdvyYUtG0zLmZO/Ri?=
 =?us-ascii?Q?JsFThyionEiZywboo03Br/vimUkkERlsnga6LRaJPxuEm73XmlIkzbCUs0Ql?=
 =?us-ascii?Q?K98cu5NbthMc2Idr8Od4CaBvV9AnjUrFIYrBzgK3zMMhYUTeKpPg8Iev/Mci?=
 =?us-ascii?Q?XoyD5PnvaLl+6ctYgUzQUFzZTTYB/VOwgH4KPSZkRMryPK51DsDugQM8uirR?=
 =?us-ascii?Q?7lEKQsiWp+20l/WwConUO3DuOsmwka3R1yzA+ta2+4QvNKc/j5K4kwkEON7w?=
 =?us-ascii?Q?qNZuhOm2QvQ2AWETNrVAULfQTq2JzMHX0D+tlb3nNxnpy3ufXe3kHgsvo1Fc?=
 =?us-ascii?Q?/6rkPRHBPOU0pdY2pMKEET4Sa/jVTTCzndSMgHGOA4TljGIe5dtUFijhIpg2?=
 =?us-ascii?Q?Fu8qGWuqQwE5CEonfqlKTgpeBUkbF3O5BoFjpdIlO57iJP6fZlK+XwP38XSX?=
 =?us-ascii?Q?OEUZxQFV2t3xWSjBuvMeZ7CsMB6jukykqY9GCQnj4U/Zg5mzUvAJnheVdroV?=
 =?us-ascii?Q?gXUYnqyoJ8/q1exstXd2/UrhfC9yGc1edTTO0xP+4SJ9oNHzYrdVhz/SaIXt?=
 =?us-ascii?Q?s3jgYt8oUDxJt+376bq8TqtOmp6o/tvmb7bxb8O/jcuoqjOJ6QEoKd+Q7Fho?=
 =?us-ascii?Q?8doxYEDwZxjYWoDa/YBf+bUjqS04lNqXqu7Py1PYe/AmrFLzn0CikQnYhJ9m?=
 =?us-ascii?Q?RxooE2pzF3CP5LI5v6GrH9349vqKkJtdyekasOY2pAqBSVi20ZZNOiidhXDn?=
 =?us-ascii?Q?59droOYBGzYe36i9Lea/k0ySuf5byD2UuTTTZhNcu+5e2pdKHmZjLwHnLaQr?=
 =?us-ascii?Q?g3mE2b0r8t8ehMq98cECM6Q/+uD+iNpDAeA/nCYzavPbmGXMg2hPG/8QD2C3?=
 =?us-ascii?Q?tYsrvxok91QDqecbJDJ1v0sreSmoWP+yZrO8L1crN4AWTb6fh8VOo03vQail?=
 =?us-ascii?Q?ztaZyq4jp2H1z3e49cFpoCp0mx1zjKVh4xwughML+Ix1g1VPBKC92QNrobVR?=
 =?us-ascii?Q?WoCyCHtqrlA9wIxEX+AOjHPLD3QyMhrkY0mNRjORAqPT8e8p2Uy4D+Nu6tKf?=
 =?us-ascii?Q?WqqEJKCUU8Nb60S52L0jL/CeO6pB5nP59Q7BkzlkkMjZ4nPJXOP2/OUr+KKn?=
 =?us-ascii?Q?wxynEL3wQe6abZCASRYUAVMXfVnEbb6Lu/OLIfFkvdMUQnyTkkt7gNA9Vm4Z?=
 =?us-ascii?Q?hERBInPowSilba0ClNjjWM78eOPaS1dTyyU0ghJAryO9TkzAhomz7hyQi2I0?=
 =?us-ascii?Q?AlIv1ow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pdGh+sc5tBtrtS6v4SFjQ6WAo0XMj6hQvF94Gw0MpCRbuwlvhuQVXUOFUBVB?=
 =?us-ascii?Q?FDhrqbJ5OwYyqhqZ8kaVxCGhTNvRtCEdj1g+JBKRE+nIPOYiSHIn09TGgRsG?=
 =?us-ascii?Q?joN48Q15bI9S+nMK9HsNb2A8FhDVcWchfzKYzcfOu3Sg+iL35nps/5edbhLg?=
 =?us-ascii?Q?fbZwIqgw7D7BztebSJKc/m1Vqk42Cv3abj7r1nru++eqaRZWzxLodQTC6N6x?=
 =?us-ascii?Q?tvlPliRh5RTryns1RvSAAlPljKLl/toTfntD1gl2vbSGQDWPda6hiJjO2422?=
 =?us-ascii?Q?jKnm4841TbqGR2VVr7/4N4ZcptFHltbEzsZWDvcctjaYMWCUiQqMsW0/9Q7K?=
 =?us-ascii?Q?40btHkDmnLSHixKtw2/XO48SeBXrsFfz73iVFb+cl4GM+qVQbDEnlt+pEH30?=
 =?us-ascii?Q?NhiHSqZ/n31PNB5Rl71vgQt72csBVxk+fAScUn0D4gkLnw1AthhuzVqyzwTF?=
 =?us-ascii?Q?EY2LIkkv9OdUN3XH2IItbP5utMn37FTNoJOcueiowrIcQ4y9q7ZlVxwFO6bS?=
 =?us-ascii?Q?6i0l+bjw/Q0K0YEYaJ0ruDbmf6UAQIbPAe/fUoCH17BdU24uTX0mXFQwj0iK?=
 =?us-ascii?Q?IAoN39qMg8l5L0hxHcgqKAqCKSw3FzUbKswlR8PFL4/ps+JHMgOjgdiWjEL7?=
 =?us-ascii?Q?T9/uSNOczzTDYsX21zg+QCrqWsqO9y+no5I0ifIemnO3nf4KEaFHVRia0bOr?=
 =?us-ascii?Q?N4l6+PzkBPEixHp7g/m6/C1+rJMoN7aN2ES3mAvovyKTFlAUGLI37Jgphhkg?=
 =?us-ascii?Q?yNzwHCH5bXBmcVq2Ik17fMex3x5kvO47kNP9tICSbNFyuIerQ9gXgkh2zcc1?=
 =?us-ascii?Q?6hHnooeGQPRRch7s+y342Nj8Wer59AxQonhp34AAuOyldlnVfq8UVQrMOulA?=
 =?us-ascii?Q?w4a5xRftvpy8aZZKYWrSnh0wqhktsdCYHM0R0vrTwufXEPF7lkHSCdzS+RBv?=
 =?us-ascii?Q?MP9mW3pUgwtuWdlPVpYFGJ/rcRSkMO5r8/m7Tlg3yp8c4ZyFDB4J6cJW/f8P?=
 =?us-ascii?Q?MrB3UzrzI+SQqQD7ndd97Cg202PirivQxutfDuhI3iig5vg+Ikyc7rdt3q1y?=
 =?us-ascii?Q?cF+j2y2ymcHQOq1nYxvtu9LUkvcflKQEaJLY5naaZ++IAakQVQX7HqRM3wjY?=
 =?us-ascii?Q?OMbhBxlsfQqt0EoFX9CLSjTf9GZ0Bo7scdcMkA/Na6rozZOHvLRC0S/aWl3q?=
 =?us-ascii?Q?olJT6pOTly12/JYSFrylRx0imOhr8LNwF9QQup3ZtQcc8w8jqN1zm4aI6kCL?=
 =?us-ascii?Q?O2OL7zjuq7dvqrWmRXJs+W293pfn1zRunxe7X+nBTYXTmAOyuMMiqmA5NLow?=
 =?us-ascii?Q?AvZ6QrCNQbmJQCIjfnpHkndNDBlMjXEJ9rvu/Et2S/v9UhKH8NUgSLx0PZNl?=
 =?us-ascii?Q?C8X9ZOiCvD+4x+69gUlfgg894GR2TTBhBxyikcm6M0dKlEn0xl25IDO8FSbc?=
 =?us-ascii?Q?c6S3YMxYuJYSfBRGz3hK2kJ91ufsEyOobFhtgWlyf8wXsCLwQW/jAoU+XfHG?=
 =?us-ascii?Q?KxvPEUxrkUB+eEwGNtI1xwaBQ6QdaL/nGimkRedOZPP7Jmhg5/pbPbcl07AG?=
 =?us-ascii?Q?3KPPPTBMA27mDqnQjPyElC/fIDGXhVRbOKQ4LM/i3TcuJ7giISmjV7aKtz3M?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N3jevheu5I391wOqvfWrhEOnTPgx1/gzAvAQ679iq+KgwK8JcDX28RN5jLKMwImqrZJ0u87HYiTbzy9YTrEMcnAqJ6c2L4H67Z9E/FGaK4oSN4qZqqu8gDrgz909+JOOW8E2Jeb6lQecQ6NRboRSnMK6/2na2Bdun9k0iO05qQbn8yFt5dFsWlp1TdgTXcQlNdVcWXgn03nhU+pNynUnDxq0U0UNvffbwfFWoTQsBrzKXEwIkW9ZxbNip3YE1Bvdf5Rc4uX4F1ZlRauiqr1WF/HMBjQof8shPBv6LLHdF4M+GH0UScmCZy0Kd3fxk4u0wAxn/lIkmE6KBpH/cLgDDENkk0WIwfp2jEBtvI6mwFz2EpYxbK6xzGBY4b3eCKzLUQsHdQ2N9uUjz3zr+LeUU/xSLuyqPLXkKim6nI/2VNr6pQueqmCxgV5ClKs98lkemWzkW5/0x+y8eKiX8SpRIWN/ctNOVqjje+W5t8kvzbrrley/3YOPh6xOF6P+z7k1Q+i4Jb5358uNtnl5pR3xeL+ikrgBHuSHzSbYPsNP7CMD5iDSUZfUtdvz/uwnFXuTQujkkhwkxdxht7qcG8OsPB5vPsEG+92BCtGFhJ44IZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19bfbc4-b1cd-4a36-4c64-08dd13f788aa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 00:06:42.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyHzPi/oNY5FzKc69ymyETSW6ubCUqe3XD4iAZL8s01GYxr/Itf4zoOWITMvj8apY8jMDU6V5iJjTN0E04APRGCklz5UUIkU5+clU++Cl6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_12,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=807 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030199
X-Proofpoint-ORIG-GUID: pHFu8moeuqQqdcL-ErVJlT-_HwIBGVu6
X-Proofpoint-GUID: pHFu8moeuqQqdcL-ErVJlT-_HwIBGVu6


Joao Martins <joao.m.martins@oracle.com> writes:

> On 02/12/2024 21:58, Mateusz Guzik wrote:
>> On Mon, Dec 02, 2024 at 08:20:58PM +0000, Frank van der Linden wrote:
>>> Fresh hugetlb pages are zeroed out when they are faulted in,
>>> just like with all other page types. This can take up a good
>>> amount of time for larger page sizes (e.g. around 40
>>> milliseconds for a 1G page on a recent AMD-based system).
>>>
>>> This normally isn't a problem, since hugetlb pages are typically
>>> mapped by the application for a long time, and the initial
>>> delay when touching them isn't much of an issue.
>>>
>>> However, there are some use cases where a large number of hugetlb
>>> pages are touched when an application (such as a VM backed by these
>>> pages) starts. For 256 1G pages and 40ms per page, this would take
>>> 10 seconds, a noticeable delay.
>>
>> The current huge page zeroing code is not that great to begin with.
>>
>> There was a patchset posted some time ago to remedy at least some of it:
>> https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@oracle.com/
>>
>> but it apparently fell through the cracks.
>>
>
> It didn't fell through the cracks for sure
>
> Just had a detour into preempt=auto before resuming the main work. But that
> seems to be done in the last merge window with the lazy preempt stuff. I think
> Ankur was planning on following that series above soon-ish.
>
> Adding him here, such that he keeps me honest :)

Thanks for Ccing Joao.

--
ankur

