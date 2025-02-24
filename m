Return-Path: <linux-kernel+bounces-529150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6BBA42069
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29DD16EED2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612224A066;
	Mon, 24 Feb 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbIR93iK"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E1243369
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403313; cv=none; b=VSCbE71ap3esU56nTR1Gpm+lovLAjotr6YyKmYng/IQfcDAJbYZfJq/taQAXNNqzirZCwF/xCJ+i1NxKQZbF8gHoh4YENrivJw86UtJuvDvZTRRfx4Z3aFi+ZSsgEeHBnKmXsOkI3mIMbC9iAcstJZSCuuNM/ZbHhipP0FI58ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403313; c=relaxed/simple;
	bh=Oy07TeCnfbpWPSwxM8Z6cTmvSYren2dJqc7NY7nv4nc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TvCLmr6HEYXofKHtreGvcMVPFOxLlB/OddaZRfcDeW1KXU+DElY5XjGY39t1OewnMk5jytDmt+pXrfynpI2cu3J4bHcoomcpKnweW++VrVWlQS3DD+ZWPT+t+kIwKcyvcB6gvAHLSMbCWMxTEr8RWCTMK7hS8dhVPJqY62nujpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbIR93iK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43998ec3733so22355695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403310; x=1741008110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4G60LNJ4QUWH+5iAZPEr11sSYa924Pp9ggcWXrajw8Q=;
        b=tbIR93iKdigw1/o0TRkB3/RTJAita9boezEkYPqMXVR86sHP4dc3EkuDTAR/hE8wbZ
         4wIht5UzawlRlBDtWT5eYssueYWG8qU/xCP79NKAozzi4vrcj0tJ9q2Pb+Ux7Q6Zq89h
         hjQNTzQwc4fuBOA7cV4I1ukTsoZDSpcljCrVg5R+rA5YXWIXPTc69QI2YJDzq3HtX2xT
         q48L1N4zAAthjmYUv4Vprr/Ytv4R2n4VP/RqvyFsK3bbfCTpzw1jjd6/ACB42rwZuizJ
         nc1a+VZ0SKZcPVcNcavGVUiwezo7zSxy8PlX+178OPildnrlHBD49vmPwfnt2GACYqlK
         1CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403310; x=1741008110;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G60LNJ4QUWH+5iAZPEr11sSYa924Pp9ggcWXrajw8Q=;
        b=Oh9gt7Yl8PZjZUDbbRBOozyH23Oi+OVisFIFseHqw33zNsnHO9p0AjlGq5RcVcr3o8
         kmCk4Lv4w1z6iJeREnPEAJw8oXlZ+SpfkaZ/8F4RSOqG7Jj0SzIrwNSi0u2A3O0164a7
         kRNJjM6rWZbqk2Nl9lSXbGzeTXGGyuJY8QbnWuY4fQh2mXDTWosdPoZAt9g/jDlczjzO
         FqgC6Y+6+/IED2sgvK5GCgUIASy27cB9oii6/wapfvru6KFq9NnyHiXuhaHWr7KED44o
         3tkc7tOZrXOPdz0WLqK2rRGtOXFZ7V7hLsIQlq9XYgeU3Ocyw35B4/suRj9E7uPuOTQg
         A6kA==
X-Gm-Message-State: AOJu0YwWHmG0iZlYilD1Zx2ep9Vz79UxZGkEzE70dlO94iTqmGRBz3cB
	15j2f/9jDJEdg2enqoTuWkifza3/4DRv750FKiSCLDPO8C6lfzRfN8SdiNtZlCY1xpA4i03mwov
	SMLFQVeDqHns6WFMzSoBicVx5sXTGVyJ2iHSezQD/9OmeJ7BsUNUxv3R34L1DYAmAGOQZdXOXcq
	V445r1ZyfZfaq1a2FxltQNUKzcr/JlNg==
X-Google-Smtp-Source: AGHT+IHHcPjN4jytk/EH4VMj8UFkSmrWefJL98q6vjgDpyjT4ufS9VD5paeSFiU3hrbVWuTwUf+OH+6h
X-Received: from wmbg6.prod.google.com ([2002:a05:600c:a406:b0:439:80fc:8bc9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3508:b0:439:99d1:d4a4
 with SMTP id 5b1f17b1804b1-439ae1f1864mr107315805e9.18.1740403310084; Mon, 24
 Feb 2025 05:21:50 -0800 (PST)
Date: Mon, 24 Feb 2025 14:21:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982; i=ardb@kernel.org;
 h=from:subject; bh=S2aIumU8fZBnlmZGEf1mwt6ddnpvhDqK3FOh22qSesk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX1PUaz9wbd3fT/f2llYJMlX/WdNsIdL1vwHl7cnpP96e
 rz27SP+jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARqSeMDI9Yl2i+yvD5MOvF
 D/Ev2co3nI3+zZhes2K3xJSpUZd2St1gZPjd3iiXN6W976/OHMlURtU3914cDXP7oXW9K5jpcGy jAycA
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224132132.1765115-6-ardb+git@google.com>
Subject: [RFC PATCH 0/4] x86/build: Get rid of vmlinux postlink step
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-kbuild@vger.kernel.org, 
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

[0] https://lore.kernel.org/all/Z5ARucnUgqjwBnrp@gmail.com/T/#m731ed0206949fc3f39fcc8a7b82fe348a8fc80c4

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>

Ard Biesheuvel (4):
  Kbuild/link-vmlinux.sh: Make output file name configurable
  Kbuild: Introduce Kconfig symbol for linking vmlinux with relocations
  Kbuild: Create intermediate vmlinux build with relocations preserved
  x86: Get rid of Makefile.postlink

 Makefile                          |  4 ++
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
 arch/x86/boot/compressed/Makefile |  8 ++--
 scripts/Makefile.lib              |  2 +-
 scripts/Makefile.vmlinux          | 27 +++++++++----
 scripts/link-vmlinux.sh           | 11 +++---
 19 files changed, 52 insertions(+), 87 deletions(-)
 delete mode 100644 arch/x86/Makefile.postlink

-- 
2.48.1.601.g30ceb7b040-goog


