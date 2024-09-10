Return-Path: <linux-kernel+bounces-323177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA659738F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5AC28772A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21845194120;
	Tue, 10 Sep 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="cjGi3+w+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Zw1o5Hhp"
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3E192B62
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975849; cv=fail; b=HIvmu4cN62bkwZXp7K3Lhg//qFeEfjQQ1cuyVFPdl72/oKSyO6O5IKL28n5g7z4dreaHPz6VmmquoMYiYS0ucEwtRhlTSdQGbTtbcg4c50mvmy8SkmhSpxWCcxMzJdMdcLs57AR7KUIfzealIjBYPGb+3jbMav16P9Py7we2jeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975849; c=relaxed/simple;
	bh=fm74sZv+wQupqd1aA35tAP0V73LJDMRwcbwSpgpGSEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYFTqq9Ou88y32EgwXQ7kDbe5Tt8PO0UkMYaOVSJvINoLKQrxpNoD/VaD9HkQYb7w3qvpyzOeK8Qh1ii6jkKGOQlGgGU01K7SYWpNkwjXTKa+96o/nqJ2ohUQQlGK6SkSyZk0+eNpbqwf3I2TMQO04uBkNX8MylJRZjyvDlGH8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=cjGi3+w+; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Zw1o5Hhp reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id BAFC9349BA9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725975836;
	bh=fm74sZv+wQupqd1aA35tAP0V73LJDMRwcbwSpgpGSEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjGi3+w+HlaHKxH9aF7yNmE9QBjyldeCW5BOc7a5uKvboDWwj0BAJrTmyP4WH1QK9
	 59YZvznORUD/hkcrC8Kx88kXAP5nMCx0cO5mrMd5lAXVvHe/lhNQK0AcN0pmk3aOsR
	 dhzeFTaB1y2WN2rycD4iAN2zuS5AJQXjBbIfDqLg=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 7D038349BAD; Tue, 10 Sep
 2024 15:43:56 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012050.outbound.protection.outlook.com
 [40.93.76.50]) by fx409.security-mail.net (Postfix) with ESMTPS id
 CA5EC349B96; Tue, 10 Sep 2024 15:43:55 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PATP264MB5061.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 13:43:55 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Tue, 10 Sep
 2024 13:43:55 +0000
X-Secumail-id: <e58a.66e04d1b.c829d.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUQ88BgDpG2+xQKfyk4YH9e9xoTSBgWecL55/QF+vYrX+yXco5AjoQa72hFNULzWSBmFwVNyjFaCHKZEyiWjc8W6ZoYK/LMGpH1V4MC77WC19HTCC83XcnpgyibjrCTR2qrtVjlTWMIrYxvuRRO3nFpZPyG5lqLOucqtHIWt+fPY3UXFzEYdAhAlEOh0B6JdLbzINGEtUaaYIQCmMHadqxrLLlOeFOlGpdBKBah0ULbidIDjVEOmOlhf7o2uUiV6Cy9ROOpKs8tqH2NbWsrHzgjUTqRvr34BhlFxv0zFVgFSqh8l848mu79qG3JAUew6SxwJknIR4Lhcbgd6tZppvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVUX+6s45Z0ge65VzI3FZt7ZlDdHSX5oJ+Km/4ciA+s=;
 b=Y3zn4ueocN7zuJv3UEqUXPb3zTt1fIPlkuKLVktdlEuq8B60ZOGrsXTXhuBnI+yqbBVBZILBXoRpNLIylYcRAn9QpY2PqndpxdkSXRJf8Aj+lxNWE3QGFApB4q+CxvwR4/j0MFtCXflQNEVfoOE9J6OuO4kePOWMHUrlAmzOg1rQKBZi+ZKpONLHdgSyWXScRdl1PN3DcFqF8H79oVln4UsZZODhypwYWijS6K/52rjcd6y3ZYfJjWPT3COS6AX/gyjJcgCwgL8hl1NjRmjBNBN795qCDHBOpGNJGv7wYiVngeaL5hmc/VNKJ0DKR849GUqeU1aMUKM/e5NLRYkzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVUX+6s45Z0ge65VzI3FZt7ZlDdHSX5oJ+Km/4ciA+s=;
 b=Zw1o5HhpSys4v5vGeASRreJY6Pn8or2gPIGz3iRhx1tJx2by9Jz9/4ZIylWf45ZkgTSJVXaV7clvudqRItPaH6b+055eWvRPLdo6kZ1NbB7PnfiBI1GBT/dXJ0dWlclE93o72pueDYesmaQqSxDushdXgT4fDEAxkak0O2knIHSsZXdwdj7IVt5Qh6J7pgZlzPlvQBQLM7qP6S6qleuti8gKu3ihhqBnuZGt5CSlrNJgUL5AYOSn9JPOHeWkb7G6DAy6CZr4HcpOvSXBWHTCPYpjpVd4IgDbITLZZhs9Tjyj9LtgRW4+U56zlSPT0bXrrAKGxP3nepryPnJEi2tc5Q==
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
Subject: [PATCH v3 2/4] Use generic io memcpy functions on the arm64
 architecture
Date: Tue, 10 Sep 2024 15:43:39 +0200
Message-ID: <20240910134341.2537407-3-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910134341.2537407-1-jvetter@kalrayinc.com>
References: <20240910134341.2537407-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0210.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::16) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PATP264MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: b998ad41-e969-4308-0ab3-08dcd19e9cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 31UafPGHuOZCxg1bE+0ndFxvDPbeoffnwLHMxpdBthre/FPBakmM5DCW8nEA7qQ6bQZmNPr67rq6xjRbOI4LxjQsGlYT61rl6Mstc6Gz5OmQfSgr/4U+MooZ91gJmFbeWg/aePs7bV+7qck828xOuFs1KFbZKh52l/pJn/Z9N9M2gFQX/7Gb4fq/DbS98pS2uT2qn6KYFZPOYfxUpAO59SYoAqifZkUzFuRpvuCQdin4dY7OEVmwjqUb/TvECvL+9+6Y/7EK8ukfANsQ3BRY/2iYtmcf2Tz77ujHo7Tys2pEtawvgySCMeVaQULdlrudNYQ3JwwJhhFSLt0RIKLN6UgkV1+k8n9DjNlXwPkD3xHZsCZryG/475y3wOjdA4KoLUqDm6IwAlva2ew/rzMA7eXkzf8BgX8flOJFZyGxOoEUIi2s5pxEf19Ot8yy7Ywr0zOAxAUDPe2AP21ULX6kBdQuyWRTntgHkm6PLvQWrjCJOtkYxQInMZxCgpDtVXPRkVBhAw/Q+0aMzgXygJ4XPOPZSX91o04lhMwQfGsYppKili8zfvG3C6xiHQTyQSUMS9axHpQxOFe2rjEIj7s3AaNKp3C7dVspvO27stIyKneiIF2fhqA1WM9r9jxA09GmvyV4vjKG6kwLg1Y+vQ2HuyC0vpRwxoqTnx+ZrXtvLG/wKlIBrtDGdXzXMRfnxg5DKNeZSN0/+e97BUdC6aVHOLx/rk1nf2YH95BlqIzj/6AW6IlUTNNMstOccPtQd7kfWBTy6ldNFVC7t0eyNKLyyugsdo605eKjBtiygKyLSm7rBrP/CZ7qhRwi5ZCMLBUUzSgkgYg/+XcQisBZTzdOy/o/223PQkG8WGRNk53ZdC7u9PEopKMxwqBI7/ALOfvnSl+4ryWpRoXEhOe0Z5BG+bIlJIzMVUISCLGlkX8T3sjjlTljUM8eGWU86L1rzGuGzf7
 sKMKMg/G7lWwQD+Zv3LoMuwKlx5P8pNxQlQSmzQROhjDZSF7RqEnDdXTcvpLkaJFPPSANuiQLlozGthu9jOB5JHQOLo/w1W6TrJTeU37WhMcYg3bSRxQOxDXgGBi/Pqvh+pcrJROvbb9y4h0KiTmtN66FwZ/JYsrc9kd9ZUgJ2orpEfhndPmjfVtESarnj98YnCvqbZjQXlctk7l+FUCPpUHWhYE5ifITyR52Zbcs5fmAW5+i4N8rp/Xeu7RTD8/E7G3Dsw/krufokGnKDvMhoPA8ck3gduTzpuZLE1nSRWVCNXtLza1WT3FBZXWSyku/vRtI1QnpTNnTGCLqtEOIJS7XPd6GjGmLk3K1RdnF/G/xBAuSLrXTLzpsaatUaSoAXzgEXfJ+GWkz1xrZ88gkbKfTtxcu9YuVVZHTinCZHXdEGbzeLvUU7NdQjaYAwMqkBEkbwPsNq4ofyTgszg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tG+4y7dXq0CRyeeyf9e5DJCZV91kHohZaXW3Z9Ffw3rx/WOKuNd7tPLaD7qzf6iKqT+EC6+CWp9q6jDDUNpytDB2OJ8JBqybg+xoNE4LVIlfeRRxsPrfDmhhWbtObZxNtMQVPThLMXJTfWbuJfKGP1VkrFVXRRvFSglj3lKgwuz2DLdjok6ED9pMHixeDy3D2pqzIeiJCF6zprtV0FlHcBkZ9GuFKpzUA5qRgI6vBdklFq/naPXYItPn+y7sR+Zfp6CX11bQujQlPmSvO/iGkEF7wP+vk5/z2tLgT3x/R/LQ+xi+tdkpA36quyrHFj5THrPA+sK5tR4+eIQ/7eniIoeWcNZwOo+1DygjQR/sxYKRbu/bPOYqx9P/isSbO7P5GQALpzbp5THBSuuEoxplE8kSjmx9nQqtLn0ei+Kt6uee0XNn8gRf07A4AgJ2zZT8VoKvymfUH71lAxoDBXu6slp/0XF/z94OvYDonO6RYyl82JTvu81dBZIvSVX39tQPrPcSy9vICV4IiAhtwvRvsIfck56KtYLwcG3UGDUfJvGGT23w8THP4MBPiAVGnecBBu1s+M5uYOdESdpechUH3e5PPwD2oogbQ8jrFFpxeKscaFWHwhmwEWC0Ntyfi9HZ9V+6Hs1V+Qf890Uo+icbVRp3ocJg2kRiodqknQfNAjFIxjuLwKfBbZeLOXqz64SZ9TMFivKoq3z0D1xWA0S9jPgVHGZjOdsIcovFvbc2KluhDTUPThI1EjvMCc0Rcs1HhLAjF1rP/28GX9mxehXhkG324DaLL8UZRI5wrJhQFvnkaMOVT3Bghd5qyZPbM6zDnjivXBftzPqfYjFoaDpEvB820xNrrNLsfageywcnMGuPikKtNzS6fyBiy/KigbHf8sTRNhJA54ufbgn5eg7YKqHzJs7pXO1PeiszhScSpDzag+XPP2JLd5sI+8VibAjM
 0G7yVibKjspzCZWescBYh6500MfruqKv/Iyd1pTzBaVDlUYwU/VUobBC2+/thElLbalB1DB+x1+sS7BGlKd7NCHR9aPpmjjtwIo9a7oZHadccZF9SGgl3QahRTuhsWmLVZImS/xW8dnWUIBL46+a205UWJzxtaoDDrf6vhIeWUobpgErU8IJgqEFRKLVj/EB9/aZDCuVTNHVdWA9A1hTbrTH4l8w/hWvyeJEd6cd6iID8YtlyHYjR6CpzcrknSmfr5FLZFHuRJi5kEJLzV4KKh8uAMig4YaanVqE/niDzUfp8u+/Oif2J72ZzPxsA9vz+jqL/csVfRQQs9+VZq/Jrx7UHzr8pCLFFhTj/Dgm8qcK2q+lLX/t/X2RE/C+bWQkY9ZRR4u3JkCpyVeWq1MtCarqIeyaVdWGrMWk3Dbw5dVRHn1QRN5lFO4E+LC4fQMx3hSZ4OYMyNqTjOpeC1avTyw+DPQxwDVRCbJaVwDVXaHvD8u0Clw6RH5VaAhtFp/mxbE4i47Qej4R/ZI8wcKHKGIAKomWmDMl1f7XxHAA9Yeps236lIk62MO5Nb83IKS3E1Zb6mHffiTZLedD2bFBWsXRzNV8mzfp+2eanqJTlfJlbnZ1UQr/7AKOvjAgPpSPgGhFKbJYVx3SNzDGxuxeWw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b998ad41-e969-4308-0ab3-08dcd19e9cf6
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:43:54.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi+dE+Ex49HAFI+RljkGXDPfv4Emtu1nilNlIa88VshU/xnF9motSu4Kowtuyy0VfbOSvMAaDfXrIjccn3cv1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5061
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
arm64 processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/arm64/Kconfig     |  1 +
 arch/arm64/kernel/io.c | 87 ------------------------------------------
 2 files changed, 1 insertion(+), 87 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..cfb1c729c9a1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -140,6 +140,7 @@ config ARM64
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IO_COPY
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_PROBE
diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index ef48089fbfe1..fe86ada23c7d 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -9,34 +9,6 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
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
 /*
  * This generates a memcpy that works on a from/to address which is aligned to
  * bits. Count is in terms of the number of bits sized quantities to copy. It
@@ -78,62 +50,3 @@ void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count)
 	dgh();
 }
 EXPORT_SYMBOL(__iowrite32_copy_full);
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






