Return-Path: <linux-kernel+bounces-531814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF7A4455B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B21317ECDC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB5217B502;
	Tue, 25 Feb 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DQSt8Cb9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rjRxt2ZA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC67175AB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499436; cv=fail; b=AQaPlAyDl6rKJAMz50cvJe/8JNWY/L1A5GUfuJ9VZLSgVIgX8UJ+P/R77qdsEq19/8aIdESKWBfnuOKMW5VptZlJYTQbaTTFxdGXVmv85YFIsD1V46LgjmpKR2jgpbVA1rQDLu2GIkXo7KvS7oMs7tqptAVKNVMp/bdxpGJDhe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499436; c=relaxed/simple;
	bh=Oh3AkUM8i+BVvgb2c3bZHTmQfHjK5O/MlRyzsXEaL3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FikMSuKgom0rlbHLCMZLv+77T8ic5t9e++11D/J8ztnOV7SVitCFtzz4ejkeieqiFvXu6/Lel1tvd737G5Sk8T8jSHU4WsPCoy74rO3D4wIxYgJPN2xSeXizSZGqcZm02fUuW5/dz2+tlUvznnZ6gqD5Q2nXJG10wEtKeUhBlKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DQSt8Cb9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rjRxt2ZA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMb4i028762;
	Tue, 25 Feb 2025 16:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3aA7n35RztzFYratju
	HHP+++E6haNfWo+5lwqPsDXPc=; b=DQSt8Cb9fHs1fDALBdcUNRs1wNsSq1pHjx
	cw0wfp7q06CO5txLm2sM8+1j48rKp//92nULzYi6yJlQPTC1diAkJdivQzlx7rhT
	dxJMUm8GJLiLGgloC2zc5sk64bpNHAnzHXLpBxuFz2i60q8gRxQBtKmeCLBvBxMC
	+MgrR9uH+zKmQlkMkyXo5LT1SHRK7ZBuA6wCYavbC8LKemlI2330L0frIFoe8eNI
	KKHXxdH0vYewhuci5nKs/7k85GYRTWUcZ1DRrbQJs+pzkeIv3uQcYU9tf5ZhPVyy
	Cy9rM9DvMRsO+rRO8J9JcDeEdyaP+CXKgJJBNQcP4ULoY0uZftgg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t5kfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:03:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFRIKn024381;
	Tue, 25 Feb 2025 16:03:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y519emdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:03:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwMR8TesfaDiNwKAx00hV8nfJK7+IGbSHJuqhqRBZqvVsUIGXQDn98MzoRWNRf6iiz96bGQz0TfjkF2PkDLojCmYmFhhmYqOp7jshpmWi1FiUCpzyVT6MlOQSdzJJ1XpwlZv7J1ZaTEdpODywzI6lfHHUsLDKbwEqtMK+RG5AYyaiLJCO4li6Q1MGht0vINZT/Rwx0pkHMzi1b4T4gW0AZZ1tmDAaPzJwUPXZhrOHTOOL2dvGEIY/2yvfIckiJLER2GYJtoUMXP2Sa4ryaj30D5eRlrjIrCkToWs3WJWnZ9k/bRRukt37p9qLbTnYVfjkA47lXNzV4z7FGpCvH1yuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aA7n35RztzFYratjuHHP+++E6haNfWo+5lwqPsDXPc=;
 b=RsCOZ+bw+RbYk8NOBpmQA2eLoyx1JpZm1/tBYQXOnudbrgJzxfH5+fVVqJbatLhKpyW9F02wO1qrdB5+CaE1vzW+J3AVEd6IV1kO3VVrhYCKLZ6uelPAnUTgf5mw6+BgReRhfOCGlGvpWRbnrEJp0Vupg0Ve61/hNJ9XfQdUgfVh9300Cs0ChWZK+S8KtSyvncGFdypbajeIDhF90lLTC9bXPu1BPooT/AWj0FCXoB48+mTM78FK0UkJRYmemuOkgrgheu7WyBIeqd99ptSItUUtpek6j7u0z7lJIhdd9RnfRnLwxTpuSq2DINr42MT1nWuOJs5cytfnE/USVTqAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aA7n35RztzFYratjuHHP+++E6haNfWo+5lwqPsDXPc=;
 b=rjRxt2ZAVRyvqzJC6C5X6SufDQ10VzRNtQ7NSp6Og+yvUUghl+rBMpcNDDAi/35H8TZ3GXOVuunBjSPvS0K30YqPpo+7a+wEL7LGXjwGRJBKUO7eHY8Sm2fll7pyvFvsqRt34HB0p/qui8GALBvw8MWMexkpuacF/c0hOnle0i8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4610.namprd10.prod.outlook.com (2603:10b6:303:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 16:03:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:03:43 +0000
Date: Tue, 25 Feb 2025 11:03:40 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2 6/6] maple_tree: reorder mas->store_type case
 statements
Message-ID: <ou54b7osedufg2wvw5wz6mfhzepnkkckeuh34yyo2nwffvpfxb@jrjzdcmuxkdi>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-7-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163610.578409-7-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::12) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bfc5f3-1baf-4c1e-9741-08dd55b5fa09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KtlZwpXv494bHimS6KC6PWyXmiUni5u1R48lf4VggsbheIImc52+nchVqm4Q?=
 =?us-ascii?Q?TQ3jYe4aRueuaT3siiw6ESOPgynUsiFdSkP9a3Qe6f+lSlBVVlX470ZgZeqm?=
 =?us-ascii?Q?/XWtgZqLKWD0MZNfsCrSiMDtd1DCL8ITyUFCtNpLdKelG0Y5o5TFNIO0fe60?=
 =?us-ascii?Q?5ZwZyFRatWuysP1OXtfDE5QI6HUG5AoZYCHR4o3FJnv2hRIHZNNNbCqtNefq?=
 =?us-ascii?Q?FYHwyp5Tsdx6Pm9Q6ka2ICZtUu4tEK761VKoeJluM8g2836QADfC48ZB5hIJ?=
 =?us-ascii?Q?Gwg0hAj6wHNS8/j9h11ygH3TgEVuCvCsuOLWr12nCgf9F85wWg71C5Xwg8UN?=
 =?us-ascii?Q?vQNTLnOLhSYawe4XXZ1msiNAyZ89HaIBjgiF7oPlsrp1UxHTOIRLNM+GSWxK?=
 =?us-ascii?Q?pOB7ZHY5rtFwlclJt98+Ht3mNP8/MES2b+nQoC4fM55/8LVwLY74nqWssdVw?=
 =?us-ascii?Q?dk6r15Adxoe1s6gTZHedoMNq67vmm/IXtwQBwSfCHTRETx0KhzBN9Bjn6FdT?=
 =?us-ascii?Q?3VLtv2WyOoWjzN/uF8+Jwp6RXM0OOUC+0NOzKt9v/zL71BLvdOQtZoVk4r1E?=
 =?us-ascii?Q?KbEuMDyTZFeRBZf2ABEdHSvdscfsQ7C0QiB6QIad8nSM4wo82i+Mcwx0S7LK?=
 =?us-ascii?Q?kZNHitF4BDYCn+h/QpK8OLJ0Y/hxNnCq5pHxer8zG+u5jmLGVj0xfSmPQ6aW?=
 =?us-ascii?Q?dlTLFh+YybqoDEHlkqCeu007qj8e/sN6b3IG685kxabejyJOgsZCfujT2xjf?=
 =?us-ascii?Q?M6mT/30hEQo8MpmQK4PjcMUQNBEcGih+vZPEqX2FDcRy3qz/QBIHyuvshUGM?=
 =?us-ascii?Q?QIepegpQ0Ddb0W0QeR4PbWeL7VMW7tBYbV0E35DPPW9JNW1kGzY3Qt0gVueH?=
 =?us-ascii?Q?+dUxr9Fh60AinNvhhGX3Of51LBiF7fi/XZkPjHv8XP9b3AESjuu0RoasTR9o?=
 =?us-ascii?Q?aDiIrRv52RpiLc9zn9ZvbNOGPhdXThjlcDCNgE5a4QGYlqkoK2Hi9BvRx5Nf?=
 =?us-ascii?Q?Ad1QBaBOZsdIX/0mfSz8AnZipq44+JOtmJ3QNZ2Y1R2oPqmI1HR1mg7UrYVN?=
 =?us-ascii?Q?7pIfXBbnK6Hx76FVutAQP4BOheHPWMghdvXIWPMMAw8zNEmjEr8ovbRy+Upc?=
 =?us-ascii?Q?5Utw3/AXQC89WclvtVom5gH2FF6PXwRbtCw0jdf8KuNCs5ETCr3Mto6NXHVL?=
 =?us-ascii?Q?w3ChgOndT0nF9tcKVWZZFqwjMyNSqKhZNXWpj2VY/iBldXeWamIsvfDNt2RE?=
 =?us-ascii?Q?7XSGVPr0Tt7/2xa2C+ysuW7HCXTuJPC5swSTQSH6zAfKRmD2YKK8GZLLhFPb?=
 =?us-ascii?Q?e04K8lRlJtpXuzmexEZ6kL89NuGbUxXmL6AzjFh5xIo2saXgJ+Sw5GXpsqkU?=
 =?us-ascii?Q?cL3jPf1JBaRrZcC/M/+8rkj0dupmUyhzcltqUjeZ1XFwl2jBhz7+4KS8qFfK?=
 =?us-ascii?Q?l8dCS/M18Zo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vByoMnv5c/UZEZq2mwgNj7E3xuPitZeaES5njb2pEAVKov3Wjg3B1YiLOJpf?=
 =?us-ascii?Q?VuC8eUfUjoyucmJPx0bfLgCARFbUD5D7hVPNL6pfeqaC56iuBs69V2zuQrzh?=
 =?us-ascii?Q?dK89D77RmcfmeMVgxa6oR3z3fGd9j4g4NFKIoAc5PMLwqz5GySun4OiiynLc?=
 =?us-ascii?Q?wA3pmZR8rZf35gSono6B4aPWaH+zoAlIseCho1O+zjIsGLGscNUjtNjpqcg1?=
 =?us-ascii?Q?9u+aUWSLxS6bMQz/tFDk9D0YLRFMpvVFoC9NmHWsbXPjc2CNixTgiorLF7zf?=
 =?us-ascii?Q?bCUNNCxSGrUd3Vex+rA7DGxtTZWGD4t1d396YTsr5rQKEMrOGOkoVlrhf19w?=
 =?us-ascii?Q?mzAM9JDD4Gq4Ltdpo485sfJwOfWrlqa8rH5zoV8uW6ZNqNDESm2+j46Gyj07?=
 =?us-ascii?Q?JN/t/CUK/93YLWBrVmw0YSfvQhaoCmLlLSITfjN6qmSbwFmJYKxorrXrINMD?=
 =?us-ascii?Q?utLVZINhHHVpqj9mGxexFQvHlRQj1Wzz1c/VU9QORPWBtJ+TLAgHdJ+FAXV/?=
 =?us-ascii?Q?P2r5Hc7b4eIA1aEMcV4CbFkj82atchXGWVFzKfq7wGNXZKpS1anqQOcMRO4R?=
 =?us-ascii?Q?Wv/OpI7YjMC31U7buCOAxNdgMqczxF4+hyUifnbJOCHfTUXTyiCYKWgVAYLO?=
 =?us-ascii?Q?UAq4sNPZIhl2CO4OG4Ie7bhpKHHE7Avf/hxjO9Levj9HamMhCKPI3dQipzw5?=
 =?us-ascii?Q?e/lp82oQqEjo2Iot3JFQsHcBjco7C8EoBKjOJ2FZb98j3FoDSd6Keny/qPqa?=
 =?us-ascii?Q?3UP7UZSCkfdD+a9QVVPLqjPpBttrVAFyvJOF8WzRUg8yOgd10PqSHdwrtpfE?=
 =?us-ascii?Q?LsyPS86H+yq878L+i8tJQGfjFmnuV7q88Q2n3xnO+KterEZj2vMq1rHLihY4?=
 =?us-ascii?Q?jW4s06Q0BDjXpuZzE/Cu1GjXitQutmOTMBTscKcKNx7EPz0+KmLbuiArTMbs?=
 =?us-ascii?Q?KOv4M8bmDdTt0mw46iOPM+RgqsC7XP47Ll/BAPoio/U4eQLwTnh4m5p/x1AL?=
 =?us-ascii?Q?JqVxHZBBe2f6DFocvbyHGm6uaYTzg5sqdGNX665K8kHTjIOFOmtdjDy0c2Ia?=
 =?us-ascii?Q?0k0GcYeSOiZFvcACXDdKQ3yNVEWrsDVYCuEyuis/nOptMZvUnkLvM0mx31yn?=
 =?us-ascii?Q?yo0xjpH5Zxxq9+dnvnFTuhrOwKCcEUJq3TVrphobXp5DiJ9u0rF6pGrbkAJ9?=
 =?us-ascii?Q?zmydH0zvpMxO0aNhJqWFTVgZ/OTYlnolDx5B87WtuL7R8rEKpU/oZpwCrvq3?=
 =?us-ascii?Q?YITPWyBPJtOLouqGMq1BqA6RMIv7eCYqMHRC8M832/qW8EkVcqKsDiJfUId4?=
 =?us-ascii?Q?IH6pzcvrrumc6d4h4uKSVdm3vlf87l+0l9BQJJ+Af9v1NSXdeFnPWj4PsV4j?=
 =?us-ascii?Q?IwEY/BwEwjU+sNGrGhMoCa04g3JwNJkW7bqO3eAPcb8LukMXNVScWDamWaC9?=
 =?us-ascii?Q?RpyD/62ik2dc9BXnap/Xl09FpllXQmwDgAE4wpJFK6G07sLQXgJW2ABPtSUg?=
 =?us-ascii?Q?cLz0/64/f9LUlLzyH3AH7GsNOHUY6KxgV9YMxZz9ApgpVF6xLSZYNd2axPzO?=
 =?us-ascii?Q?zv0agAeuV8DOOtbVHBxhx7YdEcanZDy0JF6OcWI2p7+rAPgngso1JZRbRuHH?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pHaPkZ41Q1Kj8V5hvHQOMv+MX2j75VJumVRfUz4VsV4XyeHEjlH2aeVmfJTv68E3HyjpD8/mJGDfvow0GKcSF0GB8guF0Njg+Kho+KLS2D4eI/9afeBIIWn96PpdN7o5u5CW9yvLq0p6R21jmkMBk+1oVxoeVsOJJgOS68O6zRA/NfOWzO6j65rfwH5LNkaPlSxkez0ROGEVjduXkYqU55KCmzkNUHebNO5NWkNynV37NTCrV55WXgQ12Lz2B9B2ja168E5853cLM9Wqlgm+ulQVFJmOxRhkOUCzlQjWwIQFkupWEc8yy+GpJpWibaajJrkHr5+riMz5QylReZ08DFZ8QweZqYybnqzAAJEWZA3YgMZPF9mQhXIOyWM7J6zom9EM7hoc/tDY7dsWYY1+uK+EaBp6WQIGDkssAEytBTls3hU0DpOotzH3TlvY9jvAu6E8+7mJEHZQ8ZM99T+W+91Sr1+GnQy/8zXCxygKtagOMSiiTXA4c6hG4izatTfKqUHwzMfAnHOBXzAUywVug6qlLD3M7XuFSY5RpQPgu0hF4zFXDKG/AaECr8+cEeKTHzy2Taxy0QXaGe3DLN8dAlS2XZaan2OuKrXv+2C2D5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bfc5f3-1baf-4c1e-9741-08dd55b5fa09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:03:43.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHg4mws8SNOoe08jrr/Zf0ufwPbewtd7lvB5lhrruaYiLo6A3E8baJt0SK20YLttVfr+qROb+XPBMECoJ0dYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250103
X-Proofpoint-GUID: DJbOijt7AM6VXBPnO7d721CGblFRFhTR
X-Proofpoint-ORIG-GUID: DJbOijt7AM6VXBPnO7d721CGblFRFhTR

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
> Move the unlikely case that mas->store_type is invalid to be the last
> evaluated case and put liklier cases higher up.
> 
> Suggested-by: Liam Howlett <liam.howlett@oracle.com>
> Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>

Thanks for doing this.  There will probably be zero change in the
benchmarking besides instruction count, but it's low risk and low effort
to do.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  lib/maple_tree.c | 51 ++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 8fdd3f477198..36d7d7a27e32 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4091,15 +4091,6 @@ static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
>  	unsigned char new_end = mas_wr_new_end(wr_mas);
>  
>  	switch (mas->store_type) {
> -	case wr_invalid:
> -		MT_BUG_ON(mas->tree, 1);
> -		return;
> -	case wr_new_root:
> -		mas_new_root(mas, wr_mas->entry);
> -		break;
> -	case wr_store_root:
> -		mas_store_root(mas, wr_mas->entry);
> -		break;
>  	case wr_exact_fit:
>  		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
>  		if (!!wr_mas->entry ^ !!wr_mas->content)
> @@ -4121,6 +4112,14 @@ static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
>  	case wr_rebalance:
>  		mas_wr_bnode(wr_mas);
>  		break;
> +	case wr_new_root:
> +		mas_new_root(mas, wr_mas->entry);
> +		break;
> +	case wr_store_root:
> +		mas_store_root(mas, wr_mas->entry);
> +		break;
> +	case wr_invalid:
> +		MT_BUG_ON(mas->tree, 1);
>  	}
>  
>  	return;
> @@ -4185,19 +4184,10 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>  	unsigned char delta = height - wr_mas->vacant_height;
>  
>  	switch (mas->store_type) {
> -	case wr_invalid:
> -		WARN_ON_ONCE(1);
> -		break;
> -	case wr_new_root:
> -		ret = 1;
> -		break;
> -	case wr_store_root:
> -		if (likely((mas->last != 0) || (mas->index != 0)))
> -			ret = 1;
> -		else if (((unsigned long) (entry) & 3) == 2)
> -			ret = 1;
> -		else
> -			ret = 0;
> +	case wr_exact_fit:
> +	case wr_append:
> +	case wr_slot_store:
> +		ret = 0;
>  		break;
>  	case wr_spanning_store:
>  		if (wr_mas->sufficient_height < wr_mas->vacant_height)
> @@ -4217,10 +4207,19 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>  	case wr_node_store:
>  		ret = mt_in_rcu(mas->tree) ? 1 : 0;
>  		break;
> -	case wr_append:
> -	case wr_exact_fit:
> -	case wr_slot_store:
> -		ret = 0;
> +	case wr_new_root:
> +		ret = 1;
> +		break;
> +	case wr_store_root:
> +		if (likely((mas->last != 0) || (mas->index != 0)))
> +			ret = 1;
> +		else if (((unsigned long) (entry) & 3) == 2)
> +			ret = 1;
> +		else
> +			ret = 0;
> +		break;
> +	case wr_invalid:
> +		WARN_ON_ONCE(1);
>  	}
>  
>  	return ret;
> -- 
> 2.43.0
> 

