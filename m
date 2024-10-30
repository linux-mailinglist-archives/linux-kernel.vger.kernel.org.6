Return-Path: <linux-kernel+bounces-388662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3C59B62BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6F8B23AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE01E882A;
	Wed, 30 Oct 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ld/w+9QW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cnW9+90E"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087141E7C1D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290426; cv=fail; b=tesKVpcrtV3EbMIlvImd8xdECGs1PoEsFV8lh6NopzQ4WOwdC039H0pgNTJbHc9BMm/+AogHpZAj6Cer3lqW5LILpObVK+KbfullHLVNI7JWIcN13X9gjA5EGLWnhhtdDDvNrBl2v6Zuid85v7g0R2ThVuSOefXNLogf+yfJvJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290426; c=relaxed/simple;
	bh=rPdsirB0mi2hmqLB14YRoqcRc7jcF8NBA9UWOjvm4IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LUYAsBzRaZ8/WAvVauKe3ehWkHrPY4qGiMVMj7g1N5bOlhq8uhS7bjvDha52gsksLcuzqHxOtnfBEKg6Fta6jo9lnLg9Z1hEauvfTnzeRYTpmeaWVTuYA/Qg7izW6zMk/sNOJYoawmPCQ/AmTVYxnl9DmvmrRA52ns41nvT9mzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ld/w+9QW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cnW9+90E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U1fhT7021379;
	Wed, 30 Oct 2024 12:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kGwGTHevv7+xu17V6g
	DBwkyQtW+ZMnhJw46QTqtslCs=; b=ld/w+9QWs3Om6hjRPyXPkbQsy2cmsE5fyS
	tP4XP8e+V6w9MoGh8rkzPJfmZ3ce7v7GOTkmMkaf4AkYYtvJoivIK751o0nXexQu
	lRKwe2GJNHxreMbBUe2VDyeesmhUtqxec5Ku29W70aZa7pDSScmGeRsjhNXUPjMr
	7K5e0VIN8Z4xFIUszLXH+vGw9sJu6QfCsAFsXUAorMq9MQJp+NIB2TB3E2XY4hSy
	gyC+BChlXmVQ9ELbUHR0zwUfz/wFtpVb/1IF5DUT0BgYiiBR+i0wIwdtbDtbMlGh
	Pt/09I9wYSzuuUy3qY77SWhZ4WdYYwvUS+b1ezH9qYUdvL6V9thg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqfs4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 12:13:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UAFXHv011744;
	Wed, 30 Oct 2024 12:13:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnadx9mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 12:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af5dQRUAAk4eZhiBAWaqvJ1Cvcho2xuX61JuR+bGgccHrAsBMVpoSZxfPSSowEHSKJ5f7/7YOtro6k1g2ywX0+2wxshZVON3qcjUPvfEqwycGofw+Wyz2sNl4+H+Ye51/Y+od+P0ya6dzWtRqMDOk3E97ozm2rM2kogOyf6Fmvv1W97kU+PFCDyo0Uo4BcitJaTALOFHynEeD9CRf/jOeHec6/EQnoAz9jWHaCAt6D7WCn8+hOptPDlQP2gjh//ZyoPqwzoAwrE/hjizKZ+RWnP4oU/kdzEZOLNvGV0V85Rkn7+BXzg2SjmL4dnVoGw4sgID3+Y9uWzB+RoKfPAwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGwGTHevv7+xu17V6gDBwkyQtW+ZMnhJw46QTqtslCs=;
 b=fIuUIUUcajtg+xZcaKXHGBid1SUZOrlca2u7WpjEWwwZdtaJYgRiF9ZxXNd1euWEUvjFI79RZdrGfr18xO4SUQCgdv7C7b1G3jSAtp0s0/M8xBGrq4objpk44dmcp+spQFNcLgztJSH48SDNxyFOrvtrVAlOSuAUdBZDc/eq/QuWZuUMMPGDW2TPB6KxwjhiVS5/PtljufeBrqI98tc+R5Z3EVWd+ZSSNQw592SASngDZ7/AsSfHuNoW9YrBeoKveq+ZT43YMBY2l2KOGaQzL6pooRJK0Q0fjz9IPgy8T+H6vrEuccKhDuCei2H0/ho8z/faKrlDQ7MXX6xp4QnQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGwGTHevv7+xu17V6gDBwkyQtW+ZMnhJw46QTqtslCs=;
 b=cnW9+90ExhpBPpHXe0BhFWiiLiTN5BP5uS/IucPz8PNkJ3GdZZnduKxyK8GuNnybwBYOCsVbH7cLMQyb6HJ2kEcN9Q7bySgZMIrh6MaUPWelA7kaAPW66NFz6jWtaYqacXs6PTsV57epCV6sq2PkEgmIrhSNr5duCCvwOAikkTU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA2PR10MB4811.namprd10.prod.outlook.com (2603:10b6:806:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 12:13:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 12:13:18 +0000
Date: Wed, 30 Oct 2024 12:13:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
Message-ID: <13f3c341-7d01-4be8-82b0-42c52ebba741@lucifer.local>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <ZyIfzELjiqrDMhk_@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyIfzELjiqrDMhk_@arm.com>
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA2PR10MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: ab96c9cb-6456-4b90-33c5-08dcf8dc3ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OTIP8GjdKVR9qLVd3rr4d2MAYlky0yVKae8Z3Au8+Y2pQnq+rHdtytFZ/EIy?=
 =?us-ascii?Q?ijjxmhwYopV1JYLwk6dWKU7tYbjEnVIy0Uw3JRcw6nz5g3XWBUEUFNv9Gxkn?=
 =?us-ascii?Q?8JXQ+xzgg93xrjtlfjMTvsHF+U5NM3DcUIhD/sWpt2B4d/EhegAW9Ww/Vw+Y?=
 =?us-ascii?Q?p8RFOZ0GixzpD1Y30moV8y0aOAPsTNoq8E/QfY38q0TBPFHLcS3nBLw/wVQa?=
 =?us-ascii?Q?3szvIkqWHjSxgP/pu1qjexukd3HZ8eDEkLTQzTzmCZfEfYBjn84mmq8dLPfa?=
 =?us-ascii?Q?DqRk9oee1VNxcIZGe1X3rUyAiK0/WwFr/t2shagMpMv0jDuYyio4oB3TwrVY?=
 =?us-ascii?Q?hoo7x4IBto1/pAHe+/Pg5d+LsfZ1rsF+s0qQipswmD5cE+5mQJAOWmQnDPt9?=
 =?us-ascii?Q?gZH4s8/NCiHMI0mLEIgBQaEVyIeWy9rLzrzht6iqv7DhqtqQZTgULm6CuIms?=
 =?us-ascii?Q?jDGGa6BzhUGUnJlANJED+WRS6aVLtl0G8z1YNSU3OqSOEsuEVBr759nVgHt8?=
 =?us-ascii?Q?MT7fEm6uAgAmeM8ELmC39VilO/VyQ8ExZa9RZLmb11KeiKcByUlZLDpzP0KW?=
 =?us-ascii?Q?rgtJfM2nbcIeFKionEVlKIt57gnnetuS9XjhIPG7zKjnkVMz6KyT1qXVxLMr?=
 =?us-ascii?Q?HN2Sy94eaErdbQ+DVeHDG/NLbEryixHRszChSfgrydcz57n5SHBigDVrFAmt?=
 =?us-ascii?Q?BhHclK5u/EAjwUSyFwAkBKAvYTz3fUJf2rJaNkeoNP0qBGWVrVL0QLC38Hdi?=
 =?us-ascii?Q?co8IDhn4r/lJ60gd+Gtu8E2+mB6esVfVYmeTtfQQ6mPGRqX+J5Q7l76+2Rv7?=
 =?us-ascii?Q?kladGLf5AQ9O2C3iaNfIrLqdKdglGCAIeU8VUXpZ9sECDDTGxh0xnHQMWsPk?=
 =?us-ascii?Q?nzsMLPF/nINrSZTq/I4WZT+3kFwT1WGqaBtdSUsdmNd2GsVPtsRe4MYxDjX9?=
 =?us-ascii?Q?PNQPCwtkMEciohe1LIm9rCaevGuvm/0HPZVPZEdoiTH8xcMCYOXjKPTjse2o?=
 =?us-ascii?Q?wPJOUCGdj3n3V5gxRmEnGP3asYozR+1tl2LCMZIWbeDyJwP9hfe6/YQsMzGD?=
 =?us-ascii?Q?82/MrwmPPU6widunOxrcnsbxQqBQY0Rd8uKLIMiiVUCrGQyVdQI25x8SzVrN?=
 =?us-ascii?Q?kxM4nXGYs/Z7+wh8HbJ8aGL4iA3vD1b0bd6/G1ecN1nLxDcVTgMj6lu6G9tj?=
 =?us-ascii?Q?TPXk7vGJyskvR17trHSsuwIFo/hMIYx+IPfcalUttLsvmWMIRZ1AJRkL09Y2?=
 =?us-ascii?Q?X1iqlklZrPTVlB4tBCD7r8ZB1EHcHFta/wtr0VgntahZunThWNiaLF+E3zZy?=
 =?us-ascii?Q?e+sRUTfKqTtzGXIcBGIBmxpx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kUSw5MXMTXAuHLg6ttetoNkv0LOyr8QGlFxaW+Boz34utFMMDnuOHuy6wWjp?=
 =?us-ascii?Q?pVA1hJgpECxJ6mE6pZp9Swp5BbEjYVz/a2kcEi0LNMnhceCVO2EPYfOLECEQ?=
 =?us-ascii?Q?GbHOZ2JlndnKQiNx8xoN3NytxdFJZQNSjWP45CWPfKiYlqR5ApGmkRCOHF9j?=
 =?us-ascii?Q?HKExk61pRZ59I1hTGps5Fot5cBnrb2bTKlYdOe9GzhvnjfG9fQjz3sXB3SaP?=
 =?us-ascii?Q?ur/0zGgAubg1CHhkFuA7V7V7oiQqqqw7DFgEU2l0KywxdwREPa19qz29cmu3?=
 =?us-ascii?Q?SymHmzM0qoJs97j/kfpiD9oBoN0x0EXwIgoRaN7P+oQnM9ZBP7lpeZgT3st0?=
 =?us-ascii?Q?kgqp6i1S2yAymGokRtJIjI73PfTXzSV7ZTLdi7Lfg1SnTW7sXxJQfXPB2Ii6?=
 =?us-ascii?Q?cLZEFIRr0pUP1mD35P8ZBlzvpB0at4NLvOKPRb9dAMwYkl8ZpE1uiBhp7yqn?=
 =?us-ascii?Q?6kW/0Nr9dvGJlQixy/YYKYvDw3TLrCe4srKnBIfP438bmHtTXOIvGMsU1gsp?=
 =?us-ascii?Q?VnG7OjHql9a/pavIijNpeDootDmIii213MLJeYvTUBeqc0+7yOG4NGWQu4nP?=
 =?us-ascii?Q?2lVB0zpRENjAUEuE7TyWyjxqsUw0qG25VlmlOTv0/2/5oUj6Zho5I65RjVd6?=
 =?us-ascii?Q?2z+vl1W6CmAGhRy4D7UFYr1NC40HeEn86xR2YgL7XdSEyqyukMYeBOvvbR+x?=
 =?us-ascii?Q?8Na4si8h4VgDRG3xwKNjYlTyVPH/v+buW03aW+ogFaj5gptFt6g6bWO7K1v0?=
 =?us-ascii?Q?fMtLVJqAyf8aK5m0PXqJ03PYCIlvTHZqU5UoMFdJhAwiLYwmTsGukwuq8y5Q?=
 =?us-ascii?Q?SAYTk5P8RK5CC2679TnD2MNTOyGgSuoA8939125WrgeleKhYG3tRuLt67xNB?=
 =?us-ascii?Q?4rrdcJuTyoU36L59Kf6hcWvYOAFKMvGaB39VCqyU+JXBFo93Bx3cDwe8LMgN?=
 =?us-ascii?Q?oLhVgEDgviaEsXiid1TSVAnUN7gNdOfVnfiXX1+Fr2Ck16YXMe5MAbvqnav8?=
 =?us-ascii?Q?+w81VR04/NaNcwr9wq3r5ehfwoIbBAECC8HI2kDAj6SFTKwvg6ti0aVIW04V?=
 =?us-ascii?Q?uhM2Dp57MNT5h3IDrMrq/OYUFTPZj3RIWVnvr/ggTrfY2ddthQUWw+SKvmNf?=
 =?us-ascii?Q?317HAP9wAw8UIbJ/DtdUQTYzEVk3DAkQLb8LM2m84ckUJZyoRnwYgfypoOxf?=
 =?us-ascii?Q?ggFl7v/QQPzX8if1QsDSiTv1Ysv1At2VmO5yA0I6zyDGDFDD0be2s7xLT+a6?=
 =?us-ascii?Q?rNJOlkSOZmB/jAQu97bBSqRe1DWktpA6NV2afiyzHyDkHBAf5GHxcUoWC9xV?=
 =?us-ascii?Q?Z20x3n68+eebzH9EVE4LX+r4ux18JqrMLZCza/BO+J0mbPFFTkDWQyZJK/X1?=
 =?us-ascii?Q?Lfh+2kEL69ezxgqZ4+6xNsLJO1lx+oNwXmv7pTpIIWbyRThPSotHAasgYNNe?=
 =?us-ascii?Q?lTy5Cfl9eSLzVNN4Uy5kff2GsX5ucU4Avmz9mluIX32tLYe1N3VxgTU6TR4T?=
 =?us-ascii?Q?JpJ794kH/HUhKecNiznemXJTEfS1Dl2gyn4dKPYng8YPgIVs+63g/ppv94sQ?=
 =?us-ascii?Q?4/U/Pv7b8629Tm6fxBtQtE8lgyRs7PHqF1o57NG3fq+LCYxvDosvvUHxdAqg?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eK65iU/I5niQpziQ24+kHiKG9xGY164i8VH/UnwKjQTFx500khvyy68/UViq/bMuiwkNEWdCj4DuGVkH4vHPtBJR8pD9QedJVSrjHGA1UtDWP7ZuxHVRvRLcF7WdYqZuEHGwA+5bnmtGbW34oiGZyll9NxXHy5F8W/7XRoMyqnvoZkQsHN32YvCgVYRYWDhJkntlvNu7kL7+mTn7xHyOslFqcCqr7JfKP0Rui8Ye8Z8FjJo8dLmhRCO7qetuWucmvJ5VhgELEz5wB2wZUNuzmC1CDmC53e3jRdNawaeyAmOl0goqBZK2znsZSaxivR6N38GK6PyFXscDaETP7faEIdjpmfpq7Zf+H+ZFhaq60T9Wo0OVWpvfkXwkohXfK7g1ycK3bpKa0EFLY2VYT/niLIzyav8LtcI2GtD5xngTz80/IRkULhLA0qfhcndLgRO2bfc6fBWfqDEi3yH7mtXqlytvmFzz3wSeGvqTlXOv8jXwUYnGNefXEO5MJe0w8WEDxO8e5aIPj13pg9wbwBZaNmx7VargD7rWH95FxF8E50lgMR+rKVRSCIGQptMqWacQqcEZhxGpcps1i/46zL1WND1h6q4ofjPivtT+eaSAqnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab96c9cb-6456-4b90-33c5-08dcf8dc3ce9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 12:13:18.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmHsdwTuIEa+fxkfUIbgBOy6NIl7wqCvxtx4N1cAH3FrWy8m7v1yJPadwSwy73GKkVfyycL2h1MgznUTBSRwrlTZHQoqBktkO+dvVSrUMFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_10,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300095
X-Proofpoint-GUID: 2Can9WV0BpfeSx7xJWp24DdU_82-gcDH
X-Proofpoint-ORIG-GUID: 2Can9WV0BpfeSx7xJWp24DdU_82-gcDH

On Wed, Oct 30, 2024 at 12:00:12PM +0000, Catalin Marinas wrote:
> On Tue, Oct 29, 2024 at 06:11:47PM +0000, Lorenzo Stoakes wrote:
> > Currently MTE is permitted in two circumstances (desiring to use MTE having
> > been specified by the VM_MTE flag) - where MAP_ANONYMOUS is specified, as
> > checked by arch_calc_vm_flag_bits() and actualised by setting the
> > VM_MTE_ALLOWED flag, or if the file backing the mapping is shmem, in which
> > case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap hook is activated
> > in mmap_region().
> >
> > The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also set
> > is the arm64 implementation of arch_validate_flags().
> >
> > Unfortunately, we intend to refactor mmap_region() to perform this check
> > earlier, meaning that in the case of a shmem backing we will not have
> > invoked shmem_mmap() yet, causing the mapping to fail spuriously.
> >
> > It is inappropriate to set this architecture-specific flag in general mm
> > code anyway, so a sensible resolution of this issue is to instead move the
> > check somewhere else.
> >
> > We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
> > the arch_calc_vm_flag_bits() call.
> >
> > This is an appropriate place to do this as we already check for the
> > MAP_ANONYMOUS case here, and the shmem file case is simply a variant of the
> > same idea - we permit RAM-backed memory.
> >
> > This requires a modification to the arch_calc_vm_flag_bits() signature to
> > pass in a pointer to the struct file associated with the mapping, however
> > this is not too egregious as this is only used by two architectures anyway
> > - arm64 and parisc.
> >
> > So this patch performs this adjustment and removes the unnecessary
> > assignment of VM_MTE_ALLOWED in shmem_mmap().
> >
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks for respinning this. FTR,
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

>
> > @@ -151,13 +152,13 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
> >   * Combine the mmap "flags" argument into "vm_flags" used internally.
> >   */
> >  static inline unsigned long
> > -calc_vm_flag_bits(unsigned long flags)
> > +calc_vm_flag_bits(struct file *file, unsigned long flags)
> >  {
> >  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
> >  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> >  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> >  	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
> > -	       arch_calc_vm_flag_bits(flags);
> > +		arch_calc_vm_flag_bits(file, flags);
>
> Nitpick (but please ignore, Andrew picked them up already): one space
> alignment off.

Ack yeah, I saw that at the time, didn't quite know how best to resolve as
my editor wanted to put in tabs, but was already mix of tabs + spaces,
which renders different in diff than in the actual code... but in case good
that it's resolvd!

>
> --
> Catalin

Cheers, Lorenzo

