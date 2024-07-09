Return-Path: <linux-kernel+bounces-246555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49792C371
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB361F22CD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03618005E;
	Tue,  9 Jul 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l/BRMbQw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QpE0Y/+8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E998156899
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550647; cv=fail; b=luaq4gEL5KpEdX0CLf258zrsrmdQ40kjZney35YgNn+doYr9vygxAPXArXbPHwYP2jTnMnKoP0OEIB0Pzlvn+ujDdqugcgDACcDtS42dz5BlMjR7jTGewXcSPah7aC6m6KUXuMjfcYDZrZxdzmdJYtbBTruc8pGfc+I8MzNMBc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550647; c=relaxed/simple;
	bh=mpA/irj6LtDENo7GiTtV+is6XlPkuJ3jf31cW8ctQuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U1Apt3H5DSOdQf1dgw1yy3/lsc8ibR0m1atEu56L5izAYgn89kSlQaF6N61uBpj7xcfWsgeNZBxlW04ORG/3KTxEZ5Pf7EJLVTyNEIR6MvcdqLOMh0yKPZFtB9yEif/lqDeMCqrlhfUmUmhZ8TMNX/PtAADHlzTKads7QIKwyh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l/BRMbQw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QpE0Y/+8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469FtW4W025160;
	Tue, 9 Jul 2024 18:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4C+mVhjwa6S5XqA
	IJraB7m7bA2OC0QRtkROLVXdE5m8=; b=l/BRMbQws2DSCURNUUlrIzqSWHQ1bZF
	V6xlVVBGITYIaiq7zA6M4v8p3wBp295ePw9YdqdWzJ+s5uu08nA04ODYVEf2f2C6
	rhWNeWVZVhDxKnCKIlepvrMkqbHack73wi48EL+i+BwuhHfxepiKOVrY95Cx2f4r
	MnaUhTFqAlQyG1ilwFo6uJZuOlemP3J1WiAVw22DSUytu8+klPZJbVyjRV2w3+Gd
	d77ZFFs/pMUJp0HDZISum5slbaM3Wo1XAyLxPBYUqr8veBuY+J75qdvxyytrnjgY
	WLwWK4nJm3Zfw4v5XnfYnNqY2Jd++PHIHJ5dBqE3REmeSyJ7Gi4T1jw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcdp04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 18:43:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469HmHjq007882;
	Tue, 9 Jul 2024 18:43:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu3nrsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 18:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8N9I5r8bI5A3VYWjgzN2gNEYjhALd7xS7lq52jcxUO6YNqwP0cV2bL2NX7xVr6jHcL9DnwKqtH6f6ovloocin7WTy1ODyc1yjWrg6mzDCfWhq4+awZ+dJDcmTYL7ePV/HT7I09XgI/e4+abIavKOKSOfd8JIeVFMfiaU369bylZ39yF9EuacSWeFc/vgkan6ngLdsrGa3VgmOmSCHc/4aMMLSH4pfyY8w44dG5vhhy4f+ha2OCDedxwBsGxMTczU9ful60hySiy2P8kZTENmgE8zhFUf8LDA+z2M+bbbvcKLvrEF7vXSV+eNkkoMAk9ZhOIFrz70tEEKhg9WAUl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C+mVhjwa6S5XqAIJraB7m7bA2OC0QRtkROLVXdE5m8=;
 b=Strd/Tl18zTsMs6RxwVhUYHa+SkhNAFirnbS4PGC7RyZmijiLir6yFlR8esCQKdiLYgpBezChC+PnXqLT1sgKW56TcXAOOrwlws7WCIPCW7Fbq9FO0mrfKJtxEvFyRklQ2FTvxIk+CMV/hN/1FlbDrrzq5zrkw00UOpvGrvs8/v2rqLcqkJUmipF2G69WlX2NOgRWA/tHwxu8BZVDS1cy/5CDPbzryOvTK+GULtPZ7D8MuiGuPLHlcFpkFAZ4+8gTMfGon+NhuYoC5buZOAyIjquRuvNvK9lxmWqHImqjSjkeyBWjb+F6SUTpfXm8kVHNfB+MVDYJvMN0D72daGttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C+mVhjwa6S5XqAIJraB7m7bA2OC0QRtkROLVXdE5m8=;
 b=QpE0Y/+8euiqQJngCXwbqYzfAYyyi6E4LBwWafPFRvP+aTR/MLrCmtbMztWqeJBT7vRZTMFwvBElfiOLigDKrXU59+pa95RUKKi7ZPeAsxa5yj7oTf0DD/Hkm7+veWCqbFLwZzzGPdsvLpG7dChBEiGXmFGkO/aYFiTlV/hFvx8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 18:43:45 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 18:43:45 +0000
Date: Tue, 9 Jul 2024 14:43:42 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 13/16] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <q2yygxyl2gtoy67fosh2slb3ufxzr5kx4dwhjs23cajpsmouod@luw4kdisi5yu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-14-Liam.Howlett@oracle.com>
 <867602f8-85bb-4c2c-81df-c15de15a2bf8@lucifer.local>
 <fhshsdxi4axwriv2od7lkqfzhhydccnwnov22caw5lgbfuy7mi@5hf73szoc3uz>
 <4c9b4ec9-88b3-4ca8-8358-734463533078@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9b4ec9-88b3-4ca8-8358-734463533078@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3803a0-8a23-4d4d-b5b1-08dca047100a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ab6RFbQCIanxxUENVXvb8ABA2eVlaZJdU4PM5++XbG/qOB/6VvgbGr+tlO3F?=
 =?us-ascii?Q?3ReR4tHS+srAKjvJn2ojFuV7A2fXEchtjGRmXFuVxIueIUmm5rXFG4Gu2Kfj?=
 =?us-ascii?Q?V+r8PtPc3IgoOetJp6h2CcVGtCnTIbjzEwJJtQOacdPyvW6LBuRdUPEoONIO?=
 =?us-ascii?Q?i7AncrXngTod/IWuJBL3JCMEdAENB8sUFSdu8VZzrlIjHiANoqUYEC+Ejxve?=
 =?us-ascii?Q?Or5eICsvZBzRvc5koS+ZZRFY8oA2LjQHYR/CN3CwZ5aq/RL7JCAZfuN8Alvh?=
 =?us-ascii?Q?pz+ULGC+eI8zYfXNyaZM+CNfnsFWm0P+G+42cM34Q6Iq+VEetviQ4OBS4xpo?=
 =?us-ascii?Q?JvCpHPWkOtN4UXHYm4+o5ea+ZsAs5Vu2pHsG9eQEtKvWanaTODU/5rPVWuVd?=
 =?us-ascii?Q?Qa3A83v7OINRpGhtf4r4PJG4boUVjB/ahov0TbZ3qaUUruYHNRGPEyU8boDL?=
 =?us-ascii?Q?SZ3Gf1rYUxTKA5hBWcXEbQqQ5lhBvBSViTbu4iUDDG1VUccs9AbuJQG/Fayu?=
 =?us-ascii?Q?OU42pJEDLNq4VyJQUAOO8qhXubbic0osHLkJHXpm6e9+aZOWpqGYe+5h0gww?=
 =?us-ascii?Q?ug/6tP+e/aG5rzayTdPs1dvA6Y6dh45i4LK9po88Scrj2RWNLI9R7DRhyqz+?=
 =?us-ascii?Q?/enA0UuqT1gQZNKeI2mpvXlQgKcfIAuoRb5S3LuYH2S2MPXtg+64M269OpXb?=
 =?us-ascii?Q?su7l6bQx6DoWA0wsLBkr9H6bmNGEGxG79BVuRikZrO/VYiNFG/XaGIr219bx?=
 =?us-ascii?Q?W61kc7RMt0H3SgV3P3QvnkDLH030FbFKZcbtMuOl/Z+fVGjgwIQt9wLRNcH8?=
 =?us-ascii?Q?nH8B6Wx/LXldDgSLwbAwIznskR4xd8JskNlFMcBZw14Iet0CXz6w0vhBeQwV?=
 =?us-ascii?Q?rcHN1V9z76DVreugS29rD3t1wggTn45UetByxinJCMUs0XhpHsU4oPDVPBJk?=
 =?us-ascii?Q?MSws4KTL/cPQ0XkARrIb56fc4ykKiiuOHNDaAT/OtZgGWdaYO1tuJJYRRlhr?=
 =?us-ascii?Q?PXOskIbfIhin+kHJ4OXThfEvXUuo3cMhzm09KVmc/a3jJmjmCdrsN6wzVgkW?=
 =?us-ascii?Q?KoVzwqmsDetjcCD8gMzdpdpJzdkrNkjjnqgV4VtmhgoxPBBCFLRINJs/e37O?=
 =?us-ascii?Q?kjFeAvMKvrCB4z0s6g1r2i2rrWUZ57K1smBLIoUumZ9DEoOsb2YgyGbyzIES?=
 =?us-ascii?Q?GRl8GCGMClV2ZTapcAFmkYaaQT/Rvx5GI4eqgWfLEjQLZbIq5gIW34bykOrf?=
 =?us-ascii?Q?6i2W78tmg8BEcYQ2EVs4tKlBMWHgYwfrNMAginJCAFvQ5Cz9BiOb0Kft7mNW?=
 =?us-ascii?Q?Y5sC+I2DIgjFcYYwPBAgDoaFgPjZF/cHrncJBeGIX30rtQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pyjKNxdz6/f2C6jjcSWnbk6YpQJN7qwp50AKF/sW/wOdcwisV3lgdcTaFW3/?=
 =?us-ascii?Q?5n7u6Xs6FF1fK9ieVlmc+1a3JyIP/T1GmwL0NAnm97Wv345Bp9h8FMVWZbof?=
 =?us-ascii?Q?o/iayI0V/ec24L7PArozZfLo/RHm5SA1jPNRxtaL3kcSMJDM+sZdm9uN0TwV?=
 =?us-ascii?Q?//210CuCbMdPilcVSgRl5EGoHpe4mO7DHPhAifBeNY0FoVal3qLTjn6XbPEq?=
 =?us-ascii?Q?8+3cISLYea2UCe2EdFb1xLKiQKx1QwFD3pgrvgfivuj8ZZtGcrN1dAUxHBSN?=
 =?us-ascii?Q?z/EzHi+8k5eDk8ordxeEq/PNF7ASzs2t5LlsWS7tVFG3qPaw62C8rTOXQM4L?=
 =?us-ascii?Q?IvaU/CAJSSC6ojLLGks0U+Q/gWIGO7W7xNz3+SAulcsh37k+em/C3oVafAtP?=
 =?us-ascii?Q?EJ2i7mcTXYolD7fObG+r67/X6ni8+7m2X7gTZnZyphwjBVvHzocq/yK1Q0fX?=
 =?us-ascii?Q?q1La0Zu/gKAfhOnxjQPdFTzAI5OR4tcTWVHhrbA4INpK9Oh9b+ucYub/Wczy?=
 =?us-ascii?Q?c5/XuwIqf4dCnLctZXYKVYfGt9FQrLaxAqGOIjJLRy5WgZ0FFmURBx9OiBpg?=
 =?us-ascii?Q?tTRPmkYA5YKteRIuAaFlcROnDj5D3EopgyaGi0ikd8IVLqq7KFdEPbjjfNWl?=
 =?us-ascii?Q?6J7/mqX9PRQDBlV5ueEUjIkAPRq8+rkyPLqLVyZkmzXuHTo360lQXYnrusw0?=
 =?us-ascii?Q?O5La7EGKlVrxcup8T3saNgtKJX+ztoTEQbuHvYoELlUd4FaOXuonhVRHPLzh?=
 =?us-ascii?Q?IzuTHDxSQX+radbpQV3uy2aer1dAPeGMxBgvvP/u8+VKIDUPL95e54+PvM6w?=
 =?us-ascii?Q?Mar1NuPQyW2RvV0biB7V0BeKgjQVmdWJvqzzpKDGm3xtwtuIRC0Lzysal8/U?=
 =?us-ascii?Q?X7s80S5IBcGCHmGWukMdqMHCuVJtKmnad8x3TXRWGipunvzrdvb9DySKryo2?=
 =?us-ascii?Q?1zJTbjlFmxwd+EQqYoYRgByXaFJsw1I7eZAk5Ntc73c9cBLfhW8FO4ql/yI3?=
 =?us-ascii?Q?Bz239i8KKW91S5M0i/90OSOvSWfLa3NLs5XbJVGgw96mYRVpcNlKQteElh9O?=
 =?us-ascii?Q?9J3wZ8O/fT6NMrID35cukYyq8xntQG49cmRhBEJmr2L9dGsddce8s+GTK7Wj?=
 =?us-ascii?Q?irJeSknZFVSA5ncsqkvMN2nwDKi7KD1AqKbUtym9IEhGDex2gIpY0aSdaIhk?=
 =?us-ascii?Q?VAm1uYY4dGaN0aNKg+ZKKtdW/cNLME5H1jZDmXXTFbSgz6WhjdjMhlvNEdI+?=
 =?us-ascii?Q?X+K73xt/Oo/FNXYm9inuDL45NTsgHQAj/TrGCMlRKKicyHsRdoCeC3NLQG58?=
 =?us-ascii?Q?vGHjh7ug5zf0DWDiO/wjr+afsgfCTfgvKP/vVA7D/yje7ZveKLmEy0ZP3lSQ?=
 =?us-ascii?Q?wjGPQXdKJIFSVzH/ssDSoYK7H/1V3IqcPP69NgC80OhhZz5EYivskRxDX/PC?=
 =?us-ascii?Q?TfTILJzzu+ljsHUpk9NOwUYzbNuu3NhXO147DdM3jcc18shcFt513q8nuUwb?=
 =?us-ascii?Q?713YZfipsG0juQP0PMl/K01Sr2IVXeeXdrBeLqnPqx5WqxJFn+OWx0EKO3Oi?=
 =?us-ascii?Q?43PuBejckurvRLqQnAgL0qufatSq1u2MT+Ot/jKrcY8F2KoEd1ESJW6vmDWe?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Qb4FpBsYZ8S4CXYpq9608+YxuvgnAp3rADuI+vpf6YxQaRQpIwAt9F8RfwoAqklCqWGyDeYugZkA+Bv2PRbHuBPmmZgedbYBEyB3IE8W2fXdoPhsTy4ALwY+HZ04kk416PyLyj9a/r0G+A1fDHCRsYb9jjj+mMXF8uiMj3m2ck2OZ9KLeU9tb5iqgV4Tn4/67ZawwdJvSAKKdo+Z7L+v8Afuju0XrOXsDinW0mJY9nl3UQCg1P1zv1S21Vd3t5aMyVRCrJoNjKckTzjjM2UiEuYjhEW4M+Ca2Avvq2ONr7hXFpfZ1/BS6uyMEpWEX85ohnIF5Bo6gxiKhbiYjdhGo6e9Hg/2nqXCCaPZNWCLeMAwKdJlX8EuojhfMTzhAGbYqlpUC22MyZx6PmVFpHlCS677MVngqFJqJmNUOQVc/Qi7MICFrTCgt0bkD4QgIx8zLx1fk5Ge3RthgwIIqmg5gpI+CroVeRvBOAPkFzYkwtsYHRdpUTfj892UNuRwkwq3cwRAAmTCPNKwCxjKTHP8aFhDqkYEYBbHmnSXpKjcMA5k2RAGOmfPNK5DHVjlLzTjpXdfiEn+9RaGIwVhfaoU1Jy5Tb5GVB3dJ4ayVvgy8L4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3803a0-8a23-4d4d-b5b1-08dca047100a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 18:43:45.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ia0gcMsyI6UL94p/MtKSxqEPAg1kLfPOxMZ/iSwSWHY+B5UlmS10+VXP8nlRwAbkpahQerAWQE4id+Dzo1zK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_08,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090126
X-Proofpoint-ORIG-GUID: F58H6S3jpcL8RX8TOGPAKFq94CMkSrDo
X-Proofpoint-GUID: F58H6S3jpcL8RX8TOGPAKFq94CMkSrDo

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240709 10:27]:
> On Mon, Jul 08, 2024 at 03:10:10PM GMT, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 08:18]:
> > > On Thu, Jul 04, 2024 at 02:27:15PM GMT, Liam R. Howlett wrote:
> > > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > > >
> > > > Instead of zeroing the vma tree and then overwriting the area, let the
> > > > area be overwritten and then clean up the gathered vmas using
> > > > vms_complete_munmap_vmas().
> > > >
> > > > In the case of a driver mapping over existing vmas, the PTEs are cleared
> > > > using the helper vms_complete_pte_clear().
> > > >
> > > > Temporarily keep track of the number of pages that will be removed and
> > > > reduce the charged amount.
> > > >
> > > > This also drops the validate_mm() call in the vma_expand() function.
> > > > It is necessary to drop the validate as it would fail since the mm
> > > > map_count would be incorrect during a vma expansion, prior to the
> > > > cleanup from vms_complete_munmap_vmas().
> > > >
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > > ---
> > > >  mm/internal.h |  1 +
> > > >  mm/mmap.c     | 61 ++++++++++++++++++++++++++++++---------------------
> > > >  2 files changed, 37 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/mm/internal.h b/mm/internal.h
> > > > index 4c9f06669cc4..fae4a1bba732 100644
> > > > --- a/mm/internal.h
> > > > +++ b/mm/internal.h
> > > > @@ -1503,6 +1503,7 @@ struct vma_munmap_struct {
> > > >  	unsigned long stack_vm;
> > > >  	unsigned long data_vm;
> > > >  	bool unlock;			/* Unlock after the munmap */
> > > > +	bool cleared_ptes;		/* If the PTE are cleared already */
> > > >  };
> > > >
> > > >  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 5d458c5f080e..0c334eeae8cd 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
...
> > > > @@ -522,6 +526,7 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> > > >  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
> > > >  	vms->unmap_start = FIRST_USER_ADDRESS;
> > > >  	vms->unmap_end = USER_PGTABLES_CEILING;
> > > > +	vms->cleared_ptes = false;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -730,7 +735,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > >  	vma_iter_store(vmi, vma);
> > > >
> > > >  	vma_complete(&vp, vmi, vma->vm_mm);
> > > > -	validate_mm(vma->vm_mm);
> > >
> > > Since we're dropping this here, do we need to re-add this back somehwere
> > > where we are confident the state will be consistent?
> >
> > The vma_expand() function is used in two places - one is in the mmap.c
> > file which can no longer validate the mm until the munmap is complete.
> > The other is in fs/exec.c which cannot call the validate_mm().  So
> > to add this call back, I'd have to add a wrapper to vma_expand() to call
> > the validate_mm() function for debug builds.
> >
> > Really all this code in fs/exec.c doesn't belong there so we don't need
> > to do an extra function wrapper just to call validate_mm(). And you have
> > a patch to do that which is out for review!
> 
> Indeed :) perhaps we should add back to the wrapper?
> 
...

> > >
> > > > +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> > > > +		return -ENOMEM;
> > > >
> > > >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> > > >  		return -EPERM;
> > > > @@ -2971,14 +2974,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > > >  			return -ENOMEM;
> > > >
> > > > -		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> > > > -			return -ENOMEM;
> > > > -
> > > > -		vms_complete_munmap_vmas(&vms, &mas_detach);
> > > >  		next = vms.next;
> > > >  		prev = vms.prev;
> > > >  		vma = NULL;
> > > >  	} else {
> > > > +		/* Minimal setup of vms */
> > > > +		vms.nr_pages = 0;
> > >
...

> > > > @@ -3052,6 +3053,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >
> > > >  	if (file) {
> > > >  		vma->vm_file = get_file(file);
> > > > +		/* call_mmap() map PTE, so ensure there are no existing PTEs */
...
> > > > +		if (vms.nr_pages)
> > > > +			vms_complete_pte_clear(&vms, &mas_detach, true);
> > > >  		error = call_mmap(file, vma);
> > > >  		if (error)
> > > >  			goto unmap_and_free_vma;
> > > > @@ -3142,6 +3146,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  expanded:
> > > >  	perf_event_mmap(vma);
> > > >
> > > > +	if (vms.nr_pages)
> > > > +		vms_complete_munmap_vmas(&vms, &mas_detach);
> > > > +
> > >
> > > Hang on, if we already did this in the if (file) branch above, might we end
> > > up calling this twice? I didn't see vms.nr_pages get set to zero or
> > > decremented anywhere (unless I missed it)?
> >
> > No, we called the new helper vms_complete_pte_clear(), which will avoid
> > clearing the ptes by the added flag vms->cleared_ptes in the second
> > call.
> >
> > Above, I modified vms_complete_pte_clear() to check vms->cleared_ptes
> > prior to clearing the ptes, so it will only be cleared if it needs
> > clearing.
> >
> > I debated moving this nr_pages check within vms_complete_munmap_vmas(),
> > but that would add an unnecessary check to the munmap() path.  Avoiding
> > both checks seemed too much code (yet another static inline, or such).
> > I also wanted to keep the sanity of nr_pages checking to a single
> > function - as you highlighted it could be a path to insanity.
> >
> > Considering I'll switch this ti a VMS_INIT(), I think that I could pass
> > it through and do the logic within the static inline at the expense of
> > the munmap() having a few extra instructions (but no cache hits, so not
> > a really big deal).
> 
> Yeah it's a bit confusing that the rest of vms_complete_munmap_vmas() is
> potentially run twice even if the vms_complete_pte_clear() exits early due
> to vms->cleared_ptes being set.

vms_complete_munmap_vmas() is never run twice, it's only ever run once.
vms_complete_pte_clear() is called from  vms_complete_munmap_vmas(), but
will do nothing if cleared_ptes == true, which is set at the end of the
pte_clear() itself, and initialized as false.

Hopefully this becomes more obvious with the change to an INIT_VMS()
paradigm.  I think I'll change the name of vms_complete_pte_clear() in
an attempt to make this more obvious as well (remove the _complete,
probably).

Thanks,
Liam


