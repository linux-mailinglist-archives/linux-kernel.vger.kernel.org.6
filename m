Return-Path: <linux-kernel+bounces-225365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B784912FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2541C225D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA217C221;
	Fri, 21 Jun 2024 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TboRGMOV"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585417A92C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005904; cv=none; b=beojv+dzJXamF2HDXfMFp81rE0EeA10Dof3x45obaglEHf7ivhapackZrIaA4qAizCfHS3mYhv6OcEWoID7SClE0gjpNWUWYKy7G64hxDqf7o3z+XfKqm/sQvirgzj5Cc8bgOFzkp5AQ6CXswX2qjC4dSoc8SlH+Y02COtijIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005904; c=relaxed/simple;
	bh=l3bbqVdOz1ASn3qkjBgp1S+O+JKLuhN+A9e5bmG7qB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3MuBrBvIB1zWWQi9zReUIkkSMV8POu9HGX2Q/a7aYtLKbpU9FPXCykmSLDXISZKut7CCn8NrhE+aGDupSxkPNa1DSzJQE3//8llwDVg0n3ob1PctljFJpuzKHIRIpbR7MOqHouGy42Xw2xmZqIBOrDH2g4GdZGi1ZYpN1uZwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TboRGMOV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so25352a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719005900; x=1719610700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCryBmkhav4Z9T79eC8ZUMHSX1zNM63sUczw4r29u1c=;
        b=TboRGMOVRlKhKT2qF3X5F/6bGxtdq+JiDAgmRidIesvh7yIcEmX58DpVQkMNJnCb4i
         Vp/+MNFGxa380Patbd2AJNoSjMCICOZWN4jR/RhOPOZ32O+58Oncz0F2koEMJHm8GL2Y
         Rrk3QPaJTznObGDyBvvRmSiRPBsBNMc17TNlKNNNXQ5i1aYve3iloW/nQ7I6BDLDF+4H
         A24W57gYStAjBdZWBYr6sqB6ybyqzbwFDVxCWv5aphen3cVMmDzrme0BObBOVgxd2nGl
         c/PlI3WZ9Wd9xe1vOLrviGtEY2aQk6qIWhaPhgEa0SmJ+ShaJ2TjtcTxuz4osBpFn0xh
         IyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005900; x=1719610700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCryBmkhav4Z9T79eC8ZUMHSX1zNM63sUczw4r29u1c=;
        b=ZsLDclfIDuFIiAnHdSKGldjgYgfhIgUGs5J90FvciG0GidwMNdlLoPwWWKIIGXFYAp
         VMLvGguConz165YI8nqNFMA57Vh/98E7iRMqx7k3Ykol83y0vNHebl+Bw0VriUs5YpWt
         o0ImtBkGGjFDUZY8+RZPqd2JuvtNKiPnGEm5HvJhDufBlKXpGQOl1wEvnrjTFBALtywL
         oWx4Fjc+IJ8C9Fm901HYH8YMZOjLD+RqKBvf3tEmEZa2rOCgEpIPztRWke+wlQcNx6vi
         vtT/Wkys+5DwVrbLzVtywjM1qU/KKiwF70ZDolTeT814iXvqAllxERqk53rK9YWADAMo
         Fm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHIMqV9ldRCM3Uiz4Li+TFmUtRGFhhUB3getIhhy6HKiKQUDOX9+LbbyTyDZT+U0NCPeSceOZlIEFIRJp1W/Y+erOIHq4lhaPJvGAW
X-Gm-Message-State: AOJu0Yw6ucIpvsO6G6Z/cltZiUoT/fsivh1SeWaD6bwjUIjnmIYYvRd4
	UF1dFTxf9tmPWq1Z4inIrWPdxk6YJxVbfIxmofRra0LUJ0Awg+3tGU++UwuXAK9yN47jceFieIO
	+xd90HhEj9IS7I6X9cQx/wRqTO6xu0K9ZSE5+
X-Google-Smtp-Source: AGHT+IFlNmZJQs/ZJBd3Jm2MVXxY3Wp4bKkXZoMIpXVYcO3IuF6DBbU3ex2jpHlPl+zgzsEzYh4ZogTxTykjCg+1n78=
X-Received: by 2002:a05:6402:2788:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-57d419eced6mr51638a12.3.1719005898048; Fri, 21 Jun 2024
 14:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com> <20240618170331.264851-6-ivan.orlov0322@gmail.com>
In-Reply-To: <20240618170331.264851-6-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 21 Jun 2024 17:38:05 -0400
Message-ID: <CA+GJov6u0+y-GBS4c2pvEmvUdoezMpXD-MJO3e_G90yefMV-iQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kunit: Merge assertion test into kunit-test.c
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:03=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> Since assert_test covers the part of the KUnit core (the assertion
> formatting functions), I believe it would be better to have it merged
> into kunit-test (as it is done for other tests for the KUnit core).
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hello!

This looks good to me. I don't know if it was necessary to move the
assert tests but I definitely see the reasoning. Happy with this as it
is. There are a few checkpatch warnings I have mentioned below but I
think the use case makes it necessary.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> V1 -> V2:
> - Update considering the changes in the previous patch (use
> kunit_assert_ prefixed functions)
>
>  lib/kunit/Makefile      |   5 -
>  lib/kunit/assert_test.c | 388 ----------------------------------------
>  lib/kunit/kunit-test.c  | 379 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 378 insertions(+), 394 deletions(-)
>  delete mode 100644 lib/kunit/assert_test.c
>
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 478beb536dc9..18e506b897a6 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -21,9 +21,4 @@ obj-y +=3D                              hooks.o
>  obj-$(CONFIG_KUNIT_TEST) +=3D            kunit-test.o
>  obj-$(CONFIG_KUNIT_STRING_STREAM_TEST) +=3D string-stream-test.o
>
> -# string-stream-test compiles built-in only.
> -ifeq ($(CONFIG_KUNIT_TEST),y)
> -obj-$(CONFIG_KUNIT_TEST) +=3D            assert_test.o
> -endif
> -
>  obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=3D    kunit-example-test.o
> diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
> deleted file mode 100644
> index 4999233180d6..000000000000
> --- a/lib/kunit/assert_test.c
> +++ /dev/null
> @@ -1,388 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * KUnit test for the assertion formatting functions.
> - * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
> - */
> -#include <kunit/test.h>
> -#include "string-stream.h"
> -
> -#define TEST_PTR_EXPECTED_BUF_SIZE 32
> -#define HEXDUMP_TEST_BUF_LEN 5
> -#define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(=
test, strstr(str, substr))
> -#define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALS=
E(test, strstr(str, substr))
> -
> -static void kunit_test_assert_is_literal(struct kunit *test)
> -{
> -       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("5", 5));
> -       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("0", 0));
> -       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("1234567890", 123=
4567890));
> -       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("-1234567890", -1=
234567890));
> -       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("05", 5));
> -       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("", 0));
> -       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("-0", 0));
> -       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("12#45", 1245));
> -}
> -
> -static void kunit_test_assert_is_str_literal(struct kunit *test)
> -{
> -       KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"Hello, Wor=
ld!\"", "Hello, World!"));
> -       KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"", ""));
> -       KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"\"", "\"=
"));
> -       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("", ""));
> -       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"", "\""))=
;
> -       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba",=
 "Abacaba"));
> -       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("Abacaba\"",=
 "Abacaba"));
> -       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba\"=
", "\"Abacaba\""));
> -}
> -
> -KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
> -
> -/* this function is used to get a "char *" string from the string stream=
 and defer its cleanup  */
> -static char *get_str_from_stream(struct kunit *test, struct string_strea=
m *stream)
> -{
> -       char *str =3D string_stream_get_string(stream);
> -
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
> -       kunit_add_action(test, kfree_wrapper, (void *)str);
> -
> -       return str;
> -}
> -
> -static void kunit_test_assert_prologue(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       char *str;
> -       const struct kunit_loc location =3D {
> -               .file =3D "testfile.c",
> -               .line =3D 1337,
> -       };
> -
> -       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       /* Test an expectation fail prologue */
> -       kunit_assert_prologue(&location, KUNIT_EXPECTATION, stream);
> -       str =3D get_str_from_stream(test, stream);
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "EXPECTATION");
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> -
> -       /* Test an assertion fail prologue */
> -       string_stream_clear(stream);
> -       kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
> -       str =3D get_str_from_stream(test, stream);
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "ASSERTION");
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> -}
> -
> -/*
> - * This function accepts an arbitrary count of parameters and generates =
a va_format struct,
> - * which can be used to validate kunit_assert_print_msg function
> - */
> -static void verify_assert_print_msg(struct kunit *test,
> -                                   struct string_stream *stream,
> -                                   char *expected, const char *format, .=
..)
> -{
> -       va_list list;
> -       const struct va_format vformat =3D {
> -               .fmt =3D format,
> -               .va =3D &list,
> -       };
> -
> -       va_start(list, format);
> -       string_stream_clear(stream);
> -       kunit_assert_print_msg(&vformat, stream);
> -       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expec=
ted);
> -}
> -
> -static void kunit_test_assert_print_msg(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -
> -       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       verify_assert_print_msg(test, stream, "\nTest", "Test");
> -       verify_assert_print_msg(test, stream, "\nAbacaba -123 234", "%s %=
d %u",
> -                               "Abacaba", -123, 234U);
> -       verify_assert_print_msg(test, stream, "", NULL);
> -}
> -
> -/*
> - * Further code contains the tests for different assert format functions=
.
> - * This helper function accepts the assert format function, executes it =
and
> - * validates the result string from the stream by checking that all of t=
he
> - * substrings exist in the output.
> - */
> -static void validate_assert(assert_format_t format_func, struct kunit *t=
est,
> -                           const struct kunit_assert *assert,
> -                           struct string_stream *stream, int num_checks,=
 ...)
> -{
> -       size_t i;
> -       va_list checks;
> -       char *cur_substr_exp;
> -       struct va_format message =3D { NULL, NULL };
> -
> -       va_start(checks, num_checks);
> -       string_stream_clear(stream);
> -       format_func(assert, &message, stream);
> -
> -       for (i =3D 0; i < num_checks; i++) {
> -               cur_substr_exp =3D va_arg(checks, char *);
> -               ASSERT_TEST_EXPECT_CONTAIN(test, get_str_from_stream(test=
, stream), cur_substr_exp);
> -       }
> -}
> -
> -static void kunit_test_unary_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert =3D {};
> -       struct kunit_unary_assert un_assert =3D {
> -               .assert =3D assert,
> -               .condition =3D "expr",
> -               .expected_true =3D true,
> -       };
> -
> -       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       validate_assert(kunit_unary_assert_format, test, &un_assert.asser=
t,
> -                       stream, 2, "true", "is false");
> -
> -       un_assert.expected_true =3D false;
> -       validate_assert(kunit_unary_assert_format, test, &un_assert.asser=
t,
> -                       stream, 2, "false", "is true");
> -}
> -
> -static void kunit_test_ptr_not_err_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert =3D {};
> -       struct kunit_ptr_not_err_assert not_err_assert =3D {
> -               .assert =3D assert,
> -               .text =3D "expr",
> -               .value =3D NULL,
> -       };
> -
> -       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       /* Value is NULL. The corresponding message should be printed out=
 */
> -       validate_assert(kunit_ptr_not_err_assert_format, test,
> -                       &not_err_assert.assert,
> -                       stream, 1, "null");
> -
> -       /* Value is not NULL, but looks like an error pointer. Error shou=
ld be printed out */
> -       not_err_assert.value =3D (void *)-12;
> -       validate_assert(kunit_ptr_not_err_assert_format, test,
> -                       &not_err_assert.assert, stream, 2,
> -                       "error", "-12");
> -}
> -
> -static void kunit_test_binary_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert =3D {};
> -       struct kunit_binary_assert_text text =3D {
> -               .left_text =3D "1 + 2",
> -               .operation =3D "=3D=3D",
> -               .right_text =3D "2",
> -       };
> -       const struct kunit_binary_assert binary_assert =3D {
> -               .assert =3D assert,
> -               .text =3D &text,
> -               .left_value =3D 3,
> -               .right_value =3D 2,
> -       };
> -
> -       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       /*
> -        * Printed values should depend on the input we provide: the left=
 text, right text, left
> -        * value and the right value.
> -        */
> -       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> -                       stream, 4, "1 + 2", "2", "3", "=3D=3D");
> -
> -       text.right_text =3D "4 - 2";
> -       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> -                       stream, 3, "=3D=3D", "1 + 2", "4 - 2");
> -
> -       text.left_text =3D "3";
> -       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> -                       stream, 4, "3", "4 - 2", "2", "=3D=3D");
> -
> -       text.right_text =3D "2";
> -       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> -                       stream, 3, "3", "2", "=3D=3D");
> -}
> -
> -static void kunit_test_binary_ptr_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert =3D {};
> -       char *addr_var_a, *addr_var_b;
> -       static const void *var_a =3D (void *)0xDEADBEEF;
> -       static const void *var_b =3D (void *)0xBADDCAFE;
> -       struct kunit_binary_assert_text text =3D {
> -               .left_text =3D "var_a",
> -               .operation =3D "=3D=3D",
> -               .right_text =3D "var_b",
> -       };
> -       struct kunit_binary_ptr_assert binary_ptr_assert =3D {
> -               .assert =3D assert,
> -               .text =3D &text,
> -               .left_value =3D var_a,
> -               .right_value =3D var_b,
> -       };
> -
> -       addr_var_a =3D kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GF=
P_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_a);
> -       addr_var_b =3D kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GF=
P_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_b);
> -       /*
> -        * Print the addresses to the buffers first.
> -        * This is necessary as we may have different count of leading ze=
ros in the pointer
> -        * on different architectures.
> -        */
> -       snprintf(addr_var_a, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_a);
> -       snprintf(addr_var_b, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_b);
> -
> -       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -       validate_assert(kunit_binary_ptr_assert_format, test, &binary_ptr=
_assert.assert,
> -                       stream, 3, addr_var_a, addr_var_b, "=3D=3D");
> -}
> -
> -static void kunit_test_binary_str_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert =3D {};
> -       static const char *var_a =3D "abacaba";
> -       static const char *var_b =3D "kernel";
> -       struct kunit_binary_assert_text text =3D {
> -               .left_text =3D "var_a",
> -               .operation =3D "=3D=3D",
> -               .right_text =3D "var_b",
> -       };
> -       struct kunit_binary_str_assert binary_str_assert =3D {
> -               .assert =3D assert,
> -               .text =3D &text,
> -               .left_value =3D var_a,
> -               .right_value =3D var_b,
> -       };
> -
> -       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       validate_assert(kunit_binary_str_assert_format, test,
> -                       &binary_str_assert.assert,
> -                       stream, 5, "var_a", "var_b", "\"abacaba\"",
> -                       "\"kernel\"", "=3D=3D");
> -
> -       text.left_text =3D "\"abacaba\"";
> -       validate_assert(kunit_binary_str_assert_format, test, &binary_str=
_assert.assert,
> -                       stream, 4, "\"abacaba\"", "var_b", "\"kernel\"", =
"=3D=3D");
> -
> -       text.right_text =3D "\"kernel\"";
> -       validate_assert(kunit_binary_str_assert_format, test, &binary_str=
_assert.assert,
> -                       stream, 3, "\"abacaba\"", "\"kernel\"", "=3D=3D")=
;
> -}
> -
> -static const u8 hex_testbuf1[] =3D { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> -                                  0x45, 0x9d, 0x47, 0xd6, 0x47,
> -                                  0x2,  0x89, 0x8c, 0x81, 0x94,
> -                                  0x12, 0xfe, 0x01 };
> -static const u8 hex_testbuf2[] =3D { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> -                                  0x45, 0x9d, 0x47, 0x21, 0x47,
> -                                  0xcd, 0x89, 0x24, 0x50, 0x94,
> -                                  0x12, 0xba, 0x01 };
> -static void kunit_test_assert_hexdump(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       char *str;
> -       size_t i;
> -       char buf[HEXDUMP_TEST_BUF_LEN];
> -
> -       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -       /* Check that we are getting output like <xx> for non-matching nu=
mbers. */
> -       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf2, sizeof(h=
ex_testbuf1));
> -       str =3D get_str_from_stream(test, stream);
> -       for (i =3D 0; i < sizeof(hex_testbuf1); i++) {
> -               snprintf(buf, HEXDUMP_TEST_BUF_LEN, "<%02x>", hex_testbuf=
1[i]);
> -               if (hex_testbuf1[i] !=3D hex_testbuf2[i])
> -                       ASSERT_TEST_EXPECT_CONTAIN(test, str, buf);
> -       }
> -       /* We shouldn't get any <xx> numbers when comparing the buffer wi=
th itself. */
> -       string_stream_clear(stream);
> -       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf1, sizeof(h=
ex_testbuf1));
> -       str =3D get_str_from_stream(test, stream);
> -       ASSERT_TEST_EXPECT_NCONTAIN(test, str, "<");
> -       ASSERT_TEST_EXPECT_NCONTAIN(test, str, ">");
> -}
> -
> -static void kunit_test_mem_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct string_stream *expected_stream;
> -       struct kunit_assert assert =3D {};
> -       static const struct kunit_binary_assert_text text =3D {
> -               .left_text =3D "hex_testbuf1",
> -               .operation =3D "=3D=3D",
> -               .right_text =3D "hex_testbuf2",
> -       };
> -       struct kunit_mem_assert mem_assert =3D {
> -               .assert =3D assert,
> -               .text =3D &text,
> -               .left_value =3D NULL,
> -               .right_value =3D hex_testbuf2,
> -               .size =3D sizeof(hex_testbuf1),
> -       };
> -
> -       expected_stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_stream);
> -       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       /* The left value is NULL */
> -       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> -                       stream, 2, "hex_testbuf1", "is not null");
> -
> -       /* The right value is NULL, the left value is not NULL */
> -       mem_assert.left_value =3D hex_testbuf1;
> -       mem_assert.right_value =3D NULL;
> -       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> -                       stream, 2, "hex_testbuf2", "is not null");
> -
> -       /* Both arguments are not null */
> -       mem_assert.left_value =3D hex_testbuf1;
> -       mem_assert.right_value =3D hex_testbuf2;
> -
> -       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> -                       stream, 3, "hex_testbuf1", "hex_testbuf2", "=3D=
=3D");
> -}
> -
> -static struct kunit_case assert_test_cases[] =3D {
> -       KUNIT_CASE(kunit_test_assert_is_literal),
> -       KUNIT_CASE(kunit_test_assert_is_str_literal),
> -       KUNIT_CASE(kunit_test_assert_prologue),
> -       KUNIT_CASE(kunit_test_assert_print_msg),
> -       KUNIT_CASE(kunit_test_unary_assert_format),
> -       KUNIT_CASE(kunit_test_ptr_not_err_assert_format),
> -       KUNIT_CASE(kunit_test_binary_assert_format),
> -       KUNIT_CASE(kunit_test_binary_ptr_assert_format),
> -       KUNIT_CASE(kunit_test_binary_str_assert_format),
> -       KUNIT_CASE(kunit_test_assert_hexdump),
> -       KUNIT_CASE(kunit_test_mem_assert_format),
> -       {}
> -};
> -
> -static struct kunit_suite assert_test_suite =3D {
> -       .name =3D "kunit-assert",
> -       .test_cases =3D assert_test_cases,
> -};
> -
> -kunit_test_suites(&assert_test_suite);
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index d86f7cb3b3e4..71a3edde2ff4 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -849,10 +849,387 @@ static struct kunit_suite kunit_current_test_suite=
 =3D {
>         .test_cases =3D kunit_current_test_cases,
>  };
>
> +#define TEST_PTR_EXPECTED_BUF_SIZE 32
> +#define HEXDUMP_TEST_BUF_LEN 5
> +#define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(=
test, strstr(str, substr))
> +#define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALS=
E(test, strstr(str, substr))
> +
> +static void kunit_test_assert_is_literal(struct kunit *test)
> +{
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("5", 5));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("0", 0));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("1234567890", 123=
4567890));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("-1234567890", -1=
234567890));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("05", 5));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("", 0));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("-0", 0));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("12#45", 1245));
> +}
> +
> +static void kunit_test_assert_is_str_literal(struct kunit *test)
> +{
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"Hello, Wor=
ld!\"", "Hello, World!"));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"", ""));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"\"", "\"=
"));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("", ""));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"", "\""))=
;
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba",=
 "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("Abacaba\"",=
 "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba\"=
", "\"Abacaba\""));
> +}
> +
> +/* this function is used to get a "char *" string from the string stream=
 and defer its cleanup  */
> +static char *get_str_from_stream(struct kunit *test, struct string_strea=
m *stream)
> +{
> +       char *str =3D string_stream_get_string(stream);
> +
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
> +       kunit_add_action(test, kfree_wrapper, (void *)str);
> +
> +       return str;
> +}
> +
> +static void kunit_test_assert_prologue(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       char *str;
> +       const struct kunit_loc location =3D {
> +               .file =3D "testfile.c",
> +               .line =3D 1337,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Test an expectation fail prologue */
> +       kunit_assert_prologue(&location, KUNIT_EXPECTATION, stream);
> +       str =3D get_str_from_stream(test, stream);
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "EXPECTATION");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> +
> +       /* Test an assertion fail prologue */
> +       string_stream_clear(stream);
> +       kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
> +       str =3D get_str_from_stream(test, stream);
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "ASSERTION");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> +}
> +
> +/*
> + * This function accepts an arbitrary count of parameters and generates =
a va_format struct,
> + * which can be used to validate kunit_assert_print_msg function
> + */
> +static void verify_assert_print_msg(struct kunit *test,
> +                                   struct string_stream *stream,
> +                                   char *expected, const char *format, .=
..)
> +{
> +       va_list list;
> +       const struct va_format vformat =3D {
> +               .fmt =3D format,
> +               .va =3D &list,
> +       };
> +
> +       va_start(list, format);
> +       string_stream_clear(stream);
> +       kunit_assert_print_msg(&vformat, stream);
> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expec=
ted);
> +}
> +
> +static void kunit_test_assert_print_msg(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       verify_assert_print_msg(test, stream, "\nTest", "Test");
> +       verify_assert_print_msg(test, stream, "\nAbacaba -123 234", "%s %=
d %u",
> +                               "Abacaba", -123, 234U);
> +       verify_assert_print_msg(test, stream, "", NULL);
> +}
> +
> +/*
> + * Further code contains the tests for different assert format functions=
.
> + * This helper function accepts the assert format function, executes it =
and
> + * validates the result string from the stream by checking that all of t=
he
> + * substrings exist in the output.
> + */
> +static void validate_assert(assert_format_t format_func, struct kunit *t=
est,
> +                           const struct kunit_assert *assert,
> +                           struct string_stream *stream, int num_checks,=
 ...)
> +{
> +       size_t i;
> +       va_list checks;
> +       char *cur_substr_exp;
> +       struct va_format message =3D { NULL, NULL };
> +
> +       va_start(checks, num_checks);
> +       string_stream_clear(stream);
> +       format_func(assert, &message, stream);
> +
> +       for (i =3D 0; i < num_checks; i++) {
> +               cur_substr_exp =3D va_arg(checks, char *);
> +               ASSERT_TEST_EXPECT_CONTAIN(test, get_str_from_stream(test=
, stream), cur_substr_exp);
> +       }
> +}
> +
> +static void kunit_test_unary_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       struct kunit_unary_assert un_assert =3D {
> +               .assert =3D assert,
> +               .condition =3D "expr",
> +               .expected_true =3D true,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       validate_assert(kunit_unary_assert_format, test, &un_assert.asser=
t,
> +                       stream, 2, "true", "is false");
> +
> +       un_assert.expected_true =3D false;
> +       validate_assert(kunit_unary_assert_format, test, &un_assert.asser=
t,
> +                       stream, 2, "false", "is true");
> +}
> +
> +static void kunit_test_ptr_not_err_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       struct kunit_ptr_not_err_assert not_err_assert =3D {
> +               .assert =3D assert,
> +               .text =3D "expr",
> +               .value =3D NULL,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Value is NULL. The corresponding message should be printed out=
 */
> +       validate_assert(kunit_ptr_not_err_assert_format, test,
> +                       &not_err_assert.assert,
> +                       stream, 1, "null");
> +
> +       /* Value is not NULL, but looks like an error pointer. Error shou=
ld be printed out */
> +       not_err_assert.value =3D (void *)-12;
> +       validate_assert(kunit_ptr_not_err_assert_format, test,
> +                       &not_err_assert.assert, stream, 2,
> +                       "error", "-12");
> +}
> +
> +static void kunit_test_binary_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "1 + 2",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "2",
> +       };
> +       const struct kunit_binary_assert binary_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D 3,
> +               .right_value =3D 2,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /*
> +        * Printed values should depend on the input we provide: the left=
 text, right text, left
> +        * value and the right value.
> +        */
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       stream, 4, "1 + 2", "2", "3", "=3D=3D");
> +
> +       text.right_text =3D "4 - 2";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       stream, 3, "=3D=3D", "1 + 2", "4 - 2");
> +
> +       text.left_text =3D "3";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       stream, 4, "3", "4 - 2", "2", "=3D=3D");
> +
> +       text.right_text =3D "2";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       stream, 3, "3", "2", "=3D=3D");
> +}
> +
> +static void kunit_test_binary_ptr_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       char *addr_var_a, *addr_var_b;
> +       static const void *var_a =3D (void *)0xDEADBEEF;
> +       static const void *var_b =3D (void *)0xBADDCAFE;
> +       struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "var_a",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "var_b",
> +       };
> +       struct kunit_binary_ptr_assert binary_ptr_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D var_a,
> +               .right_value =3D var_b,
> +       };
> +
> +       addr_var_a =3D kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GF=
P_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_a);
> +       addr_var_b =3D kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GF=
P_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_b);
> +       /*
> +        * Print the addresses to the buffers first.
> +        * This is necessary as we may have different count of leading ze=
ros in the pointer
> +        * on different architectures.
> +        */
> +       snprintf(addr_var_a, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_a);
> +       snprintf(addr_var_b, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_b);

This use of %px is flagged here as a checkpatch warning. However,
since this functionality would not work if we just used %p, I think we
can make the case that the use of %px is necessary here. Shuah, let me
know what you think?

> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       validate_assert(kunit_binary_ptr_assert_format, test, &binary_ptr=
_assert.assert,
> +                       stream, 3, addr_var_a, addr_var_b, "=3D=3D");
> +}
> +
> +static void kunit_test_binary_str_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       static const char *var_a =3D "abacaba";
> +       static const char *var_b =3D "kernel";
> +       struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "var_a",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "var_b",
> +       };
> +       struct kunit_binary_str_assert binary_str_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D var_a,
> +               .right_value =3D var_b,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       validate_assert(kunit_binary_str_assert_format, test,
> +                       &binary_str_assert.assert,
> +                       stream, 5, "var_a", "var_b", "\"abacaba\"",
> +                       "\"kernel\"", "=3D=3D");
> +
> +       text.left_text =3D "\"abacaba\"";
> +       validate_assert(kunit_binary_str_assert_format, test, &binary_str=
_assert.assert,
> +                       stream, 4, "\"abacaba\"", "var_b", "\"kernel\"", =
"=3D=3D");
> +
> +       text.right_text =3D "\"kernel\"";
> +       validate_assert(kunit_binary_str_assert_format, test, &binary_str=
_assert.assert,
> +                       stream, 3, "\"abacaba\"", "\"kernel\"", "=3D=3D")=
;
> +}
> +
> +static const u8 hex_testbuf1[] =3D { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> +                                  0x45, 0x9d, 0x47, 0xd6, 0x47,
> +                                  0x2,  0x89, 0x8c, 0x81, 0x94,
> +                                  0x12, 0xfe, 0x01 };
> +static const u8 hex_testbuf2[] =3D { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> +                                  0x45, 0x9d, 0x47, 0x21, 0x47,
> +                                  0xcd, 0x89, 0x24, 0x50, 0x94,
> +                                  0x12, 0xba, 0x01 };
> +static void kunit_test_assert_hexdump(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       char *str;
> +       size_t i;
> +       char buf[HEXDUMP_TEST_BUF_LEN];
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       /* Check that we are getting output like <xx> for non-matching nu=
mbers. */
> +       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf2, sizeof(h=
ex_testbuf1));
> +       str =3D get_str_from_stream(test, stream);
> +       for (i =3D 0; i < sizeof(hex_testbuf1); i++) {
> +               snprintf(buf, HEXDUMP_TEST_BUF_LEN, "<%02x>", hex_testbuf=
1[i]);
> +               if (hex_testbuf1[i] !=3D hex_testbuf2[i])
> +                       ASSERT_TEST_EXPECT_CONTAIN(test, str, buf);
> +       }
> +       /* We shouldn't get any <xx> numbers when comparing the buffer wi=
th itself. */
> +       string_stream_clear(stream);
> +       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf1, sizeof(h=
ex_testbuf1));
> +       str =3D get_str_from_stream(test, stream);
> +       ASSERT_TEST_EXPECT_NCONTAIN(test, str, "<");
> +       ASSERT_TEST_EXPECT_NCONTAIN(test, str, ">");
> +}
> +
> +static void kunit_test_mem_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct string_stream *expected_stream;
> +       struct kunit_assert assert =3D {};
> +       static const struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "hex_testbuf1",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "hex_testbuf2",
> +       };
> +       struct kunit_mem_assert mem_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D NULL,
> +               .right_value =3D hex_testbuf2,
> +               .size =3D sizeof(hex_testbuf1),
> +       };
> +
> +       expected_stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_stream);
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* The left value is NULL */
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> +                       stream, 2, "hex_testbuf1", "is not null");
> +
> +       /* The right value is NULL, the left value is not NULL */
> +       mem_assert.left_value =3D hex_testbuf1;
> +       mem_assert.right_value =3D NULL;
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> +                       stream, 2, "hex_testbuf2", "is not null");
> +
> +       /* Both arguments are not null */
> +       mem_assert.left_value =3D hex_testbuf1;
> +       mem_assert.right_value =3D hex_testbuf2;
> +
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> +                       stream, 3, "hex_testbuf1", "hex_testbuf2", "=3D=
=3D");
> +}
> +
> +static struct kunit_case kunit_assert_test_cases[] =3D {
> +       KUNIT_CASE(kunit_test_assert_is_literal),
> +       KUNIT_CASE(kunit_test_assert_is_str_literal),
> +       KUNIT_CASE(kunit_test_assert_prologue),
> +       KUNIT_CASE(kunit_test_assert_print_msg),
> +       KUNIT_CASE(kunit_test_unary_assert_format),
> +       KUNIT_CASE(kunit_test_ptr_not_err_assert_format),
> +       KUNIT_CASE(kunit_test_binary_assert_format),
> +       KUNIT_CASE(kunit_test_binary_ptr_assert_format),
> +       KUNIT_CASE(kunit_test_binary_str_assert_format),
> +       KUNIT_CASE(kunit_test_assert_hexdump),
> +       KUNIT_CASE(kunit_test_mem_assert_format),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_assert_test_suite =3D {
> +       .name =3D "kunit-assert",
> +       .test_cases =3D kunit_assert_test_cases,
> +};
> +
>  kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suit=
e,
>                   &kunit_log_test_suite, &kunit_status_test_suite,
>                   &kunit_current_test_suite, &kunit_device_test_suite,
> -                 &kunit_fault_test_suite);
> +                 &kunit_fault_test_suite, &kunit_assert_test_suite);
>
>  MODULE_DESCRIPTION("KUnit test for core test infrastructure");
>  MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> --
> 2.34.1
>

