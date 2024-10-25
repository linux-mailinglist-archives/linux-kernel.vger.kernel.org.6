Return-Path: <linux-kernel+bounces-381660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E868A9B0252
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A747628151F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA038203700;
	Fri, 25 Oct 2024 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GHQ3XFP9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0xZEKdg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C12003BC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859226; cv=fail; b=RYP7f/6du+NUUOW5Htfc0/NLsnBKAuvE5kjdnRFjG2XdC23JLKx0Jq4KPn6hYE9PxvbDDazuNpJJ3QqEX/CN+jWJm6HSyaePHazAg5rYA2Fk/6x2CGA1C/aLUvNVpmMvMsOVSces9pM+ryNN9TyB1WFJFHVKT/FyJy2VabKAUBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859226; c=relaxed/simple;
	bh=krj4eWZFZ+SlZCTq8tNUdWO8xHcLYzw0rIRwVU0sAkI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZLU5fY7SO8+NkpKITx6LO+R+LEfTWcRR9htmWbgDUVizuodKwgMwVNDueEiL/jcpQgTUf+TnMA9lxNWxQ4+EFDVt4SghBlByAkdjURu03ep4/HDSSSukTLRQ01h8qdml7zqkVD5F2YcTs2tSfQo5gNmVpE8TiTHC1x0uzDCO4+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GHQ3XFP9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0xZEKdg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BZgm026805;
	Fri, 25 Oct 2024 12:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=DRM5EAKh74PL+cRJ
	rA7M5a7ZG+h7TDdwXgAtCW2k8QY=; b=GHQ3XFP9JfAu/N7a9bQEbVIOHGhgbrZy
	01M8OIEOyc9wZZvbek2LWNfSXIEj/YzIIeOtkybGF1IBp0+PNfTouQ6PiLkqJ2/g
	KJyNS+kreAzI2ZA3Cwg8J1BupURHYjEjT4EiI9UMau+jLv9lqkA0oYu91Mlv1lkV
	eZZKkCkWQCTVWXS6NzWsj+XNWXvroddE/t6BXtx1+cldfkH98ALKxUvXWayeDFpq
	yNZXdzbdtMkixWLLW3mPWpn7DegUx2Gd2/3akofYW4SE7qkQPvQQESTxHBN89QGG
	QWug+6dKcsTV8s7HiEtiBHFY3EO07Kd96kXQBPV5KIYlcxxt6F2Irw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v4u61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:26:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxpws016548;
	Fri, 25 Oct 2024 12:26:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdt4qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmXNaPSPTDusm0MYULeR6NCmueB64EPqha1evNJEjfVXxu8XgQCuE3ujvelXqAYrTPWwkQbewY+ZuUukIS632P4OpScFgE1OXfXaE6Jp4YZc9kJpVYh6u0K7VWuhLWENvv54IbOEquKTMI2vRmQRDM0nI+goToWa7CN1JaNVaIKnQWgGv4Fn0/WHp7s2py90D4ku/rpNdOcvaAD6RNJYk22qyElDixGa9s3zMtoXNQgRhfyGt+0wrb2wXkFTz1SxG7HWKSu3qO6JzwR4H0qP+gRswFtntNOfizVUUPM/ByNPMsSidJ0PTlSNKC9XoE7Zt2txbINRTwm09+ghvaJlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRM5EAKh74PL+cRJrA7M5a7ZG+h7TDdwXgAtCW2k8QY=;
 b=LQh1NiMi9qc1SQKwcTqMWewflhGM71J9Dd/ItmAIZhrJrMk0yJ2wghUNkWoffLjfg8loNF5NY5perklesifo96rV+4DQn8eiSfmXhW8apH73/7D2r+e4Aj5eKz8vC7V40UE2TU7UQB7bmhMBGLklkm0YfwNfKGNq0Het04CAI6J357tAwaKRZB9TiBPng4kbXYG91j6QI8KdNtEEAan+4za93Xc+LhRRObT1z/tHuP+gSvrDvYrLNITqY/DeLIDzgpvG3dbEXYr0/dHlukZTwWD8TEQ0tDSjKtvgnEDjn6hXBFQE5af6Ga+s8RuJ+6rsORL+RVassF7tpMSvdc49qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRM5EAKh74PL+cRJrA7M5a7ZG+h7TDdwXgAtCW2k8QY=;
 b=j0xZEKdgXWAY/vhg6AhpSV9iCz2ZmFDYk48D9Ani8TwM7VNPQFA5BHUGMW+n0HBC5TwdjGOIAAlyDPJo9tYG74B16HiWjyc9N+PpPpAV0G57UdIjHl5KD0tyW653opQpEY+keSnTbtRWzZxgX9EUyyCnwqgV7znX2+DtsJTIUd8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4484.namprd10.prod.outlook.com (2603:10b6:303:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 12:26:48 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:26:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 0/5] fix error handling in mmap_region() and refactor
Date: Fri, 25 Oct 2024 13:26:22 +0100
Message-ID: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b26e73-8c99-4097-98dd-08dcf4f04bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nAtsyBbSvynBT0+EKRCYee3NMJJTKlVQfyPLZcAT4ZvYMfl39OEVD099AGyP?=
 =?us-ascii?Q?wYzxVdvm0XfWqkxbDk8fLhS/CAjgWF3KC4nllTBRwZIzwCeAbjk4U+o9i3o2?=
 =?us-ascii?Q?oBjrd2lHlpI0MTKU2jKEmyRuigSq6hv3zlAbXahTGBB8xnIjbLZ74ZCFztjj?=
 =?us-ascii?Q?QohdXX43c+OyC5o+1i9npagszc9k4unjcyf33Nrq3HrxHcpaIo8UL2YZqDWR?=
 =?us-ascii?Q?/u0mQ5bhQmi3rLsMratWSprP9/aiRhhKUzbn/dt9meCR+r4TG3GBlWBwNCxo?=
 =?us-ascii?Q?ne+V05kZxLf+avWZdoLEq2g6Srx0tviPYtRAx+SkD9yu7XGDUB9xRFOPfQse?=
 =?us-ascii?Q?+QKmAkj4upmvCHlD9lvvenVGpq+/Et6kQ4hAcJ3qlXMfZvShjPdZf4TzvRrz?=
 =?us-ascii?Q?chOb6EiG0rvw9LvHdV1oSDCIjximyzyj+3ZxRQICOgcJMUWZntNmvztj/a8Y?=
 =?us-ascii?Q?efITJjXy7k8txcspgBNvAQhg0plUXUBSet97FQik9hZPWXZEXv9gyI+6vy3Y?=
 =?us-ascii?Q?1cjczKl6hJEurrXmOu4k4Bu4CpslG9xbrKAQSjccVuydZrRWswIBJY4aLa32?=
 =?us-ascii?Q?Bu06TyXUFX3UmH61vsEVDUqhFa0dvnc0oxTUgjp4TtaVdPP51f4vCs5egHx1?=
 =?us-ascii?Q?GFKhd/WuCjmfYH5YH1++GFWTLu8WaTTkCLM3YGhek7tNWMFZwbeQptkuItr5?=
 =?us-ascii?Q?xamzLP4nA3332jMNbUkINOxM7GrlY2krHzobJbz5RiqpwBqHHN54nOtcMwsP?=
 =?us-ascii?Q?nHl7a4CxpaTsqn2qjGwatDeT/t5DMoqDrGAa/D6Y3lTre6qGPYnB0vCM/fXY?=
 =?us-ascii?Q?U7Ji9tuE70XNHiEz2RzdPPk6cyyfyKkE4LB1xBeK+bmddUzsritJrXId859F?=
 =?us-ascii?Q?FqZoQv/4QhYINfH+htemwSCWjTXk3pGpSTw38IBq0MX5C1PRwMGA57EIgVHQ?=
 =?us-ascii?Q?4ay6ZKHTDq/ybiI80AD9mVodJsRvkBjSYi/ChXzaRTPA2j4kW70xZ3r1KqJ7?=
 =?us-ascii?Q?jPMFsaJobubJ0R+O6sB6EetYiLAQ7akJsnXnO8kie4rcUlHpucsEB1NqQNbZ?=
 =?us-ascii?Q?zKU1V9BQcVLLVLQY21V+k8EH5meoN8vpMG2hyTJDyBSVe8yIBlgx8IV5mKqZ?=
 =?us-ascii?Q?RKZN7096w3kaKc4GA0D+7IyLlozuxPx4izCLpioCJFQGlcgtkNU+Td1jTPtm?=
 =?us-ascii?Q?YoVXzNdoNIKpYhXucWbPe4ntzvSKuCiKmnEq1fC1flLQuqHo1DgftDIBllAv?=
 =?us-ascii?Q?yAq+5GK3Twagvsy37Rqn0PqW+6uhgMjYjoVEPFjxRgN8hTExqqsEmapDC7m7?=
 =?us-ascii?Q?Nam31B0dGkW0JsRbV6IrDqm3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xfESnH5ZVvAej4rchA7KtLbcnffaMmAfyJnDY0kaTA8+vLdaU/GrgZ94YVZE?=
 =?us-ascii?Q?u6uWrBI3gz4Pt0p23BiuaX8M2JMl31CRQpcAXr+TC7ZY0p4MsYBH6a+QpMbq?=
 =?us-ascii?Q?/hDXjye36yCdNczIoBqlofHB1yPGSmil0uKzpjY4QzMl8UecdFdnsuDWpVUt?=
 =?us-ascii?Q?f5LmJKu91Ds3hpHMXiJSXMh7ZvboQb3v+u2SM+WkjVw6BfUIS9XgVUmDBa3a?=
 =?us-ascii?Q?cb0wvekos3OAJPGTrBjU8Ic/349VsR4ei5RPLEGj+QdyDQYRXthq0x1uZ7dK?=
 =?us-ascii?Q?8JCThwt27PE2Cr0VAPnj//uU5RjFIR/Aer9oGuK3uIfJMdxYB01IrhJvXVHE?=
 =?us-ascii?Q?Nygn4XxWyF7jhUEsawnAq94mGMe3KoXgzPW89N9LhcRkep7Oypo/M1Pxjw0b?=
 =?us-ascii?Q?2F1AJturrsirp20twpL5CaABsMjUB2zLsSiQFkFwN4giNIlt6WoWe/j+G+au?=
 =?us-ascii?Q?hkwMb37SX4IDT8xKZoRtqlhbHCffrRBqNPDfPFIyvghumSG0v6mEFQqv0ji+?=
 =?us-ascii?Q?7nUrft9MJNhGpvuPg/6EgJ166J0Xg2HTuuqxT8Zl85Kbzx8SBCsvPdD27IBL?=
 =?us-ascii?Q?8q4SgDuJYLoYK6npNruMJOx1blJyL18WdKjZ6/Q+gQuo980I/8oTdcUoZY7d?=
 =?us-ascii?Q?PxiBMS7p5DnKdjT/fguEEoiEvX7hBc24klSSd1jeO8nopAUFPuO2AFvqOi3s?=
 =?us-ascii?Q?Do61V/wz6Ltj4I9bJxRVeAHDo2OjL6af2JgTJIxsGqQzljEwZGxD787+RLRo?=
 =?us-ascii?Q?xXeJzghcMBIq+rm3Oc5Tjoq5jv6dY6N9O3eQ0RkqMam1JuGhn3yESmj73zrn?=
 =?us-ascii?Q?DF0On4LtF+IOahJplgdPfml27skmwGmvgUu9ut/pvPEOOJH2MlSKawiUZHuh?=
 =?us-ascii?Q?GC6Ou2/udPQ3qPjg88tL0pY8LZib2iRbJ2zNNto2luLUzFKeA1QsQNz7n/KM?=
 =?us-ascii?Q?vRjlURuMt6zsRU5KIbzXmtwC6r3JbJf07rgOw7tTvyW2Xv+6A5BZaX/bnElp?=
 =?us-ascii?Q?EYBkkqHuK1DfoSmqEIJ7X10S4gXm94kz9wYLV6boSIC+aEpdOK+TLY6MMsdy?=
 =?us-ascii?Q?BSwnFySY9PcJQgAXF+IbSspY9syCi1ji6jEMPLzAHpROIWqMDPgVQkJbDkS2?=
 =?us-ascii?Q?n7mgmQIewtPlVdFVJYDIwKWgFMbT58e7FaVZtNlPkpbBTd5ksOCTlbTL7SYq?=
 =?us-ascii?Q?FQUrdRcekpod5e0S0VIbP7u5qnE3vXFRLXXQWhaH8JR72i8oN8kgSi0Lmdaf?=
 =?us-ascii?Q?CyKn3C+++b/WArAeXq1Vh8VO/XoZ/ooWR5weUOsiSTrBNbev3J/T1rzHeoF7?=
 =?us-ascii?Q?EvFV1MgNQU3o/GgfoEG9kcg8q1XV8OA8TuEcRHVSrddFGxuRY/Xzp7mXKx+B?=
 =?us-ascii?Q?GU/jGlNC7/33r8fpzLkvxYKGzYp5vZgMB1+WorduxEgr3w1j5gfqtYjkQ5Ga?=
 =?us-ascii?Q?1YsayH+XlfiKEAF24VDevbolg4HauEpAe9onSSvfoGwQMqpHxGI4+7p/2K/B?=
 =?us-ascii?Q?oYnTKHE0pkUuAoZsayOD1TBD5bRATdG9y7IBlljPgi0hZ8z9eY6LTPR9xZpn?=
 =?us-ascii?Q?An72PevQim71gkWTB0pjulCNGMCu3g4lbUx/ztRlCmeF0Sl/VJNFCeQKEGwa?=
 =?us-ascii?Q?sj7FWufdvhxUNzFROpcUJRPzxv/g5E4F8nOyu2yUbC1uD1mFlyWmDdCyiDpK?=
 =?us-ascii?Q?xW9+kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uArK7ca24/5U7KEfJ/CXIPVgc/8LIZn41urPr7Dy2O6XkECYEhSpyM6llWnaFRg8x6gcgloz9JyIVBVdaVWs8/wdK3SSiHXItAQwUhlR/QzSVgoG0G1XwFPkPE2p2MQYxffrjx57VgB4J+ntSu8OIvQWbb77/SNWLnaxC5847R/XzzxmV32gon0OFdzhNNk4YQwAGLMcVbu5DpVB+qKoa1Oc2mQVnRxM4xAnyPwlHguAIp1rHqusHqYLvgvoWPaz4nyhv327Zw5niu/bmlvRk2MrohmmHH7GWEgXbgacQBrMc+l/8cQ3o60MXA4fD4ex9REA3O/vWgTYlFX1XLA7l4dZns59PphVa1h4vEF/ykGZRVIP9WtlJBcHZlzGgWK1K/x4hKEN+K4B9bPTMY7V11v1zmNXR7XuVhN1wtAJ4Tzb0vJnUPfNSASS4yJDbdQS3xkNaaZPiXfr1lpKxklLaqFpebI3CK9V4OQ3hUpeoASR2nHnD31y57A/6wK930k6nMHFcnkdwBzpIW+mbipKT216CRltLekAq3DB+9lkdZgp5cXD5PraJo6cKOGkq1L+cidsOXk/Ai1WxuptBtzcJzIm4WqlXQQMjEFET09wWGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b26e73-8c99-4097-98dd-08dcf4f04bbc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:26:48.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9F22pPgXHurNkDjSDhE18p3k2go57KWxxKvKKq6Tc1PvtWtnuLmXQtG0JAED5v7DjKFOHkjayETj540Ganxsj14Ef38EsddHc6whWN1YK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250095
X-Proofpoint-GUID: u8mp1PHJZCYPCyIKfjmVIb63JrE9Rrx0
X-Proofpoint-ORIG-GUID: u8mp1PHJZCYPCyIKfjmVIb63JrE9Rrx0

Andrew - Sorry to be a pain, but please keep the first 4 hotfix patches
("mm: resolve faulty mmap_region() error path behaviour", "mm: refactor
map_deny_write_exec()", "mm: unconditionally close VMAs on error", "mm:
avoid unsafe VMA hook invocation when error arises on mmap hook") - in
place and replace the remaining 4 from the series with these, which are
intended for mm-unstable. Thanks!



The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the VMA
is in an inconsistent state.

This series builds on the previously submitted hotfix patches (see link to
v2 below) which addresses the most critical issues around mmap_region(),
and further works to improve mmap_region() complexity, stability, and
testability.

This series moves the code to mm/vma.c to render it userland testable,
refactors and simplifies it into smaller functions that are significantly
more readable.

It additionally avoids performing an attempt at a second merge mid-way
through allocating a new VMA, a dubious proposition at best and one that is
highly subject to subtle bugs.

Rather than do this, we simply note that we ought to retry the merge and do
this as a final step.

v3:
* Separated out this patch series intended for mm-unstable from the hotfixes.
* Grouped all merge state together in __mmap_region() as suggested by Vlastimil.
* Removed unnecessary vma_iter_config() as suggested by Vlastimil.
* Defined VMG_MMAP_STATE() macro so we don't retain VMG state _at all_ and avoid
  any strange behaviour that comes from re-using it.
* Fixed typo in MMAP_STATE.
* Added additional patch to remove unnecessary reset state logic from
  vma_merge_new_range().
* Moved the merge retry back to before __mmap_complete() - let's try to match
  existing behaviour as much as possible, which previously would not have
  accounted for a potential clearing of the lock flag.

v2:
* Marked first 4 patches as hotfixes, the rest as not.
* Improved comment in vma_close() as per Vlastiml.
* Updated hole byte count as per Jann.
* Updated comment in map_deny_write_exec() as per Jann.
* Dropped unnecessary vma_iter_free() as per Vlastmil, Liam.
* Corrected vms_abort_munmap_vmas() mistaken assumption about nr_pages as
  per Vlasitmil.
* Changed order of initial checks in mmap_region() to avoid user-visible
  side effects as per Vmastlil, Liam.
* Corrected silly incorrect use of vma field.
* Various style corrects as per Liam.
* Fix horrid mistake with merge VMA, reworked the logic to avoid that
  nonsense altogether.
* Add fields to map state rather than using vmg fields to avoid
  confusion/risk of vmg state changing breaking things.
* Replaced last commit removing merge retry with one that retries the
  merge, only sanely.
https://lore.kernel.org/all/cover.1729715266.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1729628198.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (5):
  tools: testing: add additional vma_internal.h stubs
  mm: isolate mmap internal logic to mm/vma.c
  mm: refactor __mmap_region()
  mm: remove unnecessary reset state logic on merge new VMA
  mm: defer second attempt at merge on mmap()

 mm/mmap.c                        | 234 -----------------
 mm/vma.c                         | 437 ++++++++++++++++++++++++++++++-
 mm/vma.h                         |  97 +------
 mm/vma_internal.h                |   5 +
 tools/testing/vma/vma_internal.h | 115 +++++++-
 5 files changed, 546 insertions(+), 342 deletions(-)

--
2.47.0

