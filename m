Return-Path: <linux-kernel+bounces-302899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747EA9604C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9D11F21BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F372B19B5BD;
	Tue, 27 Aug 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2Xnd+VM"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080819DF61
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748373; cv=none; b=BUq7UhvEa2WgO+KgatVbzqr4iHjwNavgXZ8ZqEaApSIovCp9gcqAS8To4LMd7BEuF3ugUPvxMO1r3C1mHQ8jTIhBb6a9WswpPb5Vk5vJa9v6npx4se1k7EWWSJ2xChFaVproF0s9ZetLPenhG7doInVNendezuSSwksASHIXONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748373; c=relaxed/simple;
	bh=W/gned1S2aEgveAzwGHcVts33uHXT+GTG81W6x5AeTc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F4zCq//hxY2jJvR56xVXVUzPtKj32xemscU9W/cFYX+e7clzcpEpv005yuuXt0cSY+SA+PnfruQbThEk5w88483TEq6UCnnGaWWJZq2YXo3nRvEPSXsqUp28T96lw8lTrdhVFxaLgKFZlgn8iC2IKKY8tugLM6oSH7iLn1eZB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2Xnd+VM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b46a237b48so111809917b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724748371; x=1725353171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujfkbxajYNAV9coR+kUVXeI3lwos12vqL1v+iOvXT9g=;
        b=C2Xnd+VMqLKM/HQb8Nids0U6EjHRykvLQPoH3NJxao6ctN+jit9rHB4sqgPVm7UtDn
         pOkjdgK126GqAd3ZWiVVAcTynsh2IKaVfeqAnLuOVM0hgOXam9+oe15++rajBJu48qcV
         pF/K2uRiQOKXnWUE36ggzIARoi7/Wf2k1X32CNUbSCDKsP6D3ZvuVjWreJf2nO5opMLF
         DdBqF2lhbAdX1apkZxh2YEKPwaSwYYoB+v61/0roqZi4nwAbhD10cxX74uIIo7hVBzbt
         ZG91iK4VmlD8PeQ/QIpzBShH6nrtfFEjF55pviDt4/korvH73u37aK8LUyshRx3uxSOh
         z+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748371; x=1725353171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujfkbxajYNAV9coR+kUVXeI3lwos12vqL1v+iOvXT9g=;
        b=Hr+FDEc8BPtSjwlAw2am1TiANdbnuBEIoDgOGtM/Hz0mPZq98XmmJH6oyCdNIRymnv
         6/BtoKRSV8FunRKOkLf5jIrbempVjoWeqF4yE8x3prlkI15WdtzWv62bv16jLiZMQDdi
         YYhYziGp6/jEpT0bkWzRAhW/wvnu8pFRdIwT5jqUExo/+Cerr4Kp/uStEiI97f749Sp4
         QIOBOggkd4lPjNI+RvIU+gs+2UW3doJ8YbYy15TLKR/q/ZavdH/wX3wERXXY3lCtxpOg
         c0mJNtTfQvaAV0WIoiA/guy09mDx6BdJPxE0WD535bSg4XOsGpFzuXQ9gr6k8rzo5/9g
         UNvg==
X-Forwarded-Encrypted: i=1; AJvYcCX8uvB9QiV/wsQvSHzWOQ9PiUnccm9VEOGqN7tHhekkfoZaZpkUTtmpJoCU7nzJ02nLKz2ZHtlISXRuFKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyff28AgO5V8SoZGWCCzTLbCjTccvbe21OpAZUlgyHezlje/Q8c
	xCHU6O/SwRwkU/ofqnxNj6VxzTJoH6Zk/natNELfpd8fHwUfIcNBUcq7X7sSZuALkIkUxT8RW/3
	en3Fboj6nokvq2p5tok6KoYW8nQ==
X-Google-Smtp-Source: AGHT+IHOHuHbuOJF/L350TjQeQOZv00E2Fvna1Z8JsFoQh3TFmDrKS4V7q2AmDtj+RMoJ+girhVAzT4/oTPRZmzkCgA=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a25:a4a2:0:b0:e16:6d88:b8c2 with SMTP
 id 3f1490d57ef6-e1a2a5a6addmr54600276.4.1724748370673; Tue, 27 Aug 2024
 01:46:10 -0700 (PDT)
Date: Tue, 27 Aug 2024 08:45:48 +0000
In-Reply-To: <20240827084549.45731-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827084549.45731-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827084549.45731-6-sebastianene@google.com>
Subject: [PATCH v9 5/5] KVM: arm64: Introduce the PTDUMP_STAGE2_DEBUGFS config
From: Sebastian Ene <sebastianene@google.com>
To: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com, 
	ardb@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	james.morse@arm.com, vdonnefort@google.com, mark.rutland@arm.com, 
	maz@kernel.org, oliver.upton@linux.dev, rananta@google.com, 
	ryan.roberts@arm.com, sebastianene@google.com, shahuang@redhat.com, 
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

When this config is enabled, it exposes the stage-2 pagetable layout
through a debugfs file.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8304eb342be9..ead632ad01b4 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -66,4 +66,21 @@ config PROTECTED_NVHE_STACKTRACE
 
 	  If unsure, or not using protected nVHE (pKVM), say N.
 
+config PTDUMP_STAGE2_DEBUGFS
+	bool "Present the stage-2 pagetables to debugfs"
+	depends on KVM
+	depends on DEBUG_KERNEL
+	depends on DEBUG_FS
+	depends on GENERIC_PTDUMP
+	select PTDUMP_CORE
+	default n
+	help
+	  Say Y here if you want to show the stage-2 kernel pagetables
+	  layout in a debugfs file. This information is only useful for kernel developers
+	  who are working in architecture specific areas of the kernel.
+	  It is probably not a good idea to enable this feature in a production
+	  kernel.
+
+	  If in doubt, say N.
+
 endif # VIRTUALIZATION
-- 
2.46.0.295.g3b9ea8a38a-goog


