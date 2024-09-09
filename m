Return-Path: <linux-kernel+bounces-321489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EF5971B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496A11C23011
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA41B86F5;
	Mon,  9 Sep 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="il/o1ZzM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Y/uqCQnA"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE641B6525
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888906; cv=fail; b=Avokf8JyWR9jZcV8vKKhEvPT64KE06G+YkPeBnPuRHF9epeQNIIb8iWCYp6iy0BGMubt86tEvch92dxXLQw/okTZikiq55G3gpCQgjpyibjaKmiJyInk1tvlOYq4Hig22R5fM5PB6yVD8kIlA9W3YfKaMJjUkdMzzeBnQEHAXvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888906; c=relaxed/simple;
	bh=isZQ8S99cmzWBeGfBCK3nOpys6uiEhT/93Z9H0zmZDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1/NAKF0JJA7t6LFcEgL54ihXSr0L99yUirxE8XsDsQ9TATKZmQCxSKqNtFDvw99FF7TDwqt21W1wbn+JURzD0uMuUfAIaC40Yu+TwuOW67DynS5FbuJCRzBM/r7hHdCEYJr9rYYG0orQOqjJ7P/YuZZQB5oZM5/yQ+fGj/zWiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=il/o1ZzM; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Y/uqCQnA reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 24876322D05
	for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:32:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725888734;
	bh=isZQ8S99cmzWBeGfBCK3nOpys6uiEhT/93Z9H0zmZDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=il/o1ZzM03mdSzuqu7xsa3Y1TwwtA5zqBho0TsgWwjD0XELBj9C9BQ1QEkuCmqkR5
	 70+9VgQR6Z91ouL7v7bnQzU4JyH884HafaCOJ4t+4Y9weJRA35qmyOBan/6+JKUtx4
	 bHfcB/U1ASpc7j6pel/K1JhZMdiedVcd4D9HTyJY=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id E89EC322CDA; Mon, 09 Sep
 2024 15:32:13 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx408.security-mail.net (Postfix) with ESMTPS id
 44AC7322C79; Mon, 09 Sep 2024 15:32:13 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PARP264MB4655.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 13:32:12 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 13:32:12 +0000
X-Secumail-id: <349.66def8dd.43827.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov/Sw4qJUsGSPz9j8P/EctN0lbsDXwCPINa8pUL/w4WAY7WL4C4XX1cKnQRfDoFWriLiOdHl+e7mNNLMldxeD1nrIN4m0qtDiVdl0EQC/Tg1DB1ucztDbnkBCyWVN3RmVGpOHhOzURldxjWziJpzSvkvUFG121YoeLfHBUsO0VM/2iI5IC5s9Ry/IklVoPv0CYVX0l4y4XLzRXDVeD10I9A7CQCYgnjOw3vJake2QBxuRiO8RF8GgSFaCl/DeAw/2Iug3NazeRCbmnL4gqVwb1rEafpcvE3zWu8uA2DjJNC5eXTvKjE/vbdAwFRCoQDHfpjl+pX/PedM7hEue1MCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFX4Nbl+cIIYBfgTMBFIxu4xXP0OyUcfQnhOLMiIhEU=;
 b=KQZVSnvaWyYgD69ESRCWA50axtx/AjIDnR8rpga4ip+FSFPf57aNxZkS3/LK+j3b4Xr3OJ3804X/lvdZe76dM/B7NkkfnqeVDCXZpGbjUf4O0aNDkFxPFr4ade2fxwNy9CxqLIK+ddIvWcpJDJNrzeaygUsVB2G2w8/buNgCcVnFtTxF/1gSvGDCiocdLwmEt55Nmzt7ROBIRb6IkmJTNI4YDmt8IHy7lPvjKis439XqnyI+uLox8j5oQvAx6c3m3NPMzv0spfIIbDrZSHADrAyFZpt+PPoWo3f6Od43imYzEhMlijLAme/1F+xLyPPOGItRutjULHJIJHXOWDB57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFX4Nbl+cIIYBfgTMBFIxu4xXP0OyUcfQnhOLMiIhEU=;
 b=Y/uqCQnAdv4SfvXpTB3Q06wOrpynD4N72chqz8VVKaPHyvTwlkUVorO1ya7qSzWyJgRdUYAz+tbyP30JjzjqSKgnxVKz4QA7RIzL8lpkKNLMyEqSpN1RSBaQlEMT8zd5T6UHmcG6MAxl3eqWnCUFzWOfl10hG8oEg1UJCxUCH8zAPK8Yl+zK7NBs7nQm66AGf8sAwZsuJ+gjFvp8IMNKS6VAmm4aD7kdFnq6ZkMbPDBq+xSkfhdBPmjDZrUypA8feP9Gp5QJnClJFRz/dRJ4DAxCsujFJFoXdvtSzlbDKhnnAXzBOELXE2dDQxll0D/SsFv0GaKd6WcC7YKspzZLLA==
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
Subject: [PATCH v2 1/4] Consolidate __memcpy_{to,from}io and __memset_io
 into a single lib
Date: Mon,  9 Sep 2024 15:31:56 +0200
Message-ID: <20240909133159.2024688-2-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909133159.2024688-1-jvetter@kalrayinc.com>
References: <20240909133159.2024688-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::22) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PARP264MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: 9915a7d5-7d85-4edc-d4ff-08dcd0d3cfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: x4LeuOgNcz4NA3LnB/wZBnnG2yO/dDQexXT8aNVxjI/NnwB4pmGhxVAVKKIhB8T/3kHvuyHD4wHuIklu3Qs60upid7D0KNVSuE/ipLHzYtGqDg2zqdVS6BhxJPoGIkFcVAbyzokFv2WFPRx4zHASJvDuWXMqjQuFhdTvWa4D6wyc4KEdNQldaYuH09XZQq8qxDPfrpfktjfC2jWfAt6PYCkP8wuXdKu3M15cZo7qhzb9icbpbz9NxjIcL3lLyf/mCySAFagjOZWJS+tm6Iwd6zSWrLKetnKycl1QKnLbTQeKMQDn9E0V4+vbeZNv+mfNxnnqTzIKE1G+GMil32vn/ylIAAOSwHgQeftJYqDP49elQklqhI7TVkR8Qa5bQjiMEx/nqhb2J6YJg6DqI4m2vf2EPtW//MX3Un0tWL31SKtm3wjHhLlJjyRkPIbw3zZwYdQtr/UYRIbVCcJpDa8DBnRuYg6ZSl7edLFiIifi97iTPsD1JuzhSZMxaBEqj5Y9E5Puo8y/K6+mZQzf4SlQhrAphCQaE7WHlZsduGk95mpKxX+PvDwFM0yWNlkhJFEaRPS/OZxWwdLyWE6ihxYUSem/KYDJCzBFXwD6HaJ2YcpaUjrKFsWI09ZEw5YG3UnnqwhcqxKY+ll/WU4z15mzqAmJzjPilMDPjkjMQwTTBgT4krCM51/troKLs5Z6cw/Hyr/rnNwrQW+GOAuA2oCzfdEd0QW3bI0OLNQ6CEa9fVg+lhudgRj8AH+I630Zy1+O/o/3SVzWSh2SiOpyIm2kLnvTjF+1dqbgrUZDQ3Nkh5PVpK6TOcZJaaGjYMcocyyFfB8QxB6uBkNFhdF0ZMvqNjFK0PP1PPDfYYp+p0DtPheCU6n+M5nfcVh4CRwZ/SMg5mptDY4fvm6uJHZd/U2TtBCtQZv7R5Gya/cRh91+IdufP2V1yozshCsJh8OIGQlQwvG
 xJC2/mA5Rxp7GsbDoV5cYEjM+Z7yVzo2IuHvlv7wxzGaNILq32W1biv6UcgSK/bdmfItGpfOXwUZou3cnJ+g3cKyBexpK43JN+rFFn3Mwt5a16ozBReL1lqzotAQAom/8b+1hltQg6kGKJ2e0fwL82SNEAGqcaFs5Ap8ql+wgDSXEsu5spj0Qug8zO+SJGjFilqVtggjT5KshDtvFhwHy3Po3RKE7HUnkjxMkNQoirY7IhHufaBJxWSi6DG1/YOM9hdoxgtOshtqe0QIl5CG8Cj1Cr5/FlXTMAuFBOI8QCyBACI/fJOHMrxDwM3/CTFqB3gHXbaS/HqZMThAsYvlDhOyonZJGuo2fKvYwRr0dZDmozwRjGbE40MjRQtCzKVTOU7lqOzfQtdKgEowswzJnVwGe4g4W+LHYdMxwKDWG3alFuv3Z0QqRVFhkBLozpMnLHugA4QP+IGh6dVfk5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KauLMa9y4jpBDHrhjEGVXb+I+kHgU/0Qkuk0dowGIidgKIR5KGzlO0yQsnRK+Y3M/vqwi60lh9D8A3Yo98XIOBIH8q8ZbMrsoHNn1KvNIGJ+tfqkpg2gEaAgpP1h01eN8fzGW5vewrR302RmsSKojpfFG9QRdAVRkhvejpC5Rs6feu9Pip8+C2M7XQuf58e3ccVfJ7YxTexYt27gZfBnGKkZhyHiBfx/QbOU975+ys7Og1mm3sQg0u/w8CMID0OVl6hf9iYLdeNZTn1BVO2g0Zs6e75kC37OL71n3xck2hsuO8trBsmx+c0pgjOXPkYHXAC4D4AgHnlCWI37uuBHM1wg5P+G5EFSqAHGvWEqBsc0d03eL8ep1N5Wucro+u5TN6yWcueWsl8YpX9HZmyaseVauLGfXFX59jxZGHOp5gU7W7vtvoMjwgyUnyWElf4yvOTCGWGu7qWETBoUKE2CUtOI32QoD0upjDAS7vOqwaafeP4rb6vPIbuNIXdK4kklwJu/n+UfA0DkONGshHdzWpCDuMr3K0l7obVr3embDJFwx61sQyBRXAtUVNvvs0KwC9i7BU6uxds7W4WHSuOeAkUz05heIB7banWmE2d/feygnjndzEDgfApVwdqoc6ioaPuN2PMKZmmqX3rtsI7mNVcRiHYBAA3exDQwyV7TSwSZcGKBGFvtrrPF8g22aMM3OorvZuMFX1mli+pZpZHxE7G5KDwDdNaVVpSMCzSrJ8sw/49Fj+GkzMUedmGbrETOSdYATCmuhcXIkcWE6xOCjvIBvm7ifVkWRLe/iSrFHd9lUlcnnPRthIMY45d+kkp90SljelQ2BoOjaUbZyx0Q1ljIWrFmdmsy+VIQfL42/+v4j6v8vS+/WK/Df2VEhpyJv9aYvwhUWgdGoP1W/lyRXcf3S1OV4H2FKjK1Rc106oM5qHkkLpTD1/j0yESl1FhN
 SRQWo+CQpHYJnW7cuiFVzdd09zogzHVCbzZP7qU+sMv5OzqFbwyVLoL705Of507kcMLTd4wG9PhMhDghwqNuAFQPz1TTsHoMYDl4xxuV3SuERGVJAZBXa1wFlFGBuQtTp+LhlY+KhZCyi8eROZ+5ju7XjsgImPZpH6/5x9MFpa+pp4+YnKtNhRNg1DaoroLLhKvoM4M/VUPlWKko6mQI6I3NGUQI7TGRbWRwI/IQ4LbmxAIUMyewz4KQbFsd9z/IDiD9P+QtsYY6tTZuQzTBnSRgZMTjY9rWpeVQ2DullluXlermkm4NR+65AcwbYFFvFg+eAqew9Zg5FtOnok8r8R2J+8zC6Nai0XzL6136hm2uacj0tRAPRUMCgqqYw9JkvRPN3hPFVPDR4S5luqpmwV6eLrwmOYSp2vJuviwiMjGPSHGofvf2j/pzKajGonyupTafP8M4qkfg6wh/9JrPI4y5dl18nOoimA63YAJAeD6IpK7j+J8+2LH/D6ans00gtfcO6nKoQR778IeT06TsJmG8Wsz/LBKJFK7qODracQZi6Zqg4pPMroddn3QOY3taG72ptYlv3GWvFELSp9YZZvsqZVj09lS37N6/H4Iu6jQBbd4xwQ0RHcKIa+0Nx1Zo
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9915a7d5-7d85-4edc-d4ff-08dcd0d3cfc9
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 13:32:12.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFHObUEBWe95lZigCF2GWCcMuRfadhAD5kd3tAX+Z+/wGqhk7cgJh5kIbhWfhiOr0c6UB1f3M3p6EnaDX59llQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4655
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Various architectures have almost the same implementations for
__memcpy_{to,from}io and __memset_io functions. So, consolidate them and
introduce a CONFIG_GENERIC_IO_COPY flag to build the given
lib/io_copy.c.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 lib/Kconfig   |   3 ++
 lib/Makefile  |   1 +
 lib/io_copy.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 lib/io_copy.c

diff --git a/lib/Kconfig b/lib/Kconfig
index b38849af6f13..741550bc3856 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -70,6 +70,9 @@ source "lib/math/Kconfig"
 config NO_GENERIC_PCI_IOPORT_MAP
 	bool
 
+config GENERIC_IO_COPY
+	bool
+
 config GENERIC_IOMAP
 	bool
 	select GENERIC_PCI_IOMAP
diff --git a/lib/Makefile b/lib/Makefile
index 322bb127b4dc..4f56ad5f9ed6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -130,6 +130,7 @@ CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 
 obj-y += math/ crypto/
 
+obj-$(CONFIG_GENERIC_IO_COPY) += io_copy.o
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
diff --git a/lib/io_copy.c b/lib/io_copy.c
new file mode 100644
index 000000000000..bfdb84e87607
--- /dev/null
+++ b/lib/io_copy.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/arm/kernel/io.c
+ *
+ * Copyright (C) 2024 Kalray Inc.
+ * Author(s): Julian Vetter
+ */
+
+#include <asm/unaligned.h>
+
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#define NATIVE_STORE_SIZE	(BITS_PER_LONG/8)
+
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)from, NATIVE_STORE_SIZE)) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+		if (IS_ENABLED(CONFIG_64BIT))
+			put_unaligned(__raw_readq(from), (uintptr_t *)to);
+		else
+			put_unaligned(__raw_readl(from), (uintptr_t *)to);
+
+		from += NATIVE_STORE_SIZE;
+		to += NATIVE_STORE_SIZE;
+		count -= NATIVE_STORE_SIZE;
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_fromio);
+
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)to, NATIVE_STORE_SIZE)) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+		if (IS_ENABLED(CONFIG_64BIT))
+			__raw_writeq(get_unaligned((uintptr_t *)from), to);
+		else
+			__raw_writel(get_unaligned((uintptr_t *)from), to);
+
+		from += NATIVE_STORE_SIZE;
+		to += NATIVE_STORE_SIZE;
+		count -= NATIVE_STORE_SIZE;
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_toio);
+
+void __memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	uintptr_t qc = (u8)c;
+
+	qc |= qc << 8;
+	qc |= qc << 16;
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		qc |= qc << 32;
+
+	while (count && !IS_ALIGNED((unsigned long)dst, NATIVE_STORE_SIZE)) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+		if (IS_ENABLED(CONFIG_64BIT))
+			__raw_writeq(qc, dst);
+		else
+			__raw_writel(qc, dst);
+
+		dst += NATIVE_STORE_SIZE;
+		count -= NATIVE_STORE_SIZE;
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memset_io);
-- 
2.34.1






