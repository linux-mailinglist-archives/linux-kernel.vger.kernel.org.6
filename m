Return-Path: <linux-kernel+bounces-564515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CBBA6568D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084A5179927
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D57E1A4F21;
	Mon, 17 Mar 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgmMimfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364621A4E9E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226438; cv=none; b=PU43lrjcqOQLiCMX/48eBJorxNU24cqIbIWcobZdm3Wgox2EEg5OWilZx9RkGs3eXNWJ3rwEjmNlpFQyoslaq0+63fQ2UXgQsDfT4tjj0sjx8QGSQ6Yp5yYvr7ysL2aJwdxLgNizl0KlTfv+jG2Pzz4IXwEQXYaaD7m3hqnJBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226438; c=relaxed/simple;
	bh=wzSeUf7o15GJgdEVxvlIGmPmqSCFw9fT6GBu3QtI2V0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kbnCStVizHy2A0p93pI3PJDmtRO2GWasjlgThJqt0gJnRD4LeyKmAoV6b6LUKXbFY+iznvrJw4R4y4wKV5SN3oKKDtVlHJNT6owq8usxqSm3dnRN9i3NPpSCI1y534iJ2DLIZEsVwCQYXp2v7P0+4bQhzXvGvBU3Q4dAYEp7NNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgmMimfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C27AC4CEE3;
	Mon, 17 Mar 2025 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742226436;
	bh=wzSeUf7o15GJgdEVxvlIGmPmqSCFw9fT6GBu3QtI2V0=;
	h=Date:From:To:Cc:Subject:From;
	b=AgmMimfXE4O5iW6X5G/JMTY4MXqrQKW5iJyPDh6IclaLRY2jAeNEWxlt0NO5EL31q
	 afAVyS2+LGmfn/ogGT82kwP3isB2Jl6isjdGevlfa1XB5U0etHHPoAklDYCL2GDIwm
	 2/4pgW3MzPDIhX98uK3HeW3O97vAe/iow6DjXemEE1hJOf+uwraOh5DzhrP4vlmnxI
	 YjCpUIkHZtUJonZw1nNDNKY2xzuXsiuKlCcq+e2UoqwU+olx2oxHiZasnd1b52YygK
	 KBamax/TtBISECiLFxQoAerGXTbNl9F+OZW227jqaKeLXbkL3JAoh5mVBy+AE/bGN0
	 1OL9H6gysNJDg==
Date: Mon, 17 Mar 2025 08:47:13 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Bruno Sobreira =?iso-8859-1?Q?Fran=E7a?= <brunofrancadevsec@gmail.com>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	David Gow <davidgow@google.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	ernsteiswuerfel@kernel.smtp.subspace.kernel.org,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Pedro Orlando <porlando@lkcamp.dev>, Petr Mladek <pmladek@suse.com>,
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Vlastimil Babka <vbabka@suse.cz>, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [GIT PULL] move-lib-kunit for v6.15-rc1
Message-ID: <202503170842.FFEE75351@keescook>
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

Please pull the move-lib-kunit tree for v6.15-rc1. This is a one-off tree
to coordinate the move of selftests out of lib/ and into lib/tests/. A
separate tree was used for this to keep the paths sane with all the
work in the same place. Doing this across multiple trees was going to
be very difficult, so any on-going updates were collected here to try to
avoid merge conflicts. I think only one small conflict remains, just
today, detailed here:
https://lore.kernel.org/linux-next/20250317213953.01ca90e9@canb.auug.org.au/
sfr's resolution looks correct.

Thanks!

-Kees

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/move-lib-kunit-v6.15-rc1

for you to fetch changes up to d62f8c95470c395ab6fd8f344ff431a5f4ce0da5:

  scanf: break kunit into test cases (2025-03-14 13:56:15 -0700)

----------------------------------------------------------------
move-lib-kunit for v6.15-rc1

- move lib/ selftests into lib/tests/ (Kees Cook, Gabriela Bittencourt,
  Luis Felipe Hernandez, Lukas Bulwahn, Tamir Duberstein)

- lib/math: Add int_log test suite (Bruno Sobreira França)

- lib/math: Add Kunit test suite for gcd() (Yu-Chun Lin)

- lib/tests/kfifo_kunit.c: add tests for the kfifo structure (Diego Vieira)

- unicode: refactor selftests into KUnit (Gabriela Bittencourt)

- lib/prime_numbers: convert self-test to KUnit (Tamir Duberstein)

- printf: convert self-test to KUnit (Tamir Duberstein)

- scanf: convert self-test to KUnit (Tamir Duberstein)

----------------------------------------------------------------
Bruno Sobreira França (1):
      lib/math: Add int_log test suite

Diego Vieira (1):
      lib/tests/kfifo_kunit.c: add tests for the kfifo structure

Gabriela Bittencourt (2):
      unicode: kunit: refactor selftest to kunit tests
      unicode: kunit: change tests filename and path

Kees Cook (5):
      lib: Move KUnit tests into tests/ subdirectory
      kunit/overflow: Fix DEFINE_FLEX tests for counted_by
      kunit/stackinit: Use fill byte different from Clang i386 pattern
      kunit/fortify: Expand testing of __compiletime_strlen()
      kunit/fortify: Replace "volatile" with OPTIMIZER_HIDE_VAR()

Luis Felipe Hernandez (1):
      lib: math: Move KUnit tests into tests/ subdir

Lukas Bulwahn (1):
      MAINTAINERS: adjust entries in FORTIFY_SOURCE and KERNEL HARDENING

Tamir Duberstein (9):
      lib/prime_numbers: convert self-test to KUnit
      selftests: remove reference to prime_numbers.sh
      printf: convert self-test to KUnit
      printf: break kunit into test cases
      printf: implicate test line in failure messages
      scanf: implicate test line in failure messages
      scanf: remove redundant debug logs
      scanf: convert self-test to KUnit
      scanf: break kunit into test cases

Yu-Chun Lin (1):
      lib/math: Add Kunit test suite for gcd()

 Documentation/core-api/printk-formats.rst          |   4 +-
 Documentation/dev-tools/kselftest.rst              |   2 +-
 MAINTAINERS                                        |  24 +-
 fs/unicode/Kconfig                                 |   5 +-
 fs/unicode/Makefile                                |   2 +-
 fs/unicode/tests/.kunitconfig                      |   3 +
 fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 153 ++++---
 fs/unicode/utf8-norm.c                             |   2 +-
 lib/Kconfig.debug                                  |  78 +++-
 lib/Makefile                                       |  41 +-
 lib/math/Makefile                                  |   5 +-
 lib/math/prime_numbers.c                           |  91 +----
 lib/math/prime_numbers_private.h                   |  16 +
 lib/math/tests/Makefile                            |   8 +-
 lib/math/tests/gcd_kunit.c                         |  56 +++
 lib/math/tests/int_log_kunit.c                     |  74 ++++
 lib/math/tests/prime_numbers_kunit.c               |  59 +++
 .../{rational-test.c => tests/rational_kunit.c}    |   0
 lib/tests/Makefile                                 |  43 ++
 lib/{ => tests}/bitfield_kunit.c                   |   0
 lib/{ => tests}/checksum_kunit.c                   |   0
 lib/{ => tests}/cmdline_kunit.c                    |   0
 lib/{ => tests}/cpumask_kunit.c                    |   0
 lib/{ => tests}/crc_kunit.c                        |   0
 lib/{ => tests}/fortify_kunit.c                    | 156 +++++---
 lib/{ => tests}/hashtable_test.c                   |   0
 lib/{ => tests}/is_signed_type_kunit.c             |   0
 lib/tests/kfifo_kunit.c                            | 224 +++++++++++
 lib/{ => tests}/kunit_iov_iter.c                   |   0
 lib/{ => tests}/list-test.c                        |   0
 lib/{ => tests}/memcpy_kunit.c                     |   0
 lib/{ => tests}/overflow_kunit.c                   |  38 +-
 lib/{test_printf.c => tests/printf_kunit.c}        | 442 +++++++++------------
 lib/{test_scanf.c => tests/scanf_kunit.c}          | 295 +++++++-------
 lib/{ => tests}/siphash_kunit.c                    |   0
 lib/{ => tests}/slub_kunit.c                       |   0
 lib/{ => tests}/stackinit_kunit.c                  |  30 +-
 lib/{ => tests}/string_helpers_kunit.c             |   0
 lib/{ => tests}/string_kunit.c                     |   0
 lib/{ => tests}/test_bits.c                        |   0
 lib/{ => tests}/test_fprobe.c                      |   0
 lib/{ => tests}/test_hash.c                        |   0
 lib/{ => tests}/test_kprobes.c                     |   0
 lib/{ => tests}/test_linear_ranges.c               |   0
 lib/{ => tests}/test_list_sort.c                   |   0
 lib/{ => tests}/test_sort.c                        |   0
 lib/{ => tests}/usercopy_kunit.c                   |   0
 lib/{ => tests}/util_macros_kunit.c                |   0
 tools/testing/selftests/kselftest/module.sh        |   2 +-
 tools/testing/selftests/lib/Makefile               |   2 +-
 tools/testing/selftests/lib/config                 |   3 -
 tools/testing/selftests/lib/prime_numbers.sh       |   4 -
 tools/testing/selftests/lib/printf.sh              |   4 -
 tools/testing/selftests/lib/scanf.sh               |   4 -
 54 files changed, 1148 insertions(+), 722 deletions(-)
 create mode 100644 fs/unicode/tests/.kunitconfig
 rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (63%)
 create mode 100644 lib/math/prime_numbers_private.h
 create mode 100644 lib/math/tests/gcd_kunit.c
 create mode 100644 lib/math/tests/int_log_kunit.c
 create mode 100644 lib/math/tests/prime_numbers_kunit.c
 rename lib/math/{rational-test.c => tests/rational_kunit.c} (100%)
 rename lib/{ => tests}/bitfield_kunit.c (100%)
 rename lib/{ => tests}/checksum_kunit.c (100%)
 rename lib/{ => tests}/cmdline_kunit.c (100%)
 rename lib/{ => tests}/cpumask_kunit.c (100%)
 rename lib/{ => tests}/crc_kunit.c (100%)
 rename lib/{ => tests}/fortify_kunit.c (90%)
 rename lib/{ => tests}/hashtable_test.c (100%)
 rename lib/{ => tests}/is_signed_type_kunit.c (100%)
 create mode 100644 lib/tests/kfifo_kunit.c
 rename lib/{ => tests}/kunit_iov_iter.c (100%)
 rename lib/{ => tests}/list-test.c (100%)
 rename lib/{ => tests}/memcpy_kunit.c (100%)
 rename lib/{ => tests}/overflow_kunit.c (96%)
 rename lib/{test_printf.c => tests/printf_kunit.c} (71%)
 rename lib/{test_scanf.c => tests/scanf_kunit.c} (76%)
 rename lib/{ => tests}/siphash_kunit.c (100%)
 rename lib/{ => tests}/slub_kunit.c (100%)
 rename lib/{ => tests}/stackinit_kunit.c (95%)
 rename lib/{ => tests}/string_helpers_kunit.c (100%)
 rename lib/{ => tests}/string_kunit.c (100%)
 rename lib/{ => tests}/test_bits.c (100%)
 rename lib/{ => tests}/test_fprobe.c (100%)
 rename lib/{ => tests}/test_hash.c (100%)
 rename lib/{ => tests}/test_kprobes.c (100%)
 rename lib/{ => tests}/test_linear_ranges.c (100%)
 rename lib/{ => tests}/test_list_sort.c (100%)
 rename lib/{ => tests}/test_sort.c (100%)
 rename lib/{ => tests}/usercopy_kunit.c (100%)
 rename lib/{ => tests}/util_macros_kunit.c (100%)
 delete mode 100755 tools/testing/selftests/lib/prime_numbers.sh
 delete mode 100755 tools/testing/selftests/lib/printf.sh
 delete mode 100755 tools/testing/selftests/lib/scanf.sh

-- 
Kees Cook

