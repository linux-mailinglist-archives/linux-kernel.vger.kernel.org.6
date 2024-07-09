Return-Path: <linux-kernel+bounces-246070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F17992BD47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628B11C23B04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D519CCEC;
	Tue,  9 Jul 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KEDBAKpg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LlJSuB7f"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0723D38DD8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536189; cv=fail; b=e5sErEuWhsUXOtQ4kolkONO7ZSeM6bfg8x10Ie54lWOJFH8NLWlkaQdYivBxtepYfQSUnQ4Vr1crbO+6YKdBCo/r+0H4UNRrT4VbCi/diZH9pQDbC62RC0wLIhP4nqBRIULARc4XcVRXMfl/REvvFOAbQUc27uHyEvGMjA+fGj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536189; c=relaxed/simple;
	bh=Q6mCioEighQPqFKJewdFEcELYyiHvTPFz8o+X4FeLNs=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mr1dWDV0v4sejrFbtQydcU6o+lNiruNCf6ihuZsDdfiBUQ7vk5W0ApMxiyeI7GjggUTpfob6hiHhIaeI8gT9PBleta2PIRoHGmUKQ8f+Wm7y5SHw1MfU6h/b8nQOhcXzbNoKiVAOBymr/7yt+B7C+Dj7sPUPn45Ij3FXWNJLB0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KEDBAKpg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LlJSuB7f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT3Iu022003;
	Tue, 9 Jul 2024 14:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=OnueuZpS3Sm1sop
	Q5wMzUrnFAhLaXffUY+s5lIBEOu4=; b=KEDBAKpg6iOVOeiaKb4AMYcL4vTE54N
	1V3VfbJnF4gKY0mMv1T2HYfz+Tvd7uhwndmUp8g/6KX+4cH1Ve8dVinSnTbftI9R
	WtMgoLcFflGqXBWjcVtHTjp7C12K6dLLqCx/SC+hWrupQ7lypc4YbRhIyrrCbSuq
	NMYYgosRAQ/wLeqDKrWYrpzd3B2gIZJjhTBsWcqtfE+rX+MvNTX8Rc2C1kpw+UXW
	OI2MhkTPCekvpZp9SfLvM+I8bWUwPqo+F29I9JPEqmzJ/wdZoa4cfZlBYVd9N6pw
	JZhNXnVxdXnSmLz6IbiakyUIJTDR+sG2StXe+E3yT/kFMqWJAA/0xCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknn41g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:42:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469Di095037162;
	Tue, 9 Jul 2024 14:42:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv1e4bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIhD9INk6yrHMqvhe8eeqsgPaKOg+wT6WtgKSFSk1gZ6tsXnn1CW3ywL/N7G6e5TRpXSyBUfSGDgJ5YvB7Xq4kAwWXhq6TfPLlidy0Pl8aYTI5BPzzTNCRn+Wei8+1YxRd+U7DPkUesbv/LEaYyEmG76LBtIH3vhMRt9pVUdhmVVPBnKBGWL36F0unj/AIPsXdkBd1ZA+12b88FbZZxr8zqkqjssZvMIkNr2VBXgcgj0Ds8esOPsD5ehLdEq5DNdiYEJW7jOWbLjK7Wxd4yK8PbRii/PXEyHIsgxn2q7Vg+F8IcvuPv+hxvBlZuO3F0F38ui+tcFQve10mKKqzUQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnueuZpS3Sm1sopQ5wMzUrnFAhLaXffUY+s5lIBEOu4=;
 b=VXUCqcMbYIrN34f3jl7+ZDF7JgezHFqTQPs9ZLigJCQ1a8aHnZ5GJ3qNmgvP2M52D1r9lMlKSJIAGRoypmc8u9DuZaiR8ehstj+JRGP8DqOBkiIgqqn8s+eBnzA0LTmBBX8XDjiq2yBko5fBzA+XmQS0LHlG28Foa2P2V+SEX2pTfJbzbkq0btKm6V6Evgq2DDwAKx4dM7A2omAMLaFpMGm0TCV9HAHSc6IOIpkPwOZQHauwaiUBO0VSZXff9d/R8xkIotwf3cbGPImRABk/5QC1Lm/w+ucmnmibPaKUhgkgI2jE5pN3ckiuQa7b4s1b27cGW8q52hZhrGFm4BDU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnueuZpS3Sm1sopQ5wMzUrnFAhLaXffUY+s5lIBEOu4=;
 b=LlJSuB7fwJy2cXua9gDGc8nIWvvdB0t2OgYV52Ja5+zkhZkrdFznghdTXU8GGZS+YMOcop/m26mg80c+cdgFRJVjq8xeNYkErNtEQWJb2JbouFOA4D8Axl2XCSDuZcATHWX7RRkZHXFNtfSpt4H10VTKsXQK95FtT63wES35/b8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6494.namprd10.prod.outlook.com (2603:10b6:806:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 14:42:45 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:42:45 +0000
Date: Tue, 9 Jul 2024 10:42:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 16/16] mm/mmap: Move may_expand_vm() check in
 mmap_region()
Message-ID: <jn4owbmmjrthhmaene5lsnliou6lfoyrvn4cxs5mbmkvmd5qoo@banbwbsp3l7q>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-17-Liam.Howlett@oracle.com>
 <8fbb424d-a781-4e61-af7a-904e281eba8c@lucifer.local>
 <e5ldsusdn3som7wn2rw76wtrhnlrxk3vkyk3iyimh6qv3ptvwu@24zfmamllev6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ldsusdn3som7wn2rw76wtrhnlrxk3vkyk3iyimh6qv3ptvwu@24zfmamllev6>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH0PR03CA0437.namprd03.prod.outlook.com
 (2603:10b6:610:10e::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: d45920a6-0e1a-4762-0812-08dca02564f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gCoRk7vClH/vcnownrMlrqNbmOi5ou/xC4aSKx+dvjcfbWubOnsDa0s88+Uj?=
 =?us-ascii?Q?Lf+CC0Km1rAu/jUq2Cgi8SBluqhpjSg34kCpAEW2aQfADuEZGbwPRZsta6av?=
 =?us-ascii?Q?eFHuD3IPyHB6zo0YVgHDHOMWqJnrd8c8A8+ijWwQ4SKzjdnZpqFwzFOsIFaZ?=
 =?us-ascii?Q?UIY/dTN5k6ZlDnndGQptQWHnq8EnuPQrZTpFpMrs2bQ4UHh3+Z1XQ83Dm/08?=
 =?us-ascii?Q?a+fMBq/OEz5LCJqGsv5lJGD7ytdx1f2JtW8qj8zTN2qrRajSa2OKHDbsqdvY?=
 =?us-ascii?Q?9a90zsTXV9ycxZO2L8SE4SkGU6ov7pkSSzuO6SkBvBVX0TyKPNIudW3tZalh?=
 =?us-ascii?Q?kvpXnEYFMKPg8kDN4wJ4NylovknG1rLEjRVTmapPTFh6n5LOo7ctXBOxfU5D?=
 =?us-ascii?Q?IRglohW/PodcgCbuMtnUyaEbaGdw1lmQ9X4W1ym8yZ3ZnqJPrUlR8PNny08i?=
 =?us-ascii?Q?0AndYpQ+/aFhrIMhJWyuG5JSLTAnTfBBCsKcIlR2cSNzgUReY4CioqUaBh2S?=
 =?us-ascii?Q?ZEFbDINc2GJ1ePhFSI2IFinOBVSho0LYFT1UCp6d+GfFIruMJrbAHocgtLtm?=
 =?us-ascii?Q?BKm1aEkbrDkH83IiSFEc0OOJHi2b0ej+5fPcvwuOGR/+r8PlCsFtAk+7A0SL?=
 =?us-ascii?Q?stqJwdGZu+LDA1/1R51itM2g/U2ql8Yz1wJ8mh0u1fZKNAthqVFuoi9fcH4c?=
 =?us-ascii?Q?oEqEe/vtu3ryZkAHgIwROffdWeTW4mcNq8nIT+nW+q0JtihGPulsna6qDgQ2?=
 =?us-ascii?Q?q/F3r6Kd0eSO4UWy4+Ui9+/xtpCm/MX9vwrebtTA1E1Pyp4lESqaop+UXIiU?=
 =?us-ascii?Q?N9CHj8TmLk8mlAPE5HTuptPqKV1AoIjjMM5P0XBJZtqnz13KG5f0c7lIaYU9?=
 =?us-ascii?Q?5M9ZD5KJF1dIfOzBoZ84REf1SidE8Ii8FEPEcuYrQBoZnYP3uuKJn2CgbEQr?=
 =?us-ascii?Q?1FMmcCVLGVfz/lo2bz72x3Jr8z6E4rZKUpVo2DywchjZkVTWzD1JKj78Big2?=
 =?us-ascii?Q?lM6V6UrluDcuk99GApssFHDUtdnqEPjhd4oB8mDfHHtGG7RiINupgGtqTCjk?=
 =?us-ascii?Q?1Ea7eNO0jOnwzd3OPCoAdoq+KlBd4fKZ9OwGPogQSiZMKZfM6q3HR/fjgMbv?=
 =?us-ascii?Q?dufqw+rue8drQHGK0wTMMGycJ1UOxHI+7FMh5CxTyuyvzY23K+ijAwDFY+Iy?=
 =?us-ascii?Q?uNKS0v5ythjQrR4Uhm/AvScHt4h02zgxjfy1BBTd/Sx5VeFHqTNTu/GX4o2G?=
 =?us-ascii?Q?b/+q7Mi8dmuw2N7G2heWb0YaHRHrpYioO3sAenkUz0NbGWtY0F4xSlBBtqaD?=
 =?us-ascii?Q?iQldZS9KtbMYmDqalvlWm+wQ1UV+zQaKDQKAd9g1oK/X1pjKlZ3fcNzerAVC?=
 =?us-ascii?Q?g6FgR/G+K4l3BDj7PiTVSHu7cUFe?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pRISqTI2tvvSkXOip1a9NoCs0AMrVBO7j0yAw5XxOeLuIVNpG8nUabyw725J?=
 =?us-ascii?Q?yFyu/+/5CvfDH5CzRV6zj+n6Zy+w8VA8EEb/0buOQHUAIPLhgn4mG7RXrtB2?=
 =?us-ascii?Q?lP+dzhXlvSrO/ZOr0TJK7Yt6TvKDudIiUPzVn/ZvS5Agp1a/aIWcolLzmPD7?=
 =?us-ascii?Q?dPHT2w2tL4k9Qwg0uAD0mM2oEuBqAY1ZhqSb9DGoxuaMemBpfsto4342yAck?=
 =?us-ascii?Q?zVW9hysCvkocuEUdR2OZBDjpKfiGpzdd7UCaHVr8q8gDjliShl2DRxnemlfc?=
 =?us-ascii?Q?mslTavDBqLVvHbUXIUi/b26ds4Stq0Fe7VzhLLqOiSDsfBSVpKkvHlkgX87W?=
 =?us-ascii?Q?p19oOrLs/p/auHg6oNEYo5LlFAxAz73Gwa2bclv0++7rH0aw74gd39bFy+np?=
 =?us-ascii?Q?Y6UirxfjjDhliC3N14s+KgeQA72olMbKayzm2lIILD4VawIzpyLaFzXWGpjo?=
 =?us-ascii?Q?Tp0/aiLDDj/C0xCB7c6Kkn2u2dfHF1K2iP36Flg0cJNC0Yw0akEzil+zmxNf?=
 =?us-ascii?Q?oIrT4cmeWlAqpeoXrO7eTa5YPo9VvZxonVdg/gPuBdaPc9o9USEIuWRXaqfm?=
 =?us-ascii?Q?nE+YkunmEUfcCrs6Yy2WShBUhX6+geR8Jc56DCSPE8/1EmmaY6E95z7OS7U9?=
 =?us-ascii?Q?Jv4jTFJm6bC6jzr+2JaWhZKY+CQl6xwO8EpruuONcGiFH6GIJg47RkYlk5ko?=
 =?us-ascii?Q?v1ZZv+Epbigp1GExnUECWfyVXNfBcOl0hLpW5jgS9fBVmnGE7kM4efJyM7VV?=
 =?us-ascii?Q?Iefvi87O0xfZertjba0bbVz0iGMGBIK3KJ2dRljkBnWsAYkMiLHThNHsMpb1?=
 =?us-ascii?Q?cvq2wrZWOeqdFuhBWQvi4hlRQzNZTSd0U605wKYctCHL90AkzUKH+TN9jMcS?=
 =?us-ascii?Q?Ok4Z6ZzQj7KVtnFPYFBGiU/7VvpFH36BYzicINpFB+kI4el/6gzszqOegFC3?=
 =?us-ascii?Q?1oSEku1PF+VU5trDIjLVad/pFvrdK8D3wPbLugH63klgkj0d5DFprsm8oE3S?=
 =?us-ascii?Q?gDl3pE3bF+53ohSPRtU/QS0sKCJSVe4gGJjr/BNopNnmoYNWED50E65pu493?=
 =?us-ascii?Q?2vwr8eB/hzyX8Jdf3BMTU9GjHYIF6MLs4PEOpc5RIHUo2genjoFCgwI5IXcc?=
 =?us-ascii?Q?6xMBjbUnDcLZdm2x+/EPS/JrQBX8dKmwwXbN1Sr6J79srCJPldozAAhspL+A?=
 =?us-ascii?Q?3OtPlIZPEV9zwQvBuETcGp4JSbvxSvSAP56KpyZlRXOiKH5cGJrq6uL+S5Na?=
 =?us-ascii?Q?nViOuqnJDT4Pj9EuuuEbckCdcIUgS4RF6SEi8j+KwCvJGyYnQffwT0YB4BcX?=
 =?us-ascii?Q?2omcUh0GWJLqnCIfGD6PpUdybEo2110mIZb4PCxawTEenvpeVylF47AvDZC7?=
 =?us-ascii?Q?gJdfUMc/68wGOXwqSPsSg72uD8KVX35ciE9DKdtAXLAAdy5FpoO1Fqs5ZSjg?=
 =?us-ascii?Q?+1Kpe8tXX9aoqyUqD0hrs8ElxsQekv26Xq8ACeBmFo+vIeA4fHrtxMbdGM1b?=
 =?us-ascii?Q?aQUWjh1Tiq/mEOMmHLMMGd4BYGEvVh6myOmEnWOrVAg7Mir7iJgtyYIz71wH?=
 =?us-ascii?Q?1nVYNSRdIsxtl+vkgbP0KEex8v26o5GYVpam02bejathWtNF9s3g9Px8ghXu?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0oTe23cBAkMOVxnHyP2OXeaSnvxeEWhQD+WXJoOAL3kuk8jddZxH1/XdmJEubntePetLDOtiwfsJQ/j8otbTdhjXoaogiDJnCXaIfMC9Q7DbDlNzuGhWrr9BiWqFdixrAs8WEEGIReprdl+kdzOpPqm3fpMpqAB4uhJ4aq5dTBOCXIgDdvfVie/e3s2X+Sa7KzSPBmBTKbMKHjKKGkBEnWBZBPYDZjq3Mx9M/fomKy8lmh1LTSi6AGYfCbkx8wnDN1KwcJddH0joYdiM1VjXETD0PRRAiYnyuEpIrxz1xfl2zGUN0w5ppB4W5mVlryl811BybzBDNzrVhnn6X4gkTWXMWfqTyo/ZsLSHA1McnpaqxDz35ARhEKdSrf/P04vzv6/ilElnFX+lusZax+vK2DFEL97FjpqswyeYUDKu8a2aDggluiCei7tj7+z2TeWYZ67/Bb2iUfxG4/C8i+4cuFMjZ5HWd9cnlrty5GnG7OC9Pjhzd6twHR/d3GB8G8dvJbkI6RL1lcr0vNcHCkJbDvTNUEp3+H3NUpHGYFc/SB9WSBw/KimjJRO9sIY6HFIoohXqxSTi5Tq+EimqqPsPY9n1dFzSZKUP2fFAkHnBZm4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45920a6-0e1a-4762-0812-08dca02564f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 14:42:44.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y66zrHi+Ew1JelHU5LYeQsmZEwS4UUZ3yQAk4Bz0TUe6YDMVCgvatamAIWOYBWjIk0LMKCNOqgAT5DOI7VLFEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090095
X-Proofpoint-GUID: JvphZtmtd3Zer8rRXLSFbISVEiCKZHXr
X-Proofpoint-ORIG-GUID: JvphZtmtd3Zer8rRXLSFbISVEiCKZHXr

Cc'ing Dave Hansen on this.

* Liam R. Howlett <Liam.Howlett@oracle.com> [240708 16:43]:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 08:53]:
> > On Thu, Jul 04, 2024 at 02:27:18PM GMT, Liam R. Howlett wrote:
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >
> > > The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
> > > call, so use it instead of looping over the vmas twice.
> > 
> > Predictably indeed you removed the thing I commented on in the last patch
> > ;) but at least this time I predicted it! ;)
> > 
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > ---
> > >  mm/mmap.c | 36 ++++--------------------------------
> > >  1 file changed, 4 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index b2de26683903..62edaabf3987 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c

...

> > >  static void __vma_link_file(struct vm_area_struct *vma,
> > >  			    struct address_space *mapping)
> > >  {
> > > @@ -2946,17 +2925,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	pgoff_t vm_pgoff;
> > >  	int error = -ENOMEM;
> > >  	VMA_ITERATOR(vmi, mm, addr);
> > > -	unsigned long nr_pages, nr_accounted;
> > > -
> > > -	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> > > -
> > > -	/* Check against address space limit. */
> > > -	/*
> > > -	 * MAP_FIXED may remove pages of mappings that intersects with requested
> > > -	 * mapping. Account for the pages it would unmap.
> > > -	 */
> > > -	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
> > > -		return -ENOMEM;
> > >
> > >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> > >  		return -EPERM;
> > > @@ -2987,6 +2955,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  			vma_iter_next_range(&vmi);
> > >  	}
> > >
> > > +	/* Check against address space limit. */
> > > +	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
> > > +		goto abort_munmap;
> > > +
> > 
> > I know you can literally only do this after the vms_gather_munmap_vmas(),
> > but this does change where we check this, so for instance we do
> > arch_unmap() without having checked may_expand_vm().
> > 
> > However I assume this is fine?
> 
> Thanks for pointing this out.
> 
> The functionality here has changed
> --- from ---
> may_expand_vm() check
> can_modify_mm() check
> arch_unmap()
> vms_gather_munmap_vmas()
> ...
> 
> --- to ---
> can_modify_mm() check
> arch_unmap()
> vms_gather_munmap_vmas()
> may_expand_vm() check
> ...
> 
> vms_gather_munmap_vmas() does nothing but figures out what to do later,
> but could use memory and can fail.
> 
> The user implications are:
> 
> 1. The return type on the error may change to -EPERM from -ENOMEM, if
> you are not allowed to expand and are trying to overwrite mseal()'ed
> VMAs. That seems so very rare that I'm not sure it's worth mentioning.
> 
> 
> 2. arch_unmap() called prior to may_expand_vm().
> powerpc uses this to set mm->context.vdso = NULL if mm->context.vdso is
> within the unmap range.  User implication of this means that an
> application my set the vdso to NULL prior to hitting the -ENOMEM case in
> may_expand_vm() due to the address space limit.
> 
> Assuming the removal of the vdso does not cause the application to seg
> fault, then the user visible change is that any vdso call after a failed
> mmap(MAP_FIXED) call would result in a seg fault.  The only reason it
> would fail is if the mapping process was attempting to map a large
> enough area over the vdso (which is accounted and in the vma tree,
> afaict) and ran out of memory. Note that this situation could arise
> already since we could run out of memory (not accounting) after the
> arch_unmap() call within the kernel.
> 
> The code today can suffer the same fate, but not by the accounting
> failure.  It can happen due to failure to allocate a new vma,
> do_vmi_munmap() failure after the arch_unmap() call, or any of the other
> failure scenarios later in the mmap_region() function.
>
> At the very least, this requires an expanded change log.

After doing a deep dive into the vdso issue, I think it would be best to
remove the arch_unmap() call completely in a later patch set by changing
the two areas highlighted by Dave in patch 5a28fc94c914 "x86/mpx,
mm/core: Fix recursive munmap() corruption" back in 2019 in regards to
the powerpc pointer use.  But that's for later work.

In the above mentioned patch, the arch_unmap() was moved to an earlier
time to avoid removing the same vma twice from the rbtree.  Since the
mpx code no longer removes the vma and powerpc never removed the vma, it
seems safe to reorder the calls as such:

can_modify_mm() check
vms_gather_munmap_vmas()
may_expand_vm() check
arch_unmap()

This seems very much fine because:
- powerpc is the only platform doing _anything_ in arch_unmap().
- powerpc used to work with the arch_unmap() call  after the vma was
  completely dropped.
- The vma isn't even dropped by this point and so all proposed changes
  will be completely undone in the rare case of may_expand_vm() failure.
- The arch_unmap() call doesn't need to be that early anymore anyways
  (mpx was dropped by Dave in 2020 git id ccaaaf6fe5a5).

I will make the order change in v4 of the patch series in its own patch.

Thanks,
Liam

