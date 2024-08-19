Return-Path: <linux-kernel+bounces-291780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE7E9566CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17D41C2139D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788F415C151;
	Mon, 19 Aug 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4SE4HnC"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22215B992
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059362; cv=none; b=s92CDtv7s2XB/ObSKuakEdfDCRtJHwWigKZrw+vsYFi+A6aYNQ9iBEHEb+Rc6DCH0Sonjb2wL4+7dPHH7mDVNQ9ss6KKEDpsxTkbawo3OWC91Jkh62MxABJkA0kaRufI8wUB0BtEQWUzUZ3V6+BUTj9hPDfhMwnkmPlIiyEsmu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059362; c=relaxed/simple;
	bh=EMK+91+WXE8cIM+3GuapOnzTthmTvSvSnOKzVVQy4PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKN4qUeLL2le7Cdn//PqLGFd22Ez1DYtk52HkthFLCgCHyRML2YurNOB/n1y9LHe6JBvArHKEhRloUfcVGq2ye6KsseoprK8J4cbc20D4+HCdVUcJWKa3BizUN84BCFrcFW4Qzj3aKppGXi0PcIuuhLI0WE61AaUeZHuv6SxPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4SE4HnC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-530e22878cfso4315486e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724059359; x=1724664159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8acUMrHdL7UqJxDNE2U/AKmqvPKYV6U9lL9osVmzYCQ=;
        b=k4SE4HnCG84FKSeratc+SGDksONSbJN7+qay7kspABFECiKkRAmYHjFRvpZJ3IpK21
         bERKq+xyQe9MfjOHop1qcn9nUGp9pSXTWD90uq7UsL8ekGylxWIeNQO/0FWO81jhqkDH
         56Qe9FD3JgjzwcrEeD8sWOoLJGBdBMawUgOABHbgTs9e4Xs3Ohrz1y/UkhESDFQXBAU2
         hN9agFGpTWQt3sOBoxsx6k2d3rbsLAmEyvtl5VBzoUhP43qw5F3Y0UIkQbTxQ+GCBSLH
         lHFMfEHx3J6deOWhC1TPPfw4yaKWtdTH28o/cJVMXlUNt2EZEWNii9+Uqtby5G2lebS1
         tBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724059359; x=1724664159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8acUMrHdL7UqJxDNE2U/AKmqvPKYV6U9lL9osVmzYCQ=;
        b=ZlB85OVPOYl02FSMhlOYAjZ8xFdf6UTr/x6fAedIawm+ty1biJykmk1v5x3Kg5jhc2
         qQ/0Eqq8uw9/WXaplecs+tSZiP468yuZHlwJk8V8pdlh8eWpWYZK00PJ0g7ngyKqNxv/
         GeVWuzouE1mc/lNYy6vmllfuQ2cXv9RpYF/g3iCU5vJnLrTcLsZol6GAvEipAxjMJCkl
         4cLw6VRugXXtcMe7L1OS3fGCOhJUOSE/YqWWUD/JdeWHTDDx7QfHFZmZDc7QAhac3bhd
         cRevNTNPkUrDgy4f+Elwk7Z8T0bAS2F92I5eNKZXpRQQU/PTzjxVQX799orFgmg7vT+a
         B7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXZAY/AkLnKd3XVZZMc2g0S3aQlixb/BvbCd2rhcTIf5DEm8HAyaKBf8HuxTsgSSGFRqf6n6X6rjWxk0o+XoeryXpA1X/5F0FrfNmvd
X-Gm-Message-State: AOJu0Yw428umYzQ2TioEYtvmwtTreOvsvOYA0zqaW88yhkEe1xZFYx9z
	X5Ja+2VgFkcfZWemTWpyZDRGOBOIzqTaIg89LAF79MxkfniOgtsNx/HILvOngINuQM56HNFkwry
	QCHMZCsbmG253qji5l15235/ocaA=
X-Google-Smtp-Source: AGHT+IHA410JYMbLfKWjDrLWbJMrZefF493+rvfIFELIm0M4r2Hy7T1OlE1Q/fM/1of6bwPGqUPLw80FwhKg8iwpZas=
X-Received: by 2002:a05:6512:ad0:b0:52e:a648:a72f with SMTP id
 2adb3069b0e04-5331c6dca2fmr8137849e87.45.1724059358543; Mon, 19 Aug 2024
 02:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819064115.385086-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240819064115.385086-1-peng.fan@oss.nxp.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Mon, 19 Aug 2024 18:22:26 +0900
Message-ID: <CAB=+i9Rqp93+V4r6deAjKCmQE+h4QAXqU3S=ZdbiuYOqMwY_3g@mail.gmail.com>
Subject: Re: [RFC] mm, slub: avoid zeroing kmalloc redzone
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: nicolas.bouchinet@clip-os.org, chengming.zhou@linux.dev, vbabka@suse.cz, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:32=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> With "slub_debug=3DFUZ init_on_free=3D1 loglevel=3D7" set in bootargs and
> CONFIG_SLAB_FREELIST_HARDENED is set. There is kernel dump:
> [    0.000000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.000000] BUG kmalloc-8 (Not tainted): kmalloc Redzone overwritten
> [    0.000000] ----------------------------------------------------------=
-------------------
> [    0.000000]
> [    0.000000] 0xffff000010032858-0xffff00001003285f @offset=3D2136. Firs=
t byte 0x0 instead of 0xcc
> [    0.000000] FIX kmalloc-8: Restoring kmalloc Redzone 0xffff00001003285=
8-0xffff00001003285f=3D0xcc
> [    0.000000] Slab 0xfffffdffc0400c80 objects=3D36 used=3D23 fp=3D0xffff=
000010032a18 flags=3D0x3fffe0000000200(workingset|node=3D0|zone=3D0|lastcpu=
pid=3D0x1ffff)
> [    0.000000] Object 0xffff000010032858 @offset=3D2136 fp=3D0xffff000010=
0328c8
> [    0.000000]
> [    0.000000] Redzone  ffff000010032850: cc cc cc cc cc cc cc cc        =
                  ........
> [    0.000000] Object   ffff000010032858: cc cc cc cc cc cc cc cc        =
                  ........
> [    0.000000] Redzone  ffff000010032860: cc cc cc cc cc cc cc cc        =
                  ........
> [    0.000000] Padding  ffff0000100328b4: 00 00 00 00 00 00 00 00 00 00 0=
0 00              ............
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc=
3-next-20240814-00004-g61844c55c3f4 #144
> [    0.000000] Hardware name: NXP i.MX95 19X19 board (DT)
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x90/0xe8
> [    0.000000]  show_stack+0x18/0x24
> [    0.000000]  dump_stack_lvl+0x74/0x8c
> [    0.000000]  dump_stack+0x18/0x24
> [    0.000000]  print_trailer+0x150/0x218
> [    0.000000]  check_object+0xe4/0x454
> [    0.000000]  free_to_partial_list+0x2f8/0x5ec
>
> It is because the kmalloc redzone area is cleared or orig_size is
> cleared.

Setting orig_size treats the wasted space (object_size - orig_size) as
redzones. (in check_object())
When orig_size is set to zero, the entire object is perceived as a redzone.
Could you elaborate the explanation in the description?

> When s->object_size is larger than orig_size, just clear the
> orig_size area. And restore the value of orig_size.
>
> Fixes: d57a964e09c2 ("kasan, mm: integrate slab init_on_free with HW_TAGS=
")

I think the proper 'Fixes' commit should be 946fa0dbf2d8 ("mm/slub:
extend redzone check to extra allocated kmalloc space than requested")
because it is the commit that extends redzone check, but did not
address init_on_free=3D1 case.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  mm/slub.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 94f5a4143825..d03957d15bbf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2282,14 +2282,22 @@ bool slab_free_hook(struct kmem_cache *s, void *x=
, bool init,
>          */
>         if (unlikely(init)) {
>                 int rsize;
> -               unsigned int inuse;
> +               unsigned int inuse, orig_size;
>
>                 inuse =3D get_info_end(s);
> +               orig_size =3D get_orig_size(s, x);
>                 if (!kasan_has_integrated_init())
> -                       memset(kasan_reset_tag(x), 0, s->object_size);
> +                       memset(kasan_reset_tag(x), 0,
> +                              s->object_size > orig_size ? orig_size : s=
->object_size);

the size can simply be orig_size, as orig_size returns object_size
when it is not enabled
and orig_size can never be bigger than object_size.

>                 rsize =3D (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : =
0;
>                 memset((char *)kasan_reset_tag(x) + inuse, 0,
>                        s->size - inuse - rsize);
> +               /*
> +                * Restore orig_size, otherwize kmalloc redzone overwritt=
en
> +                * would be reported
> +                */
> +               set_orig_size(s, x, orig_size);

