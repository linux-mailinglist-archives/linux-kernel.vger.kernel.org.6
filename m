Return-Path: <linux-kernel+bounces-364928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299899DB38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770901C2144B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13C813E3F5;
	Tue, 15 Oct 2024 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j05TpPfb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NntvftMw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E241F61C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954922; cv=fail; b=Rm4mtFmZKBoCcCyGr9rWHhdjI+ogCfyQan0urvdiHE1Cx+aGilsyf71OwGETKgZhIWb+16+Rd/Tzez/a5ajMATx5u6SU2W6mnUVUqddP6QoOoJ3BEDz2SI+4GI3cDsMC2BteoaBokZtt8QuUm/O1Lpj7iYyxJBHlxho9Jvk2zvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954922; c=relaxed/simple;
	bh=t3Q/9+VHKq9xq0UJ7dH8l0u3jh2ON/uKl+qumwQZ1mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fDTb9kjj4++Kqg6ScuXcUZ3BvKgwkEXdpSi31DS6f/80YaZgjZp/FsWEgGhyLfsk8wv/2ICNwOZ8CV518MfX62XhXyYzC6KuNnUPWBK1oqllhmkC1ctpmjkcr8qlTJ9+JXWZKj6CLWmQi6MZB9mWAvIjp/ST0oWGjc3BxbQFIEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j05TpPfb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NntvftMw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1BfmH005616;
	Tue, 15 Oct 2024 01:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=5xMY2oZLzA0k6avu3F
	2zXsdoLWfeOIdedXC29KoQ0p8=; b=j05TpPfbLWTZBYcy0l66SuQFzp+NSgp6jZ
	NLxYO83jrr8HekBdhIxdR2FTsy7oe5cC+nUlDiWA0uSV+H6UKGUH2/8xJvPPnuPo
	OvMcvsIyqhGdmVxWpcspQMcc9O8O28d5Era923XVD1LRL0VMV4QAwtHjcfg4rLrc
	eR/dU6ujk5i3n6w3PQ1VmnLwEdD70YkgawFO7P/USUiv806SMwkTmqSDN4s45+Ua
	XdGdKR45sg1BAgGunBlYH/Dd0FkEKxmF9SdHT6dkp+FVeA+sn7XA7TunamjQZxLT
	s1P7LDdXa3g9CyHvk0dLIDRWUyZ6nh1RQERMoyTpsVPtJcCqXggA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcf6db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 01:15:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1CpGt014021;
	Tue, 15 Oct 2024 01:15:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj6s20p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 01:15:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5eTnaZcZn04VS0Qr6PpAY5obP+gvBg3YmwGHQ7lZfecEFhyDMD5MTVtFf+VS7Bw4OWHAHJgNzH+V2ghIVIvJ49aZHkCAFPkRz6/djkcIOKZJSN4DFp4ylVggoAXgYGn3jOH8XZHQfggDWXQZaMnN5XYN88/vzrrk4MN9iJ+7T9wka15Yn6AzZiD1bQhSo84Xf/0EyVErrf+aiBv1eArbMDnKeZmmAR98MLiGsD6pipTq6auEIeBl8jGRYOq0x2hn72fB5tNyEjbMDyMqYiSVp/q/QEWPs+2M7I7bOTkRUTD3XeR3B2e8n1lD0h20qeZFJKjZzI1ZNCzEuZau1i5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xMY2oZLzA0k6avu3F2zXsdoLWfeOIdedXC29KoQ0p8=;
 b=pYCOnIgrjZUVF45b3eHqDnNagJ5pB2V4hGoXysJdeKG/veIwzCu52ceD9H5iL2VfolNDIQoojuX9V8jImtwWi2qHwuCkC5j51+cK4/AQQRlmQTo53A7nGwITb9Ju7vAAjVTgXxvxUjfqZDtA4bUNvVMItjpkXQRC82A5k4IQh+IJWYTFlhhc0TepWrPWyAJTbUty6JjgYPyEQLTbTUUFUDPrIZrPFeqHI6et6KssnKi8Fykjtvtbr//50tpYWfSnJ9Lg82TDUC+RtOS//B5tD7oG7M4LbZ9ptYNd3UKhwQH5ywKdqyZ6p/H+WQargJOQb2l7MNIS9RxW+cy+peiW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xMY2oZLzA0k6avu3F2zXsdoLWfeOIdedXC29KoQ0p8=;
 b=NntvftMw9pbrBLWPRYZXQ17Z1ls8MBq2yyaJWYVYWdlKZ/oP4/2HFsD/U6ouMHNW0SVJda0C8Xjn9EZdFWoG7YyX3VwYGj753ZdRDbnQD+1S1AocjflNi0Fi/TF5vnzTJL6Ef02m2l+tkB1yO5VLSd1ia0J2ztzoLaJZo2L99fE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Tue, 15 Oct 2024 01:15:09 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 01:15:09 +0000
Date: Mon, 14 Oct 2024 21:15:07 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/2] maple_tree: Add some alloc node test case
Message-ID: <juxyinlfa5gn6pbhvae34xamz4zx6d5lmbkfeo5uwg5hu4ctj2@ruvlfmtbx7ji>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
 <20240626160631.3636515-2-Liam.Howlett@oracle.com>
 <20241011011759.wbw56sqgmhzjwo4k@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011011759.wbw56sqgmhzjwo4k@master>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0ef69a-892d-4666-1666-08dcecb6cfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5DufdLW1lAFvW1rlR6mx0w+DA1tlR2IbwHCUbONUm9W5f/wSTpWXLqaFH0bN?=
 =?us-ascii?Q?ec4M8xwDtm2OMGSFK8A8M9k8eMukLJsqpXzS1ouTKZkLFiQ9Q+wdlSRow2wX?=
 =?us-ascii?Q?JvHQweaJXm60MReQrgFxiefJ/Pcs7HvexencS2TKZjQQBgO4qhx5QL0j6hXG?=
 =?us-ascii?Q?JQ7o3yqP5aK1q9dnl3/DKgR/ISiVMjnpBxKZ6bSzTP45oNJQNYZT9u2oT3xw?=
 =?us-ascii?Q?+ytsrrtnv1zCWtP3siXA5LKzI4Rw8uqQ0QcgKpUqJK/m/R37kIxQ0mbiOl3M?=
 =?us-ascii?Q?NE2BRDNuabIlcqyaTRYmUlhe0bSmrLuRJYoE+qNm5qvw++w6GwO3vR4i4T+h?=
 =?us-ascii?Q?Pq8FZhPdoPRistIYvhLTkPBfr/ZCYYFLiSeHNMInADUgBV++ieCu+rklWnc3?=
 =?us-ascii?Q?b1l5TYtqD6Zt1CMk8n4JzePbfec0UNf8iXGZuT1BOD/RZS/xPBGY/FPRtL5Z?=
 =?us-ascii?Q?1ogUOp09Hg12DJOzoxyyiR6VBM9Xd+Ds/qAcps/iju3KDzujjA5CTsDQYlft?=
 =?us-ascii?Q?ZE/wV85a6Rgyj85h7X2GLsi4reU6DMC8XPXRiH3gubGBTG9ANowFHpUvflYG?=
 =?us-ascii?Q?WsolJ308h1WSdzd+gWaS6iM8e2QLru5aRSwMC+GlROpxjsweSiNDz0FXsVvF?=
 =?us-ascii?Q?NqRIs7vadMNgC3QnhlpDWaK+ZFlwW3sbI/JrXwjYtUMnGh2NFsET7Q6aCaZB?=
 =?us-ascii?Q?YBjLd+e449T9EYOFKPx2CfG9cR2N74Hb5NRbJRiZhAJjtQxoEKh5MlfjxYWY?=
 =?us-ascii?Q?smUnqx9NhpcwpkjXlECO9cEfVLUEm28HxzHhXW9yD8slWWteXMzg3Gv1m6Cr?=
 =?us-ascii?Q?YRMwLnfvqY7G678/2lPYXKP11/lOpHmhkvlFM+vi3E6akfYuz4cTknn7NinA?=
 =?us-ascii?Q?blQpNPewraInMt65Np/N2AmuSE3jR/mOBRKMs8qPCfZUJU3QyVuDu42p058Z?=
 =?us-ascii?Q?vNMry+C5UIFB5cDoVzuSWyMuT62kl2RBkfav9Mm/34joGwIqiHAcKxpCmIlk?=
 =?us-ascii?Q?iVFdDiHCPs6NYBqBa9bpNZOYA1rB+D8nx6FCF/Tck0rMF7V+G0FVuLkYMtwt?=
 =?us-ascii?Q?4p9zHM3oVhjTmB1LVLSGCNR3Uj8A6fAZvQBBTClNo8EXupdKlJA1Xtr3SWl5?=
 =?us-ascii?Q?XbCb/R8eup74ZH2M7FxNk+LozkJjY8uO3pPk1IV3aofy+cXv59o7HvK4ck5A?=
 =?us-ascii?Q?8HgJuy8OcLjHOeLY/Sa8UwodMJxHnm0R33gP6TDuUc5H2HJUpzVqXl5/jWXI?=
 =?us-ascii?Q?jhzeT26om4Nul7aBPF8QYSA106OD5KMMAXaSw635hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BB6hdwrTojdgsU4bCQz9g3GRODnr+cRqXcriIJaWWaEVzeyeN3fIDB2neBOJ?=
 =?us-ascii?Q?zcHe7uKr3MtQla6n1EQa0Zj/tFlOC52LjmnEnNACn6z/+vejq57Vmf/ysdtr?=
 =?us-ascii?Q?l36lqzAA3R5CBHWmRkqppS5vSvlkqVqp5H0cUvUJpn8WT2i8o+3OcWSl+Mje?=
 =?us-ascii?Q?1ct/mDVG9SLqHKIi15kUXpxR1y1WJhqBw0XryxUf3UfA2TjhwltCcA3AiW48?=
 =?us-ascii?Q?JfAQCTmnpzn51W3kjmf/FS34gcEcyJ6LKlj30n9/HXTJ//3DR+jM7IQ4Sw+1?=
 =?us-ascii?Q?AjgFm6yamSdwkad8UFdxwULOrPNqv/WBazFiwux47E51o1mG3ammc0TQcNbc?=
 =?us-ascii?Q?4GQRE3CFQ44IYzLz6Z4QgV9mjK2r1KhFIstM1yjF0Ocw7z5Th4dU9pKI85X/?=
 =?us-ascii?Q?K6MmfgABRdkpOvdEpMeV++ghQPR7xe6Z4RU7NFkaSy2q0S/b/v/vOom5vQit?=
 =?us-ascii?Q?ZLNQVsY95CFFinv9IUMYrhaO81kCE65uarVkx4ihP9RXcViz6zyQ7XQ63Yc3?=
 =?us-ascii?Q?q/ozE92l2nYXq/Qm6wiSPe7J9JdHwkOTU4teZeMNfJxzrIj1lAB/VYOKfwE/?=
 =?us-ascii?Q?Hd54yNTfWrL65msYHqnbcBKkMcuVK8iCiTwSpxWzY9lzv7ou+He/t9gFpjJ3?=
 =?us-ascii?Q?4LCXCzLvCSrfM6p6jCaHgjqcFtAg8xMi9Z0UwkrS78w9bPVBPM6edXT7tosu?=
 =?us-ascii?Q?3pX6Fdpt6yecD0YBlnXHIKUZC/DPNv4F7wdr+M89q/HV7d0S2JScJS6upVuC?=
 =?us-ascii?Q?BBUhLDDhsLHOjGF8wTdGrBVNuNtSY3WzxxJqLYAD01bh4rMBdcHPd57kl7dQ?=
 =?us-ascii?Q?1e2i2olR3j4npLZBS7OeDh3uV+ml5ma8YobiGDJGOFU5AuNuaJE/tmWOPaa7?=
 =?us-ascii?Q?pZTXTWUFssUr3WCW/TYn8EFWFRKQMcQHdebp2DchAlkJu5/rodfrTT0oUCbQ?=
 =?us-ascii?Q?llPgiilCB05EzpJoKGMr/HsKhyuwlkxDob9VmDibU+7bFLqOQHXF/lMMaqgS?=
 =?us-ascii?Q?xZWuc0S1qXlYI1/TMx0FsObawMnpXQJd4czcyIT/TKzmgasRv/i02hZTfO1q?=
 =?us-ascii?Q?aCx9WD9etlAucw9ys2p0HtOkBn/oGECYLOC3y8j/KnHBiIr00QQEgbuE86eo?=
 =?us-ascii?Q?A2TXyeZ7SLIhUGy5UtuHT17Xf5zjZxP5+2+eIvhHX1tke7WSWn3n9l9rYBIf?=
 =?us-ascii?Q?4iFaGK58w1EKhinMxGMksH788rO8GY9pW8N84tb+jpZo4NfzgNUU3N2WuY9q?=
 =?us-ascii?Q?Ysx2O1xQFZ3cGXwygtf84m2Xv/nXeWDY/+oYPexaN4FO1OeFUGubXiqu/p8Q?=
 =?us-ascii?Q?Nr1vjqMTlNn6l3mTdzUQx5NqwQwneU+8DPe1/fDuvgCD9dw3DWXwNJB5/iYM?=
 =?us-ascii?Q?9jmK6tWxOLKuyRbHoPTio7pL8ZNehr9xBXxEqHOU3UeMn0s1WV89p4pkvu1b?=
 =?us-ascii?Q?WoluhmbvqAwd6XyZK1q/pbOxTxqk9o8DCfXG+f6+YbD5ew0G7urqIKnOeAUr?=
 =?us-ascii?Q?ZoH3z2j7W/c54khXPDSTonF9+8tTwn7YQtfen11ipBOw3qlnjEamSHRsyNO9?=
 =?us-ascii?Q?TiP9rVfTOfZR6sU1SjvOocXfZc0WdZZcR4ALP1IP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	31cXRzyuz9s8hQQLor2r7m4QIVJeqKAqHO+sCYcu/4LIxfFT68MJqJwFCrTtWRrNEVL9sb3/OUCQbUjUoQrT6eAoUjvy3mJt0tJvok6rJYkC9H315I2JT/N7RBvutIkYwFovummDWfryqLyQYqdeZmKBhE/aIfGzCHqGss4Pha8CJqSJ8X2r6StGX5pM4y8oZL3gGc9bmpHOneZtnw+U5Oqw83eeHwN0BKKEf5llwRNaiUpOYCN4Caer0HkWv5uMZRAXqGw5hCaQTZ68+uzK/0E2bHNcqj0AHcizjW/uAO/5/shHJaP12RI2XxYh7aHB4SClCatTYG2rz/TS0/Z1AD/qzuq8uSdCGyQ1tSwVfYWw1cs1a60uL2L39o4kOzOrdcq1jApIzCFzFy7uMFFGzhYyiZawUibRybskyxQyTtwQBSJY8A/X3kXh8kTvzqvMA3ili0BMpJ6pUt5iI3IucErX6BQ2uQ1KFckG8D4XLHeWUtMjQghQF3Q+x4PuQLMmynHxElYKgcwM0R9hOCZwhhD2HJvXg5NH94XBTki2QdMPx9SKQXow5PmZUN/8Yjanof8/v+3BzifR5j9Zt655uMxb55AvKzmir9itzTcQ4OY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0ef69a-892d-4666-1666-08dcecb6cfa4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 01:15:09.2880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP/nClqzpsfgDiiFW05U6U35wJbrepPE1NtZExCIhf6ODqD+8VyC90z3HLcVJzYhLMGEFZ8akAr4iPwpVFu6aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150007
X-Proofpoint-GUID: KGzN3L5OlWRfyA0Tp5ZMKtXwdi-haHFo
X-Proofpoint-ORIG-GUID: KGzN3L5OlWRfyA0Tp5ZMKtXwdi-haHFo

* Wei Yang <richard.weiyang@gmail.com> [241010 21:18]:
> On Wed, Jun 26, 2024 at 12:06:31PM -0400, Liam R. Howlett wrote:
> >From: Jiazi Li <jqqlijiazi@gmail.com>
> >
> >Add some maple_tree alloc node tese case.
> >
> >Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
> >Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >---
> > tools/testing/radix-tree/maple.c | 22 ++++++++++++++++++++++
> > 1 file changed, 22 insertions(+)
> >
> >diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> >index 11f1efdf83f9..b4b5fd9f294d 100644
> >--- a/tools/testing/radix-tree/maple.c
> >+++ b/tools/testing/radix-tree/maple.c
> >@@ -462,6 +462,28 @@ static noinline void __init check_new_node(struct maple_tree *mt)
> > 	MT_BUG_ON(mt, mas_allocated(&mas) != 10 + MAPLE_ALLOC_SLOTS - 1);
> > 	mas_destroy(&mas);
> > 
> >+	mas.node = MA_ERROR(-ENOMEM);
> >+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 1); /* Request */
> >+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> 
> I am not sure why mas_nomem() is here.
> 
> Without this one, we still can trigger the original bug.

It will fill the maple state allocation.  Might not be needed but
doesn't hurt.

> 
> >+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
> >+	mas.node = MA_ERROR(-ENOMEM);
> >+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 2); /* Request */
> >+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> >+	mas.status = ma_start;
> >+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 2);
> >+	mas_destroy(&mas);
> >+
> >+	mas.node = MA_ERROR(-ENOMEM);
> >+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 1); /* Request */
> >+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> >+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 1);
> >+	mas.node = MA_ERROR(-ENOMEM);
> >+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 3 + 2); /* Request */
> >+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> >+	mas.status = ma_start;
> >+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 3 + 2);
> >+	mas_destroy(&mas);
> >+
> > 	mtree_unlock(mt);
> > }
> > 
> >-- 
> >2.43.0
> >
> 
> -- 
> Wei Yang
> Help you, Help me

