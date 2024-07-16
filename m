Return-Path: <linux-kernel+bounces-253411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C629320EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D881F22E59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5124B29;
	Tue, 16 Jul 2024 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLKMRaQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE03225D4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113605; cv=none; b=Af7in7UZLE3puvpu1PPsKRWJGsSR+gzwR+sGH+q9b0Kdsvy3EOldS2Kvy87ETbUIZkD+k8ckOkXX96vFRjEZYHZlSrGsQRIZIi+V+8BycCG6x32hWFdfG1U7WQxnBm6JqT/wq0+gwDjRYbT2D1lUcWhsMXh4qLLi6abH/3rg+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113605; c=relaxed/simple;
	bh=eXgoe0KsoXvTXbbnANqs1nc2DePYQfgFu+yrlw2MJcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBezk4cUY8ROCLzHphQVPGo2HjCj47WtRQtLk5aEyo9PnKf5Hn7prVzq/hpm6POzUGE6NvP8G/a11E531VrXUl3gN2EeD0A1kQlhyDd6rruOu+bO2lBZBmNAHfT/wlQnlh/JcmFwnYvqwAG989HY6dxWzsj4GW2e2f0xmdDl6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLKMRaQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED0C4AF09
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721113604;
	bh=eXgoe0KsoXvTXbbnANqs1nc2DePYQfgFu+yrlw2MJcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oLKMRaQmSHDNbcKowCoaGtPV404IN0QcT2J9+5dYBnVK8JTO6d5QYOzroAeht5oTk
	 xoqBaYM59p/s8mj+2UoADpiO4jBjnYnRsgEjb0TyxF96k2Cu+cGMpe+k8TXgy+ezRd
	 k+MtIO81hzm+CwETegeqNuySZ3d2Kyyq1svVjgQzwhREggZrxO+n3xN0tAnWOZJnMp
	 XkxapYmoBeokzU9KmVmLaqmnrbex32+eYlmwG2eWprhVdf18CBBh53iTTIa6RbfLQz
	 SED4PTDF0LV0VQGzCvq0Vz5sagWouVWbkvbs8s9s57U37kvwS8W+34Zj+lwgsuQgMp
	 4fvmR5uwQ9gCQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso7189715e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:06:44 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx+XweNidB1ZEdtjAeEuaZKsidp2Kn32En3ykxMKLAcPPsAGcC4
	p83a5do+bQg61ZpPZU7u/Y2JaualkIRIjkZXXOBpErFetLX+Xsf4hxpwRPBJU+hfdgt5aKG2xS/
	AJdt9OXbTJPMMSsXGSrbjChunS2w=
X-Google-Smtp-Source: AGHT+IG2SKSfcAknDc+cGMV6ZWR9F+Epdw6tLdCyCb6lq5wJ5KH/PaaTkBXKIn5wjb2xKS0W0ZFsjDWd25/fDFmCYV0=
X-Received: by 2002:a05:6512:3d1d:b0:52c:a20e:4da4 with SMTP id
 2adb3069b0e04-52edf0344cbmr1060172e87.57.1721113603541; Tue, 16 Jul 2024
 00:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710172717.1346194-1-maz@kernel.org>
In-Reply-To: <20240710172717.1346194-1-maz@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jul 2024 16:06:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREexLc6O_wakzz9+3uYP6d5c7Ch2aVAn9FCbKNgCSu7A@mail.gmail.com>
Message-ID: <CAK7LNAREexLc6O_wakzz9+3uYP6d5c7Ch2aVAn9FCbKNgCSu7A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: Fix build error caused by lack of
 positionnal argument
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 2:27=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Since 8ef052389f7f ("kbuild: package: add -e and -u options to some
> shell scripts"), building a debian package on my arm64 box fails:
>
> $ make -j20 bindeb-pkg
>   UPD     include/config/kernel.release
>   GEN     debian
> ./scripts/package/mkdebian: 138: 1: parameter not set
> make[2]: *** [scripts/Makefile.package:98: debian] Error 2
> make[1]: *** [/home/maz/hot-poop/arm-platforms/Makefile:1538: bindeb-pkg]=
 Error 2
> make: *** [Makefile:224: __sub-make] Error 2
>
> Applying the same pattern for substitution of undefined variables
> seems to paper over the issue and brings the script back to life.
>
> Fixes: 8ef052389f7f ("kbuild: package: add -e and -u options to some shel=
l scripts")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> ---
>  scripts/package/mkdebian | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 196b14e8ad47..de8b460a46b4 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -135,7 +135,7 @@ else
>  fi
>  maintainer=3D"${name} <${email}>"
>
> -if [ "$1" =3D --need-source ]; then
> +if [ "${1:+set}" =3D --need-source ]; then
>         gen_source
>  fi
>


This is wrong.

It will break 'make srcdeb-pkg' because
"set" =3D "--need-source" is always false.



I will squash the following.


while [ $# -gt 0 ]; do
    case "$1" in
    --need-source)
        gen_source
        shift
        ;;
    *)
        break
        ;;
    esac
done


Thanks for the report.
















--=20
Best Regards
Masahiro Yamada

