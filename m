Return-Path: <linux-kernel+bounces-180667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D08C718E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2551C20F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E043121104;
	Thu, 16 May 2024 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZpQxaFC"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5420317
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715839915; cv=none; b=EwngJtbqGjdKN0syXgAyXpNad9oNeBA+O0wJKWqcOqxojUcCZJ+dcMY0DqFc3ba6brXuiXdRsSJuf7aj+ORSCTlFsL0ykybSIpk5tX+8SDz6A9E/m0X83yZE6dIKeHeuiZQZNVRKvY4cCAjGbHKHiZlBu/QBpazG8HikjhAf1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715839915; c=relaxed/simple;
	bh=EZIG0xKUDpv3EETxHdOtNwt9+dBWRvFDMP3FaqEOGqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMX2LJcCng1tgQvXm4cv4PjCd/wYknohQslcc+Y/VmHZHDLuclA4Z7LvTRuTUK8krCt69MPJyXo7pwKZYZxA7OFCusq5mii19qUiVuivNNLjZ7WCBxY4FZObuH9DlSUzLWgWRDrpjdzKSieu81VELC1SlXiscWqPGw6lNv+UjD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZpQxaFC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so3039a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715839912; x=1716444712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwSzN8fvfDv5GDu8auPPWOoq9lZrwSpmFoOwo9DGQxk=;
        b=XZpQxaFClYkgsryuKzGqlyzbvQJFlrLiW4OpKjNzheJTY6UPgdGDwHQrMRhWhC5d03
         8nDNe3LMXibxqn1ydTPH6+8jHw03b8SOhkUsM+eKG3TVg5ntgJbFQmQwPSMI5dgTpKTR
         ur0Fwd2EWwOekWrg/6Mp9EOQn91Z5H9cDBfKSeGOuPkC/taXrzHhdIMbli0R3u6VoWmv
         35SiOcAjUIpLkhICXopzl2ILGUndqI19s0iDQzLpV45LM5arZh8t5jafc1o2o+Q073TC
         1Qa/xYX3wcn/9VDctWv7UlQ68485gAFfipDDpTKvjdTT3GimLCB32BOB2y2Y+xeESm/7
         w5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715839912; x=1716444712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwSzN8fvfDv5GDu8auPPWOoq9lZrwSpmFoOwo9DGQxk=;
        b=V+/fiqDaqPa1gd97IezUKaG6L2kZlh1WRx9+pcDV9WlCE4RhsghzhMOif3m4PDv8lK
         Whvoa+vkdojWmy82+XH7k69L8A4FSo+LaYBNe7i9/OvL82Z84Qxtge720FBsAGFQn+Pr
         k1n7APPGnNW8hP0ckIX+z8A/G/4+OuEOTOs/BJNngPDino8wKvRhhLvja0wgjiarPhxC
         AfGPQTJDaVvpJ3nghVOb0ceAUutff6jUZXxWttfne1f3T7Aoc1XyVhnoAPSHdLnfZj+p
         4bUsjhi40+OCuebBbW+KBu6E309P7UVgMKOcAL/SAKtiQZaKcRMjLlFw7e4VDz2hh87U
         f52g==
X-Forwarded-Encrypted: i=1; AJvYcCVGEvoLFIVQg0zf/myxlQ/OtwN3qtrrIYvd/dHbkNMT0SGcJT6hNq9mYyCJecYkfqzydURlCgcQLUk8lvD/cCxLM3Svx6cq9WCol6XA
X-Gm-Message-State: AOJu0YwsPIEjvIjrikogDxRN8RgXeW6rO6wbxvSA9bjWJjGAPOqYKWvO
	4AbBjxNwx/Hn+nwxHl+hKNIIZi0aASun5+Akvbmso3RspBO88yheww4Y0a70RxkBkb7rvXxp+ZD
	OrLCosz6Q2I3OHaZCBKYXqBctcQc1yZ9OR27y
X-Google-Smtp-Source: AGHT+IEp0x2v9zSQfirOjmV+BT0Ym9aTirvBrBvS0QkHPlchfgN4t9zGFwynf4n0RLKyS+bv4MaASd94Zp7m+NCTcXE=
X-Received: by 2002:a05:6402:5248:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-574e7e13675mr685505a12.7.1715839910575; Wed, 15 May 2024
 23:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com>
In-Reply-To: <20240513191544.94754-1-pobrn@protonmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 15 May 2024 23:11:12 -0700
Message-ID: <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, 
	dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, 
	jorgelo@chromium.org, skhan@linuxfoundation.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <pobrn@pr=
otonmail.com> wrote:
>
> `MFD_NOEXEC_SEAL` should remove the executable bits and set
> `F_SEAL_EXEC` to prevent further modifications to the executable
> bits as per the comment in the uapi header file:
>
>   not executable and sealed to prevent changing to executable
>
> However, currently, it also unsets `F_SEAL_SEAL`, essentially
> acting as a superset of `MFD_ALLOW_SEALING`. Nothing implies
> that it should be so, and indeed up until the second version
> of the of the patchset[0] that introduced `MFD_EXEC` and
> `MFD_NOEXEC_SEAL`, `F_SEAL_SEAL` was not removed, however it
> was changed in the third revision of the patchset[1] without
> a clear explanation.
>
> This behaviour is suprising for application developers,
> there is no documentation that would reveal that `MFD_NOEXEC_SEAL`
> has the additional effect of `MFD_ALLOW_SEALING`.
>
Ya, I agree that there should be documentation, such as a man page. I will
work on that.

> So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested.
> This is technically an ABI break, but it seems very unlikely that an
> application would depend on this behaviour (unless by accident).
>
> [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@google.c=
om/
> [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@google.c=
om/
>
> Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
> Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> ---
>
> Or did I miss the explanation as to why MFD_NOEXEC_SEAL should
> imply MFD_ALLOW_SEALING? If so, please direct me to it and
> sorry for the noise.
>
Previously I might be thinking  MFD_NOEXEC_SEAL implies
MFD_ALLOW_SEALING because MFD_NOEXEC_SEAL seals F_SEAL_EXEC, and
sealing is added only when MFD_ALLOW_SEALING is set.

I agree your patch handles this better, e.g.
mfd_create(MFD_NOEXEC_SEAL) will have F_SEAL_SEAL and F_SEAL_EXEC
mfd_create(MFD_NOEXEC_SEAL|MFD_ALLOW_SEALING) will have F_SEAL_EXEC


> ---
>  mm/memfd.c                                 | 9 ++++-----
>  tools/testing/selftests/memfd/memfd_test.c | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 7d8d3ab3fa37..8b7f6afee21d 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -356,12 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
>
>                 inode->i_mode &=3D ~0111;
>                 file_seals =3D memfd_file_seals_ptr(file);
> -               if (file_seals) {
> -                       *file_seals &=3D ~F_SEAL_SEAL;
> +               if (file_seals)
>                         *file_seals |=3D F_SEAL_EXEC;
> -               }
> -       } else if (flags & MFD_ALLOW_SEALING) {
> -               /* MFD_EXEC and MFD_ALLOW_SEALING are set */
> +       }
> +
> +       if (flags & MFD_ALLOW_SEALING) {
>                 file_seals =3D memfd_file_seals_ptr(file);
>                 if (file_seals)
>                         *file_seals &=3D ~F_SEAL_SEAL;
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/s=
elftests/memfd/memfd_test.c
> index 18f585684e20..b6a7ad68c3c1 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -1151,7 +1151,7 @@ static void test_noexec_seal(void)
>                             mfd_def_size,
>                             MFD_CLOEXEC | MFD_NOEXEC_SEAL);
>         mfd_assert_mode(fd, 0666);
> -       mfd_assert_has_seals(fd, F_SEAL_EXEC);
> +       mfd_assert_has_seals(fd, F_SEAL_SEAL | F_SEAL_EXEC);
>         mfd_fail_chmod(fd, 0777);
>         close(fd);
>  }
> --
> 2.45.0
>

Reviewed-by: Jeff Xu <jeffxu@google.com>

Thanks!
-Jeff

