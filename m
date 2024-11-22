Return-Path: <linux-kernel+bounces-418402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF69D613D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0FD1602E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128971DF722;
	Fri, 22 Nov 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XdL4SsGB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZHBZet+b"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342CC1DF27E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288567; cv=fail; b=K/ntfuNxAxQcs9WY6I7CNAMZBGcvCCgD1S0xB/tgwYH1yb0tr2N/d9LxqLjR7ucEJa7AH4OgUMptQWIXuIHN/U6rrXs28TAT949hSFjfcRNGFbx/3XGf5xq/+lYGbroMxefGFm+kW3MohXRFrDsjp3ANnzoiWvgrRRY0nrTBjaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288567; c=relaxed/simple;
	bh=NU7foklMMk3WD2bNK2J0Ps1ATsQRWmp/CzUNRUg4NR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rXuZB1jtLl1aSH31VjAo8uSh7CuuXM4nnMgbWh1BPmiY6KWjWkK/WUDs7nIe06VWcomypSt0taBrr/rKjmxe/TTCiTmUouYXhR7UmTzztTYAiuqv4JOeSzsjzXeykOw6N3o7xLbdl8eXEGyfu6KbtsHqx0C5PjnfyJj0GDXVgps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XdL4SsGB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZHBZet+b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDFKsC000451;
	Fri, 22 Nov 2024 15:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fqh1nvQgfb2tTHfOPz
	EBzKqGSy8M2pJ9+lxS/tVkyS8=; b=XdL4SsGB3fcrLHLLez/oUpHxPrNkwBnaOI
	lsPctmtPeyXElTibdswxZkI03UZYv3ubcLemHUvejHbHKxz8zE32QMUb3T1nYRfb
	VH8Ua2kWuALBUYMAUvkPn733C350JtZ7pxqGjzmY8whlWSsp/U0GHLwOzAntsfGq
	Z715LkfuBZXT3wt9zOWDNVnJHQQXxwqP0PDlbWWX/oeLkJscKLxC/LRAg4QQB/Mf
	gbiHl5HlIj+qsb0UVpYHtPNjBPns4ALOANW9ICHauM8Bfi3d2/dAy7SHWIR0QZn+
	gRCXXQ2s7xaCvlBKMsBLnkr/IgpwmXfCN2om3oLjbJlIsd/5Z4AQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyymauy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 15:15:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AME2nI5039957;
	Fri, 22 Nov 2024 15:15:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhud7cfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 15:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujsmikScYZRlgzvITgyUpFS+qmDH55hNoTlywXKaKmWpnZYo+iCCoYJ3UjPO5cA5y+1S3gEGUL9I4AEU2fPnRmiCoCfTBDAZKRJyFf4/gPm5x1WwvYfP+oOZqiYw6Qh9pSgHU4s2puhZhsRmfIIFPhgOBrdZd7lBStzc73srOq10IEHDUkORTEJCgOZ3XAr7OTtaiwAibU5K4e5dmDYndpgfjk36gFpEwYJtux9xFeH1GGqJWwhC4jdWrKAyBIWbSGKuOSLVGkWSDiK2qGK3CMZ5dJj5QaQW2e0+2nEp6PYwKFgWnT0vdSNS2wxtZd5BzKxcoUzKt708P57c+IhxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqh1nvQgfb2tTHfOPzEBzKqGSy8M2pJ9+lxS/tVkyS8=;
 b=FdyT9+Vka5tQ8G2msLKvy70gdBEe/ZVAS+hKhxRXSfpydiV/ojSvXWl/cNA8Qa+r0lQAlbLGrEIU4GlfdUJeJQMJxkCSxB5UseKsz9h1x6eXKRBZOfaZbop1kYeFnX3wjJBwyk7GqgLbRRUxt50XXpJscmpcQATc2ERRVgjGDm6XBC20KQ5j+FTtutVy8DTb4Jj9GwtuC7vfHm1zio8cVerk1oMFymFT7owQtAgpdQN2X8ZdJq/W+Q0KHBM3ZAg461W8W9rG+9IESKI7bC/XsDDCneO2dhucUZbMh1R8X5IEabFU6QcDMQ+V9Suz1iGA3/CpJf+6T5xBRWciOihXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqh1nvQgfb2tTHfOPzEBzKqGSy8M2pJ9+lxS/tVkyS8=;
 b=ZHBZet+bjgtfUe1PN6YZf7I2FA58LqgQQusYaBua/fN1Qyizs3PchQCkbYkmMiL76Nhy0ggqZ5nOl2iIzrFcpENs3VLr4nykA4XVdesDvf6IHsFSJ0zMhvYA18qBul2z246qrZ4Es8AOYxoH6knqJAIu62YGU7g7sQHRX3XGw1A=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 15:15:15 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 15:15:15 +0000
Date: Fri, 22 Nov 2024 10:15:11 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, andrii@kernel.org,
        jannh@google.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
        mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
        david@redhat.com, willy@infradead.org, brauner@kernel.org,
        oleg@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com,
        zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
        viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: introduce
 mmap_lock_speculate_{try_begin|retry}
Message-ID: <o37ef5nflv64x7ojrskp5vdyzfdqsdwoqdid3wy62yivmt2obl@d6pg5wprhwpu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	andrii@kernel.org, jannh@google.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, david@redhat.com, 
	willy@infradead.org, brauner@kernel.org, oleg@redhat.com, arnd@arndb.de, 
	richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, linmiaohe@huawei.com, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241121162826.987947-1-surenb@google.com>
 <20241121162826.987947-3-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121162826.987947-3-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 00967302-6d1a-4522-5735-08dd0b08779f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O4x79CHtBHCYl6x15gKYpGHivzNLEzhoqkeymTIVRPC2DJ8ZHJ+iILmMwSJg?=
 =?us-ascii?Q?flT7+/w6Pvh2yd8awbFSbC73ddcWXqXoV5+CU15W7IHsclwQ04Q+HfyS/0cM?=
 =?us-ascii?Q?ZHTeAZjlF3LdY7qmpmIvitrckOxvI7DnoUM3VXpDTdUi4MZ7h8LGetv9ZPVI?=
 =?us-ascii?Q?7fPfG5T/cEsdzC++yfkjpLB7XXeB/bStZki5owxkobT+V+NPIKueQrmbaDVY?=
 =?us-ascii?Q?k0UA60QICU7wXIXKA3UrL+gzjTaifHYfZ0OJmlfYVQp7onD90NiCm3GZY/wF?=
 =?us-ascii?Q?lkRP/D6drG4476F2wz+5v0VGBhRAYMWHEkGAGeQHWusSNFxfUwvdBwhiYc7S?=
 =?us-ascii?Q?fhOMKfT75fr74fMV5meqcbjLxQ3pgvwD7cDdrBQpjryIwkutEDsQJ43j6f8Y?=
 =?us-ascii?Q?crQt01aLWh6fI9wHwbhjEuwNt8JCzlPyhMiuqY6kI/OJRT+TsS6kEZlRlY7i?=
 =?us-ascii?Q?2w1imNV8icNgxe0CVzUset3RX7Umxf1t1urL/m144aoM5QrSWY1WmpDF3+Sq?=
 =?us-ascii?Q?kRch66cWtdumEHaU7H+itUX47epNop2qBougwCQdCE7utqBiPpgQIHF/Nith?=
 =?us-ascii?Q?iOdtVo4bJI0bybOWrxKwWOK8FxbW9ae4xHFKiGTwc6Vwpr/P83NJ4Cpd/Y2J?=
 =?us-ascii?Q?OvZ1r2yLaRdQ/tWeFVK/nfM94nkd9FRmSoXVBnZlQDGMg2cLDQKy3U+rBL2p?=
 =?us-ascii?Q?DNbC/BlwGhEWxhXN/BcnYKOkxKplWei7VJtlXv2bHXl1J82nLCBAMu1e2t8D?=
 =?us-ascii?Q?76d4CiI9cn8aIdbiGQXplctsqf1hMZ0+ZwuwjKegVa9hDm8YDCOpf4dumUlk?=
 =?us-ascii?Q?mB7CzCrxJY6PWIsWPkv9dRLTThuwiFwhYjkzy9hZrx0KfIp0gYQThgXhUVQP?=
 =?us-ascii?Q?rMe4BgwD17DwGKxD3gw/WKo2HIZnANACcplt1NfZtDWfdPhRctRrwvsdHKEe?=
 =?us-ascii?Q?v1XXqMIveM2z1dZ9ayYHXDakEssXPi7IAoLVHnFcyy5s2mVwi++0zz7XoxOC?=
 =?us-ascii?Q?vNZvPIAfrKgGtP4ANyfRkxWP9rJhJXRUtCUExJTxwbQamAH3gWRyiNrOefbe?=
 =?us-ascii?Q?gu+VXiJnC2xTgYwidbg9dIJDsGpkCHQBOFMB5UiDD3xElo7ypsQc3DVGP1EU?=
 =?us-ascii?Q?PBxMDpeM3UkaC1S3MoqzRlEDxaUwUhbi5Ak/wk11b8wRt8qfsQvukej1RBij?=
 =?us-ascii?Q?4wl+b6kwEjB43pWkZeV51z4kjJa6/frc0KMdyDpu18zZTsmydUbkLt4mikdV?=
 =?us-ascii?Q?yyrwHs9/5oNkwx1wyxFR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B1vj4Tp1psIU4eZuifSaHil4nRaNZQ/dZj2xhOVVORrAI3dNvNoLkZ3+tz7R?=
 =?us-ascii?Q?vhyp1ekAIc5hJWvQmaw2VdWWMEVL8JYNsB73V76eiTOeLLYAkgKViNqHfhIN?=
 =?us-ascii?Q?Wxdv1X1/Ic50E5aiMquC3uYZsCTb5hJ+jojaw+ClKhdAyD1HLrXMVuHWejQp?=
 =?us-ascii?Q?bn8Za64zIEPCbemGSEaPbTkybXYvkT7aNseV6UQ+0z3PWOIgDI1EC5O+bEBh?=
 =?us-ascii?Q?hS+dNy7vPk8eKzyR/cy2nVPzPtPMF5m8kV2SzmbSpzGwhPtB3Raqu9ZdKyoE?=
 =?us-ascii?Q?zTTfMyz9DPMU3KX1oBWJd6qm4WZ6RK8zYEavBUboENNygFS6V441h09ptYab?=
 =?us-ascii?Q?flffHxHbAf6buFItY7DKCHu1i8KrK/Rq9g41G/oOeFE7NjbS21woTOG+pVc9?=
 =?us-ascii?Q?OaYYG6oLfnRCXUKrd70zrhn3w23rXEZuOMH+rMn02LgoQKhbLpPE5V0rMcO+?=
 =?us-ascii?Q?YQYxB4jE3IvQWC+FhIvWXZSJ3+uTY1l9OpNWqEyzrVIJYU86SC211cluIYDA?=
 =?us-ascii?Q?nKWJWsWc+wINTk/1KgVfiBKDO3sX0wJuHbmNDHKnl0j+dbKDKbYMOp29RDZB?=
 =?us-ascii?Q?oGXFncdRmNJhVMZ1yF2LpGZMrefzWNTzIDqZrBt1OUCjfrxOe6BqVCfXNZyU?=
 =?us-ascii?Q?nXw2AfVRHhn1vtlAAaTz+Ca80FXgBRWa1vW/hj2XlayWUc+c9eXxaexA4zAB?=
 =?us-ascii?Q?3TOwWxChZEzizV04/cjoDyUE4jnUBba4hKEvFWSkO7CdLGIiriz+IKcbDCCY?=
 =?us-ascii?Q?PlEV9QgZyaNZK3xbM5h2huy3GKrIa/Gu31NGLvP7dGRJ+tyEDQMYAj0o+cTU?=
 =?us-ascii?Q?T3/jIsx7xMrwY5vFi+TPc7mnLM7RCzMFwaiX93gEBc1PdK12ODsHOjvdK7U5?=
 =?us-ascii?Q?cgxanklW5KuS7PLxrlDmIMuBnRq+/O90Rd9I4dLTQqyC0FrWz60hCEbZ/7qH?=
 =?us-ascii?Q?NCE1T/ism8/oadK8XqyjXeLeb3G+0OQXNTPGry5Ob/7UNWsJmcJ6n56AyjvQ?=
 =?us-ascii?Q?XLAlNi6rH8ZRQF2tMq9ka+NEWA9LSDVyWY9RTT0aikXlzBBE1PZd83IyJuOf?=
 =?us-ascii?Q?kQmq5ZmCq+YvKlIrXdix8uUcaTFH1bLlBR8BHHEvIBPcV+GXS39NpdIErR7C?=
 =?us-ascii?Q?aZyjPousAzFwFOyBgJNRJtZOgO60nSlxDrjan/tCNSJ5xHJeLtYlRklGkVK+?=
 =?us-ascii?Q?QHqjz7JC/gBk/0VLze5Um89mYjph82p9qBXjJubyunDNw4zVHaifpWHXVdJE?=
 =?us-ascii?Q?dsMlC4zvLXuKP/gk43OfBlX6JDRxiRBA9R5oZqbDFl5a3n1yH265fGwmlCj9?=
 =?us-ascii?Q?zm92wJSxy3a3AiG6XwesFACUz0Hkr8nCY/mGEexyw8h797hgJizXCsHKlE0T?=
 =?us-ascii?Q?aVDZvuxDJXQKvYYqvWX2ATZ+8WRZjDqFMgzXhKfcFxfNTZ0cmw+mv1Ynj7Vd?=
 =?us-ascii?Q?5X1NLzm94FRMe0AxXZZMovTzKGvwO33XvypYORX2Sa0ETxK/z8Dod3euFsRn?=
 =?us-ascii?Q?FNmGH2+fwKGYaProO9J9iN0CQzEJc0TY6sBicEOPqbJzq6v67F3M5EzGC4nn?=
 =?us-ascii?Q?zYsnLtho08P7nBTGX7Adqsg5bfNBAiFHKuxIWhLQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nkRSYs+TBEplmyZ94doQ8s4nW4d2V4AMwv6XAEix0Z5cuBtNX+FNL2SSQwV2DVNhbT+Pms+3s3kGMgFhS+X/gUD0av4BqE6O9EedSze7vOAkzR8sNs6EJupEMRAT8hLmsUxHF6UaXk36aHBfTJVqBvFPaDD0RH0Ukat8RwsGgPjN/dR4+/jsraHGVFGFYoeiQE9zu6M+xRwZvhDILYxe3G1bS8UtHGGise9rXjJrx+r4/qm4AxHvsfRZdT5sg3jphryYBVcpkUpHgZujfd+vkiFiuftjMZloSXi6uM6LkZPOrLOjurkkM/gFjOB8tYfeNOGS2YWY74wlfr1TmLHmrapBgmyr0hJ3tJB7CpzhLfcPxMffRx3esOeMCQqIBPE3+Bz3MkoYPojbkbwG1V9x4R7VfGlPfQ2Piet9ne4JjNdtpKt+MCvzRcfhuPuwVzY+UcaI64yV0Mxl73LkHUdli3+cM0GdEz62UMVUcI3FfLfG3mpumtarxUDXuO8nRSj95ph3XQwF9Mk2mGuSWDcrJkoAjVUuU9IhKXnlpBb7aAiq86wZ1YDlhZamUbR/3OQx1NtA4WR2mlc99/rsnTjr7F6Hjejy5J6Qpdnl+B+JFyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00967302-6d1a-4522-5735-08dd0b08779f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 15:15:15.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVRvxDTZ3NdVy2zSjsu7HtMcurkaLh8nPZy/7cpFgYNaDHbUei+mE2KIuaXwjzB/7ArYkOjye0cQp8cD5CMBdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_07,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220128
X-Proofpoint-ORIG-GUID: Yi78Z68UIaXty7O0bACpIrluAO0zQQJf
X-Proofpoint-GUID: Yi78Z68UIaXty7O0bACpIrluAO0zQQJf

* Suren Baghdasaryan <surenb@google.com> [241121 11:28]:
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
> Changes since v1 [1]
> - Changed to use new raw_seqcount_try_begin() API, per Peter Zijlstra
> - Renamed mmap_lock_speculation_{begin|end} into
> mmap_lock_speculate_{try_begin|retry}, per Peter Zijlstra
> 
> Note: the return value of mmap_lock_speculate_retry() is opposive to
> what it was in mmap_lock_speculation_end(). true now means speculation failed.
> 
> [1] https://lore.kernel.org/all/20241024205231.1944747-2-surenb@google.com/
> 
>  include/linux/mmap_lock.h | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 083b7fa2588e..0b39a0f99a3b 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -71,6 +71,7 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
>  }
>  
>  #ifdef CONFIG_PER_VMA_LOCK
> +
>  static inline void mm_lock_seqcount_init(struct mm_struct *mm)
>  {
>  	seqcount_init(&mm->mm_lock_seq);
> @@ -86,11 +87,39 @@ static inline void mm_lock_seqcount_end(struct mm_struct *mm)
>  	do_raw_write_seqcount_end(&mm->mm_lock_seq);
>  }
>  
> -#else
> +static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
> +{
> +	/*
> +	 * Since mmap_lock is a sleeping lock, and waiting for it to become
> +	 * unlocked is more or less equivalent with taking it ourselves, don't
> +	 * bother with the speculative path if mmap_lock is already write-locked
> +	 * and take the slow path, which takes the lock.
> +	 */
> +	return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
> +}
> +
> +static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
> +{
> +	return do_read_seqcount_retry(&mm->mm_lock_seq, seq);
> +}
> +
> +#else /* CONFIG_PER_VMA_LOCK */
> +
>  static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
>  static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
>  static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
> -#endif
> +
> +static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
> +{
> +	return false;
> +}
> +
> +static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
> +{
> +	return true;
> +}
> +
> +#endif /* CONFIG_PER_VMA_LOCK */
>  
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
> -- 
> 2.47.0.338.g60cca15819-goog
> 
> 

