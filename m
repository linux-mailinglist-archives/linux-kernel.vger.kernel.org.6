Return-Path: <linux-kernel+bounces-297886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C695BED9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07071F24A30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962041D1F56;
	Thu, 22 Aug 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cp5EN4mF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RHdtwA1G"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64B1D1747
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354817; cv=fail; b=AaRexCxhbnA3hgTQX3LdyOxuj6LiaonoiV5Xav1P/sT+2OGyImS6I0sBVKyPb/DCJ1sacKIjQuCVcx7ydvV6q0A+4y+gQNJQ8VVumxzkYyPsXF6l1NINUHxpuaSe2E7pfnyryjQ/uUuM5m39hM3F3EWl1WTMddiH4llZbGQ2NIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354817; c=relaxed/simple;
	bh=WPT6n1iz4tvD/2ljpDnFdpTOJpEDPwLKsJsKMIdTAr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rc1sGbB9MuspgtOxmcl7gmBufqmgN8SLYSEnrfXzO7FoylG4RDB9eVdJcVuOxu7ZSlYMaFzAT4FpPgk0Nw6d3poA0FkDMWIIuczs6jQcoaqOwyMVQsuFti1dIZGOyGT87gxLSyJLBJj8CSrbdiWDCjADPhshJWqg7nIBofB921Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cp5EN4mF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RHdtwA1G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMXIP019213;
	Thu, 22 Aug 2024 19:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=bp49Hgw37mOv99yWoEdLs2gNO2kzyBNnJw0rISKdOsU=; b=
	Cp5EN4mFaDleZt1mTbvmU4ZMhU5nVN/1CUcl9h2kISOOsazZKGw47eRSBAVvEakS
	vkkmqb3RQFAjw431XgIZbSSMhnH+zhIMpe24US0v3AjEFiti5PL/KyGYGUiHvEqH
	T6U4mrB/lQc7wsjca5/teVh5Snqfe1XU8erVChI4J4Kq9ZvNcHMTNNAgM0DnBfqv
	qDIGZx57V7pc60cQYLa/S+YGLfKYxY3ymtQ2ll9m8uU/TEjvmfvkSZmZD3T2vRO2
	CR1qOiwf/Cp/FhC+slqvp0bigUmEEJ4lGJSV7hvjyrYqlrsZUj63tMtO3SKSHQIy
	d1ZkXtZoK2D6E6lpagWCng==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45jwah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJDie005125;
	Thu, 22 Aug 2024 19:26:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu086e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWARxIBNXVD5p4gCNQ+CI/WLyREbzsdHVJRHuFcWu0bRAcm+U8kKNhlQ9cx20yGoEW4VmGKLQeAmzLmBvlwVy6sIwIuprnhC+e3LT4YQ/ISMSL1Ctza8BtuxOI9piuLtqJVaVcnNM4YL0Mn6T+UjpCOk/efJyuBzXZGWS9pyucyv3ohFgqarzjsYBbhV17/2FnqroAPhQMvxEixg/a0Zds9yuRJsnSWf7d+OdCRNQ9Hizc1E/AuzuS0oqwRw2WhnOb5iKV1qEGOwTMIM+DRZck+gyTPkBKQmjvjFWHfAE+4utzbmRxye86ZclhSGeeGwUjfhWRwxEi2amzlShWWlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp49Hgw37mOv99yWoEdLs2gNO2kzyBNnJw0rISKdOsU=;
 b=dgtTjDDhFHZbnci8FkEK2Ng7D5CzrtCsPONwWpabJj1evNPKTgDYaJ/o5u7s5BZdZaqokfIs4GHPWlpt1js0WvR5l3+fyMGN7fklHxHqDqmMg2bCPa2Ubt4e/F9NH6vRF5jXYcscqul80clFMDpcamvarAjfEz9R3QKNGfNABV/52fMHtOqCrI9ixKpYUZzRQ4gfFYDYWlMOBAujmp8wC9fPUqkyP1MWBF5YmFbHnT9nCsco54p1pEfQtmeUwkIpLET97HNFieF2cdU2sMNPQ9xtZiyN2anR9J4n4bN9muKVTJ6wH1CJoJQv5KI6iOnekp+N6ond6HJNTA6a9EZZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp49Hgw37mOv99yWoEdLs2gNO2kzyBNnJw0rISKdOsU=;
 b=RHdtwA1Gb7ydDEHldNuTwW/iqzp2dnnfAfJqPVn1kMAgf3nF94tThGgoJWUfdRAb5sdTk0UbyVYnNBqT11qPchuto9aS+MkSxxQKf5HfvVGahxiLv3yH+tmKGOnkNxfVDfnhZuLlnFUjgBdEZ3utdo/4jyuczpm/9SP2zLwWcV4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:36 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:36 +0000
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
Subject: [PATCH v7 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Thu, 22 Aug 2024 15:25:36 -0400
Message-ID: <20240822192543.3359552-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6974ce3e-ed00-4bde-2b2f-08dcc2e05692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0oieusz2rCb3WMT/OZyFsaq4SnpGvafKETOgnUqQQtMKuikgSBBqq8wQA3BO?=
 =?us-ascii?Q?4WLq1sgMaAgb4m6hrg8cAai2pYY92bq1bdaGGtw8e17rWeA3UHo6F6+OCp97?=
 =?us-ascii?Q?dLA0cnj+NR3l0mm7vmGC2EW9+Glt8M5CafkJYugTFgUCF9qziGS7tRsSZUoP?=
 =?us-ascii?Q?iuK5MRrKFW6vvGKsi1YpW9lRUIeeNZWStapYSZ1zmcmRBjAucu2rK+/i59Oj?=
 =?us-ascii?Q?LoK9L1s03fAzVYEcBgfLmDx3ZWDa2jfN55FzbNK6PY8dOLp7vqejpy5pMLpT?=
 =?us-ascii?Q?gaE9XxyDbvv7Ye4ilALFwZiDiHfDn5OFW6nAosnicS5exrbxHwg9Dnq4pTYv?=
 =?us-ascii?Q?opTb4GhtTiyC2cmSmlaZV+nU+9Lu5FImsr9paYun92leg7yRpFzyQbB8QerE?=
 =?us-ascii?Q?hDfqF55qCFFcfQsExm9j00/Q8CmlujmSu2Ae8QOeF27GjVaHNmM1oT5GjzYg?=
 =?us-ascii?Q?FQ6/jN2KPPacqQElYbtGEgbNEe/HeW6DjFliKvYPuJaI8nT8c0M1hMmshSee?=
 =?us-ascii?Q?f3zMwhRb/33R2tyM7ncN5sMCBCLWUAs5BBAYtyxgcSyAxWMiJ0HOndXoct65?=
 =?us-ascii?Q?ECRyJ94aR2uOt/jfFbWd1lU8ijzAyEFdU4zPPeCyIdkNOTIoEHCtU3Rq5ia5?=
 =?us-ascii?Q?I+1EEnI88/1XURhNx/RCu3aMxHteE4VwX9Mj/Xux1837VWjmwQCUfRzzflde?=
 =?us-ascii?Q?X5VbAIgpVLTUsHkgoDgLYsuxNROgtIRvJMThrRxs1mrURHd4rdVykEZYTbL4?=
 =?us-ascii?Q?IMqmj+5DEzKCel+/WlZDINwHSxwtvFPzGn9q+6wjXSjW9FMJrTJxeBtP9BKE?=
 =?us-ascii?Q?H+RRV9dTctAHRaW5CfY1ZT1UJP3fn/DgpVfmBqt/3m2WpykMoXlDTQ8/cvZB?=
 =?us-ascii?Q?+UKv+F09JR4E6XGkbPlFJo8AlCoULcNXG2e1H0lROTmPTnUsvI0dwxU1/qeD?=
 =?us-ascii?Q?0XGwn1bq9ukvcfa8kyrVA1UMbrnZEMwvUl/iWnbS7arYtpLW5CEe4rn/xhbm?=
 =?us-ascii?Q?3GnANIhNcjDDrLJd+/bPL57cwzVVOvmkAt/+/uE3rBejM//sR9uQ1nNSWKsG?=
 =?us-ascii?Q?fb662EazbOtGN4tpzLRZJg8BAkHdpF1yaESklNsc64wtuqq1H/WeP0R/9t2H?=
 =?us-ascii?Q?Gn8YfO3LCQ+yO+jiZDDS8FZyJQOoCUMNOto+jBcChbOcoEkqIZZ+j0ig2ueM?=
 =?us-ascii?Q?6ihjbY9cF+DLwGpZvDxpPPiENpSA51PqHow5YG91ml9754bRav3lj4vUlMSA?=
 =?us-ascii?Q?Y+kh7yS76QsivmcoFYYYV7bvWrEKONUkcKesdKf/QqaBAJnrwPQHsk2RbniP?=
 =?us-ascii?Q?sdLO0vrdzqiYt/qdkJcFMZy5ic4ZujiBMYEryy3I/0hCOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nS8sgHIuDVzVqnjlXJZhlH20N69Qn5IDagZq+t9w/RRaTXIZCMbFXEtg42N?=
 =?us-ascii?Q?lvI3miLSSlDOU4wQPLe2TDaRThUhtGzQZpu3+9y9PiCDGPWMZ/ThJ7NECXnh?=
 =?us-ascii?Q?aSGeW1JisRXicfsRjUKOzgMZQME49uDYflNCGXnhYp9O91Df3Cq3VJJv8ddU?=
 =?us-ascii?Q?yIwF5R2WlGwjJyx63V3glHyJSYHnYcEuBkW58W6gyboKMtGvTKFk34oORZVl?=
 =?us-ascii?Q?aBSa6X34wLbdJZDngAZnYwuvCLRePwb3U9Wg1Nvn9MQenTAuPSxEHSyUxhhn?=
 =?us-ascii?Q?b2Z2OXlOKWGhpYySkL5OJdhJH/+b4d/75Rhgh1vcvAnIou3n0hQ3iI3B8KUc?=
 =?us-ascii?Q?YEHVXg5azuKMaQFB+E/1UHewVAP4NGPsqRWm276w/Ska6MJwEBwotKqkx1JE?=
 =?us-ascii?Q?ENSKJjuMXmiA42bAPsnjER94rMdbdhrbzm7qu5I9L0OrOH9SncArcBLz8QmB?=
 =?us-ascii?Q?WBTBOoNqL/fEbkr1CnPdsbOmGF+kpg0IAb/MbEX6gX8kJ8p7woevGHqGmwoD?=
 =?us-ascii?Q?JVOutwtZObZ4Ag9hIZMpytO8gFlyJJ/X0mwVNVaZxyGkAZnYDWGwNaxC4VWw?=
 =?us-ascii?Q?8J05yzY3qboMx+Q8wPxUo73HTwmvWFf451RLi8O2clriUkDJr9pRmYXtZqYv?=
 =?us-ascii?Q?7u+dfNZ3vKRoAsWndOMwx2Xv7JRRsH8WHu6gtR61z326pO7z4pnuui86Dljh?=
 =?us-ascii?Q?AdiH6EQ6E15ajrygLVXn8mSfWRUzZVZWXn0FEPLqDQDTm27K5J6dTT3oDoY5?=
 =?us-ascii?Q?j8w2w2sxzWAW8+o9v9F9nbpWkOoH+wjiG0TpGr9uQQR8wqmq9+uxI38z6t37?=
 =?us-ascii?Q?qKQhiXbG8gsVAjU3+92i1q7yXF7ny3FrtHWakktVcOxse353Fxs9jFGrhUiP?=
 =?us-ascii?Q?x/BDgEDodtIIqjBG+M4n6a8VPKkitMXLrbnJpnnZsjcXlefmcwmYHagTPzt6?=
 =?us-ascii?Q?UnesD1LJiU1lMPuZtJnFLZbUGgV2VU5z9W+lSvVcTKaW/11yMsicy+Yo+hMW?=
 =?us-ascii?Q?9666D/wwC8xm3WmR/7DY3lvGVpzJPKe+Wb2klbeEqswz5Z12OjJN5Sb7fAkv?=
 =?us-ascii?Q?lCN/3Yrakdu461nnhuhIvf/yScf6ZI1KOmd1BWRshsEEwcovdVjPAOmL3sHV?=
 =?us-ascii?Q?DdqlUo/ANCBC/EU/HyNe8qH5C/RuH2ESPcaEjCXE7C6LKpeko2U9uyOZG3jh?=
 =?us-ascii?Q?3BFgd0vwmqf5lMYqW6RFM2NE1Qdi2JXtp8G5Jpq01jXTrAs+Ae4bD4VAYfOl?=
 =?us-ascii?Q?IbXYZflQ/byXLakSdJxuvKmc+BD3Av8u5ufMsTtiuyDYQ7R+90D1wLU6SKkA?=
 =?us-ascii?Q?K5urjEdvF3K67o7CI+Jxl2OcQGhw6YMrLGVUDfVr75iNgWvY1KpW4TKdZPul?=
 =?us-ascii?Q?2bSvA75DJmYHZNeH1rDsG1i4xK9T5FNMsnZnxALFHan5Sq6bxxznVbfUVbFU?=
 =?us-ascii?Q?wqDsfJWhe7gDBYbzgVIa1xUxfXbMeN3mDwaw7UsU+eGKvaWHXjR1Y6dkTW5M?=
 =?us-ascii?Q?QFSsmw8yES1BqqbX42xl109NCY/wHSZTvZH/tc2IKpwkUrALS3wj/7WOSfNX?=
 =?us-ascii?Q?J9sSf/0+UPjX83VOuoQT17UuAY0JbRKLMPV+pXcBQAr2rYT69aixuC9f1u4x?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UiUYVzC9rTJTv2LES7QtLiv5Rk7BGwxRIrgajWf98sXrhX2hgDAgyII+L39VjPWW69P3rb4gRjh97uv1T45AVumIHcZeE0W/vP2ESnXg5VNcMApV1i8+4JDlh+mkq4r7aGSU532JnlobHgV6N0XBK0yekBSF8Vvt/7bSBe9NbSpMfFNeb3HlHZO5TsrygExqoo0eOtcVGG+721YpET2S2rYS7wkpAFojGYzdBtubL2wXOxfLJUiK6QE+juRlp3sZGLGncwp9A5oXKHzYWP5puCRPZZti2yqpFnC0YrlolLBiblPTMnzHlcYqlazh1crcgXEhC3pURvrw8UaiL07wrSvSoz/R4Zu+TlS24ni91Zb2MuDS5aLLRK6ZA7/bkE0SK5GczXQ40kqY4Hvo7ZD07iSBAe49vHoXPEryRQoXFjwxrihmRyQagryn+uEWEr5qdxCr+XxbGlmmm51jIIZRugslrVQm0/4dA3v1T6ED9J0Un0wEYB6eGYgkERBwNiR1Su1bMODAW/ybbcZJULPyBYCTpQiFDxji9MjgG1/m8SvedhA4lo9Jz6SGcyMhYGReIVA6GCZYyI73LiEUIeEGboEaeHJSzjhrSMxa4eJG3QE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6974ce3e-ed00-4bde-2b2f-08dcc2e05692
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:36.2041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1zW/WZxso9N7/ZlUuTmPyTltU3rjAqtOUkqkHUFy6ET28EjQO7w8D0nMCZ3W9Ktlkg2dHntInbC6i649Mls4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: UH_k-W4LfbNaNtCA9yaoVaI4_cgwOAQ4
X-Proofpoint-GUID: UH_k-W4LfbNaNtCA9yaoVaI4_cgwOAQ4

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of zeroing the vma tree and then overwriting the area, let the
area be overwritten and then clean up the gathered vmas using
vms_complete_munmap_vmas().

To ensure locking is downgraded correctly, the mm is set regardless of
MAP_FIXED or not (NULL vma).

If a driver is mapping over an existing vma, then clear the ptes before
the call_mmap() invocation.  This is done using the vms_clean_up_area()
helper.  If there is a close vm_ops, that must also be called to ensure
any cleanup is done before mapping over the area.  This also means that
calling open has been added to the abort of an unmap operation, for now.

Since vm_ops->open() and vm_ops->close() are not always undo each other
(state cleanup may exist in ->close() that is lost forever), the code
cannot be left in this way, but that change has been isolated to another
commit to make this point very obvious for traceability.

Temporarily keep track of the number of pages that will be removed and
reduce the charged amount.

This also drops the validate_mm() call in the vma_expand() function.
It is necessary to drop the validate as it would fail since the mm
map_count would be incorrect during a vma expansion, prior to the
cleanup from vms_complete_munmap_vmas().

Clean up the error handing of the vms_gather_munmap_vmas() by calling
the verification within the function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 62 ++++++++++++++++++++++++++-----------------------------
 mm/vma.c  | 54 +++++++++++++++++++++++++++++++++++++-----------
 mm/vma.h  | 22 ++++++++++++++------
 3 files changed, 87 insertions(+), 51 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 71b2bad717b6..6550d9470d3a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1373,23 +1373,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	unsigned long nr_pages, nr_accounted;
 
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
+	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
 
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
+	/*
+	 * Check against address space limit.
+	 * MAP_FIXED may remove pages of mappings that intersects with requested
+	 * mapping. Account for the pages it would unmap.
+	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+		return -ENOMEM;
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
@@ -1400,14 +1396,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			goto gather_failed;
-
-		/* Remove any existing mappings from the vma tree */
-		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			goto clear_tree_failed;
+			return -ENOMEM;
 
-		/* Unmap any existing mapping in the area */
-		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
 		vma = NULL;
@@ -1423,8 +1413,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
+		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto abort_munmap;
+		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
 
@@ -1473,10 +1465,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
 
 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -1485,6 +1475,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
+		/*
+		 * call_mmap() may map PTE, so ensure there are no existing PTEs
+		 * call the vm_ops close function if one exists.
+		 */
+		vms_clean_up_area(&vms, &mas_detach, true);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -1575,6 +1570,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 expanded:
 	perf_event_mmap(vma);
 
+	/* Unmap any existing mapping in the area */
+	vms_complete_munmap_vmas(&vms, &mas_detach);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -1603,7 +1601,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (file && vma->vm_ops && vma->vm_ops->close)
+	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 
 	if (file || vma->vm_file) {
@@ -1622,14 +1620,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
 
-clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
-gather_failed:
+abort_munmap:
+	if (vms.nr_pages)
+		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
 	validate_mm(mm);
-	return -ENOMEM;
+	return error;
 }
 
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
@@ -1959,7 +1955,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, true);
+		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index 9e11892b0a2f..3715c5c17ab3 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -136,10 +136,10 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable)
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (!closed && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
@@ -521,7 +521,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -645,11 +644,14 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
-static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach, bool mm_wr_locked)
+static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
+		    struct ma_state *mas_detach, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;
 
+	if (!vms->clear_ptes) /* Nothing to do */
+		return;
+
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
@@ -658,11 +660,31 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, vms->mm);
 	update_hiwater_rss(vms->mm);
-	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
+		   vms->vma_count, mm_wr_locked);
+
 	mas_set(mas_detach, 1);
 	/* start and end may be different if there is no prev or next vma. */
-	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
+		      vms->unmap_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
+	vms->clear_ptes = false;
+}
+
+void vms_clean_up_area(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct vm_area_struct *vma;
+
+	if (!vms->nr_pages)
+		return;
+
+	vms_clear_ptes(vms, mas_detach, mm_wr_locked);
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		if (vma->vm_ops && vma->vm_ops->close)
+			vma->vm_ops->close(vma);
+	vms->closed_vm_ops = true;
 }
 
 /*
@@ -686,7 +708,10 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
+	if (!vms->nr_pages)
+		return;
+
+	vms_clear_ptes(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -702,7 +727,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, false);
+		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
 
 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -851,13 +876,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	while (vma_iter_addr(vms->vmi) > vms->start)
 		vma_iter_prev_range(vms->vmi);
 
+	vms->clear_ptes = true;
 	return 0;
 
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
 modify_vma_failed:
-	abort_munmap_vmas(mas_detach);
+	abort_munmap_vmas(mas_detach, /* closed = */ false);
 start_split_failed:
 map_count_exceeded:
 	return error;
@@ -902,7 +928,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
+	abort_munmap_vmas(&mas_detach, /* closed = */ false);
 gather_failed:
 	validate_mm(mm);
 	return error;
@@ -1620,17 +1646,21 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 }
 
 unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end,
+		unsigned long *nr_accounted)
 {
 	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
 	unsigned long nr_pages = 0;
 
+	*nr_accounted = 0;
 	for_each_vma_range(vmi, vma, end) {
 		unsigned long vm_start = max(addr, vma->vm_start);
 		unsigned long vm_end = min(end, vma->vm_end);
 
 		nr_pages += PHYS_PFN(vm_end - vm_start);
+		if (vma->vm_flags & VM_ACCOUNT)
+			*nr_accounted += PHYS_PFN(vm_end - vm_start);
 	}
 
 	return nr_pages;
diff --git a/mm/vma.h b/mm/vma.h
index 6028fdf79257..756dd42a6ec4 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -48,6 +48,8 @@ struct vma_munmap_struct {
 	unsigned long stack_vm;
 	unsigned long data_vm;
 	bool unlock;                    /* Unlock after the munmap */
+	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
+	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 };
 
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -95,14 +97,13 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 		unsigned long start, unsigned long end, struct list_head *uf,
 		bool unlock)
 {
+	vms->mm = current->mm;
 	vms->vmi = vmi;
 	vms->vma = vma;
 	if (vma) {
-		vms->mm = vma->vm_mm;
 		vms->start = start;
 		vms->end = end;
 	} else {
-		vms->mm = NULL;
 		vms->start = vms->end = 0;
 	}
 	vms->unlock = unlock;
@@ -112,6 +113,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->clear_ptes = false;
+	vms->closed_vm_ops = false;
 }
 
 int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
@@ -120,18 +123,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);
 
+void vms_clean_up_area(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked);
+
 /*
  * abort_munmap_vmas - Undo any munmap work and free resources
  *
  * Reattach any detached vmas and free up the maple tree used to track the vmas.
  */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
 {
 	struct vm_area_struct *vma;
 
 	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
+	mas_for_each(mas_detach, vma, ULONG_MAX) {
 		vma_mark_detached(vma, false);
+		if (closed && vma->vm_ops && vma->vm_ops->open)
+			vma->vm_ops->open(vma);
+	}
 
 	__mt_destroy(mas_detach->tree);
 }
@@ -145,7 +154,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);
 
-void remove_vma(struct vm_area_struct *vma, bool unreachable);
+void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
 
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
@@ -259,7 +268,8 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);
 unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end);
+				    unsigned long addr, unsigned long end,
+				    unsigned long *nr_accounted);
 
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
-- 
2.43.0


