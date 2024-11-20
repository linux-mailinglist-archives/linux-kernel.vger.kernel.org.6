Return-Path: <linux-kernel+bounces-416257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA9A9D4293
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4F2B23DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869041BE23C;
	Wed, 20 Nov 2024 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DX1CUULr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JXugZG/V"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E91A9B45;
	Wed, 20 Nov 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130984; cv=fail; b=h0t2sl5bJFubilgWIIvmrvZluU62gOIRqDGwpubFUKyQiOFfESELSQVK30aRU15Y3lxQ6pGsN66AizZwTCVRipbyBJEBgLw8RErlzGpH7Yx4KzSR5Owt42uvvYySdBvwhUCxTRqeTYf4R2Aa1pCTXqhNfbWfavhQ5RhvEVhjBg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130984; c=relaxed/simple;
	bh=d/asw42qMxHg+bgVnDIknfmLN5xYJB4LAGCihjkB73I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=na9+/SkKyFlO4nix5S+Eo8JMqMpVEDYRFqt7tEsz9DHGgzCqPE3F3AeX+YVi8OdcayavUjomzbIHBvrD8oytA6AXZz9LxUZ+1jnQbVxXBjucAl8VuLw7ajdOtr1bU3vhv9hVQadASmHs9OlTp3xVMwVKUapI6c2RlH0Llt11Tns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DX1CUULr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JXugZG/V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFta2E011539;
	Wed, 20 Nov 2024 19:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=gvSEdiwIvzHzoFr7et
	uFZFI9xSnx0oaxgZ2VRocARi4=; b=DX1CUULrhJM/KCMNF963muNfAdtKtS8KmO
	05uRAofbDdG0xIvhjeoEECZK/McP6cpJ+RhN/URDlHVAQ7BCKxwsgo7VPG3NVRYc
	PPpqOwMXrSqKBNl33gVPImHiJ/rgE4SNhZHoKgoTApdZNusBYeXXhzVZAGbtZEMm
	IY6cAEIF08fj0czGpRaqg2Pk/7Ce2MGf+MOrAqs1hlDSvcSHEkgqtVo0iH5f1E1/
	OaHsMroyNJWq/O/nnpG46t9XZveKviSd/oQW92XG329SM68YdJJ2Atb61EqexocB
	UtCZ4uM201i519x6X4P2XkAtTioORZ0NBFJyU6Uy9Ddo9sHlf+Ww==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa85ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 19:29:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKIuGie008968;
	Wed, 20 Nov 2024 19:29:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuarq1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 19:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOvbvVxEtIErkjk8VLa1ajshDq14W/ycliN8Gf/NkQhvcDRwAX24hI2QuYJdj0r2kZFHG2pS18qRWM/O2pX//Hc/eg9sLGucYjqvkONMe2NKOFwaUPO6Y09opGDB+HDWKDBnM9DzT2GGJQ9vdfxlXfiZ2ELbycfg6kjm9TzrMhvMR/8d5q76EWDAb+BvP16ylkvYQBVxmXvqjZL+kM17Bakjgr2xRLB+oFsKsl1XSRfYik7BFAtLRBIn+TruFmX5/VXXjsK6xb8bvcGYrmibG4wcx1ic8ENzmOu0d6ML5OOxhPXz72zOUAmMM2h6lWMvadYwy7hhZaAH1XsmPQmgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvSEdiwIvzHzoFr7etuFZFI9xSnx0oaxgZ2VRocARi4=;
 b=avXXFg9A2jt1uEoRpxSV5EXdeyN7VGxs//dazl2QL6QAKU6zJ7AxLEiAwNsTNGOerkcxHjw028M34yj9AqllOe2gKa0XZlJS0WxiGnz7Qg/eZ66rXuHiMgKd6JlgvVm8PNymudwA5SMwAW14wKgLIcCUVtJ6dzEkMzSmcPwn8M8VSfPV13xtQiUjD7kDAnA9Wyzx5bYuLPc4HLuDYg5jQwPt6bxXv2GWlIUpx8gF1/ehW/U8bw02ZziTWupFEkObFRZMAdGNmE4V8qUSb3B7uB6xPTBrCy3KAeoh+dGjTObJksNBnJa0LukO58rfnwZndLeKxmhfOdzPuD+TAd8fbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvSEdiwIvzHzoFr7etuFZFI9xSnx0oaxgZ2VRocARi4=;
 b=JXugZG/VSwPVrkyFC4tqy+XKi1bGgEUY9WM5hzLaObSA2JguXHw3Ixx+rl6tJtNJNloKK69QR/W7VB0NPpY9Z6IUSaUjBRLc5lPxtyZM6yBxEk5Hf34kSU0GF8LEPxpkZnv2Mlmn6en4iMyU1zm5HTnDUgKDBpvKXteAVx/SyeI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB7476.namprd10.prod.outlook.com (2603:10b6:8:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 19:29:12 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 19:29:12 +0000
Date: Wed, 20 Nov 2024 19:29:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 4/7] mm: rust: add lock_vma_under_rcu
Message-ID: <40be19b0-4c32-4554-a01f-649c12f889da@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-4-eb31425da66b@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-vma-v8-4-eb31425da66b@google.com>
X-ClientProxiedBy: LO3P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 311297f1-58e0-4959-10e1-08dd09999ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8phU4iZT3U+PnbFjRxr/HyRamaJHbcw8DFeIOqLCCqpBXxJZnz/kNbm2VQ6A?=
 =?us-ascii?Q?xFRm3fARglOw8SQdJKyfnDzCpCS+HYO6ttQ270kXt1eupmhJZpnpLVU9kGW+?=
 =?us-ascii?Q?PexjkADj5A9HDxz69RV6nspdNqG6WRP0G0oQwMtDFc+yT8aLXx06mCCJ8zCw?=
 =?us-ascii?Q?jt9OqMFNctUaBaESvGNUhO4K25NZdQlA2Qi9FU8lMhc5AxH8fM5CVkR6p6II?=
 =?us-ascii?Q?eoE42kxty8ZWVnI5yPlQXEiUGS+9UBMn/G030q4rqe+Cs+YgWc71otY1TrT5?=
 =?us-ascii?Q?y+agrn5ukcP5hmcgTLl83ddFo9FCKfOF4QS8R2gfWqP0q+juk3i2kvcIgb46?=
 =?us-ascii?Q?mg0oYlnAnVptHAD4089Tfb5I5DSY5frTomkxWdt41NfsVQlw959Vdiaj7ELd?=
 =?us-ascii?Q?URLMumA3IpX7xbdfAxqoPOrsotWSzNkmafAI4Bu4pHFYfL9sK+bqVfis4ID/?=
 =?us-ascii?Q?WghnRCSa6umZMX4uVnwPCE51uPi3KAdQ4GgxXcB2AGjLqxEvKHO4Th7Fcnjl?=
 =?us-ascii?Q?4xNPnCUnzwZgwEJATVpiN/GnkYet3fEbx02uXyUIJztDLN8W0dVDACzW5dkY?=
 =?us-ascii?Q?FtEkBbDAIK/Rr7Q6eVTjKPxWCF6c1ixuIGhZVaUgPjQ2+oqGJWZS4+wfDppc?=
 =?us-ascii?Q?3x7v7m1AdxHswTZDaQTL3xZr6OgRTJwuvc050+e4YYdBoHjhhCRWF72weLSJ?=
 =?us-ascii?Q?wptxmFbaJXjRnWZVWcZUAiC1AMnISpmVgZyUQ54r/2F3c3VVcFwO/MvOqYoU?=
 =?us-ascii?Q?XjbYRrxqNlZ85GHBNnIYG5SLGxUuEoURZuwdwP2HpoIwuhEDWEajUD9xnr16?=
 =?us-ascii?Q?84bKGTGwTl18okvQDJCUagT8V6m7dpYjrnBlejUlnHnoy9DFmjd9tuiOdRIU?=
 =?us-ascii?Q?VS97sYAogFYwKZtp885dOX1Wp9sYHYAcui+cjHm/L5BCXDv31Wqaa2EDgXDK?=
 =?us-ascii?Q?pUc/sBf2WRPDJNkn6sxNZSAukOLBwK1w0c/t1EhcyQQFw8WRr2Vr4PCAwlCS?=
 =?us-ascii?Q?a8xzmfqlg/hUo3zStCoBXxWlPjBtP+N6pyvFgxBKNsRnRsXk42Xd9ssdEgWY?=
 =?us-ascii?Q?Zlw43mEbDuHUJ7TEQK2ILKaTQZCWHqBaklcLal1q/dLuy1ui/z8KbtrkM5kY?=
 =?us-ascii?Q?m2+IYTdreIFvn/DLCAXkNTHJ2TogMBYfJYsNmSBc5shbGBunvrJBZYKB+u47?=
 =?us-ascii?Q?+F09OEBpKpAK+PEKAM8xehze7EWK5PJV1yMoT1hAn/srESRqVbNtrypxVzXH?=
 =?us-ascii?Q?z2S9NDc4y19YXWWzq7I6GXQOjIZYabfiTsTq479Eat5rqzKCB1dSiOB+T5Jg?=
 =?us-ascii?Q?J2lmrOHs9N5DGCPwOdFMt1i0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ON33S215Y5Gb2WSFFcPJImLIqo5B15pvTB2LZ2p8xvlsslS7sHU/XBvGfg3?=
 =?us-ascii?Q?drCgYugCy/19yYHoXzSAvSsb0UJV5v/VPiC5LUlShiEmR0AIZ0DboAZzOg9u?=
 =?us-ascii?Q?cW0nCXlq7ZcRrz6Wjb4NYX8gk2JVLIsONrWCT5b3G85ZY7Cvy5VSzd7laaZu?=
 =?us-ascii?Q?ElmqurrxFwcUqI1svmqz49S/t/QXPqwsrGaJYUsdJYq6tlEf/CQz/YQBlMv7?=
 =?us-ascii?Q?WU242Z9MgVhIQgEwa5M/E++kN9czxeM1Vcg5aNpg5gGMd4dvSCXin53RRQnv?=
 =?us-ascii?Q?DTLMumGpzPYgj46g7eqe3IJNyzM0+N6panWLd6y5VtPpi1Lo6paZDWEEAFBX?=
 =?us-ascii?Q?7rxmLTTJNE9pG4YBUJCUBySzZ2n+dyiwC/oiKmZulhHS4rEAaddRYImugpMm?=
 =?us-ascii?Q?JeOLaaG9EN5cu8jI8VmDmVL1tNlW3uKEm+12OY3KUG8JVW9EzZc0ARsOk446?=
 =?us-ascii?Q?Cj13MUd1i9BkTPjdiLTg+KHb1NPk517jFDFirveDTkc9Gl7NOWkcoBQKEuEU?=
 =?us-ascii?Q?JH53c60EgugM5d+47hSwNBn8Vl/7bM3iT49guzkyezszXk5FlEFsar/ZJpkE?=
 =?us-ascii?Q?JpELQCkQ6y99Zo2Jkar6Y7wAdswpT6dEU0Vn3hTnKBJs+MCQhCq+DLtIM6xw?=
 =?us-ascii?Q?epHdA8+pSIw93a8bVhUaDowIS5qGYWViE/QvmD3RXjvBlJDhOLdohhijtCoK?=
 =?us-ascii?Q?hIJNQSyh0oW1WhkGyDYOTBbsy6aRJJD50XGHgQX4kIJV7zdLvLX2o6aHqpoD?=
 =?us-ascii?Q?xOHepgJVn8B83kzPcDgAVhEvLQe6uc2IatWhyjjN2nxRAhQuHi4pigWw36sx?=
 =?us-ascii?Q?BUnJM0CQDxBtOtIkHSwAll9QY84I3n8dKDM5OUk9C8I5uOUCfe3pUtEZbE+6?=
 =?us-ascii?Q?dKh1Lzc1xOYaYkSaorSSnTTG4AG39deJgXAKo9iV4PkN5z4N+qeRXMXVsjB/?=
 =?us-ascii?Q?cqIA3IEwoCRkRW9fi/8IzIgn8oJBvTYjHb89NSeVj2CG44I3wvlK5vB3d9lr?=
 =?us-ascii?Q?sGoihErcJ4HaDxvk4JQQGL+1CKygQYCrMWpk1uqt+PVJ3rWmEagyq3k+xvlt?=
 =?us-ascii?Q?5t9iOUmeDX/wWEyMJB7x6xIcLgFrcMd7wWyNSnHnpchRJ0S3nBoFKC6w30js?=
 =?us-ascii?Q?YM7WQ7x7gaCejjBttacOCK2y76l7Ybv0lws1kkdy1peILGQ6VZ+9Fune3QnD?=
 =?us-ascii?Q?sbR/PB9Ba2MUyRgryoa4ZdCLR6VvfJMs3/wA2s8EiWJjZudg82N0+eucK/rN?=
 =?us-ascii?Q?jrKwAkABSl5cRgXFCbqfVVg06voqJOX5BVoJAvejYG57l1eJ6vK42H+eXnXe?=
 =?us-ascii?Q?WyjbKMv1BGvn9Mot1OSPjU1z3aUKemnoGJHIVelSEB5YzA+ZlJBxJgiDGHqd?=
 =?us-ascii?Q?om9sHLhrZKChpa4wQbEzzED9vBoQba7toEfg9xZXg0JD4YaCn1mnLCgfn37i?=
 =?us-ascii?Q?zxLwyGR9x9IjPDsBDc6sz3lmJ+6kb5+mcoIHcHQ/Fs1rOAvoG1Z14rh2TYQY?=
 =?us-ascii?Q?seM2XjpIEjD8NuD67sQF8AbYDyhlWMln8CHzX7KuU8jpnrL9HnigSE9DHINV?=
 =?us-ascii?Q?k4Be6Xst4EWyJHC1M1BYVS5O10+PNThAYzZffTo2pTtj2DqgGA+Zy3slPJyI?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NT5Gr8ADDhZerkFlURimsoDARzUYDccMLpdfWRyEFP/zq7n/U6t2KIxWpEHPrbAGhkrToN5bbVMY158pqRtB5S7w1ZHKBAYp/t+3FLkcAFjnrJEHkBAbDw2PI2w9VOisqDDoX5/TAZ3wUtvtPSEs2/20vpkBoA2WQ9TCkCrDdXR6/x9LHLbSLW71I7Y0MqDUJLoB4/16RowI8n6mijPYdhjbh7D0JYsnjcBM1khsXyW7WGpmCAL/VFJ8qSVQ2X7IbeBbAGBM9QZt9MZOPDXZoWFg+UED9icW0i1TbE5wCLxDmx5STQbJxa4UKBvThMHbyEPVV10yxa9dn2EGTY/+j/Ajp/DE4uOoOQ/An+WMvvqd6iJcG38PoHt4Gc7Fv+eHeWVQgGkr9ORb9aAeSO+SKdxqOvwpN6QYEX/Cndn+wzmFFcxYsrOOgab9NV7xGFLTFLL07WBaoWwm+WEmR12O5ZoQZSccNqO0/rw+ZrM1TtuMtwEH46wuheNh9fkgd/vykPr8zbhAJYKUzd4TnSMHhksuw7RncLJXn9IAKPpBbGa5wptfdpfr61xBmpGw6pHRkpxyapAexR2xWniOFQ3IyLvEOeJt6pT3kmXwHA7jBUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311297f1-58e0-4959-10e1-08dd09999ce4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:29:12.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voIS/ruhfgIx4ySIBXWh+JqZCj21Qjp8hq+VnoKkyqVnzRIgnJ3Jr+zd7vzK15A4Ptkd1uiq8Tr/TOew9MAXG1XPHQesbMz6aNR1b8yFy6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_16,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411200136
X-Proofpoint-ORIG-GUID: -vV0ozzSq4Zto9WrLoTUHJSntvfbuvqd
X-Proofpoint-GUID: -vV0ozzSq4Zto9WrLoTUHJSntvfbuvqd

On Wed, Nov 20, 2024 at 02:49:58PM +0000, Alice Ryhl wrote:
> All of Rust Binder's existing calls to `vm_insert_page` could be
> optimized to first attempt to use `lock_vma_under_rcu`. This patch
> provides an abstraction to enable that.

I think there should be a blurb about what the VMA locks are, how they avoid
contention on the mmap read lock etc. before talking about a use case (though
it's useful to mention the motivating reason!)

>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers/mm.c |  5 +++++
>  rust/kernel/mm.rs | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> index 7b72eb065a3e..81b510c96fd2 100644
> --- a/rust/helpers/mm.c
> +++ b/rust/helpers/mm.c
> @@ -43,3 +43,8 @@ struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
>  {
>  	return vma_lookup(mm, addr);
>  }
> +
> +void rust_helper_vma_end_read(struct vm_area_struct *vma)
> +{
> +	vma_end_read(vma);
> +}
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index ace8e7d57afe..a15acb546f68 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -13,6 +13,7 @@
>  use core::{ops::Deref, ptr::NonNull};
>
>  pub mod virt;
> +use virt::VmAreaRef;
>
>  /// A wrapper for the kernel's `struct mm_struct`.
>  ///
> @@ -170,6 +171,32 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
>          unsafe { &*ptr.cast() }
>      }
>
> +    /// Try to lock the vma read lock under rcu.

This reads oddly, I'd say 'try to acquire the VMA read lock'. It's not really
necessary to mention RCU here I'd say, as while lock_vma_under_rcu() acquires
the RCU lock in order to try to get the VMA read lock, it releases it afterwards
and you hold the VMA read luck until you are done with it and don't need to hold
an RCU lock.

A reader might otherwise be confused and think an RCU read lock is required to
be held throughout too which isn't the case (this is maybe a critique of the
name of the function too, sorry Suren :P).

> +    ///
> +    /// If this operation fails, the vma may still exist. In that case, you should take the mmap
> +    /// read lock and try to use `vma_lookup` instead.

This also reads oddly, you're more likely (assuming you are not arbitrarily
trying to acquire a lock on an address likely to be unmapped soon) to have
failed due to lock contention.

So I'd say 'this is an optimistic try lock operation, so it may fail, in which
case you should fall back to taking the mmap read lock'.

I'm not sure it's necessary to reference vma_lookup() either, especially as in
future versions of this code we might want to use a VMA iterator instead.

> +    ///
> +    /// When per-vma locks are disabled, this always returns `None`.
> +    #[inline]
> +    pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaReadGuard<'_>> {

Ah I love having lock guards available... Something I miss from C++ :>)

> +        #[cfg(CONFIG_PER_VMA_LOCK)]

Ah interesting, so we have an abstraction for kernel config operations!

> +        {
> +            // SAFETY: Calling `bindings::lock_vma_under_rcu` is always okay given an mm where
> +            // `mm_users` is non-zero.
> +            let vma = unsafe { bindings::lock_vma_under_rcu(self.as_raw(), vma_addr as _) };
> +            if !vma.is_null() {
> +                return Some(VmaReadGuard {
> +                    // SAFETY: If `lock_vma_under_rcu` returns a non-null ptr, then it points at a
> +                    // valid vma. The vma is stable for as long as the vma read lock is held.
> +                    vma: unsafe { VmAreaRef::from_raw(vma) },
> +                    _nts: NotThreadSafe,
> +                });
> +            }
> +        }
> +
> +        None
> +    }
> +
>      /// Lock the mmap read lock.
>      #[inline]
>      pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
> @@ -238,3 +265,32 @@ fn drop(&mut self) {
>          unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
>      }
>  }
> +
> +/// A guard for the vma read lock.
> +///
> +/// # Invariants
> +///
> +/// This `VmaReadGuard` guard owns the vma read lock.
> +pub struct VmaReadGuard<'a> {
> +    vma: &'a VmAreaRef,
> +    // `vma_end_read` must be called on the same thread as where the lock was taken
> +    _nts: NotThreadSafe,
> +}
> +
> +// Make all `VmAreaRef` methods available on `VmaReadGuard`.
> +impl Deref for VmaReadGuard<'_> {
> +    type Target = VmAreaRef;
> +
> +    #[inline]
> +    fn deref(&self) -> &VmAreaRef {
> +        self.vma
> +    }
> +}
> +
> +impl Drop for VmaReadGuard<'_> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: We hold the read lock by the type invariants.
> +        unsafe { bindings::vma_end_read(self.vma.as_ptr()) };

Extremely nice to know it is _guaranteed_ this will eventually be called and
that we can be sure that the VMA is valid by the fact we hold it already and
etc.

Selling me on this rust thing here... ;)

> +    }
> +}
>
> --
> 2.47.0.371.ga323438b13-goog
>

