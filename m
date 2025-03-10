Return-Path: <linux-kernel+bounces-555093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F8A5A556
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC20188E96A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80191E47C5;
	Mon, 10 Mar 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ij+nd0oE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pWcQ+HS1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770DC1E25E8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639918; cv=fail; b=CtoQY8TDu6kITqNSlDPyyV+AE5Z2anD7GhBKhASAo9OybJoZNip8SPs+wyTL8jbpQmIhJ6SV2WqSjks0omBzVV9hCf4Ap9NG1lC/oKT8o6L/0h9J3dbpoWXDMQRqVxnqdqpGy3A25bfULyFB/cfypma8lh0im9de1R44KEqK6xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639918; c=relaxed/simple;
	bh=ckntbXOvJRlTfKmEXlO81GuA4pcDm/ndDc2pwiY7Ne4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IUppzC9f327opAGLnKXgz1ghqyGR51Koe/SSSyiozjuuG/B6lLzQIx5dAEOlXaRW2hMYtT6dFnPEuPvTVUW89WfhU7t3A9yx6PuYx8lFiVeLAyluIR3aIdIY/znyRtszNVTr3MY0GuXtJh6q+5BEcDp1pfMwvxXE9UwZdY26Tc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ij+nd0oE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pWcQ+HS1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJu3Rh007048;
	Mon, 10 Mar 2025 20:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Sf8fmvWfkBvcymcN2DsZh62QU2fWxDWL0y/TmPHxYzA=; b=
	ij+nd0oEpzyON/oV4XaxWj1Sn2zjfOSXIWhkEGbI//3/FlBP4kYSyX1Z1gBLNHfE
	auyqM7Au0XDEjXUsJQqLBCIK4WnZ04bnPFw4jOGpV1nasdjo3+ZPdwrn41fHqFF8
	E7M9HhCYeZfH1lMXY9zYkaal62LWQ4AFpfoxkonDYrQBGU0fNhA1SD/tJEdcoizU
	srl9/ylPTPaT6oZfBNhtf2D1nuWtJ9ugjwpEPQSN/QUVO/5c0Ea1Oda5YQ7x0KFT
	zdeb5pyHgTxH++IHC979UFd5UtDF8M4EKC8TDfzxoueWNqChhmtzYWmq8z4AYCyF
	/zhC9hYWnMVIWfOVNwFfbg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cp33j2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKdiPS021700;
	Mon, 10 Mar 2025 20:51:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmnm5nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzsplmlM6trh+ni22L28MXl6BeZ13WDB+yOoBimQAUn43DYkszVviPVUrVcjfgdWRGrM7gZjicJ7GzBNeRI1BXNjsK4PASSRFLyCDuP98ZioZK5E3rdm72fW3V+S+p27uI6tbXIwHHi5BUgQi5vt1T6JTZGiEtwny9uTYbt4snYIg427PsQOEF7Qkr7mh+5kPY8vq9z0LD6SZSMvkBqL2zi48UJL9/6VCRo3PiI28Ffkdqem/15lD2jYIWfCzuZtHa2mp2dFp+Y4Tp9jA/QcaF32Fk81l2VX+XoB3xoDcpSyckUDJHerI7DONA5EiBG2PzzNWvj6qQE6NloCXNwkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf8fmvWfkBvcymcN2DsZh62QU2fWxDWL0y/TmPHxYzA=;
 b=b5GTj9iuPcsn23SO8vlFmyL+WIGgIQEAsR+6D5TLyTWroMP99l2G1RGr4jk8RGnY1M1V6uihGpKOSkPnFprvDi9AWI9UwJJdNJ4xzIJ2wTPhfK5lm31RRHBLeeJNomdZ3r7S4nv+I9/bRnr+uHiZ0+AuJ/PLPoIKHi9fbLkZnVB6ads7HXIKJh6ebhbqxy70AFiMVaTiEYYrELxwwEwnaFzjaRXoqO2XMdoSp8ORCTPldwAIgelRPZZTOX1jq+uZkuHo6RL/AEl7ieAA+/k7n0NBVgRn7RiFeFg5XvzGhPK4HgKwQap53kE1Z7oC7oyO790Xbl36LShorjqyRH2NUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf8fmvWfkBvcymcN2DsZh62QU2fWxDWL0y/TmPHxYzA=;
 b=pWcQ+HS1iFpR7ANOdRYfGJV7ecAyslLeD1rMozgdVu9x9LH1DO5DJJTrVXk0+178qlIAWuT1bOVDpuPS+wrFX4hwQFx/hkx6OMj8sAo7mQ0RaJ7YjbL3wL8Ge35LRedtunhpd2NkKet8SXjXSXeH3svxiW1yZVOPm53wSISDOOI=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:51:40 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 20:51:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 7/7] mm/mremap: thread state through move page table operation
Date: Mon, 10 Mar 2025 20:50:40 +0000
Message-ID: <230dd7a2b7b01a6eef442678f284d575e800356e.1741639347.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
References: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: e9de0a9f-7ce0-4b79-b3d3-08dd60155b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VKBTJU8xt29yfP4N2RoCD1tr94zn++DBMy1Jkaq6qpIwRjBvTswrqJffodCx?=
 =?us-ascii?Q?EwqMKCsKU2Yh9Gf6n1GjrX4Z3Uj7jeudzmHeJSZDzOc95S9w6uXetfgXPTsj?=
 =?us-ascii?Q?K9fm/l/Jb6SsRzgLJzR07vGlU7tG+dHi+sWwcq5kPIUFqt2CGXlT4Q19NlgE?=
 =?us-ascii?Q?mdCyksCQVWwKbs+4zTQUUr4ptF4fEQQPjbUZE1zsiTLvIggnhSbRH/DmsthK?=
 =?us-ascii?Q?qyxj30/PWX9hl5/7kr7J+BfrdsxPIqyQ8Ql6aSpxHTr4EVYzKs6jkSIED2Op?=
 =?us-ascii?Q?2Td2iYkkeBmVrh45gdEmbT6aeXXfT76hSrWVihxsawKNBNTmi1FXkYX+/v0L?=
 =?us-ascii?Q?0nt1iP6wMuMc5NxNJz6ZXyAXAQtAnJ2t7CujzRRU2cY+TVQakjXQe9g4dwVY?=
 =?us-ascii?Q?8vEL24PgMRezOW70/jepgAzwfqfoeME2BJpqUKnCJsiUsXLRjg4+sxv3TTxr?=
 =?us-ascii?Q?ig/YOMiznLohMbA4Oq97wq0dwzuuVH2sr5jbfz8Sabxw2+bXoq0l4Jwwxis5?=
 =?us-ascii?Q?Zsq9Jn46UThxNcDCMkQ7iJqKL5v+J2kUia0xe4ZxR9FlNX+esLml2v7FIqMu?=
 =?us-ascii?Q?0fIT1Lh/xjIHAFA8d94/c/9AxJiVgirVYMnmuHIx4Ir+ZcF6ViMjH6lGbGRI?=
 =?us-ascii?Q?tGjM20NC/ly5bME1duhuui0PVSUk6AFwOEIYW3+670dPr2vVNcWbOH+0a/Mj?=
 =?us-ascii?Q?0HsV9BXmjRsqIOxgZLq6+sKpxKCLz3lUAR/nufigk+2EInZEFFkoxrFMiZXa?=
 =?us-ascii?Q?dTwuaILT3xJkco16Hhy3fWTZAUyjLWlXLRx9YgDWAjWpEfTOO6Of66ecjlEx?=
 =?us-ascii?Q?Xksp7/O10/28V1VjwkWRwrI5sItIoxxh3VLMTvDlArDWS87QoyIH4s93fvOX?=
 =?us-ascii?Q?qKL4WVYkgONlEdPk/0MRqlAhNkI7VuG1oppux0L130Yg41n2Qlw07bF9rNKS?=
 =?us-ascii?Q?ULW+VDUBoaQ7cPC/oFjp0/KY0+FhkcVtRMFuOOC+L9wo82uyF3IjFCa3E+5u?=
 =?us-ascii?Q?wI3vxo9Mo7eSP8A7uYgW93hvPhhwLbLuXiY+Zgvkz+i6SjjNM2sjNg56uYNA?=
 =?us-ascii?Q?8NRS60MTgiPS1BLKdY0KM+gG14dYP21KDldltP2X3Oigli7Z1Z4BD4wYUXeF?=
 =?us-ascii?Q?N4zuQgF6DapG2esSm2QWSLKi5XFnPnJeucA6iHcVV3IJgmhOQmZfBaYX6bO9?=
 =?us-ascii?Q?IKjpuO38IWrTd1lelJD4sTcPwpiqN5ubvMuziYDnjJxiQAIxmUQcwFWVI4k/?=
 =?us-ascii?Q?WKEKByy4gSfCF4LwzStGK6BQyWtJl0MAU4YAW0aOf5Mp8PnVJfrWSFInYZ28?=
 =?us-ascii?Q?p4kFn01qqQgkpvNOb2oYGfFjk9ZibSrOREABpgW8kAU/uZ1nyE4RSWN1QF4s?=
 =?us-ascii?Q?E2yAfDWWBg6GdEe+0/620EfGpa0/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TISO0b2EC9tnewp2m81UlVPnGPlRJ6ZY/WHIkHmlfGg+75r3Od26hKlHQvJJ?=
 =?us-ascii?Q?SUF5hzNGBuyP37OTGkaMezSy74qY3Nsrw0BQCeZE/vbAb8kuQ0XXEUOVWVJm?=
 =?us-ascii?Q?OCXFl0EC7x/PO5otQxg76v5QYxg8AhVoHjUPJGj2uoX8Cxgu+YZXPiBpt9AO?=
 =?us-ascii?Q?rOZSAVS2J+fvrj7aFJeDeRptuK3geHiDeoYJq+YrxaMF0Ecnsw78bJEcOpjx?=
 =?us-ascii?Q?CR6ICcDwqTTy8faClyJy5Be567oQbPMUDve1XmysHl3QKC8BlbkYhwpm8Tlu?=
 =?us-ascii?Q?mQ82/d+IYv9Yz2YWaf5Vbk77ZvPXgB7iRlmTVkk+Ss2ZURspqsJRmsd2bT6X?=
 =?us-ascii?Q?665fv9OEabqS1fEjczOUs3X9eyC4s8f+n5QQu94FD42rc0LYDWm7vNlJlm6Q?=
 =?us-ascii?Q?B6XYvVrMx4RFgiloY7xdUDgDDNTbSM804Vl8FaWALunDDmUH8x2ha5amoEuD?=
 =?us-ascii?Q?m7DMyUR/58dhafZ2krYjOsGAFEKtbHitBIpa5pYd1Ufy9Bb7AHPFwp6qG4aO?=
 =?us-ascii?Q?PyGzsahm1wEcslkVpLrz29k0Gv24mAOxXfakt0MKCSBS529h7JHGl9pkou0K?=
 =?us-ascii?Q?MSzwN8yZNL/oFMglwUDkCVO2zeOlwAA2alv+ud76JDqcanZhNCIssc1qeIlW?=
 =?us-ascii?Q?MfRTi7GZzRSPsCL4n/Ht9opPFGJ6LirlgTlKniuiAHz2MYmJpQzS8Ftwz66V?=
 =?us-ascii?Q?eq9gGxTiiLdR2cXB+lcPyXiVpAeMdnW7QjFwqqxu3QVxr0Q/VHtTSoNEaFq5?=
 =?us-ascii?Q?bgTUdryQHhiC7y8ah7KpUW+P6gdZnpe6xSYwqmWd2lAmRsjLmMGv+gecKr3+?=
 =?us-ascii?Q?itNSPdwEhciLHGQaByf4or/faEL3ggT2jGgrPsS8BHWz3bpH4j4P4KvaFz5A?=
 =?us-ascii?Q?fLs19+Btu6X6teyQ8/mYu9XAFordKWbqR5Z8Z/dAVD2k8a/5bb65dUQg2JSO?=
 =?us-ascii?Q?AEqTG4EExUaj6MS3Jp62Mq7ttdYYxoFbdS+dEQHJ9s+5CDDRMRzk0pO6OwVI?=
 =?us-ascii?Q?PlyS5Cj7vJ2iWti43kvDjNxjIImt8/yEFAoWsbg3fBTy+S0IuE8poAi3JJ3H?=
 =?us-ascii?Q?E29h/czT7VDAl0okgOEsLxc8f5HoREV+q9+t2lDsZKl3mX86q4J32ztngIXK?=
 =?us-ascii?Q?2pvgwJj7/4sMzKBjCGpoxj9jlhxqvI5H5rJ6UDTP7WBz2op3T0mGV/1YeSVo?=
 =?us-ascii?Q?F7lBFTOpiAGEhhviNAKPoIROwEBMbgCL0Nh2uOtXNCBFZfzyrix8XtERTsaL?=
 =?us-ascii?Q?SA3/EcUYQb0MXsBTsOF1ue7WR9b/+feQLLZsFkjl17gLWWUMOTxU7UUzup+O?=
 =?us-ascii?Q?JiRCTosJXUzV+QJHkPVxmI0sDrgfpxnhc5BZmMhO8fgyJGk1ico2csTWdJ5Q?=
 =?us-ascii?Q?oFpbK88TQJEhUnUC432J5QJz6OvMRJBLaoEaqLN3K+QWONG0w8uqKPSn+jeV?=
 =?us-ascii?Q?KNjQ8SgzNNV2m4od3f5PaoqKOPLWgf6XG4wa1RZyDB5+ncHTXVFeRrC4xynx?=
 =?us-ascii?Q?8ouv9hddS3mF6m5cC/jnWAu7gvzXM7Eu8kqXKYxHTiJHYNlhirPSEKpctygq?=
 =?us-ascii?Q?58e3v47vMRSX7Mjd1mGhni76EymsWzxCoFENVmkEib9k6WOEPKWUGjRj2lE9?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CUxmeVyBeoSJMOv22qZXZ7b9ZXUZs1aSm9nHz6fRpjgyjMSJJ8Pt7uChAIeOmRBDUFBBCf0OmcvTg/uuVv8aKMpNvOVfU4ZAelNlla7BGvQ++93XB6aEohMUgJ5EaLKKCR/hIRccCagHiO5X4uF0f51cfVPvhJPqrum3B0WqyFRN9Ha0J/9GOeVyUcnU2rQGfZvhAFJ80oe43ON0/CxTf0t4FdW2cv4gh5YPG8aQGj/ySSZIXe7d8vZC9MtwKG5xH1Lw8ReOyJFYks0C/jrZJ+kwkfcco1AMJKKDK5ny9GFiu7p/YwKT3VX5X1lTfxiYYZnOJz1CW+fTsnorUoRNK+yRHtAIFMYxyTnW6J2/4H2HkzdqbjxAppttGUiNR2OmF/NGsfxDTZWzylff7Evh4HoAAqRbeEG33ZE62Zm2OPwBFxN4hCPPau+cgJwdVgXjdA3NjMLYuyxVgy1SQIhiufDcGY/eWxnNUkXnOsf+pxHGh9bfWk7EaSFBKIQortqWI9hCutflVGPCIvyWmImSic81z3rBzZKuPxmn0/8ECbTdF1oOt9fb8toi8BdrQJZ56kECL+HgXm9CRP+go5yvU3quFLBtjFVkIKIoUs1zzY4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9de0a9f-7ce0-4b79-b3d3-08dd60155b5b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:51:40.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErCqUx1ufaxBt+pIZlrJ39rnF3pj91iRaGK/fgAQhtasndfU+MSMq19vhJQpFPnx0pwmJojP9zVKdUcYNrHCiAshMN3c3E0hKAqY1e+agmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100159
X-Proofpoint-GUID: -KfhpcOEJfqaQg4Nj3La9JkoWsn1m5sM
X-Proofpoint-ORIG-GUID: -KfhpcOEJfqaQg4Nj3La9JkoWsn1m5sM

Finish refactoring the page table logic by threading the PMC state
throughout the operation, allowing us to control the operation as we go.

Additionally, update the old_addr, new_addr fields in move_page_tables()
as we progress through the process making use of the fact we have this
state object now to track this.

With these changes made, not only is the code far more readable, but we
can finally transmit state throughout the entire operation, which lays the
groundwork for sensibly making changes in future to how the mremap()
operation is performed.

Additionally take the opportunity to refactor the means of determining the
progress of the operation, abstracting this to pmc_progress() and
simplifying the logic to make it clearer what's going on.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/internal.h |   3 +
 mm/mremap.c   | 196 +++++++++++++++++++++++++++++---------------------
 2 files changed, 116 insertions(+), 83 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 6c611ab8eee2..aa0beec14b04 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -36,6 +36,9 @@ struct folio_batch;
  *
  * Use the PAGETABLE_MOVE() macro to initialise this struct.
  *
+ * The old_addr and new_addr fields are updated as the page table move is
+ * executed.
+ *
  * NOTE: The page table move is affected by reading from [old_addr, old_end),
  * and old_addr may be updated for better page table alignment, so len_in
  * represents the length of the range being copied as specified by the user.
diff --git a/mm/mremap.c b/mm/mremap.c
index 3a2ac167e876..0865387531ed 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -108,8 +108,7 @@ static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
 	return pmd;
 }
 
-static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct *vma,
-			    unsigned long addr)
+static pud_t *alloc_new_pud(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -122,13 +121,12 @@ static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct *vma,
 	return pud_alloc(mm, p4d, addr);
 }
 
-static pmd_t *alloc_new_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
-			    unsigned long addr)
+static pmd_t *alloc_new_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	pud_t *pud;
 	pmd_t *pmd;
 
-	pud = alloc_new_pud(mm, vma, addr);
+	pud = alloc_new_pud(mm, addr);
 	if (!pud)
 		return NULL;
 
@@ -172,17 +170,19 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 	return pte;
 }
 
-static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
-		unsigned long old_addr, unsigned long old_end,
-		struct vm_area_struct *new_vma, pmd_t *new_pmd,
-		unsigned long new_addr, bool need_rmap_locks)
+static int move_ptes(struct pagetable_move_control *pmc,
+		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
 {
+	struct vm_area_struct *vma = pmc->old;
 	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	pmd_t dummy_pmdval;
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long new_addr = pmc->new_addr;
+	unsigned long old_end = old_addr + extent;
 	unsigned long len = old_end - old_addr;
 	int err = 0;
 
@@ -204,7 +204,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	 *   serialize access to individual ptes, but only rmap traversal
 	 *   order guarantees that we won't miss both the old and new ptes).
 	 */
-	if (need_rmap_locks)
+	if (pmc->need_rmap_locks)
 		take_rmap_locks(vma);
 
 	/*
@@ -278,7 +278,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
 out:
-	if (need_rmap_locks)
+	if (pmc->need_rmap_locks)
 		drop_rmap_locks(vma);
 	return err;
 }
@@ -293,10 +293,11 @@ static inline bool arch_supports_page_table_move(void)
 #endif
 
 #ifdef CONFIG_HAVE_MOVE_PMD
-static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
-		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
+static bool move_normal_pmd(struct pagetable_move_control *pmc,
+			pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma = pmc->old;
 	struct mm_struct *mm = vma->vm_mm;
 	bool res = false;
 	pmd_t pmd;
@@ -342,7 +343,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
+	old_ptl = pmd_lock(mm, old_pmd);
 	new_ptl = pmd_lockptr(mm, new_pmd);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -359,7 +360,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pmd_none(*new_pmd));
 
 	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
-	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PMD_SIZE);
 out_unlock:
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
@@ -368,19 +369,19 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	return res;
 }
 #else
-static inline bool move_normal_pmd(struct vm_area_struct *vma,
-		unsigned long old_addr, unsigned long new_addr, pmd_t *old_pmd,
-		pmd_t *new_pmd)
+static inline bool move_normal_pmd(struct pagetable_move_control *pmc,
+		pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	return false;
 }
 #endif
 
 #if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_HAVE_MOVE_PUD)
-static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
-		  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_normal_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma = pmc->old;
 	struct mm_struct *mm = vma->vm_mm;
 	pud_t pud;
 
@@ -406,7 +407,7 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(vma->vm_mm, old_pud);
+	old_ptl = pud_lock(mm, old_pud);
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -418,7 +419,7 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pud_none(*new_pud));
 
 	pud_populate(mm, new_pud, pud_pgtable(pud));
-	flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
+	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PUD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -426,19 +427,19 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	return true;
 }
 #else
-static inline bool move_normal_pud(struct vm_area_struct *vma,
-		unsigned long old_addr, unsigned long new_addr, pud_t *old_pud,
-		pud_t *new_pud)
+static inline bool move_normal_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	return false;
 }
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
-static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_huge_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma = pmc->old;
 	struct mm_struct *mm = vma->vm_mm;
 	pud_t pud;
 
@@ -453,7 +454,7 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(vma->vm_mm, old_pud);
+	old_ptl = pud_lock(mm, old_pud);
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -466,8 +467,8 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 
 	/* Set the new pud */
 	/* mark soft_ditry when we add pud level soft dirty support */
-	set_pud_at(mm, new_addr, new_pud, pud);
-	flush_pud_tlb_range(vma, old_addr, old_addr + HPAGE_PUD_SIZE);
+	set_pud_at(mm, pmc->new_addr, new_pud, pud);
+	flush_pud_tlb_range(vma, pmc->old_addr, pmc->old_addr + HPAGE_PUD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -475,8 +476,9 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	return true;
 }
 #else
-static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_huge_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
+
 {
 	WARN_ON_ONCE(1);
 	return false;
@@ -497,10 +499,12 @@ enum pgt_entry {
  * destination pgt_entry.
  */
 static __always_inline unsigned long get_extent(enum pgt_entry entry,
-			unsigned long old_addr, unsigned long old_end,
-			unsigned long new_addr)
+						struct pagetable_move_control *pmc)
 {
 	unsigned long next, extent, mask, size;
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long old_end = pmc->old_end;
+	unsigned long new_addr = pmc->new_addr;
 
 	switch (entry) {
 	case HPAGE_PMD:
@@ -529,38 +533,51 @@ static __always_inline unsigned long get_extent(enum pgt_entry entry,
 	return extent;
 }
 
+/*
+ * Should move_pgt_entry() acquire the rmap locks? This is either expressed in
+ * the PMC, or overridden in the case of normal, larger page tables.
+ */
+static bool should_take_rmap_locks(struct pagetable_move_control *pmc,
+				   enum pgt_entry entry)
+{
+	switch (entry) {
+	case NORMAL_PMD:
+	case NORMAL_PUD:
+		return true;
+	default:
+		return pmc->need_rmap_locks;
+	}
+}
+
 /*
  * Attempts to speedup the move by moving entry at the level corresponding to
  * pgt_entry. Returns true if the move was successful, else false.
  */
-static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
-			unsigned long old_addr, unsigned long new_addr,
-			void *old_entry, void *new_entry, bool need_rmap_locks)
+static bool move_pgt_entry(struct pagetable_move_control *pmc,
+			   enum pgt_entry entry, void *old_entry, void *new_entry)
 {
 	bool moved = false;
+	bool need_rmap_locks = should_take_rmap_locks(pmc, entry);
 
 	/* See comment in move_ptes() */
 	if (need_rmap_locks)
-		take_rmap_locks(vma);
+		take_rmap_locks(pmc->old);
 
 	switch (entry) {
 	case NORMAL_PMD:
-		moved = move_normal_pmd(vma, old_addr, new_addr, old_entry,
-					new_entry);
+		moved = move_normal_pmd(pmc, old_entry, new_entry);
 		break;
 	case NORMAL_PUD:
-		moved = move_normal_pud(vma, old_addr, new_addr, old_entry,
-					new_entry);
+		moved = move_normal_pud(pmc, old_entry, new_entry);
 		break;
 	case HPAGE_PMD:
 		moved = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			move_huge_pmd(vma, old_addr, new_addr, old_entry,
+			move_huge_pmd(pmc->old, pmc->old_addr, pmc->new_addr, old_entry,
 				      new_entry);
 		break;
 	case HPAGE_PUD:
 		moved = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			move_huge_pud(vma, old_addr, new_addr, old_entry,
-				      new_entry);
+			move_huge_pud(pmc, old_entry, new_entry);
 		break;
 
 	default:
@@ -569,7 +586,7 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 	}
 
 	if (need_rmap_locks)
-		drop_rmap_locks(vma);
+		drop_rmap_locks(pmc->old);
 
 	return moved;
 }
@@ -705,108 +722,121 @@ static void try_realign_addr(struct pagetable_move_control *pmc,
 	pmc->new_addr &= pagetable_mask;
 }
 
+/* Is the page table move operation done? */
+static bool pmc_done(struct pagetable_move_control *pmc)
+{
+	return pmc->old_addr >= pmc->old_end;
+}
+
+/* Advance to the next page table, offset by extent bytes. */
+static void pmc_next(struct pagetable_move_control *pmc, unsigned long extent)
+{
+	pmc->old_addr += extent;
+	pmc->new_addr += extent;
+}
+
+/*
+ * Determine how many bytes in the specified input range have had their page
+ * tables moved so far.
+ */
+static unsigned long pmc_progress(struct pagetable_move_control *pmc)
+{
+	unsigned long orig_old_addr = pmc->old_end - pmc->len_in;
+	unsigned long old_addr = pmc->old_addr;
+
+	/*
+	 * Prevent negative return values when {old,new}_addr was realigned but
+	 * we broke out of the loop in move_page_tables() for the first PMD
+	 * itself.
+	 */
+	return old_addr < orig_old_addr ? 0 : old_addr - orig_old_addr;
+}
+
 unsigned long move_page_tables(struct pagetable_move_control *pmc)
 {
-	unsigned long extent, old_end;
+	unsigned long extent;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
 	pud_t *old_pud, *new_pud;
-	unsigned long old_addr, new_addr;
-	struct vm_area_struct *vma = pmc->old;
+	struct mm_struct *mm = pmc->old->vm_mm;
 
 	if (!pmc->len_in)
 		return 0;
 
-	if (is_vm_hugetlb_page(vma))
+	if (is_vm_hugetlb_page(pmc->old))
 		return move_hugetlb_page_tables(pmc->old, pmc->new, pmc->old_addr,
 						pmc->new_addr, pmc->len_in);
 
-	old_end = pmc->old_end;
 	/*
 	 * If possible, realign addresses to PMD boundary for faster copy.
 	 * Only realign if the mremap copying hits a PMD boundary.
 	 */
 	try_realign_addr(pmc, PMD_MASK);
-	/* These may have been changed. */
-	old_addr = pmc->old_addr;
-	new_addr = pmc->new_addr;
 
-	flush_cache_range(vma, old_addr, old_end);
-	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
-				old_addr, old_end);
+	flush_cache_range(pmc->old, pmc->old_addr, pmc->old_end);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, mm,
+				pmc->old_addr, pmc->old_end);
 	mmu_notifier_invalidate_range_start(&range);
 
-	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
+	for (; !pmc_done(pmc); pmc_next(pmc, extent)) {
 		cond_resched();
 		/*
 		 * If extent is PUD-sized try to speed up the move by moving at the
 		 * PUD level if possible.
 		 */
-		extent = get_extent(NORMAL_PUD, old_addr, old_end, new_addr);
+		extent = get_extent(NORMAL_PUD, pmc);
 
-		old_pud = get_old_pud(vma->vm_mm, old_addr);
+		old_pud = get_old_pud(mm, pmc->old_addr);
 		if (!old_pud)
 			continue;
-		new_pud = alloc_new_pud(vma->vm_mm, vma, new_addr);
+		new_pud = alloc_new_pud(mm, pmc->new_addr);
 		if (!new_pud)
 			break;
 		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
-				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
-					       old_pud, new_pud, pmc->need_rmap_locks);
+				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
 				/* We ignore and continue on error? */
 				continue;
 			}
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
-			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
-					   old_pud, new_pud, true))
+			if (move_pgt_entry(pmc, NORMAL_PUD, old_pud, new_pud))
 				continue;
 		}
 
-		extent = get_extent(NORMAL_PMD, old_addr, old_end, new_addr);
-		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
+		extent = get_extent(NORMAL_PMD, pmc);
+		old_pmd = get_old_pmd(mm, pmc->old_addr);
 		if (!old_pmd)
 			continue;
-		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
+		new_pmd = alloc_new_pmd(mm, pmc->new_addr);
 		if (!new_pmd)
 			break;
 again:
 		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
 		    pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
-			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, pmc->need_rmap_locks))
+			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
-			split_huge_pmd(vma, old_pmd, old_addr);
+			split_huge_pmd(pmc->old, old_pmd, pmc->old_addr);
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
 			   extent == PMD_SIZE) {
 			/*
 			 * If the extent is PMD-sized, try to speed the move by
 			 * moving at the PMD level if possible.
 			 */
-			if (move_pgt_entry(NORMAL_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, true))
+			if (move_pgt_entry(pmc, NORMAL_PMD, old_pmd, new_pmd))
 				continue;
 		}
 		if (pmd_none(*old_pmd))
 			continue;
 		if (pte_alloc(pmc->new->vm_mm, new_pmd))
 			break;
-		if (move_ptes(vma, old_pmd, old_addr, old_addr + extent,
-			      pmc->new, new_pmd, new_addr, pmc->need_rmap_locks) < 0)
+		if (move_ptes(pmc, extent, old_pmd, new_pmd) < 0)
 			goto again;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
 
-	/*
-	 * Prevent negative return values when {old,new}_addr was realigned
-	 * but we broke out of the above loop for the first PMD itself.
-	 */
-	if (old_addr < old_end - pmc->len_in)
-		return 0;
-
-	return pmc->len_in + old_addr - old_end;	/* how much done */
+	return pmc_progress(pmc);
 }
 
 /* Set vrm->delta to the difference in VMA size specified by user. */
-- 
2.48.1


