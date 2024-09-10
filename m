Return-Path: <linux-kernel+bounces-323176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99B99738F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F77288190
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C7819408A;
	Tue, 10 Sep 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="mYipa70a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="WhXoSmv2"
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9E757EB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975848; cv=fail; b=LnRud1gzFYJHKvtGegkHMlFQ7+j1iuXFL7L7rjm4TNRL8VF9rr+g8F7MXGiDqdUaFGNDjfMeKDm5njBsyuvjxMXFIjLF0kOWWZ8Ab4/bpQh/RK6tQIq4GUhL1fcWgHmkMMe9VPnJP4gcR4Se1BlE2hM+3oUwh+O0VR5dc4M2cFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975848; c=relaxed/simple;
	bh=T5uSHgkmAwvTJQWgMDrPyQnAF/YeHQaaCcpuB+cWki0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT4uedT1F4ZnixcKYEhl/7LUFpWrkpBALJpw+i0FHlgJsuIRB2+25YP62HUo9Ct5ajgCRA2yEBJG9ZQ96o4Xt+vIajJqMZLCuyva1htSc2ApLVRScFqnydJwn7GbccfsGYMX5owlA9JecON7R+GGVuMp57cPScqJe46it5WASnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=mYipa70a; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=WhXoSmv2 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 14409349B95
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725975838;
	bh=T5uSHgkmAwvTJQWgMDrPyQnAF/YeHQaaCcpuB+cWki0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYipa70a2IG7vadNXIKOHlQFKDKLCRjlb2vCtqKvH95p4Lep6L+edmv+XB7cRdEur
	 v1ZMI0mNvxi2IS0CBy0vLfEtDaxBfR2QihsWyRaMRg/3QcHrcWsI4kj/QUaoXDX7K1
	 TKnX2L+Zflrn+KzTQXGwQ2V/dZCpImmz+YwW11W8=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id AE6C8349BEA; Tue, 10 Sep
 2024 15:43:57 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012054.outbound.protection.outlook.com
 [40.93.76.54]) by fx409.security-mail.net (Postfix) with ESMTPS id
 9C119349BB0; Tue, 10 Sep 2024 15:43:56 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PATP264MB5061.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 13:43:55 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Tue, 10 Sep
 2024 13:43:55 +0000
X-Secumail-id: <5c5c.66e04d1c.99f26.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iY/CnXQNA0kpVy5vT6749zsuyxBDqtoPfSmsTETbaoyqWTH6hrDq3aE6EVnbGpWinmQ+gJRPf01acCnBuiyCMj0s5NbidQ04a9urfa/sL0xsAtKjWSBr6F8LDthcp3gN66ivfSPPxFibQLKMPby1/bj3VM2n67E0Is4CfuP8FjLmuvht3m7dby5T7QEIL6vfTpYLLPAtB48hfWLGm1cSEfH2Qpb/MsQFEtlrNZX7dd14g3WuPA/zIkMhZuZVLDjIPlpF1u4OQaoGPEGYHT+g7LGwh0pKW7kzwd+i0Q2KcIWjdiWQEsxFm39tcEA35NR2MDhHsWEBFduOMjSA60abHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap33tf5qZZ62I8NJEWvBds9aSZQ+d7OzAL26H+fuCc8=;
 b=SQeBuWdrkC9DFvJ54lKTKVHi0x0h16MiPBOZLlyY9xmIuUKymoPjWgcON43tXyr6OczFIWXBoPEntSqqza8zbTly6OApRi6L+L4N6bZ3m5qUdc3jQhdyI8/BXRzeIINljlrRLWOYszbz8XSWqFzHqq5yAQunUkX0vtzAMqJPpEVIMilg9wdilVwxnYoQQH7c6YLcq4H5juUv4LC987E3RfKAMhT5krpb6oYJ7ZWjzKKugX6Ho/nfBlaXHPtPRF3rSrhSY6IjNfJT/7f/3b5lnyG5GhKEGU19hss9VoPyO/JKS4RMz/nR84ucn3QVXKQXr9Xlg9offQHezo5xeASJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap33tf5qZZ62I8NJEWvBds9aSZQ+d7OzAL26H+fuCc8=;
 b=WhXoSmv2oINjv1nlmLY2xHkDhEJc4Bg3KE0QdGmwiHO4uu4nq6wwAJ8uOLOq+FmTsFpS7+HoMQjzK/LoUNWwdpwWz7LsHysmf1xP6v4dIkQDKdT29rx7rlabNDyuZkjDw/HuyIACqpCnXYIkKIFx6TxbWChzRPs8MahRSf/KpHj5Dqb9vjdjC0iagsp86x3hM6VwwIImVhdtxJx6IpJ5CPknjPKxfaX8qp3cv4Y0MEezCkFcn0/pFR3CZmG//S42teJHOAhs+Ab76JIxuNuAz04hus5op4hNw386QLh40FJQjNq8q85yCkYk5qPBXC/FvSFh5OuHeGYUQfmcPNixBg==
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
Subject: [PATCH v3 4/4] Use generic io memcpy functions on the loongarch
 architecture
Date: Tue, 10 Sep 2024 15:43:41 +0200
Message-ID: <20240910134341.2537407-5-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7155bc29-7126-4898-eb1d-08dcd19e9d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: hQwnpjhyaATbiDwk6byBbcRdFjG9Yvnhy38N1jyDF79hArHRJw8FsAVpLoxBZu6fIIsGYj1AZ7ZJuCDYkPgiWt0eFvwMt1QvSEAgNafkJchl5QH0Hg99G8vPX4a0I0Q8lv1bDPVc0zjFXCdxG6lLaMzScrueb6lsHIcsjg5ml1eMgy2JM2rbDOjd/BXlnS1mWtIPGfldcNqnMFWXeZyN4mZ6qE/2Pbq4QdlzUV5LxNXZGShTD0VrBX3uZ5NCcWm81ea55sl9IXcVLgP7VtDAUX6jHqUEhCCOdUmgjzYBljRAsuyQByo+gp5g6dQtriIKCiWSo4YX4eZv4xpS8a5q2Baeg9ar3w+XhCFx6x05sVDsdg+6bRwlV5WmggxtXgMEgY3Huu4q46J45N/wkTWuS4RgjUZWR7Pb0HValvLiBRrifLHiPksArEvMpxm2TTAtENCL4tpMK92yIbXulAH67qCCxeLIVweLs1xw2HVNkW+s9Bwri3tCwf2FwkIxBfY9WyeR3kDrL6JqQd9NPKFhOPHkAaHHEAwqn7RstACJp+0ZbLnxh6YmVfIzM5biA7VFxz1Q5sC/P57SA3u5JG0jd2FQH5H5YPmgw2RiAObVPzfU9hdTSX86QTeLzDMk9fUpQsmZx3R6HLey/D4fAkBgcC6Yo0nDbegAP7yv5OiL3edHagvdTp5Jn9Z/9kCZ6rM7J0mGUtKTFize/zabKRNbrBwRB8xLln3Y0TSmPRKBZNKGi3rB4obz11mbC8SroDSHbCTmIrQFQFhPxBeq8bcgTJBpOBZDhlatkljM+YvQBnB5XH+4Vts1/xG5V/e4VR0gP2TlWeoihzemFnJmI/aRVyuedszIfsS/6cTtUIE8VO1ad49W+Liseb6dP1OA1My0GrLkT6ORIDD6hb5lOaO4FH3j9Z+A0ZXI5/JGCIKGpWHE3WQfWFZ2mDcduZN4IWE6srH
 EmVzit4TnPJXJTXoJlF29/7r8DP7J8AFT2D83YoATFcdwfw6NrrKrrjgmq+epeiAZoUMIsKAABTwct5D32ibrR+eJxqVuNchVnbfJ9iFoW3mmWN7Mt0ufUuhd6mnEHaa2KHaR1WdwZMpsmOFsMtKNjmg7cHBOxB1HWNYU4yuOQozy4ORSOvsFzRt2/LClR+qHObUrFRDppAVknRvBS7M6v5zPddVpzbCVtM1Cwg+AE214/THMA0BTsfge3LkTPkrJ9OdrAuHa4AYA1Kam3KSoTcee4Un1NHFtJSkQWSPF3yNajM+zX0Jjm2RdH3be7hU5HrxjhLbCjbaZbJNvNykSQ6/isgMDj3UYC1nBe4F7MPe4B6AKys2EoCHY+rAEdu1GLaE5k80cylF/AygCo9idtjNc7mtSG+t8935rqY6yIawPX7TEcNcFOsgkgMhNMoYffZHoWLeIMwyVQORxFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0VmsLK8w71wwbwOnKlMddst1O7DVYK7CKLX5OUYNH5FVnXApmGzTeseWMdSV9JknylRQcZVh8TqOBjsEID8CtCBPZo93CxHPe8zQGe+S3xIx/namFoDZn1Rmd9rCRcRkwa5CMy3AJYY+M/hPuObYdj2vwF+L0Ns23y0815I84zUxOht4ouHIuX+wj1wWrzaexw84zLJ+R3WnlGS2i6s3bwuOFg+mtENVrJhE393FSlP4VKkva917mFZ5wAA3bKskowgycX6fphXNX6UM/C7HUSyySGJDjqRpLmF+KsbTBpP+JnSHDaqTc0F5t21UvBnD16BbxtQbtxkFjhvuP6yTS1VIvPHYuuA2M/UiBYs77LzY6eMT005qIjcb1vFOBNrZ9+o+VuSURF18dMhBK2SdgybroIGN1/rM3WlQcue67cNCL4/D4m6RhHim37HHeT+vVc7aBXGlZ9XlFNU6Oj61VWiOeCSrp+Ot2Zvx04qokHmnxe79Y/LyvegOf39yTtqfaJnRy8r+6MXsegqA7RI1i9rUOdFW6RvSBjmJ1Me85zEz2gQrhHm3oU8MJI79ZSdXXhvm4egFlMMiDq3JD2ZYuOO6aVcHUZiYMrlNQ/haLnfQkRv6FvVUn9cVZF25vGZPFGqVVhAbrnF5+dKakRGTlnhLjDfsH86/YZ1Tbp9POYhpQcQLi0FlYzolszfBrvend4caMO+BgKgM8pwCFv+GZHc3DER459K83h+CdHcMzfnLJ7tqavbxdVlY5NggXQyB6AukkQjaArWDvajprWlnPLPpzhfgivZUiP0UHi6GaTP0YZGTV1K7v3x+Qw1O2v+zbzaqTz9QmYELT7C42joz1xnYh/PbUF6O+dVJqMqGeR6bi5XnnPxoV4WMvjRjXBmnMVTVvsLIzmW35PENCyuGa5mPbfivTB4x8JVNkKpOt2PsqbuUUV4pJvDd5xIvmMWN
 2w0aEdxRB0eGdIB5CFsCbWSB8CDFZokKkubskq8AnNMD44bGIqr6uPIrepowtY1hm/jDyeHY8jR6GsBPiYkxtRqsV9FxpDnm8/+D8MT4OfUpiSupH0pb5zXpHcVahI/Z3BAXGOn+BlRwxcnOEjBroBxFUbSZwkbCCXe0AymzXSQh9nCTxjUAhDVloIcLBPkQnBehADzI3ZIKQcpyXJCLu2/gMi2hnOZsq0hXJj7c9TCr0qJKhXD2YxKO+/+sLvAlubmgg3sK+AakzRJFyY0LuY1JQ8f5bbi/Q4jBbf2ZLbDdjrWWW502zrqyd6STG6QXQ+LLtWE8JNbgOORmVMRls2fAbfWYmN5vBPp15r7MTZ0mnm1+3bYJRHnvghWF9gC2z/SczoBq6ZK3CKxU7Iu9sqq5AWU3iqloZsxAdJd0/Wml41aNXio2ibUcOVGyi8Xi4mGGOGu5vd6iibgBIE7OtIcqI+hOZQrIMwYO2s0tSfqcmbPb6M3sicWIVp/kX20vvknAHXQ7GnqBrNmSm79UY7pOCspOLPwoXp+sgj33la3Z9PaecH6RyNMbLjvX7VaWH4YJ0A8ONpWwTEoIF6yXiwQD87wSolvwjNs3locuz3u8YRxmpOfNapUSfvnQwXxDNydWGZRohPoHgwaGZU3prA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7155bc29-7126-4898-eb1d-08dcd19e9d8c
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:43:55.8831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEIcIPomU1qQgrUzFKoBYbgKNPSvfgOM7X/Z7zq5gQ/dXR7ojOMr8wHRuq6K7s9Kn7HAjsNb4gTCrRsnV7j/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5061
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
loongarch processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/loongarch/Kconfig         |  1 +
 arch/loongarch/kernel/Makefile |  2 +-
 arch/loongarch/kernel/io.c     | 94 ----------------------------------
 3 files changed, 2 insertions(+), 95 deletions(-)
 delete mode 100644 arch/loongarch/kernel/io.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210b52..bc97b09efd16 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -84,6 +84,7 @@ config LOONGARCH
 	select GENERIC_CPU_DEVICES
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_IO_COPY
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
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






