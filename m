Return-Path: <linux-kernel+bounces-428496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431429E0F50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF69164F28
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0341DFDBF;
	Mon,  2 Dec 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wk6vMjzD"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29621DFE09
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733182181; cv=none; b=UWjJEkKBDgEiU2yXeKICb+373AlKPCdo2HwTcb+j4a4HegCmcD4Lnts3qVyzSm4LF6QU0p0TI4mHo1N1hj/l1WwcFyElPts0JrPQnETfM1xHIojCFmgQKXRC6MQrRhUn9qIGmuY/GwFwVSovdPZBSaXTquZlaBUb9JDAtOePkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733182181; c=relaxed/simple;
	bh=WK50cpXZH4dQMiLFN8OiZnR2eSxyi+RTBUsGg1QksxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fnch6tJKhOzxD6atiTwQUf0POovRaiu0AnRpUr99SSsC+pSkmAM3JpCBbW3OBvBvHSBF92yx3M2wX4CmCCIusHWHkzh8mpph6Yu3J7T39RuBY/Lx6iOrxoYIf7H9nf8hiEzNorFR1Vcd8fuY0snVJUwW2B70eKE9dOY9a06J90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wk6vMjzD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724e7d5d5b2so4614920b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 15:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733182179; x=1733786979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LReTg15v0ZtTlAbFyfXtnh3wL3KeT354X2oVVMEIzE=;
        b=Wk6vMjzDdhz5o7bkuXt1+VffC+236XKPxYbXT/qjGN+uC9axRRYKDCUrlAFnbPuwPz
         pHSIO2hMY0D/7Rp3XDa/81nO+AW9Tld9oCc59YfvMqrIX8MH3O2hSWuVAVDNkv4SAhIn
         Yt6ic4XMQz/0AN8ysyXGutQ3ckIBt2KjvNuxySq29rlxXkS3msFLLQWIE2zGK1XE9o+W
         XVCeBIRUmLam0aZYm4LgGuaAi2DCwPFvGI7ijrT5dfziNJXMTTBLOj7GfvsEUrJsgzd9
         dutDJqF9f3IvMN2753WPdkXIy6KIZfDV+ZKy2MHRBCaHzDSnacsoE/4cno8CMXypqH1r
         O2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733182179; x=1733786979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LReTg15v0ZtTlAbFyfXtnh3wL3KeT354X2oVVMEIzE=;
        b=RB3B/YVcNvtxMBahcwBmp+RMmiAwVbe0T0haSYAk+whQpx4i659yD6/2v52OPgdhXO
         X1jc0P16KTa2Mg8tqeYk5Nqi6z8hKyNHMKzbqcKFQ080ZESM7TTKHcP2wQipijpHyogU
         yWy68em5vGUnsZ/alZrtuloa33x/lYExvaoT6qB6upbApjXthi81fQK4c2ntAyU2koCq
         BHAjGxhdUctR3dkCKR8eYsyYGvnW27pc/d/U/L1lpgiZ72rds5jmRs/F/3BH1a4m/pNf
         qSVekPDQcE5tV53P3vtQCU07LHv3qTKjbnJoR924j6LTL+apKYiKt5erMVBcRbNkFaOL
         rJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkOPYrNdFYE3Jx0tipqA3xkbTP7RBmUzW4kcQ+vYBuOHbxLIEPirQbR8qnknLVdenjsrY7kgbeUTlEiHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyt6Sfk/cS6wWdTorQQ5T7Rdc2T35Cz0MSlYqWWw5VUMz3RsCV
	5gnLbvIqUGoEl9heTsQlfeZkZQ15g8tBh5/NXJVyEJit5WvGJiFIDI8sb+lWhtlB5fMPmZZ0Lpb
	puNk1iX9g8DdKXKJK3CBNsZXE/pFWXNiEgiS3
X-Gm-Gg: ASbGncsr3sjLAXPWjZPVRq+ZKwTZcNE6kxsnmlaMG+P8f5BKvUHa+02+ZEjFAZ+13MK
	atBUsASuQ5QVgKdQmNvKhMqb9b2+OnHyx
X-Google-Smtp-Source: AGHT+IGG9gvQtdzRrY4jpTCXLk7VsAXT/IdOENrmFiS2raqmC78L2FrgNr63mNCKpMrl8spRQNKoahTkYuD/c/1Ghrc=
X-Received: by 2002:a17:90b:33cd:b0:2ee:f80c:687c with SMTP id
 98e67ed59e1d1-2ef01274889mr506311a91.31.1733182179063; Mon, 02 Dec 2024
 15:29:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202075545.3648096-1-davidgow@google.com>
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 2 Dec 2024 18:29:26 -0500
Message-ID: <CA+GJov6-p4u47B3TGYphdFTqFW+Vx94fu8v4URe1mF61p7koYw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] [PATCH 0/6] KUnit test moves / renames
To: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 2:55=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> As discussed in [1], the KUnit test naming scheme has changed to avoid
> name conflicts (and tab-completion woes) with the files being tested.
> These renames and moves have caused a nasty set of merge conflicts, so
> this series collates and rebases them all on top of v6.13-rc1, to be
> applied minimising any further conflicts. [2,3]
>
> Thanks to everyone whose patches appear here, and everyone who reviewed
> on the original series. I hope I didn't break them too much during the
> rebase!
>

Hello!

This series looks good to me. Tests are passed both built-in and as modules=
.

One comment: The second patch in the series "[PATCH v2 2/6] lib/math:
Add int_log test suite" applies with a warning of an extra EOF blank
line.

Other than that small nit,

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae


> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/=
 [1]
> Link: https://lore.kernel.org/lkml/CABVgOSmbSzcGUi=3DE4piSojh3A4_0GjE0fAY=
bqKjtYGbE9beYRQ@mail.gmail.com/ [2]
> Link: https://lore.kernel.org/linux-kselftest/CABVgOSkhD6=3D5K72oL_n35CUe=
MhbsiQjZ6ds+EuQmJggBtVTFVg@mail.gmail.com/ [3]
>
> Bruno Sobreira Fran=C3=A7a (1):
>   lib/math: Add int_log test suite
>
> Diego Vieira (1):
>   lib/tests/kfifo_kunit.c: add tests for the kfifo structure
>
> Gabriela Bittencourt (2):
>   unicode: kunit: refactor selftest to kunit tests
>   unicode: kunit: change tests filename and path
>
> Kees Cook (1):
>   lib: Move KUnit tests into tests/ subdirectory
>
> Luis Felipe Hernandez (1):
>   lib: math: Move kunit tests into tests/ subdir
>
>  MAINTAINERS                                   |  19 +-
>  fs/unicode/Kconfig                            |   5 +-
>  fs/unicode/Makefile                           |   2 +-
>  fs/unicode/tests/.kunitconfig                 |   3 +
>  .../{utf8-selftest.c =3D> tests/utf8_kunit.c}   | 149 ++++++------
>  fs/unicode/utf8-norm.c                        |   2 +-
>  lib/Kconfig.debug                             |  27 ++-
>  lib/Makefile                                  |  39 +--
>  lib/math/Makefile                             |   4 +-
>  lib/math/tests/Makefile                       |   4 +-
>  lib/math/tests/int_log_kunit.c                |  75 ++++++
>  .../rational_kunit.c}                         |   0
>  lib/tests/Makefile                            |  41 ++++
>  lib/{ =3D> tests}/bitfield_kunit.c              |   0
>  lib/{ =3D> tests}/checksum_kunit.c              |   0
>  lib/{ =3D> tests}/cmdline_kunit.c               |   0
>  lib/{ =3D> tests}/cpumask_kunit.c               |   0
>  lib/{ =3D> tests}/crc16_kunit.c                 |   0
>  lib/{ =3D> tests}/fortify_kunit.c               |   0
>  lib/{ =3D> tests}/hashtable_test.c              |   0
>  lib/{ =3D> tests}/is_signed_type_kunit.c        |   0
>  lib/tests/kfifo_kunit.c                       | 224 ++++++++++++++++++
>  lib/{ =3D> tests}/kunit_iov_iter.c              |   0
>  lib/{ =3D> tests}/list-test.c                   |   0
>  lib/{ =3D> tests}/memcpy_kunit.c                |   0
>  lib/{ =3D> tests}/overflow_kunit.c              |   0
>  lib/{ =3D> tests}/siphash_kunit.c               |   0
>  lib/{ =3D> tests}/slub_kunit.c                  |   0
>  lib/{ =3D> tests}/stackinit_kunit.c             |   0
>  lib/{ =3D> tests}/string_helpers_kunit.c        |   0
>  lib/{ =3D> tests}/string_kunit.c                |   0
>  lib/{ =3D> tests}/test_bits.c                   |   0
>  lib/{ =3D> tests}/test_fprobe.c                 |   0
>  lib/{ =3D> tests}/test_hash.c                   |   0
>  lib/{ =3D> tests}/test_kprobes.c                |   0
>  lib/{ =3D> tests}/test_linear_ranges.c          |   0
>  lib/{ =3D> tests}/test_list_sort.c              |   0
>  lib/{ =3D> tests}/test_sort.c                   |   0
>  lib/{ =3D> tests}/usercopy_kunit.c              |   0
>  lib/{ =3D> tests}/util_macros_kunit.c           |   0
>  40 files changed, 459 insertions(+), 135 deletions(-)
>  create mode 100644 fs/unicode/tests/.kunitconfig
>  rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (64%)
>  create mode 100644 lib/math/tests/int_log_kunit.c
>  rename lib/math/{rational-test.c =3D> tests/rational_kunit.c} (100%)
>  rename lib/{ =3D> tests}/bitfield_kunit.c (100%)
>  rename lib/{ =3D> tests}/checksum_kunit.c (100%)
>  rename lib/{ =3D> tests}/cmdline_kunit.c (100%)
>  rename lib/{ =3D> tests}/cpumask_kunit.c (100%)
>  rename lib/{ =3D> tests}/crc16_kunit.c (100%)
>  rename lib/{ =3D> tests}/fortify_kunit.c (100%)
>  rename lib/{ =3D> tests}/hashtable_test.c (100%)
>  rename lib/{ =3D> tests}/is_signed_type_kunit.c (100%)
>  create mode 100644 lib/tests/kfifo_kunit.c
>  rename lib/{ =3D> tests}/kunit_iov_iter.c (100%)
>  rename lib/{ =3D> tests}/list-test.c (100%)
>  rename lib/{ =3D> tests}/memcpy_kunit.c (100%)
>  rename lib/{ =3D> tests}/overflow_kunit.c (100%)
>  rename lib/{ =3D> tests}/siphash_kunit.c (100%)
>  rename lib/{ =3D> tests}/slub_kunit.c (100%)
>  rename lib/{ =3D> tests}/stackinit_kunit.c (100%)
>  rename lib/{ =3D> tests}/string_helpers_kunit.c (100%)
>  rename lib/{ =3D> tests}/string_kunit.c (100%)
>  rename lib/{ =3D> tests}/test_bits.c (100%)
>  rename lib/{ =3D> tests}/test_fprobe.c (100%)
>  rename lib/{ =3D> tests}/test_hash.c (100%)
>  rename lib/{ =3D> tests}/test_kprobes.c (100%)
>  rename lib/{ =3D> tests}/test_linear_ranges.c (100%)
>  rename lib/{ =3D> tests}/test_list_sort.c (100%)
>  rename lib/{ =3D> tests}/test_sort.c (100%)
>  rename lib/{ =3D> tests}/usercopy_kunit.c (100%)
>  rename lib/{ =3D> tests}/util_macros_kunit.c (100%)
>
> --
> 2.47.0.338.g60cca15819-goog
>

