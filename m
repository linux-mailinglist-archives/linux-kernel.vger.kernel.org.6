Return-Path: <linux-kernel+bounces-395472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3C9BBE50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F90F280D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0601CC893;
	Mon,  4 Nov 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZCPu//7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TbIOmNry"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1D23A6;
	Mon,  4 Nov 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750144; cv=fail; b=FjcsszeGPg4RdQG5BQcGPGIK31cLG9naGMarAwvTNTDDAyjz7pK7p6h59Pl73SuXnqri9pb8fAFskw0vMsIDC8VU0Xyr6MdF4DjUYZqDCEGemd8dXH0qElPqEZnuIAlMwBnezM1eyYnoQ3Qi1RJIttwyk3MeR+b2dn/B1pcUWMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750144; c=relaxed/simple;
	bh=FFiOE6hP6iXHPpJbNkc6y5qk/kUjWSQM/9fmYZUaumQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EOGyVtnoLyYuAZXjUbE66fRT4CuBmJV44Z0zB3GEFyn7uooFtdtc5dCs0zzfSI5lYQ5oB9NOviHiKIFD8h8ijxaES4KJk+TlvpI1IcPeCEUz5xinvV3TsiH+ZTVxaSuJwA29Q41E2WKvYif3i5FFtAEfj2rzA0YpQMQsHeeKPgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lZCPu//7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TbIOmNry; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4IMWvP026879;
	Mon, 4 Nov 2024 19:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=M6TYquWCsFFr3Nw5SY
	Awn6AQqbTnZW/AKPUfpbl02bc=; b=lZCPu//7D14ifm2eOADrtXI9BAiCKYR5Co
	w26Xvr5q/fCzjccEvar5Ys4vwMhrm4mf3pZHcZ5yGE8EuJPBG7xi9ClPnwiAOHoG
	1jLVmld5GyMFJvnmTMEOzqCxuO2pYw3bX2CZI7NWziq0d0ln6FvgqrL6VOHDd2D/
	Hx7QNo2nVPRhrxbB0xMohITIZH1KnKGBV6XPIz4cEzg4MX0QAc6GmS7jmtnS2gVl
	cY/1NjhgGq8qKO65dy0GOymjc/tKLrRWrUq5uichs94IFOqPvx4XJpuT1vw1UGE/
	sLp72QWD1tO3Szcs828h0CP96jMGwngLvJcMvIs+RHydbr21coFA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nby8unad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 19:55:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4IptaL036831;
	Mon, 4 Nov 2024 19:55:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nah64g7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 19:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0krMz/mAib3EyEMS0P+gLH/TQZdi828t8JoQz7tPq3zLFtk3GoVDaPW9o4CVC3AvyHFrIH/r1KnhYDBwUWF1qQhbY4cGFU9P1dvIl0lePf2b19VyAX09yUHH3zgbURqLhpKrryvoPBFwIPe7kWK9ET2Ze2clf9J819pS8a3lO1wkIoef16L7FxSDJ0qbds8+LGI/6jh1lY1cGMigAfOV+ThBv3aGDrXtXlqfZ67renHXhEzGxBi0/kdmxWB+ep9MokJZuQftye1jHwIYe2Wyl44zXXnXNBxF55B8iUW8BKknxadO9L2igrAepfmMA7aiCxMnBBf01/Nz1TVgL6iZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6TYquWCsFFr3Nw5SYAwn6AQqbTnZW/AKPUfpbl02bc=;
 b=qNHPICh7GveRGe14nmPtZeem5Q8OPl0FKT7Llap6tC0yqYIpv7VgXTQ+gcl5PINDHOvKG2U2P7ETOLK0sIhI7vHhYucK4KGuTcagoNiAU+/SCHPs7Grwj+bQ8poB6ThCLxXlsxxFmbKe7RlcOHCOOd6AVGicLa2y8k3UzjRN5QyIsBWIpKUsbzNhz1u9AaMai8ItK8eZPFzCl5PWaoLI0TcNo7PrChECisAgB42WWIVqutqKMAlXR32kZdslN5dyA4rpCrYyOLYmM/iCdC0NkLT5+KUzZeroeAHR1mljQU/YpYDjE8gcdt2eRGuUN8dsRvwyDu6s8aJcRjW9C4h7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6TYquWCsFFr3Nw5SYAwn6AQqbTnZW/AKPUfpbl02bc=;
 b=TbIOmNryj4PLAz7UHfLqJBq7g+tJRjwihGWjLGvMTl8U39HC6zNT30dVD8k1mH6httX4kZg9w7LyoxcRIlZAvNGtHjSaZsybmehSRr5eBX7cRk9ZaO7BTqvgqNEixLVcw8B8nP20npfEYSUP5DnyV38SVngv6zkHLIB9hQz8UHA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6196.namprd10.prod.outlook.com (2603:10b6:208:3a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 19:55:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 19:55:18 +0000
Date: Mon, 4 Nov 2024 19:55:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <5fbe26f9-39ac-423c-84ee-dee1611204ba@lucifer.local>
References: <8e02f3a4-d498-401d-aaba-e53ed2ac6a3a@lucifer.local>
 <20241101234832.56873-1-sj@kernel.org>
 <b5fcdae7-8918-451c-ab7a-de7136e5dbe3@lucifer.local>
 <ZyjQfG2YakYXLUdS@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyjQfG2YakYXLUdS@kernel.org>
X-ClientProxiedBy: LO4P302CA0037.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3841f01e-237b-4d3c-dba3-08dcfd0a9b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ugd16qhUpgT7Lvba1OoeIlUwcUx1KWC1COY9uQGBfvTwt13K+WvctW0CQF2z?=
 =?us-ascii?Q?cwfA/xoapT+EeyPTy3DxA3PLb5cNnAu78wdf0iWyYsD8Z0MtX3WfU469hpwO?=
 =?us-ascii?Q?t6VIZj2FDly/rhoIRMBaSY7WFrkoJg4D4WgzENTZQOfokcb35LdEnEzUoEVs?=
 =?us-ascii?Q?iyRJwSVUoIj2lNbbJE1AxYXWsJvjQBarn+6DAegyLphjvzuGyE1N1A/FCV59?=
 =?us-ascii?Q?YUfUXd0Z6NXKubD0NQS/fjkUqXQkIX1Fy3M9pZODRoO8AVR0+p6efPKRZm7a?=
 =?us-ascii?Q?orzzf171Go0YO40UVIrvHOrRIhbK+dtlmZ+QX476wR3Yof6SD/cqUjxqGgDB?=
 =?us-ascii?Q?OC2Wm6Jt2GnufaWN+g6YRHqgNk2OJqW4Uk6N7WTpN50MrFZs8h0IhEwZg778?=
 =?us-ascii?Q?QK/u7cR/GZhXUDy3Bu/+lrTGCOukAhgcY5NKcF/hn17fptFEQw4CToV3MmBD?=
 =?us-ascii?Q?M8VnuTabcUpK75GszHfiWxsgfmAKIP9sID0NG9yAKXai/AUbI9ZKpXFkiMuc?=
 =?us-ascii?Q?9dbSJeaPqfpR+sQfPDXQAxrvOhsCdzl+DMErj7xUOqPZStFDqhzTJhemmSqK?=
 =?us-ascii?Q?VFN89SBYRXzgOpQIgizLyD1ziqEqEwYVQumYvaIsGTInywoe5EOBm0Au3Kk6?=
 =?us-ascii?Q?FLTs7rhZ0OJ0KezwIUQl0RszKLx6TpXSWXRoP7u4N0tKjA5U1wH7mDUs4yAh?=
 =?us-ascii?Q?iG+kloWTb5UaaCdv/bjqKTRaz5K9xlxtQSb6Qi9Deqp4xGiXgddHvNRJU/7w?=
 =?us-ascii?Q?z1F62VnMN8JwKbGxnJ8HQlHTjx26Ri6a0GejgIAZjgWKnN+oCbC7JwP/Nf9C?=
 =?us-ascii?Q?wT3BcOhKRGa/iEr7QOxOtbEfYehkVhKgj9Ef7gy1uPACbOzY7TaL51SMLJVC?=
 =?us-ascii?Q?qnlP//e9oJh27L3UCduAUZ5dTSowt+jvBO7GPgjmsyyKzgFVw004N+/SyvjO?=
 =?us-ascii?Q?/CVoey4cDf8D5bKbUKbI7Tcx+JMRt4IDe/aLpK0FyY0wkz+a0zs852z14Jk/?=
 =?us-ascii?Q?iHgcZtzuxxpgvK5nQuajvWBaTFwZtVdvh8OW9Rni1vtxP+zygON6KZZovgDD?=
 =?us-ascii?Q?U7nx9UArPsvj/3XvoaH+kMaKPokBDvHO+eyaan0QX3s+AA5TFt2BbmewUsDY?=
 =?us-ascii?Q?z90eN3dlSQKM8qcJ8b6DVkqNj6PIQVmi0cPBcqDK+hh3XAOtGVAccdDAzwSg?=
 =?us-ascii?Q?3mUTQ7O/TrVL1DDo9+NZ1hMwTFJNF5EWX4nlnBcd6AJeiyPcfHg91BGZh608?=
 =?us-ascii?Q?hHPNm2IZa34H+UHKESvNFJG3/WFTYm7WgeHnBy0+EPYsGxiTdQFsqEDEFlEO?=
 =?us-ascii?Q?2+Akutjfwcf+UMu0OZsdEI/P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RKCFaHxT9KnPGt1q/zJgkZ6Lu0L2QGo/iirkVNmFJafofRgeakwL+VPQGKc2?=
 =?us-ascii?Q?aSzWnWVzZz2PG+9PhfMi3Za3CHa5lRvFRjmHaGRMakYOT8dVQkomRGWiZH92?=
 =?us-ascii?Q?DfK44YvgGhDbo19cO4TDN9MggzDK20azSHr3xO/Q9Z8k3EFhIGP3pvWxxgpv?=
 =?us-ascii?Q?OIphJJE+WAjE4CcUk8O3dcujrMiIGhZdmA9+74TQdDWIHg5mYLB06wnKqPMP?=
 =?us-ascii?Q?fZf6dUXdRGHY4ccI2ZlaGhimLkz0/cn2xFY94bAE5zsy40n3BHb188e/n0sT?=
 =?us-ascii?Q?4Lyt6n1O0FuLJa8UxsmklWp4TPRO4OU9/ylzgm6RJ6gWjrOLYAf6i1NgbAEw?=
 =?us-ascii?Q?AdKwTA11aLynx14JWVVHnObfX+aFV4QC2YZB7VctzeZxcaVa1MSFPnBa+b6v?=
 =?us-ascii?Q?9Mv4aStSEUy+eJSZaRCHaD7JAX0mEmdVxxgaI3iesFnP4Qp7UrhPg4jCins8?=
 =?us-ascii?Q?DtNlU6EfiISDMav2DwFOOfy6ehBh8NuXKFA87VlqYlOEFHAApcP0u8vrX6nU?=
 =?us-ascii?Q?MLn6t/oHV+2U4xe27Zr6SrM71Uu1nbFE0WclZVJCyjpjjKDxbjeJ6G5z7Kdk?=
 =?us-ascii?Q?jiJm9S288S9wW7KaB9d12ntwfKq3iMTBzas1ycEgc4btfm+FkN/4Pyhea4UY?=
 =?us-ascii?Q?8At/aC06xh2pj5kAgt6GUjA7LcGtWBejSOZ31KVur5iZiyzB8AsY4espGhGV?=
 =?us-ascii?Q?klZgfQqoyGC7RT0buQ8ugoy+My8E4wLv9vK52E3VyiMEfVdvnHYJHuS9+I8E?=
 =?us-ascii?Q?QwgSmCJLZrAiLGt1jhzHkckpl9MaOQTrkKr2+4aBR1DM9Fl6M0EwDJMWIoI7?=
 =?us-ascii?Q?hGhXBhd2sbe/7ymVC1xZHoYp8BzA/3v+dzZnQJNkn9BhMcoQ3i4HsyAdD9df?=
 =?us-ascii?Q?lEH1VAhZNT+TWHSQWRT8mHWjAtnKYhx8Z9shvv3lddAJEHIo0o+eknVrvZ4l?=
 =?us-ascii?Q?Z/WPxHxc+OfSPhDn0Cb8ZEtCP9Rq49tLcdhJxVk/L/j8+vo2d4jKtmrJ52/f?=
 =?us-ascii?Q?lT/CXfi1XMPWbqFFGRE05gZjamzvG+M2J8jPGuTSfu/WBNls786hWmpEAT0d?=
 =?us-ascii?Q?F+BwSi0O5n+lY8GbQOVam19OaNOZFIvdRwBLUC1H2e1fjlsgDm3ILFMc5amO?=
 =?us-ascii?Q?YlglD+oqJWMS5YphRXmOlaty3n7o8+kHMrCntCW5TIs3wSGdiiJspWNx+L8n?=
 =?us-ascii?Q?MfTOGsIIVllEnhE1UcllnIU0U6/SkuTBl+TLnYTt7OH/5ROm9DWqWW1Gl3zM?=
 =?us-ascii?Q?anUOOFAQoeUHvrbkYSCqdbiFJ63rzuuAA42HUZWOz/VXa143zmd7SUwlcBLO?=
 =?us-ascii?Q?FnsTfW+j13/FOetwFjR9mUH1ajz1roA1ffiaOyVhHRQ0YYpQoFVqIXmG8V6o?=
 =?us-ascii?Q?am0UhujEdP1OipVcuXNsP//FPZw9yPA9zJqMxjCXPt3bZi+9lmTxY91SdU78?=
 =?us-ascii?Q?VrhrKuR9++Pkib4UbvmmoJEpS1GC2E1jO/1o3KTjdmjqWSvFOYR3E3AEBYTU?=
 =?us-ascii?Q?lAk32mxRG5g+Vhm+w+MPXCO3FnmZM23QOVi9Iho6bbeRDdEy+K0mhCF/FsIQ?=
 =?us-ascii?Q?4zwpmyiortglHB3n76/e2XAPzDCprMytBaLRyzSuCsmmjEPgBtiESj26CAJa?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	viEFWOBfG6R5KDwg0jvdXoiPe88R3bzlB9Ckx5VZDp8JP3nWmRroLuz3mXTguO/cwr+FbL742psg0EmM/i7bGrchpU5Ps1n8GPy1LI+G5Tf/muvQ50XvK5iza6tq4yOnu83ch+9hQogMGuoGjRqnIbN1QYeebo5blMr/EQrhWnVMIsg7MFS0LhjNOOO9IZDT8LEKcManXteHwpe8exMAE/Dm1kXiYiwUAw7oYX6wSTfOtdRJeuo3cn15Gdk8fsbU4AyxNRBhw9v8JF20yOtZO3dRfALgvm/KbndkY0Ze+SvTNSclwMF/oYo4ydZtfvLLK2hQTcdMsCeSepkuTa/80IB8h7OZVhE6bIQLfhcIuKZTCtnAQkyXg7ZBBjU2KbOOk8gYqz9GyfEhr/OGzwTflXC3mA20qVpP47SF6ciFnefTJwFRLZyC/pUYXse+ApHEhdiM+NMfR+uRS8GLrQSE+xFWJlN+ghtUBcuNbQOXynyxEdMgVhtRMVb7hVQ2JiWZ7X7fXeFEQ0o5Xnps9JcsTU9SVBdS7m4K/hZpYdJ41sLEsjz2zGuVJH+FLSmGIUauq2oAh/Sv8aqzvEVAmA7ZedFfavVvGpFIXzZWJT6HozQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3841f01e-237b-4d3c-dba3-08dcfd0a9b7f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 19:55:18.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rcy/SfTpZlvPxd/LLfRctH1NT8vCKPl5XBNZXdrtSV/T3QzgI05OcVVVDiNiZoGbo5lnBEbuaFHElWyil91AHMsXBMvWBwIwLpHpvWBN8hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_18,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040160
X-Proofpoint-ORIG-GUID: pwCuM1_8OSprN-a8Rw9zXf69igJVPT20
X-Proofpoint-GUID: pwCuM1_8OSprN-a8Rw9zXf69igJVPT20

On Mon, Nov 04, 2024 at 03:47:40PM +0200, Mike Rapoport wrote:
> On Mon, Nov 04, 2024 at 01:02:19PM +0000, Lorenzo Stoakes wrote:
> > On Fri, Nov 01, 2024 at 04:48:32PM -0700, SeongJae Park wrote:
> > >
> > > This is the "Unsorted Documentation" section.  If the document is really for
> > > the section, I'd suggest putting it in alphabetically sorted order, for the
> > > consistency.  However, if putting the document under the section is not your
> > > real intention, I think it might be better to be put under "Process Addresses"
> > > section above.  What do you think?
> >
> > Well, at the moment it's sort of a WIP thing that we may want to put under
> > another section, was just putting there somewhat arbitrarily for now.
> >
> > I also wanted to avoid too much debate about what to put where :P
> >
> > But absolutely, ack, will either sort it there or put it somewhere more
> > sensible, thanks!
>
> Don't mean to bikeshed, but it would make sense to put it to the "Process
> Address (space)" part :)

Ack will do :)

>
> --
> Sincerely yours,
> Mike.

