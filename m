Return-Path: <linux-kernel+bounces-306742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093FF9642CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6340285FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB5190698;
	Thu, 29 Aug 2024 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c+rDxTdx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q0TraHp9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3118E020
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930058; cv=fail; b=SWLnbS9Xt0jwq35sUeihi05AF04oSM1eFagOVOznwUU6eQNdQtucYhrf4LnimTkdFfvjCp5g++NsEMqTfMTyJOwG76QoHkO6VF7QaVARI4QG4yKHv7h4l1OaXIug6DHcdtZH1BdfCS4T+Jv1Haze/qiX4Nij5iHD6GgkFeAoJ7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930058; c=relaxed/simple;
	bh=xh65BJsFP0a6H96DbJhvbqoidzQtOl468xCY5ws30Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PsNagfSTPNex8rj4rZSzA185zZ8XcD1JAv0S7jilXNtf1I/svq7HvI4sxLpqqzOWZRNL3uF8dFH90h1mnCwCys0Ag/nue9Nwi4Pw+NzbeI1v7XBgSF45i0oxARordL/6TFNLp1Ox2Wk1yOvfC43kYWvmaWqbulAZV9RW97QYPgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c+rDxTdx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q0TraHp9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T71DmV018297;
	Thu, 29 Aug 2024 11:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=W7f5NuEn9GIZcEW
	hRvNK1JWRFGiD8PwEn3nBk3LaCZc=; b=c+rDxTdxn1YNfUXFrSPdpKTSLZhdMAw
	tpMc00Z5uFxJ+FdUHUXNavA2HvQDrv9AwZ9YHW1V3IDRCzCvkMkUECFLiNn3tp/l
	LgfWmwRhpgTu+Gsjf760NFKeaszOUwcK0wM/Op8bAvrDv+39wtk8+R27WVm+m7Zv
	q4fEtvOOGTNurjYcKmpKl09CmWqD3UxgDGarJgrtfzJuOqxsEe5dvdz4AviNhED6
	q1PWozpsnjel1XU55XxmOPBV9TlzAF8wLNBjcH10hFTuUj9rLp5OyqL1KitQpaYJ
	/1+2aGjV7hkGyXVruPpg2HYSIdQ80sErlCClplpavJ2Z+gUzFtWyBLw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwv3vh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:14:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TAFrlK032482;
	Thu, 29 Aug 2024 11:14:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0wjnux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT5pK7PufFp/aYDN+uBPrwCQqm+JHvjZ2G0BultxKJ11uJJ4J+3ReUOXmOsMU/aMvvet7A6++xcWT3PlwdeCc2VXaxXAr+9bXkBb5YEpczfWoCP4qPpF5wkiZCePaBQfKMjBxEcYHC1fGZsJGyS4FrC6AN1vMNNTzADEJAxJ7ISXqG0UTq3kwG7+ZeE5NQuTcB9JkJhz0oYgCohmVtRFgfQEOUN1ZHDN5ZMJ2Zbj83n/vg4Dl1KY42FPKIxS0OzRWciT26J41ULSxqHVm0i8IGQlTBtpy5SVk4+tXzR+gmnuH4jeURe6DOz6SAz8srLFN53vOPBgs1SXNrAajE3Bew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7f5NuEn9GIZcEWhRvNK1JWRFGiD8PwEn3nBk3LaCZc=;
 b=d6THbBzvzgghTgcW6Jl55ijFGX9suGmBpOSqettTRhO0YRMWZ6GaP/J7DCmE14xyw6hJV5qICB63dCMfcOGKm5tHAFluqWF/4yn9IK6anrELz9AJoQRNxPqZO3QgopLdk8kS5gLlNKckkL0rAvoF0lkLmPseVCSsSVUSsl6JnMe33WO0az3DwwAxvSrEeZx21cVIx1P9J8jZrUeDintMlRtber+kyVk6PQAQpsKwPXdxrz0L0kGmKDQ1YsYspyOADOfvlv/6CK/sM87lFdvslUbJszOB55hjjSBDt3+mrpquqaXOnkq0fzjZiIR0BuIiczVC0xGqzxe3dlZTQVC8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7f5NuEn9GIZcEWhRvNK1JWRFGiD8PwEn3nBk3LaCZc=;
 b=q0TraHp9D6YTTE+zHAA/apadlsmyO1PV7F1iA5VorX1iFoyClIzVZH3gYrtGCG9M331TZU88ZYEIJ3LSBhZ4TG0WAGYgEl23ENAAXWHF5PfEKVPsvDlcYGwpuK0dat99m19b5D3GhYrC0k8wRTmfRccGSVWDrSEe6wxP1WZoHqo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7954.namprd10.prod.outlook.com (2603:10b6:8:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 11:14:03 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 11:14:03 +0000
Date: Thu, 29 Aug 2024 12:13:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Xingyu Li <xli399@ucr.edu>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: general protection fault in mmap_region
Message-ID: <c981e6dd-044b-4a7a-83a3-5c49a31d1ec7@lucifer.local>
References: <CALAgD-5myPieAa_9BY6RVfBjWT_8g48+S0CX7c=EihMzdwakxw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-5myPieAa_9BY6RVfBjWT_8g48+S0CX7c=EihMzdwakxw@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 19af48ef-1d51-421c-74ae-08dcc81bb072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dvLwWPHtt9KfsaiACSreJkxJK8Bve89r54Zdo8zA1LIyMjNR+eH0QkdZvQOW?=
 =?us-ascii?Q?mv2g5ym5sqoWjpzVgKdgiWI/uog0tnIKUtJPkfqPj9dg65TfRxraPprDl/lB?=
 =?us-ascii?Q?szOmBvUWgeBFYarINTXV+og4E9MEe7kVtFvS0db6wvlW05DOuaAt95svxh6b?=
 =?us-ascii?Q?z8S+bhHyRzwN82yUXYvgkljetwBpZpHrN0cyn0LKL8MfBq8JB9xDxd9DdRW5?=
 =?us-ascii?Q?INfMZbJhaQwmLBmYq5Ybu56zz1dik+AdX7UVKpnRcAwazIejpxzQVotjuXQz?=
 =?us-ascii?Q?XPJJTuyQDM8NwSDwalMaKGKGRoF7M7ncdXDRw/HHo7XW06IKDnKH9ClrDhzK?=
 =?us-ascii?Q?vrYHLHh23SWVnusb8yQPzKNK+CVsTnrKZ6U9dqK0kq9Ko5UCQW7HXKusZwfN?=
 =?us-ascii?Q?hBTvbwdCFcSYs7LGly236xAo8y8ALAFwmekJZwenjHCVqhdieR3cuKsRhKJx?=
 =?us-ascii?Q?mRro6opKwnRl3bNrBZy1B/S/2T8qYflM8kUYg0FARxQFAojtuReHegFhtZU0?=
 =?us-ascii?Q?7HONT3Vu2OIuTGUg0fl3Oc6T3c/79mcxRauiz7oXGFyIT+ZznwdIyOesE0xf?=
 =?us-ascii?Q?ueP9R9PD81ytLrIlVyG8/CSHhfx0O2kdb85EXV//KejW/o5c0XbGanAlmlMs?=
 =?us-ascii?Q?rVkpn4Ui+kj9/XdugXUA45VTKiG6Zvi8/2IQYGE1SRli7v5vgNezxcv2JkbA?=
 =?us-ascii?Q?gzYmeQpIJ/iSJpqZi+1WSnRRum6rnzrT3ypdYKXp6O9ml5ke7bjxFBSU0KW1?=
 =?us-ascii?Q?4vmk3Ejx4xdXq9HaQXwCe4Iu8XeBlts8XNfHQJ2PtetRnk9HPY+cAiEJ9JaV?=
 =?us-ascii?Q?5kxZc/GNft42S+mohheydxQzBUJlb4WPNr0yyl71htsWKSBLz54NAMc9dKq9?=
 =?us-ascii?Q?WnPvYxrOKTWkUBr66DuzSt7VCpNNIHMib6Jn0IWvHyWCLm0ZPvN4TpOWEzol?=
 =?us-ascii?Q?2KU6q19aKBnRNnS969P7DoCbYqFmwtLgQOQxP5Rvyl4mzE50oeN7TG/cgHkR?=
 =?us-ascii?Q?ohc6lOc+T1cKcSnxrO/vf4JUPU9bt1YUjJprzH2zpq+Hpx3jES2oXFUF1G73?=
 =?us-ascii?Q?Wrw/56ItwhlY2xqcBl6VdZ32wO5BUND7siA5yXbFEdZUgylx2aE9dcUG/HVu?=
 =?us-ascii?Q?HjXxyk5Ldzy3CZDGFWET+1vjvli8r1FgI8U7CJTqfb8YBryh7fOioiAyRNdb?=
 =?us-ascii?Q?eD/q5Zu17eSHtug/I4DOYyJjOcwZRz6f1EtSnBp+boVtEpUclFlvPPbknfOA?=
 =?us-ascii?Q?j0HalDEaiUd/osuh04/zxBph/10wRlSt2c8WTS/SXXnF1Hd40Vbs6kdFL4s+?=
 =?us-ascii?Q?cKY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjMmYnIQZCjPmn2lM5bRNZesHu1MAXcepSMlhq3rQZGK6vRuUdX4HK3BVOfb?=
 =?us-ascii?Q?AXdTexAZselDQWexWn7nipJTFpYAebDmvUfha7tUnrhgMCD+Aj5qFhBVtx+A?=
 =?us-ascii?Q?YO1WRMH8K9wf8+d3xl++L3XZudo4Ks6jsuB4ikpkvDpLaKNkjz5Nyg2fTjCf?=
 =?us-ascii?Q?8JAtLzqMWEW1ROtUP5lXx64NzgEsEghK8ZjcuugWWqMp6h8aTS/XRy+NsA8d?=
 =?us-ascii?Q?GXVVaCVaF+ELscUS6070MB1d1fLoWA3PErgA88nMYOijra4OudpQM82eTJ6i?=
 =?us-ascii?Q?dqb+EYwCSIryAjPqk1sGJVbrR7F/iCydhjynBNajrPb0Xgbcns+hXAVSvqY+?=
 =?us-ascii?Q?I+AlJopnVL3kSR5yeG3byHWJxq3VuxX3ddi2u1MdfwNhXanrqJww5TepQ5VY?=
 =?us-ascii?Q?aPyews1Ft7BDCQdb1msZK791i9qhnbJQrCUcrJ0RnFC993C1qrpi1i9r9MiM?=
 =?us-ascii?Q?p+ZqCTDb2Ej/qN8mIt4jp8Uvu5U2SEl4BI6gfk8ntAXo1ixMejhEvk0pgNYm?=
 =?us-ascii?Q?2kmu7sd+k+9mEdJQuw1w7D39BwyXcaxPAyBqUbw10DV/gVKmEXwByG/bAXqC?=
 =?us-ascii?Q?Z6wbQfjhNYEWyIi5F3uCOhsmyYnbl4dGOKKrsQ1l9LknddVX1DeK6dtXvTO/?=
 =?us-ascii?Q?TvLLRngNeM0BaFcLzHFuSw5iXmw55481HSzkT5/oy9TPKrc3fcVPbhgYk7yU?=
 =?us-ascii?Q?BbhVr7mDvMIlGYEMtvmN3dlHVaAV2naXPnDIyjTyqcoVyz8XmMnGtDepgU3g?=
 =?us-ascii?Q?s6KK5hIqxPAvTNIWaQpyrlOpqrSjavQYkvzD3pmttxlAN2GjNbUViE2xGZ2O?=
 =?us-ascii?Q?21rVJbuJud/CBNWWu5x0rZPIyKCf3d8BsmsuXnKlKxvJvtyo+KZwq6DwfT7G?=
 =?us-ascii?Q?U57gT7qJ3yNrLQJCWz8AbOFJt0rpBohgVPofEpKzdNlbvAHZ3o709T9MryXQ?=
 =?us-ascii?Q?nXIWHHaXYcb3fbnIz5kYHNoK0BBxPfT7CxGJ4ByduWR9t6w2MVgyQn2XeMi3?=
 =?us-ascii?Q?n8IdcOpRtcICobxzDx9rvvAy/RJoksmY41CmiMuCgeKoGdpYG55xFvlNP9G7?=
 =?us-ascii?Q?ht8AaJrT+pG3SRByjvEpcPakGCIsPc1aPz3wxtI3v/BL1ubIO+HvBau3mFHy?=
 =?us-ascii?Q?th/QCueEiywnugPXtC5ybtHXLQ1iXeq2qDCyhzngy2LUIn+JBQxEIGRlAKva?=
 =?us-ascii?Q?7/Ra6AR+PCpc4et1h1k82X0584/f8rkV2zG5r6r32n9OGDixdwdEE+luMdc5?=
 =?us-ascii?Q?LFjx2FIv1tzeUXMMlZeCUGfvBBAxrmvLMWbGKPtVndq4BPahVW6ToZ0jllc9?=
 =?us-ascii?Q?9pE1sTFimxP92Z0vf7NoJaONXLkAdkb0cEbqv0WOhmOz2onTI3e8/LTcCjN6?=
 =?us-ascii?Q?c4TiZOTG0YLzhtCzyxtk0kfTtVl7wM8DkEphI83+Q0D/+T1+2LS+bqP056sA?=
 =?us-ascii?Q?a+clAHxG+v4s453X8H01ycJN9X5zdlAcuKlZT3SKQehP8tOQUSYOt6NRGsNi?=
 =?us-ascii?Q?3R7FptEPCk26ZBV2N38+wEib5uU94sKnEKGu2oNWsFWUpQpneDtDFok6NXU0?=
 =?us-ascii?Q?0Q1mYsc6y3XwKf7fAwgLDwDf7LoLNhzopKHS4mQCKQmlT5ZDYUyJJtglnZng?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9sUPX2WBR5Tse9rtkaX7UZl9MkTD7yBT3suOxIGfIXuZ/HJd4yHV1TggqiGWEckY7yUe3+BwMPF+vpV040CbTJhZWCqa0eQ3d4/N0Onm9oyJTgU9YrsYjsx8LqJT8ALmbXaIxRQj9YF+6UnnOiyr2eHxGrV/z6w6qZJmvD5/d7ayGblgY28IQ5JVfSRM0D2jzBQMLckVAlmsMjFNPR6GOSvS9v1BTbZWwJRbEunnSg7tFrnAfHXKUH9lNT4I/1UL/lPe47suohCcxiIUZqEtiT4Y97y1tMyAey5FHH5rxE6UIBTuwS0SpVl0Hw5z5JBcZ3zosBU8QXlRc4dMqJQxsIxlw2kXR7EpiUyjMoFdEuEDwUnC/TPe6dUes6BRk0Y1o79eRXbmXlrRW26zfBVKMJ3IsRfm2QsUJTSCCRyesZU9cgs6zjno02sbr8xZuIRQ1OwWHZb0dBhXi8p8SmE0/5AUb5AXGKBRA0HNSVjOEkLDzR37ST5w18WDyOtt4lRcg7wN0dUVJT079MvM6GSD4TBRTTDrSC9iCFuGivBXEuw3BKabNfWpW8wTPYt5FmZksTYrxUXS1O618l9IUTL+ZZg0hwZESRyTfMMHn4Dj8Ys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19af48ef-1d51-421c-74ae-08dcc81bb072
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 11:14:03.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xe30fdHGQj0fXoqZM9ZsYh0f9bOeW4fNpUfW8ezjgeTXo+yAIM5NcFmIELJf5jy0UVXkYTvDkq+DznbdluPAns9miTfW6vWUB88nesEYD8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290081
X-Proofpoint-GUID: uFRrVZUdFq4fQh2FVJ9_oEVTyUGJW2jo
X-Proofpoint-ORIG-GUID: uFRrVZUdFq4fQh2FVJ9_oEVTyUGJW2jo

On Wed, Aug 28, 2024 at 04:07:05PM GMT, Xingyu Li wrote:
> Hi,
>
> We found a bug in Linux 6.6 using syzkaller. It is possibly a  null
> pointer dereference bug.
> The reprodcuer is
> https://gist.github.com/freexxxyyy/67b082078a6d4da117013f0f269bf7cc

Hi, thanks for the report. I'm assuming this is for the kernel in Linus's tree
at dead on v6.6? The line numbers seem to align with that.

Do you have a broader dmesg or other details? Do you have a .config?

Be good to know how long this repro took to hit, as locally I am running it
in the v6.6 kernel and am not hitting it, also spamming 'program repro is
using a deprecated SCSI ioctl, please convert it to SG_IO'.

>
> The bug report is:
>
> Syzkaller hit 'general protection fault in mmap_region' bug.
>
> general protection fault, probably for non-canonical address
> 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 8267 Comm: apt-helper Not tainted 6.6.0 #9
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]

This is:

tmp = gparent->rb_right;

which would match the reported NULL(-ish) pointer deref at offset 8.

That suggests this tree is corrupted somehow? Liam might have thoughts...

The repro is doing some weird stuff with the aforementioned SCSI ioctl's
and interfacing with a device arbitrarily, so I wonder if the problem is
actually to do with that. I've not dug into that in depth...

This might therefore be related to the actual configuration/device this is
running on. Hence why it'd be useful to get a .config and full dmesg.

> RIP: 0010:__rb_insert_augmented+0x78/0x8e0 lib/rbtree.c:459

This is:

__rb_insert(node, root, augment_rotate);

> Code: ea 48 c1 ea 03 42 80 3c 2a 00 0f 85 7f 05 00 00 4c 8b 65 00 41
> f6 c4 01 0f 85 2f 05 00 00 4d 8d 44 24 08 4c 89 c2 48 c1 ea 03 <42> 80
> 3c 2a 00 0f 85 6f 05 00 00 4d 8b 74 24 08 49 39 ee 0f 84 77
> RSP: 0018:ffffc9000962f8b0 EFLAGS: 00010202
> RAX: ffff888018b5add8 RBX: ffff88802e724e40 RCX: 1ffff11005ce49c8
> RDX: 0000000000000001 RSI: ffff888018b5add8 RDI: ffff88802e724e40
> RBP: ffff88802bf80f40 R08: 0000000000000008 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: dffffc0000000000 R14: ffff888024c55680 R15: ffffffff81c875b0
> FS:  0000000000000000(0000) GS:ffff888063600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055622b1160c0 CR3: 000000002afe6000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  mmap_region+0x1466/0x2800 mm/mmap.c:2846

This is:

vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);

>  do_mmap+0x86f/0xee0 mm/mmap.c:1374
>  vm_mmap_pgoff+0x1a8/0x3b0 mm/util.c:546
>  vm_mmap+0x96/0xc0 mm/util.c:565
>  elf_map+0x118/0x320 fs/binfmt_elf.c:395

On the other hand, I'm a bit confused as to - if this repro is meant to be
the thing reproducing - why the fault is happening at the point of
execve'ing a binary in elf_map()?

Unless the repro is somehow invoking an execve but it doesn't look like it
is so... is the repro actually repro'ing this? I mean it doesn't look like
it is, so it's not really a repro.

Seems that this is occurring when it or some other binary is being
executed, which is such a fundamental thing that you'd think that if this
were actually a bug on _process execution_ that it'd have shown up by now.

On the other hand the repro could somehow be introducing some instability
that results in a subsequent execve() failing (again, full dmesg would be
handy here).

>  load_elf_interp fs/binfmt_elf.c:637 [inline]
>  load_elf_binary+0x32ab/0x50b0 fs/binfmt_elf.c:1249
>  search_binary_handler fs/exec.c:1739 [inline]
>  exec_binprm fs/exec.c:1781 [inline]
>  bprm_execve fs/exec.c:1856 [inline]
>  bprm_execve+0x7f5/0x1990 fs/exec.c:1812
>  do_execveat_common.isra.0+0x5e8/0x760 fs/exec.c:1964
>  do_execve fs/exec.c:2038 [inline]
>  __do_sys_execve fs/exec.c:2114 [inline]
>  __se_sys_execve fs/exec.c:2109 [inline]
>  __x64_sys_execve+0x8c/0xb0 fs/exec.c:2109
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x40/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x6f/0xd9
> RIP: 0033:0x7f507cc66c47
> Code: Unable to access opcode bytes at 0x7f507cc66c1d.
> RSP: 002b:00007ffe880488a8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
> RAX: ffffffffffffffda RBX: 00005621cb93a230 RCX: 00007f507cc66c47
> RDX: 00005621cba830b0 RSI: 00005621cb9ed600 RDI: 00005621cb911990
> RBP: 00007ffe88048aa0 R08: 00005621cb8b13e0 R09: 0000000000000000
> R10: 00005621cb93ef40 R11: 0000000000000246 R12: 00005621cb9ed600
> R13: 0000000000000000 R14: 00005621cb961ba0 R15: 00005621cb9ed600
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]
> RIP: 0010:__rb_insert_augmented+0x78/0x8e0 lib/rbtree.c:459
> Code: ea 48 c1 ea 03 42 80 3c 2a 00 0f 85 7f 05 00 00 4c 8b 65 00 41
> f6 c4 01 0f 85 2f 05 00 00 4d 8d 44 24 08 4c 89 c2 48 c1 ea 03 <42> 80
> 3c 2a 00 0f 85 6f 05 00 00 4d 8b 74 24 08 49 39 ee 0f 84 77
> RSP: 0018:ffffc9000962f8b0 EFLAGS: 00010202
> RAX: ffff888018b5add8 RBX: ffff88802e724e40 RCX: 1ffff11005ce49c8
> RDX: 0000000000000001 RSI: ffff888018b5add8 RDI: ffff88802e724e40
> RBP: ffff88802bf80f40 R08: 0000000000000008 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: dffffc0000000000 R14: ffff888024c55680 R15: ffffffff81c875b0
> FS:  0000000000000000(0000) GS:ffff888063600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f012fc22f70 CR3: 000000002afe6000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0: 48 c1 ea 03           shr    $0x3,%rdx
>    4: 42 80 3c 2a 00       cmpb   $0x0,(%rdx,%r13,1)
>    9: 0f 85 7f 05 00 00     jne    0x58e
>    f: 4c 8b 65 00           mov    0x0(%rbp),%r12
>   13: 41 f6 c4 01           test   $0x1,%r12b
>   17: 0f 85 2f 05 00 00     jne    0x54c
>   1d: 4d 8d 44 24 08       lea    0x8(%r12),%r8
>   22: 4c 89 c2             mov    %r8,%rdx
>   25: 48 c1 ea 03           shr    $0x3,%rdx
> * 29: 42 80 3c 2a 00       cmpb   $0x0,(%rdx,%r13,1) <-- trapping instruction
>   2e: 0f 85 6f 05 00 00     jne    0x5a3
>   34: 4d 8b 74 24 08       mov    0x8(%r12),%r14
>   39: 49 39 ee             cmp    %rbp,%r14
>   3c: 0f                   .byte 0xf
>   3d: 84                   .byte 0x84
>   3e: 77                   .byte 0x77
>
>
>
>
>
>
>
> --
> Yours sincerely,
> Xingyu

