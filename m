Return-Path: <linux-kernel+bounces-280052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5BB94C515
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A11B24E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88515350B;
	Thu,  8 Aug 2024 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XQeLc2lF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pQLU5aDl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123D146A9B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143989; cv=fail; b=gvRdiQ7YTm9+dgQj/wwFaHu/vAGEVhXCsQSV1UIxyTJG7z+itQ8Cj9JMPwGW2IXy2BKLRE4OjAcKTTSN+iv7EbR8x+c8K93LmgYm+xQ4thQGx5AcjwWHcysP8RGAoevtjew/cY7v8KO2ugxyQJQNUuj9qK0M9FOb/UkAU4kficI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143989; c=relaxed/simple;
	bh=xY5J7OLh5KtpjDC9R7l3ImjfJbwRtwWHUk+Uh6QbymQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tnap3Ag9/+FCfIcW1BOgBFwYTRafBKdAZEk+x80rLpg2dBWkKAF8/5vI6WqFUaGbpI6U+KZifgGsXTTnqSUMcsZJWtqWoFcEL8Zt7wxxWTc6g1zLipc8huDa7hzxyw12p5HAFsQH7nWU6knOw/a6i4r6zcq+aRioC4YXZHBuBpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XQeLc2lF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pQLU5aDl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478HfVmL012269;
	Thu, 8 Aug 2024 19:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=B0eOpxSLX2UkiSB
	XRMUD3CeJ0FhkkkWVW/z1LpFJxZQ=; b=XQeLc2lFGA0NqqJyKBL6HOQ6x8OGIMg
	MTirxahskUvdS92C1JxASo4A8enMvddkrsPd8uTBbt0lGo4Isz1ah+/PidQ8le5b
	LpzK+iwXttfa3LrjtzeICRvTa0UmkjaRFw7uaa/lzU/QvVmoGyqmWXKS7tGO49E2
	kVrB+QJG2zpQV/QZKuT7QkQECr70MoBkx1qF/Mb3c72gWFIHwtqbdWP6rzv2HYrS
	GA4rr8kgPqcOhnIDt6o7Eae3C1FNAFVy36NsYcmbk4+lb/KPmvlqGTAy1keYfedf
	FMccPNGfVzd6rcAQ2JjemknhGCCS7FMPpYHhsg0E1uneb0fIAOf/1/Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5tjgy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 19:06:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478HcgsT023767;
	Thu, 8 Aug 2024 19:06:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0ht7d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 19:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2ZkZVS3pkfoNY/8M8SoM3acrlyI1LQ4QKJVsONBFzLdU+SMJ+G+Ayd61VynhdMqNUlG55Pc6lZQMjmR49/ywLhsjwv8ZD/6neo91BOVRJR7kRFku4tcgnbr8/zLdbbP8fZueeHt9fco/fGiciT6rzYiBWtqUR0tt0zNH5LeNODo9Njxjprg5/8DWVXpBhgpczuY5CoWQ0qHwzrLxuQOU/mj2kOBWTUVtv3XRClbsqLWhyvPiw0qfDHlhR00c/cgc0OP8P2zIpv24nZ8hF59U2sQ376YwBasjmc8dBKgaq6E2N+KFLoAirBXQ9yZzmUlaIgw2leRcqapD9RGNvg7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0eOpxSLX2UkiSBXRMUD3CeJ0FhkkkWVW/z1LpFJxZQ=;
 b=jh6EPp2jeHZznTvT7zO80C8EDeguCxGR/6oq0muBL3L5AE8byF1aGQhT4OBFUbmLUEwuNHEihSkcP1zgyFvVn7bTtXqe9KoLiNE2QCm64VWAfjtZl//A87YlfM8/sA0kq1qRwMpBmFVhxdEwIVxVJT9Fuq8bQKlSlUvIurPvvnlJnXtoDn+SdRQEMPw9vUQSbqaY+iS6caCcnP8UPCQfAGyVJ4+MKCXf58tYJolGc9bhkmZJuPFjjKCfkydURms1zCHpaeiTAUFqmVWiu95zTSvM1xoGilDxRxzFMpd/0ceRqbvs4ql1h2P9PLDQ8pffW8NVKRxgw6JvQuOP4Gqu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0eOpxSLX2UkiSBXRMUD3CeJ0FhkkkWVW/z1LpFJxZQ=;
 b=pQLU5aDlivKl15m+hxFFneaZcpsc5BIt87WNsCHYMVd/tdPuHooBnmj2H5M2agt+33UAY06KgzsmZEbMeYb6YAo46a0yCHWojj0DI+MAaTwHJ/b6SzsfL5jXa/AuElFRLRVXNMRN72ndPyYRXxghhrws8k0x7KoSCAy7iMkgO9Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH8PR10MB6669.namprd10.prod.outlook.com (2603:10b6:510:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 19:06:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 19:06:17 +0000
Date: Thu, 8 Aug 2024 15:06:14 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <neghnx3e4alozuee2v7ucu5utced3olxscg7ponqtt7f3tr4cs@73az35wxv5ed>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
 <28774b9d-b74e-4028-acef-5d4f09a5d36a@suse.cz>
 <dec849e1-cfa5-4a1b-820b-8dc2ee5a8bdc@lucifer.local>
 <jlie2tieccx5ulr3b77dpvw4fupeocsu4ftiuwtjkd663qkjzl@vc3imtfqgemi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jlie2tieccx5ulr3b77dpvw4fupeocsu4ftiuwtjkd663qkjzl@vc3imtfqgemi>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0041.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH8PR10MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 8522b42b-6e55-4bcb-015c-08dcb7dd2e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvsL2KVwIzD4RsjfSVtKmG5xc48i5eek+yQVV1q3VlRj82IhHxAVad3yh1JE?=
 =?us-ascii?Q?2PLVZ0DIlnvqyI7hnmLu/szT6/LBXiUjcaIJTqBLXGXW8H294XyctnRfJm6h?=
 =?us-ascii?Q?T5zyYie1Q1/H4mYA55W7rfPTPoD1LrFbPlhS31kqyhW2d7M0bpZeoNGaCQLP?=
 =?us-ascii?Q?5HaOff5KXCjh9S8z0SnxggpUKd+87Xpurm5MO4JPzQ5bt0973lFhdE5lkRF6?=
 =?us-ascii?Q?C1TRiN2ORQtP+NOAOtzV64HSmUHtDx1NatD4c9g9DUAHqZwgiKFV2mrR94yI?=
 =?us-ascii?Q?+Q2f17hy2iKC7A0HV+4qAmXGr+1AYPY7NPQmu6TVTuM5bb6N/4Mr/tkOk7ES?=
 =?us-ascii?Q?9yXvXJ9rniM0CfpT7DWvMKJ3W9CI171ILFZTmbiEDdpKmDLVnjby9Gt0CBe9?=
 =?us-ascii?Q?xBUdl7YoMEqHyS4ng3Ii+8RuSHTHR1slmUi7Vv3Hsgpht+jN0msO1baOqRfm?=
 =?us-ascii?Q?8wQtTx4GKyoBmi5UvRIyMDQbvZmXBNxTGucXV9rQ32paeOMWh6ZXG4l0gtm4?=
 =?us-ascii?Q?GGZG8vGNSAWdazQjNjeVVNdrd351hqIHVwwCKx9v1rzUy53fqDQ7NB9ryLXj?=
 =?us-ascii?Q?+RIOWFEXfDwJxEsvPt0eusnGnDMEFrPc5Zi3RHCWNWI4Cko4R2utlncmPLwD?=
 =?us-ascii?Q?uGtT24EbhgRRmJyZsxXaMoe/HTSjBtxsxx18Ec4FOrQL4tSRu8SdTtA72Qbp?=
 =?us-ascii?Q?vX159S/zCDr8L8uVK6ZiagiRjZ5FOtUjjSTr1TkZYb20ITPPGxNpk0+Brr52?=
 =?us-ascii?Q?uYfSFRLqCST9wnEHUAIWeW3sHQ4+y8knGrpioGIHCQ6EaA9UzQcCzl1QbPpO?=
 =?us-ascii?Q?U0ROcj3zv0c4ZfkuBlL9urXxo8P6eVtP93XQf8ii2OgSWcYrLNT0OIM1W0uT?=
 =?us-ascii?Q?MEeMASpuUZfWOnZCCglLRxrLUvi6P6YfGi+ytwYPByWYqUUbVr/LIUd/Sfe+?=
 =?us-ascii?Q?05HwVspdZjoW9oelbkDy+J5Rd37Z5p5+G+qA31jOe0nFBb1rVw9epagPmNYX?=
 =?us-ascii?Q?hS0fvLwwNoTF/wwVklv3lESmbmomqTsSGC+YAvAg1AdKnnV5H+PihXBf9pC/?=
 =?us-ascii?Q?2sw611EIA0rPfQffBh8l3we9o9k3d1O9HJxgD5A2kiaYbrPGHEJCVXDyoaim?=
 =?us-ascii?Q?4IiShRlHblDo61ijvsT7ACyFor46RUGkKhe9fGI2DM51jYh4O5ESxzV1Tnbt?=
 =?us-ascii?Q?iLnPkmwHE+1mAWvFwcZ7cRTItlSMefZ7CV5OaNWTIvwlo/fcsKQcZBYNzD3i?=
 =?us-ascii?Q?MKIrZMIWias4iS2SKYb0OKXZcRYnKMtfH4cZy6IK4Dw9sUQswfVBXZEunPsd?=
 =?us-ascii?Q?dDLsevKdi/rfEfPyYrfJvyNxHtA/UfynaSO7wtX10UyTdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lx6S2LxewSmoVQU7CXcvWGlTSYmR2RhH2tkpMecoRITXDDVccLcUcXOwjvhh?=
 =?us-ascii?Q?ynsn9ABBbWc7FjAK0OGEs1zSwE+FNUphUYzTt/pIm+M7KOkFC0mg6Q1ZOPd0?=
 =?us-ascii?Q?96RTvmKTzveVJlNMiX3mEgC9AJ61Fejd792k7KRXws6VVxD+ODktUNjHpaU9?=
 =?us-ascii?Q?BvCM+kLfoXB6Jb/PSu8cy4ehcrkijYv3tIB+bNDPTZBBReftczp0tzcRMROL?=
 =?us-ascii?Q?E9pNVrpeZEz/3OQFbI+05Ppzfzrx15RqbjGxxFo15FtJiS/6JVpFknTT/xAw?=
 =?us-ascii?Q?9TJPgqfwdD9FZTEFpYKzxy3Fb8u8lt6iVjMaUKCpjDhWHQ80Wsrha+z2VzT5?=
 =?us-ascii?Q?nQXiJkxDlz2mVtJTSUFXLSRkh1aPsAeafISLleBOKCQwfJqaPzj+wqMRnBLU?=
 =?us-ascii?Q?itqdmQKqRyViH0C2MSldi1v6itj/uba2bjM6L0TAojbXGj5v5PogI2ULY6h4?=
 =?us-ascii?Q?09aIGpY+abYmOwJKZ64du6XsJFw+UUoPRZG25VKCLZQQF/N+fhFOI465Y1xi?=
 =?us-ascii?Q?EWHxOIGGCPlKyAA4h92KWCuJTuiuPsp880UEUtEznD+BRuiinK/tp/tquhij?=
 =?us-ascii?Q?c2zSuTsvzFclAl6/eghvPxL4vFuIH9KlN3D0yf0mcdKwrpHWSv//fYSGXN0Y?=
 =?us-ascii?Q?P94cqFGnd34X+erKW25rIsSpxOdDV2IEraeS2Cax6M7B4NLZIYXZBNdSNzaS?=
 =?us-ascii?Q?qt609qNI+sKu3pB5KlbXZThvi6CwjUhpSYN5freZLZWnw31FD2rpYd4SCSFX?=
 =?us-ascii?Q?Ye7wfpGuIPIIS86NSMHyRZz1JPlCf9TWkjyWd3vkrGUwRPSxLyHhHxkgoYF+?=
 =?us-ascii?Q?mIdTZvA/DeVWA9quEx+heWlnsS1+RzmDx6fBSzHlCQykBNhLFB+bhAVOs+eh?=
 =?us-ascii?Q?u3fT8pQMwbm0IjX4UngQj0uBpIlYjIbeLZNbHEdccUXNShHq6QK7Efkm/F4Z?=
 =?us-ascii?Q?Xp+xHGkOJ3hUNZwa3V/d6T4r+xMqfkUcpP1MrtQRDUFkFOGTbUmnUS9bR3B8?=
 =?us-ascii?Q?2p5VcfhJrjy3lAiwfaUEUB+EiBqX/Y5Hi9zSfg9uDBr8k3ShmG/xuwCczGzJ?=
 =?us-ascii?Q?LM+Pc7k6L7LAkRLc/E+mSYRx5fy0VMDKNBFdt3ARGPJQYXGGYeum0NBUwY5T?=
 =?us-ascii?Q?/ESQ/eBAyf10HgkjbrdNF0GseV8w3qoMMIfT9eZmTeKWy0btdXz9VQKnAwQc?=
 =?us-ascii?Q?uL1WzdRtxhP9GKqvr0aiciVCl5hnCvx3jhbj4C4QInys+jCCgXRliiWOje1J?=
 =?us-ascii?Q?kotzavkIEPUZ/4KYVoWhwwsPcCdhQHwfTfEX+bgeFK57tsg0nuwVo/assyl4?=
 =?us-ascii?Q?TKjkc9OjTmA6wJ2r4Gb1/fMVpSg+9dNQRAlXmP7xuTj4L8UQonPIz/X2bqmG?=
 =?us-ascii?Q?CYkjmWrZadwXlwTj9vfOtTv1+w6RLtr52qPrcCw6NOGDPh6S8G68VjiT5bsp?=
 =?us-ascii?Q?oPdQVU6JPEt0I2DKYSqYW4rAqHUeLPJrGY/9WEyvPNuwlKi2pxPjapIo4VfO?=
 =?us-ascii?Q?qrjryGDylBK2nUW6KRv/dEtsAkvOCrOY37bhuNauc5D39m5W2ST0GftiVBfq?=
 =?us-ascii?Q?2iAB5zRNCPcb7IFoDmx8GayDcmhf2wMMisMMgve/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u3xV9RU9dde+Ynwp9zmBnaUxHdls3m8yUV0Zm8BMrjolwkgsfmch9PGhwUsIYbAvdpZZl3p86hEbc1BJDLXGNJGNKTth8gmx5VcFi5/6r9WQcREpluIgh7DfekvTIrt4FeIYvVI0ctukVeAdxxFQ/3iEMDg7pC/jckRX9To32jNMRqwsfCXqJCk+13RcPWaZgcCFPH7S9ioBrG2HQx+JkM/y1Ul1KBOY+4hdrp3W3A01nkQsw0kF6XFfcVP7Zc9WRikf1JF/kIUTMRlQlhYd5smrE1q63219zI8E1xqKFoQ+xBmtIu08yd3dpDg9LmQixl5SEOydC8LNXTQAaaMVdbe2Esvn6+rRTpbiqVR3fV/79I2RvyNpxLx38vp3toxRBeBMMjCiatOxJv6AYZ1qvbD+MnijlAQrt4oui4XM/4B8GW3JQObateePp475zXAbKCNtE6BzRQAiMxdnlyU7grX43MtXbNTvambZnPeBLxnBv8TRgT7AxCfbBVkaoxRvSxP1BcjVImKxUYnXUN8AlV+SA+8kLq7wN45f4/fCU5EuuRvQGMdN5z05bNGuXlgjVZeofQO2MMI8yGu5YCYGWoPZH0KRPVarljXwbUzmMck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8522b42b-6e55-4bcb-015c-08dcb7dd2e32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 19:06:17.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dqJGwfZW1MD0vzkvwtPRT+O8EYHt+n/CPq8hmbfdsdSEsnIbJi9X7dzpe4Ro2HMAU4mMhy6hGyXSiYvqyehMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_19,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080136
X-Proofpoint-ORIG-GUID: gSONn-YSTPL0AQW8kPN534InXxqRc718
X-Proofpoint-GUID: gSONn-YSTPL0AQW8kPN534InXxqRc718

* Liam R. Howlett <Liam.Howlett@oracle.com> [240808 14:34]:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240808 14:02]:
> > On Thu, Aug 08, 2024 at 06:45:43PM GMT, Vlastimil Babka wrote:
> > > On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > > > In mmap_region() and do_brk_flags() we open code scenarios where we prefer
> > > > to use vma_expand() rather than invoke a full vma_merge() operation.
> > > >
> > > > Abstract this logic and eliminate all of the open-coding, and also use the
> > > > same logic for all cases where we add new VMAs to, rather than ultimately
> > > > use vma_merge(), rather use vma_expand().
> > > >
> > > > We implement this by replacing vma_merge_new_vma() with this newly
> > > > abstracted logic.
> > > >
> > > > Doing so removes duplication and simplifies VMA merging in all such cases,
> > > > laying the ground for us to eliminate the merging of new VMAs in
> > > > vma_merge() altogether.
> > > >
> > > > This makes it far easier to understand what is happening in these cases
> > > > avoiding confusion, bugs and allowing for future optimisation.
> > > >
> > > > As a result of this change we are also able to make vma_prepare(),
> > > > init_vma_prep(), vma_complete(), can_vma_merge_before() and
> > > > can_vma_merge_after() static and internal to vma.c.
> > >
> > > That's really great, but it would be even better if these code moves could
> > > be a separate patch as it would make reviewing so much easier. But with git
> > > diff's --color-moved to the rescue, let me try...
> > 
> > Will separate out on respin.
> > 
> > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  mm/mmap.c                        |  79 ++---
> > > >  mm/vma.c                         | 482 +++++++++++++++++++------------
> > > >  mm/vma.h                         |  51 +---
> > > >  tools/testing/vma/vma_internal.h |   6 +
> > > >  4 files changed, 324 insertions(+), 294 deletions(-)
> 
> ...
> > > > + */
> > > > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > > > +{
> > > > +	bool is_special = vmg->flags & VM_SPECIAL;
> > > > +	struct vm_area_struct *prev = vmg->prev;
> > > > +	struct vm_area_struct *next = vmg->next;
> > > > +	unsigned long start = vmg->start;
> > > > +	unsigned long end = vmg->end;
> > > > +	pgoff_t pgoff = vmg->pgoff;
> > > > +	pgoff_t pglen = PHYS_PFN(end - start);
> > > > +
> > > > +	VM_WARN_ON(vmg->vma);
> > > > +
> > > > +	if (!prev && !next) {
> > > > +		/*
> > > > +		 * Since the caller must have determined that the requested
> > > > +		 * range is empty, vmg->vmi will be left pointing at the VMA
> > > > +		 * immediately prior.
> > > > +		 */
> > >
> > > OK that's perhaps not that obvious, as it seems copy_vma() is doing some
> > > special dance to ensure this. Should we add it to the ASSUMPTIONS and assert
> > > it, or is there a maple tree operation we can do to ensure it, ideally if
> > > it's very cheap if the iterator is already set the way we want it to be?
> > >
> > 
> > To be fair this is something that was previously assumed, and I just added
> > a comment.
> > 
> > Will add to assumptions, and again I think any assert should be done in
> > such a way that under non-CONFIG_DEBUG_VM nothing happens, maybe
> > VM_WARN_ON()?
> > 
> > Will try to come up with something.

Something like:

VM_BUG_ON(vma_iter_end(vmg->vmi) > start);

> > 
> > > > +		next = vmg->next = vma_next(vmg->vmi);

and:

VM_BUG_ON(vma_iter_addr(vmg->vmi) < end);

> > > > +		prev = vmg->prev = vma_prev(vmg->vmi);
> > > > +
> > > > +		/* Avoid maple tree re-walk. */
> > > > +		if (is_special && prev)
> > > > +			vma_iter_next_range(vmg->vmi);
> > >
> > > I wish I knew what this did but seems it's the same as the old code did so
> > > hopefully that's fine.
> > 
> > I think point is that we are about to exit, so we'd be left pointing at
> > prev. But since we're exiting in just a second, we want to be pointing at
> > the next vma which will become the prev of the next merge attempt.
> > 
> > Liam can maybe elucidate further.
> 
> What you have to remember is that the vma iterator (vmg->vmi above),
> contains (or, basically is) a maple state (usually written as mas).  We
> keep state of the maple tree walker so that we don't have to keep
> re-walking to find the same thing.  We move around the tree with this
> maple state because going prev/next is faster from leaves (almost always
> just the next thing in the nodes array of pointers).
> 
> We use the maple state to write as well, so the maple state needs to
> point to the correct location in the tree for a write.
> 
> The maple tree is a range-based tree, so each entry exists for a span of
> values.  A write happens at the lowest index and can overwrite
> subsequent values.  This means that the maple state needs to point to
> the range containing the lowest index for the write (if it's pointing to
> a node - it could walk from the top).
> 
> A side effect of writing to the lowest index is that we need to point to
> the previous vma if we are going to 'expand' the vma.  The range is
> essentially going to be from prev->start to "whatever we are expanding
> over".
> 
> In the old code, the vm_flags & VM_SPECIAL code meant there was no way
> an expansion was going to happen, but we've moved the maple state to the
> wrong location for a write of a new vma - so this vma_iter_next_range()
> just moves it back.  Then we "goto cannot_expand".
> 

