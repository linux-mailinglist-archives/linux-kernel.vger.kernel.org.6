Return-Path: <linux-kernel+bounces-386994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47AF9B4A90
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677A2284320
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876120695B;
	Tue, 29 Oct 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ShPfYuJj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CEF0+pmb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FA1DE3B7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207070; cv=fail; b=BBEbvWWEu1drKvTxhtkUlw/FiBso4NYbEg3AEC7bSBVBeJEtOyAqL8pkf6tUPMgiR6Cf47PFGgrAU0mFC3wVNzlTteBFJhXQvzQguVNHS7zljMhCjcvmbL0rgzeiLPqbni5Q4ZASxILDDOipbVSoQHEvPhIJlM0XwpQ/gBhFdeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207070; c=relaxed/simple;
	bh=an+M1mGKP3sgKgiYuyeH8QC3zheIDbbf2ATPFlzIgT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlWQ3xF/049jXzF8kFXRL+un2sSweXM9s/Prs+oE7ZDcclTQbOTSKVIImRDaEVeECCm2/dj6WhI058Qsh3I9LV6o4c3lNrRIN5tdrhIHbWrKdrMF5j137u9MYbSyNMdlhq3L7bvHAsr1/W3MMRf+nINT5U2TJL98MmSEecOSZ7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ShPfYuJj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CEF0+pmb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCbnQA032685;
	Tue, 29 Oct 2024 13:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AiDQwp5SppPm6ae4dVe9eq+4O2yzoe4v2pgxvOajGxE=; b=
	ShPfYuJjQQc7WECx2KsnX7eNv1dDKbqhJmyiA2jwRzRIl6qaHgkDZXORkxl49Xu2
	u2B8PgShcnugaIrC1U1S9TXEnRsLDuSJnfqxBjfX2z/ZTJutwJiFiKYUoKGwkGx8
	SQJibC5UnMCqdJB5dtyXYBDnwxCbnxXchyjUQaWn00Z+Iw4HGr4KfzcxKqUvg+4i
	xaXy0qzTjtP2caOhhLji/dvMTuzZMZFQBR0vBYXVFa+l7OEakUj8LWzGHjifwrdp
	mnTg7F2b7V9i7TBFU1JvOcV9jT27w37Rz/0FTsluiUnsqx0RvPFPjm9pzwXbY1gx
	847ptjH9lx5qEa0M2MhRlA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp5bvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:04:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCqEjM011986;
	Tue, 29 Oct 2024 13:04:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnacfnea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDrbqWCOl9s07wpdWRb/fQjy9yQml6BrZt0liHkUItNSJOIFVYrki91CiZcYdCRQANNW086sE9tjjZz06DOVsa6yzkyK986s1vfKLdqH3TObuW98bzJ/1DOd2KDsNHm7l9Knqc6D2XWlR+Ta9U4Dk8B144JSPdRW/QE/ZFMu5rR8GiCdP3rsg3o9Sr0OboHVt3o6vQ4gNNoXdrsnmJ16D9/xiKc36nQ7OrPzPcsro4Z//inYDWm2bc7Qha43dZAXDGrCzbOx76fS36JtnTuq8GwDnhIyleIC/m+YnUD8gzsq7Zkel+621FJa4a5PTPyHMt/7QgZe3G5wvzy1Yozs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiDQwp5SppPm6ae4dVe9eq+4O2yzoe4v2pgxvOajGxE=;
 b=h5Nnwt2rhBA+gBPlb/mgr6QOxCcFVb9rLKidS5j+8ZkxgWxyGA4mBBCUCBstteGjx5q2v6Hz+fbvMDBmhDrWYkaEznWVgF13OGjiXhNJhfJgbt8I0TK90Di+cjyoNSNaoPX5ECg77PKPY6A0ZmIYgNyylf+dTjgHt3GeCCQYLyAc6M8Fmi3cOv6CgpZD74uYJgYKSMxyPjR6B2qWpb5h08homfaaQKq+yL00vnv9P+bCygWXjIdldc+b2sAfMD7Cvuyor27FsYSo3n0q28xvsW20/Fy1UOwLtCr5mhnyx/3ukepFUOXdgfEJ4TnThTMofxH2EfZhkhu6qleEBtzk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiDQwp5SppPm6ae4dVe9eq+4O2yzoe4v2pgxvOajGxE=;
 b=CEF0+pmbYMaEStGSe01CcQ3BS8mCNWSiPMXseXX3WajFRrcgI5soWOiQ7Y06Ebksx0FwYyTD2J9PnOegZ1chgdWoNRA1mkdI4IMgFko2hqysCkGaDuVh3rRjklSn4m1AOA0nLe7n1uXuA+f399kj0KgRiEeUTvVl1YbmW6hcYdI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 13:04:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 13:04:06 +0000
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
        Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH hotfix 6.12 v3 4/5] mm: refactor arch_validate_flags() and arm64 MTE handling
Date: Tue, 29 Oct 2024 13:03:46 +0000
Message-ID: <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0235.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed47963-c553-4172-5dde-08dcf81a2bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tLzbKiM8lyGUyAxl0nyiINik8iicflG1G2OzRuz64vvC1b8Ui4VbT2W4OhTe?=
 =?us-ascii?Q?cLa35EFRYxJZ63bDb1rEHIebALbPGiyDGIar6ArpPq8u90lveqW3dVplbr78?=
 =?us-ascii?Q?iBQJlNQw8FEK9SK/GJvTt7u/nlv//EO9ZTgCFlf40rD/s33r8lOjMqM6z4G6?=
 =?us-ascii?Q?hMH0+0W8+YrIq0SsV7k4+IKpXjXfBsY9WsNnrvd/6bEWa6/G+407xWzTCgYN?=
 =?us-ascii?Q?rjGgtB76qt1rdDys8cI73NRQJ3dei18k4R4NJtjIV2Sm6EpAuNI+2lInxi0F?=
 =?us-ascii?Q?fmTAUVbsSkJ5L5A50anUutzdhWtUSw14B7/IG4OmVQA/yK+NhT34m5NhW3yw?=
 =?us-ascii?Q?QU1OAENYe0NyUSwJrD6Zl67HDAZydOFyimJOrAaNhQ4MN0Jbw5bB3G+jsIPi?=
 =?us-ascii?Q?YZgLOSS3hz6teZb7oEFtxzx9L4ZQsSH64WetcwbhkXhNGkNH3/VqkIzyHAVj?=
 =?us-ascii?Q?OfFf7+UXTL0WsMmg5rsjNPwxstKB3dhgzebc0+YKsM4wsddnFTkV6C0J2GHe?=
 =?us-ascii?Q?cKMtlPqMYzeL6rPmY4nw9DV3frq9nbv458SH04PdzG25QqAkqKwSak+cLWlk?=
 =?us-ascii?Q?XJnRgszE8FUZS0DUlpfno1Idq+ny9AMAKJ7IGiXpb/NINSAVqkGnjclqEl2b?=
 =?us-ascii?Q?9995b5Tqqa95MuNcBvnUWiqU6gv6V8STZW8R4Rugp0K6K/X7UBWaBDjOqw27?=
 =?us-ascii?Q?075K8Rnp2UI6CnvpNaqziGSlxFoiEPDDTmkXyxQqBk8faqdhVuq/jfkFdiEC?=
 =?us-ascii?Q?JyWSNNjvrNEDJwU0RwowBsQzmZt+MF4Lcaz7OCy6Wy0CCam4ZYwxtre18M+9?=
 =?us-ascii?Q?OTE5MSOoJ2fk1V9dZg7VuaMTjy4HzKm3VLV7fbK2E43D/0mfT32Lp/T7aGKI?=
 =?us-ascii?Q?/7oMm5Wo3sxhv/PCSYJuxbcDBi/FUE0tXfaSMHiM4fPYZraAWNVdROmX7jbM?=
 =?us-ascii?Q?BsFnHOfS7Z+nrvrOo0rEWZXe2kBuguQRW6lCrC4OiSeqAy712VBcEmOqjleE?=
 =?us-ascii?Q?8Y2kDYPwjEGVx9Rawro/4DPclXgS6M72mey/+PzH7cL9bXqqP0UNNi4L2WWz?=
 =?us-ascii?Q?uLdKWzRg0Fx8/YEYxRKBKkv9gl4pGdTgECDRxcYqedyJH8vXzzLbNW2uDwTp?=
 =?us-ascii?Q?taQCwcmsndcOIb89yRk/I3CoR8aNcO1ObnSmObHYb4FBU1mLnb/e6fqeOChN?=
 =?us-ascii?Q?/dUw4Zsv2CpXA1gXaIL5HvOGQ1pxGtN1u0lOsxotxaU1yALaXYwLrsZrE0xy?=
 =?us-ascii?Q?1ZtjczffV6qfkHiw0CbHDM0hMEQI2aY8zngbRkyFnSAOmAm/fHGEQyy2F76i?=
 =?us-ascii?Q?qHmOqjJ2L1x/Xi2eOB5YvMP0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kujRqwb4gQD9PKlmVcqK6vkAUol5EgoUWFg3HRBAw2wvWFEi3Ji482t6oiB0?=
 =?us-ascii?Q?NrcyoILyX7ypP9o/MmvANuPDCbVlhIEPecxAHNrY1kh0XMoAJ9fDngeV+A8Y?=
 =?us-ascii?Q?IqVZ0Dl99EwPLpjzrtJjkw7epWA8YExQU3SMB+BWHz44FiGUogZQ/1gXzvCI?=
 =?us-ascii?Q?oYFaY4WY9ktAbNWxZFzrcoCyzi2L7AvlvycOgy9az+pu1A/kZEysDc3II81E?=
 =?us-ascii?Q?VB3JIFDy/Jsz9DlCbBfp9+qyW5gkySyLOLYctaJvxdTF7539VOtv2bkAVeI9?=
 =?us-ascii?Q?m3YMXONQrei1o9vlxpNAwQnVcTSh+E9LMMJ1bqKiZfzEMyXVRWI0SbqNFuWy?=
 =?us-ascii?Q?+7Uubi1es0p93Dlu5FyRGZ9xCRK9q8tp/GFeSQgTpz/X2TIXSip4ztQm36OT?=
 =?us-ascii?Q?1AKIYLIwjV8iHs56Z7EIhe27mjah/ebzYp2HxYE50pmRhLdYw020CaVHrNAe?=
 =?us-ascii?Q?AfmowLwvLOUCKkVF+0KbIkrJf4UOHGOY3WOv8rNSao2D4QqISzOBL9tbIYpP?=
 =?us-ascii?Q?krz+MT5IMf0Cnajlw/L8EPxFrBNSV+f6QmlLY6qGmzWU8j2npO3uxfZmcoL+?=
 =?us-ascii?Q?By3iou8He927K2g11wjL0I4Q+U9YGO9x6Fvq9pI6iPnqFJOAb5tbSdiL4mtH?=
 =?us-ascii?Q?RBivsGm8hL4CvXn6gyHfR8cglPS05Pq2UO7Bgsrs+Yhc9Eege0+Ew8dwnc5n?=
 =?us-ascii?Q?CofyVIkYP/AX7V8jFsOl1NBA4/fTPX3AhN28ZtVgEKGt1fAGQ8HFGJ/iw6sm?=
 =?us-ascii?Q?mylKtlDqx6Tc+l+awqODI3BsMSWklse4deabXeS4avdNwb+V2oMyECUH5PqD?=
 =?us-ascii?Q?fHAUctRe13KozKbP83jACJ4AbILgQAxZ52rM/yJzMUUEzpucvWkXRQBpFNHs?=
 =?us-ascii?Q?Ivg+w+VH3A49KUWlCEZTeR6wfjBgCKUz5q7E8tqvB5yS5BuvpbP+k7HsMrnj?=
 =?us-ascii?Q?10rRYSfAE6z+qrNpcwWPTsls4io4SiuIreHfFCzs8SKlpUwtg5gy1e8D55jV?=
 =?us-ascii?Q?n5De8JjpVBGq3Ysqg1jh4ZLk24VcSUaUQmsmnsl5zuzVlO3CatE49nwfd54h?=
 =?us-ascii?Q?eRaP70pCqSEqYzomVi2ltUTsNpwaZl7POSnxYiwWzjLzPakwYHsNC5sSD0E7?=
 =?us-ascii?Q?eFvYSnBARI394WyP/yGZmd2A4B+2c9N4vdL8P+mMu+YtGPDJwr08OOBkvIhz?=
 =?us-ascii?Q?q0b/he/tA0rfjK8BbOOipbG4QJwgX92ejIXbm60cwfs3pYk94syFIVOGVitL?=
 =?us-ascii?Q?18EgX9lZrNVc2Eae5ciEPpMVO5VbDS+gpZr6uUQATwXxVSbNsKVupXOnmU79?=
 =?us-ascii?Q?EtWfXtutmktAPxawprYhi8lIuvSS+QFeP52RuqnJT5cAi0UVJHjNkj5Pmble?=
 =?us-ascii?Q?omq6DYH2gg+ZmBtkF6SUP95PSzYOf2vwCfbstKl182hON8ekJqeoVNtLgJAV?=
 =?us-ascii?Q?rIBykqSj6reFvZ2J8j2Fym1YgNgYulESWmm9fjsTawfzUZzAjwJt0umRsw/F?=
 =?us-ascii?Q?wXXa0WjtB0o2JWu8xPTM/5sP+2m9N68QE0Wh34fXTl6u1cTbhPljRp059kFu?=
 =?us-ascii?Q?Z3NPsusBVLS314ST/KIQSp6IgONVAqmp5g2J+aagWDSHpoYFJMyODKpEo3Nf?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tRFTRBErwd/8zhbD6tEqEMUiBGWovUnOSpvtI9D0Tq8YxNMaa0OSGJRxr+4jxyJjm0jQSf2VA8/wteFpf+rp/Nyc3NKCJsi4p1Q0l9hEPjJFq7dFj+VZUTrOs5tP/Ty1T1dJ6mFQOD83bpe9FHeqkLJWSXGyF3GVZKkFaOI375J+Fqx4QiUA4ZeY5iRDIgMii2UX+m3YRIXJ3gdXFLVlS1Mb7jyFcgiSXlyIqnqwJtLX+CR+8gq4LFDJZBsk/c/RFMP3Fc6WewE92oA1I3U8hZY/fJOItlZHA9C9Pk9ZPpVkE1t8LNXZ5/z6iT8ZBg5v3HuWRaf2LdtPHEeOXD3yEUYNLqICUfVBLZL1SA98HGbjoMtwR55Yg6yGD3Zty05wgEJUh5osQLhmdX571xz0LfBv2ytBi0+6XHXPZUVA2rSo4yXWNXL9xI9li3k8IJhv8JyMGMLwxOpJZeU8DkzuLUk1cvW7azeZeGLqqEV0GY9KFK2CRcqS0DzuD7dvCKCZbMk+K7+K23TuwkAaUSamzZHmBazL7qx2qp7nVVgYBU4K7u7SaTk6liBp9TlvptObVSYM6Y/m8r/iHDhO5rTkuDdGv+fbgA2YakpKVpbC7EA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed47963-c553-4172-5dde-08dcf81a2bc6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 13:04:06.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6LKW9BeY39ISY5eLn54WkxA5+uK2qWk1oFp6d9f2dj6w0P+lYMW/KiRoq74Q3syhpGNJb4tGMXwc/KsnBgapal84MvnHDtYOtYbI5Gc+48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290099
X-Proofpoint-ORIG-GUID: eWpePnnw00gVN1KUmcU6rvKUO-Q043Vm
X-Proofpoint-GUID: eWpePnnw00gVN1KUmcU6rvKUO-Q043Vm

Currently MTE is permitted in two circumstances (desiring to use MTE having
been specified by the VM_MTE flag) - where MAP_ANONYMOUS is specified, as
checked by arch_calc_vm_flag_bits() and actualised by setting the
VM_MTE_ALLOWED flag, or if the file backing the mapping is shmem, in which
case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap hook is activated
in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also set
is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check to arch_validate_flags() itself.

This requires a modification to the arch_validate_flags() signature to pass
in a pointer to the struct file associated with the mapping, however this
is not too egregious as this is only used by two architectures anyway -
arm64 and sparc.

So this patch performs this adjustment and moves the check to
arch_validate_flags() which resolves the issue.

We'd ideally like to have eliminated the arch_calc_vm_flag_bits() case, but
we risk inadvertently changing behaviour as we do not have mmap() flags
available at the point of the arch_validate_flags() check and a MAP_ANON |
MAP_HUGETLB case would be accepted for MTE currently, but a MAP_SHARED |
MAP_HUGETLB would not.

This is likely an oversight but we want to try to keep behaviour identical
to before in this patch.

So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
MAP_ANON.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/include/asm/mman.h | 29 +++++++++++++++++++++++++----
 arch/sparc/include/asm/mman.h |  5 +++--
 include/linux/mman.h          |  2 +-
 mm/mmap.c                     |  2 +-
 mm/mprotect.c                 |  2 +-
 mm/shmem.c                    |  3 ---
 6 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 9e39217b4afb..94925a0482e3 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -6,7 +6,9 @@

 #ifndef BUILD_VDSO
 #include <linux/compiler.h>
+#include <linux/fs.h>
 #include <linux/types.h>
+#include <linux/shmem_fs.h>

 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 	unsigned long pkey)
@@ -60,15 +62,34 @@ static inline bool arch_validate_prot(unsigned long prot,
 }
 #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)

-static inline bool arch_validate_flags(unsigned long vm_flags)
+static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
 {
 	if (!system_supports_mte())
 		return true;

-	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
-	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
+	if (!(vm_flags & VM_MTE))
+		return true;
+
+	/*
+	 * We explicitly permit MAP_ANONYMOUS and shmem backed mappings to use
+	 * MTE. We check for shmem explicitly here.
+	 *
+	 * The MAP_ANONYMOUS case is handled by arch_calc_vm_flag_bits() which
+	 * explicitly sets VM_MTE_ALLOWED which we check for here also.
+	 *
+	 * Ideally we'd perform both checks here but existing semantics support
+	 * hugetlb in MAP_ANONYMOUS mode but not a MAP_SHARED mapping, which is
+	 * likely unintended but we maintain identical behaviour for
+	 * consistency.
+	 */
+	if (vm_flags & VM_MTE_ALLOWED)
+		return true;
+	if (shmem_file(file))
+		return true;
+
+	return false;
 }
-#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)

 #endif /* !BUILD_VDSO */

diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index af9c10c83dc5..d426e1f7c2c1 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -10,6 +10,7 @@ int sparc_mmap_check(unsigned long addr, unsigned long len);

 #ifdef CONFIG_SPARC64
 #include <asm/adi_64.h>
+#include <linux/fs.h>

 static inline void ipi_set_tstate_mcde(void *arg)
 {
@@ -54,11 +55,11 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
 	return 1;
 }

-#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)
 /* arch_validate_flags() - Ensure combination of flags is valid for a
  *	VMA.
  */
-static inline bool arch_validate_flags(unsigned long vm_flags)
+static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
 {
 	/* If ADI is being enabled on this VMA, check for ADI
 	 * capability on the platform and ensure VMA is suitable
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 8ddca62d6460..82e6488026b7 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -117,7 +117,7 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
  *
  * Returns true if the VM_* flags are valid.
  */
-static inline bool arch_validate_flags(unsigned long flags)
+static inline bool arch_validate_flags(struct file *file, unsigned long flags)
 {
 	return true;
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index ab71d4c3464c..40b5858ae875 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1511,7 +1511,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}

 	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
+	if (!arch_validate_flags(file, vma->vm_flags)) {
 		error = -EINVAL;
 		goto close_and_free_vma;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f450af3252e..c6db98b893fc 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -816,7 +816,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}

 		/* Allow architectures to sanity-check the new flags */
-		if (!arch_validate_flags(newflags)) {
+		if (!arch_validate_flags(vma->vm_file, newflags)) {
 			error = -EINVAL;
 			break;
 		}
diff --git a/mm/shmem.c b/mm/shmem.c
index 4ba1d00fabda..e87f5d6799a7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;

-	/* arm64 - allow memory tagging on RAM-based files */
-	vm_flags_set(vma, VM_MTE_ALLOWED);
-
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
--
2.47.0

