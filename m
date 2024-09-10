Return-Path: <linux-kernel+bounces-323174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD9F9738ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A411D1F25EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A51925AC;
	Tue, 10 Sep 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="gkMLyO/U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="cgEF83ku"
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5234192B8B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975847; cv=fail; b=NpngBkRJedFX7f+IkF8sOIVqXH5b47oF+WcD/izZgxmzIrreJXabEghxrY7j/F5eBH3GRjGHCOgNU41a2URl+IxqL0c+vVc+6wmicLuIoXOucHqnnSQ3WWWC3Qop6w7aFzlHTr95cJI41KtLKTKYO+fg9Z6h2RfsXFCRzJwpLJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975847; c=relaxed/simple;
	bh=JDefL0JG3b+NbPQBChl61mRz8IW4sP4EYSbbUOq6XKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/YP1eF1NvyxlIwQ/meBU43/qR7sTuVhtYNMEDqmSkzSHbp4fDYoQP0nB0DVX6sdPwIEA6Rsf4UHf4wgLCP+2s3FxKjTHVYcDvjm7+pDDiSCFv6WeK52lQsHZ1zcZ5SUok+X8PDcl3tFyCAdrwf0+gNZZ8TknoipYwAssqweV64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=gkMLyO/U; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=cgEF83ku reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id E81E130EE79
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725975837;
	bh=JDefL0JG3b+NbPQBChl61mRz8IW4sP4EYSbbUOq6XKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gkMLyO/UE/Bh6guHxkHPAkHQl2KplMU59zNqGhynDfsvO9gqXo1nBSEfa2TuYdeiy
	 /abOLEdRS2LK47GLCdcrhVwu62g3lWeNixQ8bcq8Ycm5eVS+N7HvuXOGrp4HQ4PVQX
	 1UYstS1/RvDw0WeRpDdOP1djgbDuXKkwEfDdww+Q=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id 62C9230ED81; Tue, 10 Sep
 2024 15:43:56 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012054.outbound.protection.outlook.com
 [40.93.76.54]) by fx305.security-mail.net (Postfix) with ESMTPS id
 64DBD30EC35; Tue, 10 Sep 2024 15:43:55 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PATP264MB5061.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 13:43:54 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Tue, 10 Sep
 2024 13:43:54 +0000
X-Secumail-id: <935f.66e04d1b.6375c.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJrJZ6H3lLNR5TBI+gXRmwoTZnvG36OMP1o7weIh8gUXT5CroKagraiVAYZUDlEJmjecn2mcS+dND8sB+tY8hM3SA8b8NOmWoqp52K+iYQTrMyJPdl77gY7m4ei07SDAy6426tO4PLHJ266huKY9SFbVcbv9lNmkN3rl9V8DUpZHDBGKU5avxgCaskIz97HdwFX0vmSVDk5DMtv2rB5Huidv+ErZxrNhw9gUzvCijxTyCMv/ila4fJ5x2jW+3ENEDLdaFY55/d3fv7LSEUa5vXIYw4AkFW8eQty6xTe9KkbWev7do4GT4jZW32hDs/tFBNPilC8sm4Tsq5s6uCHV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+su7xVP/nBK4AP2/9awTMq43uDqoTskCRbgvJzWwbmM=;
 b=oPaWqMVlz215fcRsSlrRuT9fSHzf5uL/iyTgcBv4YdX4sTrloh3ukNKD3wS559lTSUE39/GWW9LvA10z8JeFevhIx7APe/KYvfbICXrMSoUgQWpcDbx/qj4OzFw94SSWwXagO91VDC6TZk3IclrZZzci0ICfJlJa3Xh7XGg9stN6xGUdhmeri1kFyFCn5zDbrifV5+knix4sTwlNx9eXPzDZl6FxJq3yYJtYIMv4GVEvrgDkYFc5hcUiINLc3GQPApfILb3usPLyk7eGd2TZsQqi58mZWsy5Qr7SM3NhPnNKNXoHh8S3USa4GeCMl6guJ6MAfRKOU2eldH7QyrPwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+su7xVP/nBK4AP2/9awTMq43uDqoTskCRbgvJzWwbmM=;
 b=cgEF83kuDVLwS86gNX+/kMewtz/OMWAfi2/jPqblyKy14QX5qoKwxTRWcR6yWmrUXy5TQoMWy5ou8liWt/sJG278FWy0xdq0RpVfaxqGbTEOyIiGxzov/qD7UtYGZmMR1/JPo4mutOiniOjpcj1hDUH4jDporV9xQlCwJLx8WbXchT6hOF24tuPv6o21ZpsRrJJsN39wdd55IdfLYAC9cn0DVPTwDt8lPCexkfBBZp+lF0XM92/CgyQU28+dUpKmfHuGmD8JqNJWiQWcdI7AQy/8m18sK/kXiUjV5Slt/rxFHDN5umqtZJBOMwX+QLIQcAOZurV40XOVI8HLHiXC3w==
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
Subject: [PATCH v3 1/4] Consolidate __memcpy_{to,from}io and __memset_io
 into a single lib
Date: Tue, 10 Sep 2024 15:43:38 +0200
Message-ID: <20240910134341.2537407-2-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: d53c8735-bae2-418f-5769-08dcd19e9cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 5FFfgJajGl5O9H9xm2XQpR5aE8KM0VWhkNdY1zhU8UPkI6c+K0Y3WPjhlrJh388ntkagYHFG6SiJYx+FQcW5/BVEeanTI7KAs/pdrK/ElbTGkxQTL5uq9caCQ7IyjtDBgPBbu095Pc2uVIhvIzFnzp5nu1tkk2xEt9wnoQU492llVsiXSGI4FD7HYBIn53ZsWA+I2sP5DBREMsxV/VAWfhFaaksceaXffGd5OgWgHNwF3riGHBGLndO2XH9RetJxvkMRmsndMclxSbkqlflxTOyYic5HDJDmjmRjAypYW8iJk3tPvGwFwdd1Dv+JfjqCFHZtjILxwf16fRAAJvmXSE0tvjQBdfwjEq3y3wiaU3EQPOg9DqilMbENtz3Q8jnjPhTphwWnretipDNB6QNKDdDcH/RoRHU/qZOYmTULDfH8mEAFuUgn5puMgAY9yPFFSo6KsxP0fzREf9hFqBkRjiOOAh2mqRDdUXumT6/naT9Zgq8MMvoOQ2gHBMIZXQJrGGPEAy0LzzkHoyRvglaAVsPpWkF57btCNNWp5NxxM30wr5fTLy7AJ62fAmjvhtiNm/caBh1qZJWMhfi5zslsAUUaWUlu7Hnrsa/pZHFZyP/rSYv3Xsi4+gCwZMdoo1hr66IH/CL71VNu7DaAy1Y8OLHWRITNP4rUhcK5SX1iXCEi2nPw2YrAg47WymaDW4SnXswgFJYATrOUmgjza9gtmfgU7TsrezbrpUA69eLNCF3G7n4wSIHRkTOQFzz4xcSi9yUmed96tMFLZCsg51+SU4Rhh+qGHn7oOSlFLo6E/S5aYpjvHJnncKMWptKwQ3fuAClAEKUJjFawuKIZzXBt2Q9ZlSVVukHYtSHUiNT5va9fF8Bmild/N6tYCuok6lGww6JelNbUNY4ijfvPRxCctmKlyP01PVFibQqUb8doju5009SZoAJmtLyHyin8t65r6D/
 h1Zj7RCBOGx2PJbiaDrTBhs8u9RyqyJB8kNLSyfqSbjNDMbHvUOiGzh7p8gjjGnJfNWzFzq3t9y4tP/+nVq1W8gR/t57bAPvcGiKfudPRuGIU/YEjvezmpKKagn356BbOSeUUeXWuX/gbxDZ0LAeSOtcqZkofjhdn11yodbgWje1bA3Kjt8DmJfSnZJ3Crfz2GgAStWlgeuJ4HMX57HQg2emCnJFzomfu4AKQntn1YaVxrBw1bhCqHSY25h5Ud4nsoNosUQTcm8TWaAtwjIGAP56xnPMf7g3oGqw/PZkHnvOyTG2Xk3s9aoBf5DVcgBOTKr1mtm0rNT2E1EQ74OidhICMficZxd4DTA7jf0oV03z3Pv6las5ECXxp7IjoTKZUw/GxqpFXGSj1nmkJ9TjYKCAFrF+2sZ4ZHR4+S2SSRL1/4DndF+rVyybUA0PVqjqg2g5nKsNURTDxwNRUAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +BwfniH8s6borJ9J/wkpH1ldr7q+uYD1NpzM22THyeVJC48Qy5LEBpiPiNUKDz0q9M8LvEta1PspkSW976uv+RX8zK9suwgTcPeWJ1LqBIC1U4HIGtWve+2yWpWVZrZcmCreWxfcFcTjAwmCoBTOWjavRBZ+ZqeqV7QUPOfnuLR7mlzT2LZj24JAIreStFkTRBYFCilOMEUmi/shkPjY3XQqEaqqNU+Cd3CZ2D34WuBw117FEPJSY4aTjX5q0E63WU9NscNasokvgE5pTPaYpgzd0uyXR88JC9xk4RTvzMQGdyrvRMAO2QD3PGP9NmvtjSSwK7VOx+EE4Lx6I892Ecw0YQaocqnPolKB7vb3hvxrr6Zmwb/S7OBU7cP10QC81oHGown4SRACBXu6wwbhLJfRFDuXqLKcTul0IF+MduuA5I2Q57WzIBGfsucRY4uLfjziWw0Z4BA5ZpjyDzwA8QySW7nfP61rBjDplBtksJgfxFr7I69z0Y8lfE7s0FzLvRE6fDdXOoyDvEzs3C8M3Ewg5TMgKdrOpLy7MLmxUZIXiFNs6sulRrGivLbLfQySwCYw4akQA6qPfVWstBGPCMAP4IC9VHlFHyJItLYYAII8DUXZJsdE3Yn+btw81hHBUTxwakOQ/pqJiECqI/2xP0n0ci4WycAc5W6IUOtGBFLwE/wqZUeuDdr0pijlChBnErDyAUIBQ+ODu7JrHnEYUzmaMN62ZAlD/nqzU6UTMK/N3gb5k511v0wJ4Qcro1DAAk/7AJDu53+kaKSsW27AgYFmuafbKkJ5no/4T/dw6HTbeE1tSodFixKdIbp5w/vW5pYMt2vjArBEfB2cBFHVCfkxaswZ54+hHqZDN7hntHe4GXNTFyyJQgcqRuRkcSUOOjrHwlPzC1pa+f1DpCIWTN2SGzSNcxKbF5RPR6362k7E96CzsqgVKE8O9f1wqty8
 gJkooQvItIlREAHc98RCVPcwMNLjxQg97y+/uo19ihlhbfzuylcifJTAXpyjEL2YnlaESNFLPEtgKwZ0d7ukk0RoDqGVzL1bPbg7rsAdZNHbT/+h3i70tg0hR5EcRRemMrbQY0VvStUnjpd4rrlaDKFu2HZmeFXCaYz2WV71hGk+ButeStiSOR/UMtsrv13I+bgKhpdCIyXdQGMFvRz32fcOf3J9q3p/u0X+WUTKyyfh6ZueY182shSVm7FPkBlQ60ke9Ss97jWmTwZzWkcc7sBm79U7nwNCYIZ4pHn2+SMxqWKWV05ZvmlQQughNDljFZSWBuQB1afDir3cvLhe2irpf2NH0JZJMFPqSTIDKd2d2M8rqCHkZ5sgw6EBdWcIEw33FyRINu1s7V7rx4IaWvc+2xR3HAHFMibzuon6SSCkrpk29wsqO5qpf2c/9hFa1dFhFk3LtZ+E8ZgTQvrAn9tc+WzuhQq3/W97q52tU1z3bggn/ydOAN0SZEgAKIfQiSHeFopJZzgnJwdI4j2eMXZy0+W6ojebT5x4GsSLIzyaNWlXH2/o6bBwVIm5vhGB5+wzHSlS3LVSq5rIaIEQ4bmwv26P5OZLW2c0SskzUW+2ujqpf5uunr4Uif+JqbXiMev1bnu9eTJY/mhopW4qyg==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53c8735-bae2-418f-5769-08dcd19e9cbb
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:43:54.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrk1lKVNMbb60J0TUXDnwfpvoWP/E80t3dkvf/DqkcECOhIADHIEkVuVZG6SxvlOUr8qMQJwvpKlfAJ3D9WF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5061
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






