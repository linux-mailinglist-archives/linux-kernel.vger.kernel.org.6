Return-Path: <linux-kernel+bounces-435492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77AA9E7888
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FEA2898D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01C71C3BEF;
	Fri,  6 Dec 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovcWj4Wu"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EB153836
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511821; cv=none; b=Yxq0mWOo/Z8R6qEH19aSp3UnJpTNyHQegbHa8X/XHeJF2tYMdsrB8WYlbsevw+npOZJOCaIsb5pPlOYc97Gu/6NKNQtXtTdpiKWkgM0hdz6+wB4DElBUeb0PjZGrOjg/1/FdjDbFNgHrrirpalC2yd91hBaonBQxiAk9N2iLKP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511821; c=relaxed/simple;
	bh=bstjIh0MyH3CRWPUX8+dB/XUxxpk7UQMd6rbAngSwdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUFeSloHUevtGk4GfCrrqVGiiKqdCGKjV/B6G9M0HYxyI/PhqHOUmeguQACMjJBlhdDjkzZxbkbzUKotWSxfxaid+uPtgN3VE2c9N8Edfmk50oSpGqMzNhl5AxD8ilBlZVgfjkr4ChKhL6rTtbcEft4AlMVIU8uiewW/heh3FoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovcWj4Wu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4668194603cso10591cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733511818; x=1734116618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YX5vENod+T2504BLwhTU0GY18CRB3665KAzSJYvLbQ=;
        b=ovcWj4WuSAYALkRkFKfAzUYUBglwbUNlp5cJMjHN9+voQkwFOJXNJrA7hBmhdEc3V2
         NVoq45VNwMJwI7TOUouC7CLP4UuUqO+27q6Q8qQOrld6Bip1DY63fr00lsZKChuHuWji
         Q/DMkV5ehwexhlBfzfgEyhFrgR9k1cVwRafb5o5CBVf9ncTHqRSC5Gjzb4ZNFLTc1hQM
         zxOI5zBtCzgkV8aRWD1q3pucC6Y+Uuv5rw3Rrc2tXatK8k8gPdo8HkcYK6JzBaRfJ8zW
         cfzmWPWfrFqMAuXjLKpmE5hsFg5oxOEZx7kLV96e7sC7L774S52+zG6It+0vklc1B+80
         WAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511818; x=1734116618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YX5vENod+T2504BLwhTU0GY18CRB3665KAzSJYvLbQ=;
        b=cvp7SgDlBBEj5eQ9gcWLDLtFkIdaeVd6YwTm/iHsv7C5n0rZ3w2OTfQ7vxpaQivdID
         Fj9m18nDI98v4dgUFJpRkTLaJcM/IjHIwj5hsHtHJiA/A24lxdOGLTssLFHwCN3NWsmC
         BouOoe34eo0u7hJPhXj6pQyf3MpAn6XY+t+WQC2JWvGZ5jUxLzPndIqIwhYOVYnvw+Td
         eLqAl14wJOmougeszK2+LK6NuBI6ypdQrBSGsjHayWJ2dsnxPsZSeNz+EZzb2H24YqfA
         8iOP665I5snGLH3EYZTBUZspLer0I+vGDAgy224F6+brpBCu/811XKt76nmh0mIRc5g6
         lP0A==
X-Forwarded-Encrypted: i=1; AJvYcCXea6Diwo4XyuwgwD/9klKA54CYnskRevo8hhnrmiY9aFP8hp9rb3MkpPQCgwUXqXEQLEB60hHVi8qJln0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9uE1LwHqQTiDTJ5R9d3tKZgOr763H/NEkn4W0aD6TMpDnP2wH
	y5eSiESKQyOeiF3SGUc0OeT9hl9EX2JZYr+ZUVDxRmcFRY+zGjYii42rpgCWHlLIUlw6C2Iip62
	TIkz+9DaGTP+SANgMCjUXkpDqb1PLOIl3dhP6
X-Gm-Gg: ASbGncvDWWXP1c/C2Dnj7ScyjLIopdPalUbtu54m3kucnE6TLvrlg67hh72DvVTwvgC
	wxtpsFZxozoz4toPTHOfESGPHWEpFRfg=
X-Google-Smtp-Source: AGHT+IE7az5T85bqb0ZrEqUiq279W4MrSFYCCDOPPQ5tt2P1bmQGfOgbXDo7InMVxwIvzWVakAu/ZgfG/Rse6xCGg9w=
X-Received: by 2002:a05:622a:2447:b0:466:9003:aae6 with SMTP id
 d75a77b69052e-46746f36854mr195891cf.2.1733511818094; Fri, 06 Dec 2024
 11:03:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <43bf216e-18f7-680c-ae75-773b03c8dc00@linux.dev> <20241205170528.81000-1-hao.ge@linux.dev>
In-Reply-To: <20241205170528.81000-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 6 Dec 2024 11:03:27 -0800
Message-ID: <CAJuCfpHem_cREmXTDfV9qRviApNVgLe=LOkJTCTshHiD0uwkgA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/alloc_tag: fix vm_module_tags_populate's KASAN
 poisoning logic
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:05=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> After merge commit 233e89322cbe ("alloc_tag:
> fix module allocation tags populated area calculation"),
> We still encountered a KASAN bug.
>
> This is because we have only actually performed
> page allocation and address mapping here.
> we need to unpoisoned portions of underlying memory.
>
> Here is the log for KASAN:
>
> [    5.041171][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    5.042047][    T1] BUG: KASAN: vmalloc-out-of-bounds in move_module+0=
x2c0/0x708
> [    5.042723][    T1] Write of size 240 at addr ffff80007e510000 by task=
 systemd/1
> [    5.043412][    T1]
> [    5.043523][   T72] input: QEMU QEMU USB Tablet as /devices/pci0000:00=
/0000:00:01.1/0000:02:001
> [    5.043614][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.1=
3.0-rc1+ #28
> [    5.045560][    T1] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.=
0 02/06/2015
> [    5.046328][    T1] Call trace:
> [    5.046670][    T1]  show_stack+0x20/0x38 (C)
> [    5.047127][    T1]  dump_stack_lvl+0x80/0xf8
> [    5.047533][    T1]  print_address_description.constprop.0+0x58/0x358
> [    5.048092][   T72] hid-generic 0003:0627:0001.0001: input,hidraw0: US=
B HID v0.01 Mouse [QEMU 0
> [    5.048126][    T1]  print_report+0xb0/0x280
> [    5.049682][    T1]  kasan_report+0xb8/0x108
> [    5.050170][    T1]  kasan_check_range+0xe8/0x190
> [    5.050685][    T1]  memcpy+0x58/0xa0
> [    5.051135][    T1]  move_module+0x2c0/0x708
> [    5.051586][    T1]  layout_and_allocate.constprop.0+0x308/0x5b8
> [    5.052219][    T1]  load_module+0x134/0x16c8
> [    5.052671][    T1]  init_module_from_file+0xdc/0x138
> [    5.053193][    T1]  idempotent_init_module+0x344/0x600
> [    5.053742][    T1]  __arm64_sys_finit_module+0xbc/0x150
> [    5.054289][    T1]  invoke_syscall+0xd4/0x258
> [    5.054749][    T1]  el0_svc_common.constprop.0+0xb4/0x240
> [    5.055319][    T1]  do_el0_svc+0x48/0x68
> [    5.055743][    T1]  el0_svc+0x40/0xe0
> [    5.056142][    T1]  el0t_64_sync_handler+0x10c/0x138
> [    5.056658][    T1]  el0t_64_sync+0x1ac/0x1b0
>
> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags populated are=
a calculation")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
> v3: Based on Suren's suggestion, I modified the code,Thank you for Suren.
>     I realized that the 'poisoned' is actually not needed, so I removed i=
t
>     Due to these changes, update the commit message.
>
> v2: Add comments to kasan_unpoison_vmalloc like other places.
>
> commit 233e89322cbe ("alloc_tag: fix module allocation
> tags populated area calculation") is currently in the
> mm-hotfixes-unstable branch, so this patch is
> developed based on the mm-hotfixes-unstable branch.
> ---
>  lib/alloc_tag.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 4ee6caa6d2da..f942408b53ef 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -424,6 +424,15 @@ static int vm_module_tags_populate(void)
>                 vm_module_tags->nr_pages +=3D nr;
>         }
>
> +       /*
> +        * Mark the pages as accessible, now that they are mapped.
> +        * With hardware tag-based KASAN, marking is skipped for
> +        * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
> +        */
> +       kasan_unpoison_vmalloc((void *)module_tags.start_addr,
> +                               new_end - module_tags.start_addr,
> +                               KASAN_VMALLOC_PROT_NORMAL);
> +
>         return 0;
>  }
>
> --
> 2.25.1
>

