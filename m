Return-Path: <linux-kernel+bounces-351693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E009C9914D9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC221F2375E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 06:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7F436B17;
	Sat,  5 Oct 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JY3ZVYn9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WuLjE38p"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C2231C95
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728109292; cv=fail; b=gBK0OYQAL/WwBMY4y1Jd3j92Y1x1SF5hQ2D3G1E7mnWduyAGFuKeJl807zDC8PFj3ksU07e9lk6MJ/QcEbM0iZwIg9S82ctKLDh64Brg7gau6t4RGFf5CNOHfivaPRXGlVjirI7Dc3iM224xpNhOtkhXxmybj4IZi3lGkJzWOUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728109292; c=relaxed/simple;
	bh=QAl2DKBl+57C8k+LTKC3fhr0zDdEhOFMq88vIyqCwsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YO2u+1rK0I08O/rHAxt+p0BrGw1FsimgNweRq+OL5nt4hFsPg5MJxaVeYeZO80qm47KjdIFiP2FBbajIPFPzrjNwS/NAzcdEEewfqN0+O2j0F7OL/Xbq1N5nDGFDegSX7Q6r/YjZM33M6/1i4HVtURxXl7KcuAeOIt4NAnNY+wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JY3ZVYn9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WuLjE38p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4956ECIt012492;
	Sat, 5 Oct 2024 06:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dEe2o2y4eLlNPgyVrx
	OH0csRhrMd/gVpXf31V+XBWDI=; b=JY3ZVYn91Wz0l3fUElHUV+nD7GmBeXbTuN
	fgN/bsKZ+2+rtGfnHkVzglKQbAcZBXrBkhYMaPxy3xkkKd+oNGc1IfwNmizHKCF4
	VLOu1YL8is1cPJeyMparwjbx1puNgzf0nf62OaXHneR4EoeXJ0W/2YGEL731Ovdv
	UM6jp8mB5PTjjCmnI7u6gFUg2665thm/9Nu82bMAcPmEjzhM97UvvR+f32h9OR9I
	Cv7BfCINwGmc1sobO4Sx2frKGac6m8zwDIL8hS3D7n31yzRgnvKR/Td5m+pJkF7t
	AA/UsYSSReSzXfQspUR73fIIyzLHd5Uuba9r4xPWlrGJcJOAOFcQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300dr050-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 06:21:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49561Pdw004624;
	Sat, 5 Oct 2024 06:21:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw443wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 06:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTly135m+cutKZ+cJ+bcCd8g11TjCsg5pfTaXpqhznyuvBGMJhsefuT2ootSuYimJgyxt0MsA512ZCeb7oHdG1x9JB3fA1AMhFdK1QPfwF+McKNaxgVrN1yxi9npvqTNbHoHsiTdts+HpJpPXmnhdoEF8JxgZrO905IULzXLW2FpMzLmvHY/fRIu7nUCz5fvcOSJgWtRmjP4fKVKRFIpGcm53xfDgJmw3LtyvGOIt5vd23ZAkzUbI2+6TMHr+5MdcbOMOb1Qv8ZJNVpW03PrlU/l6OtTWiiIxW68487HNDutStWhpUShMspqqFTOvE+zF40rWWYeTVP9A7X7drim0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEe2o2y4eLlNPgyVrxOH0csRhrMd/gVpXf31V+XBWDI=;
 b=tOmheO/LckHIhawfMqA8F925VghHXLxjCGC7sAOclta2ULhB6JDPyKQZaCSmRv+Q/eSSY4UriZBfML0sba9yaXVsx4lybxQMkmvamzdX9z0dG6nCuhhoe1m1+YlSle//UhTQ25X8mZp1TyGQPueUdtr8kJzayVKdeVNeuuPVJs2uFg8ruOPWucAXjhZH6FhfN4dHj7RvyBvDCwmf90u8gpUS4gZGA0DkmYpKRqqUL06e/nL/huLL+NMiPo0+J62bfXyNpgxmwardmmWFn/aY2iLmSp4o7gUFj25KdLs/sc5W5l0KCFaQyiiqTmxz17u0kDZkj/zQp2o2+OblG6LblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEe2o2y4eLlNPgyVrxOH0csRhrMd/gVpXf31V+XBWDI=;
 b=WuLjE38ptQujDFsJsCQ327qM9ybAvyROYl6qlE7djTmWWw/Mvqna3U3Zc1VI79LsR9K65S7L4l5cLZAsBA6MW3JCwNioyQDOLZce7B9pf0IBWfy9bFfJtVLeZb6CegovIB40xtX4/oKwTeFRh0/bYvrnbBn94mUlYMVTWr0b7wY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7502.namprd10.prod.outlook.com (2603:10b6:610:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 06:21:21 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 06:21:21 +0000
Date: Sat, 5 Oct 2024 07:21:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, spassowlf@web.de
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <9e1f326d-7740-4f4c-baf5-45f9eae0048d@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
 <3b83746d-b73e-4b89-9b74-5aba5a827f45@lucifer.local>
 <088a3541b85b783ef68337bd4bb790d62f200dfa.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <088a3541b85b783ef68337bd4bb790d62f200dfa.camel@web.de>
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de86c0c-494f-45bc-17a8-08dce505ee2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qe1cfOJgQho3H3IvCoHy9R8J0bvFZuqr8VTT8gl6XiY8vAOXrmxx7WX/AFu6?=
 =?us-ascii?Q?E8nZuMzuXtGYMxuQUf5MOhOHK8bp9opKxC0yS7GAr/xZBVEEldmYly4ZLmKY?=
 =?us-ascii?Q?n62pKdrAU62KEBJdX2Naw5WFPlmvz5IuNPzmka8Ds0M0nuIXl+twr+m7lEqB?=
 =?us-ascii?Q?245J7jDaBFN+bhF6QAISSZ4xSxb876OWEpMKHFQf5g8fIi/F3TVmTvb74X+i?=
 =?us-ascii?Q?3rcGAKPJFGYDIxi3bhy4ly4jDBtGxfABT3DHqiv03hxnnuTQs7+sYRLXJDjy?=
 =?us-ascii?Q?+AG5/gEkXwUwHjePoeSkGXa4rwi/YFKUU1KZaZcZy7tR3Xgah2SMj7f72/c+?=
 =?us-ascii?Q?xyEdkx+QhOQTagCxcZ8arJ9rYH4jLxUYJN7SqcHeJSSda/XRwClcjtBtFGSE?=
 =?us-ascii?Q?BdHW85Nx0KebgPC2RJfS2tOrwgaCoBgWs1UxHnKeuq8frQAY2v5nlxOGjR0F?=
 =?us-ascii?Q?IMepwnZKzGWlZGSXXWLfR0798JgTv7iH3QPIXoJDofI/ZF9CZvmKeug4zFDC?=
 =?us-ascii?Q?qVEe+oICGSVHT5foF02PW8paBB7gdSjiMH64oegXCrTU3mFy107ivo5A5GtO?=
 =?us-ascii?Q?uv2SLd/YeBviXqUP9Y5VTF0jgK9dFXydheZ/lg4SVRqe+/cMvWJi4id6EgPG?=
 =?us-ascii?Q?APB6bQanR9w1ph6qBxZhkF89Ue4fW14/20vZkTnpUvdbSssknOaPyPSDRp9r?=
 =?us-ascii?Q?Idvvt5IZww4CbdBHxfS/NSHmBsDRVoRJqC3qwtmmgF/Hmibx0a6OPrUqeHZh?=
 =?us-ascii?Q?y57Z0hxHdwhh2q+l3ELb0ULxdQCetW/ZBFxgLH5mQB+zMeRwziNKGhBduGQN?=
 =?us-ascii?Q?B8VLTDaBSKtSJz97kLg4pSj3mEsQPGWKbaDlEzMgGd0wOhSdKeazcoRsGwzd?=
 =?us-ascii?Q?ElNnHgsTSENy7Oh8JLb3ityt5/ZLLMsaEwsLoHdk2F4XWGBz0fLKRX1Tt5ih?=
 =?us-ascii?Q?sF/f7sMUAe+2o+UkNWRMN/A9pKrGzxT3OmP4IDv5NXlocISBK3T921T0hUlp?=
 =?us-ascii?Q?OIE2ommfMXqEgZmsk6EHMfD97mEM0SR+sTWq6dCQemPdibxX5Nm2CLCNDksF?=
 =?us-ascii?Q?yEVGzDvz27QPdIRHuZTJGgbGaKvStYdlPej2+Xw+r06JaNmyY0bHFBweNUCq?=
 =?us-ascii?Q?1ZHnL7EbwK5mLjrIN3e3QUcf4GbB8QJdtfTYke6/Nni7M2pNjyqNnF67zEXl?=
 =?us-ascii?Q?0RxAixyQT9VOOFVFO/6mymDDKZzDpJuq0FHQrVPJ1RL5xdK6SxIk8ZKcOkAL?=
 =?us-ascii?Q?GJ4GKXnIq4C8jlQ/TNhYqWjp7YjLXRSWHnOj/iYOzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ztVbJwzrLJBFQ6TPsoxzSQx2oBAJCjDeVfr331LWaGoNlfFTaQa5W811ADQc?=
 =?us-ascii?Q?B2R6+u6sf4ab6NCY7arNc/XQXIX6uU9gMIrDBeFhjxZuzYVEq1MzUD3WBmjW?=
 =?us-ascii?Q?EkE74w3/rLf2jFE9XUjEYEqdNWEcn243ZGhh0Qy8x8kLHuhFZyory6s7yeIb?=
 =?us-ascii?Q?faJChS7MOv4/wvN9cSIslhlMBRHE4TqZxtaa/shAabZtiyfXDFFl8qZybzQC?=
 =?us-ascii?Q?zAdIvXU91Ah5bDKda7r+f4+oNyfxCIILN3eeihAzfU7B0piYDYdJJhfBX4GP?=
 =?us-ascii?Q?WF1LmqaUYslRdWsHj5tP32Uu0rmyKoeU+6+ghZhF/D9bBF+XpCcpl519dHDv?=
 =?us-ascii?Q?vtylEdwdPTDwFZ0nJVGdz19V+HbzhNi+o+1msnmw8dbh8fEYfROl11t1P/KL?=
 =?us-ascii?Q?RF2o1asuxSnjwTSvrOzTXpBf2H29QkLv+1IbZWvnniKFpNWY8d+yXr3GZuTs?=
 =?us-ascii?Q?lPhRu8wpArFckgIRwJeqlmKZUFkDsxaWuejD3Gu0IDz9CWeGs/ylo7IsBqO9?=
 =?us-ascii?Q?o4R+eN+VSOJZm0exlWrkHxN2pP4LukFioVGCbiQl7mmR3cBep7/uYfxOxtxr?=
 =?us-ascii?Q?Ztmqs1NQGFMK0Eq5nqeoQz+GUejyku4NqlY3dwESx7dUZ0v4NHHhJvhoFoOk?=
 =?us-ascii?Q?btlVqwThB3ky/gmOXsA92aLJgG2XGqX+BMtM+uSeep89uo1bMRyMr5Nk8YnK?=
 =?us-ascii?Q?hlQZcnE9IYLLnFZTjkG7lbywc/pe3UpN3+2lbjqpxkdXuN1KE3Jd/IypszPF?=
 =?us-ascii?Q?YjNlGIvzB5VO+v6dtBQK4j5ibwNovAJ++AyWtnKul4eK4kv5LssMAYTARgDx?=
 =?us-ascii?Q?ty8FIVwJsxb7otrGyJ080C399Q3/sbZ4U9QrNseep1L1yJCeIypjKdv9PbJT?=
 =?us-ascii?Q?xMI/UHgOFZH3YzCbEVLvveOrNVdvesB7nT8nfVSCzTWXl9k50zJicl5yvcc/?=
 =?us-ascii?Q?Ud8Z3MNbSXukhYb81M/ngoKZRDV31/nJuYt5oPEM9a8Ttxv3anyhYKsVNcZ0?=
 =?us-ascii?Q?HjdsWG6ExGzV5RrA8oOlGdXMTQ2GLXWwD94PvKGxvWqYmvT8har/ywliJoCM?=
 =?us-ascii?Q?oau4xPS6medtUAE9ibr2cspbNlViBONwAXHuGCsnB924qnpx0mKPHbWr/OSU?=
 =?us-ascii?Q?9ykDgFpXf0BiYD0XLwH1fcMJncuAnv+omWIRGSxy+jHJUuE9E8kdCQKhPLsm?=
 =?us-ascii?Q?1kW1n9mlHSrI8VPiW8gZtSTi+/WPTuxmKCLA6SbnqQ8Sn0mjUz8tFiy3rxD6?=
 =?us-ascii?Q?coFMjz3v/vJwsmsU8VRByOD5buqq78U+pPP+LT34kfUWXkeTmhQUJSiUIdHc?=
 =?us-ascii?Q?kUifyZHTnDcp6LytFjb6lYos1p3Xb4FZkAkDofvTIuMTjFc4u1Os4yRzRkJn?=
 =?us-ascii?Q?jAEBHCDVI/Tsmf0O5HWXsYxsJjOI9ncBIh4Z59QzNuVJCBhrU2CdY30uQlpE?=
 =?us-ascii?Q?hTinSwA3qW7MkOBQlr2SmLs2qzYuvrW5BCXLmw5BoavM3V3xNES80oWLZard?=
 =?us-ascii?Q?ObGFyNjSU+ghzRZ76cemDJzYmkGmTaksNG09AkRUGT5LhsYOjSxSfeADi37H?=
 =?us-ascii?Q?SB+XCGMnQdWOQderm4KbAIokoDldZAcXjCB0TVrg51bovtW6xurYKWJ8K2KY?=
 =?us-ascii?Q?2536uBybzIiZAgVg3d+x2hvACwABNUPiRtiNJfshBEKRfNIeY0bc04keAuI1?=
 =?us-ascii?Q?M/weDQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JmfZBJxHakpjP8kYbQL0LGpcR+Kdb6iVXht7Wif/X8jB+QIV7tfZSBJR0gSQIG2adAi5lN80bds12CGePchA1GsHn8rd4BohQaxjsVNE/LHc1YHuYAr6K08Airlr2LSH2H6StSOAdHxH5ucazp65TPxwzHc3tZ4rCJpquuTWi5n/vB34cg0acB0HFT1R5BgE2u+SsMRoydkXclpNsB3lz/Q9WDc9NSmSDiEGThGXaOnGbsDPAeOWBBQC7YKaMapj31jdVwbFzOQqip+tdbljREo4QIaMJY/2HhFmEQpmQMI9XjSr2SwO/n3luGkmtW1hujq9AYsHg3uWfzCLIezEnxZrEGI3Scn7/t8x2TFPa974HjqaE1FVe1h2Ia29/shVEdOjGBggYOXl1O0B1UYhiPjrBvpYDuo97N6LksOidtiAyq53njrUkSumbYWXO+Ire/4Z32Uq+KhyrATc6y0O+dMvcwtoFlr6jcFuUJdfGO7YRUYyXH4QuN/6lvK5QBEf3aACJoN8ylHcc1zJ5r7SpZOHJ8iZJbAMGT++B7gJaoHuqT99h4++1W3LbyNMeMeh0wXU6pIGDsBLzjZFIoGoVJO54HUHkdBiz9QlsqEJUuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de86c0c-494f-45bc-17a8-08dce505ee2a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 06:21:21.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmMmMvE4kpGhV1Zx/Dj+aMWvVfY0S/DpPte69PzhIoUbzgpwhHd8Ai4rx2HOycT0Uo4xqZ6qS91qgYEh4TrLDb9hL2JzWZbGFL5cZR6VtMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_04,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410050044
X-Proofpoint-GUID: OCCFjYy8vwKHvK5bb6zbToITr0sgQIQF
X-Proofpoint-ORIG-GUID: OCCFjYy8vwKHvK5bb6zbToITr0sgQIQF

On Sat, Oct 05, 2024 at 02:56:01AM +0200, Bert Karwatzki wrote:
> Am Freitag, dem 04.10.2024 um 23:41 +0100 schrieb Lorenzo Stoakes:
> > On Fri, Oct 04, 2024 at 11:35:44AM +0200, Bert Karwatzki wrote:
> > > Here's the log procduced by this kernel:
> > >
> > > c9e7f76815d3 (HEAD -> maple_tree_debug_4) hack: set of info stuff v5
> > > 7e3bb072761a mm: correct error handling in mmap_region()
> > > 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
> > >
> > > Again it took two attempts to trigger the bug.
> > >
> > > Bert Karwatzki
> > >
> >
> > Sending an updated, cleaned up version of the patch with a lot of
> > explanation. This is functionally identical to the v3 fix I already sent so
> > you can try that or this to confirm it resolves your issue.
> >
> > If you are able to do so, I can submit this to upstream for a hotfix. If
> > not, well then back to the drawing board and I'd be very shocked :)
> >
> > I have been able to reproduce the issue locally in our userland testing
> > suite entirely consistently, and this patch resolves the issue and also
> > continues to pass all maple tree unit tests.
> >
> > Again thank you so much for all your help - I hope you are able to find a
> > spare moment to quickly give this one a try and confirm whether it does
> > indeed address the problem you've reported.
> >
> > Thanks, Lorenzo
> >
> > ----8<----
> > From 126d65bd9839cd3ec941007872b357e27fd56066 Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Fri, 4 Oct 2024 15:18:58 +0100
> > Subject: [PATCH] maple_tree: correct tree corruption on spanning store
> >
> > Writing a data range into a maple tree may involve overwriting a number of
> > existing entries that span across more than one node. Doing so invokes a
> > 'spanning' store.
> >
> > Performing a spanning store across two leaf nodes in a maple tree in which
> > entries are overwritten is achieved by first initialising a 'big' node,
> > which will store the coalesced entries between the two nodes comprising
> > entries prior to the newly stored entry, the newly stored entry, and
> > subsequent entries.
> >
> > This 'big node' is then merged back into the tree and the tree is
> > rebalanced, replacing the entries across the spanned nodes with those
> > contained in the big node.
> >
> > The operation is performed in mas_wr_spanning_store() which starts by
> > establishing two maple tree state objects ('mas' objects) on the left of
> > the range and on the right (l_mas and r_mas respectively).
> >
> > l_mas traverses to the beginning of the range to be stored in order to copy
> > the data BEFORE the requested store into the big node.
> >
> > We then insert our new entry immediately afterwards (both the left copy and
> > the storing of the new entry are combined and performed by
> > mas_store_b_node()).
> >
> > r_mas traverses to the populated slot immediately after, in order to copy
> > the data AFTER the requested store into the big node.
> >
> > This copy of the right-hand node is performed by mas_mab_cp() as long as
> > r_mas indicates that there's data to copy, i.e. r_mas.offset <= r_mas.end.
> >
> > We traverse r_mas to this position in mas_wr_node_walk() using a simple
> > loop:
> >
> > 	while (offset < count && mas->index > wr_mas->pivots[offset])
> > 		offset++;
> >
> > Note here that count is determined to be the (inclusive) index of the last
> > node containing data in the node as determined by ma_data_end().
> >
> > This means that even in searching for mas->index, which will have been set
> > to one plus the end of the target range in order to traverse to the next
> > slot in mas_wr_spanning_store(), we will terminate the iteration at the end
> > of the node range even if this condition is not met due to the offset <
> > count condition.
> >
> > The fact this right hand node contains the end of the range being stored is
> > why we are traversing it, and this loop is why we appear to discover a
> > viable range within the right node to copy to the big one.
> >
> > However, if the node that r_mas traverses contains a pivot EQUAL to the end
> > of the range being stored, and this is the LAST pivot contained within the
> > node, something unexpected happens:
> >
> > 1. The l_mas traversal copy and insertion of the new entry in the big node
> >    is performed via mas_store_b_node() correctly.
> >
> > 2. The traversal performed by mas_wr_node_walk() means our r_mas.offset is
> >    set to the offset of the entry equal to the end of the range we store.
> >
> > 3. We therefore copy this DUPLICATE of the final pivot into the big node,
> >    and insert this DUPLICATE entry, alongside its invalid slot entry
> >    immediately after the newly inserted entry.
> >
> > 4. The big node containing this duplicated is inserted into the tree which
> >    is rebalanced, and therefore the maple tree becomes corrupted.
> >
> > Note that if the right hand node had one or more entries with pivots of
> > greater value than the end of the stored range, this would not happen. If
> > it contained entries with pivots of lesser value it would not be the right
> > node in this spanning store.
> >
> > This appears to have been at risk of happening throughout the maple tree's
> > history, however it seemed significantly less likely to occur until
> > recently.
> >
> > The balancing of the tree seems to have made it unlikely that you would
> > happen to perform a store that both spans two nodes AND would overwrite
> > precisely the entry with the largest pivot in the right-hand node which
> > contains no further larger pivots.
> >
> > The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
> > in mmap_region()") seems to have made the probability of this event much
> > more likely.
> >
> > Previous to this change, MAP_FIXED mappings which were overwritten would
> > first be cleared before any subsequent store or importantly - merge of
> > surrounding entries - would be performed.
> >
> > After this change, this is no longer the case, and this means that, in the
> > worst case, a number of entries might be overwritten in combination with a
> > merge (and subsequent overwriting expansion) between both the prior entry
> > AND a subsequent entry.
> >
> > The motivation for this change arose from Bert Karwatzki's report of
> > encountering mm instability after the release of kernel v6.12-rc1 which,
> > after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
> > options, was identified as maple tree corruption.
> >
> > After Bert very generously provided his time and ability to reproduce this
> > event consistently, I was able to finally identify that the issue discussed
> > in this commit message was occurring for him.
> >
> > The solution implemented in this patch is:
> >
> > 1. Adjust mas_wr_walk_index() to return a boolean value indicating whether
> >    the containing node is actually populated with entries possessing pivots
> >    equal to or greater than mas->index.
> >
> > 2. When traversing the right node in mas_wr_spanning_store(), use this
> >    value to determine whether to try to copy from the right node - if it is
> >    not populated, then do not do so.
> >
> > This passes all maple tree unit tests and resolves the reported bug.
> > ---
> >  lib/maple_tree.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 37abf0fe380b..e6f0da908ba7 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -2194,6 +2194,8 @@ static inline void mas_node_or_none(struct ma_state *mas,
> >
> >  /*
> >   * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
> > + *                      If @mas->index cannot be found within the containing
> > + *                      node, we traverse to the last entry in the node.
> >   * @wr_mas: The maple write state
> >   *
> >   * Uses mas_slot_locked() and does not need to worry about dead nodes.
> > @@ -3527,6 +3529,12 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
> >  	return true;
> >  }
> >
> > +/*
> > + * Traverse the maple tree until the offset of mas->index is reached.
> > + *
> > + * Return: Is this node actually populated with entries possessing pivots equal
> > + *         to or greater than mas->index?
> > + */
> >  static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
> >  {
> >  	struct ma_state *mas = wr_mas->mas;
> > @@ -3535,8 +3543,11 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
> >  		mas_wr_walk_descend(wr_mas);
> >  		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
> >  						  mas->offset);
> > -		if (ma_is_leaf(wr_mas->type))
> > -			return true;
> > +		if (ma_is_leaf(wr_mas->type)) {
> > +			unsigned long pivot = wr_mas->pivots[mas->offset];
> > +
> > +			return pivot == 0 || mas->index <= pivot;
> > +		}
> >  		mas_wr_walk_traverse(wr_mas);
> >
> >  	}
> > @@ -3696,6 +3707,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
> >  	struct maple_big_node b_node;
> >  	struct ma_state *mas;
> >  	unsigned char height;
> > +	bool r_populated;
> >
> >  	/* Left and Right side of spanning store */
> >  	MA_STATE(l_mas, NULL, 0, 0);
> > @@ -3737,7 +3749,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
> >  		r_mas.last++;
> >
> >  	r_mas.index = r_mas.last;
> > -	mas_wr_walk_index(&r_wr_mas);
> > +	r_populated = mas_wr_walk_index(&r_wr_mas);
> >  	r_mas.last = r_mas.index = mas->last;
> >
> >  	/* Set up left side. */
> > @@ -3761,7 +3773,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
> >  	/* Copy l_mas and store the value in b_node. */
> >  	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
> >  	/* Copy r_mas into b_node. */
> > -	if (r_mas.offset <= r_mas.end)
> > +	if (r_populated && r_mas.offset <= r_mas.end)
> >  		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
> >  			   &b_node, b_node.b_end + 1);
> >  	else
> > --
> > 2.46.2
>
> I just tested this and it passed ten tests (i.e. upgrading the proton version i
> steam) in a row.
>
> Bert Karwatzki

Perfect :) will send the fix upstream then as a hotfix for 6.12! Thanks
very much for helping out with this, your help has been absolutely
invaluable and HUGELY appreciated.

Cheers, Lorenzo

