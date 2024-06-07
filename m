Return-Path: <linux-kernel+bounces-206624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12C900C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E00B1F23128
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7915FA7B;
	Fri,  7 Jun 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPwP9hu3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="llvC4aRZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFEC14EC53
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786435; cv=fail; b=Iup51lowWMDj7e8FLyU3gUkOmwI+FxVy8jG+SOUJh+gNmOZwGKtVfDlJNYFMw06pLAIFg5WrwCgWLyekKFIQKQnWufuQv1U12ORuGuODA6Oo0CfG6LeFBzH1PwmvG9cSStTeGqL5JKfcKrj53yzPVbHnverbsRkPSQWLKJfEXhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786435; c=relaxed/simple;
	bh=zB4uE2P+5HYQfOqmCAln1KJ2LbEHr4mjNNFoI5NOcsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hx5B1Z6GoQZ/akot8JqbvsLfMOG30X4WtP4qr1V+kh70RIn82U8NtqYxvUS9R0USDeDGBZeEgRh5V0t5ifogJx1evVj4+WQ7EBqHeFBrqaIxaxX40h57GkTmGKtTBDzJCh6+qUead+S0AHFYMrPmRtYHzR6qX5I2KXFXCUo9pOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mPwP9hu3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=llvC4aRZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuhbN016014;
	Fri, 7 Jun 2024 18:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=eVZpxqxt2vbi+6AHnTDpG54BWzJdcL9VsTS5wEF3vJs=;
 b=mPwP9hu3VOY9Kqs1fK6qeMA3kblbfG0DfdY+y+pg7rvPNY2LD+kaiyiglM+qRequpEEC
 KFSpmjyaQEJI1GMegHS9LWC/xzhDSxmhFsKN2GrSqUPzA/0GdE5pSvfijmOpccXFpdZ9
 rmlQgyTZuSl6RkK1JFwGYGxyLWiei5nDA9lWdm9GLZ86DcLWt4hpRy7z39gdMSxti/pJ
 9uGx76/dnWv9o0Sqe3qzcDAzW1B7ywyt5JejmT+c1Hyv+b/EB5NgsS/WzBzAQ2/mRtjk
 nPN2Yd9z7UJ28Gmtyme7MSke+JAgrl5Oqy9aU60fNWXen1n53fXsWASo7fBSp8j5/WT8 zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn69he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ICR4I023938;
	Fri, 7 Jun 2024 18:53:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2k7tv-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmaLlyBgxNSIEqnduUU82QI162cr6IS37Ux9Vr5607Tkt9H/iyWcK+Rnl2G5I/JWP4FEsYWfw1vVtm8E8pk1X2sFjd0Cfa+ifn1a2gAp3eCX8puPe7DTYyXy0H2dSAU6EXcR8PcSPoeDip6R5uTS9vfvawzS257M3hX1H/wa2Ap0bmeKDzZ6Mb+D9cKAukne7UOiTfi86XZDjAVvzHlLmVAvnT8/yOWeJSDX6e0FJPh9ajhNex58It26nFCTrHQ/yNkZQDE1Sv57ROU/OfyXwG0owZoLeAK8+eTMTK6BItk2L2EYMoaJ7EA9moxf36ndXbmSBxVNRcEKdb2ay7im3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVZpxqxt2vbi+6AHnTDpG54BWzJdcL9VsTS5wEF3vJs=;
 b=enhX8DtfuakhAlNQYAcYkTyZcFKS5rIdAspnsxsKqvHcYV9aXADrUfaEc21QpGMLXVX1ddSiIpS2dz9YKlqXcChL01naG1DFKJlFShohfADCes+C6wM4E0e/4yR5pXye0ZLbVz4eX44EyDKlS3ZtpU9lur7OIV2oMAaeSAREYaY1GdrZkWe2O+t+V38yA7Jl6Z0a0lQI19Gng8XtE8OgGxwvcv8w4fa6+gD2ltULQvCSOFpSsq+71Q29BaG9iBye23IfbdT1EjYZpocTpspCmIEkLNiUh4wgUPx+7oePHBI7yXhN1lxuGQ8EwLnbMwYvm0133356SnWnc78TrsYyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVZpxqxt2vbi+6AHnTDpG54BWzJdcL9VsTS5wEF3vJs=;
 b=llvC4aRZHe7l1kM7IoIaBGp9DisDTygD7+Dc38+d4PUh3mKFgTW//SYXhoTPs1ZUJXKaWiNrILlqZ0glurFtnwIVqgJ6EKujvQzS1nfj+ja8iVF5Z1rkzTH5C8wLiiKf29tkf7qL7g/FRl7XiWMqPoRFERPHf4Q8wL1ZSfxt3IY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:28 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:28 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 10/16] maple_tree: convert mas_insert() to preallocate nodes
Date: Fri,  7 Jun 2024 11:52:51 -0700
Message-ID: <20240607185257.963768-11-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e3d91f-7cd1-494e-3d3d-08dc87231e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WTEbk7w+Wz1C4OdBLx31MYD0OiiMSF5bvbTnSUnVrGU4hlxyjaJ57Gi1E9hj?=
 =?us-ascii?Q?HMiAFYZCI96mN3YPVwscudNoP88TRS6ZsL0D/J7x71zJJ/MiGVsKIi79qSOE?=
 =?us-ascii?Q?llLiz7LfV/JOQ1tCpFB5nQFPgq8Le0k4CttaYIkfKIm4A7PZK8Quq40hIce/?=
 =?us-ascii?Q?Kfh/3cYYrbBmPk/YgPWnOYlIOFMba2NfUU4X2z0qQ8XLYnFX78yxe4IouCxY?=
 =?us-ascii?Q?yMeHH5Jhck/228TusT0xNmYx0taZd9w31k6kpRiu131b6BGEfDt2EruZbaff?=
 =?us-ascii?Q?+sIpXOCCIBWKWp6T6CJpdJu1WJaY0yUgEdGcchT/BeIoVFtx/3hlE7tfRY6c?=
 =?us-ascii?Q?iu9LmK4QU8O4uU75yITHqtS7iYT6mGw680N183CHq5vgyDDWGRtyEHPGG3Sq?=
 =?us-ascii?Q?xXj1inDneSBQ8TAPAsiHpcVOyezl4LUaVNK+eroOJhQ0zbXbKSZ7+GJ+aD+s?=
 =?us-ascii?Q?6U0MtgCtLEbsVdGMO5xb2AR+n1tuw15Oae/S3TO4O48Cl9i96f7WQjLm9IPr?=
 =?us-ascii?Q?3P177vx5yF3Uh0bLq3KzAqBnr7ntmzD+RdM/zDSvnvGcSFd35PwJuyshopOs?=
 =?us-ascii?Q?kbz0VVcI1UG81q4oT7NHIRPeQEdLDUibGN9n+zURji7GTjmYvAeOkwXOYejw?=
 =?us-ascii?Q?YiRArcK5j+hs7dD2y48Wnnr8a//LRRDqZT10rk2n76ep7skFDjErhTFhwb77?=
 =?us-ascii?Q?12Kpb3zMoPDp2rnP+OleG93+dwGR7j14i3SBxsCORTvuUxE7/zXqSDOBb03P?=
 =?us-ascii?Q?PpKMxEz7HHsciOJtMLSz6/2W/XdSaLkdNy+BE1AVd3MkG4MNLpfb/qXJLVUw?=
 =?us-ascii?Q?WipfZcGeu3jMjx+M5fWW6zRf/uyKMYLoI3j2y3gMVscRAgfhs5abruqeJI9Q?=
 =?us-ascii?Q?fD1reqQbKYtGQ8+o9xXzYeLzmSJxM6dvNzD5eH3Kvn2APDWBGgajV03eCn6H?=
 =?us-ascii?Q?4tBI6LSCIAOfyxl4FQ0FqE/ZcNqKvA0IqFBbsOGEv/4Wo1q+Sk+9sMSRFgaz?=
 =?us-ascii?Q?7J4CGAKiMmePuYBVjjEVJqxzLtLzyla2qrxqpEAWlkm1UNhoK9+gl1o7Yq9m?=
 =?us-ascii?Q?nUEufYiiqlQSUcmI8giFARq1Hi8RS5AiT5EKJBLt0L5oAHJQvJxVmFN6P7Jz?=
 =?us-ascii?Q?muUfUMBxgNp4e2ovLfnb/tMrnqoifw44mSG7f8nDsAP4KKmzzxAd2reDqE0l?=
 =?us-ascii?Q?SKTPZUhL5bCp1mC2rOv1HijK1qF6BYzbc8LBDMLUponCAlF7uSGRIiWuhrzg?=
 =?us-ascii?Q?9GJGP8viFUfic3OUnfZUa36rVjoipeulhA4cLMD+eoPMgkpgaNoEOB5nFrJq?=
 =?us-ascii?Q?fO5ywb7SjwsqSjq6tjPV8cVY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8mytOo4cbF1iQU2cULe6pyu9qR6EwI5ngVTQWyoAb3bXuV2sOHs2lswMnSsm?=
 =?us-ascii?Q?9m73AiJ9S95mPKTpKFBeEy1uThjSbaA/D0HuyIvYTghK8O+NiZssw0+8i3/O?=
 =?us-ascii?Q?yE3y0YO7Qh1zGt6ZnuEEEr/tucTRElrxt1j+BW1do1D9S/p8xe4mI0TLLQvj?=
 =?us-ascii?Q?Q8Wwk+JS9oXcXwPseevCMnuGBzCQrnHY9RmI8p37xVHfupYJU8YMUWz1ZKrX?=
 =?us-ascii?Q?/3kLUZaeEn/UD+8S8XuzNjTXm5pzIK23fQMwSH6Kj36kk8s6yUyKG7+Sx6sQ?=
 =?us-ascii?Q?f5rGhH3dNSY4GcO0VraJDdAq1WS2LHSkf8eesSlTG8GZu2CsOYms0OTQjhzv?=
 =?us-ascii?Q?gYwe1hi+5XFMnTwW/31J+gbTeZBN00nzfR/72RufKPgXIOgNaq9nKhnP8D+q?=
 =?us-ascii?Q?w1S8+7uE9NYLhE50kl2/flZb0ufjLP2JYiMNlY3A767k/IzO+Qd7CXiu23Tc?=
 =?us-ascii?Q?LxHXYKeCZT/x90iGgUq9ayVQAqcyL2xc3jjWbtp2uT5xzktCt4K5qc0L04ee?=
 =?us-ascii?Q?p9C8xTUwHnbIGMzc+AZhPsA3JTBXOwX/UvFfKJ5JXADnin+rzh0WYPr0VaWZ?=
 =?us-ascii?Q?/RRJ/wx7C3J7YSkarhRJ3hh8n71L1ka4/5FBMQkhOo1C/4GO1HFNNhCkbj8S?=
 =?us-ascii?Q?EzeaBYOYbi9pLITqevDzCbQLmdl1xXS2wBPSCl64qPNiSlUQxPo0x16+6Ksf?=
 =?us-ascii?Q?0S3vL36AgWdsvrrp9F9QaGv0V1pKk7CiInJXq2ZV2GMN+pULxG+IOVrA8uhT?=
 =?us-ascii?Q?iYxmWtXqcBfNEUjhncNj5OXFfI6Hgu48aDf1B1y54gJ0VbdKcl73hCdpDiCc?=
 =?us-ascii?Q?PIQVyopOT9eFHqC1V6/3NBhKtRQ/DjLhC3h/d7xadXrbLNqabkqsC2dQEDoW?=
 =?us-ascii?Q?IzT9jptPoN38xm+Yrnv7X68wxS6JE4X9Y23lIzxW/a8ysdaEOWLRy19y1o2W?=
 =?us-ascii?Q?VI8lnwSv3qgr7jA07jtW7mVxRp9MA/eS8dHhme/zroGH61M1HMOp/2JmEMqC?=
 =?us-ascii?Q?scPQBHZle1T8h84WMCPBaFQOA3nRlP+HIpiQizGBRiZ5nX5zKktRoOLDvzaJ?=
 =?us-ascii?Q?Ky44xIwsMT09PMTPJ1L1tec9j1W+KznjBUtQezBiLA8+6Rp2wAtQdLapxSoC?=
 =?us-ascii?Q?r9dJ48W5IxgIBwFaN32eW37hCshdcSFjg+tqOwBIahHnO292eR8QHTLK8Xbm?=
 =?us-ascii?Q?ECxHUTCPZ+gJadAsXwruT+4/wpCnOrIZrAdzCJE4uXBmJU3OJXN4XHmC+JM4?=
 =?us-ascii?Q?xA4jt6sowUJIhLbtdeUUOSyzf2PnXDcRbZ0VT2QqrjZfy+ZgSGaZe67nk8px?=
 =?us-ascii?Q?G7wv/OHjVXAU32c/D4LVkO9rvUeigxrIAilaTD400vYsdAXFPeLhyGgJgBkK?=
 =?us-ascii?Q?IPh3U/pcwBCvO3ycJ7dk1KNnboNyJL2t1a6fe8aQo+T0qXUuP6+bH/MOWZ5P?=
 =?us-ascii?Q?WLLl/BvDvm1Auv2c2W20g92b1pkrHMuM61hSvIZVOyynoaCoUAyfVyvQfENR?=
 =?us-ascii?Q?gAEnvdStAeXXSjvCGFfvWxLF2hErJDnVaaT1WzLjboKTrq3La8YYEz4WDE51?=
 =?us-ascii?Q?SstUfM6BgU1tGmztc+F1q7pjriKJxgp7J0/yRZ++4CDfmScxJMnOaNHeAlPB?=
 =?us-ascii?Q?5QklRspcHHB6tHyKvRY+pAg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fqagOroq3N8zXVEUqcH0zbnoF8a77p7LM3yBOlnAsIkqf0BnRMqUo5oHguL7POXg9YveZMhidHldNK3K9sHtT+abBB1U9S0yj3KOZQo3N+296wrR8RRReVijuyEz5JA5Y+/1LiOMp+RakpqDzJu0DXtR373lRzTCdVq4y5w/tZ6wYUHoLABvSSzgTw20p7mKbh6Wkgm8QvueS8Ncn43yP32VVaw6j8fggZAG0wIK4hzhIxdpKvGe/MBeDynKuZ7viB7dF7GfxOFGjPBv7a5B0f2EqxBJcHmOzc0Q9jo01Iw2aE4YlMZQY6T+NAsBKAKhxSDZ9/1vTNiAcVcizdaw9PrmxR/qtZ9wIiNKK925VuIzuXWU66kwDfnMqgKkknGMNoBgYUI1ulWBRodF13phH68dvDX9rlVBMkpMmy0s7NsVBQNPDOX5/lVKRf7JsQSNkIXvEUtMWBAb/s/BHRSkJRnxNT+aEwIgtQbMeYO7YrLapExnDRSj7G3qsknp73/yKDbPfhAmG850oSIhQszAvIIX/YoZTfUNNLDMozptSL6PbQB4qlp+ZutoOcvY8n1Q6mKJiniVkH6dO1jPVaNYeKbSFv3endwWfLAsyHBUxO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e3d91f-7cd1-494e-3d3d-08dc87231e1f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:28.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnwJ+apMvAJsbvjAjjGhA0HrSdRq02IBAlMp104A+qxH16xqnkOHzrwrczC9II+99xK+4AsY9gkgPt3scCbnx8M8Hjb1xnJYcb8qGH58GBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-ORIG-GUID: WfjCc5LVIUqqxIfatAo4ADc8W21uDvhU
X-Proofpoint-GUID: WfjCc5LVIUqqxIfatAo4ADc8W21uDvhU

By setting the store type in mas_insert(), we no longer need to use
mas_wr_modify() to determine the correct store function to use. Instead,
set the store type and call mas_wr_store_entry(). Also, pass in the
requested gfp flags to mas_insert() so they can be passed to the call to
mas_wr_preallocate().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2c42e99c400c..c37bfac4f622 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4442,11 +4442,12 @@ static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry, g
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
  * @entry: The entry to store
+ * @gfp: The GFP_FLAGS to use for allocations
  *
  * Return: %NULL or the contents that already exists at the requested index
  * otherwise.  The maple state needs to be checked for error conditions.
  */
-static inline void *mas_insert(struct ma_state *mas, void *entry)
+static inline void *mas_insert(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
@@ -4468,26 +4469,24 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 	if (wr_mas.content)
 		goto exists;
 
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
-		mas_store_root(mas, entry);
+	mas_wr_preallocate(&wr_mas, entry, gfp);
+	if (mas_is_err(mas))
 		return NULL;
-	}
 
 	/* spanning writes always overwrite something */
-	if (!mas_wr_walk(&wr_mas))
+	if (mas->store_type == wr_spanning_store)
 		goto exists;
 
 	/* At this point, we are at the leaf node that needs to be altered. */
-	wr_mas.offset_end = mas->offset;
-	wr_mas.end_piv = wr_mas.r_max;
-
-	if (wr_mas.content || (mas->last > wr_mas.r_max))
-		goto exists;
+	if (mas->store_type != wr_new_root && mas->store_type != wr_store_root) {
+		wr_mas.offset_end = mas->offset;
+		wr_mas.end_piv = wr_mas.r_max;
 
-	if (!entry)
-		return NULL;
+		if (wr_mas.content || (mas->last > wr_mas.r_max))
+			goto exists;
+	}
 
-	mas_wr_modify(&wr_mas);
+	mas_wr_store_entry(&wr_mas);
 	return wr_mas.content;
 
 exists:
@@ -4532,7 +4531,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
 		return ret;
 
 	do {
-		mas_insert(mas, entry);
+		mas_insert(mas, entry, gfp);
 	} while (mas_nomem(mas, gfp));
 	if (mas_is_err(mas))
 		return xa_err(mas->node);
@@ -6536,7 +6535,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 
 	mtree_lock(mt);
 retry:
-	mas_insert(&ms, entry);
+	mas_insert(&ms, entry, gfp);
 	if (mas_nomem(&ms, gfp))
 		goto retry;
 
@@ -6585,7 +6584,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 	if (ret)
 		goto unlock;
 
-	mas_insert(&mas, entry);
+	mas_insert(&mas, entry, gfp);
 	/*
 	 * mas_nomem() may release the lock, causing the allocated area
 	 * to be unavailable, so try to allocate a free area again.
@@ -6667,7 +6666,7 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 	if (ret)
 		goto unlock;
 
-	mas_insert(&mas, entry);
+	mas_insert(&mas, entry, gfp);
 	/*
 	 * mas_nomem() may release the lock, causing the allocated area
 	 * to be unavailable, so try to allocate a free area again.
-- 
2.45.2


