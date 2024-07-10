Return-Path: <linux-kernel+bounces-248165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B79D92D910
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7CD1C20F87
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D14199234;
	Wed, 10 Jul 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YAUTbMqy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wuK6GlnB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5BE198A0B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639431; cv=fail; b=KOOPwC3O/wQGTHsSTNWwkANe5e+ms8woF9JHzPSVNub3j1bEdssN3+UjhpP3ULQsi5ZszBEu/qf7EQXv0Rv7hT14eFkIBNSPlLpyem2Q+QjyMD0KJ986H702QNmSD/Bwp4EiiuO2Zq4oSReDF8bEd8QUoVV3qoC50fy8/Hmz20Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639431; c=relaxed/simple;
	bh=6X6felgurVJVQvY2eziN7gg5D6TxgsIoz1l/XmP1Sxg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Oh252bLu3R+vZmt5gMi85fUJjOAEX+8BW2BbFK9mh9FdipY9NMhzzHdLb7Aw5p7H1FppCiz8xhXCirg9fagmZRPF2gBMTB+ctJnZzO55qdnaUWiHI7P9YpIdPkmwq3aFV+LjfqgcOSK7/zDOjuHzFSaCFBsM2vPi/xU/r3txptk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YAUTbMqy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wuK6GlnB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AGIInG012020;
	Wed, 10 Jul 2024 19:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=QcDp4MIWJkp3T5
	u0KghSh3RYvYOlDVjCT2K1TAeDYaw=; b=YAUTbMqySHuKpxreFcD7B/sCb/yie+
	zBXIimnpHNov8l6fgNwgOBb/Poe9LJtxpDYScl21qVifa7x58pkVKCxYJfkjX+mH
	icyOFj96rAhPHeGQozeEMbpHdnc5fpNuIbJp4fvICqQJdxlceVlqa9BXPjnbbgE7
	rTazvX1QSGLaeSx+USIa3z8VzW6288dKE1w9IxOWHLpXrG3mObVo2ZIm2rA3BvUF
	KJL+2TYD99MXMQofRMAq1E+ZdSvKYVQHCRn8SyPxggJfPKRyMfINf3IAGmW4n/Bx
	j1epwiJ+u1wN7Uf1G0XwUZHvsMjE5WIP5EFcaewXyO6u0RRSX5lHyr1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcg0bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIjken030110;
	Wed, 10 Jul 2024 19:23:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vva92t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0h7+LYNdwa8y/1qVH+jkVjXRI2oXNsk1HvMELzgBFepyOxtZCuSM2LvErj0iGK9pZYAHEkM+rYUyWdKwegCQ3TFRULgP7D1lJ3l+dRqn5mhFdeSUDD0rVYmCCK2hxEuPUSD8buAC4SMAbwXK3GUZyRqGwI5vltOcWnxhy3g9YxBJcty444sGAwjaP2JRn0Z902e4r37Oaz3RfBKmF7yi+uNyBVkC6QzQR2gouiitmdNx0LzUZrOvYXFmE7MpGJKurErVOSpUUuXr6CICnti0a6eh7M+krozB0stnGx38BkeeTEoyXWxrfKNGNJfI+qfRIA3cyfBCMY1+DPHBB7yiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcDp4MIWJkp3T5u0KghSh3RYvYOlDVjCT2K1TAeDYaw=;
 b=hMrkul+ALo9Mu+w6byJyyIjPFueg0oJWUnSv3GiCV4cv0IE3CjfBcQiv6I8vhCOQR2dw1EGftTKDf6OuH0O2c+q2S3uRxWucMzAwkZR5lEK8V3rGr9sLaOHROyAPrY8DRKVOeWwcsbMkmq3cKQr8RkA8NjPU+fLruZ5Zvp1hNfhrA4H8mr/IfIssV7I/UcoJqPrctqsFUgJP9ugnyFF3wN7vkG9qRe1foZNE8zKiXhYSSeocLNDL9mP8440heq3Fxr5EuU29gn/oZeBRUOuzSheZ/ysS8uStC7LfiKpeFt28IwxO9YG9D3GOk8OMHyNPCRlKkHinPTZnTP9k3qAX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcDp4MIWJkp3T5u0KghSh3RYvYOlDVjCT2K1TAeDYaw=;
 b=wuK6GlnB9YGeFQM9vU8vt9A+CzzUS5bvxjcO00pO17AE715v5xuNj6UJ2YWfhP8OJo2PX0fj0OzakxnhkiczPYAT0+agCLx7905FaIIACXVFGX1TebK+NGxHTWQl1yr1lCov1cS+4u6uTcRTYGNxKMIoDOpN6QWa2k1f1P4x4qM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7295.namprd10.prod.outlook.com (2603:10b6:8:f7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 19:22:58 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:22:58 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 00/21] Avoid MAP_FIXED gap exposure
Date: Wed, 10 Jul 2024 15:22:29 -0400
Message-ID: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6e88e5-1ba9-4a1a-0fa8-08dca115b4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5JAc1IG0nWkQTFl1EyyO/Pbh9dbEi8VQW9K8UjgDiQaWr3lrmbN3mXZCEntN?=
 =?us-ascii?Q?Mpd0WczvA9SsxhapwW6acdYtUAfOMdykuGMce/Q7UBMh+WBGtv1Mtu7+Dazv?=
 =?us-ascii?Q?u55GHhI7ntuLYGlpqfl2kBF2YMgWw+1nQx3QkWJ4mjClG3azj4TNb+ovfcZV?=
 =?us-ascii?Q?7SeoG6B5fMQ+yi5y+NXzd0APqLk/OTeIohzoPnWd03eixtHK74+XXbH+sygb?=
 =?us-ascii?Q?FhXOLzbdx0BRFIvjv8mUS/VaYPaACVfRGwH4DtIVnHspTG52XwuZrldm7zl1?=
 =?us-ascii?Q?DJ60+hcjBjQSsZDm4v/wWyrjCY5Mx8RJP3Ex5QhWzaT89Ky2nnQHayIaRZ5c?=
 =?us-ascii?Q?y0i9D9lkr4gnhSZBiDtAkJhJvjqyk25DpYmdww5y4D/QwxjG1tzLprF8OYeT?=
 =?us-ascii?Q?HFXGiwcaBhFXpAND4iiSuZ3aiH0MHaehaECmHjtJZXbZ3Shk3PjgeBAdzMqU?=
 =?us-ascii?Q?KCKnF7Nam/78b1KIUerAL43C2i8dgDOxdRu0djnXCoCkoCLSW6IubiCPp7k4?=
 =?us-ascii?Q?nhuUqI2BVHdABrKlA6v8j971WY1NNZFdxf/AmWII0Ip9fTUtePA+rhWRB9dN?=
 =?us-ascii?Q?sMOlK0n0qhi0FTVTa4sBS89YSv9fzICzRxXGJecC7vEvhnKTH4aup/9FLPaE?=
 =?us-ascii?Q?yU+rOIO+Mf0ytp6qv5B2YcC6REcyX1xe9/9UiXuJtoRECneoc6ldm0Y6Nq3R?=
 =?us-ascii?Q?Bj/ao44XUX0jsFQ7rVBwVJQJwoZNRMEJKzdLQpjklmjkLzlyK+6y5MIgZr8e?=
 =?us-ascii?Q?y/t/mD7+NZQRAt1PTJEfb+NBvzrvbG+IaP6uZiqG7r7NDDDeeh6Tso/M3LRJ?=
 =?us-ascii?Q?oH9o7cYK+qAY6CAZEoKnb1/c4XsfvBU4rzCFONCa58UEM6SUYR33B/ZPQ3vJ?=
 =?us-ascii?Q?c5Jz4ZdNMQpF1udOT/9CpXf7jPB0KwXLACivpFZscN0ERlqzRn3DqZatfUxS?=
 =?us-ascii?Q?RCL4GsFIaJrkmj+PbXmy+llad0ua6tV0AvI/qsLiI80gffn6d9wu8GOLkHvj?=
 =?us-ascii?Q?5S/iG1BVMHZ2JFvtzm27KRg4IqG4nHfZYzeqF8pPYdqUJLFX/1LpBRyPC0n+?=
 =?us-ascii?Q?RgUphyYm2HI+AU6OdvR28nzVJafrgzwaE6I81hjSKnMyefg4L++LLFvA4Ipv?=
 =?us-ascii?Q?OrxlIiOg4fWTjuX89yNihGpK7jum2VPmNfm2NwivaHKIPROWd9gqKMKFaszc?=
 =?us-ascii?Q?3cogG8IYvV/Vct8XHJFvYi6R3kZ4L0j1huB8L/+XjEx99XVLCPW+2e8O/Lf3?=
 =?us-ascii?Q?UTXI754oTIG7wqAsf+n6oMoDdwwHv1FngFofFWso7cyXaI/AwDqd9yNpQN3e?=
 =?us-ascii?Q?9dA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q/U2S/DRvEOMrD/4eY12YJ0o3/xRZwWw9Odygpugvj4VAtYahZxRmFbE86TV?=
 =?us-ascii?Q?cromvwaW+JBphp5uDnl3jS+FKrH8Isb1xdgAnW6CKHg6Rr+4x+NjmgNSmxYX?=
 =?us-ascii?Q?QwRX8QF0OwdNoGGtETM18KLJSA2UdH8GSidRe4O4WoKvz37+T2qcz803nxkM?=
 =?us-ascii?Q?D6FWwSK5l3PC7TsSwKKFGM8BTmOoO4kxWRd1Zwma5GZY6afl8bTVo9Yb0pmw?=
 =?us-ascii?Q?K/mU6CxbLAGN5jBdB+2N+mIMyNfCPmqGkn11u4UVI/z+IbJUVIUuPfoxRZDa?=
 =?us-ascii?Q?6niyEQ0F6Ps29PpTEfDcEMAaMTY4XRqsC2V349rPtmB8rnaDBZr1W9k1uXTx?=
 =?us-ascii?Q?HEKpdr5UZwH/CFNgmnI2lfOUf3vFYjfnXiVVvuPfSm4X+Pguk/4/vS1bfQJH?=
 =?us-ascii?Q?pNXmOzNHtPCCXNsQL4lpvAcQT23tv7PB4D2ABWJARqUrS9KqoAYaHvU6NbtW?=
 =?us-ascii?Q?8w3GgmgBY+3TKJZMToyaTz9z/Cp6FCi+RSzWVxk2riJmIc7t9ObnZDUHJh/Y?=
 =?us-ascii?Q?pv3SKF4xIhLl2AB9YWfu6XlEHON53rcw8Z7TL9PbPxjJCNcp4FbZYTFGY0y2?=
 =?us-ascii?Q?l+XxEQM4LG85s4dOH5WTvt4R1/zLLRAVsUK3ol3L43wi0t2KrUmnQV3EwSc2?=
 =?us-ascii?Q?KlLAcfLAyu7eZXcnILc5ctAeGw1bwdAiuF0hQcoBR6c1lQrbLJfZxSJUF4+b?=
 =?us-ascii?Q?1YEwLHRzLiEaj2uSZLDvmgHaMWV19bgo2zmGOZuHqQW2SvPs5T7OwlEjVWE1?=
 =?us-ascii?Q?6IapJsdyQTFmnmxp19fnTIOIqtohK9LGHOX389n75GI7Islm4RUU/nmGgGqz?=
 =?us-ascii?Q?pUzW7XQ8rqxnfOq26aejXlUCL60FxbTDuxJ+sSXb6E/Z0MAVfbl343UILRgD?=
 =?us-ascii?Q?qIUNifkaJROdFB1pE8rugthooYeX9gxvwAUQiPGBqbe+G6RlbSu2dfW963VO?=
 =?us-ascii?Q?B0eEVbNDWyO/xg/5+WXQXv2q0dXAV2yaVemHiJ3Nzex3VVaTjjDjxMPE+VhX?=
 =?us-ascii?Q?QFmtTyB4WH5h7tGIYysyhUhVFMFkFG5UgR1jkmqDNNsjOarOOkvX5aYv2LXv?=
 =?us-ascii?Q?4oiUf5TpjiuSiGbOeDhMFO30UJT/2RTu83bBsop736bEJXW6AUzcAE0aVfFH?=
 =?us-ascii?Q?64lrmOR4hHb1n1z2tPo1rnUL2MFfRTeel10FYt6QhNCl3pFELuJJYB+2rJeW?=
 =?us-ascii?Q?MMUcCD7scVErBH669EO0z0lCuQKmddpIpk2S5BfL0kxAvON8S+n3B098eOM2?=
 =?us-ascii?Q?nzsCLCfTPL33o27LJ7grvSstj+NTzE4g7glw95itxMxpzwa80vdYwJXOYxU6?=
 =?us-ascii?Q?kUb1E1Kmc9xdhJ7buqUVfL748dr27y3GxWq634wG88kNF1NODI95vz7Xu8FT?=
 =?us-ascii?Q?I7jZkVG4Eiccl66iubKlR5qIGyNimgrEP3bO3ZSUWmYIZCCqI056fy75ZzO1?=
 =?us-ascii?Q?xXXp/VtJdadGeGC2/RxBYqVzi3zPPNPjDh2InV/KdwVICy9b8n8f6iwL3ote?=
 =?us-ascii?Q?15kqvAxlO5PVvLQOzigSJRCxVIzJRDWcJM9sL40vKj7sCjJXQqPafaJV23KR?=
 =?us-ascii?Q?PLvoZXypyUXoOlU90ik1WuCcg+BWnihUMC/5bjmGwIWA9qKaA3rnj38Uw3nD?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s4jVBkudTZ51hdOKuYaIVrlNbz2FMjHXLjyq81ovTRqpluTt7aahTrgd2wrC3U7+C4qATADgpuQtXhZTXTBHxUOvENeAHTUw+nE1q3IiPvYf+Wmq8QFMAcW4Au1dOE+2kgKmUWuUuirXC1QIv4CNFE17i5xq1OdLwxZrEEqETgufjDAuBUlNTc+ur74XSuHEHp6usOzFfH6xg3sG3HAy+dIz0b5YaFNYrs0esSoHlF9BHLuH4QB+9UoIbfCcLkZQDnik7RiX6568cfN3RKTdBrjqN4gF3yQ/5+mB2bqdgqtdncAcp+6jnKvtcgchG08mHwiBeksx0L/2PLFJtp+OnhdnDtuXR1kMBtx7y3zW8qw0iy/ej74sSXxkWW/kSamgBNEcpPWuyqVdUSwEb7DS6hJTthqeRk9Rz8hkaTU+DrzVkmbiprANnV94Fs6BTI5baAHI2YgDPgYtvo0TDfKgJIm40DWd4Y6KvtbrLZ2TO8YmcDff9NqY4Ucbl08MG+WpIc4gGM+KRci4ughh0YYcReY7dTjIujqw97vaHYxPO5e0BYK+P2SxKStjnebyMCHmEqzTsZBuaOGayn7T1v9CJGibc3IdQ6/q1W186Vahb4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6e88e5-1ba9-4a1a-0fa8-08dca115b4e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:22:58.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny5kpE/Nv11GYp19qAU3jjqMk3Iu/9kp1fzxl8/fxYtJHIyZd4+t7WasRcQnw4vu0WSO9uRTf7zFTxPLjWXKxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: iuKW4JrqvCR89gc6JWZD41DBF4nwRF5e
X-Proofpoint-GUID: iuKW4JrqvCR89gc6JWZD41DBF4nwRF5e

It is now possible to walk the vma tree using the rcu read locks and is
beneficial to do so to reduce lock contention.  Doing so while a
MAP_FIXED mapping is executing means that a reader may see a gap in the
vma tree that should never logically exist - and does not when using the
mmap lock in read mode.  The temporal gap exists because mmap_region()
calls munmap() prior to installing the new mapping.

This patch set stops rcu readers from seeing the temporal gap by
splitting up the munmap() function into two parts.  The first part
prepares the vma tree for modifications by doing the necessary splits
and tracks the vmas marked for removal in a side tree.  The second part
completes the munmapping of the vmas after the vma tree has been
overwritten (either by a MAP_FIXED replacement vma or by a NULL in the
munmap() case).

Please note that rcu walkers will still be able to see a temporary state
of split vmas that may be in the process of being removed, but the
temporal gap will not be exposed.  vma_start_write() are called on both
parts of the split vma, so this state is detectable.

RFC: https://lore.kernel.org/linux-mm/20240531163217.1584450-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/linux-mm/20240611180200.711239-1-Liam.Howlett@oracle.com/
v2: https://lore.kernel.org/all/20240625191145.3382793-1-Liam.Howlett@oracle.com/
v3: https://lore.kernel.org/linux-mm/20240704182718.2653918-1-Liam.Howlett@oracle.com/

Changes since v3:
 - Completely removing arch_unmap() from the kernel.  PPC doesn't need
   it and no one else uses it.
 - Relocated checks for mseal'ed vmas so it is only checked when
   necessary.
 - Remove do_vma_munmap() and use do_vmi_align_munmap() in its place
 - Added inclusive/exclusive comments for start/end of munmap
 - Added comments for unmap_start/unmap_end to specify it is for PTEs
 - Renamed "cleared_ptes" to "clear_ptes" and reversed the logic so that
   it is now a flag to indicate that the ptes need to be cleared vs it
   was done.
 - Set the "clear_ptes" flag after a successful vms_gather_munmap_vmas()
 - Rename vms_complete_pte_clear() to vms_clear_ptes() since it may
   happen before the completion of the vms in the case of a driver
   mmap'ing in mmap_region().
 - Fixed comment around vms_clear_ptes() in mmap_region().
 - Call init_vma_munmap() unconditionally in the mmap_region() case so
   that all defaults are set in the struct, which means
   init_vma_munmap() must support a NULL vma.
 - Use ULONG_MAX as the limit in abort_munmap_vmas() for clarity
 - Added a comment highlighting that the free_pgtables() call may use a
   different start/end based on if there was a prev/next vma
 - Removed incorrect comment about VM_ACCOUNT and mremap's move_vma()
 - Relocated to mas_store_gfp() call in vms_gather_munmap_vmas() so that
   it is clear that the accounting is okay.
 - Skip validate_mm() in do_vmi_align_munmap() on gather failure as
   vms_gather_munmap_vmas() already validates.
 - Added R-b from Lorenzo, Suren, and Kees - Thanks!


Liam R. Howlett (21):
  mm/mmap: Correctly position vma_iterator in __split_vma()
  mm/mmap: Introduce abort_munmap_vmas()
  mm/mmap: Introduce vmi_complete_munmap_vmas()
  mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
  mm/mmap: Introduce vma_munmap_struct for use in munmap operations
  mm/mmap: Change munmap to use vma_munmap_struct() for accounting and
    surrounding vmas
  mm/mmap: Extract validate_mm() from vma_complete()
  mm/mmap: Inline munmap operation in mmap_region()
  mm/mmap: Expand mmap_region() munmap call
  mm/mmap: Support vma == NULL in init_vma_munmap()
  mm/mmap: Reposition vma iterator in mmap_region()
  mm/mmap: Track start and end of munmap in vma_munmap_struct
  mm/mmap: Clean up unmap_region() argument list
  mm/mmap: Avoid zeroing vma tree in mmap_region()
  mm/mmap: Use PHYS_PFN in mmap_region()
  mm/mmap: Use vms accounted pages in mmap_region()
  mm/mmap: Drop arch_unmap() call from all archs
  mm/mmap: Move can_modify_mm() check down the stack
  ipc/shm, mm: Drop do_vma_munmap()
  mm/mmap: Move may_expand_vm() check in mmap_region()
  mm/mmap: Drop incorrect comment from vms_gather_munmap_vmas()

 arch/powerpc/include/asm/mmu_context.h |   9 -
 arch/x86/include/asm/mmu_context.h     |   5 -
 include/asm-generic/mm_hooks.h         |  11 +-
 include/linux/mm.h                     |   6 +-
 ipc/shm.c                              |   8 +-
 mm/internal.h                          |  25 ++
 mm/mmap.c                              | 545 ++++++++++++++-----------
 7 files changed, 345 insertions(+), 264 deletions(-)

-- 
2.43.0


