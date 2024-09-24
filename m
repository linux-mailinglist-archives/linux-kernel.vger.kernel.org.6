Return-Path: <linux-kernel+bounces-336882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CD3984211
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204FC1C242E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B09716F85E;
	Tue, 24 Sep 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Bo2/dOOL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="pVtrwojt"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6115574F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169965; cv=fail; b=WYQZdY6e3UgkIpsxN3jpqHLdPWIigP/Twl1NAQrwnCVPlqO0UYaG0Stq1OAYY6RmYW74RDlCSW/Ryg1iMpDxzpIlQvV0290aE4b1JK2hGgo5EbQ/ShcIfCAGJdxxkxa/D0Lk3mVQmySiM82Q61gAw0QIT/rjQaw9wr2LJi+QNzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169965; c=relaxed/simple;
	bh=JDefL0JG3b+NbPQBChl61mRz8IW4sP4EYSbbUOq6XKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YH76xXQFiRWw+Lcy1ogc6vmfY3yu2zwuyWPuP7OoEfHqYZwRbKsz8A1YUuYHP0D7g9niLAsN+hbEd3LxJEs9f7Iz2Vpy7HT/jiKrSLrC+Sa0lMFD6wOF1i0ci5XOykKerDLLZbgsN3H4wXNgRS6fXhzMq7H01Sz1oITwAElpT04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Bo2/dOOL; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=pVtrwojt reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 7CB598EADB1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727169780;
	bh=JDefL0JG3b+NbPQBChl61mRz8IW4sP4EYSbbUOq6XKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bo2/dOOLmzx+ZDo47qdzlP+nA71W3Q7Qpy6vfY+1OubgyVOgpJapDLqk4vg8VhKSZ
	 JbmCcG+PK/lzymvwIiz/f9YjdM9ONQ4KIQ6VOvjwXzCPn2NilfJbo5d00okX3N5cLM
	 ug4exewzsD/zvF7xplpgSRRgs9kPwZP4P3GuzL8Y=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 3E5EB8EADAF; Tue, 24 Sep 2024 11:23:00 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010005.outbound.protection.outlook.com
 [40.93.76.5]) by fx403.security-mail.net (Postfix) with ESMTPS id
 312E28EA96D; Tue, 24 Sep 2024 11:22:59 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB3073.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Tue, 24 Sep
 2024 09:22:58 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 09:22:58 +0000
X-Secumail-id: <2db6.66f284f3.2f210.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYNjhToGgirar64UXlmIB3bFyYeP2aASVUwJduXn7iFMI1VV51ZkxjA3UV7f4SgcoYeb2/rvymLzQioOUqgsBm/+mMDCGe9nvytWLB7gG+RYE55tMnV0dydmf5kBESn++Kxjr8EitbbXRSDYHYpfcE/pX4n3GBulSFGzraOi/S/zsm8s1LsKaAxx8Z4Y+PMTSjMmL4+vcp8sYHPduRqK8mxxB/Wwzf95rS9L3hodVq3xXnnXWDg8ZJWsMjBmtmTe/rYZLEe9MyBwGryeZunxbx9Bwcx4FQ6jbqgnOpL4k1nyWq3MutjPFm7XG+WDw76SrzSakXXYisXS1ggZ0cBTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+su7xVP/nBK4AP2/9awTMq43uDqoTskCRbgvJzWwbmM=;
 b=W8JfCukw7744cBIgNrLMaCVjiOKcTdDNbPWJB6tn/m/Z9NIz3yVW5/G5xGsdfjWoXm51dF5CjzZ3yPN/ZUu/CFKpiRBde162kLQWZ9Q1K9l3Jp+hn6KbIHcD+CdznvpmBVNxAusVOCJkzfjurwJaUKlAfHErXssT8PrtPt3RNpK6lMjTJuxxw2QVAt3JTM5bPYdGSo3mzAoKktodMWl7oR+q4R/OpIbUqVLtC14/THy0eSBrQI6TCgkH3z4ru8x0czVU+/xWIf32quUt6V85lvHI8VOo2hjEEfk3rMqEVTNS1/uQG6y2pWvTF7dcNWMgB5qygsGmiOV9e8AaFvDRWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+su7xVP/nBK4AP2/9awTMq43uDqoTskCRbgvJzWwbmM=;
 b=pVtrwojteOtQbJtIMExgWGjmK3TWW6mcYq4Xgf4Wg2On+1NZk2GZrid0r6OCIHF1kcT7bXZoioI26fRrziTUFusz6YRwqZH2cT4qs6rcDR5Q3AcI1mXcXGYxYmjsJ58RzEv8Qq9hEsN4jgdKmLV5V5ovudsv5XjDQjRndTgjKrMEjC31kfts4t8GeGgVKfVqNCL83/WHTCIAWeDkRJ5z8AhIL833i9r8GO01v/Q89UhBmq1rnFS/0b5+e0JPngb6XPjJ1La//JfJt9Rxlb9SdZa3iA3pnfVAdrjYCiVg4HVTkOkU+FyAYAM0R8r8Lf9khz9fN/TGKWCBsMgXnf4MvQ==
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
Subject: [PATCH v4 1/5] Consolidate __memcpy_{to,from}io and __memset_io
 into a single lib
Date: Tue, 24 Sep 2024 11:22:19 +0200
Message-ID: <20240924092223.534040-2-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1941696-1c87-489e-954e-08dcdc7a7a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: ZmlNXx0aNFctZWdkWhwk2lDQoz99zh6Nzp47mkYHiQClhghHNaCC3T63ehSVeJNvQottxdUFhkq2rcxj23E2t7na8kc7iqdavy+WP4WPFA/uByZ20rOj/xz2KuRKYK5mU5RvkkshjG2kRDqCoHo5wGT+ncFHsFFSZ+tbv9MpJMFCHQ7JbnwqRtC6CVavVtLNWmxBzIZh4wL7fXSB3ybMWBJZX2qT6IimaWdOUT0qd4XZNeQ4zeQ1q5g8Oq6wHZwanmZ+hcRsrpmgBQioa7PDzFVkw9IjOQPikc2y85U72ltUfqaDeOmbUSEUh70l4djduKBuUirCiuJjm0PFPU4ptF77luByiGfdOSJ/Z7ypmNjE2tUr1mwfVhDsO5I6YAtk5QOAES5OYBwZpkw5KaZiefwiQmWXkuts39CpSevawtnOOd6YRV/vncZW2bwdaQSaRt5sSgTFS44gSCThWojIWfy1zrwzAXAgfEkpORRG0vnVNNoMIrIu3btnY5QCXLQFdNmoAa4iLjQmVEgdgjnA/j4ARUd5YG6inJiTFSEapOWSN/bT0LJSCLZnOEg+ETyeuAkhQ5ckn+SRS9lMLb2f0l6qP5P7l2dHcFjgzH8unh9LUrNcRwpNsg/3DjKGa6lk38okbxTy7q6Ne0jJRV2vlntJhC2NszNpw9MS1JWOfNr+SKIOO3ecUI3+j/+1/RqVs2B2TjKg9E4WWfWuP5u0/YyE+9/IRk7/jBliaCHca528FMNGMppP0KsM70lRB/5eclhswR/YZs9box0XaFiMSgk1Lre/tgyPi69i+bF59fC9+yDmwUUtsWdvOSIb2SaPo/f+PEfoJ6Q8//InGsvnIFEvtM9xXSUll3YwPiRCAmgH8yAmdlUdQ/fa7Z0kwmSEGHgJGtnnHD6/jasic8hGC7v4gZCl7TUVnT2iXMCCJqbPYFC+a9S120aM9k3kl6EhXcr
 gAjxeZNYoqaHP1Vv0gUH4xbqiEwRjvLX8jo6JXCSTByYaWvvYuhfOE2KaB/Y74ND0YCrHLxFvNDnKjDOPtq+uFP9yPHMqRHVht5phykn8Uigs2zU5K2y/jp627Sp5XMn+0zvuDuXGkiujKPgy6KLkJhLjCkh0nvqUA8Iklzo+3CLHio6wI9fZBGkXVdzeVPt3ZL6eRtnice/ioGZgYXq50Dv2E8QYmVn8g+E9MVOWqbObIIP2r+AyNPHB9R7CUvZXsyEApyBA9rKwxqEG1XY9QJmYJQsheWUUdPivZ8s7VlzvDvx1rdfklIlUfOms9PoiGqcqbBLvQK0FcrmGWk8C68kpV1jktHJppQmsa90hNjs3CsEMDrSEw4RZI+ysV3qrE/L5mn3M8JuUi3E+mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nG5ket4+WOxI9sEeiKW6N1o+KaPNf0K603svPpMBdRfOOw3WfnU2WOTMu34A80PbQkAaBVFjSLaiV20mu8EEizWCM7MpmOXVW02xwXggKyixprfliAUaMmlgh61spHnqNT3/YXFevfrKlIQjqfyKIbsTX6JYv8tpZemCyM5VP2sFv8s4/vUo2wUoeyRoq+5tmP70xD3am6toJShnu47xrR+YiSFZchgWWnDedf7aaQPHIvNmQA5gzsTJOu1O1l5JVYZCRbyZ5xN7txFjAv886EGC+ssBwIw+H/90FH5xgyELVWgGlfe+b2zzWyVhTB/ey1bYCiCNhBOcC2Nce3JKxlpMILk3JTou2WgIufa37rZPx5AIlh2IRtP+KRQG/j+H7xfVM/cLuHf7R1mtBNNARKhQVFS619dyu03g/tsDmOZu3yajKizRqWayuT3Ks/cgBQqGj+D1bi9qoPy3SWiRjLuUUlxlVi1ipSQa8gm7MocXAse3OH4f0Fdemwygufut30wTakxjKS8GETfZ0a5EoVajtwfmiTS9KcWSyBw9LLY0rHjdfAK9wZqYyrl04iue6aqnggDQgtB9QTTwjmLueilyq4cevkVlcHJRmb7JkNnABl/dlo6+p/tpPF3OUS4DmGsI8UuKsG3VsLTX7t/LpLCh+K5a9hBVZmcoZ5MaoQDayhNPEvKYRO7pQ/qGDzAZii5QZnXuRbbGXJFB9DTaS8Uiy02TPY3eE6fxk0FaQXa6FpTYXC5lmcNSKD7lPnmIIiBN4lOx4TWwSCo4Uk75URA6Kuoq4NsKFzCEQ9RxL1ACKH3JndGuLDnC5upKN3W2brSK1vTWoBAVx6Pxe7uGSjXd2iLS9M0S09DnayYZox52Ewo5CFfFhRSzot8QW98rsHxT4xFxv1UHmYUhcUoSVXvhdxmSE91RSgSWwc2h9IrC3PcCNJphjhQ+/xbFXe3D
 gqW/BkiJOSFtRhneRtg97bu60Cc8hEBYIns7DjCsPEo2BpHTwhPt6dnprMZjVG4pf0ePAswFX+gGh7oK2Yqjvx6zHe+CJY/Ke6uLnvdUl3bW3Wk6XpGGFZm1i74v/4soyCQLxke4pXCjYNTiE8G29VB3IfdZ8Z/5MxcGyCwTsrsfnkA4IW7t4NvRdcvZSqd/D2wUb1v/hitgxslYditFiB3tHUEz//m1UEvlwEr6d4hPF50xIXnBcMfuMRVdFxKvJSe2AyumUARyH/jAar4JA/c8+GMVEaGAdCMIR+JY/qkjnsJxKYIsekKde/EDz1KaTy4QDIheq30VQi6OOBHoNHs9zaqvhCUqH8gV4TyMZtnQStcuo+zE7M8C7oByDQKJqi/qDBEYp9psgfZnXGIPjpW+DfPSXdDA5mn5tYWW0+mL/S6N8+ANPco3pnPJWEYto2kMsokmUo3wJyOA6A3voJEf/cEmptRl615SfMg41mPg5vH5r81m7DSqhiQ5TEqQ0OwoCBbZw2GR9ND6BboKWvfyjgnU+/l+2OE4AhCXIh2078wBQXlNn0BzQh333xX6eFd66wvTcTAdjDthXCl3/jQHFbnMqtjTFV9NdYDHUOnkSnVFUW9lPsj04KUxq9L4
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1941696-1c87-489e-954e-08dcdc7a7a5b
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:22:57.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/WGzZuaHIwzhcTZVOn5ltn31M8dCIs28B7dKzN4946FgfAZQ+UVpe99o8e0oCtk62657txfKWv5yxd4LrsJVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3073
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
 lib/io_copy.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
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
index 000000000000..f44583166325
--- /dev/null
+++ b/lib/io_copy.c
@@ -0,0 +1,110 @@
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
+#ifdef CONFIG_64BIT
+			put_unaligned(__raw_readq(from), (uintptr_t *)to);
+#else
+			put_unaligned(__raw_readl(from), (uintptr_t *)to);
+#endif
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
+#ifdef CONFIG_64BIT
+			__raw_writeq(get_unaligned((uintptr_t *)from), to);
+#else
+			__raw_writel(get_unaligned((uintptr_t *)from), to);
+#endif
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
+#ifdef CONFIG_64BIT
+			__raw_writeq(qc, dst);
+#else
+			__raw_writel(qc, dst);
+#endif
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






