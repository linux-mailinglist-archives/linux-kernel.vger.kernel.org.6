Return-Path: <linux-kernel+bounces-229572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53A9170FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9A628941F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4CD17DE14;
	Tue, 25 Jun 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mYltdP6s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JBPFvBVk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C417D89D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342744; cv=fail; b=Uss0MyHA/jrBXSB4/BeL+GHjfLMDuKRZGG5JqAtRylEZ5mCHZ68Dr63LAM30NbGFphXCjz6Hvg/7l655F67LTsD7XuDVA80NCRsif2qjFitUcDn8rLoucTJYRe7gSMgvXwXZAfA9p1isMjSZ4sKvUh3dTLyfLbkAga+0GLNJTuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342744; c=relaxed/simple;
	bh=O2N9XDkq9ec+KdLypboZoLmYUUXN14OPXgzHb56VW4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qf2bc8Yb3OAB+wuxelzW/nI99RnJ3yi3Uw24tcwKwDobrLQ/hoDwFGUnFOm0N+I69oN5e8KUV1lsN/kCh2rMGI5u9IAMUJcHwOHmWew7Lu9h9o97brwsPic/Ofxn5yUbBOrgmK2mI0qpnZOl2vLqHSr79a7l74gTmTKjOAywnpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mYltdP6s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JBPFvBVk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfXD0007445;
	Tue, 25 Jun 2024 19:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=gvJyWlTu7KPZFMbPpZBAcwY6aEsrPPQT/0buDXuoink=; b=
	mYltdP6sihKm0kU73e8zYu8v2hoQijFs0KpbFLIsZ2SCH0eQsEr8t/6F2x1f5yo/
	C8dWELvqcQTC/OCiFS0qDCA15LuA1WMiuw9bS2GdqIPWlz2i6Bk1H66ib89Emq9j
	OE6l4astbfqvr12nmkIQl/qdDalyvNj+fuDlCxrCr2HDt4wHaFFLemb/dVFyJa7e
	1/YaIdUmCl7NRZbHOFZYFPrjPS8rI731YFQNlLUQXVtESMr455tDAPDVYWqno3FX
	gHbkfXcvDJJ9njLLX9DkFpyvSB18Kwva87IQkTBFYfuE99OE8OKBoXmUmEdTZfk6
	Nmk4BgYeI5sf/XbnGjoKzA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d1dn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIrYL0010721;
	Tue, 25 Jun 2024 19:12:07 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2egtm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccPHSULYHXBlZTHAar4Y3ajYBY7nZ7BW0WyYhuGC8RynIWpLLiIMszaSVDUhMr/KihpOnGgnT6kDWswSr8QxWhMsgQjwQfcA+EFUStYkoYzmu0HD8vM+gVcnaKKma3hyyeokG3HC+RT35P2/Hps0IVgOx0B6kLNK9zzLPvSajUFzPj4/ciMXeN8D9kCLM41dYM/tpq/KQuS4a1ZWhm+XyKKa3bbl8U9OZ6mp0zBRyFR31VqCrNy61Vnp2D5JbEw91UQsKBf6cMvQhdngMhvZkJ24rZJFF+zCQ5qsfBnLUaTl2djhndptvPIaDO8wJoz1qnKl7VXuDKeR70Kr8IVYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvJyWlTu7KPZFMbPpZBAcwY6aEsrPPQT/0buDXuoink=;
 b=NYrAFjDj3LmeLHWnq5ZyCJfl3DmcGq2DSOwFgzzwRTxyjltyMH3BiTnb07k7Udre1mGH8L7badhcBweK5/ug6Kok0wj9R/EMSQZOpFyD6j4WAziuPz25Fx6kwx5QxjR43XPBJGrk4DwWjZxmMa58+3Em3uZDCxVRZA2lg4u5VLWPSLeSxMDn93Nb1t2pIb5dZ8PjTpyFkyR1bQ7He3hP9jnZ30waSBqUShwCwjSFGRoB5MqcH6rMWBa9wsN0lOx47GOErH/HtkNH7h2arcZzWv5UNPpyI5WjaZvtKMp8bbO/iMWlSk6lg7Xgxs656lMiHZi0dDPfocv2kifO5aU83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvJyWlTu7KPZFMbPpZBAcwY6aEsrPPQT/0buDXuoink=;
 b=JBPFvBVksAoHvYQM233xnmDKjTG7yMRbglugyMp0xK8eLIur6av7u2wJ+xNnmCP1xzHDZmHnRSJdRPtX2N4pOcvB5Ds263PRDelHazYQ5IISe+3g2uIfBFls2Pfwd4kImFSSgspAKeeLcdyKP0pepi9qCR3qtU5+U2ebNaaGIXQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:12:05 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:05 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 06/15] mm/mmap: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Tue, 25 Jun 2024 15:11:36 -0400
Message-ID: <20240625191145.3382793-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0207.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 101ed9f5-c31f-4fdc-7930-08dc954ab382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LW2m8ctWuw18W+qKj1JicIB6pPqOAj4qagJQBSd+8d1x1Yx0P4mpTDqxu+uz?=
 =?us-ascii?Q?FOGK3p71Cd4rOxMraaFzmjkO2rWyeDSQ2TuK6gpwHH4sSD0g9DMtdhO6jScb?=
 =?us-ascii?Q?YDeLIVbVgjywcmhpGG5A42kCIAAdf1B17TTTl8STydwoz99q4IT7e7K+FFJt?=
 =?us-ascii?Q?KsxITWgeIw/ppMIsMMWGThKBeSZ6sWTBELFpNymbRLS7P+APvsk8xf3nI5Wt?=
 =?us-ascii?Q?a5LMfSuL2ytZkZ43c2VaXHbp5y4SmNgj0nHAr2BQozYutTrHfbZDJOXqP8Gk?=
 =?us-ascii?Q?ALIIDbCdI1ASB1d0fm5EQe4Rh10+Q+tTl1HRI6ZfuyMgkrDQYKjf0Gdu6nUW?=
 =?us-ascii?Q?M65Rh5apXaiG6wd6/jW8EIi2fW/9+HNGGwDB7mm4AWTAAmVJV9JIlY+678jK?=
 =?us-ascii?Q?GCuZCS+jPY+rqQiglnQKVGqcc+vB3zphEDFVZut28DYcngTm+M7zKGl1Qr8w?=
 =?us-ascii?Q?DHGTfO0AdAoeL2h6YRpaXZNGuRNAcdp78XruEWbFzhJKEn3EN9l7QEH5mJCc?=
 =?us-ascii?Q?FbpGrDQ+5cIc0vO5FjnVp1KC08nnUl0dlHGfR69WqgmpfXVjDB1y10xs5yS4?=
 =?us-ascii?Q?Ar0ztel8rjnEolqa9pIvPh3WMtLxm8btA37QNS4r0zpJlUfRmDIBmUYzw1Y+?=
 =?us-ascii?Q?cWVEvDg2a3m9oNNjc2jg4ApKsB1BplxOC2xTsH6+QSF/gkqwGFORIU4++pPo?=
 =?us-ascii?Q?ViyGwZ1rh22aSCbgJbUxcXDBKvQ7pfKutXhOb0uf+aX7Q779PMLapJP03ApM?=
 =?us-ascii?Q?hLguqYW7efoEZBjtIHSzatKRF+Y+umX3EN5Q1gf70TpaGS4V4sB5U3keu+NI?=
 =?us-ascii?Q?mnQ4i/1HM/gR+/aRxhq3gvbn/dxFtW1u4KIiOBw4y1yqJHUHY0JwjcDHImis?=
 =?us-ascii?Q?TvZBLqEsZ/ImaPW8ZNPY6vIkFwy4ZCWC1MmDYG0CeslF/WQr9qTq3nvMxAbx?=
 =?us-ascii?Q?KtDwG7BJoX4mLaNUMdl6O+e36SbaHsefpibqI46MahTqftnmBmnYhB8Dto8t?=
 =?us-ascii?Q?Q7uYhaym757LRRwXzoCoLcLoczLcV8hOvZjpLX8RjmbdSu2AZtBO6C/Ix/Yg?=
 =?us-ascii?Q?NHXplSzUxasTFCfOX9w8SXi3m6qonDDSf83E8YKBptBL9v763iMb1AJjKRib?=
 =?us-ascii?Q?gKGcVTDcs4aV08FjuoNJ+tNWk79H54aa/YX8Yk+nr1Ui3hEjvCLXTTzxjTT9?=
 =?us-ascii?Q?/4l7XX59gsciw6lilqbtLZpJEehrmMi9emsydxj+WkvgotoWEtCEuEqXL9v/?=
 =?us-ascii?Q?hMLYGtyKqDe5p65prmvEa1ss63cqSDETvXZJ3M4fXY0Q2m+7ZO6u02MmARG1?=
 =?us-ascii?Q?4Jm6gaKtRKQ29srL4rZX/X8J?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iaBnNptSocJCeOY66zc4HXGRN32ht8whBXJNcWTEUsxxz+kFUmbOnDHgGysq?=
 =?us-ascii?Q?OeXRKiaC3NG+AophcVSi8TRSoKMqz0si70v0E5akdZM8Y/qlP2pjjr1CwNOE?=
 =?us-ascii?Q?XnVzODYJb+SQypIj6wlVXdwI44OB325ZeRq6sTUQB0SI7BRAd35mXb0LjNHr?=
 =?us-ascii?Q?p00jAdqTounpFnuACeUyosnPS5Pc7QA1d5FULZJLdh0N9wMbRkzMARg3Tnn1?=
 =?us-ascii?Q?8zjPQ71Ls1IIKc2xRD99pxTU4Vps65lB3q8lwlgLLPuzYRZw84NpWFqhY8Qk?=
 =?us-ascii?Q?yaCnSPzJqRRU8sm6DvcZbKfUIHQlzXGgIKl9E5p3eU97At7tC127R8jNVW0e?=
 =?us-ascii?Q?ReEH6A0oYFgIdDpYQzHZBKny8ezB+Gc30opV82RX4VGK7dS/RvfGh/VG+jm7?=
 =?us-ascii?Q?Lezkndi4edGykmWY/TwYPi/hDBfohxb1+S1AfNSeES63MjIJyoeruuFpVPbN?=
 =?us-ascii?Q?DuiC7eoxtbrmovA1M6TAw/o/q3HEj4hT1YKIp7q/Mg9tQ++3XDuZS+JFudpp?=
 =?us-ascii?Q?PfdKimlr+OnQUCctWmr2xDdl+bKEpXVZRStgcDTIQvbUVCb4yFFGz2FN+zxZ?=
 =?us-ascii?Q?iMLzR8Xxqtu4DDwD2d6ImbrtmkRG+YhwuHkwKkOdSkvp6IpaJJAV+6Nxe6K8?=
 =?us-ascii?Q?5SulDS8pZcMd91YarxrhAJm7SM0h91n7m0OlxW4LPGTo2LIJ24SzUi37L5Sd?=
 =?us-ascii?Q?n2pCgFE4Dpc4LkYnDE5DT0lkW3TcHk1XiMSkxonckTLAbLTUi0Yo405D5LNk?=
 =?us-ascii?Q?Z9+YoDXNru/dEoWQwOKshNivDyqIYi78Esrb8Ko8VEKANKjRqvczLHOKl8Bc?=
 =?us-ascii?Q?PM/Pa/u5wCTlVXbmYAFI/S5escjDBSNgbLoZI0dPXf91b8F/K/f/xGPdp8RI?=
 =?us-ascii?Q?tZYzibnXOJeeevffF9fJfjXgYVq3vouX48tTpV3TMOyPjqxn6zkEVvSrjwj4?=
 =?us-ascii?Q?oU6cGrn6m42RfWox6AjTn41d43X+pPFd3UD5HF+njiklFW4bJ6oucdEHibOM?=
 =?us-ascii?Q?+BMVnPGiKT6TXYkAfL58iaJBIQl8PEgg0mTOKVent82IaQEjhajJm9lMupJy?=
 =?us-ascii?Q?VSGdGNeZTRwtScXHlvEqX+q3VAOkRgwkpcqNDPBIhzCLjyLOMegsy4c6pzL1?=
 =?us-ascii?Q?rHDndXTJZGVJC9VytWQs0saNZ6qmsGtw4EOMpSUp++HTg9NA4S3I+V2ZE6uV?=
 =?us-ascii?Q?SNeioLG2qQvECMoaHvsLkcPKffbC5qdDQXwFpPjb7jmwU2/2+Ua0Mft1DYcE?=
 =?us-ascii?Q?Jr4iqBFbAD0aRDwne8i0qLjesIU6B7fns1+r2nj3ZbD4KWv67Ts2KCTX0JaH?=
 =?us-ascii?Q?stQCgq7b2UMiBjejLrsfnrh6MSdBB0Ur2cDWseTTuEfpeU9ebVLb3hFapsNU?=
 =?us-ascii?Q?HWsd2SapSwLADCTeVyQNcF0PgTanH5guf5un25zZ7owoSTavgokfFenmarla?=
 =?us-ascii?Q?2gHmoaJvnaaPPpPss0BMS0izoQmoYiM4USuqlGnpBQ0IXDK/kDh/NR17E+xE?=
 =?us-ascii?Q?SKjVAi3Yp1tn1rGSkHMiF0hD54exVhuVkT+BZ2CFzbrOaC7jYH+nAOoRoG3Y?=
 =?us-ascii?Q?1qtAyzs2FO1tFmTYpFSF9gaCOVZZsidjbrlfCR4ljMubMz4Q71fNDhXuLIPO?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uV0SG3V/vOKrgTzUDU6kUzoISlV5EKL5pYVxrVHu4Y973quMLq7kKJvWr1nHk886b+7oysAjxsIXHD2vQNWEhKz98L6ZQz5jZqtKnYFA9tiOcVYQr6JAqdmoADn+yxPhX3oaBC2QnTvJss5Sgtgh2hd5pWk+hdeqXCZ9j+GP2sMjMjbLr7qHtZH4iyJ3eKCAocqw/4+a3zUZJ2uNt/arm2LnhgwBohJaudE7oNYKd+QKSeq5luat1/al30j+KPUVN2HGbjwTmXvS/3PxPJhQh6YxwOdik314Kjr8zHveVTvHLPU3t4Zvjg5NubDxjfjDni+i5yawrryCSBGPukdcwUqDtvW+li5j6YbYKcaJ3htL1zp08vEonz/Nz3cbBg5m/EwvU+ZxRfjXeOBrBb8jOzZc88+7GqDE+TLZV832mGLL3SLQvJVMO82KeGvwwcewWgO80CMtsN8mCdBPoKQrKQDEEAr+zC41AopgRt5d9sFhOrXG0K1ocX11A5ZqhltbPYVXAy6QRjo38Qr882OiqumHIx56wBlD7T4eTUwqTZUpuBz0VNWe46rRyCSzwe+vycUcxrOK8ab9XoT20IBQPVyg8nqnahMJlGjG1mMWVis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101ed9f5-c31f-4fdc-7930-08dc954ab382
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:05.2540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJ+E3ALETmW8vgS14YB6/vNevLk7Ws1GFEu0DhrAZjf6cOwFmenIyPpMVsVgJdMnMC2yUpjCEEielOwWSd1uYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-GUID: I8i7_gVCIzPEVzxY6BeDzbuukvjpCCyj
X-Proofpoint-ORIG-GUID: I8i7_gVCIzPEVzxY6BeDzbuukvjpCCyj

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduce to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  6 ++++
 mm/mmap.c     | 81 ++++++++++++++++++++++++++-------------------------
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 22563c959861..90cab15c3b81 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1487,12 +1487,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct vm_area_struct *next;	/* vma after the munmap area */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr */
 	unsigned long end;		/* Aligned end addr */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
+	unsigned long nr_accounted;	/* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 76e93146ee9d..2a1a49f98fa3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -523,7 +523,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 }
 
 /*
@@ -2388,30 +2389,6 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }
 
-/*
- * Ok - we have the memory areas we should free on a maple tree so release them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted = 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages = vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
 /*
  * Get rid of page table information in the indicated region.
  *
@@ -2634,12 +2611,15 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
  * @mas_detach: The maple state of the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
  */
-
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
 	mm = vms->mm;
@@ -2648,21 +2628,26 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vms->vmi);
-	next = vma_next(vms->vmi);
-	if (next)
-		vma_iter_prev_range(vms->vmi);
-
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
-		     vms->vma_count, !vms->unlock);
-	/* Statistics and freeing VMAs */
+	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
+		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	/* Stat accounting */
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
+	mm->exec_vm -= vms->exec_vm;
+	mm->stack_vm -= vms->stack_vm;
+	mm->data_vm -= vms->data_vm;
+	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
-	remove_mt(mm, mas_detach);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		remove_vma(vma, false);
+
+	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
 	if (vms->unlock)
 		mmap_read_unlock(mm);
@@ -2710,13 +2695,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (error)
 			goto start_split_failed;
 	}
+	vms->prev = vma_prev(vms->vmi);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vms->vma;
-	do {
+	for_each_vma_range(*(vms->vmi), next, vms->end) {
+		long nrpages;
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			error = __split_vma(vms->vmi, next, vms->end, 0);
@@ -2725,8 +2711,21 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		}
 		vma_start_write(next);
 		mas_set(mas_detach, vms->vma_count++);
+		nrpages = vma_pages(next);
+
+		vms->nr_pages += nrpages;
 		if (next->vm_flags & VM_LOCKED)
-			vms->locked_vm += vma_pages(next);
+			vms->locked_vm += nrpages;
+
+		if (next->vm_flags & VM_ACCOUNT)
+			vms->nr_accounted += nrpages;
+
+		if (is_exec_mapping(next->vm_flags))
+			vms->exec_vm += nrpages;
+		else if (is_stack_mapping(next->vm_flags))
+			vms->stack_vm += nrpages;
+		else if (is_data_mapping(next->vm_flags))
+			vms->data_vm += nrpages;
 
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
@@ -2752,7 +2751,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next = vma_next(vms->vmi);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
-- 
2.43.0


