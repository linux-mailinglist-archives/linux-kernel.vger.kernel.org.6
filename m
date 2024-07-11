Return-Path: <linux-kernel+bounces-249478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A75A92EC42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89DEB23D22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55516C6A0;
	Thu, 11 Jul 2024 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IjDS+qdN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ttVCHzSx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441615ECCA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713895; cv=fail; b=FAsQnwPTqnA03+CytnB8vjnIHbL3Ii73ijQ5g49Fqmu61U6LOuRBP3VHLuvHhHI0hsR0BFLVTWio/LzxlXCCFqdnxLluTwUX1DvNwpVmsoadM5vpNibrhetVIZzTbAnVVcFxWS0XhOV6o3ZuhYf9OECcsyRqybSMmCUwYqsNV58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713895; c=relaxed/simple;
	bh=5dOtTCapD/DDKM49v6uVea+a9LF6CjQb0ME1ZOjoIvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MhvVcmeatH1slc183R6Fhw936aeP5OfQigKFobGRo96UPXMrlG4nsoPCvY84sFcolNwd08Ihs5elzl/XIHNe3kvllf/jgAocFOLtXuFSQjGZdOmQP6DrSdLEMcrOcbXwWD9LoH2RJ+nbUdOeONOeTxCoYKFqOKYKzSAdoljGXo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IjDS+qdN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ttVCHzSx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBYDq027081;
	Thu, 11 Jul 2024 16:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=x5RjPh6A0+n9/JY
	VQDGXWhrmFUjbitWsD4Z8+HC574o=; b=IjDS+qdNmTO0BwtPKKxbCTvFolAsSIz
	FusbgTh9SnyE0Pfk7pe2HADIcmZAG1UaUzmSGd9CNI258I90NtxX2lJeCQUgpGqk
	JEQpl7x4Vh3WGsC5gFXrlUC3+q+Ey7BgUM6KKQLDUccLp/RqSY3YuXw+GPHq1L/M
	NA2xoe4B+1rPP3HR6j0nvDNRBEynfmQLQ+56FwXQDiR65ONirahJ+doE1Wlq8Sys
	cR8kiK3A4rE9d82o7EOauemFqj9cCMshBCnvnsO5F4EyvMbiEzRT+9pNXyNRkEjB
	SSo05UzYIfc1YAlg6Sp6D77XfDHGXazbmih8GpTl8VKLKPPxWReLsvQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq21af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 16:04:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BEma2R033754;
	Thu, 11 Jul 2024 16:04:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv2et5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 16:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ygw/GfYfjFmJrlFsg8VkSGGOCuztPysR71k4VSZQfFgEyox/Y3MmEqaZTmaMS1JWwvk1kuEJLtFsGuzM2S35W2x2msPP1JCXRlGuScPRO1l3n8fj3iO6/ThbMcRGFqB65C+rBsjE8sI5rDWNgK3HYZpVENPdqQInzGAWFEQ+0gNP8Di//M2v9BwTHtFao98hW3Q4SZiI/JAfBxPSj/jnd0gWAB0mDurvo/4uZV4p0PwcL226Q+tln4QoIjdd8H5YFnCIaq+uttWTdv048dK6QVpY2zcnsq9f0YxHtAOnOzD3FHWoEHyU7AyTfBt9hkIovc5hsfvmifgEYw18ZEv85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5RjPh6A0+n9/JYVQDGXWhrmFUjbitWsD4Z8+HC574o=;
 b=OVQ/itHEBhk4xyzNxHfFZdxvYp1zDgKj70nSq84jz4p2lermnGBbvpWlZAMQh2PUX4EcShaJkF3wrMVtnoXiDHbSXdWPJAkH6CpW1aYPfSPbeajtXxDI5FJGsEEMysVHjnmuDqY7w+kxO71pUV4jlUsdyMk9+eq/xkXHoi7OgL+PMizU8spet6CHdol87SmBG0g12IaBj5j7bnfpUtGEKbPqqTQo+npw0RgglUKHxvB6PGKDPgi0+7AnLpGaprOyikSFuEA4/POQafLm1Uum9VVAlP4FUCjdF8qrbII7ur42IJzZ/ryNjh2FSWpP763ZC4cIdje23GBIVwKZA9YoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5RjPh6A0+n9/JYVQDGXWhrmFUjbitWsD4Z8+HC574o=;
 b=ttVCHzSxji0z/hrxQO5AIir2HDxCArMn90mizA3WI6Jt20hRGktyLFOA0Sai7pIXqXcs5N2aF09SQhhnbJUp9uruUAdz3i1+zX5oWGWO4wLdYtDfV2kBdvNk94SMKqMS+nifgGXWryu1/RzEbIzPnU/s5FmGetXHYjj+2RLqTms=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5195.namprd10.prod.outlook.com (2603:10b6:610:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 16:04:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 16:04:35 +0000
Date: Thu, 11 Jul 2024 12:04:32 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 10/21] mm/mmap: Support vma == NULL in
 init_vma_munmap()
Message-ID: <mss3ntakl2oddsuimqfigjfvcewmc5ju7l3bychhb7r7i5d7vr@abn227s22rsm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
 <20240710192250.4114783-11-Liam.Howlett@oracle.com>
 <f531253a-f2cd-4e1c-999b-5833a6468241@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f531253a-f2cd-4e1c-999b-5833a6468241@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0246.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: c276b7ce-40b2-407c-30cb-08dca1c328a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y5qsks2IW+5saFkLV9aLqnSm+ZCZgIzCunXxvB+32jTvF7I6kdu2n1UIVuYu?=
 =?us-ascii?Q?cfM5pM3kc/4XLGnVm4F51maftaoay0Q21XMpLR3Yl4e1YQtcYVg1dWxGZqiT?=
 =?us-ascii?Q?oNOzRSMV5HxWYqCDVdRptDpe/JmysVhhn7I2tThYa5Oh/6RVmhme09BMoFWX?=
 =?us-ascii?Q?ATiEgU/E4VCHZZlsjmyO//bbPk0bmrgK6RMk/PgizSyoIguP+Hqiqg2YIOTr?=
 =?us-ascii?Q?J5cgFKYLvOeHgHwitZOjpLweYAUEw2xW/Al3M5/n14neHhwMXgA63x60a7zG?=
 =?us-ascii?Q?G8nZtzmfnvEEh1Vwbl+KjITO/0Ti+Ku/PgG0IPc7E9QwxPKaA6Hi78u8g8XB?=
 =?us-ascii?Q?JXZHl4FJabAjwbNV9ayUz5LxtPhH3UmuIS7ctp3Pb/Q6y210GP3y/TrJ1JOe?=
 =?us-ascii?Q?99//WX75dGNex1wmfcfIYDhew3yCJ2rXlOMqJvqOwo+LwJdb3SwtSAcAg3dY?=
 =?us-ascii?Q?xL1z85od2xUHDr2SQg9Gv+GwgBskueRso6OeMgjsela75GU/EIXieytCcLnZ?=
 =?us-ascii?Q?vdQDYyBCfi0sQn5Fopz3XE1TgxVJ8CCML34HbeDlmBaT4GphvG7gjWIUkHhP?=
 =?us-ascii?Q?smL08q8AYasIuIslAw1JLLTvB11MoqQlOqfSF2Ac9Ki+mcjZUBcumpDymCCC?=
 =?us-ascii?Q?eFnJs/K20Iz7QlzgTnDDPsNS+yHP8ADrZhkgU9CdYI81HXbn8ss9UkTs8Rza?=
 =?us-ascii?Q?sdwnB9jsqsM9dYmOvfE7dMOaRaxP4va6vByZf60tLOIgjjCs6MR7Ln2n6FvQ?=
 =?us-ascii?Q?jVtKtCHMDJBMoHyxx3M0uC1WYZwGY2IzcRVfp1RPAaxEsGrnqrsQnqx3quR7?=
 =?us-ascii?Q?7ygamsqvQ4f8z3HSvhWMxTAII/ZSIhlhMwdI12I/SJKU/6k6yufXJvPJ3O/S?=
 =?us-ascii?Q?1W3RDnl57j+5c2/zJA5p3/q4yn2OEYv0YjXPmvqUraHyY90ZpDlN9zlQeJiv?=
 =?us-ascii?Q?3DSNlmfx7UrjHM9a7cBOyiPAF6TMda04JtypZbEm45Cx4cJ3m/MKYRQ+/7Nk?=
 =?us-ascii?Q?zYzUsklVWu/NWYdOtb5jDfyMgcuK6I+/clSTskzraHUh8PWligEcJUp4IIAO?=
 =?us-ascii?Q?klvGX4hWTnICbizCDKLthBgVrZaNgvPoVAXqZsIX0w/uzrwHEixUS1fDk8yY?=
 =?us-ascii?Q?6voiS4HX0rzkqdAR7JZhCWi2jgdWlEfJRX+mR5KpM2+QZOvGJby1RNXrZHVw?=
 =?us-ascii?Q?5j2t9IKBLH508f78I2Yfxiv5CLSxtZ497NPepJSY3m2VN/T7kTmF0c+i2LAw?=
 =?us-ascii?Q?qv9/iHsWaDkTyOs/zPSxoPjnW9RNz4xq8Z91xEzbGcvppbnJ+R/t4bK4eW0e?=
 =?us-ascii?Q?H+KPA7rW6fRpk3jwINDEGbLpRnLLJ2e+gtxjactFZAWmDA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JhV3tRbUJhydYA2mXtWmM+ElECi8TiPust0cY4naf5nPqEYYdalTgu9wtz87?=
 =?us-ascii?Q?1dNnbY6s2r3z49MEQI3ArbzzCSQQ5dj5yTE6YZH9cqw/aWKV/DMm48R8XVeq?=
 =?us-ascii?Q?71jaqdRvBTQQW/ktw1K0Pre1shrUEcV+R2ALgFXGaWiAQ4oBDy4IraCsN3zJ?=
 =?us-ascii?Q?wx/eCv9/iy/ofCAhP356zxV1zJUCbTpEajTheBeHDKbCQPAUeLJTDuFi18oe?=
 =?us-ascii?Q?Xh+vupwg2G/ByDudCksMmMK75bl9PQyy41rYI5uwOOloPsTkJ6oBH4W89PWd?=
 =?us-ascii?Q?GUvOdz5fH019uonWwLwdJR2VSaJkJH/QRI4RlsV98/XUsWKXaCdLxlUiDeb4?=
 =?us-ascii?Q?B5k9FmdUrHPuu2xOz0jU7IRcLapx/n8rRhi/PtKnGjwgxVzBax9co4nnFAlt?=
 =?us-ascii?Q?Y8ZCdrNbKBlbWWcbbmnAf1kWinIVfcGzw/2g7+ml2q1HR8brKPCNz40pPi68?=
 =?us-ascii?Q?vF/Y2om/XJyrZ/lO1qscJlmb/Ho+ef4OW7r1JkM5sMjltn2vivT2mCRRVcy7?=
 =?us-ascii?Q?9cAv+c6Zp3xniL1xEg7zg+Rabe4bHn14Pm+awvStfB5PfasCRmVEgPIhRCr3?=
 =?us-ascii?Q?BXxPiIQdMRGNRrUJyc7Dom8sSnH2KrFyA2dDpwzo0LdHQcaakqSXU3UZQh5e?=
 =?us-ascii?Q?D3xIRM13y4EnL78FmuBpIgTVvkblXJp2tCTUOPvoaMDNzun1nZM6NBOmW+1Y?=
 =?us-ascii?Q?sh9gyyR+oztAnnzuWa749HfqY9hjcb3+i6dlnSMYMb6XxUmTvjkbmrHiQSzB?=
 =?us-ascii?Q?M8sj/3U6D7SegRP+kXC8KClaDi5VFwF0LQfQYyn/xQZqxD8Z/GwB5b2tzk/S?=
 =?us-ascii?Q?qRoAu42y4ECZKomJoZrgXnucpjNnWvHatVnmcqKCvPXMpTtFdtIeFCHCFO40?=
 =?us-ascii?Q?1UA3PUACz9N3TbtQdx68R7XKhdtHs/T9QxDt++k90N+IGWApP7iDbb75w3TY?=
 =?us-ascii?Q?qJdWWHo9W7RFQjgSI83q2zL4MI32W5nEf/acHZxdVpRdXns5HP7qPMil5884?=
 =?us-ascii?Q?Audj1deseOJeCwLuQP8qXYrFlSnKc0zL3mFNbqqkWmsQkK1CFv0qxY0V7VXI?=
 =?us-ascii?Q?NWsSXh5oUpjWKMUiGzWHYx1WW50uD5MSgaPJHz1sUgz9tiWECSj6o/x0sw+f?=
 =?us-ascii?Q?CSo1FN9cwbDMFIFainVd0PPKfwts3LT0FNtf00F6GsqxFfIiHwPwiOPkxLVS?=
 =?us-ascii?Q?nXu4F5UaiEIkax+Djb/5lQ3+rxkHoWrkNlh9R8uc/bidsukPugjhYWaYK3fG?=
 =?us-ascii?Q?/Dv3DqjBYjiNZOsKBQgw415NAPLLh5i1Xcq8SLW3fVgcRFxNOCVcFDE8BuvK?=
 =?us-ascii?Q?jCxN3GB+JOP1XPe56nW+0hy+mxDs/krqm2EQ7HpSjBb6gTKxODsFjhQbFFnI?=
 =?us-ascii?Q?HztT6kg4iMXQlZHxEfv/4E3jFWXQR5AyG9FHCVqAvup35JkXXA8gZD44804N?=
 =?us-ascii?Q?LZLhoFdkfp5oo7Fe7qwvPF1n1T+G3aeqpvD6Xi/KsBcmXVcrLYCdHuTE4eGH?=
 =?us-ascii?Q?hN8YQcYZgrQ9PkqOsPgG0ZMHB8cnBAdv45r6ngKKKFUairNH80yXI4JvN8kI?=
 =?us-ascii?Q?DytBRt1FurhHTmPMlIj0PRRLu7d0xphgclsE5d2LNkvCNJHQTaDlfPuz6jTe?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K9yU9g3MzlaKQwyQyVTg8N5RX+bmnZhVZ8YsgvQHy2ShYl6umuB+wUQSiSDIITodKLyPxfCBNyXvdOjQ4ZjC/Jb8GA83c0amhaQDSpBvlPUn2RrQKyWthy9CXk+c3uG8AnWzyQ1VxySFfh+8rGlhRpfMLOHd9ejVS+tT0gz9bJYYuSMfEMbMgUNKK5OOBMi3Y0gaIq9SFGvKZLbsZ7keEFMY3rxI94ZMZS6cl8dmXrZn7h+qYEFqAHlqL7dVH1v9IIxk9oipIerV8+ACoAxSsBLcGWbgbg5cRCSat3H8gJzsknxyXU30HrEB5IAF/gt3n7B+CMvoE7sxglP94s+5/BGzn1ZLDRdHbvOWENgqG9oWapaR8/frvyWyl6UEH1aGHwNEa7QWzON/rnDLHXg9CtLz66hp046fDQwKyUxioANGMORcWUKNucgaMHFulrIFZk6/c0GlF/jbC9zeooiE7T/icXfIb2Y96hOSh5ixZd5T9ohOMuyyUwP0yalY0LahJ1g2BVbHeBmrdvrnh0mc5W1Lsss9baiz9syRxkHloJVOhZ/ANygBY6aIH4pgVPvW2C9JtaDdBkLU4Bm+2MSqa3T58PBdee7BvirhbjYACMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c276b7ce-40b2-407c-30cb-08dca1c328a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:04:35.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5pORe6QPH87Y83dAb/4iJOtS+OrEouhLJLyWAZQoib9qdX4PRtIpUJ+44KyVjU50SMl/X/SjkkwUXY4Z9L2iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110111
X-Proofpoint-ORIG-GUID: YD7d3erjPbuuKaPj7ajDJgz9fJM6pyOq
X-Proofpoint-GUID: YD7d3erjPbuuKaPj7ajDJgz9fJM6pyOq

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240711 10:28]:
> On Wed, Jul 10, 2024 at 03:22:39PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Adding support for a NULL vma means the init_vma_munmap() can be
> > initialized for a less error-prone process when calling
> > vms_complete_munmap_vmas() later on.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index a1544a68558e..e2e6b3202c25 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -516,10 +516,12 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> >  		bool unlock)
> >  {
> >  	vms->vmi = vmi;
> > -	vms->vma = vma;
> > -	vms->mm = vma->vm_mm;
> > -	vms->start = start;
> > -	vms->end = end;
> > +	if (vma) {
> > +		vms->vma = vma;
> > +		vms->mm = vma->vm_mm;
> > +		vms->start = start;
> > +		vms->end = end;
> > +	}
> 
> Why not store start/end even if !vma? And shouldn't we have an else clause
> to make sure these are initialised in this case too?
> 
> I mean also we could have vms->vma = vma outside of this clause to so it
> looks something like:
> 
> 	vms->vma = vma;
> 	vms->mm = vma ? vma->vm_mm : NULL;
> 	vms->start = start;
> 	vms->end = end;

I'd rather not set it the start/end as it implies there is a start/end
of an unmap operation that won't happen.  I'll just make it an else and
set them to 0.

> 
> >  	vms->unlock = unlock;
> >  	vms->uf = uf;
> >  	vms->vma_count = 0;
> > @@ -2950,11 +2952,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  	/* Find the first overlapping VMA */
> >  	vma = vma_find(&vmi, end);
> > +	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> >  	if (vma) {
> >  		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> >  		mt_on_stack(mt_detach);
> >  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> > -		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> >  		/* Prepare to unmap any existing mapping in the area */
> >  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> >  			return -ENOMEM;
> > --
> > 2.43.0
> >
> 
> I really like this approach in general though!

