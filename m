Return-Path: <linux-kernel+bounces-396623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A69BCFAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8041F232DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB71D967F;
	Tue,  5 Nov 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvtRomnD"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6911D935E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818038; cv=none; b=uyV1aI1DuXhwAA13UQBbkB4icQFdpFhq/vuMLmDeTBv5aBDJXWwMH1jdETGCBfuEkaHvShzxA8DivvaGJEQBpRR2IFgmFxt+xIGlXy0Zpl/aC2kQKVy8H1Adv0rDB+Ws2lI6IsSMrls8MWBCJZkjQ9tequFpr60xKJlO/5ZRvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818038; c=relaxed/simple;
	bh=NUJeZp3Nw4C4ChRvfAMRe64rF+yZ4odrJKEqn8ZTWSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh4iIHIMORPBf2xNW12zNqzql2hobVzTg/0cd7OXeoOO82YiSHbfPNttC6UPZ2XaQk9kKTGDUPgWmQA4vlGF/4wH+4Y07WkeDCbRhkmwu/K6DcgEFQZeWceNKHkmawiOBxPXg3P+qu7Lvmaozb+/oyz7SNgWVZS3CP9jPMKsv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvtRomnD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e681ba70so22527e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730818035; x=1731422835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cagGAnxZqWV5y2Ato7lEE3OEZ0Tp2aD2OKM7V42p+E=;
        b=OvtRomnDheX7eUtU+qmm3Sfu6P7CUs5nMGW8ymONtzYmKZl71PArglOxzEhUv0G0XX
         MebGXCBVYTQQBWjsGUV6lupFS9syWAmuvtT+t5CXNpDKBVdQGSVcLEawtClTKlfA/bSN
         mJ5xA3omzW/T6+yVFNROPt876gT0bTLiFP/leIYSIV9mgE6GvpRof8zStX1blwMkpVl9
         /Gn2v30XfkfgJcrAKKWkKlHagr5FOwSSWpznDDe/792utbhGeVXGSjFqCy+NT8AD0QVe
         PJ7FoYbDG8lkcTFRVlWqTfiCF1zsJvbIDWerILMR5Pe/jNjpL1T1t7vNVrAkvkhqRmMq
         uaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818035; x=1731422835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cagGAnxZqWV5y2Ato7lEE3OEZ0Tp2aD2OKM7V42p+E=;
        b=NsDiKoBBpEmLxUASR63JwRVS9bUzRfxAMtYtfIIZKuNPnK1Z19charOKnvjTVCGSk0
         r7jUPoIrND4LWgITogEEDaG/OwTsEQLqZmtIMJUFnDnYGgdFvRQ9Q7XBy4usxm0+91Zd
         B+LFMHjeht1tMYGrui2Lb+0uJOWUAv6R1UJ32ercP1Oli8t/6fpY7CK+iJPuTIUlx9sh
         JYvDWnvw7nJIdu7QBA+3Za0jqYPQIkOUNvisR+X2XrTcpBHZDT6S3VgV3GN+zoDGeyn6
         ZyaA1aRzpWX8gioNCsscClWQJL47WR1lDn/uxDs+4uoRbgQvqixhl1bI34U8LG8eWFEF
         ffjA==
X-Forwarded-Encrypted: i=1; AJvYcCVJLhj8nT88kgZzUEmTu4wRngSRtKXO6w0FnV6JDEflVTpuuyDEYH+7REgrEEhkPDEI4PVWLXgSBHBeE4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXI+wpZqKNepZgZiYwTnRaPz1InCouXdLgZSQcp67S/0ogtOz
	bUYmRY77wyY4d3utN3lddJ57u6+qLORGrSNrlDbWtmvEjPcqJ+XPH1nwA3QgkEcfWcCOTGSbHLC
	rUOieEGlWb9gTz94mGjLzDxfe/xU/ZNCctQ+Q
X-Gm-Gg: ASbGnctjiEPSFEIU7S5iNjKB5/B7OvAuBlb7hHuH5+khJGj/gx0DcPae+NgIYFJnWKP
	3a0j4Z6ietbSG1v+a91ZKWZfJk1/eeellpSs5VlYGzR/Cxk1quqdNf3BrRVY=
X-Google-Smtp-Source: AGHT+IGCupuoPoa9Be9DIeC1oLOgRsCVHzJMID/6QbIJuejsA52V25UUPkdSQbFWB5lj7opODxhrEwcgb4shAr5+SOU=
X-Received: by 2002:a05:6512:2243:b0:530:ae18:810e with SMTP id
 2adb3069b0e04-53d78c99ab2mr385358e87.5.1730818034320; Tue, 05 Nov 2024
 06:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-panthor-flush-page-fixes-v1-1-829aaf37db93@google.com> <Zynr3DIY8u2c7wrB@e110455-lin.cambridge.arm.com>
In-Reply-To: <Zynr3DIY8u2c7wrB@e110455-lin.cambridge.arm.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 5 Nov 2024 15:46:37 +0100
Message-ID: <CAG48ez1YjoQMe-daQ8NSqN46STGw1UWygzU2-qo75FLBDBqaow@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: Be stricter about IO mapping flags
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 10:56=E2=80=AFAM Liviu Dudau <liviu.dudau@arm.com> w=
rote:
> On Tue, Nov 05, 2024 at 12:17:13AM +0100, Jann Horn wrote:
> > The current panthor_device_mmap_io() implementation has two issues:
> >
> > 1. For mapping DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET,
> >    panthor_device_mmap_io() bails if VM_WRITE is set, but does not clea=
r
> >    VM_MAYWRITE. That means userspace can use mprotect() to make the map=
ping
> >    writable later on. This is a classic Linux driver gotcha.
> >    I don't think this actually has any impact in practice:
> >    When the GPU is powered, writes to the FLUSH_ID seem to be ignored; =
and
> >    when the GPU is not powered, the dummy_latest_flush page provided by=
 the
> >    driver is deliberately designed to not do any flushes, so the only t=
hing
> >    writing to the dummy_latest_flush could achieve would be to make *mo=
re*
> >    flushes happen.
> >
> > 2. panthor_device_mmap_io() does not block MAP_PRIVATE mappings (which =
are
> >    mappings without the VM_SHARED flag).
> >    MAP_PRIVATE in combination with VM_MAYWRITE indicates that the VMA h=
as
> >    copy-on-write semantics, which for VM_PFNMAP are semi-supported but
> >    fairly cursed.
> >    In particular, in such a mapping, the driver can only install PTEs
> >    during mmap() by calling remap_pfn_range() (because remap_pfn_range(=
)
> >    wants to **store the physical address of the mapped physical memory =
into
> >    the vm_pgoff of the VMA**); installing PTEs later on with a fault
> >    handler (as panthor does) is not supported in private mappings, and =
so
> >    if you try to fault in such a mapping, vmf_insert_pfn_prot() splats =
when
> >    it hits a BUG() check.
> >
> > Fix it by clearing the VM_MAYWRITE flag (userspace writing to the FLUSH=
_ID
> > doesn't make sense) and requiring VM_SHARED (copy-on-write semantics fo=
r
> > the FLUSH_ID don't make sense).
> >
> > Reproducers for both scenarios are in the notes of my patch on the mail=
ing
> > list; I tested that these bugs exist on a Rock 5B machine.
> >
> > Note that I only compile-tested the patch, I haven't tested it; I don't
> > have a working kernel build setup for the test machine yet. Please test=
 it
> > before applying it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > First testcase (can write to the FLUSH_ID):
> >
> > ```
> >
>
> There is a missing line here, I guess is something like
>
> #define SYSCHK(x) ({  \

Oops. Yes, sorry, the tool that I stored this comment message in
interpreted all lines starting with "#" as comments... the proper
versions:

First testcase (can write to the FLUSH_ID):

```
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdint.h>
#include <sys/mman.h>

#define SYSCHK(x) ({          \
  typeof(x) __res =3D (x);      \
  if (__res =3D=3D (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

#define GPU_PATH "/dev/dri/by-path/platform-fb000000.gpu-card"
#define DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET (1ull << 56)

int main(void) {
  int fd =3D SYSCHK(open(GPU_PATH, O_RDWR));

  // sanity-check that PROT_WRITE+MAP_SHARED fails
  void *mmap_write_res =3D mmap(NULL, 0x1000, PROT_READ|PROT_WRITE,
      MAP_SHARED, fd, DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET);
  if (mmap_write_res =3D=3D MAP_FAILED) {
    perror("mmap() with PROT_WRITE+MAP_SHARED failed as expected");
  } else {
    errx(1, "mmap() with PROT_WRITE+MAP_SHARED worked???");
  }

  // make a PROT_READ+MAP_SHARED mapping, and upgrade it to writable
  void *mmio_page =3D SYSCHK(mmap(NULL, 0x1000, PROT_READ, MAP_SHARED,
      fd, DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET));
  SYSCHK(mprotect(mmio_page, 0x1000, PROT_READ|PROT_WRITE));

  volatile uint32_t *flush_counter =3D (volatile uint32_t*)mmio_page;

  uint32_t last_old =3D -1;
  while (1) {
    uint32_t old_val =3D *flush_counter;
    *flush_counter =3D 1111;
    uint32_t new_val =3D *flush_counter;
    if (old_val !=3D last_old)
      printf("flush counter: old=3D%u, new=3D%u\n", old_val, new_val);
    last_old =3D old_val;
  }
}
```

Second testcase (triggers BUG() splat):
```
#include <err.h>
#include <fcntl.h>
#include <stddef.h>
#include <sys/mman.h>

#define SYSCHK(x) ({          \
  typeof(x) __res =3D (x);      \
  if (__res =3D=3D (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

#define GPU_PATH "/dev/dri/by-path/platform-fb000000.gpu-card"
#define DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET (1ull << 56)

int main(void) {
  int fd =3D SYSCHK(open(GPU_PATH, O_RDWR));

  // make a PROT_READ+**MAP_PRIVATE** mapping
  void *ptr =3D SYSCHK(mmap(NULL, 0x1000, PROT_READ, MAP_PRIVATE,
      fd, DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET));

  // trigger a read fault
  *(volatile char *)ptr;
}
```

