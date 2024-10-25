Return-Path: <linux-kernel+bounces-382312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5049B0C34
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F59B1C21CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7102036FC;
	Fri, 25 Oct 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WfYcly3y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G6ftih5X"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF14D1F7547
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878856; cv=fail; b=HeaVqCi2Hg4c/MZ9cgHCX7c5XSZNcqCVVD62dVtXhwFGDVRtG2ek0yLJdbrMpXNRMNw13EFxCaqujk1awAKyyhXZ+aQtKAqtYYetpELZVVNwA3HI+gjzPxgInAsyMPxK7b5RmLgTpKV6zXKsIduJyx7Jr88tSbA1HLxQhjNDFxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878856; c=relaxed/simple;
	bh=EWIIAFLhIicD5wNzOeAPnKPWVgUMq3ojzIVEMy37rJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VGaFDZX0nlqc03LbSQB1yDvkkuXz7QwhMDkto9H303QkjS8RHEmYhOS/ArYXP/W2okJoKquZv7yAB3WElVZyUd1hXcs+f7NRfgXkw8n4ta2xn/k7afHSCWR/ObIGZIhnvRiXAlSrJcIk50kG8wru0UBOgYzrRdCZUb0Yb5oJ7zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WfYcly3y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G6ftih5X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0Vbg018112;
	Fri, 25 Oct 2024 17:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7afHP3jBgv4uE8XsrB
	0KCrIArf0iVAwErLB8YRwgmQk=; b=WfYcly3yORVVTkUwznsb846NpXfgQUcd7E
	h4O9aD/ZC6l5m0NgjQcf3A4WFp9U81oba7ZbeEHxIWJvDFijSe8swWum6Vz+F0QS
	Ax1M0JB5U+oD0pQKb9Ld1tWuhUCGUklDCcR36fKi8Y6fMEAqGkX8Z26UdEAaod4F
	1WxvpC1Dj8U6PVguzQkabvZD7eDJpgNyZ+H4+s3Ru0Ns1SqpNzFO//el+cbDGsw+
	zJLB+dLjsGMvlj466QBHTIgXilXNIn7oV84GPuK3DDzi6Jrg+JudpfbogMK2SqxC
	uwj/7J/Q3DI6kh6ZnJViC9oNRPZ7yBFNDscPp0di5Q1t2hrzKKJw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qnhc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:53:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG3JGM015872;
	Fri, 25 Oct 2024 17:53:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emhck6u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0r9XFT/TAOHNCrzBHOFSrJbZY/QAlWcvxvhfozp1TB8m/gXUEWWzS1HmS4A6NmSrbNiJ5madbFP2VORrrA2cN0Mxoc1RhsKVswpO8b1fwXWv28LBc8M8drEGuwlUV15t+FjWV0VX+0E/y13ADbZCiu922X1j8CB9DsJHvDRbK10x6cpG1xzEIWu0k8W4I0AzddfqD7gjfbHWvh4kLQEQJmoni/zbBZi9IkTGUQROKl8ktXHqRm9xpnNFSNX1kquKu+uTYIB6oOemnH/+ZqotFJ2yAvLxA43tTouOP5r5+eTkrQ2fYK4GrCxOUk2YQhItL8907esGhEDN16aTN47EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7afHP3jBgv4uE8XsrB0KCrIArf0iVAwErLB8YRwgmQk=;
 b=ZAaM4BG3D1szQc8xSiv+1fVbGTwu04PTJCnIH6raeKksnczWA/Jq+oR4zAxMvZtiYpxY73vPeDgHR7RHqYDRVctUB/3NFCbCYVXZVF3CfffbbYArE9oUTZTlp0Sk/V7UCmobip6qV38dAERyQsbrQrFErt3BRUwOUalCalhJkzUdeyquGjAdM7YLJudzmMZBIQCmapWIrGmtK2NYGh5m2UzifY4NIAB1mRPE5UTbHHJAsKGOkv87pUB1l4szP0Mwa48HMHZjhr+S1aaK0r6NfJN/8phg6loa7bD55TVGzC6JIAzRG+XlL8/FgXNZY60ePMGPgpwARArZM+PQ1Ob+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7afHP3jBgv4uE8XsrB0KCrIArf0iVAwErLB8YRwgmQk=;
 b=G6ftih5XAHf50wOsINnMFogd/P7/91d8xjZEABf8ck3S7cbIOJqQCn7KLwqk29xjR0+eSLb8KaOShG/ZKfg/kMhkSN3hn17B7IKZM9Xvx8v2FrXWxkUeHfqB2yweHtacvpIosRASM30Ho3n+H6C/XaD4lkUXNTh3mlTa+1Azc2I=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5149.namprd10.prod.outlook.com (2603:10b6:5:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 17:53:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 17:53:50 +0000
Date: Fri, 25 Oct 2024 18:53:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 5/5] mm: defer second attempt at merge on mmap()
Message-ID: <2e4d37bb-7333-4acc-92d8-c4ccc0d5ee13@lucifer.local>
References: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
 <d4f84502605d7651ac114587f507395c0fc76004.1729858176.git.lorenzo.stoakes@oracle.com>
 <10b88eed-7646-499c-9c67-d30469ee2357@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b88eed-7646-499c-9c67-d30469ee2357@suse.cz>
X-ClientProxiedBy: LO4P265CA0180.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd50843-9ba8-4d2b-b624-08dcf51dfbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQixxoLhro+To0SZ2VHQTSBq/GiTYX2bRq0+4GiKD2swxkOzNwAS0kfPBD5r?=
 =?us-ascii?Q?ZjyEarO4kWJJIBCGhakvWdG+x7y5rK8kFmHrtR5iSA9fwiKV43QeJ5W+coaZ?=
 =?us-ascii?Q?o+7vUgDxwrk2sCuUBxIqL5q1lHTdX0oOfJ+Kw8jXjiQbTKT9M4feMOjTR7iS?=
 =?us-ascii?Q?OfAG3WLEEM+jnKWHLWFsrXEiNFM7V6/eRwpEtPkwHsWohTyG2MGFABmGNMLG?=
 =?us-ascii?Q?C6PukEzhKlYPZ+tswCSSTxbObvL0LLlLeanPpAsGOKML3lFcIuHEhkwgWD+H?=
 =?us-ascii?Q?1eMTQxYZTRMClSPNQa1YoZBvxJnu0c7bcsKcGC3pIeLZNcmTk19r9bDuRbVO?=
 =?us-ascii?Q?duL8BHaIMoqlfTFsUuZvNeCSzzNCaG2CeRXibCTTabCaFkKbwX6BE1+X7bHv?=
 =?us-ascii?Q?K211R/EwHaVtqdZaf4gLEn3piCYaREw7/3lRwIcvLR6XtWoaW9qqKZIapCPh?=
 =?us-ascii?Q?mf472BtOwkPD5GfrGMtzT7EMJfpXjaMG+Peh5VKE2VDlEC02ultjitDIiKWB?=
 =?us-ascii?Q?K9xJJvqnZzJxnDgw9Ijh0OA/B2/3N+ojzfFFgCKsQaqRXSSEDKG2LqUN5Os9?=
 =?us-ascii?Q?lHkCP+WLd/4FEFPd4iCDTo4T3enqW3zjVZXo0e8O8LxMAYRVueAyZMOL93m2?=
 =?us-ascii?Q?Bz9Oe1ox0xZHwLbLyiK0J4WBUa+J0+KgVCpUd7PNu+A54e/n+k08zkU7AQMN?=
 =?us-ascii?Q?knjrPXiZhfYeBBMhPCluIaD0cH/NlLrF3Rkgsa+MPo7BEqAmpaf8LxCdB+W3?=
 =?us-ascii?Q?B5W/uakusEqTkfVQqVeDtzE2tdOx/gLMx81yEGWC1jitZFPoEU8RIxRzX9iv?=
 =?us-ascii?Q?KCAFq8HEUkI765rAO3qdlgYG02InMxDyLiaCRAE+gAOP6rvQ9LmoVwaVbWZS?=
 =?us-ascii?Q?hFCTJWmvGcFJklf0Q+LJ8krUjZSnUtHAxDg06omS+orhx6iCkBC0Px2nlMle?=
 =?us-ascii?Q?WzN3tB3jvTSlKWSIsgi97//rpR4woIqNL9EQ77sJu81xwalMdKFeIg8wkGpc?=
 =?us-ascii?Q?zZ1QvqK7ZhS3u8rJES4RKWXtsaL6ppjgBGUFXpg/Qh4W2qK3zQKdDJyYjTix?=
 =?us-ascii?Q?APGu022lT/QN5JQljRAbxj64+pWL7FhFDSEuffOoyphA68kUAAVMkIS3+iLC?=
 =?us-ascii?Q?Kw7m7ymuY/2gG0TETceC8umD1TKRp6/ZzSdmsOMgRuoM3Uk3WafkV5g6oz+a?=
 =?us-ascii?Q?KHfstU1UhMfiHxr3gHrXLt6VsLlDCM+cUx0YVPhcuZfuC6Zq2BZHvU30Vy39?=
 =?us-ascii?Q?sQeCJQu0kx/PriSjmkFbjJ7cAsHz7lpjKnP9ElALojS4vs5Q2yS5LY6QVp0j?=
 =?us-ascii?Q?3TGyB/MyP4ncaHT/LO7NfXiS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqPz4k4MjzGiNt0cdE/QqC8ctnIPqrt6P2ai3z3H0vGWT7nKg6oF4YCiLXrG?=
 =?us-ascii?Q?ijGQy0D6ltDvIArPcHIZdojPqTJmTGdXAkWcrKV0qvVgCj52getpP7YQdmm2?=
 =?us-ascii?Q?qd8R0z4WxG/G8KUDrLuXnpVs3yQceIi9b+htEd2rnaF775VoAyijQlk+o24y?=
 =?us-ascii?Q?S9g08b0DMPbdZFQkZAttRqbGr/sFOsVZx2oxQzu/FTPn9ljBVEPEHoWfMQia?=
 =?us-ascii?Q?jfMvvVtGtpFTvtes9dFEYIs6xkIG6zEuPsQGNtEygi95MwuZ+uTvgr+auSPG?=
 =?us-ascii?Q?8cGSX2g0bmor+3up/j0MDWxft6nOO2RTCAilyLTYhawgpnvCdd1AlEJZdy+T?=
 =?us-ascii?Q?BGAUv4Dr9bwHaI3BcM6PC2keyT6dYUShM1Vul3W6GjeF9wyVfnyobmyyVTgM?=
 =?us-ascii?Q?Jzdi4wS4EZDC/krGzSPqtznayXpxCpMW7tTQPC0d6xsGfdL+z8QDxlbrTlmd?=
 =?us-ascii?Q?PGKFBFbOxWh3Mv3ioWNFiknpdPE+fjNV33UXhko9X1xjoTdgbwlAEqzUyMvu?=
 =?us-ascii?Q?5Y18lvtdoatIqehugcYvUJWT2zKNHliuqtsiMbaD7XgQCUMo7E1i95AD7ajW?=
 =?us-ascii?Q?wTTuQT/2Yp8M43YiO25f3VqzD+J7uYgGYV5BxqwUl5y/0VFgFOpg0PqD1yjR?=
 =?us-ascii?Q?igL6++RzhZek/ELnH2Ojq6VgRwJymydlk4oiyEqTyHjR+axntX2OxMykipyH?=
 =?us-ascii?Q?OIFimN9O4UIpyhbrxZ6jipnUHm/Xc1LzLiRdFgyK5//OQXXf9wEqOSgbQIst?=
 =?us-ascii?Q?lS7FaarK+ZhV5y/DmahanKGnJUJWm/+9+RCAr91yQbX70qS1P6j6MBgI6uJc?=
 =?us-ascii?Q?PjcTOUWuGd8RSooYmweqY/E2erEmmkBjKJi8ZQXcYhrl2tu6WoQDDGT4TnQv?=
 =?us-ascii?Q?Ztk+7PAkZ5w6LxxhT10FvFe2zWiDy1S3z/5y5u1zcIhNio+AcgnHcOlbmhen?=
 =?us-ascii?Q?yYOCF/AnPxCs/yAUECw8uUGeIUZgO3NRocJ/HU/UHvyLBMO6N4HEPiVR2DBc?=
 =?us-ascii?Q?l2n6bdzpANC5WOXAgXOdDvGpE53SH6UgdlKySj3BZYibanGWMg0uow2Uns6Y?=
 =?us-ascii?Q?2/Uh7IFj8DfOuQ++Gu+7pjIjmcyTEZx8Ep/8q2rtuevs0cbyHkJ5m9+OF1N5?=
 =?us-ascii?Q?ItfHav/8ZQf+O44UWoDaeBcn5yKEjecCnKRTDyvKPmpUGv2kzSWYjblWdcDD?=
 =?us-ascii?Q?nWgUOp3asRrDSDQUHuuW5xh+cB5stLzMUouXJc5Tv2s7gifQETBAwRFLvQOY?=
 =?us-ascii?Q?FGSx/1zgAT6HG7EjARAqIDSivGh7Zr+APQ/qvnlLvklCV1HBpV2xlHy9MVbw?=
 =?us-ascii?Q?oGmX+h9fFMeTMi9nR55IRXOkG3hL3V0FEiC7xB1HKEJBhD0jAE9rSFk9CPQQ?=
 =?us-ascii?Q?CtXBi+0cgNSDMGVKkFJB9cCNWHk1eJ9/EW67c3LmvmyPoicsqhYZDPS/dsd3?=
 =?us-ascii?Q?dRWM4g44DV8WeddM8GbbsltWd8UNO+M1WOTGMjD5USOCH1N41qUEy8IkzRAm?=
 =?us-ascii?Q?fzsQA6/PpVvgIZ1WpA0IEOWYkcY8YlNajQ8cY7YWvqOR2P8fAsgSFF4YMvSC?=
 =?us-ascii?Q?Q+7ItmMNsv/9u8bluf/mOaIQeqJ4D+CTzEOHvqYhXUJ/t1tU7QDFD4WBWlNY?=
 =?us-ascii?Q?aIgk4ohF4289Eft8xEZbMSy1nQ4hx1Ts6bgmaIf00/aqW42nrtUF9xVGKKZc?=
 =?us-ascii?Q?iClQuQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mRGw4dM+C+Ebs1UAUrGeCuH29iQpNOsoFtk3X+AzH8KTSN/rCxid6scpjdNz6LjXMfAAl06etZ3STIRM5a5gfaaLpaVaC+f+YvSFPgEblVcd/SAiiIyt/uweh146iwfpIpQRNbVfgQzMT65nNUJ8JMs0sPTiH6ZI+BwH2yiuInH13vNo9t8g0d5Ne3oRvgEXVSdZpdIisMN44RSwVHTVfWwH5sjT5TfyFIbkIMzxQB0ByRa40F19IPGHY0Xg6rjgQ27+RnZIIuVCLUXkTyZUQv6v3vGuvLFZ+YZS1Hi2Scdor7LlFueT42WfVn03mMJ+bAmRa//tqSI/qGSgxvClPK3ZJYlkOtoqmpPH1HQPkz0j+r9ofA/reCnxdCxo4rGj3T3EsgD16VPfk6dnUms/GpgAYANNO8LLTqosquyKi50TscS7RWIIK3dobPh0QCABGVVEguF0TU4eg7ajbbYDpDpQwiXpz7FCaEuzUCDvzmHVdhVAV9NKqCuwvEMioip7aX5tsgdhVTlI9mzXZOGPmioENONg6EwGrPuXKfeIlJZ10DADu3lNEeHRHj0iZjktZBbrOiRXzrAzE1vElks43fvR5/OFu8Xq6keJK25dHyY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd50843-9ba8-4d2b-b624-08dcf51dfbbc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:53:50.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCI6u3VZX6gHBefqGDvRHS0UVQ2uZvFbx3OkHXx4pVAez5M9ts4dIbFkJGlA+QlxiZqBtKJmixM4bmw+D8oroXHzsRT9B0Cvgn2zUk0dVvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=882 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250137
X-Proofpoint-ORIG-GUID: DvGQMbh7twxf7VuyWYrOYnhWEkJmPzsX
X-Proofpoint-GUID: DvGQMbh7twxf7VuyWYrOYnhWEkJmPzsX

On Fri, Oct 25, 2024 at 07:40:43PM +0200, Vlastimil Babka wrote:
> On 10/25/24 14:26, Lorenzo Stoakes wrote:
> > Rather than trying to merge again when ostensibly allocating a new VMA,
> > instead defer until the VMA is added and attempt to merge the existing
> > range.
> >
> > This way we have no complicated unwinding logic midway through the process
> > of mapping the VMA.
> >
> > In addition this removes limitations on the VMA not being able to be the
> > first in the virtual memory address space which was previously implicitly
> > required.
> >
> > In theory, for this very same reason, we should unconditionally attempt
> > merge here, however this is likely to have a performance impact so it is
> > better to avoid this given the unlikely outcome of a merge.
> >
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/vma.c | 55 ++++++++++++++-----------------------------------------
> >  1 file changed, 14 insertions(+), 41 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 7c690be67910..7194f9449c60 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -19,6 +19,7 @@ struct mmap_state {
> >  	struct file *file;
> >
> >  	unsigned long charged;
> > +	bool retry_merge;
> >
> >  	struct vm_area_struct *prev;
> >  	struct vm_area_struct *next;
> > @@ -2278,8 +2279,9 @@ static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
> >  	return 0;
> >  }
> >
> > +
> >  static int __mmap_new_file_vma(struct mmap_state *map,
> > -			       struct vm_area_struct **vmap, bool *mergedp)
> > +			       struct vm_area_struct **vmap)
>
> AFAICS **vmap could become *vma now

Ah yeah good spot you're right, will chase up on respin or do a fix-patch
next week!

>
> >  {
> >  	struct vma_iterator *vmi = map->vmi;
> >  	struct vm_area_struct *vma = *vmap;

