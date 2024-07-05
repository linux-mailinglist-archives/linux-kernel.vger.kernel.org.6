Return-Path: <linux-kernel+bounces-242832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E6928DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95681F23027
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFAD16DC22;
	Fri,  5 Jul 2024 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="duAhO53J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yGt9s5hh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353313AD28
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720206609; cv=fail; b=cC9OKY25o5U8Uh1JoJ7R6LP6hiJUy9aGLUvEc9FQu9xnfc4CZtt4sL7IvtVvbL4YVhr/k3NITwCCvaSxJDZYKys6i5gswj9te+zcGjAoQdfg3YvrCGSbJva1ZIUJqeDU3X4PUzQ9QBG/L+FG6tibVpPURPQCDtfnIDL9CsXjlf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720206609; c=relaxed/simple;
	bh=koasiH8aHb4l4+YEktW313ss+ehuOvmINln1wy9AoN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eoIxH/q+RbMW4z4QsbxVQN18S8Yro1VyQwyYjrgHme/6TabiMNj54eG+V5+PALSeyGVFgSwocKUEirBb6mdhyqjjNuqeJ/ouvogN+cvAMLxcwYRnPH7CT/1RaSbW8KhZLSNKglywFikHg0f17ywNJFJuv4Tzl7XlX4ewweIocwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=duAhO53J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yGt9s5hh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMVKi024966;
	Fri, 5 Jul 2024 19:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=BduYjB4Se7ra2H4
	rLuwfhgDWyD1pk92ycvV3cHAEuvY=; b=duAhO53JX/yiLgkxBYjUbxwTyCYm24h
	1wmE7YoYW939ceHBdzgV2UmkzuR5xRbssqU6Y8ExFLqbAs6CyIb9CFysBFc6TD3d
	U3zPLkZtHaGtzcegHAhTGo+RRrpv+qO60t/mF9mva0ydOgaqsrqmR/qHontISsPv
	UJabfnAjKtXsnkF81FJbGN0IhgSHcEfSGFXH06FHvnCgqTtc0tZ8wfdNI3Tujd5V
	RtUlZbKBmhfWBPNRNjORQrUR30tdJXNX45LSpOLEviTyNjmIsV2uqflIoHUBPbB0
	Lq4LG6kte/0JM+pUwAKgxa38Efw12Jf3KTQW1B/Kyf1TSuWtq1zJWlQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsvags-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:09:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465HKuXB010873;
	Fri, 5 Jul 2024 19:09:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbpe94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDbAq5daRjpwX4Y0E6HckKt87OJ8VcHS4XV4H5TVKRA0Bwo/demRtmfAXc7BvPYd3L4VDSpj22zc2nsr0UXEEPtHtx/MpF4e4bHsHLVS20NAaerYlrt5c4v4CXVRMZf1heNgN6xAcwn+I8YDmC/JXjGlrkF8pHUmtf2NgU7wUx1gTU5Ym0uZQGmkZDQM6FIoJSejkj1h1WXkO68D6Md0gHOdqjXqlJDmXy/PCRHQEgj+4uGvPBJT3vb6rLjCkEghajE7QkrZp1VvvGuWl+EP4bSXoG/YoeoRgcXKP/RcUXWo31ovLElyqUmkChyTHL9/oNJY822Kan/Jtf2XSth3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BduYjB4Se7ra2H4rLuwfhgDWyD1pk92ycvV3cHAEuvY=;
 b=QyYWAUyZLjPDTLugZ0r9GHcM5wwuS4lxcIBJr3dmon7BOYvfKJxON8SgmDnHlA8qgwA8FHwL0O/t1xfQJ5fLFIh6VI20jdHCVuJNv9UPIrG5Plj6iOSVh9X2KlG3kfqkbCxvjKxMu9MyukZ7SrIuXf+Zmzrnh4NAg8E+hXC0+xRs9BJ8UbyipH2JaiupWc6dRoVpbIVTsQdKza0r1nPlshyvURwpyqMQGD/SVR4LFrgDICgUlP3/x4lLZl5x/0BDVsdx4aLGbxU9VYIFtj6ByT9wvddlULIVtC03MDAzV4eMCCKOQeA9UCwO55zkwkQ3Bl+8ACyoiQmarqXo8Ryryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BduYjB4Se7ra2H4rLuwfhgDWyD1pk92ycvV3cHAEuvY=;
 b=yGt9s5hhXh5z8GL7BFPIiwtgB8DZrtiLquX/W1ntsyrgt+eacMW7jJgLU8E/zZVmOt5hU08fHGPzMMxWc7IicBzplxbOLhKCnajP5GXQujEmbdncRjgIVxN219V36BIUD9w7trX6Bvzrz9B8va+jzFNzzhjYzoC5K6n5ApPISi4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 5 Jul
 2024 19:09:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 19:09:47 +0000
Date: Fri, 5 Jul 2024 15:09:44 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 05/16] mm/mmap: Introduce vma_munmap_struct for use in
 munmap operations
Message-ID: <jcdeostzaoalxqbtlz4x6egjay2agiox6mg5o744ovfznbxh3i@pdqvicfbbblb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-6-Liam.Howlett@oracle.com>
 <a1f1e48c-5aed-4c03-b4d1-b4d4ac85a6de@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f1e48c-5aed-4c03-b4d1-b4d4ac85a6de@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fac5a0-08de-4ce2-ddfb-08dc9d26097e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|27256017;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DXSFl803d9Np5J4Mwy9H+hUr14BvWfmBApMyMidUdN2kBJ7w3iDSecEPoH8s?=
 =?us-ascii?Q?w9yrz14IgrO27TA1wyZRVXR/7OfZ4t4tQI5RsO2q6dK/BC4IGbY0/JhZ8BBv?=
 =?us-ascii?Q?9L5E46EfO2JHkokERQ/UHzRmnw0C5R+0ejdvngqRBlBw3Qji9xm4hfAG7LWH?=
 =?us-ascii?Q?l/BgqGS7UbQeLaxSoDHkoydvt9mhWlCcO4aoGyyU5A221YcflJQacaX6A49n?=
 =?us-ascii?Q?4pd/ykq1mAVUFvi8mO/nh84va41HOnNuNMPyO4nZ6ZPeCc8tVdsgZn/Hz8Ut?=
 =?us-ascii?Q?Md6LrejcvavB4hOaTHxVHMY0OLHN0h3RQtBnCVERLORGxAeOd7fh9Ztzdl7S?=
 =?us-ascii?Q?BeTibN5qvtLyaQMygeSsxXvIwfeIAwZmohfKkDJfqIX9jJmDdZTSmRyHDiQ3?=
 =?us-ascii?Q?S5k5tPFMApNnQFkCmj+MIafIUC7B8dF05SxmxECGHG/3ycThNcmxhnTWVU6F?=
 =?us-ascii?Q?56hu2vOIx7Ey82YGHQG389mhEelMfdD1JYNhWFv8GJAkFHrE61E/5Q2iguwV?=
 =?us-ascii?Q?onc7zKUcXHaSKQ7ZHvOwtI2ecMYfZpC//ODD9RJTJoRHBDjMX0lWKJBJrf2p?=
 =?us-ascii?Q?mUldbomgspqZMEuy7iotuFuwaW/lSnFU4UhYqUokrF9TSVLNXAP3jg26zhCi?=
 =?us-ascii?Q?sBH8vFzT0fdQjKSS0D+BYaO01e5H730O/3yM5ju+LPE5B6WHGgRTaU1vYAcW?=
 =?us-ascii?Q?gpwdZqgc6GK9fCGLEWRiIKVkH4fl2uSlPLltBA+KHfTSFfnc36YGnNAH0OnL?=
 =?us-ascii?Q?3x7FjxdKd782B2O5JapFJuQpcuWpnErdCb4Y//yl5BTJ2kgUg8LuKKMT0cIk?=
 =?us-ascii?Q?5aUHZA4tW1fCYhODiBeinfgnZ7UyorNsVd4bVIxjjIUyV2KV0wpcR4jHGkVO?=
 =?us-ascii?Q?NZaP8E+ii9+192moH7PTm92RdgmoZ6PU0lRZKIeUE9VpcGWSPy4VIW1mSK/3?=
 =?us-ascii?Q?XMtgHaOfJkQFcd14MGUvi5yRWocpyA2eVctgDfRLTSVi11fqeRAsWGd2jFdH?=
 =?us-ascii?Q?Vz6lSeafjenaW03SxZieBIFiolQfHWS/GOnwRc4aDuggoo+BLSkUwKqJ4te6?=
 =?us-ascii?Q?gFFhSW0VaNeQn/hVATZZVRw22C6R5ELgb7TtbGmeEdwzldHMmegOuoAf1bRg?=
 =?us-ascii?Q?XPLaC4+ag7w6TACzfuB/qsBW3WwGP2fppJpbjDo8ec0C0fxnhk0jckvScRRJ?=
 =?us-ascii?Q?KayWYFYjmUvaCQ1P4Eb/oqAJBKBCBJXiDL8tJxgsq7lK2Qpabi167isVReJk?=
 =?us-ascii?Q?7YirBmeOMobWRLlbjUG5vJKiVznlC7OGm8KEowrIdlnh4wPRT8ocMNGqw+K4?=
 =?us-ascii?Q?4/4m/UTv5+dSJU5q25PHYbDaOzCn6Lt2NKaugq7ig3Y2C1MSgPBIiSm273FH?=
 =?us-ascii?Q?LMh7ebQlIjGmjrjdRUnkeDj0ebw/M2sWnO8nHUS308PyBDbKuQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VJ7wcB4gkh2SRrSbm1LTitPaBwqnWTlCAPB9DtsIMAG8TI1Fwh1drtgyHOTh?=
 =?us-ascii?Q?ywkVyd6PeOI3QCeas7U0iEky6ACPZmJxxxqyOLq+4lLQp2z8KQVsFcvN/7z6?=
 =?us-ascii?Q?SH4wc+oDSkjOH/ZN6N/ih9W9Ng5+kGSAPVeNG2QMg2ovFyuO/QX8llxFGsFX?=
 =?us-ascii?Q?ytsGG6/4PCWOhyD1fsvbfQStFQXXpUjU9sJa5XbvhUT1z1v4HZXPttRdnBgy?=
 =?us-ascii?Q?rSH4iNQmbL7vCRT3yjYphT5gHLysANj4Bj+VzpnJRidJ+7VRhpwib7Eq1YPu?=
 =?us-ascii?Q?hRP47fUtD+afbMdSG0eYTVZV3xO8prooC5zFMhiGvIvR2rV1HXb346Mpnns6?=
 =?us-ascii?Q?DSYZIllBxy8TP1hdzt/mwF3AHnVXCZNUq7Gct/TgmA7aAlwGCv6NeFrb/iVf?=
 =?us-ascii?Q?vgl5iT0c8U0zjPX1JbUBRPBX+w2eLTKsiw5OVyYpi2tSG2e9hbcTatHQmbyj?=
 =?us-ascii?Q?5ArtbtHfZnoEBwneX0sCcupCEHY50Thll0nCsuAGC296ATYDBe2L9cVtv0wZ?=
 =?us-ascii?Q?JJ58/32NYJ4+ZZOp/t6UJUHfBsUmA6nhx/gPgLuYJLwnoLsLnakwYfxU4vr4?=
 =?us-ascii?Q?AqMpteLDwn+u6ZEJmZzefOs8vWfeM8phY0k97tkdC4qHOXLoXA63kDG+Wimv?=
 =?us-ascii?Q?jXUAu/Wma2iEUWTLPFK4AExikwXbaMUY7fZpvtBn+FDk/nVxc2PCWpXr10fB?=
 =?us-ascii?Q?WqonEJizYkOVGA+XAFFa2VDux9gcTpnDHDRVZ3tykMeEY2gsVQjcr7iUklzS?=
 =?us-ascii?Q?k33SeqYGJTqgqZbqO945Fuzi/GOLam6NHw+0Xn6AxgU15dn0aWHqlpMt9PON?=
 =?us-ascii?Q?jIWCAbhY0F4QJoS4lgGVqFat7AaUPPLriVof/m8C0vxiPst005DF+qGT5bya?=
 =?us-ascii?Q?mEsCZDydYRq4GNJMTVQluQGbCw3xONMs/iJ4OjkhU3vyghD08iuvOu5euKMS?=
 =?us-ascii?Q?su+5nlFW+uV3q3/rVpOCwCymFPpfHpAgezgRrvhgJuw/CkTlOfpkrdpvvqUl?=
 =?us-ascii?Q?2G1r1ZIZlhAWmewXwPpaQoIn2tmsLo+h+Rskfbjlcx5OsFx5HzmFwVvx2MJ+?=
 =?us-ascii?Q?IXe14jBWW/MgxqVStgbeSi3jMZ7jfJYMkUXJGrp/oENi7Fy40PTeHkMHW5zG?=
 =?us-ascii?Q?K2mMf3uA9owdrHhtQ8RgOHIAkhfRy6Saau0EmAlcPOyHyYTs6m5V+L0lXMrE?=
 =?us-ascii?Q?T563WZxCf+g8lixBDEwt9P/M60RhTbZptoB3SNZDak21l/9xFjOEzoekWQI3?=
 =?us-ascii?Q?ooXUIdEpnbYwqp/xOPI4P9yD3gSW92uBREdLWW6+nhO277jGB5kCd5P2bEPi?=
 =?us-ascii?Q?knIFvewLsVMCsTlixBDnL+CMNnS0a9ben3/3VYQ41EnCyC0H2gKbUGDIYonS?=
 =?us-ascii?Q?NSXAqA41dHxhQikHzIcTRsZ0JQ8citN2o3q67DrKjkZEcF9nDniVst2wntXs?=
 =?us-ascii?Q?aP5MvfnYyx5BfBsDBKGt1HfOq7KFILzDG4Hsty70Z3+YhDn3aQ5mkQX0d9ww?=
 =?us-ascii?Q?I1fO6cstnoPHVozqUC8oxewp23iRsiqWceNvk5aJ0AyyOH1BeMSTePa8HpN4?=
 =?us-ascii?Q?78XZxlyYLAOxcPcGbHUzPTnxHM3wJWkQrsfxNt+g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K9XVY6iNKc2BaumLLZ3mpN0aJugDattGdyzjtH6l1VKQagOJ/ijhLeQ7GHx2/OMhvontFkII2gNqvShx9nVPZ9pCublXIXuN0QxGN5GKoeAWLAdifuAtG9IyJKUg43OX85cTMv3i6+CaZp00lorTMBNfORTVV2CRscBw82NdKnxA2Ysp+zxaixy+so0JG4u1Lxbq0a6l7w/zdfllqaiClJVlSK7Bhlo7gwc4s7hXalvGTy3+/Kj+A4BuRphGckg15hoTqkZrrZhn8oWRmWA5HaXORR9IYtmyDnvdGZFN7O6YXnkwVv0YJaCWxRzxpwOs+RAbl+4fXZk+7I4lUXVb+w6mL9NanAU0mRJEcMapxm2E5XkXCS/GGLpEr7MMxWgjsIf80ZxFRoUXsVl2HB+yLMaoKcYHx0tY8QFcRgTwt75PJ2AN5rusmHJCnSYnDLkpkIF5cAUnJuRkmS1qPA9k3NV4fsC/VfhE53VQGFueughDijweOMOhiD83SH1ojRnh9cwKSCec49bGrVwMzyvoKLMqZoWK9mQxKCqsR+6Sx6yJhAm40+5AnpNVdtxS0ryxXufcti6wQkaLNMFqmtP0ulwmtz2Ae5HPjlRo9uwuARg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fac5a0-08de-4ce2-ddfb-08dc9d26097e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 19:09:47.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0n6RSij7BgEL6W9+ue7NpRYnoKx01vHbR3yH6hox70bRpr1Tm2F2YQxtNDE6bcgrEsQ8giYRkr3TcSHkrr6eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_14,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050139
X-Proofpoint-GUID: HE3bDawfTG479ZBwF_gVewqcyMQp5eHa
X-Proofpoint-ORIG-GUID: HE3bDawfTG479ZBwF_gVewqcyMQp5eHa

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 14:39]:
> On Thu, Jul 04, 2024 at 02:27:07PM GMT, Liam R. Howlett wrote:
> > Use a structure to pass along all the necessary information and counters
> > involved in removing vmas from the mm_struct.
> >
> > Update vmi_ function names to vms_ to indicate the first argument
> > type change.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/internal.h |  16 ++++++
> >  mm/mmap.c     | 137 ++++++++++++++++++++++++++------------------------
> >  2 files changed, 88 insertions(+), 65 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 2ea9a88dcb95..f1e6dea2efcf 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1481,6 +1481,22 @@ struct vma_prepare {
> >  	struct vm_area_struct *remove2;
> >  };
> >
> > +/*
> > + * vma munmap operation
> > + */
> > +struct vma_munmap_struct {
> > +	struct vma_iterator *vmi;
> > +	struct mm_struct *mm;
> > +	struct vm_area_struct *vma;	/* The first vma to munmap */
> > +	struct list_head *uf;		/* Userfaultfd list_head */
> > +	unsigned long start;		/* Aligned start addr */
> > +	unsigned long end;		/* Aligned end addr */
> > +	int vma_count;			/* Number of vmas that will be removed */
> > +	unsigned long nr_pages;		/* Number of pages being removed */
> > +	unsigned long locked_vm;	/* Number of locked pages */
> > +	bool unlock;			/* Unlock after the munmap */
> > +};
> 
> 
> I'm a big fan of breaking out and threading state like this through some of
> these more... verbose VMA functions.
> 
> I have a similar idea as part of my long dreamed of 'delete vma_merge()'
> patch set. Coming soon :)
> 
> > +
> >  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> >  				unsigned long zone, int nid);
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 8dc8ffbf9d8d..76e93146ee9d 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -500,6 +500,31 @@ static inline void init_vma_prep(struct vma_prepare *vp,
> >  	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> >  }
> >
> > +/*
> > + * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
> > + * @vms: The vma munmap struct
> > + * @vmi: The vma iterator
> > + * @vma: The first vm_area_struct to munmap
> > + * @start: The aligned start address to munmap
> > + * @end: The aligned end address to munmap
> 
> Maybe worth mentioning if inclusive/exclusive.

The "address to munmap" isn't specific enough that we are using the same
logic as the munmap call?  That is, the vma inclusive and exclusive for
start and end, respectively.

Not a big change, either way.

...

> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks


