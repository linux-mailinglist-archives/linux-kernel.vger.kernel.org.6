Return-Path: <linux-kernel+bounces-206628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99619900C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D76E1C20755
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DBC14A4E0;
	Fri,  7 Jun 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AdWd++sl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E40s4gzI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB6149C55
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786473; cv=fail; b=hBrQ9TGtVYRPs+nYy7n2wdqC0AAieNJ2C353X8eh9FmW9LcfSZbZUno23RXFWhnIY4XiHzSyN3IQlVRQ4GnEE0eCWcrVrZDn3Me+A1qfnKO2U/KIpi1LuxRFWBApHSdAdxrqr4FdJ7n1FFVrOnH7HXKS5GggOylWajbtCD0N8UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786473; c=relaxed/simple;
	bh=KlL5+VNyrid3614umMOEllzT7+D/TWFoc41uw/YeR5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WzyvBdy1TpEpJs+YHsv3yCviTkEEiftI+rGpsX3uNMK+/+Nc8dfh7r2zp6cSpOhB8wmqMrDDA5H86bLdOwsdEV84aQRfqoX7QfIm6xF5V+UAcsgUIugXLmtKbQubqpNKR/0mIOSMnJBVvlemoX9T/7O00vkUKMU/MME7Umc/VU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AdWd++sl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E40s4gzI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuYTW020017;
	Fri, 7 Jun 2024 18:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=67y5PxiIBaFqmkSpIhwq/2i8iScXQ5Koqe6KIRjvNoA=;
 b=AdWd++sl5jK04kz1e+lT8/38dD99GXF//hrOrUPWHR+u/qeEcCAN6rtVXXHI5tkOMYgG
 VBIaU36qkPBTMpYBmiGwnj6S5MoiW+CQmoWmuLvAi8hG44HKQSOQArV752Rx3DpcyHOZ
 02ruW6h1j3V+vhVa/qy+z84tTcnq4A4EffwTRzDAAMJ6ywYmBXRC53d76caTvXEj0pSK
 DhcUbXFVcvZwXlv7A33QjpsSBk4hmSxvKYOeF9PeKdBTraPcOTdq8jgQmw7SDuD6cm+1
 GogZKdqZZilLdyY7EVsv0D9CHeT6MA2aJ4Ftdw+MvReKCmVW26OSC1f6yl3fqnmX8MB6 PQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsye9cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457HOGFv015573;
	Fri, 7 Jun 2024 18:54:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjh0eud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTA0jmM0qv3pTPn6KqN9vahr87VCZKmjNWzDEeCxO9o0Hr66+xmy2h/XqfpJUKAFPE8isJZMWTCyMN7ttge0XqzLgQEOrr7RIxLejJl2xXyLD0t+AB/SZI9X+egy3g7O4TR87By4jbhcbbK3Pgto4EixIFZd1MFsUi1QseTgaI7EAAKwGZO6fqhR3gr+rzYJXmuv6guG0jj7v1kqlasyjP0tm9jqaSGrENzRPrEuk3gNqmsN0pzrl2ruBq2bNcJzbVH2/R/C2AaJT9hdbZD5TrL9mhJz/smhaZOz5i0hYntsTtXch01BoxznwihNlCTb8GDxtbZWd0chhKGoe/+37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67y5PxiIBaFqmkSpIhwq/2i8iScXQ5Koqe6KIRjvNoA=;
 b=R8xSwdz3KJEQPI8+kF4g6QhPQyM3o7yFTrlmNlr/q1MQczZ5jhUU++ocAqt2XQT/8qPvbDPOq+Z7AI3HuyIaMJQgqIJ/3HyeDU4jIZkqgB9ej/YrrDz48Mvk51v2lGgaoQnspwcKLYBBN0UEk4ABgNcOvIilhCWes77900ME3ihkqpgEz3TZvWZc3jjIkZwonyBvZ4x0t8gwj2uE69Prjs2BAVh3TqzQaWl45HC5DeQJpOVTKRgOF1a8UOeB93ZjHXoXaoKZRq1/kUsePNeZHQ7p8F1ylljYp2CTpZIw/9OxLpwwG10OyJKnUTAsx468xEHvHmpY0QGTVbuvq/oM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67y5PxiIBaFqmkSpIhwq/2i8iScXQ5Koqe6KIRjvNoA=;
 b=E40s4gzIaEb8UIjTDjEX+71yw6TWDX7kSYs8SgalmXFeY4ccBlbrUttKfnRK+5R94fbV4TgWnHQ82qvm546TTbVRPppC3ONYEBLIKO9Ol5tXYcnezEtq7ivZMF/q0lDoE9c3S/I8YK2NYzNf3/ilkEHfALevyw5BVWGqmzCAhxA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 18:53:47 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:47 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 14/16] maple_tree: remove node allocations from various write helper functions
Date: Fri,  7 Jun 2024 11:52:55 -0700
Message-ID: <20240607185257.963768-15-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0354.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c46340d-80f0-4b5f-cdd7-08dc87232985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9ezmmxu1GnBA3A+AVrTtrAu/GypN3S9cfCEQgErY+Bw6KivOEan5sxOUCUQS?=
 =?us-ascii?Q?INx2GzXoziZsa0rOh8mEe3kEh2D/soFQgCzhkLBUQIvWz2Qnm5F0SsmSIHWa?=
 =?us-ascii?Q?WAbFS00eBdMn8Gb48Z0VVoSf201Kt7nup5/atfYsiYKCxeNsKSYc+e6Mrtkm?=
 =?us-ascii?Q?juOrQFx9YQx2kyY5eclM7HuNDNOUBoznc950cmQ5CQ1rkf0pKAWpnpvmutlk?=
 =?us-ascii?Q?Sq51P+0XS9+cO9y1edgpm+fGg+UeiuJ+vLWEcJnBbwR1IsUA8DemQW9Ypwya?=
 =?us-ascii?Q?UFyDOaB8kRrTTEs1gGsCkN3SRMOGjHwOfuIuknE4e7mbvghGFx/5kn/aoXB1?=
 =?us-ascii?Q?Qdfnfd8JOyi345y0k5wgU2WXruaN06NLIqbaFFKtoxQd495smiN563okHCZj?=
 =?us-ascii?Q?nizALUhE1pRGv8QGnvUpTqsRdEZxqruM0AbWI7Ia4hpZslEzYfnYryU4U0r6?=
 =?us-ascii?Q?XUyOoKqny8HNEg5prEL3vP1UGwlhztaccjbOk9BmOWY7pDZWkMjLmu4dbbf3?=
 =?us-ascii?Q?9QPqsUv46Vooqht9KNyV60gqsJFi87F1iKesXrRb3GbpIlE3fTe75flEQqkx?=
 =?us-ascii?Q?HfCHdObDp2UmhGv7oj++vQdF33MjEsEVnMok2k9Vf3h5tTiVk9PVy/Xk5Gqe?=
 =?us-ascii?Q?SkIHL5rRmSCxu3/mmjMwQpOqgN4OdbDeS5/4m+n1bPHNAWKDfdS55eOvBNss?=
 =?us-ascii?Q?rge1bItBI796H9qvL3ninvbAW8rZOktyNRQXEPD5kaLfBW54Mf3xl7hHRPzE?=
 =?us-ascii?Q?XLCsgCu+1nzWaK6fpArPuwaRemjmECoMGmjQCyDPuJNbbzV8rP8VVZy2hpwD?=
 =?us-ascii?Q?xchog/bp7oltH1vYsmzLG5/FlkqXDw86JbNXK/SXTxch71LhOiMGuWgJVJqh?=
 =?us-ascii?Q?+7pPprveEh2kQ3qhgfZ0cw1/B2dN6aqKdAxSRVG3qExglnusMDhQnHWMkWrU?=
 =?us-ascii?Q?kYSnOHAQX5qvqRpIc4Pd3O5LTM6RZE0zlkVoRx3o8qIwLGtgb3nOntBr8R/G?=
 =?us-ascii?Q?ukzaMMskxBfyxBUywWG496Qydgs42o6BVPfOr3khRDmpJVwlfeaGYihR3o50?=
 =?us-ascii?Q?o+u9iPtHCJf28zcLN2IGwFkelQak5ouzE474nyymG77jgf4cw6S/Ie/J9OTu?=
 =?us-ascii?Q?dfiMNU/9LWIEO9jntHtcIsAURSlXfx6ko/21LGnw1GGwM3+k1hdMe9BUJGRY?=
 =?us-ascii?Q?DO+LRz8cxUUcdfdrH6KuHkWBj6nxyKzm/e+5PLafiVzoaSKvwI231t10MtEw?=
 =?us-ascii?Q?lnnqDHNszE7gO4XbLoEydcTygesQYoaSrxHpDR4pxCIJOT5nYCc5oUq4QyJO?=
 =?us-ascii?Q?lPmr0l3H8QbAoYVh7qIK4/5F?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sw6wW/Dop2S7OEuAPegNqQzIZ/l3BdQ1SnxZh3XhIPYjK//dOs9nUwUuw+l9?=
 =?us-ascii?Q?Ff8Q6CbdrUtFqRoyc/Yis90yhUZ1OpzQdmPGMFIxNOjgwP3JL7EExdXE9Sns?=
 =?us-ascii?Q?DfIfnwSS9/KzWtlfVmzo7/FT4wq8xhTz9QubSdSjx4gLmTSFVpzKhWpWdWm7?=
 =?us-ascii?Q?7KiC6BTkhSOw214BRoNjH8zra0qH10eNiIr7U2ufOqBr2i4VE16awmGXHhOJ?=
 =?us-ascii?Q?miv98bbnaAzXuw9JnUdz9FBNy+/8GEI9rgioX90+cwwoY3NbvcBTViF5HRpW?=
 =?us-ascii?Q?CUAeLJjUrCnKkojaKf9GHR7UwrDyxNuSUQclkoFeZb8lv5+vuvq+EcMH1H7N?=
 =?us-ascii?Q?ldujO0++8cZNc6jqFqrchQ0Sk2iljf6sGPIEXjaSczuw7s0rc2Xyse5oZiAh?=
 =?us-ascii?Q?mVd2bp8mXZ0c9pWNEr0tBiEQHbK5BIklOZ4h5Oq6j96kLLGywgXEvhXEuZsp?=
 =?us-ascii?Q?5gFFnHBfydec3mjpYRP5T9bxCi8eHyKJvHIKCK8SbFZllPPy3dKosH4u3VGX?=
 =?us-ascii?Q?1EVw4EbxzfiNCnAeCS6Z+sRloS/g/pe89Ru1+at7MBlNRV1BkwaR5aNhf6zw?=
 =?us-ascii?Q?Gt1owd6hsPeQh8/aieHgToyaeD5ZVrhRt1PvDZyTJWg60ZmlT7SP+rLWLNXh?=
 =?us-ascii?Q?SC10IXNGynRmei8J84CIrwKcEH2m3Cn819OstO/2lhDenOqlSfgelU/x/Cau?=
 =?us-ascii?Q?GbwsRlfs2jQACd/cX6JgXZtLek21DBupDLAGsmg/swJdPWULQKXXagpIsFGi?=
 =?us-ascii?Q?xm5TxOeB3yw5wbhetHybLm7izNKktgO7smV7BF/rj6QGvM6KJuXfphDyyr+c?=
 =?us-ascii?Q?NkJhK1jJU/s6VZyNwbWfkkpvyyhwOclvrWMQEKTfJdWERWLYyxs92+opACS5?=
 =?us-ascii?Q?dl8U8/s7QG/MEzOmaH42YDtcdGpVVBQ2RhnfTHg1JTV0tefp1JEcjdjlEXqM?=
 =?us-ascii?Q?pbeQhl6+CaYGcdfIq6cJaQa7EhUoFYCqMGf4emhyi6T6PlY6LT6vtcv1YoSq?=
 =?us-ascii?Q?69DHbM4WI1ecs2Fi7psiX1Q50jFoZPr9v42m4I4SVtik9TP8nXQIj/4NPxWC?=
 =?us-ascii?Q?hXaM63cHgo5Ow+do4OeD5Ba7QlNh5kx0KP6vOv9/xQDSy4VoRUzNotnz9ftl?=
 =?us-ascii?Q?B85lhB7vEyV98VaMC54ZKNiUYo/JzHTVcW1S4G28TaksjtCYMLv751FFcZAG?=
 =?us-ascii?Q?5/jsE5RmV8LgaOu7J8UDsBWr3+NxE8rfsc+tWxsV1j0EjrwvVOLm50KDphQm?=
 =?us-ascii?Q?hPRAowleSNUsU9rqZD8GauXiNIBQkQzDOvGinPQMwj+JpDWkkKi/la4onrCY?=
 =?us-ascii?Q?IUQnrrgoLv027lU2sOhMmkQmF5eDJL8Xui8IsUc8JHKmsbtcX50EKyXRcyPq?=
 =?us-ascii?Q?/1hT50ts4AqxmU4y40LQCzPBlJYJpUA5wCMOuKBHAO+cZ4OBNUQLkPhKutWh?=
 =?us-ascii?Q?6a3VPfJqIInDXklE94BNULpyQKmn66CDEgOWmNeRu2lsSyV3gnF/DM4RI8r9?=
 =?us-ascii?Q?ApvMKxEQ/zKnxaiRoy9EvvzkQIpfcMVCd+Grkpv2NcAop/6i64Xe3z8tODTg?=
 =?us-ascii?Q?hOxTLxqvPNKgY0+gtCgze5M5Ezy9BPSbje/DDeGxvsP4N/VuN0duEjS2iGJC?=
 =?us-ascii?Q?G2WwRNBICog4cfrGzbuiZ/E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	d1oZFXEMa1p6LdLBaefg9l2+IRTK7ewyJi5A6wfTgvGtAzMZ4Mms/k98K3OmJKWAGyP2erGpOzCRa+mG36C0VdQFguxjVGER81QT49TE2sgvyX4+3J8FmU3qLfDxn4U9xZXHbTAHPj91xsscmDJqrUyyYkkYTBY4n9cO2H29kssuzbsy01c+Ssx5ukHYckZoR1pzK0JQB0TlSm4E2BS3HlJynbPW8ZCINpTi9iaVqZt9NIP3t/RjZlhg3RcUsCeh1+hkF7F6u5EYrarVuBsP1M4aR+HNMPDDX8OxRMZIFYj5ZN+gf10e/Z3HrbZ3PEIC1j1I86JNyJRQdP9OXPSTQGhIFqTMP3H0xUad6SFDrzucm44SA9n+8DqFi84pEGfRwL3us8CCbj+yf2Ei20Ym28tYJKT922uqwyXZJ39aSuxRsviPOK0LGRW5htJI6jKCvxTXLe0iYB0CTwF9taP6iWPZPR6pMEVkxnE5vHdmXcX9N7FZde4nb6WXUyXAc587BVoruv7tpnO1C4BPx1HVgL58oepuw2TKKgK2ZuFzLsoddaNLPTCsEZySz/AJEV4VxxCFwa/AZTGZ58cOEqgeXrwd5SOVbqpuTNli+ReYz44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c46340d-80f0-4b5f-cdd7-08dc87232985
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:47.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIMLdvuH1pZxBvoqQe4ylANKlkUJHIfB3VNR01bfU0xKNNhWSs0dnkVBnCXyYSJWrLPT4IcfugYDN3Xz6O6fFnHegWF/cKvY3vEA+9Q0UqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070138
X-Proofpoint-GUID: ZG7X4fZCJIAfj4i3M2m_xxxNRfgtGhw3
X-Proofpoint-ORIG-GUID: ZG7X4fZCJIAfj4i3M2m_xxxNRfgtGhw3

These write helper functions are all called from store paths which
preallocate enough nodes that will be needed for the write. There is no
more need to allocate within the functions themselves.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 92f133ea5f00..7e1f64490662 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2976,9 +2976,6 @@ static inline int mas_rebalance(struct ma_state *mas,
 	 * tries to combine the data in the same way.  If one node contains the
 	 * entire range of the tree, then that node is used as a new root node.
 	 */
-	mas_node_count(mas, empty_count * 2 - 1);
-	if (mas_is_err(mas))
-		return 0;
 
 	mast.orig_l = &l_mas;
 	mast.orig_r = &r_mas;
@@ -3029,11 +3026,6 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 	/* set up node. */
 	if (in_rcu) {
-		/* Allocate for both left and right as well as parent. */
-		mas_node_count(mas, 3);
-		if (mas_is_err(mas))
-			return;
-
 		newnode = mas_pop_node(mas);
 	} else {
 		newnode = &reuse;
@@ -3341,10 +3333,6 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 
 	trace_ma_op(__func__, mas);
 	mas->depth = mas_mt_height(mas);
-	/* Allocation failures will happen early. */
-	mas_node_count(mas, 1 + mas->depth * 2);
-	if (mas_is_err(mas))
-		return 0;
 
 	mast.l = &l_mas;
 	mast.r = &r_mas;
@@ -3444,10 +3432,6 @@ static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 	if (mas_reuse_node(wr_mas, b_node, end))
 		goto reuse_node;
 
-	mas_node_count(wr_mas->mas, 1);
-	if (mas_is_err(wr_mas->mas))
-		return 0;
-
 	b_end = b_node->b_end;
 	new_enode = mas_new_ma_node(wr_mas->mas, b_node);
 	mte_to_node(new_enode)->parent = mte_to_node(old_enode)->parent;
@@ -3474,10 +3458,6 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	unsigned long *pivots;
 	int slot = 0;
 
-	mas_node_count(mas, 1);
-	if (unlikely(mas_is_err(mas)))
-		return 0;
-
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
@@ -3746,10 +3726,6 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 		goto done;
 	}
 
-	mas_node_count(mas, 1);
-	if (mas_is_err(mas))
-		return 0;
-
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
@@ -3812,9 +3788,6 @@ static noinline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	 * entries per level plus a new root.
 	 */
 	height = mas_mt_height(mas);
-	mas_node_count(mas, 1 + height * 3);
-	if (mas_is_err(mas))
-		return 0;
 
 	/*
 	 * Set up right side.  Need to get to the next offset after the spanning
@@ -3898,10 +3871,6 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 
 	/* set up node. */
 	if (in_rcu) {
-		mas_node_count(mas, 1);
-		if (mas_is_err(mas))
-			return false;
-
 		newnode = mas_pop_node(mas);
 	} else {
 		memset(&reuse, 0, sizeof(struct maple_node));
-- 
2.45.2


