Return-Path: <linux-kernel+bounces-351519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C8991273
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76052830D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028B1D89E1;
	Fri,  4 Oct 2024 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SaNXLBW+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CcCAEzGR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9B1C3037
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081731; cv=fail; b=bDKC2ye57hznk+S6AUq5LOT6CASJpgcGfAbLXRKygiyWwaipD40KChsFNBndKovJtDsrDaP2KLKfZxvktjbLGBMUCDluuFYfmZvIn7cXt9gXrfyCu7h1g/b42fdxrbtfPwF+Koz0kOi4XxFbkNfAKlmvOChtjmexVBusEkreddc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081731; c=relaxed/simple;
	bh=mZAlq/iRQEK4oBidJEcX92/VLQ+Q01EwbN5gelqcYis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tOUXf8YiNKW17viOsN8RyQJ8PwFoqPS5AWaGHZx5oVKI5FdCa+PC5lw1N4ljWrglNIEswCZRXyuqYRqw5rXEtPsdQ9arXECm9y/1tyDDcKSIBRUiNExgp9sVZjQwCZmRQjpQmM3wp4ZmPgtb3QcTr/cdV+zdRRxXkdhOtk14IPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SaNXLBW+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CcCAEzGR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494LtxuF020306;
	Fri, 4 Oct 2024 22:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ddXzfjEOzTg4uQ+
	R27v1vdphJKM0m99zRZ5wTAyfAkg=; b=SaNXLBW+q6vF5p1MZiFVqSu6q3QqJEK
	2Fn/D5BSqTOWV6h7qwvNaHPv3t+d0z0j2IvnHOhg95GRvMe9M95WjF83r2Sd4N0S
	cO7o8hj/xSMG8r0l7APpVARBhJDQEKB/0nHRZbCrH0YUu1cM7mXEq7FSMoic0oLX
	Ertu7GaE8flqKWoh6CgtDXMkx/cccOwNfN09pRvhP0ECG2epnlq1TSKcl/SVPHyV
	HEo9e+NEcCdgf1TOKBtAB9sWUJlX9MvMb07jP7HeWMg5DTn3U178nQFVvN2a3Fen
	FnOK7AKXbfCs7PqRIrMCLvjfNBuk/8IAkGpOI2Of0AsETCRZjwR6zUw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422048akhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 22:42:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494KYA6q026272;
	Fri, 4 Oct 2024 22:42:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422056d70n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 22:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvyMEjokbEpSkT+NM9R3Ae2QUDQMZwiL/HAfAhuYMX9Mz6yDpDqsAbjO72o1J6ERwTBFaTfBfoRg7gLkMxiYrfR0CR8SnX8KHr9/wgCpkc1vgMeIRN+fCmmdBHHPShLwj2PoPrOpZiUpVcZJ49EGXNJUqJVM2Wa+Twe40NO39Zsnpge+weuXXvkNu3zw99d/zgKMn4/1HxzYSF71S1y+ruo5rP3tcP/JuJhdNg5m6Q9gofphXTHvpUnjmfDodFbr29osPUQiBfOWUc0Ya3HzxLWlfRhNstwOrmMUnG14JbKQQSD7s6ure8uLcZKQDF9cWcJy/7vg7/Z3bwBLrS4lKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddXzfjEOzTg4uQ+R27v1vdphJKM0m99zRZ5wTAyfAkg=;
 b=T6F2GmtUTaGzXHS7x3rrZDz8lag7DE6xSdtaXCw83o1tX4LkF4vv8jn/CQqqk4CQ/WSjXDSdS3s4JAw5Gd3vqsCuk4Sb5pMWjB/HkyfuXh4WgTAAIs8ZksoCRGX50rLIS/jwb4RuLu2fGF6SwCR5Y+1pyimfe6IgxReWPnjzpAAupYNOCXQy4z8kCyPz1cX3dCKdnpgULyR8x/V2StVisZKNGl/LeVEozHLFw1tkg1hYF5ouwJ1FMEMka5UjHfAjdON6Y4Z8xA4U/QdEdQta6iQVVQqq+64xFhLoL0Al0xM78xxCN1fLHVo/t7WFRKdxMi45BfMw3YLq2qmTx9Fmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddXzfjEOzTg4uQ+R27v1vdphJKM0m99zRZ5wTAyfAkg=;
 b=CcCAEzGR7we+ePa6s27OdSuXFc1s0nTN/AZpVqNcq561LBOOIFiEyGv/FLdifoCMDWQ99MguIKyXJ5YelkfJWUoDJPLebk5vdMFIjG2e8C3X859K4yU1nNcS/LDGWT2+5tRhrAQ91AGHv+AvS2rgPek7Qhje19jvBG6JNt8lUZo=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 22:41:59 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 22:41:59 +0000
Date: Fri, 4 Oct 2024 23:41:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <3b83746d-b73e-4b89-9b74-5aba5a827f45@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004093546.3232-1-spasswolf@web.de>
X-ClientProxiedBy: LO2P265CA0176.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::20) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|BN0PR10MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: b256b6f3-6fa2-4219-1d45-08dce4c5c202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LoWgWmR+B0d81ztn5uOe6atdXT7fxZhj/uoUS1c82pSmfBg1azvwDhpPGhHo?=
 =?us-ascii?Q?qOp8HAuQcm18ZqbbxFXcqz3HbP4sqnDs1fkn/600wllwm0s7MhzJy8jY4stY?=
 =?us-ascii?Q?MCGW3863a5KUsSkYU5aG2qFOV63W16jJhhrAT/lXbqWAiqyaLD3v2QFhJUES?=
 =?us-ascii?Q?7ZnRRulaA1H6U9DLzo9XXh2XyM4bgbeXBuVcxbQew9cZzeKRhi+RkpHPaRWO?=
 =?us-ascii?Q?BK6CLOmjybjvsJup0yfrnbjFsGI2gZGESiyZ3t6HaQXN4uup6tZwK3A4F19G?=
 =?us-ascii?Q?myFH5PL7nE//UHuYeqjjZOVgKGEOyD2igZ7aLujnk7SI9nV10CzsJ+TyGbmQ?=
 =?us-ascii?Q?QqDpOO5HbO9Qo+NR6cS9nTUyZdo4ZxPUaRh63r+ycHywPX20Mn6IO+GUMc1b?=
 =?us-ascii?Q?r7dhHrOQnLCUllnJ/dzfz1aWTkor+MhfvdceRYfNdysRZLxn6pOu64PWpmn6?=
 =?us-ascii?Q?ndAZRjp2corLuLgyOmDHFAbuZE/+OARrSuVaAmwp1ZE23so4no/HJII1aoeG?=
 =?us-ascii?Q?T2SkfFXX0rvXua4s1vi/pAw9F33lkCT+PrLborA7rb8bW1HML5Pw60JK8UYV?=
 =?us-ascii?Q?aCWvSiUztj7FTcnbI6hLc+CJB9d+ASIetCfc3t8eeRK72JBnATtBJwbiqPUK?=
 =?us-ascii?Q?qQa8iCe9nWOru6ubp4Ag46WrUNjYisGPPZX89dcNIIk5qM2cznMwgUgiIzmX?=
 =?us-ascii?Q?uOSYeQUPe+3igB0v9qRNlGW1hRNf4wpv8h5bFPWpvgENF/SrVUmpzt3b9c7N?=
 =?us-ascii?Q?Llix6PXN/YnqPlWM+zlaeQPV1iKWJsYSTrIFqaCIrHarT7UA5DFklk0tmP6H?=
 =?us-ascii?Q?BQ8CnffmuCF3EpsFjStaPLldyPhNuQsiYAtn/fV8oKtTYB7LTgG9vUNl5TGt?=
 =?us-ascii?Q?Tam6y3SAWTEPXAcKgfRRb/SSdi3gJF+mac2ayCqZbfgGfk3f41BuaQeCRmQb?=
 =?us-ascii?Q?qoC0qaVG3cle71vx0WEZp9rByJF9v+j3VHUSflTDwsGlqEQWVcsJCn+9+wYv?=
 =?us-ascii?Q?E/7lonBnJY21KWa9B1tMg3Qy/B4hK4MX0F2rACf+7WRyJzc9vOP5fDajcd1W?=
 =?us-ascii?Q?ZbTBJGGqbWCGnSwjxMmwQ7HM4X6abcS3TNBCgvnGYGrAE+KqTud6zoopbEH3?=
 =?us-ascii?Q?2l1qW1ToYcWmljLBHSKtu5+1bjbJvgY52tlHro3/Cicv8F5QcBbV8U3Y/qxZ?=
 =?us-ascii?Q?yrjoJK2JE9UAJfUr95FfqLFO9+PwgeIl1dGbY1wH8p48G9meeKiNS0HhM8U2?=
 =?us-ascii?Q?0FMeKQ/UBT0xUwbi9iX+Ipf9DMJQ4YB/GfYlXrbcdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sfIoEuFwLJ04wNjhykFiwmU8R1NnDPE5o7Ng3eK3T9G3KOTr0PtwPeYkdvon?=
 =?us-ascii?Q?AnNwNzmNFY6MNLRQZhVGM5GOb5ExhgFzAgnfIVOOiLZbFpYeZyT44R1pxyOJ?=
 =?us-ascii?Q?X1iRIHS74l2m+1VkQ+qy9CYxrI+UEYSDF26ZWF6IYgu1AYqQJVRen3JgioiW?=
 =?us-ascii?Q?9BZNYi5uUzC4cRmYxkkgX7Ftl3e+8mCji5yITws6KwCPwKIx+mBR8+JDKc/L?=
 =?us-ascii?Q?7Y5me247r7suZPpjOzCgvaXH9pUlEpeikSPOuQa6K82p01ze7DxzMzCfn4ux?=
 =?us-ascii?Q?r3X070fVl7FfTbKjjb+AT2/MhpGevL1VEsKbCewh3gLAzFSENw8lnHYOLDED?=
 =?us-ascii?Q?aS4CfhN7G+C0bHFDjQ92QAPxo7xXxjeCqfPsTzK+PiyHyssAJgX2/y4LJPYM?=
 =?us-ascii?Q?FdDB57RhtPMgdpxZ7piM32SA+/0W2X1nHurQjPxLbKVY1A4gFAfhJAbxytEm?=
 =?us-ascii?Q?VdzYc8s3qYPIbXHiouxdpx18GF0r8rrTV2eyuqE/FXk/o65b69oVEsDhxUrb?=
 =?us-ascii?Q?wkXo8cNGMDqv1gKGItadpjhKAZOO/2/TBkoU/phmS5xfyycSxiiR/pd9Xs8v?=
 =?us-ascii?Q?7TuBdys3E6IpvLXriVRz9jlPQEIyEwcCxWYfM9SUMlKPatM95E+VXq/wCBkj?=
 =?us-ascii?Q?VVh3UvTzqnUFmm5YZeAckrAUSfeAT3rn/1M44vUq2YHcbnczysnLLSQO52I4?=
 =?us-ascii?Q?K9exAWH962colG6Vrli1TQM6Zg8z1ZLj2zVZOnz8JUU3TJt0gzsZyBHR5URU?=
 =?us-ascii?Q?FYLHFq8QXZEq13VIx6xxmYVKGCgPp0yWb72J4pYO3Pm6u33fJtQKhrcwlHK3?=
 =?us-ascii?Q?tk39S/hiG8VEXlxbu9p6INTibwsRyBwwFr/pRnS24q6ddF2bfAU+ObHXBI1b?=
 =?us-ascii?Q?eKJp3SKJQLzZ8sMhKM4EqvmDNxlljIzL0/znKlnUA4gynwhz6wNKofiuuRLA?=
 =?us-ascii?Q?FIiIl/dVUcBWI91DXv5GYu7ilgMOScPvAafD1IFao95kGxJZZ6Yu61EOZTN7?=
 =?us-ascii?Q?obMKMdSkG2Ikec9lSJTTk5g+FpSw3mjGcPEpiH/EceX0O2CvE0xJR1oeirpf?=
 =?us-ascii?Q?4bvVkaKzuAAoz0tMg8sDKsaevfaMryxsoMij0635m9kQyBMCQ3j5XrG3hxDu?=
 =?us-ascii?Q?c7OKbIypo13PToPZECh9IjywrRW4WGpdjQRCI5LOvV16Y4z0OVfyjC6dZUOl?=
 =?us-ascii?Q?b1Xw0sKEZ2xs+4mjRPaoQKFjX5GuDa3wBjqvgAJMx+u8tkLiEXHtrvgbQRlM?=
 =?us-ascii?Q?BH61YiznJrady6ZgroXL5PuWfobYTmc2h5ivIFkNsI9ezfZH5BVZwiC/0JBV?=
 =?us-ascii?Q?x9/io+avem9EKpS9w1m1EW4HegvaYahKWZ0n/aeu3Etqaq0KGMJbXzHK602p?=
 =?us-ascii?Q?cNHo88dHLz24DGxmKfe3kEV7aQAupTj/R7vHLpFKLie55tbbs9eJ624oE7uw?=
 =?us-ascii?Q?Mm9QHxSH86aCc522YWuuVA+3vPw+rNF4xY7/X3893K5oNULp0GpTdHz5HA/O?=
 =?us-ascii?Q?mqJ0B+RsZcdvvSjqUMv7HJqlRuQgqWm0EmoEG/x/rTmEwu/I7c9WINdf2hAc?=
 =?us-ascii?Q?5swBcGkolyWGFYa6puzzurYsM66jo8G/rcmi4bi4C6VkldJU2Smdsf2g3MY1?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Ssyazbl4XNRqSu4ztFLNwcysFSXzONqeCHsNUMPune5XvOT+3uGDsm+/uZlp4cPGuBz8IM2ekTGabjY2kXJLtdQmwSaPFHoZtI0kKE0Hz0UH6p+8hOKXkscS2EABvqi+2Ml14ZLz9gl4b43bqF+zlVat1sGtCt/l1rYcdx3qg3xl+XGjzr+A2CsziY+abnqyLP+Ml8EItbkqEIK7JsCPSNZ0HhKoapTop/C1LhETw90cxUPRWGan+oC4MzgVaHRT3c0RmHl/zvk4AfRAF9hr7yq8TqXdVKvXw5z55K1xy+HtxbfbKjVCLBmLsXKT+8jVVWYnvYiPiqcFYHwvjvpPIl2y5SWDQFLtzQDJ6VxoHCMUdW5dr09AVf/7jG95sjBZxLfkl5PR/P26+rTjeOQ0Rt5C/vSz1Xv2aq1mHXqcDohPkkZqyGUaFTy4KayNOFPo1KDNzgEfCIZjoFKAo7Jig5FVNj852o7L/N8hnB7upNNnnB97MgPOvANkpQgCJs22Bv8fM06qDV5ogYDs5+BHNgAYgdiq0GY4DPb/wIG7RilHBd/1+05+GTzKSx5ZGdJj0fJomNYuJtsfl14RocAI4l6ucIw9yGoVs2YvXLIM1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b256b6f3-6fa2-4219-1d45-08dce4c5c202
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:41:59.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQE2q6po0OdPRrTZtABHE/TC6EYKE3BhSMZkE47FejTfb4IqamAOvekbPFEbMEBHFOZ35bPeUwnoayT3KpxnxB+6sxUPej4ft8X2YYbp7pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_20,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040156
X-Proofpoint-ORIG-GUID: 7lCvu8L94roopmzmVj6jHMvjJh60S_2O
X-Proofpoint-GUID: 7lCvu8L94roopmzmVj6jHMvjJh60S_2O

On Fri, Oct 04, 2024 at 11:35:44AM +0200, Bert Karwatzki wrote:
> Here's the log procduced by this kernel:
>
> c9e7f76815d3 (HEAD -> maple_tree_debug_4) hack: set of info stuff v5
> 7e3bb072761a mm: correct error handling in mmap_region()
> 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
>
> Again it took two attempts to trigger the bug.
>
> Bert Karwatzki
>

Sending an updated, cleaned up version of the patch with a lot of
explanation. This is functionally identical to the v3 fix I already sent so
you can try that or this to confirm it resolves your issue.

If you are able to do so, I can submit this to upstream for a hotfix. If
not, well then back to the drawing board and I'd be very shocked :)

I have been able to reproduce the issue locally in our userland testing
suite entirely consistently, and this patch resolves the issue and also
continues to pass all maple tree unit tests.

Again thank you so much for all your help - I hope you are able to find a
spare moment to quickly give this one a try and confirm whether it does
indeed address the problem you've reported.

Thanks, Lorenzo

----8<----
From 126d65bd9839cd3ec941007872b357e27fd56066 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 4 Oct 2024 15:18:58 +0100
Subject: [PATCH] maple_tree: correct tree corruption on spanning store

Writing a data range into a maple tree may involve overwriting a number of
existing entries that span across more than one node. Doing so invokes a
'spanning' store.

Performing a spanning store across two leaf nodes in a maple tree in which
entries are overwritten is achieved by first initialising a 'big' node,
which will store the coalesced entries between the two nodes comprising
entries prior to the newly stored entry, the newly stored entry, and
subsequent entries.

This 'big node' is then merged back into the tree and the tree is
rebalanced, replacing the entries across the spanned nodes with those
contained in the big node.

The operation is performed in mas_wr_spanning_store() which starts by
establishing two maple tree state objects ('mas' objects) on the left of
the range and on the right (l_mas and r_mas respectively).

l_mas traverses to the beginning of the range to be stored in order to copy
the data BEFORE the requested store into the big node.

We then insert our new entry immediately afterwards (both the left copy and
the storing of the new entry are combined and performed by
mas_store_b_node()).

r_mas traverses to the populated slot immediately after, in order to copy
the data AFTER the requested store into the big node.

This copy of the right-hand node is performed by mas_mab_cp() as long as
r_mas indicates that there's data to copy, i.e. r_mas.offset <= r_mas.end.

We traverse r_mas to this position in mas_wr_node_walk() using a simple
loop:

	while (offset < count && mas->index > wr_mas->pivots[offset])
		offset++;

Note here that count is determined to be the (inclusive) index of the last
node containing data in the node as determined by ma_data_end().

This means that even in searching for mas->index, which will have been set
to one plus the end of the target range in order to traverse to the next
slot in mas_wr_spanning_store(), we will terminate the iteration at the end
of the node range even if this condition is not met due to the offset <
count condition.

The fact this right hand node contains the end of the range being stored is
why we are traversing it, and this loop is why we appear to discover a
viable range within the right node to copy to the big one.

However, if the node that r_mas traverses contains a pivot EQUAL to the end
of the range being stored, and this is the LAST pivot contained within the
node, something unexpected happens:

1. The l_mas traversal copy and insertion of the new entry in the big node
   is performed via mas_store_b_node() correctly.

2. The traversal performed by mas_wr_node_walk() means our r_mas.offset is
   set to the offset of the entry equal to the end of the range we store.

3. We therefore copy this DUPLICATE of the final pivot into the big node,
   and insert this DUPLICATE entry, alongside its invalid slot entry
   immediately after the newly inserted entry.

4. The big node containing this duplicated is inserted into the tree which
   is rebalanced, and therefore the maple tree becomes corrupted.

Note that if the right hand node had one or more entries with pivots of
greater value than the end of the stored range, this would not happen. If
it contained entries with pivots of lesser value it would not be the right
node in this spanning store.

This appears to have been at risk of happening throughout the maple tree's
history, however it seemed significantly less likely to occur until
recently.

The balancing of the tree seems to have made it unlikely that you would
happen to perform a store that both spans two nodes AND would overwrite
precisely the entry with the largest pivot in the right-hand node which
contains no further larger pivots.

The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
in mmap_region()") seems to have made the probability of this event much
more likely.

Previous to this change, MAP_FIXED mappings which were overwritten would
first be cleared before any subsequent store or importantly - merge of
surrounding entries - would be performed.

After this change, this is no longer the case, and this means that, in the
worst case, a number of entries might be overwritten in combination with a
merge (and subsequent overwriting expansion) between both the prior entry
AND a subsequent entry.

The motivation for this change arose from Bert Karwatzki's report of
encountering mm instability after the release of kernel v6.12-rc1 which,
after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
options, was identified as maple tree corruption.

After Bert very generously provided his time and ability to reproduce this
event consistently, I was able to finally identify that the issue discussed
in this commit message was occurring for him.

The solution implemented in this patch is:

1. Adjust mas_wr_walk_index() to return a boolean value indicating whether
   the containing node is actually populated with entries possessing pivots
   equal to or greater than mas->index.

2. When traversing the right node in mas_wr_spanning_store(), use this
   value to determine whether to try to copy from the right node - if it is
   not populated, then do not do so.

This passes all maple tree unit tests and resolves the reported bug.
---
 lib/maple_tree.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 37abf0fe380b..e6f0da908ba7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2194,6 +2194,8 @@ static inline void mas_node_or_none(struct ma_state *mas,

 /*
  * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
+ *                      If @mas->index cannot be found within the containing
+ *                      node, we traverse to the last entry in the node.
  * @wr_mas: The maple write state
  *
  * Uses mas_slot_locked() and does not need to worry about dead nodes.
@@ -3527,6 +3529,12 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }

+/*
+ * Traverse the maple tree until the offset of mas->index is reached.
+ *
+ * Return: Is this node actually populated with entries possessing pivots equal
+ *         to or greater than mas->index?
+ */
 static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -3535,8 +3543,11 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		mas_wr_walk_descend(wr_mas);
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
-		if (ma_is_leaf(wr_mas->type))
-			return true;
+		if (ma_is_leaf(wr_mas->type)) {
+			unsigned long pivot = wr_mas->pivots[mas->offset];
+
+			return pivot == 0 || mas->index <= pivot;
+		}
 		mas_wr_walk_traverse(wr_mas);

 	}
@@ -3696,6 +3707,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	struct maple_big_node b_node;
 	struct ma_state *mas;
 	unsigned char height;
+	bool r_populated;

 	/* Left and Right side of spanning store */
 	MA_STATE(l_mas, NULL, 0, 0);
@@ -3737,7 +3749,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 		r_mas.last++;

 	r_mas.index = r_mas.last;
-	mas_wr_walk_index(&r_wr_mas);
+	r_populated = mas_wr_walk_index(&r_wr_mas);
 	r_mas.last = r_mas.index = mas->last;

 	/* Set up left side. */
@@ -3761,7 +3773,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	/* Copy l_mas and store the value in b_node. */
 	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
 	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_mas.end)
+	if (r_populated && r_mas.offset <= r_mas.end)
 		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else
--
2.46.2

