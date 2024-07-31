Return-Path: <linux-kernel+bounces-269537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5819433FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9646FB22DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2311B14FD;
	Wed, 31 Jul 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PwJjqdLy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pNmBu+/p"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49217BA0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442576; cv=fail; b=TIRzJHdR4NKEOYGPYd1Uziv1d01cq6CgCc96U0CYyUfKEIYJ1tqqw3je/0NFqEP58zCtF4kPgaObvpN7WhqLQp/iOjcZ9man9h8V34Ls0ZbTgKCLC9HUo5wgr1PfSD2qJrvpPLPG5fKcl+7o59g4gGiwinsNPhhTQD2Jh+i77mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442576; c=relaxed/simple;
	bh=2EV0hVavNlFgYLZvOkumUPOF7aDA9KnrxzEGZ0PGZ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KVJxEOx0LAkyTqC2JvZdJ5sUPiQcANejDiHitjt8Lsv0++y4KpfWZLiFTAfcWjaIzQPTJpEj5JuzbhdlptX74zE2xgQfueU28Ov1cIJH0r5B8Iw8LBdJu0LKxaWP/3pCl1eYZGpgpraAyvsul0eiZmfZfFzOVWvIMmDh1qFalFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PwJjqdLy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pNmBu+/p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VFPp0D024230;
	Wed, 31 Jul 2024 16:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=SfiNTV63oLIMmDC
	vJe/r6BdWn1vSiFZpLVPNwfQLNUA=; b=PwJjqdLy4w6kIChjp8R2v/y1hPQW4Wy
	VrjZemrULSvsz9X/s4gcCB56Ovtg+kCbG/72d7ldJ5yixMOz08stOstNpZPEZMsX
	F0qDjdDw9rFoephZUzMpJTNXpeJD07a7+OhSFL+DYpaOFAMjrbLK3OPOUN+iyArU
	dhh24/W8FPlJ3+ABqaFt+nYqPI9NcO/2pV/MJU+6oWC+jm6cIkFuu+tgwmYF92dU
	Rjx1S/yBEtIv2R/fUXaTOVL1SEwzY1neOAJ1wVFOSQmrhEXAMoWORRVUEMP99/Xs
	YCk7Pi2EonFsx59tZkEjXgvSaV4wMHqisSGhBzDJO22ohjdTHBDZjLQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8qp3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 16:15:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46VFF9AA000850;
	Wed, 31 Jul 2024 16:15:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40pm84tj9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 16:15:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5EJg6gnp3rKE9UwbGZIsH3XQLOqnsJNL7HyE/PSQqR1q6eVL7SUEbuosYLHfKDTypYBfm0nH3cQczDape5BL8JQEUMFQBZ+YCXrLW+jV8CEn0l8w9/r3nLZsrLcuzIzx1sai9YWZIsjxAEYqM/deMjNPXwXz4EmgrhHNesSFzthnTDT2Ey1mdRAhbN+D6Cw4wQTSTlH2lRdZpqZSdDuDZFUTvzv7wVgydqJeZjv6iOPVx7aSK7prrJr9kCPC1DKI3P6W8VC7pbHL3edIdU6IKV81RFti4a9giqagigOYlyyjmzsA5S0Db4C6pPA2PBM/iht+PsFINWp391wFo8AOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfiNTV63oLIMmDCvJe/r6BdWn1vSiFZpLVPNwfQLNUA=;
 b=LSpQaRfJ1anoZfgwOotY1vmBuIKWCscoM6IzJSF36jHpYZ17ZOQtISjUOT3ZN5fFznlhmy2C4xxFf+oE6ItxlQYFJYJLfxCL6aPPoEpPbXaoT/YvvG18cbVlFZnUrz5hRwI5JO0XvvuADhSbul9MGuoi2EsvWGxWII30YkETelcmp3KmWYae+kihWVixrlchLjUM6AWG+j8mBxCT9MnimgSw2r6c5jSMeLSU75PtgQbkoQvgIPBSQ7pPoJq6dwtXdlRwh0ow0ZXZmMbXJcr49ZDEN7+a+pQQRl6akomrxFiYwpA/azOBN++0HBkLKQso2mKzCx0Q+ekvSkpYL1uCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfiNTV63oLIMmDCvJe/r6BdWn1vSiFZpLVPNwfQLNUA=;
 b=pNmBu+/pVx3rpXeB7+mP6FQPuI8Mak+nonJhJkFyNq2+TIneml6KzCVkJNWrkoxfwyZIw7Eq5h0iqy9r65kRtyWFMWKuUXhtcZR9zMduyP7OVI5WE6gaWTT27jf2ybanHHnopkWusw1kZbIVLYwCcxLJAq+H7Fq8ob6i1qQPAnc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7930.namprd10.prod.outlook.com (2603:10b6:610:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Wed, 31 Jul
 2024 16:15:45 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 16:15:45 +0000
Date: Wed, 31 Jul 2024 17:15:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Donet Tom <donettom@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 6/9] mm: Make hugetlb mappings go through
 mm_get_unmapped_area_vmflags
Message-ID: <47de87e4-47df-4024-a313-03cc14b8e248@lucifer.local>
References: <20240729091018.2152-1-osalvador@suse.de>
 <20240729091018.2152-7-osalvador@suse.de>
 <8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
 <ZqpTaKHdrYt61HYy@localhost.localdomain>
 <354e4db4-e257-48a4-9e05-7f0595728ec6@lucifer.local>
 <ZqpgdBk-3Bcl3Mvr@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqpgdBk-3Bcl3Mvr@localhost.localdomain>
X-ClientProxiedBy: LO2P265CA0472.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::28) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: d359c35d-1e14-479e-8075-08dcb17c087c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mf5gEphXKXJELbuwK+356EvGIAucBhNpmd16TFQz7bK9mFS+R5uK/4FB8tz?=
 =?us-ascii?Q?ygg0zs4td8zrqlCH82FYK+F1uSrsaOAHAx7QBUIfKvD26D8wwnoib///NPJA?=
 =?us-ascii?Q?WTxg2l9/I8eIRTsHIDOWaauAfxgJ047YeqCoI1wduAtIF87MNQdGbjE8nhwD?=
 =?us-ascii?Q?jDXdUh6oYjSYjG+TzbXSQreZMOJ26u7espsRLlu0bycV3qmmzi4rkMX8TeF4?=
 =?us-ascii?Q?XulhlcUB/WqAfuFwwlJfhrA7QjGzuBDVpwo9rap2EUlG5207seuKtacT9cSM?=
 =?us-ascii?Q?UCEVNoMARORYJfB8nPLa+RaHBp9+HZiyVEm35WBfSVn+5z+RWkg5N6CZhuyl?=
 =?us-ascii?Q?Y1xsjov3ETP/QW84sS07qJGSVawX0wszqLDs6OJBQYeuk9W9AQQduBoX1qeS?=
 =?us-ascii?Q?V8m31fobY3JMdKuwmqx3Tu4xDmeLTVD5tuM8v1AX+e937v5l/t/oPcA+qF0R?=
 =?us-ascii?Q?JSo6oP2sbA8rFM1tOUPLvc3TtUSZP8KZ43iHxfxnHgSG0tLuUAwmSHNAdjPs?=
 =?us-ascii?Q?TvqQrj9p1f9Mjc6wafA051YP4ZXVF8HnR2CjQFiZBpY0gRWgYoBVD+XNXNLi?=
 =?us-ascii?Q?+9BFKwn2EOUdq01YnBtyHn4TTK3fwAaeBxZBZvCke/tKipZT6/ahmLbEfhe7?=
 =?us-ascii?Q?XHFzBhJHgyUTTvdyY1SrfkWAEXdS09v21d2zfjORyh6e2Sks0tRztF9I8pTm?=
 =?us-ascii?Q?RPWoZCy7skonGD2Iojakxh/YQKRYGVCJfYRhAh6siRlDGi+oeydCTnRLtbED?=
 =?us-ascii?Q?gD+3C0ejrsiprQEEF5JbFC+aWzQdk+MYgXVAbckFJEA1uDpUGWyGrEWfjFle?=
 =?us-ascii?Q?4jq7u1lsiC/yJDRHf2HxfXcavbFiwcw8PiXW2mNlBRtOFfR6GlAGjuYLXYhI?=
 =?us-ascii?Q?CE3GH47PYfqM1Lj9ulq89R63BtLaGWnXU4f412OjXM49JsCgNsoIwzlmQTyn?=
 =?us-ascii?Q?skeZlenVwERHqPcNdxObyoFJsDhfr5m6qN1uDrXOy30ejWBLmzTBtr+cMPcA?=
 =?us-ascii?Q?M7KSWEhGhKEXsAX8egSGw5UPAKrvWpCb/8VazpLAGFAuwt538K762guJFsMy?=
 =?us-ascii?Q?hwFZwXgd/dD/zWHgyfjPHBw7l5KeH2WpDBCeXhO8PvwtxSOf9vrgIQitTktO?=
 =?us-ascii?Q?YIduqNSakhdHH/O7r+cgmgafL6BKp1MRGTah55WbMgi2kgB9Rn8wXTv1faxh?=
 =?us-ascii?Q?ZHDE4/VS7VuPsdM17zPjQpE/wOj8ZfpjzctaPJpXcwB+9NFyaa1sbPhpoahU?=
 =?us-ascii?Q?sFtuJlTzoUWtg8kYKPR+ivvM79hoNuw6QYcUGYykfKApIlRnlrWpOlZqyEnz?=
 =?us-ascii?Q?PE7IZRrPEmL3hh4wzMKUGNjDnwzE5Uag4WE10OyFiS/zNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aB41ZotftWPkHv89P12SNEGyhZQzXKIEQcprY2U+N0vvrqn1+On4tSOxBgkI?=
 =?us-ascii?Q?mTGnLWBP5oIRaVRAJBYU5EKJlJdXcInLl4z5+exRqKzi6WuVcZDbBo1Jqk79?=
 =?us-ascii?Q?xwpFICzAGeDHcxW22APaBEB+xBXMA7wz8ua+K17X/tGhb2NwLri8EJRK/Q/O?=
 =?us-ascii?Q?bXkPVXFXOiWiB4dtWCyo3IFdIZGFyunhrTP3nvHCAOYoV8SJAxEZuyk/+sxS?=
 =?us-ascii?Q?od4vWgvyPrfTWiRfOQ4oZSMwCx8PzxrcUwBpPx77j36TZ+ZmLiw2ls4BOq9z?=
 =?us-ascii?Q?+8F9+pvpKXKO3ddZmL+KYsOq5LyE0FuLUYZ47nbsPjWjJgIVT3NbxzPekh+g?=
 =?us-ascii?Q?syr14eV79Fj42EhBIOs6lFdKm5rDfGJz8xsqgWJ43KNwucXfj4DfceR/rZw4?=
 =?us-ascii?Q?472mdgq9xc1H6cZZ0AGCOL8Q0PyK+3g49CfTA2/hZOkuFm0dQrciVZp1kIb/?=
 =?us-ascii?Q?9uOHz5OKB3N6WnQ6BTw4bx0bPhAeiR3lSF4wigF+w8LbL7xs1kjWrgmLxOl8?=
 =?us-ascii?Q?kafO4vfwSU34fZPkkdFIK32zhyz0Cbn9sgDRAmvSHBnZjR7LgL8S/9J+ziNU?=
 =?us-ascii?Q?9kz0nWu7l6911IXPBwCAmRv+I324gdOTtyFL6wUzq54KrV3LemDjuLGaSVMD?=
 =?us-ascii?Q?WpPkhxyFpTh0iZ7WX6qK5oMo36PC1sf/5DkONw41HFOJ+ilryN97A/bYl5s3?=
 =?us-ascii?Q?m1CGY2mlWA6ltcZI1I25tJufZTsymyYELG63l7bPCYmGmmoVLZ3hx58jfc85?=
 =?us-ascii?Q?j9uEsgaRrIfSUM+mA3ogu8F5EyGvEq2pqBPfceRIhCfqhoUxZCsGBAux5Yao?=
 =?us-ascii?Q?uQRya/2nw1QOijOy+jL7k0cjBx1WccoEGkxCJ0nIRs9SRRjmDeqvi1vmXfyp?=
 =?us-ascii?Q?TR/0MTTHynC2Wz+a5cZMtSnDAyGwvPB5q03LDzjr+f0D0n9J3xo4hnpooYO/?=
 =?us-ascii?Q?A8iUKcqEfAIhvTHo7dYCMg1UE7CzYhso6fhei7K7PIw444KwuezKi+vJrLP9?=
 =?us-ascii?Q?WXmQmGLhqV5nm68qxXl6gr+J8bvzT38I4DrAxqs8MGeMBcQ2/sKquUsKJ0LZ?=
 =?us-ascii?Q?aBF8uJayeORni7Aazr/l6IZwL/LoFTeGShXVDrMHikGXrO0GRu+rFzIp+hsP?=
 =?us-ascii?Q?tWkFGUMrLzeU6DJ7YmaPZZekcdfZZ31gKG+oKzO4XtEDFPPkFJDXkn6hy2sY?=
 =?us-ascii?Q?XY1lKk5QxWsh1sEHCDosn2TAgQVXfSgBniArlkA6WWEqSlPCT+ABv2ACWWRM?=
 =?us-ascii?Q?M7Fqawj2mOsD5fOdJaVwqFbkZmy6h+O3qFCQP+soYaaYI67dCczWti4ebhXl?=
 =?us-ascii?Q?DQDbWflsF29haTjJ65nvP+LhwDSXTSuf+f1d4LaDdjwjUbMCrzBmqO3e+2y0?=
 =?us-ascii?Q?vSN+fXUQf4eOj4OarO26SWyfGN6QhJ3jUkhQXYP0MnPEXpdBuO39raBGfPNr?=
 =?us-ascii?Q?plyu+b93Y1QMPuPPAJEYiBcW6RMjdaUxFfJ4gMlBErzPIGfgQM/lNGRKv6Ja?=
 =?us-ascii?Q?DkL0eqxH4mfKPFrbSOnDYBOFEwlvB+UyjhwAr/5RPilxketzoxQCixvavvA4?=
 =?us-ascii?Q?dvoUaATgPq9J+OXZaW2XxaVU2SOg55+uAvufRmJFd+PRm5LkzD70ih/XPjvP?=
 =?us-ascii?Q?Mhy1IVDe7F2+oX0HScgtEX0w6KuGbHWQrlk1SmTirlCuYf4YCy93iDDqrvV6?=
 =?us-ascii?Q?mSzAPg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eBumKwcKZ7EbVJRkQgM56thlBkiLMTgZblRbE2ugqrXAtvu5790jdsEa24k2Y8/1zXOnK6tkfZJIPQXc+ssHFuX7DJZpxcsPj9Jtqjji/oCXtmBxKx62TlQcfsDMkUWQsYOvthAD4iOuiGE6UDNBGSC5gJggJmtK8tfYRMku5zso3h3wXFlCnQuEHqxB7JTF2j7n3B61WNtMJAdKyar8SzQooOH3hlyP58bG/tz4Usl307Ta+ylxRySNEzx2ZVMtET7wGtUFZe2oGOZkNOQaEuYKxj2qOC9+nDtRwL776B9uXfzW1C5Jr85Mb5Wodg3jDeHri/ml5FdYKpgb82aZxPaWlgCJwxWu9TJFwRCiUuiEZ8znynO1+0d5KNmbfIwmpeHrGc87Wn2LyEdcAhgMS+fs/8A6dO5HSn9QGlt+mk0kwOMUfQ8BMbxfHFabh6NY3SvMX4+LtSOvrsKTUnRtoRtYx4S9816S+x+XspuUDOYbaa0ltTfd7sbZOCfPM+wqJOohBrIBYyLMEt8IJbwxuHLCS9qnkGR42z+Rgvh1QZkNmrUpdJ3pwtMYKK/8JuOZdGCpLt5yh7G5io/IHAbiBIICkWlbBOHcbaFQuwTpO2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d359c35d-1e14-479e-8075-08dcb17c087c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 16:15:45.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shRxnrXk73CCIfLTYiSJafrVPxsWtNpD4gYvTrm7YtX9YhBQs+RoY+4fflORb6cvTqvsOazO5Hh5zW2FDRuNkSkqVjI2ZBtcV/xUCU1zAEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=758
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407310114
X-Proofpoint-GUID: 2H8G5QjiKYcIghm2L_Jrt9Gx5J5S9Btr
X-Proofpoint-ORIG-GUID: 2H8G5QjiKYcIghm2L_Jrt9Gx5J5S9Btr

On Wed, Jul 31, 2024 at 06:04:04PM GMT, Oscar Salvador wrote:
> On Wed, Jul 31, 2024 at 04:19:09PM +0100, Lorenzo Stoakes wrote:
> > Yeah this is at commit aee8efc95fc2 ("mm: make hugetlb mappings go through
> > mm_get_unmapped_area_vmflags").
> >
> > If you:
> >
> > git checkout aee8efc95fc2
> > git grep hugetlb_get_unmapped_area
> >
> > You'll see it.
> >
> > I'm guessing you remove this in future commits, but the kernel must be able
> > to build at every revision so we can bisect (I found this issue through a
> > bisect and had to fix this up to check).
> >
> > A trivial fix is just to provide the prototype immediately prior to the
> > function decl, however the more correct solution is probably to do the
> > removals at the same time.
>
> Yeah, I just squashed the removal commit and this one.
>
> > This bit is just a bit of a slightly nitty cleanup to make sure things
> > build at every commit, the first issue is the really key one, just needs
> > some tweaking to deal with the frankly bloody horrible SHM stuff... Do not
> > blame you for missing that one!
>
> I did not check closely yet, but are blowing up in:
>
>  if (shmem_huge != SHMEM_HUGE_FORCE) {
>          ...
> 	 if (file) {
> 		 VM_BUG_ON(file->f_op != &shmem_file_operations)
>
>  ?

I've not got the vm debug on in my build, so it's blowing up here for me:

static unsigned long shm_get_unmapped_area(struct file *file,
	unsigned long addr, unsigned long len, unsigned long pgoff,
	unsigned long flags)
{
	struct shm_file_data *sfd = shm_file_data(file);

	return sfd->file->f_op->get_unmapped_area(sfd->file, addr, len,
						pgoff, flags);
}

Notice that that doesn't check whether sfd->file->f_op->get_unmapped_area
is NULL.

So since you remove this from the f_ops, it causes a NULL pointer deref.

In __get_unmapped_area() you have:

	if (file) {
		if (file->f_op->get_unmapped_area)
			get_area = file->f_op->get_unmapped_area;

...

	if (get_area) {
		addr = get_area(file, addr, len, pgoff, flags);

Now since you are dealing with a shm file that has shm_file_operations

static const struct file_operations shm_file_operations = {
..
	.get_unmapped_area	= shm_get_unmapped_area,
...
};

Then this get_area() is invoked, which calls shm_get_unmapped_area(), which
calls f_op->get_unmapped_area() on your hugetlbfs_file_operations object
which you just deleted and it's NULL.

This is why you have to be super careful here, there's clearly stuff out
there that assumes that this can't happen, which you need to track down.

A quick grep however _suggests_ this might be the one landmine place. But
you need to find a smart way to deal with this.

>
>
> --
> Oscar Salvador
> SUSE Labs

