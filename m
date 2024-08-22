Return-Path: <linux-kernel+bounces-297899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1F95BEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572CDB23162
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952401D4151;
	Thu, 22 Aug 2024 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ij/wZyPv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sMIiuek7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B741D365D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354837; cv=fail; b=JB9/aUsnKqwjRqTqo5pknl4cV3Fd3/S8Lh0c5D/x46yxep95VanyHpmLjSJcEEmV/qvFAzMZ/s7InlcthSy/xF0/q12ZSIw3R76hfyI59xRGXNf9R7JvHuydE58IgBQEobLX/uKIlO1eE8Yiz8OBHv3OFBySBOsfU830qoug4XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354837; c=relaxed/simple;
	bh=wCJ8vpY4Ox3YnJrb7FttPRx5X3KT3nCRfov9u8QYjwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqkiSdzsptAa43FZN991SOrun3kQB4aHjLA+wauPwJ0tXpsBM9gjmMEI2Gmm838OlFi3tLgrLKDMmZH/N5qvfE8dMW7uJ7ot26OdqmuiAwNRKfv25bHRdr8pGPPdCLT8hE3V8xs9h2vg7/jsvJfk4yTng14k5g55C2oTZx+ERJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ij/wZyPv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sMIiuek7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMijE016087;
	Thu, 22 Aug 2024 19:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MpWIi7cMQmivMHPf3/Pmr7r1vB9/WxBvplax7ihq6P8=; b=
	Ij/wZyPvePB65w1aeiQDxkwS0v6kk60cTbqXjYGw6zz6xE4zmOZCeRY/lxwcXKmw
	9GitBAFTZLDi9wIAIRbTJky+Huw1gMO+6tl8ui6/E+rYITOdMFcFLfyj6VxAAyoW
	IKd3vEhxzDyLmcG19XaTBKMjxo2j+K91qnXjueQLj7AtwGM8s+b0ZvxsC1r6ppiW
	0E3qUVqZDuaaN38QMisflmDnmtZv83qWxipiDU77T8uZgG2KT6J4laLISdHLFu0U
	sH5Ar1O0s9Ca/PTi6Wa1RBDPbKMucgXDEW+s9llsYOIQcY8veao2I7D0/41nCuRx
	FINV0gwsvX3Hm59RQCmqoA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3du5kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJK8f005374;
	Thu, 22 Aug 2024 19:26:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu08ec-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho7qtT1nbx7Ahu5PZjjjZs5eTZekmcwM6tJuUkaciGxlLtES6mfZhLkzwWtfjQT2CgkbZHn7ySzWTaW/T8XXq21hMadMWFvMabj0TAbvVbnFzly4xuwOUclFCtopfinV0UmwAwxDmSmDjvTJ7XgRCNdR0qrnhf+lDBmRseLKH7/xmtSGzu7KEacFZe6gDVPHD17fWsZXhNJGbmWv7l+WbajmxmSZmSgm1rNRxIfToxld8TmLTCFIGvRp7tVDXHt8bKgIWX3taR9lVgHTsq5XkuwuDNFlfa7xVsToo/AMo+k3zsUk9l1OcXDWRt3MqUgssC6XWUhI0QirlDC0uIL67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpWIi7cMQmivMHPf3/Pmr7r1vB9/WxBvplax7ihq6P8=;
 b=g+Afx9R74JCqqQO2zw/yjdS9nf4qjBWBzCdOo35F0HrS1sLJYIFjBe+7/uPIcYWv4bThD3emsysQGXzTGp85v8e9B5FmdeVfbrI+d2N2IEfPB6T5S0/uPz3wrxaQcW9SctqhiZTm+BKwnqbY/7N7bMg5dKGiwVQaRJSZwKWbKiwU8BrPMDCqjgWOCGR26q3c2lsB+NinHUhcIk8rX3EGr+ngcfX07pOvo6FdOp0Nx2h55jDc8K6QbGPBeE4I8Zo+2Q1ExJLqK0DoOPXaYdIZ1V4o5JpyD3T8mPflbQ3RtwSsaDMZ5TkPICxapC301dgy6qeZCmzKQDhVvsPyerT+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpWIi7cMQmivMHPf3/Pmr7r1vB9/WxBvplax7ihq6P8=;
 b=sMIiuek7GWajIofwmqdYeqvyVsjyaCzH9XormY0+i6HXg8H3RlfrKKcMMce4SUjRVfIt363I5KjnFUm3G1jZ9S9Si+viWE7I7kqVlGljcHu6lQKcTXOtxnmarooTHmzDWr+ikTPFaEGXeBd77ilmkND6YWyc4UAFsLiTVSydoDc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 22 Aug
 2024 19:26:25 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:25 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v7 08/21] mm/vma: Inline munmap operation in mmap_region()
Date: Thu, 22 Aug 2024 15:25:30 -0400
Message-ID: <20240822192543.3359552-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8f1d07-62cd-4fee-253c-08dcc2e0501d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mouoI6yc4hFWSx5nVhptBO2SlM01D7zirctezm0WCGd9y7j+BvMT2n1gIXnu?=
 =?us-ascii?Q?pqV4IVk6ouulEgNrqNf0QrK6FYzdXEGE8pxF3cK/vVRbi67nK03/R75XsXoJ?=
 =?us-ascii?Q?PwqkdCQ6e/kxhhsSrk5EzZJdDZPaVsVXtciY/oF4indyRp4En8EfEgutcuNj?=
 =?us-ascii?Q?QwZ38NqH5EhEi4ucz8YJCvSGGj/ANUhaJR4ymSiYcJZZSEOXKVfkMvKa1On3?=
 =?us-ascii?Q?XEU7p/AG0yWkZEOPj6WGyNpE9BVtuezByPtUkqQyAi+t8HlIorFR3TwojI+k?=
 =?us-ascii?Q?tu40ejkHafAXvgeXls4s1c/AhNvz/0m5kzS2P9+2b23rWk1yWRCoC5cW0roq?=
 =?us-ascii?Q?hZQOf9Gsa0sOhwa9wYL4Z2tfwmNCsypBiieonN8WsbtaLbJSsS5stJY9fzNe?=
 =?us-ascii?Q?0tGDY8BY30rIMhUWYt4eemGMVmH9BRFultMtPpGWj2T0e20LSPFECzw0bikp?=
 =?us-ascii?Q?TkuoqQDSU5UGschugR/EN+ji9OcP9IZYT4fvVIaMfXBnXa7u4VnOSKey388L?=
 =?us-ascii?Q?A6CztFSbrzMJdTUSXaB/YZW/Ai2hN3QX0afZopFja+bPdkTmsmZXe3X1Yr+M?=
 =?us-ascii?Q?vhAPbbBzgCHrcCByaTePX3/pHuFOkaOLL9pd4KzE0OggSLLbPIR2kKYDwlg5?=
 =?us-ascii?Q?uPK/FNd/zAGVFTJ91sP26Qw3bj6WJt+OINZMCOzAaZssO3Gu4wH1L9937als?=
 =?us-ascii?Q?IqZF+zHpa1lo1Ew/DuIAGB9y6GzV+EC40Rdvyn1Zpfl9tgJSZhTPSgwAiCox?=
 =?us-ascii?Q?0742DJfKC1Z2zN1jkbEPI/7TSH/VyJiMloxr1D54bWeizSxZWZQ2oJaFVpN+?=
 =?us-ascii?Q?otKHmFhf0FNK+66kOnKsnh+ZVtm6q4/AJ/a/I+ZYNW1Dg1aDkTm+Ckp8w7Yx?=
 =?us-ascii?Q?pESqkc5DipoBduJibnEEJtiEcScFRFDQIQFTf1U2R21jX2TF167W2J4Kahmc?=
 =?us-ascii?Q?P/u5RJzqMPN8/qvDXoAdbj4ZU+347GDjOTIspqH/i3j4KQTUzOXq6G17H9Zb?=
 =?us-ascii?Q?oAeBoOcjZ9L+nbh5FkvbM9mdgbKKFLNRukqrwSorhUsUfv1BJ/wQIucydhaA?=
 =?us-ascii?Q?TClg/nVTye/5EDU6XsvkVs4w1YtYfTDUW/s3sjpi5xRRaES5uVo2Jm3GSNch?=
 =?us-ascii?Q?LapNOoaMWzMkdXyRlJmhUab0Gsxy70lkoCosrESJ/aQiRKrprbXHe562kEpS?=
 =?us-ascii?Q?8OTdGGW9qiFbPXZp1k+dyv7SdYpbYphfwpZlTuzC+5U3KeifWzPeiEZLZ9nc?=
 =?us-ascii?Q?+tKNzoPHUWHYS/y+H0VrCrQ3bI8vjig2yiK8Jhbg97d/xb3D9XFBg9oRB0wy?=
 =?us-ascii?Q?+To4UKmgodiFAOAoYqIfvfQlqaPNw0j8l1Ugu+ixrRtxRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wl6XKmCWNjH5GZMbhNrQkrJ/ty0JFNDoYw95DeXOx8MvpfbsGmg31EriMQuG?=
 =?us-ascii?Q?YZU1lWVINT83oBhVk1vN+lcUg8gny8/BEv4hfHBMe29JuU34SVQz3vO1Sk8W?=
 =?us-ascii?Q?EBlUpasi8QRZ00ZmX3gs/hEfSMGsKgqGqAP9p77YRkCT+U3/OhBCTjTD1L8X?=
 =?us-ascii?Q?svzyPwgE2jdtRLEHMvEze+lgwyFAt4s3AYznlDNmVTc0bOpN6u0NzJKkPUns?=
 =?us-ascii?Q?FjYpCqzq5dOMlVvPLlNSS6sSbMbKjkNo250wF5OUzMJLIi53IOrr8IjwfU72?=
 =?us-ascii?Q?t238OrziC4Y+/RpiiPhhwjwEea5n9/AkH5nIaxKyFCC79ykJgGaE5jotF+rL?=
 =?us-ascii?Q?W0BpgQHYc4j6WZbab1U2QnB5oPm7G2Wg1KRsdic9sJG0R3cruKBfchcdyvLh?=
 =?us-ascii?Q?oq8j7V278bm59dC2JW2yDOeX/afuJPSY83tIS7Ds6R6j7wTvHXd/11gLVRXg?=
 =?us-ascii?Q?CRTwPdD4+Ov1zx9LBT9SrDJAcT40y3khbwT6WyWqr2CA1GBooibTdxFka9O7?=
 =?us-ascii?Q?GVNDaeGboVsLqLOr+b4J5M/laHx3ihN+xK1nX8gYE+N3o+W0aQWC8NIMuDeL?=
 =?us-ascii?Q?rMRIiKBqjUY5kkPpoyOv83dv52BTwIzjY1P8HzVG5wTAU5CrMekWOgUvcrfv?=
 =?us-ascii?Q?sn6yaGoicZ6mBquXpSvN0KXuGpCqOMc7Nu6DRAoPUSXT58hozTqMwSkLWwBG?=
 =?us-ascii?Q?j9ss5HTmYKEumLk6ltByu2eRCsaEg1vSq7lqbuMsNIHP+UqGlwGdh2qRIoc1?=
 =?us-ascii?Q?0SmrdM/SSzdQ1uSLVvtGlYjs0FRmywxxeBWXZE2Xj4NPJpn1fvZSf6e9cslB?=
 =?us-ascii?Q?ZQR5iZueO9mGdXuJmxNh1ryiNELf0vHK7btLlZ4LQ62HYcrB3CvWojaJ5lNX?=
 =?us-ascii?Q?RnJbL1zWJZmPrcpoDETCXi4avFwMoguJEkeiE37u8fuLJlT8kOc6N0p3XFGp?=
 =?us-ascii?Q?1dWcrpNEvSz9FBhQDiGD21Oi6zB9YTvz8unNUpaEug6Z0AIIpAMUGUywUikP?=
 =?us-ascii?Q?CXQkonfrJ/TyN+kXaPRf/1sDIDcK+YmyPRfbIVDD48/fi5bRcQN4HJQAo6Wv?=
 =?us-ascii?Q?5/QHdI7Kxu9DxzTuZBHZWgigw6O/hvEJETkDKRnthehlwEq5s/tkOKBKt41X?=
 =?us-ascii?Q?Son8iI9gxjp2QHgqcEHlSP0iZigPqYPS1kIuiiI/2wq4TzBU+/PwfB2OBexT?=
 =?us-ascii?Q?0hmQizYO12I7yrFh6YXfvlWTlGRwth/GBPGxvAnD8zi/hq58nv7jUPU/uhi6?=
 =?us-ascii?Q?6KinCbcXiQ2hR7bipeW13uKlvgFIh+OuS/7OZiUYRnLJ+cHKp0xIJFy5G+Nq?=
 =?us-ascii?Q?9j0aAU098Epr8fB4R0ZWq1vsQpcDkPNoU/55X57qaZMb1QEgG0xuBQ5qByrr?=
 =?us-ascii?Q?A8JsQXkG5DM2SRfM5G0Jv2wMmeVNe4I21PHET8Vw0w1TtIF2BxFLy6t8DV1S?=
 =?us-ascii?Q?7Zodc2aysSHhHfhlMwbSWzFh2butpVj/zoa9cWlDiNvU22QQGsSLaNd7W6M8?=
 =?us-ascii?Q?VM20bMzjfXnXt7o37n6BQCljkdeJ4X5rES0M21HTcJrLMLNbQ9OH0YWJFJaj?=
 =?us-ascii?Q?a+NhCpc9lfiOKyodis1OvjsnwFNbI5Pgyb8yTfvXzW+OyXciPF0+0nrNygTX?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DM2tRcH7LKgK2QzPyvqnj0080OPj4skzKpaIkmtP5/Ctx96bkG+AysYrz4gcwHSilib+s+4YANhhW7DUuLzrQP1ZRSHLCK/WzvwG8M+cg8Cl3QfeElNJhHlhtuhKimNDY48bmY8kyYtUi94qU9fqSs8yEijqdrpI//N/cYrhuI2fAG4Yg8fypx4Capyqt+J839DfJks8kVEwOf1NPnyFCVIHjloWNvRCGq1ipe6a4e0HZVyHwFe/syY99kO5HJ8BWKgBlfiNl26pGrK8fqWEAx1+zOe/PkFsJNHBg0SOAdPlG11BsmPznXQi9g8MLTCG0yEtnfrTmL53ev4vaUxbErcCU0+YmZ+bwFsRHowanJQ7vCYUf4Rou2CTIGISedybRztxwbSrczrVC11gMD7uY7UVlXcOt1wPDD05Lru91cAldXpVDbFEBJuEZxtFtVeT1/YKXiG/mvB/ry7HBqaSZHSEe/8AFQACVuRc2MV8gwMqPQP+jFQtezt6UBdualWk6bYmY5JUc3H10me5zTu3AgQVwTbr8SW+vAJmvaeHYneQZJo7M1T8PCBCCkZtOM/7NuTd+ZP+/yyrf8ubEguDe5tOW+PA63XBgxofylDGiBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8f1d07-62cd-4fee-253c-08dcc2e0501d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:25.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAHVP44Airy2GUCJTw54OifSDfbUPYxlD2Tmbik5mcLHDjLicOPglidFlqWaWCHWkFKDJNXA2JxQx54whqiGtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=925 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: dW8BNL22iIqjVJJGV-2vlWIi2aFHEq9G
X-Proofpoint-GUID: dW8BNL22iIqjVJJGV-2vlWIi2aFHEq9G

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mmap_region is already passed sanitized addr and len, so change the
call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
checks.

The inlining of the function and checks is an intermediate step in the
series so future patches are easier to follow.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 112f2111c457..0f5be29d48b6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1388,12 +1388,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
-	/* Unmap any existing mapping in the area */
-	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error == -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	if (vma) {
+		/* Unmap any existing mapping in the area */
+		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+			return -ENOMEM;
+		vma = NULL;
+	}
 
 	/*
 	 * Private writable mapping: check memory availability
-- 
2.43.0


