Return-Path: <linux-kernel+bounces-297896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E9595BEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27061B23783
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D19E1D3189;
	Thu, 22 Aug 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h3wPgmnh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p6xB+NzT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B51D2F48
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354830; cv=fail; b=bixEZia+jp2u8A/cmDZ1C8ke0dQ8FUowELDCbsS0jo7dOW92krWsugpdZ3FW5VMPHG5AlIh+Mx30JIi6lqAmsPJWy9LY0cFZn2/p7IT2g6LqUM8XAg4Odp/YLc1Qz6sVggifHyVTPbCQjZDHMz1aumkhIQ+9m6NFOpqyynjxkKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354830; c=relaxed/simple;
	bh=y5unJ2WZv1HzwhVZq7cQkKkDfbivjADNirD0OwgKqlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7d9m6StdsVHCzeEVGSli+vDLzoB18SxGZr1/MFJV0xiLAj9qAhq+3fEdJqVjVBwsQgqYy6Uk19F3Y2QkW9i3r//X1hfVjF037+sbkbynmovxZ4ER6886pXCVxBSoHl9+AvWBSN2rOepHwdAzRQrwcDOlhQP1hVnkzuHXocRPj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h3wPgmnh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p6xB+NzT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMXpp026397;
	Thu, 22 Aug 2024 19:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=XvkWhZ3Ci2y0PBk1VQBRW3jFIo7qKLe3EqSRA7vVjkY=; b=
	h3wPgmnhYpqvv2I3MRo/8HL2TcuGwCQ4xCW8ASM3OEiLRVVxH0KMnqGjbk77JeZq
	fTVa6rO14UXX7HUjcW4MAmvraA0vKH5H18OiM9gLnaZzWPpCmwuk69yMfBY9XVPk
	vxHvn3O+4wLMEH2s4+JDJMI3+GEQ4GA1lnFBT3cuokLbhthDNAam8YyBWppjByuv
	wL+febQJW1RTd6+ImnpOlBmZJk9uIptsFvIU8IJtE/pArVoboX4Hs3XSnudgvfnO
	e3M/X3H8zJHnTzvuSxQxkizQjgQ7dpzIIEGmCUHHKFV4B6bbYGVHEqJxOxnIhg9i
	3KbNV/zZ+KsBNkjmDmGBfg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v2wae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJOnW005646;
	Thu, 22 Aug 2024 19:26:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu08bq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuK+A1jjEVC1ZEo8ps8rQOtRapu6G3DVhkiJMbJPyZsNme5BAetys7anlH9NJtySQYwS1Bn/UgCBxzykZLIa0z1sSv1vyvIPD+UgenqalkdnLcWUp4Pif4EW8ASk4+sXyrTiQPekt2BR36l+7K++OAzEKYn6YtyWJyyxdHGFAiql+JfHQY97RLIhbGd5lDpaKy+FwsCJu757haAh05LmMMemeg9IfyHxDp+bJWl3hp1lgwHJchnwXgblHqEmQGXjvs7afmabiXEefoJhmESTayAg/WIg6mGdE3x3g0QmXF8oQZEK/9J1W6QRyXrlkMDJ/JzIW/OGbbLmO1cc3qj5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvkWhZ3Ci2y0PBk1VQBRW3jFIo7qKLe3EqSRA7vVjkY=;
 b=WEQbwQ4an2bVEgNdgRoZwVWI3ysFQ8OFd2juciDLcjXUp3A2l/j8u9OKmcMx5ZZHLJPQIH8e9MCybAwyvBiqHs0lsKNmjIJ/mOxr8DnpOEL1hMZgPHBtndC48JcTsV0YDo9e5/SfquckFYwCcZntOqHm0ilW+gLmn0cWGTknlv/93eith91OV1sEA0Qdo/6wabuPgDnmez8K2QavlZ3aGSUcxAgsjCfx8oezHlEJgxzotkuZUEAO9ZvzV+VG79DENqcQR/3w1ODaN6QZE7IdAsvaazqfHI2ruJiBOOUYaeJAftA8SlRRQLGCE8VihY6eZHL8obH6NTpU6vXzuqzQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvkWhZ3Ci2y0PBk1VQBRW3jFIo7qKLe3EqSRA7vVjkY=;
 b=p6xB+NzT11868sh2srf1IGUx2gskvDrDvCISCzAuFsw3vHYD+z4Pn76EsJOUvN6a1xHN4IP0FpFiMHJUFsNrtCDTUZOMxM4t5Ing76qsbYTTJfNEB7DkkO47fif9dn827jwf2WTb+yYzf53qxOcKe8ZsWmHG/CBvXJ8Ugmga4ME=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:47 +0000
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
Subject: [PATCH v7 20/21] mm/vma: Drop incorrect comment from vms_gather_munmap_vmas()
Date: Thu, 22 Aug 2024 15:25:42 -0400
Message-ID: <20240822192543.3359552-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: d58c1627-1fe7-40fe-a2db-08dcc2e05d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XsuE6mpobJfU7ReJ5/FqxnzVCXvNdTDqAujXlIVC/t61LcEnkIXQ4rtPsya/?=
 =?us-ascii?Q?PdFUp5wDe/LQhnKd0nBkfa1m0XJtSPCHv/+Uc6twygxL/mfP2tqL+vgBF+nT?=
 =?us-ascii?Q?xOXu6dgmfq6SlhapVRwrV4YYBqBTtF8CGqrVyw/EVy6y3KqfXtXlpX/PaeU7?=
 =?us-ascii?Q?iFgazfOBY57RhC2MnjbJgHBrjBOl8x+CcnbBoeErPnCftmTI+9lAiNRrThdI?=
 =?us-ascii?Q?GLqVGMTu4VC0HgjRR2WT9V5ZJq3TIZ9de1LWlB5LrYiE8/pjm5Ki5KmZKzq2?=
 =?us-ascii?Q?F+9LjIjYgN+tCODIPTB0ebuFD5OZL9gHI1L9B0EiKkDwQaR0/GtO9Ej+84OR?=
 =?us-ascii?Q?gpLpfI5fcxhER6LHoRwLmIqd1IYNZApnqU4npkvassLvRJrIEW3NMbVo2KEC?=
 =?us-ascii?Q?busNKkpUnc1MMEhXJ01auibvUxbndQDRaZdRYNXXZetllljhb5QuPFHAtuFc?=
 =?us-ascii?Q?WFr9aHGrvvOx3XbymNtxcCImYOIW8VLO5+tpUcGproAqlhIEQnsCHEii60JW?=
 =?us-ascii?Q?4XmTNADPGeQ93p6sxnhv3gIbHtbPPrubF5b1IMeh7rCHbuAyNdDJ+RaSI6SK?=
 =?us-ascii?Q?bHt1B8Ni0sNcI+mEem6xL+jN2y42FfOkXmoEotBPuyZbRMf/fmQSBqvwK5F/?=
 =?us-ascii?Q?wAKHpSjqOahBsZjSAgGNg0/CvDpr92eRKqzu0/1Q4c+Z/syWBVX5yxoo+WVf?=
 =?us-ascii?Q?GMRjbFlHZzBrSFPbv6k3vpwzOQPfhTIttxd8jNL2+rAVhnq5DqZl2Wa8z1zd?=
 =?us-ascii?Q?6swASkbdMWtU8qVpTplk+3XT2Ck/oaSeiAR798a2XQt3rtLMrmX63UHWX24c?=
 =?us-ascii?Q?u77ykNXr8u7DrEx6FLPS8xYGt4/DWX7A76u6+jRA33pGUJ9CacUK5NpiIQAW?=
 =?us-ascii?Q?JASkDNGwTGCVilyVp2N375CDc/++cqaxroOkWhYFGYMyLZmbfrQ6fsKCMLfG?=
 =?us-ascii?Q?IeJGT8195VDbazgSHOeo3qQGG0LVGEmcUOCp/ZNZmVbtZXWzFAQF12PxF1Ln?=
 =?us-ascii?Q?q10oLqcL5mHDRP//Ws/pJnJ7KHBmzlp26eFVNtcoEyncX77WrO4at6PFrnEk?=
 =?us-ascii?Q?zy0alLW95pcZDIy4Zuo6Cz7XvFLuXp1l8lX1N9Mo48ahAnzGFyVENgjRZXOX?=
 =?us-ascii?Q?aW0d4pr/jP5YC7xgEowR7nBw/EQDbGRT5z+TkOuDWDJkOfe3DASRW9hHhuXn?=
 =?us-ascii?Q?2sjacs1vpSnpxyAQsOPyn+wIaue0AsD9bOElLpUiT/wUZOghnF7xaE0gKgS7?=
 =?us-ascii?Q?/zpLtnlwTNfKp/3idtxoi3IxIkDN5oiu+WWHkZRt4luWVEajeejNg8gNJ7Lp?=
 =?us-ascii?Q?8m+H2888j0HQO1mHcBPc+UbYHybuIXbqOZa9RhEGko8DLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?naQEV/gr5plRHl0FmA58j9IVqL5e492vKqfNeX7qCirMA9JZhXmHUwDGEvaQ?=
 =?us-ascii?Q?2q3dMhSqaMvHfmGH/YgnYvh/OvPNezzM95q/guJsMGQzennQmFr3gMXnzoEc?=
 =?us-ascii?Q?fMRMVhKB7P+dDycnxZuGivDKTHDCmFMlk+m/ELtiyzPsorP5PK1avZkFGGsr?=
 =?us-ascii?Q?wHYak7+Pn2rowjAy7TDh6zOySHs3JoXYPrV/8g24NgeJEWbINckNq54ZHgec?=
 =?us-ascii?Q?B4g4lN6Q8WxJdx3HI8z5YsvfcNtNBVboyWvZtydccAebXxvAtomRZsbRY2sz?=
 =?us-ascii?Q?S3IeK6qtgvy21cHOz1G15zyImsLMIfXU21R0gueHJ1h1YjAovW+y9ilH4q3/?=
 =?us-ascii?Q?7ohJcYrm1Nlnbn1mlre+sjIb0Z4ZS4rJk1uU4ROaEySTIunLAr34RY9wrrRY?=
 =?us-ascii?Q?3yg/ZumrtbJeWZrUzWT/uX6la7psdGeSxH1HsOc5fIN9rgwNN4KG0CQ2Y/i2?=
 =?us-ascii?Q?O7VhWRvDPAdAER++9PdgTUChXGiBHqshjyVN0wxC6CEwMB4IrHW23eyTGn2R?=
 =?us-ascii?Q?8Ej3imDEcXYXzZ1hYEF/23FYLTljW+um8g4iSRdGRRneGoKtFgvGf2JXPyy+?=
 =?us-ascii?Q?2jhMnr/+pYooV+aHkVtLJSsBjrCtiWCzdnp0GdGs4iLV63YSZ3p3hwYMPKMj?=
 =?us-ascii?Q?m54JOtlsMImmnqA/3Gid3z+hmTa4fGCUoZOipr1o6wuQmx5rczO1Ceu6w9ab?=
 =?us-ascii?Q?Md63WiL3+N34uZViXC88/TOr7nRT0UjYAWxHdzIEOQ8j7i1LMaxywtl5p5AL?=
 =?us-ascii?Q?HXLOuj2kb+/nHSOlenS3xN0LWMI6iWthSb/tOtMrmtnNk52Kg/wnb5xp695E?=
 =?us-ascii?Q?CSILuu7pGn1s6Pi9Rj5C6mBBmuFLZgwgBb0iDgU49rdBkfZu1zQxqvTf5cbs?=
 =?us-ascii?Q?XIHDQ60J1nS+H8WYw2jylAyzXPJmiX8vrWmZBLu1gBd943L2ABNsFygFF3as?=
 =?us-ascii?Q?6Lv5pR6QWXB2uukx5v9XJe6lNBWnA2nV+XpoKrOD2u6JeqgDShkC6HSjBtUj?=
 =?us-ascii?Q?3ZVheqeiLHcHNAM+jB4r9pO1SJo6CXFTp+/rJAVeXgolR5OC+hE8DByMwinP?=
 =?us-ascii?Q?Js6FS7BkH2DNMLRncTcNk4qZMOXX7mHawbMePizq0oMMeTPmGv3y1mPttOYv?=
 =?us-ascii?Q?oS4PjlNB5GJc3R78nzvrGDuEF4DWv+fSSlbEPJY6v83iI0Qti1QBlc1xAvK5?=
 =?us-ascii?Q?gQkoX3PUcipXb5VQlN0CxM5ECh6MV4szX2lVDhaaqmmXjRf81JjzZ8P4Cg9u?=
 =?us-ascii?Q?K80ZbGFjUbJg0i1yzNp0bQhAKYhnJf+rtUO0v70hIA0yZ2HZarktQgSL1mPy?=
 =?us-ascii?Q?UJSOIVRxctcGSCH+K3bU2IIBWbQpN4O7eUtk0mIqOsCUEAYHB5fCTn8IG9Qd?=
 =?us-ascii?Q?9fI8rrwZI3XaCk1mEwNVwK9t+s82aixAqV4fbPGkrSJshEnN9VRwPnnib1g8?=
 =?us-ascii?Q?WLMr1pwY1dQQxeGBI6IyHfYmoKIzE5g64hUBnSL2TuSVwlV5YToffc7QOdEB?=
 =?us-ascii?Q?4LfJ/czcwzTezfXx4+VGkw3j4mwX2FMG+L40cGPddcPlzI/Y6VfGHekqXOR1?=
 =?us-ascii?Q?JtFE475HhgKzJwwPXKM6E7FDEulMfPuYvcxan9EzieJNSTylQv/q7yGxo/w+?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NqjYet9jI+kxgULBYQKtJ9+vHvPe573ww9JmI+jyEeOODYio5H9+YEfqIARFt1VNcsCnmYUwjoSvUNv5EzURhKT+j3snV47y1+Ia6hSVi1BUj7UhQ1S+WNgRorW2hHLJx/C1B8ye0H/OZfuaYAAsRkUk1mnC+LUN98vag8TDdt1ODhBvcZfkkA512r1updAojoMaDCkNYvw51ko43tMOM5SdyYmD71TmcAd/OCFU8FMv7EmZlTEUBuvcELxZ/7qm1bOyWUZ/7mTr4Ekpgv86qUardBRVT9yub0H49ieI0PLWT8eKzAIcc9t5f3wllkCGTagWtD3nllHIVJkJG1Dr+dWsjv1ynNlo25/q36wJhNcJaq8KQ+CRjurjS3zPVNZu97JfaSBtJRnV0xkzj4B+EkQafBJdWB4lj6ExlroNUNpcATTN+HFln9A4GJjnAncz8JNPgX7wtezgtVXdwRO7UoFgFoCh//6HUJLpcPjelW0LKQlX98qGsJWEgO+iHoCFuBI0H9boiCl+SRcm7w4c6uVUll6Ct43zE2pYYbNoKafPKtOaoEXUkEdkoEjuZyDj1Kgmm/k0WXmDkAcG0j4EqOL10H6WB0HTqowEfptQLQc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58c1627-1fe7-40fe-a2db-08dcc2e05d24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:47.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjYeX4GdnQTqSA5SDw4Wk315cgQxJnC4hY2s9ZgfMxm8Lyd+x6zJchtx02W2AuLWrNhD8Q9pobQOIMx7kIiodw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: HPylIhYx-W_f_VHHc4f9KI7XwUhkI9cI
X-Proofpoint-GUID: HPylIhYx-W_f_VHHc4f9KI7XwUhkI9cI

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The comment has been outdated since 6b73cff239e52 ("mm: change munmap
splitting order and move_vma()").  The move_vma() was altered to fix the
fragile state of the accounting since then.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 61d51677eaaf..ca87d30cb185 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -755,13 +755,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
-	 *
-	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
-	 * unmapped vm_area_struct will remain in use: so lower split_vma
-	 * places tmp vma above, and higher split_vma places tmp vma below.
+	 * Does it split the first one?
 	 */
-
-	/* Does it split the first one? */
 	if (vms->start > vms->vma->vm_start) {
 
 		/*
-- 
2.43.0


