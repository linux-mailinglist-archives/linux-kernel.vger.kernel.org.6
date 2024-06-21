Return-Path: <linux-kernel+bounces-225329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C3912F29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E24B1C21ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0FC17BB1C;
	Fri, 21 Jun 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nm1YQUsx"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19E16D4F5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004054; cv=none; b=tV/y1W+6lsYWlS4zF0um09rdaFhOCAlWnraC1y+vYob52ILiOuuAOGgYUfHaCPxrBKUrK8s1zYvW6SL+/VvhWofFJg7jT5i77z1FkUZ/wMNe4SchX9XlwLDa3swCIdf+3oBxsXCj8JxWU1EJEbxOlBdiRoDaVMLIxGDe9QUu0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004054; c=relaxed/simple;
	bh=XgUW3LEfhTj5B4QUg7GGCfpg3FEyOByCAvwb+evNrco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DO47qwBIZ7gRnZcAJV7GPsk6+SimZ/yzqH5yRds81KAKv7Y8owyHtaNABGhSxwPNCRQwsBxho5GOk1a6DiSzP/vKwNMf1mqt0zB5NAxe5k1V+fSqY0hpFfX6hdDJOO4w8zB46aQI87NDktBo5roZCF6oo2g98HcCZ1WgETsbLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nm1YQUsx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-422f7c7af49so148665e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719004050; x=1719608850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eryb272LK3HBx2dJfWKCg561fdhVAi5B8rKxZdt2Nn0=;
        b=nm1YQUsxhfJovk0hzQP6L+ahm2lwzkKnimHFgX3ifCP+yxs3zdAdr+XcNdmlxh+qbl
         FjYr1o7iNJxqZDlkFEXwTP/jt0em2nMnAyrnEmKMQlnRHjy5F7Nq+J4iRqhIE+v4zqW2
         RNy2TC5A8mYLI013OY/ugVnGYPa7FQDHCojkIHXlJdGYU+1oQ4nE0RO3IF6HLlicMBWG
         5qPH0bIeTZHyZG4BHnfqRrxWdKeIAkpb/3AlAZi8oKFYg5gn7dP2GO7y2wfMmg13hDd6
         z31lNEcrlOKFNo3fa1DDwVQRhqNjysYQuHAr66T57YQSlwMHIoab9oJdOBMOTGZBSU1o
         COoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004050; x=1719608850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eryb272LK3HBx2dJfWKCg561fdhVAi5B8rKxZdt2Nn0=;
        b=N49UNXNps4t3XEnyzhGysK3P1apwGYzitLRxYSScsp5sYhkpRjlRYm5byswncYsUmJ
         ioDAWmyCGnPDRDQGB9eCXUvJAVxnzfsU9MY1PJ/gmA8mbz2pi0Z+W6lLsgBRDpq7zjQI
         KPjBMUtdj7GwIqhbagUdTKldu7c57DVpAVnDS2aRyOlvANZmeJms9JLrq2ApsxEJU6PG
         KVcCM5jgHbnr4GUQv3g3UPPu0KwT0At3nxq8/ApdrlQ4klHvgbbJfQj8SxytvvGEaAzG
         02PS7MWEOGIPA3SS1Eq/N6awI2UPy56wHCx/P1gCRd+CKxN3NmFdgcbp7AzCOiuzKE0m
         aKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZEQU0JZWFfLY9RYnTeU356e+4wDDoJNt0Wjb2pGJdUH1pZlq4LMKX6XYqYtGd2ejo0gq+ksc/2LoSGLKU07B+otQ5NlWKNiGBhEWJ
X-Gm-Message-State: AOJu0YybDV3NGYgZEBf2JHznYzB7w6hifoycg/9Z9VVQW05n6mm/RIww
	mF9N2v7i5ot4Bb1etGZ9sNZabj1U3d2IojddTAiWInWTKiSfsvi7Es2bOk9JytNBFi2vYsa8CRt
	anlJBHgqIQtPoTGZIhuNygCHIrJuKUbNfazS9
X-Google-Smtp-Source: AGHT+IF1oDts+tFhSy3UVBEjSE4kr8DrRad9k16c46fxu2g9qG/cEQL5Wd7UmfDCaVHtbD+x5Y0B0xlMa03ILQZ6o+4=
X-Received: by 2002:a05:600c:5014:b0:421:6c54:3a8 with SMTP id
 5b1f17b1804b1-424876e0088mr230965e9.7.1719004049667; Fri, 21 Jun 2024
 14:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com> <20240618170331.264851-4-ivan.orlov0322@gmail.com>
In-Reply-To: <20240618170331.264851-4-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 21 Jun 2024 17:07:16 -0400
Message-ID: <CA+GJov6NBkPUmPSW6ir1Z0Gc9gFXP6dP-GhnoQU7nCRW0yXTLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kunit: string-stream-test: Make it a separate module
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:03=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> Currently, the only way to build string-stream-test is by setting
> CONFIG_KUNIT_TEST=3Dy. However, CONFIG_KUNIT_TEST is a config option for
> a different test (`kunit-test.c`).
>
> Introduce a new Kconfig entry in order to be able to build the
> string-stream-test test as a separate module. Import the KUnit namespace
> in the test so we could have string-stream functions accessible.
>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hello!

This is looking good to me other than the module description as noted
by Jeff. That could be a separate patch since the rest of the series
is looking good.

There is the checkpatch warning on the module description. But as
David mentioned, the description looks ok to me. If there is a new
version of this patch, it may be worth trying to get rid of the
warning by lengthening the description.

But I am happy with this patch as is.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> V1 -> V2:
> - No changes
>
>  lib/kunit/Kconfig              | 8 ++++++++
>  lib/kunit/Makefile             | 2 +-
>  lib/kunit/string-stream-test.c | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 34d7242d526d..b0713c0f9265 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -45,6 +45,14 @@ config KUNIT_TEST
>           purposes by developers interested in testing that KUnit works a=
s
>           expected.
>
> +config KUNIT_STRING_STREAM_TEST
> +       tristate "KUnit test for string-stream" if !KUNIT_ALL_TESTS
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enables the KUnit test for the string-stream (C++ stream style =
string
> +         builder used in KUnit for building messages). For the string-st=
ream
> +         implementation, see lib/kunit/string-stream.c.
> +
>  config KUNIT_EXAMPLE_TEST
>         tristate "Example test for KUnit" if !KUNIT_ALL_TESTS
>         default KUNIT_ALL_TESTS
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 30f6bbf04a4a..478beb536dc9 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -19,10 +19,10 @@ endif
>  obj-y +=3D                               hooks.o
>
>  obj-$(CONFIG_KUNIT_TEST) +=3D            kunit-test.o
> +obj-$(CONFIG_KUNIT_STRING_STREAM_TEST) +=3D string-stream-test.o
>
>  # string-stream-test compiles built-in only.
>  ifeq ($(CONFIG_KUNIT_TEST),y)
> -obj-$(CONFIG_KUNIT_TEST) +=3D            string-stream-test.o
>  obj-$(CONFIG_KUNIT_TEST) +=3D            assert_test.o
>  endif
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-tes=
t.c
> index 7511442ea98f..d03cac934e04 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -534,3 +534,5 @@ static struct kunit_suite string_stream_test_suite =
=3D {
>         .init =3D string_stream_test_init,
>  };
>  kunit_test_suites(&string_stream_test_suite);
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

