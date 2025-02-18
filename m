Return-Path: <linux-kernel+bounces-519764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5509A3A19A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEF41686F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8326D5DC;
	Tue, 18 Feb 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B70miVz5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Eo1YYE6U"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CC23497D;
	Tue, 18 Feb 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893416; cv=fail; b=Yh9ZKIJDEniBYCEYtHIpBNZ7Adr0KDU688r5lDacVfkmzcS3PX21WLxOiApAY8pQYxnZajzBtxDPnll3ZUJYosZJuAWayaWMd0+ckmGu6c0xjQPDP1/7j/k9NdwmSAlwr1nFhX39//NASK65bMR0NJFaEBqq9psrQsG0Siu+7vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893416; c=relaxed/simple;
	bh=x6vlUzWp9GLiVgpaqZXFZqXJDDT3SRHy4kVSMchrWds=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oM0MeIW1XkByFUT8fx/Jjz6XcGLUlWFHKfS6b58yIVM2duIGAAAGIj1KP/N+LdTdqyXO6I72dxS0m5BvR/9akeIKgaTf/R8py3+Tz08Z0idL5urShOUttwMC4Pov8i807eoe10TsvcXknG+ePubFM2asm/exUtlDSCNdsJlKs58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B70miVz5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Eo1YYE6U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEHnEm009446;
	Tue, 18 Feb 2025 15:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=gXCRYt5/u+KMTAdE
	hUTm8jyROcGUxa8Z8PAv0SVegAk=; b=B70miVz5qLJ9RfrzRxnC7IxaET8KNgNp
	GlQyL7870yzrR/Z+x/ybY1fdZxNPGpkHHJnBKTpMALiuSKHy9PajcgJ2RMBUWydy
	t0BCHlt2TBQMPsDx6Mc6pdhth7zitA2muNS6V3MBdWDhNrTuSWsK0mzFzkxBuWzB
	N9DZlAoxaOrqNjL/UrRCUlDBsCrdNOACDiBuTeUecfyiDyox2GPWrDkUEEJ5+eTy
	PxcKOTHDOP4e7q7LyG/pMxgG1CvKMbZLaFQtnCfCyQUa6RM7pijHh75P2AwMuqTd
	6LTkcQ367wUnnc/9j0WFyA455zorOZT2V26Z2++GUgfvAUaDg3PwNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thbceswk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 15:43:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IF9tDD028542;
	Tue, 18 Feb 2025 15:43:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thc90420-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 15:43:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZEnFL5mH6AuLzI/Y0OEd4G+ZNti0qE3vyEVeZGOs0UGVt59Knee/8Pdlhcj2WmWk8866efO9gW6fOKAAfv3w9vavnYsiUWs5jW1zx7OTBL4MQT/f2C4xuvId7dazV5QWJDGDFmMTE9J8WJqK0ZG9t3H6oiMTXHX04fUPIBKR4zY45ZBUWuJmVSQl+FipulaMomqYPXD+8+mbD/80Y/cdxsZrYCI02JabWXm1abuMR7feB57HtdM9RqPO3zTpM6S76vgT1cQ7Od8DHGXe3krHefLXFWcVtLG/DecdjxS3kbAroc0vEgihY+9VBtrgG6Z1tF7U923fkmqBu/iGw/XCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXCRYt5/u+KMTAdEhUTm8jyROcGUxa8Z8PAv0SVegAk=;
 b=PBv7KOTqwMB+yum6nxjkWwTkbTH/g4QnorBDsUflMYNiDewSl0/o19/a8PQVVY3nD0mKJOh7S3NHce2MMAzqpFc9HQJU2HCPO3tftvqXn3M4ajFLMe5ZGMQYfosMRvZ8Bk1L3x4spYFXBGFv7RRJfw/mxv6hJIXtjNvBsJntmiFSZAIWjXw0d3cU1AR8aLegJgo5+0XZQu6Oaw+2Su6UZLyNzUrp/acQUL2VOjE3QI7P6m14sUXQEWsAQ2NtEVy/HF8GMXonrxg1Icr/XB/t0/zb0UGysZMy0wr8P7Pe8wHFrcIVV8I/k7nNWOj98ZZavRjbfOG1pk3julejW0L2Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXCRYt5/u+KMTAdEhUTm8jyROcGUxa8Z8PAv0SVegAk=;
 b=Eo1YYE6UiUKD2KNW2KpV+6yaRrXbR2O2KDstga68I+R8gfgft9PlytvAfQVjuBCrGI99Cb4sttirQ6PRfqFWVlnQDFH1SUYRk0NrmSzWLgpuOTLa9vYYWhG88K8Z6Kor+FTPJSeGNsFhKuYtk+PwRxVlsZJk06ciD8ctHgLKgbs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB7997.namprd10.prod.outlook.com (2603:10b6:208:500::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 15:43:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 15:43:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Carlos Bilbao <carlos.bilbao@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-docs: Add book to process/kernel-docs.rst
Date: Tue, 18 Feb 2025 15:43:03 +0000
Message-ID: <20250218154303.45595-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0662.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3483f2-5823-4e3a-e7b7-08dd5032fc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pWFInMdozFoGOWHDsRIzq5xCP9biVslxcCegOaWkuCdE2AT8pmhVXJqnTqXH?=
 =?us-ascii?Q?60uqTYsLo2Dn5nSnLYajmq7jNfvIpGiHc+TF5Z5DkaDAdTciv9WamT8Ywo57?=
 =?us-ascii?Q?VICVkDDoSq0SqMH7i8I5yjQ5Joz+8n46fEKpRJVO6JCwbMi8i6W/ehjEamHW?=
 =?us-ascii?Q?0Hqu7KFsczNVXIbrHWd7DnzF+sQIgswmmC56vwbeTNXbNJxtmbvmoRYx8i5p?=
 =?us-ascii?Q?MCl5HvoGCVm5Im+5VKlGp8od9/rs/nCJN3lY5hdQY5fCBeTx4+AxuBdEAeQd?=
 =?us-ascii?Q?Ony/6NfoWptNXzK7t9Uo+1CICgApchQ1+acnz+u+8wwSC060kxdLtSb+pmO4?=
 =?us-ascii?Q?bXQA/8DGOwHh6AZXAnlPKtKus/rjHLxYNzkI/u4Jd/XbUvX32J5uE3rliP3k?=
 =?us-ascii?Q?ImQCbQnmRuuZWY+5xsR0uoOHaZn1N2WF0/RzgbfJC9hb0ulv4wFsXamO9Vz5?=
 =?us-ascii?Q?b5J7ZkRlVt5a1dHTc2ju5wRpVDTryCOs1A35Qdlx21dN1y05kK1gz/oFE+hS?=
 =?us-ascii?Q?fNdONw/vQSlNuQ9Y+j5DoAft8Sz88haB79YdFcvA2U5whpipVqh6VWY2e+kF?=
 =?us-ascii?Q?KBiMq1sZ6bYVjBO7E72tmfUbKKBmAhKKR+RdOsfc7Vg/KkFDu2r50voD3c1I?=
 =?us-ascii?Q?Q0styJ6/kSkJ0xvM1gYS1Lth+5U+pGScg8OiddoTDPvkaqri0jdsdL5yHjSd?=
 =?us-ascii?Q?d2SR9Dy+yy1y63U/AuCe5hD1gKWgzTEZOr+xccS02iAIW1bM2a7KduLPwpgb?=
 =?us-ascii?Q?4Ia3PZiYgXsKWK+lUZx8DjCFc+ZBLR/sjBRAe/1pu97kdIlRK6CsBm3Lx/7T?=
 =?us-ascii?Q?AEjguYqcaCDIT4CpNRLlezdfvVwisb+PovykBxa3FKGU/y4tPq3RO7e1TAR1?=
 =?us-ascii?Q?pNQLthbhfRqpSq4+DDro3BnNPRBT1TAOZ/ShxHKBWkcoh4LYKU3w8edZ+PHP?=
 =?us-ascii?Q?vY222PaCiLDqno1XVMtpasAVewK6+qoqUJrz3N0XkwMlCK/ql3YQXvBnUj8K?=
 =?us-ascii?Q?N8rScF+PEIKrQNHmR44I/R/c1OK4mVa0jwtWVsanHv6RTAWySPUPpZgv/jmc?=
 =?us-ascii?Q?8spuATRMqZs23m7ldZ0xx/oy8UQ+8FR3VW7FUyo5ttCw7nHHPlSiVBa6pfSi?=
 =?us-ascii?Q?D/JdazlFpdhHa4gxfJxiijCK6qXgHMbVQoMfNilzvNeO7JRK6xN3nOY1N9gx?=
 =?us-ascii?Q?WQHTdK6uR0M44gzgORsyO9ebohRwE+AKZU45DcIPZpEjsPkRJbT5hgoUaJY9?=
 =?us-ascii?Q?0muKAkLPceWwiM6oj3C3vubBT84DSWxaNVFwQ2ARdzMVeN7OyTsEU8o5CHJp?=
 =?us-ascii?Q?auGF2Kh1tLNfZiXES7xDfqB7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4yUIBKCnodNW14xlbq8QoCQ0yaT3NCkHzCnxsOwvoAYHWI0N3Cl5Txgj0e6D?=
 =?us-ascii?Q?33L4joH5+xjXD1CGOtG4lJIjfHKQQ1zvChGtzY3N1K7K/47zN1HnOV8iskZP?=
 =?us-ascii?Q?QiHpMYLsu7ZU7Pj7pA1jZ00x3ywUbNWkQdnZcdVzjEHqYQnD8GNlG7az9QCW?=
 =?us-ascii?Q?ucGTHVSy2u7ngAMHOxv3WjYZaJO/e7v6yrVpgrP8Hu+1/Wx/lmG6dRJ8FioP?=
 =?us-ascii?Q?an9+vz/RoYWuBRRYnW2DVkBE4A9zzTxqg4n18aCmv/DS3Cjw0l5FQX41AQ6m?=
 =?us-ascii?Q?2jyHOYaSOfj3ldMhecjwzuzovsHMA5n8VpMatXoTJCKk9MtDQkPEgiGCJaVj?=
 =?us-ascii?Q?jN15JzCDZZPnZiesCgdR0mDJ7JtprEm/hXnwJXTNGERGtX0dLpxdDlSqOuuF?=
 =?us-ascii?Q?YzYrYWavyUDXYyvaxmpKhBMi07o0Fpqn390qu2eemjjP2Fgg+VQ+0GB5swwn?=
 =?us-ascii?Q?sHHnG9lj2ZNA6xHiVeAlgrkhMA2s0+nsgGfMriE7QPxd8lHhVwwNNZBwT68a?=
 =?us-ascii?Q?GaULYa4dCytFsHtgDhyDsLE/JDXK9/1Xs2MpO5rwPu9XtmONed7JBfavK3de?=
 =?us-ascii?Q?pSfZK4kISQonAjXnMG4VuKMTYXfthoNccoEx+NULe++oNaffR8+Q2WzJQJu2?=
 =?us-ascii?Q?n7tltKXrK26KKJTap7I5hq8Rf2mUcjoug/a75MzTSnjJrLbl6Ej8VxyQjJ5z?=
 =?us-ascii?Q?9riBZ3jBUcfLwhyDKokvhdnmhv06wZWU1NpfIZwsE21u0ErEN3GPlXIPH+ke?=
 =?us-ascii?Q?KlKWdQyMAcEodiYAuBPIHQnMIBYkcrrzJycnnDy770JLVXa1A210eCPduPIN?=
 =?us-ascii?Q?Ub09+Nx3nPGIFyrxzTIDC3MxM+uyiN7iOQef4s8Sn1lNULC3uUWkFG9UeByw?=
 =?us-ascii?Q?Os03JPn1DMMw3rmNu/UaepmaCucHrdP6axNbO9nLfxlBlMaQAprdmAjJi4E8?=
 =?us-ascii?Q?qk4cubVa3ARgui7e0TJD8xWnU6FGi5/l0+TZImJX/C8JIr4OMND14Eha7dVu?=
 =?us-ascii?Q?AgZ58v9P+hcbnHgz1p/Ql3Nb6wZeyiFfVrA0r5nyIm8JavI2lDef2kwBddNZ?=
 =?us-ascii?Q?nygFPdsqgI+WjUSUAcOnJcdNQrjl9qO5IMSK9nvHYVRvj7oeNeGtpE5rKULs?=
 =?us-ascii?Q?JXO7Um/b2DLeAtTNZI8W2aKELyul2oyW/yCqZwFPB6P7mNhByFoJB+/JY7wI?=
 =?us-ascii?Q?B+FmLRgbqOKZM3IdsSSh5zkkbE9wv2FNJebbr8xHaDRL2r5+7WnHfKWBkvPD?=
 =?us-ascii?Q?mhGnIpHwJ3PmeXNYyUJf+R0xGeNWd125wEZt72h28axyTyWy34AjrtKk22MP?=
 =?us-ascii?Q?KWKyRJBxNCNkx5XMOhsTwDIxY2jIdcmhRHmk/QzP+Qb+CLSCS4BZ1WwU1SQ9?=
 =?us-ascii?Q?+XufD/yk2zX565+nD7t75Cmgr+FyH64HY1rsoIMa0aFeguH+nes+2fAR25ei?=
 =?us-ascii?Q?pekJCG2L04ZDPPAFf3pu0sYTYIkHEzCgOZjG6HiF6tkWbOg/5wJK9GHyhS+u?=
 =?us-ascii?Q?NLDdxFcrAHroG535ZaxkabnhUlU2DHdatk+Pmk0887O2fUB+Nh/ZYGHIpvtk?=
 =?us-ascii?Q?rfXWoNyRKX6cqqQCtEuEKCYyXgUxygfOwU3h1/KkxWNM6KJsOBkE+ufj9V0I?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TzsxB5IDzCNftMwVWYedE7nZ3eDUXmYKD7WN4I2TVtKoPj8jLsoOWJay7rHOBIdlWoVxgMliW/7E5Cxp5A5ncDBo5mqklbA4WITSD4z6FIVWQ0MHizzuNTsgXvCMOLvE8iqf6ZSfjPdIcuMVXEydJ33Mqvjx7lBQffoMJmsieKMGbcP2u4KXROlclzJPOFe+YPspq/OD7Oy4qmKN5Vws5tpyEWY5YHq9theNOv5lC9ouwIp3ooBDTJ6MMhF/IjMqKFEl9Fa6jCJ2pGkCt8GFHenCQuYzQGWJWjziNVTxEUmmHeFpMgZtHB59W0SBIBZyfQRQ+dK+9DDwq+9bwu8a0OIEps9W+LL956slYTGLxocIguj5moKhW6lKYXa6UDIalbIte8vSf7ZVvbN1pjwX2igyt9pmw9phQg0gwV0YDf6gLw4no/BQTsC6Y+6102M6ps3OEOq86756jo92jgHL3m6sFjfUdIk7Uul4XFyK/nISMwL1PXP9I1B5ENPnVMe79LlbpZn8uqEckn9wgDxkSF7tJH4ecJsrS1MuKfs5kWzBiYN/ciE4m2SWx0m5yVbJvIaa4TD34TPq66Q1ZLeLnQmul0B0BpcN84XrFtoVgbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3483f2-5823-4e3a-e7b7-08dd5032fc7a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:43:27.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0B7w+f8esA4ryMZXV23/u01kGb85ornR+vJu7MGrudhMo+xIt3JAuLJ4yozC/inx1Ev/kYaVuLNjA67y5PfJ53cWrdNYYGkeQhB2AOymgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180114
X-Proofpoint-GUID: 0GDX9EIxfDMg6DA7-_j8C2CKllq1YByk
X-Proofpoint-ORIG-GUID: 0GDX9EIxfDMg6DA7-_j8C2CKllq1YByk

Add a reference to my new book, The Linux Memory Manager, an in-depth
exploration of the memory management subsystem, to
process/kernel-docs.rst.

This is not yet published, but the full draft is available on pre-order, so
it seems worthwhile adding it here. The situation is made clear in the
'notes' section.

The 'pre-release' was made available in February 2025, and full release is
scheduled for Fall 2025. The book's ISBN-13 is 978-1718504462.

The document will be updated upon release to reflect this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/process/kernel-docs.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 3b5b5983fea8..c67ac12cf789 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -75,6 +75,17 @@ On-line docs
 Published books
 ---------------
 
+    * Title: **The Linux Memory Manager**
+
+      :Author: Lorenzo Stoakes
+      :Publisher: No Starch Press
+      :Date: February 2025
+      :Pages: 1300
+      :ISBN: 978-1718504462
+      :Notes: Memory management. Full draft available as early access for
+              pre-order, full release scheduled for Fall 2025. See
+              https://nostarch.com/linux-memory-manager for further info.
+
     * Title: **Practical Linux System Administration: A Guide to Installation, Configuration, and Management, 1st Edition**
 
       :Author: Kenneth Hess
-- 
2.48.1


