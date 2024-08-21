Return-Path: <linux-kernel+bounces-295455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA39959B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670E22839AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B01A4B7D;
	Wed, 21 Aug 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iBNWVs0X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gby0GjpC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84471A4B7B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241431; cv=fail; b=cUdGnavPRx/iuv9avWcqE4oTAHGU7UJpFxoNIk4tMq2L1OAVDPsFVsbEBDUdyieAjxEI54pytyk5PlYlBBCMhkjbbsqY66X4VzUrTLo+z/3/glb6AjaYFn8lNOeQIhLIKBrnW2oHO383hTfA4QNuvB37vgnTo+5ZunQNwFGaT98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241431; c=relaxed/simple;
	bh=9rOCIsjLxnxGmV/elP+eDfcO/2HPdRhYm174F+xdExk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ExG6xNcMF1N0AmFj2J4jj9Q1I5bFDKgaw21REqTNXAQCmH3hOmyNwl+jXbZ+bCF8ViDbhKlFJtgEX5UHM7Ui96e6uRFQ2ZUksWLPPPz6rEVNE3RO++Dnef4BG4ZIy84yuZFjGNuLOMMYgdEjdbaUK1OEptHwq5LKdGpWeZ9g6cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iBNWVs0X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gby0GjpC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBtVKn003055;
	Wed, 21 Aug 2024 11:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=rXvi9zRhWnrPayQ
	f1/ImEtBCpzSEuw23tOsrErrzhf0=; b=iBNWVs0Xz1CwyTUKfQHc4DmKlsEinKw
	FI59mLozvKX61qPOvlqQ73BtO0FSIQeJauf3vjDUe6of+1iwBGqcYiuGRGwO8xeg
	UgDusEUpXcrAPS3pTxkBILlZXVM8o3ZtfhET0wPBJ3CqMNSloo5RAK4knT7owsDH
	uQ+Kzd8cau9KongUK0GK/VJZp6VpbL5RbtkqBIwrsVCdUe4yA6QYKRM+eItFNZDi
	Z2obu7qFPqqhh5+41AWRH5cOGvqti/Bsf6jeLSlx7bNWzE0u8cI/qBDIjTXK/AJO
	QdGmowb+d80+o2LXPndF2cXvA0nbhkDbngzWkg+QnI6wwKwgrEtU0vA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4uy9tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 11:56:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBe3jB027853;
	Wed, 21 Aug 2024 11:56:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415fjargrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 11:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6nzVimhWeDVXNYLRgVFBfs9wUU1fL7rgmeKQDtfy1SsrPuyT9VnRLMF4GzNn0YHolXU9450bs/goR9uZNe7f/5uEzuqetpn49F0wvT8mYpb1E/730xqkB7QSR8RrDt+Xk386qVW/xVl6D1M8+IElkieRgzlUhPwooMq5zRZyQvwcQE4UKTM0x7vFJ4+zl57/giQzAZS0OluGlZfXm8aO2+a8JgNa5tBzVNIf/EHOOgnmL1BnV8jYeSucUlikOdsGp2hinFEftfVEjsNx8o8B7k+j6ZAp839yO7dgfLDrGKjqMSUpxPAvK48MG54SghTGYPJGQdmxOK8QLPdpKvz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXvi9zRhWnrPayQf1/ImEtBCpzSEuw23tOsrErrzhf0=;
 b=GTbeJJdGHDKV225WpjviLAh8mNIPTqGFh28A+xjOjVI89X7lXkF91uS1tu9XecfMKy0AdVegrsF98iXf3i3wJr48QyRNBYamvkaeyrgEvKBaYtgXVHJptmYMZtOwFvPpG9JOhqOBUr0tGiznwCiy/g0EWNMOHMGP6FdEtvFo4rNgmDleGBwHich6/pYvJtHqOGY21lTwcU+WgFODtla/U7uhRgy/z29+lqNpsWFo9x9L1i9UNcn8IDzjS8B8eGn06Q6MY8Drx/3rt2uzZFzxVXlQYWib+Zo29Q3Hqsw5ypi6hz16dQJXrKyQUTgG/tjXvMJljEpimbPTA87Dr6saOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXvi9zRhWnrPayQf1/ImEtBCpzSEuw23tOsrErrzhf0=;
 b=gby0GjpCjSB9uece6Oyi6bvavHgR/1CLJgIQEGS6uHA/0NZqNpUmt6Dq5o85j7YNuwHhoUiM4TYP6BoHFy+goiRhLEuINH+3UpXVcElRF6oSH48YmRN7cSYrpLSTBPn6V7fW2ctkOoXmMjKlHgNVK/QqMumBuea10hHQZ9Pqgow=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN0PR10MB5911.namprd10.prod.outlook.com (2603:10b6:208:3cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Wed, 21 Aug
 2024 11:56:49 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 11:56:49 +0000
Date: Wed, 21 Aug 2024 12:56:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 15/20] mm: Change failure of MAP_FIXED to restoring
 the gap on failure
Message-ID: <17400fe3-c39d-4620-accd-3fd912740cbe@lucifer.local>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-16-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820235730.2852400-16-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN0PR10MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fe72b7-80fa-43f9-678b-08dcc1d8568c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SwoZ9+kQWt7cJlWpcphrKeNahhkBW4E+UAlNjrnd50sQykwAddONUzG2pYTh?=
 =?us-ascii?Q?lA6Yb3Xitv3V6Unw+gEaXGO9EG+2UCNcm4GgUJ3A8rpO4G1HWhN8juzNw9iO?=
 =?us-ascii?Q?jxUSEfY1FWLbdMMiUVJyb2Y6ipLwj2V1ARF9bnCLccFz8oHkr44anVRe/tYc?=
 =?us-ascii?Q?zy6NbGlSo0dqYw0HXVcvBLMKMeHW/VPvlMDCR2vcXWJdETS+f6FSV7sXGIHX?=
 =?us-ascii?Q?wUzABV4jUKqa8IRLhLVlaOegea4US+it4qS6Xhow4asvQAYXSM0LRUXjckSz?=
 =?us-ascii?Q?TGHRiDVMPm7ZThttMnuZVKSICUDDp9Zci42Yrq6XqwZVqvu27hYr1xxSerso?=
 =?us-ascii?Q?6q3HRoBjBIS6lr99ZHYlhsGlJa87zkyEF7LGomXBGpblkg3iSOtcLzEkrIuB?=
 =?us-ascii?Q?/Fst6MK7diUAzH1CHmgE/voqv+hk49a7W3lgoS1MxuPEa+NsLwM4rzU2A008?=
 =?us-ascii?Q?d9fcDlFFetRNsDqGx/lUIgpGr3dGlwTO3WOVELlUYmLaM9Ruovo/LB7bzSI6?=
 =?us-ascii?Q?eRA+cTRSOK6YdkB1fy6OXw3RvRm/yZKcTJIiAacU9cdPWI3ej7YZ6pilVcrx?=
 =?us-ascii?Q?G5kd+leG4OVJX14QryBTQQlgx7hOundwfWjdQPbNQqfbPmEA6rOXL3Hi781f?=
 =?us-ascii?Q?Z9cADGvpGYOcIOkno53mXZzCUJFTEcOvtpNe3iepzuMxcefujYrw/YOXRpeF?=
 =?us-ascii?Q?t8OH4dXfMAomu/+WfbFPUL/0JlirBAqUMbO50yuv3zwvA54lG+kAw2ppDZPL?=
 =?us-ascii?Q?ZlKjSc7Hbsj+7OO8Ndw3MuIl98eTo+yDQTfrVE9QvdX7zXPe1+wTDw9MW+lZ?=
 =?us-ascii?Q?UbLT0KGYDTHUghnElKPX3weRusLiV5CDUWV3qGdvR1OcFUCOvm0ZrXEkJzpC?=
 =?us-ascii?Q?ZkKiSQZClzd46GqlPj+OZzkmbYvZjSs490QnGX/Gc3oMWbSCUsK7b6+YM39h?=
 =?us-ascii?Q?lC9x6IFgVCQs7feVmyPYhbt/YM82kiXthdXok5laza/JbwmoBVNcQJ5iLhb6?=
 =?us-ascii?Q?zrMurAOz+jHeOuAS+fAlQHaVjMY04hV3hdgITlxcBRjX4y3AjNvsZ8zx7h4x?=
 =?us-ascii?Q?/Vw8aoRx9TFwrgidyEscAZXoHUQvovv6ljHk9blbvmHNUWb2xLMzL5oxmzJJ?=
 =?us-ascii?Q?Hs0JUOofkXsv4Ru6xoLz5Un3XziVJOTLj5FEic6Qu5mkV4xIfQF7rMbNvszm?=
 =?us-ascii?Q?kIz518e+F+qF23YKs5f/wzhmpzT0RhTydKeKDB7OsYqRTbiTO2/69PoOSiMc?=
 =?us-ascii?Q?QAQl6IwHUT+m1xi6g2ZV6saSOrYYFvB+J0r9mLg1lzdx20iYzkT/trrCQwWx?=
 =?us-ascii?Q?lrjW7ZTQltzNcSVcj3tiz8g6RojLue4MYIGyEF79lGrC9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FF0CrTeVKUT9fAf9kAsey4xwhlUsG9QrW+BtMBRJBXan2f3gHqQoYdce2Zj0?=
 =?us-ascii?Q?Nf1nQH/VFd8c9nt6t/9RqyCVf01Ghw6vHJTcd9XLdvGub+S7stJluRlEw18o?=
 =?us-ascii?Q?icM9JW7AUfKiJ5UHxTz7M9s8wBWl4SfT1iwuayF3DnEL59GHPZAQMwm0Plxv?=
 =?us-ascii?Q?fsPA7ezNFxkQDwmzZcbtn/LUj9IEXEB7diBOJIdHUqtxAL+VyHMKBnpRweX3?=
 =?us-ascii?Q?ssq9zhsn8yjx8RE+zkXu5re+xPE9g77RdcgpJvPuytNy4g6WRU0xBud/0Hvq?=
 =?us-ascii?Q?IUwBqBIfNR3wYPGTbKhGoipSniUyzJ2Dg+zJH/e4ZnL0681rG/rP4hENORGX?=
 =?us-ascii?Q?3NWJxKlKf7w9xMGXsy56x8erEQCD4ECNCChi11ax2UA9bWCm8dnG5+N8DXgW?=
 =?us-ascii?Q?7zwr86E3CImazLnbRXAwF9xICFrgtClOPkB9EPaBqvncOlY4iQMuYbfMZYgJ?=
 =?us-ascii?Q?Ly1FVw7Gd+eKB95C6E6a5FMPDTfbvscH4gb/I3Jlpd2wAYb466YmSL1eGZa+?=
 =?us-ascii?Q?ZkDQ79cOUTWj+WS18VgT8pvMwNiMDoH4biwbCt4+9VLoieQcLvCviPpBNyS4?=
 =?us-ascii?Q?Qh694rWHR9aOpQlIImlDzUxfXr1eOrbBIbZgA0+OaJIhzU17QWbr08kS8eYM?=
 =?us-ascii?Q?k76igbeE8x/XiEqUh/FhS4LT+y5zh0x/u9ppFI87Y62S/dqrktjjpPpCNSFs?=
 =?us-ascii?Q?XfO0htRohbLHCVqrSTk5bBF6WNiQxqP1yKbprEBhHK1tXhaKFvke5aKY2c96?=
 =?us-ascii?Q?y05s6RENdjUop+hLmBbjX/0EhDeOzOrQmyE0Rr30Hju7nYRI0SN2rM/99sB1?=
 =?us-ascii?Q?PRN5aI3VOhnU3MrNhzg95nFi1ZSn1lnshILM1WSBB7vpl3xD2Tu4MPHJR3K3?=
 =?us-ascii?Q?iO820Y7cOErTlR49OFQxynntSI8Rb60IA4U44ZvHmGzY+lHD6zfVjpasYBcZ?=
 =?us-ascii?Q?W/EfYyROnKpA1N4ehUyy1ndpMGjCuJIqqrVq2slIXF2RTtg0isxGijB6STVV?=
 =?us-ascii?Q?5DH34GmLNsQ7gzbxba67iuwcH5Lm4vAB3Gzgo11cYmzxJJvvTaxmEfzuydz0?=
 =?us-ascii?Q?xEL01vDFUXMseoNZBkHRr7Ln3ZCCgdFZYjJ5QoKVHaP6QzYUDkexLiCnUea6?=
 =?us-ascii?Q?ND+U0auFzduXH+MXMlFDj1VsYGeq4gOY2r6STwoNdHrPedi61NWsHnAPHYeu?=
 =?us-ascii?Q?fw2yf+ffjsHjsD9DgREiGmkue4gn9LFObFyuInRgRaqzIqqKDiMvkVr/509n?=
 =?us-ascii?Q?slHpdo9IfT0djYZMY6GhbZCecoV/ocOtPH+VlxxN0wJFHXeuXsJ2Z3k/Ohnk?=
 =?us-ascii?Q?rC+y4BatgtfssA868aRpGW9TpYywh2aNEB5Vv3kBbcWhkQljRmnU4mrUn8ah?=
 =?us-ascii?Q?2Qdp0nlhUAIikq+b7/gYDk5+Q1e4JTlqL6BvrK16zENN9r43hm89YOZBtOon?=
 =?us-ascii?Q?sPLZGPNSu8+rwstw2Q1emNeb1Sfs14tzE5Z+PNGdfG+JLBBldDyxoBN+ReH9?=
 =?us-ascii?Q?C0YuUE9/VZcOdt18TyQCtzWdIrvFGFItAhnzIpga3NrLwrC3lf5Nsd4GmkK7?=
 =?us-ascii?Q?mL1eY12pKiHp6oRsTNb7b83oxzp0ATtfHaAx6wG+tmVVvo2kcoS8B2uLUlTM?=
 =?us-ascii?Q?PIg+YTyw/EOABMVTJmSeHiNtpBe4dVtXk4JAuGLbYyhfmoD1iR+RRAkdCyLO?=
 =?us-ascii?Q?9m9Hkw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lAnvT3AJK+t3AIvBUBF6R+r1HTRiwlSGCCIrqNqT6XLRzm35HpbuOfZym6w0n66T027Adnu5p3YlSW3/XbftkdAt0eK8C6a9CEFfjYXNRbb9gEQbylH4I2/74Fpdm9Lpsgzl6w+QdGTu2FWwdZz5hU2Ry7+xNBh1ZkzT2ZMI2xEPuWUqIr5/FPLL4aprrUht2aMNrYmaql4y4DrVP9tvgmTLoMwuw75LJ0mrgr5Ji34UEHKNTFpD7e7wC8l6Nh9l8rfCVXXL5dRFWUtjxNaRDGN+Fr1lfNfjzBhf7JAgtqxAyWcqQRaVsCvSP2E72WjBitWT7zyF61g9mYw97WRV6u/JDNg0/Rq7HshdrjOOqFvjmSwRLJsehxa4MQEAOLDW/3W1l+nTu8wAp+0GaMktJl2voaCgxwlukK/HQqk7fV9h4hvY2NmnQozsVerQW0yohcymWI9R+tHyTJgmfS26G3yVq7zn3xx2bie2Px8afjUEAU++kmwyooazBJICMuLabQxJc5kivaBpWfuMg144v0MwnCsjauoJo12wKMc8ea422N3KmuUPzVKC0DshmV3Wq9Hh2GoJEV2dRltuy5F83P7Ez4acF39z7QNSsQMZB0w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fe72b7-80fa-43f9-678b-08dcc1d8568c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 11:56:49.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Aifgeue0PPZVwu5ZLk98IpYyyrzmshZbXBeV+hfB49fDp/zIQSO1+f+LmaM014VWDCzFnDbfJQv1ISp4ITm6pJpZxdxExNmGGl3FXOiIN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210087
X-Proofpoint-ORIG-GUID: z4ObXMP45jNkP3OA8aLYFDctadfi1tzj
X-Proofpoint-GUID: z4ObXMP45jNkP3OA8aLYFDctadfi1tzj

On Tue, Aug 20, 2024 at 07:57:24PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Prior to call_mmap(), the vmas that will be replaced need to clear the
> way for what may happen in the call_mmap().  This clean up work includes
> clearing the ptes and calling the close() vm_ops.  Some users do more
> setup than can be restored by calling the vm_ops open() function.  It is
> safer to store the gap in the vma tree in these cases.
>
> That is to say that the failure scenario that existed before the
> MAP_FIXED gap exposure is restored as it is safer than trying to undo a
> partial mapping.
>
> There is also a secondary failure that may occur if there is not enough
> memory to store the gap.  In this case, the vmas are reattached and
> resources freed.  If the system cannot complete the call_mmap() and
> fails to allocate with GFP_KERNEL, then the system will print a warning
> about the failure.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Just some nits etc. below, otherwise:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mmap.c |  3 +--
>  mm/vma.h  | 62 +++++++++++++++++++++++++++++++++++++------------------
>  2 files changed, 43 insertions(+), 22 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6550d9470d3a..c1b3d17f97be 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1622,8 +1622,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vm_unacct_memory(charged);
>
>  abort_munmap:
> -	if (vms.nr_pages)
> -		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
> +	vms_abort_munmap_vmas(&vms, &mas_detach, vms.closed_vm_ops);
>  	validate_mm(mm);
>  	return error;
>  }
> diff --git a/mm/vma.h b/mm/vma.h
> index 756dd42a6ec4..7618ddbfd2b2 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -82,6 +82,22 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	       unsigned long start, unsigned long end, pgoff_t pgoff);
>
> +static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> +			struct vm_area_struct *vma, gfp_t gfp)
> +
> +{
> +	if (vmi->mas.status != ma_start &&
> +	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
> +		vma_iter_invalidate(vmi);
> +
> +	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
> +	mas_store_gfp(&vmi->mas, vma, gfp);
> +	if (unlikely(mas_is_err(&vmi->mas)))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  /*
>   * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
>   * @vms: The vma munmap struct
> @@ -136,15 +152,37 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
>  	struct vm_area_struct *vma;
>
>  	mas_set(mas_detach, 0);
> -	mas_for_each(mas_detach, vma, ULONG_MAX) {
> +	mas_for_each(mas_detach, vma, ULONG_MAX)
>  		vma_mark_detached(vma, false);
> -		if (closed && vma->vm_ops && vma->vm_ops->open)
> -			vma->vm_ops->open(vma);
> -	}

Yes.

>
>  	__mt_destroy(mas_detach->tree);
>  }
>
> +static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
> +		struct ma_state *mas_detach, bool closed)

Nitty, but seems strange to comment abort_munmap_vmas() and say that it
undoes any munmap work + frees resources, but not to comment this function.

Also I wonder if, with these changes, abort_munmap_vmas() needs a rename?
Something like reattach_vmas() or something?

> +{
> +	if (!vms->nr_pages)
> +		return;
> +
> +	if (vms->clear_ptes)
> +		return abort_munmap_vmas(mas_detach, vms->closed_vm_ops);
> +
> +	/*
> +	 * Aborting cannot just call the vm_ops open() because they are often
> +	 * not symmetrical and state data has been lost.  Resort to the old
> +	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
> +	 */
> +	if (unlikely(vma_iter_store_gfp(vms->vmi, NULL, GFP_KERNEL))) {
> +		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
> +			     current->comm, current->pid);
> +		/* Leaving vmas detached and in-tree may hamper recovery */
> +		abort_munmap_vmas(mas_detach, vms->closed_vm_ops);

OK so I guess rather than trying to do some clever preallocation, we just
warn + get out?

> +	} else {
> +		/* Clean up the insertion of unfortunate the gap */

I'm not sure what this means :P 'unfortunate, the gap, isn't it?'

> +		vms_complete_munmap_vmas(vms, mas_detach);
> +	}
> +}
> +
>  int
>  do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		    struct mm_struct *mm, unsigned long start,
> @@ -297,22 +335,6 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
>  	return mas_prev(&vmi->mas, min);
>  }
>
> -static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> -			struct vm_area_struct *vma, gfp_t gfp)
> -{
> -	if (vmi->mas.status != ma_start &&
> -	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
> -		vma_iter_invalidate(vmi);
> -
> -	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
> -	mas_store_gfp(&vmi->mas, vma, gfp);
> -	if (unlikely(mas_is_err(&vmi->mas)))
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -
>  /*
>   * These three helpers classifies VMAs for virtual memory accounting.
>   */
> --
> 2.43.0
>

