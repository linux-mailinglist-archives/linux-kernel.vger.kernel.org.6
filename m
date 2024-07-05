Return-Path: <linux-kernel+bounces-242863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF7928E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD6DB23DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398B16C42C;
	Fri,  5 Jul 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B+1aGGlh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i/sHK+sS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655961FEA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720210039; cv=fail; b=ebUtMrI1mzGIEQ2S8hYfB8V3QH0stUPLA1bRBxJ6jYT6V4h7l4j4eC0JVrHG+ykaSYdsZ4VeDHCM5pQ0TKVal4tphiHVDr0vXlhqQ45AVqUjr5yiNqkUVmm/cn0/12vs58q0YSz6EbINP4uSvbXSW0eYzuJaFvfiHufM5vZL9I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720210039; c=relaxed/simple;
	bh=KOpZlbe0AFKkEktkgTBPbXBy34bOhLiVltYZpVAVF5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYR71/x6EpzwzANDBv14LR2BvlBQsSNCewrtwVwDm09tBjPdilsjeF5MJFQl518Z0KjlevTPdlmbqveyw39ZhwFcgdKQ/ODa9g5usJwbhtCuVb6b6M9GLyLLlenKpzkzWt2VIAk/af4FLkkbh6WhhTgWEROShu4y4OIEjfwM/GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B+1aGGlh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i/sHK+sS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMXLB007938;
	Fri, 5 Jul 2024 20:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ChlB3NKNRFhv7VX
	iCQ3DYOb4U/ccRxLIYZuI0V+HIPw=; b=B+1aGGlhiSDHpfYHhcWGCK1ZlyRdFqP
	1ZOm61BZwV+RscVqo4TZq0gjgTH6CttTvbLpsITR8sWUgNQ9bQ9BNhX2rwmAngfX
	JuGIsxhvjGnVNh9ImRK6b+jkLhTkBrEoaNEAmP0bIeNublfPQz4NQqNCGv2ZAbaZ
	RuZhtA68+6Lx2KB98/FGjOwpMu+Knqx7fQ4Cf21t6RA5L9WNllpVLjUy7LaKaN10
	jpbf++qttqvtHPUSqkg8ZTKoO/zT/mxZGLFs5GeD35evLx0VL6eXcCqWs0IkN6lQ
	hkh3G0Hbk34a9tKYX4IjQL3apl5rxwMRPJq2rCHXWSSUVcvjBFHcqLQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgp1g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:06:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465JK3xf035735;
	Fri, 5 Jul 2024 20:06:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbeh48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nssKMsvl7r9ONPGLnHI4dejlm6txrLWV6HE6dBYqNntLTPnxKux66bflgQnu/uxFbo4Sy8bS9SJQupIBBhopqMMB0QuSCYsSg5aH/aa62jEz7ui9W1grsqWJ04hsRfdOwzX0f2eNo2wz+oIToVHTJaJl8koPUYXM0Bnjysouy9ja2Njd5daLvB6VuqSADSCiOcbV4DgPGVMVzY5i6TlYF26nphg4CxaU+UwAYQSJKVrYTkj41SSjpaAgK9lW7FuePHhur1mw6nQ6cz3vnHvzxFwpJU8IP2vBq5bfaUeWKuYFFbEBg12KlSFkkHDsq7Qzf4m+26HQZWPU0aD1PLrk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChlB3NKNRFhv7VXiCQ3DYOb4U/ccRxLIYZuI0V+HIPw=;
 b=H9PjukEhCPhMVWKCxw4zz4POcB8D9P4+a3uMvSR77hvMuj603Ll3+rKNF35r7fblcusryWUxDHBEI9SJaaAXG2/c2cf2yn2ubJzgh6ek3YHbN8xZlUXHT2ZYITgRRiOU1Vu1ayBmYRESV6/qyGeSjBh4WXMZvYN+1dU3fS+SsXyK2KdAi/gJ1OicjfH4ozqAAoLI6QQ8kGFn13d6YLXQ5rCpeJS+NVHM41EWk5iqJZk3MgrA+xXoNY6psSx10TMQ8F+AbzDHwBQ/tgN/j+iXlYnOHVpqu4fC14fu8tLQdJ839wo/5WO0raVClxieE1NISkg1rcDhfa4jHmw2uNcagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChlB3NKNRFhv7VXiCQ3DYOb4U/ccRxLIYZuI0V+HIPw=;
 b=i/sHK+sS1W9jeSXXLSZfQiRwi26SaS7Peh2WNwzsZYwPE7y3pXVIFyBzwEkoCMnrJb2VUFt79lr84GvLwASspwPsYefTgNly/So091nB6wyD6R8JOWCf91qKzP/8+c6pp4fXaXbW4bRH7968+xr4XHOunpTYkYGdvT2+rT9qx7s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV3PR10MB8057.namprd10.prod.outlook.com (2603:10b6:408:291::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Fri, 5 Jul
 2024 20:06:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 20:06:54 +0000
Date: Fri, 5 Jul 2024 21:06:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 09/16] mm/mmap: Expand mmap_region() munmap call
Message-ID: <b283fae7-fe72-4bdf-a7d9-7508c3f93293@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-10-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-10-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV3PR10MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 380151a7-4fd8-433f-0cea-08dc9d2e042b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Teq0JFAJu11bjJdg5fZOsVUOtqU3BmG1RZIKxJUUUjTB+p5UZ2PIan/G0G0Y?=
 =?us-ascii?Q?Ihc64OFpWKjkJOlZheGoM7CMXRsYY3UPNbhn8fVUn39NluYcNoKIItdLxL8d?=
 =?us-ascii?Q?qgqm3jsZiLmjBvMxWCSTpik37SNxz0jjyRg8uW0wMX2tDVkxNfoUfGDJISwM?=
 =?us-ascii?Q?jwownkIUH6J85e1ygUzwUXsznJGv1uXuMc7nLPuNRhBugYQpgg8Agya7km+7?=
 =?us-ascii?Q?Ixg6WM7gH2jBE42WfzbZ0XG9oFp09N5Ia3LbHsty9Jr1y7nBsR/kFeHU5L56?=
 =?us-ascii?Q?cKSIlwl42X7Hvt2w+j6j5D2CWMmxzMIdTumeBE8JnKsHX0ynND9nZE44Xo2j?=
 =?us-ascii?Q?/q4770FaN/N/B9td7sXK7FgBd4rscBcXafbDN4gfuWqDcw+Mc8tu75s60OH3?=
 =?us-ascii?Q?1Go0AW+FGsUBGrF9ZIBhNuwx/Jg5lsm42zqP2Duvuay5sKPr+C2tjE/berNp?=
 =?us-ascii?Q?lIhPXAJ6ZNgT447c9IXbd9okPLvrhJTvZ9bkGrWfuW7cJ2qajB9YRia1q0im?=
 =?us-ascii?Q?6xKnBP0xj4f5WiWlmp/oDj2nXPsTxMM844uiPXHQtktRCGjN2YQGPeVOZIFL?=
 =?us-ascii?Q?i64NpwN7X1Z++fwO8sKd0o4Egb2Z58AGjQqkjpwbiBOZJDHWpCd3OyhRRGB+?=
 =?us-ascii?Q?QUbQPnX1FLh7E4S+EgpZmO0zOPbKOZ5xpRTxUhym4OLbk2AND298byZ7bVEd?=
 =?us-ascii?Q?7K90tar56aFcufjRySctP/z3PCRDbd87BgZtTYuo8VFLJm9oNdbLuz8GGMbE?=
 =?us-ascii?Q?jD2LCdb3m727GybNUYZf6G+bbB4djDXd36aUwObZ4S6m+L86etvYsdl4ubuT?=
 =?us-ascii?Q?Q/pITJsXrDSPzwwcmQFZXzjtFcF5pIofuY3a+VC1qSDzApxuSzFXIYNIhl/0?=
 =?us-ascii?Q?fKYh4sQ7x+t8VYxMoSpMCc5i6mb4EJUcS0vSwd8PxtWiKXj4wNVMHdWYUmV2?=
 =?us-ascii?Q?bQIKXmzgLdKB0IIydShB1ZtaLl8Tg9m8eOWHUjqjR7h7ua2urLUxax1vRyQm?=
 =?us-ascii?Q?HAI90EBosFsW/SbLKhMAyzU/rLU0QX5zCvFTFRLJ6rR2Ln5CQgxNpQkgGPaD?=
 =?us-ascii?Q?g8tVft0PWWNGE9J1+iKRXAo3KJvcrh9HjzF/PEcikD7u79MKBgnCHORv+rnJ?=
 =?us-ascii?Q?6Ctoa2vy+TZ09P8Wo1vbyNLycPdquJzhqWR68x2FJ0BeeMDHxPpU3wrnxzCu?=
 =?us-ascii?Q?Z4gGD6eMJl803f2lu6oQf+R1rAnzgDzPrpQZFghUgeu6mkCHozvfPO+cLpXk?=
 =?us-ascii?Q?kAZOocAxmRIm9GcVMR7YNmq/jv35sfM3tE6wRYKE1Yt8BcuDREv4IW/KogwD?=
 =?us-ascii?Q?4huuc0l+sd2eA6NQmi8QQXbZJ5O6pIxoJ3SJvoDykKAI5A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Gn6eJ9LxSZkEAU9g5lddsBRcQLim4YB/29NuLzroKOc89VFoFiOg+EZZ4V1b?=
 =?us-ascii?Q?SyoovSGNAf74RrXcQUasT3+wx985BRNzHpWJRna/+7R5v9CCiTXg92qEGfD6?=
 =?us-ascii?Q?K/AD1/BpL8JXLSYAG3eJguD4uRK8zEOJkf7WR5V3RjSbIK+3u7cNSHkcUEa4?=
 =?us-ascii?Q?YV4hz34EdqU+GxxhXDsYxHeYgxhOGnyJoQJs1ruBDuLIXvVyLGYkYvVyyk+x?=
 =?us-ascii?Q?2IGAdKDIY0Xp5XvMhlsBLRoQbIdPNoX2G/seL4S4Vo6CoqKMJjX7UH98UEZm?=
 =?us-ascii?Q?X164t4KyODMRCPZ4y6bx65A1sJ2Rybn8QmPZg2CBT4bnOfbQBfwqecaJoFtZ?=
 =?us-ascii?Q?MBCNrqqGNF5NjbYvq+Rg8IMTVgwerPurb2qHvba6cPCerDZFhNN2UMCIR35n?=
 =?us-ascii?Q?C3VM5vU+iOIAgHnGX+VrtJN1fsprkqan7WzM7K0bD9+cTOw7aJ3ipRQZnWw0?=
 =?us-ascii?Q?5Np8TCGZ/aFrt9Nl/DKaGfnu1qOgTAcLK3Ng8whBi8i9l1UH8+zQRXNzbg5N?=
 =?us-ascii?Q?9kkpHhk+E9wgY+++Lu7P9E7K9k10rg6FYwUpXkdQeQ+nVrZ4hkd1+R8x1yJv?=
 =?us-ascii?Q?ShYYLmNgKwqU8oJlcesgeCG0U40A5NWmlvmiw4+4LxQUf7iBSXKSlrTymF8M?=
 =?us-ascii?Q?70AkxaaPG3yViUfzBDWmrFAd7nSZMwDg38vZrlWIWHIogBWBUaB6viyI0dTE?=
 =?us-ascii?Q?BeSjYzMv/lrqd82EHLLUtxuaNn2PP3rkbpHT+Xy2VJznWWNotblPlzfujjaF?=
 =?us-ascii?Q?u+ZOlfrMBfoAWI7xNOx+ZTSijSKSYBqm3uJtlg1K5yHY/yINdz6whRtZClOJ?=
 =?us-ascii?Q?z+lyBtQbHVkdoXyMm4hZyuzk92TqYqtxE9kJ3pI/LCUDb3pcDNvUjhDxtoGu?=
 =?us-ascii?Q?cdqA3kX4GT7uL8vtlCcIQd+kHCpFskXVwyZWgZeynOnUCBxZEk6/dlTVNYAZ?=
 =?us-ascii?Q?jB9Y1UQ0jM0E2bMqP9ZPviQBKORGxOVDEXK6eCarWpnIKyTVGISmL8VaKJIi?=
 =?us-ascii?Q?VlTxtDj8WAq+0y816jYGV7LQ+E+YWPc1K+AqJNymd3QNIPj0gatQUkGxNoZK?=
 =?us-ascii?Q?fpgFK8zU03yXks7gQgvlXpn+CDNTqBBqwM9k0sMw8hHWKJSgJzFRpNXeOa+P?=
 =?us-ascii?Q?h2mZQNnBZF04cERvWg+OyrPFsuLqnJU3BWS5MF/FQ90n62ac+NvvlB+OPxen?=
 =?us-ascii?Q?d0awHlIS+k71CAd5WjSICG9Ply7qyGAMe2v1xfnHTif7DRVai0aT0AQeZCua?=
 =?us-ascii?Q?CnEL2SX+EW+cXxkAzJp+EsMlL30x+xoa5UvmNS75LCSk+KliNg8kfF2NKEo8?=
 =?us-ascii?Q?bzWGFcVJHrNPxvE1SEpXTXBFW8GtkHNfts9ZTACMyH8uZ8M55S7tyZekf6xL?=
 =?us-ascii?Q?C911wMaBvoX1smJHKrZZsV695Fg5uYtIs7h5pEMTCmJafkARSUyQoI6J4abh?=
 =?us-ascii?Q?0w00U7cudtNb0+Z/IILJhcaAeVHSW39BGGfN4WWleG+RrDTrjBVVmu+j0Rbh?=
 =?us-ascii?Q?cDOymX7A0e0GqvsY8IADzsZzZYtXzr/pKRPuSJNVRMrEcz0BtFMnY5vHxfTt?=
 =?us-ascii?Q?WnR6rtz5CMWl9Ps/yezmybzOGWeiPTGbKpn+Mf93JRwy9OggVM7P0Y3WM/7h?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lEoy3tqHQSFO2XWlIVNK6xG2ajMVZoHfgnVKrONnR0jYdduR19S97H+CY8Vj4EdSS2iy2FIshGdBfi4qYgnPrWP/hCxht8w60I6KUFGtSBRUatlrl9a1bKj3z3Taa45QgFOHquFlXRVz1VOlNIoMZSXoqkFENZ6OiLnfYyJz8Ddq8FieVhFOKFfF+8dffe4Mqsi69VbU3n31F8gtvYHtjwXIuHVmZE57MpqzGjIgpQXPOILkk/jD8Vf21YFu4NIOqWov576f+jHMcpUS4gUjjPKHHsff3BBsufhR4z9PVMfFbHftLUYovwyg+THV8Qs2Th+V9jXQCIyEuZOjbN6HHaV9Fd9fbE0d79hVz9ZNejGooJU/aNTHt4wGynR7e+s/SEdnBC5WLx6SY1q3/OhxrHqmd7ZzZRwICsZ5EfRt2TLGLDgjB/jCpAosqKsNA1PhDlK5dpxEkSMmFbwo9ytJveyZbF8hpik5ElqYMdwZq95iOqOFXXvEbkqUVC3cOXZzLP7V+LPSFuzVypLiA0tD0iZaekkodV8tzur6y2M4PeASsRTN9hr701z2X/abqKELqllKIEteDJAOANz8XxWejr7z61az+in8rOQUHeVKrFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380151a7-4fd8-433f-0cea-08dc9d2e042b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:06:54.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyOLArcYh0JHk5EBA4vcwhJ+v8uFJXdv/9PcaATG0Zt1CUFHtdk/7KMgp3t3JCMRmGE8asTK6VkKujSNg+Bi8fbW4O2Ybwa8nntf3pJxmbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050146
X-Proofpoint-GUID: wAE8tycmyMVQ87BLZtlVjZxXiZsbtUpE
X-Proofpoint-ORIG-GUID: wAE8tycmyMVQ87BLZtlVjZxXiZsbtUpE

On Thu, Jul 04, 2024 at 02:27:11PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Open code the do_vmi_align_munmap() call so that it can be broken up
> later in the series.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e9858ca8bbd4..f5b33de4e717 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2915,6 +2915,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	struct vm_area_struct *next, *prev, *merge;
>  	pgoff_t pglen = len >> PAGE_SHIFT;
>  	unsigned long charged = 0;
> +	struct vma_munmap_struct vms;
> +	struct ma_state mas_detach;
> +	struct maple_tree mt_detach;
>  	unsigned long end = addr + len;
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
> @@ -2947,9 +2950,24 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
>  	if (vma) {
> -		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
> +		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> +		mt_on_stack(mt_detach);
> +		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);

I'm guessing this is exactly equivalent (or equivalent enough for our purposes
here) to the MA_STATE() call in do_vmi_align_munmap()?

Checking the two against each other it seems that it is indeed.

> +		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> +		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> +			return -ENOMEM;

In do_vmi_align_munmap() we also invoke vmalidate_mm(), why aren't we doing that
here?

> +
> +		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
>  			return -ENOMEM;

Same here.

> +
> +		vms_complete_munmap_vmas(&vms, &mas_detach);
> +		next = vms.next;
> +		prev = vms.prev;
> +		vma_prev(&vmi);

I'm sure this is correct, but just to double-check - we want to set the VMI to
prev here right?

It might be worth adding a small cmoment saying '/* vmi now points at prev */'
or similar, I've found it can get quite hard to follow where the iterator is at
sometimes.

>  		vma = NULL;
> +	} else {
> +		next = vma_next(&vmi);
> +		prev = vma_prev(&vmi);

But here we move forward to the next VMA and set this to next, then go back to
the _original_ one and this is prev?

Actually I guess if vma == NULL, next gets you to the next, and prev jumps back
to prev, with nothing between, and so that makes sense.


>  	}
>
>  	/*
> @@ -2962,8 +2980,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vm_flags |= VM_ACCOUNT;
>  	}
>
> -	next = vma_next(&vmi);
> -	prev = vma_prev(&vmi);
>  	if (vm_flags & VM_SPECIAL) {
>  		if (prev)
>  			vma_iter_next_range(&vmi);
> --
> 2.43.0
>
>

