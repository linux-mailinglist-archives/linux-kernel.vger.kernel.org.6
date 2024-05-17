Return-Path: <linux-kernel+bounces-182240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7517E8C8885
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315FB288388
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B266CDC4;
	Fri, 17 May 2024 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GWlqz+5u"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4A6A33B
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957601; cv=none; b=bwJ5Yk312MNOSzWKCKTuqTEGtzKrN2rVmcvwY6P9o2tt0UPolvZAamlK2C6vZlwXSkPICefq0vGRbEhqCKdr/QqRKicxVnzj7mZ3DJHRpP/9R7Z4ayzqkc9gkonBr8qIFakwhMDZjHdItauCs0w93rWCJ/E+s6TmTvbmxVkpTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957601; c=relaxed/simple;
	bh=fjweRB4T5U9ioBqhvUX+N0QScQOQt49OiYdErFsiD4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3nAy+KLnds1N9W8LwQHHB/0TOYwfR9n+vayXlVuJS+F08/MbIKJwdNCKRLpN7JIQgQAyrKcTAFa6oHwPnAl8MebnV7mXr73m901MxdU8aEqI0mY89zPGEClPQQqk0+w4iYp/hKvoWvRqkViTGTDiMxODPHsWnl2RkZe1qkJYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GWlqz+5u; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e22dd47706so275581fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715957598; x=1716562398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYWkj0uQleaCMPiVc0IX1xdL2m6WhFkCEPxGzctu0Mc=;
        b=GWlqz+5uEBGd/ns2EOHHIrIk3xjDlmU+7+3eJ6RqkZL4dJFh8ibDeWi6Le43quLq8t
         3eZ7W9oEzQCWISdvqUHEwZbPAdQOe/RDB2r8ZXQcJtnRLyf3APRboubHGmdO5bjiM+si
         KEVdOF/pQE6yQvnrammqtElppxhs7Mt6fJBiKhdr0BCW+BHEsH5irVYtpBp6g7VVpCLi
         TL1A+2HLaes7eVqBaxVXk9J5b0iyP2zJiQbBM2Ucnd1fCrflfpbSHA3F0l9BBGnROjmh
         mGyzhXnjKF7msVwRMhQrNviBGoP0C3DbReBnNBrahGhu1cvb1tQfRhIAz8qywGs/4FGM
         EuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957598; x=1716562398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYWkj0uQleaCMPiVc0IX1xdL2m6WhFkCEPxGzctu0Mc=;
        b=De4dn0KWn4+buX6aWyf5kfLd923PR3/FI00c07zeUuZZrZfku9TM5eeZ8eUpdoLlPD
         K1j///d00aCBL9bKQ11qewjrvWpkiulwCDFlbUTUmnFug72wdU4jVw8RjjrwDHlcTvXK
         Ktu3HaJa63CXWY66+VvfpQNRmhZzFx8ZfEyVnQzhDcTGsdPVSVcUzKtuCz28L/Tkgug+
         2cixTOwnmpTTnNS9LTzVh2mZNnCmmwQTJhDXsDAmEep5vexmVZ4PU0DIxeIFkHbDFCdC
         Ay/9zRdr8xm2X9rf1AMJHEMZ8eu7VjpmNIsFQEk9qHnHdZxfbkQ+ZoaUkooMslf3DmLd
         vvmA==
X-Forwarded-Encrypted: i=1; AJvYcCVLKHzY6muSa36n92HbwxuTjn8Xd4RfNyMK5w4VWBJIJSgkVcqXdNEuKuGwM61TPE6z4irbzo7cHpdC3tafDcLeqOlGEZzBs6Iq/+ph
X-Gm-Message-State: AOJu0YwfSBecxU1xJAyrO8XW+Z3eYopJXUJETpf2VbVZDH1ph1JVVLhf
	HUoUEDIh/GqdLg5ncksl2eM6ogWjmn6UZXulP5yyC3Zz7ofgvLnmLLPbzWvtXNo=
X-Google-Smtp-Source: AGHT+IFFIQ8bCYBTkej73vjqEl/30GkvcNdlZ/nAYriy2LKRNANi0QgdpIuaZdQ1x21X/bcvyrz8/Q==
X-Received: by 2002:a2e:9094:0:b0:2df:4bad:cb7f with SMTP id 38308e7fff4ca-2e51fd4b333mr138901491fa.2.1715957598226;
        Fri, 17 May 2024 07:53:18 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:46f0:3724:aa77:c1f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce9431sm301723695e9.28.2024.05.17.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:53:17 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 02/16] riscv: add ISA extension parsing for Zimop
Date: Fri, 17 May 2024 16:52:42 +0200
Message-ID: <20240517145302.971019-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240517145302.971019-1-cleger@rivosinc.com>
References: <20240517145302.971019-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add parsing for Zimop ISA extension which was ratified in commit
58220614a5f of the riscv-isa-manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 1f2d2599c655..b1896dade74c 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,6 +80,7 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
+#define RISCV_ISA_EXT_ZIMOP		74
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 2993318b8ea2..41f8ae22e7a0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -241,6 +241,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
-- 
2.43.0


