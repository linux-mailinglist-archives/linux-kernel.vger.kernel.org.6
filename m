Return-Path: <linux-kernel+bounces-385640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2889B39C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D312B220FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866CA1DFE0A;
	Mon, 28 Oct 2024 18:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dBnORoke";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OGHD5mlH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83623A268
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141875; cv=fail; b=bKUOePed1xxPU/mG4gJ2J+rTuR73T9azBTZJ1Y9+JPRQCwIVe2Fi+PtaRl08ureZ2A9nVENALpMBTD9EYA4Sn5SWPfJDyfqL/uNFdPqIcMtOyF2llfi+DhIAj8rBh4E3HyMX3gszYg45BeGAVuOPIHN2TXbmOYy4DaIMlKvaaY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141875; c=relaxed/simple;
	bh=/h35dIZRudycqHeOLTA4iQ7tSZPIgTf4idCHOFVVJ/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C3R3G/Rw8Bn4/lJtS7SjIDLpSHpKpBN5eeKTC86F5n+kWPWoWpadmLWiZ0n0T3sNyjaNza3EDRbt9gYX6XMHGsZIX9T1T9ZWAJFubzlMqHJb3mycAQrH+sa240/6Pm49XYu5sw3Uk+cAAf5lLc0O7w5qWRFQkmLLv5bez2YKH8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dBnORoke; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OGHD5mlH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEtbuk021567;
	Mon, 28 Oct 2024 18:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zIEJBtlCYliDAeQzap
	4feu75xuAbMdYLE2+l3S5/0Es=; b=dBnORokecRJChjCrlqwl7JXhKNK6UojEIn
	wmqQD7hXmq7bAKkPF3LXbj+v1AaKqUrY2K9LpjOGE3Cm69BUgwjmahZ5IiAzq4Qf
	FjVIgLm4bHqfUmrzSaqPgCCMtkV2gI+mqZVednywht6FU0RbsnH19o6hdyvq5/yp
	ZHVC2O84iiV8Dnk9o/Ls7rdgYba4+RJvqipZxCkuYo5/xey6oOVtxF26Dwi19Gnh
	35EtCzJtmpiRQrVM389N95BOFQx0mwhYf3lcoXrxXfAj29CljjqTfXX45yRswC5s
	aDyOSwZzLiKAns3XhLOs99AqMqVI5S8mn3a9pfi+PElGJ4kfCx7A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqbmwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 18:57:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SHtdSc011737;
	Mon, 28 Oct 2024 18:57:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnab78rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 18:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvaaQfuvIzgbi7IKmRPB8X2YERR+aFEjZ3AfFxtK8BBHCC4PB1MHps6AEIjbwowCkrtgCJq6DSG7JA5izKCZcv6dgx8rDHa6FwH/7pEYQROlq73x8E4vSl/m3pmobaRnmS9hwwUAwGuPCiTPrhfsjZLgDMftYgmbjegTwb9egpGwRxmhKugn2Ss4I1Yc9OvGPHioDqk4LiX3ccGmulUIWQhy1c2T7elFa3tVdihf5DHGj99dPuJGyV4+nb73mLhlh+UC1euFt7VaSPbLL6z0k1JHxH4LKnEMw3oajgq9mA27RC/UYd9BPtpRmxnJFtPLMz4q/VXOUWwuu8nknlFRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIEJBtlCYliDAeQzap4feu75xuAbMdYLE2+l3S5/0Es=;
 b=tOek03mWjiHWbZgDM2T0kj2uEhPZVOGO/QKJPhK5DUxiuo0r89qNwwaQIc7NFCuE65rL5f/hnBu9AI1z8f53M51lvYFDfaaqN8SVknv8xhdCBVmoIzrcJiM4AdDgEQq26I1FwTvvxfQmLZyYHFuylB/NGQR3FLf2K2Gvy3XYU5HOpRnzFrPUnwXsR/rBTMDZy8zrKWj+kzYwkyAwLbPwZIdouYg5oNjrVVnv3Dn38MiPnwtUNKS2s+QLBYM0A6S4gRvC/svgZpIP5UDEix6Z1qiooBpbZMxW1wEWAxWngQnqh45pdvyYBlKzhVksoh6dPiSSQS++4CEhGoIRPRopbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIEJBtlCYliDAeQzap4feu75xuAbMdYLE2+l3S5/0Es=;
 b=OGHD5mlHhZOr84iH6SBuU6soT4b4L0VadEiDuZ8hr5aiZljlsTFBVjjonp0/h/XQTuV0odsQilHjOgYFoUajIdSSnnAb3YMMHZ+k7ypRp6K+gaD7w41FZksegJyV2ExthcX0czhm6MajAfQEC37zjWNGHx26A47BHApqAXOXQqE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB6849.namprd10.prod.outlook.com (2603:10b6:930:9d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 18:57:29 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 18:57:29 +0000
Date: Mon, 28 Oct 2024 18:57:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0467.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad2b741-456e-45b3-a701-08dcf7825f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkTJ6d6XMQxAIwB0CThEDEcckfLKVfvu3hcCnbBLINAsHa+XTt+vynPpYJ6c?=
 =?us-ascii?Q?YPCVDEUBfzgxOG6G+m4Y/L+sO8g3D95wYJuZguP6eFixDA2ZRtm4ZQp3jt0B?=
 =?us-ascii?Q?xoZrvPj9d9i7oIByB0pONo+edzL/rQVCEPmeUPHg2e0Q8V8xjciM0bwVP+MJ?=
 =?us-ascii?Q?j4jyYjwtT0ZXKxfpq2dzDkIJB8Jv6t+b7EQp1KvSbd96ThO0Dm4XBQEGF9OE?=
 =?us-ascii?Q?x5F2V6jI0AQ6a8rxyzJRtqmDJDPhEVoZRaGqeCj23BzwZ5VM2K7MubUpZwAj?=
 =?us-ascii?Q?33tb7gf684sOwX3SvnRgjWP4RngLCWhnUZoPJwYsD8MzmvMZQB58xsozKaZX?=
 =?us-ascii?Q?aXo512LnDJUb+U/ZK04/FoWLPjELYQ7qW92dScCY5xcCfeJHrUNhjoCJvSAC?=
 =?us-ascii?Q?qiJMDkHEVn/fktJVVML4o0ldR4gGjpApVT7w6EnrtKt9GSirkhZaTsGzMZLH?=
 =?us-ascii?Q?uXszM/5f2FsnePnxD+VH7dkmH4zzGduAYR5amX8kM+u+wmWq7tyMfvYqnpUQ?=
 =?us-ascii?Q?zcAFP6X1Te54qp7A3+lrRpCKDhnE/PlYRSyuq+ymW81Drej/6jYWiX+BG24z?=
 =?us-ascii?Q?pCR8dvhd98w5CnpWCeLpv/mmalqXLDsRlaNTUTiRd72fjXemwG5LkpxkFbsD?=
 =?us-ascii?Q?v9sMw68RlRYkYYB8mirXt8ELPbuk1qa/x+y6+wSboy2ywJb6mlNqDv+28qHL?=
 =?us-ascii?Q?uD0mynEZYxrrp+L3jHyZV2TNPiBoMsPad30ZPElPBuBuAchWdum3sq8JVW/o?=
 =?us-ascii?Q?8RJgCD/vj0HwICviiwQ81m2Fgr/e2RYuLxsZjVKfxwlj5DMMB94BJ0OLPvow?=
 =?us-ascii?Q?DcwXaoXPUvGM/ycV7NIvPcsfy3wh6PKcf4mdMhEJ5S+S/dRvS54H56qO30nI?=
 =?us-ascii?Q?oH612pCJA6t1Xy0GccjIMX07H/McLQ4x7aucAYYgqJ+KZdyHGgY1wPgyGdGr?=
 =?us-ascii?Q?HHul1M/K+roi8LeIVrwBEuYb13vgcb6tzd7W6Zb6ur/dsRPV3NP6td+yKOUk?=
 =?us-ascii?Q?cHcQ8+9YhgRXyFEmMH+zeg2hmbQg/zWk2pdyBWESV3Y3c+jENfd8DAFBFzTd?=
 =?us-ascii?Q?V83qtz7DKH8zcJDYZ+yWRl8AK4+TTccpuAPzVulNuJCmGb9KxVprywe67xFS?=
 =?us-ascii?Q?TueXLvSZldmAk8WDt9/wZxSSr0qndsqbomo+cNe3C2jkdW0hql3Q8d4EnZG4?=
 =?us-ascii?Q?85FXTjMAcPAhbvS0ND1jxCDZClCP3J+UGMbTYJ1OwOuggBvNx2v3whL1oZaY?=
 =?us-ascii?Q?3crFq1wEItgkaAl/DWvc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQtZR8+uOSWj/2WHmbXHYHNevR/AOvOcR/xuh+n5JqS/gzqJLtghmE2iUZL1?=
 =?us-ascii?Q?vZGUH5LjZcVOlbGNvUlPyRVUnarilOzqrQblznGueQO8DvQYuF3i8bNFobXR?=
 =?us-ascii?Q?VwPwn05Aa7fR3SaN3rTrcteRkRQGE73tqx6uM+6wHp/woNXkfERHA2UgQCo4?=
 =?us-ascii?Q?whfxcsD6L0OrkWogNkEV2T51lG2ev1+OVfYy18nEG8WDyfZrofVzIT8D0TEm?=
 =?us-ascii?Q?uXHQlsyqHmRPCWhWrjzFUkLw6pmj9jThF74kddDcVUt04uQmWMMMN5ITVsfh?=
 =?us-ascii?Q?iP3gcMofpUr+ZpC/0xV8U9zYH4ZyAliXdOaTKqhVUdVU/+bNH7Z1qlXQy1ay?=
 =?us-ascii?Q?D1KVIcCmz5zNVVEw5Lar80m4AeKgigV3rJJrcDcMPPyfqBLfb6bMWgokiwy0?=
 =?us-ascii?Q?yrwdF77TZGhafQ21j+LeMVoMk94DZwVcB5ggJpa//maeTolC20VAJ1LsevJZ?=
 =?us-ascii?Q?yo2PK4By/ZtUhefqjP8j0ziBS1Rdmi2JRnE6Xetehkz/4tRJ9Qev/F8BZ6Eu?=
 =?us-ascii?Q?bdyWUMBo6RlEOjZPHsuCQWxzauZ7QPv5BoBUZsdcp8rgUhtfuxOu8qfbXHbv?=
 =?us-ascii?Q?XYjAGrVL++yAVdeBfKAjQ9N39G9C8fXuHoePPMa4XmZCGn3OAUdAi/s0amQa?=
 =?us-ascii?Q?/NNqWbV0mZa8rgSjqzj4sdHHMIFlElhIzQJPPV9iNFf9C/JywvVO+qpCZSt+?=
 =?us-ascii?Q?rskGThct/v6lQcBwIWSpG4Gv2sR/Cmeg99Kxd/iNbtsFWV+Fp1fhWdC+Wqws?=
 =?us-ascii?Q?Rcm5ITY49WH/6CIXr5X6QBc6RrPREJ8MIo6HPpBw0al0OL3kwI7gumG45GrA?=
 =?us-ascii?Q?ugaONOP4q7pQVLFtyzNJY8gb3ia39ClJMQ1s9qbYyaTHQ0dGN0GcqCQEsedb?=
 =?us-ascii?Q?IfNjui+XPSF8GRuvXSDrOVq2xbWe4QyebxFgpRN9zOBhggo/ZxVu2T5xfHnP?=
 =?us-ascii?Q?pqOoKYH9XzyzfY+FOwuMdCA0mNgEKdqhHnoDf3Nbql4M00DWtLM83ohB6IJQ?=
 =?us-ascii?Q?9zHGdQJWHV/jUuk1CN+Jxk3s/J5TZiShCKhwHguOOAeEqXr4uPiukK8AmLN8?=
 =?us-ascii?Q?2VdaUKPBk0+3EHUGwQnzhEOF9OjF0m0Lt5ACApToXJ4kxfXmZWTSZxkFG0o8?=
 =?us-ascii?Q?MCEOYJNYVoSCjNZV1tZAf4z1LYA4rP1jCbU/2HYoLE5hygFuiAPoE4KkqYYb?=
 =?us-ascii?Q?H2FdeZG3lJNWbEeG8PuAOBPJ9Cv2uvdssFdurqVj866/KXIo8EtNJ90WD/vW?=
 =?us-ascii?Q?PkT3do91OOr7aJZF4tb7wdJejMePIJUHRzAaIuc+Q/67+te/3cHWujzo20OZ?=
 =?us-ascii?Q?OTlMHeQrDv0JmP3C/cNPq0lu6EoD6/W0pQcIsFlhQbIxsR04CQUdYxIYEIEG?=
 =?us-ascii?Q?El9yYRiOl25mHNphAI087/OMKIwjA7puPmkyVNa5vkL8I4eUUM7vPQmb2C5s?=
 =?us-ascii?Q?DXVSHQWZjSx7s9DuiMhx0Dfn3VkOXy/7r3tqiQNAbyWl2LZ3Kzc6sUVVWA+F?=
 =?us-ascii?Q?yGpzZa6i6UjinBtwYKcnOYnrW4GADotB/86mAz1kV04VoupPTscpdC+A0iVn?=
 =?us-ascii?Q?hwWTwAVnXC2qgrV9e3o53VOpEaV0JKFu9XHNkDfgDoxk5FctrWPkY8Dhm4RR?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W7ZPDx3ps8A/IUORCfxwUab18DRbzAGiLqbHL3BY10+/kcCRn2SEAeCwH+FA8QlT7f5zqY2WeQKNEP4Fj3EK3SDzO2jY+ckvydoZ1K3T3Y4NucsvB9NzNg7qRC4w2vEihVeTxeAnEDs/iPBqz7eONdZEsOgSSPvrdoiBXYwuaAEfbakgRoklKdR59t9PsH7qzknZOO/TCvG+O08rRzbsRx5BzO7WcUsiYRmzy31SksauC8DU/2RNoAZwf2EedEHQlhzNjM9gxutXBTa8K24RUWT5miDyTaObSjtJFJiSpnplE8tkgz9UAK/pIAhHbJKZlMovrGiwJU++vazvwErvdleGAXsqjEuxuV8FvL03DQXmM0f9Ddt3GP/VsO4Zr581pYHD8YJcoYF1lEdnzXCtu+Ji4hvO4XQmuzPnAQZxrrq0c1cJCMflyzEB81Ugl7nwOJy11y0h2XUsyX6g7Pd9wt6XMVoP4RfLerL0mkwbdB2DWf+GdsplX95fRklDs58pUAn5qx115q18D/wYFE6m4266EyopFBjbeOS19LwwzqBZxqpjWMlBZVcvfw4Fs4kQ54EegSt3H0WqPjuYTVXQqPHqT1uTCjYeD120TH5xbKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad2b741-456e-45b3-a701-08dcf7825f1b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:57:29.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf4xs7d9vKpf+kueLy/FpyKjVIkLFYN5Mtd1WMBTuPCLnF2sB2/CXr2YnzVSeDqYkTpVlk/a+gahZ9eoeeOrYKc1vlUKG4bGjvyi/Sb1fc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_08,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280147
X-Proofpoint-GUID: lRn-dHvGhjPHxIh4HoqXPBqKC3AQuikH
X-Proofpoint-ORIG-GUID: lRn-dHvGhjPHxIh4HoqXPBqKC3AQuikH

On Mon, Oct 28, 2024 at 06:29:36PM +0000, Mark Brown wrote:
> On Wed, Oct 23, 2024 at 09:38:29PM +0100, Lorenzo Stoakes wrote:
> > The mmap_region() function is somewhat terrifying, with spaghetti-like
> > control flow and numerous means by which issues can arise and incomplete
> > state, memory leaks and other unpleasantness can occur.
>
> Today's pending-fixes is showing a fairly large set of failures in the
> arm64 MTE selftests on all the platforms that have MTE (currently just
> the software ones).  Bisection points at this change which is
> 0967bf7fbd0e0 in -next which seems plausible but I didn't investigate in
> any meaingful detail.  There's nothing particularly instructive in the
> test logs, just plain reports that the tests failed:

Ugh yep ok. Thanks for the report, this is likely then because MTE relies in
some way on merge behaviour or the ->mmap() hook in an unfortunate way that we
haven't accounted for here.

Bad time for my arm64 qemu to be broken :)

Would it be possible for you to assist me with investigating this a little as
you have things pretty well set up?

On these memory allocation failures, could you tell me what errno is? Could you
check dmesg for anything strange?

>
>   # # FAIL: mmap allocation

Interesting that it MAP_FAIL's though. This could be arch_validate_flags() being
moved around.

Could you do me a further favour then and try a kernel at this commit with:

	/* Allow architectures to sanity-check the vm_flags. */
	if (!arch_validate_flags(vm_flags))
		return -EINVAL;

In mmap_region() commented out?

That and the errno would be hugely useful information thank you!

Wondering if somehow the driver hook changes flags that makes the arch validate
flags pass but not with the original flags.

OK looking at thet source 99% certain it's the move of this check, as arm64 in
its hook for this does:

	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);

So likely hook on your mapping changes flags to set VM_MTE | VM_MTE_ALLOWED and
expects this to be checked after (ugh).

Thanks!

>   # # FAIL: memory allocation
>   # not ok 17 Check initial tags with private mapping, sync error mode and mmap memory
>   # ok 18 Check initial tags with private mapping, sync error mode and mmap/mprotect memory
>   # # FAIL: mmap allocation
>   # # FAIL: memory allocation
>   # not ok 19 Check initial tags with shared mapping, sync error mode and mmap memory
>   # ok 20 Check initial tags with shared mapping, sync error mode and mmap/mprotect memory
>   # # Totals: pass:18 fail:2 xfail:0 xpass:0 skip:0 error:0
>   not ok 42 selftests: arm64: check_buffer_fill # exit=1
>
> (and more, mainly on mmap related things).  A full log for a sample run
> on the FVP can be seen at:
>
>   https://lava.sirena.org.uk/scheduler/job/901638#L3693
>
> and one from qemu here:
>
>   https://lava.sirena.org.uk/scheduler/job/901630#L3031
>
> Both of these logs include links to filesystem/firmware images and
> command lines to run the model.
>
> Bisects converge cleanly (there's some random extra good commits logged
> at the start as my tooling feeds test results it already has on hand
> between the good and bad commits into the bisect):
>
> # bad: [6560005f01c3c14aab4c2ce35d97b75796d33d81] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> # good: [ea1fda89f5b23734e10c62762990120d5ae23c43] Merge tag 'x86_urgent_for_v6.12_rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> # good: [6668610b4d8ce9a3ee3ed61a9471f62fb5f05bf9] ASoC: Intel: sst: Support LPE0F28 ACPI HID
> # good: [2feb023110843acce790e9089e72e9a9503d9fa5] regulator: rtq2208: Fix uninitialized use of regulator_config
> # good: [0107f28f135231da22a9ad5756bb16bd5cada4d5] ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet
> # good: [25f00a13dccf8e45441265768de46c8bf58e08f6] spi: spi-fsl-dspi: Fix crash when not using GPIO chip select
> # good: [032532f91a1d06d0750f16c49a9698ef5374a68f] ASoC: codecs: rt5640: Always disable IRQs from rt5640_cancel_work()
> # good: [d48696b915527b5bcdd207a299aec03fb037eb17] ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec
> # good: [d0ccf760a405d243a49485be0a43bd5b66ed17e2] spi: geni-qcom: Fix boot warning related to pm_runtime and devres
> # good: [f2b5b8201b1545ef92e050735e9c768010d497aa] spi: mtk-snfi: fix kerneldoc for mtk_snand_is_page_ops()
> # good: [b5a468199b995bd8ee3c26f169a416a181210c9e] spi: stm32: fix missing device mode capability in stm32mp25
> git bisect start '6560005f01c3c14aab4c2ce35d97b75796d33d81' 'ea1fda89f5b23734e10c62762990120d5ae23c43' '6668610b4d8ce9a3ee3ed61a9471f62fb5f05bf9' '2feb023110843acce790e9089e72e9a9503d9fa5' '0107f28f135231da22a9ad5756bb16bd5cada4d5' '25f00a13dccf8e45441265768de46c8bf58e08f6' '032532f91a1d06d0750f16c49a9698ef5374a68f' 'd48696b915527b5bcdd207a299aec03fb037eb17' 'd0ccf760a405d243a49485be0a43bd5b66ed17e2' 'f2b5b8201b1545ef92e050735e9c768010d497aa' 'b5a468199b995bd8ee3c26f169a416a181210c9e'
> # bad: [6560005f01c3c14aab4c2ce35d97b75796d33d81] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> git bisect bad 6560005f01c3c14aab4c2ce35d97b75796d33d81
> # bad: [4a2901b5d394f58cdc60bc25e32c381bb2b83891] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git
> git bisect bad 4a2901b5d394f58cdc60bc25e32c381bb2b83891
> # bad: [4093d34d740447b23a1ea916dabcf902aa767812] Merge branch 'fs-current' of linux-next
> git bisect bad 4093d34d740447b23a1ea916dabcf902aa767812
> # bad: [0967bf7fbd0e03cee0525035762150a91ba1bb7c] mm: resolve faulty mmap_region() error path behaviour
> git bisect bad 0967bf7fbd0e03cee0525035762150a91ba1bb7c
> # good: [633e7df6cfdf97f8acf2a59fbfead01e31d0e492] tools: testing: add expand-only mode VMA test
> git bisect good 633e7df6cfdf97f8acf2a59fbfead01e31d0e492
> # good: [315add1ace71306a7d8518fd417466d938041ff1] mseal: update mseal.rst
> git bisect good 315add1ace71306a7d8518fd417466d938041ff1
> # good: [bcbb8b25ab80347994e33c358481e65f95f665fd] mm: fix PSWPIN counter for large folios swap-in
> git bisect good bcbb8b25ab80347994e33c358481e65f95f665fd
> # good: [8438cf67b86bf8c966f32612a7e12b2eb910396b] mm: unconditionally close VMAs on error
> git bisect good 8438cf67b86bf8c966f32612a7e12b2eb910396b
> # good: [a220e219d89c2d574ad9ffda627575e11334fede] mm: refactor map_deny_write_exec()
> git bisect good a220e219d89c2d574ad9ffda627575e11334fede
> # first bad commit: [0967bf7fbd0e03cee0525035762150a91ba1bb7c] mm: resolve faulty mmap_region() error path behaviour

