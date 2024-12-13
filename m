Return-Path: <linux-kernel+bounces-445146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6799F11F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB12282BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCC01E3DE6;
	Fri, 13 Dec 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kWuFKUdD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MrIXOjo9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2DF1C3BEB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107073; cv=fail; b=rF0hEfDAmxat3+9YRa+oyBOlKpoWLC1qxSfb8iX3/rbPtbC18BxKnZonlux8XQgbieJfNcqmw+taMcFI9NeFd4Je+k54JHzNgCDE9Be4EZYz8qaQzmjOanZxI963VFGVDhBndsNMQaC4zXahZtSIZ09IdkRHEzxQtv2LmTW8Ad8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107073; c=relaxed/simple;
	bh=cIhRauZAqE931te86h+HPeTbhfqGYEZRpSwSJNSVkNY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WcBfxafcgcMmxGmnIikG+0IGN85AWCmr7vr18QOWW40x4bVt2EKSrqKRrL8uOEQwuNXYsxO/Tnwi76Y6MHXngu9OvkINnGlHXMG5uyxeCAIivYOV2UJHTv5+eD2arSmWr6Ql60gtTTTliWfrebGlhNe0MCaQaFh/r4bDqyPTo1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kWuFKUdD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MrIXOjo9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDjnnn027989;
	Fri, 13 Dec 2024 16:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Z2ZRFZVh/i1Aw6uK
	SeYeDBODWK5z5B1ZTiT+ApsJ0DY=; b=kWuFKUdD2aYtp9b5UXOTzYdYU7CLnSeN
	pzbx9vb2safL2eSWLKPbOza4cHFt7pyR3AwqKDStDSZZXav+0N89U4dksocqVLed
	r1xY3ILPqEeFIxCXUh8vIOked42qBSSeDAiCrCQex0TPlRiRmqWG/3Oxe5DZ079V
	OpL6/3CtoTNLD7x45h3xkI3dNuloUeaTSL0NiCE9dKGu6V/HdmQdk/FyGpzZRKnl
	BKPUFGpNF8wOhTm4G1hSn3OSN9OIfe93NEr54kXjskbUcUycM3suhagnstATL3TS
	zYeLYbY+tYDoa0FERX1g8E9PTI13netCpWFvC5wvgs1k3dM1ln7fww==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewtdwb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 16:24:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGKmhm035561;
	Fri, 13 Dec 2024 16:24:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcwufp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 16:24:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y84ylFqqRzJddlsVrtKidbBqXXI/hMQxX0YpUkELpDsFKk041Ab7oZAeybHVnRrb8hczPgPwmw9F2gi29FjEqBuxt4eQsSp0dq9Z5gyQPTuj1JhoCxI7UO34VvftGyfTjQAsFQNvhV/UEIwDGWl07s/3nMubOjEo0aSkZ4YWlX8mvpj1BqHp7VYr/PR0ngwOU7haj3ZuKO96+U0D9GMuXk9MIemHXX+AaJxNvPdbHeh8lN4Vr4AF3OX/EpzDeotTV6VWE8DqSEyOprpJIJHxXhfMqqYX2koT5JRfDK3LX0KHyYEGGB+vp1MZOaSm+irbWmIHVRpz5IhWIViC1qBW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2ZRFZVh/i1Aw6uKSeYeDBODWK5z5B1ZTiT+ApsJ0DY=;
 b=XQ1Dej9OaXkT8hFk/UFlm4FBXe26v+zqisB3UmpIitHwis0mUd4VYNX+Pzzvm1sR/JOsPy3Hfw5ODppVznsMbe21z3dJxAPxhLjK1gDcPXccbPIoHs/VyAoUqKA21M7bzsXFGRkd657o2SZnPJM9xfB/GG0ekCArC8SBGMtiY2DWx5sUtyvVhMmwKlOttdVHKUenD/k7mCc/er0Mb6hKhfEAzY2zXsknolgfjiX2Fw8bydMm1fU7XfGyu388VUhxu3Jhimp8k4scTZfk4+BKpaifkMU73lgcjPRq1M0nK1d1ei/TNiYqPGyCUWdGCYmqxB04oFqsPzq/HYH6L8E9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2ZRFZVh/i1Aw6uKSeYeDBODWK5z5B1ZTiT+ApsJ0DY=;
 b=MrIXOjo9i3IjYeL112pmmoskPbQzZAW+FrHoGijQsqTdIrJWPVQDJRo/v48hLhgqq2uFBtdYDeuzeFEmv36tO9AcXq24s0VRwqQEInvbN5u0qBCYH08sdBP4/xpJ/qCRkFTFyN1tSMNH/usLIvMg84lydKQTXtM4XDAQ03tzwZ0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6980.namprd10.prod.outlook.com (2603:10b6:806:34e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 16:24:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:24:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools: testing: add simple __mmap_region() userland test
Date: Fri, 13 Dec 2024 16:24:09 +0000
Message-ID: <20241213162409.41498-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::26) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 931fd1a6-b992-4b3b-deaa-08dd1b9297d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zwlFvfwZpAL8aQsI4IWSAaWjYg4jSoxf5Iko3WOc3/JGKBlmA5k+uWyzhp/1?=
 =?us-ascii?Q?f18R+ocKKzPr/iOChfuUJKB6goqcxkYhZUCtCNV/v6IOvRfC1BKuyeq1Ia/C?=
 =?us-ascii?Q?UOouimQwfm+6jobOqneRtOq/A0zXwqkXpBnGVC8l3elLB3Wrqv8Z1RD2EYdj?=
 =?us-ascii?Q?aU0iSGMsAhC6D2QxK6cuVFE6cfkvPymRYur7Re/6qRKCLmff5wz54sPW5nCM?=
 =?us-ascii?Q?Y2HkXQuywfEPPR4c+JOwGAuO6Y32A3klrjZQXCypYJpp0xVyEiSJ7w+XQ08V?=
 =?us-ascii?Q?11/HlnFF0JXFnltRibUgKJzkkjAF/i5UI8ddWXEroJXmsObptABwvxJgf0V1?=
 =?us-ascii?Q?RcCHMf+NLo0y7qN4oAb7YbhfpeSJ9yOstfdYkCxEKrNu3V5ZfAwgFGnIP9T/?=
 =?us-ascii?Q?r94i5ItSOb9hg5/ehZsnJVolpQNsM2Kl/N+dynlYXeSg9YpYPD8X2aDIirEN?=
 =?us-ascii?Q?zmS1wcIFwtUIiOOyFnATUgVkPN3Z6/QI+J7UhAPRl5c2oixsUB7jtY2ZW6U8?=
 =?us-ascii?Q?zPeq6EFchf545I7EvjB4+LY+h8xIcfV+Hy6jFu5m2Qci1Wd14yZKAO7QkAXZ?=
 =?us-ascii?Q?eFiq6xWhgYpIzcc81VmApE/A3oyU23zOsZQtnZxbUSp4Gv1nqIdntUf1YKs1?=
 =?us-ascii?Q?fwH/sY9w/DxipDc0eLLdhvhx7Q3MZp61sIf5uw9zwR7WqUL7vDDcWyBzWT31?=
 =?us-ascii?Q?s4YVwYiLvHKerm6Yl9AFmMBHddFZ55UO5xP9e1LS/fDf4nTCuK/9J7VY03/X?=
 =?us-ascii?Q?znvYnYsepAiME4DIfIvp3K0JNCa9rqCY/4IPtM25nPle+DN+liPM2TbVdVR6?=
 =?us-ascii?Q?AhnNSCPfNUjohhWKpMXAFL608xPRhmn4/9zTdqJJBIEthlIec6abqrE97xc1?=
 =?us-ascii?Q?qGDqe2VWqLK+c26qwjfdC0m7gIIt1R7Gfe4b2cf5COqFkAfM1KdCH5Cz4fWU?=
 =?us-ascii?Q?+nCh+n28uyGmTrCA03t5jXUlgW1osDNMyNp5HnRuKtmiUZqrLry+Xpcy7pMm?=
 =?us-ascii?Q?lekX9HMXGwu27AA/cK8v7O6gk7mfefdEn7CaqAeeakkg8uIZrX3t8LYG04/w?=
 =?us-ascii?Q?pzd0UcQ0eiNhfivv1f3nlsFb6F3tYeLlIRtJEMskMoav7xzxhgI6N7ZzXD+B?=
 =?us-ascii?Q?/SuKYfWoYSG3ZRUkQHu/Vja0muXEmCDus3EOjpP1HWx0dJWoZoh8LFEM7skG?=
 =?us-ascii?Q?v73+Ia+A2Bb+pnexvbeonC1vSuEfYSJuzKnlVP/llBczlltH8sbpLH4tHLBp?=
 =?us-ascii?Q?YpOdGrIfuRWEMfEF44MVztmtYhAzpmQuIx46FmCDHIC46HT07naHdzkeQz4y?=
 =?us-ascii?Q?V+ybtRnTjBLRB7fSlhRTNmapXoUjvW2+Qf7O7tgbvjQymw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hyk755nrZsF7ydnFO+TbfGphVyV81IKBHDJJkiIpaot8iUaU/Rz7yud6n74f?=
 =?us-ascii?Q?B7t04blrXn0NeNDl7PC10llEUhjyBRSKD6XRFhtdBgBvCUnV+tW8m0kCDhZD?=
 =?us-ascii?Q?meRZPVUMgYgjMFompSASLkHVmNJ+6nVVaQK5TeRbGj/rl3pmuPweEIdNViC+?=
 =?us-ascii?Q?8RkL2QTcCdBqa8wKR/kpLvs4l3bMuMREoGs2gXHDTlPTbyjWxF5sw/7MA3yT?=
 =?us-ascii?Q?lLBMNjQNBCAacLterfglkh3gs5vnrzUqUX9vdCKlFQujESbOM0fGRbMd6FmA?=
 =?us-ascii?Q?dSqnNQZFYUpotBp3xV+No5OuB7nh5t5AQG67YdwVmgE/NisbxBbuHf9/p3Dm?=
 =?us-ascii?Q?DUow+xtm7FkMnxe9Dsj7pr1fiQGzfhjVn/GIDdMdKRxQYa0HdTFz5IUXzm/p?=
 =?us-ascii?Q?0HvGEBfJDsAwHN81WRTDyDeV+QF5dHEEv0ozxTbpFlVE57hDJjbszKrBftLi?=
 =?us-ascii?Q?IEyWUUADX/qrNSaJ+sGEG3jEM1gNvThajUxogiHIRaDCEpfRUW0RdX4hpqGG?=
 =?us-ascii?Q?V0pPAeHypWUTr7rq5LRbcAuw7cbTBucKyNQFglEAOsddc0rexJoIdSDO/1Jb?=
 =?us-ascii?Q?LVlCJqv/FwKjgphAOQFFtyJLWDqR5LLeD27KVbT6iGBsHo0Kg9QGkPwd6i3r?=
 =?us-ascii?Q?mMx/gtI7WBRZxdcGfvKuZZt85EfTgOzmc2k8SuQ0QSMnxLzMVoLoaFox4Efy?=
 =?us-ascii?Q?DT71PYeyMAZFNqGi2/xl6TQ3mPVDgKcM37P04OzEzWSvZJ0P8BVQzG6xEguG?=
 =?us-ascii?Q?5XGsSBp3Qgxe+3e+f3+Boyc90A7jm46ovPu8DQnABeelKuhM4JaLPG3p/vg7?=
 =?us-ascii?Q?cWKUZrcOfWw5p3TKwWsbno/744oFBiACLubjMkp+miCaC3sQxpGBv8Txjhtw?=
 =?us-ascii?Q?lKY31MQG/qzVDTpnLsLQcMhFFoOrzsJSgn4m1ogcH5+RIM1p5nEQIcjw9Q/c?=
 =?us-ascii?Q?cneoMbkS12iLpRlKcxEAIDK7vZhzaKDsRmNmikLhGKp1y/Mp7ewdm01Az6f2?=
 =?us-ascii?Q?NNQMFjQgBEtenx/lzFZQ/4gLEOfA9a3llp6P1Y0Y3Ht5bPDDEw/ThjNmNgsz?=
 =?us-ascii?Q?nkOTjDhieExtTnjZS3PM8hFItz8Ip9KF1lZwODeRuZ/Tm12XnFO+DWD/ZciS?=
 =?us-ascii?Q?EvOfm0oRydIpJq5T47BLuRt5O6JXdRnoKCu9aHLShT3wF5aMr7Z1EhgvxHcH?=
 =?us-ascii?Q?wt66L9cEIzlW4KsqzD1YH5d11cB2iEXAt6OuogLx32d9w2oDBK0Qmgr8ok7C?=
 =?us-ascii?Q?SMdlQ5I6tiyyaZsMo2hElWvcrwzErZbAMrwNbmfyNvS0dCzzbQLHO6iI0l2w?=
 =?us-ascii?Q?QTl6LsmBpGAPaZW8f4ONbWZRvDQvQE2mNso+Fr/kSjHAeeeVyD/iAunhjBvQ?=
 =?us-ascii?Q?cRC/vZGuRvg9wN/W+7CYMeheOKrWza4EWRLz75igYk6cP3FQUaRC0IrUL9dH?=
 =?us-ascii?Q?V7YUlNFWVKAqZya5zXV5W4y+9wodG318jhYndlrq2hZKm5B+SK9nURM9BG/t?=
 =?us-ascii?Q?vjFkz6QFLvFjwfhMjtR2kYNtImnqxFbvbIZCthyXIvI9msFmF9/gEOk0FLnI?=
 =?us-ascii?Q?NQrFmztTKSqUJYwjVw4p+gkScK9xaR3vfcchpGn0RubiyIKpjJVngi0b7dpY?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OQdEPzxJVTwzNDY9hbkbJ2qCK9sgMFlN22FCioqMji1LB4KKEU1JwSVgZFZbTFfrujWCJmHi4nMR8EV5NCrFnZoqqeWRSqsLFs7wlv7SFdtIxWW1382nGtV9oEspZUmvlPkRmQP6yTJONnte04b7A1H1zXt2iJlsy4vB6+2G3XPc5MnTBfIFUmrxozH3Y4sYV+h7uzvqktrbSpmpUMcpz+GXgKdntqGyKldFPw4rbjvZ0WPsmASqaR1bWMCHUanbAE6jrpAQp5vklS22qSdojyfaPeYkUwl/ySFmloF0DCvQWl4q3oRaCnHFdwJqnjd2/qg3Ts9xSyr3ZZZLOOxMM0N30p4zGGzdbvDLSSLEG9OQq7RhMUy6WPPuoxPUVC6NNx/mZyxprTPYjKbJLacG2zu2geB+6QHVtJi0ek3FrXFTlf+ObmGavxdqNnsax5hNng2V7dbXbYGyvqtVBnS8TqvbhKq10KGXLMK1jza6SUkHSalRqM3e6MxKFzZ9sqW6luMOBFx0OUYi7dV9AVUepEIODZm1hw9Dhc66BOsZy6iPyw6kCU+yRAagY4edjBKbRfP2dbRQZREuFp37jTLFQZnSc11ZrQfEMgW2I+tyHZo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931fd1a6-b992-4b3b-deaa-08dd1b9297d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:24:18.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBu3rm9u6mD0Dp4kof9nOeSUuZCqB+LGf2DSo4SzPkIP79bsvj35qO5O9tQ0gfEIwMw+uSauPLMYwxYq2HgRTchkT3gia791DOegXcw/6bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_06,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=949 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130115
X-Proofpoint-ORIG-GUID: _PJRN8THy-Vu2iEJiPmsLRhfgAIiwRnW
X-Proofpoint-GUID: _PJRN8THy-Vu2iEJiPmsLRhfgAIiwRnW

Introduce demonstrative, basic, __mmap_region() test upon which we can base
further work upon moving forwards.

This simply asserts that mappings can be made and merges occur as expected.

As part of this change, fix the security_vm_enough_memory_mm() stub which
was previously incorrectly implemented.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma.c          | 53 ++++++++++++++++++++++++++++++++
 tools/testing/vma/vma_internal.h |  2 +-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 920fba58884e..04ab45e27fb8 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -1574,6 +1574,57 @@ static bool test_expand_only_mode(void)
 	return true;
 }
 
+static bool test_mmap_region_basic(void)
+{
+	struct mm_struct mm = {};
+	unsigned long addr;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	current->mm = &mm;
+
+	/* Map at 0x300000, length 0x3000. */
+	addr = __mmap_region(NULL, 0x300000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x300, NULL);
+	ASSERT_EQ(addr, 0x300000);
+
+	/* Map at 0x250000, length 0x3000. */
+	addr = __mmap_region(NULL, 0x250000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x250, NULL);
+	ASSERT_EQ(addr, 0x250000);
+
+	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
+	addr = __mmap_region(NULL, 0x303000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x303, NULL);
+	ASSERT_EQ(addr, 0x303000);
+
+	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
+	addr = __mmap_region(NULL, 0x24d000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x24d, NULL);
+	ASSERT_EQ(addr, 0x24d000);
+
+	ASSERT_EQ(mm.map_count, 2);
+
+	for_each_vma(vmi, vma) {
+		if (vma->vm_start == 0x300000) {
+			ASSERT_EQ(vma->vm_end, 0x306000);
+			ASSERT_EQ(vma->vm_pgoff, 0x300);
+		} else if (vma->vm_start == 0x24d000) {
+			ASSERT_EQ(vma->vm_end, 0x253000);
+			ASSERT_EQ(vma->vm_pgoff, 0x24d);
+		} else {
+			ASSERT_FALSE(true);
+		}
+	}
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
 int main(void)
 {
 	int num_tests = 0, num_fail = 0;
@@ -1607,6 +1658,8 @@ int main(void)
 	TEST(copy_vma);
 	TEST(expand_only_mode);
 
+	TEST(mmap_region_basic);
+
 #undef TEST
 
 	printf("%d tests run, %d passed, %d failed.\n",
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 3eeb1317cc69..86f958608645 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -985,7 +985,7 @@ static inline bool is_file_hugepages(struct file *)
 
 static inline int security_vm_enough_memory_mm(struct mm_struct *, long)
 {
-	return true;
+	return 0;
 }
 
 static inline bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long)
-- 
2.47.1


