Return-Path: <linux-kernel+bounces-255625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ADC9342F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B4E1C21152
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE35018FDBC;
	Wed, 17 Jul 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OSGj4Mwa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fdUqpcad"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7018F2DD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246879; cv=fail; b=MeM5HWQqZUIEgpkosCnq+T5JKNCOaC2pgUaN/DJfV+Ksd5/XHLc/Ian0BIKy1MsVpuyZJEyBCioEmyOFE7hv9MNzdftzrwN8pEhEDOLjuvb1eCF+UH6xaxldCJXdP6wNmFDX8W7XuuKsiOQRPGEndxs+YJdioPeMkz+lgozZwec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246879; c=relaxed/simple;
	bh=a8UflelC67Ra5U2Vax/Un5kR0AQLbtT9H9mZeqS9dMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W486ZSNBqpJbi9eDldXj/CMQHdiTEZ5Cgs84ivv62O2/tV0LQCEJNTe+4rV0e9lco2vOV/pi/AyiPYkG+Hm4evDPYnmTw9wFAgi7crPbm+iCjYoCxd9tRqSE1ce/oti2TShyaQY5w0S3tJIdXminAyEq/pAhW5d+ALewulFUEyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OSGj4Mwa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fdUqpcad; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJtuGd032011;
	Wed, 17 Jul 2024 20:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1TtzgtfAgfJoN12sNHXK3gwWMxm7+yNqFvSCP2hWL+g=; b=
	OSGj4Mwa1q80GcM+cf44hAuyqlkPlz1Om4ioa9G7BRP0I0/OMdMOufli/Q11npva
	ym+nSBmySs0LJ4LTlLT8MYccsZfrUIfnTwnKPVN95iq3NiwvKTV7tJQ2PHvJBxAZ
	mbkPxtJQO6FSfEQqPkZoA3DRUorQtYG045nXjQfa/lWB+flfgHQs2YHqtlgfclqM
	OFTJ8u4iCwLoaaWfpVtxj4Y8t3lXkuYg++mLORNgQx8q5Jd893NNelJvZye+M16u
	eiKPy41iww/m1/sm83em1sJcgV/+eZdD/jfsOtbaVSYO+3DEPTEvwZ/huGE7vLC9
	xgSRe3JHHS+r6VjouZzt+w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emhpr0qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJ4sq7003630;
	Wed, 17 Jul 2024 20:07:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dweyhkja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgpkYaPVZntqAuUBzs/v08bb//fKwmyODrJa7wVsVnXNC10gSnJeYacakgCX13S+WuwZ8yHxnPG+lGIiZWCNKtahRaN6H6zTz2fehG3BGz3W5Lk8y2z6t9sdqHhG5OfYPaxDpJqC0nRvePcRC9bGOChYlkA2GqXt7AQSJqjCTXqlKE1CWqiReXeq0lXG6wp2D//Uc/SXEWReAUZsBjchwrxg1A2m5jUyWqMJaD/hKkjC/PRnbeonvhiNjM2umxnaUEveOzS9v9lk3s62qHTVhN7w9zn78xlsgX6SL1YdTPLW1u6QJu7SeOmyxYcMJP3opxB8xSuoigKKhgOjENY3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TtzgtfAgfJoN12sNHXK3gwWMxm7+yNqFvSCP2hWL+g=;
 b=sKA+Ilgl+KapwzyXeJzC+bckBGNM2bDOrKJDbQp41v30wdGuKIconvU4Yewv+ZY6n4Do3tXj5lCVRjs+hDur4GNAsxJ4R6hRetKdNJE4J6TSiCeKAyi8FG7/uj4QE89qGaI4F05fGRKbDB6d8FkTkrrNErTwixVmS4+9dulTcewgKMlIyb69FqRPHPQVNyDE90rJezjc3WYnF//PoP0tyY3wE/wnZ01g0aJs8eJDrJdmmvJeyHuw4OjGiJ2COIpL2hbE0dTd7hshZ51suuMCtlKtjoCHTLzWFN2+YFfyp0OyNNEHdxo7oEIgPgN/8RzLHXUwicBcCpgxJfWw459Nmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TtzgtfAgfJoN12sNHXK3gwWMxm7+yNqFvSCP2hWL+g=;
 b=fdUqpcadriZAmrLMjmdvgl9+aqRzWlqs173uGR7Pm4TZq/en9uJXBY2zoe/XDIwZ3i0LHhvzbR2bzgZWvwHETI6qFREwv5z2ySPN14ZvTUJKdF71L3/cPorMTY9rm4mGRDVIZmkVCiINpn6ZuUwNcKH7P4ZVVMU4ntTUSO6T5mM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:07:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:40 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 12/21] mm/mmap: Track start and end of munmap in vma_munmap_struct
Date: Wed, 17 Jul 2024 16:07:00 -0400
Message-ID: <20240717200709.1552558-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2497ce-a893-453e-879d-08dca69c1c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LSd0jL+q0u2kUs6RAOByPRGWWSeP0S8mnk9INejQ0SXIj1xrmQF+Lsh+Ztyq?=
 =?us-ascii?Q?abRkKb4iGuZi18SKqgp1C3xS7/uc4Z2lT4CWZd775n0k99ODvLw0APuOpPZn?=
 =?us-ascii?Q?AGpvJJK2V569SepWQTVMuo7nCDpgr/i3xFCrZS8HqkE07hKtgIeq7hg9BauE?=
 =?us-ascii?Q?LBq2c6qr28zGn6rF6zvSQmRFJ+Myj7A7sc9eFea8yAykI7ivnoyiQZIFLhnz?=
 =?us-ascii?Q?Q82r93viLvplM4yclT46KXT4Z2wCfwVD7mVhiJi+keYK6O2YsipSjuoyUol4?=
 =?us-ascii?Q?ZkuIvV50QlZ2mkSCTGDmSNBJJ3pkJgVkbfsDvjrQ8q4QIM/tWgu9re8zy8jh?=
 =?us-ascii?Q?CB8eBoZldnFdRwbOBX2VjorAZfuv0hAgdRLr5s86Vw+76UHC/dg+JZCgtRzU?=
 =?us-ascii?Q?ID13yeLCcvis1JsnGzxVhfZOWQQnT43Lpmg8JdPOIKBSM2QRJdJeyU9fg2PK?=
 =?us-ascii?Q?usWWc5lORRmCc/2MboqeHkT91qUSE9UxnPbGw9hDrIlzrKfpjZHLYn9ybD1m?=
 =?us-ascii?Q?GbvxA/346D4ZiYZaydERsr4U9aZjDqwdaf1OG8nObAB9Nm1dAI6D3QP933sY?=
 =?us-ascii?Q?hblTTlEVzGzZb+0Hj3z825mZbQ3OM/v4oObo4YuUHvKdepLpy9TrqqUIjgrH?=
 =?us-ascii?Q?UU551nWd2u3QGkoR5wt5aQy8NgSw9Z1sktXdA4BMBS9uxv/OQPZB7H6cGN6m?=
 =?us-ascii?Q?FqjUblFdraNwkvrMIfHIefDbPYEKXP9vxKzVhKnG41sizCsdYX3w74yYPvA/?=
 =?us-ascii?Q?1YQRM1PN7JsAigl9uOLb0h5tGjR1ZJqUYQBZwB0RnOruKg/1H0TNCWlk8A8d?=
 =?us-ascii?Q?xgUc1kCftPk9vnm5jyXNwnIfz0wak/8081ZAoeOwZW+0Lia6odTPFYtreBQB?=
 =?us-ascii?Q?qwShp3qSXQtJNZ+j+0jCYU1Hsay462gRH3ZDoQiplEHVu/PgRFH/G5dMVXs+?=
 =?us-ascii?Q?apdqywsHIDor4H0gct1Q1o/V4zGKkzd1/ZUdG6+nBVZCo2eSgr/qb31RJ6NA?=
 =?us-ascii?Q?a+QJxBNzHeIuxyEDYu+QYvuEA7O34JacFQMzTWVIF16hbrRo97UZ0a1zcUBD?=
 =?us-ascii?Q?KEOkicJGIGtPOlD0Zk0KGIyXqgS1wDZY7n88qVn/qC46kBkOwH9Qu+C3qVJw?=
 =?us-ascii?Q?etYBeMWgh1DCR+OXGn49rG9g38ZRTM76LwuMZ/otdYV+gQ3gRoDhJk84jIyF?=
 =?us-ascii?Q?IgNn4SZZach4wS2STPD9FqJK0lcQwhYQsJPuqgLxC5T61vVDGpcnWMNXxtz4?=
 =?us-ascii?Q?DgAqDKbjQvt2GJndEgoPo3MQRwZ7IQokgWADr2xb5u+rnQWNKBYQImmQb9xZ?=
 =?us-ascii?Q?BrDskkl8JV8aN7H9PlmHGph8fO3ZooM17RsIvUy9ueWBLA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3X8GE6puGwoEYmhJQk2OdM0P5mWK4EhjGWlxnNodHk3hVTscJnGkDQvqPWlN?=
 =?us-ascii?Q?apl0W+3OyTeIe/VjB16Wra5q2s8WK5W1EYPHG80mk+KpD5Mn4yW5r64Vuimn?=
 =?us-ascii?Q?0creO/SX/gRFl2Q5buBQr/wcWp9Lf2F5nPvS2C581f0Iv2Lj01jqWsHTDDqj?=
 =?us-ascii?Q?7Vqbealkqsve+bg6iJ4Z/E2lxcg9lkcimOGBqafEYZxZCYPnV9Akp/rDvTx7?=
 =?us-ascii?Q?wNTS+EHu91xjVA+QeM/M3lTHADb/wWNEGVbTNMXrfGc4cBrkrbJJwcDNSVts?=
 =?us-ascii?Q?znXf8cJwcODrQtMnFz6ecy8hB3UF+ZOMUyFwPeMtA0jOTTHhgPwN/ACmu+6C?=
 =?us-ascii?Q?iQ7nk161OaLKBqeuA2yhPtDVk+Yv8LaJH7WVn71hrqLku6nR0oI5BRR0y2DC?=
 =?us-ascii?Q?eN1iVAbVGcza4X+o5i9PXr5ZU8MePZLHJ3qDfDHqfJd85b5Uj5jV+eluXWDY?=
 =?us-ascii?Q?wfY0mj3T2Lfe8heUVD+d7GB+fvZCsPhPXayN0q2eb3AkU/K36EUfXNsqnB8h?=
 =?us-ascii?Q?7TznG8sl/8QmUnxXMXKvo+Y19gVbI/sz9ELQ7oez0zG6hkhd5hlogHpwCsZy?=
 =?us-ascii?Q?BNW8UpREviqDj0mQ4bESAlrkyxcm1dxvCXO6xYwbCJbI+SMGiB3KPhq2LqOY?=
 =?us-ascii?Q?iDvgJSTIX6EGtXs83BHZ7UfYmclVgtCqPtbAHr9O1tYgSpukFwimbv058yJz?=
 =?us-ascii?Q?i9gHzTUuVB7yI/F/OODoNc+x9xo1zBVAuvENqAUjtusCDT3XxiZcd4rg9JDC?=
 =?us-ascii?Q?Oe/hBfHVVTIH8V/DRq/j8uoViScfPt7kDD6NmQTTBuToeYhyf7LIZZOnDS2Y?=
 =?us-ascii?Q?5J7kiSLmGM33/iomZ6+ov6hyNjOXQNp2eG8xrX7+Jxd9jS3n2DCS6nEJWs0d?=
 =?us-ascii?Q?7lrE5HVJvpFfE7BDwSwTwlffWvK3DmTTm/OAVKlgcaHqVj71XIumZoYaA98m?=
 =?us-ascii?Q?fySqwJHeDMc0u0bumlkdA2JUF2IqGCuEcScRd+30tbUKaZGfidluLuT8usBQ?=
 =?us-ascii?Q?mByPrZhAG2AVAIgq/ZWnOrMNvKu8TWmeq3YA+OKa9YBlZhYi7ErhV7rw6yvW?=
 =?us-ascii?Q?Cz+f2tMjGIaffplwMjLXymW/xsgQunrI0EsdIps0Hmfbh6bWo3z8WrZdeYVB?=
 =?us-ascii?Q?WVG40wFNZ+ane/NJ580+mr0wC2rZIfak9eKlEWWUTE8Lm1DzCq9gDUVjgpUT?=
 =?us-ascii?Q?t9FwKBMlhUNMJwcIWpTCL+/lKuQJhQHqWMqaRnWx/61c7dFdIqmkTOym+QXi?=
 =?us-ascii?Q?2yDGgrHTjz3OUJRnjNb3aVY7Int4tIzihxEUz8k+sKaI5wUEo/0M69zqcsrC?=
 =?us-ascii?Q?MB2nbPqxi/1yqJvh9CHAFJZX4tWvlvV8dVDcQcLNyVAfbLWTXWAvjOYW6oaO?=
 =?us-ascii?Q?ANtrjm3wwIWNyv3vKSIHbO9jXRxn4bHJCwiwurImQeq4OvQQvPeKZPgz18HR?=
 =?us-ascii?Q?RFBrh9tA9UI1htXyQh7Sstr9XOEsS9esDyuKlhtANP232CNs9h6ycANyC9tw?=
 =?us-ascii?Q?QkeNb/pPyjq1ekGoC8jMS5E2oer5gBK5t0s7SsLHpZ+/rB1t5VIF9wny7Fqp?=
 =?us-ascii?Q?FE8dJNIgdi1r9whyfwRCGyBfCnavO/GBMM6STGqulcCtoPA7vfR3WFADcPox?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UZyXF+2HwiIG2cbnKvil0FqC2tBYlSNg0gVqf6HG/g+WbWTlxSqh9LA+aJFiU5AWcKvXiiRBoVPhiz9tCETQEaoP0VErcFpQt7SL0zP+iTZTKENJJYRET1eGq49EDa1c5noRHM8MJp6NYaj7itXYxA1y6iQEKjwSNHelLiL2dSZjCg9VeeWsFYS/91YdUSnt2H2UH/iVbBdspdnImsWHUMzjnN2izDJy5QUPddS+Ob7uz1fNOAy7d48yE4tLwVhZjNMzv3VNR55bWSdfnYoNmpMR6LTHcIwevXeob11v3hzdvlICYZtzF1iSjRhk1cwUcEeT2rkdw6UHk8JlIKuEFVxNc3r9ooK7x9MfFUuIxpROA53zjr4JucMDVmPmCNHHhOtuRtfLlW3TBDp0Yzvpv0qDplEQVGOInotaJgrrwhZKb4yg/5kUxhmZCbLeNPjA5klfGkjPecojJNO668GW3bXXSwHtG70PhBRrmUR+E7WoGrsysxTaLhZTgbJp4n8v6dYODee2glurJprBZTUvKUadlf5JwipMCwUbn7h+0U+rPRIzxpvTLTE23cTwJMen5mDRdr23NhmMSyIn3jQcfJTodgefdOfayYbdBNS1+J8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2497ce-a893-453e-879d-08dca69c1c5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:40.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbUt0/S0Ri2UMXBjMQ0xqcUQP6XjR8Pwu6uXOYTxaYYgwKWwP0l/TiYXWoz2ggJ7N+DDd+FFqd0I2PkkK1k8LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: I_zVh1YjHHwW-IVez-UO1U83I_cf5lFO
X-Proofpoint-ORIG-GUID: I_zVh1YjHHwW-IVez-UO1U83I_cf5lFO

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Set the start and end address for munmap when the prev and next are
gathered.  This is needed to avoid incorrect addresses being used during
the vms_complete_munmap_vmas() function if the prev/next vma are
expanded.

Add a new helper vms_complete_pte_clear(), which is needed later and
will avoid growing the argument list to unmap_region() beyond the 9 it
already has.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  2 ++
 mm/mmap.c     | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 02627e269d6b..ec8441362c28 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1493,6 +1493,8 @@ struct vma_munmap_struct {
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr (inclusive) */
 	unsigned long end;		/* Aligned end addr (exclusive) */
+	unsigned long unmap_start;	/* Unmap PTE start */
+	unsigned long unmap_end;	/* Unmap PTE end */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
diff --git a/mm/mmap.c b/mm/mmap.c
index b940de8c6df8..7cc1f47122f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -530,6 +530,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->vma_count = 0;
 	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
 }
 
 /*
@@ -2612,6 +2614,29 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+
+static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct mmu_gather tlb;
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, vms->mm);
+	update_hiwater_rss(vms->mm);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
+		   vms->vma_count, mm_wr_locked);
+	mas_set(mas_detach, 1);
+	/* start and end may be different if there is no prev or next vma. */
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
+		      vms->unmap_end, mm_wr_locked);
+	tlb_finish_mmu(&tlb);
+}
+
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
@@ -2633,13 +2658,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
-		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -2701,6 +2720,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
+	if (vms->prev)
+		vms->unmap_start = vms->prev->vm_end;
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
@@ -2763,6 +2784,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 
 	vms->next = vma_next(vms->vmi);
+	if (vms->next)
+		vms->unmap_end = vms->next->vm_start;
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
-- 
2.43.0


