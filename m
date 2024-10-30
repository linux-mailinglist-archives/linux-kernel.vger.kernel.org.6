Return-Path: <linux-kernel+bounces-388455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07109B5FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545CA1F21651
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1D1E6DD5;
	Wed, 30 Oct 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7Yg8r/4"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F421E5737
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283524; cv=none; b=X8fQDPlAkWN7p5UJBWekJgNTPf+s8hGXvJX1h5fcBoFwsKdSC3/UFHy0eR/bC53cKLVLgCAwngX6m6hrnW7XRNhDTq2dQF+pAbC15aVo+fg8OrG02D/0IHzVv/uYSDMUEIE1w50u8nKDp0RfkHixfSKXP8GvwFB5Qs0xlMjbiro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283524; c=relaxed/simple;
	bh=T6kyhjgFFAMLM4kDbtDM0D4ip9OKZgjkSqMz5Cg9VYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a7WsY3FlDf60Qw6H0hkTrTJEWOdtuJRAPw0BFjWokGTYTEWVTZqDbw8fY08O4PEuWyS00vd3V/PbGJ6Dm/lBXyEmGjwqt+u4haPGtBCUgd7dD8zoOgGdRFrxjycuntjVNOWGw0B25Zthg8JsfhZWb4xDY+3qzQwo5KT0w2VUByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7Yg8r/4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so46648425e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730283521; x=1730888321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=52XSQSJD/DBoSd/dVK+WzCA1fOPBNSpbtkHc/N5BpME=;
        b=M7Yg8r/4KzBq/0pCBDGtEzDFuxvLLAzJlpL1PQ2OYL7EcWJgGplFIR7fUcVEaz0bCu
         sS+IhKSkli5RSokM/+2W7zbADnhd1EBQYy1CnDFGk55jjcdqOYGMRzn/PsVePTy7hGWZ
         ilFakT30DXttiDNN2xCtl335oxhYRxRl6ZkCJqnGXdVa9K/j4YgbJOoz3CZyfWWmjiXG
         ICiW11G08OslRHo2YCuOnxv+trRY6ohZOQDLhI3Qoc6p7leazJ8oki+QucgMARpxy89p
         hGoBtpLQPuwcqBJS7lCubtQe/lSHfMfZT3nDySYDHrcl+RQksAk5WqKCDgIkNF+vq2D0
         vvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283521; x=1730888321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52XSQSJD/DBoSd/dVK+WzCA1fOPBNSpbtkHc/N5BpME=;
        b=e4G20nShVWi1ZOwIf8UJljRCQouQ3naOEff03B2DLJ8bq9z065iFM97qVPXzrlcMrg
         DDXhIHameaDPKC935CckcCGAy+KBEJ+Hm+8ba/5NJMpvbo8WIWNVGGXNa6W6cQGHiALE
         0H7CmKrbnYV0bXhByTP9SPIGm4B6+C0HIz5/DRjuYT3ZfeXdZKrHgql5Qt03trCCWqAB
         J1Lv+8wwYlqT3s9LKcyjcvp+69KD1GB9+B71ME14mcITcuWKJm8RaZyLWQbQkAnpzpeT
         HwF34C5cbr3RA36toVjdqJuKATzKeVBIX9+Q4fY6ELjYzoAF5Q7Ie7j5epeQKQ6t1IXc
         TUrA==
X-Gm-Message-State: AOJu0Yzp8sHWej5pZbZOfVNyyEcaWmSOipg3i6b35PldmE1LFGpd8ieW
	U3xwZzerjRndIe9AoQjccwdXFOxkv3rGcbbhK8w1NeJefUNZG8CxZ1W3G5egVba62O0lxg==
X-Google-Smtp-Source: AGHT+IE+VEO/hNHzg7jdjYQZotl0+so22jmmCWNlXHxB6h6jNcpvLk11K2SoNznqTnbSklfAXsYs5vYW
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a7b:cb58:0:b0:430:52b1:ae39 with SMTP id
 5b1f17b1804b1-4319ad3436cmr194225e9.6.1730283520639; Wed, 30 Oct 2024
 03:18:40 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:18:10 +0100
In-Reply-To: <20241030101803.2037606-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030101803.2037606-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475; i=ardb@kernel.org;
 h=from:subject; bh=Q+pr1M8F6H61P9kQUTYPtb4597ihTA9POIZzPdbOGKE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV2J/cmzb6dbs+SaWnIUZB/uT8gUOpxzjIG1YddKuaiuk
 sfN6RYdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJ2Ygz/q+wZnv75ufDFJvWD
 qfadKiGbXXv/HmTTSDMrcsyLDosUYfgfwS7VxLaaoezGeqaXZYZdormWnUv+OjDG3jZ7v3l6+Td uAA==
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030101803.2037606-16-ardb+git@google.com>
Subject: [RFC PATCH 6/8] arm64/Kconfig: Drop support for 48-bit virtual addressing
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Drop support for 48-bit virtual addressing on 16k pages, which is the
only remaining config that supports this explicitly.

On 16k pages, 48-bit virtual addressing uses 4 levels of translation,
where the top level has only 2 entries. This is very inefficient in
terms of TLB utilization, and so 47-bit virtual addressing is usually a
better choice.

Note that x86 supports only 47-bit virtual addressing for user space
with 4 translation levels, due to the way its page tables are
constructed (a single combined root table for both kernel and user
space), and so removing this configuration is unlikely to create
portability concerns.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7df7d24c767d..39d0d2eb5b7c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -410,12 +410,12 @@ config BUILTIN_RETURN_ADDRESS_STRIPS_PAC
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
-	default 0xdfff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && !KASAN_SW_TAGS
+	default 0xdfff800000000000 if ARM64_VA_BITS_52 && !ARM64_16K_PAGES && !KASAN_SW_TAGS
 	default 0xdfffc00000000000 if ARM64_VA_BITS_52 && ARM64_16K_PAGES && !KASAN_SW_TAGS
 	default 0xdffffe0000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
 	default 0xdfffffc000000000 if ARM64_VA_BITS_39 && !KASAN_SW_TAGS
 	default 0xdffffff800000000 if ARM64_VA_BITS_36 && !KASAN_SW_TAGS
-	default 0xefff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && KASAN_SW_TAGS
+	default 0xefff800000000000 if ARM64_VA_BITS_52 && !ARM64_16K_PAGES && KASAN_SW_TAGS
 	default 0xefffc00000000000 if ARM64_VA_BITS_52 && ARM64_16K_PAGES && KASAN_SW_TAGS
 	default 0xeffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
 	default 0xefffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
@@ -1353,10 +1353,6 @@ config ARM64_VA_BITS_42
 	bool "42-bit"
 	depends on PAGE_SIZE_64KB
 
-config ARM64_VA_BITS_48
-	bool "48-bit"
-	depends on PAGE_SIZE_16KB
-
 config ARM64_VA_BITS_52
 	bool "52-bit"
 	help
@@ -1392,7 +1388,6 @@ config ARM64_VA_BITS
 	default 36 if ARM64_VA_BITS_36
 	default 39 if ARM64_VA_BITS_39
 	default 42 if ARM64_VA_BITS_42
-	default 48 if ARM64_VA_BITS_48
 	default 52 if ARM64_VA_BITS_52
 
 choice
-- 
2.47.0.163.g1226f6d8fa-goog


