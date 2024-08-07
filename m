Return-Path: <linux-kernel+bounces-277127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88694949CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B021F21C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD3481219;
	Wed,  7 Aug 2024 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZFjmZVce"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6A7F7C3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990729; cv=none; b=I4XyMoKzqcu23/vcnpIotPttzOlCTMyPHZHyh53GEtgu9efVbH3FK3T+XIGCMFE+5QiYb3vmGgzaEhFlQDmC4VsdOuzl2DyQ6XaeWUD2yPtD7urvhRK4J2cprguJOjyPucVBhj9kix7mcIgYukXm1YziQlXWZObQmMWb2Jc9NI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990729; c=relaxed/simple;
	bh=R1ruP19VNMYIJ2t74sibaC/YoWJ+uh82rPlu1gqwh/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcYeiBtOJQnwEVWdgkE89AliCu9OgDBpfWwtq5d2n0oGqEDsyh/kbJV2EbeFKJ40xywaLJt8IY4BGeCDsO73rcyrLqSb1UmCHHHUqVXZvH+8QHxW8KOcQijzEx7DhPgmdG6CYmJV8a9MJe51VxNHMX4ADKhiURXLbJlpcTWsAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZFjmZVce; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db1d4dab7fso774940b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 17:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722990727; x=1723595527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzA4CLrN9c04I0TkiHjILEnLnNrrRfsvuLr439lHPOs=;
        b=ZFjmZVcem5U/QGZzgEgeR37YHbwuFd9dC+YgzitL0wTssFyo5z45LUFrXlV2wXoMZv
         IGO2xszSFuj0s3Jzpwt8ivmC5yWdgQltWVJftA+XPKLpm5PHxwgNDGGIEbyAwgoOWmat
         6gq0OQKOdEiZGHfKrjsUtJWhI04IRms1/1+Y6jxEU71ZN9J8TseQJmKojrFsO8949OD2
         M36Jb9EcaYhnKILVPhAStRycjn/zyKiXPVeND+KIpjuGKGIeRAhF38S2ECF4S125iqee
         Hr/DXddRIZo6Vpk77LO7Qp6OTtULbCrWQ2APFj3HTXdUhznHE6FpBF4omsE666Pg26ro
         h8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722990727; x=1723595527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzA4CLrN9c04I0TkiHjILEnLnNrrRfsvuLr439lHPOs=;
        b=phD9wfChPzdNsl3EL88MOuqCTEe4fmbEy92MnMksDL1PeSMiAyDInej3TRKY0wV7Zx
         +s+RymRNSg4woiPb+s+6bGvBZM7xIhvNtmfd6ihOqw611lb45Rl4TjxWEq9MDcN+ebRp
         0+Ebh/3FNklRbjge0tGVozLoaRujupfmF9k8bywaSaaIXm75BbG/H9xzr/5vRLQSGzRm
         LFEIEAxqP3jTnbdAxtSLdr5eg03mGtj07XD0FoZa1nzFXJKpZZtjgJbsZUf49yTo53TP
         MEmL0q+kMJlK3ntJF8q42qjbtusOoiwceIMpjUOzedpZJP3wB8vVTMzHf73ZNMOdskzA
         mgPg==
X-Forwarded-Encrypted: i=1; AJvYcCVDo3fs8AhHAJQnl7Q9eWDGfYL7UXNg8jVsWkb34Qgfe8VzBum2ihjCyoW4n9/y3E0Gp34dEInjrKB+wkoz4eQaJEC2Lv8ojSvm70gB
X-Gm-Message-State: AOJu0YzXh2fCKR/s37kSzgB3GlbDTW2u+nyxk9UCjYTaSdYhJAfMmEMl
	RytGbNSINh0puMTL9F/epYuMJRUQngzKwZIGLjup9skZGHl7vaRbv/q5uKcgUwA=
X-Google-Smtp-Source: AGHT+IHqzKeTjTwY0Ng2jkjIMaChA9GIbY2sG0qJ6XgUQbDiYCd/LS4ujzMb8ElUuNWFWcAn/anGOg==
X-Received: by 2002:a05:6808:d50:b0:3d9:2601:891c with SMTP id 5614622812f47-3db5581fedamr22651422b6e.30.1722990727421;
        Tue, 06 Aug 2024 17:32:07 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm7476174a12.6.2024.08.06.17.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:32:06 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 06 Aug 2024 17:31:47 -0700
Subject: [PATCH v9 11/13] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-xtheadvector-v9-11-62a56d2da5d0@rivosinc.com>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
In-Reply-To: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722990701; l=1263;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=R1ruP19VNMYIJ2t74sibaC/YoWJ+uh82rPlu1gqwh/o=;
 b=vR7egj22DaToCJ0lFeXF/Sk8iuiDix41LIpSDYfvyZJw4L8VcHmi0ndy9Vft4en/hY8js4/nv
 GniIsQaMb+HDtS7wmY4nAomw3jUjJ6LXwfSjooY3JOkZbazmUMC4IWu
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 3db60a0911df..400753d166ee 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -266,3 +266,13 @@ The following keys are defined:
   represent the highest userspace virtual address usable.
 
 * :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `time CSR`.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.45.0


