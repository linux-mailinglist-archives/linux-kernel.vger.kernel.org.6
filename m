Return-Path: <linux-kernel+bounces-428882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2EB9E149A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0E6282D76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764D5199235;
	Tue,  3 Dec 2024 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GPkJqlRH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IEns3OOX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27251BF37
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212218; cv=fail; b=SjJpGnb8D+eDRFS1p24i9MLebDdCezjs9F9DjYGpKMWxq44CyyuMlFt9YUgvNonejAYuDMJE+LokIYkbs/UyazgkWh/4snuNaHv+q3TJ0fan2n7wQAreD/n0k69Uqz8ECPOTm+5OQ/kp/d2zthls4TvYMT+eP5NBdCYVb8rlPgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212218; c=relaxed/simple;
	bh=4CJHS6WvBaU/orRAjbmSZqvwqAcam951yhfs1aCIg7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z96wKxGXFqnDMqCt+0frYBYSFAVS0YbZS71rYycVk+C7ZYQzQyqYJaC8sIo+j35OZrrC0Su+L0cKGt1lDwHwD1KwE4Jv8PywTjmiwVL1tNRf6I6yfyUpigYM2sJ29De4a9W6eR8x6QWt3pniFTJwGqOj43cFs238F6kn73AQMUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GPkJqlRH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IEns3OOX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37Xa7Y005034;
	Tue, 3 Dec 2024 07:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=DFtnZtAi8/5auAK1fq
	W4npHMNpFP3w1VK1KxEKQyuQ4=; b=GPkJqlRHwzpGzS2eOfy77uIyQmbK1RjBdF
	yfmnyivAjjeTRRG0TtkGI32DWahvIetIjDVSN2e45ZvlUOiVGCQaHvV25SfU/YeI
	ncK8jIoYABRKRkrp6FTSB1c+gGDqLUQuZl3xS8PCiZGROLAB7zQK7TJQuuwEz6MZ
	Strrkao9g/F9T6Oh4JJTWRry/alV5ddOTqbiacpZPFEQgIQQpRPB0iDBoC2xqwJa
	qwQOebv/T0jDLm416bakAC+dKOs/yxWBaGU25OyudGCSUREMevIM1iM8cVdRnXKk
	AVsRCLgy9togfJx21xXQif8u4sBp0WC79s9b3fHa5t+ANn5nlSEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg25gye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 07:50:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B364ET1037937;
	Tue, 3 Dec 2024 07:50:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s583nws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 07:50:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7iUX1ZISG2duwvgnQoWZmb7XuZuwgcdGANetzug5vdsq8VIaqmVJ3jFxpu0e9OT49Va6gHNq6G8KWKa+EEInyglJDd0P8RNQqKVL+gYWBsLy+8GPx2dRqtVHBKiEOxnx6HGvdNopB3VMPEyVjABlR21Ly8q6cnzODIWtMJI23qfxgTVTf3eEuvMgYpooCRB3H6V+sfJuN8B02iIJbjR0+ymKKkxBWsA7Aj3nvr+h6ZBJ8oW/NCL33z6qFiAHKNtN9jjO7lgMJ188D8wPDBwq4uKdoGf5O9s4dW53mVQjOrQoWsw8lbsZOHAdXfMXoCKFitZr4wtkgO4NetLzzHWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFtnZtAi8/5auAK1fqW4npHMNpFP3w1VK1KxEKQyuQ4=;
 b=HwwULWLmk42MxuOpie00p0n6z1IJ8bV1sWjlZVN6yY/fueqdYpNQom2RwHnyM3zz56tg+cW9BQXN81cxe+wrEs1ukx5+zIrPDr34poHC0TEw1IEUquCkocnOJ9XVziP8FEmHuX6ObtODXUjKyJ5sUf+f1ksm08b5yPXqLkiKP5x2LyfnBWdxuw1Gt+R8UExFxJnyA4v8skbqQImqYp9OEr1UXqHj7BaK56RqWTyOdoYA6TiuvzXi6N8zBHHLdT+4NU+lIIYc9VD/NYYOidH3dtPAgF9nGGMr5pEuh/auejteMWn7j86acPH4ZsXJvhxbgGlRRTOj5NNVyRdhkybx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFtnZtAi8/5auAK1fqW4npHMNpFP3w1VK1KxEKQyuQ4=;
 b=IEns3OOXLTwUOdxti573oxNjlmRuuwaLpUyhtoGp8iVrb5ZEGEsoHDEI/p88ls9NH//U8q99rTybHcBDoDqltLS9a+XuJfyVqSxEa8yICAEV2Q8HK7iDAY5ErCoHreugWrif0U4UdipVg1HRS0eNgnx12n/SyqAgJfI7ck5HxN8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH2PR10MB4391.namprd10.prod.outlook.com (2603:10b6:610:7d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 07:49:57 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 07:49:57 +0000
Date: Tue, 3 Dec 2024 07:49:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] intel_th: avoid using deprecated page->mapping, index
 fields
Message-ID: <b78f7b05-9373-4d2d-80e1-7c39ce750080@lucifer.local>
References: <20241202122127.51313-1-lorenzo.stoakes@oracle.com>
 <202412030410.qX3ejEnD-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412030410.qX3ejEnD-lkp@intel.com>
X-ClientProxiedBy: LO4P123CA0541.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH2PR10MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: bd73801c-3ab9-4a94-cf12-08dd136f153d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZDLASqc18pr+QxVQ4GwQN5BMPG5kZ5jYHuf8yCF6wM2Lxhi7hi3quR1YluAn?=
 =?us-ascii?Q?GUpznsyoWi/M8+5H/GZ+cbV7R+KOQBdPY7gNsOO3TLFIb7EMyg6ftLijhzQ4?=
 =?us-ascii?Q?fyzZajZomzg2xjIW5I5unYl9+8jQ20sZsyXO8sUDLCvl8hZaNF8pfwpRx5kg?=
 =?us-ascii?Q?fLL4UiIzUaD4umI2YJkb44rSEkP5R8vrw7fEvJ4YhF3Ya4uJCLyIDHoxPdhd?=
 =?us-ascii?Q?t9xbIeB8wfSY68pWdWvV8hxcAIlAfuRtVUbMW0l6caKd3RbyONEz3IvIlFOd?=
 =?us-ascii?Q?UNstdG50qQahF7t7vpqS/O07yTPDaNnviVXuYQk9fcXOp4fRt5eGCaswzJsU?=
 =?us-ascii?Q?hhns4C9hX7vGGAJZp/pJ1blF5YTtxW0Za48W75nu8iETBkk8Vjkii9wsCza6?=
 =?us-ascii?Q?5Eb93pohKcea2zvAJW+OEsWMzdpEH/Ohlgm7/LcUTVKct2qYKrWLICJnkg+y?=
 =?us-ascii?Q?euXyHu262PcY3S8GIrRpJSATXQ6UkzOn301Mp/18pv1ki9vkyICuVxvhTPPe?=
 =?us-ascii?Q?onAjAQ8ntQGfiyInAK3Sagfia6CxmtzU6QnWECFwGc36cGJZ7KHMDOBykixn?=
 =?us-ascii?Q?U5Ib3f/EUbcoKuDlxk3zOCmT6VGLmia9LC6NzfZXoLuLscq7ZewEq9X1HRnR?=
 =?us-ascii?Q?2J0TLHV7VAgWvPYDTRR2fziYCcdxw8VJPodbcYeFtW+gQN+qB67/detyaYv3?=
 =?us-ascii?Q?Hg2n+SQJe8CVFQaFndAeikzvm4kXT9+lNtJ+PeCB3ZmwwmarUWcI2a4jJPxz?=
 =?us-ascii?Q?jr9o711+FFryojQw0gUJZxiH3M/YJHkkwjV+vkMS+V1BVIufVFGUftdq8MDh?=
 =?us-ascii?Q?oKqLMXm+8udwmqy0pVEt8zGP3uiNZfFOYabKLkgWMJwPpyJ4Hy4QUYukJnME?=
 =?us-ascii?Q?cPf7YUgb5lg1FDal5JypiHmt/5JIvvBB6Mdu7PF00MBq8fWScSdvTEyr26ZE?=
 =?us-ascii?Q?SaharSj3DJQsyrjzXEaWJJq57gzRk0IbTeI50d9aT12ECFBcFe0bc8Y2je9q?=
 =?us-ascii?Q?7DvdZ7jmtyYAxbIgEpxbdgrrpEbPZa7S+nhybv83ZEeXSxIEC0yFaXTdfM6r?=
 =?us-ascii?Q?FDp92VkkJeJB0QCAPErY5X9gvw9GpG3a41EIJ3pm7/GNGdzZxeXkwIRXYY8q?=
 =?us-ascii?Q?kBK8OTRtQYiSdnjkD654/Olv+8lUrOu369uG0l7ysh53PX7KXxNexOmMf5rU?=
 =?us-ascii?Q?BdTboEuL43WH76U2Vf+Xe4+PlMnBo9JMPRY/Gn1pci8DW+HvdKlk3YsRemrU?=
 =?us-ascii?Q?cN54VkxO/Mi38UcDSO/6RrbCnuJhMASyysLf9Dzz8FvBsDvo/AdU4RDGAlSG?=
 =?us-ascii?Q?S49WMp3Ov3cndEkVwQY4Aua6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?frD7nXyqU1dB7X2RKNqNMyuWAvvAppCEqIrz8+pvWzDnfK+Cow8avwZEgilC?=
 =?us-ascii?Q?biKV+XNKmuQHIxarvwiic9XDsYdUkhAVkS/Mvhdv/RXhQo4X9iOaK1be6duO?=
 =?us-ascii?Q?h/yNQnoX0EMgafCf+g4hj9n+tpQ+fLxQWCCFq1WN8t4DSS0jqtmwgmoHaQQO?=
 =?us-ascii?Q?mXx6rkVV8whylH+CahxNl0DqxJIb/CgiT12qT1k7UJVv+9IUELKDjH9ssTN1?=
 =?us-ascii?Q?iHX4JYw9qshfaXZRpPMv3XwJPNhbbjzLKO3aoDHNf6YZKcwVWdGAF5P2Jt70?=
 =?us-ascii?Q?JK3czMlUdkTap2ibIEzWfpvSBRHWNnJWwm2Vxi6mak+g7ulSHO76Bl9hoFZJ?=
 =?us-ascii?Q?DsvvYtQOV+Dfx6bImnpptoqtiUG6VH/OzMSaJ48vrdi5kNmNvo6kld3WUSQu?=
 =?us-ascii?Q?puvoowRjqbXz8YYj374Z8aPICUsJ0qQAX5N2W6Xtl3EB8w3HX3hrXoUwhUSW?=
 =?us-ascii?Q?zBw1FUCVoy1hxnG0Zl2y+7WHWkunIsxJnb1IjgWAwzY9AjtFz6IGpbm3o8xP?=
 =?us-ascii?Q?Jm4/khiuCR+7K87h2tBRnpUwOrUl8BkNYEqG3nkHnQh1jF7pF9pcVA8lkzrr?=
 =?us-ascii?Q?BmLCmi0PEFz2kvNvyS9jdO+V2A0QxV3rCa7XYd0mDBbl152uVvAvtsSY/jSC?=
 =?us-ascii?Q?Dy/iDLW9E6F+uM/gXgntM3xvMmxO1FO/quYE+j+fgfPgcwlw5E9edcnH6hcp?=
 =?us-ascii?Q?fQxDM8Yo1IaeYdKWg/bkFRWYZVjZn0RjKP1sZltUA+ZjwARXnshOH0zGzyRx?=
 =?us-ascii?Q?FOE0l+Siwbh0XumQPheiePBI/OPeHx15twI3dJMTWGowJskQ1L3S46LP0Asd?=
 =?us-ascii?Q?mNe630myr9NTaTv5zMVOozTom7frsZT5dIHNPRuHoxQcR/9mtep+QJlyvMtq?=
 =?us-ascii?Q?vJlQ3RL5K9k4QXYMiRK9l5ju1KluxV0IcKc0y8kpQexETxIKfgprIKFwtk1D?=
 =?us-ascii?Q?Ba5dmKQ9L4yEXjH0WA7Oq9mCN5+NI8ec8kr/ccf5cjLC091Z1kYCDHYysDw4?=
 =?us-ascii?Q?En9ZgDiuPNweJ8zzuNEdiWYKApWpZnRfqzke2UIiJA/HeWur+Ngk9gpQL3XQ?=
 =?us-ascii?Q?xCWgo5cYOcZJuO/hwAzu64OpnXSxdT/XniWIClnVJtLD7+BshDRkfMhux1/u?=
 =?us-ascii?Q?qTCudj9O4HjiewQSWxXgYSXPyQgcYIHEfqPlwu6NZwmoFe3nUiWPX02jXllj?=
 =?us-ascii?Q?/aaiB+1MiVHXY8gRFcKxAxAS4SuDw3aAnDsIW624I35mKd009c3HrzQVFBZE?=
 =?us-ascii?Q?Jfe6LfGxOWkKEI1x7XCtisKnlj7IWICMTX6PaLjgbU74/g97Vs7P+laXZqli?=
 =?us-ascii?Q?4C9XdhrfWfpvuFIVKakcaqC8q0/6dIq1JXtCs68VQdceFtzJmD1HM1k4jXR4?=
 =?us-ascii?Q?bH2a287RwqxLFHHFROm3VdNNqJ6NjW5H9V9Q+f4qFikI75QXprfNYebOuw4i?=
 =?us-ascii?Q?896BMYCyGZhUXkORjlbMCVwBLIy0c9jUygwpUVXlF19BeOlUt371NTF6CVEj?=
 =?us-ascii?Q?zFsItls4gj87uNTy9Oi5YPrP2R9qEfSjeEZggAlwgPAPex3PwAahqWE5zrBt?=
 =?us-ascii?Q?v4VykxjkPr539Ch0voAmw7u5c5CnQslwJPrha0W2OShyK4tLZnXvAWB2d2+D?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vMiQcS99lqUXedMg0CGp+r2MHJKf6nExZIdbzNBEhg1LkKHr/b2cYHNvD/5Hy44R6SDHjjYGFnSQp4S0RWQBRYBW0+YPtoJmZsruN0B0RpKS4H3vgCpQG6XTwtWC3J9NJ0wgsjWMq8jf0fs9LoA7mQ9YfQ/yrXbdZazeNHT/6929KpH6Nz3d4M7CwncqepCoeBzPne+9XWaw1S/H2eIJ65K/rlaYDd43wJhFsTUaHqvhTN+AFco7p2u6Ddno1qyns5ffscf8Bo68g3Ne5gkMH3Bdibu5n3Mur+QEGtnWeNjeKzbRIzYzhnona9YanagY5Q627Nhyk1p65rfOZHiM/mPOVBNOEZbVp9dcRFPn3XfbnXIi1WqS5SH5AT5dGmnfxNAjp0bHOBRoqKGtfxPziS1eklEMhu4ITeV50tMCfZeoJuWchWFZWgnM/eIrTGyEtuqUNSoptOYXP2KZshWH97YU1YkdUp0uwPlmN3oJVuU5tPHYOHDL4pTSpOh4rOKDdgwA14lESZ1oMo6gmOZrpneJBIpP1Ygg7MhbiMC0tja0Xy5T7g7Dd9oNyxTYOK6dLRc6+GZtObe0fHbYF6STG+Jpwr6Rqn6B6KMjaeVrIFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd73801c-3ab9-4a94-cf12-08dd136f153d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 07:49:57.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FulibEO28HxRHJ9Hp6ofim+OL3Q1v03ljhfHOL+LHF8b3IDOgPFcNwpvEQGsaryiO/Q0XMw5Np8PDu7niW6NtE2evjn9SJQJKAyuYX6aVaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030066
X-Proofpoint-ORIG-GUID: 6FaS454j-ALMs0Dyl6vLtiziGqoQLoV7
X-Proofpoint-GUID: 6FaS454j-ALMs0Dyl6vLtiziGqoQLoV7

On Tue, Dec 03, 2024 at 04:34:33AM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.13-rc1 next-20241128]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/intel_th-avoid-using-deprecated-page-mapping-index-fields/20241202-202330
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20241202122127.51313-1-lorenzo.stoakes%40oracle.com
> patch subject: [PATCH] intel_th: avoid using deprecated page->mapping, index fields
> config: arm-randconfig-004-20241202 (https://download.01.org/0day-ci/archive/20241203/202412030410.qX3ejEnD-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030410.qX3ejEnD-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412030410.qX3ejEnD-lkp@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "vmf_insert_mixed" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!

This is a nommu arch, while the info above doesn't tell you this, the fact it
says this function, defined in mm/memory.c, is not availble, indicates that this
is the only possible cause.

And, as this is a driver that literally depends on page faulting to work at all,
the proper solution is to adjust the Kconfig to depend on CONFIG_MMU. I'll send
a v2.

>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

