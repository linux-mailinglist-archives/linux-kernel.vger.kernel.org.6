Return-Path: <linux-kernel+bounces-304440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D969A962015
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181371C23620
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E87158552;
	Wed, 28 Aug 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W54WTXpj"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26871448E6;
	Wed, 28 Aug 2024 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828124; cv=none; b=eq8DJ3FLos9BeRrcIIMVjC/ClUhtqdfe+VMgBHkrBFCJTJlEsRnbAec/DR+iKtqbnRqOk2mieeoQRQ3a0S5anBjeQg26WDJ1RJIPPOEHnafsEAP+bLBDw5LlgTlkfp1AMauN4IdITyrfrv03xCzG1OPbrVsLhQHe4jhVIAGevwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828124; c=relaxed/simple;
	bh=lFi2UpPJvbtKNqXqipYQyNiuOvlu0Ij1SrfqooWu3fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uF4E1+8KFKtmS5CR6wnqSa3+Zg7ZDkp1MKEVJj0CqAc2IAHX7o+k9Z7DyOFJWYtak5RMTN9cLnGQOkqWRSzuQlGbBslXX0KrVCCJYSP1U0vQc7qqrVYvmIOTk36aUYJjza+iFRuDrFYl1Vi94SluKNXBrcOfICU437kH53JCDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W54WTXpj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fec34f94abso65984635ad.2;
        Tue, 27 Aug 2024 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724828122; x=1725432922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ROqg56FyItnNUDdC6ELchQJJpYcKYxLCDK9KVx4Stg=;
        b=W54WTXpjQerjPiKTyAq5ipxrw4vHt2fbmXULzPqHOa22DNhTAoSu2X5IRYvwNqQ65E
         wo3E42fI0DzYAxqSTi1ifne5Q+Zu1GuuJWxYSRHXOZLh+rlN96O36SYJ2rg06zLUIGSg
         bBgHJ/iOmHSg5L8UtWPcXXV94mtOZ3VLSDJWNJuGYg3cZvC+CRl+V/0DdNg1GRgd4wSy
         /m1X5FaXKQOaQXItR2O71kKQWkcnIY2U1DDcAs82W9si3p8e4y69T+XYTerwr+IoHsDt
         h3lVuHOAi4kQyPWSF+PiNaQZSbwD+sOEzjjt//43RgUyngWWThcG+hLtgOfpwGxAJxNd
         DGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724828122; x=1725432922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ROqg56FyItnNUDdC6ELchQJJpYcKYxLCDK9KVx4Stg=;
        b=p5wMb243JPz8FJ6TUHtvaF+erqFmnl7u183tbHLhyLYKK66QwYgs+toUxj3ViwNNth
         qHEoKd2QxvAON0qYdXnO3+9Wnz+EGg8/ojCkeZRRtwWyfn7DeMcHXSj+dmQRwKti/0Re
         31u3bAWiTvXKOzjJFteZlWR8qgc5QqFR2syOhjxpl2/0O8yE6j5L8skTKcU9uZ/Kpnrx
         2HUkksklCfZNNW3jyPBrmd9jmlzn5kDZc5iaK4yEo+SWTy6S2C1Ktoc59tJWT06eddlB
         Yrk9C5feIN3Pyck+4NecpKUJ4J6yTpYo0ri4WpmX7WIoeUpGA6JPg5sO5Ni1hydjvopI
         VO6g==
X-Forwarded-Encrypted: i=1; AJvYcCUceKBO1sijdHIEtNOWa1XookknjTtVCQnfdBb+4wux1LmSKNUYmwtxHxVQJySHVKdq9ylxyOHKhMAJAZHg@vger.kernel.org, AJvYcCX+oCF7IFDdFkzDnIxnUom78uEOXkd9JZDBA+VrQcnIql5xYbAaDYajWUh/w2jnDj58T4tLjD57SgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+pc8rfhcDSNbRTr8EhRQE9chombxrfJYVkoPjLWCIFniiewY
	FK+cV+vD/tIgw1jzBSRZEbx8jILbJT+C7JpveM7Zg4wdyeeitpLo
X-Google-Smtp-Source: AGHT+IHyK9Bwbr9j/dan60lKEiq/HvBRavSYzYIR//sllCCG1mgrUDVgkeTETlOetRIPEotRmP5cOA==
X-Received: by 2002:a17:902:aa04:b0:202:4b99:fd27 with SMTP id d9443c01a7336-2039e4ef20amr113649585ad.51.1724828121819;
        Tue, 27 Aug 2024 23:55:21 -0700 (PDT)
Received: from m91p.airy.home ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385607f94sm92816005ad.182.2024.08.27.23.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:55:21 -0700 (PDT)
From: Bo Gan <ganboing@gmail.com>
To: zong.li@sifive.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Pragnesh.patel@sifive.com,
	aou@eecs.berkeley.edu,
	erik.danie@sifive.com,
	hes@sifive.com,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	palmerdabbelt@google.com,
	paul.walmsley@sifive.com,
	pragnesh.patel@openfive.com,
	sboyd@kernel.org,
	schwab@linux-m68k.org,
	yash.shah@sifive.com
Subject: [PATCH 1/3] dt-bindings: reset: sifive: add fu540/fu740 reset indexes
Date: Tue, 27 Aug 2024 23:55:18 -0700
Message-Id: <d4e3c23469fbddb6904b857e9d262d86aecbd880.1724827635.git.ganboing@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724827635.git.ganboing@gmail.com>
References: <cover.1724827635.git.ganboing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for FU540/FU740 clock/reset controller. The header is taken
from the same path in U-Boot with macros renamed to have FU540/740 prefix.

Signed-off-by: Bo Gan <ganboing@gmail.com>
---
 include/dt-bindings/reset/sifive-fu540-prci.h | 19 +++++++++++++++++++
 include/dt-bindings/reset/sifive-fu740-prci.h | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 include/dt-bindings/reset/sifive-fu540-prci.h
 create mode 100644 include/dt-bindings/reset/sifive-fu740-prci.h

diff --git a/include/dt-bindings/reset/sifive-fu540-prci.h b/include/dt-bindings/reset/sifive-fu540-prci.h
new file mode 100644
index 000000000000..dbaf602262d2
--- /dev/null
+++ b/include/dt-bindings/reset/sifive-fu540-prci.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Sifive, Inc.
+ * Author: Sagar Kadam <sagar.kadam@sifive.com>
+ */
+
+#ifndef __DT_BINDINGS_RESET_SIFIVE_FU540_PRCI_H
+#define __DT_BINDINGS_RESET_SIFIVE_FU540_PRCI_H
+
+/* Reset indexes for use by device tree data and the PRCI driver */
+#define FU540_PRCI_RST_DDR_CTRL_N	0
+#define FU540_PRCI_RST_DDR_AXI_N	1
+#define FU540_PRCI_RST_DDR_AHB_N	2
+#define FU540_PRCI_RST_DDR_PHY_N	3
+/* bit 4 is reserved bit */
+#define FU540_PRCI_RST_RSVD_N		4
+#define FU540_PRCI_RST_GEMGXL_N		5
+
+#endif
diff --git a/include/dt-bindings/reset/sifive-fu740-prci.h b/include/dt-bindings/reset/sifive-fu740-prci.h
new file mode 100644
index 000000000000..74d60ca9f1df
--- /dev/null
+++ b/include/dt-bindings/reset/sifive-fu740-prci.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2020-2021 Sifive, Inc.
+ * Author: Pragnesh Patel <pragnesh.patel@sifive.com>
+ */
+
+#ifndef __DT_BINDINGS_RESET_SIFIVE_FU740_PRCI_H
+#define __DT_BINDINGS_RESET_SIFIVE_FU740_PRCI_H
+
+/* Reset indexes for use by device tree data and the PRCI driver */
+#define FU740_PRCI_RST_DDR_CTRL_N	0
+#define FU740_PRCI_RST_DDR_AXI_N	1
+#define FU740_PRCI_RST_DDR_AHB_N	2
+#define FU740_PRCI_RST_DDR_PHY_N	3
+#define FU740_PRCI_RST_PCIE_POWER_UP_N	4
+#define FU740_PRCI_RST_GEMGXL_N		5
+#define FU740_PRCI_RST_CLTX_N		6
+
+#endif
-- 
2.34.1


