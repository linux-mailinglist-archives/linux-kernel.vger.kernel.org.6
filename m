Return-Path: <linux-kernel+bounces-548415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B7A54489
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF203A56FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1815B1D8DEE;
	Thu,  6 Mar 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VIcKitJq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RreJYnUB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782832E3386
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249187; cv=fail; b=IqWGASyX3z5Wv227d94Nwb9kANC1NKIJHlP8d/H2YvNy8ET1rmr57MPL5BxfWr/vdMHrhmYQDobDmDOqsMg6UKt6efomUC/c4OeSTxnr+/4NaEUvKX0VhGrSZxksvZYvvjNZ2Ja/fCLdNQWn26o7uqk3ZQo0iM8sGNkA0BEaxlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249187; c=relaxed/simple;
	bh=l7dzdyxb7J9QN6TuokdbARHpLmrj2S/zHtWaHjkyHvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JLe0DqulZROLtxPn5LcizbuPa4IsTewNhOvRjo0ePW2/MFdkGgftrETFxEd9uBkY3LiAhrt+cQZVbTaOf1Zuoa7FT6YLvV7wx9trGyiyg3z9MwHnzfWUHyVwQ5WV09lZ0IWLABXwkONfOyWtuI+a/dUyPTnyf9kAYhmTEV88mrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VIcKitJq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RreJYnUB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5261thoB002993;
	Thu, 6 Mar 2025 08:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IWxBKJdypa+ddZWnew
	MnAuV6WpW/AIDZLhfa9CuZkjc=; b=VIcKitJqUiQ3B85KbNR9G6xAKtMXmV7kpJ
	X4ZEPPtJUtK7Qr6eeivCLzeVp1enoQ7VNuuIkeB0DwFhRnFtLfFrhT4dzn9U3XmF
	/GInQYIJYvsrN4X33ZsKVwiSDJif5NzcPnmqNsIvFWaREnuc4yy7msEEq8xPQKSd
	1w2dJn6nI3IjBr6uCxlN647wzyGtK4kwr+RWLgRO6V7tep1ogLvcOua7fuXJcVST
	4GCDJS4leweX6dqQcbdKExKVR35vtYXmtzv5rsSnxhMaA6LlpvElbtYChulJ+kxP
	UvEKSG7a28X1TVEKRIhw2gznyn0fB5OMe2DGLz3IXf8o6n6rUbfA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hhkf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 08:19:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5267j6LU010885;
	Thu, 6 Mar 2025 08:19:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdc46m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 08:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA8Fttks7WqNUaUeNZTmf5KJf5FOZedKRiFQp9nF9IWfZRLfCL/M8h8akfxu4mjlt8EFhTE3QPBrV/ZRb8w0esb3AxBwxDf9tP5fiMOkotpFm8L1NBHxpwhlaYF5LeWoPrl6L9mBD+uExxMes+SUx8R/oWJZhop72gt9s5hehhjNQP+f+UA17QwZ2MTiCaiUTK6NDAvUuxulxkTxHks+1Va0Qybe9OYBm0k+HGGNetDVguf0ur0r01mWhlkLAcNQYPU1jJOOa7lA1X+s/2ONyL48Ga5avvH76j69QysIb2xwx9ypdxa7wONbWC2VJsL+MVQOq8EHW1vKTf3d0742ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWxBKJdypa+ddZWnewMnAuV6WpW/AIDZLhfa9CuZkjc=;
 b=iwyOEzFgakMT8CdDrrKmpmBxTwEekoB5Ij/HH5BkMOcAiw5e8QvZnW+ycACCW+bUS0GHFE3bcTGLoJnEyLw1k3HHUtDTtTBH80jiJ0KGWbXzghrA/+ZDKNRgcxJJNBVXdFmxL4KQxEWpbDs9AUJbVrzba8eWvi4//8whDXlu6I8pDtnz0/N6sWbe11+SdIUo2ocU6IqHnAWhyXl+Q5zNMNTmChWgRANJ/W9vk65eBPIt5/TIlkcWnRRzw796r9Hs9lsKZ485Tms3JMus1nbIjyy3Lpx1LcvSKjlwv8ianfcNQL6BAEx8c9dM/0vnDx3RjwZ1A68E/kxuC0Eu4Yll2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWxBKJdypa+ddZWnewMnAuV6WpW/AIDZLhfa9CuZkjc=;
 b=RreJYnUB34WMb7q6n+IIWUMEF9MtCkoV2XokkaAUw5YO7nN/jkjFW/HWAYtOfVhCxs2uHaPprKVDM1rv1YIBlsTsmhyCYUp6UtkdVzqhi+vScMaUuQEI+rGNvBfEyllAKx5Exn47ztiMiFZR5YsBPq6nPMtUGwnTplmOQnaKgfA=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA3PR10MB8185.namprd10.prod.outlook.com (2603:10b6:208:509::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 08:18:28 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 08:18:28 +0000
Date: Thu, 6 Mar 2025 08:18:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ryan.roberts@arm.com, anshuman.khandual@arm.com,
        aneesh.kumar@kernel.org, yang@os.amperecomputing.com, david@redhat.com,
        willy@infradead.org, hughd@google.com, ziy@nvidia.com
Subject: Re: [PATCH] mm/vma: Do not register private-anon mappings with
 khugepaged during mmap
Message-ID: <67f0916e-9825-4105-b044-a16c0e82e736@lucifer.local>
References: <20250306063037.16299-1-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306063037.16299-1-dev.jain@arm.com>
X-ClientProxiedBy: LNXP265CA0096.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::36) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA3PR10MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 60946f82-8d2e-46ff-feac-08dd5c877977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0VGtXzOMYRCGYMujlEAtYTb9x2dJAdIpI64VfL7G0+/XoZrlDQTKTubMb0Ab?=
 =?us-ascii?Q?WSBdLHIWNkxqTXWktp9Ozkh9c0m+AkaRu3rgDJF6Y4FmXn2NJcYcRwZludaN?=
 =?us-ascii?Q?NKEtQyJvuY5fITGBR54dX7yjNuWPdjNYh5pXcsLEtnhmpRdnFhvLNoAfOvro?=
 =?us-ascii?Q?9+q3tP0OFy3HIKzi2tne1G8lSOof/qWuEHL6te/cJLIdGg6SBVIgRSYPkcs9?=
 =?us-ascii?Q?4b7lyPJCk97Ec3ADcMydSS8qhi963A6D+wXO/CKH84oIKVWnvGvOKNE+QPCh?=
 =?us-ascii?Q?T8CvyzhPNsqMeACTqFVS/9C7izrtIRy7A5K9Jrmzi+9M+0sQWD+HquAD9DFK?=
 =?us-ascii?Q?GVLR3pnkW7lg9GN6aEmyLFtT/QYfAOP+l8rNeInICWVLHhZa6Bc6u00rKEnu?=
 =?us-ascii?Q?pnsH8BwNl48Vxb0JAEh851IggO+leDAl22UpMMmDUtZTGvwYJbDuQEBMREJx?=
 =?us-ascii?Q?49UuQL8foApYpbSid+ypmXzZIE6Wrpnvak6u/jlqupJ+xu5KCMSH47b0+KPc?=
 =?us-ascii?Q?LlLuM7LnVPWlAl6Fyf83rwnU3mE5bqrsFypCC5Xs2XFZCbxzTevbfZdiXodY?=
 =?us-ascii?Q?ikXqJEE4nrRyNNQ8tLiLDYKjxWrSOXs1S11L9Kth1dTZ1mV9JCujjUTEmS8w?=
 =?us-ascii?Q?WEwhAmen7BvPjBDRMBHeDG01dXV6EMZH1UMRSM17b3NwSA8nye/eaSSh8j+W?=
 =?us-ascii?Q?0FUTwOF9Vum+M234H7ZgYB6S2Ks3Hfv3I3++XzNFmI6VOEp1vOPMD4ClAaML?=
 =?us-ascii?Q?xTKXV0SthLbMy4F9bg1IOj16+8ZhqYr9BdO1ytXQ1ULDkWm5rVf8CZ/87fS6?=
 =?us-ascii?Q?9K9dZpmm8ADlSfVCtGJ9EefapNJR74cjTZBHuJt3ntHB07uq7CbnTiqHXYEB?=
 =?us-ascii?Q?RF/HhLWXOXIZirdP79N8O68GZVNxxC242H/jcfneUO0rkiwCsmD5cI9F5jmK?=
 =?us-ascii?Q?hU7L+XWMHSwO5MbrSr92MpQidSC8s0Y+e3Js4jYUxn36Dtn/BzSRdD3TJEEB?=
 =?us-ascii?Q?AZd4q/36CPSMNxaZLTaaSFLFK3Zby2kEGSiXiPcm+37Nhpw75gddH0fVhYs1?=
 =?us-ascii?Q?bR9/cfxf9Qfu0dT+pmXv7aLAlPD+XdHUrKSzovVFBiWOnbX2gJHABMQTCQcs?=
 =?us-ascii?Q?mJPKuqOvXE6bWUkjUPkYO/mLO2OK6X3PQNf1mFj/yNJMNHJq7yxdrxH/QAg3?=
 =?us-ascii?Q?XDxKfhHcmd6yzG89Fv7JgutgMXkgN6nHf9uYDcyVnHE61skpXjQwHcr0HiW5?=
 =?us-ascii?Q?NKdMP0+rOwX8nWkujY4MMbyCQk+hzQ8YnXBzgvxy/ksvjtRs1BLlfQgOdOuX?=
 =?us-ascii?Q?I7PfXVYLpoyDRrfXAToz0tH8bn+VNonUNwyZVArfJ3628zvK2SB+A9z5Plwe?=
 =?us-ascii?Q?myNAlfcrvUdCGXs++CkW8+OR1S82?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8TOZxIo7Yy3H3ZRidTw3Q1uNDrqxJ5MPJqhWAnh0V2piKfktmFLmXfhoWbu4?=
 =?us-ascii?Q?3DAXE9kAs5aBU+QQshyIFnJgKfbHBZombUUtCQ1we4LoF1wv6vAmrPfBOXgU?=
 =?us-ascii?Q?GD9QDoxlTipvO7JWMuGQ8dLgIHbuvLgHTZndQg+lt9b6dgpWygzuTnRaXrLt?=
 =?us-ascii?Q?AD87YLLgmvi+TG71AcCjBq9hjxZVgcG9EFOS0XEsOeLYDs+IBSNf1/GcDEXo?=
 =?us-ascii?Q?DFne7ea0LabSQ/3VCXS0dUBRkMtAzq3AdNQdfwhvsYntD9MRCvtKepAjS2bI?=
 =?us-ascii?Q?3EWB5YF3bwGdjGbQ8eCMAEvpxumhS9A+ZV7wVi4lQHptQyzaQa4lzhEeLJxZ?=
 =?us-ascii?Q?dyNp5Ly4NzaLjbRfhe50kBa4GU5Zkx3zq6mg8E0TaeLhKFz6/XcRJ/sRduiA?=
 =?us-ascii?Q?bIIjiYr3nJLNGwRh/52hIAedEqAKO8+DbCszTIIEy/4VEIMZYSbi2SVU2dPF?=
 =?us-ascii?Q?+nm4PDH9Rnz3HbtHFJ2YKz9upwr5A+WBBVBAlDUD3PluWqYS37vYuJ075qA9?=
 =?us-ascii?Q?HTlVbrlXZ/Edr7FIE2xUd6dp5rMt7dlobbPdlgknL0K9QheKwyBUAlgOuGs+?=
 =?us-ascii?Q?6clxKn4KeIfbeLEVF4m24rLbZVB6CijZU0tVE3BGgNTjIXO5bP5iNGuMqCr/?=
 =?us-ascii?Q?+jrcUvroavHZS8qILjQp8Lz5GGY5MhIgogmcSfO+j1B1jQWSZKp+N7+uu52B?=
 =?us-ascii?Q?Sl/MLbUG4WHj9sMHjh3LUYR9CBVUb9Z1S6qBNkXLb4cV++IQ7/VQXRx1PHEL?=
 =?us-ascii?Q?HjICexh1DbmmDlWFtQ5I3/19JKv0SUwSlgUpXTMXOzzT5x7FSx0y7MGTn/yY?=
 =?us-ascii?Q?ostRaCrimIXIz9nZeJ+tSGPeYdy7nJdtniTpR88L3EGF1LC2NeM8dPZsqQSm?=
 =?us-ascii?Q?1itdDvVKMaKWabfDW14z3z3LzN0UB3JxlSvVMxaEFnhRJHq4CH9DdYrhe4un?=
 =?us-ascii?Q?e0mBq2gZ2PjSAVnT2JblkhEorkiGg1mb6x0NvdlhCmGJiJgGDNWuytUu215R?=
 =?us-ascii?Q?psXT8z8Wy8rt7R53F+6JU7XezHcvhHhVJDrnFMZ8sjg/oZMqOmIYiH81PpkM?=
 =?us-ascii?Q?/TBdQfjJkkmJv3ImAObkTGZI+RmPoQ7Ke2Z8MTuzsDLAOKJJYRfzPubeMTm/?=
 =?us-ascii?Q?t6SUQod+tZ7jMkY52bo0Ppqn58S1AfaQpYsvb4/k4ByBEeCuCEBdDRQW/we9?=
 =?us-ascii?Q?qRsLSUa1Xh5p51RLfXuJVZURQzRiRhzpyfaI1xUTV/BF8/9RqRxMkWkaU8Iu?=
 =?us-ascii?Q?PwZI6W1Hg44pmhjwoIiJEc1klrR8UAPAldlS6GrSiObayCMn1POe551woJuv?=
 =?us-ascii?Q?Zi7aSM7I0JhCDpXK3n3mw4xQ2Qhgjl3tZ2POXtrHEYIiuMkdEMLH6rsd+2EM?=
 =?us-ascii?Q?XJcQXynjf/rUDeGCQJerSpRHTqICOUNuZ8tXKDge4+XDvk2NRmO6vVjvjHXk?=
 =?us-ascii?Q?CNq9PfBQYBdJxGandLrjIvOGZKiyAPwUSW9IRyrmg3qlqGm/CHuKf7EYa+Vi?=
 =?us-ascii?Q?wFw8Buq3XiDqOGPnO/tdWCve5Dh1sMG6Fmk2JjZXT478KyR+rOilxHaxaErG?=
 =?us-ascii?Q?hgIqsmPYqh1NNVhnsRV+8tmCceFX1SpdZTHegV3/MDOs8wQ30KiG3R9EqqPM?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7AndQzUiMk5OunWKNUd+noWvmYhapPK4LZVr97Z/FuqNtMhvrGdC1lMRA5LkTs1CN6UCVMXA1QNDutEF7bJYy6qr9PRUQ3IFL0qZ2YYgFlkKOxAlKhRyhjMzsXD4e/yiES8062zRqxJc+4z91UtlQSb5FL+ui72oGUM1awGkOUDbv1gBTESrpIaFTy2eby3sRe+tW4WtRnw4jIs8iF/zUJAuxBdFCSEjELPlM5hzdI/HXyvCTuOMfawb+lH30Lgk9f55dTF6XeAiojl6YAqAcSSDkYSh0tc7nCnsgStraSKsHLP7LKow1CQ65T6rgYPWJVSgy4koc/KqLxhHVT/7PSLCsC24RUGy1XT4HVgoS4XiMLgyswSiNzZp2EPY9jPMIbQVoLoiv5TDfUJ+FomdTQe3TF1CJPm2z3uqt/XKL3qkIPzLhKE/q3pLf5qbKvtN+TV3wZMBR95Ux7Mu/sjxwwWcaY+gqBucaSlEWpvZswfgSNYSQFGPg2Y/4g39Iyfax+EFcjhezFIjlg9rBEWEobBIE03PQUILTUB2fO8lA6WOuFqdeUKq9xHMBeU5uPGWQxAltHtC5W0qD1ELRojvr/pdn2uKnPINBdjY4gsCNnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60946f82-8d2e-46ff-feac-08dd5c877977
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:18:28.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH0Rpb8X11q4yGB7NDJZVEvWkpSQk3H9Qif5VUA/8dgJXJQH73F5AuEgI1f0unEQyjRBSej3ExBclkQEZcHkJ9tKRdw8newwEiN3uLnvYrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=946 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060062
X-Proofpoint-GUID: bOWTWf06MTqj9u2tkKCS9EzAYS65cgei
X-Proofpoint-ORIG-GUID: bOWTWf06MTqj9u2tkKCS9EzAYS65cgei

On Thu, Mar 06, 2025 at 12:00:37PM +0530, Dev Jain wrote:
> We already are registering private-anon VMAs with khugepaged during fault
> time, in do_huge_pmd_anonymous_page(). Commit "register suitable readonly
> file vmas for khugepaged" moved the khugepaged registration logic from
> shmem_mmap to the generic mmap path. Make this logic specific for non-anon
> mappings.

This does sound reasonable, thanks! Though does need to be expanded as
Andrew says for user-visible effects just to be crystal clear.

>
> Fixes: 613bec092fe7 ("mm: mmap: register suitable readonly file vmas for khugepaged")
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/vma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index af1d549b179c..730a26bf14a5 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2377,7 +2377,8 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
>  	 * call covers the non-merge case.
>  	 */
> -	khugepaged_enter_vma(vma, map->flags);
> +	if (!vma_is_anonymous(vma))
> +		khugepaged_enter_vma(vma, map->flags);

This really needs a comment :) as a Joe Bloggs coder coming to this my
immediate thought would be 'huh? Why?'

Something like:

	/* Just added so khugepaged has nothing to do. We call again on fault. */

Would be great.

Thanks!


>  	ksm_add_vma(vma);
>  	*vmap = vma;
>  	return 0;
> --
> 2.30.2
>

