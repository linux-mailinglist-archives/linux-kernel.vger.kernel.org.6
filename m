Return-Path: <linux-kernel+bounces-280008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867DA94C46F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6841C22BF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4365C1552EB;
	Thu,  8 Aug 2024 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U3g1d2uI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gkIZEEQh"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10C1494CE
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142087; cv=fail; b=E7qz+XFa9MZyH2glDAT+5COWbFf3db3NJeEmd0ewf7ei1qr9wjjo57CVZFJxyuMd7pULZaS/OF6cOvy0W6p9lwW8d48vsJuOhJs8OlLrTBZOdTz3zgVsnePZutxyddri677QzRb1BMgmrzxT6L3iz5sIS0oPsNLJV0dT04faJ8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142087; c=relaxed/simple;
	bh=Xh2sM8792M10HNL0+jBmzaST+VolBCWZqdcp2LteL4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k/SWZuV1reKygTbHE1CAQzauDbwhSJH8wvkmC2LGR/v9Rftu21WR71ZZUzjBvnqk/2yJDQTtlyB9jyyZmVrzjci+TqkMR+iyXjiFk3SWfoQADlt4jTa6zzu7wxywrkLg+WERIbao4S1m4FII43bs17Vz+sXbElAkSjJlAAa0RZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U3g1d2uI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gkIZEEQh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478HfXrp003534;
	Thu, 8 Aug 2024 18:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=0n3uTTGsqwhh0qV
	FopS+tSqdimlFnlbofMK1PPrZors=; b=U3g1d2uI+s4kR7K765usXRVgaq2J5sR
	Rv1T1h66LkwkOZ/VzZfWQWmgbxeEAMcQmzEzWBOlgN1EmcMjSLkq3tMnqJ5o6VxT
	R6Dcq/XUfQEUsJk+FK9J9kWOQyf5OSpRiSzGP8f4ocWgMNSacfntLk+Z73l/lf24
	v5azjTAglBHw7aXCmibfK59qm6U06S7Tfpffk1NJCLcc2k6LMFiHL4kaovdBn9hC
	Z8ecx2qCAcCpIYbMp0/dsIYgN4UYbTeDTIy0ddSPGshkLRiFcAHwy/jneKfVpSOq
	0V6K9hILCIcgoy+24YDeJsJqXXlCcYHOIXYxTw/0SnSg0u9WME4DGlA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sd3uth4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 18:34:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478HtjQN023683;
	Thu, 8 Aug 2024 18:34:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0hs4s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 18:34:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yehle8iBvef3MScjP9Glvumbgop1zLIXeihL+ods8gP5H6VBsIyf6ES1ekoz0ZYZ3vUy+Rl53uZTY9Sqw36Dt/Ij+Ee7b++l2D06xby4VJzaM6ALpHD8sSMg3HFiLymsNjHHpEomt94A6eZcFhvS0DP0CSYRI7TBiyQS+5cTb8/2Ut6UH2AP04ch+5s57TsLWfwTkIk52e9vf9YsJudYZHEoDt+HToffuaOck9xjxGAVyD9iG1+PDoPbH13FsPnMtFs1Zxh/l8enrle4tQqrUQ9hRC20tkMbs2YO4p3cSwjXpUhlXARkzgTHahSLBfieirZG9V/gD/Mmeb8CTFw2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n3uTTGsqwhh0qVFopS+tSqdimlFnlbofMK1PPrZors=;
 b=WP6PjgkN0eNN9y3gLMcAbUcCcC2BWForR2Ghw7Ijgs45+WA98F+hQaISUoZpE6+tQYuRYkHtdDBcjLfQM7gzcjvZvPKj1VD7rUVwTWVWiaydHjBk4e7Ln/KZmQBWUAyhBWuYWb0oo5r9OURrC2RzS6Di11P/EnCM8/2NutZMLJG+FmRaAyfsFTrXZxnoMqsyYWnRwTwFDUqjyBLPTYRiqXxhMlULCJJ5wPSnoCVXG+tHxWI5/Mxf6ljpsXF5Lg6RJhdcd98qH2LOpE8Gn3J7UnovT4CIHkSg0VL/Bk+CeMV8yc7Bgr/Cr+blHeiBDXFRspsUlAtC39OEq0CQ1n47tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n3uTTGsqwhh0qVFopS+tSqdimlFnlbofMK1PPrZors=;
 b=gkIZEEQhmuxKefbNzLLqPQaQHQ2NQ0qfkDTCpRO30gImxCLzODsiv90OU6oyHKzkejegiKdgfGcM4uK80FTNM8k0ubWHhXHcjd9Tb8J/nmWIuXpDRFB85j7/KP28Kjlo6txbFZjU3k4jbOnaSkMmXeatqWvlU6ljzYhK5wHPS2A=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7677.namprd10.prod.outlook.com (2603:10b6:610:17a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Thu, 8 Aug
 2024 18:34:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 18:34:31 +0000
Date: Thu, 8 Aug 2024 14:34:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <jlie2tieccx5ulr3b77dpvw4fupeocsu4ftiuwtjkd663qkjzl@vc3imtfqgemi>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
 <28774b9d-b74e-4028-acef-5d4f09a5d36a@suse.cz>
 <dec849e1-cfa5-4a1b-820b-8dc2ee5a8bdc@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec849e1-cfa5-4a1b-820b-8dc2ee5a8bdc@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0366.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: f080a766-4b09-4189-bdeb-08dcb7d8be28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Emh3idBW+E3MvZtQdK09h3VdA1x+yaJK1fub+LhgasZNH+nx9SO1IIJI1JJN?=
 =?us-ascii?Q?DQ5d3hLGRCiTwuByV/xQK0QXoeFvruV71LPl3KHzmyXpJ6Iw7kRdooAdFMic?=
 =?us-ascii?Q?wWeCtjP0uONzn/PISg6RGAYnpFfkxpEXOfyJvrZEaGIK1c6bTPcfBLGKF6O0?=
 =?us-ascii?Q?Gi0l1h44PqQGIvSoH3SVRHPrQac/3KuOxA5R1J7dtDumK78Ipck8qVAhifCg?=
 =?us-ascii?Q?r9gdpCooYr1tuia/K+3IqM0NDTX/OLy8EgRsRALY1kwq8gkKwYLYxgiOmnhs?=
 =?us-ascii?Q?PljnQfzXMEoDp+5uWHAAWjg0RkPW4aqaqArY4CLEA6z/gpElI2ZCsISzOkUe?=
 =?us-ascii?Q?SFdk3cLxEK1U/OArFN3rpGxdk48HVZhxdf/Xdmf8uT4YS3B2/Flr0aIwNFYO?=
 =?us-ascii?Q?kwWdnljux9RpZERV3IG1mm25emxfLjlBLOCEwb3VGQaAVSpMAellw2sdeMyR?=
 =?us-ascii?Q?Exe+pWbieKznXvlAHLKPKUNSAax8Owey4dN+WBAEji9LiAv5BV5tAC49QG4L?=
 =?us-ascii?Q?BT5e5MVh9QvAgnzwx9w82KjbWeUA9sYW/LojpIQnKpfwuuGXts6nwtU4b9Vm?=
 =?us-ascii?Q?3bNeVtVFGoXkPJk1G0ydR9kJZ7ICziytMh+30rUjQCBacqFxSJ+cRdd1demZ?=
 =?us-ascii?Q?ZS2lgHTs/e5Pg8x5msB5FxzRwfm3AUTNDK+iYrNkPFA2ZRj0h7uLnZESpEYt?=
 =?us-ascii?Q?kx2j6cnjTGPua7JpQfWKQI83qXH3J+66BWXD3qWWkWNpv1xaUPdagMqMhNyo?=
 =?us-ascii?Q?bXrnF3mcYjfIWi2k8gSB+1Ju8IDsFLph9pX+PUJUPnMh6nFzOhZk6Lp+ZAyd?=
 =?us-ascii?Q?8D9wgv5RcrY7VHeGSpKLcxmLEJVfBsQ3DQW4+YgncwDXlZGjk1pHh3w1dwoc?=
 =?us-ascii?Q?2VZHNxd719puH7Zan+g9zB2MgrsR1NjUoqTsydBv6GmrxyNZUwHQIcet0MLr?=
 =?us-ascii?Q?pkhpwXk4Px7tlvKwW3/rV5ZBvn87Run+zNf49iKz9OovG45xtFPuZTNf2esm?=
 =?us-ascii?Q?kgtb0zhKHbIBrm9rCizSfVfIncHID/CxpkFN649krtUXIrMAjqqVGbATE1O1?=
 =?us-ascii?Q?3M9EuvPMnpd0NdJfkhLSOJA95jUagm8jwndA1IskWgyE92/ZB4TQ6uxQ5Dul?=
 =?us-ascii?Q?GjLxFx+GrvWjDMh8O+WOzHfB8AFk6xmc6jb7I3BJK+KcOOhAHjQic2+IxIcT?=
 =?us-ascii?Q?HyQgrlSeF/40K+7VlK1d5MbenRqJNeUDMNrr8Ao+aLJghRIKzX90ZsmDCgsI?=
 =?us-ascii?Q?0Qdc5zqyEkbcp6kcuON4G18uDMlXuCOfQDimbS+b9uB7yiWSTNzOE0MBjVxm?=
 =?us-ascii?Q?rR8M0nQlQ6irTe/OZPUhbNF4aEhtawI6UixdEY1Qv/2Jag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s1hEJGSEoi95aUDtXhTytZJiA+h8PavowFOAaQlx0wKvT7oOel4f4R7+Xr9o?=
 =?us-ascii?Q?o3Je5LAqj19vbB33pImAiK5dmf1rShzO6JIb32byBcm4LnhuIdk7DWiNNrbR?=
 =?us-ascii?Q?vKq5HymZcgLXuIwSMlVBFhd7NieVxShr7e/aBPeuR56ec6QYRiD2IzgyfOdj?=
 =?us-ascii?Q?Z0+Ba2HII3ScnrpFjKdsLigd8KGk3At/TSLcbekjqQKToT6Q5Bg85eivTw+S?=
 =?us-ascii?Q?yy4K8fjlDuWJCVxbxlA7M5zW9eccQu5X7jlsBtfsupGQYzuoFNcwzICP7JxZ?=
 =?us-ascii?Q?DqQL/+kjbhtIYojyH2six19lCKI8NHY2PspNJ6uxa0POKcDyPjTrvPX/Seo0?=
 =?us-ascii?Q?GbBW+lTl9SWNfNrKlCwcDeis8dQ5pIM7iDWzQU3edN3s0C1/DbiE1paoqUnN?=
 =?us-ascii?Q?HNp8QNFT4xsaHrmzvYKdshNl3RjczrgpVJ5ex29lNgskdTb1b/ZnSFtDy60I?=
 =?us-ascii?Q?2z6tmHMI6ptmgdQwOSU6ApoVrzZ86MAGHFGRTdpfz7q0b/Kvpv8sRVZ7dSo/?=
 =?us-ascii?Q?SXczH7M2a15RptYfGV8sWAZwJl+kfkpHSaw5xwvwfbVCSQsjA+opNu9pS0IT?=
 =?us-ascii?Q?Lj3niVS7PMSUV1mhUfqbGoKSJD2221zNsqkauvuH3cmGiMxLOGuuRtDWzf+y?=
 =?us-ascii?Q?/7RNgOX0iJRYaJLIyCQloC100dmc8vah5VaBJIaARX039ee36M1a97MjX0F8?=
 =?us-ascii?Q?Wc2+xKr2Hoi0adsdtM/ZghmpWUTPSYLpq5SpgIgHbXZtLPXl1lh8/B28inNj?=
 =?us-ascii?Q?nJmqYKQokBFVC8nWfrM0bYC2GWAqtfrZmSNLABrVy431ixg6ZGxbp617Ovnh?=
 =?us-ascii?Q?oe6dmAQsLJEgiIoj7BXScu4k7HfR1Tw0Dc++qyWtya/vkO3S75R/fwDP5nCJ?=
 =?us-ascii?Q?oM/AZyFjBcwR/GdmY9nQeDAz2RVkrW46KIn7gj/RjuXWDbJst+sMmnsn5eiC?=
 =?us-ascii?Q?aFjIB38BLorfAeZQpfSqjDz3gJAc6OzyOtA/PC9F1r98prVf+jva+9PEkbX7?=
 =?us-ascii?Q?NJPzQYxReuITErkQ8NaMJsZA7U/aCNokZB8GugisEydJ7o0zVQoTqqg7nTaF?=
 =?us-ascii?Q?XyEj/i2+JA+Q3nbdGXzjfli7K+b1td1sGJccGCAv+O64313r8KhQYR7MFoY5?=
 =?us-ascii?Q?07+J+g6X3WL6tNhX1KzDkF+5oQAaRc4QK0ZrA0FVxJBIQ/yC97E3aa6HDXxv?=
 =?us-ascii?Q?qT6raW/x2TzVOO3u5sxg6olJQkQQGoSgA591BnfmZObMWH+wVkdNWlRCyD1L?=
 =?us-ascii?Q?RmZBIJiLROoqjmsBS5GXVHptOt4JX3HJkP/h+SVmHa5Njgyy/CUh02gWAFgI?=
 =?us-ascii?Q?akmNTbAYnbHsVbzYNKtfgGBC6TdRej4RMEEAH88WkG8GWnVhBjlTw3b2eqNT?=
 =?us-ascii?Q?w+XC/E6Kdth86w+skavJ1nwskhrDf9HerxeGqL70aqXWQ7HJQdPEMjxmZRfi?=
 =?us-ascii?Q?jHfE7w7tyP5eXvJHlNZg+tCnwX/pWpD7qv6Fq2NfnUOrFSQh4ZCzLmyg0drU?=
 =?us-ascii?Q?qhbkqIwf8YXJRFqPNKkRcV7yt7OXNK5ckTf6uyto9mZgS6Tr6LuoOH9yAU33?=
 =?us-ascii?Q?rUwxLO+LInoT+/TTq8EzrDauuRz4chOLwI6K1NgI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LgUtoPntTo9SeU3cyLKabGqbj/KE+AN7uPsrygMDFxB9E9iz92zXP1M9FWkKkO8899KyF24wwBiHeZHW4oKdjJ4qZagi7mEYNIuv9dEUzl55ChBi+CC6KjilXjrTTOslnIjmDeVZukxwkoMkch8b5Z3t326hukH6zEfFFbja3Ti1s/8s1Jj5pfhVzqOUOA/hVmNdJ3aGQDq84csycLyxtaqnmxB0jT4ZN1mf+lmpgYXPWGgnhwU+V7xqPNDR8pLT2mZR3lzpGU+FOBzm2eNCAubclnyC3f5Ud2BQetCt7m3tKLv8JNdbu+7iV0qXAnkpu+wpgE6lBvw9+phw+Q3U2+s/u4VF1NfvIwoS09z2vmQ8kwsTBnm7F+OrvQCYfIj4BdOBOuRbIERKsJ2XqLSMbLLNWnQ/+XXdEpQ9S0VmOrgZAVKu1wlJJXC8DdV8S+njGV/7f+WjFXElBd6r88HFJzU/540UFEydTywCijldDJ6cPqyxGp0dZCxoao5IuuBdWRB7NswbcBdi0q8EM6zJq+azte5EnDWTLaU133qT02JvBoRH8BWoPas1d8xF2BFWK/xIdrZqGBun+nZrbkJS6DHGWtpDrKkG3WwSTAX3lFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f080a766-4b09-4189-bdeb-08dcb7d8be28
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:34:31.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQJ3onpNMdC8foDrW7xGpOIZyk1pRLaIA9G4k7Ti8OpBkrJ7O2v5t1Oq/oqiMR0Z4UjiKa44F08wKrPZLbdLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080132
X-Proofpoint-ORIG-GUID: SoR7qLBL_oho8eUDUMp7AsjiQNsXQoct
X-Proofpoint-GUID: SoR7qLBL_oho8eUDUMp7AsjiQNsXQoct

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240808 14:02]:
> On Thu, Aug 08, 2024 at 06:45:43PM GMT, Vlastimil Babka wrote:
> > On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > > In mmap_region() and do_brk_flags() we open code scenarios where we prefer
> > > to use vma_expand() rather than invoke a full vma_merge() operation.
> > >
> > > Abstract this logic and eliminate all of the open-coding, and also use the
> > > same logic for all cases where we add new VMAs to, rather than ultimately
> > > use vma_merge(), rather use vma_expand().
> > >
> > > We implement this by replacing vma_merge_new_vma() with this newly
> > > abstracted logic.
> > >
> > > Doing so removes duplication and simplifies VMA merging in all such cases,
> > > laying the ground for us to eliminate the merging of new VMAs in
> > > vma_merge() altogether.
> > >
> > > This makes it far easier to understand what is happening in these cases
> > > avoiding confusion, bugs and allowing for future optimisation.
> > >
> > > As a result of this change we are also able to make vma_prepare(),
> > > init_vma_prep(), vma_complete(), can_vma_merge_before() and
> > > can_vma_merge_after() static and internal to vma.c.
> >
> > That's really great, but it would be even better if these code moves could
> > be a separate patch as it would make reviewing so much easier. But with git
> > diff's --color-moved to the rescue, let me try...
> 
> Will separate out on respin.
> 
> >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mmap.c                        |  79 ++---
> > >  mm/vma.c                         | 482 +++++++++++++++++++------------
> > >  mm/vma.h                         |  51 +---
> > >  tools/testing/vma/vma_internal.h |   6 +
> > >  4 files changed, 324 insertions(+), 294 deletions(-)

...
> > > + */
> > > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > > +{
> > > +	bool is_special = vmg->flags & VM_SPECIAL;
> > > +	struct vm_area_struct *prev = vmg->prev;
> > > +	struct vm_area_struct *next = vmg->next;
> > > +	unsigned long start = vmg->start;
> > > +	unsigned long end = vmg->end;
> > > +	pgoff_t pgoff = vmg->pgoff;
> > > +	pgoff_t pglen = PHYS_PFN(end - start);
> > > +
> > > +	VM_WARN_ON(vmg->vma);
> > > +
> > > +	if (!prev && !next) {
> > > +		/*
> > > +		 * Since the caller must have determined that the requested
> > > +		 * range is empty, vmg->vmi will be left pointing at the VMA
> > > +		 * immediately prior.
> > > +		 */
> >
> > OK that's perhaps not that obvious, as it seems copy_vma() is doing some
> > special dance to ensure this. Should we add it to the ASSUMPTIONS and assert
> > it, or is there a maple tree operation we can do to ensure it, ideally if
> > it's very cheap if the iterator is already set the way we want it to be?
> >
> 
> To be fair this is something that was previously assumed, and I just added
> a comment.
> 
> Will add to assumptions, and again I think any assert should be done in
> such a way that under non-CONFIG_DEBUG_VM nothing happens, maybe
> VM_WARN_ON()?
> 
> Will try to come up with something.
> 
> > > +		next = vmg->next = vma_next(vmg->vmi);
> > > +		prev = vmg->prev = vma_prev(vmg->vmi);
> > > +
> > > +		/* Avoid maple tree re-walk. */
> > > +		if (is_special && prev)
> > > +			vma_iter_next_range(vmg->vmi);
> >
> > I wish I knew what this did but seems it's the same as the old code did so
> > hopefully that's fine.
> 
> I think point is that we are about to exit, so we'd be left pointing at
> prev. But since we're exiting in just a second, we want to be pointing at
> the next vma which will become the prev of the next merge attempt.
> 
> Liam can maybe elucidate further.

What you have to remember is that the vma iterator (vmg->vmi above),
contains (or, basically is) a maple state (usually written as mas).  We
keep state of the maple tree walker so that we don't have to keep
re-walking to find the same thing.  We move around the tree with this
maple state because going prev/next is faster from leaves (almost always
just the next thing in the nodes array of pointers).

We use the maple state to write as well, so the maple state needs to
point to the correct location in the tree for a write.

The maple tree is a range-based tree, so each entry exists for a span of
values.  A write happens at the lowest index and can overwrite
subsequent values.  This means that the maple state needs to point to
the range containing the lowest index for the write (if it's pointing to
a node - it could walk from the top).

A side effect of writing to the lowest index is that we need to point to
the previous vma if we are going to 'expand' the vma.  The range is
essentially going to be from prev->start to "whatever we are expanding
over".

In the old code, the vm_flags & VM_SPECIAL code meant there was no way
an expansion was going to happen, but we've moved the maple state to the
wrong location for a write of a new vma - so this vma_iter_next_range()
just moves it back.  Then we "goto cannot_expand".

> 
> >
> > > +	}
> > > +
> > > +	/* If special mapping or no adjacent VMAs, nothing to merge. */
> > > +	if (is_special || (!prev && !next))
> > > +		return NULL;
> > > +
> > > +	/* If we can merge with the following VMA, adjust vmg accordingly. */
> > > +	if (next && next->vm_start == end && can_vma_merge_before(vmg)) {
> > > +		/*
> > > +		 * We can adjust this here as can_vma_merge_after() doesn't
> > > +		 * touch vmg->end.
> > > +		 */
> > > +		vmg->end = next->vm_end;
> > > +		vmg->vma = next;
> > > +		vmg->pgoff = next->vm_pgoff - pglen;
> > > +
> > > +		vmg->anon_vma = next->anon_vma;
> > > +	}
> > > +
> > > +	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> > > +	if (prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> > > +		vmg->start = prev->vm_start;
> > > +		vmg->vma = prev;
> > > +		vmg->pgoff = prev->vm_pgoff;
> > > +	} else if (prev) {
> > > +		vma_iter_next_range(vmg->vmi);
> > > +	}
> >
> > Sigh... ditto.
> >
> 
> (Liam can correct me) I think this is just setting up the vmi similar to
> the other case such that if expansion fails we can positioned correctly for
> the next merge attempt.
> 
> Yes it's fiddly, maybe needs a comment...

Yes, ditto.


