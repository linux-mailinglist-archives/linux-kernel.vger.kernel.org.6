Return-Path: <linux-kernel+bounces-241654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87066927DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5FB288C00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DD137C2A;
	Thu,  4 Jul 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N/VtoaYQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YGvzjY+i"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD854660
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120352; cv=fail; b=MLDbWGDnykKHAZ29uXk6MJSlSfyzZEz1Z9Q7U49BLrsQPbWZDHCjdqo4trvoPMemz54q0pRd9k8/zYaGndK9MEamOSGRyD8Mzqj7UsHyB167ynzMHEu8DiUVrmCoCLnVpJcRS3BeBgfZrwdTQsD5IjgHacXRN74JOyPJl+ZAkUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120352; c=relaxed/simple;
	bh=zgWIXyxRK0U7CMIKtGRdvF7rAXC0ub2aio/B27Rw0t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpKMZxdxBrfqfOCLQ9osuSg4m7BtEnt9rI1lknJBdu7DqArpAfyxxZzd6IGWmKUhU1UI8cQNR5bQa6f4QaJfPUgjkPUmpzwS4s5zcxNtT/zPVT7T+NHE+Dmt+kSRYb+sp1MnPWPYq7jS+UT6ghcEa0KKgNfACUM+EvL1JYMge1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N/VtoaYQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YGvzjY+i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DgwIT031162;
	Thu, 4 Jul 2024 18:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=f12gUZaqT5CBj0qbmSntgTFf0542jsJzkP1hUweMEys=; b=
	N/VtoaYQugn8AsLp/G8mvrIzhSqBZHbaNrUnowmtS7UeKJ3SN4D6NmsRHKuCaxNg
	iJwLFz7rr0F2JEDYo/impwzD0z7DZ5n1LqxjcH1tBMHFpFOQvR8r5fhEWuDHZ2hQ
	7pNh7SgRjmcb23m41AZD4iNMOzSJ4idOZyhMzHKI4xjqzoDGcW8q4FIGmttEXmUj
	uknoRsMy7L8RrzSVGEQWBup+I20UbT7yBaCpKNoj5FsL7u7oNyWDiDATG9P5Ifex
	df7x354cSug61UJpOHaZOg9N+kTS2cfX2NvlsQ1B8Q5lfUB2hmwTbbJ3hzNWNRSS
	DWPX7vru56wFeMY04JMlQg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vstk3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464FbZBF010972;
	Thu, 4 Jul 2024 18:27:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qany39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRr4opVEg9aAtqnabHIPjDyznOpgj27FWENWeo11hJq7npXm68CfFsvvH5kCMvKJtqUzWmGbfl2Tr4kDDvaMxTIwmXjgdb8mc+hUxcoJLzcIaz22+52heSLXv8VBgRQtHzah9JW2geVK4GCOJDwtrwvfuErJPY6iAcK2SmL9jR6NlYQ4qhskp7kgN33SJPi8paaHzWf9uzJAZXmw12Sj7cAc0AjMmxbYrsGoePmV9bls1v11XFQTJj6EuTigvfXEuPHWvCPXP1jyVD8U88hJD1aK16N4O5St8nxpUNkhOIWLIe6MQmSO3Zq6zoBVmi2ZJk01itaY8EUHmVsU31nVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f12gUZaqT5CBj0qbmSntgTFf0542jsJzkP1hUweMEys=;
 b=VJ3u8lnP6s+PtlDlszUHVy++QP3DY+HjyPJD8lmA46Mt3h66/ryOugSqWlMr2Dbv5x/x6iU5acf+dtEU+R7DaIWimMzmxRWoOhZ8tz0QB9s+vCoPPOzARf/jtJi+n0KFWeIGg00szvcJASOlLAItw9XL1IcDjHMDZMxLOLq4Knx9Y6B/qy+ENWuJ9YP2nxWZ8eqZwItktIa3OlBlIQxLmdMIicqq+Vw1m8xAI17Yd7ig7aL0ty52OoeQkpszPH9TNhH4Gae7kqrweI1ofMmKjXDVI4y1zZK46PyY/7AnKqkWgm0fe3VcOVEpFQ5DamDf+xRy+MWCZxIlmB8cF2BZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f12gUZaqT5CBj0qbmSntgTFf0542jsJzkP1hUweMEys=;
 b=YGvzjY+i1fKymX+A4XHtxKXVTO9pzJvo0GHh6ct67zGWDjHch5EJjzGNeT+AdZ+c2n79qiofvCNDLHue7PlETmUdZ131JN2p6y8xJCBUFrPmaNVwwCp9nmknZL8iADjrok8j8XAI+fg5ba6BkxiIPk83fPh5jAKKwNcL/xlgl4g=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:41 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:41 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 09/16] mm/mmap: Expand mmap_region() munmap call
Date: Thu,  4 Jul 2024 14:27:11 -0400
Message-ID: <20240704182718.2653918-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: fd24335e-0390-46c0-9691-08dc9c56fdb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iPKv38RdG5/R4XUPKOlduc3sR5sU7bGq9WEPqNZBh3KkIFwRSkOn6C2zxx91?=
 =?us-ascii?Q?9/ZL9FT2dMDKIenMaLqZ1af4fKAKDH9X5DDRaujOZaH9+o/PTmFkVDIWfbvP?=
 =?us-ascii?Q?iirBkhL+0/mRgY+Ie+bp25HgjKjqnXEg2cEh2WYUamEMOqJTko9ymB6dpuBM?=
 =?us-ascii?Q?yc+jQof9WKEHtvDdzhmhIKnRtPQ7m/gLu0hCdv5lC2OqnoNZ4Gh1PJPaEAc1?=
 =?us-ascii?Q?qRgJcpusEF9AIm+X4Mph2OA8eopgawFbT2CBBNwQybjD/Uj4fUMAoWgSliNj?=
 =?us-ascii?Q?iHmAySaCierKtVftSM7o5EQp01UGYImpmTjo+v1LDxjPefIYtZ1D+Uv5AAzj?=
 =?us-ascii?Q?KADWC2pIyaWNT5iTWGeXWuRyQqV4rAb0lnBP7+m9IUeggSsz7IbAAX80fNP2?=
 =?us-ascii?Q?E3d66J9Y/3fWWm1FvoNI/4ZMgKXC30cLc5UrQKNWvxYXxKC8lVF2vZdO3+O0?=
 =?us-ascii?Q?7DS1rpsowbpe+U4BgNNE0UL30mh0e9DLpou/zJZ860xDmfz2wLYk/cFCnuNF?=
 =?us-ascii?Q?SOvBLBTYCnjKRniLuDxPl1yeJ8ya7g8fNDKn5j7sbVrpyKeT8QysZX2zGYUi?=
 =?us-ascii?Q?ZQjj1fuxMrNghbip1FoCHJu3BG9jwrVjrTNvgTVyLrUHX/7isGpzqb+fNEsC?=
 =?us-ascii?Q?Ey+S2ZYLeo2qGacrfPEtmcyUfA12F1eSWTo+zVlkkD7Ncy/lVL8+ugcoI2N6?=
 =?us-ascii?Q?cIpMvuokhGfwoKCSQoDZIZ1Mc80R9o8vgJLLcEGDma0d4SY9drXzL7n0gBfG?=
 =?us-ascii?Q?mNtXpIBZXbNr+njjx8i0f3qUciaxzjHk37FuGhSzGAhXGywQAvS06Mkcb9Fc?=
 =?us-ascii?Q?ze5dYEvBdCa6CILfgF4IxBqbWFy023y76mhU3P1SJi7c2KRsObN38hodNg3w?=
 =?us-ascii?Q?GCTTFhzdF5jlWy3wKQHd2E7qLngpjN9v14bw5D5FHNdt4+osH5kCNXr3UBbH?=
 =?us-ascii?Q?1FYqh0zyA6+fhNlyDXSrbPnLS+Lw7L/FYOxpBjBu+Nw3YXGyrpYKbtjArm+f?=
 =?us-ascii?Q?jdIypACL/eEQVTlxTKe2aBHOioG0d+wbT5N6Kpalex32kkVrdJ4eKsTysTPd?=
 =?us-ascii?Q?Lin90PuwLNNG2o+bENv8YxI+AGl0BAUSQN3DulSDRAvCyOt/b0I/mHf0N5eC?=
 =?us-ascii?Q?NgPmjI2GVZu8AjyRptf64xiTytDTeyclq8FgisuQ9DQiTm2KfIv44+cjhwJ2?=
 =?us-ascii?Q?YXkyVmrbUTh3xeomCbaGDRX2z/c7s5UlqICGqqFhzLTwc8nS51Vu26ejDq3j?=
 =?us-ascii?Q?zem1xtd5HvI0bzkZr1AnVx0tDGWy31ReL5qlr2fZKG3UEWKHOiHH++73LbH/?=
 =?us-ascii?Q?bFGCBRXEdgrPrpZTHlfHCesHrOYhmQY3XBiHAh6SIWA4Ug=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Yaqjqf7J6MSDJKDNQdJ8xPyyRz4LxvyToJ0M7FhHlIcQnLIf5wuPWtSD3G2P?=
 =?us-ascii?Q?pM+cj+AHf1d6JdFakrH1B/uGWFUxkthuWYX1zZ1tpucwY5N9iSvZMuvLs8D/?=
 =?us-ascii?Q?JakfnDojbj13ME88T8wIjC3s3xZHjSoxqGIkytNBEG1chUUQ8+kgXPqmXWhs?=
 =?us-ascii?Q?d36I0WWshcTtk3gJYwI+SYSu2ImlwDhrJHTQ7EwVQ239fAiUHGaodopq0/z5?=
 =?us-ascii?Q?cgy5k0fjrqF776/MGBjZW5R2q3WR3oYVUhKWRra+v7thQaBS6OU42Cde0GOw?=
 =?us-ascii?Q?9V/kCSYSQO3jTP3YJxLyylaU2Mm5EYZyOU8KqoWLLQVENDK6gs97+6dxOVNF?=
 =?us-ascii?Q?infUA2OZ1+3NWQW/EZFSQPADLsqya5E41BtCpeideyT1x5JYZr7z2bANA47X?=
 =?us-ascii?Q?DVC8KAi0urjDaD9cA7gFfw5EKbt+N78bvf1phP0Vu3dORopmTthJnuhI6264?=
 =?us-ascii?Q?W8/2JwgnSSjLX3Lb7D6XlBsgqOkr0LCYIpLo9CMASivfaeImkfEX64RYQfSF?=
 =?us-ascii?Q?b0er1Xq6V7Kl+nJnaA4X8dlqUHv9tL7QsDyuoy3gkXA2amYGTPjAxwj9VxXh?=
 =?us-ascii?Q?PqHSh/8FbsX+ggNHKHpgJQewua3LafrTQXCM9RM1ow2+qC7jOOv5rcQSYHUU?=
 =?us-ascii?Q?7Bf8Wnxw1z1DbFDEOMHH2cRaI4qVIUhBdk5VuvCLY1x2EqIjmyL4ZxXbX+xr?=
 =?us-ascii?Q?5Hx/kNnwG/UqVceQB4eK80y7DQFtI5XNfar5erO3/y6AkAAM36P8iDWWVbN3?=
 =?us-ascii?Q?KmEx0X8Z+cXHPzHwFfv1X2N+EConxyZi4ne0FFNRdvXX5Un+vDcqGegMw2dn?=
 =?us-ascii?Q?tCxiGfkQkMvETcFTPRa2qO+cV4U7v4s7vZOabrpuqcOC0AyOcHTZTbwbUeQg?=
 =?us-ascii?Q?3NTAo6/BuQfXVGzlA2MogwGsWZPSyRglbXSrUUjRV9vc3ItzUsWPkrbu72Ys?=
 =?us-ascii?Q?9eMFLWtZ9an9Y10wP3pk9ndpO+c1eqTIKMWh+reLQ4DCn7PjllV2cYO43lxA?=
 =?us-ascii?Q?XEpJc4AqlKYSbaMhIQL0/wC4oC/DZ80R1A/cFZcXDaKXNFnVN/B0beBMs8gB?=
 =?us-ascii?Q?FdoxCdbjVr39c7XFDDTWy99VgbqjEfoHhASjYxeIamaiL3DKiPFuCt7gbw13?=
 =?us-ascii?Q?aHiDQPRxno5cJHzFHZAh0oeCHmYXlIpwxwUIV1uB+M3MynA0CZzINccla8Jb?=
 =?us-ascii?Q?1guMHWHXUEDr3LYmcVX25Q0zcAdVy2XwCQcHKo0dSZ7TmYKg5XSqf54YDXVi?=
 =?us-ascii?Q?bUaBkWyOULMz05z/qj6o14J1alnwfoCbkXEVjXzKb8jNH3RUZO5Ck17yoklp?=
 =?us-ascii?Q?YKYKkzXjWjFcjc8yTgQklgREIcTaM+SMIDu0z5L62ywZE/A9xW9FpkXz8Maw?=
 =?us-ascii?Q?rNlhpeOt0r6K6iLm80vy67zIkI4Xm50NsJjVkWE1Owr3yg/wYhM7/hbscqHe?=
 =?us-ascii?Q?0EUzSiBlPNfELG3jyOmuRIf2i9m4+nWd1BmoXYu8Ux+22cRXeUrMFOf128zY?=
 =?us-ascii?Q?B8Bw5YBMDkpMcyWajtrZoBl2hcWyOL+hB0ZIFRnrzjbEAJ10qDbkhZzOIZWM?=
 =?us-ascii?Q?N6aUdVdJc1n4QfZIFiNG6yGd3PuzmZ2h6dPYHa1r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HTOGVy8GXqBmD+khfDnNToEDRgggxd4HGpzXs0Zk5PONO+5DTNcPVWq5988M9L8dC+CN3Hn5sUdWV0mxN9sLPnD7vH8Ss1F8fQi9upGF74BFuLYH2g5nl966mCnoIiFgzp7OgVCw8/zJeuNoWTtFgPunUJv+Bc7E8WmPAZh9V+8MydPXc5IGA22fYLRl9bfbeBdYfSpE81wvxihkKnt4Kx2dlDPXeW2m15fH+r/tXv3EbnG/J0YYvP/JKhmmUnRShF+FJHelBYMP0hugL6P9Fj4x2kM8ZX6t5ZhVcOOFvE6angjlaGyiLGofq3OXhtYm/xY2IiVIru8jot8zOgMfzij/2vN3ujvMtVFPUbnNmptTUs9SPvAeWaLujBU5kY6p9tfC+7O1FXqINXseg6zc6lc8nluAKFuyI3fVxdGGbEVd39F4tKb5anndqZFpLhhaYL2Ikw9y2N36rb32YPf07s33ffFrdJcQzSn/NSTXbAFpO4PRCBdySyHVwBeccIhtdK6FdjJED6djOX+ENLx4/mTOzq6UZ70wdr9HTkIpK7AQWZ+J4rVoU0KdTfA48RiQOxyVZ/0Yjrg5+p+mo75ORbgF/38+D3nJ4MEJkf5roBE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd24335e-0390-46c0-9691-08dc9c56fdb1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:41.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m68oZl71O2BVaWlgTDQ7qq9eDOHwfo2rp/WOL25TJMhVg9F2cQg534MwP84fFzvkrE6BEccAAF7lGdKsdEYMQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: w_eBSliCizl4jkFpTOEI1fv9GAkYfc__
X-Proofpoint-ORIG-GUID: w_eBSliCizl4jkFpTOEI1fv9GAkYfc__

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Open code the do_vmi_align_munmap() call so that it can be broken up
later in the series.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e9858ca8bbd4..f5b33de4e717 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2915,6 +2915,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
@@ -2947,9 +2950,24 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	if (vma) {
-		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+		if (vms_gather_munmap_vmas(&vms, &mas_detach))
+			return -ENOMEM;
+
+		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
 			return -ENOMEM;
+
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+		next = vms.next;
+		prev = vms.prev;
+		vma_prev(&vmi);
 		vma = NULL;
+	} else {
+		next = vma_next(&vmi);
+		prev = vma_prev(&vmi);
 	}
 
 	/*
@@ -2962,8 +2980,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
-- 
2.43.0


