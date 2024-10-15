Return-Path: <linux-kernel+bounces-364953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636499DB91
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CC91C21804
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA11215B96E;
	Tue, 15 Oct 2024 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EyEaq6oB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jG0Zvqqg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561E1E86E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955905; cv=fail; b=MbON+BbaquEK3Eya7pqJu+lVpUsOgf250m/8lVtXv1Hj+zGYCJBvhgSUAuWHK45bKVRc9EZ49U5gHxHiKtQmvr2M4QLREml6VoQIh+UVotNp5CB8siRkMLieptBo/DSgcRUr8rkYkQVVymBJd3wFrbx2dY3TCVos0Mgl1Xb34kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955905; c=relaxed/simple;
	bh=mR/W+4hChLoiCK69/QU4O9KRf4Xh2nn1+EgLE82krhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ibj39/6nYN+Ua+e7mZMafjpw8mwBRvgIt29eBBM+0XOttoralZFZwC6h4jtGyBneeZwBqhVtwCpfjyirL8UAaQHt/yZeg4AtFGl8n8+8dhltVdztWThQ9PekK8WDebH9mT1CEN3PFj/1g8vN4lVo7fwTVy/r2MLsFXJPlo47Tuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EyEaq6oB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jG0Zvqqg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1Btgs004890;
	Tue, 15 Oct 2024 01:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=PH4JMkLn0CmKRNqoOO
	xnZH0oV1DB2Z5IViWDlSLuCHU=; b=EyEaq6oB1AOWCiT2G5diLbKN8lgUvbeDYv
	XeovXM9uybXJtbiIELw6CAOa6fhMXTxAvZ1GQZiucBrZOxIqHSv5NQu8YxEfpT0T
	LvUF3dOFg1OTvju34vg7qh1KdbV8kPairtlasYe+Qc6eCnvN0yRbxWPXE69/+LUK
	yrEUumFZFf+YOTWepoPmZ57zuWQ7pcDC8TgQi8LmuZFIsaWD739McQzPxWwOnOSI
	zB9/l234UeTKojzqh/pr1bW0ijoleSwcFo6zPhUxJuSSQtTpupnZZmcR6eRwOMvS
	YR4IXnqN5IYFZHzJ3otXVr3cFkMJ8ppKJHL6d8DxDVMz0rN6tBwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt7peh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 01:31:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EMrA7E019471;
	Tue, 15 Oct 2024 01:31:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj6t4ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 01:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI/p7IPglvMnO0dInzh+21XNigjXwIUln4dp2VKP3EXA/Xwqf3+pdebBtc1kOEXGpb6yZrXayvVPCncty73t4z66XDEs3rHcF0+s22vV7TKip8VBEk7YulZn6BmXkif0q9fnvHWOtGjboMxVm4WT0awwRGJnfmg2k2H8gZs2wFBaJ1D4lu5tMTK+Lk02GjXAsin+2gC72wViy8MhtGOjJZY6Zfpu3FNpVCdT2QAOpb+RwuR9knLcBJGXBmzwZTcQ03F6K8bdiRgG4/ePfxI3QDfefjpBpJI+96bZfAPq79uFWN+Yv6H3BlsdKtUmGDmr5rKqQJ5bTrnLneFDXB1nJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH4JMkLn0CmKRNqoOOxnZH0oV1DB2Z5IViWDlSLuCHU=;
 b=wyGZcMnoAs7ToJ3u/NQ6h0xbfR9HVljBO098ttEuNP8lEPGF5p7/8Q5E7LJFDKWJ08cGuYjQF7OgmE9k6u9GhC6RHkzGGQfrN4xMRIPJYFl/vaFrdgO5Rgm5dYnYq1EvwlsXb8MQX67SLcKChT9TN4oKyeWc4l//aMSAkOGIw0N39tYcIQ2sk6Nd1lfbtMJivGiwyKh85RmX83aJhI2lKmP9Edvy6/cwnLqMkNb7zI+pM95Yp00e3q53Ifo6qkRsMnSqMGhCDEkxJ/3eq8AAQqGuP297wZMyxe2LBq3ixss5nfckMNI/9EHg/z5T7H8wyoDAZPje53evYysmhHuPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH4JMkLn0CmKRNqoOOxnZH0oV1DB2Z5IViWDlSLuCHU=;
 b=jG0ZvqqgaaBKHS4iaAsRdAra43JAFX3mryNKg1X0ikvdnvSWM1EzA95YU2FsHyDpl7AjXfRnf11MsdRP/NVMpbnVePlahkhw8B7aZCUIIcfKa3b1OHGOU8Hp18/UL68BXh206qJVK4rwRqqbzLCWmSWQ9Gs2AaO5kNg9FHxqPnU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB4744.namprd10.prod.outlook.com (2603:10b6:510:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 01:31:30 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 01:31:30 +0000
Date: Mon, 14 Oct 2024 21:31:27 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: do not hash pointers on dump in debug mode
Message-ID: <76yaej5cgmbjjibnqsfoopqwe6mnw4ejjpxqmrbyjob4aipl6s@y4qwvxqhh2ro>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	maple-tree@lists.infradead.org
References: <20241007115335.90104-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007115335.90104-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB4744:EE_
X-MS-Office365-Filtering-Correlation-Id: b175a51d-2228-456a-3f73-08dcecb91828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1bGhHVoTiucSbmHYVqLZ0rulEz02K0ewp2wyer7P8iWdfWu2d0pEY3FfnNe?=
 =?us-ascii?Q?YMLymXJ+6h158uP5Rp8stWas5IKZQCPMsrvNS2M3zrMHPTDNo9urzDUMuaOb?=
 =?us-ascii?Q?AE2ItmHcAOrb+O1E9JcWAkneqfLLz4EO9fnkBQ2AZTBg3MFF3XH2kKL4y1JU?=
 =?us-ascii?Q?JDR0pfggUG9bw6usos5h+1k44UpN6/3zxbJcs7nkJ7gV/D6QAAlPHnvnX5fU?=
 =?us-ascii?Q?gWtQ8IZA0LnDTNd0gdtJovqYzEXihQmHi6qkzGt5bFZDIika9qNZUExuJ0LM?=
 =?us-ascii?Q?LfbKX89ppaXxg9/JJhdd7zNfRXSFDVQoppg1pcw3IsYzBqoQt5FQBuykUF1c?=
 =?us-ascii?Q?ATmFmgDBKq38f5UgpwnKs+MPE+Te09O2qFbq3ktvALAQ2kNZVyrFqagmhcEf?=
 =?us-ascii?Q?oh++0JjanfsAMt+hIPBJnVMWU/t4D7D0r4iuXzaRs1AJExeacjSJs4E9+ECm?=
 =?us-ascii?Q?UL5PkovDzg/bjsf49rPwaSwo1vDGwyKnrrSs7qH843JXWCINgKWJw/aofesY?=
 =?us-ascii?Q?nddpW/WPeDYAb9hcYfwC4I7dwiDhMd0Rlu3+Kt7p/BL1d/AEko5z9edO+dK6?=
 =?us-ascii?Q?tWUiEQKcRm+O9EWyQEmLajA9s8RZUApIbV0h7pg1yOxbdC1oFja3fc34wYo0?=
 =?us-ascii?Q?DVQ9QJ1Gg5SpfnEy885VEayuS6xnZ9SsMM5byLuRD9AIw2G18wssPoPHMNxQ?=
 =?us-ascii?Q?rgoi241UlcciquzrUbyqwnxxL5NaBTvUYZ8jr1xyA5VOpfQZ67Auhyh1miKq?=
 =?us-ascii?Q?Ps10PMwwL0KdpCTXyQgzETh7iRp8Bsc1/CNM9ZDHEjkzfzOgWD2/sGkIoFnV?=
 =?us-ascii?Q?V8XxRoXqVxrMB5ZT5F6MDIkSEaDGoxacotFhPGfMBQZjbFWYuw+RO8hOy5y7?=
 =?us-ascii?Q?lCbCoc5P3YpCf4qu3xi5DdVKdysS191CYWM+6XlmIRfMevl/BhmMWaSadrHq?=
 =?us-ascii?Q?4ZCy5jUewsXdUi/foY74u66h+91IpFmPKS4NvgrStxqE4oDXXuf0sIEM4h+B?=
 =?us-ascii?Q?LaOGWSczgSBcSXLkvAYpX0oaT2/w8De5IeoWe28t5vmvMNDZ/enYUVUHT1IQ?=
 =?us-ascii?Q?JJJxTT4eYO0Zo7gQHQYDYEsifP4BH3GvKLv+71LrGN5pqg2X2xQfCKNLE7yg?=
 =?us-ascii?Q?tNX5aYJLPGd6E7Gdg0maDbe0JTfPszZqAo0fdRC1Wa2pH42EbUW3syXmvuw6?=
 =?us-ascii?Q?tg0ePftKqfHCgUm04a62UW9OBqM7s/Ne73c5Kv7GxYzbXIgkQ+BUXn6EWqlS?=
 =?us-ascii?Q?2bTV9CZnmjASfPd4byP7EQxvPB3FSe+cnOMSnjR9Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qb2T4zBqlRwtyUvnI0wukIaEuWGksaoRGF9b2QXj1WRvYMc8OD2Yb6tekRcJ?=
 =?us-ascii?Q?k/p8ToZxoyidfGLDheSsyC9bUh+aZYREJKuFT+cpLD+nZESX/xxlslT4TQFZ?=
 =?us-ascii?Q?kkBBOQ4ENS/977LpLNpsNpt2rKm0frsAJRVph/hur67MW+eeNH3/BKwPkWun?=
 =?us-ascii?Q?WJCRDrtCccbL3s3tbB0Re8EkeDtdiy+ltrdzzWuCzCtqiOPTdTY6WQ0+x6mT?=
 =?us-ascii?Q?ct7QgK7EWq/e+RLspu0jqEz0XdWRHUgU/ukMaXvuLELfFOzcImY0kDpakb7F?=
 =?us-ascii?Q?vNDnUvOb/mglYe8fu9rGzpmRdNbkD6XOMfUbvFIro6D4FOew3RAQjR5O7p0b?=
 =?us-ascii?Q?dyj433WSzoGA+dDX6oPPQBb59/p8HAuZIGa3O3YUoSCMlQEvo7um6SYACENn?=
 =?us-ascii?Q?xv4gfliI740HNLfqKaHJokXrB+9YUyD0EUFHH2rNqxGId4yIDL+gZPosynHu?=
 =?us-ascii?Q?FO1dCBp5nqhQIfhG9bD7tfnntgTJWLklhtAcnjnFDVl/yTANwINqQOJXI22a?=
 =?us-ascii?Q?n4bIasjrCoTA3P2iVJX+5v/CB052pQmM84M1gXhACUujfsR1gvJgbzSN1fgy?=
 =?us-ascii?Q?vgZFrUSqWWihjAdqda+FloE4RIoLaTpOk0jTa0/TkXzGDP90ia3O4B7EWPMS?=
 =?us-ascii?Q?oDCKz/z4Oje7m4V/0TtGZdEIT9Bn5y8P4938OKoyygn78/nQcAdXm8i0NZGi?=
 =?us-ascii?Q?3kWRdNKR2/8op9VOTt8Xh0tXuHl74bNdNxLy/10T+Kl8bNHc+bEcMiVPwN7P?=
 =?us-ascii?Q?24FUWQR38SfbXn+mbujzqT5re7BrWQDbGzLx7cbE/tZn8xR7GpP7Wmjx59Vp?=
 =?us-ascii?Q?i1oc4/WtYkNqOS/ELKXYP+vS+w+uX/99RthLd0LK8dzaVV28dKAY+sk8q2oK?=
 =?us-ascii?Q?uC8eavSsp3S9iDBI4yhOYBaJdLpdTgPch41bAREbkvuFIVkTz6DWpjwlkjWt?=
 =?us-ascii?Q?9SFJgn2XI4Bi8EoCQc57WdGqp0A1EATKSCD0+OthJPEh6YRAi7rObHrli5Y5?=
 =?us-ascii?Q?I4dD5bC+GIhFLKDYcxdQeipTUN0oBN7+LRmgbgGggrmZRqik4hy/50vzwNpT?=
 =?us-ascii?Q?nZSgiTd62KM6O3u2XmCDy9lQ17OcNyz95ANBLuvSs5pH7drpWGjkglm+EhH1?=
 =?us-ascii?Q?5NkaJZP+21r0BGfNzkkx7aD6JDv8VLMXWq7u7lNNpRjeNIsfqUFke7U2pJ44?=
 =?us-ascii?Q?X3TI8X7AUEHWAu+vjEeMpjZF4YumUFLL/xVVOHi/sCEUev3fjiT+fgvKvqoK?=
 =?us-ascii?Q?bcSCh+zJudCBmk4UFn0kMoiz6FOWUzxrD7SQuwrYh9Ug6KT/+8dZ5N91DYYs?=
 =?us-ascii?Q?pgzKxP82MUejLIsbXCXygfQbQlUG6ROQirxTb7Ua6sWf/WQz1JWJa8fuvwNB?=
 =?us-ascii?Q?rFFXSi2yYHL70EGws0F6PfjO/CCe20e72f5MQfylFfkIQFRH7ZDtAj+mtWRg?=
 =?us-ascii?Q?xEFyTFxrs/7rcA07bolGdtTKPToB7yNrUqEKWf/A2g32nauoWti8ZDiLGTf4?=
 =?us-ascii?Q?SaLClASxnCawWfsDTdyxvaVyOvWinW4zovCaw+oNEJkO3rpW1AxFpNEFVJhk?=
 =?us-ascii?Q?m1O4k+1zYv3WkWr46xZnMtSPO10Xt7JV0peCI3YXpj/qlJexEDupzzyX7GdM?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ez4ZKSgXLF7M4b+d0hE8mM1VBtCD8RO/H0nGPGQJzv3Y8qBVGTmS7QdH1j8bt6VY0k1Qro0fiTLKrXWD9VJESfQ/VkPFIeiB5uoJWs0OcHIKPeQMUz+fl3v+J0ajaDaNUwbjk7/tHBHvbyWwE/rolUqEO4U4l9rBJ+PdYa6Gx15sYTt0xAdtz4Hsxe0sD7IAvUcqUelbg6kY5FJWllvWRGD1/r6qSCo5Wb/tmg7Y7ZtoO1PpHtc0/rrMrEIZwXkOTMKR2JqB3HUVI69aoRSdcurDG/6F8ZbIcnQFUEmXRUAhc2nbBi8azKwUaInUnZyHatXOnZm6Nq1KvjYlaNBFugMOCkbrH9bSir3JrfEcBHGq3Vs/g3giuoSASlrZyfiItyUfTFFY7WTH8XzlSq9093MEhxAR01vMTe1dFJ/UThECndvOau0ZTzx8EPzHiqDZiCD+5zET1HIdEx8JdDoR18oalP+NjEOWAneCJSvxi5gaNNkJG8YYuxIGFuaP+l1+V4Cfi8EX+U38/mxieKdpoVydgmwJJ4L925daPymtNFaLA+9+eflWO1r/dT//G4WQPXkWKU8vph46xfNsj4siQlElyJdssaqyV6k7Rf/qvs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b175a51d-2228-456a-3f73-08dcecb91828
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 01:31:29.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN0QVFTBqYeKfpFj2Y6LNCQ7/FzoJ35H0mZZsQq2eVFVSmhVllLUrlV+2XeAqEMr1k6XxQM3aLpf6HWjG+7/fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150008
X-Proofpoint-ORIG-GUID: dVe4p-vFQW6hF_BV_P4oXXiJLwMtAL-g
X-Proofpoint-GUID: dVe4p-vFQW6hF_BV_P4oXXiJLwMtAL-g

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241007 07:53]:
> Many maple tree values output when an mt_validate() or equivalent hits an
> issue utilise tagged pointers, most notably parent nodes. Also some
> pivots/slots contain meaningful values, output as pointers, such as the
> index of the last entry with data for example.
> 
> All pointer values such as this are destroyed by kernel pointer hashing
> rendering the debug output obtained from CONFIG_DEBUG_VM_MAPLE_TREE
> considerably less usable.
> 
> Update this code to output the raw pointers using %px rather than %p when
> CONFIG_DEBUG_VM_MAPLE_TREE is defined. This is justified, as the use of
> this configuration flag indicates that this is a test environment.
> 
> Userland does not understand %px, so use %p there.
> 
> In an abundance of caution, if CONFIG_DEBUG_VM_MAPLE_TREE is not set, also
> use %p to avoid exposing raw kernel pointers except when we are positive a
> testing mode is enabled.
> 
> This was inspired by the investigation performed in recent debugging
> efforts around a maple tree regression [0] where kernel pointer tagging had
> to be disabled in order to obtain truly meaningful and useful data.
> 
> [0]:https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Okay, I used to use the boot option but sure, it's only in debug code.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  lib/maple_tree.c | 100 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 41 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 37abf0fe380b..0bcaa1804b79 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -64,6 +64,21 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/maple_tree.h>
>  
> +/*
> + * Kernel pointer hashing renders much of the maple tree dump useless as tagged
> + * pointers get hashed to arbitrary values.
> + *
> + * If CONFIG_DEBUG_VM_MAPLE_TREE is set we are in a debug mode where it is
> + * permissible to bypass this. Otherwise remain cautious and retain the hashing.
> + *
> + * Userland doesn't know about %px so also use %p there.
> + */
> +#if defined(__KERNEL__) && defined(CONFIG_DEBUG_VM_MAPLE_TREE)
> +#define PTR_FMT "%px"
> +#else
> +#define PTR_FMT "%p"
> +#endif
> +
>  #define MA_ROOT_PARENT 1
>  
>  /*
> @@ -5414,7 +5429,8 @@ void *mas_store(struct ma_state *mas, void *entry)
>  	trace_ma_write(__func__, mas, 0, entry);
>  #ifdef CONFIG_DEBUG_MAPLE_TREE
>  	if (MAS_WARN_ON(mas, mas->index > mas->last))
> -		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
> +		pr_err("Error %lX > %lX " PTR_FMT "\n", mas->index, mas->last,
> +		       entry);
>  
>  	if (mas->index > mas->last) {
>  		mas_set_err(mas, -EINVAL);
> @@ -7119,14 +7135,14 @@ static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
>  	mt_dump_range(min, max, depth, format);
>  
>  	if (xa_is_value(entry))
> -		pr_cont("value %ld (0x%lx) [%p]\n", xa_to_value(entry),
> -				xa_to_value(entry), entry);
> +		pr_cont("value %ld (0x%lx) [" PTR_FMT "]\n", xa_to_value(entry),
> +			xa_to_value(entry), entry);
>  	else if (xa_is_zero(entry))
>  		pr_cont("zero (%ld)\n", xa_to_internal(entry));
>  	else if (mt_is_reserved(entry))
> -		pr_cont("UNKNOWN ENTRY (%p)\n", entry);
> +		pr_cont("UNKNOWN ENTRY (" PTR_FMT ")\n", entry);
>  	else
> -		pr_cont("%p\n", entry);
> +		pr_cont(PTR_FMT "\n", entry);
>  }
>  
>  static void mt_dump_range64(const struct maple_tree *mt, void *entry,
> @@ -7142,13 +7158,13 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
>  	for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++) {
>  		switch(format) {
>  		case mt_dump_hex:
> -			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
> +			pr_cont(PTR_FMT " %lX ", node->slot[i], node->pivot[i]);
>  			break;
>  		case mt_dump_dec:
> -			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
> +			pr_cont(PTR_FMT " %lu ", node->slot[i], node->pivot[i]);
>  		}
>  	}
> -	pr_cont("%p\n", node->slot[i]);
> +	pr_cont(PTR_FMT "\n", node->slot[i]);
>  	for (i = 0; i < MAPLE_RANGE64_SLOTS; i++) {
>  		unsigned long last = max;
>  
> @@ -7170,11 +7186,11 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
>  		if (last > max) {
>  			switch(format) {
>  			case mt_dump_hex:
> -				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
> +				pr_err("node " PTR_FMT " last (%lx) > max (%lx) at pivot %d!\n",
>  					node, last, max, i);
>  				break;
>  			case mt_dump_dec:
> -				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
> +				pr_err("node " PTR_FMT " last (%lu) > max (%lu) at pivot %d!\n",
>  					node, last, max, i);
>  			}
>  		}
> @@ -7204,13 +7220,13 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
>  	for (i = 0; i < MAPLE_ARANGE64_SLOTS - 1; i++) {
>  		switch (format) {
>  		case mt_dump_hex:
> -			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
> +			pr_cont(PTR_FMT " %lX ", node->slot[i], node->pivot[i]);
>  			break;
>  		case mt_dump_dec:
> -			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
> +			pr_cont(PTR_FMT " %lu ", node->slot[i], node->pivot[i]);
>  		}
>  	}
> -	pr_cont("%p\n", node->slot[i]);
> +	pr_cont(PTR_FMT "\n", node->slot[i]);
>  	for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++) {
>  		unsigned long last = max;
>  
> @@ -7229,11 +7245,11 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
>  		if (last > max) {
>  			switch(format) {
>  			case mt_dump_hex:
> -				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
> +				pr_err("node " PTR_FMT " last (%lx) > max (%lx) at pivot %d!\n",
>  					node, last, max, i);
>  				break;
>  			case mt_dump_dec:
> -				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
> +				pr_err("node " PTR_FMT " last (%lu) > max (%lu) at pivot %d!\n",
>  					node, last, max, i);
>  			}
>  		}
> @@ -7251,8 +7267,8 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
>  
>  	mt_dump_range(min, max, depth, format);
>  
> -	pr_cont("node %p depth %d type %d parent %p", node, depth, type,
> -			node ? node->parent : NULL);
> +	pr_cont("node " PTR_FMT " depth %d type %d parent " PTR_FMT, node,
> +		depth, type, node ? node->parent : NULL);
>  	switch (type) {
>  	case maple_dense:
>  		pr_cont("\n");
> @@ -7280,7 +7296,7 @@ void mt_dump(const struct maple_tree *mt, enum mt_dump_format format)
>  {
>  	void *entry = rcu_dereference_check(mt->ma_root, mt_locked(mt));
>  
> -	pr_info("maple_tree(%p) flags %X, height %u root %p\n",
> +	pr_info("maple_tree(" PTR_FMT ") flags %X, height %u root " PTR_FMT "\n",
>  		 mt, mt->ma_flags, mt_height(mt), entry);
>  	if (!xa_is_node(entry))
>  		mt_dump_entry(entry, 0, 0, 0, format);
> @@ -7332,7 +7348,7 @@ static void mas_validate_gaps(struct ma_state *mas)
>  			MT_BUG_ON(mas->tree, !entry);
>  
>  			if (gap > p_end - p_start + 1) {
> -				pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
> +				pr_err(PTR_FMT "[%u] %lu >= %lu - %lu + 1 (%lu)\n",
>  				       mas_mn(mas), i, gap, p_end, p_start,
>  				       p_end - p_start + 1);
>  				MT_BUG_ON(mas->tree, gap > p_end - p_start + 1);
> @@ -7352,19 +7368,19 @@ static void mas_validate_gaps(struct ma_state *mas)
>  		MT_BUG_ON(mas->tree, !gaps);
>  		offset = ma_meta_gap(node);
>  		if (offset > i) {
> -			pr_err("gap offset %p[%u] is invalid\n", node, offset);
> +			pr_err("gap offset " PTR_FMT "[%u] is invalid\n", node, offset);
>  			MT_BUG_ON(mas->tree, 1);
>  		}
>  
>  		if (gaps[offset] != max_gap) {
> -			pr_err("gap %p[%u] is not the largest gap %lu\n",
> +			pr_err("gap " PTR_FMT "[%u] is not the largest gap %lu\n",
>  			       node, offset, max_gap);
>  			MT_BUG_ON(mas->tree, 1);
>  		}
>  
>  		for (i++ ; i < mt_slot_count(mte); i++) {
>  			if (gaps[i] != 0) {
> -				pr_err("gap %p[%u] beyond node limit != 0\n",
> +				pr_err("gap " PTR_FMT "[%u] beyond node limit != 0\n",
>  				       node, i);
>  				MT_BUG_ON(mas->tree, 1);
>  			}
> @@ -7378,7 +7394,7 @@ static void mas_validate_gaps(struct ma_state *mas)
>  	p_mn = mte_parent(mte);
>  	MT_BUG_ON(mas->tree, max_gap > mas->max);
>  	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
> -		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
> +		pr_err("gap " PTR_FMT "[%u] != %lu\n", p_mn, p_slot, max_gap);
>  		mt_dump(mas->tree, mt_dump_hex);
>  		MT_BUG_ON(mas->tree, 1);
>  	}
> @@ -7408,11 +7424,11 @@ static void mas_validate_parent_slot(struct ma_state *mas)
>  		node = mas_slot(mas, slots, i);
>  		if (i == p_slot) {
>  			if (node != mas->node)
> -				pr_err("parent %p[%u] does not have %p\n",
> +				pr_err("parent " PTR_FMT "[%u] does not have " PTR_FMT "\n",
>  					parent, i, mas_mn(mas));
>  			MT_BUG_ON(mas->tree, node != mas->node);
>  		} else if (node == mas->node) {
> -			pr_err("Invalid child %p at parent %p[%u] p_slot %u\n",
> +			pr_err("Invalid child " PTR_FMT " at parent " PTR_FMT "[%u] p_slot %u\n",
>  			       mas_mn(mas), parent, i, p_slot);
>  			MT_BUG_ON(mas->tree, node == mas->node);
>  		}
> @@ -7434,20 +7450,20 @@ static void mas_validate_child_slot(struct ma_state *mas)
>  		child = mas_slot(mas, slots, i);
>  
>  		if (!child) {
> -			pr_err("Non-leaf node lacks child at %p[%u]\n",
> +			pr_err("Non-leaf node lacks child at " PTR_FMT "[%u]\n",
>  			       mas_mn(mas), i);
>  			MT_BUG_ON(mas->tree, 1);
>  		}
>  
>  		if (mte_parent_slot(child) != i) {
> -			pr_err("Slot error at %p[%u]: child %p has pslot %u\n",
> +			pr_err("Slot error at " PTR_FMT "[%u]: child " PTR_FMT " has pslot %u\n",
>  			       mas_mn(mas), i, mte_to_node(child),
>  			       mte_parent_slot(child));
>  			MT_BUG_ON(mas->tree, 1);
>  		}
>  
>  		if (mte_parent(child) != mte_to_node(mas->node)) {
> -			pr_err("child %p has parent %p not %p\n",
> +			pr_err("child " PTR_FMT " has parent " PTR_FMT " not " PTR_FMT "\n",
>  			       mte_to_node(child), mte_parent(child),
>  			       mte_to_node(mas->node));
>  			MT_BUG_ON(mas->tree, 1);
> @@ -7477,24 +7493,24 @@ static void mas_validate_limits(struct ma_state *mas)
>  		piv = mas_safe_pivot(mas, pivots, i, type);
>  
>  		if (!piv && (i != 0)) {
> -			pr_err("Missing node limit pivot at %p[%u]",
> +			pr_err("Missing node limit pivot at " PTR_FMT "[%u]",
>  			       mas_mn(mas), i);
>  			MAS_WARN_ON(mas, 1);
>  		}
>  
>  		if (prev_piv > piv) {
> -			pr_err("%p[%u] piv %lu < prev_piv %lu\n",
> +			pr_err(PTR_FMT "[%u] piv %lu < prev_piv %lu\n",
>  				mas_mn(mas), i, piv, prev_piv);
>  			MAS_WARN_ON(mas, piv < prev_piv);
>  		}
>  
>  		if (piv < mas->min) {
> -			pr_err("%p[%u] %lu < %lu\n", mas_mn(mas), i,
> +			pr_err(PTR_FMT "[%u] %lu < %lu\n", mas_mn(mas), i,
>  				piv, mas->min);
>  			MAS_WARN_ON(mas, piv < mas->min);
>  		}
>  		if (piv > mas->max) {
> -			pr_err("%p[%u] %lu > %lu\n", mas_mn(mas), i,
> +			pr_err(PTR_FMT "[%u] %lu > %lu\n", mas_mn(mas), i,
>  				piv, mas->max);
>  			MAS_WARN_ON(mas, piv > mas->max);
>  		}
> @@ -7504,7 +7520,7 @@ static void mas_validate_limits(struct ma_state *mas)
>  	}
>  
>  	if (mas_data_end(mas) != i) {
> -		pr_err("node%p: data_end %u != the last slot offset %u\n",
> +		pr_err("node" PTR_FMT ": data_end %u != the last slot offset %u\n",
>  		       mas_mn(mas), mas_data_end(mas), i);
>  		MT_BUG_ON(mas->tree, 1);
>  	}
> @@ -7513,8 +7529,8 @@ static void mas_validate_limits(struct ma_state *mas)
>  		void *entry = mas_slot(mas, slots, i);
>  
>  		if (entry && (i != mt_slots[type] - 1)) {
> -			pr_err("%p[%u] should not have entry %p\n", mas_mn(mas),
> -			       i, entry);
> +			pr_err(PTR_FMT "[%u] should not have entry " PTR_FMT "\n",
> +			       mas_mn(mas), i, entry);
>  			MT_BUG_ON(mas->tree, entry != NULL);
>  		}
>  
> @@ -7524,7 +7540,7 @@ static void mas_validate_limits(struct ma_state *mas)
>  			if (!piv)
>  				continue;
>  
> -			pr_err("%p[%u] should not have piv %lu\n",
> +			pr_err(PTR_FMT "[%u] should not have piv %lu\n",
>  			       mas_mn(mas), i, piv);
>  			MAS_WARN_ON(mas, i < mt_pivots[type] - 1);
>  		}
> @@ -7549,7 +7565,7 @@ static void mt_validate_nulls(struct maple_tree *mt)
>  	do {
>  		entry = mas_slot(&mas, slots, offset);
>  		if (!last && !entry) {
> -			pr_err("Sequential nulls end at %p[%u]\n",
> +			pr_err("Sequential nulls end at " PTR_FMT "[%u]\n",
>  				mas_mn(&mas), offset);
>  		}
>  		MT_BUG_ON(mt, !last && !entry);
> @@ -7591,7 +7607,8 @@ void mt_validate(struct maple_tree *mt)
>  		end = mas_data_end(&mas);
>  		if (MAS_WARN_ON(&mas, (end < mt_min_slot_count(mas.node)) &&
>  				(mas.max != ULONG_MAX))) {
> -			pr_err("Invalid size %u of %p\n", end, mas_mn(&mas));
> +			pr_err("Invalid size %u of " PTR_FMT "\n",
> +			       end, mas_mn(&mas));
>  		}
>  
>  		mas_validate_parent_slot(&mas);
> @@ -7607,7 +7624,8 @@ EXPORT_SYMBOL_GPL(mt_validate);
>  
>  void mas_dump(const struct ma_state *mas)
>  {
> -	pr_err("MAS: tree=%p enode=%p ", mas->tree, mas->node);
> +	pr_err("MAS: tree=" PTR_FMT " enode=" PTR_FMT " ",
> +	       mas->tree, mas->node);
>  	switch (mas->status) {
>  	case ma_active:
>  		pr_err("(ma_active)");
> @@ -7671,7 +7689,7 @@ void mas_dump(const struct ma_state *mas)
>  
>  	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
>  	       mas->index, mas->last);
> -	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
> +	pr_err("     min=%lx max=%lx alloc=" PTR_FMT ", depth=%u, flags=%x\n",
>  	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
>  	if (mas->index > mas->last)
>  		pr_err("Check index & last\n");
> @@ -7680,7 +7698,7 @@ EXPORT_SYMBOL_GPL(mas_dump);
>  
>  void mas_wr_dump(const struct ma_wr_state *wr_mas)
>  {
> -	pr_err("WR_MAS: node=%p r_min=%lx r_max=%lx\n",
> +	pr_err("WR_MAS: node=" PTR_FMT " r_min=%lx r_max=%lx\n",
>  	       wr_mas->node, wr_mas->r_min, wr_mas->r_max);
>  	pr_err("        type=%u off_end=%u, node_end=%u, end_piv=%lx\n",
>  	       wr_mas->type, wr_mas->offset_end, wr_mas->mas->end,
> -- 
> 2.46.2
> 

