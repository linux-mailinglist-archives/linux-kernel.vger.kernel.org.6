Return-Path: <linux-kernel+bounces-555931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857C6A5BE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E427A256A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1FB252913;
	Tue, 11 Mar 2025 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZ0w50ee"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABF241681
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691192; cv=none; b=DwOMyVH1wnJqYWoCZC/D2G6InyzNabjEWTpcrcooLDaoFOV+eILO6HRHvp3VOBouAXInrnf50Lf8GjAL6kuZhty5NxdTgtd51ufMmd8EXJ4HZ0VtyKjCfu6yQc+CTklEZAoguZJAGM4TySK/rDDtqexYDgdW35AIlvwHm59z3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691192; c=relaxed/simple;
	bh=J3wha0HLIt1oOebFs3Pu7UxTsvGviiB/W8p+TDA5yNc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mB/J1TUOjDuOh+ocZcm+aT6WrbiU7fkLUOOJn/e1ZzjDYiGG9NWpgGZXcNc+UGZ+fRQ9nLyuJQlzfHOv6ZiQd0IyUxIKMgg9mMwq8Kzvh+dw4i5UX4Ql8otllDYPKs376w7qA8WI5ViZgbZG9PhrJltvCLejIvtIAltDOfKalKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZ0w50ee; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438e180821aso25953475e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741691189; x=1742295989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jl0jQUvb42uyFp4EBwl8ReVcozC2T0AqGgikLtwYGaU=;
        b=MZ0w50eeDcIRHa+1kUH3aGZAsYEf+WOoXpqGBk3VYdn/ywmc3ADBodHSHVgDHLUV51
         sKm/yEe4hf8cJF+HYiZeLA0xll7gbGr4bR3++ZFH+AKhHHiwiB0YbJO4Oahl6IsMQqZk
         /AU1HpppmFKj9+Lqn3/tZDp9akKIAs0U/S6G5NKQiw2XzEBsVQxs98/sCpauumUOK96P
         G27CMjJ5sAciBRmves2//Qs5yxVwtxdSq5+WLnCGnq47Vf3nDGA+A/pceh11rlez1zWR
         JOaJhY7PFF16eLS6Gs5+32aiyTtANJvzgb2jO/IOYKEQiFidre8vybndoQazz9XgOy8h
         hiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741691189; x=1742295989;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jl0jQUvb42uyFp4EBwl8ReVcozC2T0AqGgikLtwYGaU=;
        b=FVu/x8K51NuxXC6FZAkhnDemdEjtlSODK1hrvGmnjyLeQ13/O2H+HZzDdAWFR6yWQ8
         b3y9VcimhzMyId24mcWdWPiTS/O+dBvaIL0M0SZu01PcTnrrezHuoO6aS9GYj3WcAPin
         ESIWxT5XYsVWPdKT6kxlx8+8Zk2o+G9HXL0SrrNzNDv7HwdWG5j7dRy/+xaSXiyvhnCW
         jJofJuIYNfyuzChCiCV/Lj/0kU4Un46UxewWJFG2TO5Tzlku3PeIJayQYRgrcYxHHpTT
         5RT1nmbDXKGdj0OIvVHXTCJh7Ww2VxiQ7P+NpxX8uo99MxQkTNbLBDOXyaA5/dE/nAMw
         lopw==
X-Gm-Message-State: AOJu0YxpBJwnh+jp2LnD2ZCtav3ndh8bNancxpAXUnvvFp8m/6YANyEt
	LDX6A3UNJe6tG+TIEKhD0ByJrX+Uy6i0D/+Txb6ibfCmXeJBFwLaE45/NG4ojJ2LLF2kz23MiJy
	8N/S72+VFh7jmFyeNUXF3CKgHrMmZyPSmFP45eqfeBH5hexxVQmuzt+rndfFJ/FTeAZk/E8Rcpo
	FIXSw0mdxu9nLUk/Os2qfiwsJn/LN/AQ==
X-Google-Smtp-Source: AGHT+IGBua3pLZQz6LdNmfZDVGcpFrFEc3/Tfvd1hQfzu8/wEZcKy6eQdpyQrhqEJXtc3wrHfyplDVJR
X-Received: from wmbec10.prod.google.com ([2002:a05:600c:610a:b0:43c:fefe:4eb5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b21:b0:43c:fe85:e4a0
 with SMTP id 5b1f17b1804b1-43cfe85e60bmr62348855e9.7.1741691188805; Tue, 11
 Mar 2025 04:06:28 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:06:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3167; i=ardb@kernel.org;
 h=from:subject; bh=gBvO1L36h6n5aNaXT8DoxiMFbhDdcu0gKVSU+mPXLI8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf2CpIaI/BfTqsziHyf91+xIF39y+5PLTl6B7ROjjbM97
 iYW71vRUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayexojwyrtE7LTVV4sv9Ur
 9HLthMw1f+LUzqUfPPvwl8Okb6V/7ygz/DN/waxwWiDhuOj957ExS/54W4tG3mPz/uuYrx0tsoh vERcA
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250311110616.148682-6-ardb+git@google.com>
Subject: [PATCH v2 0/4] x86/build: Get rid of vmlinux postlink step
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Kbuild supports an architecture specific Makefile.postlink file that is
invoked for the vmlinux target after it has been built. This Makefile
takes 'vmlinux' (which has just been built) as the target, and mangles
the file and/or constructs other intermediate artifacts from it.

This violates the general philosophy of Make, which is based on rules
and dependencies, and artifacts that are rebuilt only when any of their
dependencies have been updated.

Instead, the different incarnations of vmlinux that are consumed by
different stages of the build should be emitted as distinct files, where
rules and dependencies are used to define one in terms of the other.

This also works around an error observed here [0], where vmlinux is
deleted by Make because a subsequent step that consumes it as input
throws an error.

So refactor the vmlinux shell scripts and build rules so that
architectures that rely on --emit-relocs to construct vmlinux with
static relocations preserved will get a separate vmlinux.unstripped file
carrying those relocations. This removes the need for an imperative
postlink step, given that any rules that depend on the unstripped
vmlinux can now simply depend on vmlinux.unstripped, rather than inject
a build step into Makefile.postlink

S390 should be able to do the same. MIPS and RISC-V perform some
post-build checks on vmlinux, which is reasonable in principle for a
postlink step, although deleting vmlinux when the check fails is equally
unhelpful.

Changes since v1:
- add vmlinux.unstripped to .gitignore and to the 'clean' target
- move cmd_strip_relocs into Makefile.vmlinux

[0] https://lore.kernel.org/all/Z5ARucnUgqjwBnrp@gmail.com/T/#m731ed0206949fc3f39fcc8a7b82fe348a8fc80c4

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>

Ard Biesheuvel (4):
  Kbuild/link-vmlinux.sh: Make output file name configurable
  Kbuild: Introduce Kconfig symbol for linking vmlinux with relocations
  Kbuild: Create intermediate vmlinux build with relocations preserved
  x86: Get rid of Makefile.postlink

 .gitignore                        |  1 +
 Makefile                          |  6 ++-
 arch/Kconfig                      |  7 ++++
 arch/mips/Kconfig                 |  1 +
 arch/mips/Makefile                |  4 --
 arch/mips/Makefile.postlink       |  2 +-
 arch/riscv/Kconfig                |  1 +
 arch/riscv/Makefile               |  2 +-
 arch/riscv/Makefile.postlink      | 11 +-----
 arch/riscv/boot/Makefile          |  5 +--
 arch/s390/Kconfig                 |  1 +
 arch/s390/Makefile                |  2 +-
 arch/s390/Makefile.postlink       |  4 +-
 arch/x86/Kconfig                  |  1 +
 arch/x86/Makefile                 |  6 ---
 arch/x86/Makefile.postlink        | 40 --------------------
 arch/x86/boot/compressed/Makefile |  9 +++--
 scripts/Makefile.lib              |  3 --
 scripts/Makefile.vmlinux          | 30 +++++++++++----
 scripts/link-vmlinux.sh           | 11 +++---
 20 files changed, 57 insertions(+), 90 deletions(-)
 delete mode 100644 arch/x86/Makefile.postlink

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


