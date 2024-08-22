Return-Path: <linux-kernel+bounces-297894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E238B95BEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1C91C22E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16641D2F6F;
	Thu, 22 Aug 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O/WJMKxC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mU+QhrPz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7D1D0DC0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354829; cv=fail; b=kkjsV+dqdZeFrPYRC7NIUrOMjMiERuORqIQBoiUVXYyiu9dfIDWhMbLlgb8TAmampql8WDGE6Xcb75NW+LyGHK4f+4EFypR/wn+J6WpltPGX7UgFPYyt/Sv70Z/OVss8a0OVlRmc1lr/YM8T0sDThqNMaDtYNQUS8VdLYHTzvhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354829; c=relaxed/simple;
	bh=wu6YGWxDjZyl98ILSVqqCgq/3uNZoMpiULCziU1+zJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozfQLokMOOTvrOyaJXzdF132ytpF/P4XlXlBu9xzKiJTp6pf6HzOz5gpKgE/hyc4G3UApNAgCCieKy920UqPAMrC/CJW6EBIyxfEJoGrOTDemOjFh96hndw1gV+wIRRZ/6/dOGCcwv12+4VedN+LbQ4B1h63RGyn/m5dkhBwoOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O/WJMKxC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mU+QhrPz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMXrf026383;
	Thu, 22 Aug 2024 19:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=6vYH9SFXEQO5KOTSg7PMHGnjsSkAedVllgsa8y7P8Xs=; b=
	O/WJMKxCYiPs2dSBesNSprA/RP1Vn7sxD1jGn0lWUakHVcfmMf7ywoaeGJ2hkpjg
	pFCb0RmNRHqNlYuBHSMOs7ipVVbaFS2ToahzBrXgWc+oM715eC79TGTTdefsvwHK
	LUbZjJoQidDC38kfM8h7OQs8k10pTyL+VzrayyzbAXu+OHseTJgb1ahzKFiF0TPw
	cSvyVMjc8iEJP1V8UTx0SjanB8wXTzBukswsThPu197zcPCbo/KzbF+YpzTMe9OA
	zOZUIcyWhdPJHEgX7OD89IhQ3y5yrSMYy25mdNI5pp8WWF7GhDJa0O6Wcaij4p9f
	Tn94wqLBsnz5BNmF6UhPZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v2wag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJK8e005374;
	Thu, 22 Aug 2024 19:26:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu08ec-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFkWXXG3Tuq9pJBq0+bchU6T4CRvXCND+kIfRQarUrfpUDfEGBCuz4E/ky9/nUxcg/wid2duPpAp57Zkl66Ncqc6E9w/Ydq2tZwXnDERv+JMhBi6Si+cTJlKWr+yXQDkBAR9WKNYAjPicLwt6caGznu9GAYjaandug37x4m7zbsw6jnTSyrR+LLQRpNud8922dKzIY/Or+BL0e33/HF4VBHouA7RqcO/q4GW1fTfq6S6iIPvLZQxspiBjP9nqi/qMb8jK6nts6Bl71JawBfMRRPDGvRSG8+qxGmD3ZF0hp7nKXYACyY/rQ/YPKt4734YNwAV1JV8YMq7/95dN6G9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vYH9SFXEQO5KOTSg7PMHGnjsSkAedVllgsa8y7P8Xs=;
 b=uPLmAu74y4aBVCBdLwm1DlS9jL/CTXRU1iHABB7sTmRyykynzyC+kujWQnOK1StRI6LA79U8i2gmCjXQHg0PmsA/3CuX/NdgB2ZaYnKVVexzv/ux8BxUH3jxsymbE/HgKQwTidPSzzWptD7pCUtrAVU+FuiOkVlKjQZYhFa888IM5Ba5u4erV9FXf3rzEeXm7QsP/yzQs8osEAEp47tleN3LeqPi2wvOqxKoJ4/v6QAJRYglSRx1GhUZXuoDiTJ6zhSijG5jOnbmyOElqJ9OXuUJMAt+2JJ7qA584eURGkIRWSs6AIBxeQepx/xkxHTBfdCo2w0BrC6CgYgNmUkOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vYH9SFXEQO5KOTSg7PMHGnjsSkAedVllgsa8y7P8Xs=;
 b=mU+QhrPzpavotwIjunPeb0u5H0Vsgt9Dv/D3NaVHeyuJuFQNyamzZqxWKmKSebGJ0wV3eyL4q9HcWxPpr6LvPS43seDYE0cNU8+V0Qf0+d4AAjObwVKUIjG/ExRF5LLLckzhbzmPONWPBd8m9OT8CZ0XD8zbNw5hTjWH9cCGgvI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 22 Aug
 2024 19:26:23 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:23 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v7 07/21] mm/vma: Extract validate_mm() from vma_complete()
Date: Thu, 22 Aug 2024 15:25:29 -0400
Message-ID: <20240822192543.3359552-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa4f20a-36dc-485d-4253-08dcc2e04ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gTYL3NMMSVB1Yq5Xa6NgeWT6QNWosn81z6Y+59RlL1omlI39VF6nfRDeO/5c?=
 =?us-ascii?Q?WPj1XvOyNrya7sGOwbtmmzddXcumoOIwCXpDhA3y+9eDlNicxXn475rs4w44?=
 =?us-ascii?Q?eHY1jfttQh6REX8T6RX2vLwBdbYG/6x3Q5352GYnnL6nKSRwmFPxllnTO19F?=
 =?us-ascii?Q?eWAXZICn/HfoO7cR/sQl0EyNfppAm9FJoZIXJ3DSOJb98a/mTum48TB+1Jwf?=
 =?us-ascii?Q?EB6CuLa5WgQDND7dQfNEW8EB0Y+AaOfGMssz+M4XvOmfZZI3R79dx6L89Aiy?=
 =?us-ascii?Q?EBVOnED/nv1J51bx2nmeMaECgKMe3aAiGUSSoZ64LmE6n0DutKg2ejjYjjJB?=
 =?us-ascii?Q?sQ+A6NtAZH+iorsRlRfF0cu7aLuTQ/DOo1oJGSVXdD8HD/puWpDA4Wu97kL6?=
 =?us-ascii?Q?hd6wTRgc1xoav4NX8TVPmCF9UMY/B1fuZPpXOYqTOfK1tRfYpdFN2uB+ZFLv?=
 =?us-ascii?Q?j7rZovubyA9FEjOuT2yDAQl5uvlDxl/UyB6fCUBpKR7tgneTILN37n+O3So/?=
 =?us-ascii?Q?mKJUi4omLI179lDccIuuzDiyj4L1mtwL/9rVIFxrzYN6YPT71r3pLaUHnn6x?=
 =?us-ascii?Q?4IipYbgwK1fmLhHY5IYCz27W420Tl0jPlB7PVWqHLQ3F0euoFuOsztWqelfM?=
 =?us-ascii?Q?Tl652Pe1J3JXp9QNqrIPD3tbgMZ7Z5JQPcAx6XaVK6WTKq5vhy1YvtW4D2BB?=
 =?us-ascii?Q?ggKatHt6SLXOKVym5EvPxUwo1N0ZXf+SqUw2ixOopjYJMmZUhTkjvB6fBEjt?=
 =?us-ascii?Q?62Bs8CnaChc9u7xtctF8oboZ6lN1Hohr7aXKhtNSu9H4SQd5VWSG8V/iDopK?=
 =?us-ascii?Q?QAfnlQoIZqjGyUsFdP2cY1nrIwZejEVqoqrQ+UJ4mBpl18kQhvB2VDI3hB28?=
 =?us-ascii?Q?PdKAoqCtTnu9rGZnQAd31/44xlEj2e2mOL8bbW/Xjq9qR5783vnzaivTuRJZ?=
 =?us-ascii?Q?ogK9wdatRbqIQxz/ScLNMlSuUP2EJmjRaG+r0JSLgiXpIYdpOBrQ0ch6IbGR?=
 =?us-ascii?Q?zFDceTfY5FeH+LlqkLmdjB0wc8Li7VrVcOoFwulWZdDfiwhV8hwaV9nOmv2F?=
 =?us-ascii?Q?1qjAuuivwONiCUdcAHc2w+dLr4CsbIbxj2gCRxYX2y+A+vscxDqh8ftZCSSF?=
 =?us-ascii?Q?+Fdv7msR3uRbo0YphQiyc4+JjBqLc94xqWDPLnUU8iX2ve6JpLGmXTvrTG2E?=
 =?us-ascii?Q?QMNJhJ+puDtZZ8GVqOSw+CpJ9EmoCwbL1mIXfmXeR8YZvAFKZB1CTb7KQ5KM?=
 =?us-ascii?Q?rf/HoourZopeZsqh1WniGovujwi2yyk1uhgXppGBmdEfo03n4Z13kCS8eJya?=
 =?us-ascii?Q?7a5GEwacoUQqoGNda0vR028Gf/nrJeNjMx0oi4OtMWMcoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L1Smw93KYn4B/eVzUV2vwz/CdmSYYYTQNcV2HTyrq2Nb2oft96tKdbOUTid1?=
 =?us-ascii?Q?uZWZHGdlkR+75+SbTNxaG9nMJIvLz3VgPZs0nyUlfGQHTHKwUcCFgvYb/jMk?=
 =?us-ascii?Q?gJLr55YmXTo1rz/zByuhrz1mQsR4yVoQQiUJyhkz1SOhf1+iNxV4Krkr64k8?=
 =?us-ascii?Q?dCVYSnEqxm4Y/glWcJWtNniwYyk6581JV+6mdqLTLPQBbWuT8AWuv0f4HdNC?=
 =?us-ascii?Q?XKRq6Nubu8Rtl4ROCzr/25Wt3N9VZ5Bs5LQq0v7t/KZjY/f4FtmGzk4SZjvw?=
 =?us-ascii?Q?O2b50cHppNxoVxIYQHbpl+wzfRN0lRUZOKyzmV9sN8zvd00gkU18RYzriYlc?=
 =?us-ascii?Q?dxxUTifFuUgMeJoVp9SrV3DXi2Yqq9mXRv2JWe8pCx2rlqfB1osgrtD49S14?=
 =?us-ascii?Q?gu8/7EzOy7zuToYStTw70U18iHm6NwNiHgkFBlff8nFRJLAkZTZY6zxtN4yq?=
 =?us-ascii?Q?zGTzR+4CZenRRxiaw0D93hBkuAOOuHXbzYlOXbZAU3tC+ll1QQVNPO8Mzay7?=
 =?us-ascii?Q?LExNSUsn9BGojssS4YCY+clrBnIl51rEQ1x/Zf7MJ0CLUAw7KsADhoKo8PWC?=
 =?us-ascii?Q?hOYSyotsTUdCkONj+fbWMP5GTKaVGlEiuStatVaBVOfYGtVMjBOY6n8VCU8+?=
 =?us-ascii?Q?HN/t1pN+leL0v8PKEF3G480nPZvV+rdg6zt7x/ssC+Ww5qANoqTyLzwF492V?=
 =?us-ascii?Q?om4oELTsfe4n32MJU6nzrHOePT72acp3n/i5sG0HX3ubHZnetTOf8Po85I9q?=
 =?us-ascii?Q?mR84+FsBQXFkNfB4SvQcDH9JlcbU4LND/lnp0pLrmhCjJxvSx/asCrhrKeOA?=
 =?us-ascii?Q?xkDDUP6DbpfJyjOMEBd8egeOD+uMk5jqYoh/guVeRxB/PdBiq3NDU6uE4uQH?=
 =?us-ascii?Q?RRIc7Ayj7Hze8uhdUtcdQzxCXZWcFQCsGTVNXJiK/MFq+HtW17SXFLOKmLtO?=
 =?us-ascii?Q?OzKJQyWxfJhn7Fr7F1oeiWJBnUnq0tozW54bs06dwW0ttLsZBbn2t1zNlMj8?=
 =?us-ascii?Q?VWljqudxTdvbSPTM/m0aXhHc8UjrrMUmKwNJw6mn5TzB88dmlWo7l59NRWLf?=
 =?us-ascii?Q?RqXyfDPL33xBltto6oNM10HA1fmc0y4VB5x2B5Ckx7/t1fa7okzPq4BZOir1?=
 =?us-ascii?Q?JPlIxVuXsF+RB9ihesYDOyTE8uHG/hNJJDt6MK2Yljnd4itLa0B01oemH30E?=
 =?us-ascii?Q?mpsp4Hvjtvnup9Yxfce2MAQQMbss9e4pcqf3b8Babe3qpLL2edV8zC+AuJIi?=
 =?us-ascii?Q?BgDDo1yywhd4b0GyLIbdvpAvPg394eG8R6bL8B6Cr6Obju7iiOUmSsPB/5EN?=
 =?us-ascii?Q?LfPesbR6xUgEHSd54y9GidB7GaNwI9AcCuAarFajLQhX9KcfuPUMJr8zazNz?=
 =?us-ascii?Q?3IjKSLdwDsFfqAZPdjvwyMzmXvLvrR6FpIjvH+GfK/uDlf22G1Goy0ppd/pj?=
 =?us-ascii?Q?f2BhuCqnU5ZSyro2nBVPjbm7pjNSUJJ91/UTuYmaX5M1M9Qk3hMqGRcYjoLT?=
 =?us-ascii?Q?xt8v48Vher6SyI685J84HsVQKf9g72qCW0r/OAYCItrYrnzjOrVROxOzhJ1m?=
 =?us-ascii?Q?vjnnWWxF3bzGnBGUhf4Ulbr69s2VWCr53/p2o0lvrNBz9mpqOtlmqikcoEEn?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NuKRFDgr/whdDhR38O/J7UktZPXOwdA+kvf5kFNtFjeFKybbCtlpfy9bG9GTvDueKLVrcezH/H9MvyHL5MSnRr20qtmjylYxLrUhAdpH57HRtVTcQF19bsBTLzBjhy25vMGX9Rz1cgqXe5sKzhUhS0DxHjVA09z3731NIzCL1kTO2vr3WA5+386azBKMoUPJdJbsG9sjk4ZpJguXabUOY56fPSLiFLQHDI+VcjgtEBH2HmrzmZmmn/rMS1xWj6tjo7sNFPqoLnwFnLfF1m1Sz4CC0lzmnv0krhQZE0TpLfByNrpLBn9WDz4GtN+sK+relfbJk9YFAtcRTj5xWt3bq4uaUNj/pB8jlqKGdgoA7LpmzkSGS1k4W5W+u8gjFMVJVHfmSxXmKVCycZ3A4j9/8meGRNwIYqxZsHfkKqKRUU2W1UAQIxmpXck5NEVDD6hnL11s8CgaMiThppYoaRl/mIf/tllVSrE6dW3CVfoEKaF/XlFdjBt9TDwREQ03km/5Fvq99J7745np37Gq4wq5Z+VwZNhBfLM881A7/zX4C6Zzd4IdrSHthEzbvSeSY0JS3xNUreZN94Q+mWaMxiY77SIL69seqM09T0TyyQwLDLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa4f20a-36dc-485d-4253-08dcc2e04ec0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:23.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoOikg5A0OFVYYLBeqPZxJDFz6iGgwmrnG/VUIpDfv13j52WkpqQ0LczBL2maTBcZRnHwH2eEPtJnHaXzpTVPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: oni2CGUnKqc-DXUWQ8lgtjynDhRirt2l
X-Proofpoint-GUID: oni2CGUnKqc-DXUWQ8lgtjynDhRirt2l

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_complete() will need to be called during an unsafe time to call
validate_mm().  Extract the call in all places now so that only one
location can be modified in the next change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 1 +
 mm/vma.c  | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 30ae4cb5cec9..112f2111c457 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1796,6 +1796,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_iter_store(vmi, vma);
 
 		vma_complete(&vp, vmi, mm);
+		validate_mm(mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
diff --git a/mm/vma.c b/mm/vma.c
index 58604fe3bd03..f061aa402f92 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -269,6 +269,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	/* vma_complete stores the new vma */
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	/* Success. */
 	if (new_below)
@@ -548,6 +549,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -589,6 +591,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -668,7 +671,6 @@ void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }
 
 /*
@@ -1202,6 +1204,7 @@ static struct vm_area_struct
 	}
 
 	vma_complete(&vp, vmi, mm);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
 
-- 
2.43.0


