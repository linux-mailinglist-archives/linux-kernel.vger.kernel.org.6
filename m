Return-Path: <linux-kernel+bounces-422042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028849D93B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62DD287841
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBAF1B6CF5;
	Tue, 26 Nov 2024 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UkVKl0cH"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020101.outbound.protection.outlook.com [52.101.193.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F661BC9EE;
	Tue, 26 Nov 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611497; cv=fail; b=Km3AXtSJPYf8Pu0x8fyzVd5XT/SOzuIhBQ9w07KNsuiGup6WHnlwQ1XEq8rvQWvppcLHsQ3MaunjBCD+sIQDayAAnmyfw+UGDfzk+Yv9MVoTm+lV51713G2Z/yOEsolt2n25J+BQOsaBSOgQ86z7NyBM00OMYEhnglXkLRGMsMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611497; c=relaxed/simple;
	bh=HhPsfby+K1Ihg9A5L39nnv0L1Syo3+IDn1X+zruuYyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qt80iY3Q5uErl7XNJ938hTLrI+dU1VwZ0WyErrzZKLCMK1924v9VqP10tv/cFcZhNZu5EvkChYEimXW0X3Bt8Kk6BS1zCKo5s9JR2seQIqfqq/WsG/nBaccbHNONy2az09/ZW1yioUqylG/BEKxx4gl3l0/rgvGU9Ha6IZvGmSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UkVKl0cH; arc=fail smtp.client-ip=52.101.193.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgaQEJ9GjcJYSizu07vk36aWXIpEdSaQyFBpxx4X/T8xwoUI41jzBLyWVd9UZvItyfr+8BOIgInhG9RXTpvh/c0oatLC67xSmUIeY2lolgsC/BVhWR6tkL0xN1s2Hl08Dc57t9wYRcUeAnaXOMmHHYj+XQy3Q9lrzo9f4zwUeqS9Y8J/tL5s6nEQw1ix5KjlwxIf2iG89Ix+xicgp9NXpXnUEcEIrIAYwVRlifrctiL6rUh0LE7JdgtIC7V5wgThNn1wxMwxKtNdbFek2WcyCbJFCzzpmKA91FHzvRQ/3Fd/Vt60x1uYlyzzCzXCr5TEVzAhEKL8xpV897mq4m3u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anvbA8pUE1p7xSgy/be9SEgroL0t9VAi66YsNkMnzvw=;
 b=RGJoaBl1eZNUMePPcne8u00bF/kgyJPSU2WzMOZqKaXqWCcrvUHSrWRs7qloCjDJ/btg2wM9pb/w+KKBfH7VsbuyFmsQWe7ZLLS5W01KpAAhYpHLmSiHFkfeknOgCIHPF795yby9moDmw3LJWTwT/EldXU32U25jlV5ybpkmrsG1RW6XMHvlVT9JRhxohuybTaRrv7tFDUaj0Sl8SQ+BHHSMDH11MSK1jUHrDuMV1DvPmPq63sQWNb8kGpe1fdSakTAF8yos/ha3UzMnCW6t2EbGa5jIgZayOIJGk3KFwgILJlBQWWTNSKu+rY/uqAajCg149ZZZ3tIoISJA/sibSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anvbA8pUE1p7xSgy/be9SEgroL0t9VAi66YsNkMnzvw=;
 b=UkVKl0cHGUk8bT93UWHpTFse8cw86tf1Mwy60JipR0yGag1Ujm4N+ZogZMyRCYHz63PC9hNIKly30k8sU0hoUTKnhZq4DSDlu+7HmMxRLgHHUqraSpfyi/KpzZCjNEJVtgBkYnkHbj8xAHsbSYhaNhKRqMBJVR7RmH6WqEjQc0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DS7PR01MB7688.prod.exchangelabs.com (2603:10b6:8:7b::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.11; Tue, 26 Nov 2024 08:58:12 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 08:58:12 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: patches@amperecomputing.com,
	paulmck@kernel.org,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	ardb@kernel.org,
	steven.price@arm.com,
	suzuki.poulose@arm.com,
	mark.rutland@arm.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cl@os.amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2 4/4] arm64: add a new document for the fine-tuning tips
Date: Tue, 26 Nov 2024 16:56:47 +0800
Message-Id: <20241126085647.4993-5-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241126085647.4993-1-shijie@os.amperecomputing.com>
References: <20241126085647.4993-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DS7PR01MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f164e3-dd5e-4a3c-16e5-08dd0df87511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0oMZmdlx9rI/20PHrsGoZoTWMdolMCREMBVBohRr2iTmr6wcry3fPsWa+50W?=
 =?us-ascii?Q?qdqwiG8QaL0dAUCxHb9mWqdQJ1WxUd9kylJVubXNA7lqyenUwqtQ2sNVoc4p?=
 =?us-ascii?Q?YOCrKBAWZbZlPQ64KBJxngzBK3wKEVZK6pum/4L5AIig75eI6uKTJPuDaUGU?=
 =?us-ascii?Q?n6ZHxLjapb1svKfxmdroro2BpuQ1u434Z6Be+ZCn472ecNoZU//rjEFOCHjp?=
 =?us-ascii?Q?9G4X3tt59guVX8P+ZybuNpf2ImEIwT0eHnbqz/SdjSt/MfzBg2pwuyrNpyR+?=
 =?us-ascii?Q?mHjnumFCMZB/cS35qfaqutznHmLP0s8BalaxvlHJt90MvMFy6kL1W8QJysU4?=
 =?us-ascii?Q?gMvjaXNmiqTXgn3MPcXRml1zt1wdMaWNuMK6OoODsHYkPAAya7OyrlUR7zWx?=
 =?us-ascii?Q?2R+c/J8VU3MuR/JfVCiN/7Lm61Ri2jcJc+kaU37mMi0NX0fsnokDxmBZf4n1?=
 =?us-ascii?Q?3oCAi3pX17xpJYFzqKTSM6A0EacrKTv5QgWaNJqQchHluGRGncInMktP7lQV?=
 =?us-ascii?Q?Mpbhh0hcn5kWN+KVCib51VgU1yjOkc2uGRECtQG1z8z9k/AXOFsbeNkrZwTI?=
 =?us-ascii?Q?0/OZAvilOnuSwdWOtuA015xG5oTBh+34x+NxT0q4IcBBfKEgD0+9S22Xj2jD?=
 =?us-ascii?Q?kEYBeOUKheSH7zoEvsUJFxYvs3+cS+w6+/XREa8oxl5jyfrPoBPxArQxlv56?=
 =?us-ascii?Q?CvNr1z974zw2UwyOFu5aBK59KL4fHU2wX2+Jj6iHqK3p/WY3hwgjCQE2y79o?=
 =?us-ascii?Q?TwnJgt3Aw3bxUyvIIaB9MjLS9peMlt6iqDD42pUtkpdaHx/D/OzBSba76rW7?=
 =?us-ascii?Q?Irp4ysMCUkzDbl3b+qaEzLTTrQsWk0LNmnLB3vBrlTs/D+8CQhI4i0gmh+9O?=
 =?us-ascii?Q?Y7P2fVAhSVgxvDvz61hJai2syedH3VUJ23ST0+YTMDcHrYQEUVQsR5rMhIw+?=
 =?us-ascii?Q?6ec9+Tn8KEkavHdabWbFX45KDKXg7Ki7xcwTAfhApbHFXd/o3kSaKowXoOA3?=
 =?us-ascii?Q?t2aZAx9fqUCKnjIRDId+kl0Wdxy4H5otZAG4cFo8QG9tTF76361WnfCT+wzu?=
 =?us-ascii?Q?f7P/z4z1MHT2kVdjRt+nKhzL2oSORsgMosnGgd9aScyX1Vz3puYmreEftq3Q?=
 =?us-ascii?Q?WUYRU3hFHyCiZCiNUaYWTMeryvOKtUYYZDbSZXVtvwdUlI6ifPxPnWnGLiiI?=
 =?us-ascii?Q?xZ+bMTbSVGLlxTOb7sjk7X92Ax/luDXlE73dDSskJnlNMj9FVhuZqgBZD7do?=
 =?us-ascii?Q?iEtuMjo7q1PR2Y0hc4TZbHOPYMHCOxq3Ug/OG9YVtEaDchYY0fyi+BwhkgSL?=
 =?us-ascii?Q?p+WfH+CWCjwRUrLu+G6o+fdckLfWtCDI2v9MFJt4BFCdmtC1IuetvgfpSA9D?=
 =?us-ascii?Q?8VGJlvpxpzfleP1KSqjMsitX9dgcDN0Up28PUT4XFHoBg9KrJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ajemkZdcyWIMiGANgaSBcz/Lwz4th/v8W9l3knG14yReflJVdLDT1etNjW4q?=
 =?us-ascii?Q?XzNzbn+88uwvbyCAduOvyV8ztzUzTXom+/ChvqonN4Ke30XTWi4ERRSEKivO?=
 =?us-ascii?Q?5BMmiMzmQ7w3FDwqRWYP5QZiiFtzc1xeMUsWr487vVjSB8AMlMGa9XqXiARk?=
 =?us-ascii?Q?TfVNmg9bCfXTtrMt+uwiv5u+EMFLirWrdMhrdU+uruCFqIdhYNCBp+7E1/fI?=
 =?us-ascii?Q?zx6WhYEeEzjanhcGVsvkPuIwSBVw0d9f6zZCOcfWcNfokmQJbWnQ0Aq4I54E?=
 =?us-ascii?Q?gquyn7nHL7KesnPDCim9v6AMEoALE2JSH3Nj8FI0i+2SyN2ZZ9nMKWpuKeC+?=
 =?us-ascii?Q?cZh9dLheJ4NtJseJpJ/PmsyqBeWUQ9NDkmKVy6BnZ5OYUaOavByQQGSpp6kZ?=
 =?us-ascii?Q?30mwmWgxBc/Nocs7nc4DuZ7CwNvOR1umzKc47i530RWZcgGmmu1PnkjBE3X0?=
 =?us-ascii?Q?CFpdCuBmJF2iyq0KG0oro96gA7Lw/h7g/+RpfvZrHTtRSzEFm1vWCbY4LbMg?=
 =?us-ascii?Q?PCMSJaVQxzdBNt8yYCPIvWh5XDHmsNoH1IHeC9yn7dUfMFXskYzrQwzwfMSy?=
 =?us-ascii?Q?p+2UKwvgJCAKL82uxM/AOvCKlINNMj9HTHcyJ2AY+4/sof+BYgvY2BQR5AfN?=
 =?us-ascii?Q?dJX0UxWS3Bfbrbek9KNJm5cTHBoqgassPtcLyUNA0IdbvGdWMtB45/68NDG6?=
 =?us-ascii?Q?v676JPERd0cK/l/w5q7B32nijDJuYiQurFUOJMi8z7nHGkzl9CmLAPVdmcvB?=
 =?us-ascii?Q?+AbnaAMFJJApUZaWTA4XpSYVJmNPCfsorZNySfIa5IQFo9PdOBTYliWDJBuX?=
 =?us-ascii?Q?ZwpKaXmLbHJvQV1Iru21HzZhVDfPmDGZJnVD2+BBe2aD7cAJeX0Z5n7E4N4M?=
 =?us-ascii?Q?P1a7AGMfqXJTsdKLySuRQZN6P17KN7OVgMcvQz3GQgGdtiZ/gACKy+m5TmSN?=
 =?us-ascii?Q?5QBaumezabmnDisUv5NM/8gkyga7NtQJjQw+Z3vW2LTWo4yPzkvnKvUN/FYv?=
 =?us-ascii?Q?TuKQ3LqpcQxMATsmrnK4DKM6PVjFQYY8IMtfQadrG5MI+Phj4INPUYtN8qID?=
 =?us-ascii?Q?X2+hFXTpS/D4XFrPaQKwljq7JM1DFivH8GFCMF3H0pUntIbo7OuRbUl76lTs?=
 =?us-ascii?Q?NfaBZrdt4GJSRdVAfLMZUj+gOr28hwvGvFpu3XBmhJlVNHaRm8tu7vNbMAm6?=
 =?us-ascii?Q?sO+xofuGUceCf7hNmTUKbgq2JkPd5TwGAFH751kGeGmHim2PTQiOzyq9Y1JD?=
 =?us-ascii?Q?s4cxXxo0r+gcJtvWKrKP830cGJPIv7LHMu0J4tCYMzsqk46Ejw9y6vvIvS9q?=
 =?us-ascii?Q?JTviepAEpKTSF2S+FSwwwkq+oPFMWp11shOqgBaa1G+urm8ayek8zc62F9dq?=
 =?us-ascii?Q?duhxD0NufmhFHkI+RsoiiZED3YnFg8PCIcmyrmi6RK9DLLRaNoQXvz8a0Mm0?=
 =?us-ascii?Q?zdFeTgdFVpaQ0WUZKdl0IbYNJ1rX3CQB92dr2UMhVOekJtnsGJ5IJ4WtQ9WE?=
 =?us-ascii?Q?yGqDHHPjMaZuNJgKw85l1vcrJddM7EvgI2TzUMsdDHpU4l99/DkDVr8vwNK+?=
 =?us-ascii?Q?UAllx4tTAaikRrv2bKdel9yHaRd/OSd72Johg7/WePzX+ecY55IejWduqNL0?=
 =?us-ascii?Q?4fzhwfqKMROlo3gWxR6CNHc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f164e3-dd5e-4a3c-16e5-08dd0df87511
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 08:58:12.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kAVMsKC6i0eJAL5OSqdGegzAYtmOk5SWofRz8N5h8Cv5EHSSaRfowshiTIf6EuYQ1uAKImv/EW9MPSTYrtOE23pmz0S2sjiG97VKGshxdbTKpNp9N/uKIcjGF389aNY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7688

Put some fine-tuning tips in this file:
	1.) rodata=noalias
	2.) slab_strict_numa
	3.) CONFIG_SCHED_CLUSTER

We can add more tips in future.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 Documentation/arch/arm64/fine-tuning-tips.rst | 23 +++++++++++++++++++
 Documentation/arch/arm64/index.rst            |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/arch/arm64/fine-tuning-tips.rst

diff --git a/Documentation/arch/arm64/fine-tuning-tips.rst b/Documentation/arch/arm64/fine-tuning-tips.rst
new file mode 100644
index 000000000000..70ef1cef92fb
--- /dev/null
+++ b/Documentation/arch/arm64/fine-tuning-tips.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+fine-tuning tips
+================
+
+This file contains some fine-tuning tips for arm64 machines.
+These tips do not gurantee that you can get better performance,
+but you can try them with your workload.
+
+rodata=noalias
+----------------
+It can provide us more block mappings and contiguous hits
+to map the linear region which minimizes the TLB footprint.
+
+slab_strict_numa
+----------------
+In NUMA, it will provide the local memory allocation by SLUB.
+
+CONFIG_SCHED_CLUSTER
+----------------
+Some arm64 machines have cpu core cluster, enable it may
+helps you get better performance.
diff --git a/Documentation/arch/arm64/index.rst b/Documentation/arch/arm64/index.rst
index 6a012c98bdcd..36d1ef09bd71 100644
--- a/Documentation/arch/arm64/index.rst
+++ b/Documentation/arch/arm64/index.rst
@@ -16,6 +16,7 @@ ARM64 Architecture
     cpu-feature-registers
     cpu-hotplug
     elf_hwcaps
+    fine-tuning-tips
     gcs
     hugetlbpage
     kdump
-- 
2.40.1


