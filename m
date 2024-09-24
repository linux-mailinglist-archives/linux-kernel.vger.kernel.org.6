Return-Path: <linux-kernel+bounces-336877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708A6984203
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31295285440
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26BF161302;
	Tue, 24 Sep 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="RfENmUan";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="dBnuKBBV"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D2155CBF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169906; cv=fail; b=UmZBx3O26Rtnr/DnGAjbPvcz7j918NFyTZ/mxfqkn3RJ5A1hcrtHo0mv3JT87kFE40otWpyhBJtYnKREP4nuVItc4Vd2J2T0iFjN26rKnWs9b20ZZY6IdrwSfbx13mzcLOsfqvjBv9+dAB+9KXtegtL9FTcY1U3oUyVJGqiTswg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169906; c=relaxed/simple;
	bh=DlBtsP+yHL6mWeXFHedZo7xJcnsxHLkO3HTJki7kIVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1vvIWWWXUuVypwgbbhmHU80ccRDIEJ6lGnElS+WKwCkEd9PYXhyxLcGaTIWfKWeo1gYiD5f6fdFEhI0nUu6GpeFHr97OzHf/r8iwP2pixKFqXrcx1s8qPUdQLoa+q73wytWlaJF7rmXYYsAuePwd/hTrJpZNdI8+8JMD7qpCdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=RfENmUan; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=dBnuKBBV reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id CEAF93496B7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727169781;
	bh=DlBtsP+yHL6mWeXFHedZo7xJcnsxHLkO3HTJki7kIVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RfENmUancePRdo/hd0M8dyRwt1BbuTbp7EgN+wHec2+sVZrbn9PuXoay3uXqp4ctH
	 5RH5jIxkf0nJ7ihsfoNALEoPGemgzCyO1l76WlV2GrC01be2xpftCfVn+t+KtD3DZC
	 9Jf93EBxNh9phEwwXGgM6e5d8GHOMuSCfykOSpiQ=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 98BCF349604; Tue, 24 Sep
 2024 11:23:01 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011030.outbound.protection.outlook.com
 [40.93.76.30]) by fx601.security-mail.net (Postfix) with ESMTPS id
 D54AD3494DF; Tue, 24 Sep 2024 11:23:00 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB3073.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Tue, 24 Sep
 2024 09:22:59 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 09:22:59 +0000
X-Secumail-id: <107b3.66f284f4.d35ae.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqBIvzM50VDRloMgMfvDBh/vtIFonuZOFeZmFt66jZax+YmzH24MhKPr1YURFq11tyTntmUhMLcB4Z3SwidHage/U2QtGW9A1ytIgVZ4Rm/1i5tDwIBV51WTC6x6bpMgnMRTdNhmkIS8aP5U8ByWt/0KuTOFvPXojZcxfKUs9GjMMN9LQgodoi/FsbLm+/pnLi0O9AXk5Orf+R0tRYRE1O5hL8FvrNopEKVNGp0RKaHH5HOXIOiyxcB+C9eRM6EnXJrARWBFUHzE7XQpYerQ7YUiYeASPqrc4CyNunfLEME1MwIHCFttqA5IzoG5AMZdwu2nxWiVqllLLvzMqnPi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DveJr7zsBccpWvAJKIk+kTDfNX03apt1gxEBBsrHIOA=;
 b=yXar0Vf2X+3gzRGO/xjfszRe0K5HxKb4zdsyA1RR8x3RT8nFCfao2+ug6gqyfqRCDHf5bUdfzLpUnOUHc6rU9yeZeRBwTkO4oJWEgJXvOLODzKH0CepcHbrYDwqJpmvIwvD7WDC4GN9gvJX+xfyNIyaUkbK3H4CTeB6urpMeszS309PJfK2GFPRgb5SbZdeb9WLDlm4FHkFUhRLQ44dlKQDw2XfCiE49VwHftuuAU9RX2lBm/UTdBhKPogJ5KUQ/6YsstnLv9KPM4RKQqQEkUytLQ7whfsTDY2nzaEOE/qkZDtBfwqKTr8IOEauckWrd2PltNhXncRUeut5QzOpy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DveJr7zsBccpWvAJKIk+kTDfNX03apt1gxEBBsrHIOA=;
 b=dBnuKBBVGt0X/9wOo1F0BD1hOTrbDBnRiZAFLwGArDuXsaNkndsXpJXBlQpL56e6ca1UvpLMymlGn006+j6Kh8jv6TaN1MOMIOMc5RlrkMX3Pv5FRc+pYzpAuBzPQ1ek674z4/zn4E5T7jb3DaVV/MKEe1C7YfTUkbXcnG4OGc6msYPQi4iWC2YQmJBbA64+V83RZKisQfZiOyacir07f/cgrKmeSji6mN/wZwjdsXIxbZMT/V53vcwc+98s04j8tJMswZsF43PvxRw8acp1s9lzAqukBKDuCeULSj5POvOvgv/yPfDXwTKKzVnp26jIuZPjvTA2bIOtM2g/49v+sw==
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
Subject: [PATCH v4 4/5] Use generic io memcpy functions on the csky
 architecture
Date: Tue, 24 Sep 2024 11:22:22 +0200
Message-ID: <20240924092223.534040-5-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924092223.534040-1-jvetter@kalrayinc.com>
References: <20240924092223.534040-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB3073:EE_
X-MS-Office365-Filtering-Correlation-Id: be752e5a-3cef-4c19-63f4-08dcdc7a7b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: LJknpAN1hrh4UqAiufM+3Z5IHFe0kQVITMzI0hNyYXm6RCHFeM2yVukVBlM116hgbhTESST2Zb41n0hY/WtgjW52iz46P0DTLQSbyEP+4VAPz50SOtpGKHmFATLBIKud3VttgpDYWF0/f6eM6bSW7fAflv/8bTX2D/kDIo4sqfmQnojitkFPRGlWWGREopstfKCAwKQ9zuHyORoA61oLnIijyaE+dOYKqEt0eWr4ywiv7+0k7EbTJUXP201jukGNt4oIEwmd+97ivCpuzVQIs3SZUKGQ7LNKa8YP4KNNWqHAjUV/kAUaIIKI5F7khbm5CeZMdrcylhnn7ckFBMZn/KYHl5e6+H5o0QpsgDIteN/PlNL02NhThVsrrmPqBCRnDsg82DUqJW5MQr6OnKXGYGhn+KZJO2Il4z6tF3ryH4qDjtNEl3AE7hGbvQlNJUFRB5GTFs9iYtE/4CmkpHbpo7quxSH6rYNPgPA+u+TKmrDL1NhMWSr84ZNk9XJr+40Q4lN1OrkFaGQAEeH/w8BaYAhg6m3GkN4yXJIWFjkxi8QPBKDTttOCLwTtigqbs8eIIcBTmnIuO1aNtKC7PR8w7V0v9Ob1dTsEGg4QXCfZpnx9MUMWRXWNtNUNfjD4i1RS7DwyztrvEd4XqqrQhQ4hUVWK/tY0W9EOy7tZWmP7pnKaVQY5x2gSSCF8vXoGqOvABcFmUuuIKfxBWpdah2KWBZQMlw4SlcoJKLsbft8wAATsIIC3bnJPtKyjfIcT7xO5lj4nIZ01GDOK664TDn2Ib2prwACqsdwdiu8ESh3LbloEEMCTFNlWEwzovzWeFjw9r+ih3qt7TdhgKHts8TOdgXkgzy4gaRg6VXtWswu7VFeVzrYHYM7sKfCUglbe/1nGhNtjJmpSh3PSwdlm65hq6xopIbgtBa95BP7HW5O8zy9culS0DItZr3mr2Mmhwuh+hdb
 WGNlKQiTA2KYv4kWdfHQhi2hjPM4ovsaYzNthuViXVAY3+davxaUIyvqmDSqe0MI1zemS/TeXvZLiuKFl+ojnrjbGTQoAyn4JQ438heNakdae2RriW8Wuk4Flr7ZVGNtiBHTah4VvTlUO1W3F6lLJoDByDk8JWsaFwh0RnKs7a/UFSoyjQvCmoBq+M93/MuoURj8aSAFyEoM4TVXvDtOjTopWCdKp/+OnCjiP2H8r1wFAXFfkD+EpyZv0ysC/n2U1QKtLDyzJ7MIkZU9kfiGbHHlY2g9mPlOD5jLx4ahpNHBbP+T0Ke0Y1OGrjLiMAPs9mgn7p6FJKC8zz8sKo4JHsTZEUfnBD3Ka1Y9wPGu6J0Z4hBNzGj+fvPUB7DnuRn+YnAZN3064kUG0qCjBMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dr5JUvSeEbjbMZGuPmoCfH7ZAjnWvZ3Z4/j/OJjpFlWoS99RL7Fuh19OUbuV8eTNwW5xDWIwqtBUXvJa+wSQU6bRteo0WqlVkfMGJD+IWso7ucT7t4sNB8SxV5rwIGk0qkUWZALEC2ZvAnvXo6UZ/zQBu3ssstQCD2O/vdfl8XGymYrjf4NooeVQMzbmyBGa3s7SOpeSIAz1Wu+GhFqRZfMS8LwW9erNuXmENieGcF8XHhxchDA7LQT2p5sCk8uYVqggULVKGDkBv5wIizzfSCJkP4O/QhEpvk1BNxYeuHo+l1xDepF8gkvMM2sG7j1um3urfNGon/kyFsABzrhW42NF5URHEJ4Dg0V5fdcvuXmtZbnMTfV+Vb1QOaVB5vcGVVJS6tE38W0oR95i8nzO3MEvyG1SOUjqDyvBPsM4SuhiuMfoT7LlaqdKzxyCQgDAbbSgdZGotHiAOTOkts9qvye1yfE0ujRj3DVi8p2gymtHaKUhuuvhj94Ymfn9hcC/Deca15U30Czu+Pzv/mn+kdIy/r1aILjT9X+4vNymJQE4pgfVD0bdDIzemjQ9mT2DfvSG0dDP9Wqd8wiRtVCOUd0raRUp/wDfs0C3pQHA2Nd6feyR4sjHhq2fVoLO2iNXC1AP5WXS6RHyHIr6+OrNxbV7ZFF+yBeCGp3mJSF/Mzl+VDs/fm1KiuGWxv3HHOptyvceXXgml91RA91DSaMh2yv3ntfEaEIgrjXgCGVY9aWuZqkdtPo8cDNh0QRtcFwGB+5X84/btx/apGHPtEtref/1mhWf+8tfJEhoKlevp68A/Hf+lB4thZHQqMW3ejOdzvPvRnbneTXKyf+wQVsRkS2vCISbu3LTVtgdZOMii1rYSO/mFf0/FTkneMeK4ZWTUCA6Z8T52HA9p3wTw9DK76xyLkLpm/ya2EAsEyuOrijCEIX/Ong3Zi+ZQa44MNFs
 uUpumFT/4zOezUrTfF4LKESZraM+teb/uJY0ZyAUvQ+PkqraSsGATv+kgctqgARbjq+I4QFTlZspYi4Rev4nKuXBuoQppwbKgzZYCseioXrg9DyRnj0wmAWUzBslppB1o912wJxP8Hp6arOcuaNOO9hPpyA4uXkHqoZ2NlfhZV1vIvTqhD13DFs5GNyI2sveur8x450fb1UGrYzBCipzbnPdUGksMEFW/j+A0cxUEebiRqdXQpNhRqK3C/qIuhbuX4VcMrVYs+u7wri/SdYcr/ujnmahJFLxjlOPIrCrgQM3xSzXCNcNUsIdWeR8slDCJtvMQKhNq6tEPrW2rz8FtJ1lZY0MhcbROMuf1pWipQqOyVpGt0uF2Jw0gl4AqsXo1vV3w5tbF4CGLUcpSd0ecyIvhRctaO5V/R758dmvpyvEi9O4gjAAPazRwr/m6g9dDFT5GTEh/gy7Aix5YTedYqZHfFv+PHxc4rxnXeK0NvD/Tbf3uI30NXTO6JXO90widGn7sRLBx0aIfblw/aMoBWFcvWziCi3YBAMbVN+0McNmyHJsJjhAqNka7xN1AbqaxJY4pvZ1fEl5bi2UI2Yi2BayBIdZE7WFpWz4Re+Hb4LewSJFIwX8HToDWWwnNDU0
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be752e5a-3cef-4c19-63f4-08dcdc7a7b94
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:22:59.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLcz/WHNRXMry78gvqFQ1dzHiSt7kdiMai+QzVhPs23rgJ+h3+txKcekyDr3Qw07tuwyfbsLubi10t0Z99h6vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3073
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






