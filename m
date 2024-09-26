Return-Path: <linux-kernel+bounces-339735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353AF9869A7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D8B283490
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21511A3BD1;
	Wed, 25 Sep 2024 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwL7EGk7"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633C1A3BB4
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307564; cv=none; b=rwjwXc9gG8lVnfyUZQYQKBW1l2ZcirHla/MyoHdEbgu5cB7VLEkFQbbmQY/DL190gs9/xs+nOdg86blVtt+/PhK648muJ/8hqnOIV1KDv8pfKCAcq90+1vT+oszA6/LzzmzagCiAjssWqlGyR6jO3d2s/bSfdMtwO1qi728aRhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307564; c=relaxed/simple;
	bh=muaWdXOp0i1NHw58x/ytq5TJ2WagOWI67+2dfrsQk4o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LFQKcTLeIRPUvoKepjCTJdWVHA7Z4aE1Qt88EGgGux4KG3ZxNq+G4mWyTG0oq4FirILroolEqni5QbJATwZB4CZOHCc8MYx5KSMIIrQQEZjR+gIUe2TVnuF3os7CeYzhH0Xqs9CVZszOFaC2bJkv6yax0kRB0AZuN3fe9a2bf4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwL7EGk7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6dbbeee08f0so22495007b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307561; x=1727912361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q7b6h3HmgxgHIdWpgRX2iff7bgpoat2/yBhTNJ92XBU=;
        b=fwL7EGk7M8apziku9aY01pxjzuXj/9hRKLP1kooKi7wujrIJghEoOyYGC9usyuXZZr
         7GzOFogKNpME0m3ThbAbc9kqEdcSX5j9TgwqKAqDeb6QXO4fXXs6ydSc2SRU0FC8CINv
         VO/BynGOHd7xuK/+z3+iH9jI9mBjs1rgmRDmg6x5EYTZ86zC7Xp42GbZq3isgdqmj4tr
         MM5dmeXLgw5xR7fDQ1n+AFc4icsMEOJ49rfCNhzShfnpjvvif7wKRrj9AS3Lg++2YXSX
         7kLhy8Erpv3/IaApt2/mPzum/b/bmcO1TCI9mi05S7Bmwl1rXsYH4ha7jlcIN/CBTZW5
         wKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307561; x=1727912361;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7b6h3HmgxgHIdWpgRX2iff7bgpoat2/yBhTNJ92XBU=;
        b=oKa1sDY9b/jcyKlnqETsify4hXbhAdKFZ8NFDw5At9aWOMgLGzUA+6qIT9YXtmuZLQ
         wgGi+5xXRMhrro17KuFGNZOQWDrDhzBXdT8W//i+nwhytd1yyajbOZoPhz2iEFzvs0ed
         WtsVxj1z6eB4SiT3QipxuUfDnvqhlTepKD+4yn99Bs/094wljo4dwY2rZ/cTqcjsQ2K5
         ZJZ2xuWamPNPJQj0gBYZL2qM16ESYjROr3+/3ri97c+mMTeCxYBvCmxCSCGj/0743PoZ
         7hbeFDiQbzUxe/tp2edASnudDhaMmLBWb03J8AlxNzQ5/lGEhQWTAPq3TJv1AP09hGCI
         Yvjw==
X-Forwarded-Encrypted: i=1; AJvYcCWMhzvhDKiM4Og8meuwMgPD5I9nHh22rQ7jndGIIaZOvRLa6vsq4iokL5fDGX7fi108N+fWEsc+W839KWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4uRL3LaC2jYAT98Z7aDijUbURVEs+eqKnan/6Jnq3uPHn78c
	GnC8hL/NuCLO6OquoX5kClCw7o86N0Ws4x5IAioDi9eqb3YvWImHtcPKjbL+fywos4M2p1sYxA2
	gnhf+PA==
X-Google-Smtp-Source: AGHT+IGA4oLQ7oskOvz6jUuH8pwaRGHmRTicDgFocvw4e/tJcx31v4NxTp/MI5BNDdGho+l01HKc5yR1Qinp
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:ad4d:0:b0:e11:593b:b8e7 with SMTP id
 3f1490d57ef6-e25ca915db6mr19076276.3.1727307561199; Wed, 25 Sep 2024 16:39:21
 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-1-mmaurer@google.com>
Subject: [PATCH v5 00/16] Extended MODVERSIONS Support
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

This patch series is intended for use alongside the Implement
MODVERSIONS for RUST [1] series as a replacement for the symbol name
hashing approach used there to enable RUST and MODVERSIONS at the same
time.

Elsewhere, we've seen a desire for long symbol name support for LTO
symbol names [2], and the previous series came up [3] as a possible
solution rather than hashing, which some have objected [4] to.

This series adds a MODVERSIONS format which uses a section per column.
This avoids userspace tools breaking if we need to make a similar change
to the format in the future - we would do so by adding a new section,
rather than editing the struct definition. In the new format, the name
section is formatted as a concatenated sequence of NUL-terminated
strings, which allows for arbitrary length names.

Currently, this series emits both the extended format and the current
format on all modules, and prefers the extended format when checking if
present. I'm open to various other policies via Kconfig knobs, but this
seemed like a good initial default.

The refactor to MODVERSIONS is prefixed to this series as result of an
explicit request [5] by Luis in response to the original patchset.

If you are testing this patch alongside RUST by manually removing the
!MODVERSIONS restriction (this series doesn't remove it, because the
CRCs don't mean what we'd want them to yet, we need the DWARF patch for
that) and have kernel hardening enabled, you may need the CPU
Mitigations [6] series. Without it, the foo.mod.o file produced by the
C compiler will reference __x86_return_thunk, but foo.o will not.
This means that the version table will not contain a version for
__x86_return_thunk, but foo.ko will reference it, which will result
in a version check failure.

[1] https://lore.kernel.org/all/20240617175818.58219-17-samitolvanen@google.com/
[2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org/
[3] https://lore.kernel.org/lkml/ZoxbEEsK40ASi1cY@bombadil.infradead.org/
[4] https://lore.kernel.org/lkml/0b2697fd-7ab4-469f-83a6-ec9ebc701ba0@suse.com/
[5] https://lore.kernel.org/lkml/ZVZNh%2FPA5HiVRkeb@bombadil.infradead.org/
[6] https://lore.kernel.org/all/20240725183325.122827-1-ojeda@kernel.org/

Changes in v5:
- Addresses Sami's comments from v3 that I missed in v4 (missing early
  return, extra parens)

v4: https://lore.kernel.org/asahi/20240924212024.540574-1-mmaurer@google.com/
- Fix incorrect dot munging in PPC

v3: https://lore.kernel.org/lkml/87le0w2hop.fsf@mail.lhotse/T/
- Split up the module verification refactor into smaller patches, per
  Greg K-H's suggestion.

v2: https://lore.kernel.org/all/20231118025748.2778044-1-mmaurer@google.com/
- Add loading/verification refactor before modifying, per Luis's request

v1: https://lore.kernel.org/rust-for-linux/20231115185858.2110875-1-mmaurer@google.com/ 

Matthew Maurer (16):
  module: Take const arg in validate_section_offset
  module: Factor out elf_validity_ehdr
  module: Factor out elf_validity_cache_sechdrs
  module: Factor out elf_validity_cache_secstrings
  module: Factor out elf_validity_cache_index_info
  module: Factor out elf_validity_cache_index_mod
  module: Factor out elf_validity_cache_index_sym
  module: Factor out elf_validity_cache_index_str
  module: Group section index calculations together
  module: Factor out elf_validity_cache_strtab
  module: Additional validation in elf_validity_cache_strtab
  module: Reformat struct for code style
  export_report: Rehabilitate script
  modules: Support extended MODVERSIONS info
  modpost: Produce extended modversion information
  export_report: Use new version info format

 arch/powerpc/kernel/module_64.c |  23 +-
 kernel/module/internal.h        |  18 +-
 kernel/module/main.c            | 647 ++++++++++++++++++++++++--------
 kernel/module/version.c         |  45 +++
 scripts/export_report.pl        |  17 +-
 scripts/mod/modpost.c           |  39 +-
 6 files changed, 628 insertions(+), 161 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


