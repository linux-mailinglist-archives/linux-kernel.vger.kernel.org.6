Return-Path: <linux-kernel+bounces-202205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 138EE8FC92E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4411F248A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC35190497;
	Wed,  5 Jun 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xF79Unyu"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E318FC70
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583782; cv=none; b=qGhzk8cE/v0tEKkd2TvystUmPnzp+3//arDHCymMugP8tN7tDmqSjucHPU/YgxcdEn/+xXI+QooQeU3kSSREIvqyakqrIbViCbiB/b4byn1ImBrJZmaJz6OutSfFgCKnvbjjS/kLQoeAQyiUdahofZLzEEBC0vEwDLhDgAEyEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583782; c=relaxed/simple;
	bh=M70pu07JoZozOfKF8Tva2viVcTBU3oh/uEyITLE2nks=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ChLgcUo1bwkoKrlozOaywTkO0Px9Yrr8l55Cmodkw92pY6FCr5zKns6V63RmpnBcZNsojXGj/rBRN2wcSUnhMNZVcH8GVCZ4nLELj0tt1x5xPRxDJOWQOCXq98UhbOp/6nIvUiFBbRRSbof1y4eMUfWU1voPqbiQCe8Rjnhe4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xF79Unyu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dee902341c0so3049310276.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717583780; x=1718188580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Bf8lrJfLZs51w/q3b3Y1WHclNYW0h8603SxR/DmQa0=;
        b=xF79Unyu3pzy8lahHwBJrB2VV4BE3qu8cczw4mNPNe5Oeq8HgOJ0tobJL4d0RveDhi
         BwBKUdvL+agEtpFOsu9pncbMvad+pGkaOcyBPvNdIoEKYPs0ThZ22YabiiXLoGravMbr
         h0RW3X/Cyb4nRWQPPaj28IQRQOlwS+psN9mb0uUOIjweNgtuVKZz+QDsvWOHvVI57xXO
         RlvaEHnnC6bg9IIcjzLTrJY4SK1LeVPtKwXiOJ3ZyW/l43nO/BqUY9y2EHzalKuPZU7D
         A6vbY1t5Os8xpCCNBMDTYpxtoEitqmy8t7LqP0jIZ558WAbgepSkekM8iNPfjLtD0zje
         Y01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583780; x=1718188580;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Bf8lrJfLZs51w/q3b3Y1WHclNYW0h8603SxR/DmQa0=;
        b=Ktmo40f915rbV8LUduGgorg49l80GzsdsRiaKxOPAmqmA+F8WlW8r+f9Ty2xuuWyhB
         1NNU/M5kvgWeDzhhNfWb/LTIwBPoqj1Y/mpDBa6LF9A6kJBxU4UxaamMLPPVaBfeqnfH
         q37guW3L33rkxmpk5PA69BwYrJsp3TMKjGfrhgjYxSE6tzQH5zAVJ5LYFYR5JHbx8uoT
         3uh66z+K+V8nJeT/kZEC7T2QxpEV/8KObJGZp2ali1Dp8groNA3Eax2inAwyxLEC2jPU
         Hovl3eb1UZ0gM8NPxW2d9pXM/qMdJwON8kaYRg1tX7Z4mTGv/V12m5OkB0hpYKYm2zhz
         RXsg==
X-Gm-Message-State: AOJu0YxbGgUcpcY/VW4hUtYWu/Ordo2Cs3nF1nAER2TJ7cbY07sRGIn4
	Y9mRoQCfRH6/xbdMaGdE8DXUMnp24eAwjG2R6jyDa3uDZtk4a+Eh1jOQxe/Y6DiMb53/2KFQN7i
	VCnPvlFy7fP+IBkOD/XnkBXiQGG3FCmH3stiLz1O0a5JgcQgYjrZFxYfuKDn/5LliDS+uJbBiuZ
	CfMpD+fTTq2W6yhZM9ZpzvlPkoqSX4bQ==
X-Google-Smtp-Source: AGHT+IFieZLoYB6w+RMAW2WExC3R2DfKkHgyy2lv8r+Tyg+I5tHh7hYYQZzQdjsZ6jze3OWjkhkCPPra
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:c10:b0:de5:3003:4b64 with SMTP id
 3f1490d57ef6-dfacab29344mr163480276.1.1717583779500; Wed, 05 Jun 2024
 03:36:19 -0700 (PDT)
Date: Wed,  5 Jun 2024 12:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162; i=ardb@kernel.org;
 h=from:subject; bh=3o8q8pG6azdPq8Ly3DOb71yzaLMptVSBLiH10sUnP2M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS3B6vWb4O43kV9MH5caFiWyTwlruXdRzTTrX0fiQUXrj
 CbPt+s7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwET4JjMyXPKcxqlUrrvVr2L+
 eqW5J5h+JbzqfTfjX9UCoa2nc4pytBgZvn356FI61z376I2HUhmbc07u1S36rjj3uT2/cEPm58N MfAA=
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240605101610.2824747-6-ardb+git@google.com>
Subject: [PATCH v3 0/4] x86: Rid .head.text of all abs references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This series removes the last remaining absolute symbol references from
.head.text. Doing so is necessary because code in this section may be
called from a 1:1 mapping of memory, which deviates from the mapping
this code was linked and/or relocated to run at. This is not something
that the toolchains support: even PIC/PIE code is still assumed to
execute from the same mapping that it was relocated to run from by the
startup code or dynamic loader. This means we are basically on our own
here, and need to add measures to ensure the code works as expected in
this manner.

Given that the startup code needs to create the kernel virtual mapping
in the page tables, early references to some kernel virtual addresses
are valid even if they cannot be dereferenced yet. To avoid having to
make this distinction at build time, patches #3 and #4 replace such
valid references with RIP-relative references with an offset applied.

Patches #1 and #2 remove some absolute references from .head.text that
don't need to be there in the first place.

Changes since v2:
- Rebase onto v6.10-rc2
- Tweak commit log of patch #3

Changes since v1/RFC:
- rename va_offset to p2v_offset
- take PA of _text in C code directly

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Brian Gerst <brgerst@gmail.com>

Ard Biesheuvel (4):
  x86/sev: Avoid WARN()s in early boot code
  x86/xen/pvh: Move startup code into .ref.text
  x86/boot/64: Determine VA/PA offset before entering C code
  x86/boot/64: Avoid intentional absolute symbol references in
    .head.text

 arch/x86/include/asm/setup.h |  2 +-
 arch/x86/kernel/head64.c     | 38 ++++++++++++--------
 arch/x86/kernel/head_64.S    |  9 ++++-
 arch/x86/kernel/sev.c        | 15 +++-----
 arch/x86/platform/pvh/head.S |  2 +-
 5 files changed, 38 insertions(+), 28 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


