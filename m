Return-Path: <linux-kernel+bounces-337132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400A9845C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674041C22C46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C21AB52E;
	Tue, 24 Sep 2024 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="AmKpLMnX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="RhNZGrqh"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2021AAE3C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180094; cv=fail; b=XqAQfNQEzYUT4FtmJGyO0rMt5TW56tlMOo/gZbE7ro7TD5UhCWqWf8cMBadGlhoVFWYVUp7kjrWjcCJiEMswzUTAooHeYqruwMC9CDwlRjzu6gRwKoaKXOEpkxm+FNOU/hfDp5hYnqZI1dK2Xx+FoNq80CMfQ/LoM5IOK64IhVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180094; c=relaxed/simple;
	bh=7251be1NdUFGat2x6OZNhksQK9CIV8jm/WzvBBgUJhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaipotGyEmj0ZLgx4xg/FGoPI75W2wJQTpg1mXdPdTHapW579vng7Fn5xx6wowwSPAe9ThiRu+OGOupEOtiANlApStwSL55BPk0HItgSVxSCoISbwt2GacdhZQE70f3p1hKUxiIkMyU9jUQGz5rILhR9SwLQsrcCSjiK2RXiHdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=AmKpLMnX; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=RhNZGrqh reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 65C359039BF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:14:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727180091;
	bh=7251be1NdUFGat2x6OZNhksQK9CIV8jm/WzvBBgUJhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AmKpLMnX14XIRibeWpQhiUX66vBxy5qz3YGZbiUytPHKh4sQoIiBdc18xqEI2Ovbk
	 1pGuiFdR34TtCFBOtBYJ1HhfEQxQ8Y36d6RQ3lKYo7+caIgsCfdrcnis9Go90UZFh4
	 9WOE5p2SXAkTilKVxWe589MGF99nL2A72uZI6e0A=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 16E3E903B30; Tue, 24 Sep 2024 14:14:51 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011029.outbound.protection.outlook.com
 [40.93.76.29]) by fx403.security-mail.net (Postfix) with ESMTPS id
 EDBFA903D87; Tue, 24 Sep 2024 14:14:48 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB2391.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 12:14:45 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 12:14:45 +0000
X-Secumail-id: <183d4.66f2ad38.ec3bd.4>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9B5lcQkYUU3KeQwHnM45pnNO6uUYSlVR/zGY8bS4ns9BQTnZQ6qctCNspnim40yvI9WY60CPOkDw75eIqE3HRZHOaDfbI91BvJg7ouD2nLXlJTNpUj+NTv3Paew4AEZApCym+eE5Mc0KKCyyzuoKdH+Wf51+nUJ5vx2Mv+g7sZvpq8rWZ48xLjTlyLKQ8J9QZrN5dMjFuRUhpTlxBL9ni3/p612e3mqjz8oEYs/nloF8w/dlokcsCwdcFwDTAHp1RqhzqteCupHwm6X4iPEjg4bQI2UZn2n/fvnM/Agj2uUnYy28lMhJyQOnTEdJvh77kQgvQrxQaePCvrrEbgSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCAXrkwULjm+PubJi7UFy2hRZbaw2VKJbk3YvOeRJ5w=;
 b=yytC29wCd0UecYJ/CZfjwoWFb2IvUcCzpHGbSV95CHqzniKJC+TGKgzz4NtyVFnKU7yLn8LF9S0S1n9OSRQ8ViuaKWw8fd1L09OBK3lD+2iVkCGbRaPVtP8lcxugSUx16sFAuUd/TA9TCitlJE5vt5NIC/AaNRJqvExsqfJb0rDMoz3ZNQJaioJnRwOGwioUx/QpdJfmIIVZy50hvMOr+DhbE+X9Zrq2/niHFYha/oj14DRCaMlOyL4DN+EhGcwMnQe1v62ptVnbF/M6CNNuh0VLGDXapxcYujWwTO6DiQ5iJz06On/9PjLZ+1mzLqHLCThUu5iYqRabfVAeRfiGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCAXrkwULjm+PubJi7UFy2hRZbaw2VKJbk3YvOeRJ5w=;
 b=RhNZGrqh7m6Uww14+07YJsuVkE8j4q8nocuvsSlcKQD/j9AuMXN9RCbIJkxBW5vfoUv3cAtD3DmilRFLsRLZ5iqjaWkWXxq/xm8d0UmUzOIoseDlXx3kNmYTkAzvkEcKBseCZ/1UgK+tYtF2fXbwbcqCHm4cI24o3JWaaG12foOYQzaEA+tWHczEtuCrIdiu+TgmdQcdZvaTtQ6qWllsmPZaoWgC1PtcZ8kTxH9oJQ2+5QjYTJglnu1BsudpiwT/B/+wcZHSsA40NcSZONllNvOkg7gGxRtZeC8dhOSkwZoghUBSzJzTQ2IyB5f1NpTXmO5aHZkRNEFAbZa/P9wPfg==
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
Subject: [PATCH v5 4/5] Use generic io memcpy functions on the csky
 architecture
Date: Tue, 24 Sep 2024 14:14:31 +0200
Message-ID: <20240924121432.798655-5-jvetter@kalrayinc.com>
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
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR0P264MB2391:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd293a3-73a2-482b-3f5f-08dcdc927a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: lt4ezBKxlHW561OU88gmZTJ0/PsWsb1rzo3oqQqUqnpBbPCkqYG65rWBp95BNQIhap5jzGo3kjGwJx7ZhZK3G4BI7rROM5wnlvWvAIAAoidST+8S0B8K1B1Z++k37x/pxHbkFx9i0OwGx8EQjhA7SGXv1t8knoN9MowSvS7eqETzkSU7GFI8sI+AVz6XEAQ+Wsrmg3EZ/Z/fJM0T+Ws9P66hwofTUDn3kwvZpmgxMvQsVwJS+rs0CHa1Wt7PCi6DkIXzw1EG/9LXAwjElVS4Q/esWXXP6yMdj78bKy1r7iY5Jzf4zq2vkoId0NpaSRvgHAhyi9AB5IkMugUmZokQ/wLakC8uXwJSijcnmz89oTLFk2iJ5W725Rg2APRZWL5/IY8IIyMqRU7Spja3umhbwqJsw6Kf6cD0SSEO8l8XldfRBiqwiXBGq5bvYL4rTY5RfBTYil0FLISU4EL7X2ISqJNNrxq0QLdgWtDncmCKyJ2HyNbm4SOnYQeO1PF8Q4BvBMjtQZbHCSXmBiccnxDPVJ9be7KmHJISvm88FVybvPUzRCRmA1XtS6Y6AGuWqwUxNkWwUXWGvXwxIi/l4chtos26fIJjuy+8oe8oksJovE5WdFVkAlMCxXzsE6vOJZ+Ov33jEG8iEW8zKTUJiWKLP2U2oxQEygyui8e7NXAXy/7jQMYUtr9nfKBrWCuxX1xC3nOb1xI4vCi1wErHvGhtzr7IEXrgzDaAIofmXdT7OFrPNkhVwQoGUyli7kDnWEymNlwRZlZX1LJXHhmNbcQkVLe0zdmEFqxUnrR5OxJJbc4zsZgE7vSUafypAU4bCi3XRz4uUkX6NlR1S4S050kV7AUOm1U5cPwcBqV1HwO4guAFY6or74f3imh9MhzM5Dr5EmOikhRR2txHmVINOuBqTwLim+e2wt/J+iS4p58gN84EgIhOgeyj+/wkUQRUlTOF/Iy
 7aQXWvJ6DcK2Twr1LebBclBtM68QHD25jbczyxq1PJE9T+pneMdRjacghMyg/58awVKdxOVWjNIYDGqqJmqSC1ceb0AmdX6qqnaV6YAux/Io2KA5fPOceXsGBv0+DgPjMlql+nzquEGx4bD9wbT2zuu5EoHZNhM3aSchCPYX2ZnZpGVea+KL+OX/RirpmmlMNQ65QeLvYjWxSr0PuuPvoUlrAytX1O0U8Y91VntUKyHvjOBcUH9r5ZhfqqdanNjqEjn6FvHIgcQXjXt7/p/RCv9MjX3BI4T+JhUW/R0eXSsXwqHdDkn1gpVPRnIeJnmHyLyN/47xvxJJsxRSSsUvUydHSW85JPmU+sQEINPbteul6cCR0fin+KuPjJtbTA7CKAPmu/3q5lQ2MXa/vtuUS1ElWcCh3lzPj+pJ68jJmzx2veh7AcQ+qE1tj42kaql2LlKIIjYmPvydzy0FzFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 11L2VnbHNkrAVc75GbYfh7y/5VX+27ClMriPvTKtvSW3hRrZ6VXV9J3KQnJmXdKJg2BPHf7s6Q8uGG8PQKbCNcr6keTwVH+YG3DkpVWcIjEfAzKhBIVD5lWd8JyL6bNnqCC5xZFDGza5dvUsqFOLbNayfTGG5agTAyY9Y5U4Aa8X5QXZB2y4h2fd2c4O9mqiOYn9/A1iV2ZBxU6cV6Rq0cPoGMrBTcrOUWb3QUMteYm8jnsSncaIUQLtBtK2VOxJHw8FcZzt2jQx2zhiBDCEXYxyb99JAjLczPyUqFMekm958mSkUVD8F7IzhYibN+WHA1tgnez7Z+ZuPtiqEGR2wf10kaFHtTF7WmV4bLK4J4V/Hsg7OYU6NbHlbAetK3lgobctK2BIPKMhDZcqyiaYJFyemf2WMn32YiRhDFQwAdwuJmITwHvJ9cYDXGtNIcMgaqiOnDYVBo3f7ySbDv45nYdk1FR9cKOf1lwwnt3cwQCx/CW2zfMwOWz+6Lw0BDPIPY1EOIarUx/rgCIbBF7geRswflCvtHjTbMVK4HTu8neps9g1Ao0F83S2oDjksfiARlCF7Pn99D+ynrtIXBSnU88ZiB1v7p0QufPROzZ3ikae/hNReJasCl3nPnZjRjmep8jM9XnxJNfaYwWRSqYgA163YJFkGFWVVaxTNyVbrIyYJfMjqpkLpnOkle4+MUXzIQ5D2JZxoo2SeH5Xa8bzSRAAvFFPlPLBBDXAcxNrXFfsB6M/yvYv4EFLC/dssrZqIFQurnYc4wlVrmWUyIw8Q6GuKgyww0B6amHXckBCBRiWkHgK0uuJWAX0RhlRJRuc/ua/Ob8b2+KZxG6fccDOMZe/N99HhH8iFb4wz0THdNfePoNpUwiIyEJacBIFPQ8DrFJJ+Fmp1q+KWFTRAYQaF3v9YLM0xLmWXV0+brslx25xBK75HFrZsYQZxBblIRUg
 7jd2EzwXxlY2KeDmI07gVRNWXvBZhx4GAMdrFg5ysC3N9PfSo3XtYIdTlcKS1elBFixesRiNc/jXCj7kvORVV3mNGwxSdbQFiqfLlCjFknusczdBW8oFQepsXJmqMOQHePyfp+zIcbZlQOAA4jglfp/+Pj6txk7sNJcjpT9/QSu5kZV36BxuSWBG6dLYTw2I0tSssqI3nz56JzX2KtHCxTrM7R+b679D1zXLLHp34hLXzD895x+Tp3DJXWo8ySCxqyhnrob3oHNTeGaWAHRvdSvUblaOSpaG/pZYiCU5R4op59t3W/82xvb307QtV33+zepRT6hQ3iRAFerySPLX9/thnO2vYvA9AKdr7CBTKRm8yqbnOVfAD5EeW+SiAFXkDXEAaX0NN16Iy6kzTCZdrFgwaJIutdyeiN99lkrgN4irezwtkzONf4f6JbAETHIVMfk48oECn9iLWlk0+f4GGUTuo6LFfUo0Mf8DTCLwQ6hXcy0DDzOxMZRY21G4u/++ekWJGFSZCIGOjaZFGq8+fzo2DqabJxaJdHDJSwcetlwTBz1cPW8qxP3hJA+zN0c6FBEtXrPqDdcLfzAg8+/OW4bAbCUdTag2CDUQFkNehH9TAdj5zOhm4m3Qkfcaomxa6MrWMwBUDiQ43ypL4MtbxQ==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd293a3-73a2-482b-3f5f-08dcdc927a3e
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 12:14:45.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa+hfnPSLRoH+2sJzFcQZhr93nM2ErEPmbREPk8yCf3BxCTAa0o/KZgqC9As/34ixXrlYGq2cbY3QKAlNIVJhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2391
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
csky processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v5:
- Remove 'select GENERIC_IO_COPY'
---
 arch/csky/kernel/Makefile |  2 +-
 arch/csky/kernel/io.c     | 91 ---------------------------------------
 2 files changed, 1 insertion(+), 92 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c

diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 8a868316b912..de1c3472e8f0 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -2,7 +2,7 @@
 extra-y := vmlinux.lds
 
 obj-y += head.o entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
-obj-y += power.o syscall.o syscall_table.o setup.o io.o
+obj-y += power.o syscall.o syscall_table.o setup.o
 obj-y += process.o cpu-probe.o ptrace.o stacktrace.o
 obj-y += probes/
 
diff --git a/arch/csky/kernel/io.c b/arch/csky/kernel/io.c
deleted file mode 100644
index 5883f13fa2b1..000000000000
--- a/arch/csky/kernel/io.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 4)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 4) {
-		*(u32 *)to = __raw_readl(from);
-		from += 4;
-		to += 4;
-		count -= 4;
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
-	while (count && !IS_ALIGNED((unsigned long)to, 4)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 4) {
-		__raw_writel(*(u32 *)from, to);
-		from += 4;
-		to += 4;
-		count -= 4;
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
-	u32 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 4)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 4) {
-		__raw_writel(qc, dst);
-		dst += 4;
-		count -= 4;
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






