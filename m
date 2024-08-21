Return-Path: <linux-kernel+bounces-295576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE428959E82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76742284751
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5470199FA5;
	Wed, 21 Aug 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e1Wy05cF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XNhp0WJ4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C219994C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246315; cv=fail; b=idzOSNhPizzp08rZZT6Cow7LJRItx/cjOJaTiEErz4kMExwKIxTcXxR1XfaRutkJx4dT8UEyXxHc9pefcHfU5JElpXTPC3vtJPPO/I8trxSBCNfRRswGx73RIrA24bfC9SOrELEfai10OCRixF5G+W6SMaIb2YTJHv2w2WNAezM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246315; c=relaxed/simple;
	bh=9cY0fhWOwTnuluuEvmwTbNUcvXIMFj8PKhz9HUSKh1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SVst5b23Nf2h8lcjXhm/AdHVP5ha5+vGPGgRVfr826Gd3TmFz/OoWxYcFrGkoF1odbg34A7MsTnrIZEvMGw260MGe216iCLDrX6yGbmS24XlFf4fb0UhFCn4R4+xvVALw7KQNv26vTUuO9oFldbFzpRHr7jrWvsze/foHg5Wo/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e1Wy05cF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XNhp0WJ4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBtZ5u012162;
	Wed, 21 Aug 2024 13:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=uCacHOD6jMyLuZ8
	WgxYfWJIxmicCX7iHB2q0PgkP1ig=; b=e1Wy05cFge3IwyKyJzPyRRJ0bdzyRCk
	HmVjESbh0VTb1vwMXvYSCL+ZckgokefixxVVfu5nndpYzmTYjH4LMySgRSNoOsjU
	bX8/EEh4tefk6XTwE1fZpb8lu7g7rTQT+uDQR8X0ECwutVdtLGR2+AT187OeaSkq
	mInR6F14TtGULTDNfMT9cKzXNZUZ1lla32vJ++mVlllLO/WkFqnwlCkkoSr8JP6f
	lNSH99ysGVmnRWn+88rDxVovVfHZ19KcRU9T4PZ2tuJZcDR2LIQpM9tKHMQI4U40
	EXtiCLjAkbEfxlCgn7FR9KZDAmrwLXcgStvZt1n9W10Xjo+MvQcDa7g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67fdbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 13:18:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDFDCw006355;
	Wed, 21 Aug 2024 13:18:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415gy602kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 13:18:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDK6BNOEPFBj/daJ9GA5+AWpWLUGEP37aKfRYRRxSMJZEpGjOcBSaI2JMFegymuy4d1N/VnXvwI6K/4JSb4uy33zkzulVg1AqjvZIqzxdD/BsOZ9PRd665eajXSx90N/dZjtodoucaA/gmjyibKT2c2Wfqv4aNVTI+TtNMyXbWTir8Z1s7ZLvBf1L1xP/jF7N4PbQfMf6lKoq5We+Fw/xBbz6RMJG/i7dCEeobFjC0KO/qMaPfWFyFbvXpSN46YdjPbosU3rAhhBIUV7jvO+yUfMqXam69KiijiDf4Q8csakHrM/7n7jByfGLtlQfyatc0wadqcVlYErXdx6dykmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCacHOD6jMyLuZ8WgxYfWJIxmicCX7iHB2q0PgkP1ig=;
 b=mBUcWU+2YTaCa9JAXsbPZhN8W0jmgLWmD4VzBIezNqL1/ZWhUJPV4PhvRSgU4ROaLqko9veYwszTPvhoUfJunWfsL47fd1EU5wSYv2aVZY/CcWr5sTEH4syWB2Gvj3u6Wmr2MTOUdTgwo3PSDm2+qSvEu8WzzIjG1CqoHBqtLo/JCXGDkni5Iu/ZWX/POILfC9IaFqQqRFwuUQxEDLASjW+/NyV5xFEZg/ABeF6qkOT+c3PtWhSMorxQgmZu1Ly9TGi39NQFEP2wqnumYlU4lgGrGlXItm6I/TNQ337X3xmx9VWW9trPgzgMFgUXcWaAstFxmNm464V2qSYO6Fyi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCacHOD6jMyLuZ8WgxYfWJIxmicCX7iHB2q0PgkP1ig=;
 b=XNhp0WJ4+9sO6FblKVnYkEQNCFMuJhivAu6YReaPhoB5KWoPxbFaf3zFkItPF6Ji4dfg2vkRU35VWXpWoRgDOdLuIvYGTbrqknCri6Ptf3p0yuFSeMKtTBu05fZHRz61lSAoLd9yFyxRB0W2+MV2FyBdj9Fx6pVL6BAaL5ReUOo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BLAPR10MB5060.namprd10.prod.outlook.com (2603:10b6:208:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Wed, 21 Aug
 2024 13:17:58 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 13:17:58 +0000
Date: Wed, 21 Aug 2024 09:17:56 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 06/20] mm/vma: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
Message-ID: <z4y455g6vrx5elvtoujht4zexuwoil4voiojs4cbg6ypkrwdpg@zevhspkgnpoe>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-7-Liam.Howlett@oracle.com>
 <29bfe4bc-b60b-4d5d-a915-bc835312c989@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29bfe4bc-b60b-4d5d-a915-bc835312c989@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::33) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BLAPR10MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: aec377b2-0c70-453b-5c71-08dcc1e3acc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fiprf3rwI0chEx1HR2JQoVeury3nXBjEmUqxmca9TWCt4+UOF6ySz2tP+NDe?=
 =?us-ascii?Q?n+wNpQrKsEcw5GtltDkfr95bacvMHh8eF42Em5LHA8ecCCiwj6I9c2mblwPs?=
 =?us-ascii?Q?rthindilKpjuVcRNMY//hvQKA0haFGwMD/TyC4mhzHdKrrE3yyfi6vuzh6m0?=
 =?us-ascii?Q?R2LEfXZV0lHAVuJKTAbFkaDVgseg+09mSDLgwvKuot3d5Dn23WHTxau/vUm/?=
 =?us-ascii?Q?ymNFWWrYn9gPQ7NxmcFxnmJ7dkkf4L1b5kc8nYx8SUmOo1gtx0Z1/bQ1oOmE?=
 =?us-ascii?Q?9lcupt1aidb7LPsrlF3+wvFNhtNm37pU+UBah0Sw91nSgVjAQ/wCQo5/brFF?=
 =?us-ascii?Q?YOUecRx2I3BpVX8pGFY+m+ahgwEZX52DROuZHfqJnXEK7LufAOwBvWSeoKgx?=
 =?us-ascii?Q?KAcyoeHtHGugD4pb3lPYFPEKPNKPmvuyTxRi2jsEOBPttRMRGeSfmLvrTFiR?=
 =?us-ascii?Q?ni+gAlIvO96hD2iBekqxS4q1OfAA3pixFVP8U8ATNC9t5L1Aj0kUL/pSA0h1?=
 =?us-ascii?Q?srr+Gv5i+f7bqzlBuMsTUXYwcUeeLfOxm1cPfagnH7V9AM29iDizouBCXxt1?=
 =?us-ascii?Q?13m0b2u/vDF70Au2J+uwb+gBT3dy8LLgMciQt00TGVNZmC0EQAXPvKTsqzHx?=
 =?us-ascii?Q?tpMdkBGW+PXVbaARgZBbVImdQ7B98y6fynDmzsW23panbQjlGrQ5GSbPPXUO?=
 =?us-ascii?Q?fWoSOu2aCLo5vagOI05/SPLXrfyB3gedpSFCZWQWA3dq7HyVz6S3eLKkVcFv?=
 =?us-ascii?Q?lUGPIJbE1c0yAM4swPESx140LOsoYlXtrkEAaEd1DxZwaLX/kUSpPbjR9gZo?=
 =?us-ascii?Q?WHmGjRQ7//z9KTrkXbqQ6l9pnGPzIjIT0PsCVX82nVPIiCQola7k8CP5kfGJ?=
 =?us-ascii?Q?38ZQzDadUnQFvWzwpiUxZb34pY9D0E6GLYmYmIhFVKCyaHQtJ2mDk1eOcVcC?=
 =?us-ascii?Q?IxSpr8KXSSB4wPDzDI489gfhpuSGRFnOBjDmXmzJ7cZYhhc05Mp+NmSIPxeJ?=
 =?us-ascii?Q?IbfDohRW9SPgWzDe+iTT301Ywng21m2HdXuPYak/fbFOlp/9FzhPUIaNaDmR?=
 =?us-ascii?Q?PM7EGBihtFtsnqLxW87BYGlQZkojVZXgbRL5kg5PZK2LSYA2x2y0HO6afVud?=
 =?us-ascii?Q?L2JUJEgQ58Z6XIFcwQ600aM+s9LyxCdwWSW143gkCkAVmEHQEZvN0cLzPEhK?=
 =?us-ascii?Q?r3whhkIl+lho+uNWWm7BeciEUCl9S+Vdu44D8ahKvh5Kb0KmUH8LSccb/aYe?=
 =?us-ascii?Q?Ci+u+VpjWTcnnbMGb5BDPyWpPxfyM768z3/6zBBoO2Ujddodw5aaQ49IHyAb?=
 =?us-ascii?Q?1wUDvx1mFfk+yJSleqfupIn1TrfpNwD8S8S0EQ696mz7LdAhCwGUSaPf2xLc?=
 =?us-ascii?Q?DuH3sqI9lV6bSXFNJQ6a5cG8aDQunxrUzWvJvKoBdA1TH/sEmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzoCtlbEHeyF/jEWaAjZ4pd4KYGgkB4N8V3QOILzk3pPCE93ajkHO7s7uV1R?=
 =?us-ascii?Q?ou6cGnTCsLwL+0SJu6JhQPuiJ4yTMzba3s1CM+D+Kqd26y4lEuWlGHrCvI7e?=
 =?us-ascii?Q?JA3IzNQM2m5GaEu5Ase+5vNAbG0wFdA+hm+mQp4jKfOc2LF8S53sxBoTIKar?=
 =?us-ascii?Q?Cl+hLXvd7ZW7uT5pWEw998johbbBGyMmC/0rpnqcibYy1aeNS7AN1T49eY/A?=
 =?us-ascii?Q?L7EKC9OOOQrSUetSfffSXnRnTdzspCZi38XynGGpSc+Y7EMZ7mghxYrp8fSt?=
 =?us-ascii?Q?nn6uKUiSEiAaGVjfjh1fOf+72yBhTs3LfT/yZ8ML23S0bO8ToXE+7Hcotmy6?=
 =?us-ascii?Q?ySQ6cBfKjkcimZTX/2VwWHqPPLBXfufcSNRQ/GzlMg0PXikXjjXzl0Km/hKv?=
 =?us-ascii?Q?SGLYUO8C7FdL8Tc01huA+Q0tuuig026HrZmdYzgBgJCf0D94RqwWQWojiSRd?=
 =?us-ascii?Q?JRFemwkZ5ap8ZTqEuTnkMDbh6kowrovzp0mmkI9r8tn3Pswm6M/V2lBhlRK8?=
 =?us-ascii?Q?RVgpUKPI2cjyRlKeTUwUQNCSB4/6yIo7Y1fBizDBcS0IZ2YCKbaG2J43+JZb?=
 =?us-ascii?Q?WQX4EFVcPgMnJK2gau/X7jodEdmVJ+MZrNBMcS9DNXHbaS48L59uLBJB7N8k?=
 =?us-ascii?Q?HJRHx8EcYHYDk1GRSDgKYf8Hm3UVF7AbjioYUQv0k9e1YDZlrFP1WwujoJYw?=
 =?us-ascii?Q?cbOXCHlhdzTqTn2lOsGY6NFTUJCa82gZ/+yXGm0VoQf3zy4A0F1JAtS5Zy5Q?=
 =?us-ascii?Q?VVQIfzK91V7QmJBmZAzyfMVjzRbUO7JaFn6u5qcrbyBHr8o+WaupanhXm05n?=
 =?us-ascii?Q?yqQswO8hDIh3UxPO9RF2vL++nis9NOwzDWtcnDssM8njDp5oavioeos13BEO?=
 =?us-ascii?Q?RS6ryCwyKa5Jd+2NALqEcxdKJz/uuZPG9bMGodOFupf+ufisJvEHnqLdYKSY?=
 =?us-ascii?Q?kIg4PaAQRxcOeoubaqiDrLGo/oRbzSzjQZuU0783nATi/YcjKKB85+F5Kx3j?=
 =?us-ascii?Q?Kt97uGjX32LWpcZN+k9S89KVR3TNv24HXDs0ZCqhrjP7IvDfe1T1b3XgTK5Y?=
 =?us-ascii?Q?A4NtR0hW7iurO/QVd5W7y6GlzkJWgRWa+pH5Qoviwy/0ISLSpt/ElLpVCsJI?=
 =?us-ascii?Q?Mavw8GsoKVqlIFgbr/pDqeowupvG2+VLPnv8gp9B33kwXmp+DobDPcJGtAG+?=
 =?us-ascii?Q?bQt7ekBqD05A9sqnzdBnUf9byNekZXF7B6mSZyECOfsROrwoH4GbS/nAn5MR?=
 =?us-ascii?Q?PQeA4qiX0ne0QI0jLiRPeJ5LMCkimJd7I5SMnoHRt4Xm7yPkxlWUFEoEJz4G?=
 =?us-ascii?Q?tDL4lsrkb8WAYM9BCoH5fGtpguwYRb+5H3T7zbKiiHq7fYu7zeUR+yzQGXy7?=
 =?us-ascii?Q?hOxBAuvyqlqQWv5peyriyzOYaofyNzfOIFEjeLqmJsoLQFisRrgJHJUvaQYa?=
 =?us-ascii?Q?owrFK2M3O52Wlr5TKeUXiR9d73qHXfzuIAkP6pD0Yx4votl8LnfPKYfEpF4R?=
 =?us-ascii?Q?2kWHUAXg6QN86MOqMDIqfXkReZso0swvgF2ZkdIaQ6Go0BG4MKSzeXHoWhvF?=
 =?us-ascii?Q?QEky9ozPcZxE8riqxt9AYBeFqw94Hrj1MhduFT+OD8pVUWJpGu9wyYjFB4X8?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cQtOgUPHn/vfXFKHX3YTQ/nDFE2sRSqtJbfIsYrwj4BXrE1igpzJPczr3EMeS+tZRRmHDuxFScJbFHaoqDHKGG6j4QpCtaRS8IfNOQfpJt0/1GNHPiMWrfSIVtgOqjT9aQDFpkz5J60LKq5zK7l3Ome0tB4pDmYbdIHdB9SwNYeCuW20Ds3T5dL3l5fFE8yg93f5zKXCKq7v2nA0fcGP2fG9bZ1pzYq1EHw3GWybUXSTlvdfsTG6c0bvxkPDAvWzACqaIWfStGHJ6iKz7QOy9WH6Bpf9jwLf0MlyuNJh7wc//3o6Jgy+W83UMjitxXoWTqAxNdeDCNubCx8t2CoXJtaOWNP2Vg2NHk1H/AIJu0l5OAYfnMY95xJBPIVgLvo6rBSuE192ZI4pluPBYqAE3RdukV6zpPocF5YSFw2ACrc3GKNJqu7LZh5xxfvjFYRVmyxz2zIJhKWaMxkKjJaSjflRHYe7tfHYbx89h4Zmnc8YUdkuhWUhS0m+irRYH5QCrf4bXd44tFtwEBaWGpK6Tx/Jpt7+UaQu0/EoRcvdMk/pxKsw3azgWCqO5+k7Gaj98pyh52dFy1DiUTlmx41G2sKhSycCJUse5/woGKDMQxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec377b2-0c70-453b-5c71-08dcc1e3acc9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:17:58.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhZHOHLW5HwiPozdTj3qMtVvQmEpBBuXC2A5fudxBt2zPcJCcoHKS0BoZwM4BC6zcDuP/+lwXpr+Ue0PrbUj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_10,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210096
X-Proofpoint-ORIG-GUID: 9Nh2cGwaamro08t7xU7Utwye2opkahLh
X-Proofpoint-GUID: 9Nh2cGwaamro08t7xU7Utwye2opkahLh

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240821 05:59]:
> On Tue, Aug 20, 2024 at 07:57:15PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Clean up the code by changing the munmap operation to use a structure
> > for the accounting and munmap variables.
> >
> > Since remove_mt() is only called in one location and the contents will
> > be reduced to almost nothing.  The remains of the function can be added
> > to vms_complete_munmap_vmas().
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/vma.c | 79 ++++++++++++++++++++++++++++----------------------------
> >  mm/vma.h |  6 +++++
> >  2 files changed, 46 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index e1aee43a3dc4..7b8b8b983399 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> 
> [snip]
> 
> >  	mm = vms->mm;
> > @@ -731,21 +708,26 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> >  	if (vms->unlock)
> >  		mmap_write_downgrade(mm);
> >
> > -	prev = vma_iter_prev_range(vms->vmi);
> > -	next = vma_next(vms->vmi);
> > -	if (next)
> > -		vma_iter_prev_range(vms->vmi);
> > -
> >  	/*
> >  	 * We can free page tables without write-locking mmap_lock because VMAs
> >  	 * were isolated before we downgraded mmap_lock.
> >  	 */
> >  	mas_set(mas_detach, 1);
> > -	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
> > -		     vms->vma_count, !vms->unlock);
> > -	/* Statistics and freeing VMAs */
> > +	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> > +		     vms->start, vms->end, vms->vma_count, !vms->unlock);
> > +	/* Update high watermark before we lower total_vm */
> > +	update_hiwater_vm(mm);
> > +	/* Stat accounting */
> > +	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
> > +	mm->exec_vm -= vms->exec_vm;
> > +	mm->stack_vm -= vms->stack_vm;
> > +	mm->data_vm -= vms->data_vm;
> 
> See below, but I bisected a bug to this patch that manifested because of
> miscalculated accounting. So I wonder whether it'd be a good idea to take
> this opportunity, when updating mm->... stats to add some:
> 
> VM_WARN_ON(vms->exec_vm > mm->exec_vm);
> 
> etc. for each of the fields updated. This would help catch any accounting
> issues like this with CONFIG_DEBUG_VM switched on.

Sounds good.

> 
> [snip]
> 
> > @@ -824,6 +807,22 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  			goto munmap_gather_failed;
> >
> >  		vma_mark_detached(next, true);
> > +		nrpages = vma_pages(next);
> > +
> > +		vms->nr_pages += nrpages;
> > +		if (next->vm_flags & VM_LOCKED)
> > +			vms->locked_vm += nrpages;
> 
> So I bisected a self-test failure, memfd_secret specifically, to this
> commit. This is because you are double-counting VM_LOCKED...
> 
> > +
> > +		if (next->vm_flags & VM_ACCOUNT)
> > +			vms->nr_accounted += nrpages;
> > +
> > +		if (is_exec_mapping(next->vm_flags))
> > +			vms->exec_vm += nrpages;
> > +		else if (is_stack_mapping(next->vm_flags))
> > +			vms->stack_vm += nrpages;
> > +		else if (is_data_mapping(next->vm_flags))
> > +			vms->data_vm += nrpages;
> > +
> >  		if (next->vm_flags & VM_LOCKED)
> >  			vms->locked_vm += vma_pages(next);
> 
> ...the double counting being right here :) so I think we should drop the
> above couple lines.

Yeah, sure.

Thanks for reviewing!

> 
> >
> > @@ -847,7 +846,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  		BUG_ON(next->vm_start < vms->start);
> >  		BUG_ON(next->vm_start > vms->end);
> >  #endif
> > -	} for_each_vma_range(*(vms->vmi), next, vms->end);
> > +	}
> > +
> > +	vms->next = vma_next(vms->vmi);
> >
> >  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
> >  	/* Make sure no VMAs are about to be lost. */
> > diff --git a/mm/vma.h b/mm/vma.h
> > index cb67acf59012..cbf55e0e0c4f 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -33,12 +33,18 @@ struct vma_munmap_struct {
> >  	struct vma_iterator *vmi;
> >  	struct mm_struct *mm;
> >  	struct vm_area_struct *vma;     /* The first vma to munmap */
> > +	struct vm_area_struct *prev;    /* vma before the munmap area */
> > +	struct vm_area_struct *next;    /* vma after the munmap area */
> >  	struct list_head *uf;           /* Userfaultfd list_head */
> >  	unsigned long start;            /* Aligned start addr (inclusive) */
> >  	unsigned long end;              /* Aligned end addr (exclusive) */
> >  	int vma_count;                  /* Number of vmas that will be removed */
> >  	unsigned long nr_pages;         /* Number of pages being removed */
> >  	unsigned long locked_vm;        /* Number of locked pages */
> > +	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
> > +	unsigned long exec_vm;
> > +	unsigned long stack_vm;
> > +	unsigned long data_vm;
> >  	bool unlock;                    /* Unlock after the munmap */
> >  };
> >
> > --
> > 2.43.0
> >

