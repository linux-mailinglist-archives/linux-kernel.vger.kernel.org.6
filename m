Return-Path: <linux-kernel+bounces-242794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7BC928D3B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6351F25EA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA23314B075;
	Fri,  5 Jul 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NAcwELrI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sNKg3dYW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FEA31
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202489; cv=fail; b=t6fUCoOfDYBcVgafi5dUA+Npymx3k0Q2A2t9WkZbICJj2McgzTKYlC1CW2mCXdJ+iCz2FokhU6r0nWA2X9qqq4fkaA8TgV82T7hielCelUrb44npwlVsOQFxid7Rkr3Wo7IJnzfirh27WWvdtNJjMTi2Y5TInkeUffT9E2/o1Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202489; c=relaxed/simple;
	bh=Xe9awQKkQtse9JMMFj6KVPL2GrSwHUIF3ehE7E0fmiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jG8p43WFGq6+Qa+3VKQuLxU12fkXkXgBftTBMb9uXgZgNEHKxT/oT7O9uiPBoPQZcChagEmks9EofIgLpteIpT9c+Fo5HpOoXeeQYsFhoVnF4RRmlgmalwdrXrqcBV6EUDaZ9lvPWtC1A2vR7SWGejsXzeAl/Khto1JXITS9GIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NAcwELrI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sNKg3dYW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMZGF020446;
	Fri, 5 Jul 2024 18:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=zJJFV2rnzfyTysR
	BizcB7amKxjjjL678MIessptdcOQ=; b=NAcwELrI72F0vgDnEIJ1XBCVRHlsViW
	ReAcqPEAWA1FfRbFILiJdCI5EDeoNqbjIYZXKvPkxNdTJTamKdHbpMJSQ0p8uyig
	4VPY1ArwqKommL+zVnaxGw7IZNrgIOa+ibbBp+wgJZ/Z+7nnmigoQmJc6j0+FBOP
	4L3SSaRiVz/LNL5r0muweCEb1S7QvElxKpJmqt6hr2nZYZmkIglbBAT/jn/FcfsQ
	5jHM7mHjyXRbKusR95y0RzyzSFiNma2HS+n4AFHsRHudZ9aGwFAGcNf8qvyGz9yy
	UZUViobT1AUlJHkf9GxWAHwwS5ApYUdThNSySIXXswzeawpYNEWYRTA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attmcgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 18:01:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465G3Odk021546;
	Fri, 5 Jul 2024 18:01:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhpfpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 18:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFnfudYmtTEqPEHU6gbE4VXOnW+rSa8vRQPU7XlMRk5yxGIw6O/tqW5RigO+5LLSADzcPJDm9qBNECLr3ixbB+191RIwS0STGPENtnhRpReo7SAmIA2cfQffYMg7e2/y8uYfPZ9v0ENwBfrho12PcpgSRPUeYVsF64Zwwc7j4b0wZTLB/KweSq8831QNCEP8Tywu7uYERnW66A2dbZwop7fsCxkoFCQwcXxULcKfr5dp8wtO/7wFKEKWIMkAR3qXHpRX7ev9bYI0r3AUxHYDEzaeKn4+VQHkQ+om7vUYMvj5tIbJefvJBcL5ff+MyawYMznTncq+L2LPBoBXnhjN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJJFV2rnzfyTysRBizcB7amKxjjjL678MIessptdcOQ=;
 b=GykaP6F3NJQIcPN+YF6n4q2VZ7FzxR1gIFPqoMK0fIBG95lcYBrSa1/93mhIbjLfR26E2u1/BKgZ79AuEzqN/g38ZTc109HbRLKYCMnWS72FMwcNffOrPC6sNuTo+2fGBT4xbqH52s9iQjaqBakQ/qWMq9Yrdu/OQQUcXMuDEZ+hy4W5YTbVB+e9t7RhjR8WNTibiwMNj0XkQWLi0SUmRbqTtOFM36JwtmMv1VpWumowUBOEbd++zcbp7h0TOcIEFrnm70pJvG+ZxmhbBCHWRUi/3VC6ApC6Wj5JUTvs3kBUxvbWI6rD+A3lODfPTrfSBJpS5QiCABf2Vyjp9NTB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJJFV2rnzfyTysRBizcB7amKxjjjL678MIessptdcOQ=;
 b=sNKg3dYWd5C2N0mycHOkzQ7+jKqTQMnMIHyoaOxb88wZDIkbaIHRe5k7ygFi0oayuZjYSmdSjO+JWa8UFso9WRhghgxTK+S7QYVzMFAlpQSkKRNNd1qAAAEvhzVCzwRh6CiNYWQ5CBhwlo/MBH5eOshmVpJ0N369C2FCP/xhv7s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 5 Jul
 2024 18:01:08 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 18:01:07 +0000
Date: Fri, 5 Jul 2024 19:01:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 04/16] mm/mmap: Extract the gathering of vmas from
 do_vmi_align_munmap()
Message-ID: <bf24fc3c-a092-4c37-8f2f-ae32cbafe036@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-5-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-5-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO2P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::34) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc12b7c-8b65-4e91-6886-08dc9d1c71d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kmlEVgXlQ5bIzv3pw4FBE22FklO1OGGGFLTnUUu6IhksFnjSTZnMl5+2Vzfw?=
 =?us-ascii?Q?6148noS9pBxi8GI7OyTE5VVdMDNV+kXThIKfLGZ0FLPMrCZ8IZMf+3f9bCsQ?=
 =?us-ascii?Q?cl3+RdAzCBIR9UyMFffLFCYQzChW5BlSx+WA1ulNsGx5uTqig+F5g/5AOI/i?=
 =?us-ascii?Q?71M2CZXZpyKjorIimQ9dnjHnstdQJx6ZNg/JYn+Z+yKWpKTV5UBcoDQnw4cd?=
 =?us-ascii?Q?So3rhCLmpX398RIdfv+YjCZjTuV//M+GxSYy9kZsHuL+fVDMUcU1mKHHtmBF?=
 =?us-ascii?Q?fGsqEWknakKFOHE4Nh0JEkz5zUzwfD1Vx2m8VKehvep3H9YDeu7Y1H40maVL?=
 =?us-ascii?Q?fHJ2FRDAIdZmm4I/zAPAUgwZfSGenDEVMChpfSXNowj+LxRfKv+eStaZBPzQ?=
 =?us-ascii?Q?sm55ecQ8rpjgiI4bhZe+lUNfSAsXy8eOaslPk29ZGgr4PsYUdJ0Wb3RU+kwn?=
 =?us-ascii?Q?a2kas380CNQ36IOdqY5J4nO6YYAbLxFW8LABtcj3Ha0iRtuI0c0MwtUbHr2o?=
 =?us-ascii?Q?i8oDkMEemYzEE9S0wTj9ti3wtDYymQ4P9qGjLTFYReYYbNGW17nurNkQJRvJ?=
 =?us-ascii?Q?i86Fmm+xFyQ7Oik5Rnoka3+frH78g0l0nNauEGXY+MZROQA6aLeEvnLI6Z4M?=
 =?us-ascii?Q?Ec6l0BIi6Z+UE+tOUMC7+rYa1VvyCEQBlY15LFLwfVRHlL4vTW5hAQ+4zO4A?=
 =?us-ascii?Q?968rL9hvrWlb82+G2Y7FOPbRuuASxlUi8q8q4w3paXNJs2qzAu784bjUT4tG?=
 =?us-ascii?Q?lRfJbYxdOpRqKKJZg8OFJpYTco7aYumf9kqgk/VSW60mhE6uh+URbhLfFguk?=
 =?us-ascii?Q?rNPRUJeT+N40hHA6e0j78RYAUG3tyl5jH791O6sgyUKLLz1IBVS3okl2mMDg?=
 =?us-ascii?Q?70smkj8G10LoPabrtGjJREtVa2RMc3wkmcn5v83aYx2rskZ0EsDdb3FBaBo4?=
 =?us-ascii?Q?PZe9wmSDAC54g9b+9HyEFCZ/dPzrJl4rXpVmcIQ26E+KuaUMBIOwW1K0uyfR?=
 =?us-ascii?Q?un2IVbLhb7Eb+6Jt4JZJbE/M8qhKXLvgkPgEtDyv0q6NHyiO0bpABT8TLeuw?=
 =?us-ascii?Q?gAXB2xYC6/ZrjiRUiHGcIdAGjWedxLl1c/Qw+uZW03FVZbxSEkiyLYODsaIp?=
 =?us-ascii?Q?pZnch9z/HDZb9aTj7zQB1KdBz74pPFtxzhKU2b4c6OY4CzH1Urjuonqzu0am?=
 =?us-ascii?Q?Lot0jmucNMaIwpiSQYYPmNFOfUaa/88Z7/qqxm/JVmT4NHQSh0l/3ETn7PiY?=
 =?us-ascii?Q?1OhHizgn+8wkIH31rLdh/HYrtPpnXo7uSyC/UMbk+YaNJDqF2r24SOhAHhOr?=
 =?us-ascii?Q?sE5cNfLp1BMEG2VMGOkFl3mWw9OWiesL71Gaq4LCHZA7iQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1HtRzPcCxhcmNqK3ifhL/fHiS/+z0kaj5FdWFm77hOblYY2nwiLeca6FS3oD?=
 =?us-ascii?Q?OWW2dTSwBbuZ4645LZgNKy2Qh6DN8LlZMJfcxmsiRTiw9KbacnINJtwNb8Bo?=
 =?us-ascii?Q?wDY4wa9ozX6Af+i8ed5h2aI1deV66udfisT0Zg/VugcqzGLkFjveEdPwEb3/?=
 =?us-ascii?Q?v6aCOigxMalp6aA6hZe1Id7zZhUztQut2vexz0JH1BJTHoZxmw7x8TgJ34rz?=
 =?us-ascii?Q?DRgZGrl+Ar1c6VF6Qjt8z6BgCF74aExXfdMjmjoZ1UEhsxM+5hukBjatBGhz?=
 =?us-ascii?Q?VjhG1Ba8UmCzj1krmg98fF9Vb+ZYGeJ3GnXbjAoaPPljJvv4v3KgxjL0soqY?=
 =?us-ascii?Q?di6LDNwaa12bvNWoIXffCq42vjWdC7BXGzJXwZUiAsvLb2LeS9Nmb48/uwTa?=
 =?us-ascii?Q?tYgga+yNwYVty/6JFPNwYoVR+Ysh4sjteat2Cria1G//woqL+gtpRAeoDbr8?=
 =?us-ascii?Q?ZH4uLrDixjR4ScZZwhhV+1E4jsYnYEIB1QjUl8EV6MOwT8W9dG2FMra5N3cs?=
 =?us-ascii?Q?B/A8yR7OjGuxRlbBhon+EIV9UQSPS3c75d+BMA6bsxsusqN2/1mFvDqygKxz?=
 =?us-ascii?Q?shSw+XlZvKO302hmx/kFrBYBYofy/VW/7BfG8Nhs5aqYWG1vFupHNufHUTaF?=
 =?us-ascii?Q?Vo7QJCO++O7NWITn+pkdjFfvnb4CZbxqQhvhOIMNTWM7qGUveFjuZdtIB06e?=
 =?us-ascii?Q?fVpeFreGCUSoLqa3Ksj2UJG+WhaX9BafGEBAtCglKjuzhrd6JsSkdyAsrXqU?=
 =?us-ascii?Q?HlSIWpC7cRgVWH/TEUJdD36VuONkgrh9y8vyLRRzIvpNraMAPF9smBLPOKg7?=
 =?us-ascii?Q?9SzMlsDffOv1z9XiAFgYzvT5d4l6bfQwOxiPT+il7r1qgGST7JjlFyQaNNf/?=
 =?us-ascii?Q?I1q0+dOKn+u0i19uxFIOL+fSqAS7UrZK/hFXlgOxsfC8oJPTaiTiTwsTZLn8?=
 =?us-ascii?Q?48wAB3yF/Q5vu2SI9kGSJi+K0XrIvlj07Cr1zm237Zo8whz9Iq91w7s7LENF?=
 =?us-ascii?Q?MFTeMKp+iCDeNy2ipblXWBkhRVHK15MQL7YRSf7jUn9n2Z1iWDjVndnOjg4t?=
 =?us-ascii?Q?/ZGUuyo5AiE19//jOZsxJ/DVL1fjc5Ro4yj/j3InNG+D1wPYnwUjXzyNtK1a?=
 =?us-ascii?Q?R8d6UBpRSk/JJT6fNTqpxxWot/oWjuy+zxvn8w9RdIQDHyoKHfbs421QJiw4?=
 =?us-ascii?Q?TdbwpTs23E70XSS4mbisJ/tb3IG4jg/ZKKmgcPrzFqLeNtdRzEBMbtOuDbqe?=
 =?us-ascii?Q?PIOMUsBYw+kCaGoZXg6IuAjfNW0yZ8i15TrIvokM4IJRGDGb345EcHdyXJkG?=
 =?us-ascii?Q?tRFVw5+Kmveso5WOqepyJz158Q7L+dgrrWVGLpSCSaTdDwlCbZjvqF6pCNbK?=
 =?us-ascii?Q?J67mSPL2rCMx5yQagMkmio4hPJ6XWy2MH9VNchB475fiKZrZiNYexSVVu2i0?=
 =?us-ascii?Q?1JIimadoSOCmzH5tSqzkG3TNU76FzZFrTpiwCc9fqjuxx3QPKJe5jeJxBzUy?=
 =?us-ascii?Q?6F6GQc10dF3RwSSeMQLEwAlCAODQ2Xx689KxPrwlHAyVrBmwwMJv5tbhaZFP?=
 =?us-ascii?Q?8hXiCBDHYg0QRoNDLT78t4In29AiS3KJ2S2uem/tIYuc1AejRqQgCVt8CcM5?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	my2wk61Dh8QyzxMTrnCDAOk8IGPTfk7SuNbmw7Yeuo0RLHnxV/sL11Cei4bp5tJrlqNTjrtFObPK5Zn1mJt7do/ATy4CW+wzdXp4hWQxNkSmRnXcaUdB+oAIIY3t1fdYSCwvGflo68kFEGV6A9d1QMIUZhqj90y4WAC5GnnrkKS19cFf6+4xUcTPrYadD8Zcy7dlEFHrWiVwY1OY4hxagCEcerDAlZ4oOLNT8NMMyDq16u36xjXbE0GOozIGDDMNO2fGr+IjaxkJGddct77iIOh9+7eB+EhjCpuoZmYL/qvmhguSOTl21+L3wyo6AfwLfPsnLfrZ/9ZK4hapVRnn9Nx300GZbdAYDmo9NbgD4v0JFhRzTdOCkATmGzVrOIO5nwfh7+1kirBX6D3dvoNpbay2T5pCePfKCfDNj290dkiljjYeBJf/l19NiaF2mmT4c+ZieAus0MEOO4AwA522+Qd0i/6wHp3DgQOQoHjAP43R21DDkTAHM02DD2b+VAuzBtoFmOjQD2V6/3RW3XAayhgms81X0NyPsHKlnsaKe+vldTG8KqZZhIEWqwZqiM5PdlHVJRiMvySH+msGzUlsrpFBdRUxQZ89K0Sxx+tMdGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc12b7c-8b65-4e91-6886-08dc9d1c71d6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 18:01:07.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcmaDt1IfTDzeoV0wLpuWKMqGTD8V8xThQYbFZlxUUZSjvfcrrQgrZ2MqnICoFryqxd/BRMFrSpGGuz2Z88VIqH914x0yFWmilCaqMaVczY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050131
X-Proofpoint-GUID: KPMO2hstwICzqDIkh15iclp27l7IKIdt
X-Proofpoint-ORIG-GUID: KPMO2hstwICzqDIkh15iclp27l7IKIdt

On Thu, Jul 04, 2024 at 02:27:06PM GMT, Liam R. Howlett wrote:
> Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
> detached maple tree for removal later.  Part of the gathering is the
> splitting of vmas that span the boundary.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 82 +++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 58 insertions(+), 24 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 411798f46932..8dc8ffbf9d8d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2656,32 +2656,29 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  }
>
>  /*
> - * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
> + * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
> + * for removal at a later date.  Handles splitting first and last if necessary
> + * and marking the vmas as isolated.
> + *
>   * @vmi: The vma iterator
>   * @vma: The starting vm_area_struct
>   * @mm: The mm_struct
>   * @start: The aligned start address to munmap.
>   * @end: The aligned end address to munmap.
>   * @uf: The userfaultfd list_head
> - * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
> - * success.
> + * @mas_detach: The maple state tracking the detached tree

Missing the locked_vm parameter.

>   *
> - * Return: 0 on success and drops the lock if so directed, error and leaves the
> - * lock held otherwise.
> + * Return: 0 on success
>   */
>  static int
> -do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		    struct mm_struct *mm, unsigned long start,
> -		    unsigned long end, struct list_head *uf, bool unlock)
> +		    unsigned long end, struct list_head *uf,
> +		    struct ma_state *mas_detach, unsigned long *locked_vm)
>  {
>  	struct vm_area_struct *next = NULL;
> -	struct maple_tree mt_detach;
>  	int count = 0;
>  	int error = -ENOMEM;
> -	unsigned long locked_vm = 0;
> -	MA_STATE(mas_detach, &mt_detach, 0, 0);
> -	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> -	mt_on_stack(mt_detach);
>
>  	/*
>  	 * If we need to split any vma, do it now to save pain later.
> @@ -2720,15 +2717,14 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  				goto end_split_failed;
>  		}
>  		vma_start_write(next);
> -		mas_set(&mas_detach, count);
> -		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
> +		mas_set(mas_detach, count++);
> +		if (next->vm_flags & VM_LOCKED)
> +			*locked_vm += vma_pages(next);
> +
> +		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
>  		if (error)
>  			goto munmap_gather_failed;
>  		vma_mark_detached(next, true);
> -		if (next->vm_flags & VM_LOCKED)
> -			locked_vm += vma_pages(next);
> -
> -		count++;
>  		if (unlikely(uf)) {
>  			/*
>  			 * If userfaultfd_unmap_prep returns an error the vmas
> @@ -2753,7 +2749,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>  	/* Make sure no VMAs are about to be lost. */
>  	{
> -		MA_STATE(test, &mt_detach, 0, 0);
> +		MA_STATE(test, mas_detach->tree, 0, 0);
>  		struct vm_area_struct *vma_mas, *vma_test;
>  		int test_count = 0;
>
> @@ -2773,6 +2769,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	while (vma_iter_addr(vmi) > start)
>  		vma_iter_prev_range(vmi);
>
> +	return 0;
> +
> +userfaultfd_error:
> +munmap_gather_failed:
> +end_split_failed:
> +	abort_munmap_vmas(mas_detach);
> +start_split_failed:
> +map_count_exceeded:
> +	return error;
> +}
> +
> +/*
> + * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
> + * @vmi: The vma iterator
> + * @vma: The starting vm_area_struct
> + * @mm: The mm_struct
> + * @start: The aligned start address to munmap.
> + * @end: The aligned end address to munmap.
> + * @uf: The userfaultfd list_head
> + * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
> + * success.
> + *
> + * Return: 0 on success and drops the lock if so directed, error and leaves the
> + * lock held otherwise.
> + */
> +static int
> +do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +		    struct mm_struct *mm, unsigned long start,
> +		    unsigned long end, struct list_head *uf, bool unlock)
> +{
> +	struct maple_tree mt_detach;
> +	MA_STATE(mas_detach, &mt_detach, 0, 0);
> +	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> +	mt_on_stack(mt_detach);
> +	int error;
> +	unsigned long locked_vm = 0;
> +
> +	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
> +				       &mas_detach, &locked_vm);
> +	if (error)
> +		goto gather_failed;
> +
>  	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
>  	if (error)
>  		goto clear_tree_failed;
> @@ -2783,12 +2821,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return 0;
>
>  clear_tree_failed:
> -userfaultfd_error:
> -munmap_gather_failed:
> -end_split_failed:
>  	abort_munmap_vmas(&mas_detach);
> -start_split_failed:
> -map_count_exceeded:
> +gather_failed:
>  	validate_mm(mm);
>  	return error;
>  }
> --
> 2.43.0
>
>

Other than trivial comment error, LGTM:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

