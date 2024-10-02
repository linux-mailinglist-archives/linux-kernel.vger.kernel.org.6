Return-Path: <linux-kernel+bounces-348138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2B98E334
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426A01C22979
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F04D215F7B;
	Wed,  2 Oct 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QpqHuKKw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZxDHedHu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832E215F6B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895301; cv=fail; b=Epz5MgLS4aDFcQQJrKzxB/b40L//Z9VNXn2dCRDQZKg864QFJwke0kE9qVK/8F6N7OFPFiX5O8+AOCnFwZ6O3v06rx8UfwlZ9T8J2c0f1Pk2G+CAkEI17vkZe4i8Iv9h7L7ndTal9V9vPnLHGv/xEDbMS90K8bD4+rnJJAzoB9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895301; c=relaxed/simple;
	bh=I0iCrevGXoMtRHf6hgosILS5dhMQDW9VfCCOSb4bQDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KrZ6pQ0Y+M/fNTYlivtYxV4rjNiGO2bKVjMzHzYDSPyBhjAJkRQdjlbpyNMAU8MHZTU2x4rFGWV0Y94MZCUsDWUZnjDPVp9R6illwJF6F/5jQRkYNdfga3rw/OHZ7P2c+2sqM2nRdBgkBsUMMccsWCeVYMDNXk5wHsvPTCRI7eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QpqHuKKw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZxDHedHu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492IMch2026603;
	Wed, 2 Oct 2024 18:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=UqO/WYxQO1B7bnq
	koQ4exJeWU2y5KpUWRTm1NndhsSE=; b=QpqHuKKwy1hWohD/IY6MyOxzq96ySqu
	29ikgSWzCCy6SJZhJGTCh0zKS0832HLxV0IAf5Y74Hro50ztP0dD8AzBmd3tedYh
	79o6ixvgSP8sH1pVJhkXfSaJZGSpuLtabkv4HMMJb16eWSyl6XYJJzcwUrSIXGrP
	0Fl5MOFMvD6Npx0edZ+w9DxMi7E6oPvLDGaneIVQUwu6zx2mfFOFEz4/ssUBO7oY
	bZ8I5C10xF/kdOwWBo3nOSqKXxTSdAIgsFLOfeL4DIdUpkbjhLnJDefMHXRV0Yqf
	+JDK/JiI/ISHMGVBbBvtn9GSViOQSuL/aqht6Gq+9udvCQZP6ZGZEIw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9t89u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 18:54:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492IRivH017314;
	Wed, 2 Oct 2024 18:54:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8897kv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 18:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDf1SLIdP8EMkDgLbrVqo9wqQHFmQLn+D9PnaZNhS/gE7c+irz3AHdhuHE0t6eCB4EF/qnEKu8MNmUyhK1xhaRHeNdVZm3rOlOmIenF+hD2tS0sFhYbI8+cD2+Lax6xxN+DU3NGg0WWbLbK9YSfIZPaA6d5mdvyzse8OGXPS+neHD9gawvAlnckCZJHXUHOZNN3Og89+OipF+roOzfu1jT4RWGJiWUUz/9V0EOIY/IZun/jJFszOIoeTk8qkesuXIfbNLn9tFgvcJT3TfpWStts3k3Qby7bgXph5DGefgQb3w03Iue6L21CKJZ8Z69vW0t3E1mGAkLSGdIN4wCF1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqO/WYxQO1B7bnqkoQ4exJeWU2y5KpUWRTm1NndhsSE=;
 b=fNm00Nlvhdb8b3hwwNXVxQDj8Z1ov9BSN20hmlqUasnt5KRK7cLbhqnRrWFy0LYQ4Z+f/ZL2ird8SMyrk4Zxit3wxRAkUSztl0yOoKtCJO5I7cnuEvXuzIdTV8eCd0GcomsZ9BBCa49oXpDDM7F5zIfYALhCCszeRFfUQ/CC1GonUXtebL0L4GYwdEJ6NuF0PoU47gmwJUPOzDtfUnzJRhhpE7df6l4jrrfqZ5Ky4bQGjwDXXVuBiauqPDP1WLB0NN7j6z89uHZIukVV51nMy1VseUsK6baRZ+GBky1pf0GvlIxk/RXmDf2ggpyr9XUP1YrA0OrkJVXoPq+7hDmdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqO/WYxQO1B7bnqkoQ4exJeWU2y5KpUWRTm1NndhsSE=;
 b=ZxDHedHuSeCozGNp2N7XXK7ZybbGUDQ3eOWyn6Sd/cPHi8bt46y5bJ7zqrhkvnLll0RBwJjRQoUb2iWwUvjuLVZT6r8FGeBjLmQOvsSVwsOU45bAI4c4YcC1tDMhd86wU5AXdsFVpBPrOOxobpqecMuCrsTyIxaY+kxwhrJ90RE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7384.namprd10.prod.outlook.com (2603:10b6:208:43d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 18:54:48 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 18:54:48 +0000
Date: Wed, 2 Oct 2024 19:54:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <3bafad66-f0f3-4255-83d2-5e7846f69b18@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
 <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
 <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
 <c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local>
 <cf72fda8-5fc5-437b-a290-6a2c883e6adf@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf72fda8-5fc5-437b-a290-6a2c883e6adf@lucifer.local>
X-ClientProxiedBy: LO6P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 0741b0d8-2487-4d66-b665-08dce313b073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ff9ZWsga0h1M2gqGV8y1ov/SFUqcKJ3M/SrCS09htTzokJrES3P7NgOK8goy?=
 =?us-ascii?Q?7VGnBMW7RWlEWOmLyWSKc69OdbKCbWd+nRLYjv/GdMWz3QcTEh6fRyihwRcf?=
 =?us-ascii?Q?XldrzGHI6WkiiCJQ1t+cRhT3PJ/BmUtFBWafRhqmHNh3H2nEIHtCTS4IIlHr?=
 =?us-ascii?Q?bJLZZBYy91Wz/nN8FV2AZnYJS7ezyh+GahFcbrZwST12gU1H2xP9Ba+7xSQY?=
 =?us-ascii?Q?qxtvbPmXhPNjOmIO43Bxv4yHLnPfnMnxUji97MyTydAQaMJWTV9sAkc49lTL?=
 =?us-ascii?Q?z6RLOTU/tkdvPvMrD/ZiNO8C/DGEAk6Bd9iTWydXNoDV5QXkk+D2eWbrZ89U?=
 =?us-ascii?Q?kiTGsVOMmTAdnGN1Px7p4Gh7SK/YzPbKAsvMoL811ulzE0jEipzS2skzltcW?=
 =?us-ascii?Q?HIyqKC3dlbuVyUQsQM9y3P+Eo342CmNB14qiXAW93c8KGtY6MIVqc90l/htU?=
 =?us-ascii?Q?Q723rUnvi09V50zLgy6s5FnsE9GVLc7fsXaAPSDG82glK3N8msGGJQ7sOUuv?=
 =?us-ascii?Q?YhYd+0LTExXxjP01CA3LP7BbH+c4LAJUk2FNqGt1oyVMMr7EsBBjnRFn+Zcx?=
 =?us-ascii?Q?k2fKS0clcklc84mkD6k8ahIZ8BW4XkYjSQ+HSw7xjW3rWzIg3RtoeRq6dvry?=
 =?us-ascii?Q?kVKZK8KdXQyqZ+MzaZuZgG5S1KSEnmgvc5c9h3E9dk0qwoBfgUww0s4euXDP?=
 =?us-ascii?Q?mYFwY3v2JueLh/sqocw/ZVJk77fgCQhkXefGPk+5hNlPw5zW7MKi2rxdDBd+?=
 =?us-ascii?Q?oqexIA86ZJHE04ffAhCjvdPpsxUENOVEEercMhcuIzNnTIxtOgb3fPpwOmVr?=
 =?us-ascii?Q?Caq+EMd7iAFJYRLnCoFnWNYcxL6uOT4pn4sVfIPcXfpYVJCDh4TUnqmO2BPJ?=
 =?us-ascii?Q?orBPBiHmYVhdidFOmSPLq26KyZN49PmQs31i0T0EQgdDozJtPEKSLT/z7j1d?=
 =?us-ascii?Q?BOB1bairZ1B/Iva6f3MO8zmTchoFjhNsKnv4fzaGEiEqwNpYJ+jXg843+1n2?=
 =?us-ascii?Q?X8aAMWMAmijVa0CAUNvMA7QgSMrKq7c18xsvONROrt6eDvb0B/4gV2m+VQgm?=
 =?us-ascii?Q?e5GrreYwHFHv0AaPDLz7NjPgrMqeKVv61olJnKe6mpq/+Q1kceDjY4eRBmn7?=
 =?us-ascii?Q?c9bkGdWoAoTfYeLGct7TEgJYL5fAc0VTumdGd2jYgns8zh2dQ5LVHyEEe6+9?=
 =?us-ascii?Q?IYcZpE0TxCkuCacoZ3xbL3wp1yg+sC6QGVEnXRDE+fhT8Ad7ZSHm6AZVVSrG?=
 =?us-ascii?Q?wG6BK6sUa4HMNtaO/VDzrOHQ7odYkzOQtXctQgBttg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OyrMZNPBnbk8uQeBYYXyjUov/S1PJlE/BtFH5RqENH52AWxNYIh7IZiPmh5v?=
 =?us-ascii?Q?NTazVuxx1/mHdAp6RE4O9V9iHbiTaaPFd81BDtVbiMgmS0ovY5brQp2fNFCu?=
 =?us-ascii?Q?flJqmBX3rQUZNjmtPOqm+nFJ2UnCPzR0fRLkXQqTQGDchYSRJHZFhIcw9JDg?=
 =?us-ascii?Q?dNXrWvx5pczPNS9d/YukR7ByzrGxddf4+UjpY5oujn5nFYMRo1Myf0n7qAb5?=
 =?us-ascii?Q?CnkN9TQpTOku4bC6FQhAo3n0xY5iqkzlrxwLFbeozDgK95A/tppwUO9eZ8wM?=
 =?us-ascii?Q?IrVvqVe6Y/MR3Z4K3vH2XjXaMZcPKpprFVhbYENLLDhAVU+9ypOsnBAyEPyA?=
 =?us-ascii?Q?28y9Rg1mlPbdTPCpv28zBYJTEttqg3L57z1cq9/F/GgXCFUQAwFZe87wTCn6?=
 =?us-ascii?Q?bHxocLoyTbb43r7IWgE8oE2UaZHRZmEO6vlmpNGtmtpU8p2DwiXNUtECz6U6?=
 =?us-ascii?Q?I59e+R8fhJPFqHI3fKUwFuoTIQSSs9OMZwnJ4ShBwTRuHoKjzjzsiwU3XiUK?=
 =?us-ascii?Q?Yu6vMv4tJLyounsapA2P7GEqT/Ehco5HztRCqkcD4ydUiw8VG0dNmm9ZWF09?=
 =?us-ascii?Q?TsST7Hurvyl1Ucp1P7q5ZPpVnpZflpLQzHj6jqjQDLCpmJpAQkZL8llX98Oi?=
 =?us-ascii?Q?bJ8dINUmXfSZup3+5IQF/uB/xINxRnQVzML1XsIgWWx10RajBq0vepsoN9rl?=
 =?us-ascii?Q?qp5KdjWypr7rEz7PjF/qWeF1HYAtKkBOBhWp63K5EMgHwvrXT0h/snJ3vwS3?=
 =?us-ascii?Q?CiuFp21hUOv/LNm8Ydam5BBHxezCQlx8JGpi2CWhmfHQCLGwb+CRtmEwP46j?=
 =?us-ascii?Q?PMIyGJ7ix38FqvJ2oAi5KDObfWdEwH+aYbAF98hheo7FLUmfuisduWXD06tn?=
 =?us-ascii?Q?RkyLqr0nVEpWhclpd1mmLoPt73mPLoGse7TrJYyeri7JA62srfb5Z/MD4MTx?=
 =?us-ascii?Q?JDMirTRr+bJ7lFyo+OuSHVKSjJDHrB9usWrkHGMvN7OvvWaWhMPfdfpzzJv6?=
 =?us-ascii?Q?aRtRZ5sRe5GMn3Mr3Ns3raphZYVoN+pRnbHU3e7FCd4oR0xGJcdt08/YRqiD?=
 =?us-ascii?Q?5gIHgTewKJGD4vqTTn+noAmz9IsysGYl7Nz3rPumuQJwGxFKvN3UjwPGcKun?=
 =?us-ascii?Q?Ef/al4gH00TAMv633GIrx0IvPEj3QNWeVmIONgkcPS1uWCbM+XOkRBjM7N0u?=
 =?us-ascii?Q?So3vKUicJmcO4gc9IiDiiBuxAk3aK7B4xYMqivK4Roli7Q3ngP9TnfNxWk9J?=
 =?us-ascii?Q?Fd/YyotMlxKsJeWLHGnLphtjEYxAr2hRkYo+KCTGtZN3vJEIbJMZS9Y8iV29?=
 =?us-ascii?Q?xL+JklwgnbKevEQO0/Bc0IgCR/MAEr1TRWbrsTc3wNessAKJZa+dNg7kIYha?=
 =?us-ascii?Q?cALlP0zNLnYUGH0T1tcLgcF+5OpuG7uIUdGWvw+mj1txqwjW6ORx4YcIccMh?=
 =?us-ascii?Q?t7MaguMoNYrdAPLegKLr+aezK/nQZb945yOnNudrmePeL1Vz3l1qHRwKrZ/A?=
 =?us-ascii?Q?Ry6c9jzDpqj3O6rYefwdpEAHZaLhkyh1ccoFt3sAezlzNQTdDLd6wIzoVBuQ?=
 =?us-ascii?Q?eEh+KNOu9Md/G6fCU8J8kGSRve7e8wWLhQZBzl8o0mqVRmP4wfhqgZp2//Sh?=
 =?us-ascii?Q?waIJhc2mtT5jU7Doin1V0LVw5m01u/iHbA38ZhC+AMR0hUAyi163y4gCW5Ib?=
 =?us-ascii?Q?pfFD9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kJek2HSVqb7QaVniqONypUJ9eod/sadKAqIbDFS8oBtqnGaDBZRCxiH88/Ge2HiAy6CJXyBrPxQJkvZ8g8nKrDlzZEidMbfWpTzb/gG14Cqz171aUr3LPUup5yn9u1qBhdTwUMghnTluwNJ7M9wVHyljNAE88ciLzQf+qIvNhdPuqfxx1E0T3RxYZ1x0gXSb0g1zD+H5Zo6B1n04SSx/o0wq7QxS35LTA1r6KspCtNx7Ptf3jFfmyVHMqEZzVt6UbhpXa9kkMTCGtdx+VYVWXDZ9X4XUUKKcZG89dVSxKIChQnTlM1fbShd/Q9kGaiRpBwC62ERdSUyG6g8MoI9KbEv8yGsA7tKEmg/cNUC4lM9brK463Adq7c0OyuT2rbc4V9gTNtF7FwwVxaEAkruBMeBwxnb/W7oCue+rXASDeVFS3tufZa65VunfcDpBGCyYfHiLRSHXsp81XbDxaMFR5IDRvicpbqWlYh8WhVaMVLypmZ7fPu7+p5JL5wSjNpcikUa0WE5NpLPWZmfbTbmXUcHLz1prZfEcH7cjQRZNndcA4cI3W2CAf2HnazaoLfnpNmKxyDR8M5Glx2nLIzAFtiXiAhVyY5cSblPMJZNzPVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0741b0d8-2487-4d66-b665-08dce313b073
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 18:54:48.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3iceWU4WDxt8856K/QGwHaZ1ymq1sKM4DCtD28e6m12+UNchAK6acYV6+CR4NSYkgsS9Jf33xLoy4Jk0fQ6RD6xRwxNRO5yy7z49++Pk+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020137
X-Proofpoint-ORIG-GUID: InUEuMi4mns4eVjxyulAnTobQN4xioRP
X-Proofpoint-GUID: InUEuMi4mns4eVjxyulAnTobQN4xioRP

[snip]

Also, for fun, try this one out. I don't hold out much hope, but just in case
the VMA iterator range being overly extended here might be a problem, let's see
if this makes a difference.

This is on top of the previous patch but hopefully should apply to clean too.

Thanks!

----8<----
From 01b0afe395664cdda313f87e2e9c6dd80fdf04e1 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 2 Oct 2024 19:52:08 +0100
Subject: [PATCH] hunch

---
 mm/vma.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vma.h b/mm/vma.h
index 819f994cf727..20cb4f91e371 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -141,7 +141,8 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,

 {
 	if (vmi->mas.status != ma_start &&
-	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start) ||
+	     (vmi->mas.last > vma->vm_end)))
 		vma_iter_invalidate(vmi);

 	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
@@ -463,7 +464,8 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 #endif

 	if (vmi->mas.status != ma_start &&
-	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start) ||
+	     (vmi->mas.last > vma->vm_end)))
 		vma_iter_invalidate(vmi);

 	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
--
2.46.2

