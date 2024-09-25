Return-Path: <linux-kernel+bounces-339141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4F9860B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0EF288B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB51AE86C;
	Wed, 25 Sep 2024 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="PMIHaVzP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="QprVEam2"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6081AE840
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270686; cv=fail; b=WXaBfKTEuTHA8VqD85XgQWHg7Nt41MPtfBgsYsGcigxXnMB8DAqNjIvh9BNVA18vXX2dXXAjUmbRvEo8xSQNsquMFNKS1h5l535u2Sx8k8Lasz2V/hPXALRwrtbgs5jMHekcKJlOH1ga0+HsZp2wBqheT/m4dAu9yPQ60o8n1S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270686; c=relaxed/simple;
	bh=zXkNG46BbYzpGMMLDAN/iEUBb17+6yn1qe9DLsAMZnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JD2Fyrh779BvtKEsbaC7AlqrDLWpGSVXBBdA0ren0YdiDDUK1oyIxdJMFgSPm9lxgD/0yYLWtvDOrD9n4UALJb91RQHkJnyjjovKqg5kXsqCRBsqi4My5mzL4eD2yXlMxQnJwtxMYHB3s3ogVFIp9qb+A0BtobRNFoauegysZdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=PMIHaVzP; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=QprVEam2 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 48F193498A5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:24:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727270678;
	bh=zXkNG46BbYzpGMMLDAN/iEUBb17+6yn1qe9DLsAMZnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PMIHaVzPKXOZlMS5qT9o+rYBRDfUvdw8fRucQls770n8Ch8HXjdxP11r9v5YRSXiS
	 6fu579300gpqmLLUYZmxEnPterM/1XS34B3AazzYq024sGZ9wpgEGHcWinOtZRiqky
	 BbT9tuv331hVX/dlgJc5dfXEE1AKVbosyVyR3yFw=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 0B7B1349843; Wed, 25 Sep
 2024 15:24:38 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx601.security-mail.net (Postfix) with ESMTPS id
 6B421349608; Wed, 25 Sep 2024 15:24:36 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2543.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:24:34 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Wed, 25 Sep
 2024 13:24:34 +0000
X-Secumail-id: <ab3.66f40f14.6a381.2>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgKuJ56s/mzAA05eOIPF0f58ROOdpdoto90aOc6GP0TkOr5iuil4xt+UXauaEnxPOVeOp14tsRb1l8QUYFgf5P8JQj4rRcOKDQdJoNvwRv3JU8omlX4ckz2nd5q3t4YXiOKwGy01MD2io9Y/wFE7bGzowmCgqlLnBHLEjtGRwXw64PWEM+b/6RhbLUUEIxrRsaePLnKhCu75wk0NPUYYDFrKIzyGhTUJ7acz38tqXrm7wpQJ89yd0QSt+K6G56wxJAQ6nTXneuV0jrZ1rVh+Psx6rKHQZY4+LMzMXVPPiDOUex7bX22UAUmcTCK+1SX/pNIE9U5JvuJDx3FXs9V1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kreMTXDFdHxSgKTqM10ticlVWn9TtfUGl14nZSZMwg=;
 b=HQxTFkqTJ7W0JXZvi5XXCYqUxBcLa0efejjCzbXSnBAJsUGalFV+wS6KKaXEVta/ndaSZrYtnL5591R9krAZ1jN4+/8kIKGddAL/hKc807F1D/MVu3agSVt4LyXZUHAtHYJDLIa+ZmYAry7LLqmItt/ch1L9m5EdhfKhA9cbnLJZC3RKFxXZIMnsnf3h/30XvB/qZIEW8FgC59h1E+3d0CRvmnnnGMmxCIKE9oqG8rXtBfTfVQf4UsddIKK8OLppTGfpuQ7JnoYhzNDbkX7mSNpBGQ51dLL+hTf3fc8j3KZRXyvRddJ8nw+VM36aUEt4CpI/EblB1vLQDaRIzDRj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kreMTXDFdHxSgKTqM10ticlVWn9TtfUGl14nZSZMwg=;
 b=QprVEam2YGpDGd6E//O5RifT5v/XpXNpHx3WyigSRqmGxQIO3a43iAsBEyKw6mW6E/NJLQ4MV2XzdgldzUKrz21PcD9RHZcW62oWkJdoK1I2Blxx9keGE3z5SBVfv/pqDaWj+NVp+jC/AcF+le5W+mnEmKttuoqf2yXuFj7sXVf88bbJdiz1Ha5zv1KrcYf9dTPK+2jwQxX+zRHaOf1Xl1ZOvms8/inNoO0NOiS4sp0agAEC6sZQddoSq8PkG40kOblIAZwWEx7fPh0m9oDkgLZanv+Qhjo9jGSQlFxB3VvzVM70gW9arHmT3ZkGa+2T/q0KP8rQiP8ZIp1xbl49kw==
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
Subject: [PATCH v6 2/5] Replace generic memcpy and memset by IO memcpy
 functions
Date: Wed, 25 Sep 2024 15:24:17 +0200
Message-ID: <20240925132420.821473-3-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03de4353-0b2c-42aa-ed59-08dcdd6565b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: xuwEcpuXQssjt4Uy1GJ4VRV5zv0WozvFG5k5T1K1FAZl6Z2v7UihvKAEEIRawn1KWZEfzE9gg7KZqCU2thd8VHaTla3eWRd9jhp6l/3V2czGiJuFhm/fYOpblC7FrpxJV1NQAAcE0j/NkfabMEXyLIw88wukhk5FUPGPiglloPOHrlpPqBfaCoYitM9lYvV38n4gFyZMLLc5oZaiS3vtH+anPZsc0gGekNxgH0sMAFaaQKbrucy4+CUEG5FadnF8nDrIEtlhViPUJB5E60C0MO0aztam5Tm/KFk2iSPWR5x1kwRoVqPJrLMaFO54DTKORRetV8DENNwv2iK9WhJgIYK+EpyKopo7QAkx/uWudpACNvGG4Qk0HIDWljEPGcySlpGWhiXvKR4ElwHgf5NRmxosKXE9eETmrGuH4tff51TfpTjjfkU+KxzwplsslrUJIGE2f14pCk0kBhEZxP3dPM7hoeeHWduOBdSSxdmd6lOyBDa3O+ZUvoQz9HdUdaZfsjN4OaYxPGr1dZMMtgXjAgJlRmcWrkFmBVQaNuReUqrhwBX8NrG5FuO4Jy9mgOLEFPZq35Tt1l+rDl3+SuAsO6y2Fh4bsgeV2Iqi0gbIhWCJ2bvki0fTKX+VqYMqpyBwbEK56OYn2sZkjZxWi+M7REQQ/o9rAsXdVOoXW5o1MAacf2J64inKy49ia3s6Lb+6UI3YnzleLUHf8NlR5+9Du9vjpIqyDHcgOzRA5CEcI2yRGQRPWJF9emJ5lD8t75NIejo3F0x/7OE//3n5/BkGHLyQ4g36yXbr0xQ9MBdNYi00sI2pZQQfxRyXm6c1ICsTHSzVpq1kGW8Uoiu3PAQtcc20a9dFuP61R0+iDXSCqiR0RpEj1sKKso0gFxpvPDArt/CrRd/dk5ucPsY+kyX6ktfI4grwdRvPYwI/xhlMQEO+T1k22W/DJ996AQv6gn0jqyM
 yQdk2eSOdlVAMrX6t/IaZ8ZCJr/kCqC3OvRDlZrzqhxf9Ok2sIWk/p9BPXZ/5TkyR5OQkf12/hY9NH5f1i1ApOoydlGwp/o03uUtyw4cObWRl0myCD3T/VTsldfQtHH4DCAQl2kg8no3S2iY+Ujd8zHegLNRkHzsgvtFX3miJkPwtBVDfjaLRpZOuqOtsKP2TP97EMQ0bmE8Zz5ax0lhFtxmyVf7XmpXGEy5fNItqIqpWbI7xUzDb3VOX2+QHRs4nq0GdPBYBIFdbYnD+1wUovBSEBQmIqilTyDHzDG0IckHAWbL5UH1deb/wQSDFxHWmUeEdX7JKQExditWYZvbXHRIKCDyiYh8jhIFuUWpFis/LrH6npOdonPhSR8sXhJ1+XVRNR9iuYGaCdnMszPYdWDWNYAOEoVFvM5ATfPGsvEdWYRZmgeh44SPnRDgCRHhFJ0lQfQTT7UFyNEBhTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XuYG9tyQyQNZ6YjnXFKCuFHq7lFA78XTyudvLh5GOqLov1tRJjJsqQVIfIsxaTlqnv0moBfR6Wh/n21Osyn506PmhqTjds6LEIfO8v11kOqnteovczAR+3Bh+tSn8O2v3kQ2jEMttY9U4S70+K7gDjja7ZohbK2y+7ajCNvCDABkQ5Z5BCVNrLrWwQ+v7abS4hX9/OZUfA3jHpsbjWzfM57BWdAOhup8ULSmG2kAqZLmxjJD1a3VfqM8Z+sX90AcpXjDTUjNFVti3URlBQhKHMTTSXkdYNafI5kUXM/C3ipGSTg/gFqaBRN+EnqcDm9t+W5+HERq7p7EtwxhiUatva9BHzcRwY0ukNEUSk6GnbXIFLR/KXva2ju+lO+3i2R4e2PrnIbongfcu6T87EvmpVjZbGJSJp0zw1pGKwC+orAhrSnO5cgmnuFf3YEAj1pQjYchr5ZGJCgFha0/kIgKU+FaNWPmUXkNK5Cv8qu5MAaxVoIPAIE3RzJObbUM/Hg9KAZ+NWo9wUwFsNVLD2Pkyv0XUOvLYmI1qAkmKbVSKSDoTPS6WW2/R5GJObWqmP4U32n5YAbRsuxhHSoL2zeg4ZyIhPw1NUlWlQaHGhOfJFf3osXDH8D7uE8ffaDfDuRZDpyoFRiSFENFBQWZgrq6QCM4HlxL+dZuC33L+y4VT9hYnF7TmqH7dK/ci4VDS2O+AmDjdbc4VZt72DJqfhfLSZpHpZT5QuMrcFf2MQeSTM29Dol9AOEF4K1E5TTiOAnJFd8bXDBl+pF6mNpIskIfb37jzY0B6R9fdvg60qOa2iJtkNAGEyXD9IQ/MW4vM7m8fRtdBnxIO8OQcTYKo1OHBw7LBkFie6BBU0Umt83we/drAaPbxVtNdsRYKU6Zr32TLZLbq9H5RBuKZLEWQdqyncdVDQVPc9mF/8ZdxeX8NfOYNrPzwddiM1YYWMbruwbw
 8rOJmOL21XD620K3FJf1WiduiIl3bqIYARG9EMNrnovZ/EXpoBOv7FtEnyp3/cmxqtM5vJQj/1cvl3VCJZa4cKe7DIhq/iEl7JziSY9zAz5iCXhReHrwRWmpjcxLy+cOJ8D83hnIOpUjm8FIgNRGKbkeQxKUztZ1owcVXerFr+AAv2Fdyp83I1xtL8xMNqtp12PokQoC/o/2BhqdI4z/ok8s1oSiibdhgKsVE7ez9/0PyWzwn9cdVxos53oOYQZw3NKWEVDFiHFwIntrnl2HNSl+kJoOIby31W0QJY/Lcp4LOk+3GYexMGCBHvsJgVakjrLDsIDmSmcSXqeMwKJr0XSnfKWUtfPNCJZP1rbvjK38pc01/BC2BnbIXJG9ud/dsMwn2D4loVbb/ElaEE7WMp8D6etngR/+bn51+iVQDpVKgVKZzjpk2BFwv+usA9p/69+ntdv69ZjqkQ1LQXYPWY82vSd+ITNVfWV8Ejclpd+cpFcVDzu3gIRwOR0HDkFRGingjqpqp95hL5PFlw6PXCBSH5eMe7Dv08yYS18eKft3umSI0rjx6+whvZeFi4bzCFSdIl+MOjik4X4inID1sQeEocT7ybH9RZNvIWdKBD7NzxzBQAZD9C/h2S3g9rCn
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03de4353-0b2c-42aa-ed59-08dcdd6565b5
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:24:34.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdcAeQm46hRDCCjbEjnnC0dfWlr0k8JgMP6mSP/432qmfzQR861vYSpqUfkdi5VT+EjfM11o7THf7QHE9gSqtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2543
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Some architectures implement their own memcpy_{to,from}io and memset_io
functions, because the generic memcpy_{to,from}io and memset_io just use
memcpy/memset.This commit replaces the generic memcpy/memset functions
by IO memcpy/memset functions that respect the given architectures
alignment constraints. So, later we can get rid of the individual
implementations and use the generic ones.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v6:
- No changes
---
 include/asm-generic/io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 9b8e0449da28..3b7deb724a2c 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1175,7 +1175,7 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 static inline void memset_io(volatile void __iomem *addr, int value,
 			     size_t size)
 {
-	memset(__io_virt(addr), value, size);
+	__memset_io(__io_virt(addr), value, size);
 }
 #endif
 
@@ -1193,7 +1193,7 @@ static inline void memcpy_fromio(void *buffer,
 				 const volatile void __iomem *addr,
 				 size_t size)
 {
-	memcpy(buffer, __io_virt(addr), size);
+	__memcpy_fromio(buffer, __io_virt(addr), size);
 }
 #endif
 
@@ -1210,7 +1210,7 @@ static inline void memcpy_fromio(void *buffer,
 static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
 			       size_t size)
 {
-	memcpy(__io_virt(addr), buffer, size);
+	__memcpy_toio(__io_virt(addr), buffer, size);
 }
 #endif
 
-- 
2.34.1






