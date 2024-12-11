Return-Path: <linux-kernel+bounces-442243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670969ED9B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7702280A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CEC1F2386;
	Wed, 11 Dec 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpTIyfT+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E31A841F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956191; cv=none; b=ltqGs/k5+LQ4RvfwaRVygeS41Ri+blGIscoqwwROiJ6mUT5AwoKthLdQmNGteeILL4ahtZknsLiMOacFOqZ72Pp3WXAi/WTsXM+kualCPu9sz08P+gZMKWRxJ6s3Zqwm6qfWEcXkg1lx7LqtYsr+Rnsyw+AWudCyhWx1uNsrYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956191; c=relaxed/simple;
	bh=lPTMIG69DuHeMzgG17Odj+Y80UTrtxPqqijmq49HyrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XzA4eqwKZNmo6H3ZqQBwLRllsYAu4yl9VEeP9EShZ1DVVGpF594Msmyyfgk3Kv06xYgx2DEcgOvv2dosU4ls2ncJJ6vo+GMPRm6Pn72ZpIoAw9eI6e7KGzmd/qZldClIwk5m00CM2p/gHDL+AxMoeaGxNoM/H1bsj9+Fk2fHV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpTIyfT+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so7075962a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733956189; x=1734560989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gaZuYXmtCEmcCZlUH1hfeagvf+k7B92sq86dkr0GRc=;
        b=CpTIyfT+B0E4lkY3DS4mlM7aX/5W1WBsPUUYu0GGDjneGhsk9jGSqHqvpP5gXLpx3d
         XeH/98dh/KI4nNZWi+IfFGqlUmRVQTytaQOP5m67OY3Ph0n/JYQbdeXVpkGmzQwz4E2Y
         uk51pQcEaltTiUMdYfazqJtWxUgn0g7hMZXjYYsTPSv4I8EKCEYnQuSHFX9n9/Ycseos
         SCCeXzih+GGmRj8eawFaevN0Gcm5TFd0JfrWy9mjOV6kEabtnN8hiMxajRK4XQD2uy3f
         /KU3xzp/YV6FBYO/U/3wjOdd7zAg8frVJJASi6PB+7hLuPFUm4BClecFg0HAwI0ug8UA
         r01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956189; x=1734560989;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4gaZuYXmtCEmcCZlUH1hfeagvf+k7B92sq86dkr0GRc=;
        b=G6RGBG+mhhMn2bXYkokVp+32O8rNIcbzAjRijCz5Aelf42dCCuEAF99ed7kdrssGnz
         dxnSDsPv7gyReCvsd/CcFHjewmAAi4MlEt9kIIXT2p5yjfbr8ZhAs0DsYJrwaih9AgLg
         SFzZzD+3/+q40/ePBhp6JOhh4826W/YqkDPF5Sumht3ljtblgnXmLxRy7+X9JgPs5VSd
         lyaeFgp0r5g0xRK3F5DeIos3lCRPR5/ZnjfL5YDfs2hhQecNf2d62jBGG2W0jxpdgUx3
         XBD8Q7/m3j3Ol1yP34EdLeBwRm+Me4ABAFK3MlD10aIm1LOCa5cj7CyePmEHM+IuBhrD
         43FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgCmw3uUXwYfPPpD/BVtSTlajZWvWM1lLCFdvPsCouJsBm81HvknBDO6t8op+C64uLcYgXptAdPkFKEj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+F08bJH2zG3TDvEs5xGFzsKQodVOIyfBMxNW/eaHX8T6rNQAW
	d6c8dqmzxT+1guU3EcyvVsu/15Rkl9ihDjmvEjzauFtrfGCJ8HDwpWaA47RTc4wPKw==
X-Google-Smtp-Source: AGHT+IHpJF5MFjfWOx9odv3ZJcbe3WcuEtMz5tTkPcYgSfNSDmBuU5DKfvwNfHJDKJoUoFdrI9Ha2b4=
X-Received: from pjbof13.prod.google.com ([2002:a17:90b:39cd:b0:2ef:8612:dd6b])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c84:b0:2ee:8427:4b02
 with SMTP id 98e67ed59e1d1-2f13930c5afmr2201033a91.28.1733956189151; Wed, 11
 Dec 2024 14:29:49 -0800 (PST)
Date: Wed, 11 Dec 2024 14:29:43 -0800
In-Reply-To: <20241211222945.1325793-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211222945.1325793-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211222945.1325793-2-xur@google.com>
Subject: [PATCH 2/2] Propeller: Remove the architecture specific config
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

The CONFIG_PROPELLER_CLANG option currently depends on
ARCH_SUPPORTS_PROPELLER_CLANG, but this dependency seems unnecessary.

Remove ARCH_SUPPORTS_PROPELLER_CLANG and allow users to control
Propeller builds solely through CONFIG_PROPELLER_CLANG. This simplifies
the kconfig and avoids potential confusion.

Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Will Deacon <will@kernel.org>
---
 arch/Kconfig     | 4 ----
 arch/x86/Kconfig | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 0b36d74d47031..83731b858ba65 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -828,12 +828,8 @@ config AUTOFDO_CLANG
=20
 	  If unsure, say N.
=20
-config ARCH_SUPPORTS_PROPELLER_CLANG
-	bool
-
 config PROPELLER_CLANG
 	bool "Enable Clang's Propeller build"
-	depends on ARCH_SUPPORTS_PROPELLER_CLANG
 	depends on CC_IS_CLANG && CLANG_VERSION >=3D 190000
 	help
 	  This option enables Clang=E2=80=99s Propeller build. When the Propeller
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9363d9cc9a00a..6c633d93c6390 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -128,7 +128,6 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_RT
-	select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST
--=20
2.47.0.338.g60cca15819-goog


