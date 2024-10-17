Return-Path: <linux-kernel+bounces-369973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CCD9A2518
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E1C1F275F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E751DED67;
	Thu, 17 Oct 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XYNv3C3u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cu89zcW4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062721DED63
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175533; cv=fail; b=WJ+whgqtseua8RqIC7QiNbLkiKBr6Py4bsD7P/FOr1RCGA2NTlZs24tTxgMHKO1Ialwp9vfDLC5XetNLVBu1zZ3Jq5eYYI5EdIxDH5zM+6hV0dcZqRYfh9de4hXgrpQZgk2tkkdXOPmwAdyf5TJWijNlSet9hcac9Bh/5VSlD5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175533; c=relaxed/simple;
	bh=/NbR95b6kIYfs47sP9PpX8xBVOOc6Kh5yt+tTqBIufU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ckkdsg+BLTW3RODysLkUAQWUNqV6uPhns5zcQ5RpIJmXtBW7tBwfQ0PP3EV/FPfeWonc5F2yAHA0q4yMEl/z87CL8Njkk0E+thnVtSvaVabDLigyiYrzrzcLDtIlqHXELqy/ZuWA2bgQjqK1J2jQYTzRD0Xk9rTBP0Gbqb0Q/38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XYNv3C3u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cu89zcW4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HEBejH013076;
	Thu, 17 Oct 2024 14:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=o0Sny/sBRVs8IfCJ/rDpvACzizqPjudQsF2MltKVY2U=; b=
	XYNv3C3u++t2d4f6UZ/XVDd6lPqEcYCc4rjXULqI6OnBEhYolX+AcSV8VcEUQmWR
	zkfr15i0RS2xy8rBDBP59W6AbrLYtaDoNaWWC6whr3cmWmJYVt9bDC7ICxZUpDIh
	M2Gy0b3QZfTwQx2/UXYrwTaI1m5PfVkzdKKkS7DnaKPTeRGj0U15N7QM3NupYHt7
	Yue8wyYr06IEYq34yYqJbpE4g9EOubNZ8vEBEPYORRfn4FnoxTbxwxZ1oHt5Xxxi
	yqzvxsjmByxSvaqryriF2YzPsaXEf4hAhbUf6PRehHh8em5nGhKnK6HqWwmQ5neo
	kP6yPtf7A3vn13hidmbKFQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cpyau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 14:31:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HDDD4C013980;
	Thu, 17 Oct 2024 14:31:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fja9w2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 14:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTBSVYR76xHzQ69XM1racTt3XjQPlSOGUsUGcYnKMAJr7nL6UNWN0Pdhjtf3NILYqBPh5bt2puNz9N7kOh1VF0W2JEBb7hwRHrEbf1vDWvTFs7DZKAm/3ZrdC5PtK715D+GD78o9YGDBF5/Oay6Rz1kgp39hj5/Z24SDKcDkFW4qyBg3tokPLpNG5hgN7cA44jb/wv8H6J+VzMZRNpOCUv0qCkYMLR/0Y+ty9AZ+Iv7uQEQIb1gnzr2hMPtkkumCV0d2qn9Yzp/DFU/Hgpqk3zKGaT7FlRiGXxli4cDVENw23kj62JEAIaCOGf8qUXRQC5+eKTT5jq70BwjF8SBHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0Sny/sBRVs8IfCJ/rDpvACzizqPjudQsF2MltKVY2U=;
 b=d0x9hZC9vXzYyxla1w5uMTETHhsxMknSR/edsdfwDWWS5ADDpLBmY2ldSwbdk4CNiI7Pm07CVgaBN7E5yI17QNOMohAbSZ9NWTFUMNeJrAqoO+fmjWxar9ux1aKcL9LIi/a4UfBeOdy0jnvZ6Dg78NW9ZperpWhDkZ7jfVnZrQ6pPqzYwSiy3Relxb/bjFq8OPTs1MDFHCuFhVpvAQNwLkkkPsaQiRKN7Hxlip2VTTn4M19m1baWGpcRG8/hpaTsKQA5pNaQFcTt1nLTEnf5YWFre56QERBHfYsatAiZ6Q0v62s4R7oJjIqgVS40Li5Lrs7Pyr2ciLXV+vVkFY6SmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Sny/sBRVs8IfCJ/rDpvACzizqPjudQsF2MltKVY2U=;
 b=Cu89zcW484cIMjPK7TKqo4+ZSDeom3OGxdpBFWkzCT7harTja8st8vXJcC/JckVFatoWqUk1dXi0k76fqk7ZU5GoAsSWGX5+O2eXywbLSmrc6jVSxCEWYXbyvc7lRXZcn4d6o8s8OuTSm8HhyPa6BmCgaxkf1J4wF2Y9COSCARw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 14:31:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 14:31:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH hotfix 6.12 1/2] mm/vma: add expand-only VMA merge mode and optimise do_brk_flags()
Date: Thu, 17 Oct 2024 15:31:45 +0100
Message-ID: <4e65d4395e5841c5acf8470dbcb714016364fd39.1729174352.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729174352.git.lorenzo.stoakes@oracle.com>
References: <cover.1729174352.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM6PR10MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3bd83f-15ea-4a0e-e3c3-08dceeb8726e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ZneJuyNL39kPT94ZFk4oV/oY+3n5pIMuoUL265eTDt9tV/GTqcwIzx7NgPe?=
 =?us-ascii?Q?+9rUd//1HaQzQmOZ6R8slzg3+Tun0S2TT5GTH16ONN5glvL8UIEvMySwBc+x?=
 =?us-ascii?Q?GkmVUfPJ0Noisk34+Byg41NOqxAbiQGugq/SVjhzF+kxXqcwlGhCqEhsLpDd?=
 =?us-ascii?Q?yT+kopDxCr1LQokA6fvwRMcoIzrZ9dXC5hj/Q178ku8CgLBp7/+wWFV60E10?=
 =?us-ascii?Q?pTELnTohcow5XdVAzFNyvCP/vE+AdQkufdd/pOvQFbuAYKlRt6GKRsCfRqGa?=
 =?us-ascii?Q?NvZe8BO4QvEnrnATN0bDARqbBVkKQeZ0EE23DDtdTO/Pp/7rGckgCS4YBtKh?=
 =?us-ascii?Q?/zCNG3dN+mtZ6ArcaAaIYXvKAiH2WNX4lew7TM+5K5zZLho+ms69mKh9eWjh?=
 =?us-ascii?Q?7vGndp6EcYCYkIHYcXV4MGl+rTe1WEIGHLYX5b2cNWdPGad8zrNvK2szqm7z?=
 =?us-ascii?Q?zkF65QmvIGvSrKL/BUp/kBrTQZlBnP+JWUeig+F1H7LicSiR9Lqrbu5eSoG6?=
 =?us-ascii?Q?wv8hVasfeXxDpNIa8FtQQPb2cwEafXfHIZ4nFFtvkoWtX6JVuc1iK7Vji6ar?=
 =?us-ascii?Q?sYIWJY09wLEYuDbmCDsiZ0wHZ9pCQI+yQ5rawP8ZAMnNu8eBOIyM47Lpx4gf?=
 =?us-ascii?Q?eWA8W26UsoY2AfKTa2H4McgHiRkhgPceS/+o2QomM6x0ou09v3IJ4pvMA8sk?=
 =?us-ascii?Q?YI4Cx2ik1n4R2HfDUy29tzrcnsQHhh+yRcuHPnIxEVwfKwYpVyrkTX7L3lLx?=
 =?us-ascii?Q?kzkUYwjjr8/K/3JNDfPJw7m2SRiD3gjrbjoAQ4bZ8UYq9cUzYFZgG59etnBR?=
 =?us-ascii?Q?ywO7umk0W9WX4YcsvmNwYfsu6xZUOvgq87oeLPVYVU5b/fezb9b63PZ2yRox?=
 =?us-ascii?Q?aCR8KriOayFX1nTq+75iJ08lNtaPYSk5aqYBxt/aWqk/0RB+bZ0dIJ5mmTIP?=
 =?us-ascii?Q?KRuFrFvdxnSLxXLJPBpJKNxTmXJ1xzSZ23gwzuwGVXL/xdjyibCg0lyyORoe?=
 =?us-ascii?Q?2BPRV9mPnzUIv2JEKdoYUlkiH9FYxirT0q+UFfv85zodlRPJ86LyKAdhF6E5?=
 =?us-ascii?Q?wt43HqeOFEhoCTUdgru64QrsAl8/L6eFIXJLdBqrmtTr8JnykNNMc3vuDghQ?=
 =?us-ascii?Q?oC/XP+cpogHo8mW0pVCcBJiTr9b8l0HOBuQp6v6+VcuM/tFuLgi9YDebr1uc?=
 =?us-ascii?Q?rxroo5Je3ykXwuWrPGwYjKuqUG/iEboJlKmWW7cQmuwpFNnI8VOnGEN81TaZ?=
 =?us-ascii?Q?1lTP2ezCM4OSfFU7V/bNUcWUcLo5M+NEwdr22zcYzGuUK3EorPNjitCE3aW2?=
 =?us-ascii?Q?iUKjAWhhqAubg2uoC+fIMzhx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d1/LtrJqAaALZqqPU8opouKpSW+YsP2JDGGf9qi0M1wOWsN2BQrcIL7IgL9S?=
 =?us-ascii?Q?Jgf/BiY0UjD61/zz0WDdJHBNqax1FHPeYQXuaaqbX9/2ERxFX612LSnu/1YQ?=
 =?us-ascii?Q?XYtbBgN+td2au6NrS21gMaZQvLenf2Ajxx6XjsEd7fF0k3DArE2VLwikpQhu?=
 =?us-ascii?Q?VVaT3SQc+C/cxuClukjSMYjBxVFuFKbiYFJfFtlmRmza+Gq3hhH3wpV1EAiQ?=
 =?us-ascii?Q?y5X71RR2soJv3e8I6t2iFraxC82484CMO+6OLZMkM5jf9CQzPZZXCQ5FRpeN?=
 =?us-ascii?Q?XEs+OarRPvZV+BjU7b8/lvWRjrYliuwBYXMche9CDSku8tBz+K+Pm8mtH+T2?=
 =?us-ascii?Q?JTt/w51zL1bZvqBQzBwCtOc/GUWCMx2v9PoAAbBwt3MeEGf6QjPYxPXBbLSq?=
 =?us-ascii?Q?BgyV+ML0GKDx6IDlFY/DfNQzehac5/pmJ062f7emrBmaXBGvMxI2UbD1yTo+?=
 =?us-ascii?Q?J0BEIeB2Fy78iXQ/Gk3D7IiQrdA+2g3n9uq624ntlY6Y5qvaR7ARGxzZ9DtR?=
 =?us-ascii?Q?d6T/9ux9OU6PSZ6hbG8ELZIFJieQRHu6FXxBDwHFniki348jlruuBmT/1u83?=
 =?us-ascii?Q?z6aZA7hxn85OLzVQKA6e/2N723CsCHygChaoE/Gp92MQQ1sIBMIxKNos68Da?=
 =?us-ascii?Q?lcRPJUfVOs0TR1ZU+g3g0jgu6pIiEl1Q4taoF9QUKRfP3gXmihzqQcc6/CtA?=
 =?us-ascii?Q?XrrO58kdAPLU5V//KGfMSf/0u68M2+CWEpxRF4d9gf3mBlPsPNYCEX/ucWoI?=
 =?us-ascii?Q?cFYIGWSRiOUPWWEKJ7h8BueHrQpKC4gD97AOUlaAvf6Xqt+ZYwP9DfHISbri?=
 =?us-ascii?Q?gGXkxIPET+dOJrFcL+dOT+7/WQ+IiidBCJ1Q0N8/fICwddpKctB0o4mgtHY/?=
 =?us-ascii?Q?3twvP4qkooUyQeKdP2Y2ZprlSxzkVt6/cCFZX5AS791D1gTUmv4tT511GnU7?=
 =?us-ascii?Q?FsLtOk/9wtUVXEdjpBiybENDdSAgfIz9elASA2UXm8vLIJY/lXqNh/ZudTUz?=
 =?us-ascii?Q?qAssgU6aEksaSYx1ezdEQQAZy0UANHrz42FeBEv89YGbyhqmxiOU+7OrZT8s?=
 =?us-ascii?Q?BJkPK0dKmde2HGmciosg3FmGD5zk2cR+Lfkxgf1PQ+ltviYQ+mqt5a1KuTpM?=
 =?us-ascii?Q?M6Pdo1SS/WlTqqJ7mbCq/r0eIgG2gg3wni+SFbvFVryAbFoOwh+p3qgLgr39?=
 =?us-ascii?Q?04DPEp3aOkWYQr9/n6giQvJ0kIcBXSExGESRk7FiwAUCdOJwi4aJBn3zs1uP?=
 =?us-ascii?Q?uB/EW+FS2F9ZOdLFMb6iyxozBwr/HP5Geer9SAQLrt8bj+i8hypOeBH54Qol?=
 =?us-ascii?Q?L4wqsHC9329KZtKMKHZH94z4nQFHKjv0Y91otJr7GUiYVYtXWGCdWmBxXuQR?=
 =?us-ascii?Q?nGPUmGBVtMPKwjU3auz3FqsEhxxX3yQTub0hNqtDg/+6Q/OSGz1Gwf7dBTJ1?=
 =?us-ascii?Q?QxOmN856SI7L1SoYmyZQIg50RRHAyHVauypCipwgD+wDP1CGWewmz0QL588n?=
 =?us-ascii?Q?PcbXXYcyKo5LOiRqxRKd9p0m/sCUmxY6Offbn5YHdyRLgVVYdJdm0FmSGaes?=
 =?us-ascii?Q?c7BTTeruSJ7aaOShnvxyYf4pw1iumuZ+rzRS4N94estIDePu7KiHeqfbIWNe?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IY7GPiIXKK9A/67wy4CfYMBU3uAG1Ln4u3w6v5jnBrPLjRFXaCljXStvvQZ2uqYpRUAlGO+ggi8IV0xQ9EJVeEGjavmwU4dt24kX1fH6z2M1RL//2TLZWit5Fhf2z3PCzB69utkQQ3DzQqMQDRz6JSt9xx/vyu3daJ8nVSJDBUHVZNclExtbHO8UbsigdgURkxORiWbNl4POG5zlUkYJz1kgHr8iC6fBhTp5Bj4LqEViI0K2p8pO4Qs+0UF+DjBydEGnZpCFNpNaVH3hwREC8L+m8boy7DP1hSIAWnKz0aMPp2nl7qBuVs6RkR1jYFP+RWO+HG8QelpNS9qLavEvRdouiLH2PcVtVbLa95GgBwp4E46Mt2QIzznALsnR0/hq2aQUStlv6ezA07buX5prE2BCwSaZtAKF+hxtrvdYcTOQH63P60QNMOuMueeSJWwHcs2o6uDy1njud/zNa3X58mM7pW8TZpunKe8R1AieyYny2FHDhY2KUljIPIKHWzK01ZCbPe3FYMnFfZ+T+Gl+eMlpZa1DeMird92H/fx3yA7BlFB94N2DZWubxREUi3ZpvBpsr2mWUIKoECTTtXrKMnHzdnC1turmWRovIT7J4mM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3bd83f-15ea-4a0e-e3c3-08dceeb8726e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:31:54.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TARtuWYx3ogJO0cWsOqN23nC4beLlu+yK4WkziNTw6+abjMcIY2bsI5mJERZyr4AHNDW6Fp7rzOrbNCXJMszMvZIlvJvUIshEijGuC4Tjwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170100
X-Proofpoint-ORIG-GUID: eny0VBzDcEIIsEfTlyDRfD6gVkwMAgZq
X-Proofpoint-GUID: eny0VBzDcEIIsEfTlyDRfD6gVkwMAgZq

We know in advance that do_brk_flags() wants only to perform a VMA
expansion (if the prior VMA is compatible), and that we assume no mergeable
VMA follows it.

These are the semantics of this function prior to the recent rewrite of the
VMA merging logic, however we are now doing more work than necessary -
positioning the VMA iterator at the prior VMA and performing tasks that are
not required.

Add a new field to the vmg struct to permit merge flags and add a new merge
flag VMG_FLAG_JUST_EXPAND which implies this behaviour, and have
do_brk_flags() use this.

This fixes a reported performance regression in a brk() benchmarking suite.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/linux-mm/202409301043.629bea78-oliver.sang@intel.com
Fixes: cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c |  3 ++-
 mm/vma.c  | 23 +++++++++++++++--------
 mm/vma.h  | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..4a13d9f138f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1744,7 +1744,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));

 		vmg.prev = vma;
-		vma_iter_next_range(vmi);
+		/* vmi is positioned at prev, which this mode expects. */
+		vmg.merge_flags = VMG_FLAG_JUST_EXPAND;

 		if (vma_merge_new_range(&vmg))
 			goto out;
diff --git a/mm/vma.c b/mm/vma.c
index 4737afcb064c..b21ffec33f8e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -917,6 +917,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	pgoff_t pgoff = vmg->pgoff;
 	pgoff_t pglen = PHYS_PFN(end - start);
 	bool can_merge_left, can_merge_right;
+	bool just_expand = vmg->merge_flags & VMG_FLAG_JUST_EXPAND;

 	mmap_assert_write_locked(vmg->mm);
 	VM_WARN_ON(vmg->vma);
@@ -930,7 +931,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		return NULL;

 	can_merge_left = can_vma_merge_left(vmg);
-	can_merge_right = can_vma_merge_right(vmg, can_merge_left);
+	can_merge_right = !just_expand && can_vma_merge_right(vmg, can_merge_left);

 	/* If we can merge with the next VMA, adjust vmg accordingly. */
 	if (can_merge_right) {
@@ -953,7 +954,11 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		if (can_merge_right && !can_merge_remove_vma(next))
 			vmg->end = end;

-		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
+		/* In expand-only case we are already positioned at prev. */
+		if (!just_expand) {
+			/* Equivalent to going to the previous range. */
+			vma_prev(vmg->vmi);
+		}
 	}

 	/*
@@ -967,12 +972,14 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	}

 	/* If expansion failed, reset state. Allows us to retry merge later. */
-	vmg->vma = NULL;
-	vmg->start = start;
-	vmg->end = end;
-	vmg->pgoff = pgoff;
-	if (vmg->vma == prev)
-		vma_iter_set(vmg->vmi, start);
+	if (!just_expand) {
+		vmg->vma = NULL;
+		vmg->start = start;
+		vmg->end = end;
+		vmg->pgoff = pgoff;
+		if (vmg->vma == prev)
+			vma_iter_set(vmg->vmi, start);
+	}

 	return NULL;
 }
diff --git a/mm/vma.h b/mm/vma.h
index 819f994cf727..8c6ecc0dfbf6 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -59,6 +59,17 @@ enum vma_merge_state {
 	VMA_MERGE_SUCCESS,
 };

+enum vma_merge_flags {
+	VMG_FLAG_DEFAULT = 0,
+	/*
+	 * If we can expand, simply do so. We know there is nothing to merge to
+	 * the right. Does not reset state upon failure to merge. The VMA
+	 * iterator is assumed to be positioned at the previous VMA, rather than
+	 * at the gap.
+	 */
+	VMG_FLAG_JUST_EXPAND = 1 << 0,
+};
+
 /* Represents a VMA merge operation. */
 struct vma_merge_struct {
 	struct mm_struct *mm;
@@ -75,6 +86,7 @@ struct vma_merge_struct {
 	struct mempolicy *policy;
 	struct vm_userfaultfd_ctx uffd_ctx;
 	struct anon_vma_name *anon_name;
+	enum vma_merge_flags merge_flags;
 	enum vma_merge_state state;
 };

@@ -99,6 +111,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.flags = flags_,					\
 		.pgoff = pgoff_,					\
 		.state = VMA_MERGE_START,				\
+		.merge_flags = VMG_FLAG_DEFAULT,			\
 	}

 #define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
@@ -118,6 +131,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
 		.anon_name = anon_vma_name(vma_),		\
 		.state = VMA_MERGE_START,			\
+		.merge_flags = VMG_FLAG_DEFAULT,		\
 	}

 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
--
2.46.2

