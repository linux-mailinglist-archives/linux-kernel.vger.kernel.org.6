Return-Path: <linux-kernel+bounces-242841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E998928DD0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AE2284B94
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCECC17276E;
	Fri,  5 Jul 2024 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hnz4OqcL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ba/psZp6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53D171E5E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208142; cv=fail; b=Dmxd+2CfEvFwu00ijZO46qiKZLjOG5NPDILPWUHK0U8CUjb9WfSTlGAWt0/8qt+PMf3ZehI4g2ukSHjQ9cTC/26Jp22WPjnpsRR/OcCl+XBAdaq0CI8XkEHKNLa8Pkw0E2TOFqBb0e/xe36OgdeaYwUpdBsF9S7GJBIkWzr4XRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208142; c=relaxed/simple;
	bh=XULrQNHsTelF2lare2HgfEc6ThlPcSVemVWteDQbKts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I4RiAZP/X6FCylFXHiWRahQD+ZOMIFTY9Ujpy4SLz1cspdSUriLo3EuNOnb/3WDmsKeUXW061BYrPiEODqj2AAYemI6bW1M/q5MMYKWYRTbkYX7PCl7mSTaI3H8xs6rG8CZUDUTVsKpHryrpPh3tFqYzLW4Yf8ZYzMtMQDCo93I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hnz4OqcL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ba/psZp6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMVo0008296;
	Fri, 5 Jul 2024 19:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=sxYF6Imk07d5RcA
	Jrb4c6C4Scr2cSY+9DMNRdPXulPo=; b=hnz4OqcLvkCEBC/3lQNB87eVSUxJfLW
	ecemvIyTQRVKwFFXDYhabaxQtHuob9jl6h9069vBiDWHxRYr+9NJZcLBSIiTflgB
	/8UyzrwTfIf0dNTsCbBum7Rtg/rZDEOUHxyZcF8zZ6YBIMYygKW7Vdp1lT9JDRi3
	e0lgV2koJ9jLOquu0/DgOPkBPQRlExIjB/stk+xf1qCD5nCaI4apLcDD8wz2Es+1
	NLbQDaiwifwYgTzaHmRq/Z8/+Riq77o/evk6u0jJw4FvxlFEW+e9B9nNTizR8+Su
	mB5VIrg5UER6Cv0NPxvZBExUwIMq5eQWivNSOYiT7n+ck4fh5hbP0qA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029234f14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:35:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465IbC9q010936;
	Fri, 5 Jul 2024 19:35:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbpxnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP8Gh3wYC8kYUp+x3rXg04ZShdIe4nCQV/W6OrCdKuSWs0oVMsFWOwzCxJ6KyxUB3+QlbmxXAlRh0Vxpv4k4Q8XNO/HoFjvTaoBv77YapIh35hPInJzoUM9ezUkCo2p2lWFgGZXCwfkmZTOy1Gey3LBhnPJXJtVSpLPPshXnrhOGTfibtPbqzdVeZDVbgkv4GUGmhDT1/OyExBwtSXTCAEE/5eqsL9Wl5CxcJzak71i0RPvj4uzjvad1Peu8f21BIxoWL70goYpd4Vo9SeYZxqKpMLnfElhL2UTloA0OLYRwK2K+e3meryU7xuGkWUfjDYbMu+UYXkgqpa4PPREQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxYF6Imk07d5RcAJrb4c6C4Scr2cSY+9DMNRdPXulPo=;
 b=gUWFDqYOSiJZm+V/ipLIlOvu6FqZe7OBLhcfo1ljSR1IKjMV8KDU6I5fEsCSc29720Xh8+6D5GLtaXVsOZjlnR/Jsg7Of9VA7OaY6Nh1oS0mkZ4zCOD6/xakmx4W4yAtp7e/tt+kGOI1YXQwuVZk5dovbwOL6JHCa+cLkXcr+f01fcjmBucRalvsW2f9V3iOxMRtLIaiOWotgzhgxre+KvniDxs84vCsXnEd7j8QDo7Bh2xgY0vC7GQDkM6Zk73qV7oBavrV0/BP1OFqmOA0WlA89+GFebSXqP2swkbnDysAWMElstpjivbl6jyX7XdI1L+boBADeIfkHhu5NaUhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxYF6Imk07d5RcAJrb4c6C4Scr2cSY+9DMNRdPXulPo=;
 b=Ba/psZp63HouACiz9ZJT3dLhAcosLufrst8HXiOWCVc+7yd/xpRHnXTMUlowgCad+YfgE/4LFVRh0y3QKy096BMOQL2jO7F972CM4BNRhf1eSL0+h6P62DpiQ5FwwyHnv8fGwRxsrm9vSxs60fBsHnnjfTwEKPDhFx4aJPMw1og=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB5660.namprd10.prod.outlook.com (2603:10b6:510:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Fri, 5 Jul
 2024 19:35:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 19:35:22 +0000
Date: Fri, 5 Jul 2024 20:35:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 07/16] mm/mmap: Extract validate_mm() from
 vma_complete()
Message-ID: <0699b053-607c-4230-8fbd-e7515fd8454d@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-8-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-8-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LNXP265CA0078.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: e418caca-ab11-4938-c3bc-08dc9d299c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QGbwrwKgWLUWYK4tONv245YbQLz5wtpSQA+kGUWexbA6YmZhsiIJvl3DrtoF?=
 =?us-ascii?Q?8zErz7XgvWtVrE6Njwx2y4A68YKlCxUiqCnwjnJ9HU1jLLW61Vq4WJ1/HjW0?=
 =?us-ascii?Q?600LVfO6RZbsUeVAIozUvEdv6Y4I+oEUewsj6Tr0bfoS5ZSyagudSGa6n4XS?=
 =?us-ascii?Q?N5LWZEjTT/gVfNMcSVhCDXrZxwwOVfo1dectgEOO3/vc7QkbBRIR6g4YR6d/?=
 =?us-ascii?Q?ZnS8ZIREvE/EdKuHJdPBBREuHlQwp2PLHKOQ9codGoybdKt4fFvvnj3R0ouT?=
 =?us-ascii?Q?xtVSP3Tm2vG/P6tk/7kqOFS1gcx/uVsFOJOIZFGWr2k2fIoDLx0nRhFrxU4v?=
 =?us-ascii?Q?OixtRHSN1/mw/JYd2XO7BDKhy6z6PIcE4U9RryZ0DbPxQ6bX9BQ87Y3zx8Zu?=
 =?us-ascii?Q?jVuGUjmgxCStYyC756lwGTj1AY2aTEJveVGwwbWDuR/seYNwTsPZDDqNAiUO?=
 =?us-ascii?Q?7W9UqYohqCkUFJHowlHc80LxaD4Sr7ZfOaqjH6oGT33YKO2p/5ORerwzzJUH?=
 =?us-ascii?Q?lOLPDJZdF0xZAEgsObgXBI+JQpc9iS6ggmrqeybptUYTzG/3TFsMYcWM3Z+a?=
 =?us-ascii?Q?no0LukQCHQByEPJjS8uSepS8CNjBmDS6H91AXMAFi1eWcWxZSIo7WqFVEF41?=
 =?us-ascii?Q?YF3hiP+0EGv4iMyac/8VFpfm7nn6ym99MVF/KwxORPro8BlATT9LpwjdJSxT?=
 =?us-ascii?Q?buvGH49Dj6yKBSksV08G283YiqEbQLPvbXtr+VDJxftgCdBCKTIEF0CHJiMo?=
 =?us-ascii?Q?MnPnlfvC4jY0h0ei0MyossXyRXjQSXktWHcLQrtBdFvYmHo3UeXZla9WslJm?=
 =?us-ascii?Q?Kk65bDh81/ml9PAI3oUehhm2R4IYeJduGT6Fk5LKmhMZMku7u/Va/UOwofcb?=
 =?us-ascii?Q?welfy/Xs4TGgMKvARUf9ZWp23He1bdM3s+O0Efs4tZik230VMHIokdt2wrhq?=
 =?us-ascii?Q?iQS2KseERyMf87ICAavjShUSyVmvUh7I7N6dWZGGTjOsNzWi2FxVPm/fsb4o?=
 =?us-ascii?Q?DCjNQSouFrEfX/Cj11hGJ+KAslvcuUmFPzKxY9nWayxYHDqIVoOI7UNe5PCq?=
 =?us-ascii?Q?vJvsFFe4Y1UMRemH2SzoLTfv2CRXAJ4qFMYcb41AT4v9KZyk4PPxpAv8Q/5T?=
 =?us-ascii?Q?OFWfuRGdx2TjpuwWNcKPxrG9h0VC9OoszS2xX5Wv1h32KP+v0lrV8Zm3qLn+?=
 =?us-ascii?Q?FGkjQRQHZgsSiM0fYrh2/GEOkU5IZsLzwHzSdMP1LsHzmrRyUcaZ/zz3bLko?=
 =?us-ascii?Q?ii1eDk0OlAmfSvHSq2M8HUnrSeyl72lfvhId1BMktu8IJqKkdir7hhNA+YOq?=
 =?us-ascii?Q?RwTJ9xuPFZlV5EBWH7uF/uHyCeCQUdATPd2LQFX8Sb22Dg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l9ntHBZY9iD+ympDtvJ7TSNKDe5xgEoTr5EsnoHi7zJMzRt6tipDRAEd+5dv?=
 =?us-ascii?Q?PutPYSnX9cUMwOL1vA5PuEn21WacvlRyyflc0x+3g8oFpKg69k/9FS0Pq409?=
 =?us-ascii?Q?2kL119WEYGc5Uxr5CYJ93o/zUHoTHw9688Y+4zI+6DwvlSucjdnOGBfZxYiZ?=
 =?us-ascii?Q?01yAKMAmD1sPazp4TobNHMOE0HkrZk09I6chMHCWS/X7fMHfjsfBaDQUbdHv?=
 =?us-ascii?Q?Sdqz3mDZi4/Tp0v1aAMqEKzNXgIOxjjY1Vo7eLSSLsqVUSmHMNnwSyeRtU07?=
 =?us-ascii?Q?7Ry+Ra52hCpbVm3EzvXq71GwPLG3vTU7Nfk89gb40USo5lb+2JwNxkN9J+o6?=
 =?us-ascii?Q?iaV/hGpt6dr9AFtymvgXGo0C0HlP491DthpH3dWp7emRcL9WxO7XXbWeeEO4?=
 =?us-ascii?Q?7pOf1tmSc8Lz+9Vq9zRdM0Wa1yn5a5WRwABSwvq4axtBRpW00k1eRnc9gL9K?=
 =?us-ascii?Q?cNX2enDSQLKCup9ciGe/dE/ZEjTTjquaX7fprqAsGnwEqQHQ2tvxM+jhL0WH?=
 =?us-ascii?Q?AUVmHbTJMIHlRwZuBK1Wu80cZSFSG4Fm27mpiZUmnEww117bc8fafhHlsCCS?=
 =?us-ascii?Q?4inzuQZofC7mvPguQTVp477jrbMMD7ZBBMZ8rqve6d9ofMkfWk9DLYUyqHgs?=
 =?us-ascii?Q?ihOBqgY5n5+scUeeg9sW4t247RXlVI/s8xHaASZAJcmg0CQm8qjrWmfiGG8M?=
 =?us-ascii?Q?65ZavuIY0s1IAzPgX7/HipP6Ch6F6Co/5YZG4e5uDpxRQ3S9qfTSSTHXPAmi?=
 =?us-ascii?Q?ItqNSHeIRJaIFkfPZqoZTXeVwbmuo5g/kRh0U2m08SJjOiJ33MY99I/Mk9H+?=
 =?us-ascii?Q?JRD6YfAu1D025SlwUTkxPZsIzTTfOV5LF+sfd1g6z0o2NKhjA84ChZBITspz?=
 =?us-ascii?Q?S8V8IsOVi55lvyQgzDLk/fdEG+0L45FuoapjP4BZjiKZIVeULGpW7mrCxof6?=
 =?us-ascii?Q?Dx8JoQ2dhREPcm2OwwSKJHN6hRPHA/IsVI5iWrOYbqpaXli9gKSX7ZhiHJiQ?=
 =?us-ascii?Q?ef0RBSMx9X1n1U+NcrvJVYvOResnmrYSUmiBzDDIn74fVcxeInhw8Z8QABG5?=
 =?us-ascii?Q?bV3hCmpyM+fXkhsV0lQzxAVt52gO9todnXv/yH8/Rr8XDF2ex1v8aUOxbghN?=
 =?us-ascii?Q?4ptTMwwSFoo6/UuyTfc+muuE7TFq4jyNHhTnYRv5OOfdmwv4qRiHhIe64AGN?=
 =?us-ascii?Q?Q0E7L4Unz4FCPgQ+7g4OrxQ7DfP/cT1grXb3O0ehneEV3CHYi51oakUxp0mP?=
 =?us-ascii?Q?0Uh9/6XQ4TRjDr0ToNsEBXbalu57DXkMefQ4S5gGjIKP9lHDHV4f73VFLFZo?=
 =?us-ascii?Q?K5RP3kKR6qV9Z6eEAd+gTNQPjA0dqRvRNaw/Uo9H7VJQy6zE2iAiGqdg4qFP?=
 =?us-ascii?Q?QhJr5G32vzl4WriWtoDl1GwJ5U8/kxeCEHE6Ir4Tv+RwAqXgH0vZ86WR9J04?=
 =?us-ascii?Q?QG5Fi8k8s998IiygXq14NU8tu2EOuW2Wdz0L0AXbS84MChe9LGtw97K1oQ5d?=
 =?us-ascii?Q?z/B6gpqNo0sexIzFDskKXaY955wXJWiAx+JYHXWaYS7urcNueiY4iatVaOFT?=
 =?us-ascii?Q?GrXHcad+SE0aKG3S4MRGZpfp/iVR/mMC/g3qdJ0QPCTNf3ERBZSliEg8egKb?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pPHsjU9HM2kKed+rdbKZAxx0Xh5LUVNZ6Xt2TnKluncKb4cDGodkk0UZPdTEr1e0SS5DQ9Ir1bepxWEePerzISSMniTcInQFzx4qZ6qb32SkAzdiUrVV9QRcu4Y1WGAoYJW3vLCQxNlDVACe0WTYfIDpYdp0mCmxDdntl39rVKTuPlR7hhXbQVOSgV5OdLL58Ptz68KV7ZgteggYAMCSRZShlij0oDPFCOLpRwMzfGEUvXMOGQMzDDaDGIvqKz3balJ5VzK5dZv/53oxiseUKk9zLYZox3CPDcdzmbhze4T6Y9CI0EaNtj7OSxbvf6wTztDTf+lIX7kCNcUgkbgVeu/EKBJFbY0g/HrHN0h1biOhXL86yj5Ka07IlLFi/nQazwgOUpHeZ9kopkogsv2X/48uNcNYFzzvdDcYdGZApVitplTEEA4mX1EcatD76X3HWEcRnOxX3Gf0EJUZKtAWpo0ZdWAD11mSb22Pwz9LKAkM5g4BvU30Wy8EpFsP2aiu5CoO1uAwaSbLFUpftfjv3nVGo0zYD9LUL46nRmW1huNOFX5fe2ZxokA+hQNivD5Jw6ft6qfxxt64eonxAzhyhGkGOpOF7sZQZfN7u09uFCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e418caca-ab11-4938-c3bc-08dc9d299c49
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 19:35:22.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFirDW7v+qmw00C9V3Y0riv7wk3yNhW80qbQfNuQx3uQtpCe1gF7gLpL8j8u1qd2N8HnoYKQU5g8IFrl2y2wpszEqXN61qQL8UUPyy8EvWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_14,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050142
X-Proofpoint-GUID: LHdXRO_Y9VcZKcZZX4aS1vhF6RHX7Uhz
X-Proofpoint-ORIG-GUID: LHdXRO_Y9VcZKcZZX4aS1vhF6RHX7Uhz

On Thu, Jul 04, 2024 at 02:27:09PM GMT, Liam R. Howlett wrote:
> vma_complete() will need to be called during an unsafe time to call
> validate_mm().  Extract the call in all places now so that only one
> location can be modified in the next change.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2a1a49f98fa3..8d9be791997a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -646,7 +646,6 @@ static inline void vma_complete(struct vma_prepare *vp,
>  	}
>  	if (vp->insert && vp->file)
>  		uprobe_mmap(vp->insert);
> -	validate_mm(mm);
>  }
>
>  /*
> @@ -734,6 +733,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_iter_store(vmi, vma);
>
>  	vma_complete(&vp, vmi, vma->vm_mm);
> +	validate_mm(vma->vm_mm);
>  	return 0;
>
>  nomem:
> @@ -775,6 +775,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_iter_clear(vmi);
>  	vma_set_range(vma, start, end, pgoff);
>  	vma_complete(&vp, vmi, vma->vm_mm);
> +	validate_mm(vma->vm_mm);
>  	return 0;
>  }
>
> @@ -1103,6 +1104,7 @@ static struct vm_area_struct
>  	}
>
>  	vma_complete(&vp, vmi, mm);
> +	validate_mm(mm);
>  	khugepaged_enter_vma(res, vm_flags);
>  	return res;
>
> @@ -2481,6 +2483,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>
>  	/* vma_complete stores the new vma */
>  	vma_complete(&vp, vmi, vma->vm_mm);
> +	validate_mm(vma->vm_mm);
>
>  	/* Success. */
>  	if (new_below)
> @@ -3353,6 +3356,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		vma_iter_store(vmi, vma);
>
>  		vma_complete(&vp, vmi, mm);
> +		validate_mm(mm);
>  		khugepaged_enter_vma(vma, flags);
>  		goto out;
>  	}
> --
> 2.43.0
>
>

LGTM

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

