Return-Path: <linux-kernel+bounces-427035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836569DFB77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9EE163433
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073231F9EB4;
	Mon,  2 Dec 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEQM101d"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE81F9EA7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126160; cv=none; b=M364S7ykPEKA1gQsFWicCt/LDywCMji8vMIlqXY1+4v8Od2A1P5WGq/mByHmSKlqeV9U147YTxHs8gZZQZxBGJY1GlyN2RuvTqPAsosjXRDNmPiUNDro4NTZE4o4chibYrK53OkO0cyBXWucxnO0BhyKjDZeKL+KA1+ivZLYNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126160; c=relaxed/simple;
	bh=CcwBr1pdX1hbhnO2lIC3mhYlJa/UfgyYzruDoRr12f4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pwGZMX1xz+8crQTmVnyRNmVeX63A+61WU5HFaPgVUANMMrAd8lF6nMWXgRrkPiMNIpp3VYD9UqsjEcWdPDXW1BgIMN0oIDb03YwZF9R6DJGFd/TH0O4cVLGAFGv/K+XESKNpxBPQ/fAeQitL7w+y1p3cHULhe1v30jajzBCNBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEQM101d; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3a7807feadfso34498215ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 23:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733126158; x=1733730958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=94n4MHfZago95H2Ehby0lfepfNkVyiA7XUKBvPRgGq8=;
        b=kEQM101dV0bvz4Mhj3ghpczFChLIvm8u7YC5oBc1I229FCC0jVf09JWt8i/85x/ktV
         sDMgGO1DK6T5Qa7kohOpiye6+B6C6HNWpchj59cSsrrDw6UiQSDzt/2OR84A69HQAn50
         McYnGcHVaTZ90e6IuzZH6iKRxyk4a9Mgafo9so88PAqNW3KXMHCz4N8ht1FLEUXINPHF
         MLVdhp5G4Rnpco7uSWZ3LKud9GmMuyymP1lmuZS5eJby4K+0rKSrntlp+ld0CB6fxt+X
         f0HIwES0OPx0Zpin/GHc/DcU9trDe+QRXpC6aj+ToBM0oHjKvpJDMRT+PbEvVjkCqxW+
         XaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733126158; x=1733730958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94n4MHfZago95H2Ehby0lfepfNkVyiA7XUKBvPRgGq8=;
        b=GYJMVIhoorXA//aa+ILQnGamjL95rhNcW3DsyeixNM8TMhlCwgoyH2dNq7Dds2yH7g
         BUOJrYViT1ZL1RlIbZf8LsGONspqNkRbxZPHDrJ1FEBGHdIrh89mMMZPa/FYOso9OPzD
         GDp7MTmZN9YmYaRarhiJNz1xoFZJPDySD8Xd9qlB9Nt7R6xwwO2h+nUa+3zWOYK+4rIj
         VAbQzOKEy7eTdgP1sU9wDlck7t3uJeuOe79rKopGgEriFpVMSnkSDOX1ALpaM5IyfsxU
         6wirBzupyVS9dus81g65vulpW0i/3jF5oSfOPg/AQ+yocIoICUrYB8I59SkrXQcUJ4gB
         EEgA==
X-Forwarded-Encrypted: i=1; AJvYcCVQfCSxZJNPMSf7TU45n5T0eHhUBnpfzIvQZw8Kvezd8/6v5ZndKK8CkfFgB/XabAOKoNox3U6FXVRPn94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4fhpKphpvqpk+yFlbJRg3eV4OepjdBRPoldCdsiJfNiy4c9s
	koLl8miId2uL3cIv8V6+OmreE3/wAUgN0LjBodtc1FzouPFg7nvoUHoAzFJsdC/xnJMlC9TmTHG
	bp4YtsDbyjw==
X-Google-Smtp-Source: AGHT+IHuIFBcyPiV7QsjE3NU9vB7h2NpBJQm7Zferw0a07aEtyytICdGZvKQpzCBq7/XmaJK0mzFFVq/BDqupQ==
X-Received: from pgcv26.prod.google.com ([2002:a05:6a02:531a:b0:7fb:d8e8:ded3])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:194b:b0:3a7:9533:c3ac with SMTP id e9e14a558f8ab-3a7c55259cfmr190932205ab.4.1733126158041;
 Sun, 01 Dec 2024 23:55:58 -0800 (PST)
Date: Mon,  2 Dec 2024 15:55:38 +0800
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202075545.3648096-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202075545.3648096-2-davidgow@google.com>
Subject: [PATCH v2 1/6] lib: math: Move kunit tests into tests/ subdir
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Nicolas Pitre <npitre@baylibre.com>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

This patch is a follow-up task from a discussion stemming from point 3
in a recent patch introducing the int_pow kunit test [1] and
documentation regarding kunit test style and nomenclature [2].

Colocate all kunit test suites in lib/math/tests/ and
follow recommended naming convention for files <suite>_kunit.c
and kconfig entries CONFIG_<name>_KUNIT_TEST.

Link: https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/ [1]
Link: https://docs.kernel.org/dev-tools/kunit/style.html [2]

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Acked-by: Nicolas Pitre <npitre@baylibre.com>
[Rebased on top of v6.13-rc1, removed non-kunit tests]
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/Kconfig.debug                                    | 2 +-
 lib/math/Makefile                                    | 4 ++--
 lib/math/tests/Makefile                              | 3 ++-
 lib/math/{rational-test.c => tests/rational_kunit.c} | 0
 4 files changed, 5 insertions(+), 4 deletions(-)
 rename lib/math/{rational-test.c => tests/rational_kunit.c} (100%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..7b90948666bf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3145,7 +3145,7 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
-config INT_POW_TEST
+config INT_POW_KUNIT_TEST
 	tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 3ef11305f8d2..d1caba23baa0 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
-obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+
+obj-y += tests/
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index 6a169123320a..8ce8040e00c5 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
+obj-$(CONFIG_INT_POW_KUNIT_TEST)  += int_pow_kunit.o
+obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o
diff --git a/lib/math/rational-test.c b/lib/math/tests/rational_kunit.c
similarity index 100%
rename from lib/math/rational-test.c
rename to lib/math/tests/rational_kunit.c
-- 
2.47.0.338.g60cca15819-goog


