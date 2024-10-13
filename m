Return-Path: <linux-kernel+bounces-362956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF999BBB3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE311C20C84
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26514A639;
	Sun, 13 Oct 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grbMg9rZ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4DD78289
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851696; cv=none; b=H92MHIQt2KRTVSyLuFS/hjASfDgovA/Gg/zBdRGxiM/b3T1WRkoRmmo+MR7d/gzkYaTb8feAVfaNo5Wr82fghKkmMz5a4Iz1exSjOOPWPewOm9wtGzpkVcSm9b7/eXGM7hGpWHIU7jAaPAyWnWQa3YYO0y/fzwRDb6HjiPGeyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851696; c=relaxed/simple;
	bh=LcZfdTmeZhYBJhbxG8z3EbJ1blOKVLq5yZML0bkRqNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3zlmwTi0H4gWyGQSX+o3G1rlMm/uRylctc41xH+L5wL/vdQ7k6t8pnQjyjAMF+k1v4Fue6t6Pj7F7IWtTIP0IYUu9Kh4rgvwjuMxoEOX2Yauds16Fu0/Dhnf954oXWMujrY21IUdraifWVxMSktZe9cNMK1f0XDWgUiuNQ27Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grbMg9rZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431137d12a5so34009305e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728851693; x=1729456493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Er+DyA+nIZCWp4voswFezoCAMxbkG62zzvLI/ETBGJ0=;
        b=grbMg9rZ3OMkNjK8xbETzrCgVvEmJhOmcGYZHpsvENBWayvMD15zKj6fhfG8ct90Up
         wPkA3Sz0WWUAhQziip//yeRDLPQ+ULcsdCTYEoi4XW6VTO/lchTp6IzIDdsxc2YAFgcQ
         cpbKYjK90ur4HdBRCLEqkYH30zmtd2VOtrANLGQh+yVt50gxNdTFn7r8zoEaexIAumDs
         28UrQcu97jwTmFdZfzAuXuHQyT8xKnJVnR1smKLxoPgr1f3dkKi5tWpcJq+hppoJeg55
         /EQN7wl+thvaelEnbvfLLNmwMKdwRzDluZ+XH+8shgm5DWxbtasatTAj46S+IXQ/AzZs
         qFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728851693; x=1729456493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Er+DyA+nIZCWp4voswFezoCAMxbkG62zzvLI/ETBGJ0=;
        b=kSlXzRMu9HbQA2VEQs0A31gn0EjVAZaUy44UQ2Vy+cUxMt00r/Q2rVlgV6qsb1F+Ip
         dlL9CUsQsBAkbTz78BtfEbvHSvhh93XJfY+YrHKZCwaVEtCi9Ww72hyVziaatDbK9Tv2
         ILF5V83AjzD0CuLOeli+6OpfTkT23m24VqaU1oStviEqYRnFacjpYqy/T2+WPYpf/Rhh
         zF4mdjPBZ3up2rPsJN3ZFIVC5dS/oCm2ev8a+cJ8+9tmTynom3i1G8OB6tyljXGFoVT9
         xhb1StL43Ly7kejfICPl/78FvBLkiXXvRE4kIvSP/biaMUAV+s22RSZGqEnL2r5g7gPk
         FbjA==
X-Forwarded-Encrypted: i=1; AJvYcCUOQnfdpXds8Bd/6WdO8WaPuKFHr+xNUQUGSDjGGodOZR+gV/BDQnl5SE7LqMibZztdyXAMEuo06tXBiC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXO/pBdOBCQgwmMI9cG0z+Prj/T9RHeaDUOEx8/ABjlH7i3cIN
	uz7olLgL0OzNa8GlsknJctn5BZeXM/0IUpVlxhTVAWymz3wR7LmeqTexJQVd94BxLJ9K15XOL55
	6GwwDR5YckFeBQ4RpuqCsZAF+9bwSdIsc
X-Google-Smtp-Source: AGHT+IGksot7xAFBhWvjEpCUFw1IBFJungZfa526wBYqwxFlr8N9z/UTam+RKU0xR1+7x9AbsiCS2C2mmgOosim4i9s=
X-Received: by 2002:adf:a1d9:0:b0:37d:324f:d3a9 with SMTP id
 ffacd0b85a97d-37d5519884amr6151232f8f.9.1728851693089; Sun, 13 Oct 2024
 13:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013172912.1047136-1-niharchaithanya@gmail.com>
In-Reply-To: <20241013172912.1047136-1-niharchaithanya@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 13 Oct 2024 22:34:42 +0200
Message-ID: <CA+fCnZcM_xufVqgpmyJ_GxZC_70-kJVF7Hjhr_Vv6gKTUL5LoA@mail.gmail.com>
Subject: Re: [PATCH] kasan: add kunit tests for kmalloc_track_caller, kmalloc_node_track_caller
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: ryabinin.a.a@gmail.com, dvyukov@google.com, skhan@linuxfoundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 7:32=E2=80=AFPM Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>
> The Kunit tests for kmalloc_track_caller and kmalloc_node_track_caller
> are missing in kasan_test_c.c, which check that these functions poison
> the memory properly.
>
> Add a Kunit test:
> -> kmalloc_tracker_caller_oob_right(): This includes unaligned, aligned a=
nd
>    beyond-aligned out-of-bounds access test for kmalloc_track_caller and
>    out-of-bounds access test for kmalloc_node_track_caller.
>
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>

You can add a Fixes tag here to link the patch the Bugzilla entry:

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216509

> ---
>  mm/kasan/kasan_test_c.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..b418bdff5bdb 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -213,6 +213,39 @@ static void kmalloc_node_oob_right(struct kunit *tes=
t)
>         kfree(ptr);
>  }
>
> +static void kmalloc_track_caller_oob_right(struct kunit *test)

Let's simplify this and do a single bad access check here for each
kmalloc_track_caller and kmalloc_node_track_caller. Precise redzone
poisoning checks are already done in normal kmalloc tests. This test
is just intended to be sure that we didn't forget to include KASAN
instrumentation calls into the track_caller variants.

> +{
> +       char *ptr;
> +       size_t size =3D 128 - KASAN_GRANULE_SIZE - 5;

size_t size =3D 128 - KASAN_GRANULE_SIZE;

> +
> +       /*
> +        * Check that KASAN detects out-of-bounds access for object alloc=
ated via
> +        * kmalloc_track_caller().
> +        */
> +       ptr =3D kmalloc_track_caller(size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
> +       OPTIMIZER_HIDE_VAR(ptr);
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] =3D 'x');
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + 5] =3D 'y');
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D
> +                                       ptr[size + KASAN_GRANULE_SIZE + 5=
]);

Just one check for all KASAN modes here:

KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] =3D 'y');

Nit: add empty line before kfree().

> +       kfree(ptr);
> +
> +       /*
> +        * Check that KASAN detects out-of-bounds access for object alloc=
ated via
> +        * kmalloc_node_track_caller().
> +        */
> +       size =3D 4096;
> +       ptr =3D kmalloc_node_track_caller(size, GFP_KERNEL, 0);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
> +       OPTIMIZER_HIDE_VAR(ptr);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D ptr[size]);

Nit: add empty line before kfree().

> +       kfree(ptr);
> +}
> +
>  /*
>   * Check that KASAN detects an out-of-bounds access for a big object all=
ocated
>   * via kmalloc(). But not as big as to trigger the page_alloc fallback.
> @@ -1958,6 +1991,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
>         KUNIT_CASE(kmalloc_node_oob_right),
> +       KUNIT_CASE(kmalloc_track_caller_oob_right),
>         KUNIT_CASE(kmalloc_big_oob_right),
>         KUNIT_CASE(kmalloc_large_oob_right),
>         KUNIT_CASE(kmalloc_large_uaf),
> --
> 2.34.1
>

