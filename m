Return-Path: <linux-kernel+bounces-569044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA6A69DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB4C16CAA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C031EC01C;
	Thu, 20 Mar 2025 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Ntaki/B"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5841EB1B6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435780; cv=none; b=m0bfswgnyg4k9SqARe5v5O5JO6JQTC2lLaV+AYh1n8K2ZKcrexKu5RXfl4gou6CBNiJBbKj4iS/yDjsSX54lBe1xZjLPpzR8mMou+FxIS8XTvs1PDUrN/lWq3m2BV+lDs1o+EYPhJMELl2/cgmWHnMjy8Ms9VPVV/lT/9EtBixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435780; c=relaxed/simple;
	bh=DO4ULc+54d14lpaTVIQ8OW7DrsUOJj3+3e0epl5v40w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CMsG/iwpNGmUD2Gm3ockLT0UH2+Dbw0MEj0aK9XM9rFf8VLdPFQofU5VjjRoGICyB91fZUyGTGHpyrXs3H7NzOyP/6S0whONKs4oIOL5W+M7F5F/TO3o9VYZ45rM8HIuLKb0GSH3RXGx7FmRezy7D6V8NAXaRZkNvOZt97oMupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Ntaki/B; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2264c423e37so2837335ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435778; x=1743040578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UkcR0SU+CU01cj/UMVFVKIzr3SF+GMypT0ANn4wKrhE=;
        b=3Ntaki/Bsjc8qJnApy7KXGxifxcfyKxTL21hiEBp/XN7Q+KYUM91tim2E2p10xBsOj
         71D1CBvStjk0RlYZd27CFh6qOqdRKhzqLXXrY4+MxuWhbZ6DQLvW8jdcfc8mlqlDOsk4
         tdgNsMaiT8CadiEyPqUX+yOzr0VIlTTGSNXsj64vget9QVeT2jrtrq+KlKgarNbmDn8b
         elXiP2iDAHcvGnh4rftWBACQ1RSjk9k67rwrrAU/Q+m/WV0gNI+aiw/V/2MCTumTg6x8
         f86LeEm22LMe0xjzYTATAgch6Xry7yCr5zHwVOanXo7ETnODqqILPaB0JSWyEm7GXbel
         dDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435778; x=1743040578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkcR0SU+CU01cj/UMVFVKIzr3SF+GMypT0ANn4wKrhE=;
        b=paqE0c3IUCAmtq9oDtKlyUzDg0H8AVHIBvvZxpO5WYCLqxVvRtpSjT1sDR/za4qRTW
         a4MfcgrrEH94Ag2yCIoUIrhuskg8p604npkp0w5CX2c+Tpnebx1qwMk4PmNjLllXpNRB
         tFqnOfTEj+TJpIWq7bjnFDW9ePW7TIq5hwVyomcW8PRrgQ+w5iXv3ZbgjfPySrq1pRQQ
         Id7c4DBbDvcsbN2JrzVbAgOgdojhEuNEA2Pmfw4rDYdjsd0vJDnlGvcEjkPZ0+H6MZt5
         WuksYp7ci5F87U6PMWyrVDUKNWfM94yNPIq+6DFctJ0oKqD2O50ekfnmP7qplssRYYe0
         qr9w==
X-Gm-Message-State: AOJu0YxVL0D1rv5jxTyMaHqAw5aYTXOX+Xe0MEnaPRdOYXPqFEFhQAry
	KN3TGGVWP3Nn+GgEsUKUrhTZfsKdVdu3N51tBMuLQZMdyBqPe6jkK0UjGQJNO5g/T20K9a+hI3b
	ZpAXZqlDMocvRUK8g4fVhpXbHPYPbeFlpKaB61a0Jn4OMsDashIIQ1uy1lYIWoBD1KqIDbSZ2aA
	ukd0H+eMY3Db0ZNhyTO9ahdw2Aa4sVubSXkddkX9QtCsqdRf8s5Qbe6G5vuGdYcw==
X-Google-Smtp-Source: AGHT+IEq833KvKiO9EApYrAEuf1UTsJySLJu5CjTMNPxyZpCp1rooyCfDuUQ3lxBHQoctugFxssTdHmFh/kEHnmc
X-Received: from plsq4.prod.google.com ([2002:a17:902:bd84:b0:223:3ab:e4a0])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e801:b0:21f:c67:a68a with SMTP id d9443c01a7336-22649a2ee71mr75511855ad.31.1742435777590;
 Wed, 19 Mar 2025 18:56:17 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:46 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-12-changyuanl@google.com>
Subject: [PATCH v5 11/16] kexec: add config option for KHO
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexander Graf <graf@amazon.com>

We have all generic code in place now to support Kexec with KHO. This
patch adds a config option that depends on architecture support to
enable KHO support.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 kernel/Kconfig.kexec | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 4d111f871951..57db99e758a8 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -95,6 +95,21 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
+config KEXEC_HANDOVER
+	bool "kexec handover"
+	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	select MEMBLOCK_KHO_SCRATCH
+	select KEXEC_FILE
+	select DEBUG_FS
+	select LIBFDT
+	select CMA
+	select XXHASH
+	help
+	  Allow kexec to hand over state across kernels by generating and
+	  passing additional metadata to the target kernel. This is useful
+	  to keep data or state alive across the kexec. For this to work,
+	  both source and target kernels need to have this option enabled.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
-- 
2.48.1.711.g2feabab25a-goog


