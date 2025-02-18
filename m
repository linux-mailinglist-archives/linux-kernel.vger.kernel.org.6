Return-Path: <linux-kernel+bounces-518629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0FAA3922A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316383A7C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5976F1ABED9;
	Tue, 18 Feb 2025 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HgDAvlXx"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F161AC435
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854093; cv=none; b=PwquWvIw42BCAv57Jtkj5H5+hgiUEz9ZTCKvGtT8PXq6yk+8GhLh2722xocK4snl5UuSeNyOWFkEi5l8iNeppIAMQWKFQ27onBjxgGLgzE9J/WoQwBj38p7+Uba13G9Y9v75TSOIrcEW5TfkfydItD3ydE79P+nHUBgh873bKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854093; c=relaxed/simple;
	bh=IDHepmYeNiSGQ2IIF9Z8QJtrRavBH/P2swKcp2VVV/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swAkwj7f74ImGMW+aZQSU/Bh+nx5c6kMQofDl17GQKR7wpdl+PHwhiBRdl0994yqrbRA65ce40HSvZtGiJxOYjS/zT6V1/N2A0qqAXGi203LcfBZDf6lq6c2f4vSOm1zj7oUg8bR8bstZso4kK7J2zNJ2BkXasDvKd1tUb1fJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HgDAvlXx; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3264413f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739854090; x=1740458890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IoMFj5Vm67d64jXv8v17k6H1QwlCU/79a/V71c8lTts=;
        b=HgDAvlXxxOi8mP+hLlRDzLLvrOXjF1bXPSCHBSwbnXV098JKwVTR2Je02sZAGwqlE5
         MVzJG+9Vf7rkz3AlNjnkiBoxrXMooxheyHjZkQ/tFL93Mhh2WYyKTwpuuEo2YHdAu7U+
         n1xZ3a6Qlc+lwNcZ5ljKZIBu4yUmseLTRTy8YStPNsFTBJY2Jv1Xg92iSbR/sbu0xHEu
         AGbVoofnd3KlYZoJfGQjI2DBOeYrqei2pBGqbq4zPxuVbuOBC58cSEtyroY3LcoUz9eJ
         jiVz7aDiqYYTehfq9FxSk3ot9rJLR09jw2R52yEKLQoYiVMrURGPGyutjIM16y/qCZvF
         oNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854090; x=1740458890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoMFj5Vm67d64jXv8v17k6H1QwlCU/79a/V71c8lTts=;
        b=BAx+LsO6Bddw7c3IcBar343of+iHA1Pp4tsmcP5o0qb4NVMgtR7ETtLIUZAT3I6S28
         zObcCz0x9G7LOAEN24k68FvLfU4jcAMrHKLOJFuSHtxL77YOKRHu1tmgeJVHzOMJ/65S
         WmTDNcNtJPJFel2yzGt1dy88odccEoJMoQlA9HsWJpSVly+9JzTBFymiXj+XKI5MZ5is
         z/P9+LFPLMvXu+Sk3YEjv/1rtSJYIvK29Db6bYNwgposJeuGTIWpWIP0ch4rS27cMEc/
         OrPCGTuZk6tYmfjcGXFg0ZaA4Y35vHMWjhuOOTTmrG1DuBZSrmz1oaUEr3OctOg2uk/H
         9YpA==
X-Forwarded-Encrypted: i=1; AJvYcCVZiuXmYnTm0z/mct9jiVou9w8k3G5Ip9enIoWVv6GD1WEkfaZvzSnyZoB96G482abGfxrGkxttj9o9r1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tKLnxkBNhPsN6vbdCyLBDyvQCcjqyxDB9OZKlbloY8YwolHC
	SwlI70MOriyRRHD4VkeQjR0D0ceNN9cnLEdxUIF6DoEGk4cN5tOxVUD7O2zbOq8=
X-Gm-Gg: ASbGncvfTIIkExrl6uh+fGTeMRh1aQAUDzwXe4yqWWXR/ruPYmQ5NY2GLJLBocWlk1j
	7C2DqRc+1CIjqdl/qsyTOETvUrD3NL9Urn1FZshiCk459G8mlwrWjCYilqsVfNT0foR2Oc3AFxP
	1HFxSh2TiHD7iFMOBlGcC0Oo7TPyczzAGMn980c+Ho+5JLlFpISq1Hurx5tR8BIWjx8J5g+PQT2
	Y21nvA/+7t4rUHOhthCmyaAlzPEvD3+ZXvYQasTswGOAK/QozeYjqTtOhtpLxCIQ/Z1N/x+KBD0
	//TBk4pUbfpd6Ir0
X-Google-Smtp-Source: AGHT+IFv29p+3UIr5LNNK4VzmfCWlyKJ0cYxloF+ZcpQRwkOOdASTb7wqpLFPX1JBPccUl/8XIHVaw==
X-Received: by 2002:a5d:64c6:0:b0:38d:e3e2:27e5 with SMTP id ffacd0b85a97d-38f33f37467mr8604249f8f.5.1739854089691;
        Mon, 17 Feb 2025 20:48:09 -0800 (PST)
Received: from localhost ([2401:e180:8d00:54ae:3b1e:ed6a:2e2:626a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349510sm78786815ad.13.2025.02.17.20.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 20:48:09 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Vitaly Chikunov <vt@altlinux.org>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Abhishek Dubey <dubeyabhishek777@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 1/1] powerpc: use __clang__ instead of CONFIG_CC_IS_CLANG
Date: Tue, 18 Feb 2025 12:48:01 +0800
Message-ID: <20250218044802.17302-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to include chain (below), powerpc's asm-compat.h is part of UAPI,
thus it should use the __clang__ macro to directly detect whether Clang
is used rather then relying on the kernel config setting. The later is
unreliable because the userspace tools that uses UAPI may be compile
with a different compiler than the one used for the kernel, leading to
incorrect constrain selection (see link for an example of such).

  include/uapi/linux/ptrace.h
  arch/powerpc/include/asm/ptrace.h
  arch/powerpc/include/asm/paca.h
  arch/powerpc/include/asm/atomic.h
  arch/powerpc/include/asm/asm-compat.h

Link: https://github.com/iovisor/bcc/issues/5172
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 arch/powerpc/include/asm/asm-compat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index f48e644900a2..34f8740909a9 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -37,7 +37,7 @@
 #define STDX_BE	stringify_in_c(stdbrx)
 #endif
 
-#ifdef CONFIG_CC_IS_CLANG
+#ifdef __clang__
 #define DS_FORM_CONSTRAINT "Z<>"
 #else
 #define DS_FORM_CONSTRAINT "YZ<>"
-- 
2.48.1


