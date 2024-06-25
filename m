Return-Path: <linux-kernel+bounces-229580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 278E6917105
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD7B2746F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B9117F502;
	Tue, 25 Jun 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dnoxc4zH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C1dFjlNX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01317DE3F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342757; cv=fail; b=FSYi3yNn5PVcwz3xLhn/1GSRRrcE1D7zzvUoiLXMNYTz5mIyJ0LONLJXbTDORoDy7eoihsRdyN7YTGm/AvVr6LVgepVTLMgsBCfQeysnVsViblLJHUBBvKSLloQhFFlwKu0XaIZ17yLzstjGw796HYMtl3/6pcjjZF+9pOlIN+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342757; c=relaxed/simple;
	bh=faERbgwG4awScMgp1/a5rql57Or8EmudvQdvcGzjiuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nBNM+23eDqwOMn+GdgsLw4mt5zvs638nCzZ6vzjDy/+qhbz9Uf51jg+E74mVFS7KdPQWal3YUmSeMmIo2Op/Hu2eH/uJ1WlmC8q2kxCfHhluOJ5208u326pC6n7LYVlfEzTvU2qpfzNWcyxz8dnSQedlmfsy/1kc8bjx0s7UAc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dnoxc4zH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C1dFjlNX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfWwm028638;
	Tue, 25 Jun 2024 19:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=bcNfRGlmtr+f6hLnJ3M5/LOiANFoVZKsDxZzPTfL0ks=; b=
	dnoxc4zHcudVBHWNhxkFCR5bG6VebdfJWLJOlMl8HT0RXHxmRkES5Y5B2uNB3FE3
	Rey+9xpLwNQm+28ynJ4R2uyoV+ytNQy60SwJC33hxIjpsI/vEol96oCXNd+gyI8Z
	hQMwmElZSt+By/Ld4PIfYsODc1NsjpEjRDW9jChBXJKiaLrp6Ohgh7X3loMPZ0kR
	lT17zUn3I6LOb8y+tgJ1INpr3f6dwwYgEWMYDTCAPsqvjEUomIjBtEAMQbdj5pEb
	ricMYSDWMWUHVbcjDN/Pdsk1gWB7H2NNc+d7DPq71+3zoRhInyc5VcgzEQZFitey
	D67scj24nKg0NY1Vm3Y10Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn709j69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PJ2DjH023323;
	Tue, 25 Jun 2024 19:12:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ehgg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT+w5GLUC4jmdp87VWsVBTDL0oLsXEz1AWEyoF2werffQ0A2dxuqZw4KZz/z93SeMsW48gl66Dx+KkOwQA6B7PaWEOPqvEkGCMr0sLKu9wRdmtwAZotwKA8ty4/hqL2eh1EHNGF2/XWFDvGAqNLLL4kAgvY4pL80I0gOlJhGAM8emFCFUFiT4HhlZ1WUEdTwTspVOgfVvdUVi4qpQtOEhkEcHldt99/LJuyWUr61fdTkiEIFJVHMRjJ5XgiOu3miclGrOK6ZlQiRK1B1d7s50xXXUeEzWqoBe2ZpIYizfE7GimKZGSluAb9KkJm7Q3FUMzBDETcr+byf22P0/pA4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcNfRGlmtr+f6hLnJ3M5/LOiANFoVZKsDxZzPTfL0ks=;
 b=gwfnv86HPGWHCpVlP1Q2J8spL+6+5hgz1/mWBt1U9Fj412NdDZnq+CowH26pAwUjukrGytT6ZaCs9gdz8eX+ffKBSE4L4ePXOX1G7L3QedDmRLrhTJCqpjL/F7/vIxDjpCELqMM8GTrZG3uJng7Lse4egMSfQe7L5GH5p+RK3t1Ute8utW0pkfiagWc7euC1SLIiKf+JJs0/n9YEUq/VL2A+ECicSNU+ZE1GILPBngJ4OE7jTXUYtKHeqCLbixdDVuaDCjWoPC9bj4CLln2sdfVCVbWZyufWpD/OAX7IqNiXj8wH0XLGpgxTj54zaj85FRXfgG1Kz3cUnOpAIvPzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcNfRGlmtr+f6hLnJ3M5/LOiANFoVZKsDxZzPTfL0ks=;
 b=C1dFjlNXQUalLRsUiJICYvdOqkVRkJ3OvvvroJujp+yLji/VaXKaXQZY6OL0FurfDBiY+iNl/NLbyDBhqADqJoK6FkdmuLKwmrGymtJw/u6Fgn0EiJbWNNkd3O+/799BNNuwyzJ6BA1v656pRCcfjjhkqkXIjWMMRVyLaifR6RE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 19:12:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:20 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 14/15] mm/mmap: Use vms accounted pages in mmap_region()
Date: Tue, 25 Jun 2024 15:11:44 -0400
Message-ID: <20240625191145.3382793-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0247.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2c065a-2b4a-41b7-32f7-08dc954abca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QwBwg5CBpuiKKUBOTNzE4BIM1YgcPTt/iA5kJ0/rHI0zHuEGN4aqFR9hCeH2?=
 =?us-ascii?Q?uOFyzKeLAPsS9yJWfd1egeV8lYcVA6SeIoYGxQSbYKrt690ZKM3iFmNf1xnq?=
 =?us-ascii?Q?uS/9hLo+qiu2ZZDz1ythBELxursg0q+WAQfVVqkX7U7ifjn/DWzwqrgwiqok?=
 =?us-ascii?Q?EdR4UBwtzkeiGJ+fA5JDCCJ+MYdLCJU9YgPXBCkLgUgMyU6fTEgogCOMOhiR?=
 =?us-ascii?Q?8Cg2bqsSCy1w9fkF6cZoVbFEcqCKU5JddKoJJCMpZBh4IPSMVk6r15iyal/r?=
 =?us-ascii?Q?uHL9ehgUGJv1SxY/ylipJh/zxRer9XQybD64IoOe+zbqhjn1JkVNBmkGPZFR?=
 =?us-ascii?Q?64hfAIYcL3MaVGzoxKpJ1Nojp0ghmfNAJUu5vpnCsoKweJdCxuRMa1DG2eFA?=
 =?us-ascii?Q?shjyzOmzNe+f8t1cUSQgdMkfVkISz++hljaLED1y6x8C63P65UAP2lz8L62R?=
 =?us-ascii?Q?AjetP2WGyrp8O/sfeESFGRdntb5UbFvrmny+knOfvSiL7Re9lHKMSZsbJgCS?=
 =?us-ascii?Q?u0IfbVSCZq2z7Ze7lfFTWonzAg5AE/Q+WyqVshMCZQfpzESzLGmK7fQM19z3?=
 =?us-ascii?Q?iI2PE96G6tccbi7ycHB8Bcb1CvJ3juAhe/QSdVx3ovKV2KZGHuIR/m+wgBzs?=
 =?us-ascii?Q?q8n07LL6m57xLUZ3A5IlO/n68ubyjsBCqVMYyLh493J3n/phgz6Qkc0ZXRNw?=
 =?us-ascii?Q?KLGa5rO/5H+u62KO8TnoBvNoJ5mzpiqsufls9Q+MHiFk4sUJAUJgoCXS54U+?=
 =?us-ascii?Q?64KECdQixPhatQOBMgevffqMiXA7dA1e+A/AaUanCpcQ+S1tofwQ655yHK0R?=
 =?us-ascii?Q?RLJQ9XPcGs5aj5VK2C8UKBDnCvBU4NxqQlY+lrPT9gEtd2/+4v9iiDT+lIS/?=
 =?us-ascii?Q?BDmGAlZbyu6qnPPIwpTWzwb4JEAkckKVHvMemeXA7QKfMF+bShFw+u+Wu+MS?=
 =?us-ascii?Q?runipNe7HebLxEN/p2w2AuiZtEuT83mHpvfhH3JgYVg1JO1pD9J74XQGy8gT?=
 =?us-ascii?Q?2VAlDVhgoScj5j0jS2JTiLFIUkQPON1+0n7vliH4ezsnsV6bvuDKbLxqJZJi?=
 =?us-ascii?Q?twb+p+BpTF/W7qsvNT1EKp9NdaKXZnIpFZWr5PHmBPnd9uFZEzmIg/ZckupT?=
 =?us-ascii?Q?TFh2/tx0bXeWaU+lEDP6KKCNwxkJjrH+S/TGX+rdfqt5QUkIjYlnlWxCi1NW?=
 =?us-ascii?Q?2/Xeme7UL8CYt0TQCDb4n6JmwI+rXAnNgD2s/0g6EMikD1ctg/DAEbrNMvvt?=
 =?us-ascii?Q?xvXlbDaRZDXTxsq4F3Qt2Mzu+/CB6x5HK7L8wSdDBhfsbPFx+ckoRTKHaRMI?=
 =?us-ascii?Q?H9z/0WUr0sQ3oxLBxOHyWmG4QQE0XP4rdKisGvGHqIUpNg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rtVbDsdnyd2AJ+wJDUpG6lUpYvDUI1Y7BHFStNxSgURqIEPY1XQKk37ZaAU5?=
 =?us-ascii?Q?dIwUyvckW9pDdo+83Kfe5DhutDb3uuhuI5UOJNx0UJKM6yLJsPe7MuByVuyq?=
 =?us-ascii?Q?mYj0TY5Rl3/3NYnWucErXdoGKNDmuRepKIZbG5FQLBvLS2WGNNSwhVeWEW0j?=
 =?us-ascii?Q?peYdbKPHgm3TMk9u3moO7n+1laLor4S1myLy2AKTLKQ+4gEkl7nBKXUOflfo?=
 =?us-ascii?Q?SHeff2NZgYM7wwzCgeAT1DSiD0gWPK0nnTYbzI3pSEBOiXDMSWef7dD9tT4Z?=
 =?us-ascii?Q?Bs36gLQVZw7whjKFnWFQQUSCBPPEwULVs/OeDVl7D0UExN4A+B31AHOdBCrX?=
 =?us-ascii?Q?1t1lRdbMSJ4wmi/XCu2/040bLx/rp1P/xQTJbSqJGir4ZaD76BgLq2aJZrsj?=
 =?us-ascii?Q?1e0E0gqmUjREZC7hYcDA0NBGp6VV+qU6J4cPdr/yp8d/Pqr7eEFnDH8haLJf?=
 =?us-ascii?Q?0wiH/qlNo7JZA9KdgEguYQ9AB78NiaK0KRFbyR2GqyU0pM0SyjANeIVHWj7Q?=
 =?us-ascii?Q?XiJyA5vFKQWjJ4wJRqc4o9EMzilr3x51Xbrmp037brrni3U/Z4F22a+ETyAY?=
 =?us-ascii?Q?aITeSf23gfvEr3+RR1L21VcSX02aaYH92An1/BOOIsXylOZ2jgLfiGNkDIf2?=
 =?us-ascii?Q?CSCYdGXbkFX8yGN1dmfV/mWAOHpc3DJpsf6vxQhDDOA9LNTMZeOH/U3o4sjd?=
 =?us-ascii?Q?kTHmFjZzaddRoLss2Kh9SZES20pvdKeec+ZxwENNJ93EassBx2tI3sZTyRtR?=
 =?us-ascii?Q?rohG4yej2TmN0aJsXInLTUDrfkF89eAhwKpQpPeC/wHCHpyyU2ZB25cckqD9?=
 =?us-ascii?Q?r4jGTF2ShOCyOEmr6sD9jyaOSTk5nNqKmcoaxQDoIID37W02kw8qyT7QGPk3?=
 =?us-ascii?Q?ORXFLtB5IDjfCu8ie4jK5i9zgR5jnqcPhmR2hNB68p3DXKCR8LhLN/y65g8V?=
 =?us-ascii?Q?ALzRz9gwFCVjQrry85usH7NvNFp+SBFkHoX+j3nQVpngYrgOB8Sh6mgVR0aE?=
 =?us-ascii?Q?bKEgfL9qJZGlNZysf9vlNvmqSMo3xv1l+U+yoDZJB55XkUdKNl/RHCE9+mP/?=
 =?us-ascii?Q?ehWYkkILcLyHPvkpHIX07Ke2Vh456Yg7fEgZkeJ0OTnPHpuHesmpwEuZ/A4M?=
 =?us-ascii?Q?Jk+yNeHMUh6H5+4cNow/lOHYWYbmYdm6RaSlHyUaoO9Ia3yeGUmux5IN7fZA?=
 =?us-ascii?Q?k/fDtiYnK/1bZwEYMhkrMmlTOTnDe18CMiAnu0/sZyJ6q7+GXlGOM3N2sUTP?=
 =?us-ascii?Q?ApravNjRnhqkdeWNjiZ41t8ZLaFQ+KBFg4nC5M67V6YcOaySR5XVvEUpPvmj?=
 =?us-ascii?Q?wj/MDtxLoCOee5+uP4yPYKdzWVXTlk0X6DN3D7Gnb9fLnl1+DnK/DA8iynSa?=
 =?us-ascii?Q?VPDgGOFMM2fWNtDSGIqSeP+ydKZamuzlYK37l6vUQW9wlispR44Kr6qA2CiD?=
 =?us-ascii?Q?bfo0/teu4Lla9ofDakDq7CL0QzI34v8jNfP1pasZMeljx9DuX0EaLOSA1YWG?=
 =?us-ascii?Q?aY5e5oJfIQ1i4fuoVO3h2GkxctcIq9b3aXi47Sg6wP/nJKCS1AbcjVI97HvW?=
 =?us-ascii?Q?Sgpq6gWKghrpiJe56SuOwUAiBNBFz6LAXnEF/Kz1qEEIDbPZiSh/b6h0u91C?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YHCCUwYNiWJHRHh6+Ma/S3nEGSmTgeBmabyYNRS6Ki16ue4cbgkrltz7tn9byUdcHJCa8bBTFdRWz5LFHgbdfy3YJgH7YZE5N64eoSon//tITDzFw+x1rxmPoTOcPfKyae0ZvTyesDf2uZMUy3xuwLXW9lgEyBUr2L/IWl6XLAR/J+jupNOWepHEZDJtiVjNakS+yn5UHYzoFIQ8ryoGs9ERXvjcvQwLLdcmkBlr5S0QR9fBrcoQu50KuBiaaHx32ixWps/JNq7aNCelzW/vHUcqaWM7sL7kILiUZ98Shq0M8IdlcIrMgUVCJCMRhd3Pc18Bg58RDLAmL0f3Fyhy0L0l9MOQWP7mtRzJEpV0ZqvLAnZk/GB8XrkOOh8kTD8l2Rc+lYf/FNPSd/CbefGLaY3jXUDdWriM4PoYJ2oT3m05yOTcGAKnOfF7HbTNxywIAgQaGn1B0uGnk2ZP2lXjvnkEw3/oDRJlq+5p5cGp1uWCetHMoEWHfwXM0xFyfPwh39ea84TtpGECQSEnUnD+XUorERjlEKp0h1r6zzEydZLcdFNEmu7OfQlcx66mHnvzxwDrCvrOdVKB3tGEmNR4PWeJDH0Awv9aIgbiEN9D4j8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2c065a-2b4a-41b7-32f7-08dc954abca5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:20.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oueB3we2m3KyNEp3ab7TkLBKT4ADGKcWIUTfv8aw6nwTNlGwebJvqSR3/l+I6QN2arilIz9QjkHTdbxiiUfhyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250141
X-Proofpoint-ORIG-GUID: lLNtQOmyY7pePJyxxQzDEaY02vMZxRVE
X-Proofpoint-GUID: lLNtQOmyY7pePJyxxQzDEaY02vMZxRVE

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Change from nr_pages variable to vms.nr_accounted for the charged pages
calculation.  This is necessary for a future patch.

This also avoids checking security_vm_enough_memory_mm() if the amount
of memory won't change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Kees Cook <kees@kernel.org>
---
 mm/mmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f3edabf83975..adb0bb5ea344 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2970,6 +2970,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else {
 		/* Minimal setup of vms */
 		vms.nr_pages = 0;
+		vms.nr_accounted = 0;
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
 		if (prev)
@@ -2981,9 +2982,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = pglen;
-		charged -= nr_accounted;
-		if (security_vm_enough_memory_mm(mm, charged))
+		charged -= vms.nr_accounted;
+		if (charged && security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
+
 		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
-- 
2.43.0


