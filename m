Return-Path: <linux-kernel+bounces-263672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA0C93D8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3C21F2277F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D2C47A7C;
	Fri, 26 Jul 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="inWEQaWu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rLL6wCQF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAAE2E633
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021716; cv=fail; b=hdAXccRjSRnvypZfTIt9v8h4lV6UU7BTb+K3jfZbUpV7Yd9/+wvqI7zK38xYfmxq/jJNgxyOBzS+7L/zYWfD2qqUNwEdwoYhzh6sk6ojRDqQkAJpifIOQ3mXuYM2YILUfCY6sZEOreX3NiMb4VuLwkhs/JJ0ur+uJqpve6NSeMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021716; c=relaxed/simple;
	bh=o96F3fuzVi9/jD8tzWP4QAkhNFHme4yR6jAgtDzVsuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+d/2k8sQ41mZxIrB87O35KVn25lKOCW6L4trhscLU/PatIUE1nns89r/slgYctw/hiXNqx0q9mEQeswsh7y76FrdtC0P+P+DOOno4IEx7jiKtdzDzcQxhkPePBEBdjd6g4uLvgplWnb1rwXuLOTvT7VPR6UcfSCcPvpxge3HJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=inWEQaWu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rLL6wCQF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QI8n6x013822;
	Fri, 26 Jul 2024 19:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=bEkWlZQjeacD2zX
	xRON/M0s/LRhRmIu+RY6WYvnzAmk=; b=inWEQaWuLkg9VgNjTv72m79EhrWK9xP
	8gM7lNkPBVLvLOJWEVrl8TeFEVHCyHW/bBHf+fn86f2/S6AUchs1t8NohJiWFses
	mFSAEkFcExxZNoZ1qkGov9wyiH/4c82yiL/eAJVChbZkzcAWlOgwEGu6/WjZL3Ef
	u074b8lWQmd6LwfMuEszmYG3uZYHVGkDOlQGmk1sNq6HGhG5PY37f39wAQ42jqxh
	cMcqoUTtERyBZV8PcpU7QXgGneKrpew0CiE6bc8//9GiUlqG+tyiavcO8XLgKX35
	0sgwa/eOKcE5Sz4fvjy4YvYW2aH6WmjvlbBQx0kQsqs6Tq0/XTFLjzg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40k7yuvfc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 19:21:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QJ21Qo001392;
	Fri, 26 Jul 2024 19:21:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h26dy4km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 19:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Or2+u5YRZLJ5Ipc4y3YwoOxi34htKW/ksTTvHkCZGy6lhQjSA4yaKhtlTfPAKyFoBVkwzzTnsyCGGp7UBZd0SE6vTdr8YJO3DK5j9Jl1Bu5Ri64c7xbyCyJRlesqwLg0/PpisesAJkvMh9pT07HhRIPqrDW7EFUuLNI3b0bAh+omymB0AWGlsXZni0iQrZBBgySM6NarB8FesvT9qlf8LSYKgbUBzPA6ZX36WBfhLz57O9cdX7oYjHNsG4zfAwHC9PDMS9+QMMSGfgYszDlPOGCxY9mhNuZgJ5sJFiRCa5zWy/ffxOYyv7N44QvST8huF6HRniQ0ptIBNBauAS0o7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEkWlZQjeacD2zXxRON/M0s/LRhRmIu+RY6WYvnzAmk=;
 b=WOsovASpx+n2CwSDjedKzA6fyRUVrShoLMHohDsACY7opL+HIfxJHcalR6uCyFV34NsLxwabsJuakCBFTTSmyqQYWt3Qow0TikhYo1ZBUb678YoOEPcAWihADWw7RyjYR6EwZZnqq1UDI3fHK4NbNgqe8OFVo50WQ/NPK2o1vWOD21O0oEy3ZEuVjG/QcmnsqMTT9YVP2ycU0cb99NJYXs1Xk5bXacUd+DMOBtu7UzBFtFSh93cX5+d//hwlEDrqKVJtOVpO31vD6JLpXaTzvnI7hU4rX2Yh59m4CuLZOnHtuGab6+1VVuMLUZqjQph2hQ04j4AMxMeCXWabiplWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEkWlZQjeacD2zXxRON/M0s/LRhRmIu+RY6WYvnzAmk=;
 b=rLL6wCQFHaT/7lL2xF9UJM1AAmQwenxLjE+iRbZa+bKk3zj3RTWwYX0W4MRP+wBGqCPKo5SJDtEv8uVwpi2PZecMx6bZ/HeKb5oq3yJEqf6yNueIWdUUR4id9xCDocyEwPHfvqwfoz7OQhgQGiAfxD4KNlVQfpKvHx1puXGBres=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB4859.namprd10.prod.outlook.com (2603:10b6:610:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 19:21:34 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 19:21:34 +0000
Date: Fri, 26 Jul 2024 20:21:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
X-ClientProxiedBy: LO4P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: b353fa04-5c14-4667-ba0a-08dcada82983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MVuJsNaadxACGSWp8KTlg4wBIa9jAaOyZjOudYDHpxMUzJNzTB8Y6ky29uSw?=
 =?us-ascii?Q?SJd/2RaHYi8wGND65a3Cz4yUcQtPLfjy10d5ZIH673Lv/pX1QIlr+lE4j1HS?=
 =?us-ascii?Q?xNDrQcDsNZcQ47UyBL/wdB07rr+US8fV2Z6m11Ohn5eZuJNuObYQfOnRog7j?=
 =?us-ascii?Q?aIGSWoDbi+OwFcVj7epDz9fgybnyJkiMNwPkgurMJ7DJTCxgSIMEtNdJmv64?=
 =?us-ascii?Q?5ztKCKmQY3217kPAmh9Tfe2EyaBGgIaO8ZUuHPpPUbbnKBhOqPnanaZlrNj4?=
 =?us-ascii?Q?p7DGUeCls0RZZd46aA9Yve62x6KjbC0JjhmYWKgA6hGfZEJu+Qvr1A3IvZyT?=
 =?us-ascii?Q?4Tn/ipK0ohTy+FHjyEi7BbBhQCAfeCWifn9XlGa+tlOYoEUj2LFHAk5wjb/8?=
 =?us-ascii?Q?e+O5MBJbPcT1o0ZgDRbMGlhoyoT62rFh22rIH+YKb5I2cL+VcH8t8JumRVlo?=
 =?us-ascii?Q?dv8tNOywBJ+2P9nMUQ3TXWvG1I++ij/AsIChq3GaaJoW5QO9SYH9FTxDe2+O?=
 =?us-ascii?Q?/tzaQiMVVgeKEiAdWohlFvA5ZOR8ariYvt8IP6qlXR/G1v5sWHKzz9lpGV4a?=
 =?us-ascii?Q?uQDiVCm+hF+4QefyOamWFGOmoDjHbQ5hyOwTKbI+8Otc47WR9bNH+ZFPAkMZ?=
 =?us-ascii?Q?oMLpBjF4xx14+t5g3IouoLR4RO74NmLILGUFFaO3OAsSLqZMJBGG4JADILyo?=
 =?us-ascii?Q?01iMcJ+JkgmqlD2py7csV+CrYdVJlKx6mbJnevdH4AWU1FC8Lcm2K56EKIuE?=
 =?us-ascii?Q?cHQno1xtBYDQjRPA0I+Q0/GeXmmvScf5Qq7r6EqFpkeXlyClKr5VoNOWGup3?=
 =?us-ascii?Q?i0lObaophrvgMIIJrMiJ3Kk2XP0o2LGBhHXtW3lgZOC9JwpdHdiibATqrqYU?=
 =?us-ascii?Q?Tl6pnHZctlo6yW0ayvZWKE6WJrmTB5IUXXwvZFTSRN8rQHtVc2wnU7Gt8CbL?=
 =?us-ascii?Q?ONly3esZ/D/JzJA1jNCjMQWqavbw5oKthOUFO3i58iuckLmjQY98VV5hw+Y0?=
 =?us-ascii?Q?qb5Snl+EVBgs2zu9Q4BBFnAHvLFH7FFQcw+ouEJfnHgX91kLVnLOr+naj7Np?=
 =?us-ascii?Q?pkqJ0kxb6PEnXCLvq1DwBTCWTthxg7D3Pc1JQSaisn0eN1t7iH4lkIHukXNj?=
 =?us-ascii?Q?p+pOO/89l6CwCAYIVQtH7EZFGjKtx75eICgSSxIc3t4jOKHSV9Nl2GDLworr?=
 =?us-ascii?Q?ZGKPjjo2ztx53YOOx2F2vgUupbhJdnfforpYec90N+BhjBBHUf0+fnY786wu?=
 =?us-ascii?Q?SMJg/YflGikNeU0V5ae4tjIu6VyqSzIyYnmGvFGThEo0ZbPceJxkFAsL/25d?=
 =?us-ascii?Q?IHGWKRX4R9fTwIZVtplA4Z2nUF4GrdX06e9U8gl4814A9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7J/iW8ubI6O/KYm+l0rw1wuAteoeEyPo9JCQyn504NN9d/QNu1mBil2/IVMH?=
 =?us-ascii?Q?S8SIi3SqbR3nLdQvoaqW1j4jilN/sbOKq2vM/6SbEvWkIMPkICZQE7EL9Npz?=
 =?us-ascii?Q?0I3zyqbtSmPnVyVvrT0ZRofK5crLaQLkyAUOGX9YoSi3CdTDrOY9gXDy34Ed?=
 =?us-ascii?Q?hUWxxc3EhA9tMQmBrlSHIKAFeqklti7ONohdq6zuqfhX54TDy2kYyRENWDEt?=
 =?us-ascii?Q?M8H3Hnz72ED4QkIfKOAaaiBQg85zQcOAoqNKwwxvBdTq4x1Zf5RzLTdvGbin?=
 =?us-ascii?Q?IWXdH1HKcRIsD9MppT2HHWzYLvJGTIQw+YbYKPcVdIGOqUJJE2ZttB9moANO?=
 =?us-ascii?Q?sXvR4HrtxhQIoszutfVrIjndzN6+DrprFx1bTcuqVVrZgsJQIhOa5tXncnmB?=
 =?us-ascii?Q?U+D2Wej2MAIZZwbECLT0uuBDYDUG8+1IPghjmUX+gQqiSM7TuQDP9CoiMBrm?=
 =?us-ascii?Q?ucg3RhF/6wkPFGdBOCHjlYK6OxFP2KE2EcFPHbUL/mXxKqYHrWzCrTZLrhSW?=
 =?us-ascii?Q?z/pDJMHCo4RkP6W2DmR65pBCCqkjotaNHGeHlueNr6JkS9fol3u47+YoU7tc?=
 =?us-ascii?Q?yBe4LPifj3IUQSmYv+7rTRmM0MEuCgst2aBShtooxHqWuNwpuOMuD9f66SF/?=
 =?us-ascii?Q?bgfqjGkDP1u+k3c0QuSTeGfb5mWN4fBsWbxlkIuYrQskFOW0goBkT5VlTCCK?=
 =?us-ascii?Q?XikiyvJF1KwtcUOvmDwl+w4QUhoYCs7BbbfyUXk1fjUcHB/frEAEotnzSJKE?=
 =?us-ascii?Q?50xO9ER4+Nabmom4cInJdPGOWXaCgPAo6Z8ChLNxP9cFsgaK/IcUYlrNRRj8?=
 =?us-ascii?Q?TxwizcRVTImuLvb7nFLtaCTEhexZ0VglX2srjSp7YDnVHSQFSh4R/u8S0Kix?=
 =?us-ascii?Q?Xhrnw4tksZmsfSWV6Gpxn7kmVjdZydCGSu6wQVaTNUXZG1fmyVVCcBGhLyhc?=
 =?us-ascii?Q?NOEbioULQWsAxpHW8qg46VQbLZxbz7fbOPOKlDUEpqZAMChh8BKnK5g8Cn3A?=
 =?us-ascii?Q?RhLulPI1emoB4BA/+UK5JOlkV0B4aMEoeYVVPvWDDI1qxsnXSMhU4kSKrf3T?=
 =?us-ascii?Q?uu2pOe+E3LlyqeZN/VtotXsABu/5NIG4QyNbbuqXKSWKNn/cEZftfCOju9hl?=
 =?us-ascii?Q?DsIfC/C6fGl4DzN69v/D14IUPMwxb72ag9lowIImUMx/PAjFslY+eq3CrVPD?=
 =?us-ascii?Q?vePSBas8MNUmP5x2JEDzeo6L8puoYvWsrOCIjNDlLmPKMougy3sXtfn2jLIB?=
 =?us-ascii?Q?++Js1rgWs+39kqAhscwBDVgRsVjaJ/Arh+52zqiN+IsT8byv6k+SHq3xV6U3?=
 =?us-ascii?Q?0833+gojt/djuUGOXb0tfNav5SvWTG30+J4RUrLfAd+z3oyIaiWz6+Gzj66l?=
 =?us-ascii?Q?rWez7cMCpgGlmTgEDaOTkjMuiIepFBMbLM/UGJYP1+MVGQHXJn/EGhMSSy0K?=
 =?us-ascii?Q?J1XTLTdq9oiiIKP2TgDKRbdo/Je5sBH0n415wecVVDlqCYSEgDpfYt3tk5F7?=
 =?us-ascii?Q?aXwu8kNRaboI5WQUL4mS+EzSbiZl1gq0ESvkWZcu2EKIENTp+6X6QQRKuW3v?=
 =?us-ascii?Q?Gf0OaZuZCh5pylryr3ZP0Z+Sc/Fo2pNMKpJXdSKXdrPzhq58RH8JbBbLnMyJ?=
 =?us-ascii?Q?lHKbYIZzvlAtfpvhM55rjZ54/zxBtmCGNoPU7u2E6SFC4igZ4d5a/axYnH9r?=
 =?us-ascii?Q?zIur2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sKZqKnbok4a6dbABNHdVfkTmY4O2tXESH3lc68REh0TmHDqIFPQod4NJtm2xBnljOuUTnwAW1CqpIP18vaKzm+bKESfbYbnHVsbAv+hpaE7TPKwKH6SiO1pmPaoET0IePQ00I/5SM5enfWZt0B0Qk8aCza3TEF+TlobtBJkF/CwvW6HiYUeK2LHwInclU5AsUkDxd6RIPOkYrK1j42q4Gft2dkLIVt9RJUqzFZyEueOFdMmDnNRkjuJF1IOtZrHzP54AvtlEGD/29ce7GTstOMeyxyexois/neXlIoHmqZDyM/kliNvkOpJ3JWzb04MnEZ//VZQj8WXAGSUD7lV/t4YY9xSujzKrOEnb0WPgNNhKPDAtJTX4OsZ4xKh/8zgcVUKWJZVLiRWXz8TIQkDmw7AYPh/Km9dcjU7LeHNVSKGDhGoZD/IWkwKSKbVL+FNQ6wwthtgzdq8rKELc5Gk4hWTgn3FK9WJFtulzeu5CDIKymINgE05H6OtyScPVnTk1pAL2OV0jrcCl0crBZQTcbanck+1z0SHEjDPSgSJ7fbvqaFqx0rIzuIXyjbnmzYVd+tIV2PJL8FGvVh2cJvAEArTroRi7aHEUL3S74nZ5PGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b353fa04-5c14-4667-ba0a-08dcada82983
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 19:21:34.3516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W22pxriRdcjrQ9EKctWB01T1RUfwtIQqUJFagtpi2MrnWQKYjmoPo9G25OQh37jRQPJE2b8t1R5SHRlOh1Gq5ISKp9P4Hws1pxmaWeOmUfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260131
X-Proofpoint-GUID: ZpwGSo3x1XQ9SMDpRAC9ze6TZHZER18K
X-Proofpoint-ORIG-GUID: ZpwGSo3x1XQ9SMDpRAC9ze6TZHZER18K

On Fri, Jul 26, 2024 at 07:56:31PM GMT, Lorenzo Stoakes wrote:
> On Fri, Jul 26, 2024 at 11:24:09AM GMT, Linus Torvalds wrote:
> > On Fri, 26 Jul 2024 at 11:13, Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > 5,447,539       ./arch/x86/xen/setup.o.pre
> >
> > Can you perhaps do some kind of "max expansion" on all the
> > preprocessor files (you seem to have done it by changing the ".c.o"
> > rule to just spit it out as "o.pre", which sounds fine).
>
> Yeah I simply hacked in a gcc -E, ugly but effective, e.g. prepending
> cmd_cc_o_c in scripts/Makefile.build with:
>
> cmd_cc_o_c = $(CC) $(c_flags) -E $< > $@.pre; \
>
> (with credit to Arnd, who came up with a timing patch using a similar
> technique, I just super trivially adapted to do this instead).
>
> I therefore generate a bunch of .pre files, + run this to get total
> numbers:
>
> find . -iname '*.pre' -exec du -cb {} + | grep total$ | cut -f1 | paste -sd+ - | bc
>
> So I have the numbers for all of the files. Did you want me to post the
> numbers somewhere, or were you after someting cleverer, not sure what you
> mean by "max expansion"?
>
> >
> > For example, this trivial patch seems to fix the setup.c expansion by
> > about an order of magnitude (ie 50M -> 5M).
> >
> > Entirely untested, but looks ObviouslyCorrect(tm) to me.
> >
> >                      Linus
> >
> >                 Linus
>
> Yeah this has a big impact, with just this patch we go from 51,407,944 to
> 4,351,747 locally for me, so match your results.
>
> Patch looks obviously correct to me, I wonder if we should just apply that
> now and take out one of the worst offenders while we figure out how to fix
> the broader problem?
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> fwiw on that :)

A simple comparison pre-revert vs. post-revert gives some ideas for other
low-hanging fruit:

  389180./drivers/block/loop.o.pre
  409741./net/ipv4/tcp_output.o.pre
  462230./net/ipv4/tcp_input.o.pre
  470714./mm/page_alloc.o.pre
  570698./block/bio.o.pre
  600206./net/ipv6/proc.o.pre
  761333./arch/x86/kernel/cpu/cacheinfo.o.pre
  1315265./drivers/gpu/drm/i915/display/intel_pmdemand.o.pre
  1334256./mm/compaction.o.pre
  45960405./arch/x86/xen/setup.o.pre

I might try an allmodconfig with David's patches to see if that pulls out any
other really obvious cases.

