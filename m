Return-Path: <linux-kernel+bounces-318803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C6696F390
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2CA1F215E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20921CC155;
	Fri,  6 Sep 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="lvo6GBf6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="q9wtiRsK"
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8A1CBE87
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623406; cv=fail; b=XOel0JlEVHCvOlESmOODNTAoYu6ANaQiXzEwssHX6e4Wbf3E+xxMXV3ktWCkBAhcagxVveRJnaeQjl7xZPfSUumPX8n/CBG2KenZLUJdJAQ0Yq4AXmdbL/8/fl4X1mxBMYrYEiZ9gusR+z9+x1TSNfCNSLssFzo0JH7VIyH4AjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623406; c=relaxed/simple;
	bh=U9+nDY8g39PXw4DtmuwHPasEG4a7/1rvjM/Fqb4DP08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSqDX/ZcyXJJRC+yqWBdW0HPHwspvuDHdidRNakLCP1IGd8dhS85eUh0ayLblrxL0FJnNOLHTVmpQBtjRU+UT0ZIgc03Rhk0lokX9PEi6T6kcYQlVrnNBL9Gk2jaTrxBeZ4JpfWiomUglThV6HOgRzy3NixoPZNEMQMsMeVqmDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=lvo6GBf6; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=q9wtiRsK reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 2666D30EB53
	for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:47:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725623250;
	bh=U9+nDY8g39PXw4DtmuwHPasEG4a7/1rvjM/Fqb4DP08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lvo6GBf6NCF0smJw2bsR1BlUnDoKq5zsI/FZQqQzvpJUvt6q1UzPdwP23ddnIVyM9
	 NQ86t7VeenNW26mVn2Es77Ho30+TYluPRd+YIh75PbITPCR3jSvmjD9+TuB5HDlNBs
	 Bdt4X0tP8bLid8qYMSrlOvjY/mlFcArVhU+Qtn+I=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id DC46530EA63; Fri, 06 Sep
 2024 13:47:29 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012049.outbound.protection.outlook.com
 [40.93.76.49]) by fx305.security-mail.net (Postfix) with ESMTPS id
 17C6930E9C1; Fri, 06 Sep 2024 13:47:29 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB3466.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Fri, 6 Sep
 2024 11:47:28 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 11:47:28 +0000
X-Secumail-id: <9222.66daebd1.15d35.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMFoi6HaE6iH8RVZRAuzXBu0QudeNVceCK7YFGXI/coFi74B4LfctECvIKDvAKf7xnPthd4sXsQx7agOip+TbBm10o4gkGZMfz6PS6qc1Yly1c8V0iJKVh5T2xBnU5tjfD8BFBZmAsRCSU45fP0T4EOWavO0niH1Nb9rWFmM8kNvHO3+97AbJBuZO4OGEgo/uodFxGq35GA1hpa7VfapG0KoNDEiU8z+/HS63CTd4ODIQLfa5Jn0xgv0UvgyIG3RJnMgBNAZotr0QuLk1o28FKUrveSMzC9ywRsosmFJ6Vnl5J+IvYhZalhzuUIBRC6u2JKNLvSFvb5VNIULC95+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j0A+Mqhw/czNF4nL/vV83T4y27EkGSjAMRLvQaCIPM=;
 b=CDWwyTsPj7LBOaFgquWIaxQGb5IothQbxdlxuUiiq8urk8dBIqC2pMjnP/Vygr5u6W6ZoyaujKXi0DettS3uDzDsZti4/jmXjcICCMuE6QOFiBVBvSx0WbolXciW5jUCAzBm72fSr3WyggPrhtEQvyGVlIOcAyvV+gAkg1HzAqX89XLOJVng5UG90a8I+xuV7XrSc1x6ZNqmuApNUksd87SbD6bgo5D3gISQ+8HjfHjDKNSNanHONM+tcpnmq3/y9m+koyOa7VI9h7fkH2mXyx15X8vTPZB5IifMPakpgXD2Mmvildu0iGjk+d0I3jxtX6w70qb3FC724Dbu/UCIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j0A+Mqhw/czNF4nL/vV83T4y27EkGSjAMRLvQaCIPM=;
 b=q9wtiRsKctKkMm+TtfsHEM4fjzkZMHdTicIs3IBZKKsCj9Oca/prqPxtLVoPxQ8t+6lfSCi78TmMICep+5Dg5xE7/pkjHy5yZ7wv22O06LcZSy9f1XKutJ/PTi0sflKCimxRxGC9y2zwf6EKGPm+K2Y46L8qYYNzEVrLLto1btBWeYX/o6BnCuzYzx3FzsYWCPzmNkA9OwL9aFsR1wgN4HTYEs8ZaI0aijLf2YaoXkJbzyTrEOl3DXt/I+A5+X8yRWNm4uStYJDydgVRGMJrjec38l0n+HQoHyVHws3H2xj3nSQtNfnY5HMHwEGGUQzdTpamUsSdccqOE+DqBxE2Gg==
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
Subject: [PATCH 3/4] Activate GENERIC_IO for the csky architecture
Date: Fri,  6 Sep 2024 13:41:50 +0200
Message-ID: <20240906114151.519028-4-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906114151.519028-1-jvetter@kalrayinc.com>
References: <20240906114151.519028-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::34) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR0P264MB3466:EE_
X-MS-Office365-Filtering-Correlation-Id: bb11cd3d-ca50-4d54-4565-08dcce69aeee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: AhLWn31Xngd9hQv84TsdaSCqLwi7n19bHlAwg9/9FCacEbRgBiu1bTJMao08wXtCXU8CpOZ20PFn5BZULNbK2drDeyI4wCF4X9uKijF6qo3h8t5fR6wr5Ps9aVl6Mx+pzj/R87R2ekjRiGooEgyUVme3qOOhA1jAWZe4SE3t77e+ZChjJGlzwX1jWXw80mj5C47VOwBQv//gqsulPKmNRMBlh9qylwjDWQbn7XdxdKAcOJtVDOMQya608L+10CM+5dOj3IALY7wjh0fvyKXGKcPdQEpLMxA5yVh6QNoEowL4cPQ0dmGzSPk0XUr+G3+6+xkgCtPhhC7f6rqE7YaWCz9c76Ph00GBjccPSTDYdkzLgV28N7GBagrdVq+ORkebH4wjCmGzddMgiJl5Hm4Xi4DGy8Zf4J1W82qqC9hIQgQ3/yvWHJBFLaCuS9ctHctydTkXO3vKuS7MYmott7vR6dKoydyCcbzy386970tUrxiDkIsPmfEHqwLV/Of6axuRx313uZaO3MT/eeUqxbwW+iRAe31QxJUg+wi+PyqLxiGJOnK8XyQLgalYXeMzaZeQF0EDSo+Z6TQ/4L/Q1VSw2Y8A8L2yWO8xq9iMWtrzPJWtMFonSYiOZW1DZdOi2C99s+ZP8WAwhJ6AbNLDZ1f9hi4J3JGy8sF6uNI3zYhWM2054S2FCJNeDRMVMZfKTqydM+ohcvMSExXY/doGT283l8htVEGhDS1QWWFC6Wyxn0pFLe9imyCtFNCP19SJyeDFJQDZT4nAJknPlk7QJiIC5h2/HPhse74GHLUDDoSsb6GofbLXk9DVU4oA7gS/fQI1R1DMYUV0eyAsCKv5C7/kxu3582BuAuIAMR1lzLSi2mCa3I2fgZAZxFVtlFAix2+Q2M5V9plag8ARhuCSXe7T8EMc+8oVw0HPfhM56UxRhuEh9BFfR4N6Yi1MDggMUz9PwA9
 nQ98R7iiqkEwH49EsWK1+b+z75OWF44c4YvHd1gHJkAwtSqQTNRgYDoOVZwnSLk7PkBx4GO3KQwNACtynUcII6KiY1qR87YXqe3h0A6eEEj1U4L2/8v6Nk0xqCGYi7OPCyfKbhQ2wkx1wKO5SGHyUpp1DzP2xsThRaVPn1LP4JfXfcpakxB/6bYNn3uoKk7jJFxgyTG9hktUqW4wnujZsobTHwOAVQSdfFHu3lB/iTtfS66D0pZrOsW9AAhtKtdort436NdaaYm36k/oTBN4MhgAl35tAqILoP4sVni78pLJUCMa6eHUthADPE6qesEyDkw0OxwG/aGDOZP094HtSZbeYmjiSiunjG0QA8FIAkQGdO0RuLQIApB1tXxz5AMMTBRcs+Q6ic0mMjyZ15Ddc2zQpStd6wGBtNQFQqw4wo6dulLBMp7MmjLKl16uJIU/I6xLhf57yv1iiu5HmvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dkVcrK7H65xdDv4+47cKb94vSZgjwF1DMx7zlPIoeh2sNoCNtrmHZllyJkM9xJwqQv/Y6/v7R/V/SVcMWbXkG0x+fwXSXF5sP8EjAuu35iTViaJWpRyay5kp8VIEdBi1sGrhkxC1J/NfWnvJ7rsXH/T2G3UOKF4yAoV+F/rAtJc9Hv5RRuQUegG2J7au0m/eUiknNawnM9m7i6ZBdLTdNS3or0s6p557DqWSuZKvlnuG5STTpm1Dr+AzB33eCtlrea3qTxIjr1/fF8TkA69/0egLN8cxePVT5lihsqAgLsYQnbw7n5GE/ewx9AIN221h9xyN3w6CYy5f0rBiKq5j3X5/fsdwTP9uSjOmdrp9Trt2lA4HfirDs1ytoU6uJkfAyhsjUv6L/1u5rHvmbaIY44z9c3ZtNQIA46klMordVakZ5LJfGuN0F41zsehQHLP/WubukUsEr3GjDYYAvXZTYykBaXE5DbYJ5rBu+MKgBAJkm4lK+eS70nKH9L7lxZ43bQ0FvVuZISukvtDRbP6sQUjrTCJ+iW1/uUzW8SrnhWLQreuKnXrjbahKvGtSHqywgEyJV8enuCHraQYv5RPtjbdA3mCCAOcirVBo3Bx1CkC8OTsMevy0OdFJg7KwNZz/JXpnu7W6SwYne8alsWznZopbye35DZY/R7Gih5zp9KSCT4MuyV8XDWMfYdcPGxRE5/6rLLOOwto1TP/dHYjS6sz5pFREsYPqCwGPxWm+eEIT07t8VMevopel3AA4aWbCDOKSF40xZuvGr9cqJHB4wu4SzaAlbmZtIhBFQz7R1jmbbnkSpU5RTKIBh9oifqUir3dqBcgUED3IEqL8hll9BTODBUAiCr0X0KfYP2kE6kXFM91HWSHRx+GlmZCcFguc77cZnPaUmhNWQv/arqIuqn3Fv8B/1wPQVvsRS8bcIP6BpPLSk69wMk0LLEt36Yi0
 VsJJ8W9Z+cbqvEN+HLB7IDfmgwYbv9KxzXTSjzMcdJN/8YHW0b/aHj+yH2y/nmu3i+GjcZ88jj4ssyOS3P/86jduDzihGzC32qxG6laUKf07L6PmLiIiAV+5BVCOrTeojkcROrkPpo8LxbR+/nA8aRt9vdSnn+nZ18XFX4pAo48gWPlejqt0Ni1JCuDKRYPWNTf+S2mSp69RuHy9vRe028osfz7ljcpcvZj6HA6qPShTPA6zB8Flv8N2xvTmKbvEmhrt5cBFZ6Usz0ERfqZmcjbSlfW6c8khQqJNB/TVCVJaHRk1WAw3zddDKkCOeab8su7PpqTOLkrZxOV6Sz7BQF95cbFEd4F5cE9Q2V7IygIMk5b+KnPkTvm4co8ub+wEvxbBZeD1FXjTFsy5OLN6XrADtXEk1Ph8BT0p0hn6Szr6XjHMCxrE4qtZAcynBv/hRP3MTqZTJFk0Tzm6A903Yabi2HQe97U3GM5k1GLvqUkqZ3yyrNu1/19OrJD1F/jhq3LYLuNdGHZBjktGw8NLdUViwu7moJEX36pp4OL13+c6xNZtt2kSJBj70hGPvXUu0JryTPlDo4mNkGYT20W9+OmFh8qtNiJ32wAlJ6cNdWTrHLkG7daDS7/0aBXD+L/L
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb11cd3d-ca50-4d54-4565-08dcce69aeee
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:47:28.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyJ7nCprp6cZ++52UV/pBRJ1gFlYfqiFzPys3j+DbLnb3sdFJBebiLmBCdBNRdRM7ER2UdmUdBKHYWyg1owwhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3466
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io for the csky
processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/csky/Kconfig         |  1 +
 arch/csky/kernel/Makefile |  2 +-
 arch/csky/kernel/io.c     | 91 ---------------------------------------
 3 files changed, 2 insertions(+), 92 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 5479707eb5d1..d64329b691f7 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select DW_APB_TIMER_OF
+	select GENERIC_IO
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






