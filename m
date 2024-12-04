Return-Path: <linux-kernel+bounces-432073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B79D9E44A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DA116514C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4FE1A8F87;
	Wed,  4 Dec 2024 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIXxo1fL"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C013D246
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340803; cv=none; b=HxcowOkj885rK5G8jnyuQ2bwMsUGEaIkW0fw6XS7Bv8gQPtDu9+9n+e5EP3bnoD8gCpG5XghL0zBFbjdYZmWsa9LIk6NOdw9W3xJB16zASFmtf6AEXLQsEYfkhl2hcwujaLBYmfsLzjavAN7e+3YEPAtlBCS+qwRSrM2HvERisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340803; c=relaxed/simple;
	bh=Q+RldcqHNJdcdZUW2CRuzh+FFyEjNRahbm0IZwySbbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1cs5P5lxGD7zfSjMLhWKZ+cFtvex4XIz8oGBJKpQD5q7MybuvYb44gO7ihoqK/0hkcmB7W+S9IzaIxaJW9Nf01MDFIf6CWRQSXXoroqxRdTMyI1gYzOglNDV2gXflewMhHy+WlAwZ9MO+u4hkCa2acEWEmzQjygwa8y8xOUkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIXxo1fL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4668caacfb2so46611cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733340800; x=1733945600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H83UGO30c2JkKZkvdZrQ2zWSG0I/+rE1r5GKWENaucw=;
        b=BIXxo1fLmhwPVB16Xrfr1q/KSqB+ILeYQTGOQwL40qjAf0Ewkgdabu41R1BeIMgrql
         dK/Ue/nH8QLmHttBzri6fvTPysb9CzxottwxAAgKk7zMeWFs/TxWBJ5FBLcVI8NmsZxz
         7l9aonT63e925URAFoVSZgKMXKLSHF9hEmlOmWoUcsDGLFbemq2OJcqEEW6foTtHOps5
         ml/X3i9BfKPEQ/ZPuPkhiRirjmZlDoBgsLHtSPhHW0d8J6WLa2zgTvI2lrsQIouaAfUK
         4yDviruKl9Ehv7dsJxleABicTgocbfzOqpsYk4W/yMWSsVHclF3oUHP4kupiSuzU2qql
         0ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733340800; x=1733945600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H83UGO30c2JkKZkvdZrQ2zWSG0I/+rE1r5GKWENaucw=;
        b=kxs6+Ib5jNl70BfKABihskOMplBLo8Kt2siH1j6p6UTyOSAlZUpxj9tQwuNrk3zD8T
         PRxbtK2eEIELpi4IMjO7oC0N1P0D+bW1lowjw5EV2p3wchmngN/1C5jYQ2Y8czxkxu1/
         MwseA0ikuFub1StLc9DRZKtNox3/DGH3gpfbjdVZy2/Z8COhckc+H2jMX+CArF/FYtpk
         b6LZ4hwtuEDst2DJ+/S0HKXq6P370EEGBQ8DnMmoAfqrhZJNeYvoTfiTpUXT/4ON1o/9
         OPqjuJl+rtEw8VaXHAtdjplfX9Myj+OETVDxf54SGOT7YX4SiX5zdD/NCHpxPPOTvkwB
         2Dyw==
X-Forwarded-Encrypted: i=1; AJvYcCVR2YEuRkweQFhcHKOD6BotyOPPv5EkmV1EiIdUFvLoqgJn5U2RQ+qGjBX8Z5+5350nTc5sOetlPXsfaK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yUguyZ5VowHCg9+RC1C4OSiHASy1JhJ8093aFYreW0ow+hDr
	EIk255XvgvL9q8OPWTI+XGCPZHHgfzisskVQQZ/7bq1AKM/8IylEmM+38ay22axcXzd+zsQmuvv
	ebVxAMEJpcOpKvVVYyDkglhqeFjgkPP7QcgWi
X-Gm-Gg: ASbGnct0Pjfg5IwXEjmEVUIs778OTI4gImuFtGl8d8GpC9ISbas/h8QmKppK5N0/jtC
	s/xjnCab9vqQ6Hc9b6VjmOCch1fC5tG2v
X-Google-Smtp-Source: AGHT+IEg6anCBXDE8NiPzMvLbz+zyyykYnuhRhAc0Jfx+v+cAVG+l6Np+LIu5m0w52+VV1EerCMm3uokQ4eb4i+Jn0k=
X-Received: by 2002:a05:622a:6182:b0:461:70cc:3799 with SMTP id
 d75a77b69052e-4672886410cmr240141cf.21.1733340800307; Wed, 04 Dec 2024
 11:33:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204075248.384215-1-hao.ge@linux.dev> <20241204083448.387862-1-hao.ge@linux.dev>
 <CAJuCfpF5Yo3Bz1OUy=rfd5-0DRZsWSRaekR3Y-f5TRatdXWkVQ@mail.gmail.com> <e5d6cb44-9a86-ee94-9210-d56acee483c4@linux.dev>
In-Reply-To: <e5d6cb44-9a86-ee94-9210-d56acee483c4@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Dec 2024 11:33:09 -0800
Message-ID: <CAJuCfpFHEpFw61ZtqHzgYrpiHn1k86h2LwzZf+C4=sfpULY4TQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/alloc_tag: fix vm_module_tags_populate's KASAN
 poisoning logic
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 7:08=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> Thank you for your review.
>
>
> On 12/4/24 22:39, Suren Baghdasaryan wrote:
> > On Wed, Dec 4, 2024 at 12:35=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote=
:
> >> From: Hao Ge <gehao@kylinos.cn>
> >>
> >> After merge commit 233e89322cbe ("alloc_tag:
> >> fix module allocation tags populated area calculation"),
> >> We still encountered a KASAN bug.
> >>
> >> This is because we have only actually performed
> >> page allocation and address mapping here.
> >> we need to unpoisoned portions of underlying memory.
> >>
> >> Because we have a change in the size here,we need to
> >> re-annotate poisoned and unpoisoned portions of underlying memory
> >> according to the new size.
> >>
> >> Here is the log for KASAN:
> >>
> >> [    5.041171][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> [    5.042047][    T1] BUG: KASAN: vmalloc-out-of-bounds in move_modul=
e+0x2c0/0x708
> >> [    5.042723][    T1] Write of size 240 at addr ffff80007e510000 by t=
ask systemd/1
> >> [    5.043412][    T1]
> >> [    5.043523][   T72] input: QEMU QEMU USB Tablet as /devices/pci0000=
:00/0000:00:01.1/0000:02:001
> >> [    5.043614][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted =
6.13.0-rc1+ #28
> >> [    5.045560][    T1] Hardware name: QEMU KVM Virtual Machine, BIOS 0=
.0.0 02/06/2015
> >> [    5.046328][    T1] Call trace:
> >> [    5.046670][    T1]  show_stack+0x20/0x38 (C)
> >> [    5.047127][    T1]  dump_stack_lvl+0x80/0xf8
> >> [    5.047533][    T1]  print_address_description.constprop.0+0x58/0x3=
58
> >> [    5.048092][   T72] hid-generic 0003:0627:0001.0001: input,hidraw0:=
 USB HID v0.01 Mouse [QEMU 0
> >> [    5.048126][    T1]  print_report+0xb0/0x280
> >> [    5.049682][    T1]  kasan_report+0xb8/0x108
> >> [    5.050170][    T1]  kasan_check_range+0xe8/0x190
> >> [    5.050685][    T1]  memcpy+0x58/0xa0
> >> [    5.051135][    T1]  move_module+0x2c0/0x708
> >> [    5.051586][    T1]  layout_and_allocate.constprop.0+0x308/0x5b8
> >> [    5.052219][    T1]  load_module+0x134/0x16c8
> >> [    5.052671][    T1]  init_module_from_file+0xdc/0x138
> >> [    5.053193][    T1]  idempotent_init_module+0x344/0x600
> >> [    5.053742][    T1]  __arm64_sys_finit_module+0xbc/0x150
> >> [    5.054289][    T1]  invoke_syscall+0xd4/0x258
> >> [    5.054749][    T1]  el0_svc_common.constprop.0+0xb4/0x240
> >> [    5.055319][    T1]  do_el0_svc+0x48/0x68
> >> [    5.055743][    T1]  el0_svc+0x40/0xe0
> >> [    5.056142][    T1]  el0t_64_sync_handler+0x10c/0x138
> >> [    5.056658][    T1]  el0t_64_sync+0x1ac/0x1b0
> >>
> >> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags populated =
area calculation")
> >> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > Thanks for the fix!
> >
> >> ---
> >> v2: Add comments to kasan_unpoison_vmalloc like other places.
> >>
> >> commit 233e89322cbe ("alloc_tag: fix module allocation
> >> tags populated area calculation") is currently in the
> >> mm-hotfixes-unstable branch, so this patch is
> >> developed based on the mm-hotfixes-unstable branch.
> >> ---
> >>   lib/alloc_tag.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >> index 4ee6caa6d2da..f885b3f3af0e 100644
> >> --- a/lib/alloc_tag.c
> >> +++ b/lib/alloc_tag.c
> >> @@ -421,7 +421,20 @@ static int vm_module_tags_populate(void)
> >>                                  __free_page(next_page[i]);
> >>                          return -ENOMEM;
> >>                  }
> >> +
> >> +               kasan_poison_vmalloc((void *)module_tags.start_addr,
> >> +                                    vm_module_tags->nr_pages << PAGE_=
SHIFT);
> >> +
> >>                  vm_module_tags->nr_pages +=3D nr;
> >> +
> >> +               /*
> >> +                * Mark the pages as accessible, now that they are map=
ped.
> >> +                * With hardware tag-based KASAN, marking is skipped f=
or
> >> +                * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc=
().
> >> +                */
> >> +               kasan_unpoison_vmalloc((void *)module_tags.start_addr,
> >> +                                      vm_module_tags->nr_pages << PAG=
E_SHIFT,
> >> +                                      KASAN_VMALLOC_PROT_NORMAL);
> > Instead of poisoning [module_tags.start_addr,
> > vm_module_tags->nr_pages], incrementing vm_module_tags->nr_pages and
> > the unpoisoning [module_tags.start_addr, vm_module_tags->nr_pages]
> > could we simply poisons the additional area like this:
> >
> >                  kasan_unpoison_vmalloc((void *)module_tags.start_addr =
+
> >                                         (vm_module_tags->nr_pages << PA=
GE_SHIFT),
> >                                         nr << PAGE_SHIFT,
> >                                         KASAN_VMALLOC_PROT_NORMAL);
> >                 vm_module_tags->nr_pages +=3D nr;
> > ?
>
>
> I had considered making such modifications earlier.
>
> But considering the following situation,
>
> A module tags spans across the regions of [module_tags.start_addr,
> vm_module_tags->nr_pages] and [module_tags.start_addr +
> vm_module_tags->nr_pages, ...].
>
> It may result in false positives for out-of-bounds errors.

Sorry, maybe I'm missing something but I don't see why poisoning only
newly mapped area would lead to false positives. Could you please
clarify?

Also, if you do need to unpoison and then poison, using phys_end and
new_end would be better, like this:

kasan_poison_vmalloc((void *)module_tags.start_addr,
                                      phys_end - module_tags.start_addr)

kasan_unpoison_vmalloc((void *)module_tags.start_addr,
                                          new_end - module_tags.start_addr,
                                          KASAN_VMALLOC_PROT_NORMAL);

>
>
> >>          }
> >>
> >>          return 0;
> >> --
> >> 2.25.1
> >>

