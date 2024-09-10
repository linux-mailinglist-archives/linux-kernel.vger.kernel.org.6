Return-Path: <linux-kernel+bounces-323175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A69738EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9921C24F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0F4193067;
	Tue, 10 Sep 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="fQcktVDU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="VdBgqKsm"
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48040192D60
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975847; cv=fail; b=kHZk61r1r02SAm6GkmcBrA+xA56n64LM/R6aiN179xanGOeI/HbV6fFSm+Py50kDTp6UNIJzRVlp8zoYhtyKaH3mMkUNyVknmupVRQzqUsIXvvSoJIyv4apFbesE1nZaVYV0ekG1z0cRifVcRweQDRwgZrxUn5v/XLkEkpHRa+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975847; c=relaxed/simple;
	bh=DlBtsP+yHL6mWeXFHedZo7xJcnsxHLkO3HTJki7kIVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUCVHU3Bn4zrInMHQ/KSYQVQRIO6ZHQWMTa1E7jV7TlVEOtOUPTeO7JmT1eW6//10KcVBc6IFg5IAUaiq6vfSpmYyiERLnWSPEkvA1Zs5janeOlArszWwSeZG5Z1hZi8JTN6V1WkoxnVLiSK8hUsK79E6vPlM35rjs+x+1wF2Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=fQcktVDU; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=VdBgqKsm reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id AAFC4349BDB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725975837;
	bh=DlBtsP+yHL6mWeXFHedZo7xJcnsxHLkO3HTJki7kIVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fQcktVDUB1BUiO30SfUNITvUHDlXDUPraHjkqDB+gppdzgfS3gCnnmCUQWFNMjwtR
	 8WQprMt4t3Cu0nLhDiehR245fBAe4ot7cevaLtu8RfEUg5AXFWOf7oNyYlBFMDC8NL
	 9uwHhQGn6SisgRub/PifHsyltiQZIJLCEE/80/RM=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 3770A349B95; Tue, 10 Sep
 2024 15:43:57 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012051.outbound.protection.outlook.com
 [40.93.76.51]) by fx409.security-mail.net (Postfix) with ESMTPS id
 5A5CA349BAA; Tue, 10 Sep 2024 15:43:56 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PATP264MB5061.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 13:43:55 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Tue, 10 Sep
 2024 13:43:55 +0000
X-Secumail-id: <3127.66e04d1c.595e8.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0iW5ef8Qv9ht03x8kbt6pIXF09AQET2H6Rr4mXqWqrEElj/k9UKwcc3zDg9BQwYS8RfciIlrAnkGBH5XHWVeh2+1xIaEtv9K30Rim2TenysjsTFLkCBqwLV8qWn5SQEitnRA+7ZHSAHC0x7DT3nz3UOw1BqX0uP1QFwj2/Rt/rNVPYXOu9RbdIrn62QKHjBJDoLwInFJg1OPbX6KiGi6z78Ob88oZd7AI+D/f9yp4M8qnNcEXFLtHS6hFt//KimoxtPH+67wt62wB2x8RHlfQcW/hn4M+/ix+wZRLCO+W4VobkYqmhkIyGAZIu9RrZ+fNBgCDWFvCylX85vRfz5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DveJr7zsBccpWvAJKIk+kTDfNX03apt1gxEBBsrHIOA=;
 b=BX4n0bl0P18O0njNRqfzzeSz5H/Xrp3aCJuM6SjLhsqo1ORnuzEwgDHrYROyPwTgNNXW/wqFl/qRf/UCIgctJqjGh3V+jkpDnu78JI/qoC3jLFqtV/ZUG/21etrNjLuHxcsHgKWREjSTOtmm5p6jkNEE3Nelw3ad0rnM1P8z8pAjD1Y/FWyGh/2uTuo19iAFGcoZIJ29PuHYrM038cOujtibFXkTVzHR5aqvzGFGwgyd357RF4LKEECuRjEvmiHeJJi0pEaSx5xDQ7+Jqo0gfK1E05Pbl31e3SzTMd0zL+GL3eRE17q/JxNAsZP5KdP6jpZc6YVZ9tTO9T7yLqUb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DveJr7zsBccpWvAJKIk+kTDfNX03apt1gxEBBsrHIOA=;
 b=VdBgqKsmy8rvfyMmlKCVk66K2VOjiqlMiZ9jYT5fz584MJiBVqNb3iV2NS9CR+ZFNNCkmEwaF/c4ak8qb7IEyKZ4Aa9Vv0IMCpn8SE0Xq2079ie45SgDyZWokdeBBHKOK+Ej/5lAjGj+Y8XVk0cQif6zbkwz3tTSYJ/3Nx4mMnDL/r86vM8HKUIVJVDhWZ4EP6egbCzq6RhKBb2rsu9RSivsZ7enCVMM8xrk4gA9U2QVKLGbJ+5V2UDM1O5wDZCaTDbj0QNMsmvRyctA1WJ1xnHWRUAomE2DarTKEZkb6dNvz8hvcRkZCL5WQclhIFQ/fgGY2JNyKnjpOst8z/LhtA==
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
Subject: [PATCH v3 3/4] Use generic io memcpy functions on the csky
 architecture
Date: Tue, 10 Sep 2024 15:43:40 +0200
Message-ID: <20240910134341.2537407-4-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7141727-83c3-486f-3c53-08dcd19e9d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 5pVqRklXPl9xv1mqn7umFca+wwcYCi6cGihK1z7Nc4e4FW3veCdVqxDM/mqVVYSB9Ug8isyLnnf3xXglgrFtRFpWeBbgyemRRjQ5Bf3lPuvXx51o8oV3QK1nP9tyuR2GxvIjYAgTFMcv816D+0P3KvST/LmlUKwtbaBsbczpzd4gpNK2xB+oOPJch2Y82vxAaFsQ6yuHNSsQrFLY0CfJBNO80yu5CGl4UsL9Y5Db6L4WG9wuAFOJzdbEPeanihGnC8RcnybqHU36zhnu7iNs9Gvsg3NF8hNqwCY4PySfPqCtYhSciyAZlCtplV7+qNFl+wipLeCEpRsmIW3FyFEW1flid6bIt9kRx4L7MhK/X7evz3zXNxBjTAPhHtWSYp6MdfrnkAk2Hpc5DPy6cjnH6vCwvbDuNj//BRIUVDS4kPAo8emlyIAXVMLCnrcBiyJg2A7B4ddMSj8O5ok+5Kv1MWMg9S44OFH3IjNyCYWKuayUuMgujP5c52qi016Mi383VUG4kOsKTlIltWODFrhd9CqMa6vdedALKgYTvJy3qzPwb8tEQUinKe5s+UcZ7S9uJSd3RhJTHMij4V3p95r6RWJKeKrWDxezF1knx0x9zDIXVTn1SnXC36du4KN6V9lMU36iiErBItZcZ6zNGrX24McivJY2bZdBE1/TsDd755Ly9Wu3dBaw46JDklBK/VTuDYDn7nBfMRGQn/ODmQFDsRgfUf++5gwx7WqTvZkqFtN+mb15zDH6m1Sj9XHJoVC68YKliUrgdMurZZxgq5Ip/Dwfg6bhY60FTGug7knRN+v27Aij385w8UU4uDeD1B9fw7SbwX/XmE1+4cQWl35v58MzOvbxyU6FwPPlBtDphyBU3F8HmYxtDeElhptieqTSd5gQAaIoA+lJeQm106aDGbofCSNWiONxZB25IcsJvk7MsBS9e6dfDIj9PrRMWrW7aeG
 ofWjWWdcoU4HyzH7u/7SlShxDXfvJYnHaO469wG6CxZ2CkEfz1Dot5N5C6f9t7WqLOBtXoXwH0fzOTukiAruWsjXIxLBU8qFzize1WAe9NJcJZZUQTthZV5i7N35AET1h+ZquZqTd66YoB6dOu9rufiT8+seC9aZQUdRR7xmqxSoQT1FVKVXEuKE+YWkAv0rJKB4ZTFhWhfKLpbk5X86OsZNjZYPUosTtI8QZcmIvryWxMsdtgxy2s/CmK+bA3AwNkLLXLz2L5it6GZSZnD9DmZ7v2Z5cTPuv4UAGvNl/KRvPfqRp/1iOu5KNIWy04aL53wA4diax6Ha4Kus53EluJrFmqsv7N9MsMGLdgHroSMpqvDn2dK37UmropTGbdJpNIwAfQ0pTbrP1XcIVIX8hItLfJvBv5PuymA+ey8cKZwIZ2WY79u3jDDImnEOzBiw3Qu8Xxkl4X4L435OmiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WWLKnpkSPQxtey6jv63VxngUX6A/v/ERmP8KuIxKU3vmWfI3oJV+BC8ca7Ekfj823nGtwsayNaXLh5ch9siw1LWnhAXZNHpt3zmFhrBSZ9rXS4k46vsraycS/R9aW3v4olYtV90aZT+0eIsUiY7Jc5B2Ns8V5OKPT2PiWDlwmuKM00VskclAFDWcHtD1l9o/rW7/q1NgrrxUH9NmJNiVVYdC6XZAe4o/duX0Q2+QvUliXiINShzN4zbh1B1RNli9jZ2w2BJfip2SGsbupM4rSCn8setWPT3VDAc/feIQmnymtrUTl/viiH93bjbRt1CEmga3fmd09NK8eCPgy7F6Skin0x7DbxigPDxwxOP0ptX2A83OYQRPdzMOGeHcLlwlIs2RhZ422ZU+V/IDNT08oBU/RxI0dY6FyxU7PfRR5XMzQrfvvAW8bPstLzVZybjNX+sHpPHDRslDsdFjdnDaRYUnYUNsAIWCsK6SmxUG/oHXFHbAifM/wQtBnd20agxMJM2WIRogR3YSpdysERr43IUbbPZoDlPWt6GGcbrbzRKvNidu/JwI3STYmiIScn/u5ZXql+y2pTDXg4+Ocwgs8OjwXMDfSRXws9pDbhRu2YxV/kZdJ+Dnvn0ANZbx+EVSCP4nRSj0dFWVI631aQAj4Bx1DOTTqeDaqFgykM8IQPcPKB/PG31XGbgNwpOvxzGqN38g7BFWzlN4rmH5sFBCQ9pFuLgqFDAd581DmRGsLhaPqkM7DPWpJhlO/CM9IbAzWV/j/ghQO5l9g4sGzfK4/lt3AhQnnNGpj3mfDorA9XMvhoFVBycCbsq1z0j2CcBI5BvPvfEWUysUvEqwfAUbMd8Uz7PysGMysHTqYOUVEV96KijyXMsbCDGByV22/Bgyq+JzvKcRqbiguTNYwSK0b6R1+1oI69Bzb/l/joQ/bFOheOW7jdv/9yqtG+HMo+hl
 p/Ww16Og452kPx/K6nePf4wWeUzoQnh/Pp3OHRhep7dgm5jqvUeip4MG5MelsUt3M4uE/QFxJh396wlv1y8r/z6KQuJBCu4XUMl2yY9ZDdkKxb2h0XBXiR3U6/owBTWj00BAaWVRq3gacX4eiVsMt99zvd9loGFatV6Mlu7C+U3T0b6+Am2KsAQz9ZKnRIAJdwGL32fJ9+b428/oDiesmBXnN6zCVpn21NKIKgm1G+7ipEMzP6K09GgCIOnixRynes9t9cwTb+7fwIm/m0JGkcGhT9wKz+O8CbywHEPF4hgf8sLCTpB304nzo2ZsyodxYjUrnAK3OFD435qpMQY2v5MNqDxQ5uCRivKcIgVm6WhETfUnXh8RgF5Mcyox/4q7AHuQoYCkEAk22VxbFwKLbF1jVbNo8CmeyTHYPAI2a7ZugHe5zMQOwFTiMzKDFw2Ys1IcLPSCoayyKwPF0TNyOcSHnn339mS2P8B3x9zPZbI1gDwy6WU01aTdKogO42oj49cngAboI+9ToOtSvzY/In+YAUNdMPzVn6b2Htd/ln8Fl0ia8wsRgAZ8NrPGef0eN7yKT5EE2mGKt5xyE079HLg/2QZefKPgZS3py73qlRf7nQx4Ebkx7Xi6CwCZj+IvqHt0/wAlNCD7xiaf3e2xFQ==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7141727-83c3-486f-3c53-08dcd19e9d4b
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:43:55.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADHzW/q2cd9N64XRBp7Kvdi+f5FO3N4PDndLjTj+JRN88nq8mWnv+Vz/NiGfhiXKtTdb/ogp3V9gWdH1at+TTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5061
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
csky processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/csky/Kconfig         |  1 +
 arch/csky/kernel/Makefile |  2 +-
 arch/csky/kernel/io.c     | 91 ---------------------------------------
 3 files changed, 2 insertions(+), 92 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 5479707eb5d1..59d4051b2a83 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select DW_APB_TIMER_OF
+	select GENERIC_IO_COPY
 	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
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






