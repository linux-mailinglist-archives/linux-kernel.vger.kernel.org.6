Return-Path: <linux-kernel+bounces-566407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A55EA67799
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FB73A8BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C620E6EE;
	Tue, 18 Mar 2025 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sk5bdfDg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SlHwFDNE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAA20CCE7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311169; cv=fail; b=WdC67rTtEufz69qUfbiCiwwKUrEDG23a70JEjf9Td8d0JcUJXGrrZ3NCvH9HlQgoeOANuUmN9YUznj9YDDQMOS3DS2eXIEy/vRXr2trDMzq3uiRByS/Clc8qLWQjqZm9PjMbGgPwxf/8aDvexBjnFJYZjRnECvBjab5axQvFqrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311169; c=relaxed/simple;
	bh=ujIH4yujrZMwMROyI1NUBcRHguyAF90l9blSYaXKpPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fwu1pdh/EvEdlrTPDJY4LLMJNt2ojgnrbJL3woiqDP8xI4pBcD4+WFNeimhmZCC4cRvYZ78ySlvJCUBJFc8eOxLoBMPdkWqhjzgxACTsCkyE+WHjSBiUVzF9UDV8y3bpIoLLSOl20U6DoJHDTa8gg1B2S+FnlGvEOZaKqAj4T4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sk5bdfDg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SlHwFDNE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IEfpAA007488;
	Tue, 18 Mar 2025 15:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=c4BfljiKJrlwBMiOVn
	LEFgH0jNr5MRHs+EX70YHYya0=; b=Sk5bdfDgUPg/Kep2wY0QpwgnuZoHJSYV/3
	0pgBn8IkIsV+YhdjvIn6Avinse/RxSEKr2Y5EjA1R2vatTIq6G/dvfQyjLnvftOC
	UCce1x0nSQDnKhZ8mRSnRKqf/hMz7xgTMAmL8Z5geVHEzaxUuiWcPFyWPgkfnHfk
	FIPTYt4ljppfl4CKx4oJNki9fWpi9DeTeTQNspEFZxqVOwSuQk8C13RsK4WqE74j
	UOOMx+wdjtzuVB/eW5znVfobQ19g5sUc5L4yo3ojbEL3Zayi6Tn2oA2vSn14l0TJ
	uP9SG0clhSjwymlKm80fcDMtMvthAtt6KCU6HL+p4cYv8K6zmZVw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3nd3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 15:18:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52IEv11w025237;
	Tue, 18 Mar 2025 15:18:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbhh1e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 15:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT+KOibhjR8tcItnRYHXsh3+2ZetvQRdR48iLZLiqvuwNQwTFLeU9lty1zfX2yH5Qea+pjZljIab6C/szaQQVeymFTHpnAirYltOoOVx/MGnx1jno7vgmd+q+jJzZK2ski4hvUSXP6Yz7fybER2UBeIUY/+xyuTLUtj/JZAyh1LRHCsUmOJT6CLwcz5f3P/1wxzEqgbwPGGek00cfpWHbj3IKRvgNiLs8RG8ZxQD79lMxnaJPynRmazOUArmBqmIqa/zfRPvg5lCxouvgRc4lime0qgcFdqZTGkNEBpK7isJPJgfViBdUbNMLk9YUcLO1xV0NTsAaFsKGKmLuwmP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4BfljiKJrlwBMiOVnLEFgH0jNr5MRHs+EX70YHYya0=;
 b=wPxa83FnXIKAoQtDSrU+B9XC732PiwAs5Q+y8UymRbTSdbj5i31d0WauAe3LDA6akTI7xC6ls2A/UnawqzgUjmTVHOH8z2Rh/CLdAs4ccVvua1v+oDPNIMBEVmRu3MT9m4KIBprgQvjRcpvgmLagEXURDBlKPQjAZfry1GcX3XTQc4XGmBGKg3ustjeujoHg9004sSNyEIyN2xrKkRvnzdngdjqv05rRgbVb5v5NV5Ls/aTXRsk6W+Zg16Wd1WD740bhCUpVZRIYwhB36LL9xDx891vcSEkxL+gZdkdL4eQWhQtpI6EJHsK6gutKxKf5r4tpl5itR5cTh4mPvY6pWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4BfljiKJrlwBMiOVnLEFgH0jNr5MRHs+EX70YHYya0=;
 b=SlHwFDNEYswdeJPAuWbXMf2Mc73jplzyTfWdbysbGa0OR39Vh1JH5rhEpA/uHljbmkojXZH8t9Tf1vZhBWzPH7p686lYCEP2/u438YZxh+NhgQy2i2RPv29OXQ0st1psIU4EGkINLjHGGa9wsYrMK3KrW8DIPR5CXLFItFFwYq0=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CY5PR10MB6117.namprd10.prod.outlook.com (2603:10b6:930:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 15:18:45 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 15:18:45 +0000
Date: Tue, 18 Mar 2025 15:18:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tools/testing: add PROCMAP_QUERY helper functions in
 mm self tests
Message-ID: <52a7baf4-5235-4b51-b1fb-d9bc9250794d@lucifer.local>
References: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
 <fafaa05d2f0fc7ff3c2b852427dc9b64e1709891.1742245056.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fafaa05d2f0fc7ff3c2b852427dc9b64e1709891.1742245056.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0577.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::21) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CY5PR10MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 026a5626-32c5-40b4-6dee-08dd66302cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TvWgGmeSZo69VJ/VXWqHt9nDdl/cxTf2m7luuKzTFw/0dts++TuvDhR/jjU/?=
 =?us-ascii?Q?GopBXoR23shDgLogzPlJ5/nP4Lex5WFmB5VJ+/Hwhi85TUAs7/7bby4b4wsC?=
 =?us-ascii?Q?MPDbQSYV1WX95G2w1THCctDlmMJsp6uufEVMu8B2eLRf5VoVTN6blNTTp/6n?=
 =?us-ascii?Q?G1GuGD9ySDe328xKO3FSm3GDGCSzdwbaxJGy/78aOqV6io14cVZwYeIFwQan?=
 =?us-ascii?Q?kD5GaYnCGFbnTsJEvN3fR4Xib80PBMabmksG0qrbWjVliPpZjjyV9ubIFgEp?=
 =?us-ascii?Q?ajz/E/aQT/2Y0X3vblqlB4EH1PObKmX1wtw2IU5naHHvzxviPqQrf4kdhq/J?=
 =?us-ascii?Q?gk/cNhZzdrh0g7IA3cvySEig8TS3FfWDYJQmbGcVbpTPrYJwpBJw3Q1ApKSo?=
 =?us-ascii?Q?FjH7LpfEY1jPrk3fsk/hWA3ER3aCWnBP7zYNxuwZKPoVO9QgoJfDHmvEup2s?=
 =?us-ascii?Q?aPXv0N6qoNuvgUjzWaOJFtoOQfjy/544EBAmkNKB0B6WyejCPx03nVamjsAL?=
 =?us-ascii?Q?rsmJQcwik7Th+5dfn5kjf2tbUzL9WIIdGXhTOAjUJTWyOiMYttsAMri69P9t?=
 =?us-ascii?Q?KlIZqujiTmyqW27AKXows2ZeR1pVjryIDzhuC1DBKRJQhizTe7goacatbF5Y?=
 =?us-ascii?Q?lU2Tycr7atQ8ZCQBxIhQKEhdEQOgV/mt8D79dqsUM8fSncudmXg43h0/9mgX?=
 =?us-ascii?Q?7rRwNR83O31vOwdtgFUh2Vp4TqjfsUeWzuegL2Bg/XLkIdmoHWSaL17IWgu/?=
 =?us-ascii?Q?XgS0D68e02VCUsAGA13zHcn64w6phSO/632YIFiXNxlW+YTMKs24+Vr50xZn?=
 =?us-ascii?Q?N8YSjjfkPSJWJlILyuSxrv/6rBHku3erw0XyTBekIA/N4mMlYAxlP/6xdgyz?=
 =?us-ascii?Q?UdFMoVcVo0TCvOhaU+MkJKtigUDCM8qJVM5k7m82AuvnaLKAfvUZKJtrDhak?=
 =?us-ascii?Q?LfgtZ5NThHAxHhw40G+6tfA52v7WmHtfMfhdyJ0Lc/sgkMMBLeNRIlPo64tZ?=
 =?us-ascii?Q?IJla2wvenGq0kWWmosyKsrICl+C+l1aDb+oOOr1yFX+0/VBxLzGR/sS9GpgT?=
 =?us-ascii?Q?Hl/tT94haSSvlzhN0VE3WG9cO63KV/XGClji4q4DTc6XDs6vBTrwo9qnmdZH?=
 =?us-ascii?Q?MEM/2lVr6qC/q4x5K5mWy5+yv6fblXeg2219M6v6FXnXI2Lrx9YsqweehUzY?=
 =?us-ascii?Q?mwPK5E1kkiOwtvaSJKpObqawD4k6TR66TeHknj/ZkpEYL2o1G8Exaney7oDS?=
 =?us-ascii?Q?lvueCLtqAi2NcIHIGRpKPIUAsaYYAwSOW/vEZ8h4tIZBKZauYFi96v7L3lQ/?=
 =?us-ascii?Q?hRU+GUr7MVreLTMCTwsewzh4so5CVuhffOwyJMtwWN1L8SajO9DuGIIjUglZ?=
 =?us-ascii?Q?JmaZbgL8NmDlLsHBQ7THxQMR10ty?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5hHAq8o9UdsW/Oz0umwKwu9KFN2B2TbX/pR1NUYlJqiJmJZ8jjntb/61YP7+?=
 =?us-ascii?Q?gEHYpfLRxdkFsHBmVa1b8Vlcgb6QmfUsoIG+6HfXq4IVd4grKldYsyRJrJAz?=
 =?us-ascii?Q?cuDguu6SAf7mQzfauihv/uNZZa7nmxTtvAXto1rZywTu/xLmOSrzeqpqnjRm?=
 =?us-ascii?Q?Rzo5zqLs3vrmPRvxhNPMmkhmnKNfdQQNBp67M6lzQctYdJpwWy0Z75nV2BPD?=
 =?us-ascii?Q?v6P0kPWcaKHHPh/HrgovghKW+ZBX4AT2J88XpMXWMdWI9jsOl7LrV2/j0HD9?=
 =?us-ascii?Q?nh9nzY2+NdBEu+iqcGOhbcEMv9zg2qpxOyyXNuGAvp8Lt2TwFl6betDVlfy6?=
 =?us-ascii?Q?HGo/ZAU6J4E8doWE2Es8vyDlY8S4HQwZOjkLGKGp9TmFvoyzhB1BrF96VaGK?=
 =?us-ascii?Q?zeLo6iHJTSMXe6plU6x/zD+vuVQxhiS0g6iSeHbynX7hgGwbY9WeQY1ozzsW?=
 =?us-ascii?Q?R5H6nLGNGtPJrpLIuGw7ajygBrN9oWBufjb3+ZGPxBC/qTalkNJeJNm7yGzJ?=
 =?us-ascii?Q?b08r43sN+F7qk9RZfojdB0/PUeJFX6hc8iXa50wcc2Exo74IwSPyxK10NS80?=
 =?us-ascii?Q?Xipv5T6A55iHTntQsTVe2ruC413eqczefDNWX2mFPBljtsEXNAONnHVYHOlR?=
 =?us-ascii?Q?ERv5cvWrnr2kWvm8Nw2dqRKObmvpifOAsQzdlXNbqoZIUzi9wPqJeUGEQCqh?=
 =?us-ascii?Q?0kuZJYai4opbPrmNJoAueGrwgu8PNDIM7JZXrM89c+IGZrkDs/lBUZ7k4TMa?=
 =?us-ascii?Q?WyZFKhk7FKCcgO/0MgM0ATvP2Iz0ydp6nI54Q7sFvKqpMdMa39iYvIPHCXO1?=
 =?us-ascii?Q?8NvmTaFDX2774odXgwyFOfvXhK9cHJhi3j+CgspHNxsxqLrjToyyPA/TBbnm?=
 =?us-ascii?Q?OhepvKPFdFtd8O78LlJFiwX5tlAJ6cc2RboJThAZNIZ1mvKQ04/NCgQDsqMO?=
 =?us-ascii?Q?Vol3m1aW7/J6S75AW9SB6gSW8HkyBLCkCkPHi6+zVEcVV3guuSWpX0y/V/db?=
 =?us-ascii?Q?LtN5WYBrUNGVBt7yPCRw+C8D9zVtfKZCILIa7NILqtm1uuOnuuA/UbyPMKk6?=
 =?us-ascii?Q?nMWMB9GK1hSkrKtFYiXxRUMwnYNjO12Nv0zkNZ+/zS/uxU/u9M7/EbH3lsPs?=
 =?us-ascii?Q?2zpgrtyy0BLCXljJZ0SZFTnpgmpSuifHXD3x1Jp75zJ0lmsu0rmChYoCB08C?=
 =?us-ascii?Q?i+wSxNpT9FtvrlQorUrLV6BBGcy9orSpB2DIOSybYS2juIbORWAaSAs2okop?=
 =?us-ascii?Q?Dnk+Mefh5IqwPaTOsN651BpMmUcIap/6Mk0P+yMwmHwc4C7aj5oKj5fCPqen?=
 =?us-ascii?Q?UaJvHb39kXPp/TpwE1XoaS17n9FfuiOIqIzS1Nj91phDPrtS5Uxlth3n8eMb?=
 =?us-ascii?Q?RhfHoUpjNJIQ9ZZUDyH304EoeZTR4NMbwoxFvaRsWxATzGcg/OqJ/hL+4Y/k?=
 =?us-ascii?Q?7DzvO3IGeIgn1w3l9mmtGRm3t3P5JAGrbLkRJIHYOgMfTUe9HjKpdjICG92S?=
 =?us-ascii?Q?205QBmN3By1XyOEPH6mXN+rmgqvrVS0KeOEY2NrDxywcPKHk44Ul93OG4eYI?=
 =?us-ascii?Q?vlZZCHbWSl+IfMzS9GBuuI8L3XLdCEdjK6Mdxrj6in5HSsjs6j6oe2CFRf1+?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FwMyirRJr0vrma+IHcQQ8FeRkjBTUr4WC7HY2ufF3bWfBcdVGowgu/jpP3Va8dojNLoxcVpoUQZZayQ1Z821CptZS6M9gi9kJ7YFpGA+dWzni0AX7aUMbpxu8PD30GBw4FaasK7Wp4mxZrmjgvD3ihKW2jLFyy4pzxHLJzSKLKUc56zNbMIC0Xd5V+wtSu4dWXkPmYX8tfZL0OM109+aGFi8YcM6aMFne89L+STfTasnN2ptKlVaYGN9DN/Eh4xfG3q31Fmp2Q4u10titZDFoetrMiHW8COizaNInuvYsUeNTOG0WFTcOqZMKQuWxDuUv6vmqipgUEre8+mxSi6iBjFKyx/1ZC1FEDqpNgmhv4+F9skb/mBt15wEqeIOZtqS9sVMzb7BdzZfD4Z1AiC6rmWa/sgzVGrjaggdLeX0CTdKUNew6gDTOY9eCZ0Fc+gP4KuvJXujF/tHkfWfmR5zew+Xx/oiBuWFn+nMD2tPHMSiRL7A0lqOB1wlhmfre1G7MopkU/JK+NnUcb9o1dstWWCu+al21nBJNDS2SpxQZNdbt+dwJMBmeVmvwRN9Y4oL+Vikjnm/XrqhezXpH+6/g1bhefBscqKz3sbKguQsoIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026a5626-32c5-40b4-6dee-08dd66302cff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 15:18:45.8104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRIxiZpoIGxX5WpGAq2BMrEWlT7+QIggONIHYV2RUyIL5tE00y7sDE1+UB9flenKmcmzbJC1F+gilBdi9ZS3XysER0XV7nEoKg9WRXqRt8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180113
X-Proofpoint-ORIG-GUID: 17sne3oS3vgiDaaVdfyP_CZBjSZv6Ult
X-Proofpoint-GUID: 17sne3oS3vgiDaaVdfyP_CZBjSZv6Ult

On Mon, Mar 17, 2025 at 09:15:04PM +0000, Lorenzo Stoakes wrote:
> The PROCMAP_QUERY ioctl() is very useful - it allows for binary access to
> /proc/$pid/[s]maps data and thus convenient lookup of data contained there.
>
> This patch exposes this for convenient use by mm self tests so the state of
> VMAs can easily be queried.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Quick fix on this:

----8<----
From 02d674de3736e3726a97a27625d4598c3d49d08a Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 18 Mar 2025 15:16:29 +0000
Subject: [PATCH] correctly return errno

---
 tools/testing/selftests/mm/vm_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 891ce17453cd..1357e2d6a7b6 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -440,7 +440,7 @@ int open_procmap(pid_t pid, struct procmap_fd *procmap_out)
 	procmap_out->query.size = sizeof(procmap_out->query);
 	procmap_out->fd = open(path, O_RDONLY);
 	if (procmap_out < 0)
-		ret = errno;
+		ret = -errno;

 	return ret;
 }
@@ -451,7 +451,7 @@ int query_procmap(struct procmap_fd *procmap)
 	int ret = 0;

 	if (ioctl(procmap->fd, PROCMAP_QUERY, &procmap->query) == -1)
-		ret = errno;
+		ret = -errno;

 	return ret;
 }
--
2.48.1

