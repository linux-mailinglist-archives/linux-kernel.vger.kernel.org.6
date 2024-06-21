Return-Path: <linux-kernel+bounces-225345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8AD912F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4277E1C21D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1DB17C20E;
	Fri, 21 Jun 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kL0RYT2q"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94782488
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004790; cv=none; b=d5fZ3ItLn5Okfd9mKA6J0LwYS0anRTBC5g/MqST2VR3RQh5tNKbNN1xONAiL1epWRrtkUvOkfhI4kHqdkhLIZwsB0PLIOzEUcYkoghQ9ZTnf3glBGfzTXalvSU86D6cYfJjXgsRN+sUoY7wWuzM5bWmZ32jnIMT5BD2HwtPU1KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004790; c=relaxed/simple;
	bh=5XHHMKk4nrpuQrS++N+tdEYS245V96nvkY6ZidvUSMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ3MfPWcKD+Qp0d+0rE2I7i/gx5xKNzACqKDOf2ff/3vi6zI3JBvGhv0OzXDfWpY9IJo9P+uHCCerf1t8cB3ex5BGF+XW3ugu23XoIqSSexHHmvlJyS3xjA4vJbVIlgcsP+rajZS5Ex1lZ8PpPquQ50epOGDv4WeQa9yVxOV0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kL0RYT2q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424877221d6so9005e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719004787; x=1719609587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=487Z5jEIialMJaJUH5v8eHBq6SrBQrtZB46/x7TUKe8=;
        b=kL0RYT2qQPC5+aJ/LJ8NbVKiew0WTtXHn0M3vqDKc/HETq+3cuc2C5w05ENkAnyYrk
         y6graS0cLazNo71AOaMQvtzfhNEIgD2mWFj6XqT0szc2JgdtphRZmBQfDA+rem+Akvsr
         yOWO7PnsUYEyXGixypkcQtKKpeYJGEBc3OBSSn+phq5WtCXWfWU0UQe/s0uGl9qDjK7g
         dCbozCeidDgv/LcG8fPSzNAmVrPIAo2x68O9P74KE5FKRFUYEe6SozcZgrOtFJ9wpNmr
         v1JdGb1fp1pK/G63dt/QQkDgIG6hbGNojKpAiFIP8AZAB9pIeoQz81FtJiQQIDdrMAEu
         YxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004787; x=1719609587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=487Z5jEIialMJaJUH5v8eHBq6SrBQrtZB46/x7TUKe8=;
        b=e8Svtw2QFNLkGOHh0GG8kEurFDqGr6OUOFchTeHfor27x9q1GNbOX1wtSXKwmq35N4
         WqV9ybGfiq6rJd30Rv+V7NZ/GbfBxc4eJ6Z58q/HthcVA1qdP6WwMN8WQhhNHHN94KEn
         hrFmy7u8FCPs6uugr9EFNgQj0hJRYX3m50RP0MQc26+E/QzdG4eeQIlLFLh6N0JWR9Ne
         nqaVeNnvgXLaraSVTQu6ZtnGsHjbHZ2aKJ+hcWhoJn34/WeSQFLAc33Eqkyc4MIg1ch2
         l+x29fGAiE5Z4SCUOKvDRX0Mr/bMtLCnqk+i9qXgaYQPo+I9iOOJJHS0VCyFO8EKtRLR
         WPCw==
X-Forwarded-Encrypted: i=1; AJvYcCUwK1QGqAwxdYkOF+GW3W+Np/Yd4Rfv/F39bRvfGmbtFhmScuVkpT7exbdFKgGOQRfWB0vJptEflc3/83isXbJjo47snbKOI8Km9Is4
X-Gm-Message-State: AOJu0Yxy7C+uegS5d1pYsrKZ0PUN0FwmbVH2f420pxT7Ne10GLDDIXSl
	5p5M9eholkirH8ckBu8WKDQawRmOLF631ZSEql6amixIKWH+9KmtgIazAE3fLWFMJ7KASYJQrv3
	Elw5WZxt3/JGdUqqzgf0iLIu0DNnXNymGk4DG
X-Google-Smtp-Source: AGHT+IG22zx+p5stxXawd4YC71kzI0L+IOhy05pWo+AJNfSlRjlWxAKw4a73Vz/nFJDN+H3NorrrrIW/tEhZn8I6nw0=
X-Received: by 2002:a7b:ce90:0:b0:424:8784:26f0 with SMTP id
 5b1f17b1804b1-42487842726mr247125e9.2.1719004786490; Fri, 21 Jun 2024
 14:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com> <20240618170331.264851-5-ivan.orlov0322@gmail.com>
In-Reply-To: <20240618170331.264851-5-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 21 Jun 2024 17:19:34 -0400
Message-ID: <CA+GJov7LzOSfFVRA4rSSeR_AeryWC7hPpXki8RDQDywa4ngEig@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kunit: assert_test: Prepare to be merged into kunit-test.c
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:03=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> Add 'kunit_assert_' prefix for 'is_literal' and 'is_str_literal'
> functions. This way we will be sure that we are not exporting ambiguous
> symbols into the KUnit namespace.
>
> Export these (and other) functions from assert into the KUnit namespace,
> so we could use them in the tests (and cover them as well).
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hi!

This looks good to me. I am happy with the changes since v1.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks for your work on this!
-Rae

> ---
> V1 -> V2:
> - Besides exporting the non-static functions from assert.c into the
> KUnit namespace, rename some of them as well (add kunit_assert_ prefix
> to make their names less ambiguous).
>
>  include/kunit/assert.h  |  4 ++--
>  lib/kunit/assert.c      | 19 +++++++++++++------
>  lib/kunit/assert_test.c | 40 ++++++++++++++++++++--------------------
>  3 files changed, 35 insertions(+), 28 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 7e7490a74b13..3994acc520ae 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -221,8 +221,8 @@ void kunit_mem_assert_format(const struct kunit_asser=
t *assert,
>  #if IS_ENABLED(CONFIG_KUNIT)
>  void kunit_assert_print_msg(const struct va_format *message,
>                             struct string_stream *stream);
> -bool is_literal(const char *text, long long value);
> -bool is_str_literal(const char *text, const char *value);
> +bool kunit_assert_is_literal(const char *text, long long value);
> +bool kunit_assert_is_str_literal(const char *text, const char *value);
>  void kunit_assert_hexdump(struct string_stream *stream,
>                           const void *buf,
>                           const void *compared_buf,
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 867aa5c4bccf..62b86bf5603e 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -38,6 +38,7 @@ void kunit_assert_print_msg(const struct va_format *mes=
sage,
>         if (message->fmt)
>                 string_stream_add(stream, "\n%pV", message);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
>
>  void kunit_fail_assert_format(const struct kunit_assert *assert,
>                               const struct va_format *message,
> @@ -91,7 +92,8 @@ void kunit_ptr_not_err_assert_format(const struct kunit=
_assert *assert,
>  EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
>
>  /* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
> -VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
> +VISIBLE_IF_KUNIT
> +bool kunit_assert_is_literal(const char *text, long long value)
>  {
>         char *buffer;
>         int len;
> @@ -112,6 +114,7 @@ VISIBLE_IF_KUNIT bool is_literal(const char *text, lo=
ng long value)
>
>         return ret;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_is_literal);
>
>  void kunit_binary_assert_format(const struct kunit_assert *assert,
>                                 const struct va_format *message,
> @@ -127,12 +130,12 @@ void kunit_binary_assert_format(const struct kunit_=
assert *assert,
>                           binary_assert->text->left_text,
>                           binary_assert->text->operation,
>                           binary_assert->text->right_text);
> -       if (!is_literal(binary_assert->text->left_text, binary_assert->le=
ft_value))
> +       if (!kunit_assert_is_literal(binary_assert->text->left_text, bina=
ry_assert->left_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D %lld (0x%llx)\n",
>                                   binary_assert->text->left_text,
>                                   binary_assert->left_value,
>                                   binary_assert->left_value);
> -       if (!is_literal(binary_assert->text->right_text, binary_assert->r=
ight_value))
> +       if (!kunit_assert_is_literal(binary_assert->text->right_text, bin=
ary_assert->right_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D %lld (0x%llx)",
>                                   binary_assert->text->right_text,
>                                   binary_assert->right_value,
> @@ -168,7 +171,8 @@ EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
>  /* Checks if KUNIT_EXPECT_STREQ() args were string literals.
>   * Note: `text` will have ""s where as `value` will not.
>   */
> -VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value=
)
> +VISIBLE_IF_KUNIT
> +bool kunit_assert_is_str_literal(const char *text, const char *value)
>  {
>         int len;
>
> @@ -180,6 +184,7 @@ VISIBLE_IF_KUNIT bool is_str_literal(const char *text=
, const char *value)
>
>         return strncmp(text + 1, value, len - 2) =3D=3D 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_is_str_literal);
>
>  void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>                                     const struct va_format *message,
> @@ -195,11 +200,12 @@ void kunit_binary_str_assert_format(const struct ku=
nit_assert *assert,
>                           binary_assert->text->left_text,
>                           binary_assert->text->operation,
>                           binary_assert->text->right_text);
> -       if (!is_str_literal(binary_assert->text->left_text, binary_assert=
->left_value))
> +       if (!kunit_assert_is_str_literal(binary_assert->text->left_text, =
binary_assert->left_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D \"%s\"\n",
>                                   binary_assert->text->left_text,
>                                   binary_assert->left_value);
> -       if (!is_str_literal(binary_assert->text->right_text, binary_asser=
t->right_value))
> +       if (!kunit_assert_is_str_literal(binary_assert->text->right_text,
> +                                        binary_assert->right_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D \"%s\"",
>                                   binary_assert->text->right_text,
>                                   binary_assert->right_value);
> @@ -232,6 +238,7 @@ void kunit_assert_hexdump(struct string_stream *strea=
m,
>                         string_stream_add(stream, " %02x ", buf1[i]);
>         }
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
>
>  void kunit_mem_assert_format(const struct kunit_assert *assert,
>                              const struct va_format *message,
> diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
> index 4a5967712186..4999233180d6 100644
> --- a/lib/kunit/assert_test.c
> +++ b/lib/kunit/assert_test.c
> @@ -11,28 +11,28 @@
>  #define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(=
test, strstr(str, substr))
>  #define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALS=
E(test, strstr(str, substr))
>
> -static void kunit_test_is_literal(struct kunit *test)
> +static void kunit_test_assert_is_literal(struct kunit *test)
>  {
> -       KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
> -       KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
> -       KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
> -       KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890));
> -       KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
> -       KUNIT_EXPECT_FALSE(test, is_literal("", 0));
> -       KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
> -       KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
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
>  }
>
> -static void kunit_test_is_str_literal(struct kunit *test)
> +static void kunit_test_assert_is_str_literal(struct kunit *test)
>  {
> -       KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hell=
o, World!"));
> -       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
> -       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba=
\""));
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
>  }
>
>  KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
> @@ -366,8 +366,8 @@ static void kunit_test_mem_assert_format(struct kunit=
 *test)
>  }
>
>  static struct kunit_case assert_test_cases[] =3D {
> -       KUNIT_CASE(kunit_test_is_literal),
> -       KUNIT_CASE(kunit_test_is_str_literal),
> +       KUNIT_CASE(kunit_test_assert_is_literal),
> +       KUNIT_CASE(kunit_test_assert_is_str_literal),
>         KUNIT_CASE(kunit_test_assert_prologue),
>         KUNIT_CASE(kunit_test_assert_print_msg),
>         KUNIT_CASE(kunit_test_unary_assert_format),
> --
> 2.34.1
>

