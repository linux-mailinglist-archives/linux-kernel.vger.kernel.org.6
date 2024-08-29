Return-Path: <linux-kernel+bounces-307709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85B49651CC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1641F226A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD1E18C33B;
	Thu, 29 Aug 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OJSWig/t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mb/AE/zx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62570189BBE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966596; cv=fail; b=ogD5KEemquALFpgLQzD4sDefA89ooS8NcfWaRa9wHFRBF1qL/rO4dhZPZ2/SmebghRQhuoZDnV2ycCWzAdY5EDZR87nZJUjz4P3FT0pZ1fTQjS2bElTF1NfFB8hDKAMeJYlLpcCUROG5AyMGmh2VtRzTCDSb49TVNKS0If7Pn2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966596; c=relaxed/simple;
	bh=Z8mzNSLqWp75AGnTSqZQr0jAU6ALES82VuN5JJOen7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S2WZ/DoaNhfttqN2VUCaaLcZafM6bwhvsCqj5wptAaRglOv0iLz2buiqbV2rk0u0lcmQulZ1aOYR4STrny/Dh/bmNoVdpVPNFX54+gnF0DxJtj1nPwZ6+upRFf/vh28/cVP0eiCCBG5ORzPf2hrrvmVEw0C2B7miZh62tyokJw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OJSWig/t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mb/AE/zx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TKO4w3004619;
	Thu, 29 Aug 2024 21:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=a0mFVHebenHOpKe
	kiFtkPZCt4lkt52XPsAwdmcA7AuU=; b=OJSWig/tI8Oqhr22n4OBVu0OgXh5Yx/
	xrkycZfjy1p4FHEptUdw2Hf0wduDeW70ckL6t134uHZaFq9kIZ9Ags0e/n5PX/Wu
	fJ32YVQ10a8CCwwTAEO+8IAnMzxckeoyPOPNdOs7KzSJTDMjqBjD/Kxm44lUnJox
	9waeeX2DRe93zgjD9F/An5IopPZcuFpr8iYMJC4MZE102dPKQ6aCuQy1b+UqxOD9
	u93yaXbnkEqRYF4/wNEnef+edHOaS6MCDtIvh0urFt20YOgks1cmAmrHhQBtVjsM
	OK566gaZ3kSePo5D9Lkg67aKCKeOccJ8NJ9AgS1hFy76gPTMBUsm98A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukn7eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 21:23:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TKUQYR010593;
	Thu, 29 Aug 2024 21:22:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894r9q8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 21:22:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRhADKIa9CAQ4UJeAQLCrwPmIGx7VfgYxwxqe3GOlQRVx13jT/wDdfAzIloxL62j3rqMpWU1B/sWlvtP9xTXl+ZA/wwzjl3VnRK2pPqZugOrqkNd0XdZDpDIEDqWVDkp2BAtpR2AP3Y+EyGn3KdgYBa+GKMk+clfVqklyzjZGoI6AuPnbJLSz6/JuQL1BwG41FIPpoz7M7Lw1H5sssTZObVz5FupewmdaRRVE5spbLUmJYEZN+ujHJigF7qJHQL5WKxGaASpqyb9t5895HzlJr0Cqi5uxUsw2JUZ6/PW2Sv5vyDEOgmud07TsI87jjmE3cELHPnTRmYCA/rcxWLZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0mFVHebenHOpKekiFtkPZCt4lkt52XPsAwdmcA7AuU=;
 b=i5UJ2lZ0UjWQbTZDBIVXZwDtV1kHw7HREYrYUN8NakfH8UOvAWa9mnZ0TPMqIfa/ZsqfDe/VJwNV1GAoBl3bKV/VmNZ+sscqRJmjj3lZ9gp9BPH9os4FAAJHpvUS7olQrcguaFoxKeHheCChImBVunkYbuWoaUnULl4KgRn2wsRjqLSrYf19AVvo98lSMOpmnY5pT/BURzoYVj+dPmY8YaPSF6kqucYgNCv+v4nkb8gheq/bFIfH6OGhI4NA1xiXzb9rb90BME5ngpyn7tR/7dDeLUgPg7Vn99KHQT4usXQHbX81KGtPaymrYLrQNLjPiaITiouJze0q951rZi79qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0mFVHebenHOpKekiFtkPZCt4lkt52XPsAwdmcA7AuU=;
 b=mb/AE/zxDqaBcbw76wQaXifeQW6aqgzUsywX8UuIWCTP8AcI57PCXurIG1reGLB+DZBIy9xNXDHLYAG6z9JA+TG23XrETyd72cxjbUp/ciDjEWxTNikCZbzwNy5BY1XTJSRvEuDQiAZmmgmhB3Cbx7Wmr8Yuw1q1fF5vdvEr0fI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Thu, 29 Aug
 2024 21:22:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 21:22:56 +0000
Date: Thu, 29 Aug 2024 22:22:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>,
        Aishwarya TCV <aishwarya.tcv@arm.com>, dev.jain@arm.com
Subject: Re: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <9dcddc2c-482b-4e12-a409-eee8d902ba26@lucifer.local>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
 <51452bab-65ef-4924-8ca8-61536d2bc168@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51452bab-65ef-4924-8ca8-61536d2bc168@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0506.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb41086-7468-4569-15bc-08dcc870c03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ec+9mG/f58jMIvLIHZ944RAiql6Oql+ZEFGxO3Q30vUu4v1Dpm534PFApNjW?=
 =?us-ascii?Q?VFRlHCVTVXV+3QguJjzjn63dKuYSJoarY//2M4Bh1e1PGYSNxiuPLryLTfQ+?=
 =?us-ascii?Q?uDTkZit0Kw/C5lnjtQa04Udzg30mAIH+cDT8azDmb4la5MKJOoF8FML9FLay?=
 =?us-ascii?Q?Z4gGHuvV+9MfeTysbQTC4Nz+jyKmDBbiXtdpb6yMaDqB0kU6sxSHX6wxoeSw?=
 =?us-ascii?Q?z9fTcvygQbAomVilDBOd2M3bupP1iTIGtwsQJ5r45dKMarlJHdkt+8BRXdRo?=
 =?us-ascii?Q?dKnHqT63sMynE6ttgAbdt2EKYqAhzmzlU3cTa8w0qe5Ip3GHu7MWrWw0hYLs?=
 =?us-ascii?Q?QwxotgfJRM+MXLC/yrAwuHy/0plHWh/uUf1HPK82fxNdGArRyWYGmt8YTLxV?=
 =?us-ascii?Q?KFhrmUqweOwgZIDxJl4YryiSw9xx7tzwnLiCbuLmKr6jVkz2ajlJqhcgjUZO?=
 =?us-ascii?Q?wHacrDG8mktDQt3vwakhJ0hh3H6rhkvTk44Lnv3/uqil7xU3AAv22LUzRx2r?=
 =?us-ascii?Q?qAt18te+jUdyThruyoMSZIbnZLdAJW8lIT/TcFclt4mT7WdROyP4KJ/3fsit?=
 =?us-ascii?Q?XBAyY2OQy1zh05U5GzDvAPcRYgMwp8mmNO/XkGfQnXnpYK1E33ZGibLRXNH7?=
 =?us-ascii?Q?TZ6OIbFH3fLHJAjgyTNlreS8k9nZxhR0KdNk4evmaBnB5HKeYa7wRDy3DojB?=
 =?us-ascii?Q?Kor2hsFVIWPfyG+4r8PdoYYwN0k9s1xl2OEJU8sMA3qkEB/on2IpPxb/UTeX?=
 =?us-ascii?Q?mibPPhKA6MFLjHW5x7H/jSvoBYLx9LhHZ6vnpKmD76ghHbouwgPwvOOhnaaq?=
 =?us-ascii?Q?ONWObLgxNxUtvz8hkv0nD7p9dMewXFqdgjB5y7iP87uXJ2LCOfHbBWCSwVhV?=
 =?us-ascii?Q?A0kh6okyRYj4Rzi/JIXb9TrnM8mVJmwZzziAdljyYaaquKkzRJHKM3QCdhTD?=
 =?us-ascii?Q?nZI5a5FLMX+b6KcBSFYvqLa1zKnKxgQv8JUr8MS1XNN2SCr67cNteTWeK+4n?=
 =?us-ascii?Q?uTJI85RmcQiTT8biVYKfNtOhTK0kvllLYOwl2M1FJwiod/YCWWgJ1ddYBZB2?=
 =?us-ascii?Q?LiOgsCt3sNOff8U7MwE7Qbemf9ImBQ5Ek7Olc4P6REhIQOH5GWxGOJCFb2HX?=
 =?us-ascii?Q?fUE7bQhfX3Kz4BO673gbWTJFA66fQwYZMV/oyk/3SWU3fLEtUzbusqdiKXAd?=
 =?us-ascii?Q?19IjKCaudFad4FMoFnv3615ums6k899muwE2n1wbyfUs9FbUbyq16VB0BIiM?=
 =?us-ascii?Q?5GkqIi9cK/ohGwD2BrPVoBIJCm21U6W3mgLZOujjKPwFs12Us0xuy7/TkczG?=
 =?us-ascii?Q?KQP09pIRQQofN73e3Fqeob+VvtoP4a4fm7yE56iJI1SWLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HaGmKqU8kgBh0ImR5g92vyOX2rLz2wss8MIqk864zB8eINzCRF/nAbDo/svB?=
 =?us-ascii?Q?KseCuf4EvoEyW/w67unitwdmrwyh2sgS/vZQcVr2eHkbBkECCGe90MLJmqRJ?=
 =?us-ascii?Q?+KZacpSskXEINaAwnwGV/6qEQ737ItlmyLvuWijZ3alZvaA9TF9ak30tOz5T?=
 =?us-ascii?Q?NHQPZi08Ox3c5KQ4wGY5SU2uY4lE9ITYSH6drM1Ln+f8OK6b6KRFue3fZJau?=
 =?us-ascii?Q?MzIYB1iFCL9CXFUoHaRBsLjbTPiR5ApxFAB0jg79Ei1WshhZkMTbwLOKODyP?=
 =?us-ascii?Q?3MydolJ5xGz2AeSPhDCQWnP1tMZeD+LTIsmOv66cVhfGMMZHGWttXflL3uUT?=
 =?us-ascii?Q?8P4+JRHC5693NBU+Hx10+J6vf+lVwgh+YLekbMSsWNZSBqGqFhFRZNjAqyPl?=
 =?us-ascii?Q?lYF+JOrtRgpjGPwAWlSsFo0tUEKJrx45kmMNg3PBdC0RitrSvIbH+ExcXX/P?=
 =?us-ascii?Q?FDSKFk6rPnLq9aKq89ON4mUrcRs/QrPbmWfY6BYGk4oBF70RhK2jAY1V59Rm?=
 =?us-ascii?Q?6o1XDSl8mLA5QNPFo8XLBtkBgzPCzyyBb2qZhE8RnJCqZ5XqW1Up6zGePN0s?=
 =?us-ascii?Q?3zPIJaOnjyBK9PIUTdUwuBoNWUwS257/nQVfyQs0Mq4Ft0NiQWwfx7phTba4?=
 =?us-ascii?Q?PmO1gUJGm5GIPDicRagUnr/MNXM6NEwhPeJtUv/udVYjumdAvAv77flCL53G?=
 =?us-ascii?Q?3csKZbj07WiLBuxxL6Ehp9VxY5LvqhPHn/OvkCpJHfHuNlCz/9vGdJxlLD7H?=
 =?us-ascii?Q?i4n9ptdcwxv9f4rNfmVpQY4biEUVhA5m+PLyCm3Q5xQ4HlnAA872MP+gTLa1?=
 =?us-ascii?Q?OFwm+m7vxA3nvDc7vtPtWl3z7OSxtIvpcoZQuXcJEO86ecbGiC1pE3YRMVCr?=
 =?us-ascii?Q?ULQSqpUyy59VF/ZD/zVveT8owNHRGtam2Q7cenxcbzspiI01LR+574fFdwSM?=
 =?us-ascii?Q?aeC3qKgjd7pI36+Q9pLTgw/0q8mRSXgkMogg8YdzrW0bm7Gxwf/YAdgxVcys?=
 =?us-ascii?Q?AHDNv/27gU0iridrAmdVjbhYFHPRCFWWDg1mJytLlSx6zFTkQPgvAIQdBn+P?=
 =?us-ascii?Q?RyUSk5yfHJn4USf0GoZZAH8afEtMlutJ1ZzVx85Ih5NgX2MqLQt047uFoXnJ?=
 =?us-ascii?Q?YAnjkhjdTm3WSVoZi/8ZyAf0V1L4Z6N28rpChB7bLKDb9K7DU75bMRupNEA2?=
 =?us-ascii?Q?yGnhKjvaHHNQijeEjhMLONRubsXsDjv92V/bZcQIqGU0s84FSA6li/o0RKLX?=
 =?us-ascii?Q?pGhjgc+CB+5emMwtAsN3nAcTUF3n4Rrn4EwO3BcO+5MKD1k2FUctqUTHK8vM?=
 =?us-ascii?Q?ZVpg5cBjWZlQ6u550NJLXL+0S3sL4Y95z/GNHFAPi44Dy/6dvtb3YBiIABrX?=
 =?us-ascii?Q?9y1khwU36P2l38QIUNAhCpUWFEP3fkpZKxONiQl5x/+jzPtGqws+7GTm+Cz0?=
 =?us-ascii?Q?2MocOtMEg3weHePXoVffr3WmY43Oy2EIZc+fNpthpNsNagkJNbR2icp4E6k3?=
 =?us-ascii?Q?4/5TIh2PVuSP+viCFX9awW1U0piEuX2Gnep79ciaaTLxEPsn6M/QKY6sFYfZ?=
 =?us-ascii?Q?HyrO8gYTfdY7zH2genz0+QhoRcvUSRcA0cnaL51uHBQ1IEaAyV+7R4to5Zz4?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xg7GfuvHy900IQ3xJEJ7vOlO4lDVwm+WE32jCzxFugD8c+/vjQW9nNGt9mh25soE675O8soRrdMocuap8XyYtXUrtaPme8eiIKcr3SVfRlI2kld2PcughNPl9rlRUm4r320oYr5ztheBUjvjr+tnGEPI+OKeVFM8/V55wTcHINnCLnjK5e4RZw/PWrzWQiAURmmWQZpWtFqRrzJSyIyjkMqebX/CslHmeYmYvGGco2B+S2qHsEvqDvF1s4R7MF42/qfd/NQObP4qTSQ5Qs/jftvmVpDUJCFMe0dxg+kB3CS6EL5YqQaZM7jYG/PCoe6RgmIEIr6xuSKXO4agyyqvjYYcXb8lFYtNBXJ4h+O400z/FIHLVv6y20h3uXx1sSS0f5ccPAUiB85hVSx2n51k0IWfjNcuU+ZY9t34q9K+1sQaQ6WB/8YokhsiRLsdu1AsZB4eEtIxwWlphwWT6XukhgyamHr468jAi4KnaSWzkAYquClrcYO/PXPCsMoovJhZGe+n8fw2CTYVPF4PR6pPDw/5bkF8yUliD4YtMwLLK8U5bpXvzWDNTc6jch7VIfbeK4h+idI9DqjzKWhG5UYHtGa9RdUNgGkUGlTTPyckJcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb41086-7468-4569-15bc-08dcc870c03b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:22:56.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAj1ZASdGMv5D6N/ITNGj3Tf5qCrR7pMkjsVZal9U2BDgkUNwodKHMmf211if4ZbglUfno/XrS4YDFIcPgb+sRa7DZs72ot22+vtt1XW+0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290151
X-Proofpoint-GUID: hkAcHni952jiIrtlzXDXJYjrmNfrtsaX
X-Proofpoint-ORIG-GUID: hkAcHni952jiIrtlzXDXJYjrmNfrtsaX

On Thu, Aug 29, 2024 at 08:46:28PM GMT, Mark Brown wrote:
> On Fri, Aug 23, 2024 at 09:07:01PM +0100, Lorenzo Stoakes wrote:
> > Abstract vma_merge_new_vma() to use vma_merge_struct and rename the
> > resultant function vma_merge_new_range() to be clear what the purpose of
> > this function is - a new VMA is desired in the specified range, and we wish
> > to see if it is possible to 'merge' surrounding VMAs into this range rather
> > than having to allocate a new VMA.
>
> This patch, which is in -next today with the fixup Lorenzo posted as
> commit 8c9d0f8b1e9a42586, seems to be causing problems with the mremap
> expand merge selftest.  The test has been failing for a few days.  It
> unfortunately doesn't log anything about why it's upset:
>
> # # ok 15 5MB mremap - Source 1MB-aligned, Dest 1MB-aligned with 40MB Preamble
> # # not ok 16 mremap expand merge
> # # ok 18 mremap mremap move within range

[snip]

Thanks, I figured out the problem, it's not arm-specific, I was running
self-tests but eyeballing-failure resulted in me missing this.

This is a product of vma_merge_extend() invoking vma_merge_new_range() without
having determined the next VMA correctly, after moving from vma_merge() (which
looked this up for us) to vma_merge_new_range() (which does not).

This is after having adjusted the assumptions between v1 and v2 of the series in
each merge function, and I simply missed this mremap()-specific case.

Andrew - I enclose a fix-patch to get a fix out for this asap, but I am due a
respin relatively soon and will also include that in this.

----8<----
From 3678f8a53f98de52f11946d4d32e6fb239d11c2f Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 29 Aug 2024 22:18:02 +0100
Subject: [PATCH] mm: correctly determine vmg.next in vma_merge_extend()

vma_merge_next_range() requires that the caller specify prev AND next.

Failure to specify results in missed merges. Fix this by explicitly looking
up next.

This function is explicitly used by mremap() in extend cases.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Mark Brown <broonie@kernel.org>
---
 mm/vma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index 7cddeea907f8..bd35abc70ed8 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1489,6 +1489,10 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 {
 	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);

+	vmg.next = vma_next(vmi);
+	if (vma_prev(vmi))
+		vma_iter_next_range(vmi);
+
 	/* We use the VMA to populate VMG fields only. */
 	vmg.vma = NULL;
 	return vma_merge_new_range(&vmg);
--
2.46.0

