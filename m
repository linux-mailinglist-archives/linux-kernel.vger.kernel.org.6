Return-Path: <linux-kernel+bounces-388454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C069B5FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836C02817E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56DA1E572A;
	Wed, 30 Oct 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bbbHwrT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0EB1E5016
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283521; cv=none; b=ObbDopxZ7PCkwKwNx+xxsLqFh6tNBOPS7eFqEMZf99LJeX5NNAXv6hykDfR9DOjQoqBT43bvbNVNcqrjCrQqgvnIoNa6sq1TOTItt6G0rAJwodIwga+L+BLNa4N+8Fp6IIz1oBrDt6abXUn7siIwlA0fv6dlDEPDaU6uhgUFAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283521; c=relaxed/simple;
	bh=RPurPv0asBGPwsLFH371fmYej/KST3NPJ6PSd9ncPeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aSyXmNZvA9GEADMnr9X+BhVgPYXgiTr6LhfmMXu5SxIQ2gsmcBZ9/XbHnvvxILQKpUX6ZFOBWXdrv/tP9NAsa5UTRNYyDkxdE1TufCmZW8iFrIYTAg9XwGxBfrxDwtEfbXQG9yykMI+r8MYkfE1RY+dglX+RkrH00gzkbwhED9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bbbHwrT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e370139342so120135097b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730283518; x=1730888318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lkeE3D8+J4OcDtDEGiGIXOA7IIy99qfhKrBIJpYyvY=;
        b=3bbbHwrThLJAB5HRcd65d41fnnF7CD53YLam9nipce6GwRuiDh/obheaJSKA2Gkg2k
         kYGJfqy1SEo3mHA/g6l6ZPwOer2NMFILx3TXH2ksyf87AVEjND7O+b2JPufrNPSh6lST
         u8pfgr69z3hXJoXp6VChprFtzJoZT0XAs0F2wvZuLoG69/Cb5MCjISXG1WWBi6cvd99y
         3w5JHHkap2fpYWnXlVZUmZktBkg7j6UMGovD2IAjcTELieDI46tgE5ZGn0lYdgzIjge/
         VESgLNfnKJ/u3XaI/PykSyyRQ4G9FnVg9lztu2WaUudtZ0Mo0ntYxK7gWTApZzJ7+a36
         a0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283518; x=1730888318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lkeE3D8+J4OcDtDEGiGIXOA7IIy99qfhKrBIJpYyvY=;
        b=Ztwl9yWwskDe3iC60zj1NcHmIGnLgPyHJTNAcuiJVW+y9iBtHgx7VQPUdBvGP6fPNu
         e8DqbFy0mqs+Kab5uDEwrfTHjkzvj+PPWWq7ep3vUtqLrwK5yRmXN3kSm3NrekUETJr0
         K5gKY8hRxRmNnjmEhLWf/vh2X6+nKRWRm+r4sEOYmMvGAFEyDM1H5JJoFPpXQdvys5wN
         gP3VMC0Ob7s5u8iMNnIldQ5MUvq09H5de706pyh3nyb3AJ407XO1h6oC6iJ0j/IwUF1+
         KCASGIi43g1wfwNb+X4AocTdODVpT/qu7CAC3T9Y9PzybNJ79D7iWRAMaZZqHB/lNl5x
         I4vw==
X-Gm-Message-State: AOJu0YwcDSV6ZFwVzRTidYJNz1i0RVZwO1uZLHmreCec6iYUK3pn6lvU
	IFjRb2KGPrQmLGORxyjUbYQHbRQjsdZeSJl7Qo9QfEtoFnEDNBpoabcyVno1CieLygdgbQ==
X-Google-Smtp-Source: AGHT+IGYWIKtsISSLmZozooMwTQpsr6uP8eXuzu1h8K7n8sXmZ2Z4/5RcAprTfRvs8MnaiExmLO2GGiB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:6383:b0:6e2:ad08:4924 with SMTP id
 00721157ae682-6e9d8aacb2dmr10859077b3.4.1730283518114; Wed, 30 Oct 2024
 03:18:38 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:18:09 +0100
In-Reply-To: <20241030101803.2037606-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030101803.2037606-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2720; i=ardb@kernel.org;
 h=from:subject; bh=KrPhtIjOJOdsjzLuM0pYgTBMlukJZDWck1DRFJ4KhOY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV2J/fEK9kaevBx3Dv2e4nzmCa9FlknPUUlkW5NUe/yEu
 OU974iOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMBGlXwz/PU99XLJ41767Ozwz
 bmYfFnoUeIDj3XOLCeJnjs6eP+302ccM/xTyTxXuvDnz4OW0kshvCzneJLwXODqh6kHH7x95bku TGpkB
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030101803.2037606-15-ardb+git@google.com>
Subject: [RFC PATCH 5/8] arm64/Kconfig: Drop support for 47-bit virtual addressing
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Drop the separate 47-bit virtual address space configuration, which is
identical in practice to 52-bit VA configuration on all 16k pages
capable hardware currently in the field. For future hardware that does
implement support for 52-bit virtual addressing, this mode can be chosen
at boot by passing 'arm64.nolva' on the kernel command line.

This reduces the number of configurations that need to be supported and
validated.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 099b1a825b9f..7df7d24c767d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -380,7 +380,6 @@ config PGTABLE_LEVELS
 	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
-	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
 	default 3 if ARM64_64K_PAGES
 	default 4 if ARM64_16K_PAGES
 	default 5 if ARM64_4K_PAGES
@@ -412,12 +411,12 @@ config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	default 0xdfff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && !KASAN_SW_TAGS
-	default 0xdfffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_52) && ARM64_16K_PAGES && !KASAN_SW_TAGS
+	default 0xdfffc00000000000 if ARM64_VA_BITS_52 && ARM64_16K_PAGES && !KASAN_SW_TAGS
 	default 0xdffffe0000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
 	default 0xdfffffc000000000 if ARM64_VA_BITS_39 && !KASAN_SW_TAGS
 	default 0xdffffff800000000 if ARM64_VA_BITS_36 && !KASAN_SW_TAGS
 	default 0xefff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && KASAN_SW_TAGS
-	default 0xefffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_52) && ARM64_16K_PAGES && KASAN_SW_TAGS
+	default 0xefffc00000000000 if ARM64_VA_BITS_52 && ARM64_16K_PAGES && KASAN_SW_TAGS
 	default 0xeffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
 	default 0xefffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
 	default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
@@ -1354,10 +1353,6 @@ config ARM64_VA_BITS_42
 	bool "42-bit"
 	depends on PAGE_SIZE_64KB
 
-config ARM64_VA_BITS_47
-	bool "47-bit"
-	depends on PAGE_SIZE_16KB
-
 config ARM64_VA_BITS_48
 	bool "48-bit"
 	depends on PAGE_SIZE_16KB
@@ -1397,7 +1392,6 @@ config ARM64_VA_BITS
 	default 36 if ARM64_VA_BITS_36
 	default 39 if ARM64_VA_BITS_39
 	default 42 if ARM64_VA_BITS_42
-	default 47 if ARM64_VA_BITS_47
 	default 48 if ARM64_VA_BITS_48
 	default 52 if ARM64_VA_BITS_52
 
-- 
2.47.0.163.g1226f6d8fa-goog


