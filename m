Return-Path: <linux-kernel+bounces-364929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C6199DB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952311C2140E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7CF13E3F5;
	Tue, 15 Oct 2024 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BUtA164Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LXw/z104"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC0184F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955041; cv=fail; b=XQVqpUZFcHGodLQGmIxoMYfEQuUE68pad/zzYlqr2WV0JPWUjZVEadqogyKXeFqavBFtPbNUytL4o5nWMoORxiP8qE1dehLiEKrxk9MAUI00js7A4zCR6AbGt1QKJ0f2nCF/mBtmcU5vI+HAdnbUgRncXXyUfV4vmStCwQO3N0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955041; c=relaxed/simple;
	bh=wH9vTW3lM6TO6Wh35mw4GhKDDCW0FQELsI549KU/41s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9uOkMg/ULWMOzEOvDUjaAq/TuLkVGkzxsDPl8uYN4R5i+YzgMkgA8dCUDlDnI9HSruDcr2GkbEVWYgQT2Zfi7Bjz6avn//bP6WUjyLlTlfBowYM1cJCnEjFSxFgizybw8vs6jUfdPTMji+NEFB06b5KYmUJAbDWtaqz3IdmktU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BUtA164Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LXw/z104; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1Bed8003584;
	Tue, 15 Oct 2024 01:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tZFbfYbnX69DBZ+EpJ
	WKO2XC3BZoqhxT1PYm+sCqbAg=; b=BUtA164ZznQHRo/jRVeqhl/ROiU1G4Dy9F
	pQw2496O9bRKLkGyiFYc12HdF1Qfj8qaCGEGNxgRMogGkQs97Zbn6iYSjM+VNmcB
	JDk0sBYM7bGNLFAYO5fhI0JL6SyX7ZnddSQGn1Vc8kniEYCxgq4p7Odi1pgxfaxg
	VEt95lu9yOJv9IeVNfVNTnYlbT5Rvv4LOjVsNhBQW9RsRREjM8pMH71DOc7rVqEH
	A8cVvEz+JaX5+dbR2HaKCanSRFq+8JP87e2l3gZtOP/rQ4LI/5jN2haUje2iyrZi
	z3DjxZ3HbqZ2E9guWW/Eq8EMeqgyTCI7bM9K6di7+T/XKZ8aaC9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cftgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 01:17:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EMlWhp038945;
	Tue, 15 Oct 2024 01:17:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjd2f1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 01:17:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft+hxI47uabaZSlHlIbAccW94tAMGTMR4+5l71ryTi+wxSpf9slv/3cio9Ie7bN7AuhkFQ5RRVUJkYIAaEhGxGhHSP6hlHMLbmr3ekepJOOFkH2KlRhVmT3YRmOXXAB28cnTCr9ahXKXxI58NhHtJdyTnTiF/0p3iOfXaQFVo/u9OMTo/y3plUZdUYnARt8mjJcoGjxexTcbHs7LQKt12PeS44OdvA6L6xt9jDlcoMIdpfrep4OksGyNoPn5CAjFMAHbXUUBEvDMPeA/TeQXlReMCmM6fgsWXi6sqqlDB57RhodEIcefXeJNLBcJ13BAmVJbHMNEx2sSe+IKHX+dLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZFbfYbnX69DBZ+EpJWKO2XC3BZoqhxT1PYm+sCqbAg=;
 b=QyOHBlC37iFmRr8DwoABiy8bRLjCisCF1ZAXfAaeU9aBnbFlyGCJIs+sFzHMiWuDYO8zkhvn3X6DrfneFEFm/blTBNmBpa/3Ag6pPvu6kzfB4xkfmeOzKXEXsCosa61PyCUa1zkkZFOyQsKylxa1sjTPoaf4iR9lZNTzJ0H0GAhOJITmxAP/yOn915wm+FxmeV588jbUkigb93S7QWoZCOpSMN8NsI5BFxuq+Vrct25Q0n7lO6/I+4D9SLFUBwHqa1qs4ZrFw3Lh1PHMTdhweiei/CQM8O+yDWlHIoDln9ltuV/sFuABAbNa+lmKJIEs7aS8YvHlyVDiL8Dbu0vvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZFbfYbnX69DBZ+EpJWKO2XC3BZoqhxT1PYm+sCqbAg=;
 b=LXw/z104qin61/h2aU52F5riv9C51rgrQVD/bc6adVYfm650z60DiyEvopiT2/eGuPolm9sIk33AVao7XmKklGe2EUNFi/T2TtzXL42ndRrsMuhfDllu1c9FBtoKuJ8cxgTuo8MhegCvp2C+81QN90g/Myyf6x3Lt6WdxrAWNQw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB4712.namprd10.prod.outlook.com (2603:10b6:510:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 01:17:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 01:17:08 +0000
Date: Mon, 14 Oct 2024 21:17:06 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: fix alloc node fail issue
Message-ID: <7ei6xebky5shub5qlat5t4g4sznfzlyqrjqsalcbfxhza6ake6@6xnab32uymhk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0485.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB4712:EE_
X-MS-Office365-Filtering-Correlation-Id: 846bdb6c-9db6-4a8c-302f-08dcecb716b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hl5TrqGLAFXnWk9FNwHdhgkn4d43r2IJRUfmXicqXmpCOPv8d+wjZMYrDX2B?=
 =?us-ascii?Q?k9gFdlwiEyA0fVr7VCSQpcsX+nvMv3I1UQ2LFbFwnkn+bIYMGNHixitsMKGo?=
 =?us-ascii?Q?T07kDBcUPI42sW3vG9PgBSG2fjhNDt5WwU1NXpzNKwONmsNIhpidljc+OUey?=
 =?us-ascii?Q?iG9wQp0p5n8+0IatsXHfGbiT6Naz9f8RSdyfUS3ICPCWQCu1prDuqHWrLUJ+?=
 =?us-ascii?Q?XLAW28UBXG3+7AEly3MBi2D1Vmo51CxRP7wtjJj4prHHAl1GU3LCGgWWrZU3?=
 =?us-ascii?Q?WP2cSxs5zTnQA5Q6KIHF+YAkuPUd3bIyaU3I+zhRNWS42lz66ygBlpLJ9RBX?=
 =?us-ascii?Q?dlNFxHxrBKtcMjCUqyU4OBGOenRrt26rBI1pXZ2bsstHt5QROts8Md5+FMrx?=
 =?us-ascii?Q?ftQlNPo9mXSTW6xRz/G3y4JjCM4AUlvxFl/av77cFwznynSdC6Yxmx5vfvpd?=
 =?us-ascii?Q?yVZreTxzsRRZTKnFCMbSRaIoAPxVPAGDoMPqv/Nph+47uBf7DlakTBrmd+Hm?=
 =?us-ascii?Q?rITPXA1PHNwVC7Du5slmHUUY7TQDwhS39uw6APYY/FJ1/5S+WVKgvpf65DvQ?=
 =?us-ascii?Q?PL9qbFW/e3mZf3wLk8HdXwvIliCg+gaXJKzQ5NCoYEG1dUy6/V0vDR/IOk/v?=
 =?us-ascii?Q?Yx10mQFIuQvXl/gmoAUIJplWVRuO2r9uu16Z38T5JyHlKezHcwOhX1BS+byU?=
 =?us-ascii?Q?uI2um4wELchqYUPDYOXdCaNf0UlgEln1ReoHGZrmtSSOYicKszJ89S5LoJ9I?=
 =?us-ascii?Q?VJHvgj9yAtzq1755jSX0SQ5okrtw22EN6fcXQq0VIcNUb1N4rNk47MdB0qpo?=
 =?us-ascii?Q?AjMQv9VTEdDxfxWBE/U7ye1+KE8jerTqOzdiDwWTzwVaca/NEQvzwjtifOYH?=
 =?us-ascii?Q?eZVQ4/at5ef2jq7Vefb3iT9IOij3SD1mZbooSR68OeeozZuK+G7P/YdPp/qX?=
 =?us-ascii?Q?2zNhangqzbKq0L9Wx3pQrj5+yGkVNfBeXn3XCCEwC0QJbZlqrFigWCFr0GnX?=
 =?us-ascii?Q?GGcEWqPBmpWbVqcFasLZ2nLEsEik/Ov2gPu2W2O01VCBqAT58ws42dscH7TU?=
 =?us-ascii?Q?AyzPC8X3n6msfaXQ4TqrVS9IuU6jIVV2wsTgKDlnOzavI+8gWctWF0K3p1Go?=
 =?us-ascii?Q?bnLFr9Whd8MacbKWlQlF+dvXZzN1PPr+5Jv10SSFFsI3nBFJt/33npsoqXIX?=
 =?us-ascii?Q?t4CVKoWX89i5VsiczzuVC5CjXQO+eKjlh1NxQebehBiYoOTYJf+JAwK62Xt3?=
 =?us-ascii?Q?HcbdtISucGGQ+dz6JtFafsSKj5ZczMhOJESxO5gWaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DtCHCFCmXM/EXEwbPjZYEgkJrn2jZPxway0xUN5r12NTik4R14yTsOiD9HW6?=
 =?us-ascii?Q?KZySLEaBcisG27Qu9u8E4sufkey/h7Fw7GziXn4umq4lq1QaeILmaj+RD8np?=
 =?us-ascii?Q?WiXYYRDms/uOJuQu2Y4TVfkY7Ci4nkFAQ6QE7SFxegVOfuOfx/SUINwpCbRa?=
 =?us-ascii?Q?R/elPwtNH8OiMt5ra+hvJE+ER4GliiX1pp9LqmEdDelg0kashx8tCcOABTIh?=
 =?us-ascii?Q?AK/CyvgMtm/sg8ShHV7XMokVt1DU5Z0mj68vn5NiRCkhXbWtcP1xhM09/QnY?=
 =?us-ascii?Q?GmUuMmySXWmXvg303a/SAPBa/ifC+mOO9ow50p/iQtv5XVdiz5W+ijkZ23eP?=
 =?us-ascii?Q?jFBzv68rBYvijOs2L6A6kyswyTT21dshyg9iCzbfU9ct9TCfVMZ4icJBbpwx?=
 =?us-ascii?Q?B5+pGBnO1kbyIka0FHs+2WnhPe9kdlzMbeVRuCZgm3n0EBFSWc/5pKMFcL3U?=
 =?us-ascii?Q?qnHC99x24QZ/6Snn4FhXDqBhQdqE89wJCGXSf0aXEU5rTun0dF7pff+70i6s?=
 =?us-ascii?Q?CsYO0xivEOBRrKT9aM7Tlr08lsdNqjou+u5zJO4eog06x/2OrfCtUgyQ7lBX?=
 =?us-ascii?Q?LkEJg8fq86sMhzXQbKLjTy8CaMnbzHvR6j6G/GGfueMbJs1Lfcwu6BVgeH/m?=
 =?us-ascii?Q?kqteaotbfRAdm8XzfQHAOlp6PM4MycaJJjc9WsZj2/L/75ZqHWaT9MEIZ7pU?=
 =?us-ascii?Q?rwD4JPfrlwRuAuAq8ymBDEemolXhpcrPeXxwG5ezDzB+0TCXUNIobkEovgWo?=
 =?us-ascii?Q?M0IXr0uemaCNveK4Yq9szuOG6vmG7BG7N+m/uBTB07Wrtl25BJ3ozXH0KK6l?=
 =?us-ascii?Q?Q/xYFcLAYcVxRPHGy8+Dsdmg0YlFkt9GRLdTWNnH3dGijEMFq4yKcOZOpvN7?=
 =?us-ascii?Q?rLKiS/fU5XUrUSjzDrdn1OuKQJWHPYSrzLiqbzmM1mtrDWhNZ2QtgR58Xn3W?=
 =?us-ascii?Q?Xr71XHNawy5KAm0quzxk1EtIvQA8xq/0zEFjrHzmKq+zBr2myBBp8bHlcCuz?=
 =?us-ascii?Q?hkxQPt/hLr9JwRgA3Z/vWtSaaZlIzanf9JLG4vBAOlZ/wCQaTNuPXoXpT3j+?=
 =?us-ascii?Q?kU04Gvx1y187TwAk/ZT3gyFIr8loq2SY6Vxbm+BcLZBF0vXhO8Mq7IbRHcd2?=
 =?us-ascii?Q?u0TvL7nuahl3AU/uV5/FEXmnMDrq01udwbHdgVRSMeRb6tnYk2qOyA0fYkfU?=
 =?us-ascii?Q?0HOHtM6qL1mwL/d45iE0cfcXN0OUf3bZ8zEWJ73OOs1F87u4nX4dGJ6krsRM?=
 =?us-ascii?Q?Pgl4KrUpfiisZn5giq2MOOCVBt07Oxd8GJQ+XIUFEvzZZ1HK/QGlWi1vFkyv?=
 =?us-ascii?Q?Ws4f00O4Q63wTiPZJjkHwV/WqUvkUt8w1p6bdgn4jaH7Uqh5Q2dNekSIbnDZ?=
 =?us-ascii?Q?cLNOw/k2OoPKySRE4OFJ7ktRj53FJpoUVuZcNnRkf7w4cmgN5xx0LMVegz77?=
 =?us-ascii?Q?WNpoljevpcdti653GWBJxq/Is2luUz9koZ3WrmcIIoHA4ArUc0NB6kmon/Ze?=
 =?us-ascii?Q?5v15+VeJE0+LEXSC8M4CJBbVP7wWw/bd58RuxzXSv3ElnHr9ua+BWEPGCAcg?=
 =?us-ascii?Q?6wetY4mCVIpPncWsyq7C8AMC9EPgVVMKiG+Jxg9f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qjTJLb786R6HBrPRDN4ZG2j8WDDXc2H3L9Fh7ymfwN2xf70Or+Wu99zD755K/HulW8di5/nMg8uhzq01dKTK/q21W5ZH03VP7kt8c5qWyz8Z0arg58LX1+AN6vpIiPqSoKOsJKT5rQgCkoapywZrJjh0an9THdDXru2kr/9pji5OUyktNe8Kihg9KoWQoqBadVmO8GdMyygPUcQ7YaODZh3sd9YAI1IVyaDWPsPFokgUoE7Gt9LBzHB35oTt6jvenpP2mABGzN0N0Iz3KqvJp5SJalb1D6xLPliB4zQELo7DGasFExqrPuKIxRmrpdq0QkwdKMFq60/V2HPbeTBqOiWRGV3huZUZsJcGH0MA0GWTZUFhmDxcydRbEFofcT49inChkKOjJZSrn6GQQwxzdEROuL7VqnODiPLW6HB5LLJ9daKB3GHd3BW6QCmrpJDNZxqTtyNcxY3wt/tNZXI1rCQsJpUquqOPdHpKLF2Vgb/fHPoK8GPlJxkBuDCWLuEktFiKAhBlWhPkmmuzbvN76jiz2kZqgWkOtaE9Yx3aUPODyVz7zCejRD0jQIKbLhswxM2xoMSJ6GVYdKJby/houK8QRymNmKXyynO+Nj5eJuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846bdb6c-9db6-4a8c-302f-08dcecb716b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 01:17:08.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHGgqJz1vFVwwknburYV3f9yTO7EmqjV/fmUSYBQ3KK/7lyof54we54TgTZFCldtf295RrzbGgjS2lsL/afIjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150007
X-Proofpoint-ORIG-GUID: qkZ7DN0o9h5hsweJoJEUwJKq8ZGtA8pf
X-Proofpoint-GUID: qkZ7DN0o9h5hsweJoJEUwJKq8ZGtA8pf

Andrew,

I think these two were missed.  Can you please pick them up?

Thanks,
Liam

* Liam R. Howlett <Liam.Howlett@oracle.com> [240626 12:06]:
> From: Jiazi Li <jqqlijiazi@gmail.com>
> 
> In the following code, the second call to the mas_node_count will
> return -ENOMEM:
> 
> 	mas_node_count(mas, MAPLE_ALLOC_SLOTS + 1);
> 	mas_node_count(mas, MAPLE_ALLOC_SLOTS * 2 + 2);
> 
> This is because there may be some full maple_alloc node in current
> maple state. Use full maple_alloc node will make max_req equal to 0.
> And it leads to mt_alloc_bulk return 0.
> As a result, mas_node_count set mas.node to MA_ERROR(-ENOMEM).
> 
> Find a non-full maple_alloc node, and if necessary, use this non-full
> node in the next while loop.
> 
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  lib/maple_tree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 634d49e39a02..fe5c6fab26c3 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1272,7 +1272,10 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  
>  		node->node_count += count;
>  		allocated += count;
> -		node = node->slot[0];
> +		/* find a non-full node*/
> +		do {
> +			node = node->slot[0];
> +		} while (unlikely(node->node_count == MAPLE_ALLOC_SLOTS));
>  		requested -= count;
>  	}
>  	mas->alloc->total = allocated;
> -- 
> 2.43.0
> 

