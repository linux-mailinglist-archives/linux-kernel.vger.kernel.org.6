Return-Path: <linux-kernel+bounces-176714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093278C3394
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2971C20DE6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 19:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E63200C1;
	Sat, 11 May 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FqNUnITj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9A1CAA5
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715456563; cv=none; b=PxBrrpBDsuDKntja883VKvopCZC/NHeYDvGuzoUmEAtBbfmR8q1LaMgVEoOHbksp7x7HNWhpanFrLJkfiFCeX04/UQ7+0FMbf3uphZ2d9A2rlUJnenNOVww1x3edMV0fK/raWBamCfsGj5jh8uDaTL/ms3ZvogxQj0NnWBZHcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715456563; c=relaxed/simple;
	bh=I0rA/vW8J1E8xYDKxPgNrRLRdvbXhixu2mwIGYB3dXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jZMj5Hdv1bbtl62qAVCsfo/nsKwDc+foE5qzCmsamvUnLBd96cRuaPzQVPYwEbM7J0jaIzPL0ELkbbtmpz3feGNIC4X0WbdOi6dSv3Q+B7F7UDDNMpDAWjyUDpETTtDSUkMCCHcUSgf+Bl40y0V2tw03VzaTNowf1qo8ZAPV1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FqNUnITj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f447976de7so2807985b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715456561; x=1716061361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPw5Y/qY+Bj/2EFMKZJAroys6lSvRQ8eLJi2nV7naKo=;
        b=FqNUnITjBSBa9vBagBsxr2xigyYG2NxDLD/mGd5xy2wUZCS8rlCL0+3V+41Yf0YKIB
         fDnuEYjHEacra6PScfhwT+TYaQhDxs5OzUNZ689xqSem7qWfNV3jQu8j/zoAlGPGQSq2
         UExf3mC3T0yQTKoL0mh/NjI5QNnKb4YpAEniE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715456561; x=1716061361;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPw5Y/qY+Bj/2EFMKZJAroys6lSvRQ8eLJi2nV7naKo=;
        b=vv1+RasH15uHH3p5X4lfMrly9Gc9/IQ6UH5YnNVaRN8KMV7XnadNnRI78aghpiNeIx
         r6+4jWWj6KNM/xlSPyf1dAEc3484MpoLecbI3FZ5tgfuFEFSCyvYGs7VRaam/bncVlUv
         cNG2q8YYADtU7iwHycQokUxKSiX6AYUcGK3oJxvaGr+oFfbFGJKU/GAH/iDKMOwmuCj5
         xibhlNar6yYY+J6p5VWlofgSL6qyL/9fxGcA5L+soh7jGFMa/Eej9CM1oerSzF9zR/jT
         5O0/qZX+0rlDOjhtWiVja8TEObxI0kA9u4CMgNTLbSCcSc2/7QIhOJpJqHrJv17z9t9I
         fCow==
X-Gm-Message-State: AOJu0YybVCHvnYde05CnkVpeBXRrXtdCGG/4OXytC3UYT1Avrjpd3acd
	559cIWLI/0qiFWhVZZI521f0KCqM8UYEkYrdxCVjnFIlYtl6a34riydVPAch2Q==
X-Google-Smtp-Source: AGHT+IGfgQUa+1VBqMinStz0mQMd2kVMuyWW8JkhrtKzTrVl5Gh5Plmt3JzwERhyFGrDZMjhYxdWsA==
X-Received: by 2002:a05:6a00:114d:b0:6ed:332:ffbc with SMTP id d2e1a72fcca58-6f4e02de3acmr5330956b3a.20.1715456560701;
        Sat, 11 May 2024 12:42:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2d767sm4800475b3a.186.2024.05.11.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 12:42:40 -0700 (PDT)
Date: Sat, 11 May 2024 12:42:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Charles Bertsch <cbertsch@cox.net>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Erick Archer <erick.archer@outlook.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-hardening@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Marco Elver <elver@google.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [GIT PULL] hardening updates for 6.10-rc1
Message-ID: <202405111234.6F2AB1F@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these hardening updates for 6.10-rc1. The bulk of the changes
here are related to refactoring and expanding the KUnit tests for string
helper and fortify behavior. Some trivial strncpy replacements in fs/
were carried in my tree. Also some fixes to SCSI string handling were
carried in my tree since the helper for those was introduce here. Beyond
that, just little fixes all around: objtool getting confused about
LKDTM+KCFI, preparing for future refactors (constification of sysctl
tables, additional __counted_by annotations), a Clang UBSAN+i386 crash
fix, and adding more options in the hardening.config Kconfig fragment.

Thanks!

-Kees

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-6.10-rc1

for you to fetch changes up to 6d305cbef1aa01b9714e01e35f3d5c28544cf04d:

  uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be} (2024-05-08 00:42:25 -0700)

----------------------------------------------------------------
hardening updates for 6.10-rc1

- selftests: Add str*cmp tests (Ivan Orlov)

- __counted_by: provide UAPI for _le/_be variants (Erick Archer)

- Various strncpy deprecation refactors (Justin Stitt)

- stackleak: Use a copy of soon-to-be-const sysctl table (Thomas Weiﬂschuh)

- UBSAN: Work around i386 -regparm=3 bug with Clang prior to version 19

- Provide helper to deal with non-NUL-terminated string copying

- SCSI: Fix older string copying bugs (with new helper)

- selftests: Consolidate string helper behavioral tests

- selftests: add memcpy() fortify tests

- string: Add additional __realloc_size() annotations for "dup" helpers

- LKDTM: Fix KCFI+rodata+objtool confusion

- hardening.config: Enable KCFI

----------------------------------------------------------------
Erick Archer (1):
      uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be}

Ivan Orlov (1):
      string_kunit: Add test cases for str*cmp functions

Justin Stitt (5):
      virt: acrn: replace deprecated strncpy with strscpy
      reiserfs: replace deprecated strncpy with scnprintf
      hfsplus: refactor copy_name to not use strncpy
      fs: ecryptfs: replace deprecated strncpy with strscpy
      init: replace deprecated strncpy with strscpy_pad

Kees Cook (21):
      string: Prepare to merge strscpy_kunit.c into string_kunit.c
      string: Merge strscpy KUnit tests into string_kunit.c
      string: Prepare to merge strcat KUnit tests into string_kunit.c
      string: Merge strcat KUnit tests into string_kunit.c
      string: Convert KUnit test names to standard convention
      string.h: Introduce memtostr() and memtostr_pad()
      string_kunit: Move strtomem KUnit test to string_kunit.c
      MAINTAINERS: Add ubsan.h to the UBSAN section
      ubsan: Remove 1-element array usage in debug reporting
      ubsan: Avoid i386 UBSAN handler crashes with Clang
      scsi: mptfusion: Avoid possible run-time warning with long manufacturer strings
      scsi: mpi3mr: Avoid possible run-time warning with long manufacturer strings
      scsi: qla2xxx: Avoid possible run-time warning with long model_num
      kunit/fortify: Fix mismatched kvalloc()/vfree() usage
      kunit/fortify: Rename tests to use recommended conventions
      kunit/fortify: Do not spam logs with fortify WARNs
      kunit/fortify: Add memcpy() tests
      lkdtm: Disable CFI checking for perms functions
      hardening: Enable KCFI and some other options
      kunit/fortify: Fix replaced failure path to unbreak __alloc_size
      string: Add additional __realloc_size() annotations for "dup" helpers

Thomas Weiﬂschuh (1):
      stackleak: Use a copy of the ctl_table argument

 MAINTAINERS                            |   3 +-
 arch/arm64/configs/hardening.config    |   1 +
 arch/x86/configs/hardening.config      |   3 +
 drivers/message/fusion/mptsas.c        |  14 +-
 drivers/misc/lkdtm/Makefile            |   2 +-
 drivers/misc/lkdtm/perms.c             |   2 +-
 drivers/scsi/mpi3mr/mpi3mr_transport.c |  14 +-
 drivers/scsi/qla2xxx/qla_mr.c          |   6 +-
 drivers/virt/acrn/ioreq.c              |   2 +-
 fs/ecryptfs/crypto.c                   |   4 +-
 fs/ecryptfs/main.c                     |  26 +-
 fs/hfsplus/xattr.c                     |  22 +-
 fs/reiserfs/item_ops.c                 |  13 +-
 include/linux/fortify-string.h         |   9 +-
 include/linux/string.h                 |  62 ++++-
 include/uapi/linux/stddef.h            |   8 +
 init/do_mounts.c                       |   3 +-
 kernel/configs/hardening.config        |   8 +
 kernel/stackleak.c                     |   6 +-
 lib/Kconfig.debug                      |  10 -
 lib/Makefile                           |   2 -
 lib/fortify_kunit.c                    | 222 ++++++++++++----
 lib/memcpy_kunit.c                     |  53 ----
 lib/strcat_kunit.c                     | 104 --------
 lib/string_kunit.c                     | 461 ++++++++++++++++++++++++++++++++-
 lib/strscpy_kunit.c                    | 142 ----------
 lib/ubsan.h                            |  43 +--
 27 files changed, 768 insertions(+), 477 deletions(-)
 delete mode 100644 lib/strcat_kunit.c
 delete mode 100644 lib/strscpy_kunit.c

-- 
Kees Cook

