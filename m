Return-Path: <linux-kernel+bounces-246551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561DB92C365
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE61284AED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493F18004F;
	Tue,  9 Jul 2024 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f/OwZmhO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D5Ogkne8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCF18003A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550562; cv=fail; b=RNEEgHfqDlzOOsSKr0O/N3ZP8zN4a+dozsjDBs2yP5uqLM/DpP52qjuE2lZ09Ctn7pefPJdqrsgwIjexBTG0skWpRWUwGUkUnYMTO3EzycV8VKhgXJ1gajWcaspGSPeNVJbmCZNqw7L3mbh1EbErJQDiv6yMC5LIaMoeov7Rahc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550562; c=relaxed/simple;
	bh=KdsHIMojtSQXkHXzymFcPewmN2T0zl0D6nzcMN0Pzjo=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MhavtbxueJ2Kj85mc0lQkrr3I9gFeAW+ouuKET4710hDgH+PeOsEmPWNaempEa8yMynDIacZrhyD7zg7cWxCuRdKZEsXf3mU/+s2F2X6RMLTL5EGAIPvfNM4vl4fsfL77SWaiyI17BqkI07gymeauhB6gE154+84f5VlZQzgv6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f/OwZmhO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D5Ogkne8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469FtYx3027871;
	Tue, 9 Jul 2024 18:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=KdsHIMojtSQXkHX
	zymFcPewmN2T0zl0D6nzcMN0Pzjo=; b=f/OwZmhO9kWEi+oOw3msFedUseCsMx3
	ZqscTtwWDTYd34t90tMRYs8C+cJvofc+/raartMAoxB6Mj5MIYJhM6pDiEmtSRjv
	nmeBzAl9gH9WfMB/AF3h15qVbSX15Vkdb0MBF+b9vy4cTC/IhI3x73AoKTDKr1nv
	f0y++s2wEmAZeAEKS/+W0qizdbXXhFVB+Lavcpxv5buikZeRYNPOC0j60cNTuup3
	CbkSG0ITfJt69OA4kg9UgVtiVSWiEbQTR9+cqxFW63yZnHIhJS58M/x/mcVrASDf
	RlnQlSwFgWyEEX2ZFrO6UNZm3LHDPXo3iN+3ROCcMt9troCbcOFZWvQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsnqjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 18:42:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469HCAIZ036427;
	Tue, 9 Jul 2024 18:42:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv1sk4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 18:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFjlnBC6uV2hoGQ8HrLrWzZznKMWi7jlHI2jLNJs8Lf8WKNJ3qWZTL2eBereBCZK8D/WFZ/MWPU+BzVv1Ifajpx1KCSsrbPTS5jM/3V4/lhsAEW0pgPBa0HeB0FREBNjpA3X3JNA35KLAJtyoBqevuRsTnPX432jHhy9ORpssvRD+sfXYODCK22++6NhdyjHp4tHF4OOA5Y+tcO7aRVJuOJmQBGpk7EkELsPK97HtHh03Dr9cdp2ARNdHzmmDQm6If4FWe4q2lfXFX7lFzpVB43Eac6fj2ei4Pz7vsdGZXvJFRIYpyx4bzWl4XHKVIiUHSgWzcXDSctg96qOjR+JIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdsHIMojtSQXkHXzymFcPewmN2T0zl0D6nzcMN0Pzjo=;
 b=X+lRURavdbY4lvDMWBSRkVvF1EjPSXXBbu1DImTA6E7AXC+oiYepF2Z2VzZlG9tQAxvgNNCMBUXdNacRBa7Irjs7EoFS8UWrnTa48yoyQfYUXdHkpdaSkUe1EMHslQretwzDbPwyg5NcQ+hIfJuMIUpGUaCvvoqsr/kA2g7I6CagU31tUsInSy1JULNr05GhVOd34MrPM/Ajk1P98r/zVzMSHSoDRir37tWNYtEMD5jPw4MZS00a06VdCwZGbRaK/JoT0b/yfr/Sh1C9aUJ3kUdt7H3KoiVglyK8JEvFVNmQOS3b7T32+tT0zoPM2O4WFrXFZiPnl5SblsPAqisOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdsHIMojtSQXkHXzymFcPewmN2T0zl0D6nzcMN0Pzjo=;
 b=D5Ogkne8NRaQbdJ1xG+woqEaLQ/Mg3RP0Iju70g058P62i5D44vWYrQhQ4rwtpFVtFyqK0gbzybiieZ70DJsi3vaw5m/moCd8fRsElmtoJdxn7CRdWlYVZQU9kIWmohTOmV7jCQm+el8wBakbSDgSs5NBP4+XRZBWeKybBlLIRM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6413.namprd10.prod.outlook.com (2603:10b6:806:258::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 18:42:20 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 18:42:19 +0000
Date: Tue, 9 Jul 2024 19:42:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 14/16] mm/mmap: Use PHYS_PFN in mmap_region()
Message-ID: <820d3203-d854-46b8-b10e-ebe88f36c958@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-15-Liam.Howlett@oracle.com>
 <7a0350b3-ea23-42d4-b2f7-4680d761c969@lucifer.local>
 <7ifrcfw35jqp5zlu2zofzexiy7kw5o5pwqxrolfk4azwpv4w24@uhw2ksxdswkm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ifrcfw35jqp5zlu2zofzexiy7kw5o5pwqxrolfk4azwpv4w24@uhw2ksxdswkm>
X-ClientProxiedBy: LO4P123CA0331.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9ac040-9a9a-442b-ff7e-08dca046dcf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0cs9pK3vuUvz7ZKifrXJFHRjOdPfeCJ79WOoABON+Ow+UffBGN5iFxTLude+?=
 =?us-ascii?Q?NOuwOp9KYciZ6cFB4vyxlVXzHMz1FymmSpDwpNABrqcSzlU9LxWQywCbG4qr?=
 =?us-ascii?Q?o7gqjEwunBbBJlqGPFopr3/aWX2qyAABVU2mWDv8un90uBNrk0XUvTUi7eNh?=
 =?us-ascii?Q?0aGd0suqxW9RrfQ3VStyC2pnOMAQ6hTQHftC3LBAS6f1yrxSs7Y9e4XNP63c?=
 =?us-ascii?Q?ivmij7/9oqkVBAkh1zxjaOYP5hOa707z5GuSiF/qhbNufOxHvmeSEFwNCKms?=
 =?us-ascii?Q?q79PFWzaBjZgKT0QAWIf02gOGZpTddbsEaDhhTSLjBMCfAE0Gbi3StZ7sRo+?=
 =?us-ascii?Q?beF/GFyrsJuTNyA3EkndEFA803TrpaQ/mk5HwAD2Z0Jwup8Xe49qJ6asYfin?=
 =?us-ascii?Q?Se5iOKkrC9abX71n4n9+4DIkGq9WnF1LD4m1/NDPMe3znTakqPHTsZodVjRL?=
 =?us-ascii?Q?NQ0a4VZJ/WdqcH8vSNXF8wXAmD+VzAlmTqJVlkNdi/1ymfItvr/Ds4ZJjob3?=
 =?us-ascii?Q?oO6n71Ky88wG2bz5Fz0X0y2G4H3IE4go2YL8onmSb5C+PTYOxCURnANoJaiT?=
 =?us-ascii?Q?Et8AL+/gdsNdwH3dS/lyNKMM69RZmwQ94Jtv+S1rXxlttX1zd7b9Km83ODd4?=
 =?us-ascii?Q?F9GD0hWEJagdTHn0WWI2NvelWDvh3xxAk/us0uAgxd0J7yPQtrmoJO/MVRtg?=
 =?us-ascii?Q?rc15Dq1ejcCZbfRHNNDvVza6VhTXB2yv0OOb/rg9DTm+GttkQmVbASby9Od/?=
 =?us-ascii?Q?O62XhGDSkjD1Ti2SaB1s10wNFsnSFyMBR7i9at1eqBMw0pKzFgji3/kdS11i?=
 =?us-ascii?Q?kGlGKgg6dV+t3fry2SWYdHm/FINut/zcNbPOf5AsUScW4/k2+OOPovcjjr4c?=
 =?us-ascii?Q?kTa6zRHACNX1Y/VA37ljcpX6uXZPTG6f7DKfddIz5fboBV9AW/RglHnPUkDw?=
 =?us-ascii?Q?F4tn0QUk0wguuzSxdeC6wkE8XEe+BOmm2Mf5ZLpg/tOJoDnkq7c1jx4Kw8ye?=
 =?us-ascii?Q?hFFLKC4CTUXXGhfXZL8Y4csIVqE2QGrWh4e+TP+5TM+KsQnNCyaFhlpAD5g1?=
 =?us-ascii?Q?fL2F5Um4hRlAbRbMfAkrfhaz871n5KWbgLFtQMk9KoNx8O0u3eVp2SQiekEU?=
 =?us-ascii?Q?ZFHnVVLoN2Fh+pxZuQhKUW3qs8xH8l6oSUWgSTuRoZULXFp00Hwvi6CgcBex?=
 =?us-ascii?Q?wp1W30Hnh0hTOgN/xweiCq5Ze/ZbdiHyVeqr7SXiNb0J2BuYBv7HD4WAmXkG?=
 =?us-ascii?Q?sqFB5Wnu2UrggqOft4n2l0Q38bQn5Dp1v7kUdnfPV9d+4nr4AGutnNYWlwCE?=
 =?us-ascii?Q?p8z311bVznFcuUld2FWi3LFLB7fDtioEmX1fuZPnCIPOYtS5RdwTMkpd21Cw?=
 =?us-ascii?Q?4tA2clvrZ5rPt0oNjhwMJw85EDv+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7iprOzD5Y/3iJAZkXclKTiVtW00XRfIKqbLcHaK064FhFbp73kHi0Z+opFeH?=
 =?us-ascii?Q?ixOncnnPxJv55Y26IE3Jks0mfMAfhi8fHoUTY4WGGe0NGsnYjKQnDm6ACtKp?=
 =?us-ascii?Q?j0vs2hoVKovQ6T3ZyVl7ReRpHcsYtUWOdyv232jglWkDv56aJh7aHAFx7DBH?=
 =?us-ascii?Q?z0pDpDuMLYC8gztoZ/TWz9IDZTt2+mrGwu1lq63n/fwvIlq2E4hCWcLqTFaW?=
 =?us-ascii?Q?W6MwcTk4jYeuDJpu1IWNtRBbgAAdDeHyI9o4JcAURrEiSUTf/lYiAtDjoM8W?=
 =?us-ascii?Q?cORn0BnOuXlDlcB613val900extYXFLQoF6Mguns7I1UnQGnTu3PILPxh3kA?=
 =?us-ascii?Q?rHpLXWgHLy0uy0gz8qjdZ0BM/8Tcu6rzjAkuRdU4JRtLeR0TtHcEYCNq6vM2?=
 =?us-ascii?Q?9rN/dDm6t8UMsz5zdpi9bSTDTCnH+cl5qgegJH/TZUjCwmAeBUh79mw2mTHA?=
 =?us-ascii?Q?kts7Az2XoZW8PIx3xEX9SUISjgkEkIyWfjPp8nvy9JHv+JOtuexZmbDsh9wa?=
 =?us-ascii?Q?rwGGh6ZjcTZ/EG9JVO8rG6SyM+oft3kluYZOpWGMSdyD33sLN7dJefdLOX/e?=
 =?us-ascii?Q?2IBNocKxUDe3Bne4pKKL+VQB6vUyZ9QXNtXh/XEc6SWX0CjqFj4wb5vberym?=
 =?us-ascii?Q?aLVq43bI5HoKWchr/+s9BuIHw5leXwD5kvx/yjNAR0KUr1nCgdYYjMS1onpG?=
 =?us-ascii?Q?f5o85ARa4tba2VOPng+v9IifA2tgS+ijz1I8/XtEzH/VsVGsLVrKoQY1JwZI?=
 =?us-ascii?Q?rn0VVFa5e+/gg1mUcOiQAcmmyspYhhxfyl93wEDiN5J/dv9KauH5Ml5eGTqq?=
 =?us-ascii?Q?EMdQ6RoA8dfkCOAhk8yk/tGMLqzxELfoMjmny5UjBSk3MqP00BhNq3KJZVi2?=
 =?us-ascii?Q?t2TgTDOZj5qRHuHFcS5C2EJbQksaQ3tXkY/V6lY7YmA/ftx16c1s7uEPKz9c?=
 =?us-ascii?Q?+iZfhFt8ikEvajJ60e9v2UgVmP++E06238K+ZEe7q3ARg+Y3bUnWM+yCQ6/n?=
 =?us-ascii?Q?TJ7pmxbMVq1rslq8Jt9LEQMOQcW6MuikjMDS+Qpc6SKqjMp8v46GCkvhqjx6?=
 =?us-ascii?Q?7tz1Do47VQmonjl/RwtXQDB+AP5aYJ7HJHp2Ez/37bbiAfei9pOfGobYm446?=
 =?us-ascii?Q?m5UuHweJFXMVGQRpLbUOZds5dg39nVInqnHl3vImuiZO3m19A+ZoB+4ET+xb?=
 =?us-ascii?Q?2SKuYqT5PY9nq2+8EAMBZ2Dq5QvxVafUFJ4zEw5besNrvn26ZhSb/2KEtpYi?=
 =?us-ascii?Q?TIGAkEC9yUY/FUk9jYNdj95bz2xJXa25Mv+KatzbQICCh5K3Vv4RNOB8grUP?=
 =?us-ascii?Q?nE7RI2V8Nlr568r2IfUlrXZu7JUBfVTBtMn3kUjAjzjd1Z25afi+A0Mx7cW3?=
 =?us-ascii?Q?ICf46gZHkWXWDYMw16513Qtx59pF3AY66j3YeadXQu/qfOuQhEnV3jMBVVOw?=
 =?us-ascii?Q?wrmJHkU0UMairIpazlH8YIHHr1YfR/upJTgw4y8AKBvERbc9e5FfNbIakTUc?=
 =?us-ascii?Q?wxpjTV01dmiGezYk5ikOPRi7XnTvHezkLZVn5KHYq2iQIWFUG3tqmimRJPO9?=
 =?us-ascii?Q?RaoaV4FVDCvNYsU3rMTVsLPeA+VFlCpurTaPfdGTMnVxnOiYF4AUsUKL6smt?=
 =?us-ascii?Q?Rc9H/B9+1ySb80JyR2V5mANqdErj6MZ7rASoCqTEq6qRaND5ybbSW/dGsHOX?=
 =?us-ascii?Q?O/Zwxw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qCPPRsfAGC/WQ6Dmd1svuXvoEo6VUD+JCPxAVVhBDE9wA1Gb63ANGLuI6lk+YryDCw/xdBxJpRAZxbMg4HYqHu+2E6Tehe8IVhygfBV0mwFLMmGHGMdEbUBICgcoNNEC7SE1i9ggh8ltaW1FrkZwA4x1SyIb19Qs+SE9B+NcYczfWBM22DtaOQdBbtXMDA/Jg/mO0qbcuOX9lF0tDBZ/nu+V512/zyOp7DnVgZTP6a02CvkhQU+yTlc4APuYnNpf2IUwXoZZ9Vo/l83NdfhN63p6fFXxIZs3YigY2LrawF/EdJ0bf3X2A7f3qZBe072rUCIB/l1proH9TzOEsNo+EHJikVrt4g1dqMYWlfCfe+F3S7WUAdktZQJq54pYVTEsEuuWGLX93I+TUIwjYi8K5TxOUkjB1aMrDf0IA3Iw56MIFsRSrUEXL7B+uvneLawXCz/O8Vl702wxl92ARbnbASUmu081NxlAkpJQYN7Nt2V2Dvf+6/LIniJ4xpUcM7u3mtfX3/G1qaGyi5zbunSX4muDhLJ9K6ATAWnz1TkBlRqd+TpSFe9QNNqzyaRy5Mz66mZdMPvY/HHdGmlGmr3d6rAexbFIjtOAwob9OZEcIxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9ac040-9a9a-442b-ff7e-08dca046dcf5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 18:42:19.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7l1xyDThsfplQnpXygNuOIgWzg0mH6TdDo8O26zinmZisxLsyWo6piv127jLe0oPCpFlxWxp3fuCB+OKgMws7EBu4hJpuhkaDSDraYgYh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_07,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=927 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090125
X-Proofpoint-ORIG-GUID: K-mY74wwMQLlmWQ4YiV3699kISnqyc3T
X-Proofpoint-GUID: K-mY74wwMQLlmWQ4YiV3699kISnqyc3T

On Tue, Jul 09, 2024 at 02:35:16PM GMT, Liam R. Howlett wrote:
[snip]

> >
> > Maybe I should literally look ahead before making comments :)) thanks for
> > reading my mind and doing what I asked though! ;)
> >
> > However I don't think you've fixed the duplication of PHYS_PFN(vm_end -
> > vm_start) in count_vma_pages_range() - still worth doing I think.
>
> I drop that function in the last patch so probably not worth doing.
> This is just a few patches before the axe drops.
>

Actually that's a fair point - I think its fine to do without this nit with
that context!

This is the peril of reviewing forwards through the series and being
surprised later when things are addressed in subsequent patches (or become,
ultimately, irrelevant!).

> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

