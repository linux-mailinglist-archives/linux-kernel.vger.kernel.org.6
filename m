Return-Path: <linux-kernel+bounces-206630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9E7900C21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A15E1C21743
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B193314B952;
	Fri,  7 Jun 2024 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gaB3ho/o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gEeJ+Gdu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F0149DE1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786474; cv=fail; b=bqCV1nTwotIZqrceKoHAresaCIW7yZ786up4FG5zk3yKB21GPiedEGrPRN2xRKOd0AwEn0YXICEQ8RUtBlEwDILXXFFuaOkOEUZYPnSUZ2BIomgMxXJSFWlOvh3O5Usb117IN2S/6Wmu6n3oMuV7xOCTy256+udA7zE3okcla6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786474; c=relaxed/simple;
	bh=ivblhPz4Jc5nLEphsHCc9pIwWZ44cP9vMhqcpVf64g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KI3zn/DBNEoIz2UwIisuTE+dJskjIEK+ORoNNC/cx7ui1UUq7i/MlVWtFEOAPpV0eykVRX3HcCf9BY1DjaKbX8DmUUIglr2avH18pXUe0p27GVht96owyrSHEP4z27+NtSBouSs1aik+4zwmksY5zkPzYn2NcZ2z2Jap/+K3zww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gaB3ho/o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gEeJ+Gdu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuTD8019997;
	Fri, 7 Jun 2024 18:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=LN9dwNd6OihPg+ZrPmID4uIjxFNM2h9/QkvA8wi9P2Y=;
 b=gaB3ho/ozowoxX2Mxoe4izq1XrxprzFbRekUCfPa406GOgRmmS7HXFWWH/TQvb6/F878
 AGTE6WMHZiR4voAFlwMb3vx9EUyx4VI+HgrisDLkwYrofdekuqtdZxd3tlXh2bvR9FIa
 QEw9vZpe5m4qK+8YJhC+Ef/tSdv+AFByYfogdsbLANIjI/ai8mwZT6lbm3K3+y0a9OCA
 KQAVR3sU0GpoRa8elpQFj3ekjcr37aOBB/3TkqKT3ujsZlmU5KEkYQaai7ncjddW2/0A
 pAG2m0vd8AKk5SotRvx+JEB+IOF+KwKCKuRKAb/01WWcw98f9ep51GA0XFr1LWa/d/My Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsye9cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457HOGFx015573;
	Fri, 7 Jun 2024 18:54:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjh0eud-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzOIIHN9TA03DbccKkOVCVOvtQRi1UdZ7xyoiR5gD7x79OhAX17IWttds3UQQ5jdkc6oJwXQ90dWcBtaATgHpWIUBEhgUhUcWa3cIKLWyXLhI/fnpwxS9/bA4zQUndNZEDYjhCxMSn5lHJp3gggYKeWLgcdTqUtUsiXW67YxkP1WXMAWrMfU2v3a7EbGp80794JPFLH1XMarBRTKl5pmJ0ZNW2J2oNa/earlXpr0GzMOEAwPPh71mn1DX1RDjySZJPH7BT+a29JzuWeroU3X8D5bA7xeV5I2fYHWr9mCZ2I7voDzLzdM4llTRPkWT8IOASJu9kAq47fdXnqWQaWbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN9dwNd6OihPg+ZrPmID4uIjxFNM2h9/QkvA8wi9P2Y=;
 b=Ta4kBGRBI0yLH03dsS3A2rxZl0Zx5DFyj2UlqdEU7FaSf6pMFrYp56K2v/8BGq5nkJbUrutloKqsY0/FOf1Xw3WmXLdr1A3hIhkvGB4/GB/F5ajdBnjSLJ+6qp8NYzy8xyolJvvQQih6Fd+a+fI4QZ7xDlx1no5KWHRunWmUb/IYC8EAk+4vehbj+iaVzrIaorAfs/qwEOnbYa+UltcnTR/B9475BWnAkb9L6PT4Uk95syHuIMVT9/9qAs67r0c+U0SYUCESRUPQmW3oDdqagY7gLYCAhGdkI+rqXlIeXk34P8rbeiCrJOXN8L6NuUksBanxQwTEAyQRSaG9u7p1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN9dwNd6OihPg+ZrPmID4uIjxFNM2h9/QkvA8wi9P2Y=;
 b=gEeJ+GduASQUMrYVMwT7qR4fhrXNMq7Q6cM8/L6BB/BhgqVlkz+2XU1FnzCQdyvDvnCuXGDk2qRG2TjBqcxc16WukjRbSq0NxLv94vtaUEyqAZAzK8ppIJZHrrNqn97Qou5BTBHfC1vyA0/BOvjkxdlPHciVlKSUSXfTtPQa75Q=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 18:53:53 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:53 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 16/16] maple_tree: remove unneeded mas_wr_walk() in mas_store_prealloc()
Date: Fri,  7 Jun 2024 11:52:57 -0700
Message-ID: <20240607185257.963768-17-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0030.namprd19.prod.outlook.com
 (2603:10b6:208:178::43) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: ae91e1bb-95f5-4401-8aa3-08dc87232cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AwAQwDl1kyQjosB6tEji8N9tcbDpK41RQEmP6S3JEmelccFpC8EH3mhQ5yLs?=
 =?us-ascii?Q?0Kbz4RjUvYJ5obfrvYVSdiq1wKQLrbdFQwDVL1kDFgE6nrkVNt/E6QHjAyEE?=
 =?us-ascii?Q?c+xluG6mn/GyaXccq/UtR/G7XC0g/nFHJoE65afRmuCwWEhkZ7+BCj6wSVQy?=
 =?us-ascii?Q?8glrdZ9+ubjLW6xJ3dgyzTOaA8aAkubfA3uUQR4mFBaCAcMnopGjKo2rCtYb?=
 =?us-ascii?Q?W0gLB+EurThDHN9BeIyTDAnRoxl3TyiB71/MgwdhPHoJbjOEDqaqbvrpi62c?=
 =?us-ascii?Q?9eiP9GizFF4qfDaVbIo2pxdUa9sOL2GhzIaUMougfS9TOpJX4caOGK+WVb9N?=
 =?us-ascii?Q?kdHIqiXmY33JDXOLjb3OkJXKc+JUVudNV1zCh1C4msS1QcOXraGfC+QVQ6Am?=
 =?us-ascii?Q?9eDrZUIL45DGdYuVDyNIalmA6YC7csoneNE1eDn98sYwOLhTRb1ygGUArIfg?=
 =?us-ascii?Q?y1zVCSKeYP1Y/uqPKKuoZI2cvzyWJzqclNNOZeT7j53e2zFTF9S1TjT9jO+j?=
 =?us-ascii?Q?SzN19GP3cYsxYAr/XAKK+rU0+YBPR123e1JiNHCakd6xvA3pKR6+Lb5JJsQj?=
 =?us-ascii?Q?pnfrUOZlTPs8zRQaLIzO8FQIKMUGtke0B9wLDzmQEPmMQaQiJTzpFviTcOLd?=
 =?us-ascii?Q?Tw2HGyfg4R/2D7g1K9/On0varCdjeEXYgSxzlxiOcD0/V1Y4GbDP4oak7OZ1?=
 =?us-ascii?Q?4B41TH68yFhF+OlGh9UfnKFi7cqKswjrv2KKna/HFmYz+Q4WVI7O7ZEqFQSR?=
 =?us-ascii?Q?/bbVY96fJfJXNYXBB88rjZtq1DcGP2IkORAg6eCRfOpszTMSynlEOXaJ0+ov?=
 =?us-ascii?Q?VAi5PqAgWnol1GsMVW+2QHazQ8EjuXQQNeGMh6pv8AUkS0asvLCmftYoPiCA?=
 =?us-ascii?Q?cMsTFVAtLZNggOakRaMW6EkImX/JEuNJ13V/jc2S81WKGPk4MaNKUEY8U8nR?=
 =?us-ascii?Q?MMygZDv6EiHQFnVmZ2/sV2nT7wtYe99M7SnONtvrIjKIjxptkOHb5xWmKuQQ?=
 =?us-ascii?Q?WTbkG6D0CvBA7B83F4Am6uvsv0xsXZp/y3yE8QkJK5xdC1ZERY47i9rY61VQ?=
 =?us-ascii?Q?ODNTkWh/7fzZYUcSxMiMcM3u0wOG4Mni8IfeQhq48Dm4AvfKplMUEA8hjES4?=
 =?us-ascii?Q?YqINX5fMUusmZnAvpHeommKxHHwV5r4htpcvBL1CYVF7b73JETWsntGVp8mz?=
 =?us-ascii?Q?ylFQ5/zjiaxrWUfu//5ByZ9WhW2f2pHUJKnd6kHfIyYLY5vse9M/JL5QiVzD?=
 =?us-ascii?Q?0PxL2dyoDXCA7bRtbimu6Om2cnJnj03e/duSY78RekxNqnGr4K6ekvNURVVo?=
 =?us-ascii?Q?MLY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uMzg8Bs9fAUvmWxZy+/+yTvvLbGvyIcRwb+SNJhRGVpDRfCWc4RH1JpmlMXv?=
 =?us-ascii?Q?jfZ3K0L4ytKJ5Esi6YfvY5CwNly9OzEWo/k0X/zIBP7DklEHEFYC9cFXP9LX?=
 =?us-ascii?Q?gy162QXvREyb/EM/ZMhmnbljLt9aShIYocuhevenYknTjiE2bp7sEaKKGU4X?=
 =?us-ascii?Q?2QP6AFgP/Gs1vN1eivWdztuOSZoG+QMOwgu+pdNJb+zTPj+8v0CRRxWVaBId?=
 =?us-ascii?Q?O3RRoNyzaYiTERBgUQs5FiUyrFeakynwHSVbnbv2q5Y0x0iIhLnmr13MqxFt?=
 =?us-ascii?Q?JrljQwfCvlXDYmKQO2BDAlMiCoFatZaKAgpv6yNG/tIuOYR2VOBbheIffu4z?=
 =?us-ascii?Q?wwU5dhahV5RAZhA6yVwN6Iy3cGMcGj7o36mbbIapEPYXX7SVfiDJ/KKUZiQK?=
 =?us-ascii?Q?IBrxjH6IGa3LtsX4RbLomZ1zrq/p4CHi/GSvoChQsLoDZLNVqvLCHJdbXStS?=
 =?us-ascii?Q?gmNzjGqafGpaxlvWTlu3Q/lioBYMBIiyFGQs50hDCv4EIeh5tuORJ5aL+Zyr?=
 =?us-ascii?Q?kz+8/4PnSl2NR21YFMqdX9GtW17+SvnzJoQfNJJqQ2X96RnsuZ+vSkVXTAMH?=
 =?us-ascii?Q?F26dEGrJ4b/ZTB8X7MpehahU1QXKsOM8kAq/Dh5Xfo2v8n1m9r4NkzO6rBG1?=
 =?us-ascii?Q?awT0tQ/cCDBqdmhPpLblH57R2eIDRT4mn2axQUWog+a+TMzcOR69YXWUGCSl?=
 =?us-ascii?Q?fD8guzMaWrza3Tb0ROkYq+PoRPr7dwjzRWdDDs7lOvssefCoKoBRGSRyhKHg?=
 =?us-ascii?Q?46TCT2cRxBj1y1Ep0l56r02iNjwj0SVjAcoqiVJcCKsuexU5k58GPUZGGPEf?=
 =?us-ascii?Q?xuGR8VctTBlsF4D7+BWxGgKZpzdm9mfpcq5im+LxpCe+a9U9Qys8YkrY0Mvg?=
 =?us-ascii?Q?wjkS2KGjmi4crE78RIxPE9LUxOkdlmkQnYp3uT6FywA5TUBjFkyXAR77FXK+?=
 =?us-ascii?Q?kafuUsVreifISr0a9WvhlGQmj9VOEyzTfmUVDiKgm35gB1NKjYxokXOlCyz+?=
 =?us-ascii?Q?NpM4V9zv24PkLUrTXLdYqsrim07CRRTV0IM61WE6Go/j/fo3Ele6wedCpBLJ?=
 =?us-ascii?Q?pHqYXCK9/19Dw/F7omSYpDM3m3w0znN4WiMgN2NmL1vO3DBhupbUDoHdPH8k?=
 =?us-ascii?Q?9L2eandq/gLENFW9wkw8WGOzoFH7vF2KVynMstvLDvVphCwDJzpokoSW18kr?=
 =?us-ascii?Q?UlS58ozOouwddBtn2zHDsyYrXaDFxXgC0AOpMG/dbZ+Z+Osacfav6oJx0Ija?=
 =?us-ascii?Q?NxomgX7/Uf5zHtIxHNO2FfViFE0UDAzXITsvCRWP9G3leVsMfSZLLpPSVRDB?=
 =?us-ascii?Q?CGFj7G09Q/pkdhH6wJgHWl29TU547HLHSGhsKWNKGgoqP+n7A/JimI1tbW9c?=
 =?us-ascii?Q?BIoUQfQMz/gauoj9E/oVcOM16E1B/z79mvCOU9dxQYcMNPRC6HbhYRBq+svX?=
 =?us-ascii?Q?KdIvEEYaR199jCKZUOc0Y0e5vaLGGX37LkXCVav9cD+b7DQy8GZvGlV89ZRl?=
 =?us-ascii?Q?Y2ReXlPfB67ohq3AQFumu4GK3xOrs1o9R4VoyKPBl9xG6xVggptbUvuimwiV?=
 =?us-ascii?Q?VysRir8IhS0IvDxnvTk67YDgkXQngFkYNy32jcq6vyCwR3NzTJhB14MLTXy/?=
 =?us-ascii?Q?QXp8HYzU15TyF5sJli3hc4Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eE4rMOqgQkci4XJDxvus5lubg/5lL5Iyc/Kspzdk7g5mmgNOyPqebYfgFgEb1XWz/N7+Xxg47UjVDDAY3rJY9daL+IXzj8OM4JObtuIv62ZSz339rwXNVusAwcQKkVxYUcxIefM7sWxnxMhT8O1fA1Pqzc9yANxqkYwhDlpSI/snZ6wGVMgOuPRPKHs+Kds1Ul1QtHIr0gogPegQ8u7QTp66Flsv/P8pM4vMhLedZEHxeQuOGkRRBt/+D6djhHTyCayh5Zm+CazbFJGktH5c0cf5CZ9zQyEEGOGY2DjTWQh6Wj45NVHDlq6WXOTNVh3djq1EtTRyrk9odxG6w7oh9VDM7OCfv18LpSAzE1UFvqNFlKcS/dNlUQvKO1ndzsMr6UVUxflM05n+ihhXhVtEqVKl4Lc92tq/QdFNIF16xVlfSqf1CSj7Yj5vRaz0pJupm5fjWI3wWh5sGNP5jcEvvy6YJEUz3lbVuIy++JEl5ClBWv6UzvCrqxMy7O7Xibll+9mhfkx+I1cY2hgzDFSYvK61kbVRBnl7uwqrwPh67KQEzB+uFzpWWecZPXb10PgFSDZJY9oKxneoo6q6VxEjc3uffKm6PzTU41LU8g0ANRo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae91e1bb-95f5-4401-8aa3-08dc87232cf4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:53.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scQQd5c31gn9YE7Yu7RzM4yoHhmzDE/SYRbpvvPrdgydzWa+o3qEICotaKu0bkpskVO6ZF3Ltlqg3AcvvOedpiQ56cXPYZFEK2snG9aF3aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070138
X-Proofpoint-GUID: lsOVYUOxyU8eo4HtaI5MiKA8cv9g5mab
X-Proofpoint-ORIG-GUID: lsOVYUOxyU8eo4HtaI5MiKA8cv9g5mab

Users of mas_store_prealloc() enter this function with nodes already
preallocated. This means the store type must be already set. We can then
remove the call to mas_wr_store_type() and initialize the write state to
continue the partial walk that was done when determining the store type.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3d334e7c19a5..5854f25a4ae5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4027,9 +4027,6 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
 	else
 		wr_mas->end_piv = wr_mas->mas->max;
-
-	if (!wr_mas->entry)
-		mas_wr_extend_null(wr_mas);
 }
 
 static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
@@ -5598,12 +5595,23 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	mas_wr_prealloc_setup(&wr_mas);
-	mas_wr_store_type(&wr_mas);
+	if (mas->store_type == wr_store_root) {
+		mas_wr_prealloc_setup(&wr_mas);
+		goto store;
+	}
+
+	mas_wr_walk_descend(&wr_mas);
+	if (mas->store_type != wr_spanning_store) {
+		/* set wr_mas->content to current slot */
+		wr_mas.content = mas_slot_locked(mas, wr_mas.slots, mas->offset);
+		mas_wr_end_piv(&wr_mas);
+	}
+store:
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
+
 }
 EXPORT_SYMBOL_GPL(mas_store_prealloc);
 
-- 
2.45.2


