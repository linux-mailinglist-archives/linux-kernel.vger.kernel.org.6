Return-Path: <linux-kernel+bounces-297900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF7795BEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37111F2374E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707B1D0DD8;
	Thu, 22 Aug 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mlXkmc8P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zei9FVr4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665741D0DD4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354855; cv=fail; b=RpRx9Ypy041bCSzSfPxE88c2OmROQGGyo3T/9cd+60zn8xUTf/SLiPvLkopZS+8U3S0BW826zZc462XpVNmkyxMXHZWDdnCbpGPM0oorccOjTICt/JeUWij8/9kyLMKEabXeKqOIWiAi9AOkBKRE8qayUGeID6F3uusilzakevk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354855; c=relaxed/simple;
	bh=3n/0eoFZaBEsTFSF/sDM7IeJudyjqS/ym9HvOX++stE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mdCSWf+5QIEbLTwVNTM8JNfUCd9KPcsVKftbmqVjlvXTHmgEcy+6y5RoJGxzh7LPvbVa8f8e4IveiiDSwz55ypxfqihXFkKo0jf/iJgEud3BuORRb+TuoUJAumeGsTp9Khb0DfmXaf6mId3fQZ7oIUwmqRct8QowwkhM9boX9VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mlXkmc8P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zei9FVr4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMVOI029699;
	Thu, 22 Aug 2024 19:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cQBQ6roZjofnRdkNhVdNis6vJDFY3ZS8i57oI04+9wY=; b=
	mlXkmc8Po6/KCAoQzVI8qOo+BHYa9KNTlmIyRJ1jYDxTIRNFlRS2fhNWFAgcrGSQ
	GU/F9U2fOuBp7WFdVt8ouQYUWPhJjLPLEaBqNkFysTUlk1SGZt50FHRNY9wAKB3y
	rTzU+j6CZ4o0v1w23gJaOOv1Osrtutm6LiBbj5QihYmQAAijjQPGqI8jr77wqswn
	eGlsx6jd8eZ84ZCGXvIYlXD21zGmz390OOxUwfDXeIrpuujnIft/AI4ZpiCmo3C/
	KdvvNLt7JBeXOfmp9yAB00DTUbYCxu8WhI8UsCV5EE2wzCRObG2luEZqYXgfh1xb
	NzfN3RC7euIk8ZCltcXVwQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67jrt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:27:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJJKm028323;
	Thu, 22 Aug 2024 19:27:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bct88au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:27:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czhlbSkWWHKUTwDXsI+KYP9U7554ppXEwvAIIjXBAE++za28D7Bo0TdZ8C1QQrgqAYAzMTML2+CIn1XalBAgJawIPhJKueUarGyrpgwd/xio3hvTDwMIoerYfCSqhtRjT6GFHDpJQ9xPCrGXXBHsJN6UYpSofh2cJOVQPX7nhyQCESjGCF3Yqya/wyxpY2BnpgcZlb318/wBv96zHlIlIEh4athbc84AzeEJcHulDrQzBrnrk1ERdImj118QrUoD4vP1iW/zvGU7kK2e3nYpnlqeoKoo5/KkFyylxu3XEkWuVGcuiVgUSmNzNPeoVTLwsSA9SrWP220cNR9YAj2WIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQBQ6roZjofnRdkNhVdNis6vJDFY3ZS8i57oI04+9wY=;
 b=EqSlV5VoHWVAUsPV0tMq47aeFKx/iX/+QPywFr2Qa35kfB2kU6cU41JmV+GHQbwqyNAXrpcTZz/VHpGVWXlX3WbUTq8fttfkKSDW61xM9MakfHpMbXHp5uW0SJYUh/KmJlo9/6XcYa//M+8ljKgYYjx1dx4zme2rF7zXFS+G74FttzPJpotFA8ngNYJKHj1fTNCJxYNafSRNlGRjM0Lxt9V871KZo6oLumg8UWUwLYuDkybqN4+UIpmWa8VU5eMm9LXirAnifBTqXRf/oDL5rH59Vt1JtjCyF1FRgu3K0FmLlSrXE9nBJGPzpCBeKlDq3H7YflcOfD0jC5YCn0ukSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQBQ6roZjofnRdkNhVdNis6vJDFY3ZS8i57oI04+9wY=;
 b=zei9FVr4eMif492iVDn+yG6ko7WQjKtj19Ug/q6KFPAtjyj7sW0wa9kUOmDEiUy0ha3OGfFSdNSLKqPZ/OfsOd3nnD18iPhxItDYYkJ1IkSu0d83l9byLCnfLPrmUDizfsaHgdwUmzQ2ZQ+D1Ek54hx2mZfgBPzSnQnII8/Owr4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 22 Aug
 2024 19:26:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:14 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v7 04/21] mm/vma: Extract the gathering of vmas from do_vmi_align_munmap()
Date: Thu, 22 Aug 2024 15:25:26 -0400
Message-ID: <20240822192543.3359552-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0282.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a16c7da-5664-4ec6-4129-08dcc2e048d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?87Gv1SsTzuTSEp+t0azdve4O2bs38yh9EFtZ9oQEz4Yfypbx23UbvgnRIaZa?=
 =?us-ascii?Q?W4ZcMEyrFNiSdPTHfzqEprEZ8ENUpJCLPn4PxnWP9D3osvTBsZ5ikP2c2P8f?=
 =?us-ascii?Q?6NeTKvacxR6qfjoB2/PP8MOULdbpw+CSG/QYENh4JOR5YuSNkeQ8HagVtfm4?=
 =?us-ascii?Q?y8Jl2qBG+FfXHlscejhJTxFxxHWDnm4ZyKVjLe+GW9pXt9i2b45FUA0acVCq?=
 =?us-ascii?Q?ZqY27c5+M6gFQ5UEsgX85gt1DZuiXwZfMHnh0emby0s3EjdAbnyZa2bIr5Dw?=
 =?us-ascii?Q?P9mzskL5pmRge33ad9IKlM6wZkwpx5JoJiLFnrMU15a3nFnlOBedgkc0DL+k?=
 =?us-ascii?Q?ftGiBegPJbSAyGpa4Yu/Eo9yrRbcLbqO6UPYH5R4Z6cOYjB2879mDa20ouOQ?=
 =?us-ascii?Q?6ScI9FUIAi42KY6/gyJTbgmwpYuessFbAQGgtqeb3NTH8JcdHaiAf3C/CzQc?=
 =?us-ascii?Q?ICaNjjInhEQeDhG/q9mO18PhwYalHEa4Kqo7+HBsQHijnkFryRz2yi5byiVv?=
 =?us-ascii?Q?cuI1z1Ulnb1OoMj0lkfeYo2Fm483Hn/fGX7vE8B3gnDRbtGIOXSAkYaORFBq?=
 =?us-ascii?Q?WhndrGmJi24HKZgDYI9OitJ0OOSfPVnDv/zh42JaSAZjfiahIPzRpXRgovyL?=
 =?us-ascii?Q?+1fsIdQ8bj8renP1ckGA+qk+mhb7CBp086tMi7fvUcnZVb5TYM/xp6QxxbZa?=
 =?us-ascii?Q?utT+Zj5916QpY3U8pnpBxX4FOFjo9tEJOgSVvzu6xluklc9ns/w80ZY8sEoR?=
 =?us-ascii?Q?clDAXD5B6y2diJZ1IefUzdCPZeO4IPqD42rsimVoh0BIWPvuR/xR1VWR3nvI?=
 =?us-ascii?Q?+V3yLwcOes7RywHJ6wDxoUjtXurpKIA75HLrOroR0mtLj0SQ4uxVo2EDlWfg?=
 =?us-ascii?Q?drzX9rULURITS+TnD0vxECR35QLM9Yga83HiaN7M2MC6D+Jdgg6dxDz6nTCB?=
 =?us-ascii?Q?8w674GcS+GmBg3jK322VvPCCeCSvNBmsU+S4d+xODZGfPedcTfGylBrIyLnS?=
 =?us-ascii?Q?5x1c+VnA17mYA04vwG6Vtt+X6gza37P7D8oeDWbDOPFwRB+8GG6bS0NUB9Pq?=
 =?us-ascii?Q?KF1uRImKpT+yCR4+aYqLbNhrGKuc6VRnwyf/doAAPHnn3DSApkxwlPHu455C?=
 =?us-ascii?Q?OHbocVEK3e7lHcRJAsMOZeFwp4nnFaFe9+NpsKVvxT5PeZfK1xc9PElkeE29?=
 =?us-ascii?Q?AwvsyE4afhuKrrQ9JI+S+MORx1+sNepFVGi1FhxLd2o+C+WX1NWG0Rb/rk/I?=
 =?us-ascii?Q?L/FT3EZUnG8RfK627/e7pcOOivJMhRvGrL930yxI1XgKTSITqN/uYvenNIaj?=
 =?us-ascii?Q?wz3S+D3U7MriH/IMalp3x2Fh9mMrreuf0GTcQeLW2UFqbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ff3xX5FUZhpT3NYrkagEaL7dtjUAR8POaA2QfUpkS6ooux3cSaVnVs17XKaQ?=
 =?us-ascii?Q?38HEES1YALWn/0yoXXqc1K2ds9yWK1e+s/uRiaAGYntjec5JWAbW1bg5h/gb?=
 =?us-ascii?Q?9FG6JuWdmcLlolDIRb2rv23z9W0mjHqitiltvIBS0pUaDRhEWF7WptzU0EtM?=
 =?us-ascii?Q?VOqwCc8PtFJPEYn/9v7J8ZN1ef6rP1j2zwrQ/GretyB5TU+Kv7dJs8AKKvVs?=
 =?us-ascii?Q?u3wMfJyOGsGWgJGh+z4aChIg0ezPl2/EdUIksPKNk+nUIGp+6GvyKcmHbuov?=
 =?us-ascii?Q?q1wLwSRwtLZ4PlXaFInKtk5pPwDf3En9KafaDndm8LmmMCZJPyjFG34E9/g0?=
 =?us-ascii?Q?W48b3wKFUhDA52oj2sxXYY98BVKDdODxNmv68kTmJY+qJYGzBjVbRiAT/fBw?=
 =?us-ascii?Q?h4hGhda73X5cThpOQe4FJn+4gLia4yDnpkLz5ZC/2DzWvssohpfyR7URzLxX?=
 =?us-ascii?Q?oyb8weh8TtEtdmDa0c9rkubYT8G8e/bqpBPOKsVBjvZkcjeY4ldTfhce2RT2?=
 =?us-ascii?Q?BXjembQWz3wa7dnrRiQ/9PpbG8f8hDDd+l/iIjytSh4PjX1mmYdmO67bi+bA?=
 =?us-ascii?Q?AgI1wX/+HvS0gR7VSIzIlYKyKEg5ZuVso+ldwDZdU2QLJ6ZPdpujXvqNwWnz?=
 =?us-ascii?Q?nNESR79oA5ks0DnZPdTRbqbhxOZOjeKhxB0V6uUYptuIPqASo/jjM2HMZd+s?=
 =?us-ascii?Q?xBqBUxbDIIo+/TfgH+/nMs8cHOZ/k83c0BC4GoPE+wLniBwbUOO60WSBz8VW?=
 =?us-ascii?Q?XHwIbon7NhEWq1Y6TOnrJjuj9tb2w6/tYiAZHkUPeDYfFmeIDcX3hVawz0If?=
 =?us-ascii?Q?yKCxd9Gml620ZxXLOcWtSykR6xBXhqrXCu3bprIHUHkCKrdXyX5xk0VbkRv0?=
 =?us-ascii?Q?GJTdT4IvfQ0SFWEF6aAWxXRXWuvtWJGsAU5r9uZQj5BCy9DJHOtbYIBdz/od?=
 =?us-ascii?Q?i6O6egYjXl4XHc5sGambQg3J6mPyxUpBr9FHblbN3E14ORrZCzhnk6q3eAIu?=
 =?us-ascii?Q?UzWAsrumHpRRKXdQvPYktAN3JjC8kU1SNeXLI3nC7aNy85eTvhxj7NXe5VcI?=
 =?us-ascii?Q?kcTeOYGPqyoSk9kr6SSH4he+5M1kmQQbFk7iBrnHrBeIOxtg88uYQfyhHbIm?=
 =?us-ascii?Q?2nltUHg5osGgQpdtEhuY8kkSt3HmsGIVWSne6ozoSIn5yVtXtdBoAyIEexvI?=
 =?us-ascii?Q?+BDH5gduCaxUyGvPTzT/8WNT7RF+4pFdvGVynAmW0KIXFeOnUYjLreOM+Qzd?=
 =?us-ascii?Q?N/Lh6P0XUNMWV2eVgwRwbcr3xpHb6hTBb3iishWDD5uHkY86OdcNdK/KZZ0U?=
 =?us-ascii?Q?RdnIWu/RV65sqQKk1zY9r1QXu7zx+EdtZTDcBCmlB3NUzH3o7rwM/pdITJSu?=
 =?us-ascii?Q?lLWTkZ7ecjXyr29f15Kmo/E9ktfUPKyC0qm+HIbJ93muNatQRwV8sjhdrVJ/?=
 =?us-ascii?Q?8ag9UlYrlBxPCW+m65qs6BAWSBMFbLzRCyCTRPEUivWr6pCTqhiMNvaSZYm5?=
 =?us-ascii?Q?gF0X3rXXaETmKPMW39eh898Q52i43bcc0cKYQMMvr8JdLJGauvTAYoYPzHbT?=
 =?us-ascii?Q?JNq5TIS2OJQkSkfTpX3nwCGyLJ63/CMIfdKfa1vV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JhE2OfoTarwhTHmmrW0e6meN9YKDhPU1NomE8dhmSEgm+6bHFEmI04EPJfBQCIL8h5/fQzUuN897IjVSS52xP+wYRBrQT8EYhiZkreyLS6TWTbiru++QWshAE/qGm+ztfE0LO/8kSxpMSiMk2fczPyg5BgIaLKEx1ZUmM5MieHkJdRdRfPCbM0wCi7dQrn5W/eCzmgXbeFdIcrnjZr6tI2RDJwYFNzXNLq83ePlrUth5fkVgfQKzT+Dcqnxia0ffqcvv0IKcA7ZrpzfP7Fj7/351KaccPryALNj7KW2EE57X1MG9vM2LjXuKHeh3qk6Q42NWmgxFOpkpmnAlm1KYjLCPqKL3awaep9jt9nAVhg7SlNnL3L68VW0/4pLCD8xzRQJw+UBl7jBlg0JBQDQ18Z1chvu/svmG/cu73AySrXXVHc2cyQjBng9wKFsiSh1DmrhpEJVD8sxaLLbR808KgF/PEwyhidAaqukMwRuAo2Xv2++GIi+y3NMUZQmgVd4wexY6yyhSR26LFmrRIod2jXb042kMzwlJxRohpbIuiZHM3oYPWwi3rKm/MIyKJSUK7fyheaBNiGNu+0fqu3bsozVbML1ufhdl/D2AarWjV2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a16c7da-5664-4ec6-4129-08dcc2e048d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:14.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypxva6bjSGDO5ri/rBG36q5tz9QeXbzKNrJ0sqIYMW0pvx/GRWJn3x2/+2IQjZHylE0Tc9OZLNjdlqYQxJPSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: IntJzcRh19xmNhO6MN_tDhiinq-XEC3M
X-Proofpoint-GUID: IntJzcRh19xmNhO6MN_tDhiinq-XEC3M

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
detached maple tree for removal later.  Part of the gathering is the
splitting of vmas that span the boundary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 82 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 3a2098464b8f..da489063b2de 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -737,32 +737,30 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * for removal at a later date.  Handles splitting first and last if necessary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
+ * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * Return: 0 on success
  */
-int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+static int
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
 	struct vm_area_struct *next = NULL;
-	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -812,15 +810,15 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		mas_set(mas_detach, count++);
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
+
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
+			*locked_vm += vma_pages(next);
 
-		count++;
 		if (unlikely(uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
@@ -845,7 +843,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
@@ -865,6 +863,47 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);
 
+	return 0;
+
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start, unsigned long end,
+		struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm = 0;
+
+	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -872,17 +911,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Point of no return */
 	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
 				 locked_vm);
-
 	return 0;
 
 modify_vma_failed:
 clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
 	abort_munmap_vmas(&mas_detach);
-start_split_failed:
-map_count_exceeded:
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


