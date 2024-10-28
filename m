Return-Path: <linux-kernel+bounces-385840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15B9B3C77
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BA91F22B00
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B41E1328;
	Mon, 28 Oct 2024 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DO9+g9Ys";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LxNGvue8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AD1E0E1D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149541; cv=fail; b=gsf5RYS8I8IX7Qd5QsJewPfcycoP8YIM2nXb/LmTMGZCrPo6eaCWJP4NbpktF0ZBDHVnoPMJdM8pbsoCLqg0pz6fsGM+sXYKO5O2YxVbxu3vcYJ5MaOL5dSEpwuYOfZSJBKUfgcQ169A19LMAd6tyAdRIk4tVyGiHhQCmdQWsXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149541; c=relaxed/simple;
	bh=/qo4H2fmJKTYP4SlQcXDTVoqBziuCQX3V7rCHHUwnU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C6lwmdGTLPDQh70Sq/0CHIDkNc2E4OCOCB6eIw9rv7/rlgnf/BU4IR6ePwSuBW7PlSMr+g7ovy7atc0pxVTmpQ/ght2/LjkdSFfIZ+5goV3eDRdF+f4CNG0LQ/eQVgCm4/TMAis5zgSvaiEeY48/0vi8sx/Ursit5iT+To46HP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DO9+g9Ys; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LxNGvue8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKtcLa001649;
	Mon, 28 Oct 2024 21:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IHALKmkth1pLi/9bkQ
	hFiw/qY7Mx1uUqDHUtmbRrkJA=; b=DO9+g9YsH9e/MdtM42zYNIc5CQMDzUj7sr
	LRFnp+ny2/j6aVnKoeqkT0Ag9H6J7jA2JtpmlT+VViOThJNsKzBxufOeaIIvGCQJ
	k/uH6ZqXuLXr0btd1wYiTahq2Zc688fcrPQ8sax3sf9KmHUXm11qRZG1nId9IaM4
	t8hxTOarihkgufC30FkdKbaaeC27zNgZU3IpGljwaXxAVPoJ9b3/tpz4H5L/f3GX
	kreDlmnGaximCuHO5oEDhKLlsyjaOWgHabqXPOAAxzuY7kL2Vu6RYq8uEZON4pe0
	r5JGC8Je7rafV1lHwwnWCVDH8XL0ySHjz+IyRI2+s2xpmViGak9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxm0xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 21:05:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKHFaK040322;
	Mon, 28 Oct 2024 21:05:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnan2ku1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 21:05:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNJqwSpbYJHxxOCNNykdimAlGDLFqfxRjX2nnERXwJJp0hHBpNESi7wf5LmXDvereZcbOYZD4SKx8N4AFlX6Z7aWi3bc/qns3IGcoaKqCbocyjdYtm6Cshu4kK+giOhEVFTSMD3zX1RnbZ4s9ukpTfUexFuU+YRSR3rZv7qdBGOmMjr9LJMi2DJHclMzUVaJRo8LPBeqWnpwzHYygJ8duodnLykQMGcbnNT8emwM4ONIkw/UEwHLpYg02Jio4D+hvNW+l55bUeEDd9zmNbzWw3UPFe927Bw4PryTp2Hl+4LwyZzAZrXwSHDNgT0xrehCUNY8IitFrD2I71dnJ6bvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHALKmkth1pLi/9bkQhFiw/qY7Mx1uUqDHUtmbRrkJA=;
 b=tvejer57348ZPdrr2VHG3ZREasQyLBhATYpjghOV0Nv1oz9mZs6A7J0qUimKNqYPsenLYlVIv8I/Iw0lUPr41iFi6wIdsieXuA2b/YAHO8Hffi43HRkJqF0ZoGTr4UcnJplxXP2mDYKF20xbCq7V3rSNT3MA7HmEqmbnfsPH3e+Il1eADNbr3kZe/HskZ/qdugliRGFw2Ms4isthpmnGFNvYNzgaCyRdLEFf2/6CC5LkTjTNT3Qj9R5SF8+KWfl7gFNLWVwP7B3SI64fuWjt5crI8k29KgA2TmyNjHgG7lBcx0d4jcnU1UIzTm7mMYAyTFdK73LWOcgGa3WgWSIMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHALKmkth1pLi/9bkQhFiw/qY7Mx1uUqDHUtmbRrkJA=;
 b=LxNGvue8e0ZtKj5j7YhJV/WLPDPZvwqPh4Q2Monap1wlCBvFLyO957URjqLKokRbOE0Q82+ACLnsiLpvfL0HjNcKGP0xvgWM6JqXkNqYQiPf3sTBRWH5+vPXEpTDJRC02TJT09uJpFJqiNUbPQUw846P7MWHfbmoqnOEO2iuY8E=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV3PR10MB7819.namprd10.prod.outlook.com (2603:10b6:408:1b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 21:05:01 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 21:05:00 +0000
Date: Mon, 28 Oct 2024 17:04:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <iebkpucm5epdcrlhnqmr3xolxtgxvsukwy43rtvamtl3zjc77o@2azoxvhwt36z>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
 <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <a1ffccb8-3f53-4486-a250-282ddc7054dd@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ffccb8-3f53-4486-a250-282ddc7054dd@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0402.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV3PR10MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: b227d517-a1ba-4762-bcaa-08dcf7942fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N4hu2bKHs+PIp82eO95+GPPZdy54BQEJ0ffQN5eu+URyDca+OeXcOdQKrhoe?=
 =?us-ascii?Q?s55uysAppUPpksLDRNi2YIyV1Sc1cZjejPjraAYoaa/BMElPU9Yce0g6hD6D?=
 =?us-ascii?Q?FXeh1aeEB8yWGrL6t9i6zO72KttDXh2OAUuLq/wUJqx+LtPfAUS4xaRWi7EO?=
 =?us-ascii?Q?hNjXqdX08VdQHCIMyrrdDWaR4SETVKdJYjnDaFXcekbXkVeqNsDuo8oGcdvH?=
 =?us-ascii?Q?QVvwoKc+q9R0OxmRRBG9IdYouX+Hlv+otlghnxzb/O93+lkyb03JgFTdUuDV?=
 =?us-ascii?Q?5peyM7yGKltLBKcFmblEeLg+acux8RHmcaTe4hg+g0qWiInnhONTJtXYa6M7?=
 =?us-ascii?Q?GQWA72461qU6BUgw0Oj5ewbAia9eAdzkU8vpA5HykoFkT7FKc6KUt4lqPKeX?=
 =?us-ascii?Q?/+VTtF6zOg//zjxTdaqO3bU1MnuQRv9GGg1fexZuxDNzQYw9B7TvwGqBfL12?=
 =?us-ascii?Q?zwEVs9p1YCDcpYkAG/BZMs5nfLhlAvmjR9p1UHbJwc8wvn9j1s0chMf4qyWJ?=
 =?us-ascii?Q?Eh+rFcwQktq758s/brcheFUWO5J633xm0Gs6mneKf6NrgSm+CK1ZxbAcpLuq?=
 =?us-ascii?Q?8IRnXSt0V0tlJeLYoxnOC2TTeI7tlPz6DNpGrYZE2ZIgsoH/kHqNkIF1vM0J?=
 =?us-ascii?Q?kRPPFI8C6I3A69oYpSkfyNV7F1QC/qJ/LxIDJVdGJuJxlbA5sdyEVtkXH0CV?=
 =?us-ascii?Q?oyOqEWaR7LG9DzGx9BkiFgh/JAgqZsl7yVnTTpUq4bi1TJjLfYleb976K/Ty?=
 =?us-ascii?Q?Xdozm6HIKBDdSS3BwzeHCy0M8h6MUj1nkAij395BjJh8EI4Dt8s6iIdv0ZHU?=
 =?us-ascii?Q?TPQPggJkXV77fMvbNCFW2iHylnq2fbXMLaiiSAT5p8NXtz2TaDzSotGvPDVK?=
 =?us-ascii?Q?UvuHSzLULVNNScpjber78arANbVWIE5o+lW8ZcTyzP12vc6mdOpUSL8PKH9j?=
 =?us-ascii?Q?ALoVnH1akLdqavdvm/rQuznxuFYQGdFyRf/4ekOmbAYPi/hq11KQrKAept3s?=
 =?us-ascii?Q?CCE0+AjITue5pULf8c0S4Uh0+5VC+aEVA/rBD7teT8mUg/KWBT7gyQzYwTl1?=
 =?us-ascii?Q?OKd+jKy6oRgveQabeWtLoZzD/GYpPphdhZKg6soECd1QLrxEDLZgI0YFhwTw?=
 =?us-ascii?Q?9d2F1mlVCZfn248aLlqIPAnd1CGoijvzCkqc5plxVmZM3wqTlQIyehoLYjJ1?=
 =?us-ascii?Q?MkUut81HoYKtRcyCMvIx4PtY80K1/dBwnEFiXrFdSJqlIGIYvAVU17wb5DAn?=
 =?us-ascii?Q?UKbyGMcrRUWhIIdGqBdDNgfAk6+RjKqm2FrRgmrsGj2xCihDzIBtPIbBpLn2?=
 =?us-ascii?Q?Da2dyNvHyM8mu26JNLoAkvXx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sFbbLhHMkmkrYDGMJ3bbnKFgEOYx9YDchFK5cIgvUW9PnqKP2UJ59M/FwVha?=
 =?us-ascii?Q?9/yuXMntxGlMfmNIUYv8orx/IDTjCUe4rm9bqzZ3VbzGqqCw3mQM0DpDL+L1?=
 =?us-ascii?Q?tRwkcvdAkMqW1gvc02jls4zleNHOh3mvJDtzhCZ/ucoRXX8uH46xObuSbU64?=
 =?us-ascii?Q?R4x5mZ7k6EU2NHGGKRkLtSbawOApdQM0/w6aTR/QImHdbQSvyjfJnIy3HvmJ?=
 =?us-ascii?Q?M+OVe3lUVelOf1jkkgefvTAeRPeg8vggbRMZzatdqih4XtpW7SRcfDupVTV5?=
 =?us-ascii?Q?kJLFQTx//sGu29ddga9hNcjI9YFdO7giDIb9Wv8A7bqHZtV7YlIoBZWaoSYh?=
 =?us-ascii?Q?3G6zIQN3A13dhfrLc+dAPy/uIop/Tw2cKhE+2f5/WM+BDTLbWRUi6cAGSDpE?=
 =?us-ascii?Q?9PXosLlJTrd3XuT/IB/SkvH6mNb1yLLjgw524ailnP+O2igYFR9pfqcZilGp?=
 =?us-ascii?Q?rjE4LgZqbbWDpbuVUjU0XM2Z6b1YldpZHZ5VKAbFBDUcBf1mdyXr6OSfOivh?=
 =?us-ascii?Q?zGExgCXvD+KkqTMEg0kzROi1k4tDmyAKQAFKXDUYXwsQcHOfGyBEWW2Pugf+?=
 =?us-ascii?Q?HzgKe7iuRfoxRNWl9+YsPfe/km14dGv72f2FOJSHCsgcOE9wMsq1V1xDlaqF?=
 =?us-ascii?Q?wSrDPjJi8vuf8Ihk3ZfUKC7kISCeYNikUP/VYfPffU1WXJhLdV2GBbS6wjo9?=
 =?us-ascii?Q?ZAJAESWwevmWFmSmNeiQ6bUY/LtYf6IwyquOKAQsnKHOOG9hugLRDQIx0quv?=
 =?us-ascii?Q?HifbmFoevc7e3pdXb81pZBnIFWusxFfcEsNhKfd2wGxombx4VPSYa71GccOb?=
 =?us-ascii?Q?BCVFSlH+7Ug6urhs8xyG2b88+55VzGUWkPOlT6iyP+PmngzbA3Xtq6bb/CRc?=
 =?us-ascii?Q?qmnbPmxFabNHqY7E6GdFGYG+11lQ6aG4j15g4EsD2mWdSLo4IUZK0TCys+rg?=
 =?us-ascii?Q?mUp0HuwyvyG9R2baMQ1HbVRFUt9jWCxYDsRp9KwQpoSvRsIQy+EzWpJ3sX/Q?=
 =?us-ascii?Q?x+wyQZUSLB9As0jjrKrFHQfT254FytrNNFbcQW/cRkWmVAlkVrQLAP5dipIQ?=
 =?us-ascii?Q?PAcVqO1ltv9ZqkKkmfLtvdw7Zy2sZWJ/6zDaR5shJ14abG32YksBmZO5i0zi?=
 =?us-ascii?Q?KDrAPmcoFowmP+pUp+fZ61TYzoj++NJ2DLj12aiFowI/3R9pBqpGWqb7d2zN?=
 =?us-ascii?Q?JS0z/O7k1nV+WAo8B8mapF3THGC3RVZSDDVyt2Dy/Ny5sECa/C8BsQJt0Kkx?=
 =?us-ascii?Q?lVMzRVD/5bV4TEXs/tfCsdmnYmGz7lb+fVlFsUbLu5x9mMxuVD/A6M+rCLKx?=
 =?us-ascii?Q?QWmKdCuLBp+j5YAkudZUBYR7JOKyF/77yS+1iP959ljRXwFKTWGQyG7lCCvw?=
 =?us-ascii?Q?4d+kGhwgPdFfgRnD02OeBsqRchcq8uWeZA2241h9WfW+9roAbDBhyEjmMd10?=
 =?us-ascii?Q?MXriVPkKTf+pO+Eyze5ekDVMYYZWy/OlFcaacBSm087fJFqqVfI5trjfw/4m?=
 =?us-ascii?Q?WvtvzUHyO53Z0aCRY/ORPWf2gIRMHz33NWghMiCy3Xt8/t4Z1jwc00iIchrd?=
 =?us-ascii?Q?WVt/9CXIObZn5pVCBB7q5sk15gwozCxinNyoFw9M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tGwMolPQN3jXatG+KsWcpBMKBkzUSM+GoCDHrwpcLGn1rPwoAlMLG0QiERzk9wD5+Dg9D0sPi3PmO9BINRMzGv9Ld3ccR3DCCGfamI7bMsqs6YuIpQ3h/lLrVFHmE9rChbshuKhBe/exXP/ChdfDjXw3ac6cqlHiyIhSQ+GQrfyQCgYxZGEDPDqDpYa6d4AsADNTmME4gra5OyiXO7UNV3cPcEKRyfiIzhCtA8wepHymaJ3p8XLXxUJW5zLCVvJ1Ltxhe3eUCarxIcOdojViTuSImblGV7bM7Hq0/bDZtDBSVC5kqg0w1Ptg4YyIcHzqnTANHkDZTI6KUoDITpMRkqekYipLBa1U+4RMfqn/V74KTVPS3xHlEkuml56ggmNrX6C9tog07STw1cgF8vNVT/fXNNEuoQlfsH2g20CjvIK0lEdeAX8I/2ON7k4NpYB550yeBFVegKM/v4T+0B/mvh7T9EwYgn3UFX6lGJsU/Ryo75OCpV5pXV7NyCn05L49X8Xll+ZKEzOjvsTC6uqjnwdIoc1/pYnP1dozcrli4lLWH0hSAFyf0YDG39XY629Q6DdKLswGYgRnKfX/j4eNmD2HPqO822M9M2VVRex2l7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b227d517-a1ba-4762-bcaa-08dcf7942fb3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 21:05:00.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X25piqx6v3sgpdlop86IsSYxUkjyo5sI7Z0QR/CdWCKSnIBvXUVET2noz4dSkNGPxOVzWrcfuXWG1aFkakoQSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_10,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280164
X-Proofpoint-GUID: r_oh5VI3vbeDJJmo7a4wlAIvW4H6ror7
X-Proofpoint-ORIG-GUID: r_oh5VI3vbeDJJmo7a4wlAIvW4H6ror7

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241028 16:43]:
> On Mon, Oct 28, 2024 at 10:22:32AM -1000, Linus Torvalds wrote:
> > On Mon, 28 Oct 2024 at 10:18, Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > I'm genuinely not opposed to a horrible, awful:
> > >
> > > #ifdef CONFIG_ARM64
> > >         if (file && file->f_ops == shmem_file_operations)
> > >                 vm_flags |= VM_MTE_ALLOWED;
> > > #endif
> > >
> > > Early in the operation prior to the arch_validate_flags() check.
> >
> > I would just put it inside the arm64 code itself.
> >
> > IOW, get rid of the VM_MTE_ALLOWED flag entirely, and just make the
> > arm64 arch_validate_flags() code do something like
> >
> >         if (flags & VM_MTE) {
> >                 if (file->f_ops != shmem_file_operations)
> >                         return false;
> >         }
> >
> > and be done with it.
> >
> > Considering that we only have that horrendous arch_validate_flags()
> > for two architectures, and that they both just have magical special
> > cases for MTE-like behavior, I do think that just making it be a hack
> > inside those functions is the way to go.
> >
> >               Linus
> 
> Ah yeah makes sense.
> 
> FWIW I just made a fix -for now- which implements it in the hideous way,
> shown below.
> 
> We can maybe take that as a fix-patch for now and I can look at replacing
> this tomorrow with something as you suggest properly.
> 
> My only concern is that arm people might not be happy and we get some hold
> up here...
> 
> Thanks, Lorenzo
> 
> 
> ----8<----
> From fb6c15c74ba0db57f18b08fc6d1e901676f25bf6 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Mon, 28 Oct 2024 20:36:49 +0000
> Subject: [PATCH] mm: account for MTE in arm64 on mmap_region() operation
> 
> Correctly account for MTE on mmap_region(). We need to check this ahead of
> the operation, the shmem mmap hook was doing it, but this is at a point
> where a failure would mean we'd have to tear down a partially installed
> VMA.
> 
> Avoid all this by adding a function to specifically handle this case.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c  | 20 ++++++++++++++++++++
>  mm/shmem.c |  3 ---
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8462de1ee583..83afa1ebfd75 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1575,6 +1575,24 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	return error;
>  }
> 
> +/*
> + * We check VMA flag validity early in the mmap() process, however this can
> + * cause issues for arm64 when using MTE, which requires that it be used with
> + * shmem and in this instance and only then is VM_MTE_ALLOWED set permitting
> + * this operation.
> + *
> + * To avoid having to tear down a partially complete mapping we do this ahead of
> + * time.
> + */
> +static vm_flags_t arch_adjust_flags(struct file *file, vm_flags_t vm_flags)

Is it worth adding an inline?

> +{
> +	if (!IS_ENABLED(CONFIG_ARM64))

CONFIG_ARM64_MTE .. otherwise VM_MTE_ALLOWED is 0 so, really doesn't
matter I guess.

> +		return vm_flags;
> +
> +	if (shmem_file(file))
> +		return vm_flags | VM_MTE_ALLOWED;

Would if (VM_MTE_ALLOWED && shmem_file(file)) allow for the pre-compiler
to remove some of this?  Also probably doesn't matter much.


> +}
> +
>  unsigned long mmap_region(struct file *file, unsigned long addr,
>  			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  			  struct list_head *uf)
> @@ -1586,6 +1604,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	if (map_deny_write_exec(vm_flags, vm_flags))
>  		return -EACCES;
> 
> +	vm_flags = arch_adjust_flags(file, vm_flags);
> +
>  	/* Allow architectures to sanity-check the vm_flags. */
>  	if (!arch_validate_flags(vm_flags))
>  		return -EINVAL;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ba1d00fabda..e87f5d6799a7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (ret)
>  		return ret;
> 
> -	/* arm64 - allow memory tagging on RAM-based files */
> -	vm_flags_set(vma, VM_MTE_ALLOWED);
> -
>  	file_accessed(file);
>  	/* This is anonymous shared memory if it is unlinked at the time of mmap */
>  	if (inode->i_nlink)
> --

