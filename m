Return-Path: <linux-kernel+bounces-346469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC6798C507
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304131C23AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC941CBE8C;
	Tue,  1 Oct 2024 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GpNwKS7m"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020140.outbound.protection.outlook.com [52.101.51.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D901CB528
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805848; cv=fail; b=ZeNLhb13YoBoffTfRGoehxSVsK9h051yoyGm67HkjNAgMs2HjUiebH+ufoX3QgJFE1VBmcQ2Oq9ICuc8wPG9X0eepXhxBNGdkNLrTCzjt3lFwPC1vqJmuunAjPOqEFSxST9flOWfSJZVOkck9PNwZAjxLtysw0f3NjYq5epFvew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805848; c=relaxed/simple;
	bh=hIRc9ohilk5z3sMMRv5hSr3/sjM0zx/6dZO7GdHNRkM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aR3BcWBIaxKjMt2E24D1ugE0RVEmAUwkCQ7PcDCB8oxwEFkv0WO2SOauguhRGs7OANHuMJ+6U0fd6xC9XCMllIqruhqF067qQnKhWKH6LyVo4nCtlLBtFpdjuVb3zlN10fK+2EhxRrozrCfmQnLZyccxy1y2z26muOIAETxu9xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GpNwKS7m; arc=fail smtp.client-ip=52.101.51.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E07REEFwRl6rE1+1YGUQExpnfw+Jqhvss6lOxOW/Mb9a4Wkzbpu6qI2wqGwT0naZhGYcTIe6ieiMEr5EP4qE9QAF99V3coAYaRuzOY24G008/XY0+nxh5PCeryCXV+Y29lHG52SosBW0oZwvA4Wr1twtHQs10sQi3R5dG0ivLU3qQ5QqRb9KUoJz8kHucscCoc1Nsp/y5KZo6Yb8AamCIBfbJ+4FCTYA8xfXNU8vQsMA0t3IfgHKZdMilOe908hgpnkOcxKSOrLHM5qSZ+17dsVls/5i4QOkruAKmRpBl6HJ2dwmQ31Bp8yh40Re6S8W4ZOVUDnSaCH1zKZKdh2NQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/ssRKSHa4LB4q2bBGXvtdiX6DMkaOAuG89qtSeHkmg=;
 b=G1kSkdpIH/wOg/6htMTZ2yNhepoSMSDHnVgW88cj+EXWUzneVypN/UjSx1FVJpnbs4pPzr6mVYbN+srAT+Fmx53krAFhCNREihqTivRnD2Q/b1qg3tAQbCaNoD5qIjvE2faCyGJWKBlAtn8cZUTm5bBBcSXj2azC36uNUTiRbpogdO/LxQtOe1XOa/Dlzr1R4UQFZRqghVPUvnMbxUpozokVT46Avoz0NWFO3i9W0kTJewm7gOO00eyVWxdnCMrERWAx2673rXYVmws0/pRhMV65sHWbSD1iDlk0/or6b24lXt6ou2CoD5ufGKF8dr+Udol6/EFzN0DWENkG+/JX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/ssRKSHa4LB4q2bBGXvtdiX6DMkaOAuG89qtSeHkmg=;
 b=GpNwKS7mQbzlYqPSCYzpHZWv83B7nrOu5MxksLDxnqkwTCkMK/hcWqlAc0jPW6uD/yguGNtp72X3I2aEdEEh3g7EMNth8ZVc6tU2V8SpTArtfG57dyNwzs7VAoSAwtkYq4JtIck2xHOE7g0caD8maEnZYWQbkHbR+/ReiYct/VU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW6PR01MB8580.prod.exchangelabs.com (2603:10b6:303:247::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Tue, 1 Oct 2024 18:04:03 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 18:04:02 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: jgg@ziepe.ca,
	nicolinc@nvidia.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation for AmpereOne
Date: Tue,  1 Oct 2024 11:03:46 -0700
Message-ID: <20241001180346.1485194-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:610:50::28) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW6PR01MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: eb67af99-ab8b-4dae-db23-08dce2436e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ptb7f64lcyFxuGAdhr0Ql52MXtgN2CP2fxeOncRgp/BCAe4fLpW+r9hXPL7X?=
 =?us-ascii?Q?fZ1xBFHHys6BP9e9brpI0k+Nhxj+UP7FSWCKIvSF1XLCBziCKtKnTquJ9Rjj?=
 =?us-ascii?Q?NrAQrlDHdqtRoNbwCuis4No5NqxyqdvtEuaqQzBcl1T+dOqBUMXVfLvcih/2?=
 =?us-ascii?Q?DIB6Ma7Mq//PDyaK8GI/RMeONoE/gRgsfMrFgRhFdcyFHagpisvC3IOuRMv9?=
 =?us-ascii?Q?F++UU4Lvx7KAVYcE1zPC2A94KjKta89bBnrR5+kEnRzHdq8AAO8HAn9ND+D8?=
 =?us-ascii?Q?DQHkKJhBdmXRl/R7d0OBPnXYozZ0+cijFcfiI38+ExLc2cnhxCMrJSy6PH2M?=
 =?us-ascii?Q?cocCCVJJvA3HAIkmDBlu9lfPpxH9I215BNt6cczrqWgk9s0PG4LeKP4eXKU0?=
 =?us-ascii?Q?A8SHo9hVgFXIZ41yM4ETgu9dB1qBwPeU/fbtTtViXRvXtEQ34VnWrQ/nLgOc?=
 =?us-ascii?Q?W73vCwKhkWwc0jSdxg4Z9T/5q9ElGRpnAWDYKxqCghu2zJKRdgkuQCcQveaK?=
 =?us-ascii?Q?b2WJWnk2QujZE00ef4xgY0wyPu/98+8OzCFbeYbHqY4Y75UDJ7KA9UyLJvqx?=
 =?us-ascii?Q?VlYyGqaoRQX0/wMWU9vKJudUvqdhO4a4YyQBMSq5r8kprHtZ8b82PlwImOZm?=
 =?us-ascii?Q?s0Q5jVcO+8yFEZzjewhFCLCDaJpGrjaDAYQeL3uWmZosORYMAIwkY0Y0HgAV?=
 =?us-ascii?Q?ABuLWyvW38JNIjiQbjt1jZsxajVjzbklp7I0zxzqj1z0qmtbBINKHOvYiDZA?=
 =?us-ascii?Q?DRdD073pIOVBdlARPUWND+i91aKzkuvVLLBG9eJoFIoxVXhYFXyqdg1dxHZN?=
 =?us-ascii?Q?io8CULKOj+Y9s5zD0kClD9jztiZUxGOmM0a6BOi6Aul0mktiT7kv3Uk3DDte?=
 =?us-ascii?Q?x1tD70EXMQNAs/dDYY3W8zpH5VSAho2AtvMSdFqRX6hDihnlPgZJF8WGLquO?=
 =?us-ascii?Q?k1jXaFM6I+nYbNeW0lp4V/fkXOu3iuOxtiLhscv63cX/i62268nReApEWyjq?=
 =?us-ascii?Q?xLXKqr/D1IPA4YqNz/kJwDC3w4QLDPs0IcUB/CC5uRiHYCWOHefsnZVtGxD5?=
 =?us-ascii?Q?7CwGRxb0AcxWLLFp7JuylNTP08pMRcYrwAVORBgAVPm3C8pbPpYtxbTkmx88?=
 =?us-ascii?Q?gGh7HiCfq5MXxb25YoFLHM08DgoHRB7lpDM1FXko8wt6vKYGMcKNgFAMhPjB?=
 =?us-ascii?Q?57dcxe1z3eMeZGYCQCT+4SbsUOwQF+n82BKSCiwH+1rXVq/tAT1yl09rY/LO?=
 =?us-ascii?Q?351WQGdcAZ+FpbrgOJaNFe/CYK968gSHrGRXBVHsdlYhxeo1u5nRvpvniJGJ?=
 =?us-ascii?Q?rGp/vzQrtnEY8spgtcmb9zFjNAo/0KSnFUuCECgmNCVg7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aVtNSBJDHyLSP3PrgxyyxNzxXlykT9baVBFDL6a20NubRRPPMZ3JX0GbCxw5?=
 =?us-ascii?Q?u911Nj7EU/JD0Fwnb+srE+qOH1awiI8pSMpN9lpg8vsrS6ZSlNJ4L+K/rbLa?=
 =?us-ascii?Q?ZAHmHFBYb7OOqXZALXwkinRMfnljj+N53upIK7zJ17KFSdB//vvqCrypCABL?=
 =?us-ascii?Q?TJYAiT7715NDV3QvMkSMrMDiTP4r3r1nsBiiD9xG6Iq6/vptGjFcb3bCt9ZX?=
 =?us-ascii?Q?8f+ddU7YuVGzsmrWORSQ/MxNW9+BvsVFpSOXuGOCtFKxgyH17kusCjTfQy3h?=
 =?us-ascii?Q?SzWi096+4Qo9dYeFqyzPUo9TdqYaRJKI/hWZVuJEwyKiqCa7hp05T1FNA3Qv?=
 =?us-ascii?Q?g2iTxG+IWuMmLnjpaQOSWGa06eI7UjgDuwFoAgrl6mPNLdovfUdv9b8+sOa+?=
 =?us-ascii?Q?JHHwTjKe5Ac42vvLE17dJQqCRk/QXDrs7mo5XK5YQnKVUfibVLYPHYeQ/0Jp?=
 =?us-ascii?Q?NORNwABO5PM6eNbSjSvigQiVlfexT0VyJrs5vZAZClKKpUcuq+ollD0dPsQe?=
 =?us-ascii?Q?t28UcAPkwl4zrjxqsR8ZdHb81/sezWqzo4h1qce0c6ZKH8FEslaJ7FLJOXwr?=
 =?us-ascii?Q?llDDHzU51VPbA3XiMOgzYxLBzO0oGM+LrKmUOrv9nJzAIRlGfv90xQyNgLYV?=
 =?us-ascii?Q?a9vWQ7+GGcPeEcWiLrju3I/j5E2RcVSHYKQaAueddYiAFonKsraSROxeVgwW?=
 =?us-ascii?Q?I+qTJjNWk1egIwAAxVrfl8MtT7fWeXLDUE51ygfEmlZIqgIdRuPIuwjFXOHN?=
 =?us-ascii?Q?0Fjmng41SNykXFGOejU3k3A9Xhqa7ARNLkklGY8lSq05iWO9PlWiWWYBlitz?=
 =?us-ascii?Q?Ti/VMgnqIrEKuWgttyyUEa51X5LheUUm+5v1UHDnHeu/RBx0D/Oslfdvfpmt?=
 =?us-ascii?Q?lO/JPd96vGGNyQyVNw6WHzflhE12NNB3S3QtVV4t5GETEerpU+FrpERj/3In?=
 =?us-ascii?Q?+MxhXc7tyFkz0lL5IVJtQs/uNS8B5yP9gQmr0wnJI3FP5FKhjLzuZI52Kike?=
 =?us-ascii?Q?meQCvVHr30YZmPTV/Hn1JULHqOkMPan1/soW86uVPpZlGcDR2Uee9pxhY8pm?=
 =?us-ascii?Q?zHL2GSjVo5vhP/6L+y7+Hs8IxWwToI6AczV4CJHevq0+/0ECvQc3Asfq4vA1?=
 =?us-ascii?Q?csKvn+l+jSKO7An6RjmFcOJvDykWEBkd8+1jLiYm8eJ5hzUqxYgdnunkehDG?=
 =?us-ascii?Q?vhh0WyzzGSk9wEBJ6pJzqYrhQxAc65dvXPTnucwrheiXak5EHoIKbpEPdaSz?=
 =?us-ascii?Q?0lXzYYocrhV7CntrsRwIAgWDlDPXNqqNR388hyN6Gvb9YkELgXT9kQDGlNJR?=
 =?us-ascii?Q?Vr44yjwrM+wRwnA+IhSCPoejFwLUhWquyxjD+Wt5DxSL2X6uyvzg0So0N88V?=
 =?us-ascii?Q?yKRVheKt8EHR+Du85GROjw3SbKRqnoDWfrOPrhxPK9la689OX6zGR1uNSzPl?=
 =?us-ascii?Q?QutVwPr8Oi6WAnHw8m+RmdR6J/jMsl//XberYb/KPxGKPfws4HhSyqVu67xa?=
 =?us-ascii?Q?7h56pcnfGPwwE0pJL/kl+mlutFOta/letooJx4NQqRjE7Gat4+E24OwCaHt+?=
 =?us-ascii?Q?2gOELkTgmHYtDivIml++PhKwx9fRub8qIfKKOe0C7+77G4dpM59ObqNWFAvg?=
 =?us-ascii?Q?XSdJBZkfxN27FhJzD3IrycI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb67af99-ab8b-4dae-db23-08dce2436e68
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:04:02.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgzKFlnl4xt9BNNcD7V125yHv1WVuMcjtBqb1m2Zy6KVCZWtXuUVlXyJpmKkn7yZ9r9YNX/fuFU+/fsKIH0yyb9rhzJEdWSJPn0yzFktvWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8580

The commit ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
calculated the last index of L1 stream table by 1 << smmu->sid_bits. 1
is 32 bit value.
However AmpereOne has 32-bit stream id size.  This resulted in
ouf-of-bound shift.  The disassembly of shift is:

    ldr     w2, [x19, 828]  //, smmu_7(D)->sid_bits
    mov     w20, 1
    lsl     w20, w20, w2

According to ARM spec, if the registers are 32 bit, the instruction actually
does:
    dest = src << (shift % 32)

So it actually shifted by zero bit.

This caused v6.12-rc1 failed to boot on AmpereOne and UBSAN also
reported:

UBSAN: shift-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3628:29
shift exponent 32 is too large for 32-bit type 'int'
CPU: 70 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1 #4
Hardware name: ZOLLNER SUNMOONLAKE/SunMoon Lake, BIOS 00.00. 2024-08-28 18:42:45 08/28/2024
Call trace:
 dump_backtrace+0xdc/0x140
 show_stack+0x20/0x40
 dump_stack_lvl+0x60/0x80
 dump_stack+0x18/0x28
 ubsan_epilogue+0x10/0x48
 __ubsan_handle_shift_out_of_bounds+0xd8/0x1a0
 arm_smmu_init_structures+0x374/0x3c8
 arm_smmu_device_probe+0x208/0x600
 platform_probe+0x70/0xe8
 really_probe+0xc8/0x3a0
 __driver_probe_device+0x84/0x160
 driver_probe_device+0x44/0x130
 __driver_attach+0xcc/0x208
 bus_for_each_dev+0x84/0x100
 driver_attach+0x2c/0x40
 bus_add_driver+0x158/0x290
 driver_register+0x70/0x138
 __platform_driver_register+0x2c/0x40
 arm_smmu_driver_init+0x28/0x40
 do_one_initcall+0x60/0x318
 do_initcalls+0x198/0x1e0
 kernel_init_freeable+0x18c/0x1e8
 kernel_init+0x28/0x160
 ret_from_fork+0x10/0x20

Using 64 bit immediate when doing shift can solve the problem.  The
disssembly after the fix looks like:
    ldr     w20, [x19, 828] //, smmu_7(D)->sid_bits
    mov     x0, 1
    lsl     x0, x0, x20

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..01a2faee04bc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	u32 l1size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	unsigned int last_sid_idx =
-		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
+		arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
 
 	/* Calculate the L1 size, capped to the SIDSIZE. */
 	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
-- 
2.41.0


