Return-Path: <linux-kernel+bounces-294628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A595906D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C80B20F51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896C71BE238;
	Tue, 20 Aug 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5oAHiB3"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8318C01C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724192501; cv=none; b=fgfMaICAze0bZI2DfvS33es7P4kiIKgYdtR3RYd1k9STqhNdAlQ2I69ZvixrpRtwMjg2AXdG/kDEexkDGD6pM5i90e8Y56qOi1R54ddb8a7HVPJ5LvNr06PxckYoNV99rM6ZrPoCADcc0d12auMmDAr+lU6HQXbDW/lAfLLEBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724192501; c=relaxed/simple;
	bh=p7WMjsO7B1VjuFRAm4/Vm/H7wsOWMxCoTuIyR8ZbIec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm944KWLZiVZQm6Sb20tTui1SjeheL+7xbYXw5rn2lZHWjdLjjXy+XE3pYQEqjXhB6o2II9eG8N6jdSjN3iN30f/ynQESADr6eZd5aeTI+HBw0CfEN6AbE/LqQKuS2sWjsbjMpQ2SUVdIf+oSUA8bKOUfZHfSZQlAebUUiVeS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5oAHiB3; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-498d587c13bso35037137.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724192499; x=1724797299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hv871P/o1MS7poPvy1dF3jHOd59twZpXpXgf3p5JXE=;
        b=i5oAHiB3GsNclrmWUzAoJaS5jInM0T3mOH72sE99lDq6XK0FscuYHf+4NxFc0OjK/c
         hKi24qOAssYBXMmzyjj932vv1QAdRNrpR3gM9TMgn7sm9sSvvujwMRXmwfi6noF1N2dW
         jZeczZtGSwPJy3xnFapDKR1AtsLuyvcChgyEsiDq6vZ26xqu/nIfZ6zegpNENdn05sw7
         GWxMfZOhWuMQTIssk1rCQsg9q3JK0+c6wz6X+7PZHGadNHyi/BlULXfSPs8fmV53rA7J
         PmDPCdizTSd6XN2GBLy7Lk3kGZp+jW20jwRzSjyI08GOgolw6IoSzYspitYV0XGsraiM
         sDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724192499; x=1724797299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hv871P/o1MS7poPvy1dF3jHOd59twZpXpXgf3p5JXE=;
        b=GawKkyMH1ty5gWaQJ/xdbIzT5HUqf7/KGlaMR8jrdX/wLGANSCTYSZqh27ol44JsXX
         J8/rvvdv0u3UcjAKEq/qC2A29dLGLOrqnxfJmJ+Gxl1LA2/DBsiPMV1Xwq6wEFC2KVPo
         rRItc5pMyAA/7Oo6WCe1YEz/kFyw9ZmHWYHjbrk0FouYRBmaKeTQpnx8u/x59Et6JQoF
         1eFfDfqZf/6eBSVDhhoqISuqHzNBSsOCBr04DK4qtIw73y6p6Rpa+xES2DQclorLB4XI
         GcZm5SgCoGN14Nn5dp02r0IOucnJ5mbUJeCbfES2J204YIfR8yB2g2NabtJiHfJM7qX+
         Ay7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlnYFd2r5bTrKskQ8a367V7e8Z3BC0+PI+1hIJbl6GWM2+1Zuocx+y28e7JqwiLMLoA5JSj0Cb1XacSRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMjAokosD9yM0Mc9XjrXdG/PCpb3m9YbJOZRycI12EDvEfwDj
	s4pFdvSEpRSbFp/EYV4SwSoWtLTEB2BSwl/CVErNyZjYlgJ4jY8od1F5B9tJ4lT3gxhSCgmznF2
	/DEMdOlo9qIpdsgApWcsPgqWheF9+xJRfaqc1
X-Google-Smtp-Source: AGHT+IFlTf+UAiD0W71XbG/Kv80aODrewkNQc9rz19st1IWj0E6Vu2TgKDRn94RSifgv1S0d68uT2mD58XiJs4gAu+k=
X-Received: by 2002:a05:6102:4190:b0:493:c81c:3148 with SMTP id
 ada2fe7eead31-498d3a160b8mr837695137.0.1724192498479; Tue, 20 Aug 2024
 15:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816045123.1934387-2-davidgow@google.com>
In-Reply-To: <20240816045123.1934387-2-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 20 Aug 2024 18:21:25 -0400
Message-ID: <CA+GJov6AcP3u59jYTJq5hiYeSgMaYRTDMUV7mbL62Ru4=xM4Xg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Device wrappers should also manage driver name
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Nico Pache <npache@redhat.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, Erhard Furtner <erhard_f@mailbox.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:51=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
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
> However, these are inline functions, and is_kernel_rodata() only works
> for built-in code. This causes problems in two cases:
> - If kunit is built as a module, __{start,end}_rodata is not defined.
> - If a kunit test using these functions is built as a module, it will
>   suffer the same fate.
>
> This fixes a KASAN splat with overflow.overflow_allocation_test, when
> built as a module.
>
> Restrict the is_kernel_rodata() case to when KUnit is built as a module,
> which fixes the first case, at the cost of losing the optimisation.
>
> Also, make kunit_{kstrdup,kfree}_const non-inline, so that other modules
> using them will not accidentally depend on is_kernel_rodata(). If KUnit
> is built-in, they'll benefit from the optimisation, if KUnit is not,
> they won't, but the string will be properly duplicated.
>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> Reported-by: Nico Pache <npache@redhat.com>
> Closes: https://groups.google.com/g/kunit-dev/c/81V9b9QYON0
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Rae Moar <rmoar@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> This is a combination of the previous version of this patch with the
> follow-up fix "kunit: Fix kunit_kstrdup_const() with modules".
>
> kunit_kstrdup_const() now falls back to kstrdup() if KUnit is built as a
> module, and is no longer inlined. This should fix the issues we'd seen
> before.
>
> I've not tried doing something fancy by looking at module rodata
> sections: it might be a possible optimisation, but it seems like it'd
> overcomplicate things for this initial change. If we hit a KUnit test
> where this is a bottleneck (or if I have some more spare time), we can
> look into it.
>
> The overflow_kunit test has been fixed independently to not rely on this
> anyway, so there shouldn't be any current cases of this causing issues,
> but it's worth making the API robust regardless.
>
> Changes since previous version:
> https://lore.kernel.org/linux-kselftest/20240731070207.3918687-1-davidgow=
@google.com/
> - Fix module support by integrating:
>   https://lore.kernel.org/linux-kselftest/20240806020136.3481593-1-davidg=
ow@google.com/
>

Hello!

I tested this new patch with modules, particularly the device tests
and the overflow_kunit test. And it seems to be working well.

Tested-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  include/kunit/test.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/device.c   |  7 +++++--
>  lib/kunit/test.c     | 19 ++++++++++++++++++
>  3 files changed, 72 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index e2a1f0928e8b..5ac237c949a0 100644
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
> @@ -480,6 +481,53 @@ static inline void *kunit_kcalloc(struct kunit *test=
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
> +void kunit_kfree_const(struct kunit *test, const void *x);
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
> + * kunit_kfree_const() -- not kunit_kfree().
> + * See kstrdup_const() and kunit_kmalloc_array() for more information.
> + */
> +const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp=
_t gfp);
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
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e8b1b52a19ab..089c832e3cdb 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -874,6 +874,25 @@ void kunit_kfree(struct kunit *test, const void *ptr=
)
>  }
>  EXPORT_SYMBOL_GPL(kunit_kfree);
>
> +void kunit_kfree_const(struct kunit *test, const void *x)
> +{
> +#if !IS_MODULE(CONFIG_KUNIT)
> +       if (!is_kernel_rodata((unsigned long)x))
> +#endif
> +               kunit_kfree(test, x);
> +}
> +EXPORT_SYMBOL_GPL(kunit_kfree_const);
> +
> +const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp=
_t gfp)
> +{
> +#if !IS_MODULE(CONFIG_KUNIT)
> +       if (is_kernel_rodata((unsigned long)str))
> +               return str;
> +#endif
> +       return kunit_kstrdup(test, str, gfp);
> +}
> +EXPORT_SYMBOL_GPL(kunit_kstrdup_const);
> +
>  void kunit_cleanup(struct kunit *test)
>  {
>         struct kunit_resource *res;
> --
> 2.46.0.184.g6999bdac58-goog
>

