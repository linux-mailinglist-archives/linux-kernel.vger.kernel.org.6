Return-Path: <linux-kernel+bounces-170549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA68BD901
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF9A1F22C3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0374688;
	Tue,  7 May 2024 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTP8WTSb"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0FEAD35
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045734; cv=none; b=S9NZnjgEVxa7cfDUOZOhYeeN89BPeDlClHNc9rA5BmyBssynE1fzAz7nDs4kq+6+sOoFdb5r9/GMOw5DJSDb2g8fLDYxOx05Yg3MAMev3ftynnfOhA3APGbwEn6diHqIInePGCiX8FcyeZaos364qSjWC8sWQW3ZSw4oDGAyNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045734; c=relaxed/simple;
	bh=cJjey8+N7XA0lWDAjmdyuCkOhS9zN5a0WpUdS4sjd3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZe9jG2I6JVPu9l8ARdnU/Tb5TsxzGArsQhEjwxoewggwYn0pnYpZjiAeJwQuz6vjSfDeAT1M2FCek/2nrPfWPlRrHLLem8QaUVmmijmmvSBeoxWii6rpDn1SGNa0rsOua1sq7HLfEDtgdQoIdMD70URHTiQQdYXQuy0H3cYDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTP8WTSb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e54e6ba9a1so26787555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715045733; x=1715650533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgYO7v0ogCok46mLXJTMv8ZgjJeavmyV/7t/mM5NWqE=;
        b=FTP8WTSb2KGDUAyfU4scl7gd292yTFMR1bnU8d4dqQs+yOMP5/acLynE1iCLoWIwas
         lQqq78xDwH3ZuoJxb6ibwcS5gvedylRhx+F2GQsFAQZbW92lPgxcMJodwwYu6AFJYxHg
         XxgmxNUKhTQmKfta2GYog6vqm/72r8LCUkXlXNAIIeGMM54R2RTVFEuEgfA+v/5zto+z
         4vo69E5lXhmUkpVSoTQrRVgpI/QCLzLOPXJ1w2bPwSjfW8G+sXikXT1r95BbyiqI3rR3
         sPw6tSUW2rn976SOVoPDFxnavSutueiIlmhG2TCUcCQKuhONDmp92Esh+eJbDa2YEHFR
         nLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715045733; x=1715650533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgYO7v0ogCok46mLXJTMv8ZgjJeavmyV/7t/mM5NWqE=;
        b=pObgYLUYcK9RWWry/vUWrPDqBV0ON6+Xxyvp6quISdokmJxL6npnmpAlS7qKOhdpy1
         koiY+kHZ4XRVbJ91C2Sys85SgPX8vSGBiimk+Wep6/dlam3UNELTQV3bWlUJhD5bWrtk
         cUXuCyHA9jE5JQ4c9tPJXMwVlMFQo/ol1DSyzUuOso1lOwqJ2PqrmH5rNqdMiojqgFkD
         14VXL/PlWBrwLpWnZmL5enpsaSQP28XrZZax5I/0O98QuKnT+2FfSh+DA/5uT08+c/du
         D4VXg52acgvOkr7xKvPaenhkNZNMfzekgvVxYMEnowhIeXsLR8EurTOOY7XnuwS1Yl+8
         W4yg==
X-Forwarded-Encrypted: i=1; AJvYcCXNyG1vH+PrKMpDBD9silTJRrTb7QMIIiJYwVYjysDWX8KXxBF80K8BmrxJ7JdMdwGQGN9LQ5b5NFOAc8CKtabQCxuMRb92QgnLZg11
X-Gm-Message-State: AOJu0YxX72PNx5aE+ZKfRzDsZPUojrnbLJ1g1IqHMQz/Xz/psXKMNtuN
	ujJKLCHIQa0yAXocHFklUtn3Ad0lW7N6HOh4soEKucMShiJB08T/EkcsPn+WySCzr1J9XhDkvby
	PPUiR5eHsg12nAQ==
X-Google-Smtp-Source: AGHT+IErfLerZobD9xg1Wmd5+21UToJ9w/LMkvvj/wvhb1Ne0SrUXgnxBdtSvjMYm3uIeFmtL+QqkX9J33f6zCg=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a17:902:da8c:b0:1e3:d6e6:45ab with SMTP
 id j12-20020a170902da8c00b001e3d6e645abmr1078068plx.8.1715045732859; Mon, 06
 May 2024 18:35:32 -0700 (PDT)
Date: Tue,  7 May 2024 01:35:00 +0000
In-Reply-To: <20240507013502.3095744-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507013502.3095744-1-tjmercier@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507013502.3095744-3-tjmercier@google.com>
Subject: [PATCH v2 3/3] doc: x86/iommu: Update and reorder iommu options
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc: petr@tesarici.cz, mhklinux@outlook.com, robin.murphy@arm.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Several options were missing from the top of the IOMMU section that were
detailed below. Add the missing options and reorder them to match the
order in which they are documented.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/arch/x86/x86_64/boot-options.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index 18161657b301..04baefcc1712 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -242,9 +242,9 @@ Multiple x86-64 PCI-DMA mapping implementations exist, for example:
 
 ::
 
-  iommu=[<size>][,noagp][,off][,force][,noforce]
-  [,memaper[=<order>]][,merge][,fullflush][,nomerge]
-  [,noaperture]
+  iommu=[off][,noforce][,force][,soft][,<size>]
+  [,allowed][,fullflush][,nofullflush][,memaper[=<order>]]
+  [,merge][,nomerge][,noaperture][,noagp][,panic]
 
 General iommu options:
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


