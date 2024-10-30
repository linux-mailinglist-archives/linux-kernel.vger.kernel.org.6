Return-Path: <linux-kernel+bounces-388451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883BD9B5FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F71F22CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9921E47C0;
	Wed, 30 Oct 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nxeov7Ro"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CF1E3DEA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283514; cv=none; b=ZUOd46ZzTLRwQq6vYj3GNcQ8gP2/x/oIKwkLlLzXFmY/ZxhLeocB24Fwnre870bMV7wMBSePkGAdZ1WE3cvNxUnKGFOkebj0dDnhJwuj2t3envoTSarTXw6ANZOCuBdMSv7bD9L9K+3ukhbWDG2yR2xgqgDUpmVR1ImJqMmgy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283514; c=relaxed/simple;
	bh=FQ+ymp5e6cm9+/3wZN6fvqmxb2yfY/IspmPE5y/Wytc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oHNJzAmzeerZYSnLxlRFzAzWV4b1pkcCMLlQsPorwuU7fMDbsZOg1PiJmZ++ghp7Su73zKZKA8fEonSyPgRe9/icNWSi1PetBtaJFItwC1LN1lQdUUg/E9OBk+1q1YZ0vR3VgBTaynkf6E8KpYhzKQemkUPv2SgRecGjNDAb5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nxeov7Ro; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3497c8eb0so9062807b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730283511; x=1730888311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt+GDj8bSCsrOuFvhauMB0QKz25eKh57Bb5+kpwY7Gc=;
        b=Nxeov7Ro05rJZYh2r26MIpSGpWY2E5uB96MEX3X/GE8pRRDvs/mDJirP6TbtbyVtit
         qymB5fZ2SqUbitrnc5JTiAkSUC6ydZbjLNCn1z0E9MNIjUnASA0K+NP81/+MHMCEFFLI
         QydJuPLMLBhlMbZgfxxaAS4hP7LhK9X3KKdSraeFridw986gV8xbIR6RE+EFdmVdnscr
         VqegNoCwE8mpYsNokbqy/BWLmenwInthHfmeoTOi79MmOsTnPuVMvH/UE7Hxn/+wDXjL
         45VUYqzH6Y5nlSiWwhZIsPLGN2L6Y948wNEY71t91a4RVOxPFFyxfOoFR3Qz0K5dqnXb
         CebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283511; x=1730888311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt+GDj8bSCsrOuFvhauMB0QKz25eKh57Bb5+kpwY7Gc=;
        b=iHMHCqSjiaVlNFOqjyYkp0fyc8ZaWf1Irari+xqYHCDE7B7sT8r/Y8335L7eqZWrxE
         4USv5PgLAtKPgo0U+di3SnU3VGinupviKmKqr6DPNK91cr3WDp945oLI0ZPhbUw+QNRz
         b92UFH0w7KK/h2dJal0+iufNpGTFc0GzH1hNPAlFmcrB8N+po5bd7rj8w0ogMbO136n3
         SsmtU2jAznfhBaZwBOGDMrcEZnkkle6rs4JW/SCNk822WXhlHZCY2vJZEjXPt/w9WmqF
         FMbfWQQZlrr05h+iUGS1V4WzmPcjNjoaedDmfdWHywrAUOVswIDBkzDy6Sp88JkAAPQ+
         Wy3Q==
X-Gm-Message-State: AOJu0Yw7bX/Wg5FsdZFsuzcDAlr4JYtcLfu9tGma9DEYLA9+Z8JoT5bB
	zCkpWDk7fV7Zw6BdcL8tvtRBWxccEq2EKaeK+UiPNt3BUprcZo1cTq/bYakpvj/Ru8+psA==
X-Google-Smtp-Source: AGHT+IHkg/m0TjIto84EqA/r5FuO1zVU5A4uj4lUTPcQZpzUFb+a+5T9IxFqqsZLyYJRz7Dar4t9cHib
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:4d45:b0:6e2:ac0a:8982 with SMTP id
 00721157ae682-6ea3e59140amr1606947b3.0.1730283510742; Wed, 30 Oct 2024
 03:18:30 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:18:06 +0100
In-Reply-To: <20241030101803.2037606-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030101803.2037606-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=ardb@kernel.org;
 h=from:subject; bh=5xf0c9c6JVxVeaGrMTt8Z5pUMYFzvmJMGfwOWomg+o4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV2J/f6zFT9nH5hVuODhimtszh7iS2sfqq4Kapj3UKp46
 dHqRemNHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiQRsZ/ofeD8s69o3zJWun
 a6LH1Um6UXe/Ti/cwyAr/ih6ZY29QBsjw6vpRqe+3yxvS1rY9kF3artwwL+mVLMe+7vMc/7Wbnb 25wUA
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030101803.2037606-12-ardb+git@google.com>
Subject: [RFC PATCH 2/8] arm64: Kconfig: fix ARCH_MMAP_RND_BITS_MAX for 52-bit
 virtual addressing
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The default values for ARCH_MMAP_RND_BITS_MAX fail to take into account
that we now have support for 52-bit virtual addressing. As these configs
are compatible with hardware that is incapable of 52-bit virtual
addressing, use the same value we use for 47/48-bit virtual addressing.
(For the sake of simplicity, use the same value for 47 and 48 bit
virtual addressing for 16k pages)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ec218ef22f2b..ac8e7550430b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -324,13 +324,9 @@ config ARCH_MMAP_RND_BITS_MAX
 	default 19 if ARM64_VA_BITS=36
 	default 24 if ARM64_VA_BITS=39
 	default 27 if ARM64_VA_BITS=42
-	default 30 if ARM64_VA_BITS=47
-	default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
-	default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
-	default 33 if ARM64_VA_BITS=48
-	default 14 if ARM64_64K_PAGES
-	default 16 if ARM64_16K_PAGES
-	default 18
+	default 29 if ARM64_64K_PAGES
+	default 30 if ARM64_16K_PAGES
+	default 33
 
 config ARCH_MMAP_RND_COMPAT_BITS_MIN
 	default 7 if ARM64_64K_PAGES
-- 
2.47.0.163.g1226f6d8fa-goog


