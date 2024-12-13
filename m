Return-Path: <linux-kernel+bounces-444492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0244C9F07BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CC8188BE7B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182021B0F35;
	Fri, 13 Dec 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CWx0Lolo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hOtMDZKg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCD199956
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081754; cv=fail; b=TW8tyzQX4bj6BEqFIecIH9X0YqrVxk8+8HbUeK+jpBQkOXIgfNElWvI/BaCOW6sm1SKWzfykiE08mTZzTSTB2P9vcb2mz8ZL9QCx/LIRJthysX/MvMlfp4jSOg0at9EBzEGlXPcQntm77RBBsVY2GYRZbLHZn257Hg+N8R+1oM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081754; c=relaxed/simple;
	bh=eyWblAppEaYJYSWMwklQh+r+tkWHBe3JUlpm4TmYvbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pCHTgCvace58A+rmyCgzf+yDbZ5l7ZvdfUOiRw9ekKneRumFVYAzu4jH3HDSHUPZkDv+/1/aZ1gnuEz8adQdBQwnVqOQraBrJ5HOGxU/SOOAckXI+TeP8idyRpDVCzrZ5OqJJxHnyambjRQ4w1TFIywndhMBme/WYhzCEIF9QUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CWx0Lolo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hOtMDZKg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1foVq023722;
	Fri, 13 Dec 2024 09:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=c6ujDucGUrBH8TvXTb
	bFN94k02q5IZYl7pCthV9dV5A=; b=CWx0Lolorqu3CzLOYIfyw1Xp/wQT0tk9Ha
	SPn5H4jJfbawYbZPC8UokmdTT2IBdJCo2bogcMLUNXMkqvfr999bDLWqimGgl8Tw
	8HKpmXIETUt3ysABqLFR/nCCY8QrYRlHY8SlYBrWKpim4v+H2d1SD3xVKBufoKq2
	5JlqGfBmFAeJPtOAKmnW1D48Puy7Svjj+lovmwbK9Ysm/tij20iHiJDO1QLGPIVg
	8mT84wJKuPoWyovlXMfYM5x50JSRA0+5hS+2JloC7pp1nexG0ElwRuYO1sdCWwbP
	XXzsFmci0CQnSvEGiccpIFATNk0I/GuGywiPv1SoFrctxSppZQ5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewtd691-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 09:22:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD7cBk7019287;
	Fri, 13 Dec 2024 09:22:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctcgfm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 09:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUSsNvFzfzv+mxGWQtbdsDT7FO+KW+lnB31X7D627R+To5j6eR9FAq4SKWmF55VSim0i9AML5GuS4nEGNyzaAR4GDT8QffCYx0RLIcmmpLTyPOOoB3nsPjQqnMH+Yl25XoysV5wZGOBkcyRK6xuoQRvLfmTrzAbdFZ3BNCdDuecUNgdBTZhT35eT3hBp3TaUvjujhBcrhFezk5VcxC256Uo2ufvnBQukl46Ah8XDPH5s6f/gkMlnpHrxWaIGc8DPC9qpejhG/SmH8YzxbWPG3cVJOcTo9Ehn+VYPmrzUQogHGVbMnrdE1QiK7D3MixWwAjMz6T3AYsUIoWj0gdT1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6ujDucGUrBH8TvXTbbFN94k02q5IZYl7pCthV9dV5A=;
 b=nA2QAD5kK9ZJOU9wB6XGDIgqjK9tmAq8rwYfoc837dfezQBR/4PgJrvgQObLWsEodP9vrr1Ekq6DNBAVY8VoHpYgzi1IrDEL5um/hZtRH8SqvqjJAP4OyMUdaUasj/cWtXvr70TSdPB4+1QVMpdmcE7t2mK9FI6Tq9PoqI5TozmcmjtnckKlZR0pEj6x6OswNeC7eL5zN0Tpy1nVQgAnbIs4ghcAYSjg1VqdDoYxju98WaRoiWI4fALPimUdrbBRmpFAOk6XB7o1Pvy83cfpX1N4d48kLqY4rHRjD9tNa5RPtIPOGopLdufZeGEACzyOKXT6UfUr73iOeSpPOPWm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6ujDucGUrBH8TvXTbbFN94k02q5IZYl7pCthV9dV5A=;
 b=hOtMDZKg2/j5Xuu9S2OsCnYo1/TzxvDRj/TjKYzckFa6kTtmEFMJSyh2R7Eu3A3GydoKix3gAPpjsumpSYvnJW5MpW9xedng1/HXhiRrI8SEjTFFt7ZAK2a7FryoeEZMQdOVUJv3Y1o5Nio7AIRReIiWmtxVLYt9tvgweBBLYNg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB7097.namprd10.prod.outlook.com (2603:10b6:510:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 09:22:21 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 09:22:20 +0000
Date: Fri, 13 Dec 2024 09:22:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add comments to do_mmap(), mmap_region() and
 vm_mmap()
Message-ID: <f0263af1-a2cb-4f3e-9654-549beba79732@lucifer.local>
References: <20241212113152.28849-1-lorenzo.stoakes@oracle.com>
 <20241212183604.9da0c62eaa23770092798767@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212183604.9da0c62eaa23770092798767@linux-foundation.org>
X-ClientProxiedBy: LO4P265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af8b0f2-61be-424a-afc1-08dd1b57a55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2DkdPEZPXj2RyihV3zD1Bj9wlYfNor351FhyeglRUpsPYS5uy9Okp3CpKzy7?=
 =?us-ascii?Q?aRc0TDQtFptquyMNRMIlmTPfpeMG7uB82o51+PUsLcbNU3Rm0EskcJVST2WO?=
 =?us-ascii?Q?a0b8nTUIvL5Lb9tQy8OqBg+cENToNUw45XTXlqwGy/BLF0jzPFWOJiUDQwcd?=
 =?us-ascii?Q?QbpBThE7rDiH7stM0kTnknhnAYcNnIjlZsjgD9gYIDA/XM0+2I0VXaY0lH7E?=
 =?us-ascii?Q?ZxJS1FJRNbOgEMa8Mt/UkVn+3JPLZwakRfiL/10G30mNC6jalVXBw3Rx7kzA?=
 =?us-ascii?Q?rEpl2wioB3j+LjqEaKTe9Sk39JcTluZ3n0CyxdNkOQiZgSqrn+VSPS23K/8M?=
 =?us-ascii?Q?u1w7FF6OjSMt7FFEqGiF2ZzmEggPDDr2xiRXXihqxGUX5jSp22zQwOabsDIq?=
 =?us-ascii?Q?PqKeHeyU+P9T9d3dpwA2FsJrWhd02zYQxmoDYtgAuk342srG73nSkqOETm+o?=
 =?us-ascii?Q?kp6kIsde0XoDDprioHYDJ2WwNcqZmOMxdQO9nQzjkbUHDocYuebkd23yEe7M?=
 =?us-ascii?Q?iXdD1N//Zs5XP2ZTxHqTBz16MK/nc5goJ+h6WJhvhCi/edHhpPpJ3rwHP4Vp?=
 =?us-ascii?Q?qbPoiT4roL7nT+FH6okdET9uF8o0wofRkOuG+BMSPYJrvHYmJjNMYkN0Y7XK?=
 =?us-ascii?Q?cMSK7kE601q8k8Auf6egV5IcukrHIMEp2boL6HYORpmNhQosfommfWv+2l8d?=
 =?us-ascii?Q?yKuuP/Tx6EmH0EA6FRWAzxE5VUPM4DU6vStbbiybpDZyeExq0q70HWuIxAhS?=
 =?us-ascii?Q?b2PngBBcR1nH19qXrH8UYUvcbRSBAbFNs+m2zsVGSNNaupuLCm/GFv/Mkmmi?=
 =?us-ascii?Q?K6VIIiZrQ4XjwQ2w7dqSO8FQlBVvNmiEf8H9poGIJ6ZaLqXcgMeNMdm06Zg6?=
 =?us-ascii?Q?sPCUhk5wFiiuFIIx+5iIPPwm/BuUFzqZj2ViM4nOGzmTKSi6UNBLXLveAem+?=
 =?us-ascii?Q?iGFE0fAR/cLpxe8ZV4M1u7oBZCGDgkxRztuDx1HSDI+Vr0st+betxuSgbZaw?=
 =?us-ascii?Q?oFcTV8F5wtH1zooN6SyIG/ctYAz/TPO1SV/gCAUQvPOnlPpFUaxoX4u/ARgJ?=
 =?us-ascii?Q?WZT24lE6a3VA5TGiJF0BpFZfGCVpPkZZY5kBMqdiBRCVTfeaU60ZShcLTS5r?=
 =?us-ascii?Q?MfKZxgsqmnB/7Mde6eO6GlDwERAg4dnGc7ucS5oPQ0GDwDuQBVjaFvxsVC/Y?=
 =?us-ascii?Q?QpuCLvNemLakd72Ndh13IT4dyKyUcLxqqIvkq9kPxRwYy6YuiMnU59sRPrAC?=
 =?us-ascii?Q?00NGM4cJFoZcy1Y8D/RyawnRHUmN2KrnE9YzBJ/gv/7OU7Vk2AMiMwD5Sx8N?=
 =?us-ascii?Q?VckmPgN9W2fKh69HAlTgYhoZvGh09T+31AE0AhHB7Y+4eA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?auqex1dRagy6Z7i++0qtPNwe78zFaIEyuNAE/+3FaHn5yCPoVQbu+1pY4gJO?=
 =?us-ascii?Q?ECCMsB+GkcYFTDGmVNFq+cFVFY4hzxFVrhiPQwPw7fUeF6+gwcflPCjCE728?=
 =?us-ascii?Q?harlEsZtUmxuBEAt3ewBH7wYXOo7MXRQjnj6KUbCApEWXgVDyTQR3PBeCENs?=
 =?us-ascii?Q?sqbn580o2DqfXucUK2abqZ2DtmG+iHAH2StrP2favLXrPGEkk6U2FYDhnBCn?=
 =?us-ascii?Q?RxBDrlBQvwpx6tyjAHZOWzXYmERl5y/PtvSNMLIf2bKYV7D/tDZeVD8WhOZS?=
 =?us-ascii?Q?quuI0EX1sp6hUmQlsLBDbx4WUNUSi4KNtjAyz0z6kcdnaX4GfWXCWEnB8NHr?=
 =?us-ascii?Q?eYyBTSCEVbMmJes+HFjqhyx2SOSF71HqW0vxH5EGa68+Q3cRI4KY7SLn8RCc?=
 =?us-ascii?Q?gyvHbkQylYIjiRNp8mAG5To/rvYwKRT47HwC7Ju9NSDk0cNDrzXKYc+r43qo?=
 =?us-ascii?Q?dA9yw8eevN7ZYGTh8GJ6yXp+ErOaAfMKDhrvBOf3oASGBovO+btYEMT09Dlw?=
 =?us-ascii?Q?wbjg9csC33bMVLOZk5nfztJDCuif8LsB3S4DhC0g/rxzctREDbKCZiGdqrAp?=
 =?us-ascii?Q?j2vY3a4n9RX0mWHUbkGuYiL5Qqxt0ACr/NiHVlqf1CHYZt0kpg0eR+Gn0Zqz?=
 =?us-ascii?Q?LmzXSefnjh0U7sNHeH85MynDBRVdbZHlRsT9s7qMiFrNrmAurSeHDGFJOuae?=
 =?us-ascii?Q?fXUu3R5UMYyWCs9uJjdNGB9rLwBpt8Ye2t94saJ8jyupxcddSpDOizNioBPr?=
 =?us-ascii?Q?XfwzDq2wxS929CAiypPKPiqUjDybrgDB9CfJJREp1u1BkmSspmuL9c8pYxkE?=
 =?us-ascii?Q?JEkTttz0AeBlrUYdBZnuWNRxp59dI+EbzG1rVLvJlH0BDuU1tdAlhAcvZurr?=
 =?us-ascii?Q?lsOqsXPRK0jrw7LBBLvng2l45c66T8jsMtXX1G4hClKcMe42JBLFm13g5REZ?=
 =?us-ascii?Q?HYXJqyxPA+CmiPDHG+ET70oBbMEdY7iF0LFpqP/jaBqq2JLVF0wlKoRGXqiG?=
 =?us-ascii?Q?DrukJF5NDDIkpoxBOIfgiEfkMMOWQRRUGgDNjNzk6/xYCcwpgXhSj6OC/rZF?=
 =?us-ascii?Q?p1cB5lMh81ZQbBDC8UQYKnvcTTnmPNpHqVrgbKgcbzbF713SNfhrxZGMOsH3?=
 =?us-ascii?Q?InnnqDXXiz0rn6Pq7L79yyLHK1GlIH2Hhwd9Xyf8f9bk1poeBcbCxBPQ9kHq?=
 =?us-ascii?Q?6/X9K7q1QMKzDNlQL+aSYUY+dxmj6lMTbohd9PBfzCLCKqb7hJepAzNBj5ZJ?=
 =?us-ascii?Q?GUO5BJNbT+kou1HOaQ6ZUMA05Ofu/QGZn2rJ3pMqZabvRBpOLNiZ5/Uy2iMo?=
 =?us-ascii?Q?bPehYDOhYW6js7hr5+9BcnbkxYSIckMLlzr1JHIebf9dX/rWWFBBr+2Pzd60?=
 =?us-ascii?Q?3H49Avb+27+RmAzxIiWNm0svN43J8ONZnxso1qaSoDUhYCNm8cBRcj69g2Gx?=
 =?us-ascii?Q?wxeVWjH54wqdUPfyyHAODbi+yg/uVyrugkbEPp9o0ljI0YuTj3ULvxsVX6Cp?=
 =?us-ascii?Q?UVgp1rvQ1h0Lx1wDCFGJTjy10vXjDBgkGrfyJOiWWuBOnjdgXVg9TUG1/gJK?=
 =?us-ascii?Q?gn5p6vkLS05glni7z2dkxerjTpax82Sw2Wygw+ur06fACX1lOJmVImWDXVSq?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0+DNZ5Tvn89+vLsd2hTtA3kWTpXVs9KCreFHAlaplizNGPAlGocV9l6sV1SJxSF0bxWi0VJ4mei1iYhw9+sa6LJhREpo7ECiMXjCJjNBX3dvjhxvZGJPAvyyQS/JECqabzIa03wGCO+z5bqZhHEnjJsXnsJZoj8EylDKNwP+FHS7bFwh6dmOdpSc+cF6S1CrI0nZVXvSva6JTt3k6kRvGP8lkmXIBcaXZHPSDD4oshdKeb7WdXYet5vwi+pI/nRTUSmZClVxWBN+gjsZpVmqvbzWhRK+PNlAey3PXkM9gx6ZL7rhO5lyTlbNDINoHxsgAG5d8FvKszir5X5INfOcd3udm8AEgKWEByL+DgcaFWUFtWKhzM0Syy3kzp8LGnIqGnU4vQcxiERAbN2bilfOLRkY2Yhj0hIenqNDKm/JjYj5IZ4tchBf8PlZ/f44t/oJocH4YGmEmj1BXWcKeOhcvoRZPK3mHN+5LfKRBo13tqeIwzZ0SGG8VgdKydfN67SMGwK692MeUA4fujCWZ7S81Jp4Ky0HC0E+1BXBncbj4IesTbq2mf8EkMfS8ONSmGRpn9OFGP/lQca/T9OoD+DQx5hYbIpOHRpDoThsBgeXalc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af8b0f2-61be-424a-afc1-08dd1b57a55f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:22:20.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeINmYVxIau27YeGiaCiEUJLKH/cO1eSnNw5j3JnOJZgmbTsW+s/smFA0qeXZgNaaNGBtrsS8lxeZJc8rc+w34PCKgVhSw7GUS0sTrQNN+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_03,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=922 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130063
X-Proofpoint-ORIG-GUID: tf5_68SsLT-it0HxsXNDFH9jVZSaKnFt
X-Proofpoint-GUID: tf5_68SsLT-it0HxsXNDFH9jVZSaKnFt

On Thu, Dec 12, 2024 at 06:36:04PM -0800, Andrew Morton wrote:
> On Thu, 12 Dec 2024 11:31:52 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > It isn't always entirely clear to users the difference between do_mmap(),
> > mmap_region() and vm_mmap(), so add comments to clarify what's going on in
> > each.
> >
> > This is compounded by the fact that we actually allow callers external to
> > mm to invoke both do_mmap() and mmap_region() (!), the latter of which is
> > really strictly speaking an internal memory mapping implementation detail.
>
> Thanks, the world just improved.

Thanks :)

This was one I promised somebody a while ago (sorry to whoever it was - I did go
look but couldn't find my mail...) - wrote it on my TODO - and so since I'm
winding down for the holidays and like to keep my promises thought it was about
time I tackled it :>)

>
> These functions have pretty dumb names.  Patches to give them more
> useful names would be small...
>

You're right, they are pretty incredibly dumb. Let me have a think on what would
make more sense here...

