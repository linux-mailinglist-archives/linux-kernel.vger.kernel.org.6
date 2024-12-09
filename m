Return-Path: <linux-kernel+bounces-436728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25B29E8A08
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47AD188538E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE041537C3;
	Mon,  9 Dec 2024 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vQcNirfX"
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020072.outbound.protection.outlook.com [40.93.198.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0E2572;
	Mon,  9 Dec 2024 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733716502; cv=fail; b=AigNE6b5CR1oAsw7gDSKQUays5lo6vEcCotlf0uoytt1hoUBt21fAhrStoaFg3yGq2FdrF6UJJWVtaVC0qT7TfDNPaX/TiPwCtuWCUTA82/2pTpSBXyTfTlG/xkOjVj84mwt+tgwuTXZpuaZDWAY6hG/WeFV5Qb7OCLDNj5XlYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733716502; c=relaxed/simple;
	bh=NITflXCGCzi5rQOxjTlvJO1JSIutLVxpXYnUiCUTRVI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V8BqxwE1PMDGS6Vr6G5W2+mgCWLY9xN9cx7+WnBMy53FBSWnZUnBu67fyOtGpNn9LkCpRAwLiQF415FO4VmYqVUKH5Q9+ydNXpjRUgS0N1MhfwNp1us5afgGUn8XhVSvBwQM6kcY5kOYYjp8YcjdO0a1jyvAZrK+dv3joddetHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vQcNirfX; arc=fail smtp.client-ip=40.93.198.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUi//V59RK104pcxScox/nqrvjIXh9ctCVXLkScfUiiza7V6ZZYK8fbbZgboqpJ+GOmGDYtmIoDWcNKHhq9CrKChJb38H86/p1IR2+XBuwmuvuS5xU7JCxW28dGovI6nxRIMfWhhjN9Oh/Kyn3sWirVTPWH4/Y9Nqr++ze2algQY50BYTl/eqJWwnCUErkHMuupqT0MCUumFY+D9rUgEtuORs3DLe6jJ/lIeOrNa1sIzG/w0jliPRKX0VgPHeuyIJP3dsngUfQiB8YNed/0gUCXQBe9xCnaCwQFOp5dVpPgK3IPivc25IBWnuHdhG1g9853Q+zm/y7nZCI8jgRlxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyk58fuLqzp5PFox2DlDXJONW5qEXWNmfeWd8M1Wxlw=;
 b=AMxaTpwEgey3L2LDB8tqvVgIGR/ZJAKybVcRNFptpSQAZzWIMi6wl5PBEOw9imhddKcX9C439n4FuFVPxa2rQLZt0fmnzL6AMjcw6rO8Pdn10OBUAo6KieVmy4AwYcq64zp4oo8QniooRio1emjNwkKz42tqlNTrgoc/sE8QQ/4TvJE51Ju0IgfY9Dkm/Bo+ixayhKxbVJNxk+t67YyQF56Q8p5NAvpUmwzZ/IqlkvWkEr52+IhnLP75olmenYBs02dUfZ31+Vd1U4nvIsfkjrSClPIfPDwRZNxPzWNwWyEVBgDU6qrZc0an/u862EjhbpuDi+v9ktWj1YwKqjXpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyk58fuLqzp5PFox2DlDXJONW5qEXWNmfeWd8M1Wxlw=;
 b=vQcNirfXXSr8SXP7yT2xeZ2Y8QdRg059XGbH+GMt9+YABpkReCT437HI0Re2qEFIgo+gRhpTpsdapUOkTNpvfV4J8zFv8SLZUMcKxTxPgDJWZRq1Y6t4ch+2INUQVZl8cTbZqOoX508jsQMMxvSpLrcVTCjaYzjc7pZiNs/bOUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 PH7PR01MB8098.prod.exchangelabs.com (2603:10b6:510:2b6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.9; Mon, 9 Dec 2024 03:54:56 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.8251.011; Mon, 9 Dec 2024
 03:54:55 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: corbet@lwn.net,
	mingo@kernel.org,
	sshegde@linux.ibm.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH] docs/scheduler: Fix busy and idle type ordering
Date: Mon,  9 Dec 2024 03:54:28 +0000
Message-Id: <20241209035428.898293-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|PH7PR01MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: bee9694b-a9e4-4c22-f9fa-08dd18053e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lqseKybMwaWhRXDUfCNfUknDqkpqJ8dG3VukP/mysCBU/eYTN+Yecjn/E33E?=
 =?us-ascii?Q?ZNNpX+R9VUkBwZhOkklS9jndRuws+L6bBV4+kinJhLRo8WXwsrKtePB0PXYl?=
 =?us-ascii?Q?l9d1sPzCdCy1I+m2D9CDQFHfgJKWNRGEcXhMklauNWBPd+agN7OLxPvFrb2C?=
 =?us-ascii?Q?WRJuyy5XYZrJNeG2eTk7d5E1m7hwoROMny3hqQFn1j8e12GQ628on/cH9aCX?=
 =?us-ascii?Q?wCyo1nS5ziiWoM05oSllzCGIsyC/dVTSrGbLLEZ/qHUwZhh2NhvLzUSXYlX6?=
 =?us-ascii?Q?DDZ59NhxPBy1oZFCRQ50PlVrvYgHy/trsuk+zZoNzq0KR7ynEAA2/V9HC1Is?=
 =?us-ascii?Q?sdLuFyssxe2QEb7EnnXRfpdlNSVEkBN9gIAMthNWWrAyVbowhoQe8IJqyMvs?=
 =?us-ascii?Q?6aUMtwHIeJbi2ZGcW1LiB/mWZjWPFxknGGPEX3mmQWowzcrzBWNVZc7sZUS0?=
 =?us-ascii?Q?OhWNkJSBO0zHi1l4KWaxHWdwVjly0vC4KPBGCLhjs/J09IyVvi+OqmvONTue?=
 =?us-ascii?Q?DmqnpoVs0HQzUN/nlaWcWz5CPOnKTpqttofX3uCZRCTjh81H8gZYzJyO0jdu?=
 =?us-ascii?Q?pTA4jTnqU4l3Y5tf0KExY26fsxcrWIC+AKx8Fj50MSJEmFD1wZbzxd4Lof//?=
 =?us-ascii?Q?pDUbZna0ufmEEkwyl8LSitK74BLKuNAK+X/kRcAvHXjzuaHH1mCNZ81n56M/?=
 =?us-ascii?Q?Vrd73tQl0n7c86V7vfrTf33N/jDjAebqkJRXBKk0x/s5ilC05412ZsLJtdCm?=
 =?us-ascii?Q?0Q/yeUgS3icg9j47b7/uL5HRVIzb5bNbub6pphl3urjHQzZ62ImY7zzCFWAz?=
 =?us-ascii?Q?qxLTaQRuJTyPTLE8P9pWFz5h5yI1RWvYzxV/di38XYoQxkcZEKTzRDs2DyCw?=
 =?us-ascii?Q?fXzZhGMK2frdPT6xgINVtVw9NJWk71NdMbGaHc0wpZGQ9U8exUMad1Smj6yf?=
 =?us-ascii?Q?ZFSIrLJ6aY/FewGFEg/DPemBh7YUfi634yw9dUni0nS8LY8yQb/UVc1fQv0h?=
 =?us-ascii?Q?/O/NMbV00y2ztiMaKZfRq4XamDjnbwKZ6zPI3CpqilmB62fXkb5NKukblsQh?=
 =?us-ascii?Q?/IHDYC93PKWvMeAxEWmuaZdcNG/+BWjo9liaNxhaMJgql3csQlYOWjbm+UWL?=
 =?us-ascii?Q?2Hqh5isUtNhZ36gr44yiQD+aTD3nWY3kMiRINuQVpMxUOnLq9kmljE4xNmjN?=
 =?us-ascii?Q?rpG18A2dVC9aG5K2CXALhdBdlqbhUCZ7NZzPa/I1mTcyR7fJi2phfanVEpJc?=
 =?us-ascii?Q?9DA7pMD23QBQwREvLUhC9q9lviGIf3XxCQxEYU7H+VXZGB/a86gdq51v0mZu?=
 =?us-ascii?Q?/tlNnzFacCf7rozpm1KbmwvGaKn4y1Sar7hXit0uWCk8f03Nzo3u+lkEMdp5?=
 =?us-ascii?Q?Oxj/9opk02OZH1adNq1cnF1W1ACwyEEBWv2VZ3YhM1Diuii0cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zOLfSEMjlAtdFfB3CHoxAiuVxJOGkAdeqY8lA6Ps/0u4wRzszDTAvo8llB4t?=
 =?us-ascii?Q?XHwRWF+qw0xkfFNSH2OEir6BNEIOSzOdSlMrZ1VZdrLQrYRdKMj2gdc9gfSn?=
 =?us-ascii?Q?haqKBx3qBMyqN3e49lK5Nym+WZYhviuDdxa0MGh+GgT21u3AHm/97Gm21+25?=
 =?us-ascii?Q?GQXcs/W8tLynxQGt5dtTFzCHHf+T2kwSATiqDZFJG39SMtHSYwNSV+Z5pU5C?=
 =?us-ascii?Q?QpRldbQVKL/Ew7fXHf/8ebahWfGCZsjmS4tToEYtJMds1u85hbRDF7eHT1/j?=
 =?us-ascii?Q?xF13tEVwrh7zFd2vWy6WZx3rxjDvJpBxYi0Zul1p35rCTwDX9ia8bkardJl7?=
 =?us-ascii?Q?zz/1K0q6j0R3i4CRhSae3QQB0Ku4aiH8CRF8Ogb5TexguOKew9ODeeZ6bLvf?=
 =?us-ascii?Q?srStHVf9ALqAG/MWslM0kv+ypLy1Rq/cTDmUoMFawA7YPOnzUaav578q4o5b?=
 =?us-ascii?Q?lwXIxPy8BKjpcaUpTtwyxUpNG8VHDDv/FWaWoN0K3iJkKGHFoboijSp7NbSh?=
 =?us-ascii?Q?ZhRuQ5CiGmMEUlGqyotQdfjF5ZpmI+BAiaH7SSs1MJV3kDzbJ+VStXgeN+/c?=
 =?us-ascii?Q?k2vj/ybaMpWEQIGbGkRvpf8D6EaNebICNCZav0WiitqJ61fGL3X2GRKjSMJ2?=
 =?us-ascii?Q?T9AdvMc800wG2mBYDhdXrtZYNMdrdQjFzVgslEJUepyylntyyFX99Xus1vE4?=
 =?us-ascii?Q?/spWzrK5qp8ylpav9vYS3W3+46DR6LT4FBOmWFqe09lq+ucoxd8tZMBml/sc?=
 =?us-ascii?Q?mgNTWnsLP1AbwwYreukVV1o1nIwoHYgLm7r2f/nfv8OlGg0ewlhmil/DDm4N?=
 =?us-ascii?Q?Fevt955Ak2OFqeL3Yu+W5p3lpyW8LnTDmLDuBoEyIsKnd6zzeCY4DZ5PA6xM?=
 =?us-ascii?Q?vJG/0QdVzi5sEDjA3VYPTnpRA3DoixT6eLQ/C2AdhMSqOYg0u7/zr6vXzX87?=
 =?us-ascii?Q?ryPlgoPPxGzdi1Fouc0nbslz9AEklaodnQYjy9qHfB8HdVqWtqNHnGSKkz53?=
 =?us-ascii?Q?7yLmotgSxIArc+obgfVMyUK2qayQZacmESSsYGVsY6DjWIkRXU7lNW8RkT/Y?=
 =?us-ascii?Q?mVa1iCmA5b3RQ0Fp0StntsfCgadHxcgmXPx5T5O7X0iIQnH7eQsGt9GCyXz0?=
 =?us-ascii?Q?SQz5LQudcVEFn86bKoRgAoA8f7MIs+yR13L+v7znRVok3OLtpUmn9qyfmhTq?=
 =?us-ascii?Q?2zZzOmfSwOfnQfwlGwMCJ5bVamUzttnXi0PnznBysec/8VvyvSCcYBjTArsS?=
 =?us-ascii?Q?7NQaLZSRBAeQAL09cLpQ9hr5WCjHBzcF5l0OW+vqpUfGCS1ZHgiUS37MvykM?=
 =?us-ascii?Q?klK/igK4dL/N2Eko0w6W7Hbb72A1yM+mj+fXmHbS16itV7sP7QIPIvRclYV1?=
 =?us-ascii?Q?dZMGAGEWGH/HaFwfv57ZqdYP8a0WU9AEl4cSS2/tukHKwvYzKSSIQ6hI0VdN?=
 =?us-ascii?Q?DIrubmJXvXrz6oj4BmF4tYVEAJCs+Kk0Ybs7O+gBsZ+5AbT9IV5+Yclhdqmf?=
 =?us-ascii?Q?pp4eYhImp3ezxQg5GU3gxC6O7/j/E/Qvo43UNgarwsP1LzcLwgxgjETVy+v7?=
 =?us-ascii?Q?8RJXaYj8Go+bQldPivuVFiosy5x/36MNwrSDkFX3WlPEkNPnbJAGaOSB7xLH?=
 =?us-ascii?Q?NaLJP/BwfQ2sSf6qSCjD9wk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee9694b-a9e4-4c22-f9fa-08dd18053e00
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 03:54:55.8390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nc6isfl/o+V6p0jbepq102n/wnVEuPPBPuKc1GBPPXkzJgltJG+av5+zJLAjGcMEx5w7a9ej+Gy7Yp4F5uUH+TBlbkMCU5ze1jAt/sGG1NaDKNmcfLFHREHD9IY815xt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8098

Commit 11b0bfa5d463 ("sched/debug: Increase SCHEDSTAT_VERSION to 16")
documented change of CPU_IDLE and __CPU_NOT_IDLE ordering in
'enum cpu_idle_type'.

Fix the domain statistics description due to the ordering change.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 Documentation/scheduler/sched-stats.rst | 34 ++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 7c2b16c4729d..ab6f5392910d 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -78,39 +78,39 @@ domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
 The first field is a bit mask indicating what cpus this domain operates over.
 
 The next 24 are a variety of sched_balance_rq() statistics in grouped into types
-of idleness (idle, busy, and newly idle):
+of idleness (busy, idle, and newly idle):
 
     1)  # of times in this domain sched_balance_rq() was called when the
-        cpu was idle
+        cpu was busy
     2)  # of times in this domain sched_balance_rq() checked but found
-        the load did not require balancing when the cpu was idle
+        the load did not require balancing when the cpu was busy
     3)  # of times in this domain sched_balance_rq() tried to move one or
-        more tasks and failed, when the cpu was idle
+        more tasks and failed, when the cpu was busy
     4)  sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was idle
+        sched_balance_rq() in this domain when the cpu was busy
     5)  # of times in this domain pull_task() was called when the cpu
-        was idle
+        was busy
     6)  # of times in this domain pull_task() was called even though
-        the target task was cache-hot when idle
+        the target task was cache-hot when busy
     7)  # of times in this domain sched_balance_rq() was called but did
-        not find a busier queue while the cpu was idle
+        not find a busier queue while the cpu was busy
     8)  # of times in this domain a busier queue was found while the
-        cpu was idle but no busier group was found
+        cpu was busy but no busier group was found
     9)  # of times in this domain sched_balance_rq() was called when the
-        cpu was busy
+        cpu was idle
     10) # of times in this domain sched_balance_rq() checked but found the
-        load did not require balancing when busy
+        load did not require balancing when idle
     11) # of times in this domain sched_balance_rq() tried to move one or
-        more tasks and failed, when the cpu was busy
+        more tasks and failed, when the cpu was idle
     12) sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was busy
-    13) # of times in this domain pull_task() was called when busy
+        sched_balance_rq() in this domain when the cpu was idle
+    13) # of times in this domain pull_task() was called when idle
     14) # of times in this domain pull_task() was called even though the
-        target task was cache-hot when busy
+        target task was cache-hot when idle
     15) # of times in this domain sched_balance_rq() was called but did not
-        find a busier queue while the cpu was busy
+        find a busier queue while the cpu was idle
     16) # of times in this domain a busier queue was found while the cpu
-        was busy but no busier group was found
+        was idle but no busier group was found
 
     17) # of times in this domain sched_balance_rq() was called when the
         cpu was just becoming idle
-- 
2.25.1


