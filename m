Return-Path: <linux-kernel+bounces-439827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827099EB46E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C471659C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF221A9B3E;
	Tue, 10 Dec 2024 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LqfKaP2O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U2Ki3Iv1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC023DEBD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843732; cv=fail; b=c5V21nK3DBdTfy2f5Llx6LIGD+IddvUMKOUwQwHE6Uocengt26QZBypzEAouKfR4yg7kqOz2YdAtWqQTEllrvUb8M1drMeXo2iqTSAEtJ0NQfMz1kDTme9EKkwDNTvDDGgGc+3VkvB19n2OUZMNNzykS5gJMdhwlpirMfpXHBPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843732; c=relaxed/simple;
	bh=hE7dUFXPqZjZ3b+SmqGjOrYdZLgN0kRWtHjS284DyPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=meAF2hMDirxpKye4JSyELMvIIony8miE6BnuWcg2+Gy0SoEtCK8Iw1pHru0fgWcoXOEYG1OITgdiN01H/VfcLbDkRlWfXNO9FJS3IiWl8ryHd7gOdtEaHFPQYXyHbLLYGN2hbEqx2/CVImKRCOoDpF6RE6DWj2lnV0930MFg/2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LqfKaP2O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U2Ki3Iv1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACAtrC005416;
	Tue, 10 Dec 2024 15:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kgKX34TOIJnbeBGGox
	8cUGNmR5yiOO/5IzdGpx7pVVU=; b=LqfKaP2OSxKw1AKNY8UZ0VAkoQu82wLf77
	ceOsQLP0ayxULhiJ7M2LyLQHGcmsggx4tiIAS3tofBG5Suiey3hl2bj7rceKUvnh
	1TBa6DNPUT0BA+Zcjk6EbLu9RlIGb30Lpjc6ZJUyG6bQW36cqvFXU997ztynMSe0
	HXi9weuZ6AkK6l7rwj0kX6OLZnfzH3NNPoUeH3tHvXyRaN8gzWfZwz/Yx3Oah23l
	nsVDMAk+2nSNcxTN7pCe1zz1WkItEgcKZ1aAncW/WY5Kl2vNDvtAnGSXpER0NsdV
	0f8ZyaV2XPj/JPuK7leAZNNzFFIPiuxI78AbCW75xA0rSgTrNQcw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9ap2ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 15:15:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADcTIR008576;
	Tue, 10 Dec 2024 15:15:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8gfff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 15:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlDhFUh/fv/y8uGGm4rg5IpTk7aXMmiwA9y4Al5oCcphCaUXqGG9J0LSebWSOVvrlc5TRlk+ql3slL1Y3gzHrAhX1H8aLZa5F+Sbi4qSbnmjEHv7xH4Pauu9UfX3BV6RO+W3JTEwgCaP3YqOrVciESwnn2YpfMZZHsUfd+xYLd1tlU5X4izAg2tjSoBgAfDtov2hTRv4yzFeZMWeGP1uZaq+akZ8+8uMBP/z2VBCorP+BcJlj3Soc2oXkHCMEz+zswcU/Y7Zti8z6TI0pcnup86OdXbSUJQRL2IB73pBDrS5Fgef58AtxrZwbZtmPN6h+mKwbIJRaYbH/aIVUQr9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgKX34TOIJnbeBGGox8cUGNmR5yiOO/5IzdGpx7pVVU=;
 b=fuYX055ivmJllKtoRNOg7QPmrX0xXlIYV/cjsO/OB8Z1O0UJcJP2Vjl94qDikgqJl9nso4sscjWvdFu4lvHxvsQQS/jYbW7ceTG46J1xrFT04bG6mneUjPSPAlORjgEzDrhgABFx3+2hKspLWwfmjbxehCO4O61+EVRxsK7/NpMuZr2uMHFu/IsKVslyyyuCu1KhsbbmoM/wHDwzoKXtERCj4Rp5R4I1k4ehwEfogflzeDuhywF0qDQtGzA9gwbWjIqYSeMldkYWxej/Wr7eT/NrD8OfQt1FsKX5jYeDktkznuqGpazWCiBhhYN1ALtPz4vARUIxBeKv8B7vkGHH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgKX34TOIJnbeBGGox8cUGNmR5yiOO/5IzdGpx7pVVU=;
 b=U2Ki3Iv1aLRQDZzme8I6v1n8TRSplhS6fvsc3SW/M5XcHsapguAP7HuiDTZYcYe/rSHF+pU+jBSxSX8Lgg7pB96vDXgpWKqmQEXVtOb9z1aYHOqbEmKurz6bgBwmmdOLPdGONPAbnSU0fmhn7Mb3VrUuTasp8JxlOw3n3seo2CY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6130.namprd10.prod.outlook.com (2603:10b6:510:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 15:15:04 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 15:15:03 +0000
Date: Tue, 10 Dec 2024 15:15:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, mhiramat@kernel.org,
        peterz@infradead.org, Jann Horn <jannh@google.com>,
        syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <0b5f4e8c-14de-4b8c-974c-379640e82ce9@lucifer.local>
References: <4d05caee-d900-42e5-84e1-448cc62435b2@lucifer.local>
 <emgf7rbacg4jqsnyg2mgmlbbeehc34o33fpnkmlaghb3xynzjx@gmldlwjliwiv>
 <c946c9d2-aff3-4492-99d1-d50e6e2659f6@lucifer.local>
 <20241210150528.GA31266@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210150528.GA31266@redhat.com>
X-ClientProxiedBy: LO4P123CA0536.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8e87f7-805e-433a-959d-08dd192d6c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WUiiwDAlXkjbNnkBUiW9OKPfDfa9Pg4jMb/aQC4VkZbp2gHfnQ+6XGZFM+bC?=
 =?us-ascii?Q?5nil88FzpEU8/CzEnu8h0kNfnPkthYBQMOK9AV61ukYvYzVkNA960H0mAlqt?=
 =?us-ascii?Q?ioZAC64v/QBdtBwXTGqBPHAy8TfwTtUeaXr+vFSXUw9pR4CTbP9PzBpdUPWh?=
 =?us-ascii?Q?jOVOEKPyFtbKqkTEO8kWcToBKNXefPUVFwFXnnnAYjvyI5W7ik7jn3E1X0xm?=
 =?us-ascii?Q?Gesl98EDxzXnmFn0qWVraSwfjK/CbpouKLyWaJBRbdRqRmSYa5QR3Z0uyYp1?=
 =?us-ascii?Q?kyUVMeJG4RMY8ymQvlD/UvI4OWXRKOJAy1zr1cTv3U+AN/I61fjX5BiXOjRA?=
 =?us-ascii?Q?irfC3egWo1h1Hi/DTs2QM1SQMV5G6XphNNjQuSeENWTIw+Ab1b3zB+4+NONY?=
 =?us-ascii?Q?Tswd1W6U3oDlWcFsQLuzXKc4ufcO9lto1b4R4vQvtJ/16cxB9OR4cCf4Ltz1?=
 =?us-ascii?Q?tiZ6A/eVlkW5mPqgj9kDCHQi8yVVMbSP19ZT3v15HUlkl+I0T+WNM/B6GxYk?=
 =?us-ascii?Q?/iHeEcNumPV6xZ8THfenEMdSCAo+kTUdzQB/WPGlQD9RBMuZDleG8mZezRHZ?=
 =?us-ascii?Q?oycNl62Xpd1UZINBf2j0zweXgcQXfWmu081pUDX2Hd1mBubrCqlWTkPakBC/?=
 =?us-ascii?Q?Zps/aC1s8rFsFBhJ8mT+TcTHpI3ZnR0RhA0JNfL/jrTcWirVcs2Z1hNX50Z2?=
 =?us-ascii?Q?pbPh44thItW6idCc9rliwNHLiNZj2UunFEvrv0WUk7WItsFcsHDMah32wEpS?=
 =?us-ascii?Q?oX5/Q+6byYB+g49p2PMqv3Ed3HngEE/hgPovF8ztUT08fkqHNqkKX9xq+yF2?=
 =?us-ascii?Q?peTjlWqXNaNzHvw0b0yDFNuJVzltxT4e7HMOFgmw+7sdhN/P0WI5pa2wvx2l?=
 =?us-ascii?Q?nyYydfzaHVUA1Mk4h4f8hYZDKxJIdtjpXqLcQop1BQTOYCgmCwRY6Ve1197A?=
 =?us-ascii?Q?arn36tjM9M9wUGfUaSYjvCk1P5GAzaDr4yJ0UlUMGgjm9kDyFr0uEFVXBQil?=
 =?us-ascii?Q?6MUcMR7ghX3ForNysPnjxq+0As5Smeh5HxlXg01fqQgmkYFDexcmYaE2FG4K?=
 =?us-ascii?Q?nriCsl2G2brKBZGkeXKcz6vN0tcFg0RdCEnOlq9Rxm3X+h2Oiufu9rf+ZOER?=
 =?us-ascii?Q?9Qb6XTH9I4RLG6xpZMuMo+z57CMy3nY3GbAfK3uCnmNPoW6j835EB8612hJj?=
 =?us-ascii?Q?9WvfIpHfQe+Xv3FncU+RJ7d91j5ZyQHnQOHnYOK+oHp2cyFeRzw3uviWn4XJ?=
 =?us-ascii?Q?O//QYTLcWzIKVZrH3pCTLkl+LP90Ab9whI/ZwkSLVL12cO5GdLUxepF4UGGM?=
 =?us-ascii?Q?KCC20U4V3tsCcBYnvj3gJWyoydkF78whpyMhMtvZqPNANA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c/EgXp6h+qA8xc1uVO0y2aqgg5mrU9NFi7OUiyop7d0fI3/aAwxfdxItAtnD?=
 =?us-ascii?Q?yvzqwiM0/hiETONVzLkyZd2BkHa7lfTmMIIZ/r10dsSNA2DhOFz3xFZ0356D?=
 =?us-ascii?Q?whZcE7Oyr49VomTnXIq+hzPfsmO0fcmfcRtm4r+K4RmzY94nkjhqttLtSdW2?=
 =?us-ascii?Q?3mlx1eQnt6TA4YB9VTlfx4iMHXF1IoQCg0nbRZYm9oC424694ms61AOnUaI0?=
 =?us-ascii?Q?xaa7hTnoxSae9ai9X6R0UD6e2al102t5S+qg8MObW0u1w6Z/OCg39qKHlu8d?=
 =?us-ascii?Q?a6D12Qk+A4ks6RIfSZ490NsD4QGF52IA+ZRM1YrVJFcYZmCncQFQncWT2ULp?=
 =?us-ascii?Q?d4lVvzF3ZmJauENNobnSLuu6XPlI0l4pndrls+zC6V/GRbqpICVpmCvaN2Kw?=
 =?us-ascii?Q?soyzCaGG2R0X9pefNB3tk7IwxroY1QpoRWHiYT5Bgt+rkClNOxnI44wcQdzj?=
 =?us-ascii?Q?7D/YOyNZfu64dFzJSPId2yA9L/j5z+X0TCTuS6YP0Npxq49+PKwZxCtUtPjJ?=
 =?us-ascii?Q?KEJrHcLegW8TrWn3OySJUReMd52eV45pRg4VK5Ck3h0eJY4YcXApSo35dnqB?=
 =?us-ascii?Q?EhPvwab98FEPAb8A+IdFL5y/m+uyP98oDmXoOeOpnrGdvmidX5o3PmA8UIUm?=
 =?us-ascii?Q?33AHd99trGvlrqaOi0+P23aYj6Um30Jy8GwWk+7FXTa0KEn97eM9zBfTkTg2?=
 =?us-ascii?Q?yrYHHl/Yl/Vl5h4jvxUrGZSdGDXW1WF9RpgUowCMTVpeMKqJSbpLfnqkv/RE?=
 =?us-ascii?Q?YJ78GwqISfqXSd/UZ01vqXjeis5ANODi/WVA40gTehKEmA/81+Dc7z5Bylln?=
 =?us-ascii?Q?h+lpJprOHmRzC44UXZGQJATgVtbGcuBtPqPy2mtCcqsnIKbCBA49ZlTuK3fG?=
 =?us-ascii?Q?SiWVnvJyefpFR8TOXfRY1bm2A6WrAsehzfg4/Gbr3QtYrkSZNRh6prIvorsS?=
 =?us-ascii?Q?8+Du23W3gkNdGp/G2TLLwFogSW+GgOouVTb3rGVtqXMjFCjXEr69d3wX9RHa?=
 =?us-ascii?Q?qcgoJXQK9WxJNq+/uwa+PtKq4i0ut+TTFLWMtvCQhBtYGk9FYCfBGt4zibbh?=
 =?us-ascii?Q?CX6243GcmaVcE6Cpd5FouaFHQmxEy/F5KRRjtI12jav+LUKbOr7CMfKtHnBM?=
 =?us-ascii?Q?fUWi3fc46ScYFqoWbYfqUV5zO9m0x1QYpLV3TPIegcZzgTk2sZ8yuj9TKS3z?=
 =?us-ascii?Q?Oyv4WWbcNU4ZxdZg3sU591NtTvjDmV36AlEsieJVgszkn0lBNZrv8xoWAPBu?=
 =?us-ascii?Q?FaQTlCWkPmkNfyEieDyBkUVxqdF+rKUxZp2xQR8nZdKsKynpD0GLk0Un5yJE?=
 =?us-ascii?Q?73rgogB8ODZMZoREeOgljRjPZmUYHyNkBzVsEwsVN9MNtp3eODAXNXh9U0nc?=
 =?us-ascii?Q?u7/m2t9w4JgQ3jfTawv8O5CJ8MTfPGd7hDiKhin2962CY7o3Ye4DgllJv2Uz?=
 =?us-ascii?Q?zyXgGIQ9xVrNe2kN0hoO86nLhzoxvZsWebZAAM99ZjnLXN3XdpbxvbR2xzIo?=
 =?us-ascii?Q?zEKGmjVb69ODBjNZP4/lEw+sO8sYYfZw5fZwzwZXmJgAarRB94zE04r4wSTT?=
 =?us-ascii?Q?+5hWREstZMtKWJ6+ksWPb4AUJr2Zvd53tCn3IDsO3088Q6BjNo0EBcN1ccnx?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oVQTqbgUVS/D6R5y5Ju6824Cq5/V9BDATE3vDPrXS+1KesealvHn6fJfyrNdA5TKI+qheP1RJj4xhBisySyATdf94py9q2YMTJ2O6EapDiPYOMzsDpxsH3Cl58wAlo1/7jtb/WKQJ/sOqNNIOlELZqeI23f+j8xxhhu93xNmUuTE5boNXv9Q3H64SwTVDv6M+DYewNOdNCWCB0ND4skMRmCpLYVja6Y/rQoAWiSwSnKiEYToOoqsryk9WWoQat2lujZ3XPyX20dFhm1Xj0TdRMsaU7Y1Cjxpfcs/9kIH5Ar/No+1oWvUAXyZwU9JKy0xTnUYHIues1F5ZAeUSoznpP46eCBu/3V3tHSJNunIFpwjQkcEF7yQBgP7VHXHfJfs5XqgvnJ+yAkJc2pmHPeUouO9AnKJZm4jO62PnK+5uN21OKorvDCeRtlwtwO6QemUSKFVed2eusjg20BiI67JSzjKx+NAip9rNTCQV7vOzqR1KmisOVlKTCA1g/GVAJSKsPyKVr3RESCmwNi9EQzSy8IDvm6WtnjvPZLTZv1iYTH7hi3JzFLBF9G1BTBSTPVneM7PvBGEgy6Mg4UkRKr2DV9VBH6xpKA4BL2dBHHo39I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8e87f7-805e-433a-959d-08dd192d6c56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 15:15:03.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b93wrlBUVrnja4v5itnTYv+At4ZSQDB7/Gq6aN+i/J5ct9DEhHWLhi9fojNI4C6k5UzQA0fODm0DCyMHLw62LWNd/nNNqKqcCMha5I+L/Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_08,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100113
X-Proofpoint-GUID: 0jpFxXkFQhannHa6g_OajpoVhphc2JPc
X-Proofpoint-ORIG-GUID: 0jpFxXkFQhannHa6g_OajpoVhphc2JPc

On Tue, Dec 10, 2024 at 04:05:28PM +0100, Oleg Nesterov wrote:
> On 12/09, Lorenzo Stoakes wrote:
> >
> > (As discussed on IRC) how about moving up the dup_mmap_sem lock one level, we
> > can put the mm before the rmap lookup in build_map_info() is able to find it,
> > which should avoid the whole issue?
>
> Not sure I fully understand the problem, but so far I see nothing wrong in
> this idea. However,
>
> > @@ -1692,9 +1690,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> >  	if (!mm_init(mm, tsk, mm->user_ns))
> >  		goto fail_nomem;
> >
> > +	uprobe_start_dup_mmap();
> >  	err = dup_mmap(mm, oldmm);
> >  	if (err)
> >  		goto free_pt;
> > +	uprobe_end_dup_mmap();
>
> If try_module_get(mm->binfmt->module)) fails after that, dup_mm() does
> "goto free_pt;" and in this case ...
>
> > @@ -1709,6 +1709,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> >  	mm->binfmt = NULL;
> >  	mm_init_owner(mm, NULL);
> >  	mmput(mm);
> > +	uprobe_end_dup_mmap();
>
> ... we have the unbalanced uprobe_end_dup_mmap().

Right yeah we can obviously fix that, good spot though.

>
> Also. Perhaps we can change dup_mmap() to set MMF_XXX before uprobe_end_dup_mmap(),
>
> 	fail_uprobe_end:
> +		if (retval)
> +			set_bit(mm->flags, MMF_XXX);
> 		uprobe_end_dup_mmap();
> 		return retval;
>
> Then build_map_info() can check this flag. I guess we can reuse some of
> MMF_OOM_ bits? May be MMF_UNSTABLE...

Well this was my initial suggestion :) There is some concern as to how this will
interact with OOM however.

But I think my original suggestion, modified to fix the issue you rightly raise,
is a good proximate solution to keep thing simple.

>
> Oleg.
>

