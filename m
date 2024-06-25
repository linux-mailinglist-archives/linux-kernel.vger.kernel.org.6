Return-Path: <linux-kernel+bounces-229576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73889917101
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F521C2082A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF417E8FC;
	Tue, 25 Jun 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J9Mg+Yg7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YHI1plFG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E417E457
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342751; cv=fail; b=mKx71V2Wqq6FKuMIaReLbEv9vj6h3HlwMp4d6ST2/rNU1AOQCPCT2wskKSWEH0VLX0r4Y4tLeb2wrytsmfShnMMun9FklQkSLjA4AalNGW8j6Qg4XNSzyaKYydsGDJYB5oj64umxB8qkDP61msaZLjUKBB7hRQXXLtWZV5Twqe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342751; c=relaxed/simple;
	bh=lMkoTE0UomRncgbXd9RBLVAPkkh1qYs+g/CmVo7H8KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sa19vIrzK2mejV5UYNT+gQZVzga9hizAE6CqAXKBv3xJlbtrI4o/0g8qj0kM3MJ+Zolm/Nk5Re2Ne50KIXSJKPg1YbUAebQVlmReVNyJeZO3H0Gqud+xU33eUnG2GoL1F0bM4wqt1xECUxkh/nKbBypMFBSNqew7LRpa1zxaxVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J9Mg+Yg7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YHI1plFG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfUrc003580;
	Tue, 25 Jun 2024 19:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=481Re+ATCvAQvWbPAjt9N9MaRrHnR8VIjSEjBs80iUY=; b=
	J9Mg+Yg7s7Oj68CD+mUS5p0Z8A4sq3INPfOOKmfMGPs7zGokXw9//Yz3aCdQ0PHh
	AK0uONOzp9ktDH7iCzb/rGxhRo3dnmVsZGL+gZrK5A1qJjYvyqTEWPfUHlsLEzLU
	RAuc7QcjdANBqqo25S7WVHeXcPa36gVj4eKKxJrtGV0qIpN8QQXL/dfFMPVyvvGc
	YyxD84HHqg2jNtanHKfPZFhhn+fFn70hRzCwtz5ydzGmYWahbVoox0tuKWhyD6vO
	nJP9hT49hrgyy25zh5xyx4lAS1Y/vTb/1pquzGmh8zXx3aKZOXbgfgJ1CXxNPbKm
	HONenIHTarkgZeDGDPzpEw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7shjvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PI1vRu017872;
	Tue, 25 Jun 2024 19:12:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn27ytyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqphz2H7FQJIlJQgw0C7VXYQmslO2uoBaiEzjwvjl4s+NEhlAfI80+Z0WLTm4qrvQvwpd5WSuwuDYjLxz1fk6q9RJfcL7bVAqDya7k2+9BUvMOguJxshZnkZgQrKKZRWU1NslDyFETNgOYJtx4YqxqqL+blhwezcLVeSM7A9dp23KGmID7tEQtgEBzi4hNWsq6ffeLx6oVs5E2Svqx9wwe8jNuXdP6soIdIi1cNvvFfJRz299gut3SZlYA5th0Th+fjQjLweE0ardVr9N8CLorbswvZ5UhFcwqrM7fCLuDG6izMnOXYUJK6h+Y388euyQpuli5l4PLBZcZfxZ/xdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=481Re+ATCvAQvWbPAjt9N9MaRrHnR8VIjSEjBs80iUY=;
 b=jM8yFNq2XeMZ4tvLJS+pRUJvcRfCalJOPiCKojuL/ErbrsEj9RRSY/WiJQV1Zb94R8GRruGgafsKG80cfej84kN6ZwYRu7c/wqxjE3JZftJIr7CR3gTc1vfcZKs04WA0GT5e8wSjenWzGgAHlmLqlHKQKl353i+62A3J4kl2llFjK6YfIuy9nbaNJV6c5oENz+cLzZCGcmgwuXZqVARuWyz37/VbbNyI9CDQPFGdU3K+maNV0t33Dl3gY1qb5qdlDaKXMAnSA+f1IbVF8yCbjjRImE/9q0W4PdXWSWpPpVyYEPgVHOjs0H6Tdw7tWETWUaom4dV8ClPa4EV0aaFMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=481Re+ATCvAQvWbPAjt9N9MaRrHnR8VIjSEjBs80iUY=;
 b=YHI1plFGEqv9txdfkNk5rd3CcuVz7U6sHArFhfJvr3If2L5s4vaKIxblFYEuRQyGR8LJ3/BQq4ayMbQlL/gjJ0Sbxf+EKGkLsBQ4dyTOoRycQHkkqb0+2ysYcGErPL2qfm7UvlG0Fyp3tLsrxaShgRQS+WfDHoLZ68OlCVeZUUE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 19:12:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:12 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 10/15] mm/mmap: Reposition vma iterator in mmap_region()
Date: Tue, 25 Jun 2024 15:11:40 -0400
Message-ID: <20240625191145.3382793-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc89935-efde-4818-2a13-08dc954ab7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tP1Uc2fXm5ac2F5YcX2DhpC7ERAnm4xCWm/HKzcRr3PoRvY6z4Klaz5fOnQe?=
 =?us-ascii?Q?bz/cWCNthbQJnKj68N8/H5Pk9ENOLAwA8RRcvKN0u8hFMKV4uengDoYCi3Yq?=
 =?us-ascii?Q?SR9lmxHH9UuD5OM9qpgh94nsBSxZGieDz8ZHlUa4cYMB4EppFog6QkMFA5gJ?=
 =?us-ascii?Q?oDPY2vKaRf7EYlRxuWPoelLGRDjp/6lfv+UWd27TYbouNq/rkgZObyVmVB/T?=
 =?us-ascii?Q?yI6NWfs6H19EDouJSIw0hkqZzB8Jk5ei6QSXZEPSXDfzTluf/cFOHKkFJcCy?=
 =?us-ascii?Q?JSIi046PWBOmfBcIT7MFIDnuJ2ESyw0LS50nmKNj50I3jAWRNk99qTxUkUbX?=
 =?us-ascii?Q?3JfWEIGsdG+ZBeMHZdEtHoRsIUN3Y82+lHBGuXCabvO9F2Z5B6ms7ZzUmR9n?=
 =?us-ascii?Q?o5QS17U/41XpAh0H16TvKzC9EN2ky33KBPcGnbtENQnkmyPP/yRjac1GkzQ0?=
 =?us-ascii?Q?2yfja6oRmA42LvkW9l7EXcH7YWPOgGhjalyg3J+yzAIYkalfUYL8ss49YmwT?=
 =?us-ascii?Q?RyvntSQl/5PtgMNjoHWpPXjb/cWPkw3z7KND/S2CPYE0U7mYc8hFXEU7Myks?=
 =?us-ascii?Q?Mo0pjbp0F1FsFwblYhkvLnJn4HobqNrGt1Z3tRpzPR5CQi7AUqVcVPs6LtGp?=
 =?us-ascii?Q?IhkCF5zVsFHZnyWxUaU8uF57RttiAkzB7T5KEqhQKvoEWbcvNz/KO1UYXNlG?=
 =?us-ascii?Q?pPAIwMIlGiiaMDY+REiDfS9ub9RLl8G0URknpPBTaBws+12d4Yy25vrl0j71?=
 =?us-ascii?Q?atiuo7hjq09OIk4sc6eS02fC9C1DEMHLMKRIeQs8df40o8x5OColR2+1N++I?=
 =?us-ascii?Q?/dSnx93nAYOyaL08AQawSRnojlzBVY1ynaI1BbrbbelPwFCezW9EUGrVuqj0?=
 =?us-ascii?Q?fpO+pEkTE6W+yQlkSFw7J9Hhn6frhGH/gRtN45HU0xgamys+gtRw51rtgRgf?=
 =?us-ascii?Q?bogCUaUvymAQxZkT1R/nJbrCRizXol22knB2HM5z+PaWSILh29wlVfW4G70o?=
 =?us-ascii?Q?WF4uPMhPZG4wzr1Sm1ht0DqpcVbzGYfiiXnL+AAncgQyNz5rYUU7lGd5lSyy?=
 =?us-ascii?Q?/+2jXtetzyd2EJc5xoVJ+8Qs148I9on+LUrVuIu+4FNKMmEk9G5BJQcTvHpX?=
 =?us-ascii?Q?4uQvIb+FkSm17HHpl1p68FcWLu8GR9orzLyW+rPB3ByxrrHb5Ooo0Ou4Sb3K?=
 =?us-ascii?Q?sIV6wLtYBzZYVl+sKd5RABQUepF2d+nR2qw4x3W/qbBO2zXWZCz+gnUAofl7?=
 =?us-ascii?Q?oZitBSCIiJGowccEXP5+VWWoyTk5iyBe5zxxeMU437HwR+pdAKoVKkgjaP8N?=
 =?us-ascii?Q?JHH56WNACvtC7Wa4P9TH5sJyD/YJivGF61B5M/pcjke8gA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gjIcPpkcMltLNdybeJo2GJeEcTBODECuK96o2fkJnEG1Fd8Xxxvx3MoHJ11Z?=
 =?us-ascii?Q?sE17XkgBelx/M2+0rEDtYphzIJIj+0Vy4zHw9RjErMfEUOtnkyK1BDHMrX8C?=
 =?us-ascii?Q?ouTmRj4KULvSjyEUQ5+YApT3fM+hbbqd7k/YRYvV588K4eNZkP/qXmNGROLz?=
 =?us-ascii?Q?wTB8nhMQ2rPDfzBiYAg+68FaslBrQJOA4z1+Qcu1DZjAMI0vDIO48RDxApSA?=
 =?us-ascii?Q?SXgKgGStfJeaFgwPa4ZNhWUcaFN78qrAr6Rlo0Rnd0ixzQmA22zaM25gowwA?=
 =?us-ascii?Q?vFOMDJHBuNSC2z1aBQyN0AQLxtZqp7vq+l6DdEPbFVZTpSY4bQ8ejlicjwL4?=
 =?us-ascii?Q?tm+ZWHHQRRndAL1/zOU05woC2mO+PBuhVLnFM/ZW5fLupxT8/pKmigvG2gw5?=
 =?us-ascii?Q?DPXKPkXDO0nFsm3QQ/RLaHfZ86d+B2wStcc/2aqg4djg0auVzsH8iONvqC+k?=
 =?us-ascii?Q?UjALLmuV4ARsf3wg6Eo9oU0NGIOQEPIBXDWZ0bMS/z+G4jXKpwC0Ql2nOynh?=
 =?us-ascii?Q?QYy1IF6nRzQTko9YUZVSdCOXXe5qBf0fI/S1FHfb8PhUvKKjw5Tkzm1uGxe9?=
 =?us-ascii?Q?JdnxBmN2/VkrRCHyZVDPdz42CCWX3eHA/3pjLvduF58ZDzcnwwsdDQzB2qYF?=
 =?us-ascii?Q?9dITWqikOV/D1a9cseJkYNlUx39qS7mVhdqGnjsEsgnc2oZnIl+ZyEKyUFBR?=
 =?us-ascii?Q?+NFJg0DeG6OtZZ7yrTO2VqwRlfClSWM+Y3T3belWigP9aMEgUbhP/Vu4xK8l?=
 =?us-ascii?Q?M4IB/sZ8p290SH3Jq6NQNOvWyZbWILOFSk6V6E63QP64DCT3iPflo40NhDCe?=
 =?us-ascii?Q?BIrUTatpcMiPiSNdQ0PjUG9uOerNC1LwpdIyijW3IbWlugI5b3cjIgmpqoPa?=
 =?us-ascii?Q?T107AdJavQmxAaLfePCuuVjdjEmwc3m3Uic0wZz5m7i3xHBvkRyvX/wXb6sm?=
 =?us-ascii?Q?2js6DCjPyvZaoYRUpuLl/Q7/E4cSIu6jez0nhc3m+dtO7st37ZKnuGERLhn2?=
 =?us-ascii?Q?fgmHxMnQ7gBtxAzC2hXHh1CXlDhCddDscTSCv/I+O4ZX6b8/GY97YgpaXrDj?=
 =?us-ascii?Q?S+n2DYinPzTXceFgHdYopypDHozphZkQQ8rlKeq54jSvBERF9rV6G5E6nxs/?=
 =?us-ascii?Q?scsuw5VBALTTvwVRmUTSXrICpx5S9ZFdaM9XdpvfEQgKPeWzSxXy3Hi+rPnH?=
 =?us-ascii?Q?CuEvkcTtrSslqsMydWPmcWWntaS0WMoKK63BojqAIWu59mxmzWxkuoicA/OF?=
 =?us-ascii?Q?LRndXKwr8j+vqP5Bo2hWIMzPzoN8/UJCrGO1za1BYkElEkApU0QJEfuSPkVB?=
 =?us-ascii?Q?uC6UeUURkqlfbMzXfbxp0X9TWU5UAuNrpKcx8GI3UvE7KnndqCF0Q7b5sE9M?=
 =?us-ascii?Q?pNisM5UtHesluTSuMsbRvc6Pd4BWCBvdrWgk+j4g66yj93iD4mTnJRxlPBsu?=
 =?us-ascii?Q?FqNm39Y/+e2mgOzGYcto4Z8S12FpDAcGz0cbG3+7zv6rC2pxAD36AxuaLkWG?=
 =?us-ascii?Q?jfTkNopDPrSw+3mvtrvIlrOiaaBTUKZhbycc2VMq+24VAc4H8ENgSgFf4T7O?=
 =?us-ascii?Q?KnBsUFXKj8dLD+YHb5pDAqNe51jI7H0bQ6v1M7cGTpshejs3UHVXxQxSLvn1?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2NxfP4S+zq2B5tFh4f2xe6yJktl7DmVCPDR/1BcDHCVHQl6Y9zvwy98nUmkRNp/gNSw4XXj2Uv1Ym8Sw2fMMud0oDCwpw/wZgvdpFD4tlEDNb5cnuwwR/TV+f1EHaWjrDUWOHpofMvhYUykcRMpqOg4dTdrRNJpnFslH+z0e2Un3se7An/OVWPEkQdEsMZ7uDdEdM6mvYGetO+Lh38usT25KgJTWU2BOOTKFMOFaebkZMQ2NRmY5oqtE5boXZdXbJWDL9Vvc5WEOqFZlBwQUw+Om3oQpqj+6v9lgLu3yCYB++ANzV7GHTtOj9cxrQLLPPqLjSH4tYfVMM098wcwBqqyMVyq665WwUcsh8PdwuMH4gTDRAEPj3JK5KIOl4EATawnxl1DAceQP/cvaPL0ee0OgyQq0+feGOh8mId2/4W5YUD2kd9y4mc8+/2krWp7ZNupG8WIjWwyay+bMmVvGu0acv5wEqdVKCYwEo2zbzlIhDX1rdhtKrCDBxDSyA767CkAkIx4eM/wugkf5eclmWyyiafcU52R74YFRs0U2wqVEzoJKr8aEkqgAm5BW6+HfDWdma8R54vQSuTeJMDOz58eKPmp32N26ORBNr/b7+t0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc89935-efde-4818-2a13-08dc954ab7ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:12.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROZ6yEI6FOCXlvDdnHlN+f24SuXarkZQO1gWoq/qdCORv4St89Eziiq69V4OZWBk1bgYvty6q5CGTB/XSm7cyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250141
X-Proofpoint-GUID: t5mv1WdILhOnp8Zm24i4lfQttnBsh7QE
X-Proofpoint-ORIG-GUID: t5mv1WdILhOnp8Zm24i4lfQttnBsh7QE

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of moving (or leaving) the vma iterator pointing at the previous
vma, leave it pointing at the insert location.  Pointing the vma
iterator at the insert location allows for a cleaner walk of the vma
tree for MAP_FIXED and the no expansion cases.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f5b33de4e717..ecf55d32e804 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2963,11 +2963,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
-		vma_prev(&vmi);
 		vma = NULL;
 	} else {
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
+		if (prev)
+			vma_iter_next_range(&vmi);
 	}
 
 	/*
@@ -2980,11 +2981,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	if (vm_flags & VM_SPECIAL) {
-		if (prev)
-			vma_iter_next_range(&vmi);
+	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
-	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -3005,19 +3003,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
-	} else if (prev) {
-		vma_iter_next_range(&vmi);
+		vma_prev(&vmi);
 	}
 
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
+	if (vma) {
+		/* Actually expand, if possible */
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+			khugepaged_enter_vma(vma, vm_flags);
+			goto expanded;
+		}
+
+		/* If the expand fails, then reposition the vma iterator */
+		if (unlikely(vma == prev))
+			vma_iter_set(&vmi, addr);
 	}
 
-	if (vma == prev)
-		vma_iter_set(&vmi, addr);
 cannot_expand:
 
 	/*
-- 
2.43.0


