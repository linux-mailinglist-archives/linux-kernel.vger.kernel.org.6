Return-Path: <linux-kernel+bounces-229566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FFF9170F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329A21F21F30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDA17C7C7;
	Tue, 25 Jun 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="geKPBgWh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a3O9nx2l"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282817A906
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342737; cv=fail; b=ThlbhvbqrVDn2mEMqUbLQA6OSVawgRH9kw60YCC9dmCGSYQ7pJjEgu0WqP3LJeXkp4w0pbIo5jdF8M/WfmHJTco8J7Na+NIaosMJxjod57oQ0EcBlk0OexkZV1z1fgnEihMCwmpJcfZ8SRd+0DvcxdyggSXYiu7Lgm5s0n18IRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342737; c=relaxed/simple;
	bh=MUdGcyuD1zj/hoz6fbwcxO8kS6iWTbAgAnBkUwwqZ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TT45D8Hqevq7W3bivdd2N7LFsKgx7W8jP+z/MMO3I3BijjBgx6TXtNicOUNiJvql/nssBJ+Fvoe01oUbUN1/nMIETmqwmV8thd7dtZOe0KM2les03JowbgjRSoxcUNX6oxf2nJ0sqo8vpUInbe10LVB0/bzW7GrtY1A9bMPQkSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=geKPBgWh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a3O9nx2l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfTXk018305;
	Tue, 25 Jun 2024 19:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=zSu8hDWlGjMxPlRgldY+gYYh1jH3ES1rfBL14tJEjt0=; b=
	geKPBgWhM5WIp2+ekoXwDoNwufxBJj6bRgerNypGXAtUA7xW3ZNNxoUVSdGqXbRJ
	aBNX4C578kFSazvs5IZODIW8cE5rvpXFozxsaJtMwsfFzRQLr7NrMS0ciPt0mp/v
	MFneqkDrTWAwl/Lve2qZsxS1KJiM1FXVDNgfkbvMJg4ruhc6DnLRUZXT8o+vr/J8
	wNFVUxJjjsgNky6ekITINPuLKtlVTbKtk1ZeXOR/aNx/doMRNOV47ggxeQeNehLd
	/3IxnJ8jboqTbU4wt+WfNpYjia9vl5eNEhlMq35RdOM9Xt94cqxIm3+wGSmsgkbg
	l1gFkPxXArJiUSdG+RSLVA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2hmby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIrYKp010721;
	Tue, 25 Jun 2024 19:12:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2egtb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnMtv6b7znPbELE25pRfsGA4dhQEgmzFIoZQLJLsaQaszzT2myG55Q+s7Jn+k15jwGaTNs/gk/oGLwvH9/iToBwz0RAfmN3gB0v/r7P573zb/fQ4HXPVlqcfM/d9yXE8hbT8/EdgJliW7l87JjZITwmHCDqYZAW6DKgG8ITWzViIjygV7ZKCBO/mj8RRLXsRsL+mNfqB39Q2MGMk/6WF28PsDsxXZgqv3R8b2dSjw0CJV18OGAfJGPtJQWhaSap6UYXsBBSF2Kp8tlQT+B5+0UFBWk5uruIQdHVSo4iNElpDH/2U9NtJi0XVqu0WglUR6hsORue2eYxVi6B8OLbYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSu8hDWlGjMxPlRgldY+gYYh1jH3ES1rfBL14tJEjt0=;
 b=aiiFpfm2MLxPy8cPZrCQ1VaLeUrXWqmvObgzQhJ8cLdC8VkSAbI3BeGAtd0v7MLsUxwi6jLPYWywyRAcm/aT238YpjddcF3WRAT5iUX+0+twMYFO4al8XWvK4QOBciY0u7SVGpG6a7wgZ2H6hDNCi1GpLuMEmmCHyUN56oIQS7x0MoJX2ZlW9mv+3NC2uqCCDis7XV8AKfg4Kl7wJPvDh1+t64YG+nr827Zh3qbrDNjIh+p8qLn28gzQ51fdoFJ7EPSIB4w3A4DaPxJ3Je4Vu0Js+vsGtbFLXXoyY54+ggUHWYyf3Qw4RcS9fRyPN1JvtPoYcRFtp8xHonM9eRz/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSu8hDWlGjMxPlRgldY+gYYh1jH3ES1rfBL14tJEjt0=;
 b=a3O9nx2lOKAGh3dnVekeXdbA2QoGK7yqMC5KNM/Uv0xzLBvrv19YGcr9BDefzkSRLW5DCg1nTfiwBNriwS/zMX/QyHcekfvjzBCVPB4tEEjmC5sCG5X/qPYChEnBirSRVy2W2JLdxA2P/5ql10AB37u7eA6XU/qGRqQp5szAIbY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:11:58 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:11:57 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 02/15] mm/mmap: Introduce abort_munmap_vmas()
Date: Tue, 25 Jun 2024 15:11:32 -0400
Message-ID: <20240625191145.3382793-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0057.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 36296a7f-ac08-4850-d64a-08dc954aaed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NwbYqFQpi44WKwMz2ua+aosjy/aeBPxdj0XcvPiHNqSG1gPeTxeYhcDkRZhk?=
 =?us-ascii?Q?Cwh+75iVHNFMj0Uydm1kGR+lk+fTY97DuoH+W148JKIUOiDUgbyOT5G9xkai?=
 =?us-ascii?Q?2fIq8N4w7G7pDo6ZaanbJK26SwN3z2mp3lka8440Az4hGBOoZrXsiSimEw0B?=
 =?us-ascii?Q?xFL+/k62ZoxXHGtiQD0To+/wCJDbTz9BnFyOCJTRfaIFt5hc/aoKnce/Gwzy?=
 =?us-ascii?Q?ShQLve4Uw+f7OgJ7R/fvXTiJ45KI29Y0YU3UBhcguQTVQdlHGaAxo+quPs19?=
 =?us-ascii?Q?effPMwrWlUMwkNMjfDxeFZG/oithNYYVMJdJegPH3x8egi27pBQvTrKoCxtb?=
 =?us-ascii?Q?8Ajyd/B0CtTydIdAtk+UHXzGjiSw7TH/V7ZjfROR/8KFpawofR9Eu6BCqvF9?=
 =?us-ascii?Q?sPm++rma4Nymf5WnsYVWQBGhhGD0LPGnfkMCfIeC5TgA0TYq+MkSM6RObQOa?=
 =?us-ascii?Q?bNn4saIF0IjHzVl025dKGlq3OOwiZLicV5gGB2W1VLGwiLSLgUFJZjfqAPZ8?=
 =?us-ascii?Q?N9Hj7czks/nL3HfS95wkcc9Xwk5bID466gbSmeT1OD3PUgO6hq5udTpbFbkJ?=
 =?us-ascii?Q?/Rns7YbsqOw5FAVnrOUTmuwds3LWcjCheaQu9sv7eQ4wRzgI+46LW9/4DLXh?=
 =?us-ascii?Q?1Eq1OCqjgoU0lKWVtzdCr8sX/3zfaeTozy/HLLj8rBlrpQJmCuAJuo+qmXaM?=
 =?us-ascii?Q?FDJEvcfeDenBi9f1WLmWwpv4HL/SsmdtPZ6GCjo3gCgSf7ntrXl77O9PEusg?=
 =?us-ascii?Q?+yNkv4TOSpXivUzsDIMx5TNVIvXCj9bicoX4gyGDKLlENjY052FtP5NlQBOp?=
 =?us-ascii?Q?apTeH0b0ty7D88MszwF6ty3B0IiOhLKS2/JzN3KJoruZuvrRto2X7DHs9INR?=
 =?us-ascii?Q?HM13X47flaR64tJw8cpUEti1lqullI+mA7Q3/uZMDtufuaa9h4PbKAsTTWL4?=
 =?us-ascii?Q?eS8HS4vSnGhA04X5ZUm9aRF1c0BjJYahXWmKdU/22B1nwjPkr8hKql589IR2?=
 =?us-ascii?Q?XmCBR4I8dSSuKRff6NEU2oDk1pQSHacYjXSvsbUER8YCkVXYCFvE/tACGvh1?=
 =?us-ascii?Q?CDDg5bBn0E7b81/+NxUTlS+a1+s9yXnmAAgUp6RdUm4J2Wpl9nZSgDE1eR0r?=
 =?us-ascii?Q?JZRFrUGpPRUkWqvTK2SK6oQ0poXoyyFCK4L9O/ph8U4S0ODJC8RvPi0WLNjX?=
 =?us-ascii?Q?kGxp+v7LL1oPLewJHjit5fRz3VNn0S7tHa0vmFNMptT1gJJpgX5bg4SUq4gM?=
 =?us-ascii?Q?pEZ7LQJuS0s0L2pC7Y7xHh1Ku7XUH+wQ3v2NpqZmjyTQMvVGJJWwpvVvyvTf?=
 =?us-ascii?Q?UFw4KlI/L0VfBmnZf8qlpLgx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZmGh4lWeZyu1V8C28NP2HqGxJA5f7XghJnpgzoOWgKiV+CkhW6au5o1W8M8s?=
 =?us-ascii?Q?HwclAxflOOfjjMsjByhiaany0+ArZ4xL2tCDBBN41/YMbDMUNcfqJvoEWN2C?=
 =?us-ascii?Q?nEXiIwfTfJk5XFCM9ic9PVE/UXMgECqUiDIJKkA2TWXXDQLhljgi5nAqTnj+?=
 =?us-ascii?Q?MnXY5g1FshSX9NQlbLY/4Sk7ZeoWQejPwduMOONUsyv+CcQlg2aCvkZQEoXI?=
 =?us-ascii?Q?XKjjJ2Y0K7SOL4BsLQSDODzs/tbEaLoCXYBEFNxKavxSqoMPRjF0CxE3FOHb?=
 =?us-ascii?Q?KHqj8CMkHbBcjuklzYqucv87D+Y0CkQy++VWTmy1XAuhCaAlIAByWgB8LYjI?=
 =?us-ascii?Q?uc0iDjpsKpHPpdI+7ybtuiXth3ytQOSSF/8GCZ6KK0Ez3QX8OjCMmisV4bmm?=
 =?us-ascii?Q?8d1/6M0XkGsLYQ1bAk6K1ydYCArmyYrJZeVO+3gF5vENmF52tkvMMTKxfAA1?=
 =?us-ascii?Q?lnO35bFGpKc4HLU2sVl7EXHVXZ80Z+B5nsierbksfRrcZBYpmUpjZsHr1SMs?=
 =?us-ascii?Q?JcMtldbcyYh37SB2QVweuzWiHFQ9lOZZhQcu4PNvn3K+IIAI6u0vQQSMkLuX?=
 =?us-ascii?Q?goswoG5x7RyqvPUyyxD4L/DncRDlIp2Ng/hHJMS/he1MNjo2ThVEXLXwhG7k?=
 =?us-ascii?Q?y/mT7Naiil8AO6wWvM0sfJDx6xrzLjLZVjXZZXiWXYrn/Pfd8Gnr0NlH0YaW?=
 =?us-ascii?Q?mJleTDGZmUlF8yTZ5gl5sWD/4mDZPpjpW2ZJrQS5ltxyT3eVY4KSPI0A2XhX?=
 =?us-ascii?Q?nq2r7oDV25tDdgdeF+zwxV5zM2wuEpV9pEhUVTVa1jSabG6/2VQwfdLuQNGm?=
 =?us-ascii?Q?FwGZEho6hZre5c2YP64Xy6k0CaOfY/7Hmw6v1rC2qYJ3zz3e9hKu7cMhGm+X?=
 =?us-ascii?Q?0CVHcgCr+z+GeXa1RBMdSiLH7OTjdBg9xKQsypYPiJWIFrH5dZNWkgiAyqHG?=
 =?us-ascii?Q?+m2I4QxrFLEHiZzzUzsyPE+uy3RE1JH0kDaKzy8tCSIYeQ4IDt9zxjJcxPiO?=
 =?us-ascii?Q?8EqM7Hi2yZ67zHOUrOcP5Ity7NF/FFSt2yItxLvdyRytP8OIQSOsgPmmpq13?=
 =?us-ascii?Q?Qoe95rKfcHaYTHyAP+uXA2sY/vA8tJYWWcnG1DsfccTJdzTdCjLV3Um803Y/?=
 =?us-ascii?Q?FI9t6tt3p9KJL31b5fhd8OV3BI7e6O8JxNyINk0Bx125miYd/i5yUcw8wFct?=
 =?us-ascii?Q?ngpL/M6AV+0Ynu+nitE5rMBYvjs02LScZq3GG3YkaEYPQpcRx/70xeBei5xq?=
 =?us-ascii?Q?DSuPfpSw6WOJHONhQK2W+vE1zoS3+IDtywOFOH+IHR4yZZ7qqXFVUvm4oQ0i?=
 =?us-ascii?Q?UZtIbm2/BY9q4OMdfrIoC604gLmR7kHH9xry1Tv5blIUoi9gmtvyBVYiaKdf?=
 =?us-ascii?Q?tu/o1DUA5UhJr2REk7+bJZ/80GQSSyJmBhVPhK7ehUPRcyQnuKRayG5nO7FQ?=
 =?us-ascii?Q?qQ7f8krPs4ELu51MoThAx4691Oq2IOZ3cKMycnvW9oANrJ1mCNKHJtrU+24E?=
 =?us-ascii?Q?lffCN3TprqlKdCGtf+/VHTfSWrR4QSj3oq+5Hv0D2FtF8xEKsPyIf4Ndr7wG?=
 =?us-ascii?Q?KZcCawJd4xORW4lP6okZW68NBPGtwb4BababhmoG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c5SVP4S2q6JOIpxfSStRILTOdaDmbXf6Pqbd6UU1XKSyR/hWrKKKktAcIzlO/FaKQSc6mLnrGTDkGIlt7neSPmoe9xzz9k94dCj9m8K95AHyEz1ePez/QXlNWRFA5PJTIldiW9KUhVfDkMWI89bmn+4+AthJntPhxodvDU4NqYibQS5ta9U/3a7YLZ+zHL/Po1bnRFs8UbqfDknTrkTW0LRZgKipITjoFB3GOPIGPCZ/uxGk77CyMq8SSbk1eJcyoc9bMeqj/qGiL3vLjg38NxYeNyfdVhEfTD2z33WwKpRSajw9K9DxoMpWhLv8mgwlawpczqywBY3vgx16lKb9Dijuj8XpdmAK2RR6/ju1IQ5lkGc76ZuMSTLWdPblWlpcz7xXyYy0kamzkhUPAlKUD8Oo68nyjUQAf2U/VkVqmpUFQCGRFThP0r4pVGhdIpwHMgNBaFTTOYOdaWLGtW6BKY93OkNq0q2GehQlcVcTr9cUcmCKfu2cE9GFJi3gthxkHdJieydAljk1fxrKUSnRdaWBYkfKzlIPWIewuraAJJVvZb0mR84OtleoNhdi3cUur1ENpglsvt2ir8lU+63hAi1XLeaA6oWPQXK1v3+RUCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36296a7f-ac08-4850-d64a-08dc954aaed5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:11:57.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSliW50W3k0XYfzLXr28pMJ3Th/3QMgf3FrlmPXSOnqfhCvMZT8IBs4WvkvClr6i1lUWqv4wzdD9WQh//w7aOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-ORIG-GUID: wwxhG0xOyhSs-M8cgL1YVo9GwSdW2cxm
X-Proofpoint-GUID: wwxhG0xOyhSs-M8cgL1YVo9GwSdW2cxm

Extract clean up of failed munmap() operations from
do_vmi_align_munmap().  This simplifies later patches in the series.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 28a46d9ddde0..d572e1ff8255 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2586,6 +2586,25 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach detached vmas, free up maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+	int limit;
+
+	limit = mas_detach->index;
+	mas_set(mas_detach, 0);
+	/* Re-attach any detached VMAs */
+	mas_for_each(mas_detach, vma, limit)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2740,11 +2759,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
-
-	__mt_destroy(&mt_detach);
+	abort_munmap_vmas(&mas_detach);
 start_split_failed:
 map_count_exceeded:
 	validate_mm(mm);
-- 
2.43.0


