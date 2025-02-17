Return-Path: <linux-kernel+bounces-517213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D394FA37DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D827A2AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852BF1547C3;
	Mon, 17 Feb 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BG1L7W+G"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084519E7FA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782720; cv=none; b=SZyKvvlsgMur1VHLzVtMQ8h21pcwaN1KHdYJXgXOZZbgVj479i+JUKp9gXTqMOXZqueBiG9nHpKWSbRLB/Q/XQBUUvNszLkB8pmSecP7OCEDyBJcJq9BM6GBPtqqpDPvpJk6WHvF31ZwoWRaGkuA8mZcf4dPmjvjW6VFJk4goVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782720; c=relaxed/simple;
	bh=n4slH+wgDA6MSJsnkDzYIOL0zzUU8vlxw6wGI5nPdQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU+RZA54FM8uh27PNBSUa1GPsSMA/aILxRecI+cdOWCNIQI50zz5TJNAjuQ3WbF0mQFDeXwaoLoYfwvqz3Zu0fPk62k4yDfYmUqiE6NrLxWbSLprBVnHKhMjyQ2NGEe8E8lqXfVhS7Nw93rYIk+nsHrk3SeoQssRpK1hq+ysehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BG1L7W+G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221206dbd7eso15647325ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782718; x=1740387518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBZXTbuS/jzxIISJXLRWUHAJ1oANsva3E4CzlwWomJY=;
        b=BG1L7W+GJP/Tdwxcw1LxdIh2hvzCJRPde/VyaPhupVxOCqlFzc5cbyeDwXf+8tkx2n
         izBa4EdSHTriAYf/93FvA+uP4NXe0eXIffuPeYTBBUUMy/GeXP6DOiQhZT2biuzBuI8V
         S1CdmqsqLVmiZbHbrmQPVTBflTYFjwofpgW8bNq7miqpxMKDAY+kw0/d3aBzwTmZgXVs
         X6WVQbbvRnTKOU+Wh+fo8Jfvf8Aplqmdny2gcy0Vnl0xXMmpYqSAZLtS7Rwq7zV0ZSuX
         qBGhSGaPO84rGjCW+vmApxvHOl64A+9VjDB9xKi9Tx8PosxaXkZ/xBIgGJnk2Z1kPOvn
         qOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782718; x=1740387518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBZXTbuS/jzxIISJXLRWUHAJ1oANsva3E4CzlwWomJY=;
        b=qUSBEu4CqyVdpkYgcog9r50QJb5iokBBgOfGpyko/NocOHO4fIBTZYo1eapz5wUaOt
         xjdHuVEeJqhYswgVsVch7fJ0RYONoFFDfnsEJj9acfudgDAdIodXXZqAw8vArWcwyrG5
         JwyLeP71Z4NNXj6uxP3DAUNS77VRfOTpXgjFhtJA19UYwO13Gdq0YoJV6utN9j7RpPjh
         ITuCv7TQ1unW/6ZYvx25KaL52PbW78lUJMK5DHRTyNGBO4c5P9ndovOgzbEUmS1MmbbT
         l4qmaOYtKVALfeIRLyaNnVPKcSsiLXxdDAOepmtxQWHxdvFua7a2RzPb6igSlSpKnf/0
         KicQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRa2ph8H1qnKrfgG2Clnq+MPyBSJCSFQL9J72UaLOyPob3eT5Ap35GwtK+035CSd+EnY1CmwMC4gHqMFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsA410yrye7yyUlVN4T+ydvnW7e9rYM5Twd3xXtXsxSRv+k3rb
	Rx07I/pd0PFbmUP4k/y6KRBA7GfaMcP9JFntNMT6Hzx3A5MKSPrMVQrSz9ViCcY=
X-Gm-Gg: ASbGncuWrK1HONicnc8M7AA+k27pGLxs+0Gx03R5OGKeBg4AhIDS4+Ur5vOKlvesYwf
	KD2Xr6txJhd/jJ9QUtkJphrIzgznDWGR5Pej4vk7Aazgy73Jy+kBwBkrYwT8len6jQRFRB9n22q
	xGy7DH3Bb5ZKeG/cr66B8by2xKGxcZuiGGwiTHGEE2/0U7LfWokOmvYKYz1g2g59XtKV4mvswLk
	EFZsAYCdQsKZI3qr65j8iXdPt5r+1C42Kgf0DGCpzN5LLgLj3sjZkZ6NZglEBwMXZAeT/NaZVGO
	SJhq7VlrOK0Z+0HP83LEwEKHkio/7reR/p5w86+6ymUH5dkEVyGERn8=
X-Google-Smtp-Source: AGHT+IF5wHBOeSXkGQAxYL6n4RikPXg1rsQVBSgGjP3SNk1+gp0GdS9NH13FpIk5wtFAo3PxZIMq+w==
X-Received: by 2002:a05:6a00:3d0f:b0:732:4c47:f807 with SMTP id d2e1a72fcca58-732618fa196mr12143576b3a.21.1739782717876;
        Mon, 17 Feb 2025 00:58:37 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:58:37 -0800 (PST)
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
Subject: [PATCH v6 06/10] RISC-V: Select GENERIC_PENDING_IRQ
Date: Mon, 17 Feb 2025 14:26:52 +0530
Message-ID: <20250217085657.789309-7-apatel@ventanamicro.com>
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

Enable GENERIC_PENDING_IRQ for RISC-V so that RISC-V irqchips can
support delayed irq mirgration in the interrupt context.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..a32f39748775 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -111,6 +111,7 @@ config RISCV
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
+	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
-- 
2.43.0


