Return-Path: <linux-kernel+bounces-407577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EEA9C6F69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4AFB24CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7034B1F80A7;
	Wed, 13 Nov 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BLo7hPYo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZvRvgp5y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C61DEFE0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501557; cv=fail; b=O5AwfAjIkqxO1y2VxncHuCEFkkVoMjwpaUceCAp1RYVKwoC+3ISLecq2+2iHP4jvmVpujTY4+QzsT/KhY251f+9HKzRm2gQaD/hF01XNfU19ALAH+r/ImMyBIznCWepmgUfhMlh4f9RzyPeaeSeH3Vg8wJyJHBMK2nnFk0KUn/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501557; c=relaxed/simple;
	bh=UEkF+US5koUemGThXZmhDUUnjt4esmVxqdYpsbEj8Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7DCxoFUxPKUK2tw/+u8CvqOCg+UzQdnaQPRqSNTSnPoALql4Im4G9+1opbkFSyZCC6+ojAsrIzzVhINqQSYvLzT/uXUV8hwXAEgn9XG75jvMWoE2nbP9ZW92biPvv28GZJupZJEWo1U5MzPpVoD4JHgUQkGiR9XwcslbVsoEFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BLo7hPYo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZvRvgp5y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD8c4MT015262;
	Wed, 13 Nov 2024 12:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=MquZVJY1wuWLn1glI5
	iCb3xbbtyNR15BAQTYq24ObSc=; b=BLo7hPYog5KuNHSdE98EsAAHOoysz3J6u6
	pwcG6uwiVUdEaqcADYd9jkhMduK14cyneWNeeW7mxdbwXRieJJX0KwwFs5PAGNLd
	oUbQQ+D7CZKWgcfj4P6ma7ukMUCeq6FXYTE6HU3oG9wkH2AxVC4fBQyEHkcFrpvA
	LtenpyrbqytOjR+JlXhxC6OSZsEyAcNMXqWawF9pCqVSB7DCPhRa4RfL1IhKUdLd
	mZ0wUwvJvS6UeXqUbinWMQddhGiV6eESUGPZAmOlP7Q0C5hUvklqLCy6LL4uj6jG
	tRtZGlHkjyJHtgHJ5SddAlK8fuMrNReXXfJIqhMMBjQL7gllw46A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbesxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 12:38:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADCAkdc022759;
	Wed, 13 Nov 2024 12:38:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuvyrx1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 12:38:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLvrbY2QK6x3jRALiuRBGx3T2Brq2oYV1lzt1VgRBam7fO1MYgIsVaDWiDkvOuP28FmETckJE/mUOLsRwKYTrDr6iomhK58b88aNYWdvU+RjaYvAw6QVElBParWcZDZF2VNJtlYQVzz9IQaSBDA+LY5HWd7jhO0mK/JMcFJj8r6N619e+SX1sMFh1rXdarwUoKMq1yQrR1Ti08UHBKoiLR0gbA/HnwYlbSqc5J68mdV1QtPB6DD5XzHoqEzzGMRzRD/vmyhJA9Y7jFsEhwuevLUgTG46a1uH3x0VP4L4iWNM20axQTgQhGJ/tUIQpWphhbjBA3V9Wz2yRA1kVvZmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MquZVJY1wuWLn1glI5iCb3xbbtyNR15BAQTYq24ObSc=;
 b=DE870x9BkQ37KNkoAm24SLPGgmAVzFwm6ggAcGIN9R6ikyKUbZSiHRugmzyNYHxgMtsKJcmPDcm54RUk8V3mU+UJVEk3luNj1jjKCEXeY9alM2G5Bxznc+A/HdlnNWQ/aM+KB6cOcMAZfB9LnTFHrfLTGiy6drjZONIMYP81nIvDdSEdhMNoUd9e6EiHVDZN43zm51c/Kj1dhPyMuNwXFenL1NG1e0hlykq/fr02qB310zTTZlgv4wtrpFeQVVF9guMclPrWdNoUbfFG0x1GrqDlVctjkyxjhAGmVb9Trk0J1+JX34yjWoTjzUv0nW7dXXhiMs3YljnTWsrW5F1jhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MquZVJY1wuWLn1glI5iCb3xbbtyNR15BAQTYq24ObSc=;
 b=ZvRvgp5yZiO2R8CvGLK2oKlgc6V2j5h3oj5PJhicEVGdAxbQaYsqd+YHxVv0/YR0RDRK5wQrT0P/UTQnKZhA+Exe+mTNSS4ny7BuTeVhqmcN63z3naJ/Khq92Ao0R0eOgf+gNejEWz9GTmvF5XdnuqxIg2XtPKugpFqX5ZjntVw=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by DS7PR10MB5902.namprd10.prod.outlook.com (2603:10b6:8:86::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.16; Wed, 13 Nov 2024 12:38:09 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 12:38:07 +0000
Date: Wed, 13 Nov 2024 07:38:02 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
        hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
        mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
        oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
        brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
        hughd@google.com, minchan@google.com, jannh@google.com,
        shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Message-ID: <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, willy@infradead.org, lorenzo.stoakes@oracle.com, mhocko@suse.com, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, oleg@redhat.com, 
	dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|DS7PR10MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: f14af0ca-46d6-4616-6e2a-08dd03e0063d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WgQ1J6qh7BDpwfu0L+tpciYpZroi/1PVkyGYhV4fBPPukagEmRC+pNNqGmQ3?=
 =?us-ascii?Q?THgFi/V5UhJhYBEvo0o0YaV4nKdeqPf4FCF4qKrCJXKlDWAwSPKS0Q/cU9/B?=
 =?us-ascii?Q?Jz32vXpN7Pau12aLzLxMxIKrbL5vVAnqLjX6wxzCt9rDIgclsgXHyzGhzVBT?=
 =?us-ascii?Q?gy7thSilDfzC1sKUMY9oetLWQV8ASn+8lzHkQ8yWIw/X3tV6OBYi1mlAH8WK?=
 =?us-ascii?Q?/IAZff8CxZ1Lo8fL5F+nryvg2FgrQ6yN+LReX6WQ6IZPw422lEjTCSddgC4J?=
 =?us-ascii?Q?3K808xzgMNdACxyuNfohiSYYwsTMoGTOC4B0GBOHJxfvF5dYjUs/bdM+i0Zp?=
 =?us-ascii?Q?qsHmhZnlCtsgKcwXiVxCrAxPFD3Fqy5MnKQFSaZZl4MwIJBx3o9ZZJwXPuWw?=
 =?us-ascii?Q?XKF/kxMBP6WtfAUswdVG9jqldRxyvjYBrkm0k9XYFXUvqG2YlF67u7x5sYZF?=
 =?us-ascii?Q?NJcD5ZD5se9rGCatROm6cmwAeG+hmXURTGbNO/FIEDDYzFpDHiDLzXW+PCfN?=
 =?us-ascii?Q?5rBjOZBR9/pijnLxxP6ZKO/IKfQ2H6Fq4pSYCBMpL4tEmD66GurQD4aZBeFa?=
 =?us-ascii?Q?3iqVW4XQjPlzx5sottHIzb8+kblUPNyg6oZeZ3XgYNmIT30XrO/5xlZ3GWat?=
 =?us-ascii?Q?9NN65a4RwoV3cIyug95EICN8ttZLKohjj/IY9t+CdimtTY8pWijYKTkHfffz?=
 =?us-ascii?Q?lohr5YM6dVKg+udp8s9ODSHEJWsuIZQPlOl8eRmFABKTuZI8IR28c4erDaHO?=
 =?us-ascii?Q?Z/HcITq6spZE9LwWftggh1pm1XUOnaUBmJCpUwX/gXtUzmPvjDWQxfcA/2it?=
 =?us-ascii?Q?GaoKa2CylADStb6VOGxBRiZJAvY1VcByGkk9cgMIdZjMAYjeOTCU+ZOxnfgu?=
 =?us-ascii?Q?iBALvDymcCOdeymY99s50HrxXcBL5yOquupFanAGJigrplKtii3mN+zm8DzX?=
 =?us-ascii?Q?maVxGClzhEkEbtHK4ebiOVg+JIGBLAcUdvcXzxhUwmUYKk3QVan785vltWGF?=
 =?us-ascii?Q?AtaSn/Yft2gmkrUz6Be8SDpLl4xMLGq5/dkGUHzLpLHULj3EeRtb7L3auCOU?=
 =?us-ascii?Q?APqbTkGaUI2uJYPLQ2BgqjgaFr+kgTz1gcX6wpbo5CkSqFFeJjHDivV4672K?=
 =?us-ascii?Q?WjW+SIyMGu9CPZLFYG0lB/u+3m9lVR/kZ0PyH/qO7f7VyHQpy/y/i6NAUOlf?=
 =?us-ascii?Q?DflfDTZoJ3gd1JCSTmBeuCUFeKhiSUIGmxp6WAEPQiu3F9oP+clSxRuiC/8D?=
 =?us-ascii?Q?mz30WAhtwxKwe16DUVkOSeO8JUwZyRx3oBrHm3GBdijWvXFvCA9Lyhtr/JGa?=
 =?us-ascii?Q?g5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uc7n7yQ8eu633qMhYi1/8ksp0yyLbyZaCS7WOpTUhbOlkckJwW2B0ECUEKp5?=
 =?us-ascii?Q?gh+ivhe+F9bDlBYBJibcL9ap2kw4yI7p7XpBcvxHUCbB9EWxmJq73gTRSeiT?=
 =?us-ascii?Q?VZRM83dk8dQNNKXDa/cOEEGIWV3Xe20ehXjm0GC0332aVENxY+n6/2kH71nW?=
 =?us-ascii?Q?wP8fGhQPyPHO0B798jeu5wZl1oVcV0cKP57WGNWlIP/Lo/K44mwv2aEKl3AX?=
 =?us-ascii?Q?0w6NljQ+eb6sNKVuvZLvnALGBk8e+ChGzX3skV8v/MNID3DVVSJNx8O9ISLD?=
 =?us-ascii?Q?j7fqRUM9mECeQ9hjFbq2ZK+9UmYLOjtPywXxrY05AWFkM431IfCKliN0m2LP?=
 =?us-ascii?Q?EtLz8kFlW8hSyY9ftWNmfJztsN3URfpDoXECzsgktMQdAjAZcgGDRIKL+hAb?=
 =?us-ascii?Q?qxI5YpevMGV1mWHSjEKCy4veORzEfJJw8qaJDdcqmw67zQX3at9ZiuUVgSnD?=
 =?us-ascii?Q?VK6mFiEjDO2lRViazQa9cJFai4kD149waFaXy/vjJFS7/XVu7OolLrk36mi9?=
 =?us-ascii?Q?TNj8wmqIoI5AdQbTCD4kxN0XrRrYqQ8UDOqGKEfhU56G24aVaNWTiMu0TqvQ?=
 =?us-ascii?Q?BztWl93vtN6fPGwqygZraVvqbK1g7Ix1weDHnDkJ41jqyXrJkOLR//5Pmgw/?=
 =?us-ascii?Q?pZfWW0KuNypIXvAL1aXXSOHlSYTgR+08rrgYPrPb9r/2UV9WsVKbdBSfV6Wm?=
 =?us-ascii?Q?/vfPsGRYmpfJRUm1SoZNXViEn9zdnNK3MMnbZWNZN0bfGxUryE4XaKdgX42h?=
 =?us-ascii?Q?JiBanezxL9gO4JplXS5R0insjATQM0+h+ONxZBtjyQh/bPEVW3ZOllsJASGj?=
 =?us-ascii?Q?pj4SGXMEmzbsRkrmxYMx8XjvlCqIU0vH6kq2Pz/rifVk6+dzP9Mj5oyd993D?=
 =?us-ascii?Q?uZD4Bz+mEEBwNxifskJECi8ikPOVRISKiw9VIUPZQ2R/Y1YaD9Kw0cTrnkDN?=
 =?us-ascii?Q?hKg35E2VMIc4iTG3w33Lcu4tARhMz2CsjrfNWyUEYLigyC9/ByyeNtCKaVAg?=
 =?us-ascii?Q?Wzt0zzIJEGW/GGUBCvTAvjfCAPxPNJS9IcCEpsh9AN49UPJ3ZJcama8lLD3f?=
 =?us-ascii?Q?v67W9fuNqsoNF0TDPgXOYrpZ2TxfLNl5YWl0LdqQSbrPM/ZmiCAqwEFIlBEY?=
 =?us-ascii?Q?Ay+W7UKm5LbV+HYsn3av5mP6H4Ju3DU6HRbmjJBjobZ1+SgSdXu171j7RF0h?=
 =?us-ascii?Q?F/FdbAzEtkZ49NpRYq4ux8nQ84lw0MqgZBgS+Ot+fMUoz70twpYa/lfEhalb?=
 =?us-ascii?Q?Z+griME1KBe6ECuMQiJw3vrRPxvsOZ5S7duBkpg8mI6fK5qfwUDdjGcM6BO9?=
 =?us-ascii?Q?SCbMx+eG6eczDpXAOF7UuVQ+nHF201/Lwb0T+8BfQ9tNaIQN5seKxIjLSDwH?=
 =?us-ascii?Q?OwSxj6k8vGZNw6f+cFFHi24NDfT/GWIFWIPjkK7ya+JsvjH/3QwosTRkKpSs?=
 =?us-ascii?Q?5gf5hB9NiVxw/ozDqy9Acz2I1mv5SrciR1p8bsXgUp9ANcxJctqkWVvm6HD/?=
 =?us-ascii?Q?Aq4KdAWWqUzHMHmTTDJirUN4Dobaz4Ne5NlySnTerTK1SavMjPGNgl+O0ziN?=
 =?us-ascii?Q?rs/Gq/CWJymFG0D1DX5zqLJLqZwYXtd9CeCqCoWB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+47V0oiYxbrB4O3UAABWvLsp/DXrMw0QoYThuHxNjTwLCuyaxYQIRvCgVako5v15yAEi0JIM5kvQ0korqP3NZqlmNyCSMxid0jIBKvMgPRcDmoD9pmkfBVaX1V+PouE+i5QhVvLccsH7BbCWm4QuTQGaip+uxRQSwiLChgA9RmvlvvZGeR4LrgxQ17q0hyn2kx3dM0egHThEHVS4Tt3T1YvF5L7rMfZZelBzbCZjzPWlyZOIF9TxlLlGlY8xJgq6rBqaRp5amBTZsUnQECP/S56Ecx2dPeJFjFaI/SugoPAKgrnEl3ijNHryYcsb5Hmaglg+PLJ4OgMO+pmyJzFPJvk5NTeLBU2YoUIjerUXgkdLxOA196jxfZd4MRDEk4xUxqPSIqt3hDLigWLTZcCKy7CiHiJcrY682NxCK1bocLU1ITdxdSWS98xMToAerAzmRrAEMz08wtLui3YZfkeMM6CYmNqQs0fyVHxYsDlrSe9+DsL8bqjKh8uH0x1jrG/CqIn+ixQPhviuwJ+N4RF/W+JcyLHSWe5NiklYYk/isigvTm/+QZCriJyEHXDiggzjCzWJe9T8mmlRP9pqIsOSAh0RQ9o7MGCoQTGWSWRaLnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14af0ca-46d6-4616-6e2a-08dd03e0063d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:38:07.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giaHDZOtmfWo6eX0AiXJ7tb5Id7ymwQYe3nG7IYTxfB058xasf6lxLfk5Yfxv0IRQEl7KbRPN3cSqbm49ti2uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=762 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130108
X-Proofpoint-GUID: Iamm8MTHADxNKvvjSD57veK15lPi8wId
X-Proofpoint-ORIG-GUID: Iamm8MTHADxNKvvjSD57veK15lPi8wId

* Vlastimil Babka <vbabka@suse.cz> [241113 03:58]:
> On 11/12/24 20:46, Suren Baghdasaryan wrote:
> > To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
> > object reuse before RCU grace period is over will be detected inside
> > lock_vma_under_rcu().
> > lock_vma_under_rcu() enters RCU read section, finds the vma at the
> > given address, locks the vma and checks if it got detached or remapped
> > to cover a different address range. These last checks are there
> > to ensure that the vma was not modified after we found it but before
> > locking it. Vma reuse introduces a possibility that in between those
> > events of finding and locking the vma, it can get detached, reused,
> > added into a tree and be marked as attached. Current checks will help
> > detecting cases when:
> > - vma was reused but not yet added into the tree (detached check)
> > - vma was reused at a different address range (address check)
> > If vma is covering a new address range which still includes the address
> > we were looking for, it's not a problem unless the reused vma was added
> > into a different address space. Therefore checking that vma->vm_mm is
> > still the same is the the only missing check to detect vma reuse.
> 
> Hi, I was wondering if we actually need the detached flag. Couldn't
> "detached" simply mean vma->vm_mm == NULL and we save 4 bytes? Do we ever
> need a vma that's detached but still has a mm pointer? I'd hope the places
> that set detached to false have the mm pointer around so it's not inconvenient.

I think the gate vmas ruin this plan.

