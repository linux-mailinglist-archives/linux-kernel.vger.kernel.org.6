Return-Path: <linux-kernel+bounces-513786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04126A34EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FF47A2191
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A401D24A077;
	Thu, 13 Feb 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KuBFGC4d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Esj8CV+l"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E524BC13;
	Thu, 13 Feb 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476089; cv=fail; b=pqEbX4WMfkw0b8yy1P/QNdj/al6XyJ30K4XN3wabu4JHxxYOGi8pC1ZvV9dxQoi86YpyQgbTneCZPgUWwCQBnm3zABTEo+2Ibgf0Al60JGxMHAU/TZZ9SlLrOzTg9WmxdIlTi2J+a3WZneGKCgYtSBqBBr9gF1gchxiATvf9m4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476089; c=relaxed/simple;
	bh=daZI0PJ1+fIJ+5IwyIlfFE8taBv72lyhO4qXJdgw1aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dm9stwBHMNG/0U1bX5Xo9jh08W4Q0WOmXK5ohLPftpsoXl0XNHWuorMlm6wvKAInyGMz2bKy3qLGVZqxZozBVPXsqxPzekxitRRvMjOmEyrnht2Bk4ZP+/hFeFrQSIe5HYrngStng0tCo8iJLOS75LV+oD8GBIpP3chT83i+Fao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KuBFGC4d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Esj8CV+l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfgoK008196;
	Thu, 13 Feb 2025 19:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=cL4QjMGQgiD1lMR2EG
	rQzdg9A10s4CZ59Vyb1oxgsB0=; b=KuBFGC4dcDHmdrB3Nw95aQnd2lhfCZou4h
	NgSBeruApoafN7fNc/GbOqAUVTqjwk1XvMf8nGLSWlpgklLyqDd4G/t5znC39q2Q
	NzIgSdNr04iLUy8MmiENU1P8JpmaFUMuowFWEaMZHo3S5tEwty/58q58DmMvza6R
	G1jbh+1xniW4YQRTkZqsAJcz3VOdlKXlOKUdeljUHT3nqU5LmgsRWtsMiTJhTkKj
	9UweNqoFycoYVjmJqVmCQWgYVwWE4ZjlG52ZJp5u8JnnSrQMg6oBOQKBYecGanf+
	vO69PEHX02nY678p7qMS0EF5tJeKfwQ8dRpeARDCUVyWPvN9ImxQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s42bux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:47:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIhfRb016304;
	Thu, 13 Feb 2025 19:47:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc8dgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVZnznl5YYmspWOAOkpIU/HVE9+uO6JO09VTkje6r00IJKQtOGyBaHY182CVSGBITqLJWjmXKiOB+y+8CxUHM6TQn8mGKFfNfD7XjVfXBM1T4cM05IHH+cN043Xu57u5R0kzL0y8WRbjPvBsIwZBuVEmurnebsSGP082qi1/6yliNA4bf+xZ4yg2crPqFSJGVH5Z9jSxyjQfAAUepg1WXvEeO6eEmHrcXPewyfb7RBD/t7OKe/3jN178zMuYf68TS1JDsOYXbHWvnnmpMLvpTzJSlNDSFqwNL1dBSiKj1FFXWKL9xILV5bFMCjJJVgmrqo+VW10wx5ddBwgV9h+qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL4QjMGQgiD1lMR2EGrQzdg9A10s4CZ59Vyb1oxgsB0=;
 b=Hml3vljmnFtGS46Zdocvtcv5d+gbZf1PcR5LmGf36MTY7KUjkfWs7soTVu+vr000dZ2jJD5kqTgQBmyTH9ev/05uggnZDpuq+hOzpsouKf1HTsJ6wCdZTGBbrUY3MHqjV4VE84V1va+VQ7lV3LDGbDchjKDhJsCGw+lkbCcnkSj7BNMZzW9fxOz3LrGUw1nuCTnus/RgdTJhq+oBZeA5y/DJCYqqfXUA00FptBJM8yVNaM6cjfxODjjyfoTAoGKt3f3canqeP8BPTQ5dxkfOd4czdf+yfhqYbdn3mSFFWm19zSlcmCLkIwG/dHIFJZKAlb3SegnwXw7f4M/wLJW26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL4QjMGQgiD1lMR2EGrQzdg9A10s4CZ59Vyb1oxgsB0=;
 b=Esj8CV+lGfuD1hbS2OwLIZi+JqjJReNH4wI2IV7QeahlEdBOBjQhqIuXqbYjX5ZLeJDvpvhvRlByEyyN0BC9C9F1yBfGRV2fvdEvhIB7hNhLsb28abyHQlWbKlPsw+K/spB/1ZvtcxJlrm7HEmwtnG8zUkbPm0Ps3zQzG/8ZiOg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB6847.namprd10.prod.outlook.com (2603:10b6:8:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 19:47:25 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 19:47:25 +0000
Date: Thu, 13 Feb 2025 14:47:20 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <acfsp3mmw2gc5d5uswrnsfcty4lqqgeb4saaigdpwro2m3wumy@ywquqcpcywog>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Balbir Singh <balbirs@nvidia.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-vma-v14-0-b29c47ab21f5@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1P288CA0013.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::26)
 To PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: db8a67cf-11a8-4a23-cf2a-08dd4c673d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+I9jRByzEqWNTiIGnkDger9cwT8iCyH6fC5aB7ZY7QFho4nxCW96+CZCwCAb?=
 =?us-ascii?Q?MuNx3Iai2fsRHYoBEZmgWZq2E5buBZ8AwDl9NFKZSeAGvXSxnJ7iGGXCbDP4?=
 =?us-ascii?Q?GiUCRv1sa6cVIZW50KIjdhgYvaM4HZguF5fdevDcnyIoN7SiNHPa8Ydm6rlT?=
 =?us-ascii?Q?Hvcqf/RBbRNFojYXLoCzTDm/+5Tv/YOlSsf8CHGx01AJe3udKi6uwDMZC/y4?=
 =?us-ascii?Q?BddC2+aAaJ5H/lIhYIjYPE8nG6RlsbyYBS0on9HivdKNhGLyvuJTgHcQEg34?=
 =?us-ascii?Q?Jxc1o/CW4Hoz7oAr1N5meIWLGAOerJ3qsqCa5P7utopQEIXoC2h7co3Nlddz?=
 =?us-ascii?Q?jwqrQJxsgG18Mp4u6r5vEHIZcbEg+TaGdXIOW3Mt61djmk63gRjmW3BbKMzd?=
 =?us-ascii?Q?zoRmgPeFgvLSNVGTuRbyMt2TjDzcxahY8U53RyQEO/dyZh1hR6KoPp7Xrvfc?=
 =?us-ascii?Q?Qv41z6c35p5mEHknzkCRNviJ33YwLX3lEFSTNWhNx66O+v0H4LQYUSBHoqhA?=
 =?us-ascii?Q?AKgqiZwZeLrFMhjNZHv0XOyiYK9SeZf8rVA0H12FyHqYKLixiaCSJ5OpRUKs?=
 =?us-ascii?Q?QBOCYF4oFYEGMNvo5q3BkMq6frt6b0ondhUEv5EWIRcgsJIip8b3g758M52L?=
 =?us-ascii?Q?cB4oRx9mGUK3prpdEbu7m9PH6VlLs8K19blz/UGc57xsPCWrFYPVrG11s4aa?=
 =?us-ascii?Q?gBHjlIIM5sJIhpTpH+TK6Vli5oE/RbJWn84dCn+XJhwJEZShJ0YMThCQEnRm?=
 =?us-ascii?Q?nJCiiQK7MwqwUtikW6YX7RECJ4nFxgC77neoIVROqr6AAOGECtEIRFV0F0EJ?=
 =?us-ascii?Q?9/zrhEq/dDSuZoxEXVLQwLV2TRnlMrQkTaNk1XBePHCGbVdIVWD/42GQCLob?=
 =?us-ascii?Q?zWSpd1l2ZjYojzNV6yfpO+EVeByLYlIT61peTXfzcMyIpWdXKjrAcvPVnmBg?=
 =?us-ascii?Q?2vDpjO3sLOC/hIlAww/GnEsvLJgk/R2RJatNi6ViKkDBB6WcRkrooQPdMs4Y?=
 =?us-ascii?Q?rUIwuj4nrABw8qJCcdBArticPn0lvz4H4M8UHx9kNOBRBelsFa8f+lZKQ/Av?=
 =?us-ascii?Q?F30Q17c4W2ZGvMzLfnKbnRtUFYwVyoKyPvMWipaQY90GF4IO6lOhWkVpDwKo?=
 =?us-ascii?Q?llKKr3baNZLtAojPHClaZbKuQSW8kquCm5RozI5uCbwkAsStnxzlm+3MKlhl?=
 =?us-ascii?Q?q3uQTsJpzqQ5cmPCnKmxeleimfKb5zUerufIGKsEx10x9Dd24Vz4lZKtB4l3?=
 =?us-ascii?Q?t9+N5+IYr9oQ1OIy0gAnyvdMNLufIq8XdA6R5ERFCnHqdgfI8yJzIg72qRuG?=
 =?us-ascii?Q?5qm6ByGc21r82RK91rMd0bSR/UGIkTl68tDQxJYGFTaqMJCa6Gjxr2nXKh3/?=
 =?us-ascii?Q?WWVPHAGWv2so3zxDK+pyjjISqpMUGtwv9q8ERcd97Dj95EajZMg8wfeCG0cw?=
 =?us-ascii?Q?6sUpKB5F1s45eRii2CQwigy4hn5/j7CO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djfHsicVtF5ppTQ8qG71N31ozGB/ynK69K63FjJiaC3qvzjazpiDHkFhW8f9?=
 =?us-ascii?Q?cNB6DbXYIRGPEoxf7DJSPYITKWBo7MM6ac1Ww+t1WwOtI1qoWD11FdpxIE4v?=
 =?us-ascii?Q?gK71ier+CFwh6l+2gQpMGgBvIMu26IEjleywqpKYU1xrFgUqm63P1dJEQ9ao?=
 =?us-ascii?Q?feGmXmMSGXR662ZBQi5H1LscUlR4LaWE8M5aGFUYS9jXxbc6d3gReQOXbagV?=
 =?us-ascii?Q?JyezYMcy9H1floOODfA2jde0IEz2TeZLlIdxM3VDbLgCyTKS/cjY/TH5g1nz?=
 =?us-ascii?Q?4rvYlCfFOf1E+eJ4HltIfemv5+ubeEZ1NzzOT+ueJ0cVVL+7E5ucTRtWfIWw?=
 =?us-ascii?Q?PjIEY6TpdFmbMapBMWA2zSMI1UoIkaYeLCj58vtEs5/IvIQ1xzbko1Y7Xf8d?=
 =?us-ascii?Q?Trzu35jJ0wPgqsD8yvjycfXPxOqF6sNY3WGBDiD5HxJebpWWDeXegGFcg5ch?=
 =?us-ascii?Q?C6pxzg67pPJTP6rIuh2j4tdYPH5xyZ3ZHobqiDIAARK/qH/PpDpM4Wkmiwdv?=
 =?us-ascii?Q?2jxpGMZWvCMG3yoMSaqAxkyhiX9YD4M22h70YdWooKII3VROKdwBWndEK9Xq?=
 =?us-ascii?Q?dyu8q0ruuF0G7f5BiGIOeJNWa2oSv9Qi3IRnLdVb3HNHiUwkSI97dGCRuHzI?=
 =?us-ascii?Q?+6Qj8hR26XOv/h/PVK7KerMY4u7ONtEBtzj8rTNjj7EfBo/ZV82ICycd4oCB?=
 =?us-ascii?Q?woxCGtI9CkqaNnhMJARNiDo4yDPjIyF/OXisgJKfJHgT2NgiZbmHIjFOgna6?=
 =?us-ascii?Q?1igVAakTLRJviEJNFuGFw3brjj1M7kVndPDTGLB+kBMyGN1hkauUbwaMhc8w?=
 =?us-ascii?Q?8/oDgWDdFFTrfoCxz1Sf9Lpdpv1hpDZEUD6Kq9a8Q3N3GDZkug3zs8mIs4e0?=
 =?us-ascii?Q?LQ0w/9tTZLNntNCT1Rty3ltK7JGBE+YMgoaO5uh990DwVeaQi5UQPdUsx534?=
 =?us-ascii?Q?+dr8fLRum5DwpBgDZKVV3+3rKm8FVmY1sW18aXY3+lx05y5RSxfD7t/3ilhk?=
 =?us-ascii?Q?X/t3SWlzM8QwZCH7fONxMBuSBU2YzDFY13F50aW2ClT+HSY39inkcZG0PnuR?=
 =?us-ascii?Q?24sW9knk44AmDPLv8rzptQObXA/J8d3x5WEUsxzGbtVIZ8x17iC80ISdWzwD?=
 =?us-ascii?Q?Z4399DA8ImDA2UY31gTz5XLX84+t0lggUZbVun1aB7R157/sDMq+x0vuuag9?=
 =?us-ascii?Q?6TRYGugq+2wBllpL3xNJYeRDfGuEt7uYu3iF9tpZ90Q3z6gtjgnae126vTPi?=
 =?us-ascii?Q?jcZinO5cThjR2lyieZ8iaM2sNdcyPeIAT6uwGEGlpcYLYX7V5AVUv6Fw1ZIz?=
 =?us-ascii?Q?HnbtFFfMt7G5DjMXwoCWRY+BSbWANOK1v5HR9R1x7Lx0JAOgyzlSLLRMPsEy?=
 =?us-ascii?Q?LhIRHA72SO3lxcDLikaapwR2r7t34u+9N+9/UZe0wruoFPvlN++5cyWqY3gC?=
 =?us-ascii?Q?RDFePmWBwvifPYhcitnzmGViTguz6s38f9QaR2xtAu9MKtmqm+lmo6Rde+jM?=
 =?us-ascii?Q?PoTGdwghzaIUlCp0qcHZ6BYoLP2nx6ZtBnGHTJYN6DbGy9dbxdPr9rZIBwKj?=
 =?us-ascii?Q?LwCm7Qi8HgqwiFvQTXnpxgVnf+cgSGCnsA9wskvU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	574KbirOKwIH+NLj/68clFvuUb4kjO7+7haWUs52wzc0Q8PTbU222ep1fDgUGAw2ZvSFpT5gwyeYNXNqmgg6vakRrJm0UQLdV5Se1+ZiFGmiQ8We2X4zzF1mIFLRHfMW5Hvm1PZ54JxAv5/TJ3h5tf4am8XDj7IFTr8RDraJyqdVIuXYavvnBZnz46ddrDRhjfxLcWs6LqQtVXF8tcKC0rtouw2CNoawtfDpm0FMmlQICfg01hli6j/SThG1dX18Nf2cmA+oHdeK1EaXsQ9/dzPDCV98hQtEmz+jbyP4uNL/EfDPcndCEzSwJOUCfoGyk1wx7kV/iiNR7BgtMQcylROHdyGRq2Sfq518doEikJLIl7N55lKbJZFAkAtzDay/6FrFD/ChAyhO0366vf8TVOXxhBha5vbtsd2rwsigH3XP77wEObPMOcvvpMe2iVjfx3HLXjnbt4HlkCpG5JGDtP3Ha4OMbLoP7z61/X9veAVBypDRabnFopyaRhmVHUQ+Jri/awdYNB3tpbDRyYyEervRYjs5Rkjpbz/CsfqbB6idYsLIdHXJoKzp993b5VphxgNKpBjM7PvDzqXm0MBxYVuG+Y1/AQml89njXomrZuo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8a67cf-11a8-4a23-cf2a-08dd4c673d4b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 19:47:25.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +L3uOzL1xzJOENpf+D841BXFhzP0BglfxUc4NZvyQgybaH/P0NZ8cCAcBQnCAHlCXXSB4vQXasYmWFbpyf5B1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502130139
X-Proofpoint-GUID: 2XRc_SiSMJyhWZ0RzI5-UZ_ePGsjJOky
X-Proofpoint-ORIG-GUID: 2XRc_SiSMJyhWZ0RzI5-UZ_ePGsjJOky

* Alice Ryhl <aliceryhl@google.com> [250213 06:04]:
> This updates the vm_area_struct support to use the approach we discussed
> at LPC where there are several different Rust wrappers for
> vm_area_struct depending on the kind of access you have to the vma. Each
> case allows a different set of operations on the vma.
> 
> MM folks, what do you prefer I do for the MAINTAINERS file? Would you
> prefer that I add these files under MEMORY MANAGEMENT, or would you like
> a separate entry similar to the BLOCK LAYER DEVICE DRIVER API [RUST]
> entry? Or something else?
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Thanks for doing this.

> ---
> Changes in v14:
> - Rename VmArea* to Vma* as suggested by Liam.
> - Update a few comments in patch 02.
> - Link to v13: https://lore.kernel.org/r/20250203-vma-v13-0-2b998268a396@google.com
> 
> Changes in v13:
> - Rebase on v6.14-rc1.
> - Remove casts that are now unnecessary due to improved Rust/C integer
>   type mappings.
> - Link to v12: https://lore.kernel.org/r/20250115-vma-v12-0-375099ae017a@google.com
> 
> Changes in v12:
> - Add additional documentation to modules at the top of mm.rs and virt.rs.
> - Explain why the name Mm is used in commit message of patch 1.
> - Expand zap_page_range_single with docs suggested by Lorenzo.
> - Update safety comment in vm_insert_page
> - Mention that VmAreaMixedMap is identical to VmAreaRef except for VM_MIXEDMAP.
> - Update docs for as_mixedmap_vma.
> - Add additional docs for VmAreaNew struct.
> - Rename `get_read` -> `readable` and equivalent for write/exec.
> - Use mut pointers for `from_raw` for VMAs.
> - Update safety comment for fops_mmap.
> - Add additional docs for MiscDevice::mmap.
> - Don't introduce and immediately delete mmgrab_current.
> - Reduce active_pid_ns comment at Andreas's suggestion and link to get_pid_ns.
> - Fix documentation test in rust/kernel/task.rs.
> - Fix warning about unused variables in lock_vma_under_rcu when
>   CONFIG_PER_VMA_LOCK=n.
> - Fix minor typos.
> - Link to v11: https://lore.kernel.org/r/20241211-vma-v11-0-466640428fc3@google.com
> 
> Changes in v11:
> - Add accessor for the vm_mm field of vm_area_struct.
> - Pass the file to MiscDevice::mmap for consistency with
>   https://lore.kernel.org/r/20241210-miscdevice-file-param-v3-1-b2a79b666dc5@google.com
> - Link to v10: https://lore.kernel.org/r/20241129-vma-v10-0-4dfff05ba927@google.com
> 
> Changes in v10:
> - Update docs for `set_io`.
> - Check address in `zap_page_range_single`.
> - Completely redo the last patch.
> - Link to v9: https://lore.kernel.org/r/20241122-vma-v9-0-7127bfcdd54e@google.com
> 
> Changes in v9:
> - Be more explicit about VmAreaNew being used with f_ops->mmap().
> - Point out that clearing VM_MAYWRITE is irreversible.
> - Use __vm_flags to set the flags.
> - Use as_ and into_ prefixes for conversions.
> - Update lock_vma_under_rcu docs and commit msg
> - Mention that VmAreaRef::end is exclusive.
> - Reword docs for zap_page_range_single.
> - Minor fixes to flag docs.
> - Add way to access current->mm without a refcount increment.
> - Link to v8: https://lore.kernel.org/r/20241120-vma-v8-0-eb31425da66b@google.com
> 
> Changes in v8:
> - Split series into more commits to ease review.
> - Improve read locks based on Lorenzo's doc: either the mmap or vma lock
>   can be used.
> - Get rid of mmap write lock because it's possible to avoid the need for
>   it.
> - Do not allow invalid flag combinations on VmAreaNew.
> - Link to v7: https://lore.kernel.org/r/20241014-vma-v7-0-01e32f861195@google.com
> 
> Changes in v7:
> - Make the mmap read/write lock guards respect strict owner semantics.
> - Link to v6: https://lore.kernel.org/r/20241010-vma-v6-0-d89039b6f573@google.com
> 
> Changes in v6:
> - Introduce VmArea{Ref,Mut,New} distinction.
> - Add a second patchset for miscdevice.
> - Rebase on char-misc-next (currently on v6.12-rc2).
> - Link to v5: https://lore.kernel.org/r/20240806-vma-v5-1-04018f05de2b@google.com
> 
> Changes in v5:
> - Rename VmArea::from_raw_vma to from_raw.
> - Use Pin for mutable VmArea references.
> - Go through `ARef::from` in `mmgrab_current`.
> - Link to v4: https://lore.kernel.org/r/20240802-vma-v4-1-091a87058a43@google.com
> 
> Changes in v4:
> - Pull out ARef::into_raw into a separate patch.
> - Update invariants and struct documentation.
> - Rename from_raw_mm to from_raw.
> - Link to v3: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com
> 
> Changes in v3:
> - Reorder entries in mm.rs.
> - Use ARef for mmput_async helper.
> - Clarify that VmArea requires you to hold the mmap read or write lock.
> - Link to v2: https://lore.kernel.org/r/20240727-vma-v2-1-ab3e5927dc3a@google.com
> 
> Changes in v2:
> - mm.rs is redesigned from scratch making use of AsRef
> - Add notes about whether destructors may sleep
> - Rename Area to VmArea
> - Link to v1: https://lore.kernel.org/r/20240723-vma-v1-1-32ad5a0118ee@google.com
> 
> ---
> Alice Ryhl (8):
>       mm: rust: add abstraction for struct mm_struct
>       mm: rust: add vm_area_struct methods that require read access
>       mm: rust: add vm_insert_page
>       mm: rust: add lock_vma_under_rcu
>       mm: rust: add mmput_async support
>       mm: rust: add VmaNew for f_ops->mmap()
>       rust: miscdevice: add mmap support
>       task: rust: rework how current is accessed
> 
>  rust/helpers/helpers.c    |   1 +
>  rust/helpers/mm.c         |  50 +++++
>  rust/kernel/lib.rs        |   1 +
>  rust/kernel/miscdevice.rs |  44 +++++
>  rust/kernel/mm.rs         | 341 +++++++++++++++++++++++++++++++++
>  rust/kernel/mm/virt.rs    | 471 ++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/task.rs       | 247 ++++++++++++------------
>  7 files changed, 1037 insertions(+), 118 deletions(-)
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20240723-vma-f80119f9fb35
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

