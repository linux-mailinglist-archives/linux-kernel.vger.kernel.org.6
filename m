Return-Path: <linux-kernel+bounces-412214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC139D054F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4314C1F232A5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08C41DAC9A;
	Sun, 17 Nov 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RylEKXX6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="juWQ2lv1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9826ACB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869424; cv=fail; b=jibVY6xTw3O25GI4+2hj3l3xMjEo9rwvV+gBEf5VcMfgPhksHFE9Bi/zJzvkJWFS+ER4I2rbxlTdPPH58RE5dce+cTEMcaSDdbawjzxZ7U8Pbn1lG95OxQa+/6spYbXJLVeK4WEoGXsXXGMWZ4LXm72KGH20azdUjuUv2HfYhfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869424; c=relaxed/simple;
	bh=a274sabRy7r5gmnf4416vwlyWjMJmxcN9YOQrVoi/c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZ5J/POoSrWSmZDnRcvK3SprUBuxBiVXYDEurKrFu9HxQPjfRYJ+yx3GTqbUmGh7ARD1CGjWNT6mp4TzGMG/j0ESfV+Q9w4I8iHRXEiSa2xpbo2sBI1p5Vs6i7JiaH2aG7qtA4eAN3F9Hx7Q22Fn7cgQL6YwYiCCEwIl3/s0psA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RylEKXX6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=juWQ2lv1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AHIo4Ko031393;
	Sun, 17 Nov 2024 18:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VNPBZRf6UYxongpNqk
	3KxHIFJRW0qEU8OH+CWV2EHzI=; b=RylEKXX6Yj4xWBs6oYdle8TPeGMAZ/w3ua
	HfByDC3dM2sIwbpwQCskHWPq9IQQGe5Kmn61TtPNIDf1BE7FXwsNTMlBiJprIa9a
	E+JYhEGa58Cz9rNsIDj2HDsanuEqrUZv945B+oSrBbLGzPqcKRkwoxz9plvUOObE
	FmpXuRQyTJMSpaJyd46a4j7XIBJR0xl6b2tyc05ty1eJXav3VfsgMNhgajhq82S3
	/gU53tZeLg1jVxlqBAiJmYB6gfpqz6URYRPZ8yEYjtlpKpyA8KQKFGBTTotE324y
	wfGcOPeAnicvikGExcF/kihmqMigvxU3JfdN2UGADmFhS2yxFwww==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa1khf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 18:50:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AHHBNLc007836;
	Sun, 17 Nov 2024 18:50:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6bced-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 18:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1SuUAfPfo6ec3Of6bp327YcS9Dwglacf/BT1ZjFVmdgIQf20k0KuaS3sb3yv65yqTbzBjWk6tVJwGm6N1z00JJbcwTCsauTQk0/0Zta81kLTBi/ghYZceSuMChHaslF1WvumZFxA4UbxbLOxXz+CqeSf43EbgqQMmGdDQEE/SfZ6ne86t1O90Rm1/9+j3l3M8YAR7r3P6xT8dZ1uhRp4HJlb7L5bMpDM6K1MmaidPT70XnY1WK1PXK6Kyc+dQDyabvv3rbj/yk9fAMKlREYqMS6ksXVSgbpMXvXOMufDsQf8UwqPoqGTvAznrnjdslxAi206nlJOOELOT8CEdXLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNPBZRf6UYxongpNqk3KxHIFJRW0qEU8OH+CWV2EHzI=;
 b=umn9V/z4oLACgeKhqrPv3nXCzWIgOe9wYdu1c84HPDAeEcbQ8M913lMa9kF+sZJmucPfeoXHU7qFW8j4Q9Qijqm1BZ3+iWCmjauexJHCBAYsBty153Es5eFAySKmWnOS/jJwED0cO7aCqExEIj9UkesjBcLZZwqRM4MqckdYtpy/lW4kK14Dorio7UuPEBJ4k2Jhh6IWtX++F6hbU2JTSG/Qo2Pchkqs2/kO+BmvFffOr5tPUT81vAm2ZDZ10Jq3thJytwRQSarcburGYpJ7yVUiGpv+yek87wCVSiB6tuoBtxWtmnNQlsgkillyxMqEO+zzWAvISQlNdY7ylrUEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNPBZRf6UYxongpNqk3KxHIFJRW0qEU8OH+CWV2EHzI=;
 b=juWQ2lv1/B+m+04STdViuh1UmtUsRqQDz29oGsS923ANvoo9WpnAkFKrl1IfGhF7ekg8dXt2swoxmmK0pMSelaqttUPT2njbOFf5NG84ldqtKwpS/wvPan9v2c1nKnpEYU394SsKgkFeQ1e5kpiWZ8ELzMEZjQUc8V1MqT0sqjM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB7915.namprd10.prod.outlook.com (2603:10b6:408:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Sun, 17 Nov
 2024 18:49:59 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Sun, 17 Nov 2024
 18:49:57 +0000
Date: Sun, 17 Nov 2024 18:49:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
Message-ID: <4842ef8c-bcf1-4cb8-942a-68591332c948@lucifer.local>
References: <6739c892.050a0220.e1c64.0013.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6739c892.050a0220.e1c64.0013.GAE@google.com>
X-ClientProxiedBy: LO4P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: c8391af0-5145-44e1-1369-08dd0738a1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BSsIfldZJ8Fztq2rCWJW+GDOhWRp5Xhy4FTIogoyORVE7ZYJksTjaPTyTEzb?=
 =?us-ascii?Q?dYLwvbT5n8GW/3/u8sDrnJ0+TdyinpxMYBZrtKkPdhYRsUvwrCRzSsECd5xA?=
 =?us-ascii?Q?zA5dRIITZaoZnG1UAa6ynAoQ6/S9OIcnjKdjupY38cvgYdQS68xWl6ofGxa3?=
 =?us-ascii?Q?Qi1DMUBKS2Aipjkuqq3BEJetpFtVe0ApiAOZdt4XcoBmiPSCLerzxZ8HLX8K?=
 =?us-ascii?Q?gjjLGEIhd8o67yRrxM3RTQ6cbZ7yllhmaWTa2r3eEY82SfKU09Cx3VikHpzY?=
 =?us-ascii?Q?bmGJ6KKc4O8PSRvUrtnkgYScQeC1dtoD0B/wHGHqZg7+73lEKlBPCl6mBLFo?=
 =?us-ascii?Q?/cj6gYZIRxfLUDaZma6wUDAZ6v3UwcfrIFqupVGn42AMN0VL8blKfcEGzVA4?=
 =?us-ascii?Q?ze8T4o7qyLULVu9yW0pGt30ane99kRyZ/qxaRwE5QwRAxYpWhu5MtNUhWnjQ?=
 =?us-ascii?Q?wxKeG51U5McQ4y2O/piASgJXBjt5jcRLIVAt6VTu1TA2wc203fhIJIj8K6p1?=
 =?us-ascii?Q?9+saoMo4/+GW4hpWrfP7Q6OmPbIzxeYJqG3gKIJJYJe4G3DKUr8Ce5KX/8nH?=
 =?us-ascii?Q?6RZlsII68dT92uCwY3HF+Tk0fBLd+WugACC3Dn9jLauUb2fX2lZFO9WSGSTR?=
 =?us-ascii?Q?+YhA5O8trdZaTRgiQxkypEaRxEZqJemie/V0KzTqWZoXh4pdCVZOsLTWc3OL?=
 =?us-ascii?Q?Gf6lhhmXjP5yKx6G//BQgp2+Ww1ufJmDTcbtuP+DDIMuW05d/M3g8XWMU0J1?=
 =?us-ascii?Q?93/xMQZobvuGr1oQevx/Aup9D8NRmd6IRPQcWtbPM/t49QknWGpzeqkpdt0f?=
 =?us-ascii?Q?Qftixv7izua9vE5ooyPgEQ53MBl6RQUAgTT1S5IyeJAI9ynu2yanDWHptCKj?=
 =?us-ascii?Q?o0LPGomKgH2oyfFFdelfP9m+Lyup140S5OuKX5JQv7VLfA0/gM+alUOD7Vxg?=
 =?us-ascii?Q?YpDXNz1JTRVvwZhXkMvUOgMiSuakG7HkuNXxARsXNuJfGqo/+bpodiCYwCds?=
 =?us-ascii?Q?8JEDFjtWUonx+hmj0GUc0qL2bjmGcM2LQTLuS5SfVGIHoE16bQlFTWmy5v+d?=
 =?us-ascii?Q?0PfDVGC5qvBxAUrWu63+An7FtLpLAhf4TGSAsLhEv+wjaE8bC8vg5B24d3Qg?=
 =?us-ascii?Q?jfiYtEB3Um7vj0hJyeLDMc/oHcRFF4LmPPeTZaHz5PPEtIqL7tYaDFdBtFh+?=
 =?us-ascii?Q?DmjtTFKPlCr1iLvz0too0j2UZNFemDuufNyAoL6/rj70MkLlAzTjG2TDRM+7?=
 =?us-ascii?Q?bTczwnXKZoJNGBUv6lA1gD+BzDvXMtoWqi9MgviuxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djCrlw6btQrIYMJC5sqHerx5jJiI3uD/2QIQEImP92jR4ZLLnMfLWdcY/pM2?=
 =?us-ascii?Q?Do/7+wL5zmyp+22tQgS+uWkuVSfA/2k1ZdE/4VCBrkHSGXz3uhkG+6JpkUo4?=
 =?us-ascii?Q?cp1IZrxIPsN3WeFQBsyJEE8YYWlgYvTawMefbBD01evIjX29Qaf2KreelcUg?=
 =?us-ascii?Q?1X9jqdWPuCa/htquMKItASGav/6PLTUPXPxKVzkM/QgRQKE9V7WCP/RP34x4?=
 =?us-ascii?Q?AhFjF1EMK0joacoY7mKcW8xK7MNDXdfkfS0tPwnKHtEo8O7x2m1+TiVO6zQ7?=
 =?us-ascii?Q?kL9kVfKoj45HH/XgRzpfTBOG3cYW6Hxr0MZqBfd5Zo7o3Q+xHUjOr+SaRAfb?=
 =?us-ascii?Q?zR1HaYANQhkTo4/sj4UgxEEEBQhC/wbEtehsseLpJ76R2BxdvTuGMpJ0B+m5?=
 =?us-ascii?Q?zmzDoniLew5iADKLGWvdin8JIYQeq4NvSj1r/cTDwMnv2bAq3Sv7V1PHQcuu?=
 =?us-ascii?Q?R0rWz7NQ5h2XQSvxjaytu+2CLQ23wGu17j6XopKe0gMi45Bt6l2kh+7bVeqU?=
 =?us-ascii?Q?oqngcgfMATIiIUVsMGM5H3QD7c3pQ66IRiJcHJiII1DjzWba3RMZHc5tOH0m?=
 =?us-ascii?Q?qRYZkUDyuPXA78CuCVyOQDvVu8Ik1hXK5H4H+polWTEtZQaoXqla2P6a9NOe?=
 =?us-ascii?Q?mv7gFq7d7dkdgFovK9RcmD4uql+ad6uGtRhiROPAAmxQ9yacqcsGSqs3ZhP0?=
 =?us-ascii?Q?/oWfZk1aCg4QTxiuCOylvxVo5PlriVRw4uhi0IdAD26OuG1lLeYsMHns6saq?=
 =?us-ascii?Q?Sd0KLVfhNATlDfjFK795OtRbwbSpBawld+7Fv7tgL7cyf8E1txpqmX30u/wV?=
 =?us-ascii?Q?Tgx/z0Iorj4YG1CfkXnFkWkaAl4ZYcJizF1xPf1V37jMzpfsVVTJcnSShXjL?=
 =?us-ascii?Q?0vORVdadeYun4mBZkVVBZu1hZOeJOpggg1WdTSvd2IGKUusv7Tk7h8sorJ3S?=
 =?us-ascii?Q?97JOc1JTauGoqmUM3kd6jPonwDEeUWdW+LdusNJhmRwuu+XUKTYofSBwYadK?=
 =?us-ascii?Q?DmgJ7UCFJTYJQ5KlUbNANPMZeGAWQiHKHfdSPepfUKJkaU85xIu2TE+R6htl?=
 =?us-ascii?Q?tNa0Sp1+Hgle8M/C6bb2aCLQL/BA0K16psPNFvpM8lbkN4OIsCDiGs/hMcna?=
 =?us-ascii?Q?D9LFEb7P7vmSV3q7autEhfcQSKskwLv56NNpITr78c6jqNz/BiUlvpiMAwO0?=
 =?us-ascii?Q?8GYkZueJh2jOTSNNEJODVDEpJ4U55CW0mxFaQ2v+e01q8t5HWaukGq82PGep?=
 =?us-ascii?Q?6n86AsZP7HZbmmYMyc7smkGjw8KmbiEb58SS1Q2wTGrLgSOb1/DNQVTJn/Om?=
 =?us-ascii?Q?X6M6AokyItZFSeripw57vQlX2O0kOg7PB1hXQnC+XfFVoLzk8uOKWyuaQxKc?=
 =?us-ascii?Q?QQVmAmzQPyi97bwCHP22HOVW/gV/qBXlER5xvRJL0zNZbYDqDNDnLP66PBQI?=
 =?us-ascii?Q?EUiW2pFy+TUsbyjyDOB6v9TFWJ/UMsD1RUBbaRQdhH2VXJfz8eVZ0eojyEMe?=
 =?us-ascii?Q?ypvHa2NT39vGPVGVMAwTjKcxBSTbzlQ9MdH6q7WjVx4A8JULDsXFsBufaSkd?=
 =?us-ascii?Q?GlX9rzU/nYBQJVK0EDMpKfMusadpMQz6R0m/D0yzxyjGjuA7ZmtrppwSfQeH?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K5aiBuXFheJ0byd+9WbpaPEdFr/tdSV4FzXC4OipNPjq9eHW0hMSi5X2HZ32ZZ9vBD6779BGROCEPcQ7gZdLV1hRrlNsh94QpEkW0JjP63pwCbBNsSCSPelyqRtvuvz8Kp4S7hs6/Zs0eZCe/XkPRdLkchKxvaw517NIVgW4qS7WOT8dsdCZKOG+oI2YR/KU+MrcsNbH4P5FFzJ7MJXd8zwLLuXfp2uKp8GB/lhWiATsOaBwPqA36AsxS5m8W88n1+A9PlAyKWXt8Gz2BJGaDdo+50baR8SbCEPgTtEvOZpBwN+ZSaikJ7X9vuLMr/gk4eJWcGhVdICdaABn33vZRiJC577JXHtPddp2kbiYS7bbcugkcCNfcLrXOQeCJqGJt+/YSMTQ648FSWLfpdLqZibYft5uNp2NhXOMLN8saZz74zLu/2uux2sbTCRbtvhB9mSoFHqZ+aEvWuFR+VJO7GAXPpdk40j6ylfSeN72J0ryh2RXxc4RcGD+IZyEdPhRpA9EMUTVOG7bkdlA2fB88xzCdIxguhSVCC4AmA9j5GvZxlxZ2MvSJ1p64nbXLb0YlIcOGFKKRQrVxA2R4iZIzD/fJkfyWANXJ4tGVoHapO4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8391af0-5145-44e1-1369-08dd0738a1b6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 18:49:57.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqAnzZeI5E/2GCGxU/P9KL1LrdfcAttaZ1JEKkWBJgny7dxYz1ZmwBboEdh+Bt1pL22/1FmdyrTDeCYfOfz4ZTUnPuX/OD76eUKN6ls+nTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_16,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411170169
X-Proofpoint-ORIG-GUID: 5JWvzZlkFNaE7XfHOPF44SlKSldHrOVN
X-Proofpoint-GUID: 5JWvzZlkFNaE7XfHOPF44SlKSldHrOVN

On Sun, Nov 17, 2024 at 02:42:26AM -0800, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8e9a54d7181b Merge remote-tracking branch 'iommu/arm/smmu'..

Will take a look properly tomorrow, but this commit doesn't exist in the
tree any more.

Let's try this again in the actual existing branch...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci

> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a1eb85a42cb8ccec
> dashboard link: https://syzkaller.appspot.com/bug?extid=bc6bfc25a68b7a020ee1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147521a7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102e14c0580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ad658fb4d0a2/disk-8e9a54d7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1b7754fa8c67/vmlinux-8e9a54d7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/50315382fefb/Image-8e9a54d7.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
>
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> Unable to handle kernel paging request at virtual address dfff800000000001
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [dfff800000000001] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 6421 Comm: syz-executor374 Not tainted 6.12.0-rc7-syzkaller-g8e9a54d7181b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mt_slot_locked lib/maple_tree.c:795 [inline]
> pc : mas_slot_locked lib/maple_tree.c:808 [inline]
> pc : mas_store_prealloc+0x870/0x1068 lib/maple_tree.c:5514
> lr : mt_slot_locked lib/maple_tree.c:795 [inline]
> lr : mas_slot_locked lib/maple_tree.c:808 [inline]
> lr : mas_store_prealloc+0x778/0x1068 lib/maple_tree.c:5514
> sp : ffff8000a3e57440
> x29: ffff8000a3e57560 x28: ffff8000a3e574c0 x27: dfff800000000000
> x26: ffff7000147cae94 x25: 0000000000000008 x24: 0000000000000000
> x23: 0000000000000008 x22: ffff0000daed1040 x21: 0000000000000008
> x20: ffff8000a3e578e0 x19: 0000000000000000 x18: 0000000000000008
> x17: 0000000000000000 x16: ffff800080585ea8 x15: 0000000000000009
> x14: 1ffff000147cae99 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7000147caea2 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000001
> x5 : ffff8000a3e565f8 x4 : 0000000000000008 x3 : ffff80008b4208f0
> x2 : ffffffffffffffc0 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>  mt_slot_locked lib/maple_tree.c:795 [inline] (P)
>  mas_slot_locked lib/maple_tree.c:808 [inline] (P)
>  mas_store_prealloc+0x870/0x1068 lib/maple_tree.c:5514 (P)
>  mt_slot_locked lib/maple_tree.c:795 [inline] (L)
>  mas_slot_locked lib/maple_tree.c:808 [inline] (L)
>  mas_store_prealloc+0x778/0x1068 lib/maple_tree.c:5514 (L)
>  vma_iter_store+0x2e8/0x81c mm/vma.h:476
>  __mmap_region mm/mmap.c:1513 [inline]
>  mmap_region+0x1650/0x1d44 mm/mmap.c:1603
>  do_mmap+0x8c4/0xfac mm/mmap.c:496
>  vm_mmap_pgoff+0x1a0/0x38c mm/util.c:588
>  ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:542
>  __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
>  __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
>  __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> Code: 393b2668 972c43de 8b180ef5 d343fea8 (387b6908)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	393b2668 	strb	w8, [x19, #3785]
>    4:	972c43de 	bl	0xfffffffffcb10f7c
>    8:	8b180ef5 	add	x21, x23, x24, lsl #3
>    c:	d343fea8 	lsr	x8, x21, #3
> * 10:	387b6908 	ldrb	w8, [x8, x27] <-- trapping instruction
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

