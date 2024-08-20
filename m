Return-Path: <linux-kernel+bounces-294708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84295917E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1E1F26008
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048D61C9DE6;
	Tue, 20 Aug 2024 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GD02GfOG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AriZs7dj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A841D1742
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198316; cv=fail; b=D/H0CxrzmgDK3Ai/DYqabXG/0Q79Q16d8/ZuXGns4KDjJvLNhr329hTfcpDbEZg7D09477n6wLkmwySJAO/HqZyk6kl/+centffjSJ30Bi/vm57MR83n9tjZWMGQ7myuyUQ040bZM4707KcXzh5Xy+lgMrSCLc70x5yS6M8SWgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198316; c=relaxed/simple;
	bh=hygKnTgp1lFS3zNqeg+XUlMB3rKTe63fOaUtEeaOdFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnG0e3ZqbbBKua9fl5fs/9P+yAGSbP3VwZ++vjk9k/xo/kqER5LnES2HuVQysUCKqv1OCVpgTDohgNGYFAOpWTiYqEDiVFcLiyufm1iJr2UcLTuE+TlGNciyZfDZBadTABgicktPlRYXvEX+XuJyDnVguNzchPxXE4YF/ezlOHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GD02GfOG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AriZs7dj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBegq020565;
	Tue, 20 Aug 2024 23:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=XE9RiA4eVXF12Bs90znzCWWMvf9fN/K9WnVIKHwPxHw=; b=
	GD02GfOGlOWUzkBAicZBuNYkHZH/nbFPmswsJzwd9H3rx8c72V/jhpcOrN2THXoZ
	1A8Zyim4/KJr69QvJ3yAoZ8W7tt9U0WdYZ8o8bC96a+pwsNZeWC/jPnzFaFAp/qB
	ewmg7sqKG8rLFAsYncsibCXgfDH1ve02RguZicVXIJsm9OsiBTEDJE/cmB1e75fl
	w6P+RggLOpv787RkNG6HMMJwH9qm2R+Q6Xs1c93pmFx/Q0QzGlKdLSXDBoAIiyPF
	wMWQ+UhfyjAE/2tJ0YXVJ0AN6GrDzISFSnaCk78fgTwVNkjSBjIqkEfYCFpaJZdD
	WrLarrDysKoFOQZgMpr+jg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6ged2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNY1IN023382;
	Tue, 20 Aug 2024 23:58:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154x78g2k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dK2W+Vr8R2kkW+XfE5mD9d8QMP955Z623vAO84sLQFmO5GAUP2XF95zsFa0QOq4Br78eUkG34aE8RWkgqncqTsMtVJjAAlRtV+OoI8CiDhEfFGYNoEBNKxaDIWyIAWc7buRUZff4oiyRyJzx1jKv6a/Aqc1plTiPpRscGEwE1G8jCBt9mA9iQryLVcNlNuJ63lQ52U5AnZjdAHNk0kJZN1ZMz2yFK6iywJ3xESGLm5RQ6tJoGYa18cWis60bgEehlXKS1S9PpvFMd3nikqy0G3w+UPVUPm5YisZeX5/tyciEw4h1UWwrWgEFF8D1zdP97qpxfbQEZ9KYrf7KNv+QGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE9RiA4eVXF12Bs90znzCWWMvf9fN/K9WnVIKHwPxHw=;
 b=MvYLqV1xii2hTiRFhdMLHLgrXV1vmUql1V4jVfg6njBeMPDp/FPc8Ic6RRq4d0GdsPxXUxAnfb+HlOtSsDapV8BZZ/yYrZ0PLDKPgHHo3y8rYTfKSaXeaYGza34L0f0gQ6U0daNSX7heT6Wqf7CYA9hThW+VR9BRic5XbTYsuW0enxoTo6irI/MiUn1QuRgK9tsu4/0iTXLzySAFDPHmrs3UUBClKQQoCeDbe+sv67dnsNStccFEh7g4JQvOd72XbjWl4bGOqMvHQFzAN/5LiQbQLZG2wzSPa5hY7RqOu7oRxKRrDFKeBgqPItjwdmbthMFl57UeyW5hqutc7GF4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE9RiA4eVXF12Bs90znzCWWMvf9fN/K9WnVIKHwPxHw=;
 b=AriZs7djrwjUKla9m8HYyAkwnQPylnBUtu/HVpthldQEDQIPvdc/KbE8F/o/8/3URO2FbPqvupaDH0219wLerNR//8+RH4dSgcA/Puk+gUCdW7DVZwDwt5OzsWZ5tNbvZiIA/plJUd74YjKv+lawRyCasvO91JaqGHhatFSQLKg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:16 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 16/20] mm/mmap: Use PHYS_PFN in mmap_region()
Date: Tue, 20 Aug 2024 19:57:25 -0400
Message-ID: <20240820235730.2852400-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f9b360-97ce-4dfe-62a1-08dcc173f5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hyz89Ck8ydcrWS1ofl2Q9g6LPAKQy8fez2P9Mi0XSRYZdCqGrNWiuNqQ/xEv?=
 =?us-ascii?Q?0JIfLM8aJKN2MA3tl83VtSRKFmtr9NCjD066HzZon3PR+6K+XeR2ow405zWR?=
 =?us-ascii?Q?+XNc8w/6B6PamFv7Zj49Knx68Lg1TuYgYBQZnLoBLrS3fb2i3sI5Xt61wrzE?=
 =?us-ascii?Q?lKhUrcDQ4GoT4SNjn41/jkobVJBRNWX+MYjYxl4cm4c8wi74Xgzizg8PjPm7?=
 =?us-ascii?Q?S7xnZs+v9PQPJbnFj/KEMufkjVX9aGlmKDSxsvFp7KrlUFqZBCu0QvNIHM9/?=
 =?us-ascii?Q?Y3RNVFr+Z5VF5bLtWA/1Bcl38M+c6G34jj3EpRcUJfXcTk00P9Bc+UyJLBlS?=
 =?us-ascii?Q?Fd33fGiV4M3HuShIOsVAWjGpFuPUVSHTTCo2VmZLmgVSD6gzqkKuporCXXIQ?=
 =?us-ascii?Q?2ITb2X3sGPOk1rwpIhQD/jvbkekfFKjJzboG+1WTDWhUCIDM1cD5V/m3UXTW?=
 =?us-ascii?Q?KBIgtfhekLhg4FqefzsJ5q/9Le3vBeQ0OWWyP21cDxgVWyrIY/YWDmZx1zDc?=
 =?us-ascii?Q?jsRUcNlASidQdrSy6z3L0kYfP29EWZIctGS5fkDI99a6oHMzczJDPpkavmU3?=
 =?us-ascii?Q?Viw3AYDRqNqW8npoJMyWrcP7xg5Kwfw2iC0CnV7XFqPD1xoAHrw1Ry3kwojt?=
 =?us-ascii?Q?M1Lq0T54PlMZrMXC/WdqutCAXau8SkQl3EGB+IM0QHR21qYd/HtctG/88A7a?=
 =?us-ascii?Q?KDcoed/KDlDdq1HTo3N0SqMDxdElNVBKEZOe0xGsjbZXbH6vvSjPa9j7EiUx?=
 =?us-ascii?Q?vPkRQondeTPFiFX2anbebM8/xC43fPX4+5lJuPbvuyrfJms3DEDdtxA9w3mG?=
 =?us-ascii?Q?FcK1WjTfYu1Xtzx2qHCRBQKmQTpI5CZ20lMDudV3hW3IemscKHPylRWx35LL?=
 =?us-ascii?Q?GRKg7NHSwMcdVUNMltHDoopLf+DRpYVxRLxKiDLm9vCymzIEQKxYD0wUVndl?=
 =?us-ascii?Q?GBv/AH1octMVYnXL9C8ULnGC5H65q96h/TaSqq5Uz3mv3NYyx7azvUQHke/g?=
 =?us-ascii?Q?uOwdg1DD6PJvNmUhJTQoFXT7yha3LoLFhvs3VKrYPDQ5JpZDn33mn70BesEc?=
 =?us-ascii?Q?MqAR/EGi4hU5rWGZ9ztWp4n5gaSg/5ypu+O6kk9SlWeuSt0JNK683HqMeuhg?=
 =?us-ascii?Q?EqelsgjTKfw7MxDLjCLmRnJ/wedbI698gsZAY4qKAVi7OgYNIi5+Zgxzydws?=
 =?us-ascii?Q?TR/XyGbMEbibDBlUkkhi2p8+zBAWzMXVDqrTa9fsqjP+PyT+aBejsRpaUgd6?=
 =?us-ascii?Q?wTlDTZUYkBnS0qM+ta8TM4YspkbkKoKM9HXgnGx/b8zeFZ2sntvvX3enouPi?=
 =?us-ascii?Q?Kj4wKsbTZsDQwKiYpFkkH7byNLrpCIihthWH2V941tLT+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A8SlSZkEfKsDUJaypYaaQAuHesjaS8kFa/gD4Beq9TZ7gfKGKyvGliOp0fM+?=
 =?us-ascii?Q?7KJOXyGZnzZyUd+jp3rt0hzWVT3eIgsvfTtOr5CyN8sGzLxbPPo9EtPRYEDn?=
 =?us-ascii?Q?C0wRvO8SVlGjCYkeI8cvZPQnPc30n/XLxFKOMdoWECnnl3811Y3Jlhi/GQSp?=
 =?us-ascii?Q?fE6TvpC601umtQBjAwl0dSac/GYA0+ylq9cnD84e4mvoUohuIXySQ1Reie+4?=
 =?us-ascii?Q?vzs9t5Yykypm0TfKNvDViidWGC5Nxc/K7+BKd/48NuaE29S7/6GGa0FilM6l?=
 =?us-ascii?Q?18o/fO7QUyhvJoH18ghIWx9JvSzrvVlcpPjoV5q7/6r8SGna8dlREdFI1f1X?=
 =?us-ascii?Q?RpSQJuHjkE9uRGUwLNoFXwiLPWlyvsXs4I/+rMsd7uOafoFmiAyQEIS+osYV?=
 =?us-ascii?Q?XXodSErGOCEnWEgiIhQfAmX+d5Flyj94mKZ6e6Pza7yLCKL1DiEEoE6fbqod?=
 =?us-ascii?Q?kd9jlNnAJb7L6H0qvuJgPOJdu9osuKfJFIEst2uSkziz+n9OK6vlkGKR38Kt?=
 =?us-ascii?Q?xl7pXIaWJOLXOsodSxF1Itbhyoy0nOiIIG+xpLcA3UXFfxA5hDnXJXCn4ptq?=
 =?us-ascii?Q?aYgTRhonugcLPODkgaaULRAjaxnhoUKkV4+zNrUrbetkv9JDaJuK9Ik6lhdV?=
 =?us-ascii?Q?L3w9Ixp2au+1ndHt3pEKhzzPrkNEcbCWJPsbQgJWZ3bG9cmXv01c4t1XsoF3?=
 =?us-ascii?Q?XAzQrZZDOS+mxJsl+yw/vUmH1QahFvQrYtOms6Mf8txrudMIo0/PJ/5dIvpm?=
 =?us-ascii?Q?25gwdZAQDQF5ToFzHWcmC5bDTIFcnkeE5LtP6D+X/A9/NqPuu5lac0N3ow/N?=
 =?us-ascii?Q?0Xfz8P1XYktlavd+UuwyAFTWMWvQS5g+LEt5FN29wSarGDBI/pH8A3Phy4aa?=
 =?us-ascii?Q?g2uRggCCMm0Byt0dBq9EUUxAL/fGcuy3V8R0x6bB/d2KMxj9UnvpXEDQwmgG?=
 =?us-ascii?Q?BdhKEhFizl/SDe7gNZpqQ+uRk+VRouDiyHPlJLTg7RaAHIKisfmoJaLnNA7Y?=
 =?us-ascii?Q?fm0+UoCjEEj8ngPg5irUX3g8hIerXTTLoAbX6f03x4h2nn2vyattACw39NWz?=
 =?us-ascii?Q?jN/Bc1xl2NNSKwCph319IAh1BY9nCyHtceP3pcPoc/4BgZ/bNlJbqpnoUcC4?=
 =?us-ascii?Q?rOoX7j5mUv2ALsgtnGE9yfrYe7xHEihgzBr9pg+nUwG7hw8vWQZQsuoAnFVF?=
 =?us-ascii?Q?laFnkDcAbU5IzKQUSFETnF0myysR4/x9YYnpTpEYe60/JaPihPoSb8KHfe1p?=
 =?us-ascii?Q?oHhcHv1gT+EJytvJch6qHHuqyVJh8GJrT8xzSQkv+eR+MDRIuH+EzWtxOmG/?=
 =?us-ascii?Q?RPvfyB6oh+79Fp+irAmdH+tHVA+n/sicgCRgI13q6N3LB6GDOwG3xfYbJ4GC?=
 =?us-ascii?Q?fZpH+rVZyOg0GjWk2nLPejgfmYuZXbLQDxB1BPRJVh1t2dxz0OsP2PXDAP54?=
 =?us-ascii?Q?nJktmyL/SZBhcRY0zKHHI3HFdZgrCIbgznNBMHk9MhetSrZyxljhQElRyndU?=
 =?us-ascii?Q?OVTQ+yH5KzNiH6aGZa0kP/E/ruyddzqXORERw+gEcGTAJWonqMBs1ABJ4rcD?=
 =?us-ascii?Q?Mpe/rBmnM7W+DUGnMp/GkLhr7JwHWBACziEUO6PGuLkoT5pDP5FhHW1nc9oD?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IUTA6yyD8gm9xDXrtN/UDhMtXbjJyJB036CxW7hf2XccXpwV6hCsagAHUo9FipBXSz0JmRbEmqoE/6/jGgD2DFrG6qSFfiZSgJ8B1bIa8z9jkpC5qW54HGWvN7WrIkTpWq3CWCN/QFhu9Xm8LjRxbZ0gx+h5dP1jhKNYrZDq4t4TxkvFc1CNdocznTdzP7j62MEbG6QnUQKEQXnPW3dvpTXs4PsxbZpdHy9A8Ffc8G2/notozWbFi7FMVOXUd/fQivGlG0s82D3lXWbeEIBWJORWf7n9Pqah8jUOkUNuj8W0UsWpauRTzJ8z1+NxT+I2VvGQfIOaU4cxR7j1XSKm7TQGm2LTlDTJjAsTKCFOa/rEvCII15qvxITGg//2kJH8KmOvadlyUitx1DhUyN5Jt8/0n1YZTCjOcu+6AG3tzQk/Ijk6oEHinBCRhyBNrGU3WtXrqXnz+HlCLvLTzVSbtBF/jKfeXX0Hs/62L0CloKgVDS01z5NAvKGOYhofMBa5p795rDaj0uitnnJ45bqiLwVtepfq3NPayW+wO2dHA6ba1m5/uPwICY5oPZuLCTqyp9KfwsvTcsajTsDIiQM1bis6KqKiNWmAuO3ZWzP2Woc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f9b360-97ce-4dfe-62a1-08dcc173f5af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:16.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaUm9psfDjXDP6FI43q72V2I44Q2UOk1pqTnDGbQ3mFSfdhYwXTJ6UYxYxT7PWB/Vhb8BEwz3qON9bSwtvfdcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: 6cgoLUxnxlgtrCxQ_6ZDrGV5xShNyGYC
X-Proofpoint-GUID: 6cgoLUxnxlgtrCxQ_6ZDrGV5xShNyGYC

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
existing local variable everywhere instead of some of the time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c1b3d17f97be..19dac138f913 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1364,7 +1364,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(len);
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -1384,7 +1384,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * MAP_FIXED may remove pages of mappings that intersects with requested
 	 * mapping. Account for the pages it would unmap.
 	 */
-	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;
 
 	/* Find the first overlapping VMA */
@@ -1412,7 +1412,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
-		charged = len >> PAGE_SHIFT;
+		charged = pglen;
 		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
@@ -1573,14 +1573,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Unmap any existing mapping in the area */
 	vms_complete_munmap_vmas(&vms, &mas_detach);
 
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	vm_stat_account(mm, vm_flags, pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma == get_gate_vma(current->mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			mm->locked_vm += pglen;
 	}
 
 	if (file)
-- 
2.43.0


