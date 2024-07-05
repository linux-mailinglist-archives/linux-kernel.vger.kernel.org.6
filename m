Return-Path: <linux-kernel+bounces-242759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043FE928CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C717B26DBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69516D4F6;
	Fri,  5 Jul 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7de/Am5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eVG9oaMX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E1170837
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198988; cv=fail; b=JeYjsVnCtpLbpDv73KD+X0g+C3la6l7VTZP/3d8zHfHpvyLabr4knwc8YhrTHtkRMwFogoEdI9i3+M8lujXeLQQvNxXdt0kvKdDMA75yF6yo+imOZTshhGl1I3AosPm+EzIlWNC1wMuuyMShwq1iqanpkvtyM3P3egWc+ci4hsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198988; c=relaxed/simple;
	bh=oYD4PFrb0/W9gTVJJlTn5qS+CXXVjVhpdk0RPIcaDbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VPfYvLmPFOq2f0G0Az6TR26nLAQ7laIBCLqivVVcRti4Ue+IdZCzB3kmSA0+dEh4NSt8HUBp4yDjlS+StCaqMRRTHAlZ3HAs/NhTqZPI1+L2njG2G0Hyg3FDqF90e8vzA/iKLqIJT5hQdwuscKb3/34rRZpaLCeOjEapEcJPsXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a7de/Am5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eVG9oaMX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GO2qf010410;
	Fri, 5 Jul 2024 17:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=sf9lF3XMdvV9m5K
	ZpC7Ignc+SYhq1rQiBflNjc1mCVI=; b=a7de/Am5zoa+YYv0rR16acfHrdvxqtT
	7p3HI2aJbIwu/aW33CGVyvmEFKP3wlnPnelF1tviBPk+n6d1gVw2DqRgIN+4m7ek
	D2RyulNiaacfMieMWZxPiE+0cSqahliEgaVcKSAxiHR/bEPUfUFdARg29tAj9yEx
	bBiR+J3E0/Ktg+fu6Bxuw8sCnuHNYxxcRaIfy2MoYfNrG6TsrLX9KPdkZj9Hy9h7
	yKblOXDf9kxV6qD8jalVzHEW6yNU2uTJ9ab/P9rCIgWODOfoq+3+0J7Q41Kg67SD
	x8t/gxIIskTF+TWsgXr0/OtMEx+xs0h+8f0d3xbvpwpZY201GyvLg8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgntrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 17:02:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465FKUWw010447;
	Fri, 5 Jul 2024 17:02:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhxr6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 17:02:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNL/oVSe4hg1SUwiThoQdM3CUisPP8BoHPPq5U6u70UfTN9zX7JhowtOKdvj/HyVhDlkCq7sBQIl9fDK+7Uz+nTkZVqtFBg2clzGiNgcYVAWgeo2fPiV7gr5RwSBPktUG+X90/Rz4cA4+YkI+LzkPpKT8+Vo4ginuiSHnwU/3SpBZBAbpawcHS5QFeCcnWffvFjQRkSv6MomRkzNm1G7nSCRMDcVBCmPskOmjTeXPKaBqCdfDibtWvvGl++Ua/PCo1neK9eYM+FHS6hkUVPY1mV+I/rGiRvprRyr79BaV80vDI1yvurDntN+5ba0kUePq6daFHLkNzMTJX2qdO7ZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf9lF3XMdvV9m5KZpC7Ignc+SYhq1rQiBflNjc1mCVI=;
 b=nUqv2B2k1+DEIuu9V/2zRKYm0IhSJlnPOx0bHs+Le++arXD1xTrgrz32e0e+aI2f842Ig44o1FIzlhkNhCcqNo03MG0f4Ib52k8jXfE6uqVTOelqXvfRlJLrYNGgptZhDXmTaxX8g7scEqJIBQm9+OC3K4n1jaTnML+MSqPu4G4OGygZ0fBaiktc3CBQcWS7T0L4QCRVejkPw2185aSwYo7nzp08mREaLgKfUBPzWM03z/2USgVfafvqyw7ZSGrQM4rYhoBQdz4SbMNy4BYFib9W/w8NPbDQMQXvZSv70F0wTAaqE+p0BCwRASwywYagoxgt9QeEhbZYrdX8PlUEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf9lF3XMdvV9m5KZpC7Ignc+SYhq1rQiBflNjc1mCVI=;
 b=eVG9oaMXPub9OKajW6gE79AzX7TrO2anGmyYYiwNKe5i4SALBhepBQBkGmnolnPoKc2LYPFRmt8jSy265AK/m4x8RDbu7NUNY9tV0HBxxsLDbfk9mfNtCRFF3gCQ6ldjDflbX21mvA41dEUh1Avic7T621VKht0ZBZITqkxxqPk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6092.namprd10.prod.outlook.com (2603:10b6:208:3b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 17:02:41 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 17:02:41 +0000
Date: Fri, 5 Jul 2024 18:02:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 02/16] mm/mmap: Introduce abort_munmap_vmas()
Message-ID: <f9b7c816-b0a4-4e9c-a5c6-0cc5990e56d2@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-3-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-3-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8b6df7-bcb2-4651-e871-08dc9d14482d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qTFvsbQnmaPbgNKZncGaBaXW4xI37Ko+Du7y/WAQeUNbBytpFjVwNICAYgJS?=
 =?us-ascii?Q?4/YcW5ALh7Ev/ENyQOEDHWxwBLi9MWD0ZNKrssx26kVl+tqHX2zLj9zh7D+T?=
 =?us-ascii?Q?UoxAuJgO5FWjpTjaQxvWSnlUvG0I1ovVyelOGyHorA1m8fQuVik5RCh29XB6?=
 =?us-ascii?Q?W2k7T9zhfDqM3jsVRQd8rVQ8u9tl33+KqoMrRRX/A7ho9wT87LkqZKIqhbSZ?=
 =?us-ascii?Q?H3PU7WsarSc4+jDmZ7uRoXwIDUrxowqPs8bVM/fcnk9STBry9jBtWZsITFXQ?=
 =?us-ascii?Q?Qv1kYEsAu5/q54+N1qm0V7LBBpPvS2fK+68SLJlUDy1dni5ms/xMIkIAJDYA?=
 =?us-ascii?Q?LTNW5/4ePFnSbP276tL4oCjsW6fdoTDPp92Pb9exaaAHGQm0c1NXS03gxEjO?=
 =?us-ascii?Q?Zl4PWh28bWm4c9I2SuiVsQAUSLn+PE9dcM6BE4lU+5nHaU2lUVQgleWCZgIR?=
 =?us-ascii?Q?1XBzzFjFIp+rheXi47fg4EzXETiiTiqd8Jkgvg0c7YUdvnx08HKQmi30ILIG?=
 =?us-ascii?Q?Uj81bJqhTIJ9eKI7lswp066xq1Jyz0y9668t0ZkDHly8gMif9lOPwKsJrweh?=
 =?us-ascii?Q?R39v9sYDDvDFxWs6dxG1PMaPrwRiVb3RTlbdJSraimg31hHdnxDB8B4WXWXu?=
 =?us-ascii?Q?xpOdXbUddm+j2ZsPV85TP6jRH11YiQ8wBLyfRQtiuPB3x7FNuBxM5cIsrmR6?=
 =?us-ascii?Q?IfSf/iLh+fX53lSuf42bW79E+pXdH7OdL8Xn2ixHGFzS6o+Gx4LBLpNISo7h?=
 =?us-ascii?Q?TgIa4dZwlism/ER8bhsIy3EYNbffYrdydmzk9ZlqmZbN9wYDFYwhTVN+Pnen?=
 =?us-ascii?Q?YPHaZMGoX2udDG0kFyeBDhA5Nj0y96L7jokb/0wdNsJD2IgvL7HHj3Mt+bUW?=
 =?us-ascii?Q?uLK/oCbrbFfheABrMiHVo0BtPhjszmN4Lkz1KQyh9zWps/kUxGP0twJ1B4NA?=
 =?us-ascii?Q?l57Ned+cksJ1vfxxl0Ig8GBq/GL8DW9eZDHFi9ikFvxNE9eFZ4+RQ28Z5FeO?=
 =?us-ascii?Q?uNwcgUPyMZR7AqOkTIGoeSo8X9sinlywTmHXPVsogKbsU22KvpJS/N1iXSSR?=
 =?us-ascii?Q?i1O1XboElCpWNWUaKfJ2y72wrxV2xRz1IkuIgVLlIkCW60rzk5tPWrPM73No?=
 =?us-ascii?Q?RUfpkmOIYwMQsDAHyPg/asOghsMLUOLNtX1kMjFrvR2AMihCEanM7tt5laLb?=
 =?us-ascii?Q?lhGn0TkxeIHyQohoKGP0tEBKyZgsP8ox368xlU0vqCsh/LTDGr3afsOwIjKu?=
 =?us-ascii?Q?+eeWO+/9MBYSUQVFm/YeKVK8oUl9GSKIZaCoVGZ1KNE9cBEX/R2UyFahs8EJ?=
 =?us-ascii?Q?aPxMbJyBKWL19MrxHrlkgLQ6gFrDto4d85ZA+KE1X9PG1w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JW2e1n8raDYv//Cfo3c/idoyoISzj7g9HJ11tW2HaiOHjBB/O/zmefkhsX4v?=
 =?us-ascii?Q?vk4++gBJoL4vzUpbw2npDgr31yFr46MaJ/mq9174yOTW8rdXLY493ogwWUZ3?=
 =?us-ascii?Q?mkgF2Jhyt0ErP7SCBM/SxYiRGt7m+P8VDVWGeKCOJDPzkmybDcj+dcuxg7yN?=
 =?us-ascii?Q?bwMoAbTN7fCpFX5CoVBPqK7IO4hiVOBaIB9r10f3sx37PXUBLhw1U7jf7bs/?=
 =?us-ascii?Q?qVQnbxsO6PnIOPmOkpKM8TTli3Bh89R8G3VYpLGu1ELQk1Ill71yXd5eaU3n?=
 =?us-ascii?Q?Du+CsLxVWXb5Z/MWfmykx5u/8ShxwbERZ4nze84HCGXv8UXbkAeSIN0oy7y8?=
 =?us-ascii?Q?j2setlcZRG27rJzlFHJBhIB8kuSY3Iw7LHJhYC83Oj6wmwV9qtH88IXa/ye8?=
 =?us-ascii?Q?bEbMHsbdQUtjy1aYpKBG984m36WHgYzvRqCPz1QSI3N0zZbZRcZwc24f+E7w?=
 =?us-ascii?Q?vjyET/if7l2ZN3cArLdIGpyGwjVe5fKAKEaAAikD/Up7+Ug6D4kRrmUHPyp7?=
 =?us-ascii?Q?ma+uGYtG/kD+3vXAOTOx+yrwbb4S4NFpLNI6dzFSfxpLo6BKeFGiRoDIoUsZ?=
 =?us-ascii?Q?Y06fHXoMODLaM2LK8VDjhqHk+GFbozQM7wXOPKesSq57mLNVcnkeKR7iKAs7?=
 =?us-ascii?Q?HzJc8QJhsIW3quI4FJGlGtUsnwvG4xt82clqyaVlEH4Bm9PhCDCwVsnC7s5w?=
 =?us-ascii?Q?i2YI+6qnuCdboi4cgc5wPrLWPfXQe+eWiP/SZ33Uyw6r4a3u0TTDoK6OalEK?=
 =?us-ascii?Q?cmxmiKzEp/Q4ZN3Tv1OkEUQi5SqK1UYijNMmlyMlSqvQxmWI3BOEADL4nFEj?=
 =?us-ascii?Q?cohXTsyKeQ8CdqvunNxE+WnjFDtjYWRFwPfhhJaITo/18ptHu4M4T16MPwdJ?=
 =?us-ascii?Q?JDuTLV+aQe844OVuXDN1EHJaHcSiUljN7bx+6npd/m0AhC7kNSjgFnMUtpYu?=
 =?us-ascii?Q?hCqGEqPMhNoJ45NFgxKxjU28IG6F3JE7KPp+nYA4SYtB6fMoudwKQIyNVN+0?=
 =?us-ascii?Q?Z60N6NM3UhIqoIkW7nQquKOLS9DwQpBFrnDg12f6JrpJ+yjW4LTmV1lZKFME?=
 =?us-ascii?Q?v4DqyfDEyUxhPDSJy6n8gHqA6SeoohZPlnBgej6vyq8jhzTpsM8zvOo/ldn5?=
 =?us-ascii?Q?YEib3UnZznDMXrtD5rwWKiAgR/WErAJqFume4eBeEuZWMrAd0YRvBuZ9xUC0?=
 =?us-ascii?Q?xkYLtxqqXvgpVRqHREtMC5X+UCiYZ9QpzJnwiO71fM8IMjO6EkmH5xNntl9v?=
 =?us-ascii?Q?Mgbm56lgj7qGOqCbgaXcKTHomjB7cM1j+DC2dKtM5VmiQ83lFHR3AYT9tqmZ?=
 =?us-ascii?Q?ToFGB2tvQ6NaEoDTsJ9jvVH3zFA65nca1UiiUA+sT/xlMpjQSI5Jvgl4zXkP?=
 =?us-ascii?Q?GtRvD0ilbYA1zhgrV13KB+yGXe7hSL5VnR4s3YTuMhk/3JoTbHD1iUcBuVHa?=
 =?us-ascii?Q?OOnwQDxWQYOZl6wPp+HYSebhrhMlzVYxQgiAT724e9+QomgbDlgHLfdPMpJJ?=
 =?us-ascii?Q?Avjh1n8Q/yczZZ2/EM8qhIhEoV7V1689n9p6UbktrXOKGeJJkU+xb+Q4WqGT?=
 =?us-ascii?Q?HtsPK8FNzdsWroyqBN7x8UlffKBVAZjZ7Hx1Q3iRtrqzoGh0f8kAiIkIf3Sg?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qh0KWIlKH/4wSHygcO7L4ciBIpBQnNAdzNkh6uYeKXam2XIiBIPWzCPnVaUsJSWBqQkEQFA9BSCUGo/3/GjDHPrDjo0gjcUxEykXn8CjJN7YYpKmuBvKUdnO8QzfVWzzLBOmMvwxw3cX2od27K155NiL/Hp+HOXaTM/ybONHRK+b+j/SmoH3Zv7z5BmmAqgxTA2CHfwvNBka+3rmYyk9Bk6HcJXvjzl1ylvHGItyk5stkMtVr0DsjEhtSw5wjWFdQihEeFfSGB10JT2O2trxMrjsGM1Qs4/nPdp0vNQDTkwSTxT/FqxL+rENMFQ8i2bQXOYDJCX5AePdfk5MiNj6eYvmB+VDwLxB3USbNDoCSwMZQ65aD/tugx/sMjEmyfe7hOTIutcUrHT2WNquFD1873tIfi7QVr3Piah/lhPu9uyG7WBnrukocIvB6quMJ1zeTk2TQv3WZRomFeCXPw3a4SDAob/njegBH41J1oshg9u+9ie8s2s8rv1BFE6CnQvRn3YYkBmsmtQ1/BcV/zAXRD388hE8JOFDj2Jvk6No+rLFV6KwC02S23N1WVozJVCgaR3euYprl4827/wN70A9Q8aQG1pXW7XDYACmZO6CZ1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8b6df7-bcb2-4651-e871-08dc9d14482d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 17:02:41.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FE8Z3l4A86xv5CtM6yOksM4aXjNMXMV45ZzaJf/22qGk4enZOeiS++kAApBOD6A89FNO1Ruve2kkF6WU2sdJBPJ1fKKZtw/XwPN803mh/78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050123
X-Proofpoint-GUID: -CBj8ldliTjqR8QMxSzG65N_MDfaCJIl
X-Proofpoint-ORIG-GUID: -CBj8ldliTjqR8QMxSzG65N_MDfaCJIl

On Thu, Jul 04, 2024 at 02:27:04PM GMT, Liam R. Howlett wrote:
> Extract clean up of failed munmap() operations from
> do_vmi_align_munmap().  This simplifies later patches in the series.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 28a46d9ddde0..d572e1ff8255 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2586,6 +2586,25 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>  }
>
> +/*
> + * abort_munmap_vmas - Undo any munmap work and free resources
> + *
> + * Reattach detached vmas, free up maple tree used to track the vmas.
> + */
> +static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> +{
> +	struct vm_area_struct *vma;
> +	int limit;
> +
> +	limit = mas_detach->index;

This feels like a change to existing behaviour actually, I mean a sensible
one - as you are not just walking the tree start-to-end but rather only
walking up to the point that it has been populated (assuming I'm not
missing anything, looks to me like mas_for_each is _inclusive_ on max).

Maybe  worth mentioning in commit msg?

> +	mas_set(mas_detach, 0);
> +	/* Re-attach any detached VMAs */
> +	mas_for_each(mas_detach, vma, limit)
> +		vma_mark_detached(vma, false);
> +
> +	__mt_destroy(mas_detach->tree);
> +}
> +
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
>   * @vmi: The vma iterator
> @@ -2740,11 +2759,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  userfaultfd_error:
>  munmap_gather_failed:
>  end_split_failed:
> -	mas_set(&mas_detach, 0);
> -	mas_for_each(&mas_detach, next, end)
> -		vma_mark_detached(next, false);
> -
> -	__mt_destroy(&mt_detach);
> +	abort_munmap_vmas(&mas_detach);
>  start_split_failed:
>  map_count_exceeded:
>  	validate_mm(mm);
> --
> 2.43.0
>

This looks fine though, feel free to add:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

