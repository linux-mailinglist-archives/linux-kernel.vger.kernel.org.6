Return-Path: <linux-kernel+bounces-536298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB4EA47DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F4C3B6465
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D830922FE13;
	Thu, 27 Feb 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WWt95wJi"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC022FE17
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659806; cv=none; b=u00R1jBP0/Kc0deLkQIjht/U9/TxKTHoV9Eqyv4SziZVCvD4wRxN+kxnfZvkDQOsUcvJrukEUWh9gQo7pQxQN58Xuw9IVmNvh98fRj3jloyqH3pYXTV1WnNNzITt+lk7oRZR8a8RilH9eSIqixOPoE9PSxsmQppJju+2uNrpUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659806; c=relaxed/simple;
	bh=4W8Vqpl+3IMkDiuQlRiTKkhuW1t/YZ/ZWyYWVjVjiH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAMOAe83le5XAWfZG8bX0E1FtXoXgm83II0xAHrE3+JS3L1CYCv/a2aB9z0MFAcWG8k72CWssKUlc1mleQhYaiLmjRT7ONy3AqMqApj1Nq3xdSrpmMKPzOdOYTFU8WTQzqB7OaZtRM+snJ1fRh2nZmHg9Ep6uC/ra/RgFHRclTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WWt95wJi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fe77285e12so1670526a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659804; x=1741264604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeQ9SvTwKEilvSawoBKDfpL5rlVs3kDSMMrIWfL/lr8=;
        b=WWt95wJiIaUPtTEagHmAJfPWF4WsTvLJJ5r6dBuGBiQPe9WtLVOUuNVWDqOa/tb2O8
         IzJeOxNAJZFigDiuVgl7a5vLlBtYGc21O34+od80johgNmw1+NzWO3JNCZeHWXYC2Q4C
         PFc+tn3NM2nNDptbiZagMjCQeUMzwK6fGZ8zxGoskaOmnEFp4gDXJ9FRpWbhWS2w77Ov
         JlSN/B9GMVe1HN2Wc19EEIej9PvKfRDCuYrLc4uoes8ldumWlEBilOb7ofjCB7MACiab
         QmRQdJUPrmFdziLvxPkt25XevTD6awiXWj8tLfm0WB5qK4Z6JOXVtch9OlCU+DS2y12s
         +y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659804; x=1741264604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeQ9SvTwKEilvSawoBKDfpL5rlVs3kDSMMrIWfL/lr8=;
        b=u1/StZp7tuxTdGtfq+EqS6AYh+bM4i6Gvo/SkWsCX6FEo5oiIkGsora1WTIyUd2bow
         mpkoJs6MDby54NhOKwfvo5qhJ2OYsM12cSTYlhtDewZxWSS1wVfQmKRZhM1lRjVU6hT4
         kpXJG7hcpScCiNRa0bS2+EpqLY8dxP8lkYOhgef1KNixlj8On2F7LaNXfQZ3IPTt4C1+
         c8UJA+sMEjZOB3KHhP9vPCpFMrQOkgrvZkBiXI8LoLqy7o5bibXB16hdiBmiJ4aPhCMm
         r7x9Omzzx206ebN0pTlqH9zalnh7H8T+mIRPfWrnmGr9qasTaW9GB2/HLDWUif7uOiyN
         Y9gg==
X-Forwarded-Encrypted: i=1; AJvYcCUV8+UsAf3j3zuhNOT81QrzhWsP6x8pDbqVMjkMDKktDybzS6EWS4N5Ibc6O+XLnmiL2vZpVdqP0xlW9uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbCLMYx0MZK1FYCWVMp61qqTaDqVOHNuI61pf6uAh7JfS2NFQ
	fTtW+GzfgeTfDRt2dYmfDJgJQ7F5Fky3mqcviFDxLpI/HIn+AqKuCa2ESeVeiWY=
X-Gm-Gg: ASbGncu7NeR0etvE3T0Hx3U3YWcDN/w63KVeybO81Xg6DKm1g2XK94DVK2bOJes0xa4
	fbyEDBIimjt+D5iDm2CVTShlUhqEd+d8nKMHwKadQ1B94BNXw56GQaYsw1MPHY9QIlMGDX4WZeI
	mfi8ZN7OIP7Egj+0foam9QJPAWH+mFdE07omnb0StFZyJRK8PTmW6EtoWSG4f3IxlliJJxUM9Cj
	nPuQVmlIcfpcxIuIaY8zno5cJRtXtyrLu2UPe6/to+YgY0NuwcQDF7gSkp2+2wxappX3ywxoQ2C
	IWS//zsC0b1uKLEZnvZiSKr6/9o84KIdS0+b
X-Google-Smtp-Source: AGHT+IEWiqnbZ4w9mnQftgIr33jcau4DSGcKb/iqQJqvpeA7JbmmClnCCIaI0W3mRc0c/5zLfcvALg==
X-Received: by 2002:a17:90b:2dc8:b0:2fa:ba3:5457 with SMTP id 98e67ed59e1d1-2fe68ae6c4fmr20594318a91.17.1740659804130;
        Thu, 27 Feb 2025 04:36:44 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:43 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 01/10] riscv: Define ioremap_cache for RISC-V
Date: Thu, 27 Feb 2025 18:06:19 +0530
Message-ID: <20250227123628.2931490-2-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 1c5c641075d2..e23a4901e928 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -30,6 +30,9 @@
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 #endif /* CONFIG_MMU */
 
+#define ioremap_cache(addr, size)					\
+	((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
+
 /*
  * Emulation routines for the port-mapped IO space used by some PCI drivers.
  * These are defined as being "fully synchronous", but also "not guaranteed to
-- 
2.43.0


