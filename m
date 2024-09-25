Return-Path: <linux-kernel+bounces-339143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AED29860BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85301C25790
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAC51AE857;
	Wed, 25 Sep 2024 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="UzxAhAUd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="TaQouHs3"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C509C17BB26
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270688; cv=fail; b=lDCCKX3c4wMxR/JiA3O6j3C0oDEb7A1hHE8r27OgV6cF4ttmSmS0fE8/w1me0UMVOfZWxiK2rO0CtZPDYtbfBGuy9d4wvLyrvO2URDPSh/IKs6c+HO8QeRwSXhsBsAQ4AdX5qdXSaHSnhVftenNovsTEc9yUfrGSjfjFMlnuWKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270688; c=relaxed/simple;
	bh=ebU2POQDrXM3XeAkQlxamwrbbopU2BjL2REyKYQt5NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxXMlT9ld/iW/x8YrDQ/+yayIkmYgblpr9v/zeiRntz31hAoBoD6xWhE9UUBd7F3ntAqgRgimY/Ylu9FgKucMpnzolA/hUpG57lWAeNby+NZre9nYb8b2gpLeOFjsR7Dcj/9IuKXBQOlQFIEidMSVl7dkqhi97nqoYDB+MCF9AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=UzxAhAUd; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=TaQouHs3 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 68F77349B3D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727270681;
	bh=ebU2POQDrXM3XeAkQlxamwrbbopU2BjL2REyKYQt5NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UzxAhAUdVIVv2GgjTCns9xPzXFCcLbuBnju/ITr8jjNCiBRdTHBAXCXyEjo/SuyfN
	 dR//yuIF4mQGMVKcsiKx9502HQd5G1Osx6pSnTREYNDo52Ual8plphBZ9Kf/IZ3Tww
	 3fglTUcPSLAaLbKkaqxK3cL3uZnu5fLkU5WGC5JE=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 3FB74349B1E; Wed, 25 Sep
 2024 15:24:41 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx601.security-mail.net (Postfix) with ESMTPS id
 C2D42349AC7; Wed, 25 Sep 2024 15:24:39 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2543.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:24:37 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Wed, 25 Sep
 2024 13:24:37 +0000
X-Secumail-id: <ab3.66f40f17.c1c48.5>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1ykKvAZvYd6B1kSZL5KHekgjG7Oh4LIQW53I0TnlGAjPB1B1xY8BIs6og+tL3ZDYW7fuUQ9m/H1CTHVkPjv9JErfgyiEMHKCNKyXVB9TFFW0Kwz5rzQ4Oa5iQr36yZA3tZhnUnOGzWpeJYz2rPN65w4Jjb4/vZqC/f65zg7quG5EWOkgW8x/UVQqJi+PfUEYht62oRyrbggjrEyT8aMba4peUQ0WTUul/B8qERzboATRHQ1JKOQq33VArtOe+Ltbhwx8rkn8TY4Cd2ATC7tQCQDs/bf5zH4uflXzpjYfwTudH/VKwNYKydFexOTp9BxNzDdp75J4reCJanyTzX1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkaRwNXM6Svs4joVTR3jwab5BELH3isYU09KvmxyX/E=;
 b=qCuwhXb/2Ipg1LsNXd4f7P/HzckplmVQh3mMy+RdAXouWEftJfehgRuBbUiDHStBmnAGL6f1dRKPJlCB6KALOZjbd8YJDBEAc5upwiO/WkC2po+T/y0U4wwBnqhDa9ODnxDDQK2NOUbxghaOJ1iRpdLNgz38l+VNhd5BNUW/Hz692FS+HOV8802MdmH9mpjMW67hgHiSbiTt+SxoiFC8VXlA2Nh5ki7ui99+lmL4XuUzmlGbVf4/MOSb5SCrvlq+b6Rr0YqhFhTJib+puxorxZkGdGYLc5PK8ZQibLiGHlgNCD8T32on9jtuvyTasIThQzIBx6CymgFN4dMMh24TLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkaRwNXM6Svs4joVTR3jwab5BELH3isYU09KvmxyX/E=;
 b=TaQouHs39eZ4vxkodcVVrbVfVsYVwnXOL5Dn/Tlq3qjdmnHMNeFljyPraa4+QigIxVWIWJfiPRXkfQ2yEz8w5vndaUtIrVEaQcziNMSwd1xEObUr3kT/nFBgDBzQ1QpOyoaa5+jD1nHvhDiQzF5eWQFRgV+k7MTmJGwOlM1TDWCazt2cskOWZJIoRre4n1BMpuBtsreEqq0DgduR3viDoxsi/3yTyyLW/QqOWrX7mTVgdqdE8XG8chWsX7FRl2yWA6uLRhXFlz9LoACRXDNX6J1e54Ojr5PCDGBXP/On0v2h+HvnOhnKCXv3YwQ46DpTPMkYKPBQNFXXNgFc9kJrUw==
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
Subject: [PATCH v6 5/5] loongarch: Use generic io memcpy functions
Date: Wed, 25 Sep 2024 15:24:20 +0200
Message-ID: <20240925132420.821473-6-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925132420.821473-1-jvetter@kalrayinc.com>
References: <20240925132420.821473-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0138.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::43) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PAZP264MB2543:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f68df9d-cefa-44b1-60a8-08dcdd656718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: OOqTe/sV9XC1lVwEjfqyUhb8s/byamcad4/34xuj/GzFcaXUoN1tPGwFfE3w+Ff3KfnyQStuYfILeTnDQ2UNfC+tOi8EJpbQk2iHvaEUkpHvAOlpM1q3h+YbpOlwdcVBMJMaoTyJkb1KZWXm1gc/f0IMBCBn+a3vp8HTZ76gCuEujD7iQSbJunkER7ql63pbzuzsTH38JHMryL6bwe6m3hJ+pxd05BDeHrnMfNJLx9UhLYtskvSueLTYWxsYhojYsxLx2+lQBucTNRzaZNSCHgIDQFFL3eyj6rUHcvkNlshccMXecQsKnhYU07LibOVw9bbzGrmuD2ZBtSo1ctW+IYgMcQ6S9YNizJBOkqdUzB8YlQhQ2sfjzYODml2APSZLFi78coqP+bNQpRivTnBSPxQfoLOS+pPwrdLqnn3Nkar8jmxC04i1k4h33kjU8xpQA7pCf3E2O1VFTCi2DTSC47y/pmeo2lmSKPUlYqp4j5y7szqUbaXui8kuojLpJ9E4hBXHzZss4RtSME6vqTAlf4xg+Hrwyanffh4sygLlS38Sscs5RWZCpSChR23VNfw/yJGdMyPSSfK1r6nHYf+ijdtEuDZK4SgY0fcWN6il7VLjeiyieXQ72k3AJegutUA2OlwUIVFvmBLEq91d19m5+jZU0R3OEv5ABnqpKPqgrmwGVkIC1Y9hTpJkI6FJkFI/1g19SKP91Y3LUrdwX1bSdyiLzSrG5592SlTR1kTtihZEJzbWtglqwTX8JrhyiFXWladvhyERx5k3hY00wdXoYP40FdyCbR4joiHzczZYuEVpWbSDcd69DhCSuD3r+0IDOQgsDFlujmQYxFGC/O1t/73KxAvn9gizi/Pr3DMfk70yrsRWGptYEsFFm0iItNIZ0aoha76Zfb3uqnoFMcvN5sE6QVCCPMRVF/TD1nFDwFrJLSYqXi/8I1qs5dR62olLD5d
 8exsaBHW5JEP+aiNBUv2y7FiebA++EH1KGCjkEg63A6FCGx5q8k7G5Ii5JtQh+QVH8ivOAk//MpLjd6E669wHmNzzB2M4/oFtlnJ2OTlOebea0Fjv1hUqBRLkHbFG029lzF3T2VvvmXryVtALiSCOqE6GMAnU0swS/5RCpG7qQfkBsmvJ1edjpljj1Vxj94+3A/Af3zOItSu0DJxlw8cSdXLLQoqCYewOfDfY3a+EQtHfNGevqaf4+x0BrCeJ6Y+9iR0N/JtuzwtYqJUqRSiN64pczgA9kocGAE+Dlz2eHpy+pSSkq7NpTjXoIZwwniQnAp/E2jdPR7whWLPGHOeK7tGFZTNucZkRrP1RIvhKdXo9dnbYt0o4VG+qEIPR8o2cf0bHiyT0fkrw5tYxuw0N7fC79EM2L8pKhGpjzfaUlnBsUnXgwLGTbBhqSpg8DitKl1MuxRSxCxFYTHynmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tOA9QU6uEeT3iB8UNRqtoc5vna0MOL3Z4irLOiluQW3Q6XjJ/CUXTxtbE4mpW1Q1sYnVkhOT6gu0agR61lzVdvxqyu2RQBzlb2c29J0lae8zlOugf4j01hEMlV96JnRXvJpGwUajn9wGGJnLyIQJPdj+uK2EFbDfAh9mMwT16fH1oKP1QuHGTz02CRj2ssAFMIraC0NdOHY2JQuaoqqq0+3bCZ1JVcdwmkSFfNfmDAM2Tl0gUE/3/QRV1sRmInBrprg2YRtrjpQK47oB/gYDtq+ZMnhpmRHAqsfIsrw5hOGtLFUIlznLgucY77T6hIbux3zhrb6kpJQvq1JPxnMGT5tS1Qd6nb87Uz9fKcvCJLaVO5vKw9ywZEP3XYHwlU57men2vOae/WwPLZYfVb200to79kWjdaXBTBnK3FNLCAPIyGTEOe5pNzAqDiswPG6RTQOoO8Q6sNSGChpdBEEJuQ5EEJa0Jn69UDQ7rluZDErrIrTDWQYZ/cxCjVjcRWG8ExfHQiV7DzfRi4xLIzieCIc6Ft6ULuMpkxm9+qtJ5dfN1D9CE27Vz2jIUFrcaXKVBfO6ZLXtq+rSOGzOfzg8fUIYMUeMI2dmT2lEiSHyNSJ5XMMWqEqX7ywQbMF2aKsCSadzt97oh0ok96DCRRCmVKozqxmFen/sTrpPs+VMW64FifQw6gGAgyjCE8ORp+qj+3W1icraETMbUZKg1nM8/TIeKVkCJWAxWxKrfmwaUj7hcn/66LND0Q3uddiaxG4jgMI6YIl88MgFI0vq/2sXeqe2NaNBRWmARrGVOmbU3lvYcmSKj5UY/Q0UGjWYpgSbCXx+9kBx6oOLNCD5k6Ji2ayTLKK0lfGnyPodi0nSF/XiZVtfFFceDT+GFIe44guj7vNq7xZ58UAeKOip6ag4Q5Yqw8/ZFjGd/u/N8oudPyWIx96xkVgc39G0ZwKZKUSK
 k7D4r308Jqx9bJoO2mrtJQLI65LXQ2uvbrefDKw5yLtbCCAI3OVK73OowFWt/mTb5eAv2yMycK/TfrchOwTVuyX24smtEvLmWNCSa26hK00VxYwW/BiY3LXzVv2/BwvfCiHy8Odvx3m51RW9Y0BNZf/YMfm39UlqiNt3YbRteW6RmGO9S9GUuDz2O9FChhSdv35D82XcXz2zxgAXlk1QDMbQeLcWKbzP1c5OyayCMQ6fTDHzVzamy2JliogCFIQQP0RkV7XLArWeEO5fibQX0fQA5+rO3u+p3BC4DBtiklT3I60BhcvD68iKHbfhjvyV6cRrGHMwloJJl9cOVc4ArfETY5XGi5Esc9H9KsPN+rIFM9Ut80ihPElPm3LTPjbz6/gy3Gnjz2E8UZKF+jxpTaHNaR4UeYV5A+k3dbtAUdrXSrm9xAInhGVtu4vIrWOAikMZqMERNlOeGinaUCplUH9ayYYKPF9ZYEMq/0l9QWwqdfDlIlJYSMKQwd276l9HxSbfZo5DAMrWUiN484l+MLSW4a2t4AGXaJcYzvQGMgUAsD3ZCLxXL22d2egI2e+T9O1Nf23+nSEFXg9W+89MLixojfTPSSZ0wMk5hd7KAgV7oXQiLkTxlbxZ6MfsLRIV
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f68df9d-cefa-44b1-60a8-08dcdd656718
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:24:37.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyJN44p8Rvu/G72lZw6BAxk+6GxUhAwFj2ZYiNChV8ysRGOkHKW1TU7rU+yrfAKdDNPM2q+3tyWpUIpRTRfq2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2543
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
loongarch processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v6:
- Added proper commit header suffix: 'loongarch: ...'
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






