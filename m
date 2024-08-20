Return-Path: <linux-kernel+bounces-294714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE7959186
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47289B22114
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6491C9DF5;
	Tue, 20 Aug 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B6wRyGX1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZBh6Tzj1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979C1C9DE4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198325; cv=fail; b=KWTkFt2rWi/wAywMbN5oREATSQoFoSVatVwmqAcDt8latsTWemixw74s8o4WP7Jr56mvevi0CKU6l+y8IKkaWwR3ymQ5nzmmsqOpPMO5mje+1x9n99gwZO96zCPkXmwmk1ogQ/cKHLWspqPaV/aJ3orQGgWOTRbZMFk4Vmx9Ydk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198325; c=relaxed/simple;
	bh=83cueVwP2DYjaQIVW4vnan7O9fAXgzO0UPbhOCMU/zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ak0vlbAPsVU/jTQpYLt+raW6GFYoMb++PeDhlp2Mv/D7/n0zIWa5dWLZOhMEPSnnUlzTCOxf/cbvOsi6c7+NCiu/NjurjAOzbL05KYbCL1T7ru84/6LN5wItqojksE32qWI6fQYCHehs87s1uiVoLVvkCohJHhwNtJItVMKC/m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B6wRyGX1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZBh6Tzj1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBh9u005273;
	Tue, 20 Aug 2024 23:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=sz4HyiBxeYTd9ERWqAfMhOMdcVpivHhrD1PZOvJqvI0=; b=
	B6wRyGX1oFmkushSpBz69lbejw6zWi9F3GuNSAesoiC+hAXq8sNAeBUsHXEveC5W
	vFGE8tOZLxQeZGnQoyw+lKWnuiFPAvRBJGBrhQtefXHQacYHhPAaC8QTWd9z36vD
	w3qHqsIZS2fzC/irXNO+IqYtkpRL+JMaPQPk2umNlzFI2lc8j30tNCi52FFNmZsx
	giDGK9qISH6uL03Zb7jn1VtxeDFTcJ4MbPh0qZWhRMsNDIUlSIbBwsnMG+qkfdNX
	FURi6AqqG7TWDpVLDsekletuQjgz5N+OK5oJVkahtTqsf/EMo/TRoxDyfZ9Xhm3q
	M8nOwlqqCLWFvOKvThV8Kw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj0mmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNi8tm033645;
	Tue, 20 Aug 2024 23:58:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41552xg9w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxyQklxBVhCEDU+InWmTM5Y9L5JyILYnnLhtL+unD8znIrI6RIkuxDNU6Y0/0TMNd+eEW0iGBrNibnvRVB+I9Bbcl03TsD0lWwT5Et5r1meoDRz2e4SXLCsgnKVMc8VFSQe9ubh1W9oAmj+U6H6qeIUo/+HDg3YdNDOFZuuNr4BIL5NX1/iti5Jyon0D3a3wI8dkkyxV07qRJiXnHoEsFUHzycC2uJC6j4bz6cGhcJl1AbpZwJEN7oHXj42MLogPrc5JSqBJ2JyWR/+Q0Ue+6GdAyLFibBNFHSbC/73i/kYNBDTd8mySr/0XAf1aUe1OfJCqxzn8E8CfzW6kHnUxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz4HyiBxeYTd9ERWqAfMhOMdcVpivHhrD1PZOvJqvI0=;
 b=N6G0Ujbu9mPxjrojP7cqktX2RCFs052reHb9R2Abtb3X7KoCrg32rkaePkkhfQacHO4i6SF7F3xygEerRq9LLNDOrJF5QDAo0vuI1dWnGBl+xhBm7reWE7SiOkJVH1zFJ2l7sMpv46yIZmmKfPfUVzv/RPLPpoUK0VEXKa4Fk97nzjqkiY/AovcNGVCsmpC+MNa0WiZeWR8KkTv85F4cHsLu/3zteCTRlr70PrR2G/vU+uzfTOqh4746Z/upmKQmhFUbgNcSCfEqkxZVwKLNX1HQZiRIl6umjkHqDPDodcPo4vGdrLsa1rRnJPe/CfY4y1OJHD0iMwWWkL1lA718nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz4HyiBxeYTd9ERWqAfMhOMdcVpivHhrD1PZOvJqvI0=;
 b=ZBh6Tzj1BdpfjZDiuitejV7o4JCqqu+AdQ1vrH+GQBSF1ftAi1o9kTsFG8VTqopDTicTXCO80WE03AmcnbpuoxcR/0epvPcY+82QG0z2ust/LHhfbDXxp+AaXzLkDBEIuVXPfc5DSMJEMZgBklC04q7bwv23Rh+MngceAoW60dg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:22 +0000
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
Subject: [PATCH v6 19/20] mm: Move may_expand_vm() check in mmap_region()
Date: Tue, 20 Aug 2024 19:57:28 -0400
Message-ID: <20240820235730.2852400-20-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b71778-8145-4b0a-8c33-08dcc173f8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6HB7SkiB1n5qDLyW4+LIc9Ipsj4udKNexB2H5htK5LN5/xLxdZMsDtb45Bxr?=
 =?us-ascii?Q?hrUEX/S54gdwp+J0Lgg+RTX7FyL4jWv7gXGEUmLXimGUAHJ538nhyX2iNptG?=
 =?us-ascii?Q?BupsngKvBKGZxMmYvDIhniv5XquOG8aTphpq+awxdojMrtllEaRUFHV4mMmE?=
 =?us-ascii?Q?bAHMIm/Cb9F3ZN5tWV6OfEhF4ENL4IoMjzdBnsaDDag3eyXqYNAqa858XjrV?=
 =?us-ascii?Q?Kgud55l0n5V+G2uHh+F8niHw+wE7xedmUwbC4qnMQJCRx2T/GcbMX8WbQeny?=
 =?us-ascii?Q?Vh5tA6V38CSM3jpCspY/qJuFdxTRCMT6gC/CsOz1rpZ3GjmtwNnnA9f1w7lC?=
 =?us-ascii?Q?fA2maVgwOTfOXiUFdBqsjj2jjL7dKk5CkftjSz1/BjI5uuExeGCYDszHs5Tj?=
 =?us-ascii?Q?3uDIh9hBGrU5X2hWe+qxn0Y/Q9qpEnUfUFgmG7yLovQsYp2BfRmnrfZbrazX?=
 =?us-ascii?Q?D8yX5RLta0qWhaSomPF2rEOs5uzH69cuU1JCYz8fEXwMkToClniaEMMhbkEx?=
 =?us-ascii?Q?WiOuwboFkRTpGik+M2UC5GuNSBokhdBS9ImyoGjAxOSvlVPLIkwaRX9nyeGW?=
 =?us-ascii?Q?YdyCtRv7AIABHJt/KvhV3ScPXlbOqOwtMjT2nf3Eok37bwOLoX91ddWNFASB?=
 =?us-ascii?Q?zy+bX5EOQdDXiu3WaZICmm9aFsD2ajPZhuIB0BEpgEUYUKLO7a37A8z9TA+p?=
 =?us-ascii?Q?8eS5Yhk+nhjIHup05Yf6mhSJIzKRUTuSB6Q5JdAextDJGKyCyirYzbQ5jpsn?=
 =?us-ascii?Q?ALM4E34A1GIBmtoONNhEr8uMVamdOBg7VwAkqpt3nKnCot1S8oDOQCNEPCLb?=
 =?us-ascii?Q?5O2lgp605noHtjaHbqV7uBl0AmOOuVOpHnE6zafaWh7upx1e0KfQJIQs63+B?=
 =?us-ascii?Q?JkZrujFKuQjRTkj5dKUfhU8K2NQIhYgzNfjtzWOgExu2hoejRziNrmwxjpSi?=
 =?us-ascii?Q?2v5e6D76uh3KeV1KpNbN/BVLR9FUQpxf/etpXkgYNCf1FI3tQTDve/z0iuO2?=
 =?us-ascii?Q?R+YQN96sxReQJZf2aetxFLRKaA+nM+7kb5BQDTq6qnw8hgoeSul1VRKOCJpE?=
 =?us-ascii?Q?K4OMTvp63XOs6lBxzGloyabli8qS2B4U3GmvjT/BQ6wVNLjqE8HgBfA6HW3P?=
 =?us-ascii?Q?cXuEFKkEBsm3I/vFXkAONktYkdJrx+PLIUIGrsMGZhxhzRqzM4xOdNqJxvjR?=
 =?us-ascii?Q?Gdb+SVxFLkxTy4gBL/buIqnp6z9G2rPemIJrXgPlW49PAPC/mX7gfSgpa57R?=
 =?us-ascii?Q?oSa4sQEpGGw35QTHJgpg+biSlttyGAINXxiO7W23YBMh7RTPTnGlBwdst0ph?=
 =?us-ascii?Q?REBmVaQxYgMCtnLoPn+d4E8MEH94GEXZ/4bmWntarubclg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6EcUHwjgXtSJWtT59cKAimladhc7nMKyo0kBjQr2ucYmKZNTVPEAD+y0zOR?=
 =?us-ascii?Q?JssR1eDPF6o8iU085WK0tBL3SN2afbUGOlERsnjhxy0EYVFm9+1+ypnfkOuj?=
 =?us-ascii?Q?++5DW1BNh7AFacRzFNH9DmLxv1XAyMHXRgYXOHdysRuN66qOdwq6yZiCAQuh?=
 =?us-ascii?Q?HVUnvxkW+4vQxplQ9OF72MCk+DvFTa0dMJ4gxAHASO/D6/LyevQkNfTGeUkV?=
 =?us-ascii?Q?tsgijP5VfZ7K4qACd52xx/pxnQ1BlKFVgCCX0Ih1UuVT5HXBvkRMhb4dcULw?=
 =?us-ascii?Q?kSqJi2eu/UY/rmDoX1b33VApwTmyzKOJODbmtIBWXGpt8P2BiVvcYao3jNCg?=
 =?us-ascii?Q?EeGSMrkXqPKhjgdEB8LsX1ehORSgBDLukHAyDz2kZFxd+9OQL0JZ5SnMispS?=
 =?us-ascii?Q?ekx4Su+z2Ofvpukf10BYn5aW0cncdeZa+2O3Sdn0F4cX9rSDbr55T4IBrNuD?=
 =?us-ascii?Q?lw51kZTPDdJadO/ysQImc2FrJ/Ii8gRG5+Qd4iew/iSOH3/GIXoz81ULCJ8W?=
 =?us-ascii?Q?2Ccv4XQy8LBN5uzMtOU8ZqrbskDdkkqQm+wWz7ZDIw4SmmV6DdlAqWuA2hWe?=
 =?us-ascii?Q?tbffwKE8q0jmxm+ufv1zZZCqMQqpDORu8g2NmGRDdQ3xMm6Yue+7gmoZKt+S?=
 =?us-ascii?Q?wQQPIPON541rxTIyUScr3Lq0aE1Bzh3XrKL0CUoLEJ/UClEyGxlMAz5B1bsT?=
 =?us-ascii?Q?3ONr4di4rnPKgkto03P3mPnet7EHjh/HzzDih9W9KBDhwuPhiDtA6b/NjgTo?=
 =?us-ascii?Q?B4Xwbdakpb6s9EwppiEL7NLgkN2cEIYJJ38t5ePUkxpyD/Aul8yXMFGPzTAq?=
 =?us-ascii?Q?mDAHLBwntaIpljQgg2tZ3zJZ/8CI4fzC4yWFIN9F+n7GzwJcF+20sTsIFf9l?=
 =?us-ascii?Q?4r3jCuRdKa4XojYMp0JWs2PRdW0WCdbaopofCnibSXbkQocf3OPwmnkS9i38?=
 =?us-ascii?Q?R4XKeZfj1dIPMfoiaRSdhru6UUvmgkEz7jaciZV08qFF/OLNjX80mSAdMFwV?=
 =?us-ascii?Q?m58yH+r+8ezkh+c4cpCF9H3VvmegsmgWBEbzEfB+JOp9/7mhGOwVG/lUw8Me?=
 =?us-ascii?Q?Ha/skLURHBZ0KsFE/eKXW4Mo5mMH6Pj56tHM29qRkB0VTZ+6f5I4rcq4zrPu?=
 =?us-ascii?Q?XzhSCR2aCX0OocI2bHhl3cAQhbJljck5cRjDya6x6tHo21G2/ce3Sh6L/eAr?=
 =?us-ascii?Q?XOR1D0zUt+w+sDde1JJDZUvT89XQiiMjpJWGMBftAmomPDm2Lgy/qybZKy83?=
 =?us-ascii?Q?5NwaCl0F9eEN7D+M0pQIdNR7DXeuuyqRxWmKpuJ19KQRnhSK3Yeds9sCGBpR?=
 =?us-ascii?Q?cJLr853yOfqS3UlnMGUmvI4rD9Ehj/Omm0pOSooCdgzqM4wDLm3lRZptq7Sr?=
 =?us-ascii?Q?8NMt/WRcyiYKlenPLrfqkzQOWMYkRVqa1llIsbAQ6yqwueDjnqyCZ+zAngiv?=
 =?us-ascii?Q?GreTWqf54hvGbHq81Z6OUsa6bsUKC4dF1w9RywrU7m8KgzM3e6wCWRjq7x0q?=
 =?us-ascii?Q?YGU6f8omdNOYKTObSQPwzHkGT6m+5vlKxNUu4En0wXxqc5+46ISqzPW+RH+F?=
 =?us-ascii?Q?mC/GXoRkKl4cas0YNW1dfFbYmygYTcmoIqXOfQrznEYUlZeuPoBV5+9zrYDS?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1/cWklK0eJ5BvHFQ2lgvN7AH67GRFUWNSngEcwOxcjjrI79jwYBRPLofYwLW0lrcqGvMjQQrO1rKntXCOW8U6QYYzfOKQFUv1HbZnZFFYhfLCeveLNa+CiEaEf/doqNVrPuvjzOC0LB0HancNx9f/OjlLN6dBT9s83rGrpuluAtKCxKhtks6qYegSWeurGHTxSBuPeDmdWh138/JmUSYVrgu/OJIS8LOcUY3fl1FvWdtbGPzTHrjHnFDZErHlmhzGJkVc7bL9Gz1V754Dmyk39d3p2HUndvV81ZcFjpZTR5dkxF2h326gRD+xVQoYXZbygolww8y92KAWdx//2Jzk3aJOMit0+6EhB5i60BnwLHv56fgBa8rCO2MEZwo93FpBA3xMZXt4eM681Vrspp46ch43yr7GEv6nX6HdHZBU7jPb93tT4QJ/LtXq0q8sL20hO5OfpRfUOAI9RQoD/iTBjpwnxF2WzVXfn8EKFV4MJ4lpgvfAnFsb1QuQUnjuxLDECcZAyxNYjOcaMPSNjEUtpl7fCfsmt6+kElT9rTpQylSe5InCECf2aJ5qQ2QyMBnaxmlNWW+SGS/nS5hQVBvMKdkJVGo5p2tPGo3QIjBgE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b71778-8145-4b0a-8c33-08dcc173f8f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:22.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XQiiJghoykLaBOqlzxhV6tXQRwUaWFfWPmzbymOZbbiwfFPM0a8kWhUACMM2wJm37FZcDXBdrJUbNvwdub8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=871
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: _mwame6VNS5XRcoMRfGcjQwjgA9wF9Q0
X-Proofpoint-GUID: _mwame6VNS5XRcoMRfGcjQwjgA9wF9Q0

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The may_expand_vm() check requires the count of the pages within the
munmap range.  Since this is needed for accounting and obtained later,
the reodering of ma_expand_vm() to later in the call stack, after the
vma munmap struct (vms) is initialised and the gather stage is
potentially run, will allow for a single loop over the vmas.  The gather
sage does not commit any work and so everything can be undone in the
case of a failure.

The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
call, so use it instead of looping over the vmas twice.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 15 ++++-----------
 mm/vma.c  | 21 ---------------------
 mm/vma.h  |  3 ---
 3 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 49d9e95f42f5..012b3495c266 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1376,17 +1376,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
-	unsigned long nr_pages, nr_accounted;
-
-	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
-
-	/*
-	 * Check against address space limit.
-	 * MAP_FIXED may remove pages of mappings that intersects with requested
-	 * mapping. Account for the pages it would unmap.
-	 */
-	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
-		return -ENOMEM;
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
@@ -1409,6 +1398,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			vma_iter_next_range(&vmi);
 	}
 
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+		goto abort_munmap;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
diff --git a/mm/vma.c b/mm/vma.c
index 5b33f7460ab7..f277ab1b0175 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1643,27 +1643,6 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 	return vma_fs_can_writeback(vma);
 }
 
-unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end,
-		unsigned long *nr_accounted)
-{
-	VMA_ITERATOR(vmi, mm, addr);
-	struct vm_area_struct *vma;
-	unsigned long nr_pages = 0;
-
-	*nr_accounted = 0;
-	for_each_vma_range(vmi, vma, end) {
-		unsigned long vm_start = max(addr, vma->vm_start);
-		unsigned long vm_end = min(end, vma->vm_end);
-
-		nr_pages += PHYS_PFN(vm_end - vm_start);
-		if (vma->vm_flags & VM_ACCOUNT)
-			*nr_accounted += PHYS_PFN(vm_end - vm_start);
-	}
-
-	return nr_pages;
-}
-
 static DEFINE_MUTEX(mm_all_locks_mutex);
 
 static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
diff --git a/mm/vma.h b/mm/vma.h
index 7618ddbfd2b2..f8b4d3375a5b 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -305,9 +305,6 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);
-unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end,
-				    unsigned long *nr_accounted);
 
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
-- 
2.43.0


