Return-Path: <linux-kernel+bounces-442242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 851649ED9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A40281C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9D1F2360;
	Wed, 11 Dec 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lakRqNgy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480091F0E59
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956189; cv=none; b=ezGbI1sr6j11Ux8E0IoSVydYl+Oh6NxL3eAs6/tUzkxTb5UibSt/rCz7zYO9k887tAHv5tA+etxSfM+WZs+mq9Piit5V9tDSxUpKpfdnNso0aGlfby0RuMR/ydgsj73Vfs9xi3ukWwbgijGSWa2eMPoAyPz+YlahVUfK6p6NKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956189; c=relaxed/simple;
	bh=Qcc/fUmgQX6539hn3+SnUkTl2HP/l8GGH5btBJOW6+w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W3Y9/Y7/ueRSv42AnRpylEG8eVgdnkr+5yPinrQkvfD/alm9vCNigfhOa5t3gLkxx8m8jnO28K45hbyTlzRnT1PKNdWpNLYIZ209dzHKF+zIWIy4hpJBoC2dGFtKYhby95nYL+JGcD0EHH4fdRGQLcaughCI7HQhJMAUJs01Jzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lakRqNgy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef7fbd99a6so4800512a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733956187; x=1734560987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afLzMNYSjFaV1BRnpx7y6AiSvyqc3VW7ILDJntgtX6Q=;
        b=lakRqNgytYVboxBFS3AVIMmtlo3/zzGgAIVJdLLR2uvVOrVqIZ87+LhWknJqWCwAXY
         Wd2LnhIl4kMRKvBP04PKTzPcP4Lsyw7rZQtPvxruO2QEAK7aHnzBHH8sPUMSBqdN3Buf
         nABCTAQq5MKpPj2pL0T5f51NGAMFP8Nf/YnOrdg/fRnOt5b8+ZGR20g2eIn6R9qAniB0
         5H0Tj12Fvd1iN5yXvK1j6DRIrP6qn+SiJ/Vt2Tl/VVcVCYGZgw7Fvkf/BnZbi4HSuCpJ
         8embHja3gNIPAqzIbhmN2BI7CJgWW1kgGd9df8dGU+LSLtlmkTboEosILxk4/qUdOLTj
         hGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956187; x=1734560987;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afLzMNYSjFaV1BRnpx7y6AiSvyqc3VW7ILDJntgtX6Q=;
        b=hPxM4e58ILlxIRAbLXmjXYX/DMhUmLevVDs3Ob5OnzTYtxo/ZGG8Z7SHEdzLsfJX+v
         caDurDd7OY5YBK5LIZjI2VrVKPazonBYZRhNE0IVC/pTEwPEQxre8CQQ6HmbiRb1TaXT
         6RBknvQlT3PiC0VwVubQcPCCkcnM3QhsEUTrljHlb0py9XdTmAK30kl9Kgv9K3BVRgI7
         TpffK21EqiP4ijF3omia2rIyIX/FWGYC5rjZfQctwaMTJ6zXMt8nu0Gtomtd1F5a2RWM
         Uanyc+F0cgayqIIYo3SAFCoq1zx3vaIA5gpZJx1gEvAttzl6JcVPcrnmN8do4mtjU+iS
         n8lg==
X-Forwarded-Encrypted: i=1; AJvYcCUcIOGkcIW2ORWXpZZo8jtVvTiy+vpgbu8EnUguZcUhn1WVZpZ7SXjQddYvbjFpTq0kwxtTv5ZnFwCtzf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKe48jSWvfVeK8OAiaVptPk+fRP6qfWHk0uH9kp7zItAJbri7
	JeCkmyKH640CYbeTnbGyRW+Xlu/ztQtMVWHuA4o0BNgMELnV8WuKsI1ieny/dSEJrA==
X-Google-Smtp-Source: AGHT+IHSqmGnd1iKAe1UoXeEJUP+FpZhBFsJLxPPQOZ6HRTRXmgZKGnyfdbCmr4t0iV7F/cQJyWsiI8=
X-Received: from pjbsd15.prod.google.com ([2002:a17:90b:514f:b0:2ef:9e7a:486d])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d47:b0:2ee:45fd:34ee
 with SMTP id 98e67ed59e1d1-2f1280586f9mr7296484a91.37.1733956187644; Wed, 11
 Dec 2024 14:29:47 -0800 (PST)
Date: Wed, 11 Dec 2024 14:29:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211222945.1325793-1-xur@google.com>
Subject: [PATCH 1/2] AutoFDO: Remove the architecture specific config
From: Rong Xu <xur@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Yabin Cui <yabinc@google.com>, 
	Will Deacon <will@kernel.org>, Han Shen <shenhan@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, "Paul E. McKenney" <paulmck@kernel.org>, Rong Xu <xur@google.com>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The CONFIG_AUTOFDO_CLANG option currently depends on
ARCH_SUPPORTS_AUTOFDO_CLANG, but this dependency seems unnecessary.

Remove ARCH_SUPPORTS_AUTOFDO_CLANG and allow users to control AutoFDO
builds solely through CONFIG_AUTOFDO_CLANG. This simplifies the kconfig
and avoids potential confusion.

Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Will Deacon <will@kernel.org>
---
 arch/Kconfig     | 4 ----
 arch/x86/Kconfig | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6682b2a53e342..0b36d74d47031 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -812,12 +812,8 @@ config LTO_CLANG_THIN
 	  If unsure, say Y.
 endchoice
=20
-config ARCH_SUPPORTS_AUTOFDO_CLANG
-	bool
-
 config AUTOFDO_CLANG
 	bool "Enable Clang's AutoFDO build (EXPERIMENTAL)"
-	depends on ARCH_SUPPORTS_AUTOFDO_CLANG
 	depends on CC_IS_CLANG && CLANG_VERSION >=3D 170000
 	help
 	  This option enables Clang=E2=80=99s AutoFDO build. When
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0ae48c42..9363d9cc9a00a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -128,7 +128,6 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_RT
-	select ARCH_SUPPORTS_AUTOFDO_CLANG
 	select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64

base-commit: f92f4749861b06fed908d336b4dee1326003291b
--=20
2.47.0.338.g60cca15819-goog


