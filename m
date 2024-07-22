Return-Path: <linux-kernel+bounces-259099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9C93912C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668321C217EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8649B16DC3C;
	Mon, 22 Jul 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mVVoZUew";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LpI2XBva"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F716DC36
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660352; cv=fail; b=I7I1zZ4aTT3Whv77CINZUNSn81dLjSY4zT+DGdv9aGDN2uwiJCoMJGfIQM4sOQGW70/s7HQ/eg5EeQerBos39SqTwrMEgl04tcIHO1a48V7sB5Qp0tCWiPlCSxRW0ZvjgoozYOO2d8blsiUk9OToPUIxRUkTZ3N96pO90uJUP24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660352; c=relaxed/simple;
	bh=INB4FpWERxX/lH+SDotVeycNZoHkcYmoGs7wMfQZXXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hq47XZrRjbRBWMPvfykd80RKoOMupTORa53OkkeNNehDcMuEcBPRjFlBPbl9iF1NyCdrlpLltEdj9OrLSOIpjTL3csAh31Nq7OPCWccfNk2CbR8Jy3c4aXKSJgrwy3Q4EZrxvPVZPhGwkAjmAk+rmr871WswX611HN3ipjVU9ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mVVoZUew; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LpI2XBva; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MC2M14003143;
	Mon, 22 Jul 2024 14:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=38BsP+7pD3/99qA
	cpQ+0gD+B4WgTTCxPB16zu3wfwBU=; b=mVVoZUewlWJNEveQntCgiGash2Kkq0W
	9H+FX9ibfRoQCk3i9KUPHNhq2+W6+OgCuTvcFEGzL9f9fezWPkMBaBHvZITkl7I9
	Tx8RS3B1KYVyof7fXTbLtfVBmWAhZC109GPQAKryUoWK2jKvse1F3J6fezosUNJ/
	vJoH2EqHllcKms204zOgnTKIKVbPVZvpYJL9/nCqeg8ZWsyLBqh4Zx+GhX1QqV0q
	BnEK3uz5TaJ67gJfscjGCkiSkXA2l175fKt4J/c8IQtDxqielEBTj9se1nuhOblZ
	RAkT8vdVcRGRAulbxyQbI0as17MpBYMr+zKSCSTGdnDhxUP9S61hLNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0a4su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 14:58:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MEQ6Cx040086;
	Mon, 22 Jul 2024 14:58:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26k2jsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 14:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGcCf4hXmNuvEZ5WiJq9ZLbCzQ+4h1JER75mRCKuDOVevPf5+k3LlJmVa75O2uRk15rtTk41/GpYu5eVR9bwzxfuw78F1ZBDxuhPo7s9CkKm/a3DUTuVXQ2q7SJmYYHR+SonH7taBRPvfaQUwCv3D4mrJ2l51GRZeYUp2jk2OLGsjXdTbHfAe21BfMKzhEcaH+bZlOnFrQ9yzZJbPAJ6cxVi0r0+Ib5zZE77Ei4aOA2sc/oRX7+4v88v0N651hVmrI7K+NdbYluuhA1vWZTXE4CwZ23Lspn/wEbZTZFHyZl2p4ZBM/fQuxYHjlENdlcFxJ/x1+He55kjXjZ3YgzC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38BsP+7pD3/99qAcpQ+0gD+B4WgTTCxPB16zu3wfwBU=;
 b=oUfSvaflbU09CcG3Tl4bHQsxR4piVnc9BAQNnACXKS+P8RqT7v2eUohQZpYmRI29b/IrrzwXevF1HHGx5BntqbIF97x3AGBGmqa3B4lOFDZCe6flrVB8E4+KmcAHhNyjEYiJ8oJfbrdKDIn+ij3/UClFWEx8kyf/yvfgbXZZaLarFaNIT8mIPhvMS/ccoSfb+jnz8kgZK8YQ/izu1a43YWwC2lATpANoF1enNEslcUYZ9xRrL03CaYBza9PfKBm5EFSbfcoQab8W33BaMwShJn8wAAd/hu46C5OZPmSXhbdCqcdy5cXmVNymwUM5nlR+zRi0aZ3H3CwnjU0DFLhFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38BsP+7pD3/99qAcpQ+0gD+B4WgTTCxPB16zu3wfwBU=;
 b=LpI2XBvahO7YdylCARbaCcPyWRFJTaYUwcr0w1uhP0U3fh5QCo7h29WSefIC2x4CHqd4T0cZ8Rag037l6+UO8mXdB8mIoKNQ01kwYzJWgvy78+fbgsO7Zb/hnLClZ2h5bLj0bzqRrFfLpIAEOJn7EIK3J4FYZ/RhVbd9JSaorto=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB7008.namprd10.prod.outlook.com (2603:10b6:510:287::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 14:58:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 14:58:46 +0000
Date: Mon, 22 Jul 2024 15:58:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v5 19/21] ipc/shm, mm: Drop do_vma_munmap()
Message-ID: <a3d9af1d-8b3f-45cf-a188-47405797cb49@lucifer.local>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
 <20240717200709.1552558-20-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717200709.1552558-20-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO2P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: d855a1ad-9728-4375-c7d1-08dcaa5ec950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m/iuOkzY5Nr/XHRSaZ9Dpoz5Og0B1dJUoU6onxEoFv+g+hxNZYm4FHbqLJZ5?=
 =?us-ascii?Q?LXMp9L2PsbhxyGHVM7pPUW6r9ZNzb8RuCQKZbYO15RvCLEzB16JfNHbuYxaB?=
 =?us-ascii?Q?QZyqoI1/qWTRyg5R7DsW/LiHdnQzauauA5EbWGT6jrT4eVuYVVVhWZvYBQVZ?=
 =?us-ascii?Q?KL5eScIF2pBFnVB7JVv32ecEC1hmHp7Q52lH9MzPJiUr4dMj0NjMe4RkRDP0?=
 =?us-ascii?Q?DCgSbFumKxQe7SGGHDK8HtH/GR9MRhY23Csh5mQuQRO7r2rTfwbqlIAB6vMA?=
 =?us-ascii?Q?Tuqda6d6eMDvPUyoM6gzJ9NJHPgGdap1yrNuvCE/+qpZkH4CU4/EpvLYHY+3?=
 =?us-ascii?Q?R2GMliAmLKywGtRByBzcLyfuoRwb6HJgN2thfXc4Sbxi3RgeCqat5iz7lRg9?=
 =?us-ascii?Q?dbKXGEf6WNBoIfqyzvqWiUUbVgfzOgLhI+W8hw+eX5kfQiPtnpkHOOaOEMPA?=
 =?us-ascii?Q?jIaV8p3Cb8CATwRYLPPOwWGB/Vh54456FNtMD/+gQ2Xdz6sUxss7EQ5iB/By?=
 =?us-ascii?Q?3/7YJgkC1ILEF4QDumSGQpiPuQPJnNFJ6uayo/L+WgXvRbQpK6FU/oL6AqNH?=
 =?us-ascii?Q?flXQGejcr16adiNEO67UJCkB+ozHL8Po2iDTSSZbOBSJjqFnr++taHcj68DX?=
 =?us-ascii?Q?zYCcnN5deZ2sIcBKcLW5mAMY0ZTJbwoxrKTNnbmMjqWlbA6AylxuTDzTmLQp?=
 =?us-ascii?Q?mT36LC2bfa6iDv4+uZD1IXPNqSJH0Ew22oPgXS1Dmkeb2dJ8z0WOgwhjhXYQ?=
 =?us-ascii?Q?EFoaetJ6S070KBccOKTV7fhs6NLXGycWfxWLEcBktAsuFNFJrChuwVZfmad1?=
 =?us-ascii?Q?pihryLtEVDEQKb4oTVE02dJ6Pyd60vhqdVqC0in4jYs0/Zk5oIpRBGfDqVKc?=
 =?us-ascii?Q?+j5MNyZDOCJj94UNjgquk8SPP0lDgoJXcdr/b1tbcZzt0gZv1AQZNwV/kFGJ?=
 =?us-ascii?Q?rRLlfCOEbQmHUz5pzYqTVwZPY0W0n4vbD1qb1Rl13bPqjRixNClZ99nfVgRg?=
 =?us-ascii?Q?OcfE/tcyIQcy5GBvQmGnOoz45vWEjIkJggyidOdpiSpye9VCw/uGK1hLbI2r?=
 =?us-ascii?Q?okj0BZ0U9wkV8/Gc626/9C8kKgQUgAwkbxxeTzFXb4gV56WXYZV57u/IIoYL?=
 =?us-ascii?Q?rqymdp4TcvIkZUHNgiizr/4nx7SP1dsrOzY6Ii7CgaVpXvJw9/zv0CkQd6su?=
 =?us-ascii?Q?x7YobCxSxtstwL4hE8bo4CncSLtKshNEW23gsH1fB482c3iaaMPSIWWIjl7l?=
 =?us-ascii?Q?XWim3+DBstu/Wd8lrK4ZEoCMqsG/mmkmD4FxtczEl9ApMFNeFBzxFirWbIfG?=
 =?us-ascii?Q?balQNphUmjxr9zEB50sgf/4MVb7ON31iQq658wVw7cQvJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVDc4jrZ+V9cAwT73jyGx6Cz/b2TRR0ckOhpIP/QuOFdhlxrjoQwgeYsk0Z+?=
 =?us-ascii?Q?sRxI3xVjeZuEVMEbuRrG8zkMsXFBTgflnmKcZSpbJOTzNJqIe3bud2j5SdnT?=
 =?us-ascii?Q?YDivs/ciuwAU4vT+UOkJGrO7TSMI4qv9yTX3yRDXK4vHr5MHM/+ZaLo/ANQP?=
 =?us-ascii?Q?m4oNQojjkLv9LdCRoDgNxy0pbMPNm7S/ytPjmdg+12Szk87FnJGlnFxHFcAp?=
 =?us-ascii?Q?kzCRo4rTp0RGQJCVLvdgcPpG7M4mX9ScaQSxkSLAV055r+Ob3XjCZ30JfmJJ?=
 =?us-ascii?Q?Av7C/LOHHM1stHwxBQuSkD1IsrS9iSvtiscjSiCIXGOVpfwzFr5gdGXuXI52?=
 =?us-ascii?Q?8AiO/Jf8A+eOqLmLLFq4GdwwVpibtEmlRoePZ+pDoIJwNP/GxPatwiHa856U?=
 =?us-ascii?Q?dCAUoDWNIE/wutc1Al57tJ3jt+cVK4fuGONie8EQ6iGjMXAbJGKZiYbuEF2O?=
 =?us-ascii?Q?81uvBB5NgdsaPpinlk6r0OsCdeH/LOuUmuu9uCLcc4dcvke5BN61nHqWHqO9?=
 =?us-ascii?Q?LomSoaup+k++Lahig/7C1Ux6XhxcmsAI38cKD9gzqYdCjzF25v1DE+GrlbTd?=
 =?us-ascii?Q?DRXyS186xxzyvBIcSjxvQZJrIRVxxavbj4vOvfYkQkZ2e6PTitEHNEuIwpWO?=
 =?us-ascii?Q?3jgiWE7znsI1+iYCutA+hmJwzvRfWeb4enSkLnXLG4FaNXiPKLqMJRK6SeQC?=
 =?us-ascii?Q?xJTkUlrqoCzZY27LIy8n/O9UQIVnwhG+52waTz9b3jTt1gmCqcs7LgMqugJi?=
 =?us-ascii?Q?NxOwPassuy8KFG6f/dYxm4rllunWX1svsG9JjPTlkWlouZCPsmzVRgA1c9l+?=
 =?us-ascii?Q?pJA3iL72OMDiOQKPuUpo2t7fxVc29M5s5mZlGLKrCf2M8+8VaQWJ+HBnreXn?=
 =?us-ascii?Q?qIZZpM6U7gpOIRbaUKkBw4HhEb8dRFy0rYtzv+95m2zENdRPmJtUOYGcLnj8?=
 =?us-ascii?Q?o7w0sAKy5r1LShkRN1lQ8lo4X6GTe0B0BSgLOjenzrNQE1YhgzZsty0SYT9D?=
 =?us-ascii?Q?B0PCyd6zQbHmTmJ+WiSUIQwu7oZMs+2WAkDIFcGG1kpm1ClZPJp8KXWHuolE?=
 =?us-ascii?Q?aK0Yvgh+vD0imVJvfTPkpOg3ZLKMM/3hI8WdC6NW55Y1hpZEIvM3f8bzWRhn?=
 =?us-ascii?Q?I40hjo2Az9fY32sjM7U94xJsXYrs6mzfwMlR1BnxJL67UMOZwQraVGBTkUPT?=
 =?us-ascii?Q?3lYqunDXiJhUCQ9zLUTT7UbFkd11b9M2vMnGru3hPmSKbrx3iYDi6NUBLDhm?=
 =?us-ascii?Q?vPAKFPPeQEI11PvlnKiZoxh3hX/f89g1IT/LYgctXAq/zqL9+dlxca6KyFCz?=
 =?us-ascii?Q?tCG4kRI3gmlB8i/XFDn3IGKh4BsT9wHiQT4cNHKISYMjh7WE5ai6VI9hwn9w?=
 =?us-ascii?Q?C/v7G0wxSYgsFMA+uc6xKYKRWrV3xCKzYT/Qc9FvN2u+2bBnD00qm07HcdeY?=
 =?us-ascii?Q?2XxK7Nxe9xQJsxdCIKQuH9uSVoCDz7P/KIHVSrpyTgJ9sYl7ET08IL6soYcB?=
 =?us-ascii?Q?KCOxUUf2LIerrvUGHe1YaEEGPSleFAa2TILvHlAzTLT3Uu4bLHnF8WBStCm+?=
 =?us-ascii?Q?YskKJjjMGQ4/MDIUXa66hGvJR+khSUuuA+RJ2dvKqCSuNrufU8uIepHVanQw?=
 =?us-ascii?Q?0CW/EgtRMDbHG1fY+9teFDJGnwY6J3+xstUPRvlzeHC80H7wUWmsCwUbSkWk?=
 =?us-ascii?Q?PbxiuQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PMqzadbc2mJDXdA6OAGeoQgbo/iu3UZ/7bT1ScbFBdvEU4SyVvP350bPIOj5AVQsVKAYhK6uhmKTUnJ4S9aqKVqQZZcjDFDcp7dxM3j4TZx5pX9+mHEE3w3W0I6U5BoOxnbsUAag6G0dGOCUpYdYGmXKEqFscmt6c/CINzjd00beXIW0S9QnxXBZN+A9eK0hEQXhB5zmV2rDdGHAJGcpnG9/gCnZjpYI6hOUmU/K4i73RVu73RsrpmO3gJoJpYZtj/ugaYcuH5vb+sbo7UUUBmOzFDGQb0oTO5jvRLbYIdeLTiHFk6tSsDxUyjLZgw4ATIWuDWqlZsP54O3uAjhZBg6sQyOph67C5pG1WpzMEdo72zCHREY1uUxCDj2B7zCHaKJoS98aNgW/u3B4+YjuSsrez+LkmWeHfxeXSH7IlAQ68hSWUaVaezdjjTUAcVyGSKEgVWm73Ms4QCcSNKr6xd2gkl+juYA6kTcGxEJBLlV+9ls7dxopAkd8Me11rfg0783yfUFNM6xBVZeVl3aqa2lTHQkj2HuUAxTLAQ/FmF4BhOBWrgxf38AilSDPBVEwq/f+j+X9Fh86YoOy+GxxrUf93VNblQrqF3hb1DDXKXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d855a1ad-9728-4375-c7d1-08dcaa5ec950
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:58:46.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8bHChVksOJIgUPgg3NKw93slbLFmdHtvQxYjIEh95V+snpNAuzfC1LwPalXhQp0322a2Td6tZGlYVAQv/4elX6GRbFgPAR6IZ1aRwm7c2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220112
X-Proofpoint-GUID: RznSsCIxZ34Sd9InMFVqAmXn3XqExs2V
X-Proofpoint-ORIG-GUID: RznSsCIxZ34Sd9InMFVqAmXn3XqExs2V

On Wed, Jul 17, 2024 at 04:07:07PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The do_vma_munmap() wrapper existed for callers that didn't have a vma
> iterator and needed to check the vma mseal status prior to calling the
> underlying munmap().  All callers now use a vma iterator and since the
> mseal check of can_modify_mm() has been moved to do_vmi_align_munmap()
> and the vmas are aligned, this function can just be called instead.
>
> do_vmi_align_munmap() can no longer be static as ipc/shm is using it and
> it is exported via the mm.h header.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  include/linux/mm.h |  6 +++---
>  ipc/shm.c          |  8 ++++----
>  mm/mmap.c          | 33 +++++----------------------------
>  3 files changed, 12 insertions(+), 35 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5f1075d19600..49a24c023153 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3406,14 +3406,14 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
>  extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  			 unsigned long start, size_t len, struct list_head *uf,
>  			 bool unlock);
> +extern int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +		    struct mm_struct *mm, unsigned long start,
> +		    unsigned long end, struct list_head *uf, bool unlock);

Going to give the same nit as Vlasta gave to me ;) which is that I believe
there's an unwritten rule that we drop the superfluous extern as we go
here.

Obviously this is not very important! :)

>  extern int do_munmap(struct mm_struct *, unsigned long, size_t,
>  		     struct list_head *uf);
>  extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
>
>  #ifdef CONFIG_MMU
> -extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -			 unsigned long start, unsigned long end,
> -			 struct list_head *uf, bool unlock);
>  extern int __mm_populate(unsigned long addr, unsigned long len,
>  			 int ignore_errors);
>  static inline void mm_populate(unsigned long addr, unsigned long len)
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 3e3071252dac..99564c870084 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -1778,8 +1778,8 @@ long ksys_shmdt(char __user *shmaddr)
>  			 */
>  			file = vma->vm_file;
>  			size = i_size_read(file_inode(vma->vm_file));
> -			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
> -				      NULL, false);
> +			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
> +					    vma->vm_end, NULL, false);
>  			/*
>  			 * We discovered the size of the shm segment, so
>  			 * break out of here and fall through to the next
> @@ -1803,8 +1803,8 @@ long ksys_shmdt(char __user *shmaddr)
>  		if ((vma->vm_ops == &shm_vm_ops) &&
>  		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
>  		    (vma->vm_file == file)) {
> -			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
> -				      NULL, false);
> +			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
> +					    vma->vm_end, NULL, false);
>  		}
>
>  		vma = vma_next(&vmi);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a32f545d3987..ca752317adef 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -269,11 +269,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  			goto out; /* mapping intersects with an existing non-brk vma. */
>  		/*
>  		 * mm->brk must be protected by write mmap_lock.
> -		 * do_vma_munmap() will drop the lock on success,  so update it
> -		 * before calling do_vma_munmap().
> +		 * do_vmi_align_munmap() will drop the lock on success,  so
> +		 * update it before calling do_vma_munmap().
>  		 */
>  		mm->brk = brk;
> -		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
> +		if (do_vmi_align_munmap(&vmi, brkvma, mm, newbrk, oldbrk, &uf,
> +					/* unlock = */ true))
>  			goto out;
>
>  		goto success_unlocked;
> @@ -2865,7 +2866,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>   * Return: 0 on success and drops the lock if so directed, error and leaves the
>   * lock held otherwise.
>   */
> -static int
> +int
>  do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		    struct mm_struct *mm, unsigned long start,
>  		    unsigned long end, struct list_head *uf, bool unlock)
> @@ -3348,30 +3349,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	return ret;
>  }
>
> -/*
> - * do_vma_munmap() - Unmap a full or partial vma.
> - * @vmi: The vma iterator pointing at the vma
> - * @vma: The first vma to be munmapped
> - * @start: the start of the address to unmap
> - * @end: The end of the address to unmap
> - * @uf: The userfaultfd list_head
> - * @unlock: Drop the lock on success
> - *
> - * unmaps a VMA mapping when the vma iterator is already in position.
> - * Does not handle alignment.
> - *
> - * Return: 0 on success drops the lock of so directed, error on failure and will
> - * still hold the lock.
> - */
> -int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		unsigned long start, unsigned long end, struct list_head *uf,
> -		bool unlock)
> -{
> -	struct mm_struct *mm = vma->vm_mm;
> -
> -	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> -}
> -
>  /*
>   * do_brk_flags() - Increase the brk vma if the flags match.
>   * @vmi: The vma iterator
> --
> 2.43.0
>

This is a nice cleanup. LGTM,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

