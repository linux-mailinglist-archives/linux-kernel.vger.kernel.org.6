Return-Path: <linux-kernel+bounces-572529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847EA6CB21
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC2417D92A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43F757F3;
	Sat, 22 Mar 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIcVlj5m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE71BDCF
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742656524; cv=none; b=bBTKak2uixRKc7ycsuMx/kvGWBH94pN7lnL5QhuMj99GC9d6TAPcspMevk2lqLIt5hoQkeX/jlD0VaN1sg6xBThiMWhBes+sSGaQGnxrhS+RB/bUAWwOzvjeKDz+4gf5r0UpptRmqNkmQMVUeUPBKopgG0tqFJJIzAHJ4Mnu+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742656524; c=relaxed/simple;
	bh=WD20/rrDwgVxbxUEGKxmjIwO8A5tb2yY3ykyeJNqvQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtBkSbko63a60iaRIF5iJquz43bNHAtKrHKa44jx1PRH+ikKA9wX9McFvMBOwTSNUkeW2ox2Bgn4Wyw29KQE1cGpULAKHcobE9bO7wJGaTXLBJgOYqxvMmVY92HDAMMbqG64qd5+fmTh/rQrRLf1277traEE8moSiwDJ4lxICBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIcVlj5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23152C4CEED
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742656524;
	bh=WD20/rrDwgVxbxUEGKxmjIwO8A5tb2yY3ykyeJNqvQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sIcVlj5mL7nJiqrTJLSh6YkmHFeSKOX7DwFIVgtoH9GCl1mTOsgzdc+sfDRcumhCv
	 h656cGeRIChdZ61+myNH4nMlQJ4ca0g7xiUajlZTyPeex/rSdQGKRvoiD2ZVMl3f1q
	 ZsRQDqrTfFmCWyLI84ni34tIaUY40VWqRSXqT79rL+mWV5fbIqVdyp4/rQ0FHZHS0C
	 UaPNn+CcpBcn/VcGJuHigjYLjKqn7If5pOXHSA7uSd4lQ7snHI+rZokJE24N/AyyZ8
	 V31BVdbf5UUGwepuOEgf2U8gT8aIlLfmPO1v51P7DDkLJGCpTyFoCz6VzBTyyPOI5j
	 /sYdgEj0Jrxnw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bef9b04adso31661371fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 08:15:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0BXTN09z4LcqTTSCB9BqSSJAYVg0TkGoh/XYnzhSC7z31LedaXdZqpZVt7p/vdae/nvVFj0Gb6KAcmX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLMEh5sn1KrMNXMXK51ChRLmeBpOgF8cdEJL7tXF7L1tKCGC/
	v8lb43TPakmWFjQKOYbQUL3/AeOE3Ud2t2k+AYymFZ3jrotWd2UKjd8VBoHjjMzg+hjjngd7YQ6
	PfaoKLkZhnF13GZJHpj46saPotCk=
X-Google-Smtp-Source: AGHT+IFhe3uVW7iXi9gGdCxHnPJvi3M6RTDXdAtRK1P2cDOSCCAe6psE9iCOcfwPIGdV70SxYHQcOb1qIAPmP+n8tgI=
X-Received: by 2002:a05:6512:138f:b0:545:fc8:e155 with SMTP id
 2adb3069b0e04-54ad647d115mr2589882e87.20.1742656522771; Sat, 22 Mar 2025
 08:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNASqYkDTPNo20Bj1knwsJMrp=nbQyh__=Do67eWq4CKU3A@mail.gmail.com>
 <20250318005900.2256921-1-elsk@google.com>
In-Reply-To: <20250318005900.2256921-1-elsk@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 23 Mar 2025 00:14:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARA7_3W5CRhW+sKXuqdANjczVbaTO+y1tGTRzAxiJGUzA@mail.gmail.com>
X-Gm-Features: AQ5f1Jrvuq5PCuCtIM0MbIfS4ZzSK2OTG7wLiC2ZksO7Gx-zzxpRM9NeSwwcsWA
Message-ID: <CAK7LNARA7_3W5CRhW+sKXuqdANjczVbaTO+y1tGTRzAxiJGUzA@mail.gmail.com>
Subject: Re: [PATCH v2] setlocalversion: use ${objtree}/include/config/auto.conf
To: HONG Yifan <elsk@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux@rasmusvillemoes.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 9:59=E2=80=AFAM HONG Yifan <elsk@google.com> wrote:
>
> setlocalversion reads include/config/auto.conf, which is located below
> $(objtree) with commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to
> some in-kernel build artifacts").
>
> To be consistent, the setlocalversion script should use

"To be consistent" is too weak because we do not add
$(objtree)/ to include/config/auto.conf

Just run "git grep include/config/auto.conf"

You will see more include/config/auto.conf instances
that lack $(objtree)/ prefix.

So, "To be consistent" is not a reason.

You described why Google needs to have this
specifically scripts/setlocalversion.

Without that explained, I do not understand _why_.



> ${objtree}/include/config/auto.conf as well.
>
> Signed-off-by: HONG Yifan <elsk@google.com>
> ---
> v1: https://lore.kernel.org/lkml/20250312021154.102262-2-elsk@google.com/
> v1 -> v2: fixed the other two locations of include/config/auto.conf in
> setlocalversion script; also removed incorrect claim in commit message.
>
>  scripts/setlocalversion | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 28169d7e143b..c13fe6e585e9 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -186,16 +186,16 @@ if ${no_local}; then
>         exit 0
>  fi
>
> -if ! test -e include/config/auto.conf; then
> +if ! test -e ${objtree}/include/config/auto.conf; then


Please quote

"${objtree}/include/config/auto.conf"

to avoid a shellcheck warning.




>         echo "Error: kernelrelease not valid - run 'make prepare' to upda=
te it" >&2
>         exit 1
>  fi
>
>  # version string from CONFIG_LOCALVERSION
> -config_localversion=3D$(sed -n 's/^CONFIG_LOCALVERSION=3D\(.*\)$/\1/p' i=
nclude/config/auto.conf)
> +config_localversion=3D$(sed -n 's/^CONFIG_LOCALVERSION=3D\(.*\)$/\1/p' $=
{objtree}/include/config/auto.conf)
>
>  # scm version string if not at the kernel version tag or at the file_loc=
alversion
> -if grep -q "^CONFIG_LOCALVERSION_AUTO=3Dy$" include/config/auto.conf; th=
en
> +if grep -q "^CONFIG_LOCALVERSION_AUTO=3Dy$" ${objtree}/include/config/au=
to.conf; then
>         # full scm version string
>         scm_version=3D"$(scm_version)"
>  elif [ "${LOCALVERSION+set}" !=3D "set" ]; then
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>


--=20
Best Regards
Masahiro Yamada

