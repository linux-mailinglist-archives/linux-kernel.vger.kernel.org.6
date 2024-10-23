Return-Path: <linux-kernel+bounces-378158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3EF9ACC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A57D1F21253
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37DC1B85CF;
	Wed, 23 Oct 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jy/wua1A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cSAnHFd5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33561AA787
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693342; cv=fail; b=eE6J/TyPPX9oMO4I5o6onZY4Krud8A5WWt6oKIhWBKMrJNGVzogJTJaA4XKJK61tp4DGJQewEmGWLDZtiH8Flxv0in6gOy7hkoWpkEInOjizHe3D5cUhSFqCNQt9kQGHfSppPq34oOQwL+RB0XIPHbtTJRlFTiQpAQ8/gilWKrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693342; c=relaxed/simple;
	bh=OtsuGUkGSds6uus+6icaspHwm+u99W9UjUcBOcoQCNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A85HomOaAN2XeNlhZYDRJugGyH7fmu7qkY4Jnuyg6Tge7PbBh3PmxiJOpDJxCMWVjiDX3fadslRKSQqoyAVKgFqS0e4IOvYGSnvQq8cwQue4dE2Owim6kfVfMTMLbjxyCZNP7YMA3orobHlDAZ36ovcXTRg9we4OPDRIW+BxS5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jy/wua1A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cSAnHFd5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQYH2032099;
	Wed, 23 Oct 2024 14:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4wSbRWmfpw609tJ810
	eEnTnfCv7MCpwAcGQSn9IXd2A=; b=Jy/wua1AKnbQOA2O32n0FqHgnh/QefanoX
	EJ+5j7X1P4IMDGZBSm4aK5HPm1471ouIAPyKghtLgGOg3QVhbf2Pdt2CdVYWrKWG
	zDKYN0+qV1U3jWPhDRsvmNUQpfFD4Wrn559tWJffCzZ3XYqDNZbXbaTPEqmtL+xo
	WPPJIfKESPI9LqQ0sRxniWrPsK2tez0+vIMKToZdD0HiWj9y308sBRSg9XCinD6+
	BucQrJOAYjcQhnGMlNXHKCh80N8NYskEAaDiLTYYz/uuXhAlDpP4sCMmSR/N4818
	ny6vdcBPfgr8hGuTtUtSQpdI302Cf4YdqbFh2q+TzUB5FF+R+SXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qg9nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:22:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NE6gYb036236;
	Wed, 23 Oct 2024 14:22:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2kfds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgU0mD5sEHXrKeoQMiEuV9ejOQdzsIZMYBwynpRdH1S2IaG8xKnVuREHBJUOOptL/2GER3bxWV5xVTJR8RKyAZ5NLb8mXXdlnqTjE+fW8OjW8Zhf+VKlvInO/S6TvDpenQWeVoX85tEDHPKVi89ed8fuvvBuvDQtoQ5xn5hHtWqviVazZX2JFE69DUdB93H+u2awRl9vX5hpIukvLkH8pitqWSaMcjjjZcl/jqaVzQ8YhvDyjIS1DDKN86MWEiXXzYOW+SOlwgzx1bpzQhZhWBDC5CJH3saSRXV96ai8Jh1b2yXGQuBWNeckmeq4yCqCxnXDwRn6TYQytiLYW/XYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wSbRWmfpw609tJ810eEnTnfCv7MCpwAcGQSn9IXd2A=;
 b=ynbHUR6DV7AleNH8yOw4pySd2AgCgQnQDsBh+ubWTO8cafnlLw3w430NlmxFZT1tuxE6Qr1e7RAFeSSlrqhneiXBa+bNwY1ksv4Rh9VP4VZHMtjyq1ciFTvqeEeNKauhZJPmmHKMUgZudKO449gvyQbxMcTTEFnTt7+2FgyMXBClxzGj2NAmk5dbY8jg/xYqUO7N0rTsUCyfMlPvSHw2OD4WsWjAq01Tt2IwrN4ATeGSa2YXVY55TqroAoyUjR+/3YVVrXev6wEn2Jr81I6WYtUKJe5AnQ9mxVJVQ/gEht40lN0lh2qu3oN7bU4OyK2dDN0fokP270BLran7hUt03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wSbRWmfpw609tJ810eEnTnfCv7MCpwAcGQSn9IXd2A=;
 b=cSAnHFd5KiVa9cGI2R4RJaVyW9tNHkA6hst7mCtM2g//A4LzqcuE1O7quFtZGLEgtPAbRBtjXpmgPGGUPyZQPfVMrnwDL/BA6XCyWpTDlSl2tMjYJaze9LNCORSOhVnGQy8BuW71fhfrzR61xTn4hwoI6Aa1iKAvLT3FrELYIy0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7394.namprd10.prod.outlook.com (2603:10b6:610:149::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 14:22:07 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 14:22:07 +0000
Date: Wed, 23 Oct 2024 10:22:04 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 1/8] mm: avoid unsafe VMA hook invocation
 when error arises on mmap hook
Message-ID: <nvymmqnuyn5oscw3qp4fi2rvneyjevvs22oaji4phxnmrxkfcp@p65nrh3fwhjd>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <ddc1e43edbb1e8717c2be7fde96b682d8a898836.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc1e43edbb1e8717c2be7fde96b682d8a898836.1729628198.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0499.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb2f196-e771-44b7-cc7d-08dcf36e12e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dsh1Qe5TVnmLlAYjo4RhQvNS/kWqjtGZzGhG3H/Rv1PS3p4u9z/BwYs1SS++?=
 =?us-ascii?Q?aeY5clFZ7iK38a0hfTRBQvifFuCZtK63KdWdjUmQxSy0MuD9SE7WbRIDN7Td?=
 =?us-ascii?Q?KBb+WF83ua4jb4BhyvVpONwjgyQt13BYAljH7XeRmZpSnUcL8fOvZ+DsyOEh?=
 =?us-ascii?Q?NuWkdzn2p+CR8aY2K513zQYnya79tqvd2CjqJpl7/UMc7mNbBaJwECPKbxKq?=
 =?us-ascii?Q?qhDkVNlLVbrPd/AIAbhgUl0T8A94yVX8YskWQdZeNa/3uh12+8bTSelw2DtY?=
 =?us-ascii?Q?kmztIvMAOwlO0HIaeRbxYP7oApLhKqWbraSLK4wyKBrg+I3yK7udw4vs4upa?=
 =?us-ascii?Q?MURolcBpsklaTUWpuQcWd/nuVHVU55FhFuvjfTQb7sKJIkPMVyZEisAMCgYB?=
 =?us-ascii?Q?H2nQWwD+fUtCEy0CnmvpGx19vTAa+8POQ5maUISmRebtir2FvvztrM6JxXyj?=
 =?us-ascii?Q?04ppJyXR3UHcgxOHHDAMQ2JTd23NUy4yoSXYTSsZcmp8sjxoHClww/UVKRBa?=
 =?us-ascii?Q?f1VUCZVHMm13LQ/bhnWhE2xm5iKWFV8XiDETY+n5qEyleEBv8AX0JrwCAAKr?=
 =?us-ascii?Q?mbDCEWxzOJqw8YLN3V1lmzbhnyl/CDwsUxqPimYaj5kBHv+2beMW2J9pt7LS?=
 =?us-ascii?Q?hYgpuOfIrD/Jlf8ZDiVL9t0muo83IlVYuW45HiptJ0LNTs3JQSmvouKvR4q2?=
 =?us-ascii?Q?zTpLFfYnwBknhy4IxF6InLc297VBhbJlGqEWUBcaQqNWn/rhB/zZ7qkZyYMS?=
 =?us-ascii?Q?M5DbLV41haHey+/1GCS+S8Vf3ZK+8/f+rTwRj1iAdTKVs4vfU0vMBveUSk99?=
 =?us-ascii?Q?8LJMfHoWmW8NNsg18S6ZzsPkhh8aaM4f8jmwPfpuoYJDhJzxUgtp+9Fr4puG?=
 =?us-ascii?Q?zDjEbKcdHKPxDiQ/sxVKr9TgDwU7BvIUHeUpta80ZyU126wRLDnuWYoeHlx0?=
 =?us-ascii?Q?uMNI3RXrPVWQxCq2wfWuGDpxhDssZb9XA7jNgKcfabdARyWHdMTqN9YRwRQ3?=
 =?us-ascii?Q?M4wY5BkqvvWLhvRE7qk8fulF/CTimF42xXS0TzTbATtfQBdk+1jsLRRtqnc1?=
 =?us-ascii?Q?hGg0tHAYlkpj8A2GEp8VV7nrDbMKcD4qWT/B0hs/3BoqI4LWCbD5gpMceAVi?=
 =?us-ascii?Q?rKl3+j0FPFUA8MmRx69Ynic9UfabOTPBLC6bosowU/k2/JWGNvjwcUYVG304?=
 =?us-ascii?Q?rny+Pm7yzQlxwO8lKlMBYWpa2qS6J9r85xXh6MU6kYt06WfsouSLzqnIXO5O?=
 =?us-ascii?Q?STzJJ1pSK5CwgXjtVSln3AFbXC8IujDNjuEO5QTMHYLVcbPf/03TqvKY1IZz?=
 =?us-ascii?Q?aDRQpiz1PscqvT9bPxF18H0P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+l/LN14lZ8dMNx3LB20+C8NbEvnx5Rcn/VqI6gctQp98gE9xTS9GXNB8ig3?=
 =?us-ascii?Q?fQm1ZBVkelYDV+h+nH2T8zDKDG/LsJdHmt9joB7krhBe0F4uOBs1TFa7uAdw?=
 =?us-ascii?Q?RGZkYSj6U+bxHbJNrVEShquDACj3xeRbQYan05S/NjvLbrDk0h5V8TeLFbc2?=
 =?us-ascii?Q?eSqz4WxWxBkX16gbwNk0qdX52rCVSXOWb7tzg5w64WG2No/BbDRGCB/q1XKA?=
 =?us-ascii?Q?Env5yhnSvER3HOImH+wdwkXKAsNVXwF7ixBDYLUxFiq850Ve7qybbt/FbjLg?=
 =?us-ascii?Q?dP8viTzSWTPXzL7uTSbCqAgb1Q2xInSc9lYcs2bbmiaonSNRgRPSzoce8aS/?=
 =?us-ascii?Q?LsWdCLpqnrEDueWZ/4Cp/uo/0nfDPejxDCN0+ZxP27V60DxFakRk3LmtviC1?=
 =?us-ascii?Q?N+khVGW6/NbtF6u4K1YFQSYamVO8ISsukUU/3BpC2DSMJrDhpV9X5Bj/pXyk?=
 =?us-ascii?Q?OA/RNWqi0JCLhyO1c3eTAb69O1cJxIX0x8m7uSepg4bF1jRNuxGwpH206eUH?=
 =?us-ascii?Q?RCkIpykdCnj0FqsA4eqkc9Ljuj0qPr3QvSGFDoFrRPTTHiEPKbOfDDD/cv/R?=
 =?us-ascii?Q?Qrd2pdhdKA5mWc/U18Z09pDtN/OMRa2bP1lK0dwhgBxhuRaIPGKLOkmPiiQ5?=
 =?us-ascii?Q?egQUPKOM9jFee3uEn03WaLJl8vgXzVBXTtDw0i9xuFHb1zGsAMoaBpAokqrS?=
 =?us-ascii?Q?p6VXgLmDf0atOFiOsQc+NnFImUcq2yoSvgytzuahKKOMaiYlKju+Z9lpiwQE?=
 =?us-ascii?Q?Pnxf996n9QwLuW1Z+yIf0qaciekxjk3cyF3MIZWKTT9rh58SJ9zY4nbASmI9?=
 =?us-ascii?Q?svaDfnI+PVdzfrpj/s58COPpw4Ebfh3kTp8MyCfB0FNRTUWpCF/nPvN/Usfn?=
 =?us-ascii?Q?4bkLSMXOV4kB5r93cOPHtEgi9v+MxzNIB7xBN+GsCYgUXHGYAuwAtny9vnfW?=
 =?us-ascii?Q?bpo2t4Wx4WFZQMdb/4Ch8UCvl4SyzGTfNwyMOHWVyfzcsBbaxvF4PblwY2jJ?=
 =?us-ascii?Q?nHajFFqnDja4VX1flWHfyNkPXoL7XzDmmMlXLT3RatbFapMHzTs3cm6+uiJH?=
 =?us-ascii?Q?owbjerD6S3WeODdezZasqOGxoDDvFoVBbm0HAUpf30RaYFvoP51SXqpweHO5?=
 =?us-ascii?Q?fjjnBcuxBa2TFYuVhLj3Omr4fp4YInHdQsI1Fbr/uDm8YBPadXW931NRUHVx?=
 =?us-ascii?Q?LEQABDiGfq5DH70f6ZXQnMcPGLxXbrE63NpzdAc2R6bq4IDDKrzmdnua7vY3?=
 =?us-ascii?Q?/og33w1PeI3FqRl7P/iMYSmdrMHv7ytnYHMdpmdjeKwOVlzqn00NvLOui3A/?=
 =?us-ascii?Q?eSnbaU55kcimJ1E+nwOLi2ih8bmLWFE/QQYik/w+ubIJvoSgoRDo8S6d4Ph9?=
 =?us-ascii?Q?EyouzGQe48+5P0stZteH2FCEfRClgMYHNtj2FeHhXBsWQfYxfI+XxJi2/Fbq?=
 =?us-ascii?Q?j0KK8bnehzYLntreiLXsBkdFe+6EcqFwA60N85ohEaEpwdI1k9vgVH2rzO+v?=
 =?us-ascii?Q?8awfvCcNZWPIFD3ReXjbQ62bfMy/OiFDatg5TNdbbyS93TQWOTWPTYjUBcxR?=
 =?us-ascii?Q?KRdGUWC4BNl2swAUhFZVg3jFKgfvT4R+xuDchhbwELA8dpzAKUKzQsNaU/Wj?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qc0Q8taqF5IemnlICyyBCpTwdrnQUyDu62Jvy53BHVl9XtbN5E0ZcILfwP6e3xMZXOF+pyTQ+tQfcXGcGdFfH7d4VZy0RDU5NruCh7AqmEfi6p6pasAQ3avHTWZBDg3oei4HAeuI+epZmB9lm1bhQWKT3eoY2VvE9o1bIYT7m+FU8ZoL9jYJN22VyOGaTc+WzTh8uuO9h8RGAYdlx8ewoCH2yqtDBDD0t9tNnF7YueHy2Irz2nzpvr7nyn/aw87YxqEUBV8l2biUwU1Rw/Khxozckyub2DWmnmenyDAauQ5mCoZpcSrAkyXLIrBUKmsdV2qVlfoqxicWoqHujbdd0R0lAgJGkWOcUSJNj415nA63QI7siAO2xG/U4NlxkpX2Idi3mcINpJ2lTyQcQ6Lchwd1kCqrO4CNzuHrW8G/CBnlqL0dhcqwdA+HxiTX10R/cG/TaqfW909Ug8fN/fgGd4j3kQzpPO6QXDnlWSffS54IMTY0UU5F8uF5BEGQ0L5MH3X2iWFW3e/jhpEiC8wzAnib5tyAapACHl2BQp/rigvWS+m8Yd2FWA2ck+bJQWxv7ruFG+5ZKUQh9L2bhPiYkw5xwuOjrMKtxAbX5tiQrFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb2f196-e771-44b7-cc7d-08dcf36e12e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:22:07.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuxBr3vFzrSVxUd6yHDJ8HK9EpdUbtdd/tpJrir8TMUQ3PqCXp1LMq8qCzoBho7v5jBKF31omr49Qe9+Vo/lWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_12,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230087
X-Proofpoint-ORIG-GUID: 2IAMCwjTnt60QuaqGhw0XOoZj19C0_wg
X-Proofpoint-GUID: 2IAMCwjTnt60QuaqGhw0XOoZj19C0_wg

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241022 16:41]:
> After an attempted mmap() fails, we are no longer in a situation where we
> can safely interact with VMA hooks. This is currently not enforced, meaning
> that we need complicated handling to ensure we do not incorrectly call
> these hooks.
> 
> We can avoid the whole issue by treating the VMA as suspect the moment that
> the file->f_ops->mmap() function reports an error by replacing whatever VMA
> operations were installed with a dummy empty set of VMA operations.
> 
> We do so through a new helper function internal to mm - mmap_file() - which
> is both more logically named than the existing call_mmap() function and
> correctly isolates handling of the vm_op reassignment to mm.
> 
> All the existing invocations of call_mmap() outside of mm are ultimately
> nested within the call_mmap() from mm, which we now replace.
> 
> It is therefore safe to leave call_mmap() in place as a convenience
> function (and to avoid churn). The invokers are:
> 
>      ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
>     coda_file_operations -> mmap -> coda_file_mmap()
>      shm_file_operations -> shm_mmap()
> shm_file_operations_huge -> shm_mmap()
>             dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
> 	                    -> i915_gem_dmabuf_mmap()
> 
> None of these callers interact with vm_ops or mappings in a problematic way
> on error, quickly exiting out.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/internal.h | 27 +++++++++++++++++++++++++++
>  mm/mmap.c     |  6 +++---
>  mm/nommu.c    |  4 ++--
>  3 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 508f7802dd2b..af032e76dfd4 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -108,6 +108,33 @@ static inline void *folio_raw_mapping(const struct folio *folio)
>  	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>  }
> 
> +/*
> + * This is a file-backed mapping, and is about to be memory mapped - invoke its
> + * mmap hook and safely handle error conditions. On error, VMA hooks will be
> + * mutated.
> + *
> + * @file: File which backs the mapping.
> + * @vma:  VMA which we are mapping.
> + *
> + * Returns: 0 if success, error otherwise.
> + */
> +static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
> +{
> +	int err = call_mmap(file, vma);
> +
> +	if (likely(!err))
> +		return 0;
> +
> +	/*
> +	 * OK, we tried to call the file hook for mmap(), but an error
> +	 * arose. The mapping is in an inconsistent state and we most not invoke
> +	 * any further hooks on it.
> +	 */
> +	vma->vm_ops = &vma_dummy_vm_ops;
> +
> +	return err;
> +}
> +
>  #ifdef CONFIG_MMU
> 
>  /* Flags for folio_pte_batch(). */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1ba0878bbc30..10f4ccaf491b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1425,7 +1425,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	/*
>  	 * clear PTEs while the vma is still in the tree so that rmap
>  	 * cannot race with the freeing later in the truncate scenario.
> -	 * This is also needed for call_mmap(), which is why vm_ops
> +	 * This is also needed for mmap_file(), which is why vm_ops
>  	 * close function is called.
>  	 */
>  	vms_clean_up_area(&vms, &mas_detach);
> @@ -1450,7 +1450,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> 
>  	if (file) {
>  		vma->vm_file = get_file(file);
> -		error = call_mmap(file, vma);
> +		error = mmap_file(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> 
> @@ -1473,7 +1473,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> 
>  		vma_iter_config(&vmi, addr, end);
>  		/*
> -		 * If vm_flags changed after call_mmap(), we should try merge
> +		 * If vm_flags changed after mmap_file(), we should try merge
>  		 * vma again as we may succeed this time.
>  		 */
>  		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 385b0c15add8..f9ccc02458ec 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -885,7 +885,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
>  {
>  	int ret;
> 
> -	ret = call_mmap(vma->vm_file, vma);
> +	ret = mmap_file(vma->vm_file, vma);
>  	if (ret == 0) {
>  		vma->vm_region->vm_top = vma->vm_region->vm_end;
>  		return 0;
> @@ -918,7 +918,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
>  	 * happy.
>  	 */
>  	if (capabilities & NOMMU_MAP_DIRECT) {
> -		ret = call_mmap(vma->vm_file, vma);
> +		ret = mmap_file(vma->vm_file, vma);
>  		/* shouldn't return success if we're not sharing */
>  		if (WARN_ON_ONCE(!is_nommu_shared_mapping(vma->vm_flags)))
>  			ret = -ENOSYS;
> --
> 2.47.0

