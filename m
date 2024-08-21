Return-Path: <linux-kernel+bounces-295382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6141E959A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BF01C21F93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C53F1C8715;
	Wed, 21 Aug 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oJr0CG/S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z+uIDS0d"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB101C86F3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238155; cv=fail; b=VuLNYQjdwU2xG/XJlyrse54hpfO64WFlHWn/w6J7eevysrvw+y/6TFdIb+6GIKKSAH9y1DPM4TGCfqKfRiwggNkd6rBQH8bHhpD4YFqz852nt8Rz3LhffN5hqhUBcAKufUgtzc9C5LcgkBbCX6wBs39ahg8J4zpgzJ6f1fLSMJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238155; c=relaxed/simple;
	bh=kNgqf5D5ipMTWgVREAPVHPyaZOx6nEwqffhJ0dOtfkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c+4hiPcq2/hbNrhDT0ipfVlOeKwsrLHTKw33QT+NAikX4nCXE5VHHR6s4pE/5JZ+HdWVHMsnNcOkIy2Dq2r3+fklyUXjuQGfQ+P224XzwJyXPvlT7P2BqzbiErv59T/ysBHJyY6J4vP2+k4k6zV2Xujs4KsztJUwv/i7+P83ZM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oJr0CG/S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z+uIDS0d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L7tlUb006299;
	Wed, 21 Aug 2024 11:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=tubobC55HkZ6vvX
	KKyXV3ndEmhuSOCtQ12ockVLYlt8=; b=oJr0CG/SmpHPWNcv0f47VCMZ3Hrkg24
	u/gfC/JGlZDUZE8gREF8U7Ry9xiNLgT6eEmYS3zjppcwX2evH04Ls29Tj9WPU1BH
	rP7kOS696DYgMu1qYPRZ67uV9GnIN8pxJuWk/zSEVH8qK15beaLSC0cb+eOkRELa
	vJORbEA6tAcCmc9yMlugynKTEqujACFCyvZdYAs0//7/2h3celmaYs0xKVqtGP79
	5YvtgDLOUhJwcLYE1cWcmLiIQGMEIeKVCR6I1ZyfS4Ql+3UjwJUNbr5x2PXohgh7
	sLP96GJOnUIwNwqpQDO851qqwR3LkaW0/6dE/5Pb9tkB6f8Kklw8R9w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45f7j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 11:02:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LAQq30035781;
	Wed, 21 Aug 2024 11:02:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415cwsw605-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 11:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njvjF0wRdP/WEfCHiyh5QsaHOOFucEiRfwK/xGZEqvbOnZCAf/rzV8UekSRRT3nX6K7+0yODPE6Q42ZzGddjaO+ORNvGz3y7vRp1ycN3qhmHhYdsK536WxdiXHsblSh72wv2VsE42kvG0dpnDVAgtULJHMmBpOqYxwz2BeryX1+1Bi7dTYJzed/E/7kF4/XEkcsCP4APmv5RSHfaC6Gz4L1b6I871r/B7GlIhWIUBL4MW0DNS0sm70xxBMh9KB4qw8N6CiQi5lzq0JpN7NnSZ8N4dR8niV94919ZJ5hzbvDzOOGH1wCpLUknTPBLjKyBiMDlwc+QhrvRJ682BLLt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tubobC55HkZ6vvXKKyXV3ndEmhuSOCtQ12ockVLYlt8=;
 b=mUjy20hYvEpZXfOvhJFcIHBjNs12wZbU2nVIs/6qu+arwhsUy67okbxvjE/ZPTC6SAom5USkfSUExD0CDYDsuQ3llv84Xnh/iD2IdAnRFwlhGlVJFtCGccXy6Pv4zIqOhycnoQkVVl4mPmsqjbDCj4DHlH8VzRs1n+X3CuR4CxvXjujP/6eDYkju5GaNPlNxu0BdvKAfTAGuZV9xcI/jJ1wLNRajAala6npB4EPl3Lw1QT8pvZDdqkwo3QIOl3gMxC1JYFf+iCmA/rwb991rl8fFCfmwcNi9eGWLPNGgBmQdxKZj8YF+xQC151mOwl50HlH5zdz4Gvao0iyIu+QlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tubobC55HkZ6vvXKKyXV3ndEmhuSOCtQ12ockVLYlt8=;
 b=Z+uIDS0d4SL0wKS78jvRl4Rdq3hDiBW9nu3+koq7q6eGo7e1ZBjslPwWSdwdXRWL7ycqIu4kj97yHnN7ja9TMow6UzhvD/VxSndWc3ZQf/61pQNV6g6OsAVxrsx2mbXZmlaXMgBW0RWzxX0QOs2eFbLnFOX1AOXSa3xSYhDgVGA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA2PR10MB4554.namprd10.prod.outlook.com (2603:10b6:806:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 11:02:10 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 11:02:10 +0000
Date: Wed, 21 Aug 2024 12:02:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 14/20] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <22b6346d-b8a0-4d89-b886-1ac2c9ce6ba4@lucifer.local>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-15-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820235730.2852400-15-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P302CA0014.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA2PR10MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5a1c4a-28a0-447f-30e6-08dcc1d0b465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c2W9RjLyMVuV4bQ98EYshqNlbg2AGDDN/UYusfWCebrTQn9IGFIMWxTYTHAO?=
 =?us-ascii?Q?0nZMuwAF7UKuGpmGYwdutAn/4WfRUgpETsCb7bXaIBTegFQbQpmlN+NTlDLi?=
 =?us-ascii?Q?iz2gdI9PFV6W7mbnXt5ZqeOIdXwh+ge4XmTqkvoXl8pJxX7TD7tETBZ6zmpP?=
 =?us-ascii?Q?zNd2bTMwUM6BztlfwwvkP8TwMKDt1rlUA+NXlZCovDCKn4sHcMREo9hdwMSf?=
 =?us-ascii?Q?BKI1qakzORJZXsRG+fHIYVyPH5FGNRj4aGDTt8S63H7FWFOacrd2P/Fi+0+6?=
 =?us-ascii?Q?dYtWtTOq0a7BNz5SdERIWWik30eoYeNLOXQYtV3EjxNmGq8oNTrLPGxABygJ?=
 =?us-ascii?Q?2V1l5oK0lBHmW9n43lJANDvhuk+Qv8dr4+TYdx0zq30sFXUFP13+HROdjM1k?=
 =?us-ascii?Q?0YMPH1sXVgE0GlEBkM1vNq2bG7zM1kZZzyzMIU0bIanOe/KlbHyGJ0nM5nn2?=
 =?us-ascii?Q?feu0AJQBqkfS3k4FQRt3FIn8R3lKM/JtVUl1yGWEAFFhegP5A/KiBsOsadMs?=
 =?us-ascii?Q?bO4s48zpHY/88wJhhGI2TS4KBqY7ZESkN+YkZNpkUJ2Nogl9YajxaCdEwTd9?=
 =?us-ascii?Q?jaXvCiVCfspUZlzoa3fqEaAaSY52skhJKiyuvTjVYrRU/pKwKFmmXTc8tz48?=
 =?us-ascii?Q?bPLVxgHH6eweydjF7MjQw7gUfDBas5iOIkGnQQIEwhlDCme520lD11FURMEs?=
 =?us-ascii?Q?2rzghwmXMixN7OcwEYdEHL7G6MKYaYwXBFmq5wntmFOM0BHl59Rfv8k+oiim?=
 =?us-ascii?Q?+LvGLXXq9vvvbIhohxiZ5kWqbsQ/l8zycVY7y4nDwbPtWmNOxBZIZM+xOFEq?=
 =?us-ascii?Q?iODBtyKSAEaYFtKid1xDlpHm7QaohharQcpD0vL27TM1gtWE1QArx1KApUTW?=
 =?us-ascii?Q?yc6s3fCn7o6jbYDgnicWnxGI+lOtnjW2ZFCCLqu+sof6kldba36iWAndjBJc?=
 =?us-ascii?Q?iL4+ZXHOYiN0K7O7/S3Emcf6zKCrpIqK5OPOyce57ytl4sa3chdBApN5DLFS?=
 =?us-ascii?Q?Khn0eNMkmt1q6fzS+mW+XCXDy/i2XI93CSodi1D1rB/QWT7ehA8CVaN83sy8?=
 =?us-ascii?Q?d3r0mCA5olCw3w3GpRD5iJOE8Ju9dZAmlqjcXKl2dZgs+EZdIr6wgUYCAffv?=
 =?us-ascii?Q?OkPdCgAY+G13cVRz5oerecZWtAJBVal37uQx9cBaUWzuvgElykFFSGwqswnR?=
 =?us-ascii?Q?jTIho8eGu7bwVqMHxbt+Z00kV4dxK6n/pMX4xxPF3xjOtaeOIjHfjkrDOXLm?=
 =?us-ascii?Q?r0kTN7rVVuhlqAM6yQ9xGH+6AUM2CfJpvNdE0LCCPE7X5ggEp/q6UDqWNMTy?=
 =?us-ascii?Q?5kO+gEwbb/i3yHBFhzk21dbJ7CyK8Jn1ispi/QPwZRLiEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9YgSAH37ZyaJs1FSt8IgJwHeiKwJ7z3VTJDRnKTk37dcR77IaQTJXYsaErZ?=
 =?us-ascii?Q?zyX5XZc1OMENSGHswylIiISth9b1ekZVj6kiLBocd4HuAtjeU41FGv7JTRxt?=
 =?us-ascii?Q?75A29trSnIO5PFTfXimvkB53jJno//LgLjbTz3QEn88+oQq7bMzUEnewrSQf?=
 =?us-ascii?Q?tHPDa+zZnFJrhh1ji5XFUMFMR0EOQUG4PHDsPb8aBjVxOtBIAmfCeykQqDBx?=
 =?us-ascii?Q?yCbD265G2Iv6eS+6a6Phx812Q2pQz0F/aMP9IPZaUwa1n+KaC6lB4CBILnxa?=
 =?us-ascii?Q?24bOtc78L9V6SJsQ9Tv/Y27TN5EnoYd/jeKITAhEJtR82Z+vHIoe0cbRLMH4?=
 =?us-ascii?Q?ZivbRTXEkhslKGM313QvNSKdrmofu+1RWhJQRTKuJhXVFJQP6HTzh54Tm9Kx?=
 =?us-ascii?Q?8kTB2Jczi3Z4sL4j4ifdZG1bU2dQ94cQyHGKwv7VcXvex6HQyGeheLu9N7c7?=
 =?us-ascii?Q?KsF0+aIGZt63lMVD2zd3/PRf5Z7wqYVsoEuMUric47eO8Vfr5By92Ci7FIn0?=
 =?us-ascii?Q?fGfTxjZdTobgHrQ4G48iTlU0+FXLPqItlzIYZLzuD3BI668vzHMhuBRRga1t?=
 =?us-ascii?Q?istKqWm3k+mfWID+A/vPO5q/7nOCnss+IdXYNyM2gW7RKAsKfWy6eoZ5d4zn?=
 =?us-ascii?Q?mTh62u6vFKunMfsv+FJek9IIxunn+ZU8dndr5PpYW8zpvBVBdIfdy7qyFj48?=
 =?us-ascii?Q?0Q8tHz3HPmDBwu7Cqe3OTqQGmCwsi4EN9OwMH2sjV3oJ/XGLdk5juTIPtY8L?=
 =?us-ascii?Q?J/GKld+4B7W+RRylMMiwuubgmMlGN4AsUIeo8ztaaTGBAZ4oQtTf5nNjdsVK?=
 =?us-ascii?Q?4em3ToXWJELDGH2ARFojmqJZUKWg+nZrlMpnfJsDorxk1R2Bji73gQwl0/1y?=
 =?us-ascii?Q?dciMHtLg+6aOrfeUuV9ka/YuPEikMyB0s9z2NaKUf9KiXAVOKj8GiZHDcfWS?=
 =?us-ascii?Q?shHw1aGWBdpie7n+haES8rbjpWNcpEYz2ziOLyqS+VM+f2jYHrMzxjWmeAg8?=
 =?us-ascii?Q?pYJck6scVii/5m2NnwYfqs7iLGCJ2NXTw5dsWVc/sJ8RlpalcWQgfffWQFME?=
 =?us-ascii?Q?VjaZePGNdyGuq1gYyljoS9YOkAiIET0sYXH3Mzqj8HfZUs6qtkR8ShiT250s?=
 =?us-ascii?Q?D6GVvtkgZZzekZRTDJCouy5V+7CsvKLXRY7nKmCuwiTghH0mFdFgjeI8Le/i?=
 =?us-ascii?Q?QJWxwZlFFNGeUFum50sNJMS2ssEQdVDkZ0hCznecG712av9FSPzz5wEhhcS8?=
 =?us-ascii?Q?w/OrTKT8m0bRqqFfY6znK1fMzyTpOFhCGhri7TioVNPU3ysMhG/iRoWLY7sF?=
 =?us-ascii?Q?9XYKmW92UZGAVdNGBrzRsfGDdHWEw1uuyc/ZgSi0+XrrodxgSbnmM79XifQu?=
 =?us-ascii?Q?F3yk8KMCGOUljY4gOn4XY+lq+pLBiGRgVL1T92YET1f/M1o4nZ5Si2/ugLOy?=
 =?us-ascii?Q?d001HItJT1kDuHb8Gqcqp3yxhVs+t+P6w7LhGHTcCmB2YtrBpJToAohUOMwf?=
 =?us-ascii?Q?6W1ZxkawGsZ7tIdEg8khAirYAldkB3t3JmZ6Qrjfz/JKOdWefxcczWS+cSRz?=
 =?us-ascii?Q?xfJo8v31kedfD+a0d530qoX+/bYkp9SVEhIPL/TyY9DTJFn/WZs8H7lk059/?=
 =?us-ascii?Q?kwe2HFhgYOOrHcUhbHU74EtOGXjD7Od3ab9KlHSeIhRgZBQF+3/yB1qGYUAe?=
 =?us-ascii?Q?HAyF6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f7p2YcAPzrZyLSnpPjMIJRjqwjcC97064NKqCbXO2QTISh83ojJKT9yzPEW5pji6CXAewh9ouhPfKo7wKI24RX5fWYo7IiRg/rG1xgMM8aFQRz9trh5r3Sgjioim7qcVttyZj4Z3nj9NwRQFE450h235l0l1OnDQMQi9guSvoQZeLAfDDNidvxN5SCO4GTKjt17zI2whVzwff3Vek4YP12qOkoEMJW3g8Fao1lSfTsjN1SRzyf/DSvedM997Pa6IXE3gby0cC3NSwAY3ara1qqSXPdOi5xhZaaU3A/OAkxpUovv0m7zcRrM/6fW3J6bVhDc5w0aEswKWUKcFahF37sCilrpMJumdmZjNDJD6Jt3yQqMV8Lt2SB5BsNGRXtPl8jdDiIZiIPjsh7fKBzmC/3Ip1Q/iTrRhAlmxPLhecsJcKly6Yms/rbAGpeQzXumSRK3PYGnxPc9rAytawZrofk9TaaptyTN9wZH0RNX5JGnJNY8wf2TOhDJiBTiu93xdp+k8wdhFBkyr5EavFb3dlJVwPPGMOgU4kceYWG7Jv34RRqYIsRilT+G12WQowrTS7VR7tR2F9QqknB6msZ/PvLNX4VcLhcorN8oA9OpNYu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5a1c4a-28a0-447f-30e6-08dcc1d0b465
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 11:02:10.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqY/G1Cw3Y2SO6THnVj6pJlnFXl2hoyVck4UFxtAcXml9HXBbNjREa01f4QMJMGAnZwXgKRVYr0i8koXcx3vCEk6zWPUuHdW+Fl40nivAjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_08,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408210080
X-Proofpoint-ORIG-GUID: SUaldqqb12XygW1dPxChSq2TtcLx0PGl
X-Proofpoint-GUID: SUaldqqb12XygW1dPxChSq2TtcLx0PGl

On Tue, Aug 20, 2024 at 07:57:23PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Instead of zeroing the vma tree and then overwriting the area, let the
> area be overwritten and then clean up the gathered vmas using
> vms_complete_munmap_vmas().
>
> To ensure locking is downgraded correctly, the mm is set regardless of
> MAP_FIXED or not (NULL vma).
>
> If a driver is mapping over an existing vma, then clear the ptes before
> the call_mmap() invocation.  This is done using the vms_clean_up_area()
> helper.  If there is a close vm_ops, that must also be called to ensure
> any cleanup is done before mapping over the area.  This also means that
> calling open has been added to the abort of an unmap operation, for now.

Might be worth explicitly expanding this to say that this isn't a permanent
solution because of asymmetric vm_ops->open() / close().

>
> Temporarily keep track of the number of pages that will be removed and
> reduce the charged amount.
>
> This also drops the validate_mm() call in the vma_expand() function.
> It is necessary to drop the validate as it would fail since the mm
> map_count would be incorrect during a vma expansion, prior to the
> cleanup from vms_complete_munmap_vmas().
>
> Clean up the error handing of the vms_gather_munmap_vmas() by calling
> the verification within the function.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Broadly looks good, some nits and questions below, but generally:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mmap.c | 62 ++++++++++++++++++++++++++-----------------------------
>  mm/vma.c  | 54 +++++++++++++++++++++++++++++++++++++-----------
>  mm/vma.h  | 22 ++++++++++++++------
>  3 files changed, 87 insertions(+), 51 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 71b2bad717b6..6550d9470d3a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1373,23 +1373,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
>  	pgoff_t vm_pgoff;
> -	int error;
> +	int error = -ENOMEM;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	unsigned long nr_pages, nr_accounted;
>
> -	/* Check against address space limit. */
> -	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> -		unsigned long nr_pages;
> +	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
>
> -		/*
> -		 * MAP_FIXED may remove pages of mappings that intersects with
> -		 * requested mapping. Account for the pages it would unmap.
> -		 */
> -		nr_pages = count_vma_pages_range(mm, addr, end);
> -
> -		if (!may_expand_vm(mm, vm_flags,
> -					(len >> PAGE_SHIFT) - nr_pages))
> -			return -ENOMEM;
> -	}
> +	/*
> +	 * Check against address space limit.
> +	 * MAP_FIXED may remove pages of mappings that intersects with requested
> +	 * mapping. Account for the pages it would unmap.
> +	 */
> +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> +		return -ENOMEM;
>
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
> @@ -1400,14 +1396,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
>  		/* Prepare to unmap any existing mapping in the area */
>  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> -			goto gather_failed;
> -
> -		/* Remove any existing mappings from the vma tree */
> -		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> -			goto clear_tree_failed;
> +			return -ENOMEM;
>
> -		/* Unmap any existing mapping in the area */
> -		vms_complete_munmap_vmas(&vms, &mas_detach);
>  		next = vms.next;
>  		prev = vms.prev;
>  		vma = NULL;
> @@ -1423,8 +1413,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	if (accountable_mapping(file, vm_flags)) {
>  		charged = len >> PAGE_SHIFT;
> +		charged -= nr_accounted;
>  		if (security_vm_enough_memory_mm(mm, charged))
> -			return -ENOMEM;
> +			goto abort_munmap;
> +		vms.nr_accounted = 0;
>  		vm_flags |= VM_ACCOUNT;
>  	}
>
> @@ -1473,10 +1465,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 * not unmapped, but the maps are removed from the list.
>  	 */
>  	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		error = -ENOMEM;
> +	if (!vma)
>  		goto unacct_error;
> -	}
>
>  	vma_iter_config(&vmi, addr, end);
>  	vma_set_range(vma, addr, end, pgoff);
> @@ -1485,6 +1475,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	if (file) {
>  		vma->vm_file = get_file(file);
> +		/*
> +		 * call_mmap() may map PTE, so ensure there are no existing PTEs
> +		 * call the vm_ops close function if one exists.

Super-nit, but maybe add an 'and' here.

> +		 */
> +		vms_clean_up_area(&vms, &mas_detach, true);

I hate that we have to do this. These kind of hooks are the devil's works...

>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> @@ -1575,6 +1570,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  expanded:
>  	perf_event_mmap(vma);
>
> +	/* Unmap any existing mapping in the area */
> +	vms_complete_munmap_vmas(&vms, &mas_detach);
> +
>  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
>  	if (vm_flags & VM_LOCKED) {
>  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> @@ -1603,7 +1601,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	return addr;
>
>  close_and_free_vma:
> -	if (file && vma->vm_ops && vma->vm_ops->close)
> +	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
>  		vma->vm_ops->close(vma);
>
>  	if (file || vma->vm_file) {
> @@ -1622,14 +1620,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  unacct_error:
>  	if (charged)
>  		vm_unacct_memory(charged);
> -	validate_mm(mm);
> -	return error;
>
> -clear_tree_failed:
> -	abort_munmap_vmas(&mas_detach);
> -gather_failed:
> +abort_munmap:
> +	if (vms.nr_pages)
> +		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
>  	validate_mm(mm);
> -	return -ENOMEM;
> +	return error;
>  }
>
>  static int __vm_munmap(unsigned long start, size_t len, bool unlock)
> @@ -1959,7 +1955,7 @@ void exit_mmap(struct mm_struct *mm)
>  	do {
>  		if (vma->vm_flags & VM_ACCOUNT)
>  			nr_accounted += vma_pages(vma);
> -		remove_vma(vma, true);
> +		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
>  		count++;
>  		cond_resched();
>  		vma = vma_next(&vmi);
> diff --git a/mm/vma.c b/mm/vma.c
> index 7104c2c080bb..5b33f7460ab7 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -136,10 +136,10 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>  /*
>   * Close a vm structure and free it.
>   */
> -void remove_vma(struct vm_area_struct *vma, bool unreachable)
> +void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
>  {
>  	might_sleep();
> -	if (vma->vm_ops && vma->vm_ops->close)
> +	if (!closed && vma->vm_ops && vma->vm_ops->close)
>  		vma->vm_ops->close(vma);
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
> @@ -521,7 +521,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_iter_store(vmi, vma);
>
>  	vma_complete(&vp, vmi, vma->vm_mm);
> -	validate_mm(vma->vm_mm);
>  	return 0;
>
>  nomem:
> @@ -645,11 +644,14 @@ void vma_complete(struct vma_prepare *vp,
>  		uprobe_mmap(vp->insert);
>  }
>
> -static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> -		struct ma_state *mas_detach, bool mm_wr_locked)
> +static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
> +		    struct ma_state *mas_detach, bool mm_wr_locked)
>  {
>  	struct mmu_gather tlb;
>
> +	if (!vms->clear_ptes) /* Nothing to do */
> +		return;
> +
>  	/*
>  	 * We can free page tables without write-locking mmap_lock because VMAs
>  	 * were isolated before we downgraded mmap_lock.
> @@ -658,11 +660,31 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, vms->mm);
>  	update_hiwater_rss(vms->mm);
> -	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
> +	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
> +		   vms->vma_count, mm_wr_locked);
> +
>  	mas_set(mas_detach, 1);
>  	/* start and end may be different if there is no prev or next vma. */
> -	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
> +	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
> +		      vms->unmap_end, mm_wr_locked);
>  	tlb_finish_mmu(&tlb);
> +	vms->clear_ptes = false;
> +}
> +
> +void vms_clean_up_area(struct vma_munmap_struct *vms,
> +		struct ma_state *mas_detach, bool mm_wr_locked)

The only invocation of this function has mm_wr_locked set, is this
parameter necessary?

> +{
> +	struct vm_area_struct *vma;
> +
> +	if (!vms->nr_pages)
> +		return;
> +
> +	vms_clear_ptes(vms, mas_detach, mm_wr_locked);
> +	mas_set(mas_detach, 0);
> +	mas_for_each(mas_detach, vma, ULONG_MAX)
> +		if (vma->vm_ops && vma->vm_ops->close)
> +			vma->vm_ops->close(vma);
> +	vms->closed_vm_ops = true;
>  }
>
>  /*
> @@ -686,7 +708,10 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
>
> -	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
> +	if (!vms->nr_pages)
> +		return;
> +
> +	vms_clear_ptes(vms, mas_detach, !vms->unlock);
>  	/* Update high watermark before we lower total_vm */
>  	update_hiwater_vm(mm);
>  	/* Stat accounting */
> @@ -697,7 +722,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	/* Remove and clean up vmas */
>  	mas_set(mas_detach, 0);
>  	mas_for_each(mas_detach, vma, ULONG_MAX)
> -		remove_vma(vma, false);
> +		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
>
>  	vm_unacct_memory(vms->nr_accounted);
>  	validate_mm(mm);
> @@ -849,13 +874,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  	while (vma_iter_addr(vms->vmi) > vms->start)
>  		vma_iter_prev_range(vms->vmi);
>
> +	vms->clear_ptes = true;
>  	return 0;
>
>  userfaultfd_error:
>  munmap_gather_failed:
>  end_split_failed:
>  modify_vma_failed:
> -	abort_munmap_vmas(mas_detach);
> +	abort_munmap_vmas(mas_detach, /* closed = */ false);
>  start_split_failed:
>  map_count_exceeded:
>  	return error;
> @@ -900,7 +926,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return 0;
>
>  clear_tree_failed:
> -	abort_munmap_vmas(&mas_detach);
> +	abort_munmap_vmas(&mas_detach, /* closed = */ false);
>  gather_failed:
>  	validate_mm(mm);
>  	return error;
> @@ -1618,17 +1644,21 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
>  }
>
>  unsigned long count_vma_pages_range(struct mm_struct *mm,
> -				    unsigned long addr, unsigned long end)
> +		unsigned long addr, unsigned long end,
> +		unsigned long *nr_accounted)
>  {
>  	VMA_ITERATOR(vmi, mm, addr);
>  	struct vm_area_struct *vma;
>  	unsigned long nr_pages = 0;
>
> +	*nr_accounted = 0;
>  	for_each_vma_range(vmi, vma, end) {
>  		unsigned long vm_start = max(addr, vma->vm_start);
>  		unsigned long vm_end = min(end, vma->vm_end);
>
>  		nr_pages += PHYS_PFN(vm_end - vm_start);
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			*nr_accounted += PHYS_PFN(vm_end - vm_start);

Nitty, but maybe:
		...
  		unsigned long pages = PHYS_PFN(vm_end - vm_start);

 		nr_pages += pages;
		if (vma->vm_flags & VM_ACCOUNT)
			*nr_accounted += pages;

>  	}
>
>  	return nr_pages;
> diff --git a/mm/vma.h b/mm/vma.h
> index 6028fdf79257..756dd42a6ec4 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -48,6 +48,8 @@ struct vma_munmap_struct {
>  	unsigned long stack_vm;
>  	unsigned long data_vm;
>  	bool unlock;                    /* Unlock after the munmap */
> +	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
> +	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
>  };
>
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> @@ -95,14 +97,13 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  		unsigned long start, unsigned long end, struct list_head *uf,
>  		bool unlock)
>  {
> +	vms->mm = current->mm;

I'm guessing there's no circumstances under which we'd be looking at a
remote mm_struct?

This does sort of beg the question as to why we're bothering to store the
field if we can't just grab it from current->mm? Perhaps because the cache
line for the start of vms will be populated and current's containing ->mm
may not?

>  	vms->vmi = vmi;
>  	vms->vma = vma;
>  	if (vma) {
> -		vms->mm = vma->vm_mm;
>  		vms->start = start;
>  		vms->end = end;
>  	} else {
> -		vms->mm = NULL;

I guess as well there's no drawback to having an otherwise empty vms have a
populated mm?

>  		vms->start = vms->end = 0;
>  	}
>  	vms->unlock = unlock;
> @@ -112,6 +113,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
>  	vms->unmap_start = FIRST_USER_ADDRESS;
>  	vms->unmap_end = USER_PGTABLES_CEILING;
> +	vms->clear_ptes = false;
> +	vms->closed_vm_ops = false;
>  }
>
>  int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> @@ -120,18 +123,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  		struct ma_state *mas_detach);
>
> +void vms_clean_up_area(struct vma_munmap_struct *vms,
> +		struct ma_state *mas_detach, bool mm_wr_locked);
> +
>  /*
>   * abort_munmap_vmas - Undo any munmap work and free resources
>   *
>   * Reattach any detached vmas and free up the maple tree used to track the vmas.
>   */
> -static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> +static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
>  {
>  	struct vm_area_struct *vma;
>
>  	mas_set(mas_detach, 0);
> -	mas_for_each(mas_detach, vma, ULONG_MAX)
> +	mas_for_each(mas_detach, vma, ULONG_MAX) {
>  		vma_mark_detached(vma, false);
> +		if (closed && vma->vm_ops && vma->vm_ops->open)
> +			vma->vm_ops->open(vma);
> +	}

Hang on, I thought we eliminated this approach? OK I see you change this in
the next commmit.

Not necessarily a huge fan of having a commit in the tree that's broken for
(hideous, asymmetric) drivers + such but I guess it's okay given we address
it immediately and it helps document the thinking process + split up the
code.

>
>  	__mt_destroy(mas_detach->tree);
>  }
> @@ -145,7 +154,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  		  unsigned long start, size_t len, struct list_head *uf,
>  		  bool unlock);
>
> -void remove_vma(struct vm_area_struct *vma, bool unreachable);
> +void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
>
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
> @@ -259,7 +268,8 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
>  int mm_take_all_locks(struct mm_struct *mm);
>  void mm_drop_all_locks(struct mm_struct *mm);
>  unsigned long count_vma_pages_range(struct mm_struct *mm,
> -				    unsigned long addr, unsigned long end);
> +				    unsigned long addr, unsigned long end,
> +				    unsigned long *nr_accounted);
>
>  static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
>  {
> --
> 2.43.0
>

