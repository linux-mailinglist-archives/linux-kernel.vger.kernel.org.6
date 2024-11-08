Return-Path: <linux-kernel+bounces-401624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157E9C1D03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FB41F20F2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5CA1E511;
	Fri,  8 Nov 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iPIBEW6F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TDrCUjoz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3051E7C3D;
	Fri,  8 Nov 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069014; cv=fail; b=G5Jok2/xhg8U4ECjmCgeaYrx8GujjoZrGEKm6Whs4SX+XYA/pfalsHLRd/TlDmbhAwOJn0Z2ZLldpwkwNW/ovYca64wZUyY3UYwye+ixmP5pxzO47kvzUJB0+QKLy8MByU9EQtlmxXwiYo2acPA5KBWA30Ms1NqgMbzO9esuv2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069014; c=relaxed/simple;
	bh=yQtbsHKfbPdSLBsQwpDNFUwIGO+Fa/+aH1SESKoQBcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=leBPMVHTeAgG8PaqSajQkDq3336kqKXpNXbzeuOqnuZbEhtd30cpGxbxNS9IUOAtoHoKRYJn5NZFiG8o7E6J1yRpRp750diJA/3wAc0g3DAABsjODiGYrtEHprcVZWygwegSJQ891H0k5xoDCgpHmM+u1LUVe+mf7vPuP0E3UUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iPIBEW6F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TDrCUjoz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8BgRSJ019046;
	Fri, 8 Nov 2024 12:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dY7qtbCtm/XS75JUb6
	PbphC60UUbCmc2/q4k9h5nfx0=; b=iPIBEW6FEruf9SI2hz/vJP/1UFB//11lk7
	e1x72+3ZsKy08oCWq61XFnZSwRdpYFDS0/zK07XCm4+T+l60MJB9E5nW90t5CIBT
	DFelrNekfr/3Ywmx5thut9OA+pJOIOra+zyyU0IBfSx6sWKQCVsJxrkWtm03V+cj
	zZc91JN3zQXH3oeDAXOU2uw8UErNLL5ZxsmEx9mzaZPMAYoVxO3xm2YawSYHSxu7
	QSS2YdnNgXgD1ZkN4RGWpI/E0Vn0uafOH9a1GLChheOUP7HEexDcUXvWzSG/Jy40
	EML17Qad3leuYMqHzziVVpbUy+H2X0any8Fvpn4SOpICwm+Bgi/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6ggsas5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 12:29:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AvZAF037036;
	Fri, 8 Nov 2024 12:29:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahbj988-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 12:29:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2q2gnw1+FelRAo2MHZQIlBeU7HUmfWBE5RHKzS+v4ycRLKKxA2NVah3gxCCG4LZCkjnCKwV4VQEFRRLRKIRhy2pyD4hQhi8q0RwoIU228SJ3YsMHwey9soG/xo1R6VPfYwnal9xqpQccl2MktFwBRRYkwldYWNvQOf/RYyoLfv1NNxIOBR52/LMfliADMFJKlyj2Jh4P6kEW0jYE9cACTq9EdziHggKP6Xo/1y/OjyYgqkwh8bP/MEAQMDxtjfeRisEYCcGmWk3TqxLP3m5kEZPHDqeNFL/MjrxUwRDPDscIRGtCwirqXGtz81uELX0ob4xsubdtoFXxuOZ56Jfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY7qtbCtm/XS75JUb6PbphC60UUbCmc2/q4k9h5nfx0=;
 b=BJLpMQW7UVEWyysKavKoPh1VGsJZDTo5FaaXSM15Geqy55ZO4eYFTEJusSDg/2cQmEv1l39K2Kll2ox1pR6vH/BTBKTY8Mgj0XoCaR21PGchilN3EnOhZT5IBMsLityweSy8C9yvTQBRcHJCNzmjiWknSLoip9Biv57QXXkQY3My7X7sWLDY477XQsdZyuDRWFGsUwAIMHH0u4Hgnxruk24HcextzLQPuVY7MqKRVD/ti4+Rfr5Sm5/Y+nAz2wOAz9agQ28jlb6lHLm3wo6k0Coa8bItcmDhaAwMRvtfviRNkK3xNVbkD7nPQYQa7gY81ak6Ft8K5+KadFoZ7nA97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY7qtbCtm/XS75JUb6PbphC60UUbCmc2/q4k9h5nfx0=;
 b=TDrCUjozuq2SNePiw2LdXnExoFhAMeumYbYOaNqYxkNlaqtXKjY+t9AkhqCcKdCANISat0oYP9HZUCLSziJVXilznWb7T5RQwYBCD6LuF16oP7r2T68s0ViM09G8kzLgB7j7UYUI3WXPXA7uAZLXiRThiyME2syMbLlOPktzaeA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 12:29:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 12:29:19 +0000
Date: Fri, 8 Nov 2024 12:29:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] docs/mm: add VMA locks documentation
Message-ID: <b81e4cc2-fc86-4ed2-996a-ad78a3524f31@lucifer.local>
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
 <Zy4DQmWHpC_QMGTP@archie.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy4DQmWHpC_QMGTP@archie.me>
X-ClientProxiedBy: LO2P265CA0358.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::34) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: d58dd123-5050-483a-3ad0-08dcfff0f7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vHRoHS3GXg+PkN/+XOA+tDPv/6ix97supLZo0s3t8QKvzVJY2erlQTPquVJS?=
 =?us-ascii?Q?qAsb3/LsRIRoVEVjNAuqJ6qCZOW1+/KOs6w8d3zqaFa8TYp/uhPtUROOFf7Y?=
 =?us-ascii?Q?iG5L/s+m8ir9oge/0l+2TA8tqJG70oJwrtRbfZirS6IK5rJNba5xEEb3sEPE?=
 =?us-ascii?Q?Th8po5Qsi/nF/I/yOlwhOUfjbBQTw3POgZCdi/1LcqLvVr3GvgadYFIhYiGD?=
 =?us-ascii?Q?D7HR6BFAqLlwGt1ycBbfPQC7ERAyGg0TYswFBwwoDe5+wv89nhLgCJJAU92/?=
 =?us-ascii?Q?/b2LSPgZRpFKRZ301jxOMfjP78acVAm6xsvWqLA6/UJDlYk4QPHCufyHcQMm?=
 =?us-ascii?Q?egxPuy9JXETK5EdWO9cCIs/3SkvzRW0G/sW5roG2kbQI9EUF5psdUhC7RHRR?=
 =?us-ascii?Q?fW3QKeIrXW9Fud+oro6EmTy9LamICJQ7i2LXI0qiOutzvyuftiNJIyUqjbo9?=
 =?us-ascii?Q?PSrRJl6RyZ2k6quHoErTRj7bLaELzK1noQv+/cZFMH4cMx/FMjZKKlsYnGEV?=
 =?us-ascii?Q?JtlueOsEFe0EuQhuiu7Ee/HdY9o9NDgSn8uCKkFzSJso2LEsXdRbAc440q5X?=
 =?us-ascii?Q?PQ9UYE4o6ievQVUCSbFlkIR1mVOldWbStfBZ5HQtHnC42406CjFFEeCM6HYy?=
 =?us-ascii?Q?yr1ZmAleQGD6UztMNbjELlSiXCRkgQyjelV1jNCX19QauLrOKr7lMrq1TGh9?=
 =?us-ascii?Q?gc3xsaLVT/FWfSzJI/MVfAc+a3Rx0RiPx24GpqZQD8xOPF1zFLk9jHjkBUqM?=
 =?us-ascii?Q?kIQpU8vKHo7bUm3gJ28j8X9udxaULn3C+0D/i+ry6Pl5piDoZdYZvaf9/6In?=
 =?us-ascii?Q?2++mHvh9cWsc5bMYfMBweRpviZE/Q39VwwEikTCZCG9KJ+sq5V7LvfjmwAMG?=
 =?us-ascii?Q?AecNnezU+ZVVUiHrJ5RHm1QuGa/6gIlRPJfwdW7K/6uHTIWyEch/+VrnE3PH?=
 =?us-ascii?Q?BxeTVkk27EMi/lD74TRt9IbE8gXMOT19Y+wFVNk5l+CepywedtWmwatckhRo?=
 =?us-ascii?Q?2uqHnwS9DVY2WY8goOvnUvyieFhUhGEN1USAQQfaosG+qmIbUvuqTIkG40uN?=
 =?us-ascii?Q?uGwYq7DEsgQbGH/njAAu7UwRyJYzvtjwmbP2MiYSfCrtai2fARUSg+lzFHBD?=
 =?us-ascii?Q?zdhc57Ip60AAguL2cSCsEG/ondLv/xM+7d4Sny4gcLJVf3np6SdXsAar3LWd?=
 =?us-ascii?Q?xLAZqM3rjGEMMbnMeuhZRRABGzfMUF5mIlEJgF14jcsgGizcMc5tGnu8a5sw?=
 =?us-ascii?Q?He0F/EmkDyyXnSaGjpZ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wAB9xNFazLd3bxiRwMiJjE1QOiVyAV0RMad1QsDdBrbQ1BQgOslklK/7C5mz?=
 =?us-ascii?Q?5ZtAgC8/LVxM1P7zcur/v3PHUvtE5RZRHX92VIYO9HTGTfSa3djRxM0hC50K?=
 =?us-ascii?Q?lbNxvYSDW5OmHJOM94ys1/aHwXUZqxafsEArwpr48woyLlpcFonLB/RewGYB?=
 =?us-ascii?Q?mxNfs8oBn0XKEFk0TBEKCPolcNxGtGra/ZA8X7taH88Ciy+67UpdRifomsbn?=
 =?us-ascii?Q?EGAUfGzJKn21GH3aOeHaPRnsJrPW/nAEyO+p6Trv/7BBSjv560IFADI5+T6p?=
 =?us-ascii?Q?ebjOBjU59EQ3QfwX1F7du4cDGGr4MRYvioUNv+QZn8rYa6r386e1AJb7dyAi?=
 =?us-ascii?Q?sKVceYBjt/Gm75V+PQ7tfTUbQbdDiNLVYtszP1P2VeHKSEKJYSCwOA/4wme1?=
 =?us-ascii?Q?wB6M3KInqYvbkbOSMLTbzLCn8v0Hyj3eb33R9rrR9txiltP2H8iPKxuDMXOc?=
 =?us-ascii?Q?/v+DdxmE9+OTzYTCLsKGoD/J+fQ+T0p8HgnG3uG9B8zugeiUYEaAfCjJtJxO?=
 =?us-ascii?Q?rgHuN3A85/MEwKpfcT3lXObWvhDuyFxuE1wD2b29/8+LrDLwPk0LnTHx86Gq?=
 =?us-ascii?Q?W1Un7ZQcMyCL2JOJZOSl6GGOiox0XvhF1TmZjHxkiT0pmJUlJAfCkQb+buYx?=
 =?us-ascii?Q?pXoq6itBgK/XEntwW7C9bbT2TcZvufWLbxQYItNnEL7yu9hbDm1Vl7eBrUEV?=
 =?us-ascii?Q?7LhZ1cg2nLEiKm0qtEXCjY9scHI2ibaMujjTWcQxCgzAMnLZFCEpLgd33+vL?=
 =?us-ascii?Q?gtfh+J/aRlBImfMlHsw+DaCV/d1wh+1yVkqdZwo3qcI6blJ1XF4YBNpr5qHk?=
 =?us-ascii?Q?m8nPix6KNK9HU3tdS2rcWFtpUMWzT7b+SlW+uyqwfv2y4Bk20O6hWp7OtFh1?=
 =?us-ascii?Q?TX8hAkowE0G/ZO22OcHFLQuwvzzG7/Enl14pVO9IhwjX420XsCEo+rM9RhtQ?=
 =?us-ascii?Q?XPfjyPNPDNVRMGxnl530gnFII29o/63nuapdKzgra5bXJauVVUcMUwSydiXz?=
 =?us-ascii?Q?E3DByGPFB0PiOB2cyLe01Z9Wkc/cduLVhLjmXAvgax9VVU5Fzo/8aQJZFkbs?=
 =?us-ascii?Q?i7AfPggihyk1evI0QUqLZMiHP1XXW5j00pF+VcwySeHM+Ga1glzcrUeFFNjh?=
 =?us-ascii?Q?iJTZj+HVdvw9BBKfPFOhGNOYM/OlrQAWXnpC3DIfhqc59AAILKBLJIwrtsYq?=
 =?us-ascii?Q?csIZVhSkoJUSnzHlAksv/NAkbkrNPtHs3Mmvpleh2kCOujv1VdJKLqeIxzLz?=
 =?us-ascii?Q?CUS6OwZ/uxiQ2tIZOqwqwwZId3GDKoIXvjQzb1AoQmN315H62o+zbCUrJPve?=
 =?us-ascii?Q?/VRQu2i5EM9NaD9F7K0AewM37M4NIwH+bQLvMJWkhuec46L/N2SkGHQbvHw6?=
 =?us-ascii?Q?gM2dFmxqbXnan0NrGfKOjjOH47KnGnQ9UFymTU/tOPe9NxS48TddFAbze36i?=
 =?us-ascii?Q?Ffxd+V3Glny5/vwMrCL8ls1Zq6Lum1SZlcAHw1ZU+mQggij5MHTeyIVd+FZ3?=
 =?us-ascii?Q?jlqDWYZ3H/oOTlytPrm32L4AtTM3GBS7D9NmnTD5zjZHAmkxoICLeHmMESuc?=
 =?us-ascii?Q?RJWG7apg59/+DkVw1M/5KT2OZh+e+6JQWhh9NpToFCQyyPbcSCdbl3CbpuQH?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QV4adzE4CAsiKfCG3nULz+qHmic9ED/Vj4DVOpoZimwarJrMekZ6WMGOlJkH63kOWcV5R4XweYcmZAmFlDYtKf9Sb7wnVCXF4m9Ce5K/+EiaZOcaI9lRp0pg6v+sT/Eaxw+uO5J4gZ+hrDOl28N/d7pB1rVBYEWR2zxmO98TPf75Nh85wrEgnPWI3N4wNzPiK+MwSgg4tTuFuWydSRpo9RT16tkOEBJsRwPhA9Mg2gcczIZFTBFmqngJAwPMzdZ7vPQ0eBzozx5eBnSTtXoWwK+9HOFtxTE68q70Ui5EAJE/CDaoXgld7Fb1qgFyKQkpPo12fSyXNmkR8u8Kbsr/vUbTiugiSCFTCsHXIXk9nX0RxKwRbpZ/c9noBjaHxam+qlrIMznW5R7R+TSRduvFJDszk5YGrlzwnzcEe9cEOZ2bJBxIGu0Agz1svq/KU/sY0JDwtKVUJFGtivN86L3mCmkrOuU7aMb4ERc/2oL5SftL4szYtzSoSqrcIlhAQagJzcrHXvLltlP9S0fHmjg2E+j2o9qwF0Ju1NXGW2ZavEEDNNdNT6uMmpH18v9GeisbXT0YW671QCv+W0JjK2vSrEOLmGbS0TjycUQsTtlyN3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58dd123-5050-483a-3ad0-08dcfff0f7fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 12:29:19.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVUm7uYrbInsV99jMRIgggNL9Y/Ra/8SsxTrXBdh7TVW43QvNzn+gK1shhzU2UMxvs1jw4rDTwY8m4NZUQwzf5v+yVst0nUKtkkWr6/t+8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_09,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=855
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080104
X-Proofpoint-GUID: n2NTH88OtBxJ4UhMovKQWS9eXJqTBCuG
X-Proofpoint-ORIG-GUID: n2NTH88OtBxJ4UhMovKQWS9eXJqTBCuG

On Fri, Nov 08, 2024 at 07:25:38PM +0700, Bagas Sanjaya wrote:
> On Thu, Nov 07, 2024 at 07:01:37PM +0000, Lorenzo Stoakes wrote:
> > +.. note:: In instances where the architecture supports fewer page tables than
> > +   five the kernel cleverly 'folds' page table levels, that is skips them within
> > +   the logic, regardless we can act as if there were always five.
>
> What are being skipped if e.g. we only have 3 or 4 page tables?
>
> Confused...

Page table levels, see [0].

Typically achieved through stubbing functions out, etc. So in the code you
actually write and _conceptually_ there are five levels, only in the final
compile you might have things like p4d_present(), p4d_clear() etc. squashed by
the compiler into nothing.

I don't want to get too bogged down into the details of this in the doc, more of
an aside!

[0]: https://elixir.bootlin.com/linux/v6.11.6/source/include/asm-generic/pgtable-nopud.h#L9

>
> --
> An old man doll... just what I always wanted! - Clara

