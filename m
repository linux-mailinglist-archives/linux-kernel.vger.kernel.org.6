Return-Path: <linux-kernel+bounces-545680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E513A4F011
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F8E3ACE85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B71261560;
	Tue,  4 Mar 2025 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aPFTIeHU"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD525279324
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126858; cv=fail; b=E3jB1ci5aVnCp1q1nORZZkr3/H1Zo3aMnVLYABXjJ0eahLsLwTpBx9Q7N0AGVjeAVGQhZPefSHk9ON3sGcfHzjeUAN5U3aZlF3l/bfAvD2fWHUa5wNlkdxLmYneFO39H45ZqU3Yf3AY+jveSVBOIxaVC9Xsa5mscCIi48np5Ry0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126858; c=relaxed/simple;
	bh=g0RpaQcNRpqwOKrX8jNZH1ZGfGH/7jzZ1b2Cqb/XTHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tNtI0nUY7wTb2DbhPe6w+eWK3/27y4STLdrnETaqrCqfWykjECFBe4x7rBjZLjDUyHfwT4GxPVmBvgahz786nMq4Yno8RxdWGVfCiMVMXAS4FbyW/la7MGPB3X4GEZwJzWQVimcm2rLQ/IpcmziOAugREYXm4AgmSJYxZJZ8BQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aPFTIeHU; arc=fail smtp.client-ip=52.101.85.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+PVzPjWEgusvsnqd+pXygerLo6RUJ8oN08vI4lGBvjB7BR12qIWwvj16cAIaiqrXIdevesJDtaCeIBY0MaozsFSFgt5B5NI3DCLbUGM3+Rq78h8TR/MWZyYhlQWxA9ulgF14vwj8imO1giAaLlK/3jyjvbXnULULSl/rVe0EosMmrkVtYCEpWVBlEiGYz52no7mDZhlnT0x39cutE8kq3/DUSINJamkRaZIutmkr+FlbeAkAxJRBpHEc/yMuqHgODYX2dziLh5I3awxtzun97eH8aFGK3CDPr6mc7s3FuIx8ia0sH8Yp3E2VnFhLpYU4M84tpkBXoffUH+C6RPf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkmV7x3mcQBAyxbvWzDtrcqC+7mmWkYjzNradsUNkVU=;
 b=F8ZQbKOyfNQGKpAK8qJoT1pyxJwd9FhKU7zILrWsACOp4Af4HsUTkBcPeaJAJItF5HQf+Wz4uC5xTj6qQYvRT+Iy3bdmhLdB0gkygma23kAKeqIK1eJg8BAD2AvSB/4ZXeyzH9Bvs6enzX2lfXheJJvXM+KCbNZCg8XCMzLasrPrU2eYXj2O1aL15+zRkD0OSb5xMFrO9ot3iESJJKhwAx2/fMY6Qtm3iuzxeOvqnC1GKEXvv5qhLHqLE7lx2Mal9aXlt1fcEne/Mr9BhY+ymT/Z08dWgnUEIyK2YNPG3EhCaySMNmutaPNxuZDlZE+rN2yVjHFGUsQobyYACT1A/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkmV7x3mcQBAyxbvWzDtrcqC+7mmWkYjzNradsUNkVU=;
 b=aPFTIeHUjVx6Oya+l8C1SNhzJsO2iC4+oVaz9ZQwhGZomv7X64szM3xHLPubK5p0FxAtC+7dyXy/5vZMFi4gv2v/MUrth4/5oZW8iVr/RZVYnpxS/fIfndFLcSnBbK0jjQvrqWkXSAoP77Sg4mtQ9IbSThHPVFl2z4KqAPQa5ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH7PR01MB7931.prod.exchangelabs.com (2603:10b6:510:275::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.26; Tue, 4 Mar 2025 22:20:50 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 22:20:50 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	Miko.Lenczewski@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH 5/6] arm64: mm: support split CONT mappings
Date: Tue,  4 Mar 2025 14:19:30 -0800
Message-ID: <20250304222018.615808-6-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250304222018.615808-1-yang@os.amperecomputing.com>
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH7PR01MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf135ca-f1ff-4deb-a5fa-08dd5b6ad226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYrdNVuVE4Zpjm50pgIWQ1cQlC6zH8tELKx5InYgCHuXvh7cJ5XC2LZ0QnKF?=
 =?us-ascii?Q?56tl3hpsaprsAteEhCcmMBSfkSyYvx7M9pLwxIQwiZTkjK5AQNy0KFZxT+C4?=
 =?us-ascii?Q?HDQUv07zPQPCxCbNO/ONwgwN79NkZYI+0tCzxn5ZKlgUGHrdwxPuKmx2WcP+?=
 =?us-ascii?Q?nM1ZtqS1YRdg/ZJDcAveXOfwxUMT6CNUcINhjRwaYKNypbMXNiMRoYPrwr6w?=
 =?us-ascii?Q?pzm3Z+gAIi+AhNJY5/GpIKcLtoBDo/W02MqsBt+re5pc/1npyECFmTV9w2ku?=
 =?us-ascii?Q?uZhnxPFstpiZMLuF3HOLbodIMlieU/AbSj+8aHpBfsGhOqvN6o1GRvGSbwFh?=
 =?us-ascii?Q?bPLzodvl204qejIEEd7UqRoZdvfMnziyPsELAh2Sxm0wMTFmLM5eqOha5q7j?=
 =?us-ascii?Q?UPNJxgYxFaUiunNYziA/zJw64dNROyGrBQPaAma39FLO54FmXfCPXhe/9pWd?=
 =?us-ascii?Q?MayT9oOzdCYSrq9eYtu7681PeU+IpH14KSwTVJi7pqYXyaHbC46dfhxj3pVm?=
 =?us-ascii?Q?bspK+Hm58Vi+P0G2uGmVxcgwTJvLrJREkxwcXpPvel4VQM8kxdZyToH2Tzby?=
 =?us-ascii?Q?q1RzY31GdZ750LLoDjP/ndoZ0KrsVYpW7AZnj+XmzDa4airhGM5mMPtQO3LK?=
 =?us-ascii?Q?NOfpobTcCX4ARKM0sBqSiw8KUNdHXcZx7lkDaaAkh35zVmkAWarUuiNsnYq3?=
 =?us-ascii?Q?MDLFWwQxBYzjpSv0SMGBWC/QBQYM7tgE1JEBn2YtoAmpYpDsDnR8N81/eAwe?=
 =?us-ascii?Q?HsliBoeP22t8/5r70sEbrfl0yUA/IGhO7jsBJGtiJyNLo8JmZc+YYJ4yvQ8n?=
 =?us-ascii?Q?B3QBZLfVr4a1x3fp3RIUJPOrUHavzWRxvP79mK9WlqCnWEQSkR/hfwOgJO2S?=
 =?us-ascii?Q?4yBQIx1OSDUL54lLVcD08nQZrrrtrrsMUniXjCjp9I+3ilZu8/UaF6VqlUcT?=
 =?us-ascii?Q?lPcKHbZfVNAdzHpW6QgM+qAhWh83G1dGV7vTaGoRuu16TZ66SA4BnQBOf9an?=
 =?us-ascii?Q?IgmRSRxM4o1OygTohRY+exVgZMgwijBecwIn54K+8zGA/57RVscL9TBdk+US?=
 =?us-ascii?Q?nmoFV8SglEYEBRn9jor6Sfx3yC2JO2/gThr5Ps31gkEvdGosYZzhon8Svhxv?=
 =?us-ascii?Q?1aXyrGH1ifKcH7yc0bovjOLPibm6lclANHPtVXbqS4QGGMqcduV+FqY1jzsj?=
 =?us-ascii?Q?suh4turJk5RdJOGtP8UuOQ7M5xIfo3h3Qc/0wkMEborh8RCFOp7M0bLHKjto?=
 =?us-ascii?Q?UDqD/BNSl2BSOUsaBY9M96NTVXsWZq1ElvDtyejY8aL8zdt0a6EGBAhBcdEF?=
 =?us-ascii?Q?UNy2VnnZr7TQnLK1FJ1RbVr8Hx3RRqovKhmcBNFCe4ZCo/J0bANbPEEhnjrq?=
 =?us-ascii?Q?L8+mcUQG+71XRJvPP50AkGDtdY33puDue57MCmXEp0ResfT0DNajb7HbluBc?=
 =?us-ascii?Q?bZ5CZgnXdKPqAxWUdhSzrlqJcs/C2Kfb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gDymRz06GBCH3t7cNxtqi5AU7JRs+IAxQPr2pqfnE8DY4RNRy/r0crKBUbG/?=
 =?us-ascii?Q?7WvHaf2eWT9Qv+wBDR6oCCScoDZJ5p3iuQJ7BkXBGCJ7m05P/ILOc/OaECPP?=
 =?us-ascii?Q?xcVLkkzNOVDyDCTDG8Y1yL3JnIwdnppY83PdK8EFsEZrm56qMkRRIxAkhlkX?=
 =?us-ascii?Q?0isr4KjZetu6wm8KSisWcRmz10VdTN5o6Eof2BV6ojFQLGVfSq3QZRPEHP3E?=
 =?us-ascii?Q?/qeCPMpMrlaFk+aZ9Wh+adTPB6QKrM50ikjonMPYDnDYUvD91cJ/8XHzFofo?=
 =?us-ascii?Q?+lGVUHI/U9UfQJXDmRUsoSth8UfVD2TdGlZ8KruqYujxD8+5UIaThangFkHN?=
 =?us-ascii?Q?Q7M86KiUK5m8msH4hVsI9Jb37mNo+YtTRfmfiF45c6WksFC+ZrUobGeVaueG?=
 =?us-ascii?Q?PIopq7h9y7Oh9Zn0Dee9n01bhocm3xMDEQ2kFkWmmtH1fy7afo4Kt1Nybjj5?=
 =?us-ascii?Q?D13dVLbKXXP4CbAY4J+QHOqEa6ku4+KV53igl53uEJvFYTaXax3zQbytxnPq?=
 =?us-ascii?Q?FyeUDvC2gMAEWfLWPR301aI+HNVA/EBoV6RV7Au6nwEXqG2sHLn80NF7tL/Y?=
 =?us-ascii?Q?NDNShGZ1vFQ8G03wZFY8czVARCkIDFze1I0Pse0ct+0vTO+tlwz7QCyNovoV?=
 =?us-ascii?Q?kfFpPtkpgDj2Td+j/ULQYIaraTrNH6i605d8ZOroNR7egNwktYgZQn2JL7c+?=
 =?us-ascii?Q?jYMrWx2m7kcbdjZ+KDb5FO5FPbV0zmnGG+jwzaFU1eBrCdZotrnCFpkET5Sh?=
 =?us-ascii?Q?akIrK7BJTryLiyI9hZHbrlzQs28KQ2a7bLCFQGw4IC5CJczepBZAEaaPNXwy?=
 =?us-ascii?Q?QfOlAGpE+MEiaqvtCny61YZwGeyiQmhCqV1JOhhjY4jAsXvgh84BHHPOpi5O?=
 =?us-ascii?Q?hbBzw33M4TjIHT1XOeClCDUKoq2qC3NXvFqQ0QKVLijVPME5KKbOdsCcs26D?=
 =?us-ascii?Q?28k23iVwKH6v1P4m8HVH7GwWmV+jGppnuuwGUFqW0mSKpPGOujBxNfF0tC+5?=
 =?us-ascii?Q?IG+tZqkyaIcIz/YwSy0N0qEqANTp/IuxbreESQ/YryFQCqCcrZO+bIu/VVCy?=
 =?us-ascii?Q?19j++l8TLy2k2IZkMOgzgWQ65dJCrQ/8/yqQI4bMAjrCwd69PHXan0v9Elto?=
 =?us-ascii?Q?YIjqwocmlVL6276PjsQU36voEqrGFG7fJqk/Sgd+cO1r74LPcf9pnvwDzEpn?=
 =?us-ascii?Q?hlPViW5fUxSzKLUZrfsnamGTiWRWPKiIHkaXxC6dIkkSsNfbnUxhFogeZlWM?=
 =?us-ascii?Q?Jp6x8Ii1KxEkuymG8U3gSsl93oajdgmXsf3fYcjYQJQokY0G2Pxg1f8ZwjIc?=
 =?us-ascii?Q?Cp+9RQycoP5UgySgThnrCDenxq+AbSUors7hGlmzhk+dqFJdQOK//7yTqAqk?=
 =?us-ascii?Q?CtsCN5aNkUdqJiWoo+W33/a7G1wm4PnT1dNCDyPp+T4PMeFvq/seuooEBTz6?=
 =?us-ascii?Q?CpY0WJE/3KPlS3cQ18iCnMwDUfPKCt89FKojYqlbS4qpUsmk4g76VkHvA0TC?=
 =?us-ascii?Q?rMV/yYwaucMH/oTVkg9y67/7qRabgP9yXMpPgZmul7BvWOy5i58lO1+jtySO?=
 =?us-ascii?Q?vW9uItKgXRbBoFfhczibNeu+3dREsq1fQe4DufZTPa85V5mc6tY3YGJhe1dz?=
 =?us-ascii?Q?LHm5wtioYy8eZ7j7V7tV4iE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf135ca-f1ff-4deb-a5fa-08dd5b6ad226
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 22:20:50.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMDqNUQQ89PmMfJSaW0o0mWFHLBZNZRcmT71Q+8UsEU97T4ZE0Op4C/dtrBcZCWyxLFBtw7PhHSq+Ah9TGuk4xZySwgLJ+wC91BXG0iMmW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7931

Add split CONT mappings support in order to support CONT mappings for
direct map.  This should help reduce TLB pressure further.

When splitting PUD, all PMDs will have CONT bit set since the leaf PUD
must be naturally aligned.  When splitting PMD, all PTEs will have CONT
bit set since the leaf PMD must be naturally aligned too, but the PMDs
in the cont range of split PMD will have CONT bit cleared.  Splitting
CONT PTEs by clearing CONT bit for all PTEs in the range.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/pgtable.h |  5 ++
 arch/arm64/mm/mmu.c              | 82 ++++++++++++++++++++++++++------
 arch/arm64/mm/pageattr.c         |  2 +
 3 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ed2fc1dcf7ae..3c6ef47f5813 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -290,6 +290,11 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
 }
 
+static inline pmd_t pmd_mknoncont(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) & ~PMD_SECT_CONT);
+}
+
 static inline pte_t pte_mkdevmap(pte_t pte)
 {
 	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ad0f1cc55e3a..d4dfeabc80e9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -167,19 +167,36 @@ static void init_clear_pgtable(void *table)
 	dsb(ishst);
 }
 
+static void split_cont_pte(pte_t *ptep)
+{
+	pte_t *_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
+	pte_t _pte;
+	for (int i = 0; i < CONT_PTES; i++, _ptep++) {
+		_pte = READ_ONCE(*_ptep);
+		_pte = pte_mknoncont(_pte);
+		__set_pte_nosync(_ptep, _pte);
+	}
+
+	dsb(ishst);
+	isb();
+}
+
 static int split_pmd(pmd_t *pmdp, pmd_t pmdval,
-		     phys_addr_t (*pgtable_alloc)(int))
+		     phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long pfn;
 	pgprot_t prot;
 	phys_addr_t pte_phys;
 	pte_t *ptep;
+	bool cont;
+	int i;
 
 	if (!pmd_leaf(pmdval))
 		return 0;
 
 	pfn = pmd_pfn(pmdval);
 	prot = pmd_pgprot(pmdval);
+	cont = pgprot_val(prot) & PTE_CONT;
 
 	pte_phys = pgtable_alloc(PAGE_SHIFT);
 	if (!pte_phys)
@@ -188,11 +205,27 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmdval,
 	ptep = (pte_t *)phys_to_virt(pte_phys);
 	init_clear_pgtable(ptep);
 	prot = __pgprot(pgprot_val(prot) | PTE_TYPE_PAGE);
-	for (int i = 0; i < PTRS_PER_PTE; i++, ptep++)
+
+	/* It must be naturally aligned if PMD is leaf */
+	if ((flags & NO_CONT_MAPPINGS) == 0)
+		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+
+	for (i = 0; i < PTRS_PER_PTE; i++, ptep++)
 		__set_pte_nosync(ptep, pfn_pte(pfn + i, prot));
 
 	dsb(ishst);
 
+	/* Clear CONT bit for the PMDs in the range */
+	if (cont) {
+		pmd_t *_pmdp, _pmd;
+		_pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
+		for (i = 0; i < CONT_PMDS; i++, _pmdp++) {
+			_pmd = READ_ONCE(*_pmdp);
+			_pmd = pmd_mknoncont(_pmd);
+			set_pmd(_pmdp, _pmd);
+		}
+	}
+
 	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(pte_phys),
 		__pgprot(PMD_TYPE_TABLE)));
 
@@ -200,7 +233,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmdval,
 }
 
 static int split_pud(pud_t *pudp, pud_t pudval,
-		     phys_addr_t (*pgtable_alloc)(int))
+		     phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long pfn;
 	pgprot_t prot;
@@ -221,6 +254,11 @@ static int split_pud(pud_t *pudp, pud_t pudval,
 
 	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
 	init_clear_pgtable(pmdp);
+
+	/* It must be naturally aligned if PUD is leaf */
+	if ((flags & NO_CONT_MAPPINGS) == 0)
+		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+
 	for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
 		__set_pmd_nosync(pmdp, pfn_pmd(pfn, prot));
 		pfn += step;
@@ -235,11 +273,18 @@ static int split_pud(pud_t *pudp, pud_t pudval,
 }
 
 static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
-		     phys_addr_t phys, pgprot_t prot)
+		     phys_addr_t phys, pgprot_t prot, int flags)
 {
 	do {
 		pte_t old_pte = __ptep_get(ptep);
 
+		if (flags & SPLIT_MAPPINGS) {
+			if (pte_cont(old_pte))
+				split_cont_pte(ptep);
+
+			continue;
+		}
+
 		/*
 		 * Required barriers to make this visible to the table walker
 		 * are deferred to the end of alloc_init_cont_pte().
@@ -266,8 +311,16 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	unsigned long next;
 	pmd_t pmd = READ_ONCE(*pmdp);
 	pte_t *ptep;
+	bool split = flags & SPLIT_MAPPINGS;
 
 	BUG_ON(pmd_sect(pmd));
+
+	if (split) {
+		BUG_ON(pmd_none(pmd));
+		ptep = pte_offset_kernel(pmdp, addr);
+		goto split_pgtable;
+	}
+
 	if (pmd_none(pmd)) {
 		pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
 		phys_addr_t pte_phys;
@@ -287,6 +340,7 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 		ptep = pte_set_fixmap_offset(pmdp, addr);
 	}
 
+split_pgtable:
 	do {
 		pgprot_t __prot = prot;
 
@@ -297,7 +351,7 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
-		init_pte(ptep, addr, next, phys, __prot);
+		init_pte(ptep, addr, next, phys, __prot, flags);
 
 		ptep += pte_index(next) - pte_index(addr);
 		phys += next - addr;
@@ -308,7 +362,8 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	 * ensure that all previous pgtable writes are visible to the table
 	 * walker.
 	 */
-	pte_clear_fixmap();
+	if (!split)
+		pte_clear_fixmap();
 
 	return 0;
 }
@@ -327,7 +382,12 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		next = pmd_addr_end(addr, end);
 
 		if (split) {
-			ret = split_pmd(pmdp, old_pmd, pgtable_alloc);
+			ret = split_pmd(pmdp, old_pmd, pgtable_alloc, flags);
+			if (ret)
+				break;
+
+			ret = alloc_init_cont_pte(pmdp, addr, next, phys, prot,
+						  pgtable_alloc, flags);
 			if (ret)
 				break;
 
@@ -469,7 +529,7 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		next = pud_addr_end(addr, end);
 
 		if (split) {
-			ret = split_pud(pudp, old_pud, pgtable_alloc);
+			ret = split_pud(pudp, old_pud, pgtable_alloc, flags);
 			if (ret)
 				break;
 
@@ -846,9 +906,6 @@ static void __init map_mem(pgd_t *pgdp)
 	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
-	if (rodata_full)
-		flags |= NO_CONT_MAPPINGS;
-
 	/*
 	 * Take care not to create a writable alias for the
 	 * read-only text and rodata sections of the kernel image.
@@ -1547,9 +1604,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
-	if (rodata_full)
-		flags |= NO_CONT_MAPPINGS;
-
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
 			     size, params->pgprot, __pgd_pgtable_alloc,
 			     flags);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 5d42d87ea7e1..25c068712cb5 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -43,6 +43,8 @@ static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 	struct page_change_data *cdata = data;
 	pte_t pte = __ptep_get(ptep);
 
+	BUG_ON(pte_cont(pte));
+
 	pte = clear_pte_bit(pte, cdata->clear_mask);
 	pte = set_pte_bit(pte, cdata->set_mask);
 
-- 
2.47.1


