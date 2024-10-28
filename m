Return-Path: <linux-kernel+bounces-385571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C879B38C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072EB2837A0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32BC1DF99B;
	Mon, 28 Oct 2024 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UrKjU3ig"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78731DF97A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139009; cv=fail; b=mSectlgyHu+kx/r84R7Zb/BTA/9vMdQUKMIvOgK6Do+zgaekz5tFv42FcFkPTNZ6cs2q167Q5qeS2n9uzA9rL91P4K0EMrEoPTTVyec6aIZM0Z3O1mVZ55pgwPZiXFkxbvXBWVdPaDcuqVw0qb5jMV89JaxqKmmJlFvxS+yA+xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139009; c=relaxed/simple;
	bh=pCnj9LKKX7p5Ee4iexnWXELUkzNPt7+ggX01appZl8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxAPGEh7KIkneHGWFJYu67C5ceXlTClUSUzZ2ZCv4elFMnpWHLfzOt4RxDmS8+tBTdU38nvA/IbQecRIPAI85hnlbYDDYctOX6bN38wZ3bKpDTqVSR2hIvQhnuNpBMgw072Wa10mI0eUrmUaHKbsZF0HtIFZK559eMt6vrEio7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UrKjU3ig; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DraQyIbp4VfaQChjd6a3QhCVl19RqCSf9DiOTtJ8R5vJNIhiKUZjtzZaveFfD6mvNnmfbUdMc4ei4rUqwJit4vfpVDIUptUyKi6nSNZG+cynacR3ipT1LLLp767ORv/8dEaGI0zv9S5Au0v4hXsYslE0yfKznALncq5F98A9B6KR3TUEOK9mWkBfQ1FylkiWU6sOGKeN+0FtaGVH7RAfJWeRKIotJSk/8agBZWawIhRWHid5W/D97JPD1mO5gRO9SyZi7+4iWOSNSjPn8OL0rcFO+dXVwtJxYJcvYVkcTXuNodqYWHcHO3KMBixLjhVy0v8XTsJRMv4O6VGvgsqGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44WV/xweiC8aLwwZu1JatIBrE2jU2L2imh5jXosdR0E=;
 b=QAZXnYJEhs/uhP8zC/Dab4WcMrxS35Ex/W/omgcaqOTHZeLgbTcyV+1o7sjRIiXZsaB4q0lA3I+MXvNRJpu7LMdrBgxd+cPEr2o8u1EGzhaoyocyeoRZuhMO4ee3YHzK0PpyTGgifjQYJpBqYNPt2OvP6i6K0o4Xf1B6zdcbXvcB//uKWE+8bqU5fgh7d2LG+E7xiG4g/tNB3UXbKqTjGp7b0C2NY+gycGraCOwMGqgEkz4uMfnyz74E9GFafL5vNurVStcQCejbfTs2EWZXxJUNYnSOSQsIywoyhQRKYgzIFNc0dLUdFPdBTRXEM3ygc3bkLwosQIOKLpxYgRdHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44WV/xweiC8aLwwZu1JatIBrE2jU2L2imh5jXosdR0E=;
 b=UrKjU3igim7wVVopbHW8+etym0z5/G++iW6TDh98Ktl6RW2fIgYY2HkB3oOIhQgFy80ujNM9CAXGb+MxNXGo5ImX1onyy2p17vJDfoveXyDHd8qlAp1wEav/ac7VJWWpBSD9NWbi6fLDkgVc27SRgBHWCGjRXKlmAr8oej9NSPzpF/76rGEV8b6zVdW22T3275aUb/uIGuGow0niG/k4uRvzKR8B5ps4iG6MN70rp6ev6OznqEwzlWH8OgTZJ2NVflMHeg4zYle9Pd1kNxPbp8kBZklugEUiylBfsgrSP8IbZJA6eB3ihDLis4guyHf+wiVyMnSWZuUbWeyNkMITKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Mon, 28 Oct 2024 18:10:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 18:10:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 3/3] mm/truncate: use folio_split() for truncate operation.
Date: Mon, 28 Oct 2024 14:09:32 -0400
Message-ID: <20241028180932.1319265-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028180932.1319265-1-ziy@nvidia.com>
References: <20241028180932.1319265-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: bccd475a-7f0b-465e-ea6b-08dcf77bbcc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XtvgvwKZPv0BafahMUjbFYxPL+Z4mMGSZvrc3kq7zKHRBS9sXyLfpZV8vhn7?=
 =?us-ascii?Q?+cwsA5ExdmrTwsJ+NV+k8EpWd2lG0mBJap6BuNqsUuk/HRtvste+VC9LBR3f?=
 =?us-ascii?Q?PGwSPE6HwszZxBmhcgjL7z7Lpju4c+EgavqauT7yAM553Fgn21M8zaJCyYQ+?=
 =?us-ascii?Q?51vKNXN6jGiWQn1CL8VVaBNLNJOjPnbywDtm138GPdiRe/elYcCP30ZT8/S1?=
 =?us-ascii?Q?RWf8h4/4BaWOCaISvXBjS5dXNkICTdPLM42ml8BMBo1xvyzqiAaFAayVu54L?=
 =?us-ascii?Q?t7/eSweCYxs8w0n04i0WVkypxsXsEYD46AE81SeLa3ZnlyvySyEe+vUWwHos?=
 =?us-ascii?Q?7OpTmRS0eGvjzV7LxV277g+H6mxYCmnK4NbNF2aZy+Y3t+4VZomja6jFCVnm?=
 =?us-ascii?Q?SJ/TyDM5UqlzrjeQ2uHWtZWBhaHyX/2YuFzexVTAbeDtEEQ2TZoSJF7tB43q?=
 =?us-ascii?Q?Zku2MVhoRJbZUdG2qJIv8pa52F/lgtM36YWyuvnfqPsSGmyisJNIyRnLOmUf?=
 =?us-ascii?Q?tUGJmZ6iLS48+iapEtjhFLvqScFW/1J67PYM/9gXzbdAPqiU0Ks2to7bzSD3?=
 =?us-ascii?Q?GtF7ON4Xq4gsZAG6md3t+w/REESJE/DP5+KxlT/+UpW68qXh7izMB5Z19gJ2?=
 =?us-ascii?Q?Tp4zxdaVNVbph+L7Mscs07V9SbojMQ28D2Srr8DtXpJKZZnRgF8YlagTjA54?=
 =?us-ascii?Q?+63SWjiz/owXzkKQYwJZq/HHPo4b1Midxpz7nDSV5UBzojNd0fJrgWfMeumO?=
 =?us-ascii?Q?fI8s6oQG6zDPpmla5apOMaYPYPepkLyOJ16D3F1VNZy+ZxYzwEkSQ0nOZzaz?=
 =?us-ascii?Q?DWHBc33fz+OBg7wDvjXv+dPLssSQo2t5O8utcMoYvU1MMUnchuNIbnXmj2ZV?=
 =?us-ascii?Q?XHUQy9YXuauDVR4UxcoJxz6gXB4zGYs0QIQp842u+DDDxyQC/rrhCvCJwUiE?=
 =?us-ascii?Q?kXFXc9URjsMTV4kocPb6HSOulv8hm/a4kRE0C/sT+3d1qKI4QBcskHq+tLMz?=
 =?us-ascii?Q?sTlc3Igz3ch1gDhshnLKioie2YvPlLtTNrsw745SeQj3BbRJ715DGFKtfMsC?=
 =?us-ascii?Q?TdspLNGVLXPdtcbTVaGvZZS8C6Wt/9Kc4DAXLgH/Oo8hFhHNfT6lVsJUo3I5?=
 =?us-ascii?Q?qWFRyZ+X2yZhG7dyx5I1vXiyFz/sHkWlKb7CS7+f9L8DYQaSGmXTuv69OvDS?=
 =?us-ascii?Q?lgnIEYtcUqsHH3MJu6suCohxHOCiVAp8mglvyQPHj8N2+FD3MjRKd0lgMRF8?=
 =?us-ascii?Q?TRaB3VN/roqs9IveFTrqcJFAZzt9YXciXFcSSy69cyuRAQZdB1vHCuFgT1Tf?=
 =?us-ascii?Q?H5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x6apZXhoITnycejoxt+iJvX45Oe3jwAxmGvHYEzXLzxWNwIVkIZMdIb09zJA?=
 =?us-ascii?Q?v+DbNPFvPDQ3/VsIOQPElog6Xebkk7uPK/8+6bZOFMvahYgQLZZBwmGhQuZP?=
 =?us-ascii?Q?4HAKHsG3rcb31Bgk7TrEDxy+V16x1eXWlyBTXs6xsG7mvdNwMoGHi2pKmjDV?=
 =?us-ascii?Q?Oc2EzXKFfZd1jmFCA+lg1Ri5CbD84bCSX04hr57GUUv9JGSSCwS6clhcn9M8?=
 =?us-ascii?Q?dBvs//fjhigxYSwGyBcmaAOEmrTUULpUw9t8ykruuFB82EqmBcqOnmVAemSb?=
 =?us-ascii?Q?rKUbWBi/E1IB2Qnfuz0Eo8QnAqCE7GIRsT8a2aJzx7YG/jAXR5ZiIEbBkOgU?=
 =?us-ascii?Q?tnMa3BXLRs3TAmpY1Yn1jv2YsrCQEcDei2XaREnEJYf/VSUme5ZaqCOHjqYf?=
 =?us-ascii?Q?nhlLBVKUNomx8or874aXcJxgHTu+rBiqVOgfpxP8nF7VSukJJtgCXHdDYXdZ?=
 =?us-ascii?Q?qyPVPg43jjDaesm1TeG8Hu0TZgPRPSuDaJfEa/6C+lU6ohPof4M5uSFH/1xZ?=
 =?us-ascii?Q?PGbyfae5cXFI/kDQfiUu+pFEkRMF1ifvr8pxk3cdVG72WVoefb+S3fFImD77?=
 =?us-ascii?Q?ZcKlxSo8+NgulMpGp2kiCzus4+UXxMAH+uJrBq5UP14OgkrcByH8taOhL9cD?=
 =?us-ascii?Q?bhZvqPNrMq+AE1HgNeUT+qPp1F6YIewtfJX55IcNIHqZJksO6R14f0TcX/g/?=
 =?us-ascii?Q?KxoaXr/gdeTGVzFeBNsYI7qUyERP/DuFP2LfYCvukFnWAcRdgB7HOapnMI5e?=
 =?us-ascii?Q?OQnFLOIreE+KPwqud0PmbFC0fe+KWy0lJ/nf2WhdRrp9Da2nwv3EXGaEQYRa?=
 =?us-ascii?Q?99gOWgT0tbvdaUejzT1o4YBTGULKIWfQrnVqduXeD921K69JBK9t1jHwZgZ3?=
 =?us-ascii?Q?Vl4PZP2223xN/kCRS2uvMD0FwP9oThV3KNEnNIwzC3KBwb4Rl/bFhr8ebKfn?=
 =?us-ascii?Q?kEEItNbVajGvuKtRKzyeaCCJHL2D/aeq6JEwVNJXKssxcMVTXHbVOqubXUye?=
 =?us-ascii?Q?IvHogOpXaK0VmppL2VwtZ3Q3IZzRifTwz3A852e5nx2npKF7S37PhiC9c2q9?=
 =?us-ascii?Q?jCMu1NNQcj37SSlZUIPfzS88yjxnLoAvYw28W17sCzxijCb9AGwYhzS6tnNW?=
 =?us-ascii?Q?TK00IwQJ+SoPSJhMsl0vuV1wpZgT+6dcE3j3A6my02dZrbK8Wn+TMGk5lvtP?=
 =?us-ascii?Q?UFFg0dejEDkCqOQzv7IRp7R0JlUMuhBDilRt5GA1ZUFVHCSdIk0PYJhXCsv4?=
 =?us-ascii?Q?sY4boBn4Hz3rGDEFgsewuA8hiQq7r4vmN3fPsbVhP8owM6u+i2EqYfsATEQx?=
 =?us-ascii?Q?2Y2ZGfU8Evz1d9Vmk+CAxnpKghF9L3dEJCJnXq+KW5EExTfD6WBP4zv59R7u?=
 =?us-ascii?Q?X9v3ci49iik28b4opuIRjKtpDFtD0ar0sjzdrTwBsdqK7EeImJb4itj672sm?=
 =?us-ascii?Q?tXWRf2RTDDq+3kizna+CmQnlRUJI9hqMPkG0m6RQcRPKSv7otUuPjA6P+ua5?=
 =?us-ascii?Q?Kv4rIZ7Y5hXePwbKFP6AKbhaU0lH5kP4paKrLmQNWc6jPDcAfHXFlK9pBhIN?=
 =?us-ascii?Q?VQrTCbfsok6XiCreWU4lyBDpCls+kWtBqjDudY0m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccd475a-7f0b-465e-ea6b-08dcf77bbcc0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:10:00.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYhXKAw8KyN+2vJFw7IPWUMBDhun2nM009PBW7V4WIOKa0wBXPDzSd82RzLt7lgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

Instead of splitting the large folio uniformly during truncation, use
buddy allocator like split at the start of truncation range to minimize
the number of resulting folios.

For example, to truncate a order-4 folio
[0, 1, 2, 3, 4, 5, ..., 15]
between [3, 10] (inclusive), folio_split() splits the folio to
[0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
[8..15] is kept with zeros in [8..10].

It is possible to further do a folio_split() at 10, so more resulting
folios can be dropped. But it is left as future possible optimization
if needed.

Another possible optimization is to make folio_split() to split a folio
based on a given range, like [3..10] above. But that complicates
folio_split(), so it will investigated when necessary.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 12 ++++++++++++
 mm/huge_memory.c        |  2 +-
 mm/truncate.c           |  5 ++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b94c2e8ee918..8048500e7bc2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -339,6 +339,18 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
+int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
+		struct list_head *list);
+static inline int split_folio_at(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	return folio_split(folio, ret, page, list);
+}
 static inline int split_huge_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4ccd23473e2b..a688b73fa793 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3803,7 +3803,7 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
  *
  * After split, folio is left locked for caller.
  */
-static int folio_split(struct folio *folio, unsigned int new_order,
+int folio_split(struct folio *folio, unsigned int new_order,
 		struct page *page, struct list_head *list)
 {
 	return __folio_split(folio, new_order, page, list, false);
diff --git a/mm/truncate.c b/mm/truncate.c
index e5151703ba04..dbd81c21b460 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -179,6 +179,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length;
+	long in_folio_offset;
 
 	if (pos < start)
 		offset = start - pos;
@@ -208,7 +209,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+
+	in_folio_offset = PAGE_ALIGN_DOWN(offset) / PAGE_SIZE;
+	if (split_folio_at(folio, folio_page(folio, in_folio_offset), NULL) == 0)
 		return true;
 	if (folio_test_dirty(folio))
 		return false;
-- 
2.45.2


