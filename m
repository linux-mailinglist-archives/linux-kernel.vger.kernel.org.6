Return-Path: <linux-kernel+bounces-248157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F42F92D905
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922321C20FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF8198851;
	Wed, 10 Jul 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kH75C1QG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QhtIYVJN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8B197A93
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639427; cv=fail; b=mEAqFa2aXo0SgF9LsZW96yVb3p8nha1UuVX9+ibJ1byWB/uD2WaOnZvbxovjkrB4QCrf0N3Y1a3bWlrspP5jt20ApmjylijN1+5GBF6jeNBnkrIyeOi0nh6CAUmKX0+NeD3PEUtUgezns7Alfve4d8iVco+7lyjnh5Yks8yrFYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639427; c=relaxed/simple;
	bh=o/vxcAtBQy4UY2vf/sacRBA+pJQ2L8jcqQcEGuxhZRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CgmXZTMYsGRUbgcwKqeOdgSikdxppqnUA03A7EjW1o3P348bhGE5DZV4Ux5Ht/bJWn1e9+EKZzHW4leCPxE6w/5FHiusRLjLt7SHWVvAF3GEyl645EyJlvW71dG37TyN2nJ+Y2VMOodeaAUsGJ9b7EGlRk3U0qcqESjkg8wP44s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kH75C1QG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QhtIYVJN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFqOb6029616;
	Wed, 10 Jul 2024 19:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=R72J2Rq+pSM7hD2A/i8y70d9fRxZSFkCgc//56gCKE0=; b=
	kH75C1QGYiqJh7JsZk5E/VoCsVvp5/pZvaD4eup3bFhaQElIoSYdeLUPZzwsOy3g
	EYviTh3TL+CV0wW4zLIyPqFdyVMv9G/rgHIN32/iUBMz9k3eYfG3Mecq8Nq0yEeX
	mozO7i4TmGeBjtNli20D+fA/DIWE3M5l4XdSm0LUW4SsE0MckHFhsSE59V+5w1EO
	kzNpOXMSUEAHOEWVU/6GZ85gUzQGi35WiNLyOjID8a7SGNOH6m81HmVAIGEuNdxt
	Hujwuf9KBIpzmhqW5OiUgklDoO6ToXF1jRGRATbhk81CHQZOzDRl8GmR9JLxQsYs
	M383hYncMHNDxdTj9pEVgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq02f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIs3bf022604;
	Wed, 10 Jul 2024 19:23:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1gwv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXJSVk06BGL/re7ezazeKpybX9q1PoATPkV/S6K6vhpKo3qxcyiI4CIMDUnxJJcuxDfapBHPDj59ZVU9/D3JKZlo7P4ntlOLrFtw9PIzSujvcpoLWeea+Dw6jjgJwUfMeKuNSM+rFWvRNyZZl8Fc/KyXMdPKG5dBSdYwe+i9HeZfDrDvE73oXiCH5yHUoHUOe+7dpDdH75aLDLJgKr95DCdCCpYoM2p0dlGqrTRKVA+zl/xV+WTd9mZDlCIdGKRIq168qSxgfQjsCirFXx2c+0ZKDtS6uvWzTaeBr+kdVf4vx6XHGhHZKnqKdZyFwf/E4H+H6Cn4p0WdT0jzWfm48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R72J2Rq+pSM7hD2A/i8y70d9fRxZSFkCgc//56gCKE0=;
 b=l6ZwNhzV/AryAvn0coknt3pUkKL7yKuYwi/MBAk5bsLYZg9ns75Np3I0fAcirzlZyUNO8HXovhaYstOsufA3Sad0lAOyzWNTmSlTn4/Eyu+Ju/12CxkouDt1WB5b/IpZ2MEY+GmRKzFYvRyewA0wCTZZbvF4AO6Pj7OGkCML0YgDEt81wrSMurn1uVJ1EauB4hlv/dAuvtTG4uOWgh5DSNquWOebInHJ4FImaVVe5bCtJVTcTAYLI5rcL+t85fRqmj0YAhmHRpWSV4g/jfHtRpAjc9mRqLedUQRjCerXGo7a/pdHV3KB6bEFgWv9ZUBfMR9MqvBjCYaNStaCLuDC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R72J2Rq+pSM7hD2A/i8y70d9fRxZSFkCgc//56gCKE0=;
 b=QhtIYVJN0O7XXGVvzx8OkSwBYg+Ez6hI1RaIXoPP81cBYSVuQ8NqIDDBWsDI3TFMeEvCJGEhWSpiKcnHdmfGE7u78E+V5pW3TCfMBeOf7h+o7uP3/p+hsbI/WEiOfcf7GTLPoA8tyOgFpE13DIXsXfAtYgAqkdlztgKCbjQ7AwM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:12 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 07/21] mm/mmap: Extract validate_mm() from vma_complete()
Date: Wed, 10 Jul 2024 15:22:36 -0400
Message-ID: <20240710192250.4114783-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::32) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 913993db-e462-40fb-3f62-08dca115bd62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qpxRz3lnXqCWo85Py7wuPQqo3tHZKh2aTXeX9w6aNsehFIPOXnr+KxmN0m0p?=
 =?us-ascii?Q?axsIQvcK7vcAfx4XCIu5oHcxzjoMXG5LfofcZBt6q9VeDhLrpcTZzYq84xND?=
 =?us-ascii?Q?E7als1tmz5q3tQbU3EZeZAhn3FEmo8pRpP66qSbiPLZpzlCoz7kyQfQhZhjI?=
 =?us-ascii?Q?O9/N4vQNRpMEA45vcCrd/bMJgBgrXdjHp2cI/QKC15bATsv8vfjbnUFoY4Ti?=
 =?us-ascii?Q?LoytHOH6u8WqjCoIKf+BPFbAV2sGyBPn1LqM4ZoHvSdjSkB/moGYZRc6w/sM?=
 =?us-ascii?Q?ceQPIM1P3mwl+56osvIp1/nEknDqFQe832SMYHXxtbpzVWWPMBIkYjLtX5FD?=
 =?us-ascii?Q?QeSK7azS76n87249zhCCpQxf1eBBc1rkojxChXto+PpxWPYUDp8eeclhGU8e?=
 =?us-ascii?Q?wR9EMKqrDw/VMGT0RRstzScrAnuV2qrfBIob5wJ5LSjVbXQY0HaEwP1hT5Ey?=
 =?us-ascii?Q?ATAOeyKwr9pCKQ+vUAIyfcEA9K1rPOV/orXMEy1Ugt8qa80P4ycVS5Qa+oIo?=
 =?us-ascii?Q?zYPT6L8MFGjZffdI0weohF5bf/BPL1EfnhRbqOj6sW9f9mvdPIHBFxtC1yOD?=
 =?us-ascii?Q?lDvuQgJ6D6g9xuPQKMy6JdF3ZFcP782aAhw9RwxQ0Ns1wb1xY3/15aAXJjby?=
 =?us-ascii?Q?rERCNkNy9grKiLThy1DQn6uXhQ+sjct0HqF6jzUQgon8p9p50sEGrxWMCiFP?=
 =?us-ascii?Q?d7lZD59M1cC+372X+p9I2uYQWfG3TQi8fXsU/RyDOjydTeV+XL3V+15dy755?=
 =?us-ascii?Q?Aqy0zjnPnwUX0gVzEHOpv6HKYXAhqwxI8BnV28FNdUcron4wv6efQ7CesvSp?=
 =?us-ascii?Q?asfQgTuHDs3NwSoLYu9EzwCUGUXjo06+tyTdq6Kl2DPBH5/ghLLtmIPppgwO?=
 =?us-ascii?Q?00sF7MvQCmW4+ml4MnyeWVos4fc3wsfz5KCI3T9iIDRHZUlvllmbufCrwpWC?=
 =?us-ascii?Q?LwI55pmo2SisqpKZj4aLQ9isHz0olQ3wJHFgKEnxuHGN1st1A6tLiA0mC1tb?=
 =?us-ascii?Q?tywKyfTawtZgCbmm5iI2DJPb1vM/aKVVCpg7ot4b5U83wjMuCYPm7658wwYC?=
 =?us-ascii?Q?TX8uFLgvISyhmabV8pBN1XpqWZ5b0cgf6+ryJWU1NEr+n+cSh1pZJwRrxEo8?=
 =?us-ascii?Q?85i+bA7nv01wJRhNWGj4Y2z44AHBHXVSRIb/CIgn62kVEhoxMBUYeLnCvqK8?=
 =?us-ascii?Q?40aqfOFaaixwQzQa1JHF4lglfgIliJ1XqOfkK8vxT5/XF7Ih2asiTqw4nlu7?=
 =?us-ascii?Q?1NO4ypcdGAjkRS/0AeP5ahOJd1H1jACua5CkJb7gjfNvtao26+V9Qm1trRDD?=
 =?us-ascii?Q?76rPW5lGt6eltw59X+c9ZhJcNeJrtZH9DzTDw1Qe7Sb5rQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3GXi1P14dsee35q0A6tu4L3vftdQ8r/8To8OT8IAtIM3EnMqIrhz4FN+cxpN?=
 =?us-ascii?Q?Xhq/64klJW77eDdoOYiQQMydc+e4mDvhkvZXD20gCM9Q3zAcni4JXGoy2L+s?=
 =?us-ascii?Q?zrE+NSzFZIv20QAhfR6h7tildrWzE9IemgHehA31VeuFIEe3dvl1U2JvICRF?=
 =?us-ascii?Q?Lv4Vd5wQNTwgJUS2KuFJ/7et/8gvuUDZeOo1vf/No2Sv2Rf6Nbd1+RbBUrdj?=
 =?us-ascii?Q?PyiSS9Hl9xKR/WlI1HJrQDXvi2AWhZqz6dFruNiOfxXb7EkyrossIGgdxFmC?=
 =?us-ascii?Q?m197vdcd37k9W/ubFHS2cj2PZDfPqApIQnMTqQZWgujcs64oIUwQXxJkO9FF?=
 =?us-ascii?Q?C8iuRedlV7m31MfngfWs8XiYBvwJYsV58vI1lNUyZNo9V3+rVzubTlJdVC1W?=
 =?us-ascii?Q?e9SiY6ddgYh2Ig8QWVFL3/YMg8AdoHRm6Ct7lDTLEwxEolT3krqe3IWeHnMv?=
 =?us-ascii?Q?mGLhZY6W8BhxC5sFDoU2kuA13UfKHoEvrXuSPHzzt76s5FJq745CfmOVbQlg?=
 =?us-ascii?Q?Kt7sVHnjnKI1GGERWK8p1UWMbrjqXBRj2pekNTkEMivCoIugrLrub06lAiCs?=
 =?us-ascii?Q?V9e8J23EThpVZCE4u0scJb1n5COmoW8gPmqae2Mb9iuj/1OLDwgQhMbwzJCV?=
 =?us-ascii?Q?A4zd1T44T7GD866j+a2wd7G2R5GEZQX5JISFL5NJNUnH9anSodcEAnAhv6IL?=
 =?us-ascii?Q?YNR5rkd8oK51mUwRE9H/3H+Gvo+wRLJcmbYGt805IvTBivs6XtGu6GYzPLuh?=
 =?us-ascii?Q?wQj57qZJZ4DolCrhWJ9OavNHW6rjqSLLVsAk1UAi2XF9I2YY3zL1Q5ED1reI?=
 =?us-ascii?Q?KQouKMDcAS8HY6Nq6j0bqDd8nCjl/s+XbF7INJtQAn8M6JhWpAZfj2oytdU8?=
 =?us-ascii?Q?cEYz//1SjbwIL/sws6O6KASGK98tUaVuwf9UHA8UVgJm4JC8h8hZpsc0sgFw?=
 =?us-ascii?Q?uKqhLJedSrg2qbGRNvqx9Ww2NfWcAgxn2+lOzHETZnvuYgc8tPk0F3DO5thH?=
 =?us-ascii?Q?zESgYIYTKuvSWhebF4BNDocYyblmZL9GyfSrY+HPq8hTSSQml4cPqcwxqvFV?=
 =?us-ascii?Q?xr95TSq1dxVK7WFAbTOx/x9lCtKC/zXjUNKezgZefbBHgyKFzY9u1mOXUoYW?=
 =?us-ascii?Q?XpzKmWMT5BOPqxKQwaEXHksD6hNnPI0Ck5DENPwaIdvgKEbp6O9dma5RPdIe?=
 =?us-ascii?Q?oxNbEI9D0CJ4ZWex5Vj8jrD36nrtbv5SUgJmzjzyukOt9yh4jaXJvSx4V5WL?=
 =?us-ascii?Q?2448VI6cMnRbnmB9H3vDlp37A42YHzHB65d537kECbQu1puZwHvN9XQ0raT/?=
 =?us-ascii?Q?yPSk03hdQ9NEd+k75wVQ4lpZR6BacuZ2g3sg7xybSOX5zzy0/VWZv9c2aQkg?=
 =?us-ascii?Q?xsd4aMfvljP5Y2+8I9jGd+tBrTwvz59SKg99A1eZbUVg2gLdIxq2dNhoRTvE?=
 =?us-ascii?Q?/J1er41UslYy+f/I2ZFps8klMDWZVjylU5ja6FY1BNo/IxrsRAOOfeGDWVeq?=
 =?us-ascii?Q?gv+GRV5I0716wveZ7I3xVk5IgFXuqpiMl7SKd9+/bJWfoj8Rbq6jmi0lWeVB?=
 =?us-ascii?Q?TU0GWxGAa4UFFxHpm+kQNXArjCmCe0NmK6+9zt6tB6sNHfQgvUJjkM/tObsH?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PRKu89PPurl9w6qEoyEUVf2JPRwnc/K8W1McNoo1c5a/6fW01RVMX0YR5R+PSTALha2G+42XKrxwwGoZqvrnwcW+AyLE+tDQFHvBPYW0G0V9aCIkyOlS9L7xpSRWNONLIecc6vw50SkvEu8x8yscIPXLwNtNzOKU8zlJYwWh7fchWnTtdsxY+KVrKqltSq0vbUvKrtxUN32fkaTpbLLha2Ad9D+z1fNybRgbkkg10KB6bTwTpLF0pB9ddZq2VqxJL1yfW3SomtnI45rgZnOGTmEAlZ+uo/UClQ/PwSbMfPX0pySyYC51ljVa1joEM09BZA6WEI4TYHPIfgS5MGTJR38hfSheuRwpJhx2J1yum5kSJcW12qkDtAs96cLfaWW+AF6kCNIkyTG+L3uCOAKXR1DueTwnKjlm6tgn1uypEGih/VBtSeLeQ+q866/6VuuZn9i+GUSChuTNMlpz3Fg3odh1AP8USAhqHt/zmNwAkN8oPPgP+f2FgsabQKHCkq3MxfCa5TQBOH54YAgRYSVuaJFCo57wJ/j5vdxCgOvHhvqFXXl9hWOl2Lq51oej4lOwbxJrYnlfEI3gzoEPgFBZbPkJ8Rdiz4/uXjwe8ylIO0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913993db-e462-40fb-3f62-08dca115bd62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:12.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs9G4uTv6nLBU+h8/F4NIE3JnTzije6TnGKzOZnjZ3ESc9ObXv1Wxd93RUyUvenuWGHBB0dXlCsb4NXbauDzvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: MCn9IQfe5Uz7v5Q-FWv99Znj6zJzbt2S
X-Proofpoint-GUID: MCn9IQfe5Uz7v5Q-FWv99Znj6zJzbt2S

vma_complete() will need to be called during an unsafe time to call
validate_mm().  Extract the call in all places now so that only one
location can be modified in the next change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 62ff7aa10004..1c9016fb6b5c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -646,7 +646,6 @@ static inline void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }
 
 /*
@@ -734,6 +733,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -775,6 +775,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -1103,6 +1104,7 @@ static struct vm_area_struct
 	}
 
 	vma_complete(&vp, vmi, mm);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
 
@@ -2481,6 +2483,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	/* vma_complete stores the new vma */
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	/* Success. */
 	if (new_below)
@@ -3354,6 +3357,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_iter_store(vmi, vma);
 
 		vma_complete(&vp, vmi, mm);
+		validate_mm(mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
-- 
2.43.0


