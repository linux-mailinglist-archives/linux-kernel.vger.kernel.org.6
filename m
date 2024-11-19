Return-Path: <linux-kernel+bounces-414065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8414B9D2296
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CA61F22460
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594201AA1F8;
	Tue, 19 Nov 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oSiT/1YH"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2101.outbound.protection.outlook.com [40.107.20.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0A2AF0A;
	Tue, 19 Nov 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009180; cv=fail; b=uMUd9FvOaKGkyFGbhldaOrn6KwEFFEB7dG614KSKY8WrAIBDYdDWDe3iCuz0IenTk1KE6qVIkI9ZQrJ6rraR1ihw3FA5lg2esTW7jcIF2uPNMHwi9sLCo+aQd9MwzbGjaflnJ2eSPWvYVWGl/rO8cKO0jo30ytZIRsNUSAPXrqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009180; c=relaxed/simple;
	bh=vuPv5rkmZVeggFak0GNecIKJBtQOvhUM5yNGKZT+0E8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TSV71gnne/ePJPhG8dObi8qdhoZdX8uRLWnLlEKFLL96RcuQ3ENFEDw3eLoem8FeYup2vzSC4sab+k5Yq3CD3+NfjIVYKgimUzFCk/gO1lI/Fa5lrA7wARtd9r5VabgxkpWyOaRXE4egglSr8N44BRWLHXf19nVqJqLwW67HTHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=oSiT/1YH; arc=fail smtp.client-ip=40.107.20.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIPqTMHYNZN4Uz3XWVTuxHI1BG13gRPYUnph55NP3LPO6wBCxA3SkiLcOA2iP/Xw3qYiLlt93HzxbFnuBIwCvGlhGuDtQgDHgA529aQWIUy/MSww9pKgU5RMggnQb760Aq+U3OtAguVIMhsv5ZneMt5ycC6nZFBDEOdvX68GBcvWi+VrFmg5cxJN11SmnyE8bGK7TpkFiA9nF08GQqeqta2ygpNrynF1EsRqVLS5ExVbmeIm61g4yFHGreSvX/bNn0hXOixa3zDUvkMRTzjmY4am3C/EyeG26ldMNRV/0bIgV3geunancbwz2didPRW4yGz5D2YtCyj3VZpJdslOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7x04hpb41Sagnj6zAmdSwIjekM7JkXaP6J+8Whnu+g=;
 b=b+JmMQvYsJCpEhAD9Ex1sy8UTUUQIwws2WNwiOK71yAGX4rRjAWCBsHmF7ZqM1QroqLUDHu3inQnAGnHwYnFMmWkVsVsmAoXL07p8U3DvMw+/x4w9fYuRt9rjqe/97Agdl7km5gZJ1gcAgUdlH4wzf+o6onWSn6WaON0FVhgsTa+/FKtlEKbYLhiB7KUdfHtjn8V8+T8nSgXV/KOrOQQ4twhZNizcIbkdx1GQVbYPPtqKySgkSr+30KUecks1wqNV4oAE3yzzBf8msJpmlhEFjnyr+30cj+XWw1fTqbzm3HX4lwDJ9FHubz+cknypmdtYDJ9imEBjpAA76Cv9/OmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7x04hpb41Sagnj6zAmdSwIjekM7JkXaP6J+8Whnu+g=;
 b=oSiT/1YHUlU/22MY20YZO2NPilAmSx3CBu9wJA0HukI+OAIhkdm4V42sBV6gpBeaoEoUWS603zoPUtjrXVRbc534J45xfZIkgqY3wWapOoB/pXDVFzsFY/sxSn/zDWuyPnGKcC1Fv+Cq3uO/Ct+7UoK57/7+1VsFw9NQ3TFIKfjfxqN3Xyz08dzYmpC9x09uVFJEd/dvnyH0pHAcKiJg/jrHsI67f4ZtPUCfaJRsHzgJaMjoemm12wz8o7n0JgMXEgpVqcwfRCTAT5/J047UZF6b0eKKMhEGyA68K0WsKvL/uNfDohwWFDaikIs1N0ux5I853BGwxjJ++PlzymTo1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS2PR08MB8951.eurprd08.prod.outlook.com (2603:10a6:20b:5fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 09:39:35 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 09:39:34 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH] docs: core-api/gfp_mask-from-fs-io: indicate that vmalloc supports GFP_NOFS/GFP_NOIO
Date: Tue, 19 Nov 2024 17:39:01 +0800
Message-ID: <20241119093922.567138-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::15) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AS2PR08MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9b6aa7-90cd-4fbf-22ec-08dd087e13b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xsLIy2zLVDi6g89L581ojFXcaZPIf1CRezlrzbiOcU/cCvYYRx6O11h2PBqp?=
 =?us-ascii?Q?wLezZeBsiZ3guxG4zuhq9RsR8LbJtxqlNl+OtR7pY4RlL/ibpmQ8EphrVPoA?=
 =?us-ascii?Q?pyxq0TfQring7pL1b0WUqOhrWXvWHi+0Vnyut0+haOBkpRJEa7Eefgh1IeWY?=
 =?us-ascii?Q?pfnjHFPW8Yd1kYeYxniaxtZCASariVfHJq9Aw11ELj/gi2S7NZ3uyocDBEtA?=
 =?us-ascii?Q?CrZep2mOFsHCAvCdWJcUra5dh3IstEq+JyPezm19UjbULxwkdWxe/X3RBgQc?=
 =?us-ascii?Q?oW0aD0GXzsPdZUHbgjqkSecefYi1QmGZkijCip2HhKvNmRP0GrA+8HEcYZrz?=
 =?us-ascii?Q?FyuN8DwHlA9TYhCEPcm85owyP83hK8kfJxiUQ3mQyD7lkdpWLqldXj0BmbZz?=
 =?us-ascii?Q?0TgdulgcZ6XE/WPSUqjrA8eqo9nK0hcuXgL+uNxgozTt23AgTYwnDkF5RrOg?=
 =?us-ascii?Q?hQuUZVWY7yEo+uA5M4A/5+QUP1arq7L1Z+tDtsFmZiRRN0oOB9ig7S71pjq2?=
 =?us-ascii?Q?cFICfSfX7mAh0hO4xLtuyElHHkheQ9p/j+XpepUo2EU9sL9ZqcnidWI+ijI6?=
 =?us-ascii?Q?uCPQBYQS1oV/nv2rlbj8/zFEssUtHg2kvm4q+tiuOT5nxxvA+T0K6lS5kY6V?=
 =?us-ascii?Q?hYHEHGs12dGUecdphiQHwZ1reLjJ4WHACgY2IHYHLW6g9PQnyjdZgjTWg4I1?=
 =?us-ascii?Q?PmlwJlnfuzuZ2CdXDSzY5NPQNifJ/eqCSrkA5/XT7OszgTkv++44d8W0R8aL?=
 =?us-ascii?Q?zC8Vee5gmSUumy4+P2CjD0beR+8M7ml6KQNRYmU7j4UzTgig8atvNa4qnAHN?=
 =?us-ascii?Q?fP2Nl6s5tjYNB4yNBAbC4lgbrYwqi3uWSUnqzESnFuc8eKm6wxvFaOAL5VpZ?=
 =?us-ascii?Q?frx/AIOiUzxgckZna6PFzi4fa6KHJUIPURmqkMJjrnTrrmzOU/feQCF7OUZp?=
 =?us-ascii?Q?nqv8xEs4YdJyq+b3IY9MtNhIqJFaCUZTveC4bBNAj5BsW8a4sTgy9a3djzY6?=
 =?us-ascii?Q?nhjabGa7DqXSSeDE7gYLGYizYT5m2hJ4835SIdxoaQeAhPowbgDrebCxMBwj?=
 =?us-ascii?Q?UD4bwqLgh1xPVL6yV5CycP6UCBLlNJZNpqyFjysuo9TH4WP7BHGiCycm89gg?=
 =?us-ascii?Q?XT2YoTBqOKxdZMNDB2QcK/F4vjMJT068zOmGDaFgDRd29F3lZh9VtuisCGB5?=
 =?us-ascii?Q?ayps6RXobxgTWZ0Jki8mveh44JFwB+KHHUcAqptk3MqDgvB5wrg6OBvbTxv4?=
 =?us-ascii?Q?wtAJ6i90BOrXBgXFLU3gzPr73BmTpNH6jWCFsPkn6k2ig5s+k5rNvmDb3/Sy?=
 =?us-ascii?Q?Hi2FfW8q9elkXPcAgwyy7Bha?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfpNHAbyLUg6FhZT8BYjT6PyIYqbYo4MokEBCIDqmf5sUQQl9tfzBgAWrRYa?=
 =?us-ascii?Q?N56MVcVN3roEGmt7iGwvOFPaE56Lxh3ktcnHYqQkd8Jc4AXD51n+CxewNVH5?=
 =?us-ascii?Q?IGTNrrEjDYLjnge1UZYBwM4I1IIfU2W9xZYgqPcZ0axSDHsZaEzvNSqyU49v?=
 =?us-ascii?Q?ErBWU/vBFmNf82L1sJ28hnRev9lbsp/tODbHnr9eCW79PEXGAu2HoMtOIzh3?=
 =?us-ascii?Q?txbchcD2jXWMLutgtMTjeh/oEUh8WSCBV0FENV40TvpAVMCC/9+SqqjSUx8p?=
 =?us-ascii?Q?HGPYymC2KhpS+v/xwjSMCkG1RKVbzVG4TEICZW/8sFGf4+DyyR4G41pfvnym?=
 =?us-ascii?Q?2dGqxLrQhuxfSOmUa9bwei1r05SlTbMwGf9qXvJn76ky8BoNys1KMkGswe7M?=
 =?us-ascii?Q?Vh9OOhpiTS4SqyT5ZQGGgNNu3+iVXTapLO10y9gcjdmTWq/iYG8+RCnf6nCx?=
 =?us-ascii?Q?6c5ZqkAwmvMhqTNxXod9c91naqU31Ecq9shYqCFlkxLn/iLrcNN4SLRT1jtQ?=
 =?us-ascii?Q?WGWVxIpsMaKjh7qy2+0BqSEp0dqYIAqNUIfAAknQDKH7lqVU4eLc1J0XGq9H?=
 =?us-ascii?Q?AGjl8liQxr3K9vKkuVMnyRKCVNpr/BxG1bSVE55IjWQsg4w470pzPbnEdD9Q?=
 =?us-ascii?Q?4+FNiUQFPTulk0G0TDB6AeLmy2qn9pISLP1MB+LMeWGiuDcovdFakDyCYWyN?=
 =?us-ascii?Q?3Oiw5m21cInxvwtKDS0KiuwWr4J2NCc6fgJlsM5tn9m6VUs14sTKyi0GUBx8?=
 =?us-ascii?Q?o1SpIsfOCUyVq6hq9YUmlEPXs63z4N0awLkjzxuJqAtF6lXJBkiKV7tD5h8N?=
 =?us-ascii?Q?nxFeRAorbeAa/zvJaESNpwaFr7fP3tA33Xw6ICCv3zKU7zZ6Q1lmOwLly8Ru?=
 =?us-ascii?Q?vIsbSTjEjO08wW9l7zlBiE8eWdKmLc1LHksYuU22LxieDiiSOSP0uUi+RnF1?=
 =?us-ascii?Q?RGhOVDsnI14/pKpI6EDT6qMUaqEBmfwVuRT+POJe2CoEXXPNT5ZxLVcftsXX?=
 =?us-ascii?Q?QNTTQmqH9wKXSPXI+xcE9VDGnlW7QCpY8u6U6Yahn0kjOpQMvWadrjprtO6j?=
 =?us-ascii?Q?WjtTuubq+BnQsF9Z/IUBFk+OJ4jNDB4ogEbV//0mtzIvdTN5YIDm7fBuafuj?=
 =?us-ascii?Q?/jcrID8EuempDgOEqK7J02NyUBoUv8+J7WpTVv7bWF4CVGUEtaqK8uNWVMUQ?=
 =?us-ascii?Q?bhqtkKcJQUDuPrxVT6kWghnwhNjaehmxpzqmDT4uiuWKb65hl0RCGvN8N3cU?=
 =?us-ascii?Q?J+47nEbsKCjhK3KTZbWYrVOYY+V2juRe/BeuObQZuKCMWHSiro9Tw1yRFLGw?=
 =?us-ascii?Q?C3dVmmR+kknHbGh/R3qPMdqxHsLAT7y2xYeZIE8CIHENZA8hfPBeHq766jNz?=
 =?us-ascii?Q?v/TFUaAZncseUHcvT77zgwmI1VIumbO4Kikla+JsIcvAzij+ZjIlq6maO80N?=
 =?us-ascii?Q?IBDXC3Dr0VifsLYa4fauZdsLmAem5Ldn+Jf0miB5XUkdGCeDP4U+eiirq/ZU?=
 =?us-ascii?Q?b3zML+bLcJT8vqNZE/q9UmQpYZLMR3o6yoYu+qmg7XSZdoPR7Gi7mJFdWJNl?=
 =?us-ascii?Q?9xcOP4H6DIgKd3mdlgqwl+wvMfoI7ZiePbLpRT+czbSTlW1mioetSA0TLd1+?=
 =?us-ascii?Q?w+j26X3PqrMaZPfvbkc7ydNeaAzfb0InvoNqlvUY60N+B3qVtxh1+piRIK43?=
 =?us-ascii?Q?kbg7qQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9b6aa7-90cd-4fbf-22ec-08dd087e13b9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 09:39:34.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRqPntkdRT51G9LjUhwK/Rf0iB/UVg6bmhsdmNtglGkTGdR8HhSrEL5l/N7F9BOBgy59Fu2Td2hYSyOHFANhMaS/pBRmRMBdXVUAnOTK2hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8951

After the commit 451769ebb7e79 ("mm/vmalloc: alloc GFP_NO{FS,IO} for
vmalloc") in v5.17 it is now safe to use GFP_NOFS/GFP_NOIO flags
in [k]vmalloc, let's reflect it in documentation.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 .../core-api/gfp_mask-from-fs-io.rst          | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
index e7c32a8de126a..858b2fbcb36c7 100644
--- a/Documentation/core-api/gfp_mask-from-fs-io.rst
+++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
@@ -55,14 +55,16 @@ scope.
 What about __vmalloc(GFP_NOFS)
 ==============================
 
-vmalloc doesn't support GFP_NOFS semantic because there are hardcoded
-GFP_KERNEL allocations deep inside the allocator which are quite non-trivial
-to fix up. That means that calling ``vmalloc`` with GFP_NOFS/GFP_NOIO is
-almost always a bug. The good news is that the NOFS/NOIO semantic can be
-achieved by the scope API.
+Since v5.17, and specifically after the commit 451769ebb7e79 ("mm/vmalloc:
+alloc GFP_NO{FS,IO} for vmalloc"), GFP_NOFS/GFP_NOIO are now supported in
+``[k]vmalloc`` by implicitly using scope API.
+
+In earlier kernels ``vmalloc`` didn't support GFP_NOFS semantic because there
+were hardcoded GFP_KERNEL allocations deep inside the allocator. That means
+that calling ``vmalloc`` with GFP_NOFS/GFP_NOIO was almost always a bug.
 
 In the ideal world, upper layers should already mark dangerous contexts
-and so no special care is required and vmalloc should be called without
-any problems. Sometimes if the context is not really clear or there are
-layering violations then the recommended way around that is to wrap ``vmalloc``
-by the scope API with a comment explaining the problem.
+and so no special care is required and ``vmalloc`` should be called without any
+problems. Sometimes if the context is not really clear or there are layering
+violations then the recommended way around that (on pre-v5.17 kernels) is to
+wrap ``vmalloc`` by the scope API with a comment explaining the problem.
-- 
2.47.0


