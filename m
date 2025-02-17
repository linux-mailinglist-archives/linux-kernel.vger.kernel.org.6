Return-Path: <linux-kernel+bounces-517212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CECA37DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111B11888719
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497F1A707A;
	Mon, 17 Feb 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LmXPHVW0"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB519E7FA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782712; cv=none; b=L+JWie+MqubKLt9h0hv5MNwJoaDsgSuh5ZvqQXeWCPK52W9cKV7HzyQS/9AsVHnLkPDZy2KC8frXO1C2f+vYL1gXtJOcviLpUYFfRIBmGXKHTcVZ/gDfkezFhhzlLCpLfHMO1xh+MBcsZIWFfNk5Vi8IGBIU0TIIPYe8kJmTEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782712; c=relaxed/simple;
	bh=PxpxF0dUlwKn44FGhlpT2SXXiblCpU8cCNLnLI9M4ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQ9tL924Pfwp7voMSDXUXqR12mYw65ddnwuHBdYL1GlQ1jJJ3N8/l3o4zZrPqHxMQigIdyvWLDseM0T3i+Ifo/Pm12EScsO75+P6aWQCADOCK/9f3nfH1gl4KxnsI8yIDQnqP9ZD5ojDRpDBetzxR7f4UEHwS5ikDfObtoHcliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LmXPHVW0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa7465baceso8397917a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782710; x=1740387510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sE/PXdSSokJ0Zgm0Fk4Pk1jUj6qdWvd3FyfD/aEiAI=;
        b=LmXPHVW0iELFdQz6cBNN/iAH8jN5YvQ7xGPmgV8a9xvf/Gd7At6f4PYitvBt+fnvIh
         pEhn1+JPCF8d9g76ZnLKA3NVKgEgIo1sitTXp5lrtjA0Qx4CHWZiavNA2JcS5Xcly8AZ
         82ayRT+pSEn4hqtgx5zdvUnQsLN2dkeAlRGPtsWTnEPL95vAxX+nEWL89Tos0qqvcnae
         qLtSDVMCTFnmGTKGmk5koYEt63HQKluM1LHfvgKdAxch5i6q4DTYF/SENxoiQH4L+27E
         OAgfLVmskrW6hZszUO0WhTNDL0u5t30eYZQNJihqiLGAvIw/TEZ50fvXxMoBRMaa6z5h
         6D9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782710; x=1740387510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sE/PXdSSokJ0Zgm0Fk4Pk1jUj6qdWvd3FyfD/aEiAI=;
        b=LeVKJH+NLZbc4ATHv6GawO88lkg6PFdFBtm9lWQazMEBd/Ch66kPFDhwaROtPoITpd
         w/naISBKNfhtuEWGP22dq0rYduPh7taO4CMKgp3YNOpelT7bS/IsYyOHeqfk+yzYHkFp
         Ke1ym11/hNRNnnreMJYC+BbpeEOH6XB/dcrkVp1z+1e8e9Eyfo3q4Ft9bSBW0exbu9j3
         MmE3I1CgG6wFBhOCmNrq3NsSDHUivK7QLNduIldkClfpIkuPMoWlqLtH58qD1EddgNFe
         xMuB+mK2DvjnZ2wI3pNwqH2SBMsT4cMcD2HggqswcBuEwvx3/pzo+oi8jNSdL5LIj5Gw
         Ccaw==
X-Forwarded-Encrypted: i=1; AJvYcCXYvd+BMCrEA1SFs+VS1BNq2mTLdcBqJCVhoo6bBbZBdTc1waqHTtWRvgTceQTYJ5dexAVJj11AF+o5IOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW9o3XBJrAJKXS1B0KBVtRdLEJwKeP7wuQlWDlJqcel0SSvIPb
	x5+U9QsePSvUR5WsbsLTdTFyYVboUCqrfjqZcCvjcDscHzGSBVsr5Bycgo1ihwY=
X-Gm-Gg: ASbGnctRqTHcL7oZajvj6s6yhtypc9CeZIHu/4U23DE4y54QGJG7CCugP1IzFR0Vsb6
	XHSphcaBgm0RGk1byKuytJr8yh4QdYqAUB9lp3epYgcZnIidbWIx2rzSvecuwEizT+AoVM4XrVY
	PX74bAAxtM+dlCWmEoRZqLOAx21g0YQjI5uSKaltqF5byDl97qBwDFVVnNFqE1LS831VZYPGGzy
	Ix/aHvJBG82fCp/vAn7gON9NnEW8frDTOjapzYPmgX6QK0bsl5W6rP1vI5F3RRVKvi/ATeQDZRB
	6P98ts1DF3vgPOpg2MS4wHQjrle5E/REzLmbHvTyQmZFW8cR+JAdFZg=
X-Google-Smtp-Source: AGHT+IG6/Z+Rri3hr4qvHP6StAr0ON9USjeH/PioUg2db6lXPHGQJycOyjvnq3k1DASkiPsG+dguug==
X-Received: by 2002:a05:6a00:a83:b0:732:2967:400 with SMTP id d2e1a72fcca58-732617bfe3amr12464017b3a.12.1739782710139;
        Mon, 17 Feb 2025 00:58:30 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:58:29 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 05/10] genirq: Introduce irq_can_move_in_process_context()
Date: Mon, 17 Feb 2025 14:26:51 +0530
Message-ID: <20250217085657.789309-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217085657.789309-1-apatel@ventanamicro.com>
References: <20250217085657.789309-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt controller drivers which use GENERIC_PENDING_IRQ
can move interrupts in process context for downstrean devices
which support atomic MSI configuration.

Introduce irq_can_move_in_process_context() which allows interrupt
controller drivers to test whether a particular interrupt can be
moved process context.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/irq.h    |  2 ++
 kernel/irq/migration.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 56f6583093d2..dd5df1e2d032 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -615,6 +615,7 @@ extern int irq_affinity_online_cpu(unsigned int cpu);
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
+bool irq_can_move_in_process_context(struct irq_data *data);
 void __irq_move_irq(struct irq_data *data);
 static inline void irq_move_irq(struct irq_data *data)
 {
@@ -623,6 +624,7 @@ static inline void irq_move_irq(struct irq_data *data)
 }
 void irq_move_masked_irq(struct irq_data *data);
 #else
+static inline bool irq_can_move_in_process_context(struct irq_data *data) { return true; }
 static inline void irq_move_irq(struct irq_data *data) { }
 static inline void irq_move_masked_irq(struct irq_data *data) { }
 #endif
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index e110300ad650..5acea2ac57be 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -127,3 +127,14 @@ void __irq_move_irq(struct irq_data *idata)
 	if (!masked)
 		idata->chip->irq_unmask(idata);
 }
+
+bool irq_can_move_in_process_context(struct irq_data *data)
+{
+	/*
+	 * Get top level irq_data when CONFIG_IRQ_DOMAIN_HIERARCHY is enabled,
+	 * and it should be optimized away when CONFIG_IRQ_DOMAIN_HIERARCHY is
+	 * disabled. So we avoid an "#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY" here.
+	 */
+	data = irq_desc_get_irq_data(irq_data_to_desc(data));
+	return irq_can_move_pcntxt(data);
+}
-- 
2.43.0


