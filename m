Return-Path: <linux-kernel+bounces-436909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E49E8C84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB80188646D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E78B214A95;
	Mon,  9 Dec 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Sy9FjADD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BD215072
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730316; cv=none; b=MbpKqDHkynveiTvcf4E/nknAUGWzu1hwHj+J8uj5+TFzLd8F7v0PMj40krV4fR8ZABT5Df6fjj4itRyTxSncOaBjHIrxo70fZnKCoH0c3D4lRL/t3FqkhgrYk/k9hke7avBq4rcksXyfhq9Kp8xgwN2pz15YMT0+P2o2J6yVPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730316; c=relaxed/simple;
	bh=HCAW8jEmJkAwzKjYDv+HGVlojiGSyOVesRmh/ECAvvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VnNWwFOnDLWTQUJuQeA9RuONybf2tB8OAKfeWoZp503bI4zFkutxU4t+BvxWRJy1PNb4/jxSoVvmDTVxhfSswEADk9UUTLnPVQ0sZZrrGAURR2n4Gb9aBVHd6fVrSFk7RWx90LnMa8QYX2tLre0tixWl2rd/plSPZqe/c+KrsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Sy9FjADD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434f0432089so12602195e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733730313; x=1734335113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcyXUAz4b3DdPe6MIyU8hAlJU3yGxHg69N45Hq+y8kA=;
        b=Sy9FjADDI4p9RmEVUPrCUkLz8+9KdE90DUwtgV2V/7ErE7KKMVzHMncqs20cZbcYij
         gVSYFMbhCfPuxtbukbdTyNK6igrI1vaecV5R3gxzuSbWafzlVptwxJulX6hKEkj8/bG6
         NDdtNcr+MEynG/aFOMPX+SL52dsLA4o0aLVPnC9/CvMBVwZf/iyfvBDkcqVnLrrCigd1
         D6hmxqdeP2pQEC7bjs9YaZJ/Fqu/79j6lt31BzK76gtFQbE+jhu0Nw6W9fVDPsKC5viH
         r+OTlhrcVJSC0Hposq0hU3w3wZxxIs17wrJxJ8rLGpBtyIkx+j3mznSusLRKx5gBwuJa
         9H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733730313; x=1734335113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcyXUAz4b3DdPe6MIyU8hAlJU3yGxHg69N45Hq+y8kA=;
        b=sSzOhZPPljFDs1YoLGAGGGA2RZYQqi4b6fl5e1RfUWkF9nPk0/OYG+ht6b+v0za4D4
         YkOySSDmDfwqRMxSyNwGpqrHvjKnIX42p/D86rt+lbCQ8UHt14vgQAL7SAvw52OZLggk
         7FUaHPCoDCpCr59DIxdftP1Me2oVtRch0JF5sBp6dn5bDsZ4NimNDHz/mKPjhjc5SSSk
         LoKVhmL5kKJFGRx8aUmgZyq0vIphZUOza21rXYwDsFXuBPQ6OwIszhUYFl87spD5nMGX
         ZIxG2GYQpwGBhVLCtJvqG36PXx0uf3SRlrLIdl+SGu0FSAEPeqV9JAtbvBxjV2jmcnG7
         3T6w==
X-Forwarded-Encrypted: i=1; AJvYcCWExC+L6lImu2jKP6DVptL/xG/TiOpVygZPG+scXAtcwlINJZYBghgRYDgbU5Uk+uD+70gxOunJoO8nAx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGN8EsGaM1xq8xUEuYYnQ8h08CHC+cqcd4G+5MaAEkgmp6Z3w1
	KARHEd4KMAhjMFf7LmkdLQtoKp2zE06c4e/VDnpMgPWyliBDzfoYMevimZOBQ5I=
X-Gm-Gg: ASbGnctkN3iLoE2NNVeBjCtTa8xsZhlN7AVo0Z5EnA38kNhYIAmpRPbDvimuDhp78qj
	PiiQMycee1NKFIAEdPgF17Y9wxOVd9DJsduU4GuMPy7WjfnvxbCgvQTk9Vm4wafdm1VQ4PYEItq
	WdyWBqDr8n2ra1n/R3r8YbXik66st9BFxHGZ9Hw9irvHztmZfT+4VnxpWOaFhFJ0/JLyBbJ0I2c
	DzDovRqvuNPqY0qgzQnDHF7/upbCzafLyCmUQm2K3uxOWNuy+qV+U2euTPdDK4WUo6IETSDe4EV
	jkDH54mqXHWDvtSWrQ==
X-Google-Smtp-Source: AGHT+IEv3hJmUDl4OjMfgDSl5NjxorbWzxMY2ZLItHCtIEDk3YFd6uE4Bo9cwXQKYhJvheOPnw0OXA==
X-Received: by 2002:a05:600c:4fc9:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-434dde6b9d3mr102698905e9.0.1733730311394;
        Sun, 08 Dec 2024 23:45:11 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm185576695e9.44.2024.12.08.23.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:45:11 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Usama Arif <usamaarif642@gmail.com>,
	Rob Herring <robh@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes] riscv: Fix wrong usage of __pa() on a fixmap address
Date: Mon,  9 Dec 2024 08:45:08 +0100
Message-Id: <20241209074508.53037-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

riscv uses fixmap addresses to map the dtb so we can't use __pa() which
is reserved for linear mapping addresses.

Fixes: b2473a359763 ("of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 016b48fcd6f2..45010e71df86 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -227,7 +227,7 @@ static void __init init_resources(void)
 static void __init parse_dtb(void)
 {
 	/* Early scan of device tree from init memory */
-	if (early_init_dt_scan(dtb_early_va, __pa(dtb_early_va))) {
+	if (early_init_dt_scan(dtb_early_va, dtb_early_pa)) {
 		const char *name = of_flat_dt_get_machine_name();
 
 		if (name) {
-- 
2.39.2


