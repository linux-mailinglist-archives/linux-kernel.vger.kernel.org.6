Return-Path: <linux-kernel+bounces-368625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D986A9A127E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEF3286466
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3780F2144BA;
	Wed, 16 Oct 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/AtDdFf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435812139CF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106808; cv=none; b=AKdcOHZQd17A5BHMqMfa+QDd/nmzlP2c+NShNw9bKEGpdV2BxwcpV2ee+54L75SEej3+nU+7mgxdUILeJew/rBBISFWN+WvJHLndTsKq50AxuVm9aQWSNi3/vA8e1oqhiDAmp64H9GgFHsac3F/LtEthKhCLOFNvhxVmLBn/4/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106808; c=relaxed/simple;
	bh=X6ryELMqFz14NmmqX610wiAkHfOIG3IH2APQykNVovU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bdzwl4OwA4iao3PCHxZmpMCERhannqe0TvLpF74qDsOLXDAzS/jJXJ4naSg9D0+0qLePOed0HCMRSdoIlrP9WuBj685h2IeVpevqZOyBlPYAxUKuhwCqXrFq9r1N3riFnpvmq6MMiq9R5ufTKs9bAaTPSR/NBU/7gIm7UkpveN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/AtDdFf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so5750017b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729106806; x=1729711606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=71jHtTZ6Tb0ubRmAvBFlz10X2hosJ2gMr/QFtpHOJss=;
        b=h/AtDdFfd06oQYBQVr3+6hs9fR97R6zr26e1gknxHyOxpb5PJjc8IbmWagC5hpq53Z
         Av9L0qUi8fGp5SGJuq7KuSHO/mQoQhY+PLyzRwXqFyKEtfwUr9+G3+CpJu7Nqa5BMmyl
         NSVKzPlNvBu/3jNVT+I4ucgX/tdDMiuQTRJn1obHSywisVKsgN9pWxJM3dhiuOmhVkte
         MhTlTRRp55+OxTnhTQQtbHeYjY5EXNz903c1L2o2Hbj8tluFbILhplYeoGCvg9cMqgG0
         nT3LFkx4m23B9klKHOMcRb7f2juzFOf0rDhCDE2f7gfB9tWn5pDeODVGIym0+uAHdzr7
         2wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106806; x=1729711606;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71jHtTZ6Tb0ubRmAvBFlz10X2hosJ2gMr/QFtpHOJss=;
        b=Rl9KTN1tc4l0Mq6Kp7syMzXb0Z1R9eTk5cPgTECHr9eOpyk7xhxAtQYEoPkamWHsUA
         ky/P9qYv71LeAZx0x1Zbw7te2oXT1ERkXxB4rfLjzrd9j5WYe5ryV4nKZVQh9riVQBdL
         WN8zU8XVkeOW1v91ZjnYG4kU/Og2POd4bntTuP32ejXSIlrpqS2nIO4hwZniFKYZcVkJ
         azrtrPCsj3W0JKRA7jPEWObzmh0KH4xZA4J5FFR9RKxlOOZqskfFx0iOptse7xhNU90u
         KHEEiO1EObprXC1oi7+D5ENAissE6sxoimuVMNyFqesUVBXR0l7kv9H6UTIdeIWvttJS
         ZRUg==
X-Gm-Message-State: AOJu0Yz2ac4henjdiq3BuDp6F3wOesilJqNqyzDSFq3s4/TTmMPXgNO8
	VWLmwy4b+aN4vsJZhL99R51GmmUmCCQrD/g15DoI2+sTdFxag5hud5HQPoqaQ4618KYQEg==
X-Google-Smtp-Source: AGHT+IEbjrUITaf482uKQsYG7Ig58W7dEGDKbDR0Bksm7FH7a/KxsfpLBNROUttO8dKYD6M57Wsyl/SY
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a81:fb04:0:b0:6e3:d670:f62a with SMTP id
 00721157ae682-6e3d671219emr419867b3.3.1729106806212; Wed, 16 Oct 2024
 12:26:46 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:26:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=ardb@kernel.org;
 h=from:subject; bh=vlMaODxGDLJCYsHMLyzzK3JwRCTjZ6nDuceb9GBYtEI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV1AuHCy/2kPRgvXGkWH54905xZV7zZb6qD55/aHlWI3h
 Gdf/fuvo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExESpeRYVE1ZxSLk+tVUZY4
 vTNTt/1+uHPlkb1zy//2lU6Z6LqeOZ+R4VPIE56PpQJey6LeHD+r7ez8VTHlItfvk07fXv5fnt5 kwwIA
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241016192640.406255-4-ardb+git@google.com>
Subject: [PATCH v2 0/2] arm64: Speed up CRC-32 using PMULL instructions
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, will@kernel.org, catalin.marinas@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The CRC-32 code is library code, and is not part of the crypto
subsystem. This means that callers may not generally be aware of the
kind of implementation that backs it, and so we've refrained from using
FP/SIMD code in the past, as it disables preemption, and this may incur
scheduling latencies that the caller did not anticipate.

This was solved a while ago, and on arm64, kernel mode FP/SIMD no longer
disables preemption.

This means we can happily use PMULL instructions in the CRC-32 library
code, which permits an optimization to be implemented that results in a
speedup of 2 - 2.8x for inputs >1k in size (on Apple M2)

Patch #1 implements some prepwork to handle the scalar CRC-32
alternatives patching in C code.

Changes since v1:
- rename crc32-pmull.S to crc32-4way.S and avoid pmull in the function
  names to avoid confusion about the nature of the implementation;
- polish the asm a bit, and add some comments
- don't return via the scalar code if len dropped to 0 after calling the
  4-way code.

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Kees Cook <kees@kernel.org>

Ard Biesheuvel (2):
  arm64/lib: Handle CRC-32 alternative in C code
  arm64/crc32: Implement 4-way interleave using PMULL

 arch/arm64/lib/Makefile     |   2 +-
 arch/arm64/lib/crc32-4way.S | 242 ++++++++++++++++++++
 arch/arm64/lib/crc32-glue.c |  82 +++++++
 arch/arm64/lib/crc32.S      |  21 +-
 4 files changed, 331 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/lib/crc32-4way.S
 create mode 100644 arch/arm64/lib/crc32-glue.c

-- 
2.47.0.rc1.288.g06298d1525-goog


