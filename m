Return-Path: <linux-kernel+bounces-383316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1599B19FF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFCC282B1B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F131D7E28;
	Sat, 26 Oct 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jtLEsC/F"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CFC1D5CF2
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962891; cv=none; b=jxCpzKxga6O1e6MSd/jQ+pDDtgSM85BgzMYcBBXXd5ZFt/FeaRscWmbzTJ4oFEjm3ojar/r1aCCmBc3VAKdBRZ1RT5CdfRQ/55P5etTiRpveVbTrgfB1ZYDxLPR2vjGHL36cVhVurScamf/tMLpy7ixQPzmjDbbQMC4kvibWYcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962891; c=relaxed/simple;
	bh=rd6YWwjPYp0QiSDAMTFQN/MxjYmMfqqacnTci1hEjQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1vdc6ndv/cnNktMcIMezt4PE4377lOf656hA6en36UdUBxx95KrJ6EiG1MlHzDLfGCdJfekqIbRdgzeZkgowW3nxGR7yTDRSaQtrRlnaXsWasBs0xQ+ypbqQ8hg/mONkv0wjN3CcNOZ0CX063yuZUYUi/zc+X564STZz3IHwxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jtLEsC/F; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so2189277a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729962889; x=1730567689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv7+Dx0EhtdMcX+vS16ls1Tc801PV63GFkQzeGMvPJc=;
        b=jtLEsC/Fh9MxZMkFC8hwa/XisucQFaTJZ1zVzzZJHAB6O9rz1rCVuOrTXTaKbYjigx
         5zJJ81T96asYkiuXvKEFm5Mvp9CG0VVRukXrNdYcL3zLqo6EmJj2h94+mwkAVa2wrNuc
         SrYZa0DcbhDehj95RHAoZM/eV1TUeiIPw29kZx/4sls/vzAjtuh6dkPMnOC6uh9HmFy4
         ogk1jGzFrcVwg04J2WVMCje0SIyWn7MTF+np6Y2gyyxSWRQQNfyFENoozT1iqQcuMUO1
         KId63ivS6F3hM1fEvlEAHTdMKJ1lushxd1+6hl9ieEJZa7+J13OaiVd77coUaC0X2yVU
         thiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729962889; x=1730567689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv7+Dx0EhtdMcX+vS16ls1Tc801PV63GFkQzeGMvPJc=;
        b=KemsCMHgIK2gMJLP6NfikLQGxzZu9JOTeng6U9UQqRKxYxNYacqL5uGOaGHhvrsv6X
         zO5J1+1iHCa8cfW3he2BocxBj9iGRvUa149iUzysBHzi8OnsNXZC51A6gJkUjjCRTUTt
         SzBmLydkh5Grn5QcJEPM+GG9Rxr3IDumyNNH1z8oSdr8l0Cdt533sAwZIqS8ZcpOLyHR
         DAeFyX7haXbNwniIMs+fz1hAimpO7/lZpYJ4hWDXRrrUqvKJHyt43VvDY56NHQ1WcTH3
         Sln/orAzAxAVx0FfzlJ5BBxUCwAopXBIfX0oMKZTyjAJrjKHU3D2aadWY9h8RveCC4Lf
         ddFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGrOym+JkIqp/LjRQHbff1KoFkv/vH92lUnQJ1T1+goaBYhF4z3w0Ei26Y6lS+Y9MuPASo3RWMu0nwpNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJMppglvj6mf1Bhgm6/SjxsXfHOxFYhxcOLg9FgHhL9kIJz+K
	lkXTCxyU0s/i+g3LVxsgV3g9KqUCdd+4SmS5jm9Bc7wqV4/76DFY9yu61+GuTSI=
X-Google-Smtp-Source: AGHT+IEjLY5x3N7GeCdbR6UpuMygbezclirV4ORscEH6CuiNkRrH5F4MjYIKgmPWwSgRogFjiRq95g==
X-Received: by 2002:a17:90a:d807:b0:2da:9115:15ce with SMTP id 98e67ed59e1d1-2e8f106d6bdmr4079277a91.15.1729962888814;
        Sat, 26 Oct 2024 10:14:48 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e558114sm5663762a91.36.2024.10.26.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 10:14:48 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 4/6] asm-generic: Always define Elf_Rel and Elf_Rela
Date: Sat, 26 Oct 2024 10:13:56 -0700
Message-ID: <20241026171441.3047904-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241026171441.3047904-1-samuel.holland@sifive.com>
References: <20241026171441.3047904-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These definitions are useful for relocating the kernel image as well,
regardless of the type of relocations used for modules.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 include/asm-generic/module.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/asm-generic/module.h b/include/asm-generic/module.h
index 98e1541b72b7..a8622501b975 100644
--- a/include/asm-generic/module.h
+++ b/include/asm-generic/module.h
@@ -19,12 +19,8 @@ struct mod_arch_specific
 #define Elf_Dyn		Elf64_Dyn
 #define Elf_Ehdr	Elf64_Ehdr
 #define Elf_Addr	Elf64_Addr
-#ifdef CONFIG_MODULES_USE_ELF_REL
 #define Elf_Rel		Elf64_Rel
-#endif
-#ifdef CONFIG_MODULES_USE_ELF_RELA
 #define Elf_Rela	Elf64_Rela
-#endif
 #define ELF_R_TYPE(X)	ELF64_R_TYPE(X)
 #define ELF_R_SYM(X)	ELF64_R_SYM(X)
 
@@ -36,12 +32,8 @@ struct mod_arch_specific
 #define Elf_Dyn		Elf32_Dyn
 #define Elf_Ehdr	Elf32_Ehdr
 #define Elf_Addr	Elf32_Addr
-#ifdef CONFIG_MODULES_USE_ELF_REL
 #define Elf_Rel		Elf32_Rel
-#endif
-#ifdef CONFIG_MODULES_USE_ELF_RELA
 #define Elf_Rela	Elf32_Rela
-#endif
 #define ELF_R_TYPE(X)	ELF32_R_TYPE(X)
 #define ELF_R_SYM(X)	ELF32_R_SYM(X)
 #endif
-- 
2.45.1


