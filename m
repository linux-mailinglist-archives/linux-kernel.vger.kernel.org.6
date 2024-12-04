Return-Path: <linux-kernel+bounces-430384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E819E303D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF4B1622AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A035624;
	Wed,  4 Dec 2024 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lc+fzwjA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OqGPxi8p"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF0184
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270770; cv=fail; b=dscqA4XNuLtnm3upyBTAi8yhRhXVrucXbMjNq7F7TjPke3oItDTtNc4C4vf2+4O9taUa2Xbn9GS/fSZcDeDPY/jwhbHltkCx44HZPjUy4WoyuQEYOsRG+FpWkKdMg1dDqB4VS2rbC/hs+4ZrWUXskzLfqAChasQsou2UddbYHbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270770; c=relaxed/simple;
	bh=t4se1XyspkrPSYb+5ikXWq1p5s6RtQHNS7gX30tXOpI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=MHfpeG8o/dqgOLYmQCgwCH5Ex/sfeOnWcoZIV8FmMCJE9RzWj7WP6I060a0n3XeTaitejoRq8Lq7dsGKUM4X4dPAYQZWCD3lgjdBdF/JdFYD3LAsMKOVOW9qXz00ix7NfJ6GynkdCgn6dpimH4dU7G44jXbV1RjqUKECi2ac57A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lc+fzwjA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OqGPxi8p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3M3QSw007885;
	Wed, 4 Dec 2024 00:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=t4se1XyspkrPSYb+5i
	kXWq1p5s6RtQHNS7gX30tXOpI=; b=lc+fzwjA4VIPlCz3fDRmBSmg3nh8Gk3qIR
	d/MVXn+BkKaQdxvQ64M4oC6CqmqyAPxvADlrC190hWS/vUahCnzxBW6dpkfBD3fW
	RWOYC94gjSYjoD6br+eBGGXXHgjbshF64/Bk0AOr0aDLyRLmAM6pwg9fFeARN5Hv
	sVIwDcrxQsYTaUgkhUC89xr9X+Ce3IUnsZUkdceMae+EY+vUp1Bm5wk5AcTHk7XQ
	4BCbMmuucXWjj/MMMuIcVGZRTqtuTUuyo8fJ/yNhKrNzKuOJYvhBy20UKHuF5EjJ
	HnRPO1qR+amN8lVSJCKCubl/R3M/+3Jxek/I3qcFcpBZk2vjkZPA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbqbyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 00:05:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3Mmvrg037979;
	Wed, 4 Dec 2024 00:05:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s594yht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 00:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEzq/bJT4HeASK8gMWzG1b6jkdLQ2/IaHTSgSw7tE27YhU+Wxn9F2spOBeynSqU1ZEpNP5qbIlByRLSZonejPylLAY9toUvaehs4+EIjAqKdRtX4BoN0J/SClZvWHX1dhyrgyyBGBjYHZvEv3NHN2ou2IXELtsdHTYna6h0NvW6E9J1ZDR5nqg7VFpqJZrZxkEakiElSQNhlwGZR9EYQeszF9hNR3WVgccmFewmMp5wDCNhyRyJGYLE0F3EYr3jc9cIC++PKz+fOvQLKbfkUvUIocVp+lfjoM+RFsFFW/aC/uIg/tJMJM/ZNWicMMrVKbfjupICxdOB/4RIH93V47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4se1XyspkrPSYb+5ikXWq1p5s6RtQHNS7gX30tXOpI=;
 b=QWcb6r385n1J0+Btmm8KokgbQzNy1YPwYfxSGX03hIcDGoc8umCXZXwrX+MWQ9NEPUHIlrnyMVN4S6TtWbhh+M45Xw+s0ML7BSrxTTF9d9Rw0pMHLTtMRxUJtHz5smgEdTMfu45vsGI8/ggjXURfTMQ2wme+c7DgAthHsmoCc4PEIoRkZHgNi2cfQWLnfPvZl8BTtSt+nDjUS4oaYLAVN8ocwm3ET7smH+mxUstP8eWXx6D/Xai+cnOkj/NFe2m0lKtX3GoJkkdxIPInaG3VW4ZlBbqbej0WQtFOk8FRwA60wIlOZejLlxWn1V4H0dFKUTx5zR8dHVy3GZDK2+vH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4se1XyspkrPSYb+5ikXWq1p5s6RtQHNS7gX30tXOpI=;
 b=OqGPxi8pgv/Q2T3Ng4Yk+tuY95oaldC6ApOeUpwNeSSKB83l49qozLy94HszgkQg0kBF6mLz1wMbROGvB052sh6LOBH9ZqegoHll2TAve6uvt0mcmWM0Aw/2+/HrBitMPKaVTe3r6691smxw+22V8RrZEF3STT6dqYDMospN87s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 00:05:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 00:05:37 +0000
References: <20241202202058.3249628-1-fvdl@google.com>
 <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Muchun Song <muchun.song@linux.dev>,
        Miaohe Lin
 <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>,
        David
 Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
In-reply-to: <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
Date: Tue, 03 Dec 2024 16:05:36 -0800
Message-ID: <87mshccnxr.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: aae4a4d4-b505-4fac-c358-08dd13f761c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TvrjV8iL/7/27YeDAJQ4g5OTeyb5mE9+xe75/SYEHI8sGSvDiTppAACcUqGf?=
 =?us-ascii?Q?UbPbGA6b5icbh2+NLMg2e+KBISQmDghX3LYC/+TZcTkj6YF8RFh3rVNXuLTi?=
 =?us-ascii?Q?ro9zFc66en4tU6dAX4B8XgCnoKvinGXSVW2hnJhV4pLoKBtpKdkyxjyXoB3B?=
 =?us-ascii?Q?G2PP+DE6cLX7d6g8TI8zEXl4La03kpKlfcaGw6n6093Y0WnHA3StG53qRo5S?=
 =?us-ascii?Q?2iI56WpUgT0jxmA7z3Jh08yRhOLyUAPA7EAlJMVsExY26x1MrsuqtJuUcv+c?=
 =?us-ascii?Q?vf5Pcww+wDWnfHQrKzir/gVZZuszflng7tuP8wN+sQEtVixGUW5ZiHbMZ+i4?=
 =?us-ascii?Q?XVgmYFdsYG8J+d2D8RfvLzkS1MRUClJX6N1qub1mmHcGQd/SI3NWgLSlBEbV?=
 =?us-ascii?Q?shWT3ErIKuLmkb6bxnoY8QwxHxXgHuDYQnWLgy5FyVPhvS2chGWIKoB9o+3/?=
 =?us-ascii?Q?nnqL2BuEneTbnmrw4cgz+6AK3FW97ELjx41c+4SiCvy+Jtcj3ZelXfzhKoU+?=
 =?us-ascii?Q?x7PWdgYWn507aJWTyTUgtfxvM5sUwvlbNhz//80Hk1dv4+bUUcaLXznXQXMS?=
 =?us-ascii?Q?0/eUoPJLNUqbufr6tnTJmMib8j+7TLeoXtzG5G/GJDrj2WzrXlnf9vjnqYui?=
 =?us-ascii?Q?Egk+vG9Ok/F7S6h0VJy+8T0G2iDLpqYbEAFQwJI9CqStz3jJxOD/zm42gs5A?=
 =?us-ascii?Q?/3EHmKT5GvwI6EVa+gPxU0yco+9+IdRal7TPh02RGK/E0nE9O9PnzNfWF34b?=
 =?us-ascii?Q?Bhb5qa7Smsy6OPGxrZKKl0U+HeozNfxNxDnzDXZImn0iTO+Ey/cf8sy/EiRZ?=
 =?us-ascii?Q?jsZJ51nJhTSderqL4YCVQdoFiWgDg2L4M08A5Lg07Qbm6obbD7AWPy9ORgiP?=
 =?us-ascii?Q?eLbmvAS5rC9Do12BDopMDRR4RlkkrOIMgMUB1zkXtwnby1W8AisqIh6f+ilJ?=
 =?us-ascii?Q?gbfjaljMb1csQvQtAkV8q8Rfgwm83kgTU4NG7XIJJ5msQwK0U3HvfKvRYybW?=
 =?us-ascii?Q?xBCn0554TGoe/eSVLtwPdKScUQqGo0oX6PyPyVCDPQDW/Evh1Ruaotpq5nzr?=
 =?us-ascii?Q?KkGOg/jKTK/93YIBz9hpoB9CU2oM60QI1QCxB1NyH3m6h3pQqBaIClgcdjm2?=
 =?us-ascii?Q?eH2q3MDcBvUyUXU6Oiq708c9NkcuyfGscQRkoO9g3Idv4JlpdGPIBr+1p4wW?=
 =?us-ascii?Q?3uCyV8C80cRDk6lxtFbOfthjT+emwrtWHYEmHhd2p3Xf3txm6dlBeX658v1v?=
 =?us-ascii?Q?pbRIflnnR79fCtsLHpzj3T7z75V5Z7gaGhj/hXK14Hk3AJGmbpq5VUmnLw5e?=
 =?us-ascii?Q?xPyuUExs245HQJH9lc7yIOhVtCg5rXy+1bwXQFlIAzeBnzcC8UyEseCPuEBz?=
 =?us-ascii?Q?pk5WTRI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lT9SBcXGI2H8WZ8rSjMlxESaCnA6QsC5NyixCOXrtsqBqZ1agAiZIoSisc/w?=
 =?us-ascii?Q?+KyfNZk4plnFIYLhjsgvg1Mx838hL0AEZ8hELwxx59/pIV9aBCo5VTeQMzBr?=
 =?us-ascii?Q?IxrGPrdSLJKTKWbAAjNQgAt41dAQaQi+LccenT73TRWiYdpkKLFI+2YiacbG?=
 =?us-ascii?Q?hFQdPFQ0Sd4BKCYLl1VE6N0SpeHxsuilt7wA+7gcucrHswrCW4emAWTe4R7f?=
 =?us-ascii?Q?CuWhPwV3xzPkhvfRRu5zSXAfP/mTQqQ4tSIxDgHFFYxTJyClxqo/F9gXVbhB?=
 =?us-ascii?Q?EmKIGFwcVGvkulsP9XVnl9wRW8he2I+b7yD2/526dF3byKBuuprFeQjmdrEJ?=
 =?us-ascii?Q?jCe0CI1Da24jjnMDhn5vwSEV8oBq3fgk6opnqm7Y8dYVVScRkMPPckpAzRwm?=
 =?us-ascii?Q?GzRRW9o4YUjVLk2mf1oEV5n22il6P71XpsJ40FllXtJejCZAhPVYeGuGDqZP?=
 =?us-ascii?Q?xnTDRVwO+5R+vyLO42Csp3UM2QNsjWPcZtv6XcSIuOEtHarMVgkEoqEgqArZ?=
 =?us-ascii?Q?xgllH/7D+BbP4ZbgvAYMEL5pNQAl4DkYZCo6/xH+nqUqRBVrGw5tJ85xRkN3?=
 =?us-ascii?Q?RWJfQf4Bja4VvuekRIyVEYQs6gVhBjh4NGPYyVFErLicslruFti7m36YlixX?=
 =?us-ascii?Q?ZcNvI6kftQ7xV32bFqrZqN9IqMmRMsb99sSfG5CJGpCEs5AwHT3egUD0Y9DK?=
 =?us-ascii?Q?QKdBQf9NZEbPA8xBbOiwiL8j/EA0XQxuNE4nPl7ZC3318esMapOX1CnDEpRy?=
 =?us-ascii?Q?ukU5kAegQZE1YS4T9CUfkNxeZtvvYfocGj1cOodq5VUeJqOGmGTR3tg6msvC?=
 =?us-ascii?Q?JsIJDvidVM9teP8IvAioGxlkizfVmWmg2pRToJutIYZZ+VMioSAGv4gRnzYu?=
 =?us-ascii?Q?qWyuxTCQkyJFmd8oSR6yES+hpE873fwuNAA2zypEDLpp19ILKmrKT9NQUBe+?=
 =?us-ascii?Q?ehprYupasbqEVdfpB4tWM2Jw5NVpb94KE+BiXS5MmqZnUaaetu1VPxYkEOGT?=
 =?us-ascii?Q?gSbO7zgxO3ez1szAt/RkyCnDabGlfy8f8pnwrIYoynKHehZ5hH5SbLeAd5o/?=
 =?us-ascii?Q?wGXntgTfYy1KUwzFapzhYI/4Lri7mP4iavEGsmjtw5x46cEsmiZd9to6LW/A?=
 =?us-ascii?Q?ZMF7nwlUf6JcqH6b3+lujRXpns1y0/+I5dG8hrRawYPxEjTiE30S+ODOf79S?=
 =?us-ascii?Q?5EvYfRbCCufv9wUiEMUtIVgtg6/+p8Ols2HwCqRxFxsmVwIsZKGmC8LJi2BK?=
 =?us-ascii?Q?uNLQqLXjz5TxFFWU3lRCwoAt+F+lIyyvYIrVVXu1ynHJDiZWfslElJkrHCz7?=
 =?us-ascii?Q?L1RumRekvmdcTvYf9HG/36v7b9ZEI9VYdidXF9K2LzMmiXcOheGzVARDzJlv?=
 =?us-ascii?Q?lp9CRSqbBAjhQMkmrb1dEt0Vp1gKbySuQPzhB24O8rxe4HAvZ9skpMWwfoJm?=
 =?us-ascii?Q?C8j0Lg3PvKb2l5NbwaKNj7s+V9HMYRMxTJfYMiCDE0+BGtQl3uj8bTdsfgeo?=
 =?us-ascii?Q?QoyJ18ho8NAUI7LOWdEt0kla+YWtJDraDuVaJ7XalhuM32ewIEa/5+sXEUiE?=
 =?us-ascii?Q?Wyk9MsHf4F6Letz1KJhbbIGhv0yIMSsvtvVYWQHELq8bfP8AInKZJ+fNlwf9?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HTPoC9X/kSO88uc5WUrbmW6rBFsnEOXcCy4v39f5NpD2dWSeRgI/PAS+Uvir9ElfnTtz6z3j+klp8/nAR0RGGBmPekQ2m0nuQ6iNf/1ompqAqfgN0GXSBm9B+Yy4GSOpN4S1O2vujlvdzhJ6o5T0Uj/9AVALMmhWp3lObg+DbqcSVzcfundYqnUQBGhMgSmTlfmRJki8lTfqFadeiEx7YsOdXSguRVphoXX6Kku73HjWZYO3nnvYfW9QcgN28xCCN+1u3OKBPoAW3u3GCjKsvLIXJHHyOGIiaC2INZ0afE0lXc+VI+8OKjuMjY99BqDhtvNPEb3cC+7u6cEWOqQIGxj2nMm/ZOox0JV0H8Mnz6l1LMb1ktJgJFa2Ok/z+/H8pTYFXHqyNVaxorDQ47nQX/u7krSC62CCfr4n5gFn4nCNsW2JaP8t+O9BRzCUKp5z7AYzpVsZ2hXyrZs8dnnnkKi0QrE0XTfgPKBP03vdA0T0XwQh0ajNls8xo8ypb/nAzLb5RFS9Uv8pMUxjycxXrZtNpHmNRXqawhuopqAc8kctalpGOB706D6oFqUTqnsoozgN9P0KeXjRbKBPOgBKsOZKZ+J8B/H1blgHVwfYZVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae4a4d4-b505-4fac-c358-08dd13f761c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 00:05:37.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJMZ9vMg83BGxndjn3MPhMPXIAu2yoT5r3El4WGnmtufvm1kl3Niyq4GrzIMC4TtrUQEtvc8RlAB/cXc27RRUAiUPfty08oJYADsTS3P1kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_12,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=946 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030199
X-Proofpoint-GUID: PftLGWToezr6VcrBhMrTJDYKnYvSEwyW
X-Proofpoint-ORIG-GUID: PftLGWToezr6VcrBhMrTJDYKnYvSEwyW


Mateusz Guzik <mjguzik@gmail.com> writes:

> On Mon, Dec 02, 2024 at 08:20:58PM +0000, Frank van der Linden wrote:
>> Fresh hugetlb pages are zeroed out when they are faulted in,
>> just like with all other page types. This can take up a good
>> amount of time for larger page sizes (e.g. around 40
>> milliseconds for a 1G page on a recent AMD-based system).
>>
>> This normally isn't a problem, since hugetlb pages are typically
>> mapped by the application for a long time, and the initial
>> delay when touching them isn't much of an issue.
>>
>> However, there are some use cases where a large number of hugetlb
>> pages are touched when an application (such as a VM backed by these
>> pages) starts. For 256 1G pages and 40ms per page, this would take
>> 10 seconds, a noticeable delay.
>
> The current huge page zeroing code is not that great to begin with.

Yeah definitely suboptimal. The current huge page zeroing code is
both slow and it trashes the cache while zeroing.

> There was a patchset posted some time ago to remedy at least some of it:
> https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@oracle.com/
>
> but it apparently fell through the cracks.

As Joao mentioned that got side tracked due to the preempt-lazy stuff.
Now that lazy is in, I plan to follow up on the zeroing work.

> Any games with "background zeroing" are notoriously crappy and I would
> argue one should exhaust other avenues before going there -- at the end
> of the day the cost of zeroing will have to get paid.

Yeah and the background zeroing has dual cost: the cost in CPU time plus
the indirect cost to other processes due to the trashing of L3 etc.

Ankur

