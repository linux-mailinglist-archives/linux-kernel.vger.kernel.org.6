Return-Path: <linux-kernel+bounces-521429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF52A3BD29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F3F3AB280
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5261DED70;
	Wed, 19 Feb 2025 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OlazLVeq"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF61D88D7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965316; cv=none; b=D2rAjnruNTiE8H+R2bBBMcyE3vU+9ONoa/Nnx+KBXCMkHdS6Hug35VWumVU5O44uOFShkaC9CPBJLOjUjZLyXML/jqJqfuMSQyuofrporpKdCCRrd609JxYoipYHKbrQCwk3GP86UmnA9vGw+BWHkCdRhEylSGlueaY5UDS0BbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965316; c=relaxed/simple;
	bh=v4Nxihrrot+B12P9jCeJPg6UUTZPQjPI5KJs93sMlZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UdWop6dhoGWAD1zgVIvsS/YXALq9fbeuM9XC3SnqRhQphUQD7YtHUzBuej3FreAKM4n6BD6PZaPk/DkadDDwqycbHJeVaTmGWGSEf65ZXwvARYozvhGV5JZdPL0/1TBCZQkoH3k+eRC+DVuaE7RE5LQTo1+V5EUaZmb0kMTdAdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OlazLVeq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22113560c57so74641415ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739965314; x=1740570114; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TvtQB/lGlc+Tk5xjdqGmPEVFQSYg82f1Tgy36DWvKQU=;
        b=OlazLVeq2uIf4M8VpnDXS+6owHeQOXfJXJ5ZST4DBo2bpjcvQkoqKJ+F65RRSXJbeQ
         icsY7iQr79Rcjh45qhueU1x8fxhV52uwuMrFknjpQm0f/RqDRU2GFieigLcjJgtG5K0j
         FxYFpC10xJWDzSTbZixtIvwLr8IDeg09D/li2xfL3nL4Dp9+ng029vGyd1DzzP3SxSoO
         iMPlBH0tq4FTzc43+mXF5H6K3Z0w0zPyF2t6Y2d1jlJXzF3yPSvRNodJ7vMjWKvLn+aK
         ovG6LtjS9889V9DGulKEbsLzC0GuWTv62Mi9/I9BEL+ILbCVUUAv/gDPDSsWUTxtasdH
         RzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965314; x=1740570114;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvtQB/lGlc+Tk5xjdqGmPEVFQSYg82f1Tgy36DWvKQU=;
        b=sJtLB7j5ggQn7flNk1oW7ny4UzEMS9KlMGyYo1yNC3Qd+O0bkp38W3FG8kvlAIbFs5
         RcaQbhfebhykHEF6ofS7iMdLfg4Kyz/YiYvij8buT6K262OnNYcj551Sk1eQS1qYvQTm
         TOjbBbiNVxqEvi/v7htNp+RyyD5sOZfD2UqdU+WsAx31alOIWzWYtLS+MoWSvPMUCr6S
         /cgYZsHh4o+hGTxEWVFO1yn02ypWh4/MP6nT7g/Gttz7zB3RwKTG+o2QcS1P5FzWHyav
         XNn3S1nHmwrJCZSbKB9lgsjCWVQXky6+A3amQO2RJU31MkPia6ey7TTiKt6hICebdb1U
         ktXg==
X-Forwarded-Encrypted: i=1; AJvYcCW11u1lnm3lbeWtnSCkiHBdybT/rjyHILpo04WAJt58ZTidEs/z3Cqg0DgJ+CcBQOM9w1FnP0dZIXW3Juk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVG/G2biJz5QLwUc8EtMNymjZS5+D/ywildA3wQpKNhyD38f4V
	7XvzryGRjWgLjzZj9cgH8/vZeM1EF3u97Bn0WZ00YmKp1NxcUB3JhUFZI3ZssdMJzufbZ42Ju7K
	i
X-Gm-Gg: ASbGncsKYNSai6xaw4HosZy4kyrg6XTSV40dQrf8e/zmB5Zu6nidrmejJgwpW1AOjtu
	MsrO7DXD0Aq67tXNTe88DfIqUzloAwYBMbW4uhf0y9C2KqG2iLAEKe6sTmy5dC5q/hb6y+Ed8jo
	ZjtrQ9rJRaUKnCgcnO+4JKZAGmjKRtQae7MWi7MphHJEt+U7Ef/1wwGknSztk/KXDima6TRlSGb
	eH/1kihYaP35fNdi7Ehj6ByeWwqK9tTYQpi5vY4DE34aCnjFM54O/sh203m7WAfuOL69/wLhPNr
	K/irpK6yXbiQ1I39zga7dM13Qjl3pjuQGLf3eA==
X-Google-Smtp-Source: AGHT+IE6NLalTRKF906UogoaqA2vkhz8eL3B86SceRlnQGiSoGs39HTOQJs5eyoh/PazNPL54JFJxQ==
X-Received: by 2002:a17:902:dac5:b0:21f:507b:9ada with SMTP id d9443c01a7336-2210405cc66mr282536845ad.31.1739965313971;
        Wed, 19 Feb 2025 03:41:53 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d507sm103218545ad.145.2025.02.19.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:41:53 -0800 (PST)
From: Nick Hu <nick.hu@sifive.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Nick Hu <nick.hu@sifive.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] riscv: Add stimecmp save and restore
Date: Wed, 19 Feb 2025 19:41:34 +0800
Message-Id: <20250219114135.27764-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250219114135.27764-1-nick.hu@sifive.com>
References: <20250219114135.27764-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

If the HW support the SSTC extension, we should save and restore the
stimecmp register while cpu non retention suspend.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/suspend.h |  4 ++++
 arch/riscv/kernel/suspend.c      | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 4ffb022b097f..dc5782b5fbad 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -18,6 +18,10 @@ struct suspend_context {
 	unsigned long ie;
 #ifdef CONFIG_MMU
 	unsigned long satp;
+	unsigned long stimecmp;
+#if __riscv_xlen < 64
+	unsigned long stimecmph;
+#endif
 #endif
 };
 
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 9a8a0dc035b2..24b3f57d467f 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -30,6 +30,13 @@ void suspend_save_csrs(struct suspend_context *context)
 	 */
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		context->stimecmp = csr_read(CSR_STIMECMP);
+#if __riscv_xlen < 64
+		context->stimecmph = csr_read(CSR_STIMECMPH);
+#endif
+	}
+
 	context->satp = csr_read(CSR_SATP);
 #endif
 }
@@ -43,6 +50,13 @@ void suspend_restore_csrs(struct suspend_context *context)
 	csr_write(CSR_IE, context->ie);
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		csr_write(CSR_STIMECMP, context->stimecmp);
+#if __riscv_xlen < 64
+		csr_write(CSR_STIMECMPH, context->stimecmph);
+#endif
+	}
+
 	csr_write(CSR_SATP, context->satp);
 #endif
 }
-- 
2.17.1


