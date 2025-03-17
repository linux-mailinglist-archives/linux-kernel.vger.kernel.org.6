Return-Path: <linux-kernel+bounces-564749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2EBA65A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AD63A567E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B82046A2;
	Mon, 17 Mar 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ofsUQIZx"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF381FECAD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231305; cv=none; b=JoEtwa+39wCyhM3o2pSx+2ZmPDIb5/DiBCyfKR3rR1uStuCLKJZ0/r7rtybq810cTwTQIXNBV+BoU1KVFJAppk9DMvJ1B5Q5z9YPxcu9cf7AYaROXRqfD/4ENBHjj7UM+SAXxXvAyuD5d4jIfmAy6ZoLaW8K9dt53Z6VI//HU90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231305; c=relaxed/simple;
	bh=Nf3XuDar9gitRVwziVjGXEjo/ltPNzme/nCKwMDO140=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZuGUQADIsr0FoJ4dEu8i600gezI0L7inQ95Sk1KotQGwN7xoYXR0kHlFAe+HMuxfZDpgr6MKlmLVgPtL5ufDU59dFylqej3yjqEvr+EAQKjljA1Xn8WHpAbOZq3aSHQueWGjeWiESSNfTj7YIpiUCpnl3q0ci+rQGvpI7bKlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ofsUQIZx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so16000705e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231301; x=1742836101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pNqCCOYMsZxxXyyqHIS5snuORKLAQN1trvRZ+awEuI=;
        b=ofsUQIZxvs8LTJ56g982crtRu6dTuFCOkCYZVrQCWEM9tNwWGc1A6HRz94CH1V87MH
         B4CtaDJ5EA8iRA8aj+Qw3axJREL5n9xqwSCj4nwn01RplBuROB7Lz67ZX7QT6akWUHah
         gopoaQKzRnZugbRPKYYYXR9uq1Hc0tC6QABH79m51W+4O9+a8g0LjEB6zxWDTjNyB/Fj
         8BcvwfOE83wsZKwYkLJpajNNfRWPrcq2hcAp7fU9fDhGmQfXVMFfgX1MmzlbctXI6MSL
         8XvmcW/VO12HZtFd+jtyTPhMJXyqBxV95XQk0bhtTKu5XLpIdVZmbhetpI9hvCzkqvpJ
         qfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231301; x=1742836101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pNqCCOYMsZxxXyyqHIS5snuORKLAQN1trvRZ+awEuI=;
        b=Ncl6gTtS3KwHSLxMfzNhPVrfAmoHF1/NnCCwgS3VKtljwNSGhBwLHnAKNsb+6qebl9
         U2/D3nIvBUP9bFUe/PBjfsjlvHEyvMKxo1XPqIQbd+W12MqAudGDa4sFIfBEL8EVcAgI
         fqLOii55LR9JGDVkDWL/9eeshNcRW6c8K641ONz04DTsFpo4Q5aI76r0gsXX7xssT1sY
         5OXRE4IcQtJ7Me3WpEwX55iSVyFrLjcOzC9U9D+yD6J/tlXID/Po4E1zZ17hTCxBUueZ
         4QMHdb+ya7IngBk8n1NisNuYo5Dm08YLJAJ0zfUxGzNEgYB/qODRhYrEt08fQuJQBC46
         04mw==
X-Forwarded-Encrypted: i=1; AJvYcCWTNCkYrJC4y/qI2afZz0UBAlW9mqvIJqmyZCHDSQTS5zjm3JR55MhLY8u4jRLN8ELYGCOMfbItO3vauOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcHo9WUO54D+L6qD3le2PTpES+ne46jDwGzkkDbzZaXjutaXW
	7o/1ue8Posa0Vxg4UVSEedMBvKbT+EEjE75Jx1rVQ3w0BvL3fmP8ISjJEvCLjaE=
X-Gm-Gg: ASbGncuWBSI4YwTSLq3NGs4IA4mH4kEIXh2BNGn8mKSxE+RZfwp8ha0zjUke2WTlWa8
	5/27BuJ70rsK7RkDN/ku5xAkpBRlLN4U2Rbm7WDiXvvotol29852HKxOqycpH9ToUnd41bN6CsO
	Q7HAu93VfUP6prPoRAfelLdc0zqG1t3zRDTkbyefx9RPOWe3b9Vg7K9hgwk/chXCeL3k32C+UVn
	Y7DwGecn0FMGOBNgG/OH3HFzUrDVihtSEENAhuWD7KM38rj7YZlTan6/CzEqKRZhQFNmujHHIw2
	HbyIQV21wkdQM6jkLZhUqEdF0Vry2Zr31wSxfesSZCo+mA==
X-Google-Smtp-Source: AGHT+IE6X4Zl2SvCnLBWCWxVkBGrawQ8DSM4qV1sZG6LsJ3FF5B07Zi+O2FlbpqV8a0E2j6PRS6VBQ==
X-Received: by 2002:adf:b183:0:b0:390:f88c:a6a2 with SMTP id ffacd0b85a97d-3971f12cd8emr13396928f8f.39.1742231301480;
        Mon, 17 Mar 2025 10:08:21 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:20 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 13/18] Documentation/sysctl: add riscv to unaligned-trap supported archs
Date: Mon, 17 Mar 2025 18:06:19 +0100
Message-ID: <20250317170625.1142870-14-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317170625.1142870-1-cleger@rivosinc.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

riscv supports the "unaligned-trap" sysctl variable, add it to the list
of supported architectures.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index dd49a89a62d3..a38e91c4d92c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1595,8 +1595,8 @@ unaligned-trap
 
 On architectures where unaligned accesses cause traps, and where this
 feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW``; currently,
-``arc``, ``parisc`` and ``loongarch``), controls whether unaligned traps
-are caught and emulated (instead of failing).
+``arc``, ``parisc``, ``loongarch`` and ``riscv``), controls whether unaligned
+traps are caught and emulated (instead of failing).
 
 = ========================================================
 0 Do not emulate unaligned accesses.
-- 
2.47.2


