Return-Path: <linux-kernel+bounces-387464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381479B519C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB113283EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D351E1326;
	Tue, 29 Oct 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n4UZjoS9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p42NuNDp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8294E1DD539
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225565; cv=fail; b=U/hq8Rse8wqIx8Y5/hlLV4vwyGgFkoZXeNt32aixJb7+s9iA/pzN8LZRCVkcwWH/pEksKQ4SXJV1CpyxWVdQii2F5VqTtcJcj3B2+kzl0PlSifd4rupaCY89ACU5FQhuYh2u+dCHBAFFyFvQbcoqbb9VhIIisTjY2V0wp6j4UfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225565; c=relaxed/simple;
	bh=3k8eGYPX0IV6y7jcp2J4f00AARzr/yEL5pvSwM4ks2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZoeCZHZKSZMrydEYjHAOpwV9yduk2B5tC/Lqm90i7hWj3ZRekuoQf+CyTXfnbfZFJGOzd8ysxJP7Owd2iWMqxCnPler2yYhAfc2bAcNqX1s9q1PjyBMYQjWi873K1YB1s3/BQ2EiW9F6HdVUpTK90qmfrC/PRRHRHgUAAUGiVMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n4UZjoS9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p42NuNDp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfYZe028562;
	Tue, 29 Oct 2024 18:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n/a5qI/qPIV7EvCPopGmVIpb6ZM0YGR4l7zVgmrebNE=; b=
	n4UZjoS9D3khq/DjBOCIyJIK6cJTi4yu5yjMUNj6u90AIc3M4Fc79eWlKPFfdAyc
	Nbh7mKgv4/iGqXIDXvCJKoWhJvPucj7chMw/Jq+1bXPWeJJ7+aNMKHhouPv9TTdu
	ArBq38mKXFrMvqUc247dIAZyUXO7ZB6XzcM4mZvfF2IQPaeb40GOG8LshCabpu29
	52pGZUhp9MvtvMNYMmlk+WpvDXbbNmazk1be6t58gRCOj7TMgg9SRt1vfp64+KYy
	bT9ZNdtklUBupfMP4AAoxC2b5Ug49CXWeRjQqh2hadrg876CHTarGBznH4G/5q6k
	HLH04YuYVKAEjxFFU+B4eQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqe5xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TH0i3d010118;
	Tue, 29 Oct 2024 18:12:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8x8ww3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R//vmjpoxzcvTXtvSLKyF61VLqg3wAx+5aXRmxYy5JIyjPYJndonD7Mx+R5PFNOWsxqcIWea7SHxPMcPWAeFgQXw5xlx+MX7BhSXh1VTmpZ9xxdvtX49/tIf1/JCLuGeUmWwu9oh0l9xOrBQbqDiAuqRyicuk4xjN60WZK7Uco3ikx6RSvCLFOuBIqAgfRw1Eo51IlZ0StpNXPEB4Ab/9KH+30HI83dWnlhs5sTBs4ATG+G9LhH8/Yn0ROzg6lvJ6NJ1YrSLHfW1lnBgauhbPbZzs9HKbdyP1/EH2rpSOtXlapRkt/+ZZ4BX7IdbYzm2v+3ZjdWmZkCq5JDSeISbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/a5qI/qPIV7EvCPopGmVIpb6ZM0YGR4l7zVgmrebNE=;
 b=TjKY8OmVryf6BSNSFQMVi67c5XJlU5joWLS09vyy3p9ku880UGSDtbS9AySh13keIRSdxGxvDNTxT6/5Gka9WnuXnssxTOY6uRWRRNBy/WtTi0gXATd0f3DGB2HEFoPn4z3y/W1KiEobGqCRy5AQWSpjFrAA3SUEUuy4XimBdepJgrcJicjegITdlOtBGWD/l2wThW+E8GTaFeZL4WUiq7FfdH10r1n2zYm1N6stcXakPSyZ1qJ7JaDbuiHiZnTEJdlIw1yUDx0ic0phdblGTZ/D5D7paebhR0WJECIxSDv8t+Z/TcmTYTvtfA9h1elBweuX1Zs1bsNodfD57WSPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/a5qI/qPIV7EvCPopGmVIpb6ZM0YGR4l7zVgmrebNE=;
 b=p42NuNDpBm35T/Hu403uX/30VEARByAEhFTgEE8GPcD3zUDJF5Q+P2TuB7naQbhqWSVE2UMWDESAUFAaH+ajPxMGpY/UwWZEhdWqhKds7qXNzl+hd9fg/1inl8T4T1b028y+S9rWpjqUSES+zuJSyC+IkU4gFY2mCxZZjOhLiXk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 29 Oct
 2024 18:12:12 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 18:12:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH hotfix 6.12 v4 2/5] mm: unconditionally close VMAs on error
Date: Tue, 29 Oct 2024 18:11:45 +0000
Message-ID: <28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5f6cf4-72fe-4f5f-4ca2-08dcf8453561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?lVTKyn/UniBN8nhqViHeq6eD5LQOzvvduO5ASVCOCDd+k7EkDp4Kh6sHOLNJ?=
 =?us-ascii?Q?DAk7ICHBpXpvFw+afw1MH6ollc1k0pNFtiytni7y55yZDfoSZ7wiRE40DZeN?=
 =?us-ascii?Q?NTeNHnjF91ZPXutmmDYTH8XSrSTEiYeY+OZ5fYJXnDcQiKoaTUF6x44as3UW?=
 =?us-ascii?Q?WyKI9G3+Pg86y+96yLwIpZI+1CKv6pW19CBIpXwBuKO56LILvZt1vaO6bwlo?=
 =?us-ascii?Q?0oPIxPBdI9HWKzEmnglNx4Z7JS3jG3Y2NJyPEMPoKz4U9NXXjWiGjsXbKccu?=
 =?us-ascii?Q?rWdZs0GjetdBrLmiLCE3Rew+KngPCU3s9Zjl4rXetQviUIa+gmyDFkGJbzV3?=
 =?us-ascii?Q?p8VefzfBF99YmGpVmAvmt+MC+4wQTf6Vb6UNW5RwHJpJ1ynK4cweU4IqaEP9?=
 =?us-ascii?Q?Pu/ukSejM0ayxt7VkTGCVQqpESH7SzQeLhsVlPcv+3xmTbP45g5YJNZGo7Fz?=
 =?us-ascii?Q?uEwTFBEy/rW/CQIiutz3DCmaZTbfMaAAT/UMXqKsEP2wEB5ZE8mhVgpRnR5K?=
 =?us-ascii?Q?I02L1goXhFYQA7hF6FOhI/dl8DYZeLBnjHH2KUeaHluBiY2MtP4G521M6ZeL?=
 =?us-ascii?Q?Qr6Vdv2nHo46mpa3BzGKJk/RrWpxlXJZA7UYR5DzrOKjw4+AgKo12wukf9u2?=
 =?us-ascii?Q?mrpG7M1aje2+CaeveDTpBCFf7xfNsnQ/kVgUVPzoutoZ4K+NMuhRhRH6WnvU?=
 =?us-ascii?Q?sZOE6/+F+0k9TsDkObz4q0hsYY+DkYPqIf5g1iQmwfAchoi76sYSK37YQ9J3?=
 =?us-ascii?Q?cHv0qRdCuO9lQsLzRNgXX6L8gY4ylZH9sSbYVS/qtk8fj1yvfJE6keA6zRoF?=
 =?us-ascii?Q?rPP25at9aBssU8cwByWE6CrlLb6f7oNWqcTaVIrkEH2lBKfGqYNZ7Yb7CzJf?=
 =?us-ascii?Q?VXiZHV9NkG3c3BppIerpXsWwGq801H71/5fn8nz5MNbfuoJrEeyCiodLWhtx?=
 =?us-ascii?Q?bbLjgvQyY6suguSgsOBYnNhGgKgr6wpn4LSFbAs4ySNaW/obbUiZ1sFTEglW?=
 =?us-ascii?Q?RVY1MTg+rMItoiKGuZaVoat2ltWHlNKm3CZQIOv+nQBDvxGkCkN5Dr5bAC5J?=
 =?us-ascii?Q?GVF5FmGQJBhg0SGKt3uUgJxHVdifSW/OoCanPxgGK2wxbw8dpv1yUjcrVu27?=
 =?us-ascii?Q?fFFqTUUtuNtEZ2XyKVhFQwZgfXStADL4eEbRu9rXf/kn/VApwTAnuwQ+8gc5?=
 =?us-ascii?Q?G0N0GrmG2pMve7mR+cXkuUoRks78bCh4ynlremVfta5HHwh8bW5pTAG8+5PE?=
 =?us-ascii?Q?0x8WLGK9hvwMKrVhdK/xaIXg7Ly+lirjP+Ji9Xs4Sj3D51QIwD51UTiOYIC6?=
 =?us-ascii?Q?Rbt3wgPwG/u9OxOP0bLqEOx+?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?l05g67BRhYr6lt36+LCPE3cwtFD3Kc1W+OF7kSPhVuwNjpAvRmU3zFUvCahl?=
 =?us-ascii?Q?HOlZGnLFHsELsBD3xPuqmClPs4pUWmTZvY9PRY7O50cPjPzMAe8iDZ79cm3P?=
 =?us-ascii?Q?HZQng87bj43fNkgVP8tt8ylNVHUDp+xOdIkfje40SK/yHAn0Ay7yDnm2tQJ8?=
 =?us-ascii?Q?ypC9yCGZx9uI7npZ/2CIwd2aEMwjxQDYmWfeDixekwX8ApYwjPguglOdSvU7?=
 =?us-ascii?Q?pbxPqjANMmlH2NB8zj+VvV2qV+xwe9N5T3ABzlPcAPKn16DV1PEfR5JQ0Imj?=
 =?us-ascii?Q?wq+zi3b05BDOC16OWpzYiT6+wEVX7s0uVFynN+8aEueMRb6rSh6KfixDVUrv?=
 =?us-ascii?Q?9q08jMGVks4HVl8hJsqv2403P5x/TrhrYcEV/Kfyox3KSWQXgt2WvEv6KgP1?=
 =?us-ascii?Q?6CQUzjs/Ucv98zLbka59aGDlwVOQ/vIsY+zsxtuNRyQ2kKpZVxsYU8i9JXT/?=
 =?us-ascii?Q?2+G9DKPAkO+hwC870wuTRdeo1/SvwT6HusCqCF+2kaSwsUya7c69Nx2EADGW?=
 =?us-ascii?Q?Fc94Wh8BElFRMcsYU0GQBDDz3g9Kd4y3hLH5LVsReoZLjeEpqxrIbnevClG7?=
 =?us-ascii?Q?vowi/YB3b6XKiU6CAv0VqCja0A90sufOTyephC38FyiK2daTPgijPYK7VQzQ?=
 =?us-ascii?Q?tqTkavVapNfTipkQCk/c4VVhVGHvuHbAMza/KPb1oy5iizEpYPyV1TuwKzBK?=
 =?us-ascii?Q?VlpSOSEvCvRBfStnR8MNLcyp6pAhxP2UekQ7aTr2mIUBcQImxEQWUtU5YboJ?=
 =?us-ascii?Q?KtICL/EShx0FJkQUvd/jH4k9FzjRqdmFZlHeHTGDLLI/EG2AqyQSEIKHjqRT?=
 =?us-ascii?Q?V9eqQcSk8yxXgyguiW3Mzf0GcYKYMY2G9cGwfZEtaP6bh+gFJ3Rh4B8pFwfk?=
 =?us-ascii?Q?dTht/SyI8pjUe1XB/9vbVIzebBailVG0G2AvAqFAds9negJ/i5fnk7dSyvzw?=
 =?us-ascii?Q?UHzZ4GpYdnkJJyzDjQkh1Px8qudVyuBhCQBG/npWMUgCztPR3GE92z5tXEp5?=
 =?us-ascii?Q?v+TVAp0g5kxgmrRLw16M/bjYHLOweE58ZgWJ65h+rdp9Z9y2ZL5047wrt1PZ?=
 =?us-ascii?Q?gcOisON5+DACNWhoDSaWluYKAhgQzXTw03JPj3GI3HUeY1QVDsTvyaGXg2kz?=
 =?us-ascii?Q?ad8z869qhWJf1FA++G7iIs4qd4muPqoen8U/ay1wdzJiOVG5DvP/qgvDu2aD?=
 =?us-ascii?Q?sRDbJplYLhyFOxDIFgo7un07oFztQJ8rLuAdha5kKbIHDRc5w0KKB8hOm4Oh?=
 =?us-ascii?Q?HTanaIyQY0K6v/QFJZMVNYY9S7GYyUf/3wXiTCSedFttLau+zjYikhhQV7oS?=
 =?us-ascii?Q?ktPISzYEJDPr0y5a2wN9TKcTMAskugllSXlBe2NeOCZITXzhALLjAuZsnpKD?=
 =?us-ascii?Q?jLZY31QfpwlbN/JEFUdBoB9LdENwYH7nTp36FZ2Fy2Y5c4btT159UhAKDhe6?=
 =?us-ascii?Q?/YywIKJ5QJm4JdTeBlIRuieNsc1vOtebB25eeSNRqYxrFMBccYAsJvZjLg6/?=
 =?us-ascii?Q?qsWHSxoZu453FXiGUv7c9v03w5WxsknGOY1ECkV8xC20imtko0Rp/iaUPAzF?=
 =?us-ascii?Q?+Iii8d0GLer7AoM0cET4c5sDQN0A8lnr9FcK+5z2TJTZFMen3JGG6cWVtXwO?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 efByVV7VyxrdRD/Bvcshi/5QZ0E2xRaNgxYJK/JisTyDpLCQ78p7qa/hwWuUM6k7v3gAWVxIK+d2F6hQNGb7+CNh5EI2tX3JcI2USwLFi4KhVB10mWLWDCvJ1f1z1kjzjsjMzgcqph7W2gY287pJq9NFn2L0zkjE3H3rxVFuXcct1JBCoQUW49dhFLObvvtAhiFX1Nl3+1Yuvtzy+IjPunobhFrPWIG54MJMri21aj50I5hDPIBk2hjPP24jCAL5RxcTYWpSacbFPsKBanRILIVJuKX1OKvJdCvyewr10yNLVW1iJM6lv54ltHlbHvc0oM9eGijURihJ5xKq20tOUsUxmTWfeGiokU1S5pUs9SkaT/ms9aH4rpK2Ozj0HEJ8qpVhtVZwH1e1EbYYwp4/bTCxKsf/TC8dk7MIGCmQKjBO5QGTsyJyoVXYp/j/BXsSmXFxY34ufMC9nj44a0O0a6g9R2bISTG+L3k1ts1GthzHycK/xmX+YFZzDFKbBEYxgD7m7TJENgryMZ18qtKwcaBQJEzOlS4pUQG4DaZw37j1btN+DMJBIMQyL8wLdPl4QzQxdbYTWj85l1Nm5HKOeU/p8DhZWpLTJBhaAFBUFy4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5f6cf4-72fe-4f5f-4ca2-08dcf8453561
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:12:11.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSJ77UMuojcsCsd49mkvf4oA6aQr22nT2K5ufIOjxX77j015NsI5qYlui+LWM36smLT0QpolojI0BHsxeP8ZheTNP+6YiizpQUkYsS8GQE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_13,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290136
X-Proofpoint-GUID: t7dVrWr3N08Q_sPkB-9aYMw1QthhsncK
X-Proofpoint-ORIG-GUID: t7dVrWr3N08Q_sPkB-9aYMw1QthhsncK

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 18 ++++++++++++++++++
 mm/mmap.c     |  5 ++---
 mm/nommu.c    |  3 +--
 mm/vma.c      | 14 +++++---------
 mm/vma.h      |  4 +---
 5 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4eab2961e69c..64c2eb0b160e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -135,6 +135,24 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }

+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+static inline void vma_close(struct vm_area_struct *vma)
+{
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &vma_dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_MMU

 /* Flags for folio_pte_batch(). */
diff --git a/mm/mmap.c b/mm/mmap.c
index 6e3b25f7728f..ac0604f146f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1573,8 +1573,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;

 close_and_free_vma:
-	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);

 	if (file || vma->vm_file) {
 unmap_and_free_vma:
@@ -1934,7 +1933,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
+		remove_vma(vma, /* unreachable = */ true);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
diff --git a/mm/nommu.c b/mm/nommu.c
index f9ccc02458ec..635d028d647b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -589,8 +589,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/vma.c b/mm/vma.c
index b21ffec33f8e..7621384d64cf 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -323,11 +323,10 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
+void remove_vma(struct vm_area_struct *vma, bool unreachable)
 {
 	might_sleep();
-	if (!closed && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -1115,9 +1114,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
-			vma->vm_ops->close(vma);
-	vms->closed_vm_ops = true;
+		vma_close(vma);
 }

 /*
@@ -1160,7 +1157,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
+		remove_vma(vma, /* unreachable = */ false);

 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -1684,8 +1681,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;

 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);

 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/vma.h b/mm/vma.h
index 55457cb68200..75558b5e9c8c 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -42,7 +42,6 @@ struct vma_munmap_struct {
 	int vma_count;                  /* Number of vmas that will be removed */
 	bool unlock;                    /* Unlock after the munmap */
 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 	/* 1 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
@@ -198,7 +197,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
 	vms->clear_ptes = false;
-	vms->closed_vm_ops = false;
 }
 #endif

@@ -269,7 +267,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);

-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
+void remove_vma(struct vm_area_struct *vma, bool unreachable);

 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
--
2.47.0

