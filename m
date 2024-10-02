Return-Path: <linux-kernel+bounces-347184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E0498CF33
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AE61C21BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C1196446;
	Wed,  2 Oct 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oDokj1m5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wWssd5/F"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51B80BEC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858940; cv=fail; b=JmC4E5qpY/TfjWAywj8k3NYaBDGR7GxDHFbn/9e+L4UYAF28BHvcgDNC8cRInx2IwMgrdBNV/ufhX06hPMfL2BYDyXgtEgQrDY6E+tZL+KG5u+YZxz/ykXuqu/iJBJwViC4wpA9eZ333x4mKfWm/ojG0JqYoT8uC1DwgMCG8s7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858940; c=relaxed/simple;
	bh=5YueTTk85ZtHaEt2g5jdR0ynISS5+/OyfKHK1eGhstA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F1+qDAl+iGpld9QLEmYVVlLvDluKQ6VMmGAlsLfdVMiMtC4oUCffVHVSvE7VbllKae1RKA9NGsDzf08IW9rZL/7qD9l2DTLwzRw1skhUqcSwL447DN7DxCCw8YN4o9KRH6rD8qkmVw4tXL5UrRSCAPWyhZU2N6C1d/cWQ42ipsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oDokj1m5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wWssd5/F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4927fbX7026221;
	Wed, 2 Oct 2024 08:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=+nNC6CruvbT7MD/
	Kbd4ErdSF/JpZ1mMcJhRUiNJF5Nk=; b=oDokj1m50osVAQQ/r0ThZqWFuPuP/Xn
	NqLJ49UeQJIs/ngog+eQFfM/GzPz1bm3+jQ7AOEBhA3J0j2EkbGfJUj6W9kImKLX
	+T5I+Qn0ld5zYN0QOFpZJ8ksbweNMgLNJTwEEC1oE2LGykrlm08bMRcm4Axd/ikQ
	2QV/f6TsDIwY8ST2OePVuEKdpk1ud+QKpsu13Orz/DO6U7UaL9OAqA/vlXqpuTIl
	GDXesYsegXbX16OJLuFXy9E/slHRflKDdoZ4IOiPujm4r0AYj4VkEd13z/jGuXCH
	oJJZWtnYLfm0flc7BN9Y+65i8thR56IpC40PQ8XapWNpjB5qpC1IJ1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1gfcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 08:48:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4927Gw7m040473;
	Wed, 2 Oct 2024 08:48:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888kh5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 08:48:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP+GK1OrhJykvip+TETzqOXmEr86MVAtbeor+mQeBen3+5H8Iwi2nirClG+bvAgVQqGAaINqsfs6ekq346LDiQGIO7YYiJsv0aPGNKidvkbOhfRYGPPgCMwff6olRUGf640lRThm3LmSOrk6SZo1/kER9pnuQimdBG1BpqAGslUKgwnFXv1RTxEfClchfAHss6DAIjlrXSI9lVm9qrxB2CqWR2CrXbJ/COq2gf3L4BvytdwsgwmQXgUdX7o4plCfJKxgPvbAq0puXwficYtQWd3N6LI8v/hS85DtC/bkCvIBOEf8XFHAJi1aSNJD2tfnx6t5OehJyVblsTbPKJbAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nNC6CruvbT7MD/Kbd4ErdSF/JpZ1mMcJhRUiNJF5Nk=;
 b=TkOMisXOjdXQfAvZ7Luuj4+KghF6ul0B5Gmg3mfUZHv3f+P3hhI/bv40bumU8rHYuHweAdsWWgx/0WXU7x+SYrdB/KA4POFxV/5Q2HP9m29Ytpp1EuCvwtEkGB+iqU4TZ6DosZ9N1zTpGwDmCcvg2O1ySB2cRfuCm5Rnm73cdW7I474E8NWpawhyVqlGrFUYcbyQUj/GomjNMLre/X9dluE233NTCz65fqzLqtlWY1+y5K77C0fAUHxwiH4OEkQ8dpTw3XS9MU3JQh1nzBceeq2LplqBYsnT8NT8tB1djhs9BV2gXYs4Q7/aEdV8cJTD8nxJS8qdinsoVFlXFWA+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nNC6CruvbT7MD/Kbd4ErdSF/JpZ1mMcJhRUiNJF5Nk=;
 b=wWssd5/FpTJNx5oeSlpyVMSLhWO/CbKnuHP2sc+RMYOFTJeYHJnfR0OX2k3lHaupCZoWY4/wX8aIwMY8pHOgc9k3UQbli3x+ZFCjObCk3522SCqxo7vuB78QWKZknUhVQDrEk0e8eGugWGTb/+aXljNbzbzfbzgQy2iZkAtBKkA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB7195.namprd10.prod.outlook.com (2603:10b6:930:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 08:48:45 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 08:48:45 +0000
Date: Wed, 2 Oct 2024 09:48:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <b98774e7-d2e7-4bac-9b05-723cc02f4fb6@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <44271477-0789-4fac-a649-75420d0c403a@lucifer.local>
 <76adbfac2a0cd1f500c5cc481b6e0068d11d37ca.camel@web.de>
 <aa6c26da-f1f4-4bc2-9b5c-0f682f8bc7f4@lucifer.local>
 <85796e78-277c-424d-98cf-63457713c761@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85796e78-277c-424d-98cf-63457713c761@lucifer.local>
X-ClientProxiedBy: LO4P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::6) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 795fc434-4c9a-4cbb-730a-08dce2bf05b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WZEiIno3LFDs2ZLXKHwqTHI2hFvOVgqKD/BFsKakdGQCzkVZ5VSbOYqrNreP?=
 =?us-ascii?Q?D8H4eVX84cpqN1Vkiy0b63uw44em1DaNXjl8D9Ezdv6FTVX7moLXhcHPlxfi?=
 =?us-ascii?Q?Eilz1gnNPhuLpGrHOaUd1GKD1Z6H8UIef1xF3Fq6zYI4n8KNhrQFQDhL0IGO?=
 =?us-ascii?Q?9P06DBnV3CLcQ0T6iBIFst+Y4107O7wuPgmAfv+r19YXH1PScxInDMEhFSGR?=
 =?us-ascii?Q?utPAThSUSDZcSo1o3nvDGZkjeANin6YJDH/iPf6RAgEAKR2xnp7bH9vT/3aN?=
 =?us-ascii?Q?v3q43oj6zE0d+jpsdaq6j/9uHGfcKJQm2WEbYYH/Asx6yn/zluacqmHm747X?=
 =?us-ascii?Q?WdPhVSiLevFWuSJBaMgO20XIps4Oc8sCDpSobT1akbMcMu4Q8/Gw2VChN46e?=
 =?us-ascii?Q?7LsHquXAkmem647/aSCupm6H6m694uM+vJQnuPltP96kPNi/ePmDHawyAMmR?=
 =?us-ascii?Q?rZKwC7qVCiJE7A7PcYDzN+wjSjohT/7Culw3MzK/HuHPiqYdD5fh/7tsTUEs?=
 =?us-ascii?Q?PeH4lm8Eme7frLBn9ejtDGKbdT7o4T8TK7EdK/pZCkGqzxP0zrTPdJimNWoo?=
 =?us-ascii?Q?trJXlG0N5vz1+BwfJk04kXwx4PvONbVXTyyRO0jJKXQmQDl/1nWy5PjrzBfn?=
 =?us-ascii?Q?5Ax158vjI+LeBln+Q+2bYIa0s1u0+h4g9xTQ9cQyuWhCiNlpxeWxpVqR6ntf?=
 =?us-ascii?Q?pKONWw0ovUsSql1kc3zNQaHmXcqxWDQ4nL3UuG0frpsHf1d58PQIAegJI7qJ?=
 =?us-ascii?Q?q3xGs2g2Dng8kq01FbsOmpWbXsBSe5WU3w4Wdnw+b5m7NU2bDIqL6Xnt8Jfu?=
 =?us-ascii?Q?878uZGmd0kEBbpwS1vo0qAYiMhcbpn1zrrVEGIR2EPsmMoMtPTqCdn6CHpas?=
 =?us-ascii?Q?HlLYmUx1HUe2B1/KkaybX3cVeDNQPNqH2/uCzYzcxCtIy2R2SlDvBWBL1Goq?=
 =?us-ascii?Q?q2JQTfJOaoQyysG59rCDZsBHf8oNy08vGVKjMeFaUBq5rrXLwlHcs9spK9oA?=
 =?us-ascii?Q?w+yATCJ3GZJi433VDFe1F3RCapsJN3hGtd5+efl9xTJkKXwEZBsedd6zXRuw?=
 =?us-ascii?Q?jSgrwgfpsKJh8XSpDeFHQHRDOIkkqe3N892plMTljDPxcK4HV9J5t8T1Mim/?=
 =?us-ascii?Q?YzMQdN85NQelDrnOHWuTNe5y+YjsGFZFY/SMy89jXghLiA2G3OaDppJYrfO2?=
 =?us-ascii?Q?xUmnOx8FIFgSYnPKfh+Sf/cJzR2iAVw/U8ByAyR+uLLhHnWmucDM/enPoaXw?=
 =?us-ascii?Q?WgpWa2oq1dmo45121w6UungpjUq88s1VNoxJVp0eRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z1bh80pINyN3M1EOMOaTpobkgBo30vkk2SjfQ3euDH8ljsGBmY/6OEQl0Nr5?=
 =?us-ascii?Q?8Ll+tbsH2l6bNQPON6cqMIMN/GmBsL7frb6r4P1ulmoNehZvFy5zGhSiqdoA?=
 =?us-ascii?Q?utkfcjnu/diB3Kj//z5uCqTf/Qy4m2qexMEzZu38fmWP3CeWyNuu+544xjvT?=
 =?us-ascii?Q?Mf7nt/qqUyy3yOyOBuISC4b3nv8ek1HbjDDPZuW4lYmOKiBjwSJpQXjYhKSo?=
 =?us-ascii?Q?Dpt5vS9wPmy8RFExT+rBGfeWACleFNicmyoxq38k919YkTz+Ew+Syw6Nj5pJ?=
 =?us-ascii?Q?sgqiVPKgltAki121To6vu23sqdPV1W1hNgtHQp6ecUM8ItAkZruaODBqEllF?=
 =?us-ascii?Q?hvQGGSYyGhkhxRE+gp+kvFHSzPjqiFMsUbN8XogsdKeoXQsvV0yz4JcVcH5M?=
 =?us-ascii?Q?Az51BZKtg9FzHsC+bcbTTAjlKcHEs9F0PSZ+mMHZmBoScsI3M/Tal+KXE3U9?=
 =?us-ascii?Q?Cp+KCo6YcWVomEx/b9giX449gviUmjzlGN+ZcdutJXo4zck2Dso2Zamu/0Db?=
 =?us-ascii?Q?fdcowO+dHzlEhsmdXOV2jm6HxuAr12PH+wyYLZPi9u9KzdoWo3aLPal73mKa?=
 =?us-ascii?Q?DpQ1GzeEuNvuacy+c6we6sJ7xEVOQCgCS4STd4rsVsIxw0YjaNQPEbb+tM4e?=
 =?us-ascii?Q?b/E67uvXkbKtgQikGWd2jj1jQtCDFv+6tfki7908eHvEA+CYDz7XzLV777tK?=
 =?us-ascii?Q?B3e3CgM8vWPcEvKfc5qQtZ0Q/EyRhT0A+tW3HMJIq5c5wpKTgkkU95SUqfDl?=
 =?us-ascii?Q?eaKizeDHiUXhvDEqhrbf0EHMdxmNPkH3Mv1I+uRfErXq1lbwywLybfDF20QS?=
 =?us-ascii?Q?I3uWrGzc+7vY7Jqnmhg3hbFexa096US+AKym9i2UqJX1frH09X5U97bUCTHg?=
 =?us-ascii?Q?v7LCsR3rf4PCdKZjoXwnA5AFg0l+Dt3HIPsKQJiZBPxaPtVdQC5w7xjKqn/T?=
 =?us-ascii?Q?th9eR+4t6p5IPe46EN2YT0fVwRV8He56c5k/QhpZMVscBwk0FiN44AxxheDw?=
 =?us-ascii?Q?x5QL+q3+T08nGfjKm/SOFifEBRsU0LgW5GFCniTCRHDL66iiGX21yd+rY4XF?=
 =?us-ascii?Q?+3x0oRahfk3RWFsxrJP7wP6CPFP1PylX15TES35cCrlYUoYrH8wq+0kYeEef?=
 =?us-ascii?Q?Eq11QE6KbWczTXFiMLR80uopdYaz6KIkaHsd0N2pTQGrBY3KdnLS1/UiUKKJ?=
 =?us-ascii?Q?L2zDKSAOf7b2eYeb62Y83sQ51qWavJebzjTtodR0zM9Yx7jRJJ0Ot9aPTJWl?=
 =?us-ascii?Q?CO9ImR9M1rL4X9HOW9kjG0IIpdAY03qRLC2L4il5GyujlsnkU/1i4Zg9byNG?=
 =?us-ascii?Q?FVSK0JmXInMmN0NNJOQV8tlHHy2wTuXLUWmPSVhJ19NgrZyuHfDbQ7NRve5G?=
 =?us-ascii?Q?uMj6utIqPCa9MIAvvaCa0MCq/koin6OXIhbnQMxOoJRuh+HFy4B0nEzq7Xm2?=
 =?us-ascii?Q?R9UyWm0/L3l+QMBUppVAkp1j/hHsTvZxvFgrp6TDJNU9vxHpdPXlfThdrDrU?=
 =?us-ascii?Q?bomxgjKFYMZd+XUUymuYTTJFIKr4dQXE1RTjTfYkXIYRwB1eiSOGBezLVYYm?=
 =?us-ascii?Q?eCdDytsz7W86CqMWw118NLHImAgXUAEQT1bVrh2zQ2gauWb4MY+N5F4fTzUO?=
 =?us-ascii?Q?nOS9I2Toc1B8wyOlKqYW9sL0gnEN54upLnh1i9EDxGqE5RcfJwO/ZjNpGG9J?=
 =?us-ascii?Q?GgG7iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nBl+M/NHjdzCmu3ozguEDpHGje4P6CI3HNZAS2nltGp5PNdAsV0+13EAgAWjI/BXJ2Sm7G5p7FcfX+811cX6LRI1WFZNk0/bHv05mnKzpkLuVyNezFn4IkjWMFSVnBZ63G0a96AaPbVd1A5j/FXyfvlh2XeDEf9KNHH21k7DXtp2eT9ZTSdNb034dO7kV8Gc55QySp7s5Da07uOvaZ3yQmantPMA6Q3RqSP04AbYTnXzk3sv0RACdHufYmjZkqkQEvyWMr5qXVlodsjUG7LczNQBMMijeEJDKRz/7KT9C0Q5bm3yieQsk8SBadxITHAmlgyB1QeVYbyksuXjRUsZqXNI2X+jtvy8eibAtVnHTCn1pEIW4iD4ZwzIMmYUPU2RcmmcWs14C/wcAUPFtgkjVApoTRKiNdyrLNQslZiyYOXxf4vSpBnjkvfmpfSSOglXNMO/Sbs1WMAlURzgYcPzPDJRdXr431Gei1DrEORfAJGHg2ytTlqxy5oGacTx/wfSWgIfAXIdPFAHOhgRLq0ChLH8P6sa4L7ucOhMU04BwMnAwWrzIwhy7eOyFnazJD6nLj55d8uovQvQKlZifEd9it4rMNbAnQQKVbUSdxJoQHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795fc434-4c9a-4cbb-730a-08dce2bf05b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 08:48:45.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAGlcCMy4hzLDnObWFvmD847PenogQdIog1Mhpmmvq63AwI+dNN7mnAU9AvuLLByOepte/8EI/ldnGhzAWEvRwmmUFetAdtZ/C266TJOqwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_08,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410020064
X-Proofpoint-ORIG-GUID: 5BTuZJUJJ7Oftg8libEaAVK8Q9oiuOnj
X-Proofpoint-GUID: 5BTuZJUJJ7Oftg8libEaAVK8Q9oiuOnj

On Wed, Oct 02, 2024 at 09:39:27AM GMT, Lorenzo Stoakes wrote:
> On Tue, Oct 01, 2024 at 07:01:41PM GMT, Lorenzo Stoakes wrote:
> > On Tue, Oct 01, 2024 at 06:43:35PM GMT, Bert Karwatzki wrote:
> > [snip]
> > > I applied this patch to linux-next-20240110 (it applied cleany) and got the same
> > > error again (Andrew Morton asked on bugzilla me to put the logs into mails):
>
> Hi Bert,
>
> Could you possibly apply the below hacky patch (again using the 1st oct next
> tree as a base), and share the dmesg output?
>
> Hopefully this should give us some more information and test some theories.
>
> Thanks, again appreciate all your help with this!
>
> Cheers, Lorenzo
>
> ----8<----
> From 36c5c148580c5aaf93f0f689c2c3de36ff62f1ba Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Wed, 2 Oct 2024 09:19:28 +0100
> Subject: [PATCH] hack: mm: see if we can get some more information
>
> Add some dreadful printk() hacks so we can try to get some more information
> on what's going on.
> ---
>  mm/internal.h | 15 +++++++++++++++
>  mm/mmap.c     | 20 ++++++++++++++++++++
>  mm/vma.c      | 11 +++++++++++
>  3 files changed, 46 insertions(+)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 93083bbeeefa..cd9414b4651d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *page)
>  }
>  #endif /* CONFIG_UNACCEPTED_MEMORY */
>
> +static inline bool check_interesting(unsigned long start, unsigned long end)
> +{
> +	const unsigned long interesting_start = 0x1740000;
> +	/* Include off-by-one on purpose. */
> +	const unsigned long interesting_end = 0x68000000 + 1;

Sorry to be a pain, could you update 0x68000000 to 0x798b1000 here?

Thanks!

> +
> +	/*  interesting_start            interesting_end
> +	 *          |--------------------------|
> +	 *           ============================> end
> +	 *        <=============================   start
> +	 */
> +	return end > interesting_start && /* after or overlaps... */
> +		start < interesting_end;  /* ...overlaps. */
> +}
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..0ed27e558ebb 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
>  	return vma;
>  }
>
> +static void ljs_dump(struct mm_struct *mm,
> +		     unsigned long addr, unsigned long len,
> +		     vm_flags_t vm_flags, bool is_unmap)
> +{
> +	if (!check_interesting(addr, addr + len))
> +		return;
> +
> +	pr_err("LJS: %s mm=%p [0x%lx, 0x%lx) [vm_flags=%lu]\n",
> +	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
> +		vm_flags);
> +}
> +
>  /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
>   * @mm: The mm_struct
>   * @start: The start address to munmap
> @@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  {
>  	VMA_ITERATOR(vmi, mm, start);
>
> +	ljs_dump(mm, start, len, 0, true);
> +
>  	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
>  }
>
> @@ -1375,11 +1389,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	VMA_ITERATOR(vmi, mm, addr);
>  	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
>
> +	ljs_dump(mm, addr, len, vm_flags, false);
> +
>  	vmg.file = file;
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
>  	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
>  	if (vma) {
> +		if (check_interesting(addr, addr + len))
> +			pr_err("LJS: mm=%p First VMA we unmap is [%lx, %lx)\n",
> +			       vma->vm_mm, vma->vm_start, vma->vm_end);
> +
>  		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
>  		mt_on_stack(mt_detach);
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> diff --git a/mm/vma.c b/mm/vma.c
> index 4737afcb064c..989ea3ce366d 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1202,6 +1202,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  			goto start_split_failed;
>  		}
>
> +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> +			pr_err("LJS: mm=%p vms=[%lx, %lx) split START of [%lx, %lx)\n",
> +			       vms->vma->vm_mm, vms->start, vms->end,
> +			       vms->vma->vm_start, vms->vma->vm_end);
> +
>  		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
>  		if (error)
>  			goto start_split_failed;
> @@ -1223,6 +1228,12 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		}
>  		/* Does it split the end? */
>  		if (next->vm_end > vms->end) {
> +
> +			if (check_interesting(next->vm_start, next->vm_end))
> +				pr_err("LJS: mm=%p vms=[%lx, %lx) split END of [%lx, %lx)\n",
> +				       next->vm_mm, vms->start, vms->end,
> +				       next->vm_start, next->vm_end);
> +
>  			error = __split_vma(vms->vmi, next, vms->end, 0);
>  			if (error)
>  				goto end_split_failed;
> --
> 2.46.2

