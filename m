Return-Path: <linux-kernel+bounces-294697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD4959171
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12601C20C97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E01C9DEB;
	Tue, 20 Aug 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nv4quwBW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dez7pu40"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D211C8FDE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198293; cv=fail; b=DFL4QWBEZoCYyhdwo7B/7mSTVNA5dTk0Z5ouP/36NE4O+KOmjt5ekOz5fLE54Walj946XFYzrvuIDvePPFpx2q7m8krfYQVaDLYZq0kXtsXQB+WSIgE906ak/gn5zYGCBBM+0eQbftq7hfPvZOfVqbxFSpInCoPQzgstFSQODpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198293; c=relaxed/simple;
	bh=VOUDrA/3pOEobvQHsjhY4Mw0X+i5TXp10gtl99DoZVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUb8RuyDQ4sS5g7VilSyxcCu41tl6ETBU+VJhS2JsyAijgJ915Qlf7/yj96vb29e9C0f1JlzU+JN51Vtvg2x6tucszzjfOepQQPgANJnMlZf2LsNsCKXOM9pC0Slo/uD7Sbc2rWxFmVRwLZSZFcF6Byvw0O2wk/EyLguVODVc10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nv4quwBW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dez7pu40; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBb5f017828;
	Tue, 20 Aug 2024 23:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=WZRaFvqKhmeZGOgIn0cNM+Fo1hKAtKZhH+jC5oCYViw=; b=
	nv4quwBWD7pYdG94/GKZ9vqqN6RPoLz6xpPBU6kv5jyZmhNsQcyL/PK6vCroKYQy
	wOo/molDKmTukHp8iaVzEEcVtv2cr7F3vpGXnCFSN/FxAx4P4OU7upsXt0U6Jx0m
	D0xBcvVlLsyE3AoMuDcV125aSWc+wUrV5gUnZKd9Bh04a6vE2txRP5XAtcQRlCB/
	PTN70I4vqz/3HF9ImMUMiFEmT15sFUwiOX3X0NKSAm8I5PtpJjGxaluFA0iP8NMh
	bwPuEsInVG1nza7bsZlWw744ewJEEWO9zN0/DNDLVx9kD3hJzrmgQkVy5Km9u7+i
	i4WEely3orQl/pGksGIK2Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdsxagh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:57:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNY6L8023532;
	Tue, 20 Aug 2024 23:57:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154x78fsn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:57:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/OmLi9P0va2F5nd4IcG02exAbXdDsTBO03FASM2uO9ue1kC0za0qxaJdQk2wx0Hw8AM6whQ+Igx8dElJBfDjuqa1PtZe47+vY+w7ktsCvnHVzQC55PyPtgl3RG6IcmvUE27pAU8ArGAjsxwi6GsRuQzP2IUijptbMi6Ey35lvUr1jWj8jMseKB4QnVOTAQnnjAHJ6Ya52UzoidxqrzImJn2OUVTY1d9zz1KYRsgVJ3l96bSE0hqV8RGV8puDHgk+yVjkDhAKOY1g7Ue2mQeZPbpBpgLpxi3AQ/BZ6JMrtRcI5Pmq5iFVCN4x8jWdfm7w3QJ4108zUbFIZHmWgVPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZRaFvqKhmeZGOgIn0cNM+Fo1hKAtKZhH+jC5oCYViw=;
 b=XdjZ1IgTrSvQwfWJB5JRNf3nFehT+KVzrWi5m/iJFs0pXzfQFxiwFKpEmvDM4uBJI4pOgjQugOSQH+KC5SKu2SW0MbzBJ78RGd4DrnaZXclauc+Xom3+Yww3q5SFE242UKOctVr+BoDDJu7HEBfYLicb846UGxxSFiXKwIxdg5WpEmyHRblFGSYZYeqPa7DpBQLtTTcZ62Sk7tHmeT7RzgJTwpTYJ/y2XGqU2jAx1hYYsHKmFPh1Ou/YkWlxUu2qZe7OEUtiRZP++y0CZoGuzzBjE48Ho/nBVniNy+oeGVo2bQXal4/1Qs5k1IAWqidAD0QiI8coPBxOYqp85RoSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZRaFvqKhmeZGOgIn0cNM+Fo1hKAtKZhH+jC5oCYViw=;
 b=Dez7pu40Oe1FtiBVWEkDQA9IVFsMkVi0nD6RCxcjjHQ/YqkxhfgfP4mycBtTm2wQaW4UrYMRaCYUKdExWpk6zSFMFSHi4XQkNjwYUWWBIyIIAsQy+y0tNgqAq54TRIgyQLV9dJeWJY8HGdYA8lVuhWwX79wcJpUNLj+3C7Q23a4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:57:52 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:57:51 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v6 02/20] mm/vma: Introduce abort_munmap_vmas()
Date: Tue, 20 Aug 2024 19:57:11 -0400
Message-ID: <20240820235730.2852400-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0189.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c9c907-2a0b-472e-6f23-08dcc173e69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LKFzCz3SrF4Wc1UIFCCAkva8PqQhG2LZurC3Sqvp5DdChyZkaaRG1uODbNSk?=
 =?us-ascii?Q?5DGHLbYAIXIlGeoCdWn97an0qZ1/M17lRMqCrLq55qxxmuPPLgp/OuzmM+pd?=
 =?us-ascii?Q?VW8/+ov3fJTAiy6hbGr6AhMgMkiKo5fb9ICtbW/nCHSVzYIQU4IHEaUMuMTA?=
 =?us-ascii?Q?SnJ0DkWrd2+18yuv9xCP79pbMOV6pME8vmi+VUD+zhJKVIPw2Q2o8GE2iP03?=
 =?us-ascii?Q?go+nGkvgc0n/CIdSzl/u2ULURZOsTbxd+nb0cGr9v3SORLDuPmI2NgPv2DIQ?=
 =?us-ascii?Q?gKuYJLSbElcVfPABF/Qt+zIr/EGCiHCPR9wk+lttPjYWnE/p/VY3opd4IBOK?=
 =?us-ascii?Q?BC/Qtspb7+jyqfEmtGbFa8jmbz0WOpZAtG4/S4fPRXh4MaE4V3QmEdqXHbt1?=
 =?us-ascii?Q?x98VIhIZpW0lRSfhG62m7JDeMs402rtunb0FHI9o4CApvp6UY3gdo8N7IBq1?=
 =?us-ascii?Q?3mOQwAwlRzit2+BBwbLbuuiptpptBGCb0NieS55/3opFGaX4BG0b53c0fVoB?=
 =?us-ascii?Q?kD6nRw73RQxWwnbFtOzulff/5dSeGG6d56i4BdWxHXpvznjmvc90RDuOZ5Uh?=
 =?us-ascii?Q?sFQFLpJfs1tZezIliT+YbpeA9anybjbxf1i8gdTDbcd0rAIm1DGY4Zr8RCtD?=
 =?us-ascii?Q?9fBlRQpq7uUZI/+WCTEuvEDrlZmRUnlz1BX//3fFWaiWNKkqgTcKM1RimQa5?=
 =?us-ascii?Q?DNT4cUcalOJrCKUE9QMO98LBkhkNR7q+GjeLKOWDbXB9BzW2ff6iAYWXw15p?=
 =?us-ascii?Q?yBgDSD7jH14AwKHIZK/sokLx745YfWp7m3MB84xSdhmbShIChBp4o/k+/2iT?=
 =?us-ascii?Q?aht8dBzumTe4GfuxSrfVBpgTCeLKvLlS/9/OyLKCxjCya9DVlSg5vvGlBtQP?=
 =?us-ascii?Q?xlPjzY0M6Q17aDalsbbDUNR/x8/ZG9ZeNR04e1+pELlXLyiJnK7gtZRv+sM+?=
 =?us-ascii?Q?J+ZKVeCHmcTl8SXu2Oc0pdVyVgxkUejI74zIKSx3rF/aFUJjHO3WdrL7CoZb?=
 =?us-ascii?Q?XgcN0efPS1KXy5IRqF4I3p36uEeUj3awbcNNql9MRmOb8UA/veBncu/Jyw4K?=
 =?us-ascii?Q?IcmnohlE+6SMqDMliKsOWFxpA+f7G+TD3ygu6o6bUimWMrvyU9PHBExWg54V?=
 =?us-ascii?Q?ocr/WaQyTl6VCryyxulgn/Wm4iukWLc51b+FjKMOCf8yIFxPQvHmO1LVGLCf?=
 =?us-ascii?Q?U9YOQ4999L4jtSRpAsD464Ze4X58w/c11rYhiYWeNdEOoZbXS9aR3nfHtCFY?=
 =?us-ascii?Q?ims1TkL2Iv6fx3xSqWmhbJOiHzQ2ETBDjKMNCzEdkE0ccbREzeArT2cGflVN?=
 =?us-ascii?Q?gBExKYuk6qQ0WCPdLQiC+KgvXo69yeZgHa53AQKyCuRGgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WAdoOczHvFH2En/0a5/ul/ZAgvbX8GCjsoqw9ssoxqrbQoWiJddgRrX0IeEf?=
 =?us-ascii?Q?Rr+yyntId43Z6JTic5cl3AKytDmrM7yr5r4QajDtU4ksn8wtF0FHG3TFZKp3?=
 =?us-ascii?Q?vCERVt+YHC/y5/XYsxkRIPtZh2tvvVzD5PiWeCPupNpJXHXsWOUi+6Yc0t0m?=
 =?us-ascii?Q?vw3oLXWdxaY9yB/e4mwTvXMkkT1tiCJJLEqqqLWxJSLQwPKE+ZhOwBfBD0CN?=
 =?us-ascii?Q?AGJvhBLKStagMA675z+dCdPN8RzuJ60B1fKJpUfxYN8WnA8fUNjHCqfq/fs4?=
 =?us-ascii?Q?qUvvyIViDmRt+VcN/+8X1IQjdobSW0Ew7xkPStusbHpC9Gm4P9q42Rc9DkDL?=
 =?us-ascii?Q?5Wocj8nfZmrXSVGcyAGHOOauXEec0huay9EF+QmxyURyXsBdfuuLQEaVHIQ5?=
 =?us-ascii?Q?MoaZJcEC1JturE83iZP0Lt5hHAcuUC1s3FNuPgq6rrkx2b44o1I+X6T1pmeu?=
 =?us-ascii?Q?DdoYYXaNyPMeS+CgHG+2jR5TnmCgcNpDf0ZfKKK917C9uF6pii7Dgdb8qyC8?=
 =?us-ascii?Q?iVevbbOUk2hiPqVHowFp39C4oLIS6BzcXjucjoGb1AJ1zusRlzh5g3Jj00ni?=
 =?us-ascii?Q?2fMSXuzaAWmdZwy+A3+ER7GVV76zFXbkqjPiJs4gOE7NsJOhPhSzZaXvJnIX?=
 =?us-ascii?Q?5aDj6Jn+j/urPWTPccGRoRepuRI5J+PUrfvksB4q6OH5sRnFP2OKYRw6ZWT3?=
 =?us-ascii?Q?FNMCpmxcAWmYjtzxnvHscg3VqgHhz9vTiPn3D/zR2y2BM8dayUVVjf/uta2g?=
 =?us-ascii?Q?kVsVQT5VTtKhc0fHuBDZEw9iZJ2mVO9qooC8MCUcwe0Qr1VUxM/uzDOpHbhi?=
 =?us-ascii?Q?tik/rLAXZ7DihdXKxdMo/SjQd4lyyBIYq9Ss1qkkSHc+VG4a1iw9gkeqFeoT?=
 =?us-ascii?Q?lAqYXQCaZZ5Y42deYiQYVtYACvTLIrphk8WFW8/R6unTkpDpp/RJG6hB1dlj?=
 =?us-ascii?Q?20fJHQ5SE2rcvzKdmxID5U5gMsNfKtgtsbEorjBMAbp6k5ry/C95dpo0p8LW?=
 =?us-ascii?Q?3DaCMoL+CFkXuJfCrxslE5rKfBZ56LWCSZIZfF5CVXXyac2nemOMaIXd5s9t?=
 =?us-ascii?Q?lacamVH9aPPChlDHaNmU8M0sygbv5pzgvkcGcUa9NwX+ia36FZRCKvABob6Z?=
 =?us-ascii?Q?xA74UCRmUHhnSi/RsXiton8mTZquGFT+BkMF0/bHx5ZdL7mhP06/swMWSHTG?=
 =?us-ascii?Q?riBr3XZGOOgqGj0tYWna2Fh8YQ0wDvneC5gudE3Puf2aOrSeXhbPVO5E0kRJ?=
 =?us-ascii?Q?06yStRhlBhIL3X1P9Q/wOQkD8Tkomo5gC07pQWfQ7skUoqyLB2PzSKa20HtQ?=
 =?us-ascii?Q?+u1f81wBg1ZS228hhunqMeatWdZl79k5syu5oCOqNfj9fxiwjH3v6zp8ayQH?=
 =?us-ascii?Q?kfwpTwOAdFpT7odshF89c4zKipN/jh8o0S2g7QWRJhRE9derpvH4/d2/jUBp?=
 =?us-ascii?Q?csdzVbEslzBwPoHjpgviGKNDL5SmEmkyVC4wlfMmCUZqhxuC8ebIjvVNlaq+?=
 =?us-ascii?Q?Wg+QLcmQ1WTkylC4nzgrBff1SMHBlfWqVFqU0rBHFDSuJxqhj8NDAtEUiMt+?=
 =?us-ascii?Q?OF+RRWgTMhFWVQbWTkxBAlldOWP0Af6l/rvWiujL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MKf4s3w6D3PXoHQocLQ2G92NVArKk1yOMMqzosenk+a7wgZdr3axDXUk7Shgk7N3PC0OcOg9HyPX4DtK6kodcNgHUnNAvwrF/yrZ0Tq8pNZ5xyjNbo2KYXHOx29YXjZjvPThH7OxAIdRziyzQsfkbG6lkxcrFJF9mtCkCPyCSd0t6CW+m/nH8tnqGAdy4tUTmgZMLeGtSRjYvA4skjr8/ghbVKNilb6Qir+/syaN5Uo/Nq4BlW+niIq63Chh3lW2S1oG7+yIGoN2UhKmQcfPJHuomARnLRoM66/3PgSmeg20fYR5ATqRjYmHkUmL4i4TABFbstkXjmd6+NzwuOwqqPB+Sd1vHjEtcjq0QUS8LOo97nRSSaDyItUXItTOH6OPie0vz3uUeuaSV5QD9wK49/+glOBENbPOCjn5fetT3K2WuwQkZYzJDca+BGN432vCoobpLBXQZuNv8lQBlOLEgjn6q3Yb71dD7+274CX7/rqYqCeXXz3uZoXzlLqOdbVR3sgXizHr5YRBZoJyDu7YJXEQtNH22Hd/ZFqvNlBO//vIH8HWR4mhAD99P4pchRwpE0mfJkZcpd0+QmUC/txmlO3S9sA4pu0RHveusFNPZfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c9c907-2a0b-472e-6f23-08dcc173e69d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:57:51.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktSLuLHdDSJEAbZA5LCGvm1M1jFQXlS/s7d6yy6L//GdhyMgxuUGDaY10eOeiGZaz64Z4Usqjc8nNtFuxcHIIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: NTcSUdwHOlOBrs8MHd0DWvugJDpDi-Sw
X-Proofpoint-GUID: NTcSUdwHOlOBrs8MHd0DWvugJDpDi-Sw

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Extract clean up of failed munmap() operations from
do_vmi_align_munmap().  This simplifies later patches in the series.

It is worth noting that the mas_for_each() loop now has a different
upper limit.  This should not change the number of vmas visited for
reattaching to the main vma tree (mm_mt), as all vmas are reattached in
both scenarios.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 066de79b7b73..58ecd447670d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -668,6 +668,22 @@ void vma_complete(struct vma_prepare *vp,
 	validate_mm(mm);
 }
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -834,11 +850,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
-
-	__mt_destroy(&mt_detach);
+	abort_munmap_vmas(&mas_detach);
 start_split_failed:
 map_count_exceeded:
 	validate_mm(mm);
-- 
2.43.0


