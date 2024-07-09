Return-Path: <linux-kernel+bounces-246545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7447A92C356
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28F6B2332C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF255180047;
	Tue,  9 Jul 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m7PPJSOL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pvJAe75T"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90591B86E4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550146; cv=fail; b=Dcz1hnOGSTX1n1v8jvYFP+hu0O+EW0MeTxPSx30ukaDp7B7O8eKEjQO2wQeo/d/euLtQR6pAqp4sqPJbmh65qMNazoJsrFeJb7LmoaccyWssWMwx3d0EvXx/9S/cYHN19Exmh/ey+efXZn7c8TcY5Dw5yTiGi6dN7c1kduw4oaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550146; c=relaxed/simple;
	bh=qsIBBUl9bpKfzxoL2DB5ECnvMMWn6VjCYYH3fykQZzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dUtJqXvjVmQ2bhhBeZ4BYpLfmKGFX23Gd0TkgU35Mp5U3aZWxnmzcJ2b2VmLrGijteGvPp6j18IFryMljkLttaVPj5fgSGf+DEqPn50PGiKZiSpRF8iu72ktEx20Mf74JM9RsYy5vpUzrI92V7EVNEQN4iLjJBVgaJumnfYrrFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m7PPJSOL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pvJAe75T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469FtWkK007633;
	Tue, 9 Jul 2024 18:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=UyYxaz1nKDvWKec
	vONRy+SzDiwZr0hZ6Kj2YaBwfoZo=; b=m7PPJSOLheb5I7hdD7hyTPNA7GpWBqk
	QrxdX5xFH6xccI09dfcQ89UEkGSeyF1rY48c9rLW0aQOEECwr6Ha5wM2UV/miG7J
	HuL5hLZbkmiugLF4WFwuZuotIJYIbaVd2FUcQYG4PpvQd0UeFpK0lFlnm3WlqZpg
	IEoO8tL02464tihQPxyOE9HR0AWmTMbcMYjUSl3UkZnVU09fAbFNcuDqyowShI6f
	SqkPL2QhVfNSOZcbSU12qZK9VT3Zwd0IyOctHRKeJT3y9gjYRPcrvax/SPkQdyUg
	iIsZgxvPlso7Cj/465Om0hpjesoUxlbEVSDfTdstQ7YnhM6Tf+QPTIw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgpwqgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 18:35:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469HraQZ030304;
	Tue, 9 Jul 2024 18:35:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407ttu3urr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 18:35:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4Pko2VTh0EtcCD8yG8qtaB4oZLfiuQ8fEfkvR9M3YaIPJ/f7IiRFPZMd99nM/yofINSn6SfEF6XScVKuhLoNl+ef93djQCIe1WEzMVO6b2gg2R6F75SKs1OgY5zWpUidWAldPZjn2ErBvdXhxKgxFzoZRJwGpgk+trQk1CVPYl5xiBHLyBtZ2rTnTnvohJcxvIzKu4vzJgxoy3actD03q0dWqFiOjZTOtEjnAg7OYQ4LKsBvgESM4lbe7b1f+IhiTVzkzDGQsJ5or0SlBZTWGKLqTZVYMd9wk0ktrayGbIGYJmjzVdyapuaf6izOU+1+GairKYtBljbL6wobuLV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyYxaz1nKDvWKecvONRy+SzDiwZr0hZ6Kj2YaBwfoZo=;
 b=cv7RroDDziC0I+vbENz+RgxJVm6C1NMRnePAsywtvEHxRw0+mqjDkghKYT9hRt0McXFcUKMRpM85wvPag+LNdvp/7I8ZXmwhv/dBUZrsnckSTHJ9kwHIAKGDCAb1qtKtEF6ZnnCbyiW44bDGUxOzL0b51W0ETwJgyehpmQZ0+L+urBGR96dXiSdYY9vwbGjFEKoF78sS/yj7eQB4S2xTGilP9DQk+lAIpsuEKvUVGEzWwNal9yrdnD3UIHbsjvPZaB1ksiimy0GEls6Yh9pvC0uLD1jwd1siIm1168kR/HMgfY41xWj546+1kLqoIKX7RDRsjodhuUDliuo7GsDSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyYxaz1nKDvWKecvONRy+SzDiwZr0hZ6Kj2YaBwfoZo=;
 b=pvJAe75Tv6oS0xvpYgYbI/B3EI8wUUi7DV/MoMCreW1jZgIRabA7+mJYi+6r+ai/j9Fb3U4poElyj2Pcoc7qFjBcSdh84EuoCJIfJJ9erxq7rw04YsocDY1TPj3KoR4IxxEyWGcBduiI48bb7RfZRcWLUOyNiYkZtb1AwC3MarQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5546.namprd10.prod.outlook.com (2603:10b6:510:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 9 Jul
 2024 18:35:19 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 18:35:19 +0000
Date: Tue, 9 Jul 2024 14:35:16 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 14/16] mm/mmap: Use PHYS_PFN in mmap_region()
Message-ID: <7ifrcfw35jqp5zlu2zofzexiy7kw5o5pwqxrolfk4azwpv4w24@uhw2ksxdswkm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-15-Liam.Howlett@oracle.com>
 <7a0350b3-ea23-42d4-b2f7-4680d761c969@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a0350b3-ea23-42d4-b2f7-4680d761c969@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT2PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e45c1dd-c665-47a8-15b1-08dca045e24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mu1FLANgk0ET+5lnyupG+rikTNJSmlku5htBLc7PFs1dVAeEPwzJnvv9ywft?=
 =?us-ascii?Q?T1pUvwdUd6y1+rW4XHf5oQr9LjAXw4tuqZKoB9PY8FjiDkBYwMGaDp2zjaIs?=
 =?us-ascii?Q?jJXt6kH/LM14zajKz6ea6NSRuMEbK/s5FyuofkvAGWgrbQrtn63MfDkfCixz?=
 =?us-ascii?Q?kFchbI2vq8qWZZlGEw+3Vg0ZMTYiJIXxTslEXZ8TCrxzRyitMV3BlHZwG0ia?=
 =?us-ascii?Q?ALAWvBYiFgBpLWMCVvRud663t6sPA+BjxOci9UuRj7PCnsERjh0IhLgESi84?=
 =?us-ascii?Q?v81Tjh6jIA/z4ostjTKGmczmtkwl3JsZMaYy1y6UL0mvnO5ug3/g+IGer50L?=
 =?us-ascii?Q?cvaOvmykoUupyM8rPViq4tbal7AE+B03T9vR1Z7jKdnXlwDHKHqe+0IVEe/T?=
 =?us-ascii?Q?A6HkKoTwEF+sbPgQ/sA5VUMb/SZ9R58KWjt/T46tSkD/tWfsQ0nE/N124r7F?=
 =?us-ascii?Q?6Z5L0iqBfvCgIub07ggZ7UjbZ+0JiQDZlWnIv5nsWSVPaqBxZPRopxHSlfZT?=
 =?us-ascii?Q?dnxdKmAbytsI8iugfvSY7IqxziziJBODnb0xCDblN33neekzyMdWQJecTlOQ?=
 =?us-ascii?Q?cGHQcF3kX3YhBDsZ/7yXhI0+/WpYfvY0MWMQ5aTPCuiEAGPhC6jCd7hJFTRP?=
 =?us-ascii?Q?EGOKZnIv68b1bJ9Q15om6lqyIpL9zGs9lzahGl4XVYNxf6oDwKA9UcvwlgKP?=
 =?us-ascii?Q?QzY62SIzwiq9KCKYzb+kL6n32JltJ+/x5b0j6zDBngYLsS3XqwnIMNnYu4PI?=
 =?us-ascii?Q?OHA3TBqQdA1U0OAMN+13NGl1wEZLrTWOIYVWTsMS6ntOhu6Oz9BJ6OglNL9h?=
 =?us-ascii?Q?FB45+6nbyvFdDQansUM8Dd9ZIZTcgRCjjlE/abAMQgXuCtxmV6TIiBBXOLKW?=
 =?us-ascii?Q?hybtLebrvwWw+wcV+32gByQaQ/Z6qOSvaO71QP3+xpfTqCf7dDFpop+WGOTz?=
 =?us-ascii?Q?+QJCiTlH01nRkqy8zcFkK47QTzfC4kn/vDBYU2iHBrXDgDoaLoj+recqZNls?=
 =?us-ascii?Q?Oyl0qQJtvGhzrq1inUqPv9rd22/Z6+pWUAqvF/zxVPMHRBEVOm/KJHJslOpG?=
 =?us-ascii?Q?d7NLDl7aNW6E2gFgl7Sjbqr0KBcEh2VFmRtJZEsGsVJx/l8OYifx20klfNXy?=
 =?us-ascii?Q?KdS2aF+vbLOlqupOuUakBGgftYKFhYRyTxTZ+U+UUGjDuhbkZF/h8Q6hVUCD?=
 =?us-ascii?Q?ZU+9MUgJDfoTOyCZS7hdFrQdrnrItdcXAztE/SWptSLgeElorgbyBbfZ/BDH?=
 =?us-ascii?Q?soKC4C9Duxiowh/6k4uc8m+cVQfCte+eSvgC9GUowSYYgewPlWvv2aZa/RHd?=
 =?us-ascii?Q?0GdqZaYiscBHlT8z7RMNvpvxs+Bo6z6/VhXArLvX/ZJWAw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RMFXB+pH7wNSPEYW4oRYZENCidOk7/3d829FQUDv1eMq70rLPf5+gl9wMbaH?=
 =?us-ascii?Q?sRmW8x1Z7YoRo08+zEeoORn+n+UbVe93D7aDiJJCz8DTyKFESea4CstyYHpw?=
 =?us-ascii?Q?mqgzC2dHEVhAwynlygNyfF8YXG7Pib7ia/Kz/akSIK+t7oebGchwc0KSOLQc?=
 =?us-ascii?Q?bbxKy8zUKqPcOjDelS0rcyEvnG56F1ssiuwl9/C+gI9iYgJGpBIjxEnzTAnf?=
 =?us-ascii?Q?3nnNvzlI4oTsr7zZypwqRlTX9kcO+XYysGVWmhtXZBvmdFJ+XslE0AJpfiLH?=
 =?us-ascii?Q?jc2PoMz9nms9rh5zxS7T/Z3F7q/mujpWjrIq8KbkWaqydYBHc70+XCQmDWuP?=
 =?us-ascii?Q?DEK0Cj3TQecNZfrAVrazhbSO2wFosMT73E3AthLqVqSMUaRuuqibx4s4JhJU?=
 =?us-ascii?Q?IJOjbPRwh5VLZfxbnK2TT5ccKq1MmJ/MTE6aM8G9Q52O6x7E8joFCBGtLK2I?=
 =?us-ascii?Q?0lqM15ptr83pDtEBJc8gbW+drjekL8N5SixJue3zOigKeSuNYwGz00gQKwLC?=
 =?us-ascii?Q?+4EdIPMqT+Iyc2b5/4GgHfLv5pn3mdUA2s31jn8B+RnfttGcRxNgwExoCckx?=
 =?us-ascii?Q?iiqqboHtikoY8Od4N+K7Sr0XfoVleNmgh8q0U/oRgYqhUiwYbagcBl9reAev?=
 =?us-ascii?Q?PldHElRpq0/tiXidWmq3HQvC48zlVu0PlTD8Nq+tXuT+WHXtEA17aMwj1YIn?=
 =?us-ascii?Q?rhUBLk7kWzFFfCHBLCHcJPtat1EMSVTAEbVbYHg9p8OZk4TerR8hvPB/Ehnd?=
 =?us-ascii?Q?fSF/Xc7CvjB8j89IMiklUWtYCgPMNlqwbzsz6A95BvYaf5q2gbeMh1XjyAWY?=
 =?us-ascii?Q?eFG5K74TSkqRHJVrz03JcpQsbBc7W4NYRwh35Uwg7xaxk2RUL4R/H7VwWxwF?=
 =?us-ascii?Q?RbkfxAu9jg7z+byLpzsU9LKgIUF2Hn1Y7DonvM+nz35bgqzjAxRDp1NVcyzd?=
 =?us-ascii?Q?zNn7AfNwiP11Vqng6UcBEzy6k0ZKkNM1UKkRMc5LnT7pqlK6Z30rILHbvzEU?=
 =?us-ascii?Q?YIOIRZmibUudvUQK+7F/XxOTkr+Qrkh0G3mIlnBE5IfY8yjXxuQgRvXNBnvL?=
 =?us-ascii?Q?T3ndu6ws68Fsx/Thuf5Zt1ucHTvTCFR52FutOor6aYI/qZ4RF8Rywo6SLnbv?=
 =?us-ascii?Q?55P1oHWhL5h86WSGpKd4MIpqHetw+10gU4EfGr8ExxZBFHbhOyk1mPMtaig4?=
 =?us-ascii?Q?ywntOrdmp/a9DNPFtpqgMMV1sU08UXcLb1BAIZstOpVV2hoV5xrK1tukkEtZ?=
 =?us-ascii?Q?dnvBSL7EM5Lk10c9mNmV46grdcXM74tmD83xqIb3/Vy77O14ixZrNQ7sJ15N?=
 =?us-ascii?Q?ox8zpswUuBbMGFEHqO0ukZj/b6GJVNofqtwzKd4NjCLjsnRV6wZnPT3ZMcTC?=
 =?us-ascii?Q?aY9jYzkBu/SyHZtgwnjgkWcCh0JdOIQTng6o/TzXoj6C2QBsFRkeRoMQrnvH?=
 =?us-ascii?Q?lyKyMWL9OK0i/rr3izJ9JTFTgyy+Miqg96lpk1vVNaMYRu1UnBwJaF6mhT6m?=
 =?us-ascii?Q?e9QWrm2FDwtAl4ySj7KUp+NOOA8cqjM7H63E/WYTOX637EVKtCWPNVOkyBx9?=
 =?us-ascii?Q?eTh9ClRr19qQ6Naz6SKs0bx41JbN7vmlt8f9DJJPXsN1NlSYCRr1zVGnrHRp?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qwm4rU8Iu9gxHjx7jz8SaLEZzCjlgu/1Kt1aoxjda/HR1dooePx3YplZcR3Bgb876TmYp4QsSzsqVX4QSPHmtzA2GIyn3DkIpa96rgnFxUJmjx007SSQe6R4HQbR7DdbJ03PtCV0+E6ukPjJ+OQ2PZ+9HXdYMYm6OUIJMB1SLx4GcVQXJscNuojjrUBVY9zvyf+T+JIYMj15vpzg+omAamX32g9I0QBUjyl8t2OcO1ErqufLxKAstw8G+uDnqCVnpdJcqWtoheRrn2k8E/w6upr5Wub7OiYBGk3R0gAnZfI23EGfZI5Zg56yXHXM72vAwIOqZBlTx+jjox4w44awv/3Jd+rm1kaYGXZrworT5CIlGI+FOYbDTe6BoyBuDDSS7Nn67O87uBYHycFymqwW8Pq2aY6o1bAuDNyx5Ju7ZE45Dqh608EdYArZkebsg56BBxhFjsqmZZA7wcCfqS2HRougOrdDLFkZscqGOTq2HwI/B1zL0Ea4i7iAFlg9MVTRmc0Kio1WOytPYRipCSZJq1pFaJ0mxbLDhvnBlzGKX7c0b1IXXamhE1FSJ8/63kMAJbzuA7bgpSsWGOLrdqk86S4CzAHVfwG7bYPpFIaerBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e45c1dd-c665-47a8-15b1-08dca045e24b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 18:35:19.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3Z+uJebrqWBMZG0k2d5KeucP5tALRQo4M/spGwGott/yvV4AafVQ6cL1QOgniTFQUSzxZB05sSOrvBK3EsQ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_07,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090125
X-Proofpoint-ORIG-GUID: TdjaARTSseWJCJOaXB1euXNj73sQHWEw
X-Proofpoint-GUID: TdjaARTSseWJCJOaXB1euXNj73sQHWEw

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 08:21]:
> On Thu, Jul 04, 2024 at 02:27:16PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
> > existing local variable everywhere instead of some of the time.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 0c334eeae8cd..b14da6bd257f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2935,7 +2935,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma = NULL;
> >  	struct vm_area_struct *next, *prev, *merge;
> > -	pgoff_t pglen = len >> PAGE_SHIFT;
> > +	pgoff_t pglen = PHYS_PFN(len);
> >  	unsigned long charged = 0;
> >  	struct vma_munmap_struct vms;
> >  	struct ma_state mas_detach;
> > @@ -2955,7 +2955,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 * MAP_FIXED may remove pages of mappings that intersects with requested
> >  	 * mapping. Account for the pages it would unmap.
> >  	 */
> > -	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> > +	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
> >  		return -ENOMEM;
> >
> >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> > @@ -2990,7 +2990,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 * Private writable mapping: check memory availability
> >  	 */
> >  	if (accountable_mapping(file, vm_flags)) {
> > -		charged = len >> PAGE_SHIFT;
> > +		charged = pglen;
> >  		charged -= nr_accounted;
> >  		if (security_vm_enough_memory_mm(mm, charged))
> >  			goto abort_munmap;
> > @@ -3149,14 +3149,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	if (vms.nr_pages)
> >  		vms_complete_munmap_vmas(&vms, &mas_detach);
> >
> > -	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
> > +	vm_stat_account(mm, vm_flags, pglen);
> >  	if (vm_flags & VM_LOCKED) {
> >  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> >  					is_vm_hugetlb_page(vma) ||
> >  					vma == get_gate_vma(current->mm))
> >  			vm_flags_clear(vma, VM_LOCKED_MASK);
> >  		else
> > -			mm->locked_vm += (len >> PAGE_SHIFT);
> > +			mm->locked_vm += pglen;
> >  	}
> >
> >  	if (file)
> > --
> > 2.43.0
> >
> 
> Maybe I should literally look ahead before making comments :)) thanks for
> reading my mind and doing what I asked though! ;)
> 
> However I don't think you've fixed the duplication of PHYS_PFN(vm_end -
> vm_start) in count_vma_pages_range() - still worth doing I think.

I drop that function in the last patch so probably not worth doing.
This is just a few patches before the axe drops.

> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

