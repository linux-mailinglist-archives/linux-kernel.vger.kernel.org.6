Return-Path: <linux-kernel+bounces-276910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D099499F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2721F2402D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F86016BE3D;
	Tue,  6 Aug 2024 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iB2E5F8X"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE914BF9B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979274; cv=none; b=g/FYcoNg7oQ+1xVm5Z9NVCdS/cNgpc5cMMGLRObI1cQ/ibz+P9OLtCtNEp101g/J62XfHYWFXYnTGlkFYxeixnbB1+mxnGlwUFOn7HkkufaoWQp4+ZTUZrRKwFxGqZxkgSHi970ZT8LL6Ji7VHZb03HB7Hdb1632N4Ihop1cBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979274; c=relaxed/simple;
	bh=heM5uA1h3O9sMxylWx0nEPtpRLemZa0vHE5S3SDNWdw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U8OgGMEnU1KULb7IG6mfsuPZrzRd9BEJMu2x5bIZWVszuiB+2Zf4KM9FuM+rmtDZWvi4aL+0touA7BgE+XNKdsTCYsway2hzJwtjs3BAIBLozQjvBG4iMHygeHmWGM9txgkI+esXwXlFKcqYMyeJACwW+bz+i3Z3Pg958qkgZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iB2E5F8X; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05e3938a37so1739116276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979271; x=1723584071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4FbkHsjbrqQbuRvkdw57dKFwFPFfEB/U6kkbaRbF7t0=;
        b=iB2E5F8Xz0nJGn4/fb9k9vvcdN20LKnrB9kwye3OD6kdx7MaoY5Qnzd7nPv5ER4BLA
         VDQ8aj3zKzu9LLxyfDl3dnnY2BHgfl1VtBJKtcdVp/wl0Szp+nF7wp4r7I5EY/oTBiGb
         B3CbRkJzyL7oZRs61MS4Ycn6wNn2eMUTbnyadPGoFi3uj7RAZAsnfJHqJ9ZLT8fIetfI
         DkBKbjJ2D0KeW580h6FxpI+vLOaJxotgGjnSO3TvzxCJJH4OnxRLjkVNUaPcN64y6jup
         rEW76zDpsKP1J7/hTrIgVohQafe2bK0ouMnY3RmWVfAY8AEwdWhApnTCvmzbc4tQqg2m
         3i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979271; x=1723584071;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FbkHsjbrqQbuRvkdw57dKFwFPFfEB/U6kkbaRbF7t0=;
        b=OkOqCE9Byro9vIBaj/GtyiIqrtfz8KPMLo95Wcw0MiWPu2xbqVWz+XhgVTsNdqvuAv
         G/zTOjJWn6jKjm93yddK3AdOo4myupUX7W6zENK2prt00dQEHyVmN30vIE9otmFL631s
         DOZORR1HdjFtUWOpUvcvamO9q3vZzdnghO4MC1DLOkGi7U8x1BM1EAKKfGG0WqIamaIw
         RJ6HmL9XgvEq9DT3CwdfXrFCCVzA3yRrh5yyt1xdaAXy4FUSEbVrFNo3D/aVvZNvTQlV
         fsejjMPQselgir72tCC0a8fYoCqAHFVITHFJbDZz0TzT8yb7LMZME6b9aRt9eYkTS3s8
         oyrw==
X-Forwarded-Encrypted: i=1; AJvYcCX5mpyfAA0MA9xO2gH9dKNjwwHaPsMWuHQn5fgAJC6N1FehVmYGD4SXblx3zSH0XY+VsdJpvNhn5Nc1EIjPMjSPXS9SO/PHtp8xG4Cf
X-Gm-Message-State: AOJu0Yx2VFUjJ5n8AjU+eBxO3iBaeL3ImST1a63NfbTpuTESosX85EKg
	rjQkclK9o242LxLELM+69suKmbiJw12l76QrMBPHQX56J1HneOLOgfRrvWhw9XibudGi0Iu6mPn
	F96vOmw==
X-Google-Smtp-Source: AGHT+IExCLgM+sXMSR6m0P1n1GnffNaAREKf4oeChWkKCDHm8cEPsESVi8hBFnwr8hMTvIMraQmWAixONaRW
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:2605:b0:e03:62dc:63de with SMTP
 id 3f1490d57ef6-e0bde29b508mr309326276.6.1722979270695; Tue, 06 Aug 2024
 14:21:10 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-1-mmaurer@google.com>
Subject: [PATCH v3 00/16] Extended MODVERSIONS Support
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously MODVERSIONS + RUST Redux [1]

This patch series is intended for use alongside the Implement
MODVERSIONS for RUST [2] series as a replacement for the symbol name
hashing approach used there to enable RUST and MODVERSIONS at the same
time.

Elsewhere, we've seen a desire for long symbol name support for LTO
symbol names [3], and the previous series came up [4] as a possible
solution rather than hashing, which some have objected [5] to.

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
explicit request [6] by Luis in response to the original patchset.

If you are testing this patch alongside RUST by manually removing the
!MODVERSIONS restriction (this series doesn't remove it, because the
CRCs don't mean what we'd want them to yet, we need the DWARF patch for
that) and have kernel hardening enabled, you may need the CPU
Mitigations [7] series. Without it, the foo.mod.o file produced by the
C compiler will reference __x86_return_thunk, but foo.o will not.
This means that the version table will not contain a version for
__x86_return_thunk, but foo.ko will reference it, which will result
in a version check failure.

[1] https://lore.kernel.org/all/20231118025748.2778044-1-mmaurer@google.com/
[2] https://lore.kernel.org/all/20240617175818.58219-17-samitolvanen@google.com/
[3] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org/
[4] https://lore.kernel.org/lkml/ZoxbEEsK40ASi1cY@bombadil.infradead.org/
[5] https://lore.kernel.org/lkml/0b2697fd-7ab4-469f-83a6-ec9ebc701ba0@suse.com/
[6] https://lore.kernel.org/lkml/ZVZNh%2FPA5HiVRkeb@bombadil.infradead.org/
[7] https://lore.kernel.org/all/20240725183325.122827-1-ojeda@kernel.org/

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

 arch/powerpc/kernel/module_64.c |  24 +-
 kernel/module/internal.h        |  18 +-
 kernel/module/main.c            | 647 ++++++++++++++++++++++++--------
 kernel/module/version.c         |  43 +++
 scripts/export_report.pl        |  17 +-
 scripts/mod/modpost.c           |  39 +-
 6 files changed, 627 insertions(+), 161 deletions(-)

-- 
2.46.0.rc2.264.g509ed76dc8-goog


