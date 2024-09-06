Return-Path: <linux-kernel+bounces-318800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B696F38C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD1F1F22ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903351CBEBA;
	Fri,  6 Sep 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="GdBEV7jQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="gjiYLUDm"
Received: from smtpout144.security-mail.net (smtpout146.security-mail.net [85.31.212.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B21CB50F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.146
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623406; cv=fail; b=ot4AGX+fV3Dkjkkao/u+EWeCwjKDp02NHnapVvHBW3LgsnkvDq1w6y+BMVeI1TZYUmt5wYWQypaFXHb/ACHAO2VDBamEx+6dwXnJgO6qgfs+7XDJCjB4RW/6FqqKxsY+2Wdv4euuCgOKszbLm29OyhXwsqu8S2SIUKtSeSfws18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623406; c=relaxed/simple;
	bh=zsz9SAayOjCkEYXsvfYV05bD2nmMvTn7YzsRgzfj7bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKvhjSoyATIoupsFXUVvs+0LSgME9PMlg14zBJ3CowHok1UE71L8Fx/YLAPq9XSXk+dmEc/Ml7Qv4fF4tKnunUwfbhZfvatHsXOYUA9aHZ0/AJKpTggVKY5IHPVfO86TiE628uFyil51nchnLxFL11pOZdhoOlI7h7tBBC+cAso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=GdBEV7jQ; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=gjiYLUDm reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 7015A3498B6
	for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:47:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725623248;
	bh=zsz9SAayOjCkEYXsvfYV05bD2nmMvTn7YzsRgzfj7bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdBEV7jQHUXOHa3Q7MIbgyOMdx9QvvCgsT+TTQSq+oLw3vdkJltLm+rNzHKYkUbGs
	 o+IY/yS1yqRb3TqPBUHci0oyFIJ51C49W8Dut4xu4qsp/p0I8brAa+S52+rnTs/lWN
	 VN/36yAaNzE7Q6MxrODD8/uXRcMb5gGY0nV9UjNw=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 277DA34988F; Fri, 06 Sep
 2024 13:47:28 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011027.outbound.protection.outlook.com
 [40.93.76.27]) by fx601.security-mail.net (Postfix) with ESMTPS id
 41E8834989A; Fri, 06 Sep 2024 13:47:27 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB3466.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Fri, 6 Sep
 2024 11:47:25 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 11:47:25 +0000
X-Secumail-id: <1595f.66daebcf.18faf.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7SdRq+fOuKLe1a08Qg3uWvtFcqWUAo5EybJB8W73kf7pbJ9UUcn0cbHSCg54djEMSi2a0TznGiajLrVabAX7cT8kkYt9Y5ziD02SnI/6YscSIhfcQlEQluwkXnhNpiIWeXJy4ExkST0w5+CPeyXin9bMsE3O2SUB6iJfPvULLRKkTQYFPk4CYR2wG/WdzHwQJyt+K12iQRILFWV/XsVAFEbogm9fRxx25Fa/5jS2gppl5wsO1bqsfuG7K+1t7urhhVPUQmF7Jt16cGvGVfUZfNNaKOUnyMlSQ4MtjwYzT8R7nYbi2eZ4EtAyBcIlvwBi101Dm9KANdau9oyDxESog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su6uqV//aq3x8vFtvr15k76SevvdLy/xrw/uCm36YQw=;
 b=DRS8geCXop6OoQzmmkrsq2vsadyZL892FmPBP9e7uD0KyOSIJL8t7R3KCvQPin9IJYZOL21el18rovLYOLWlCNH252/weRHGBHcdlSLJz1Tx4QrjV3bWwNFrlik45S3LZzX1SLlreoC9cARMFu/0vykNuCM6yGo1OygRseI2KoOciI5+9fdFFk6uY4yAKHGStyDV7BrY8j3CK1D25VUgsn9/QgjyxW4479WthZq1da88byfK91GAAcYs6VUbUQ3qHzeeL+ucQaw8SAA28h9Gt9Y4qDwTeoGoWMYzx16fQzN5IZu0j5QXP3s4atM6QUW2GXYnJMp3DKFIo2xz6m+AfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su6uqV//aq3x8vFtvr15k76SevvdLy/xrw/uCm36YQw=;
 b=gjiYLUDmd4iNk1gBHtmzVw0ArKn93i7goL9Y74qbH9DEZMduDJLvE5L/XNybG8Eab0BlKPngXWlBarsJOGq8cI1jRzN5yuUALD0PEEEKKlhTrYNDBE8zCsbTfRIedriSp2rrtrUTHIEfqFoyZrnlGFYAHz/rCrioaULRHS7o9KwD+qkjw61+7V9rWO1l+2hSfmeQzerXV63OqX83w2mUKPD8reMRgNAr01gex2hQ2uOrp3lBYF3hOKd64oiTPJU61rw3WA3Q4KtvubTE7k7dB5AmrcwK9S4F714zPIRVcni6JgDrjcFgys1TdEehyhOM62hHsdMHfXfQC7/5rlJjGA==
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
Subject: [PATCH 1/4] Consolidate __memcpy_{to,from}io and __memset_io into a
 single lib
Date: Fri,  6 Sep 2024 13:41:48 +0200
Message-ID: <20240906114151.519028-2-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95feb3cf-de43-4739-6af5-08dcce69ad26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: StYenri4oTQVjuheysfK9B2Y9+kZuKojV2BjWWUUQDFXVuJInIFxExwt2Adbb+dYW2rkhBH1sYBe4i5Wv523N3WJQd91ggdp0IVrlqAnevdYkijvjb/jtaoF4v8YLAJrw7D/8cK9Yor7hq7Pr8TJdypjmqR3grGskwzhkrZAdnzYWPCvLgsXYKsA+p4cTu87M8SvHGbCY3N042MK9p8KqmCWtTsvNYSRv+CT9uNYY7GeXtPfx+OICQyGeknf2V3a2obhyCN8EdYDeQOK/exvdAd+iPiS6+btzJ9jrFsEcwFJlQkYei06Xo88dMRvsQt9o3zqH6dc0/bQOkGQvEor4f4oRnzi3Aa/ZRGqwUT1qeyR6pv/KHSgn9hDWtq/yVa9TA4kNsGp/PMQFloZcPkiVbbLaqTwsmvhzeONyVKaqVQ4mGKySFT8EBOjGW2LTBlDdbVTSqi6Wy0SWC+qxsFFGEvoUW8CcaXWevKruLa75HUWpzzy2a9yQqfD3pvkjO8dQvnttPTDAsB9ffK3dEwicoGiq7wJPtYZk9ESEG/nPtx/GT2McDoDPNxlntALObaNemcD2mVW82UB/M79wifx8esPQOOg+hsIUuggHVqRbZxSoHkck+Z6jP7d8dnoElo6i+kp26aEnnj4ndIQiHF/I2TuFWs+W+IQK3qQP/kpzdT86Gn1vBS5n8XED2mJdBqh0JcDaBTj4pzqWhu+0s+KXkmu8Pw0TVTaT2y19r323FzAVy0Baa5byhzQC1Mls+b8z9KOa4Yf5qwBrOwdGFMKdqHYCopR+TSCAtbkJuxlo+phjssC2pqX8KiPKfNfUYI33+H3NLtw2M5QFyAEUuyOv9hIcovQilW4Uu0KBzke0BRQD/KRrYLP1Xs/z+lZfdmUNcS2ojgVC3d3XMNz0J9+9OjoUYl3RTJCOyx1xkEQf3qpkaw1332PDkeWxmS5bz1kc7z
 b3XQDLcvmT9BJi0bazce3ofBycVRMMa0YA0ho9oNaK2gAEDKZns0ZKsScZdC2yOfVbiWTNEM0EsLuKrhAHwunOSMdeL2oxlCmCS01xorSzw0VGthxauoW949u5VNyRGPDzOrYiUPEoWSYoZPEfCjyt9NgTdTmF2eL3mo22f0nqT3yYlUxdk7CdRkjEko4H6qmJYUjVuaSnUp8FzqRjMiK0/HOIJAYhIZsL/dD/POoHRywO3nRAJTEGNrPC6PsDM36VCWDeFnR+cnhIQi9TxeGE+04W4HNl3ovjac0ymRoXe87M+Yf9jNCHu3fRMfMN9IgCyxoum/M2IZP2LVyVXu2lCaXA/uRSD6ucPYIpgkhstf9/OA++V1vnW2tyrDFnV5CyXpbaGCtMtYpxxg6IifLDvFrheTqRiRj26sJ74VwMjXBPLmfWfuL2l3oIMV+YeoeTlD8jOTjjzcnVOn4Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Y0+CJL1bLcR0oQe/rr4LKFk+TaSypyf/KWPMGAag77JYv/Xq9SDbW8QLvak4hXTULoV4KXZtN1xKnjJuyKclOTWxQCDbc/G+bknTHOtOiMcdig5X7dGUZgmWQTcvNHySI8dfe2B1voUx1Xuh8lGnOaLIqgioE6uNOcF1Bjtdn/ViJUufK2sbaDq/GiYEE2rkFtdOl9WMA083Si9TssfVCyRFWfhLR2SwnpZBMOezYhd8R8nJaT68xy9pCsUNNO/ssuc6S5yLFRulTNn6ADcyb1kkzlAk/h/bKmu0Nnk9+my2tXbU6jfTq4JqIEAgzMGOXAHHHdUeWvv4lVnHntkzzKZBGe01bYvMP9trlj4iP7EJjfm+k6dEI+A1ACfdojh8uPewqc/ThtRMgNYOGeWcXVZqWmpkI7sUOsyaGwf6FjNEx7/U8c0FQDXlKWwnf7Dy7gKxwnKVGY92sOYZQ2P4T27AmVhWjReFfZcfCcnvqy0I7m7w5YbKxSRlxZdPcPPpOKhX9HXpv4m3nebbf+7TtHwntRbk4YQ+fNdsnk0S7X3qk+tR8FMaJWShwUBPSwPYoBPhG+zj4mfnLC0frzFWoVArxaa8s2aDKUiVFvOnRczIyFkhszAMDYa5aM5GtfILhiylhYrdJjEvQCjbGtEh8733ZLEtG+mFJWVVrnWvzRFyly0XkyP3HB30fwNNM+hX0bC41fERSiK7sxO/mPBM75GpU4AC5seJ5UkKct8Jp6Zunf6HkaW2uVZjxBprfem7opkOJEPtNuUfpjvlGaLZGciEJUgCV2k0pXnnb+ACTo78BjQT5wDATiqv2+wQq5v+enE7gvMxQ1wvs5rwGOZbYJs2VGGfwbgzV8gvgh0wTmC2L3Psp9BzBSZbniAhrUbqoLOst/lTHk4MqegLgF+iesF0QegBLxMHAhyCYXu/Xe00+NAK127yLnl8XvvUl4F
 LfxdQ9qd/7gXr8Q2hQTtwv4wcgTiKbZ1/KlTb2vyRRvgbb4EraNMDVqTcCvVf6yM2++JNFGnyMwdgFcEoSe/7HjR3TXFjHVZo+HwLLx32zzkF8E6ziRPUzvBt9WPNnx7FeGLghcbMu2YmZ8tmHMizYdBSCg6SbwZ47mbi37O9qz79EsWlgvd55rmVo15fWhxUVjWoKkv35EBofwsEkH95S+K9/PEG0CAEai+TSC3c/YO5BKRW02w4UQr05DZSu5GS6qCGeAI18XcUR8Bn5Ym+3SnrbQriCKFKY6hgCfN8aTZdxw8vztgmE6YgMaU3bNEcndzK6n7ETjWLGRk7ED8e5XZorPibKvcmHnDHLg3//xPHtfrxChIhB5N5IpTmyV8Xc0tTtRkgVyJiKa83VGj2ENMnG28igBut6zTrzpZg/EsTMz6Nj5aUo0G3STlpibuG14bm6F4VlNoWI8hOjiT/TY6kupdYxApe6uhI9Uadmf5/Frh0eIstOgg2g7tk1vZQDB2wS4egAD7Prc+d+oBOVxx2taczyq3lO+GdLzY+XJWlo1cEWdXiWCQ+9Hw2/nn7biUcn7cC05F3b0hnctomsBc42gc6eTOalYCkSgmZm1SEkE9OPojsJN4EAO57UPM
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95feb3cf-de43-4739-6af5-08dcce69ad26
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:47:25.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1cuZXsBDb1x14h5ZCvo6JijXZFbbkq08ii1AblBzgqKlQMw7zcLCmE9NgJl9BO56neEmqzprbTTkgGzWbC8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3466
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Various architectures have almost the same implementations for
__memcpy_{to,from}io and __memset_io functions. So, consolidate them and
introduce a CONFIG_GENERIC_IO flag to build the given lib/io.c.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 lib/Kconfig  |   3 ++
 lib/Makefile |   2 +
 lib/io.c     | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 lib/io.c

diff --git a/lib/Kconfig b/lib/Kconfig
index b38849af6f13..2ebdc41cf0a1 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -765,6 +765,9 @@ config GENERIC_LIB_UCMPDI2
 config GENERIC_LIB_DEVMEM_IS_ALLOWED
 	bool
 
+config GENERIC_IO
+	bool
+
 config PLDMFW
 	bool
 	default n
diff --git a/lib/Makefile b/lib/Makefile
index 322bb127b4dc..d231a1c49715 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -135,6 +135,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
+obj-$(CONFIG_GENERIC_IO) += io.o
+
 lib-y += logic_pio.o
 
 lib-$(CONFIG_INDIRECT_IOMEM) += logic_iomem.o
diff --git a/lib/io.c b/lib/io.c
new file mode 100644
index 000000000000..c3385566a3e1
--- /dev/null
+++ b/lib/io.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/arm/kernel/io.c
+ *
+ * Copyright (C) 2024 Kalray Inc.
+ * Author(s): Julian Vetter
+ */
+
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#define NATIVE_STORE_SIZE	(BITS_PER_LONG/8)
+
+#if IS_ENABLED(CONFIG_64BIT)
+#define __raw_write_native(val, dst) __raw_writeq(val, dst)
+#define __raw_read_native(src) __raw_readq((src))
+#else
+#define __raw_write_native(val, dst) __raw_writel(val, dst)
+#define __raw_read_native(src) __raw_readl(src)
+#endif
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
+		*(uintptr_t *)to = __raw_read_native(from);
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
+		__raw_write_native(*(uintptr_t *)from, to);
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
+#if IS_ENABLED(CONFIG_64BIT)
+	qc |= qc << 32;
+#endif
+
+	while (count && !IS_ALIGNED((unsigned long)dst, NATIVE_STORE_SIZE)) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+		__raw_write_native(qc, dst);
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






