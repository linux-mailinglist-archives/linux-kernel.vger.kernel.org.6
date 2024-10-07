Return-Path: <linux-kernel+bounces-353231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490CB992AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFEBB240D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0A1D1319;
	Mon,  7 Oct 2024 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z2BhB0mH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BOt/vk8x"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5418A6AD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302043; cv=fail; b=BwuV3OvGO2q2MpSd6bFCX0Age+j5sj0sNLuKL/MEAyBbjE5OWVu5T7hVYDs5tHnpiCzpruq9/ijn8TXLkcLAcnL36nVEmZvS7sYUJVXd0fWgmIMdR4/Tl+IgqmCQhTsO7evwmuqhYEFs8RKsVy7+fAI9fQjy+RdF0trw4lVfnew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302043; c=relaxed/simple;
	bh=0vpbdQtRnYDRlD9L568b70rHhbA/akwp7yxdsJusPyg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KmOg/YzlWrJB+ZN05+LVL/v2APaKvzuKRqbVLcmN+cAJcf0NCReXlMz0Qm6wIlOjY6IDaRggw+4C7KUEquklx+5lttQ1KY1MHS3VozawQx0FRDQ53ewHRzh3bbw26NkfoX+n/GZ0H3CE8Yo6lgb/EcvKbnNCK87P1Z1vefGbBLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z2BhB0mH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BOt/vk8x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4976faNr023986;
	Mon, 7 Oct 2024 11:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=gb59LByXz0/7L7Ry
	RbR944w57LjKj+luVJzmN09EXJg=; b=Z2BhB0mH2hg3drjAuagnwn1sPRH7xdOa
	pH44+uYhg5/rZLYvFpK5MV9gn7dnbhNfZ3fIgqf8sWoLF/oaWEu08l4YtDa6+icv
	QAxZJlUcRhA9KBnF6dggRvpW9Zre3M1xHjsG6hyJs5JDiZH6oAQ+OEqfe09/ITaf
	5YN3cOL+MREhY0BBiBgGHahFT4f9n6sRacjogbChdRcxQMqAu/yNE7d2dgz1yn0y
	uhVSwsdtCLd3xHGv6brGc88SLILVIP702J3TIZC+DgeWquJlzjZpCOagLhXCyhTU
	j0Xav9Jr1WMRFlIov/edPv2qork4WSiyRh/ELd6Alq7E1dIpTQMyxw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034jqdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 11:53:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497AVYar011678;
	Mon, 7 Oct 2024 11:53:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw5n729-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 11:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqobIkrc+C5Bm3B7OXLdrwzyfkeUoI/6WQxqP24DB7NMgvh8DJVbCmT0RNWZ83pMz7tUxDAHasyJgm3xkKQS0dOGEMBPpkc1xRtpewnKLnNUsQDK9Qrb/qBdSNpU2gKq1IbRz2ZT5ODlxfnXfGOybUwwnNa/ViNlZQjJ2YwO4ggX2RkeufJpLrqk8SdSgTGr8Usk72xSAFV3nJ2wIbXFq4WLmFu8ToDva9cS7eA+rQDpM0VeRhNR6PiICl40S8IyrTCZHPh3EhwdMBnQvDf7avpLBfD/7KojkRVf5SYygOibQ5qaGiRcAd5S7uhX5aO3JwMzvvqTSHG09+lzblOs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb59LByXz0/7L7RyRbR944w57LjKj+luVJzmN09EXJg=;
 b=t7VNA+gvQhdv7PAnHxbL91AhB9fZIt/0ABgX5t4seoJmq0GMjUcfMpuWvEok0P9CualoB7cBosltQOSUMkcmmGkxOV4kaqcYXsFKOulCtn2asTfKG5FMuLROlfiWayr+BZ3dzrPluZcbniw9uV2+395MoedVBUUTyF++n8B3AL5W9PfhhE98EQLDqd1rmAIjJNoq+bXJm/X6Vct1VsmuZdn5V/x8o/lfQg7CDmXzjpUOfXWjiw7aLKgXoJhqTX8WCQq6T8iZ7n7o3J7QKhhFQYOdQITH9VBQ0zlVFRtjssdVj8nfP06HqTK1xVI84z66YY7s6JK7LEf887F2VQmUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb59LByXz0/7L7RyRbR944w57LjKj+luVJzmN09EXJg=;
 b=BOt/vk8xPTgbTtOy9z/Rf0gSRDZm1LeOqDC9dh1hyyDV/bV7lmWuT71NbsaZOvllVQFvhUxh6stJS8Bfp6kmittQZ7nNxI6vNnvTbu0W443NOg2mmSAToD1wv3+KaNpfQUYcb12HPoqywAxo2LFtr45B5tSy1jfELYQQJGwv2ok=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 11:53:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 11:53:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        maple-tree@lists.infradead.org
Subject: [PATCH] maple_tree: do not hash pointers on dump in debug mode
Date: Mon,  7 Oct 2024 12:53:35 +0100
Message-ID: <20241007115335.90104-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0331.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::31) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: ab22ee49-eea0-4078-12a2-08dce6c6aef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pkg/OGIbTtrWPGdUFoZ8/upVrs7cnz9F2nfwvJRTRkwWcXBvVt+GGI1JAAyf?=
 =?us-ascii?Q?I5rWbMCCJaTuoA+doWDN3kx6BwH7S0EFrjWOOMHrpUHiUQ1NC1v5/LGw+cCz?=
 =?us-ascii?Q?H1p41tQ7Uf2rexqVEsd/5zbsCF9WsTbbGL9mdUaePtxz+mqpUZvC4QiF5egM?=
 =?us-ascii?Q?ydZ7H3OfBEaZ+EX8hBJCtTkYa5Xz+3eFlWAv7ycLIbKuu2mHWNCVZYt0UFIU?=
 =?us-ascii?Q?3ksz1uBtQ08z/xU1DeedLQTdAfRoLl/AI4Gy0o3SJEOueS1uU+9cjxSwO+xU?=
 =?us-ascii?Q?fzGiMtfYCfeHIjiRSySuIZglNCCi+EazonQ7MwRf5yuyHFtQdMgYrjzrpmTG?=
 =?us-ascii?Q?wimSH7N75tVfuRDYLNDbGTBzMTd3TxcxG101i69IsbdaDy1B9sAbXRYX38/Q?=
 =?us-ascii?Q?b+JpXXjFack7ti4X1nAp+AA3j/Pte1mynb/mYZgnZ5BcFFv46Y5Zz114WxCo?=
 =?us-ascii?Q?9+0yptLSh7edgcxJjhED7Cv28oWKZ8KvSUG33RYw5inB4AqGZGL8xQ+kf2P4?=
 =?us-ascii?Q?xD1pnv5x7yl77b5pSbG5UPA20uPHwkUyO3iLr4ic1VcKOETSuh3DL2Mcvkwc?=
 =?us-ascii?Q?Clx5gs9Kb0fj+yxvslXlz8AhcqFavyigrMF2u1FIkhRFMEeD3EAzabL6bouX?=
 =?us-ascii?Q?ZN2V242ZQdkGzbTMEJUFDiL8N9w1nI6BgIbXOB+5F/pkyJAE/Gbnm47kPNsP?=
 =?us-ascii?Q?AgGsI9p2d59vSxxTVvTI4uNBLX4XA4M/hGGm1VqvMFWXkQp702Pit5ApuAnK?=
 =?us-ascii?Q?fSG9ijHHnK96KAmUeJLE4160I+6KjTvnzSrF7OJ8jVDHNuL1jlZXbORbuGHi?=
 =?us-ascii?Q?xuz3AUryv0Mo/qjUzdBOSS5V8ms3+tQl4L192dqTGm5ld6pA84koG9yqgUdI?=
 =?us-ascii?Q?2uc7EvbdR0Gx1Vh8upW4Dko2Q/2buk+uEdySWzjfHf1vusdQejZEADu0IW6l?=
 =?us-ascii?Q?txzpDoMPNbwafFqqkl/uHL3YPayjwyDTA2lIZYQojmbP12jYxowCG36sP2uI?=
 =?us-ascii?Q?qF/W52cdnJ02IdWIf3b/IYZk9T7lNMa66Bn+7YkbGpMc6rC6SoliggMTwSjQ?=
 =?us-ascii?Q?X+hTHdXFF/G5oAO96dPCqhZUN7+9JJ69N8W6aegwHzmuy0A/VajBcLFx8t2v?=
 =?us-ascii?Q?lBMuQJsi/6NTr1OlU7NI5KEE33rWgF88nYoIAcz1hTp+VkhAQhdcK+vE5+g5?=
 =?us-ascii?Q?89ghS6VqqyG06Sc8GiLQm9Jbda/d/Pf55zeOuLq5B+SEBmwFj/dc23WNTLsE?=
 =?us-ascii?Q?3pALIi51BWqcZRpNuXshn2ua5pAg8KZCxrgq4/Xuug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?omUyDlPc5YUGBlstkZPawmQrOMnyBmt8uUvCp74C44sfsIp40MTS+xRADKBv?=
 =?us-ascii?Q?zsAe+BRPY4HdDcGRHCPAjzP2bnwGsm/wGWuyegMmQYsJQhMlG70jAb4rljLY?=
 =?us-ascii?Q?y0TgJhyDGW1EB8gyFbhDyokozvokvYXYHVB7F3uylFadtMyQCt4AhIHFWEIo?=
 =?us-ascii?Q?XlmekOluFxDCIJa9Ewy4jDP2YkE4K6FKqL8f8jOvbs8Ep6sP5Q1CTrtDyhqM?=
 =?us-ascii?Q?3hetV4moWv/angaE3o5MtIdN/hs5tOuSYFu+Lm/411WnTzeVkpnoxj8aO182?=
 =?us-ascii?Q?y01Zz3Hzffo4YAiiUCOVHAP0KKVxoT/hWJOfU4YpG5y+S1QuipOA/K7HGfiH?=
 =?us-ascii?Q?KcZGoKMMIb0gF6PgIDuoGkmYX5k02oPtH/fbVn4uix9uOQte8EvpcV7gN+NJ?=
 =?us-ascii?Q?qESXMVld684dMTaE0E9fw4MoFSg+32V2bnSYXI5e1jlOr+Xo3jZxIx6cIFn3?=
 =?us-ascii?Q?vi13Z/M7zPa7WbosP3nFh57MxhNqC42le+Mku60XtB6DQVhv4QigCgvbnTE3?=
 =?us-ascii?Q?J9/8Flh93zPhv4TxT8jUguVR+TcDTzbij+28aXy4+JV0n5lQ4J/5hkGMrsCc?=
 =?us-ascii?Q?VMdb2xxHG2rzbhVSw7sy4bjgEYQl8TOt9OU/7Kuml9EkfIKXTj6qkAMPVmCq?=
 =?us-ascii?Q?v9ULB4DU36IFd4jRXEj4jnVpNjyDB1VzLLt7BRtj5ganD0MlT7qYOlX4A3sh?=
 =?us-ascii?Q?75sf0mOkDwWDWWCsgSU1rlzZ24xGVfO8Hvt0MNqfw+T1v5aXVQ+bac6pxs8H?=
 =?us-ascii?Q?ekn7AEOp2csdjOI47NV/OFfObQwyn9lu8YxoGIWhSNbcXmqIKKq5pcHrVZ/w?=
 =?us-ascii?Q?ZIYqBuq4DmwWiPpCLPP2OHszTCpgH+8BctVt7D9//nakWHcJ45bAeztM2LFS?=
 =?us-ascii?Q?UPCmi0bIc1pxAA2RMDae8pOzn9I5DhohiSRjc+OrtdaxxjdEyAQkc4d8jVm6?=
 =?us-ascii?Q?0jqNY2SKbtFYmO+XEm0PWlScaVsonk8g9XClhp2TnE+1O7QmbsDAoG57cNst?=
 =?us-ascii?Q?j/8rZx0Rrb7Zmlnvq/hNrZTe1PRQYtYtfIH3n+Pz7425n6tHPjdOOAbd3w3l?=
 =?us-ascii?Q?9musj0ECltwr+5QPJNiwTf6vZfQJZeC04iHohsS6kFWJL9+pUgE5QBJC3ti6?=
 =?us-ascii?Q?gXhurdyrYic1Hy0bIQz/soiAVKyhDFykbaI9Z4b3NuUn44Nq6gw1hct+eHOJ?=
 =?us-ascii?Q?MzPmMoXSsli3glx9abFeOOZf439D+q2DmMoqIYS+luZbcsMYX1/QWx8KZ+i4?=
 =?us-ascii?Q?welvZpOAHONscb6OeVO5KTNRBSG5SC57We45KceBudGnWwTQ4463JPOVcqwz?=
 =?us-ascii?Q?a/fC1JPI0ko6zaOBijMU2/cvacpKGr1TqbSXpVqv6fpMdp/dAhkqcRGStLQT?=
 =?us-ascii?Q?yU09G0HYdgb36cZirj1Kb4ZmDo1j2I/7inJ1dVjD9fH/xTIS1LtZFZT03fFT?=
 =?us-ascii?Q?+DhhIsP+o+TGn7LAbKz400gMXWzqxHla2GIQaFSpUsFilFIIfLyP/4kI3QoI?=
 =?us-ascii?Q?kjql5tV+qFVFgolqGPc/zA/8wPx+xoaNBvCZYQcQJ6N8PL/SSkzIXljqoB1z?=
 =?us-ascii?Q?YJe+uFBKvPwjJgOGZZnyz92P6po2U6bLhxa2uhK1v677h6MTfJ3Ei8xzFXge?=
 =?us-ascii?Q?lLlrqgvtyqOmuRrqKaCThQ4UUp/giNPWJoteX9WKJk4EHqOycmq7RfLzNjCf?=
 =?us-ascii?Q?zGsEXA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SnEM1WpuSbE+OkaoOy+OscXs5nEXA4NP+tD+Q7vJGBEyh9HLz88OxJbMy+G6DloL69BIhEbNLJ1te51puU2/16/1vW8Saewir/7NxrrI9rbt5rnvw5HJg/n87xSDWBpKTWKYKpeCZK+6kVmQx7zV6BZqG1ik4XX3PcnopdHrxOrA0xkJhWXzijjT103bLEjPlICzYFoXNUfznwlZjyQNkTPRQ3sQyJkt6PePbM0Veo/J/DhxRsljIJEq6BP25gsDbBJ9YBYiVzfuyr5vOREUx+OEqaVQfdJgddKw3YDcGY4md+D56BMRaWLQO2YuH13057B8iKCsTvyPtLjmkKNS6tXUlAzolpHhIjOHevCBVBzW8o0/1l8P/YzlxfGpaxAwabxrD06xTXkI8xaSwEe7wi4M13iSfBpLgsjH3YWxrUrhXE2XsDnGTE4XIQLLumNsmIkc0BFvFSZ0cXLiuQ4CqUIENMQLReuExU296xDAD5ONy2/PMD5NJFocAqTGsgqKg/g+2nN8WhqKNlqiIG2hW/5eJIcLQTDyLdVorGnyk+GHXXRn26NZrAkxl+jCt660PfNvevGntfYeGcZq1TarllyU1r+BeYn2kusQbzd6Pzc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab22ee49-eea0-4078-12a2-08dce6c6aef2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 11:53:39.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pzcAeYU0K0S82s7Zv79HKcn5FOV9+kH5s2dzuuUauU6kTs6y64+f1CHIfIeADbFl2PmHalwg04Dy1DrwFH08OYCwjXcFp45icviG4XZnuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_02,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070084
X-Proofpoint-GUID: jzoTfD642LcYzbWyfIkvKJCX0_wgt8-v
X-Proofpoint-ORIG-GUID: jzoTfD642LcYzbWyfIkvKJCX0_wgt8-v

Many maple tree values output when an mt_validate() or equivalent hits an
issue utilise tagged pointers, most notably parent nodes. Also some
pivots/slots contain meaningful values, output as pointers, such as the
index of the last entry with data for example.

All pointer values such as this are destroyed by kernel pointer hashing
rendering the debug output obtained from CONFIG_DEBUG_VM_MAPLE_TREE
considerably less usable.

Update this code to output the raw pointers using %px rather than %p when
CONFIG_DEBUG_VM_MAPLE_TREE is defined. This is justified, as the use of
this configuration flag indicates that this is a test environment.

Userland does not understand %px, so use %p there.

In an abundance of caution, if CONFIG_DEBUG_VM_MAPLE_TREE is not set, also
use %p to avoid exposing raw kernel pointers except when we are positive a
testing mode is enabled.

This was inspired by the investigation performed in recent debugging
efforts around a maple tree regression [0] where kernel pointer tagging had
to be disabled in order to obtain truly meaningful and useful data.

[0]:https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 lib/maple_tree.c | 100 ++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 41 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 37abf0fe380b..0bcaa1804b79 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -64,6 +64,21 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/maple_tree.h>
 
+/*
+ * Kernel pointer hashing renders much of the maple tree dump useless as tagged
+ * pointers get hashed to arbitrary values.
+ *
+ * If CONFIG_DEBUG_VM_MAPLE_TREE is set we are in a debug mode where it is
+ * permissible to bypass this. Otherwise remain cautious and retain the hashing.
+ *
+ * Userland doesn't know about %px so also use %p there.
+ */
+#if defined(__KERNEL__) && defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+#define PTR_FMT "%px"
+#else
+#define PTR_FMT "%p"
+#endif
+
 #define MA_ROOT_PARENT 1
 
 /*
@@ -5414,7 +5429,8 @@ void *mas_store(struct ma_state *mas, void *entry)
 	trace_ma_write(__func__, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 	if (MAS_WARN_ON(mas, mas->index > mas->last))
-		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
+		pr_err("Error %lX > %lX " PTR_FMT "\n", mas->index, mas->last,
+		       entry);
 
 	if (mas->index > mas->last) {
 		mas_set_err(mas, -EINVAL);
@@ -7119,14 +7135,14 @@ static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
 	mt_dump_range(min, max, depth, format);
 
 	if (xa_is_value(entry))
-		pr_cont("value %ld (0x%lx) [%p]\n", xa_to_value(entry),
-				xa_to_value(entry), entry);
+		pr_cont("value %ld (0x%lx) [" PTR_FMT "]\n", xa_to_value(entry),
+			xa_to_value(entry), entry);
 	else if (xa_is_zero(entry))
 		pr_cont("zero (%ld)\n", xa_to_internal(entry));
 	else if (mt_is_reserved(entry))
-		pr_cont("UNKNOWN ENTRY (%p)\n", entry);
+		pr_cont("UNKNOWN ENTRY (" PTR_FMT ")\n", entry);
 	else
-		pr_cont("%p\n", entry);
+		pr_cont(PTR_FMT "\n", entry);
 }
 
 static void mt_dump_range64(const struct maple_tree *mt, void *entry,
@@ -7142,13 +7158,13 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 	for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++) {
 		switch(format) {
 		case mt_dump_hex:
-			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
+			pr_cont(PTR_FMT " %lX ", node->slot[i], node->pivot[i]);
 			break;
 		case mt_dump_dec:
-			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+			pr_cont(PTR_FMT " %lu ", node->slot[i], node->pivot[i]);
 		}
 	}
-	pr_cont("%p\n", node->slot[i]);
+	pr_cont(PTR_FMT "\n", node->slot[i]);
 	for (i = 0; i < MAPLE_RANGE64_SLOTS; i++) {
 		unsigned long last = max;
 
@@ -7170,11 +7186,11 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 		if (last > max) {
 			switch(format) {
 			case mt_dump_hex:
-				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
+				pr_err("node " PTR_FMT " last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
 				break;
 			case mt_dump_dec:
-				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				pr_err("node " PTR_FMT " last (%lu) > max (%lu) at pivot %d!\n",
 					node, last, max, i);
 			}
 		}
@@ -7204,13 +7220,13 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 	for (i = 0; i < MAPLE_ARANGE64_SLOTS - 1; i++) {
 		switch (format) {
 		case mt_dump_hex:
-			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
+			pr_cont(PTR_FMT " %lX ", node->slot[i], node->pivot[i]);
 			break;
 		case mt_dump_dec:
-			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+			pr_cont(PTR_FMT " %lu ", node->slot[i], node->pivot[i]);
 		}
 	}
-	pr_cont("%p\n", node->slot[i]);
+	pr_cont(PTR_FMT "\n", node->slot[i]);
 	for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++) {
 		unsigned long last = max;
 
@@ -7229,11 +7245,11 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 		if (last > max) {
 			switch(format) {
 			case mt_dump_hex:
-				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
+				pr_err("node " PTR_FMT " last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
 				break;
 			case mt_dump_dec:
-				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				pr_err("node " PTR_FMT " last (%lu) > max (%lu) at pivot %d!\n",
 					node, last, max, i);
 			}
 		}
@@ -7251,8 +7267,8 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
 
 	mt_dump_range(min, max, depth, format);
 
-	pr_cont("node %p depth %d type %d parent %p", node, depth, type,
-			node ? node->parent : NULL);
+	pr_cont("node " PTR_FMT " depth %d type %d parent " PTR_FMT, node,
+		depth, type, node ? node->parent : NULL);
 	switch (type) {
 	case maple_dense:
 		pr_cont("\n");
@@ -7280,7 +7296,7 @@ void mt_dump(const struct maple_tree *mt, enum mt_dump_format format)
 {
 	void *entry = rcu_dereference_check(mt->ma_root, mt_locked(mt));
 
-	pr_info("maple_tree(%p) flags %X, height %u root %p\n",
+	pr_info("maple_tree(" PTR_FMT ") flags %X, height %u root " PTR_FMT "\n",
 		 mt, mt->ma_flags, mt_height(mt), entry);
 	if (!xa_is_node(entry))
 		mt_dump_entry(entry, 0, 0, 0, format);
@@ -7332,7 +7348,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 			MT_BUG_ON(mas->tree, !entry);
 
 			if (gap > p_end - p_start + 1) {
-				pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
+				pr_err(PTR_FMT "[%u] %lu >= %lu - %lu + 1 (%lu)\n",
 				       mas_mn(mas), i, gap, p_end, p_start,
 				       p_end - p_start + 1);
 				MT_BUG_ON(mas->tree, gap > p_end - p_start + 1);
@@ -7352,19 +7368,19 @@ static void mas_validate_gaps(struct ma_state *mas)
 		MT_BUG_ON(mas->tree, !gaps);
 		offset = ma_meta_gap(node);
 		if (offset > i) {
-			pr_err("gap offset %p[%u] is invalid\n", node, offset);
+			pr_err("gap offset " PTR_FMT "[%u] is invalid\n", node, offset);
 			MT_BUG_ON(mas->tree, 1);
 		}
 
 		if (gaps[offset] != max_gap) {
-			pr_err("gap %p[%u] is not the largest gap %lu\n",
+			pr_err("gap " PTR_FMT "[%u] is not the largest gap %lu\n",
 			       node, offset, max_gap);
 			MT_BUG_ON(mas->tree, 1);
 		}
 
 		for (i++ ; i < mt_slot_count(mte); i++) {
 			if (gaps[i] != 0) {
-				pr_err("gap %p[%u] beyond node limit != 0\n",
+				pr_err("gap " PTR_FMT "[%u] beyond node limit != 0\n",
 				       node, i);
 				MT_BUG_ON(mas->tree, 1);
 			}
@@ -7378,7 +7394,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 	p_mn = mte_parent(mte);
 	MT_BUG_ON(mas->tree, max_gap > mas->max);
 	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
-		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
+		pr_err("gap " PTR_FMT "[%u] != %lu\n", p_mn, p_slot, max_gap);
 		mt_dump(mas->tree, mt_dump_hex);
 		MT_BUG_ON(mas->tree, 1);
 	}
@@ -7408,11 +7424,11 @@ static void mas_validate_parent_slot(struct ma_state *mas)
 		node = mas_slot(mas, slots, i);
 		if (i == p_slot) {
 			if (node != mas->node)
-				pr_err("parent %p[%u] does not have %p\n",
+				pr_err("parent " PTR_FMT "[%u] does not have " PTR_FMT "\n",
 					parent, i, mas_mn(mas));
 			MT_BUG_ON(mas->tree, node != mas->node);
 		} else if (node == mas->node) {
-			pr_err("Invalid child %p at parent %p[%u] p_slot %u\n",
+			pr_err("Invalid child " PTR_FMT " at parent " PTR_FMT "[%u] p_slot %u\n",
 			       mas_mn(mas), parent, i, p_slot);
 			MT_BUG_ON(mas->tree, node == mas->node);
 		}
@@ -7434,20 +7450,20 @@ static void mas_validate_child_slot(struct ma_state *mas)
 		child = mas_slot(mas, slots, i);
 
 		if (!child) {
-			pr_err("Non-leaf node lacks child at %p[%u]\n",
+			pr_err("Non-leaf node lacks child at " PTR_FMT "[%u]\n",
 			       mas_mn(mas), i);
 			MT_BUG_ON(mas->tree, 1);
 		}
 
 		if (mte_parent_slot(child) != i) {
-			pr_err("Slot error at %p[%u]: child %p has pslot %u\n",
+			pr_err("Slot error at " PTR_FMT "[%u]: child " PTR_FMT " has pslot %u\n",
 			       mas_mn(mas), i, mte_to_node(child),
 			       mte_parent_slot(child));
 			MT_BUG_ON(mas->tree, 1);
 		}
 
 		if (mte_parent(child) != mte_to_node(mas->node)) {
-			pr_err("child %p has parent %p not %p\n",
+			pr_err("child " PTR_FMT " has parent " PTR_FMT " not " PTR_FMT "\n",
 			       mte_to_node(child), mte_parent(child),
 			       mte_to_node(mas->node));
 			MT_BUG_ON(mas->tree, 1);
@@ -7477,24 +7493,24 @@ static void mas_validate_limits(struct ma_state *mas)
 		piv = mas_safe_pivot(mas, pivots, i, type);
 
 		if (!piv && (i != 0)) {
-			pr_err("Missing node limit pivot at %p[%u]",
+			pr_err("Missing node limit pivot at " PTR_FMT "[%u]",
 			       mas_mn(mas), i);
 			MAS_WARN_ON(mas, 1);
 		}
 
 		if (prev_piv > piv) {
-			pr_err("%p[%u] piv %lu < prev_piv %lu\n",
+			pr_err(PTR_FMT "[%u] piv %lu < prev_piv %lu\n",
 				mas_mn(mas), i, piv, prev_piv);
 			MAS_WARN_ON(mas, piv < prev_piv);
 		}
 
 		if (piv < mas->min) {
-			pr_err("%p[%u] %lu < %lu\n", mas_mn(mas), i,
+			pr_err(PTR_FMT "[%u] %lu < %lu\n", mas_mn(mas), i,
 				piv, mas->min);
 			MAS_WARN_ON(mas, piv < mas->min);
 		}
 		if (piv > mas->max) {
-			pr_err("%p[%u] %lu > %lu\n", mas_mn(mas), i,
+			pr_err(PTR_FMT "[%u] %lu > %lu\n", mas_mn(mas), i,
 				piv, mas->max);
 			MAS_WARN_ON(mas, piv > mas->max);
 		}
@@ -7504,7 +7520,7 @@ static void mas_validate_limits(struct ma_state *mas)
 	}
 
 	if (mas_data_end(mas) != i) {
-		pr_err("node%p: data_end %u != the last slot offset %u\n",
+		pr_err("node" PTR_FMT ": data_end %u != the last slot offset %u\n",
 		       mas_mn(mas), mas_data_end(mas), i);
 		MT_BUG_ON(mas->tree, 1);
 	}
@@ -7513,8 +7529,8 @@ static void mas_validate_limits(struct ma_state *mas)
 		void *entry = mas_slot(mas, slots, i);
 
 		if (entry && (i != mt_slots[type] - 1)) {
-			pr_err("%p[%u] should not have entry %p\n", mas_mn(mas),
-			       i, entry);
+			pr_err(PTR_FMT "[%u] should not have entry " PTR_FMT "\n",
+			       mas_mn(mas), i, entry);
 			MT_BUG_ON(mas->tree, entry != NULL);
 		}
 
@@ -7524,7 +7540,7 @@ static void mas_validate_limits(struct ma_state *mas)
 			if (!piv)
 				continue;
 
-			pr_err("%p[%u] should not have piv %lu\n",
+			pr_err(PTR_FMT "[%u] should not have piv %lu\n",
 			       mas_mn(mas), i, piv);
 			MAS_WARN_ON(mas, i < mt_pivots[type] - 1);
 		}
@@ -7549,7 +7565,7 @@ static void mt_validate_nulls(struct maple_tree *mt)
 	do {
 		entry = mas_slot(&mas, slots, offset);
 		if (!last && !entry) {
-			pr_err("Sequential nulls end at %p[%u]\n",
+			pr_err("Sequential nulls end at " PTR_FMT "[%u]\n",
 				mas_mn(&mas), offset);
 		}
 		MT_BUG_ON(mt, !last && !entry);
@@ -7591,7 +7607,8 @@ void mt_validate(struct maple_tree *mt)
 		end = mas_data_end(&mas);
 		if (MAS_WARN_ON(&mas, (end < mt_min_slot_count(mas.node)) &&
 				(mas.max != ULONG_MAX))) {
-			pr_err("Invalid size %u of %p\n", end, mas_mn(&mas));
+			pr_err("Invalid size %u of " PTR_FMT "\n",
+			       end, mas_mn(&mas));
 		}
 
 		mas_validate_parent_slot(&mas);
@@ -7607,7 +7624,8 @@ EXPORT_SYMBOL_GPL(mt_validate);
 
 void mas_dump(const struct ma_state *mas)
 {
-	pr_err("MAS: tree=%p enode=%p ", mas->tree, mas->node);
+	pr_err("MAS: tree=" PTR_FMT " enode=" PTR_FMT " ",
+	       mas->tree, mas->node);
 	switch (mas->status) {
 	case ma_active:
 		pr_err("(ma_active)");
@@ -7671,7 +7689,7 @@ void mas_dump(const struct ma_state *mas)
 
 	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
 	       mas->index, mas->last);
-	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
+	pr_err("     min=%lx max=%lx alloc=" PTR_FMT ", depth=%u, flags=%x\n",
 	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
 	if (mas->index > mas->last)
 		pr_err("Check index & last\n");
@@ -7680,7 +7698,7 @@ EXPORT_SYMBOL_GPL(mas_dump);
 
 void mas_wr_dump(const struct ma_wr_state *wr_mas)
 {
-	pr_err("WR_MAS: node=%p r_min=%lx r_max=%lx\n",
+	pr_err("WR_MAS: node=" PTR_FMT " r_min=%lx r_max=%lx\n",
 	       wr_mas->node, wr_mas->r_min, wr_mas->r_max);
 	pr_err("        type=%u off_end=%u, node_end=%u, end_piv=%lx\n",
 	       wr_mas->type, wr_mas->offset_end, wr_mas->mas->end,
-- 
2.46.2


