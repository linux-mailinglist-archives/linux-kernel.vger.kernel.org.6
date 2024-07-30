Return-Path: <linux-kernel+bounces-267638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D619413C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02952B26D83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406B1A08B9;
	Tue, 30 Jul 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZfrWquEC"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767219FA7B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347969; cv=none; b=PzTIEiHIOUo4zej1wcBqR4HFfHNSF/iEeocgw+KknIIxum/uHIC/512fHOuLX+ecq5CIWfbVLxoKI8fSmxuoA4pT/q/cgLcqxZfTMejdyauULyO74WSS/Juseby3JuzZQM5TK+G5iDQNqTkXtBPGGLECz8WiTlwwX6nn9hsYQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347969; c=relaxed/simple;
	bh=WEvhomnXDDuN2QQ1i/LUg4PJpIdwekJe8Kn0IQvAlcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SYERLvV5MRmPGLmYaCHSx4sQKK/hBw+0/pUd4zy9+4JIO73jEWzTCzSrOTM+1mozkNSzFoQ0ISOt7PZKNOUEM49JeDrt0IkQf/FvOoAo9iEX80tM5h2sntKotsDENCc5NnCfaxjzf0v2DLvVw1sy3BrS59G44Z8HpqGXn6fPIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZfrWquEC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36887ca3da2so2085067f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722347964; x=1722952764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4SiGwxv+GpYFMy8yihMexUGzaqbAnscr5FG6o9leBM=;
        b=ZfrWquEC+x0qbDLwohwY8Z87IYDVqFCEFimFj1jI9bTEuAED/z8Zw6ri8mjfp82E37
         tn0RGHuXYE/YgXYQo9PE9g+vOg4B8M/QErgiGbk14d94/PA9nNJOQLQlYKBYOSxLgyWv
         WPv3ooeJ2PWsgnru8b54B84Pdp4oj0Tg9F5JDk49FcWGIiZehtnVP0mLjPZ+u6ELyWlI
         kh0so+2oKtfqZLVUhPlrV70Bt2CbqcLzndEysicXDiUwmQZOblnpSj0yLYNFwT4/rEVm
         ZjC/Ed/RxECUwQ+pucyfpNDoX4OWHHz5FS96n84hcaYKrHAbglmZeGrHEVEJjgk8vmKt
         tAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722347964; x=1722952764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4SiGwxv+GpYFMy8yihMexUGzaqbAnscr5FG6o9leBM=;
        b=XcovtgyA+xD7og86ukAZn/nBankYb6T1wP5kXX3EouDpaD+nTqPo5CvyFExeTwawBV
         KRYI3UF8zf2MpWw/mVTWC57CLSvOERD4Vu6ACElUp33Lqkv+ZOj4/V1RM3ZbeJ145c+h
         zgsT0hn6SwEq18i9Ra7kmPNnPiIHj29XEU9Lg5quK1xSxZkO9u0kWCWNBIIVaojB6LVp
         YEs1yuPhdDkQ5lVGzAZhCEoQmlzdj/00htNahLlpXY68WLXEA2sg6rL2sJXyFYFORQeA
         +0qsv/Kq08rW8e3qxN9YWzXQ/DCcxnpyZde4r8YR4RB2mIAXY9xlGdIph1uLbGt/Mcwh
         NRSg==
X-Forwarded-Encrypted: i=1; AJvYcCVgmW+hTF802SUVeyFkxwuNl1cDfIc06TQ7SB7c8RX+pS3+THDB6o5e3tKuJsvDOEeBZ8jbpwawG1ZiWDODpp285gssQvzIm6if8vpK
X-Gm-Message-State: AOJu0Yxh+8c6oDOYxzCCZnWGR9wnLh6rTInccFPu6cJz8DNi3taO9q+M
	QwqXxJ9gENeuoDs3QdYRf46hwtmWy9c+SV4vsOTCJRWI2gic6lu39xNNHwH1FwA=
X-Google-Smtp-Source: AGHT+IH2BtPulAguT1+cAEJxnp1N6qxal/SAgpXL+hqSe7M0GC7DNoKGOzPVXDlTkJfX0++s9uKgvg==
X-Received: by 2002:a5d:408a:0:b0:367:f13b:ae8c with SMTP id ffacd0b85a97d-36b5d08b2admr5567861f8f.47.1722347963623;
        Tue, 30 Jul 2024 06:59:23 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857c78sm14685815f8f.87.2024.07.30.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:59:23 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH -fixes] riscv: Re-introduce global icache flush in patch_text_XXX()
Date: Tue, 30 Jul 2024 15:59:21 +0200
Message-Id: <20240730135921.156508-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit edf2d546bfd6 ("riscv: patch: Flush the icache right after
patching to avoid illegal insns") mistakenly removed the global icache
flush in patch_text_nosync() and patch_text_set_nosync() functions, so
reintroduce them.

Fixes: edf2d546bfd6 ("riscv: patch: Flush the icache right after patching to avoid illegal insns")
Reported-by: Samuel Holland <samuel.holland@sifive.com>
Closes: https://lore.kernel.org/linux-riscv/CAHVXubh8Adb4=-vN4cSh0FrZ16TeOKJbLj4AF09QC241bRk1Jg@mail.gmail.com/T/#m800757c26f72a1d45c240cb815650430166c82ea
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/patch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index ab03732d06c4..91edfd764ed9 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -205,6 +205,9 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
 
 	ret = patch_insn_set(tp, c, len);
 
+	if (!ret)
+		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
+
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_text_set_nosync);
@@ -237,6 +240,9 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
 
 	ret = patch_insn_write(tp, insns, len);
 
+	if (!ret)
+		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
+
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_text_nosync);
-- 
2.39.2


