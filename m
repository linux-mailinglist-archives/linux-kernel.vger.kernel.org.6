Return-Path: <linux-kernel+bounces-308005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77DE965615
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF162885D3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C65D14A601;
	Fri, 30 Aug 2024 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SzoZ56Te";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="doMnEIvS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81F139D1E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990489; cv=fail; b=tkFwRMsQzUpgFIIyBLegQRNePzkpOb38z8tcc4dhZlDkoETk1yY8iQw/U1fXiPEZTYOwtxda9om7hfuJ37+SQIRGr4yrSeD5L0270Qmcgu7PMxXkSdiS4csbYTfyteQB8wHrd5hGBmrIljKyD8nYNOF9z8z7hsoQOi2r316fPbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990489; c=relaxed/simple;
	bh=BqQz40OqzPtGsqK+chLoMHo9IBeOINIsNRURO7HunHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smtzhgahNQ1Yl952WbNf2e7ZYWQByuVljsTwVpuus1DsVtjxPtP62i9GVW/lht5OQaaq0ovqSxN28hUsf3bA/ZoE8tDdfLos5nCTuGlyPlohRE+Egg1KQPgOJ2fMpJrT2Rc+8jkirlgCO4t+hUqLAIk44BoKed5D3/YdCEgaghg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SzoZ56Te; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=doMnEIvS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2fnwk000993;
	Fri, 30 Aug 2024 04:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+SgEZNii7vamI+Wr52WRA094htKGd868kPJiAHCbwa0=; b=
	SzoZ56TeDcjmyiefwjGSMryqu7MQErLbMdsOW8GzGZwOX4bDtMNhxqyyUtGFZBQ6
	C8Lg1HHOuhEbesQMRsKSOAUTwrz067Rjgtj3q8rOZz51lO2T77WAJh72QP9hy4nV
	zHvLr5OQheNlfNspNi3ueDgxkkgQDD0ibd+1dCjOZQHVeVrpHsOo6IPSwE4FNmv6
	o7wdVvvXmholE5B0WJiyfnYMf+kK3SOVSDS24BGkC0wYTd187KtD610QBfY7CazK
	YmKw+FMdVZEUZ5fOd5vMZ9zzkLgg/WkdiLtgXzSUromS1Q9u39fm7ntBiPRIJ1tW
	B66iuhZdTX5aI0dn7zlwJw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41ax0grrgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2Cu6V034855;
	Fri, 30 Aug 2024 04:01:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189swukex-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXhVpMwjWbONTYNn6T3Mau0KxOUK2fXthg4FHwxbDK9AH5GKfy4RC1JzSDHhmiGiLpXZUG5q3xHGNVkTxjjSGglvIDE584SHCdTvlZOduh7wIC25P44yE+z8vtuTxLypDrblDlmDATfgT+F/MkXsd1rXqO7Z7V4wE6YxNky3RolUc7JhpoF0phzcqzoANlwAjpR+PGXzhkNEQZhJdFTQp/9KHtiL/9MD/ksXBgVfHcnrT0i2PhvqbpBAWXzuRRS8a5Z4El3apXjoWWv5Atd5Jkkli5mSLxDNu3jPhIN8FreEjcG0CI1O8DJGn7vehSRu0oTnv7t8xzrGmuHYS4qBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SgEZNii7vamI+Wr52WRA094htKGd868kPJiAHCbwa0=;
 b=CuS9pIJDhGy3ddwvsPR1KPxdGhsUjYkMZ7kFWctJDhp6V70nT0IhhauLkW2Mu4AE45M/UE+lzu73nNZom2fvs+vTQ2BTSFch5vOjtPSXQf00HDo16eNgKLD87cixL18QnWizUbmFVEr3A61snDiZklOVWoAANweLsetat5ZJ5EfpRH/Y9/wZxX2WTqrAxYlczA7FbJnhNgXFacgj4RqUaSDmW+ux395AZY384mAx9czHyBweq7mtzxr6BtgPeYHk8aVvAYB5PEoqqzWN9grKhUtpH/Ehs2/TiM46DlGBrNaN9+AdI4pOmWrKLNPcUa+zYu4wXMSYu9SA5pAuSaQACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SgEZNii7vamI+Wr52WRA094htKGd868kPJiAHCbwa0=;
 b=doMnEIvSHBC3dkgZa1CTq7gC2Etx6A2SKNHDGCyDIer7hyLaCd8aKX8ipNZ0PGTW1SvLACnZCDm1QMt/6aT7Y2t9up6olBQcAUADyf3u2ixmWgQwWA3LAyoqpSMafM8rt+2HlJt+GDAXkS+8k/rPEBZ6THP2ZaUqgk1El3P623E=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:07 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:07 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v8 01/21] mm/vma: Correctly position vma_iterator in __split_vma()
Date: Fri, 30 Aug 2024 00:00:41 -0400
Message-ID: <20240830040101.822209-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0427.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 4599cd62-f987-48aa-1bbb-08dcc8a86068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cdi1d+3b2GiFa+Aki9HeSVO4uJSmuhVIduatZgXJ+ed74BQeOkLwPS4guWaQ?=
 =?us-ascii?Q?S1vR412SAIDz7YAz/lZKHmHKIwHc24yG2bEd357pDe1IFb4JuCpWk6OCIXHb?=
 =?us-ascii?Q?7sG/YOlAsOiQipXbJB0q5ga0an0YanQSpOx/paqoE0grDGQr+I+XPQceMjZZ?=
 =?us-ascii?Q?kSTICLf7TDQxg/hYGSA8f3tmKpYBpxt2XWJja4Uy0zBj+CUqkUyKXernSoI9?=
 =?us-ascii?Q?GwkF13UVy87mODr1g5rAhE1Y235mAGqOzKZ/4DGjm2daoDQu/+jGW31kSxR9?=
 =?us-ascii?Q?85lJGOU7m99huiOX/GW0WnDA+MsLlMYkdLd+LqJRn6ePi0HUIs9LK17A0Idd?=
 =?us-ascii?Q?IQgxcR+pPZO4TLWjccnINIRYpABmquPWDWdWHwDjfzDOqdTJsXlPXF5/3EBv?=
 =?us-ascii?Q?L7WEmo7C2TTVaTfk6OUMq3SP2Kd9G/B4xIC4wVaj92uO48CPJVwD3eVLNILL?=
 =?us-ascii?Q?1t/O3JdxHP2oiAXkuZPHlWyYeHbrZLYLLQqDnIIdacazevW8Zu7D8CeSjxxR?=
 =?us-ascii?Q?MRhoSJjgctXY/jww9eIfRCE3ryep36fgf8P+yjO2LUS7xF4C7O84YKm+/+sX?=
 =?us-ascii?Q?+aW7YmEjIiPWNc85qFow+g+c6+irt20rYkAKSAZQLQa7PEbUOb4o97AdXrbQ?=
 =?us-ascii?Q?hLAGHJ1ii2l0S00vjSQzfLTuuYYjesYhk8dzpj4FG1ueo+3WjbOhlqEVYTWW?=
 =?us-ascii?Q?DWMuvBno+S+hoJ9A/J+llB5ANJRQnDCr5/5lASIf9k+DkbJ9qFGA9ontHZFI?=
 =?us-ascii?Q?HyiPmACj6g6YwkXjqAvcxxjT3KfkrK+5ZyEsutdQikLTjQ8Rro16ekaTrUFS?=
 =?us-ascii?Q?N+VpEcAHpcBwebaGKIPrMT1W5OuAj8g/NEg7eC68Fv+gTspaqR5p1Vmewfqi?=
 =?us-ascii?Q?3LFjUGhsnGXYhfWkscKmFMu2KQTIbnJXUvPTc+F1m5IyXBWl/ahKggZk/fVL?=
 =?us-ascii?Q?UJYDk+FzksqrmRRvRwrnYQ8uLKvI46Hp92P+RCJwWXNQeQz0ves3m4JbjFgE?=
 =?us-ascii?Q?sEkL/NME2c0PE9D+UX/eMHhgtVjOR7FHnwf+ws3EEUAvYW3xjnB+qp9r7h2u?=
 =?us-ascii?Q?F1P2/OiRNzM3DH6N3sy1DaNxYQE2UbmhZqe2KCQsXJK/SnyfQ6vhkXdsTSi4?=
 =?us-ascii?Q?w5WlgHcueHqc7fD3xA6zn6rGHQmrsPX266R6MQQzxXMBarRsPUadvXhakFjF?=
 =?us-ascii?Q?fSKoZ/aKn+2aN1GIYe5PVPBoGgJ5WcywGhT/tPt19Sy2n6DLFA0qqo0jXRXO?=
 =?us-ascii?Q?8kqsPtuo4neiYuGilszUTmCHwEzDhXHAPLfgV5VOBIhgKlpGZ3ThAWIekrcf?=
 =?us-ascii?Q?tkJCR2AyhwmMnuC/jDIMAZOGT/Wv+mofeXKJI0do3hiwCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z4q4is07N4vxl+rj/O5sIbPPGcuI6Yvk2wjrfV5CQO6wCw8j9ENEswoLrgkf?=
 =?us-ascii?Q?IbThVbKnVBMOg9NpTCCL2yEOaaMxcmw6mMdg7y1CrfLiYw2hkScqFgLCj0Oq?=
 =?us-ascii?Q?f4alvbo90q8TS8u/oV1skZjLJti+TZ+HGVJyF0hjmndX0KKmlgYVWIJyMcSR?=
 =?us-ascii?Q?TEAj3zK5n52e1bUndrLd2D15Eowk9fb3x/zT0JUrvLUmnFr4USLxHpO3GhrX?=
 =?us-ascii?Q?v0t0PxYSqFYdMQGZFM9Kd8MoXbW5iENCk3s4i/gvkz7fH4KyhUGT6+rh7mul?=
 =?us-ascii?Q?hAX56tyiCcB9zjrscXlubQn7D/3iy+dle5OiIojh13r77vhm5hcvLblThiju?=
 =?us-ascii?Q?LJ985uCDKVj20mpQvKUh5rOH0ahIxBkmzV50ljnFhv2loGsgaAfbp39XLYL7?=
 =?us-ascii?Q?uXNJIzp42NpsW3VAURjRsnNhWeezXHhpz9t5vB33cdxbS3OCP4zsiMWUbXIQ?=
 =?us-ascii?Q?twen7THFG/fIgDl1ptCqL8/IMpyvdyFGgUi4jSO5h/FHbTy/sXXHWeQsUcC5?=
 =?us-ascii?Q?1UakBpCnrYy9alRguaYk0frcnEJt+a35u9Bw6us8NnbbRstPI7a06TqBGnRA?=
 =?us-ascii?Q?QB7bEC47VteJY5JO3q5wAHseKU1WArlnNUXS+yzST5pjlQGojXZ0rrDk12SR?=
 =?us-ascii?Q?RmrTxxaYL9PIDtcTUYpMTRzDAl5jUw7vSOj1bfpdSJ2hAygsxeKbUffHrdH2?=
 =?us-ascii?Q?OkIAF+N70FMyFeQlXASwxxNy6Xtvcpn95B8cUpCMwYtKkRgCeInuvZp8QnI7?=
 =?us-ascii?Q?Cu5I4lzwzEuV4ZjuU//ecv6OmV9lV/EJBHm8+IkV3WqbmaxPbI2mzFhR64Ps?=
 =?us-ascii?Q?HDJiifTdlzTjbeLfqYOazvKnPdepswvE3SoFeLFKbGqSqqJp1/oWDr75zwSN?=
 =?us-ascii?Q?uzAb5hot9zN0BqXhnmTq8FpsJythB43LUXcFhk6mTNhiIog9eKf2ILfnRC4v?=
 =?us-ascii?Q?jdOzvETrxEYxP1sYtxvsuxnIOrNfd6eJ1z/U8SinEWlIu6RXJudYVwgRREbX?=
 =?us-ascii?Q?nZH4Ndiv6nAzGpDRWtECKiPRscFUVPE/Czo7jv1zxjFpOIhFo+pky0lUD5pY?=
 =?us-ascii?Q?5at9GHckssLjXH+XekueK757sVKnk+GGrYxUToGzAe2BsGIHzcucLKPWMcQI?=
 =?us-ascii?Q?2QSXV0OxRE+WQsgnSpu9SUgaN5zoFX3Ylmk/XDyWa1zFAw/LtsV8/wogWcZf?=
 =?us-ascii?Q?BFX/ZO+mr2+MG4nYf9+pLNVGXo8YOJ/lYX12QievQMy1dEIw9/JKOlufCgir?=
 =?us-ascii?Q?zBfIwrRuO+drjmFCUdqwWkZCVW98myU4yMbQURHyzDP1oBb/7rRMeFsaar+i?=
 =?us-ascii?Q?ZWYHXvvoNKlO9oDyUdPxYHzNmVQ0DN1xrJy19YiBY9aPgqb7x6g47LMfNbI1?=
 =?us-ascii?Q?KvQx4ZGOb9eI0U4fWCW+OzMcIkDhCHvfKIV4qF1uUKbIqsvaItGW+IvrNNdl?=
 =?us-ascii?Q?Z2arKoKrhVSSySahvmydQQnZzOJsU84KdQ8cJ2xG3VccG0C82R5SnJYYTs3S?=
 =?us-ascii?Q?3Zz+8opslK4UnLMAMJkh580vlcqx7jF/yzihjvfB98pdGzmQh0NzV3LHdVM7?=
 =?us-ascii?Q?am1mzfjqQUr9u4sLHa2h62oKtHVlzlmTbNBx6Guz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gR7uJof7Mk6dSMRPBvRJkABPXZULKGV0eSXf0Yd+LOniw9/sFOjtJQX9okDQyTtjHfK8eD6UUnhH4irHg31M3zvExs9+DWz3nTceghRxhM2AorYmmoJGBM4ARScmheT+1MG3PXawuHjNqEPK5eDycgPNch7H0tubUMtILhpGQwZYVInbkw2dRxpCeKaHQmeYRw57lWno/qNsnzQUkm/FNjw5wk7Vus/rXaP9t8gBZI8dmBM956m/PjUKAyZdNHPCMS1Q2lOUDTY+AGvD3YKIwHaRI2h8CVX4SJtXWhUJk7ddyANF9zG4TuSkNUFhMkUi+q7o8GUzbehT99Ag6P5LO0qm/B8zdhm0/qgHpG5cKMAA3BLH0oqJYl9xFR+kLiC+b9fVvcOMGKp5RPH12LiJm1RggAjLhbdUWLwrl/khyBU1dL0nGNm+89T3GQLuU/S5UDhE7D2YqWKv5Zfc8VGuEKCFBHCMGunaTgSHRdXRD5GfFD2JZga+Uj8gcXMMRFAm2hp3no/0BWD5sN1O3cG0335bNAUKSQyjGlhlcI9u0OzlyZM5QU79OTnrVH7oSMlQzi6WogLssGCJoDditDTkGH9BKQ/FLgY+XIvaJbUhk8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4599cd62-f987-48aa-1bbb-08dcc8a86068
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:07.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1dUxOCqWeCZHSUwaV/lazS62WN6f1kfK6QFwEZuoxKShqxuyKjDu8vl1ho5OhtYYrkPjSfocLxgx7ZtTE/O/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: 10gfR9VdhwdVEU9Jc4MIXMsiPYNdQyJY
X-Proofpoint-ORIG-GUID: 10gfR9VdhwdVEU9Jc4MIXMsiPYNdQyJY

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/vma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 5850f7c0949b..066de79b7b73 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -177,7 +177,7 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
- * VMA Iterator will point to the end VMA.
+ * VMA Iterator will point to the original VMA.
  */
 static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long addr, int new_below)
@@ -246,6 +246,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;
 
 out_free_mpol:
-- 
2.43.0


