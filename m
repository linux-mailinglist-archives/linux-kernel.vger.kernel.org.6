Return-Path: <linux-kernel+bounces-211239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B16D904EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DA6281FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C30B16D9A2;
	Wed, 12 Jun 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpmkz7AB"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234116D330
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183632; cv=none; b=lHB21mZKbwj00mjS8JOskf53HxXxgYBIk9IDDYsCMlOO4DIR4QaJ6xZehKliODSHyZNrRS2fL16pCcJl0uzWdBdv6Cfvx3652PYypxAixzOvNCAnJKhbPBlPo0UYlafBmQv9sKbIQaM8/gOZ9x+Kk3LYet1FcNfCBBcqyf+Z6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183632; c=relaxed/simple;
	bh=rBq/Zx0kE0ZqDInwzxUlvFLkFI1TAneglYjGvt4UfVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNaEUd0vdwj8SqiK8bi/Cy82dsirm+6c0rZP1Fb440GdtOSC4+YRXRkIdJGH+VSot2A7ugcqtdu9Ad66nDBccVzvSNvH7hIXVXKlG0Sr3d9YGes7dxFoQPaLcZVP58C8jmfcNaKvR8bFKn8WOIZb3UGjsLIp8+gvsKct4S/NC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpmkz7AB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4405cf01a7fso225651cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718183629; x=1718788429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/PmlvILeAo6YRa/ohUJ8QvTiVWIK8syY94oDBxO5V3o=;
        b=wpmkz7ABWg6PZwAAlvDVLcTI39V+XFRN4tyceQoQBbpOO6MF7qT2Ht7NbUAQ2KVB+9
         qKYSJI1BIu4JoAkmxi62ayTE6vHkHTfsD3ZwUaX3QBAy3woN+hh0mCZaCep0Q2DugByz
         VYn3ZTJ+1iVZOPZjZ5+eA569z5DrVTfOMR7bfm3qpTy7xLOBcNifgfcui9/Yq6lGikAI
         CdjQ2/thWcMpIfTugL0PHvVAW4tAf9LEADLln/yh9pVW6Eppap2bQ0+ki+PFHXu+eBLg
         L0eI6K+iVWgdfqAjk6+4vU21/BZrvNMwFRtRFQ7E4Yj5tnQd+S3Ej9soYF2SFtry4v6r
         d+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718183629; x=1718788429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PmlvILeAo6YRa/ohUJ8QvTiVWIK8syY94oDBxO5V3o=;
        b=lrQojYf8D/8VRAczHILOxNktRVj0cAgaZERDFZAWqipDALJ987N1HOx01X9BatDVq1
         kEmD9bU9L2dfzJOqeNrzhZXbckqvWSS18dxV2J0SAokPLTzmNZAQocF2b0wQ4NodWS5s
         6fGa5oPwixLzB1zpYyj3Gfx/vd5MVJ/oH1mm/xBtsysDyJmiPHEQezMQXMaZthWEWMuL
         2ur+PrDP9koT/CZnFx+HQ7mECXz2YxXMelOsfwvQ87aU7nq+TWTMIy12lImBBAZp/nOE
         XZF5eCF7vsvJi4r3cC5KikIaQyVnMaxCcEr6I9zOzBi6/A9UGXIWQJKWoFGpt4pkUFbR
         lyaA==
X-Forwarded-Encrypted: i=1; AJvYcCXV5/O6MgHG2rgy55t2csNlMpcglgpZNOyy5S1OZTuUKt/dn2U+I7oYoO+MoevHYAcNGnpS8kWsLiuDx4hEpqdlRhV4lEYwypstv8KN
X-Gm-Message-State: AOJu0YwyXCZgzYe7FpM0Ql1MoLl4kgDAB/ZE5LI8T8Qnj9inyW2G7giB
	NYooJ3KMNDgDfAxUQ0O+H68pPzkkL9/j3HPfGlk6H4YQgXFhpOqqtCjExaP6cZsGm3Z2GmiLpyX
	gZ3TJ+ln/DutISXiHZc4Oc7OyWQiVD8+ZQNc6
X-Google-Smtp-Source: AGHT+IFL56h6cC+EX90XV/p//2kqIxzBw2KcGFQ9v9I0jHiCIV4yz+/0rlLEL2yE/29YBjWwru6dj1DYmN8umguUc5Q=
X-Received: by 2002:a05:622a:420e:b0:440:1fbb:9b0c with SMTP id
 d75a77b69052e-4415a238e01mr2353641cf.29.1718183629379; Wed, 12 Jun 2024
 02:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610213055.it.075-kees@kernel.org> <20240610213330.1310156-1-kees@kernel.org>
In-Reply-To: <20240610213330.1310156-1-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Wed, 12 Jun 2024 17:13:35 +0800
Message-ID: <CABVgOS=8zL+jj4w32Ckh3cKq1DvidMLPGs+vj2adhbmCEcQ_6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: test: Add vm_mmap() allocation resource manager
To: Kees Cook <kees@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Vitor Massaru Iha <vitor@massaru.org>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ecaf10061aadccd1"

--000000000000ecaf10061aadccd1
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 05:33, Kees Cook <kees@kernel.org> wrote:
>
> For tests that need to allocate using vm_mmap() (e.g. usercopy and
> execve), provide the interface to have the allocation tracked by KUnit
> itself. This requires bringing up a placeholder userspace mm.
>
> This combines my earlier attempt at this with Mark Rutland's version[1].
>
> Link: https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/ [1]
> Co-developed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Thanks: this looks good to me, at least on the KUnit side of things.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/kunit/test.h   |  17 +++++++
>  lib/kunit/Makefile     |   1 +
>  lib/kunit/user_alloc.c | 111 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 lib/kunit/user_alloc.c
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index e32b4cb7afa2..ec61cad6b71d 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -480,6 +480,23 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
>         return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
>  }
>
> +/**
> + * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
> + * @test: The test context object.
> + * @file: struct file pointer to map from, if any
> + * @addr: desired address, if any
> + * @len: how many bytes to allocate
> + * @prot: mmap PROT_* bits
> + * @flag: mmap flags
> + * @offset: offset into @file to start mapping from.
> + *
> + * See vm_mmap() for more information.
> + */
> +unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
> +                           unsigned long addr, unsigned long len,
> +                           unsigned long prot, unsigned long flag,
> +                           unsigned long offset);
> +
>  void kunit_cleanup(struct kunit *test);
>
>  void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt, ...);
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 309659a32a78..56dd67dc6e57 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -2,6 +2,7 @@ obj-$(CONFIG_KUNIT) +=                  kunit.o
>
>  kunit-objs +=                          test.o \
>                                         resource.o \
> +                                       user_alloc.o \
>                                         static_stub.o \
>                                         string-stream.o \
>                                         assert.o \
> diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> new file mode 100644
> index 000000000000..d66f42282f43
> --- /dev/null
> +++ b/lib/kunit/user_alloc.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit userspace memory allocation resource management.
> + */
> +#include <kunit/resource.h>
> +#include <kunit/test.h>
> +#include <linux/kthread.h>
> +#include <linux/mm.h>
> +
> +struct kunit_vm_mmap_resource {
> +       unsigned long addr;
> +       size_t size;
> +};
> +
> +/* vm_mmap() arguments */
> +struct kunit_vm_mmap_params {
> +       struct file *file;
> +       unsigned long addr;
> +       unsigned long len;
> +       unsigned long prot;
> +       unsigned long flag;
> +       unsigned long offset;
> +};
> +
> +/* Create and attach a new mm if it doesn't already exist. */
> +static int kunit_attach_mm(void)
> +{
> +       struct mm_struct *mm;
> +
> +       if (current->mm)
> +               return 0;
> +
> +       mm = mm_alloc();
> +       if (!mm)
> +               return -ENOMEM;
> +
> +       /* Define the task size. */
> +       mm->task_size = TASK_SIZE;
> +
> +       /* Make sure we can allocate new VMAs. */
> +       arch_pick_mmap_layout(mm, &current->signal->rlim[RLIMIT_STACK]);
> +
> +       /* Attach the mm. It will be cleaned up when the process dies. */
> +       kthread_use_mm(mm);
> +
> +       return 0;
> +}
> +
> +static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
> +{
> +       struct kunit_vm_mmap_params *p = context;
> +       struct kunit_vm_mmap_resource vres;
> +       int ret;
> +
> +       ret = kunit_attach_mm();
> +       if (ret)
> +               return ret;
> +
> +       vres.size = p->len;
> +       vres.addr = vm_mmap(p->file, p->addr, p->len, p->prot, p->flag, p->offset);
> +       if (!vres.addr)
> +               return -ENOMEM;
> +       res->data = kmemdup(&vres, sizeof(vres), GFP_KERNEL);
> +       if (!res->data) {
> +               vm_munmap(vres.addr, vres.size);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void kunit_vm_mmap_free(struct kunit_resource *res)
> +{
> +       struct kunit_vm_mmap_resource *vres = res->data;
> +
> +       /*
> +        * Since this is executed from the test monitoring process,
> +        * the test's mm has already been torn down. We don't need
> +        * to run vm_munmap(vres->addr, vres->size), only clean up
> +        * the vres.
> +        */
> +
> +       kfree(vres);
> +       res->data = NULL;
> +}
> +
> +unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
> +                           unsigned long addr, unsigned long len,
> +                           unsigned long prot, unsigned long flag,
> +                           unsigned long offset)
> +{
> +       struct kunit_vm_mmap_params params = {
> +               .file = file,
> +               .addr = addr,
> +               .len = len,
> +               .prot = prot,
> +               .flag = flag,
> +               .offset = offset,
> +       };
> +       struct kunit_vm_mmap_resource *vres;
> +
> +       vres = kunit_alloc_resource(test,
> +                                   kunit_vm_mmap_init,
> +                                   kunit_vm_mmap_free,
> +                                   GFP_KERNEL,
> +                                   &params);
> +       if (vres)
> +               return vres->addr;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(kunit_vm_mmap);
> --
> 2.34.1
>

--000000000000ecaf10061aadccd1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIB0E4g5BBc0JWZt8dHEfRHrSMXYTT0P7eePeFVyHWWcaMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYxMjA5MTM0OVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCAKZHB
B97dwl0vUB6hSwAwj+g7bzQ+Ja3tYFvHs2KfZ4JtdEh4NZq5iW1YmntrCWqMrruLHexLbARXyYsP
ZzjYa0zm9z68A4+HVq1Kbv9hO4hbMSgNhHChleK0J3pt/rrx/R1vSGLlXkrrcX/CuEbp98anSxgd
25tvN+lG+H5G9QUBMKyYMTD/YNVpZPyzkSsSdMS+wnchpj9XGv24mg5Y/fTD1dixxti87JJudEiN
j6Mh0COdpFT1hqPU4+GHhae0YFe72d0TM2Yl4kwMbzklDutqaYo4PPwm/TRg8VY3lXEoeNrvotnF
Ic3mZv3N2eB37Cv1RYamvq8uH17ul9GA
--000000000000ecaf10061aadccd1--

