Return-Path: <linux-kernel+bounces-556174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0CA5C1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA806188DC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290C38384;
	Tue, 11 Mar 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qo4NpkGR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LBw5bjQR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49382629C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698471; cv=fail; b=WpGCZCcBwuIbpLsH+UdTtLnDzNHWXIttHw7IonaQJcu/x7xi9u0Fj2Bdyf+/d2zzD7qqMZXA9N32xjwji/YlETOf7Y+6Z6fOe+mo995Qigyn098GoKP6jefz8CwyEuvVUJPDIgANviNWTfNiDHqBZoliGO/7YYGUTHddEJoEC5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698471; c=relaxed/simple;
	bh=fWQQKeZuP+Vx0vp+qgPcZpzdsHgItSMTH9tMbc4aL7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r2O7WxQp6NGRjXUtt+OBN11Wcw0ZOlHGZuZjezm7y7gTYPxnPWxf+0SuNST7d3dx48hITGJDEvELnffaLbgMYfdiMqu+YttjgwHo6KbvQakZeS3dlaW6U996nawxxteLrqZHNpNCMN/nqF1sziklkw75joF+sU5kX9MKKVjus5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qo4NpkGR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LBw5bjQR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fukV015707;
	Tue, 11 Mar 2025 13:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=HmJ6cO/2/c1YbrXgcZ
	qPFgA7JBDOzjAHJI7BmCpJOMA=; b=Qo4NpkGREoJskDeSyxDxDgsnvuBSouXLww
	uJFU2GlB6D1o+wD1FDZ6aRw5lF0LQMwXinO8B3iQEm4pLbVQEFDdptRpI7lxLQPr
	TW1qbMRd3cuP4h0FjU9MCZiS6SRrrXJe81KMuu2O3IaogeZFfxc3X36tSiUJgz4o
	187oklab7YWIZuVrt8I753GSA4mSUNzjGC6nkn5qyvZLPwfKQ9SsYoFn0aJffdf9
	by1IdP4i4NrxtTJmZj4GcUY5qF9xz+R0VntdlRaGvxXpHeZFxH5ym+e6GN+Mey5U
	aYb6wimxvabmBCYPXoMBXFf8gPJjaSQF06Nz5g1r34ECW3WCUbDg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb4v6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:07:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCh6BO014999;
	Tue, 11 Mar 2025 13:07:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbf9ccy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/pYfe+h1XhFyxJgiV3AWwfh+i/Py7g0gYk/VvE/6cc258yctic2OKQr4Nhf7uEJbYw3yb3/oQfsXv/VA/6fiTFwvWr4vj1kiEvDvCZ/2pZ+NlDsqAOJsgKEgqWhpy8ZsFJMlyz4HTr2lDU7tVrxy9MUF0bGPQPtkwZWnEdR4HJSbrdHN1JDem16VzqzfWWQJtLwQqNiF8TfigouOl4UypuStALFiKzbIPiZZUamiWtFpPQZdhCcIDtlK5vROfTZt3mvAUAXX/p3B+wvDXWUMb220i1R8olAuGkS8JajmO+K2YMQXC2+u/EOj4TwqzTB3HF5PB3X3JP76IIaB65lnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmJ6cO/2/c1YbrXgcZqPFgA7JBDOzjAHJI7BmCpJOMA=;
 b=BL7UEhH+p7oLbgCQxNgYC/e85T9YyCA+SyHGkwWE5oe8jdjBfUsaoSCsXd1CD1H1M0D+wayOVpTZbQZzTEeqUQ55oEKmAKedmBMrkDIYhLxWf4gi0WSpboI812J/H00tguZEUMa2iOzSDdij5i8ABwQWZXF5QZSKlOoj9d/4MAkLHDC8Y8npSPfEiySKXwV8yRRv4HaZ9F6aHXdDPPGDeRxuM8te8z2gBCqju65vxMwspjexz9w3DlxSvKCckET/5BiHW4vijiWpEsTUaBOuMzyeTyKAdMtDmCJT0FRe9Elohd08gjVEfoDqWav7x1TY2NPgdqtqwpgxx9iZtX3Q3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmJ6cO/2/c1YbrXgcZqPFgA7JBDOzjAHJI7BmCpJOMA=;
 b=LBw5bjQRF1w/+iahMKQtPh6Cz8L9cvk1y2WLssYs1UZ84HcPos0kW+wtWGqcCvXO/AtWrDhRgJL+BilYexs+vadgVetKbV5r6oyecMmeETafVQJdptZrj9FfNGBTJwCP9z54+fCkMx5P/7ljxfOwAa7uYde4efYpw9na+EO37Ls=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SA2PR10MB4635.namprd10.prod.outlook.com (2603:10b6:806:fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Tue, 11 Mar
 2025 13:07:27 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 13:07:27 +0000
Date: Tue, 11 Mar 2025 13:07:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 7/9] mm/madvise: let madvise_{dontneed,free}_single_vma()
 caller batches tlb flushes
Message-ID: <e55c43a1-55de-4720-9177-8af08c797d17@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310172318.653630-8-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-8-sj@kernel.org>
X-ClientProxiedBy: LO4P265CA0232.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::14) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SA2PR10MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c77a863-a189-46e8-2a33-08dd609dac76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y0iWpfs8FPuZFX3lj2VNt/+v2tiMuRiys3CVVFDs1CqzW4m/K1iBvfLhIa2Z?=
 =?us-ascii?Q?PoKKlv95k1LvUyN1MSJttBqLfv1/Ah653Fia2d9HObigH+PGKmRv5aCmmlbY?=
 =?us-ascii?Q?15Gazk4TnciPnx+w6dvSFqdJBHDfb/YBb7AOORf9SWvmyEbiHgArvnku6Skc?=
 =?us-ascii?Q?Zl1/Ja6FlDX7/2NoWZgK4yYIkPXRxHs4+xlCm0o13KTZmzSd0EfRdqbpp4EN?=
 =?us-ascii?Q?sfTn9PL/CkOrgNbLzJXP4EfOmCnetXchLYubBAxb1Z69+r3kfTgsxwTQKZmO?=
 =?us-ascii?Q?2TYI1KeAdZRF52cKcqakXeSt4yIlcgzgxm/W/JmzaED2FDrIX4nMG3R8QPdx?=
 =?us-ascii?Q?wPxfyrxrG2ihRKF/DF5IogCygI8+VT4389rcWkgqNa04DumNd+M5zgptMO3s?=
 =?us-ascii?Q?k009nj+6y5oiZirW0fSAXPlKkCFiQp6I8PxMMkKCpu+270k38GT1c4bv/+Fd?=
 =?us-ascii?Q?yWRLUNt0i29v2pNYDZBNKJuKmm/GVXjhDuzhqMtZIQBXdM+SbuNbHiYhBL8G?=
 =?us-ascii?Q?B25NTljL/8KHqYnJr6p8Z20u05ZbiBvlXbcKzp3SCcB1nMe8txgg4br+yNLt?=
 =?us-ascii?Q?8qt9pANeveWwhsX66BlThwzaMf/OxtMLpbP1PbXQ/wEfo5wyyY1ryUKBSa3z?=
 =?us-ascii?Q?Gqw/c8vxIw/RSowkaqEke5ef9vlUessHrZ05uvSTvWG0sEYDEQJcI6er7opq?=
 =?us-ascii?Q?jO0FjWsLTC93VKOCvohb8EzgxojTuEFujqOUoODDg/7XBTwFj6pn/vmqC/Z9?=
 =?us-ascii?Q?A6Nzlrt5U4OEabOkjtKZsXRY6I+7SiHHZdbG0ML/FOsqwueJoC/H/FFOUHvQ?=
 =?us-ascii?Q?EtPuGE8Bh0gtp0ulpPXwK/QsBuZcZ2xnUhDPApNsRz4CY/Q8VsFdnPCbE7eE?=
 =?us-ascii?Q?frgsWE8UfqXHVien+DSZVV1CN49Ob5DbyQVHo1uMjxfFqqAfcG56Oa1oIb1e?=
 =?us-ascii?Q?J8nl6yXzwoeDgAHe/iZ+OoiUNrjeaszk6MZ5qnEWgfJJGUi65dcRjFl5643k?=
 =?us-ascii?Q?9ySl2gy7vsHpIJyM2ONeuGsiUqqExnQmdwK35g7UbGMNQOrN3xOAelG0o194?=
 =?us-ascii?Q?btO5i3ONpaPY+j5uT44x+RnF7KdQrIrIHZjWPRKOtQ+ElLU+VZ3CU3HlSOQA?=
 =?us-ascii?Q?Ue2tP4l2DRlZU9Nx7WUl+xB6ti+yO4mYZeLU9QH2MdNPe2jVXDJx6lCTkVLN?=
 =?us-ascii?Q?7rQfpekIgcsT+iQX2kzc1sg3zV0DxkRAcv1RZaEpruCxbG8eRdRgDpBUKKLW?=
 =?us-ascii?Q?xerc/mFO9DX4E6iWGRmy6KXrWZNa6QfD5NzJIFEcCFkd55ZpRDYdXrDHRhJ2?=
 =?us-ascii?Q?kJ2DQwIVPM8wjIollgp3BXVgy1QSm7yCPK8Uli3I9NzPRiw2t2A6ogJquMXY?=
 =?us-ascii?Q?AHchKYXIbJ3odfKKNAscmmORqlC2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qlzBEmNuxNau8AjH3YPNQVaagtjpVNkJ3kLbgqB0hX6LdUkoLUmBtUU95zO/?=
 =?us-ascii?Q?IesuLcQ+fFqTcS/TCX8mEmaEkhDRmRSWKdEFxRhxQ7g1IEwNz7lCLrzEgJQf?=
 =?us-ascii?Q?AJ0h06lEeAQHBn25g3iHHVzYoFEa+y2Z+Rm6M4gQeygGQSer0zwtAoEgaklY?=
 =?us-ascii?Q?PjKzPwLdjEQXEhvoM8inhEB+FySFz0CIR3KgCUyB6cy/+O6bvjc3ITwQw0mk?=
 =?us-ascii?Q?PR9AOsgYQWnxd2TxpTYpbGi8FP6TqZu+sR+8OtAPzmEAoIX9ttQJ0Cs6Bpoh?=
 =?us-ascii?Q?FTkHvPBIjVFhmuFt9t+1VvfKw2Wc1N/v1PSw/Q1Ce6nipZDZ9096z6XXFpn7?=
 =?us-ascii?Q?X5izjpaBSDJCyyZ8YKfXbpWE14hGh7t8DWm5N4juzkiesWscGTjOiUHGq7yq?=
 =?us-ascii?Q?334qU6awpsgigPL9OZTZGxdVU/N84LNI4Le1gEvldAtqtICutDK//9Lm98x5?=
 =?us-ascii?Q?Xc982gPkPMpavpPL/PnJaY2sp+bAN8LG5fjy+kmwPyKtffRSW9LGHz/PPvTi?=
 =?us-ascii?Q?0ONt1IHB9BODzVSx9RkejbphVTcMOyux5zmcDdcEWfG+Gli3InrEoZpHDgam?=
 =?us-ascii?Q?cwNIIZEKh4GXGgkpHx2RwEqO5u0h++QSHUlQGWQHpWNduaglO8xUM6OQOLjC?=
 =?us-ascii?Q?JNqJrd8phsG3YcKktsM3R+Rdse54JpHgtquwSKcz49MoEbSwp2JQWGjNakdW?=
 =?us-ascii?Q?B9OL4BX3GWajBye265oaVo/D6qDmM5q0dZNFBFninE4hCggwse8OOFhbtgpr?=
 =?us-ascii?Q?FDCU7wmhj4Q2M4bAMJ7XXN81nrJPYRVDLh2vVQ07wWN58XkU6GMe84lYkXkC?=
 =?us-ascii?Q?jtfA++xJaejSZBbv5Ixm5bLtWMGV4zfT0M4a0KRGR70wFxCUt81ei4HyblKJ?=
 =?us-ascii?Q?OtaXtNGXMLQ6HXJrOC1Uyuxrqbv40cqWfY7BxZOPdc6CUHy8JXgYpB2b37Ca?=
 =?us-ascii?Q?uD2tCMEt4PdrpMllwehvovcCsEIXQUIaalwIC8LFWN+kzAJ4HB+ZqtL331qH?=
 =?us-ascii?Q?TBehYusVj5/0WVRgOxvMsDRPtB8e66aRzn6w6kPeTnRk6JmZxREJqW37/Wcf?=
 =?us-ascii?Q?7fXVsB8EmzbbTaSiJt797+hW67iQhIQDmExJeW9Qm1ZxtVXmO7CNNdbw0N3K?=
 =?us-ascii?Q?su9JAlfCIRjcDU2p2cjODQPakff8MUbivQpYJ63cUZQfmikl1On2k+yDtk6W?=
 =?us-ascii?Q?TR5ckTYBhF7BkmKF8v5F214u8E/qSfvEgTzlfkiOptUhyCHXPIfRkQBDLb5y?=
 =?us-ascii?Q?C/w3tThkgSQ3o199ZlFeg5O1La2cp/k+jDq64UoTtSj0gueyGhvCLFniBkXu?=
 =?us-ascii?Q?FCB+ncimG6wGMvgXzW/IJ27NR1PEnFJZSoKsCm6bfMGEWrMl1UJz+rIpUeRS?=
 =?us-ascii?Q?eOXpZ1e2mURybosTjFrMRxFDldXABpOIWy2WWCxjdPSv2IHzMd9DL5Fhydfy?=
 =?us-ascii?Q?RbNSYK3Ge+xPOS6WDSihSAO6omD0yviIpVXPPxrMbMmuyOdy2LQ/q+3C78Jm?=
 =?us-ascii?Q?ALtzSiZN8qeG2yeHsjRBj3Y+SF1YDnUdT9BLnV8c84rj1KlnuqAx3BhLIQUk?=
 =?us-ascii?Q?lVBMZwMGT8CiBXWloMKByHiymKKETNj6rD4KpRYd5gC3hZ2CNrbJeeHWwUJ7?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/hfpuMOwnEJDmlR/EjXzZGz8vRUni9g/06ckaLA7nQW4WnD4gxl/cj3n7u+0tMf7XS5fliw/7BiDnbgM6NeRvL3NpwAEB+i+eJ6/KDusv2QZqpytH4c7FAIWe5BadMgIblaH+9bLElQOd2DfCGmGDhHimkfqaU4UKoblMW4kttwIeXcCvKtErL+MKJbXOZVqztwrbm3SFg113Dd2KrnJR/scn87nmonJzho1LMFuLwD6KZCWlLQ8oKL8NhBhR/0irICEdO2GOVBIdYQ2c5aqKvwYPBO0zCQvqdRIsbZp4S3rWEmIyC5ZxkGztOszAfxx2jI4PUGz7hJYs3mExZqwIqVkKmp+iUVMWOZ5bdLxjSDWTI8wVmWxByUOdfB8QgLePLllCc9kM//ufkDrScfiKNbMdWO6uwk0QXXG43hE0nKXCJH65hr1sFh8Uhh02veeC0nJdbn4h9SUjqbd5IDBLQ+juFGEC+0Vj1ETRLQMt7eBFpo7r1hzbfA/gw5InZ8SRHz4iPuivBwl9iNyQHjF4uk/CDP7sMYoTVEtzfXvIpp8vmEOj5FqkM/KBakFWtDFUVJM2NUOPGH5N05zJ/Z8On3KkrEE8P9z4RX/7gCatlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c77a863-a189-46e8-2a33-08dd609dac76
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 13:07:27.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVBV8u6Up6DHntJjdpYYotB2/0F6B6OzZlgPgDdrhFtK+YlkcJRePPmmZTdcmzforAjBjfEf1Gqh2nHKCYe6J6pkXEjE48PDUL0FdbYdH/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110084
X-Proofpoint-GUID: MerAMc1qYBWT8kPzk1Co6BZHuFuTBKJw
X-Proofpoint-ORIG-GUID: MerAMc1qYBWT8kPzk1Co6BZHuFuTBKJw

Super super UBER nitty but... pretty sure the subject here should be <= 75
chars right? :P

On Mon, Mar 10, 2025 at 10:23:16AM -0700, SeongJae Park wrote:
> Update madvise_dontneed_single_vma() and madvise_free_single_vma()
> functions so that the caller can pass an mmu_gather object that should
> be initialized and will be finished outside, for batched tlb flushes.
> Also modify their internal code to support such usage by skipping the
> initialization and finishing of self-allocated mmu_gather object if it
> received a valid mmu_gather object.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/internal.h |  3 +++
>  mm/madvise.c  | 37 +++++++++++++++++++++++++------------
>  mm/memory.c   | 16 +++++++++++++---
>  3 files changed, 41 insertions(+), 15 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 0caa64dc2cb7..ce7fb2383f65 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -438,6 +438,9 @@ void unmap_page_range(struct mmu_gather *tlb,
>  			     struct vm_area_struct *vma,
>  			     unsigned long addr, unsigned long end,
>  			     struct zap_details *details);
> +void unmap_vma_single(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		      unsigned long addr, unsigned long size,
> +		      struct zap_details *details);
>  int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  			   gfp_t gfp);
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index ba2a78795207..d7ea71c6422c 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -794,12 +794,19 @@ static const struct mm_walk_ops madvise_free_walk_ops = {
>  	.walk_lock		= PGWALK_RDLOCK,
>  };
>
> -static int madvise_free_single_vma(struct vm_area_struct *vma,
> -			unsigned long start_addr, unsigned long end_addr)
> +static int madvise_free_single_vma(
> +		struct mmu_gather *caller_tlb, struct vm_area_struct *vma,

I find this interface horrible, and super confusing. It's not clear at all
what's going on here.

Why not use your new helper struct to add a field you can thread through
here?

> +		unsigned long start_addr, unsigned long end_addr)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_notifier_range range;
> -	struct mmu_gather tlb;
> +	struct mmu_gather self_tlb;
> +	struct mmu_gather *tlb;
> +
> +	if (caller_tlb)
> +		tlb = caller_tlb;
> +	else
> +		tlb = &self_tlb;
>
>  	/* MADV_FREE works for only anon vma at the moment */
>  	if (!vma_is_anonymous(vma))
> @@ -815,16 +822,18 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
>  				range.start, range.end);
>
>  	lru_add_drain();
> -	tlb_gather_mmu(&tlb, mm);
> +	if (!caller_tlb)
> +		tlb_gather_mmu(tlb, mm);

Yeah really don't like this.

Ideally we'd abstract the mmu_gather struct to the helper struct (which I
see you do in a subsequent patch anyway) would be ideal if you could find a
way to make that work.

But if not, then:

if (behavior->batched_tlb)
	tlb_gather_mmu(&tlb, mm);

etc. etc.

Would work better.

>  	update_hiwater_rss(mm);
>
>  	mmu_notifier_invalidate_range_start(&range);
> -	tlb_start_vma(&tlb, vma);
> +	tlb_start_vma(tlb, vma);

Also not a fan of making tlb refer to a pointer now when before it
didn't... I mean that's more of a nit and maybe unavoidable, but still!

I mean yeah ok this is probably unavoidable, ignore.

>  	walk_page_range(vma->vm_mm, range.start, range.end,
> -			&madvise_free_walk_ops, &tlb);
> -	tlb_end_vma(&tlb, vma);
> +			&madvise_free_walk_ops, tlb);
> +	tlb_end_vma(tlb, vma);
>  	mmu_notifier_invalidate_range_end(&range);
> -	tlb_finish_mmu(&tlb);
> +	if (!caller_tlb)
> +		tlb_finish_mmu(tlb);
>
>  	return 0;
>  }
> @@ -848,7 +857,8 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
>   * An interface that causes the system to free clean pages and flush
>   * dirty pages is already available as msync(MS_INVALIDATE).
>   */
> -static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
> +static long madvise_dontneed_single_vma(struct mmu_gather *tlb,
> +					struct vm_area_struct *vma,
>  					unsigned long start, unsigned long end)
>  {
>  	struct zap_details details = {
> @@ -856,7 +866,10 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>  		.even_cows = true,
>  	};
>
> -	zap_page_range_single(vma, start, end - start, &details);
> +	if (!tlb)
> +		zap_page_range_single(vma, start, end - start, &details);

Please don't put the negation case first, it's confusing. Swap them!


> +	else
> +		unmap_vma_single(tlb, vma, start, end - start, &details);
>  	return 0;
>  }
>
> @@ -951,9 +964,9 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  	}
>
>  	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
> -		return madvise_dontneed_single_vma(vma, start, end);
> +		return madvise_dontneed_single_vma(NULL, vma, start, end);
>  	else if (behavior == MADV_FREE)
> -		return madvise_free_single_vma(vma, start, end);
> +		return madvise_free_single_vma(NULL, vma, start, end);

Not to labour the point, but this is also horrid, passing a mystery NULL
parameter first...

>  	else
>  		return -EINVAL;
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index 88c478e2ed1a..3256b9713cbd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1995,9 +1995,19 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>  	mmu_notifier_invalidate_range_end(&range);
>  }
>
> -static void unmap_vma_single(struct mmu_gather *tlb,
> -		struct vm_area_struct *vma, unsigned long address,
> -		unsigned long size, struct zap_details *details)
> +/**
> + * unmap_vma_single - remove user pages in a given range
> + * @tlb: pointer to the caller's struct mmu_gather
> + * @vma: vm_area_struct holding the applicable pages
> + * @address: starting address of the pages
> + * @size: number of bytes to remove
> + * @details: details of shared cache invalidation
> + *
> + * @tlb shouldn't be NULL.  The range must fit into one VMA.

Can we add some VM_WARN_ON[_ONCE]()'s for these conditions please?

Thanks for documenting!

> + */
> +void unmap_vma_single(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		      unsigned long address, unsigned long size,
> +		      struct zap_details *details)
>  {
>  	const unsigned long end = address + size;
>  	struct mmu_notifier_range range;
> --
> 2.39.5

