Return-Path: <linux-kernel+bounces-345365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD298B535
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1530F1C22448
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9A1BCA11;
	Tue,  1 Oct 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="CRJ9ZNPM"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2132.outbound.protection.outlook.com [40.107.236.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B41BC9F9
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766321; cv=fail; b=ovTcCZwppIMpEf2x1qgZZ/sL2jRZbmR13vwOcFTEIv75OCYFE7Z2mWEklZQ5UXJnouUXMgkfDPh3GyiQDEEW4Bzn8oSbnCeMd+os+aNwJAnQI6kxaO+we/0hwF748AR5kiYbTcD9JgDvJ6OHtqZOPDiiAECZdIixdqknFJJgSgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766321; c=relaxed/simple;
	bh=/ZWVcC7noWUCyRLz5F/qdKutl1oW6vWRrzyti3ChX/4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s87fH7toNbJ/kb0tEkUynmyxae3ti0fNrEyAU2Il7AjR//LaB9kQipxtfhGAwQfSxfVh5InropVp6U1q+UA9xLly8vFHV8bw31PoOhOphF3jdIdeNGgkG4uAojqPVZ9j5nDPsps8t4VqrwMqX+I8rGm5O0gL4NeDzkOIYV3+eY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=CRJ9ZNPM; arc=fail smtp.client-ip=40.107.236.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKiMxBocit4bo2NKZXQRvM+E/AjTARdnlgA6FJRQoklJPhclgV4/D7DOY7O4m4A9urcc8poxoW+DlplN7m3Nv3xfp2vpVC+zmEXl+U5HXDEcr3oHWQ5trnX2Ymwu7ktjufi6W9kfMyqbevkUD1PW00JnZulXvFXKQzUxnpDvdiqE9w8Teuncxy/Cx8PeI/NQjG6G/30EJ2SsgjdUJwC9WUop4wmuY95AzUvF/4G7idZTQmzc3DtKr2xGL1efMwR7mCWwL4xzp1pvZ0UPk4MwlsGEg2YltAxkk3h48CXXnK5yxp1e6m9R+OiGxD+6P6S2qa4MZwkf8fE4N8/O7st/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYX3tB5dkg7wHQgQvDZFGEzXIpIkcVW3t0gg46kibLk=;
 b=ALcm8zbDA9vw/hxdI7sYWxt/Bq0WwwZNQrzlQPRuPcGgO8gNZZDcfF/TbeU6fBenACbif1vfF+7nd1/43VAV628+1soUa3ASj2r8Wki6yb75v4Jzmi/VdeLuUu0XNW1xZj8D6kByF5F3Q1l1bD8qrvzY/2pX8PdYw4f7ZYB4VafmebAh/AGww/NLcnXT2UA1nKx3dUzdG81gQycQc4VdXcFd3M3ezXbUIeyZ57bYZl9ar3gDE69aR9b15r1ZzOHdnBKxGE4XLWYfsGHbT4LCJHko4naZhFlrg+DJPe9+c6aOultObJm86AF/wPqzcVk7jR76zfB9e2EWSQwQv2rtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYX3tB5dkg7wHQgQvDZFGEzXIpIkcVW3t0gg46kibLk=;
 b=CRJ9ZNPMIgwavt+7hI0LGZbeN5TkBCSTGFe2+54BVSvLCplqeIRRo/PEiET1/b1PnDL01fhaoWsZ4eJykl3aIyH0GlJ1IrZe+CJTmY0UhesOoMLRxhbo//LZi4qMQnu4LeEVpoZFU1oWHEoK10Zm+YL6XbPt25BHZjt7nnOjxbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 PH0PR01MB6327.prod.exchangelabs.com (2603:10b6:510:8::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Tue, 1 Oct 2024 07:05:16 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%6]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 07:05:16 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com
Cc: patches@amperecomputing.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH] sched/fair: fix the comment for PREEMPT_SHORT
Date: Tue,  1 Oct 2024 15:04:56 +0800
Message-Id: <20241001070456.10939-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|PH0PR01MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d847750-3352-486a-658c-08dce1e76705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gMi6nVJAa7b4RM2GdnmYNCdn3goJx8y1UfW/xWQz23aAo8G9Me/kBi1rWPaq?=
 =?us-ascii?Q?Xo1f4lNNiZO8lC8xaFW3Xcl6dPCQYL7A2PF97HSMwN9e0x7+ul/4Ygmgqx8m?=
 =?us-ascii?Q?ubYujb/SLNHGRLZvzV8nTp6diiw/8mbkkenC185W1CVx0x1+3JLQs2LzSVWd?=
 =?us-ascii?Q?L4Vsb+Vx5BXDPq8JtBFYjhNXzi20HGSpinNWNczSZqlC9MnXbT88mpdGfXsL?=
 =?us-ascii?Q?blcjl7YREs0kV9jmafpap56+P3H4s5UFGXUtx0B1yyAmbg1xWLfRzEZjn0TJ?=
 =?us-ascii?Q?v0KFmsv8RmR3ZrEXjYJ7lR+r+8n9pHFI0RB8htjHoJv0pTY8WVm8dGDtGzwo?=
 =?us-ascii?Q?n1Vfi3Vhln8mLeXHbHz7Q6iZex+jPrdFRUMtiCu4nedDzSbtiYg5nnUv3xTq?=
 =?us-ascii?Q?ZltVTnw/Oy3qC21ADEysGIRkhOCGO6uEnpWdsSnguc5eAyn86Qt8d7K6vHCe?=
 =?us-ascii?Q?39zMRhSyLvMSHi0Eam/mYU/G8de0qxMeHKpXcSlrgU/iFWJ2Anz1eBnmjip0?=
 =?us-ascii?Q?qeH8jYy5+YnoMl2rKmbdn5tBygdwtqcsdyYmae/nVrynbs/KX8dNYZuWKB4Y?=
 =?us-ascii?Q?on1hU4R4WRoeWMcTMGjGeQlYGtqe2mpQwg0F+eFNJmst2HW4YNGt4Hd33aIQ?=
 =?us-ascii?Q?EgcvA8yB6a1wgel1POJXBgdIS2dXVvwnJSfCpkAdegEQs8cs3HPZy1IdxzsJ?=
 =?us-ascii?Q?lDZnjOxaff6Hs3aRAoejryZDtOaNTJ8uWe6TZE8o6Arq9ASqbiQlsN+4EZfo?=
 =?us-ascii?Q?6RHcF/FWv2b/eQNUSSDXWqFSDjuhcWSjXP6pt8i22C7P2uj+EzOEfQo+4oNF?=
 =?us-ascii?Q?LF4gQiQdSoaIlNkNv3sR1kSiZ8zbLS3HhXvfSUVKFz0KOAWuu6O2obwG+dF3?=
 =?us-ascii?Q?lY+7g6v9qIkq5T9oODQQnjyttwYX30y1qtQPqISIFyuV678fKcWLUt5yxhAG?=
 =?us-ascii?Q?ev1KfMajiXchLFuomPxj1bPtZH7kzGVb8s8bf1QPHf9o16hHr6A3fCQNXUta?=
 =?us-ascii?Q?8W9souA89NE5XH9vDY4Ez5Iip56rQGVTp8H8ss3OGPOVmKEoZDYSlitAIxiU?=
 =?us-ascii?Q?+yW3dMrF3RvHAaZm02QNs0HnFRvWylcPeqfYtfNOSGAUw1CQQbRwXFZfD7Ci?=
 =?us-ascii?Q?LGlWjYGkzqSBqi3BS/O+H/9qrt9Vq6xRTE7OOj3+YbllxJCn7dB6JWSxzs4B?=
 =?us-ascii?Q?N8AHD3/iJapTBKQWHYsRSqhKTyy4rfUSLZyzUr5rZwr1WJZBqiUPxUps+/hH?=
 =?us-ascii?Q?lMJyFb1U1Rq0MaYp7Woa+YPvaIsEZeVnm3DYL3c+TG4cNQPfYYu6HTaoj94s?=
 =?us-ascii?Q?5w1E7G0YI3UZCwNZFpYpSoybJvcEtYwVz5yMh0uFXqwgHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iGrcA/Zp4K414xORYv8aCabvxIAmIH47Ny6Xacxw1BA7KrmeBUGSGg6fEoGw?=
 =?us-ascii?Q?tHt7J/onir0s1V/QDS0ASaWt+hUTF9K4V9mxZJN0SKK/WzjrCUKypy+qFzNr?=
 =?us-ascii?Q?HbmRvl/M5PiTLNXeCGmd9ExPfEPHGww+KfBr9n5H3KukKFUmrUQqABRc3f+B?=
 =?us-ascii?Q?svaYnCQeWgNz3vR/rZ8zt+R0Oy37ovluGEdoAXEUzyc5i4VimikqQF/J72Ef?=
 =?us-ascii?Q?IBgdOZTu7aRaOHqlVenqwshR6WaJkWWe9Dny/LqaMVackE5dGHA31wemmIJ4?=
 =?us-ascii?Q?hBhn39auJk0P6dzSqOLb04q2/1NbJCR8mPOp7OD6SMhkwy0N03j6LXwMidnT?=
 =?us-ascii?Q?Kl36hgF4dQiw1h2E+H/TNgfGyyueqKmBaqyfOiuQ9GunUThIj751M3lyPSFX?=
 =?us-ascii?Q?J6kSg8rMPnzoy7w/OZGzXXMKdo9S19aHakW5vKoy4BM//Y0xpYL8y9gupnxY?=
 =?us-ascii?Q?MfLa5VS7T4T5Mp4+3sn8D3wzyodFC9i9jTvfDOc/iQ7EBzg/GS01ggCso5tG?=
 =?us-ascii?Q?YFYcr08joXRKrIPMjHFZm9FHK1hLjshBIt0cfQv0DlYkFdxThuc6AFbgLL5N?=
 =?us-ascii?Q?08lYthbmomZpydDgm80JZJcoxrljytO/xtG7gi4yS0yTGiZH8Tm4ec5c/Tcx?=
 =?us-ascii?Q?dheHlN6ndmTh4XU1PclH8R8fR/wFQKdJKFWAijny4A9i7L4MpBsSITTHKoDe?=
 =?us-ascii?Q?G+8HayVXJHLEZupkERLX47pV/kEEDXLvDfMHSh6QKzO4QavIp8Ta60zx3nmZ?=
 =?us-ascii?Q?6BzKtcuOSER01c4aUt6wIqqvWZ4CUdfFvLM16L6olTNUaCSpStUHhRbrtTBS?=
 =?us-ascii?Q?71CecY479E3/v/Ewa5vQ1iwExwqSNuaSKVBFF/BSXrk/Mfnu7pS4wpvoDQJc?=
 =?us-ascii?Q?Hu2TSe5rNQgF+fY2OlQDx6/u0LOPRMuJFkQQs48kMrQwSBOArD9VU2Pt0Br4?=
 =?us-ascii?Q?aobrYDRptfM3sAgbQFrTmoDLQEHQB5CWlHizTYwuejfpj3FeMHQtyIV8bKhX?=
 =?us-ascii?Q?ZCXFvD9UoQzGiFilGZaIWkF5l4lP2M2/2rtLj0uUa6/sDnk8N0GJnk0Fs1p3?=
 =?us-ascii?Q?3wt1/wrUle9X8ZCnsSLzesPEOYCp8PQtmKmLDngrEXMFbEiYRofXZ2d1wRg/?=
 =?us-ascii?Q?C0r8HGGlvUjv/ZwrE3StRGS1jXCNQInoxuHIAotWgnGeeK+VNGgE5RvjH5bE?=
 =?us-ascii?Q?29Mnp27nImEPA4kZ9cPEd8OjIox/KiPQeE7BJeN4ILIfMLPeLlUgEE6Q0Clq?=
 =?us-ascii?Q?tTanwZaEVbWsDxQM1p5jcHp94NgdZENCthuxHBfmd1S+Q3VDzhPcU7t0HBFy?=
 =?us-ascii?Q?7hRxHa3/K5+jfBmhQZtHdVg0V6mF9x7iopC7EuY6udoNnfCrG40oVfsbwrHR?=
 =?us-ascii?Q?22eljN0Amgfcy9LLhgmk522TtVVAN0HPCTVm5cKT3Jkgf1TFOjfErcKza1BI?=
 =?us-ascii?Q?mb0Vw4uAt8hEF010YptUx2saQR7yBRg8o54pxdzIpWMnrBjW2U1u2AIWSmsx?=
 =?us-ascii?Q?9QEHFiP7s616DHW0t366ljfRG+q+odF456TjbblhVpSbrmxzqaCpL7rAXyrf?=
 =?us-ascii?Q?ARUGI8Cr5t4DCDoHHz326s1/3OAC3vTzqRnoJefRx325RDA6a7JnhxZ+dK9+?=
 =?us-ascii?Q?nCSG4xfJWfqPue9mPmdHymM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d847750-3352-486a-658c-08dce1e76705
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 07:05:16.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POIL5wDL0V+hTYEvKOoUEq31Vi8czw4mWhXBdVojBnPitkBeRntCaiCGMEfnb2ZvCWEot7xHZHtphR9sw8gQSum65yAlTUmScPPVl67xfy9hzxsyE5ks5490KqHRPU0q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6327

We do not have RESPECT_SLICE, we only have RUN_TO_PARITY.
Change RESPECT_SLICE to RUN_TO_PARITY, makes it more clear.

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/sched/features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7c22b33fb9d3..a3d331dd2d8f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -19,7 +19,7 @@ SCHED_FEAT(PLACE_REL_DEADLINE, true)
  */
 SCHED_FEAT(RUN_TO_PARITY, true)
 /*
- * Allow wakeup of tasks with a shorter slice to cancel RESPECT_SLICE for
+ * Allow wakeup of tasks with a shorter slice to cancel RUN_TO_PARITY for
  * current.
  */
 SCHED_FEAT(PREEMPT_SHORT, true)
-- 
2.40.1


