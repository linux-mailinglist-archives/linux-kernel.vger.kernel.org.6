Return-Path: <linux-kernel+bounces-306772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB32964356
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA0BB24F25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3E419306A;
	Thu, 29 Aug 2024 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n+r59QpS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wDr2yptc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71E191F97
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931729; cv=fail; b=GyLMRSEBjorCLnmWoa896rfKuKAAbZTKSLpApela5RSakeCT9b0ZeegueDBHfO6NaOHxrxdr1+OsFgvGyOvZBln6GCPvGT5d98xad51oPamAyfbaVMc/WECBaHLi/O3xyYJmGrdNXItFoeGpANcggPDif5nxjp/0MYqMw8gMyCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931729; c=relaxed/simple;
	bh=vTAptiu/a6Y1yQMO+zjHDu7hEJ9fvRPvl7J/QCDQhAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oUMwC/KoL1+S7YaAVmxmc0XPCxq1hEBP6XKn9qHom4vmZlFlC+WWSVE9Y/WYvjaGrrjeU/Qnoz13AZDyTksaTVKArx9pIy0T6h6f/o7NqRS1XRLI1QyYntl2S5GmiWdnZj5v41LaYxm/HIuUVFiZ9Jmw9mEM5JSh2FoOMrj17us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n+r59QpS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wDr2yptc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T1g86e013788;
	Thu, 29 Aug 2024 11:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=eDHFWJc8ulMh/fm
	w2TTcqrl3QvAA8r3CoS9n6boCw68=; b=n+r59QpSdJPB8oja51tQI5jeDpLs81L
	jrV5nJGZ1bFXscQelinr46XYhU+EONqngwLayBIkaABzdi1qVFjVo2Y/3bQih/M7
	zVmtOtMI8REl3M1W1IWHPafawBm2BcBOHo/tLX2BXCVuztUQyJERZEmcEFKBpcd4
	JH16H3+2kktXI+b3RhsX04KFWEifH2yJtPAYnXFvvC8xqo/lKBldUgVEbQfxy1Ix
	w8Zj9etQpQpVnr2erAnlVG1Sh9QyZzhFQoaeyvUAgqWP536kTsPCY33Xr0S9FG45
	oOT3M+JNyNAszAN9TKUnErC9yN76eMzNqRXbJgZNZtLzdRjf4FrH3/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukkus8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:41:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47T9clHE010198;
	Thu, 29 Aug 2024 11:41:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894qkqd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV3wO5x/GcrSJogHyjWN9zZSscPvT2eNgkJxd44ifWlJIq6FFDTG/88ytBN32qVLRBkMEh/wDgpjd9zWXxGzIEwDYYTrX8988wi4qmnR58j/XCOCdXpMbWfPDoZG2m15BVKezlq8Dn5HRUBOth5jsyhaqZmTRFPpToD3TNiihKmrgepOIgmA6DXegx6XzPh7d+oYYOCEVNTpzP7ZBs1aI+AJTkQ7YrzglmNpVv+B8s4NQGOZc3EFLX+ivb2iYVf9eTe06QhCnbVxCdAudwYVeV0FkCNcUSpPxpEtGNJW4BvkT3RN7CRl/GFb76hRIVpTCG613hw6TVBq/g1qyrIhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDHFWJc8ulMh/fmw2TTcqrl3QvAA8r3CoS9n6boCw68=;
 b=YpuNKXKaAUsRKkyOJe2kf2CmCfZEXgWB30PIzaxOlVqdCNKZCqUo73lwX0FZ3MNBEmfqjHgB0H03C/ct9FctTSf4kBkpiXK13EdGduMUmAHVR8VhYDH1vOEposp9LRegeParKHEfVSI53MiqFTtQzetb4I4xF0jyhP1wM8v46GQj0ui46xrHUQkFYu7KJuG97R60IbVsvMRZSUyVxsYP4g1wO8c+FNYHstNXjmgHvrONCesbsyJLps1yuPuXqODji219zrNgRrTgLRWR7s4tYwTJqgHFBbD9v8zvBRNe4KcYUO08FzLZPfye1rD96J/iLyWktLOC+HXBukvJPIJlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDHFWJc8ulMh/fmw2TTcqrl3QvAA8r3CoS9n6boCw68=;
 b=wDr2yptcE4cCTbNAcJFCPnN+JqsBohWFd4O/19hZ+e+rjFXMtgSTvFFPa/nxX3unIIj66SCiSjZgjSwHfP9NJaTBzIeG5capBbL7S5MtAOroB3T72aE1uPnH+6lirr9cEmW+woe09iFj59znT7MZUMV3t/usKpI1SbZbZp4VuSY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW4PR10MB5773.namprd10.prod.outlook.com (2603:10b6:303:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Thu, 29 Aug
 2024 11:41:55 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 11:41:55 +0000
Date: Thu, 29 Aug 2024 12:41:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Xingyu Li <xli399@ucr.edu>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: general protection fault in mmap_region
Message-ID: <de357fee-ed28-43a9-807f-bb3c53ace661@lucifer.local>
References: <CALAgD-5myPieAa_9BY6RVfBjWT_8g48+S0CX7c=EihMzdwakxw@mail.gmail.com>
 <c981e6dd-044b-4a7a-83a3-5c49a31d1ec7@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c981e6dd-044b-4a7a-83a3-5c49a31d1ec7@lucifer.local>
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW4PR10MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdb8cf7-5bf0-429f-93c3-08dcc81f9548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LKFSQhEN/ks7LJ86rmy5zkgfamRsfzLdDw7BeU6DKy3ejs59Ew6wRGnBJ1gF?=
 =?us-ascii?Q?qvajzpaGxP/ipm7601u5wbkTntDBPBarUhAE3yS/aLq3dyaou3vr5VOLMVyr?=
 =?us-ascii?Q?JDiXuV0CZJSziDombwHel1+1cM4ZZTRYdzx9ZMkZ5jXon0uZKWqoV4sckZNo?=
 =?us-ascii?Q?d72gDoB6kySQQvGTeWCHJ9fVQeKheIUKC2eQ/Qu+KuW4ihKdvVNlYFnfpTpm?=
 =?us-ascii?Q?MrhHr77axGwN/GNdW0Hy0EINxohfk0Rv8AVUFGpAJpTWnbDJXRtd3kjGX8VH?=
 =?us-ascii?Q?R34WpPMQnrhfMVpMiUspKuYwZI7IHysEiZ9BfYaBJT/6+Wr4x47j1VOA8haK?=
 =?us-ascii?Q?wD6RzmoLF0w/2wX6K9OVcZJ9+FnNRP0O0D+iG0p27srL7LW0ruDRQ8sYFiDG?=
 =?us-ascii?Q?tTFiQffporu4yjS6x8AsKTavTAPbh1ZfjlbJLCbzAN/J+6Pes6ywiqbfRA+i?=
 =?us-ascii?Q?4+3u9GNXHy0ekn2W1BrL6IaRFvksXdrnADHPN6MkA1I8YNtmyhRF7WH5/mxh?=
 =?us-ascii?Q?sfREtvW3e/6tfvpByqTcxG8blCbg+Ki90DVWIGf1imo9iTdWgq9qZWl8tdRy?=
 =?us-ascii?Q?n5qebNlgUR950CrTO2rqTypnuwCJ2+1JR6EBA65brXTuUS4T2svYhktSehrS?=
 =?us-ascii?Q?k7R9DsrpCfRL9ya5GOmDXUOoPBd9Tc37VegPwCLudgyQaE/v6+VRJ5lcRSLe?=
 =?us-ascii?Q?phuLbOeZcxn/tITRPXrpZYOSIY6JixIxGtC0N/F0+Y8APPjs8LYtNaEZQh1G?=
 =?us-ascii?Q?bfKt8fPW7mKNM6LzbUWfIVnSLRaoZZSEhAj2QaS7bFCE7qjenXUF/iTn8d1H?=
 =?us-ascii?Q?Id4DEgbn2N+Pdrt2GJIvKqch9M+5IAHtWZmYFNsUG12+mdy6TEVI7aWyGxXO?=
 =?us-ascii?Q?nlKAUCc50qt6Z67QvEY/At+vFd0XCEpaD4cikw6UMx7pR1ddqHqoT/Kgc+Sf?=
 =?us-ascii?Q?bmA/BgHoxFz8g6alUTOFrbudbc8y/33AWbqA4uDHp9m+s+9Byi1IIoxuGhsR?=
 =?us-ascii?Q?aNEaPASC0LdfENEXAAe6rfSBOlIBwQNJxtNHv2I54Ld88oeLj9tJwKXr7Jj3?=
 =?us-ascii?Q?TJjYE7BoqkrXx0uoFb4Xg2r0Ej5J967hKPKhBL/uY4dYLTJNTxqwXW7cnM0H?=
 =?us-ascii?Q?RuiOjonksjpeQywkuHEsi61vWsAlBAK/tpctCoHwMGbKQBx+sLgVZW15CvaG?=
 =?us-ascii?Q?6cYzYbxsCA7UUIBpL9zMb/yNgCzYiPBDNOP2vXx+2KJ6x0254gIsKsMUzCwo?=
 =?us-ascii?Q?3/HEHuq3vVzOTeXv3kF/k0BITRIU9/JMzaXrBpSLv5tLRrymIZizbSrQdY/a?=
 =?us-ascii?Q?nS90zfrstMlWtk8UONu1HryTjWexiTZ5nqQ07hSZTQt08g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7t8PjN+tUatLt07nIR7lGHl+Zzt6w9TZcpCBMYahraqxvy4vrxVeoXKmy+A5?=
 =?us-ascii?Q?fIwin5wbvigqCJiT+aQ48DwKJqIZKP3E+s0NDM275cIzAYxe6ygRM7Tf0Jzi?=
 =?us-ascii?Q?VNORWd30yiyN0UU7QaW9mHl4XNzjx1gLuxCUgrvkdpVheIfibzt6f+2m0bT3?=
 =?us-ascii?Q?+5QkEKjpPTJ9WbWhofUMIiEVI602LW7yQdhGPUWCHFPCNXYe2SmjUW3Jk+Xv?=
 =?us-ascii?Q?CD1r36Ns+0BlOqu40bS0rE4BLVdX/FFPmnYQ7O7m08YI9xCS2B7j8FWQAgV2?=
 =?us-ascii?Q?sVn9yMjHFyiKc3d0IpSo9L/C7Ofaiy/BwTW0tPvNLCBAObyNuZ4PuW7OFoT+?=
 =?us-ascii?Q?EOfHnRThe4+bPYWkxPbcKLC1t1/0Nj8aVu7usQmqed9O/WPhMKFCokrUs1rY?=
 =?us-ascii?Q?Mvd9aCft+WexAm1ofTxLNVRTZWHBxcqs8IIm5DujY/jSS3XvehIhQShIdzDU?=
 =?us-ascii?Q?x0bRJU76J8f7CBnz7O5I2nc7jb7uinvvpm6KAuBnO0YzXBZMxkxUgEVDidBx?=
 =?us-ascii?Q?DI4Dw2JTlGu2z5o36Av/Qr6GMRmpXuTSlJAbJ12lmh2wE5tiVuLVuR01tbun?=
 =?us-ascii?Q?EuKx0ycBVNRIu3ruw7F/o5T/rDB2qhZwQAHFKlAEBRYxYxnbFnREOsBcdCZh?=
 =?us-ascii?Q?L91Rl8cQJSU8HOvsy17sZL7wOSK9TpskCZBSalbHDhmrqm/cJdm0oT6cz2Qx?=
 =?us-ascii?Q?SKdqaoLNnqs+TEVCw/dqmcBYUGEhYbChRUKwq47ADoj64cWW0TvCxML6gB+d?=
 =?us-ascii?Q?WUq0Z1b6VNjTZYHKP7n2mC+qj04C5MHyztKg1t19Cx1Zp4wnErvi+ta6U6gA?=
 =?us-ascii?Q?S7JL0X+iqkieDQmeZ4yJTrLPYj9+5V1+7Cu319Hv/OohaDNFPzc31HfNhhVM?=
 =?us-ascii?Q?565ONLKMXqluxyZA2e37MIbC/A4573Vf0mMZKJ8UuNNMLZ9behcTV/dH1p8K?=
 =?us-ascii?Q?HNOn9sOFaIclDeYeRCw4MhW93m+DMbvX2uKbKOlzvHphhZUA68cCXKsL3QMN?=
 =?us-ascii?Q?HwgZm8Km2tpMjB+DNpqPJAJTvSo1MVw2fVOLNhn2KI5CIp4QsOS095xCR9av?=
 =?us-ascii?Q?6k8UUjQNwW63EY/lihOkXlsGKwZ3Io2Eq7PWqTulU97s8Rt+kJRPrvE1xAlu?=
 =?us-ascii?Q?+ItDnMTag80iUiPGl/CRXuoxH8zvP609ojmggDtRFqsrftOJtiK4aBwPVidW?=
 =?us-ascii?Q?5a+UK/4NvON55XQF3ftHvh6nOttRWyFao166kRf7GW5Slw1zgqLKRka0gfCJ?=
 =?us-ascii?Q?VoBHYChLhvfE4X4VELK1W2tSwNhlELFKH7z9GfgEkTwteHx4WQq4QawC38MI?=
 =?us-ascii?Q?Gxrt99ODm1C7DeGaVcRt9MEoTLJ+TJZd8NLAG71ox8Uppsxz4dWT8HJIR2RF?=
 =?us-ascii?Q?Twx+j3gd9cGAzunWPVbAm/39hPy6DcITEV25OpZ6Albm1EayGUwLr3OQF8a0?=
 =?us-ascii?Q?caewKM9cKW4fa/HoO2yNkKw0fRqTxGemDzugw0EvBKOJLnLb6+jM2dAtduAN?=
 =?us-ascii?Q?yYdTBlgJkwwR1Ii+UaD+xsbTuRNwuvWWzbgZdVFJZLdedYs3sAPrjiHrJwd1?=
 =?us-ascii?Q?JQJndcCm8QeW3fKD4YKFWgAPjbHyWP4DepAH+SLZZMHkwyGH19MldeEKdZ02?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HnbZiS9sZplQ4AH9+1qT+1QzXa5IHsYHN5GJDrr2OnPfKN/aZazmaEQF5g+1qlF77ECxYxxOaNJc+cCYxyj48HXkUhjRfpKlFija0JDbYuxj4QvabvyRnemu7Qsribr2M+uwR2giOQseXhb9qBMCm3Rkb3uYGdicJ2d4seKmduk3xEEb6skEJHuwIpgIXPRmTmBm2LyB1iRMChR/5D0LbAOxKLY+9MLRca+whwtQtOD0uqW/5AucmJoWZOJRUINbgdTw3bpalvUOQVy7RXPNHOGVvYLTpDcpj7r2CZUWwYKZl4f+V2bYhEWnCfaFyUn2iabvB9+ZBYIg5RzCPyzRrRsSva7t+hzfs/NXxgjIpQF6s3fh+5ScClxl69PLuHd78TalLPfbuwhZdfbHhVP0/p1THj07mTsfWn38S4W6O4JYCVu4reFrPPQCiLLixl6R780rR6Wothd6PCSn+MFUs1F/kgG41ymkx0q9f+tjD9ujF7P2/5KnSiOSavrZ5w2zia0rindip2sq030ad2zc836HBKtoADN4gSHSEWaSdHPcbDrqp3F2cOO4/RWj/nBqnxSidCZQRPX1v8ghYh7s+d6Q+c29onaV9T4A5btM/8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdb8cf7-5bf0-429f-93c3-08dcc81f9548
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 11:41:55.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxZj0s67fJKmjh2l4QetxDM1mQeaJCgTTm2qkNAuPs+sOteVn4dM8jGuttmiCcZR6m/0tEZ8UlgpbKL5pCRF4YGhsNcDPxF1AQh1fjkus1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=556 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290084
X-Proofpoint-GUID: oxaNdsvjs4VAP_05156XDMWwOLz2U-tC
X-Proofpoint-ORIG-GUID: oxaNdsvjs4VAP_05156XDMWwOLz2U-tC

On Thu, Aug 29, 2024 at 12:13:57PM GMT, Lorenzo Stoakes wrote:
> On Wed, Aug 28, 2024 at 04:07:05PM GMT, Xingyu Li wrote:
> > Hi,
> >
> > We found a bug in Linux 6.6 using syzkaller. It is possibly a  null
> > pointer dereference bug.

[snip]

In general - you seem to have sent a flurry of such reports recently, all
without important details (config, dmesg, etc.) and at least a few of them
pointing away from the repro actually repro-ing the issue and perhaps
towards problems with your qemu setup.

Could you take a pause in sending these upstream until you can confirm your
setup is correct and ideally ensure that your repro actually repro's
please?

Thanks!

