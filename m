Return-Path: <linux-kernel+bounces-339139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F64A9860B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9169C2888B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73631AE85A;
	Wed, 25 Sep 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="JSXzGQa4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="qzX7BSCp"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33618C92D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270685; cv=fail; b=XzQxYBDvcmPayPGIBAUIsFcOc1EKOChIYe9mRJmCiGWDtVDwr/Unp3/9tPz1BDjOxhDse5lzCIYwTGLHEJAEu4bJafXj2CkLwd9ukbL+1+eiS70KWAlIE7xjLjzJbbduWcLn/h58nBu5TfZWiA36eqtFOYRps684BPuaPdH5ry0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270685; c=relaxed/simple;
	bh=t3PIPDgFfa10k7lyBZOl7ja/PpTflkQ69xbt2ZyFTVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSObzYlU0tgLgM8R0/96ysJBTsLbeVI1fApI8uFw2l/j01gAwUBtU0QOS+4l6KLpYIS9GwJOrQ51JUcKTJxUgVD7JxeLbiv5fIZKJxYrtsX7f6FOWALh9HRPORe47U9p/DqV344jjDn820fCSpqtz3+hdFUsP2fvYhp0wlKwi4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=JSXzGQa4; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=qzX7BSCp reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 81810349B2E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:24:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727270680;
	bh=t3PIPDgFfa10k7lyBZOl7ja/PpTflkQ69xbt2ZyFTVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JSXzGQa41Tbc4puDGUDKif/g+ndpSXFJEDLFc9ceL0QFXcqFPfiHfK05h/Aa8Aerc
	 2l9AoDzz865tM4tMVYRIuhPEhr0Z0aW33w3k0I3zWOH9+GS6rMT8IgZBXEIfo1KJeP
	 kqSGrkBhT74x+Uiv+Dx/ZOQNh2SYLjUol/r7muqc=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 502FF349B1E; Wed, 25 Sep
 2024 15:24:40 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx601.security-mail.net (Postfix) with ESMTPS id
 A4FD834994A; Wed, 25 Sep 2024 15:24:38 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2543.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:24:36 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Wed, 25 Sep
 2024 13:24:36 +0000
X-Secumail-id: <ab3.66f40f16.a4132.4>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEK1rz7wK97Lus+KvKa0VB1i9WEcVT/lnbSuJo5gaNs001ZJCDYEs6S9/PkWz6iib1sCPEwo7KIQvswbUyIFpBlRz599aJWLkZErWaRPIxvsNNbQE1f/CHQHDLfTZAIoyaab2sT5IA4VPhmAnLNStduzy0qnCZY9Yd+NGrmQD1qNc1ixTGxwBxCLL5HyLDLxEDKe9Pe86aVF5rjyiFsnDLtlU2Et6i60mWqsMbFCwIAsMjx6KH3W4nIMeDheZuMIGudUSKvlNeK18dBcZiep7j++HZXdJ8ZmZaStnwYD5cTB5h7S4J0tzSvMJt6LWGPD+FwYBDgUFIae2mujGSA3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRQ3rJvYFZmP/8xJmPTzzsu1FS1rrxAq7oKbyf+3BLo=;
 b=gFhU+6QcrQjKgyJ7nSFfxD2u/AHzGRfvF2rWo6jRFIlKRx42nY22dKZDj1OEzwAFj5MKqEEA7nvgg4l5TaOFcRm8X7sHiTCo+GGSCx+MNoy0JOLrseupprPP5lMnYdH8HJ18KEQgFF3V2o1loa6aXRF08Pwc1fg7ORDsJNiF/qcDkab3j0v7J+Egy5H5bvbG7MyWxlqI+z4LlAkTQG4pNrqGiXjfTixeTqZvy/0qrLbfsAaI40TSsLbz1So/nE1iMylojOTmAa9/vjcuocaZ+GtBboUmN/AsI0szb4kznMT/OaDX4QOeRxgAlbVx6R+0XcK8yAjE6jV0R1grCnzwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRQ3rJvYFZmP/8xJmPTzzsu1FS1rrxAq7oKbyf+3BLo=;
 b=qzX7BSCpB96LcQXgt0d5P9gL0dXgAWzKC2xTQZBbRqE9h0ncWEW9Xuzsi1cMTKfmyIQPJjaiGVbwrxpYn6KARgHgU7sCrg3u5T0ntOs7/tGEWFHb1YfIs0KjXyq1Zfwfes8OH37Zg3Tel5nvMwBTnBmvJbUpnHDCcPR8nAIJ3gyHekdCp3xXMpCHeMS2rjFidMsP2ryHvLQYIU7hY5ZCW1PziGFjjK82XbDKo11x2dQJwyJHQEGhY13qBujtDUoZi56WPy5fuHscRyphm64DNpsUpx3qjH1lUZam/AnJE8OIgbho2hJeCOHxd4tFplhmgPO9egToGFUrzlUJdrfC6Q==
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
Subject: [PATCH v6 4/5] csky: Use generic io memcpy functions
Date: Wed, 25 Sep 2024 15:24:19 +0200
Message-ID: <20240925132420.821473-5-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac9a4111-7ac3-47cd-63d6-08dcdd656674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: uJJCPlk0SB/680KuTPX1DwTIlyLGIvgUD/RshnMM/bFPYO/cj1Xgbf+JqKhASppTS8xPmzuf1DkZ0p0M60vfYRv7e2Mpt8ksZYCGeB8rDxKLnzNmBDemXlPzObHPoUgl9ZLRmiDi/EaCI7QD/JWp8NIa94/GxVM04blZYff8qv0HG4le4QmnL0dNzMV93UsvF7xzRJLGBcjfrGZVCan3N5zustapHAKyU4X9ctNkMannxJoaM8Y8qaJnIh2KhxaCQYsTe/yyx6lB1U+rZVXb+H3Io1pTAAcMTSbNAK13jhRXOnSoNvnpkL3ONo69Nn9Uo1pxS2QKkRcdmPDINQht/9eXU9tNEWLMrctvXZuT/g6lieJWCVMXlkLkQwUDk6EtWFQT9vSUa95W4Bzyb0Y0/jGu1OcXE7U27tcVdNpPwBaI5XORB3MGIlU6EuCt7C5Nd5HFDJUF3yeo1WNRCiJDRqDVkza/7uefZM1mczyt/2dUaRHKAACdQDRhUWk3Q4D3ifeVqa05UiARJvEjlUsXQI+68kGVoPHlEN6+R8hDFfFloJdgGVTkdc3jseIrMguUSGIif5v+I+qGI12Q4bVajBcyVYyAvWDKzwMaxpUo+b7vMLGfeyylGcyCWulmfx6yOkjl4ni8xx7bRPxtrt8s5pWX2pq1B4hoLr7zVfHxzYKIeYjZQHKeUd/ndC7RDuXEJbmPuzP0b5fECTJco9IdOdIInEGXVN1boqy7Vk29DoEt+EhL2cBrtYpOhSDQ9iBY92OjZYtRrvm9fNTeDJhMqpYqKvvSC4RDBq41xTtaD3aAs9D/ZTsnlNwCEVIxqCMMdE3KjF57uJDqQKRqh1o17km5maQ7Sm4kAKDHQoZ+iIqVP9h1QIeqk/UcbcAIJUsx544GmRJPbEDfgp6NnwI5A2m/SQiGTsjyy0I9e+g4171/rf/+jcgiUJ+OsNbuhRjldFI
 jQFaMkIK++QzHd89sDhAj+CXHehe+XIKlhLZC7T0q9kFaYcN2r92kXXvrKcJ+3iPbaPYGXnvLwWlZ5qcQO9c0crCa5G17FIJRCeVuGON+DlIyOknqIXAkfghtmOtkpnvRN1blpq087IGz3mFC2zvx556L7v70q0lzfl90nSYR9C7kDDgJ1lANmdg1BIt1ngG/24oGKQ5HDuorOAe7tDAjFFEkGGtRMhzoY1b1V9SsYGKDC4fb3a+yjQJXksZH3uUDD4W+SPDMOjvL8eseaPdXM+VGul9FD9gOi23GDUqbicMRpXaDLJQD7jZm1IJbJRsy3hqWtFej1GshsBKMjKuHopFNX0OA4v/inG7c6Aft0S5ezHzuYFt0Pm3I2dUGaqsAwRvUxrASZqn+LFMpmMaiSJvwmYTyZozyvlAC5/jADycc92OgID3rjgN9o7Kev6hwgwlolQZYl2u0iKCG0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4qtZmVfOOh/wu2dAmdl975SM9KbYGclGXlOU2Z/q9w/IfjlwmrwF7P7sk3lYMZr25B6FF20TcOWKku9Enn37wrLumRAsRx2Q0ZavUzAJzNyoG1NsXEHvB+lVXfxKxmweK8FwClxyghfVT1knul/k5geIqhX5F5R0/JZOCSeGz44+OALXIp5hfqCwrkv/xnKFswH0dY7CVtqXksLZJHJAy2CiozyOAbfWnCfggEvWBic7Kd1mvk5Z1lV4EQOLfPJeCgzRCRVDQwjHS1HIWNUcSnJmk4XGlIxkc4kueQ6OPm7M7EE1Z8fX4fePxnMpGbQCXs+Be6aduvGxD0BEsi1wbdBGcGe83QirIi9vx1e/EoHcDmpE1SHnVmh1H/6E3IHMwdBniE5/rXv0TFD5dytz8J4kq1OMv5WHLKjQJ6gLbMI0Bj8VQwRuWyGPt+0CCIEtIQEkl4ff1AInpA4cGuvyX5+FUXHGvBvolfcrtEIwr5S97+Oh2uOUBFK9f4Q9goNYnSFBMmdS4vycq9lq3hRf19XNRd3OM4AZsDj+cYGzwSvaAym+TZ7j4biuorMc6puDNxSYnTCqeqVnGaSbT852oNIaKgfWb0sp533maFPl9dRQyUT8Dr+++06jGGL49TdSXangfiQqQX//aw9RxBo7Mn5wBzjYu9sfE7o/03wjgdc1YXsFWY833AQ5sehaN8zvrmxbnqNLeik1z4X0l7GwKvoBm1seSTN+beF/CT3bJmsQyojAX175X2mQc8mIRVx2GIrsVbZaAziIL1UUG4BWlN5+KPkNevkxoViRVSBeqrdeGsy9HEQgvRzzMyxOSImhGbX8bGrh/6zX/V7wNnpyqI/vIkaQG/rmIMhAx7uQqnCfwIFC5A55+BwcePCdAYIhV5ZgRqGH4kl4hwSwuEO9b3boDDMeQjxeBh6+tf8oPgVQF4Ft8XJ8B00aKELHkN2d
 Ximejv5rqI3k5/ahv45qq9ILWPxPoqgHwFR5v4hHHOoYmCO0aVPVkjb/bM2TV3AdkTQ78X/7X63unOZVSmP6TCl01PnRUZJFr3zZvRU4YyxRueHkovdqYmimbXIOtf5tJ3GT4XWvGYCG5CwXCMssuOY6OmI4Ia3zbKH7z8mm3g5ZFImF3ur4wN4Ng4k+hU26V8d8FbDSCM8mWXJUoZHls0No88QgZ9yfFPG4fToX0hwiDqBhT4+khZZL2tSZPveWH3rBA5qhZ6Q3eXxqh+VEvndkyWormuLn6UMi5dwQRATyZOu7gY8nezKA3YvYcvn+qtKWZURmKOJ9yQyrpuuIkyhI5xXtYPVmCD0nZNfuBAfqc0DzSDF+2ex0JVkiMThghXFFMlhUtBF2BKFYXXiQmKqY3L2xIF4e7G50Zs005WrlM3tTb3JkKqbMhWG/j6IKdv3DL7l5AbwGGOnmJr1cFOFyMxsfmYOr0zNvkP804UyDjs2mmk0wAGxlhCkVD1TqmOhGLeujpiDw7raoUaKBlFhKk3aFEcpx7Sl88+IbKp53bER6Ot+UBpByixO0gWWJ3NFjVoFeqxLzwamL901ZDm/ZqjURvd5sdPZevorZsTHgPU2V1wQ+ZtrjmTqt4Zm7
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9a4111-7ac3-47cd-63d6-08dcdd656674
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:24:36.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7OHDMssSDe5D9iAC/0psPIX0ITiELyZsDgT7jUsio/hHc52mn3+dO8xptj6mza3JMmqPyxQF5uRSSuVPvq3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2543
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v6:
- Added proper commit header suffix: 'csky: ...'
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






