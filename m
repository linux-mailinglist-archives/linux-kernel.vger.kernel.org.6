Return-Path: <linux-kernel+bounces-376938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525169AB7D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654E11C20C98
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A41B1CDA3C;
	Tue, 22 Oct 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hScche31";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lh9nQm6b"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E91CC16E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629702; cv=fail; b=lGjKyK3jiI4viyuVtRtCK62ldUyDlyGTx8nYOF9rFAvToEK6SBnJpmASnGDzJ73x5FRaJAWkkiUJRnsI3sN9GH5sfZopCb1dvXTFt4CwyF/PPQl/s2OYKJ7KrN0xIuzC71Ch2oM8buN0WViKKHRUvbZyFNwF86PGmtReus9DfPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629702; c=relaxed/simple;
	bh=j6Bry8vwwiTHR0NSjXHQVEt2yKPbmC7N2LXNpP/nYdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KNxhOhCLVTArT8OwNCr0vTOerdfZVZtlfi/ITcUGErHWcTvtvHp7cQEVY5buz80HPw4aI1YdD9IaOr7BdX0SDy/zl6Y26dQXsEeW04RcfuKXozrkGlVLqOviAK/qEG4x9DrEK4J885YLKrqDi/EjFKEEbrslp3wHgPwXJNx3P/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hScche31; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lh9nQm6b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3XLj017466;
	Tue, 22 Oct 2024 20:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6OaAYLfv3ucTeWXw9L1215jPvy4GpESA8WWmWuVuaUE=; b=
	hScche31GSNLLsXMjENWvE+re7clPwY4OOZJHzH7RPyymwXU28uuKkRCLx0mIuqQ
	/RWQnnqy13AhfQe7F58fYAvjdoP0GNLDcMb/8OF7vHKi41YMRUQ6GuJ3M3+gUh5z
	UqGG6mSBeXpOXTYWJXbqLqMwbZ1AU1sytwxB62lg2nVEPEEKwS6I+XcwLUFGOa7m
	ytLLqbP+tE5j2IgiBogkTif7P7wxpUcCQbjZ8ErIJLlBrqI91sXfBYFc260UjNKh
	bgvG1fZWlSCnt4hmeg6gTGVdYFuTjccIH39Ew1/iRtnSBG9lvSAp03Sz9w/fLauj
	Z3mir5/Hwec9O4u7MrrboQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqwy26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK26bU020317;
	Tue, 22 Oct 2024 20:41:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37ef3r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOvA59Upmf2U2dj9/HlbjFJg74T+8e5GXr0wnjeChbAcGBK1ldfmmPwmhG0nhHiAiNIpD907sMdASMfxvhPWcUzqg/aZ7jXGwV91rJepM8Or4mbW99qLb1ZhcbFHz4aE/ITQVSYiFv0xpzPvqBLdKZpFGPUWIN4BAHY/rlXDk6U4QYFI53o45Yy5Jpb/WT2X13Bad+Ijr5rup1UNrz/ioalQbjTZdG+y+FW0dFh9PYMj+v0y/EPkNsZvgsCbEFn4Ho/0CC0xYJypY7UhcCbZtNWykjzfuDLuijlVxYBB+gFGZQSkiS4kdpAqpwcF915DFxCE7qUiD3kGRSU9zhLMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OaAYLfv3ucTeWXw9L1215jPvy4GpESA8WWmWuVuaUE=;
 b=BWYt+2seWqL0UdBjDrYj+k5/EG4/3bcvoM5BKP6Tup4xBJpNpxF52BWWpxWLwC4U3n4Is61DS7329hjnTldRQ3WtTNGRI6KdSGpUF+7mTswTrFvYsdQJArnbAFC7CcpX9YCgIe6SbNT8loeqtxmh5x6kZOpNiaCM7TxFaCZdin9kucguZSvobZPEmd5XxWGFUOJ0gVsotIf82TOOnG6PWwnux75mK4mJPagKvmlcyIqjQc1KVmnQwrChlSw8CokRVUEfmWmu2wsjC17ZG/z/Gr+ccBC9TWSE31pt6ojnM1RcpeiXLytlbF/mvl4o4DbgKmue1f/Bv2qs8V1EUu7J9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OaAYLfv3ucTeWXw9L1215jPvy4GpESA8WWmWuVuaUE=;
 b=lh9nQm6b9q21rQgYYucr58ISykTs7rlpS/uUxy8CHsPoC80S2x6p2pdQl9kfZtHmjqfr/M6GG8ReXuED3jQkQ2meQhjkjPV6t9NXQVcAov79/58L25j5YRReaeR5ZkCsb5jWlgcNErltucUiA3SVEs/2WUJdEW1xDFgM2Ym9Mc4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB7437.namprd10.prod.outlook.com (2603:10b6:610:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:41:26 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:41:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 6/8] mm: insolate mmap internal logic to mm/vma.c
Date: Tue, 22 Oct 2024 21:40:57 +0100
Message-ID: <0b90285f68de7d091595d78422f9e48eb8600b7a.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0661.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b3d9ab-fbcc-4cdc-9d4c-08dcf2d9e64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MiGhNlcxffPlXRydNIxcInTUpWa8tHtnmTt4vA1MQfmFwTVavKjz/kcUzITD?=
 =?us-ascii?Q?Bf/F/bZl3wk1naIGDyyADHj2vOaACS6OODmIbncFg64IChWxKKN/PNa9+9b+?=
 =?us-ascii?Q?8tkRhsG5TjC0mB+zw1j95WqaRMZhD1ify+pOmd9GXJCIJIbmnMQM4vLFwUML?=
 =?us-ascii?Q?ShbZ5kVDA0o2TylsXfcnTm+lbD6CYceqUM6bhKmE0+URv8xX+Ev6akUg5MnE?=
 =?us-ascii?Q?qVt5pO/B7FEraLelRJFFn4MWUI6uIn2uf+GCK7WIPutI+8/zNKzWm3sCDKNO?=
 =?us-ascii?Q?knt4b/74dQaX1DlvNmUigAbF51YWEr//FB+Z3GYKOduY/ACPY2v26jijKN7x?=
 =?us-ascii?Q?hQJW2Eq9qgi59HWktwRUz2gRbkBKNs8ww/mXRajWoNi/n6ZsQrcLC34ISpCO?=
 =?us-ascii?Q?TU2QY+bu63H2Oon5jn78wnWU8urrNFEQ9KPOJtQHc0hhuZx3hSmcMxobqDFN?=
 =?us-ascii?Q?q+/zoNL+1NrHJFpLek7Ev8IRJLi28PivIoPcYDvjWXoer63ZdJges35Tvup3?=
 =?us-ascii?Q?Bhm/rjo7RoIjRgpK8kj0fCrIYr98uUbJppket49Tt1XsEl6jo9yl0YMjQjtT?=
 =?us-ascii?Q?Bbbq6gevet3vLDbVxzFfllWyA5hwOLM87boMpQYLRgaHeQt4aV60WS8k7ooH?=
 =?us-ascii?Q?C6r1TxnUquKzNohExhUOkxa2WB28A8BUwmOqLTrc5PS+PQ/tcgVDePjDsD0J?=
 =?us-ascii?Q?n3WwC7e1APAJCRqjTsQi9CkqXD4bF+2D3/37J7eny0hrlZ83cLcv/ASsR65p?=
 =?us-ascii?Q?dxJEbjHovYO1zdm4VaY6a0E2VcWBoqFnNP2mUWJvUIt+ddi8QDkRs6qUgvQQ?=
 =?us-ascii?Q?Wo9BV2c2ipk65msAjBK6l0CZUouplRjGfok0aN9Va/vE+bZDslW7J79Y9DFA?=
 =?us-ascii?Q?iFw2XNurOK2fzvRVi3VpniIAVLT+JOoaypJrnsQ+h/ogesYrgdB+vpjFNspX?=
 =?us-ascii?Q?OGmjeXK1hi1cceVYpXqMrRHXcWhdLnGYVZZP/87cC0UV0o9Cc13V51dPrupc?=
 =?us-ascii?Q?4wWdSQXaHLBYic5LFEUdsp58RK0yoRJbNBaLSAhTnU7GxY4Nb5hSjAmFzcYc?=
 =?us-ascii?Q?QaTr0lBwzj6bvgzI9HGJzLpaJ68+oI2gC/Kn+7NsgHFPYB/BQq02dWpGtddv?=
 =?us-ascii?Q?k6vMBvrnX/MMpiDpEoso5gkINu+lwZa0yQCnV34NXRbXYpGzU7H1wyvxd59y?=
 =?us-ascii?Q?rOBlNHAda4a/qxR4LAzgps4ky1y7jrCZIKsueZ4maDKz4aJCXJT16XwwOvE4?=
 =?us-ascii?Q?FmbaGXlhbqfaPTuas1ldVGUxueNLSQWFKtMQ4cinRi5n+Dibc3cfBiLlM8nG?=
 =?us-ascii?Q?N4XmbOlqucVUhlSf4kBHrzgz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rn/wtlHiuW1SyKoh26wb47uJHyJCLBavHNQ0Ibu9PYTeGy1n1GEOnIYU4Tnp?=
 =?us-ascii?Q?KnYUeO/PjglCHN9u1SFT7Dwo+1Z8W/0Pzkild7s7j9+MUw3GlZj4pLSZHnbD?=
 =?us-ascii?Q?BIfHqXZdeXPa+3Cp8n1mbFVaBWwVRkReYeA0XbGUA51TxyCX7i7vSkwYDbOD?=
 =?us-ascii?Q?b+PGv5AHrMhGq6KNpHO53nCv4IfHhF0+8xkVs0KxqtMOU7AC6quLTSgRTeWT?=
 =?us-ascii?Q?YrHcCr9YWoIjdEemsUJ7A/dgmMLme/4tdxlsGAt4bFQlph0MdqvKjrhrFyu2?=
 =?us-ascii?Q?eQgHF5A/gFFrb9x7qQGzGwd/GcvDALAP71V2Mit5XL5CVv9ciB22Zg/dsYBX?=
 =?us-ascii?Q?UySG0UpMN273+VAYEi082cqaRC9Uzw+VD1eCXFhmlkinB8tvRghDyO+XdIcA?=
 =?us-ascii?Q?DrbfwDFGssJLVjiizzhLKL+TAmqBNViRzGtdp1IcHNtjR0KUJ3YmGRv+ferh?=
 =?us-ascii?Q?3DrxoQk1QpnSJURTfwhDQL3aBWBlvX5QY0od8HtVz4EGUrsVTieP6zdzRXNk?=
 =?us-ascii?Q?V5TrDolBagQuLkzLNNk93nwO/Y+SRdr068+9GCGQfWl68Or1rVE5IlD5rGeu?=
 =?us-ascii?Q?uAwFzbCD26tV6UEd1uhD3MgWIsxa8r0yziMzYa9fYHIHyb22ZOrtpJIFUxQs?=
 =?us-ascii?Q?eS0+NPyZZP74k41tArXr3TmFG8/1ZL7A+J/PozQE87gsSELG5Tcnu9xdZ/er?=
 =?us-ascii?Q?btKobKRSLMR0GkD58ScNv54rO018F4VUHwN38kcDJMJlR9O8scZdTMGTqcAr?=
 =?us-ascii?Q?BxdSxefjfn3m/n5FcnbalwwRjrsi2oii4C7zEmuO6dhW7GIJGlUwicxc170C?=
 =?us-ascii?Q?wRYVVa1W3GZZXk9EsIIb24BhQbGuF6XxvetkV3qHxlEFdEser/+B4hZvx+D1?=
 =?us-ascii?Q?cQ6o/wwMAXk7HM4fqoTxTKvUmhz4M1ztCm3Pnqwu4Bxs26Ydka/n77/0uGDA?=
 =?us-ascii?Q?+FIjXf9GduBJK27OOOGtbhqJAwoAi6mfXSW0wxQ2icceBUXKSC0N65rIfCc/?=
 =?us-ascii?Q?0vlY0Y3wlmkkpSIEgz2FsGFjQiJelq6uEczxM/xZHB4GAEICINdbgRSo0DrH?=
 =?us-ascii?Q?XML6SQPwzMjUqzYuay27Ui3e4QOUGgXi1k1Bb5saP6CwoLTT0kxvTvbeD07w?=
 =?us-ascii?Q?8alXkBu2OlWCbq0Tjvh/G2w4BUcp5c0K8trtp6b4cB97Xo57qHfpD4ELz1cm?=
 =?us-ascii?Q?LK90j7IkKB7uoXFeWsq0ZC0hHZHMW9TB28/FZjyLzfg1cI6HVYWTStPmRWRr?=
 =?us-ascii?Q?ibcsvUJCDOLyMXpHtukUfxnXgCN12Od5L06MMekolJVFpTPtf+ursWX2beha?=
 =?us-ascii?Q?ClC27Dg7J3zEMa+C/gPRRg2GhohGMAgQyzd96P/4SvuNb1dYY7goRPv8RzMP?=
 =?us-ascii?Q?mC4CUnEpLsglDxdcBEBgn5XIi1nRIIWevxMHQLhSzP88hUg3exv2rvNyN4VL?=
 =?us-ascii?Q?WHtvWtWCcPpcCSfL5rUkWyD11sI9bWOUObWRni3qEzwuz17wSJlo4LXZHh1E?=
 =?us-ascii?Q?0A3E4FYv6dQ+wzBM1uyYCs4KVvcbIbZDJHHOsPfE6UcfIU/4LtBO4+a6N/sX?=
 =?us-ascii?Q?Kv4cSDD8Ui8au3Iy+Yee2jitt2syFVbai5mL0kiDZWhXxgHykg8FLr+UZzTV?=
 =?us-ascii?Q?UBcIGIAd3LYWHrvN6lEA3qjL8VIDxdn4NqMhpAxJMBJMgEtZ4SmqF6/RdkRn?=
 =?us-ascii?Q?o+69cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EuZ55C6AMsbmH8W9f1jWu+VWJ3b+0PqFqaHvfshQVonl/XXD0Hs17nP/SVh0JuSXcYGYUSff+kFMEuAIEMGYGxXPXGeAz6FJ8PBk3Siw5V5FsaWMAvd17CLSuBylJLCJ5aWW9M1z5Bpy4m6JQySygI25sb+qu8SL4FZDlvSkJsxfOAnjldahoTB5Js7KXQRf6KMiViBGPC/q+ZHmKLQc18ypbnW1xSRV22FJMDddCxhHP79goDcyIhjZ9HqDlFrKG7zOyhEEHibh2ANHsMeTfe16MEihW9VuLJHkKk80JqJF6l82NuoeGkpjjTeWsvPf7ryLgije7C32ef0DyF/BWjgsGa+nKFTPOp/YcUYxMkydK1p7ui/ujb6nC0mdptbnfce2lLwkYUaj3AFMkelyWbB358CGetJG8tXuQ1iUJloHv5g+PsuJqzd1b3sonb8WkzZ85y9fMZACQVDQzUlNgDKprZsRhtXGPcESZfmDzRARWPFQb5T4fgmlxmvi1KU2CBYSpcAA1OzWhLzBqdoLUCm9FfTCAzX/j6F/Hyza7qmyaojjKAE9rXuFDBr9Xv5fXjr30vbLTX9lwM0eOd4Ays3k3UGB4dwhmD88zxaUThE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b3d9ab-fbcc-4cdc-9d4c-08dcf2d9e64b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:41:26.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3NAY8d/jsBs221Kg11m0goz7qOrCtGOQISK+dA6ORobGb4TiQfiJigeLUQBoPS43BDalRYkukuR7XdX/7I4vCcuhy+0voA52jtr2drqkwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220134
X-Proofpoint-GUID: FfHMgnH1wUJLWAEkO_MGPTBhVvof2AfG
X-Proofpoint-ORIG-GUID: FfHMgnH1wUJLWAEkO_MGPTBhVvof2AfG

In previous commits we effected improvements to the mmap() logic in
mmap_region() and its newly introduced internal implementation function
__mmap_region().

However as these changes are intended to be backported, we kept the delta
as small as is possible and made as few changes as possible to the newly
introduced mm/vma.* files.

Take the opportunity to move this logic to mm/vma.c which not only isolates
it, but also makes it available for later userland testing which can help
us catch such logic errors far earlier.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c         | 235 ---------------------------------
 mm/vma.c          | 324 +++++++++++++++++++++++++++++++++++++++++++++-
 mm/vma.h          |  97 +-------------
 mm/vma_internal.h |   5 +
 4 files changed, 330 insertions(+), 331 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7d02b47a1895..1adf2c1cc3c0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -577,22 +577,6 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
 }
 #endif /* __ARCH_WANT_SYS_OLD_MMAP */

-/*
- * We account for memory if it's a private writeable mapping,
- * not hugepages and VM_NORESERVE wasn't set.
- */
-static inline bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
-{
-	/*
-	 * hugetlb has its own accounting separate from the core VM
-	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
-	 */
-	if (file && is_file_hugepages(file))
-		return false;
-
-	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
-}
-
 /**
  * unmapped_area() - Find an area between the low_limit and the high_limit with
  * the correct alignment and offset, all from @info. Note: current->mm is used
@@ -1361,225 +1345,6 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

-static unsigned long __mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
-	pgoff_t pglen = PHYS_PFN(len);
-	unsigned long charged = 0;
-	struct vma_munmap_struct vms;
-	struct ma_state mas_detach;
-	struct maple_tree mt_detach;
-	unsigned long end = addr + len;
-	int error;
-	VMA_ITERATOR(vmi, mm, addr);
-	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
-
-	vmg.file = file;
-	/* Find the first overlapping VMA */
-	vma = vma_find(&vmi, end);
-	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
-	if (vma) {
-		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-		mt_on_stack(mt_detach);
-		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
-		/* Prepare to unmap any existing mapping in the area */
-		error = vms_gather_munmap_vmas(&vms, &mas_detach);
-		if (error)
-			goto gather_failed;
-
-		vmg.next = vms.next;
-		vmg.prev = vms.prev;
-		vma = NULL;
-	} else {
-		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
-	}
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
-		error = -ENOMEM;
-		goto abort_munmap;
-	}
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged = pglen;
-		charged -= vms.nr_accounted;
-		if (charged) {
-			error = security_vm_enough_memory_mm(mm, charged);
-			if (error)
-				goto abort_munmap;
-		}
-
-		vms.nr_accounted = 0;
-		vm_flags |= VM_ACCOUNT;
-		vmg.flags = vm_flags;
-	}
-
-	/*
-	 * clear PTEs while the vma is still in the tree so that rmap
-	 * cannot race with the freeing later in the truncate scenario.
-	 * This is also needed for mmap_file(), which is why vm_ops
-	 * close function is called.
-	 */
-	vms_clean_up_area(&vms, &mas_detach);
-	vma = vma_merge_new_range(&vmg);
-	if (vma)
-		goto expanded;
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma_iter_config(&vmi, addr, end);
-	vma_set_range(vma, addr, end, pgoff);
-	vm_flags_init(vma, vm_flags);
-	vma->vm_page_prot = vm_get_page_prot(vm_flags);
-
-	if (vma_iter_prealloc(&vmi, vma)) {
-		error = -ENOMEM;
-		goto free_vma;
-	}
-
-	if (file) {
-		vma->vm_file = get_file(file);
-		error = mmap_file(file, vma);
-		if (error)
-			goto unmap_and_free_file_vma;
-
-		/* Drivers cannot alter the address of the VMA. */
-		WARN_ON_ONCE(addr != vma->vm_start);
-		/*
-		 * Drivers should not permit writability when previously it was
-		 * disallowed.
-		 */
-		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
-				!(vm_flags & VM_MAYWRITE) &&
-				(vma->vm_flags & VM_MAYWRITE));
-
-		vma_iter_config(&vmi, addr, end);
-		/*
-		 * If vm_flags changed after mmap_file(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
-			struct vm_area_struct *merge;
-
-			vmg.flags = vma->vm_flags;
-			/* If this fails, state is reset ready for a reattempt. */
-			merge = vma_merge_new_range(&vmg);
-
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma_iter_free(&vmi);
-				vma = merge;
-				/* Update vm_flags to pick up the change. */
-				vm_flags = vma->vm_flags;
-				goto file_expanded;
-			}
-			vma_iter_config(&vmi, addr, end);
-		}
-
-		vm_flags = vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error = shmem_zero_setup(vma);
-		if (error)
-			goto free_iter_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-#ifdef CONFIG_SPARC64
-	/* TODO: Fix SPARC ADI! */
-	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
-#endif
-
-	/* Lock the VMA since it is modified after insertion into VMA tree */
-	vma_start_write(vma);
-	vma_iter_store(&vmi, vma);
-	mm->map_count++;
-	vma_link_file(vma);
-
-	/*
-	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
-	 * call covers the non-merge case.
-	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
-
-file_expanded:
-	file = vma->vm_file;
-	ksm_add_vma(vma);
-expanded:
-	perf_event_mmap(vma);
-
-	/* Unmap any existing mapping in the area */
-	vms_complete_munmap_vmas(&vms, &mas_detach);
-
-	vm_stat_account(mm, vm_flags, pglen);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(current->mm))
-			vm_flags_clear(vma, VM_LOCKED_MASK);
-		else
-			mm->locked_vm += pglen;
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vm_flags_set(vma, VM_SOFTDIRTY);
-
-	vma_set_page_prot(vma);
-
-	return addr;
-
-unmap_and_free_file_vma:
-	fput(vma->vm_file);
-	vma->vm_file = NULL;
-
-	vma_iter_set(&vmi, vma->vm_end);
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-free_iter_vma:
-	vma_iter_free(&vmi);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-
-abort_munmap:
-	vms_abort_munmap_vmas(&vms, &mas_detach);
-gather_failed:
-	return error;
-}
-
 unsigned long mmap_region(struct file *file, unsigned long addr,
 			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 			  struct list_head *uf)
diff --git a/mm/vma.c b/mm/vma.c
index bb7cfa2dc282..7617f9d50d62 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1103,7 +1103,7 @@ static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 	vms->clear_ptes = false;
 }

-void vms_clean_up_area(struct vma_munmap_struct *vms,
+static void vms_clean_up_area(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
@@ -1126,7 +1126,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
@@ -1167,6 +1167,23 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	__mt_destroy(mas_detach->tree);
 }

+/*
+ * reattach_vmas() - Undo any munmap work and free resources
+ * @mas_detach: The maple state with the detached maple tree
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static void reattach_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
@@ -1177,7 +1194,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
  *
  * Return: 0 on success, error otherwise
  */
-int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
@@ -1315,6 +1332,39 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	return error;
 }

+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	if (vma) {
+		vms->start = start;
+		vms->end = end;
+	} else {
+		vms->start = vms->end = 0;
+	}
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->clear_ptes = false;
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2069,3 +2119,271 @@ void mm_drop_all_locks(struct mm_struct *mm)

 	mutex_unlock(&mm_all_locks_mutex);
 }
+
+/*
+ * We account for memory if it's a private writeable mapping,
+ * not hugepages and VM_NORESERVE wasn't set.
+ */
+static bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
+{
+	/*
+	 * hugetlb has its own accounting separate from the core VM
+	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
+	 */
+	if (file && is_file_hugepages(file))
+		return false;
+
+	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
+}
+
+/*
+ * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
+ * operation.
+ * @vms: The vma unmap structure
+ * @mas_detach: The maple state with the detached maple tree
+ *
+ * Reattach any detached vmas, free up the maple tree used to track the vmas.
+ * If that's not possible because the ptes are cleared (and vm_ops->closed() may
+ * have been called), then a NULL is written over the vmas and the vmas are
+ * removed (munmap() completed).
+ */
+static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
+{
+	struct ma_state *mas = &vms->vmi->mas;
+
+	if (!vms->nr_pages)
+		return;
+
+	if (vms->clear_ptes)
+		return reattach_vmas(mas_detach);
+
+	/*
+	 * Aborting cannot just call the vm_ops open() because they are often
+	 * not symmetrical and state data has been lost.  Resort to the old
+	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
+	 */
+	mas_set_range(mas, vms->start, vms->end - 1);
+	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
+	/* Clean up the insertion of the unfortunate gap */
+	vms_complete_munmap_vmas(vms, mas_detach);
+}
+
+unsigned long __mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL;
+	pgoff_t pglen = PHYS_PFN(len);
+	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
+	unsigned long end = addr + len;
+	int error;
+	VMA_ITERATOR(vmi, mm, addr);
+	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
+
+	vmg.file = file;
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+	if (vma) {
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		/* Prepare to unmap any existing mapping in the area */
+		error = vms_gather_munmap_vmas(&vms, &mas_detach);
+		if (error)
+			goto gather_failed;
+
+		vmg.next = vms.next;
+		vmg.prev = vms.prev;
+		vma = NULL;
+	} else {
+		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
+	}
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
+		error = -ENOMEM;
+		goto abort_munmap;
+	}
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged = pglen;
+		charged -= vms.nr_accounted;
+		if (charged) {
+			error = security_vm_enough_memory_mm(mm, charged);
+			if (error)
+				goto abort_munmap;
+		}
+
+		vms.nr_accounted = 0;
+		vm_flags |= VM_ACCOUNT;
+		vmg.flags = vm_flags;
+	}
+
+	/*
+	 * clear PTEs while the vma is still in the tree so that rmap
+	 * cannot race with the freeing later in the truncate scenario.
+	 * This is also needed for mmap_file(), which is why vm_ops
+	 * close function is called.
+	 */
+	vms_clean_up_area(&vms, &mas_detach);
+	vma = vma_merge_new_range(&vmg);
+	if (vma)
+		goto expanded;
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma = vm_area_alloc(mm);
+	if (!vma) {
+		error = -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma_iter_config(&vmi, addr, end);
+	vma_set_range(vma, addr, end, pgoff);
+	vm_flags_init(vma, vm_flags);
+	vma->vm_page_prot = vm_get_page_prot(vm_flags);
+
+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
+
+	if (file) {
+		vma->vm_file = get_file(file);
+		error = mmap_file(file, vma);
+		if (error)
+			goto unmap_and_free_file_vma;
+
+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
+		/*
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
+		 */
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
+		vma_iter_config(&vmi, addr, end);
+		/*
+		 * If vm_flags changed after mmap_file(), we should try merge
+		 * vma again as we may succeed this time.
+		 */
+		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			struct vm_area_struct *merge;
+
+			vmg.flags = vma->vm_flags;
+			/* If this fails, state is reset ready for a reattempt. */
+			merge = vma_merge_new_range(&vmg);
+
+			if (merge) {
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma_iter_free(&vmi);
+				vma = merge;
+				/* Update vm_flags to pick up the change. */
+				vm_flags = vma->vm_flags;
+				goto file_expanded;
+			}
+			vma_iter_config(&vmi, addr, end);
+		}
+
+		vm_flags = vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error = shmem_zero_setup(vma);
+		if (error)
+			goto free_iter_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
+
+	/* Lock the VMA since it is modified after insertion into VMA tree */
+	vma_start_write(vma);
+	vma_iter_store(&vmi, vma);
+	mm->map_count++;
+	vma_link_file(vma);
+
+	/*
+	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
+	 * call covers the non-merge case.
+	 */
+	khugepaged_enter_vma(vma, vma->vm_flags);
+
+file_expanded:
+	file = vma->vm_file;
+	ksm_add_vma(vma);
+expanded:
+	perf_event_mmap(vma);
+
+	/* Unmap any existing mapping in the area */
+	vms_complete_munmap_vmas(&vms, &mas_detach);
+
+	vm_stat_account(mm, vm_flags, pglen);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+					is_vm_hugetlb_page(vma) ||
+					vma == get_gate_vma(current->mm))
+			vm_flags_clear(vma, VM_LOCKED_MASK);
+		else
+			mm->locked_vm += pglen;
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vm_flags_set(vma, VM_SOFTDIRTY);
+
+	vma_set_page_prot(vma);
+
+	return addr;
+
+unmap_and_free_file_vma:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;
+
+	vma_iter_set(&vmi, vma->vm_end);
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
+free_iter_vma:
+	vma_iter_free(&vmi);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+
+abort_munmap:
+	vms_abort_munmap_vmas(&vms, &mas_detach);
+gather_failed:
+	return error;
+}
diff --git a/mm/vma.h b/mm/vma.h
index 75558b5e9c8c..eb15616e4e2c 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -165,99 +165,6 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }

-#ifdef CONFIG_MMU
-/*
- * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
- * @vms: The vma munmap struct
- * @vmi: The vma iterator
- * @vma: The first vm_area_struct to munmap
- * @start: The aligned start address to munmap
- * @end: The aligned end address to munmap
- * @uf: The userfaultfd list_head
- * @unlock: Unlock after the operation.  Only unlocked on success
- */
-static inline void init_vma_munmap(struct vma_munmap_struct *vms,
-		struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	vms->vmi = vmi;
-	vms->vma = vma;
-	if (vma) {
-		vms->start = start;
-		vms->end = end;
-	} else {
-		vms->start = vms->end = 0;
-	}
-	vms->unlock = unlock;
-	vms->uf = uf;
-	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
-	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
-	vms->unmap_start = FIRST_USER_ADDRESS;
-	vms->unmap_end = USER_PGTABLES_CEILING;
-	vms->clear_ptes = false;
-}
-#endif
-
-int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach);
-
-void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach);
-
-void vms_clean_up_area(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach);
-
-/*
- * reattach_vmas() - Undo any munmap work and free resources
- * @mas_detach: The maple state with the detached maple tree
- *
- * Reattach any detached vmas and free up the maple tree used to track the vmas.
- */
-static inline void reattach_vmas(struct ma_state *mas_detach)
-{
-	struct vm_area_struct *vma;
-
-	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
-		vma_mark_detached(vma, false);
-
-	__mt_destroy(mas_detach->tree);
-}
-
-/*
- * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
- * operation.
- * @vms: The vma unmap structure
- * @mas_detach: The maple state with the detached maple tree
- *
- * Reattach any detached vmas, free up the maple tree used to track the vmas.
- * If that's not possible because the ptes are cleared (and vm_ops->closed() may
- * have been called), then a NULL is written over the vmas and the vmas are
- * removed (munmap() completed).
- */
-static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach)
-{
-	struct ma_state *mas = &vms->vmi->mas;
-	if (!vms->nr_pages)
-		return;
-
-	if (vms->clear_ptes)
-		return reattach_vmas(mas_detach);
-
-	/*
-	 * Aborting cannot just call the vm_ops open() because they are often
-	 * not symmetrical and state data has been lost.  Resort to the old
-	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
-	 */
-	mas_set_range(mas, vms->start, vms->end - 1);
-	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
-	/* Clean up the insertion of the unfortunate gap */
-	vms_complete_munmap_vmas(vms, mas_detach);
-}
-
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
@@ -336,6 +243,10 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);

+unsigned long __mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf);
+
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
 	/*
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index b930ab12a587..fc5f172a36bd 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -17,8 +17,10 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/huge_mm.h>
+#include <linux/hugetlb.h>
 #include <linux/hugetlb_inline.h>
 #include <linux/kernel.h>
+#include <linux/ksm.h>
 #include <linux/khugepaged.h>
 #include <linux/list.h>
 #include <linux/maple_tree.h>
@@ -32,11 +34,14 @@
 #include <linux/mmu_context.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
+#include <linux/perf_event.h>
 #include <linux/pfn.h>
 #include <linux/rcupdate.h>
 #include <linux/rmap.h>
 #include <linux/rwsem.h>
 #include <linux/sched/signal.h>
+#include <linux/security.h>
+#include <linux/shmem_fs.h>
 #include <linux/swap.h>
 #include <linux/uprobes.h>
 #include <linux/userfaultfd_k.h>
--
2.47.0

