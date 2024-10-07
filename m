Return-Path: <linux-kernel+bounces-353630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0FD993081
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009CFB25D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F7A1D7E31;
	Mon,  7 Oct 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dmjd2pmc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QBtTaGmz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62A1EB25
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313474; cv=fail; b=uSY7Qdhc7qJxNUZqIJAglQS+5WBJtPSxd9Gj7SUcUZyBuaMAl+eMrjAXNebN5BH3pyUJquj7RtwPjrBDHoIcfIN2iR4f3HRTT4WeJDODqJrpmBqrf3b/2YFQYCSGWZMQYJ6iaUuqKYUCbi0EvY4FE3M9w5ioiW2XMU8AaPjU14k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313474; c=relaxed/simple;
	bh=JE1S1dhWJ+1nqsGNc16G8bKYqXf5bIrRBeF6KLBAlrk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qoRgwDQ8CCxBa8a8h2C5gKbyxE39SOMRIYZIuw0ckKCXntFrbhSmxad1AmSKTPa7esf6aqBV5vQrANY6DsEV+BUchaFZS0A2j/78o4IsZcya55a76VIj7Q24yQy3uYWD/JReD4jbC7O0G5ynAgzphtR4+w87VVZH1IBWnXfiAxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dmjd2pmc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QBtTaGmz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497CDo6V026607;
	Mon, 7 Oct 2024 15:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tEBvo18Wx3qGEywumV
	s9XoAe5ZSG6E/pN3alw1Sd5Vg=; b=Dmjd2pmcyQOa3ShVXCLE14rHLLIulZTIbS
	eJV6+xuw5eOYRmeF6FRw/Z5TQA/wnCK2miqbE5jH4J3dT6gZPYSdJyX7UBzkVrQk
	ua5klXC1k4BwHV+I6bYkGBLSK5Kwyp78aNK1/MLzlsC+rwzqkyEZbkDhtVNOgyNZ
	TV/ZH3N/mURoZL4b1I5jcgNMiCw6D9i+pkwwDo/h09oLheZo5ugkZUwzMqJJ3RMk
	Fbj7GQI1bB120KepslypGDavHneCsOVfSSehuKwIqLqVD4l0p/HusAN7ywOzkl/R
	36+jVPIGQYXJJrp1vomGkuNvbkEaDCIOORyi1vjmCupeznaOCq2g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306ebkmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:04:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497E48ca004625;
	Mon, 7 Oct 2024 15:04:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw5x5t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4iOtEz8x8khSsjDKvZ/8SwXE/mmSFc1/xpN7mJaDLLqFY7kVdOGCFwfpTbly2pgXszlEhmKIeGc5ZyCUSZYF1EIcKjubhy0LwVQc/B4UiGpsgIoEGCKTiEViM5Z2p+Mo3ycUAZvD37nTBWxO0/GDwo1JRrY5x9d9JO85HrdpWYwfqouF8tF2bzBcjbHTCdC+hPKNZJ9FDuBMR3GIuFNA5hHwmynUc1e1LHeUPgoCBV2p8QcYMBJFQ7eTmeznUaoQYMo0ZLj+/HiPxTXFMYcYrTApwwB4EAKBZspEmmRnQ7M495i3rcIgHBpu9/7uiC81dnSlp7kE7zJhehew1z7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEBvo18Wx3qGEywumVs9XoAe5ZSG6E/pN3alw1Sd5Vg=;
 b=kfuCbTUJ0Au+nw9uuyyYMTBz7RV6H/dU5LKgp3qXS3cQK5Liu8jm4ANl5hNhDLOdY9xWFx22PO2L1D4BEdzuUXrgUKuByOn6DlVYuTQmq7n8HPcyYMtqBwN1C0YeWB4e67nWFrutXojOMCwIrx1Bgo/8Mx+PoH6zf2xWS6XNOM/eXfTcCivi+fp2KP5zUflVtFn1iLyux6+C8iaobEEv0lLodppwSa3f74hDFWRv02jtGhroIKQlesM1rWxl60+TJuKBmNw70KJu8S3y5AL0CZlAJWCF6NomzWfdf25ZXbgE73EU/jv68rOZ3f0VHCGZ00mgeS7DjfyoF6uaSporbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEBvo18Wx3qGEywumVs9XoAe5ZSG6E/pN3alw1Sd5Vg=;
 b=QBtTaGmzCoT7LptkiQqMSC3XP86xRpI25dPq4waipD1p7pwF4n5fF1qRToLGC0/+LufelKOVuxVXH36CMifpNdAippeWptXPBEwemm8mvVRK2n9XQbwvV0yInfMCXVy4CA1MEan/1/n84a7bdBrXdniIwh1l4NLupgL3cbY+EL4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:04:08 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:04:08 +0000
Date: Mon, 7 Oct 2024 16:04:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v2  hotfix 6.12 1/2] maple_tree: correct tree corruption
 on spanning store
Message-ID: <c2afe8cd-deaf-4545-801e-f305d5694a28@lucifer.local>
References: <cover.1728223996.git.lorenzo.stoakes@oracle.com>
 <964860c315780cf3a5b8929a34b68d8208333c16.1728223996.git.lorenzo.stoakes@oracle.com>
 <eydfju7fth4hxyucwz5ani4qyrajfgzkjj3voiszam6d7tu3w4@hsef4adjoodq>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eydfju7fth4hxyucwz5ani4qyrajfgzkjj3voiszam6d7tu3w4@hsef4adjoodq>
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f914fe1-04a5-43a7-0610-08dce6e14b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gFRbxl2YV8WV1+dGucKy2kT3wvM8yGgIDSTwGKX7x2z+N1Icza+uHEdop5g3?=
 =?us-ascii?Q?odp9iZ7bs4rp2YURvYeHGekpx8gJetQ0X/LMEaqkTo4tJueabwXs+xU/we9j?=
 =?us-ascii?Q?uV465DLqXvYXI6l8SfiaSaWAbbIyaVSS/cHVJCpJ/IDOdLfP4CoqcQOyXyGK?=
 =?us-ascii?Q?IOUbWPi1bxt9gcR47nMR2MsK3HRnrXX3+OAb3W2VbdmsWbLVmvbMUE1HfnrK?=
 =?us-ascii?Q?sdO9aPAKHmiOL83sY7o4hJhlLTEqBx1fMpueaOOaMnfKmtOUZ4kgzINHorvq?=
 =?us-ascii?Q?h/iFS1EZExBICKz8wZ7WemqtYYHnWOKiYJoDlnD9Ry42umxV8bcSUyXzZmyp?=
 =?us-ascii?Q?btoDpRKGQ3orw1WTN6FbmWGQbUeGuquEdD4zFeTLF1Xvwa2QomJtn4PIFVmA?=
 =?us-ascii?Q?aPYYXkZEG7UELCBH4yCsHr6+u5hj2AYoOHX0HZsm+GDXsTvOaD1SCmYePaQQ?=
 =?us-ascii?Q?qM4ovsr025XO7TBHGdqw2ppRjfJ5lBUixi6Hu6HcOGCDMq2Y57pf77Mg00fw?=
 =?us-ascii?Q?fQ+GePGGGauxuh+9kAkHdDkHQoRAwEg9ys5eTvXw9CRUH0vxrm8r3XD0l9TH?=
 =?us-ascii?Q?xjcyFS/d7sFx2mrc/0vyBl6pEKx1bJZpSpegw8B7U5BdpBmxBLIfN2N5vP5I?=
 =?us-ascii?Q?vtatic5/H5rM/i5D8BTtnUI03AZN4BTGBjhx+XKDLaVXc2wimU8v785b11WZ?=
 =?us-ascii?Q?i6zAAVTdbvAFasceJvBHGKgHN4clLgSP8fHUemxah0GIjeuAHEiWRweLjesS?=
 =?us-ascii?Q?6vhP8rNVJU5YTwuVmZVFOLFcOH+Kq7nkVSbHW2dWrjQvqmxBIaPUM05QAfZW?=
 =?us-ascii?Q?B1odPTHE+IpPQ3XWDbulA/EeOtmK4Qxg7lUuM5S0y/Gaq3dTGrnm1BePpo2W?=
 =?us-ascii?Q?EcDw1X90cJRBf8v/z/CK5KSZ/4nRPC0ibdpehfoTl2hqvfzerr3SyFoSjzRG?=
 =?us-ascii?Q?Q4PiiNouBlHhh1h8aJG9mbp4uxXgWCfc7t7Y/zpunjLLQHvXOExIvY7TrQlh?=
 =?us-ascii?Q?aS1xAkRoFXr85riLl7IVygBfJRmrum3/rKUkINdM9Zv9IcA4gUWYc3nJ59vP?=
 =?us-ascii?Q?EwPYdVYSFk1z2RQXKm5VtI2CGch+ryDZ7oPm8cQWL+7H/zv2bcyqq91APDvF?=
 =?us-ascii?Q?jT/otFCZWjRRBoA1Bcwu20uUvL2C9FCc4Rov7tzNkWbhnRH+pR2x7XfxvY3T?=
 =?us-ascii?Q?1utvWvHAjoJRtBfNsbrn8xZz3IljaWI6FCkJPbubETq/wfknUYE+omqvu0QS?=
 =?us-ascii?Q?CFxSzfu/NVQfHWXij2kJITLRtd4mRbpqO9OF5zpzpTNzR086vwAAnoIcDszV?=
 =?us-ascii?Q?BIcB7/8IOa8bloQHQNtsXy/Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9eQR2YI7VuC29csboHSk6zZEUjYJDcguj0PYXiR2c0mwwuya1ZUToeJ3acjM?=
 =?us-ascii?Q?9jhZOU1n+ayrMxFwzoRhrOQ7mwdj7diaBL0WJf45yi3yBYNcv+zNoxNt0aGK?=
 =?us-ascii?Q?hZDlGuR3HxTOeMk+KZppdsFd6FxSrMNPYmOfkJ+XngxLE43kJsxHt0vH+QQT?=
 =?us-ascii?Q?R84kkeQKtzFhtDp3aDEawEHB08UCGEuaYoE4dlWQPWEiAAOfLJ38HKeGQfNC?=
 =?us-ascii?Q?5W2MloapMBTWhcKutX7BQCs6B7vkXT7bHG0lLi66DL3eP8N6p1SVFcTYyf3o?=
 =?us-ascii?Q?rw6/6VafFKgq9Rrq/odLSDgsnAoYJ2Ui7oT4H/3utp/TXk4ikepxBYyidld1?=
 =?us-ascii?Q?mJtj5KsHSoHtSibexmYhOfZO5flcQobgIG3zbM0GlzmAxgg0lEnLyaJzZNl2?=
 =?us-ascii?Q?JMjy9kaDyGkE6dA55EEeVLir3ekExcMPkoEXyPPDO+TOzIbdRSSpwg5agcuz?=
 =?us-ascii?Q?NraCXgSdPFF93Ubs8ToOgxKMVStvS0Ms8oUOYGxQrUlDSFM2zAc1S4bI0Din?=
 =?us-ascii?Q?+PSxr/t8F3CMex+rm+Hfra8q5NMCQ0Bu9OXsJpGxVHYGivFa5I0WOHwuTLwi?=
 =?us-ascii?Q?HJRxGGuVf39ytmlUfIGxVcISVZ1zb1Y27Wyt9zmgzg8Z4Ddc5hj5kRgy2Bs3?=
 =?us-ascii?Q?0U81av8LFFnqdtJhPL+4VZeHMm6R83NYWkLl+/AOX8fUUT98e3w7W5K9qS9z?=
 =?us-ascii?Q?Oq0SHQxPUDkJ5lTfPB2bRjyN2Cha+QkONN2cew6wYCyqzOjvAshiE5ZDPoJB?=
 =?us-ascii?Q?pDTe02FVXzYaiE1SEzb2bZ3cRpPMo24xNyjB2tZFwt76A04es/KEJyBncAaS?=
 =?us-ascii?Q?C4iPKzKfa9TExt1AGi5Uq1oqyZ0QSt5T+IPOhqQewPTgGypeg/NIuyrZOlNb?=
 =?us-ascii?Q?UIYCgVbxDItQCs/6yfmRtvMc5IODhBXcYOE2S+NgrabxT3riywTjKR5tFKQU?=
 =?us-ascii?Q?ZaqqRJejnSb6WN12sN188DFOYvv6aPy8gEUNodeY0UV7v0QCF/AlYKM2HSC4?=
 =?us-ascii?Q?PJ7XR9clNFSX4rj96JeKA3oVo9xSuwhYjAqtMyZfMp96HfEvKumhl/x6ksCB?=
 =?us-ascii?Q?yMxz2zX9cZ/P/vwsvo7zB6I40kEIvvds1p8hNCHZLjFW8asw6O18dmGFzw4j?=
 =?us-ascii?Q?phwCclBXhGrizLwF9gaaOfZsz8fsulavHUgvRh/V3BAH3u2fd0R+qc3h1tiJ?=
 =?us-ascii?Q?3JbLRw77El9xCukm5vlpS6PUXGwUPnW4fl1grtjvu49sfBH/JHZZHM7ndcGL?=
 =?us-ascii?Q?eJ08WS0XSXCKZd64wlC2OGFQHr2JvGvfIzYO0ctGrM+66xc0izANYeyp3P6Q?=
 =?us-ascii?Q?MyNlUt6mzj7A42iLVPsFdnb2vPcb0FuOrfOC7kbInA/SLAmI4qfx4hwx6kyd?=
 =?us-ascii?Q?7PBAu6mQf8nMLnPKIRcp8bro/zopglodN9LepxLgfxRBZF+rup7b8Mi+OxkC?=
 =?us-ascii?Q?QX3qOwaUCxMv7QgrxqiK6kJvJy3vaRWhRthXfayHxYRWA6rP8Vs87mFcJilJ?=
 =?us-ascii?Q?rbyfHtqT9e9SBXOOfgk/k/y9oUuYpWO3MV0VxPiV4m29MuXJNrFQEOhDdhd4?=
 =?us-ascii?Q?WtBzHnpOwLSQCh4aEA4cpPVI3yswao0ywQsuQ7JWtP93sl0KsTfGQw2AERuj?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jeer7kBY5NeUGbSAPQin7m9EkxdsfmfuTCC0dlx+6528jtURM7qw+/+AK6whzr4uk76rlciGrvvPBYEx8dYaJIEwMpxG/tZX1uwK3ZOWOHa8Ba9fBD5We/SeT52Z62iyXeZ9oTiyCYeBe7+bBtWZJL47T4lZkQnxIEqZDEQ/6MOI4TjbUq8pkjEPJPrlHF9gIPbi/x214bPtYnTXLHLrB0DDvlXhk7I2VGUjM9R7zAOuWx/DHCPzXRi7ekZAlIsFniU8SI1J2ZASPSXNQb6qa1JhiIS3u1Cdr+M/XAFYNiizC67902T38UQbX1A62xamoD43GjMNc6yFWJBbPGz6NtjoikeU0QwW+RIg7Efv5dOK7yZ75BwbfQcCSyUtZXyBDoMo67As6srGMJ0GRWSh/Xx3oqIpxwm1rF4P8HDoRuni1FYpXeY0BlRuNGsDHbOlnPhA+pPklvQadb3zItIG5jOXoYsojI3ReGAbxI02UDDJvsnZZruaD/F/VPaY6BxKoUG9y46ra4pVR0fk7QCpxKqUUDsC3djxU5brJ9uddLttvBxOcuvl7P16YwgSaukWLjolLL0InnPhxTbo4V/K3nliFxYILVTkJwqxsg5erWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f914fe1-04a5-43a7-0610-08dce6e14b24
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:04:08.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 629QaCKjYa3zCg6Zswve6Aw9vDv4LfNlmVf1Kf59v1PWTXab6/Bs1YeqjS4b4aZcozbZqe18nx2gVxGVttQ9zJvGigGQDurTviEj1LPOjPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_06,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070106
X-Proofpoint-GUID: ivRlkepPyyXbemx8ZDdvlV3wpKTLEgzb
X-Proofpoint-ORIG-GUID: ivRlkepPyyXbemx8ZDdvlV3wpKTLEgzb

On Mon, Oct 07, 2024 at 10:47:04AM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241006 10:31]:
> > There has been a subtle bug present in the maple tree implementation from
> > its inception.
> >

[snip]

> > +/*
> > + * Traverse the maple tree until the offset of mas->index is reached.
> > + *
> > + * Return: Is this node actually populated with entries possessing pivots equal
> > + *         to or greater than mas->index?
> > + */
> >  static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
>
> Oh good, I'm returning a bool that was never used.

Yeah...

>
> >  {
> >  	struct ma_state *mas = wr_mas->mas;
> > @@ -3540,8 +3548,11 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
> >  		mas_wr_walk_descend(wr_mas);
> >  		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
> >  						  mas->offset);
> > -		if (ma_is_leaf(wr_mas->type))
> > -			return true;
> > +		if (ma_is_leaf(wr_mas->type)) {
> > +			unsigned long pivot = wr_mas->pivots[mas->offset];
>
> If mas->offset points to the last slot, then this will be outside the
> pivot array.  That is, there is an implied max pivot from the parent
> which may not have a pivot entry.

Yikes, you're right! Would say 'will fix' but you suggest a much better
solution overall that vastly simplifies this patch below...

>
> > +
> > +			return pivot == 0 || mas->index <= pivot;
>
> What is the pivot == 0 portion of this?  The pivot should always have a
> value, unless it's the first pivot in the tree of range 0-0, but then
> there will always be more content to copy.

As discussed in IRC, I suspect one of the tests is using data from an old
version of the maple tree where this had semantic meaning. Without this
tests fail.

However this is irrelevant now because...

>
> > +		}
> >  		mas_wr_walk_traverse(wr_mas);
> >
> >  	}
> > @@ -3701,6 +3712,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
> >  	struct maple_big_node b_node;
> >  	struct ma_state *mas;
> >  	unsigned char height;
> > +	bool r_populated;
> >
> >  	/* Left and Right side of spanning store */
> >  	MA_STATE(l_mas, NULL, 0, 0);
> > @@ -3742,7 +3754,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
> >  		r_mas.last++;
> >
> >  	r_mas.index = r_mas.last;
> > -	mas_wr_walk_index(&r_wr_mas);
> > +	r_populated = mas_wr_walk_index(&r_wr_mas);
> >  	r_mas.last = r_mas.index = mas->last;
> >
> >  	/* Set up left side. */
> > @@ -3766,7 +3778,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
> >  	/* Copy l_mas and store the value in b_node. */
> >  	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
> >  	/* Copy r_mas into b_node. */
> > -	if (r_mas.offset <= r_mas.end)
> > +	if (r_populated && r_mas.offset <= r_mas.end)
> >  		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
> >  			   &b_node, b_node.b_end + 1);
>
> We may be able to leverage the information contained in r_mas and
> r_wr_mas to determine when contents needs to be copied.
>
> Perhaps r_mas.max > r_mas.last instead?  Where r_mas.max is the node
> max and r_mas.last is the end of the range being written.

...yes I tested this and it works :) so we can drop everything else and
turn this into a one liner.

Will respin now. Thanks!

>
> >  	else
> > --
> > 2.46.2

