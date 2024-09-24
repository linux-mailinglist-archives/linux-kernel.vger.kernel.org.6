Return-Path: <linux-kernel+bounces-337137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436B89845D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637141C22C73
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325C1A4F21;
	Tue, 24 Sep 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="h3j3yxA8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="IaVc/BgL"
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FB3F9D5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180407; cv=fail; b=IAjdIRjlW6tmOK6z1x5jI6uaKprVibqZBJ/Erfmw7dsMVAPw1IsobEqQpzmUQqDrTzPAZmUCuqmNK5Umz23jFualiNYF8XwflDi2N5DPhkRJ2L4c10lm888MXIAdcp6KB27zKoC2CQzbkXKJERiFs9xHkpkhlo1w0K4tVT8ruO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180407; c=relaxed/simple;
	bh=t67N+eRG6Bus32Yn5nrGTa0KLzUNxSqXsU7/n76Z5Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk/lnPv0ko2AOX2nj/A4hRJ6HZqZtmieTi9KfWEJAEJ2OLq4atvnmWmJ+yZXnnwJr9qgpMpcF3ZPXAB6b8L/OZ+c7+WxoKcIZR70lNxX2vrz1Muy5/8RWrvLiUreKUdotvalG4LTnOiFOG7FLFcNOl1RBzWn2o8ezDcxJEg2w/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=h3j3yxA8; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=IaVc/BgL reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 4EF1030EEA5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727180095;
	bh=t67N+eRG6Bus32Yn5nrGTa0KLzUNxSqXsU7/n76Z5Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3j3yxA8pkEXVmwFeY/sIZOXLotLeprIF4p+A8d9m49lQtwc9SAy+Bo3njguOu/1G
	 zYaxXks9P8CSOLQUDzItzEatJCTNDC+Tlm4U0kEyX3EO7X3HcgOM/Fwb+802/NYidW
	 RWL2VFzH3o09sTyNz/aBZaLEPCJtSogktFXKqKPw=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id DC49530EA39; Tue, 24 Sep
 2024 14:14:54 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012054.outbound.protection.outlook.com
 [40.93.76.54]) by fx305.security-mail.net (Postfix) with ESMTPS id
 91B4930F06D; Tue, 24 Sep 2024 14:14:47 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB3153.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 12:14:46 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 12:14:45 +0000
X-Secumail-id: <4821.66f2ad37.901e4.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPC+6dqfn4wQWkDs/4PNgPIPkuInVcfOE7oX4dSyRMipcPxFUE4Tnah4/BoIAXRMJAlXhEcbX9jelk4C3CxigVxGiE2nl0oui2lR4tXFdBWmWLkM3xLopyzGYCjuDJen5m7a5KPPl/s7JYyK7aoHDM4mMyWtc2XPQc6xarKgHd4VAjiKPkZutWTS9mQRqhdzpXTXPoty1uDO4PItuVQbpyRxBcfepP6ViAdVreQi5oVPvuMYx7jPOvn+ri99fzrMt0Y2ABWed+kK4A9NYA+7lc4RM9nbRXeHTuMXKipjH3vbS+Q1pNCzHzXjjSMEU4bjwe0dBV7S7H9rAM28qxijhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJTGgacsYFaEsu3T7mxy9E/2SaPsUedgRxJayCcSpws=;
 b=SxFAE0hgv1XfISqxuLl2QYgVLIUGjYwbxtQtM+RKRSMMItobObywzlRzgIz1JmNiLMQb91Y6d/X3KyW5302Q8We0lzKgxTj2Ifw40T297mxtSjd4pWRX3hjm60nO+aRzEaWSqAQ2DIpni3nZIfZbf9rNE7XHxjW5MB49pWznrvC5/EVI4wH5SP8hlBBdCVa9IgMmVyGDGYuVDwmNqOfscZhHYP3QPX9bNtDiwr8jujjTkJP/eLl98xIncP0FRJgqkNvLcOzTBJRdolR81nny4yQPN4U1vlwWeNbW/7sP++Y+7alJ7PGCsjA62VUBYMM+GLsu/sThBuU1xmtE4yhg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJTGgacsYFaEsu3T7mxy9E/2SaPsUedgRxJayCcSpws=;
 b=IaVc/BgLIcCutUDHk+dSWx2BUC3MPD+2uORuam5DMVq3ddGKNDxnxa/37ugivhr/RLGJKqeoCSU/6EAZM4KzjByb4nu+1NVQekT1um6MqkWYHzBdZGDPZMQr3RtsQXMbOVPHA2+Y0ywE7hAYPQ19ABqhXKVa3UDcHBljfB0IMhzeV+UVCtU5g3s+F/NXWgHw9qVKEKWwdEatxw8WaHf9Vn3jRMFtoE5phUhHr5Rlie/ssql4HWOYDu+aDxZM2x+7wBFQ1Cj/VHsgoII52Smu7dE0Mp8zC3j3rSIbdHr2MncpyyjxNtaeZn1gJMcq9Qe0IPsoHcwSqmxIifNzqWmvyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v5 5/5] Use generic io memcpy functions on the loongarch
 architecture
Date: Tue, 24 Sep 2024 14:14:32 +0200
Message-ID: <20240924121432.798655-6-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924121432.798655-1-jvetter@kalrayinc.com>
References: <20240924121432.798655-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::10) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB3153:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f5e1b1-9d68-457b-042f-08dcdc927a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 9JqgyHgyBLQsi53tByJz/Kz/U68+H/lBzFy1DlSEbA7Qhd1N1wljvCgaAJSkFMG4OL0l9o+aS0/p2F2ZytA5FTCL1r8553Ea3orJRMXmnZlVr5zsvfbhyW01uAjAbstx+6GHkFAFRQLl2VZOfEQ6DkfwfoG/QxM83TfQbYsVcF1kpdjvaSvM0KHjrgWQiAlFWlsV6psw4Dj8WZnIiqE+Sg+6uYcJ5UueSvdt9nbT1Kci5tgmUqXwJWlm640LrUzcm0Qa9irrdn5Ij94FXYUVrsEfedjwxC+c1RJ2xam0R2wJR2RO1JUG/2lo+nOBepJyfaXtiQrGvOm4IAX3urSfC3+Kbu0ckiCTF1MX4GRsMPQchVSsO4GWYn6Zr0B4oUhPCKRjOU157uwA2ZE9ZQ1WDIjQSqlZx4q1C0RB8/srxT/xT10gUHcb5Y3Zp557+SN0gZCpB5z81PnmjUfvg2cMdZ3khmzkPfHMMMjxMwr0zQuvvGm26r9jS7f2nFR6Cw2RAZSiNczqijXnLawpUB8pxtOKvKOfhZDVGy5oiAnfuj/NjJvzjhaDHxwOMOCAH3JBcRUnH5L6h80d1fabnijOvD1ISWImAqllqJuQqaw88I2lmxE/zBmg3pvNDvTXynfl9ML12oLhwWJhgAaW2cKlskBvVHt8/lJC2OOSn8tMjJO69/YziUCE4mS8VzI+JRMLqd3xhBhIaafBFl8X8U5IEnBfQQkIGOYYBzQTq6QNWeb2nleu2wLpUhAc5BDNsyAJy6MR8N5J4IPUEchwoZiJXG7xX4mEOi+iNcSfcVAFDtDKX4TpDshupf0x7svttdwkvh7zwCbcMusHd2gi/s1w7XWLxKX6xVb1FXj4eHsNRX3HWil1fLRnF2jXskOwzlJAs/I6jjCb1Wf5OMPqdLp6mawy34OSezka+MMOfZnXRGu1gPneyaF/ZHakTCuUHg7u40b
 NqCyosOLD9ks5ghef61ftTzenBCrFTOjezjUM7DvQWduk+f49/0MayfgTsnVtG4s6Mjr6eGKTHG2kkTc8giFvy6pkcc203O13WtMZ36eoaG37+qoMxIqlrkRM8v8/cbnixW/ktGA8qEHK+uQ6aWPhzCd/UcTVdaNa0oYBGca++C90VeRMD/F3QZSzULjX+15kzLvgGMA900JKzh8S1A17Zk7MHCLV3nAhBjM8L4VttEfW28+LN1C6SPeDYKxuVDs77gz3p73WWftyrIqC+gegthjNGtEAEm9qwxykOryULpIiqGfDjRZI+VFNMhetj9ng8acHMJCIS+CSE9JrAatKKHya69vvuYt/jTLOxXVyzEhpwoSLXB9BuhknWtVXnW6778LxK1IvDLa94rs8bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tqFZU7LtrBmT1cLn/ULDbi2Hmw+FO69RcSPlyVRhZ4xdpoX80UGDi3by0r99UsUVumi2Te9LFCoxqVhhTogv/MuhL7U2NITfgbTpw21K6iUb95ICiBxX/GtiE0m4CDPkmRG8ZppEdkOyf/jB6uxIxyH4iLA4b2N8sflIr9OR6FL5+mm/4Opl4yYYDXrh0o4ba6HYq8nlfmw+LB12XuXd0rtITTZDTJ8K/DL+RkcpmHOTcu2LfJYZ606uYABH8kOPtzbo1c7A8p6fx6jG+TcGTZ5fSECu8sNc8OHULqixlg6gBP4wb5vzBI+eOyhKku04mmISrtREOYVFf0UIbnlHOJb6n9Rc+q9GpIt3z5vTpb5rryB6J/VVifZZ7hseNe8SHaqJRtHhzQKbb7t0Obi0s5siMZie0sQrmRz3MIXYdgWOPsTQfiqgiWB5OqqxPU+mXiwiexhZbmCdz0W/N8Rea0Q7qgr6BSBuSpAkAE9M1tOGUJ8nu1F4W1WmrPUCKAsyseXSpA+VUW4UzovPlUKZ/YIHtz6Wor1eStIVGQIpBed6bEEHC3/2+KRp3m/nyaV5VhdQUk2CnGzaMw1XvMUQJEPVMcYoeH1ivxgWKTBwHej7GhKCOougGv8OJCK2E6oxvFhmYAPxpdlXU28KOA+HU5io202GyZusxm0RS07gMoak1DrPCJeiEfsfikynevD6caFOmxTNk2f9ev1nmDrGmvXMr0O0BCiEBK4NIowRchzi8DzomyikeaQe6Jwlrw+R7yR3EldtzIMUYEgpYXD9bbmplNlWM4GUHhd2HNvMXDW+4xRe36XgVOKbJNANd/CYmbHqd6TnANFZ3h4SiQDXJkx4+TafShwUAERcTGgx0n9LTCUm7/4mFbwhRHG2A8eYxIu1YU2yYl1/T/n//xbyBPXDP0G2sM+7awBwfqtL8nRGSODIOwC8WLmhBIW4Sxi1
 /51ShLOz5mpPhDc4LGGZ4OV6nDpVAzHDFBBP9M74UrNsM1x6CnbB3yCI37lnbPg2Qr8vJ6L4xtcPR8robSWeGAOHTxZnoDCA0ZhcJEgpyWJxCWabMCKSh7fbBq0Tnz37yfLbjUN0+Gq+ZbA/2jrr7ga0o4AVBT2wX9Ruc2TVNWRSd6oRaF9DELuJv/W06+6g6LuewSX1WwIh6yCYPYBcvugkTbRSpWa4HG5DTdCsxUGCjFNw3mRPfMHofecsgYkCiS4wRDPa3K+o/r3OI7wSVwHbGcDfpcIHBe4DTlimJWKhHWAyaEXZ+aEuo6FhX5iR/1rGc7uUisOFtdRLeICoSqoQNqbAl7Se03HO6qk7n462V5o/jans2ERe92kWkL0trELahd3tOAGUqXjtJKR1rHhIBybR5nGZ9aT1CLziK3Q46XePmFBdwPLn6RmVZj+SYfLm97QZtu/Rh9rRcO2fR2zdAIDoBrhM+yLBT9+irGiiXvOIbhORMhzqnmOyzcoqVQ1koqTISY7Vs3E0g6wiCFbm3Eua5CpyhcErAqCVwoH36uKqHFnqN75wH+jvyc4VrzsQ6V4XbzMGr2662hy0dU0HzALxXU2jZAdYqSW9AnCQsc5ATr58Yx2Ul25rJiIDHmwjcagWNne/grt/eEsbEA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f5e1b1-9d68-457b-042f-08dcdc927a81
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 12:14:45.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qFJ2zpM9SUNly9Z5UyvDFEBp5eGGCn5Ng06bmcCEMBBqg+umKGvdBuzsbvS+zdgOcVVE52EKqUsUKiFycPVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3153
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
loongarch processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v5:
- Remove 'select GENERIC_IO_COPY'
---
 arch/loongarch/kernel/Makefile |  2 +-
 arch/loongarch/kernel/io.c     | 94 ----------------------------------
 2 files changed, 1 insertion(+), 95 deletions(-)
 delete mode 100644 arch/loongarch/kernel/io.c

diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c9bfeda89e40..9497968ee158 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -8,7 +8,7 @@ OBJECT_FILES_NON_STANDARD_head.o := y
 extra-y		:= vmlinux.lds
 
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
-		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
+		   traps.o irq.o idle.o process.o dma.o mem.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
 		   alternative.o unwind.o
 
diff --git a/arch/loongarch/kernel/io.c b/arch/loongarch/kernel/io.c
deleted file mode 100644
index cb85bda5a6ad..000000000000
--- a/arch/loongarch/kernel/io.c
+++ /dev/null
@@ -1,94 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		*(u64 *)to = __raw_readq(from);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_fromio);
-
-/*
- * Copy data from "real" memory space to IO memory space.
- */
-void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(*(u64 *)from, to);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- */
-void __memset_io(volatile void __iomem *dst, int c, size_t count)
-{
-	u64 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-	qc |= qc << 32;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(qc, dst);
-		dst += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memset_io);
-- 
2.34.1






