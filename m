Return-Path: <linux-kernel+bounces-275507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716F94869E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C961F21C76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327D23A0;
	Tue,  6 Aug 2024 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFQ5P5R1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC210F2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722903809; cv=none; b=MgDBHwVo+E+6BNzd6q1i34a/gU6Uu26CQBME+8Vs/XhHR4hMGysp0jzWRxlChpcRrQDA3TAY/T0VP2o5nDVUMMiv+ihKcCqf2dvcUYsszwqGOpiAv2VIh1kNBu6sfB//KgtKS9o0+j/sp6tRNXR0zISXM3MhWBAqHzfoHjqjtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722903809; c=relaxed/simple;
	bh=Y4thmYZAfoMzC1yfRsLinoQGaj8/a37spieo1hFhhfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwFrZhr5d9zlpXQi41xVsIYrgMIlReXH1Ypzp2JU4jxltKaRuv5GoX53YOUSYbMa3bkfeiPaAfT4q59krX0Cqg0pBrTvpdHs+uggWuVsCzdr3g3NSTTJY2NEoT8jaUdQUJyAy7ve1CKYvgq/v8Dng9kUrMptOJVpnn+2Zwngs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFQ5P5R1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722903806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJlfPXtmMFFW1men+UhmIi3WVByyjRhzXx3BjNaIlwg=;
	b=DFQ5P5R1nyB3wNmM4ex+nS2w9Gga2Jic4C8ZwXlLzu2Du8cj0Oh4zRRMbPvX2WlrOM87DY
	xOcK3QUi4aTUN7f7ACYM2xCDJ8/U6tZUOVIt4pegTdvOiqGX39fSGPGLAlpvzDbaOfRfcb
	MGz7knTNVtMXcs9mHirFdfyHW2RHBPU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-S3V08NhbM2SD0m6FbnmzVg-1; Mon, 05 Aug 2024 20:23:25 -0400
X-MC-Unique: S3V08NhbM2SD0m6FbnmzVg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-650ab31aabdso1508757b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722903805; x=1723508605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJlfPXtmMFFW1men+UhmIi3WVByyjRhzXx3BjNaIlwg=;
        b=dqL+q3x2XCi0dl/5OOil4LRWGtIMhp9BUtCs3k4pwkY93gsDpo0l9xMZ4YfljvNKzd
         17xkLx6xT5iu1kdZVKHgVzS9AH8yCyg6lbjzPJ7SMgLD0/EeEFCCfzdferedOi2vQj5C
         NptMAgJP1JBEAH5FXqfqFjeEfYG0Gj3GFA5VRlHHv6dRwgoJ0RV1bGC5JBg68z+JPp8q
         ++tdiUxjUYENAA1QxsAyFluCiaJKnbIGa/mMMitI4AWe/0qNzTPJbNOd2idiTU5aD48Q
         lvH5bI3WybiY9vmwL5Z+KxqxPx/xD5opirEGzldVDKGYrRd5lGQTYnDF09eHAnF8l07i
         onjg==
X-Forwarded-Encrypted: i=1; AJvYcCWJkUJxxANSqmdPt9o14ZIY6MTEzekzdOaxcZEflWpNzZinbxxoNr3A38mNJ84ur3FXCz3oqaaJScikimZkPFs6u1i6J4lLVUa82hMH
X-Gm-Message-State: AOJu0Yw+NW71xs2U01vXFOKRSeZrwmxraxkz2bc44VOjwJcOPxmCbs8n
	eZiArMZpBije5Gohu/6x+gjAX/G3RUgyFAU5K3XiYg2d7Qvalt4qWWUtT+9AhkcX84rWKgNAmDl
	wzDUiVuHKQJ2isXXNTRkoxU367b8rcyC/hDxjBbmmLuvWCrznDAcVgBeJbA/YFfO/ZNrzC6HUcg
	G8kmNnkJ6jbdGshg86pfjE+BYwDAHb7elhGiOC
X-Received: by 2002:a81:a210:0:b0:664:f825:93ca with SMTP id 00721157ae682-689613220a2mr139396917b3.25.1722903804888;
        Mon, 05 Aug 2024 17:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEskZB4+QSMqoT5ZJMPRzBqYjfNgH9WZS17PDY7kjDN6AsXY92Yw3o8eQShKFanVEFiTlzK0gohHRG1mkqCWos=
X-Received: by 2002:a81:a210:0:b0:664:f825:93ca with SMTP id
 00721157ae682-689613220a2mr139396567b3.25.1722903803787; Mon, 05 Aug 2024
 17:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731070207.3918687-1-davidgow@google.com>
In-Reply-To: <20240731070207.3918687-1-davidgow@google.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 5 Aug 2024 18:22:57 -0600
Message-ID: <CAA1CXcDKht4vOL-acxrARbm6JhGna8_k8wjYJ-vHONink8aZ=w@mail.gmail.com>
Subject: Re: [PATCH] kunit: Device wrappers should also manage driver name
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
	Kees Cook <kees@kernel.org>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:02=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> kunit_driver_create() accepts a name for the driver, but does not copy
> it, so if that name is either on the stack, or otherwise freed, we end
> up with a use-after-free when the driver is cleaned up.
>
> Instead, strdup() the name, and manage it as another KUnit allocation.
> As there was no existing kunit_kstrdup(), we add one. Further, add a
> kunit_ variant of strdup_const() and kfree_const(), so we don't need to
> allocate and manage the string in the majority of cases where it's a
> constant.
>
> This fixes a KASAN splat with overflow.overflow_allocation_test, when
> built as a module.
>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> Reported-by: Nico Pache <npache@redhat.com>

Hi David,

This is failing in the Fedora-ark build process [1] which builds the
KUNIT tests as modules.

+ /usr/bin/make <SNIP> modules
...
ERROR: modpost: "__start_rodata" [lib/kunit/kunit.ko] undefined!
ERROR: modpost: "__end_rodata" [lib/kunit/kunit.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/builddir/build/BUILD/kernel-6.11.0-build/kernel-6.11-rc2/lin=
ux-6.11.0-0.rc2.22.ov.fc41.x86_64/Makefile:1895:
modpost] Error 2
make: *** [Makefile:236: __sub-make] Error 2
+ exit 1

This seems related to

+#include <asm/sections.h>

which defines __<start|end>_rodata.

When I tried exporting these symbols I got:

ERROR: modpost: vmlinux: '__start_rodata' exported twice. Previous
export was in vmlinux

So I'm not sure what the problem is here.

[1] - https://kojipkgs.fedoraproject.org//work/tasks/9116/121539116/build.l=
og

Cheers
-- Nico

> Closes: https://groups.google.com/g/kunit-dev/c/81V9b9QYON0
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---

>
> There's some more serious changes since the RFC I sent, so please take a
> closer look.
>
> Thanks,
> -- David
>
> Changes since RFC:
> https://groups.google.com/g/kunit-dev/c/81V9b9QYON0/m/PFKNKDKAAAAJ
> - Add and use the kunit_kstrdup_const() and kunit_free_const()
>   functions.
> - Fix a typo in the doc comments.
>
>
> ---
>  include/kunit/test.h | 58 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/device.c   |  7 ++++--
>  2 files changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index e2a1f0928e8b..da9e84de14c0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -28,6 +28,7 @@
>  #include <linux/types.h>
>
>  #include <asm/rwonce.h>
> +#include <asm/sections.h>
>
>  /* Static key: true if any KUnit tests are currently running */
>  DECLARE_STATIC_KEY_FALSE(kunit_running);
> @@ -480,6 +481,63 @@ static inline void *kunit_kcalloc(struct kunit *test=
, size_t n, size_t size, gfp
>         return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
>  }
>
> +
> +/**
> + * kunit_kfree_const() - conditionally free test managed memory
> + * @x: pointer to the memory
> + *
> + * Calls kunit_kfree() only if @x is not in .rodata section.
> + * See kunit_kstrdup_const() for more information.
> + */
> +static inline void kunit_kfree_const(struct kunit *test, const void *x)
> +{
> +       if (!is_kernel_rodata((unsigned long)x))
> +               kunit_kfree(test, x);
> +}
> +
> +/**
> + * kunit_kstrdup() - Duplicates a string into a test managed allocation.
> + *
> + * @test: The test context object.
> + * @str: The NULL-terminated string to duplicate.
> + * @gfp: flags passed to underlying kmalloc().
> + *
> + * See kstrdup() and kunit_kmalloc_array() for more information.
> + */
> +static inline char *kunit_kstrdup(struct kunit *test, const char *str, g=
fp_t gfp)
> +{
> +       size_t len;
> +       char *buf;
> +
> +       if (!str)
> +               return NULL;
> +
> +       len =3D strlen(str) + 1;
> +       buf =3D kunit_kmalloc(test, len, gfp);
> +       if (buf)
> +               memcpy(buf, str, len);
> +       return buf;
> +}
> +
> +/**
> + * kunit_kstrdup_const() - Conditionally duplicates a string into a test=
 managed allocation.
> + *
> + * @test: The test context object.
> + * @str: The NULL-terminated string to duplicate.
> + * @gfp: flags passed to underlying kmalloc().
> + *
> + * Calls kunit_kstrdup() only if @str is not in the rodata section. Must=
 be freed with
> + * kunit_free_const() -- not kunit_free().
> + * See kstrdup_const() and kunit_kmalloc_array() for more information.
> + */
> +static inline const char *kunit_kstrdup_const(struct kunit *test, const =
char *str, gfp_t gfp)
> +{
> +       if (is_kernel_rodata((unsigned long)str))
> +               return str;
> +
> +       return kunit_kstrdup(test, str, gfp);
> +}
> +
>  /**
>   * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
>   * @test: The test context object.
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 25c81ed465fb..520c1fccee8a 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -89,7 +89,7 @@ struct device_driver *kunit_driver_create(struct kunit =
*test, const char *name)
>         if (!driver)
>                 return ERR_PTR(err);
>
> -       driver->name =3D name;
> +       driver->name =3D kunit_kstrdup_const(test, name, GFP_KERNEL);
>         driver->bus =3D &kunit_bus_type;
>         driver->owner =3D THIS_MODULE;
>
> @@ -192,8 +192,11 @@ void kunit_device_unregister(struct kunit *test, str=
uct device *dev)
>         const struct device_driver *driver =3D to_kunit_device(dev)->driv=
er;
>
>         kunit_release_action(test, device_unregister_wrapper, dev);
> -       if (driver)
> +       if (driver) {
> +               const char *driver_name =3D driver->name;
>                 kunit_release_action(test, driver_unregister_wrapper, (vo=
id *)driver);
> +               kunit_kfree_const(test, driver_name);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(kunit_device_unregister);
>
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>


