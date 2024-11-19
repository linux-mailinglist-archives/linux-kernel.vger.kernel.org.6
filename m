Return-Path: <linux-kernel+bounces-414158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6F9D23CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAAF282F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5A913AD03;
	Tue, 19 Nov 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l92l8rp2"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556821C4A01
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013276; cv=none; b=CXphPbveviZui105XWeAw6LPrDC6QAB2QCiUd+uncL8cSDcP6615hymGCQeHx58X45Mld0ciQq4OfMj9lcdarkRoBLPFMBNkV8mehFsSh+PapHHNg9sG+FcZmiVfivcVuQdgECs8ivVWtNNZQdJZGd8Q6I4akGYXAiOvsWiElfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013276; c=relaxed/simple;
	bh=+8OEVnPGa46gHtkRF9wvJKb+QNcihrIDAtiCUEXgyic=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pEPLKkhk0SG8VH7u1j2bYnLnXDjtoGtVlcA1R8IHa9aJ4iXs8FbwmnVkqRRqt6aEekDfuK6ToOfFPNVsrpPyXR2vUdLxruErUiZwBNT7w9WgJJKmpVXS9DVfW/l4IZvfitamzhx/t9OEIhKgO8zsxGvi/IfOOQdROYS5mXmLmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l92l8rp2; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-856e76fdf11so1487455241.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732013273; x=1732618073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/xsQ9zP4NpkXypxR7yTAJiAxxPPAP90eO4pmL1ZKo28=;
        b=l92l8rp2qRukMWs6/kvrjY2PjdRbEQSOE8G7tgN9XB2fobEUiY/LcxvpvwBKY7hFD8
         GSvzYShxFsqv60ZPkdkgo67uBoiRI7jgvEJoRhAFksHvDXfDmsO9aRyFfVj9hwvIwcTr
         Sw2R3/IezFpzn+RA+IjF2GNCkvDoNjIfjjtQzu/LOut+etHQAs4uGjQzSNoEKTTLmfXQ
         6Fnw2sQOJZ8L7yx7Pedgmy0Mxlp9Hs4k+bRIGeh5EV1seBatbjq6Wtqfs8gRgbPbHLeW
         YD9r6jHeug7rQnaeRRnLvtuU0iXLgF9VcI5yH/0Q6OmyYfku/GrPOgCJznh77j7hajDp
         3cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732013273; x=1732618073;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xsQ9zP4NpkXypxR7yTAJiAxxPPAP90eO4pmL1ZKo28=;
        b=fTGxmQ+i4TqcI2TOMMoZBozqJafNGPCBpXroTjz3d2Bph2ojlv+JLBRpzLxEWTCNmp
         BDQZB/zVF9yY/TuYFSs0vVUxAoNILHK9giE3bLldhKage/lzPNfSsIBxNK1q9v8RGUxG
         dYGbLDwy/5j6/jRlb2VTpq1aG4X2aD2geBXOILZ4TViXXciMUAYac2crJfsZddK8r6X0
         g9MBVDaM2WbcXXI8Ws2qWT5bt9vx6kOtpq8Vaat6Axjgu8TQTnzqCbcZopRdphZMDgpb
         3ZOCF6w3yL7KgPws88txaCQDJMEIO/21aiTf+VcMQ8OGlGr/Ovg4pgyUkM8AegAOMd8v
         FO7w==
X-Forwarded-Encrypted: i=1; AJvYcCV2TDHCZ9u9QbihnwlVvc6DxXQ/kQpSenK04JvSRA0sMd3thfizv1q1ba8tVVtkl6JyJUcStmmTwdeO3M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWTNM4tE1jxmEevBg80zj/ixtVWWrgjErdd7XG5+vhcnqRffN
	fDTWPNIYXMZkU7+wJSoXOu6ic9TbaMWI4Xb+UoaHswyazUvdeGvMNmTl49dujxpPq2QMwE8vidj
	zUR9PwVKhFnSyBpE+Owgj1TQiZF37rQomUmSJUg==
X-Google-Smtp-Source: AGHT+IGfIAmzbAQ3UPbaFATsGGzkHqD5l3RInFAgMeY1qUh9DTK1A9Bywf+fKHzZOfbxXYAtr1BvjAgtEJqRaRvJkrE=
X-Received: by 2002:a05:6102:3ec7:b0:4a7:4900:4b83 with SMTP id
 ada2fe7eead31-4ad62b4d937mr14474408137.15.1732013273183; Tue, 19 Nov 2024
 02:47:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Nov 2024 16:17:41 +0530
Message-ID: <CA+G9fYs0mh8ex1wWYTW_o+BstwCAZ6rgQJZbGRkSH4WoQNTJdw@mail.gmail.com>
Subject: DEFINE_FLEX_test: EXPECTATION FAILED at lib/overflow_kunit.c:1200:
To: clang-built-linux <llvm@lists.linux.dev>, kunit-dev@googlegroups.com, 
	open list <linux-kernel@vger.kernel.org>
Cc: David Gow <davidgow@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

The overflow_DEFINE_FLEX_test KUnit test case. This test consistently
passes when built with GCC-13 but fails when using Clang-19 or
Clang-nightly.

Test Case: overflow_DEFINE_FLEX_test
Compilers: Passing: GCC-13
           Failing: Clang-19, Clang-nightly
Observed Behavior: The test failure is reproducible with Clang builds,
                   while GCC builds produce consistent success.

This inconsistency suggests a potential issue either in the Clang toolchain
or in the test implementation that is exposed by Clang's compilation behavior.

Test log:
----------
<6>[   92.471692]     # castable_to_type_test: 103 castable_to_type()
tests finished
<6>[   92.474933]     ok 21 castable_to_type_test
<3>[   92.476715]     # DEFINE_FLEX_test: EXPECTATION FAILED at
lib/overflow_kunit.c:1200
<3>[   92.476715]     Expected
__builtin_dynamic_object_size(two_but_zero, 0) == expected_raw_size,
but
<3>[   92.476715]         __builtin_dynamic_object_size(two_but_zero,
0) == 12 (0xc)
<3>[   92.476715]         expected_raw_size == 8 (0x8)
<6>[   92.480178]     not ok 22 DEFINE_FLEX_test
<6>[   92.483020] # overflow: pass:21 fail:1 skip:0 total:22


Test failed log with clang-19 and clang-nightly :
-----------------------------------------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241119/testrun/25908897/suite/kunit/test/overflow_DEFINE_FLEX_test/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241119/testrun/25908897/suite/kunit/test/overflow_DEFINE_FLEX_test/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241119/testrun/25908335/suite/kunit/test/overflow_DEFINE_FLEX_test/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241119/testrun/25908335/suite/kunit/test/overflow_DEFINE_FLEX_test/details/

Test history:
----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241119/testrun/25908897/suite/kunit/test/overflow_DEFINE_FLEX_test/history/

Test pass log with gcc-13
----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241119/testrun/25908488/suite/kunit/test/overflow_DEFINE_FLEX_test/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241119/testrun/25908488/suite/kunit/test/overflow_DEFINE_FLEX_test/details/

Build image:
-----------
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2p3Z8y7TVGQ8pXwjhYTnnMNxFpZ/

Steps to reproduce test run:
------------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2p3ZAtZdJgM7AbNB5vGAGDf73vx/reproducer
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2p3ZAtZdJgM7AbNB5vGAGDf73vx/tux_plan

Steps to reproduce builds:
----------
- tuxmake --runtime podman \
          --target-arch arm64 \
          --toolchain clang-19 \
          --kconfig defconfig \
          --kconfig-add CONFIG_KASAN=y \
          --kconfig-add CONFIG_KUNIT=y \
          --kconfig-add CONFIG_KUNIT_ALL_TESTS=y LLVM=1 LLVM_IAS=1

metadata:
----
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git sha: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2p3Z8y7TVGQ8pXwjhYTnnMNxFpZ/config
build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2p3Z8y7TVGQ8pXwjhYTnnMNxFpZ/
toolchain: clang-19 and clang-nightly
config: defconfig + KASAN + KUNIT + KUNIT_ALL_TESTS
arch: arm64, armv5

Please let me know if more information or logs are required.

--
Linaro LKFT
https://lkft.linaro.org

