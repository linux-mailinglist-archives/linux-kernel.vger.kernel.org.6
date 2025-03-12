Return-Path: <linux-kernel+bounces-557322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD7A5D753
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8452C189D422
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341291EFF96;
	Wed, 12 Mar 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzMDdue8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CC1EF0A5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764694; cv=none; b=a+LVTPwKaZ7Sp34aZCYzJGmume5lkWfgeV5l0r3uNGXtkN1XAeExJ8nbG2WB+fvXJEjTqm8NhPVJhmfTXCtQwyAUTwBy6dKiNwWcjynrIlko+12P+bEyJgWPdEJDvWuywDfUFGFuUXHOnc8ClLnCIvgtujk1GoqWuxN6Akziey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764694; c=relaxed/simple;
	bh=vDXXOXMc3BbJU8Zi+rMhAEWot7OTms2YT2Z9GcQat1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2Ec+UqSDRNLbWzoa7pumEbgHwdFr8HFxIB5K11fVfQzttpC8xBmHexXLMfUA3c/s5HCsjcjyrP70pzFSbBdigCeGSeYPE/qYu7H/VoI5q6XW5itrmaAY5AN3zMsT9+sW9eLmqghqNp24odGmaW6rnuo2LdllhzyxModHjshYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzMDdue8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804EAC4CEE3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741764693;
	bh=vDXXOXMc3BbJU8Zi+rMhAEWot7OTms2YT2Z9GcQat1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SzMDdue8oyCV0HOr/eFqwZw0/fbgMEGvDcO+2bjnjpVnx4lqwgoHXF0y2YRXLFp/O
	 2ETLkV2Q/0/8P5knT+IQQBDE5H5whLQ18spi4MYKc4gIxyAQoBotZ28G4tCBHql5tt
	 toNZd1pQ+5WoKaLC6NlpWGY67sF2o0RBfHIhoDJftwKoMUJOf5NVCkoAaaZZCoESIw
	 PmFo81KVE52Ydsx5Gy9+zrxyccMw1Y/n05w+wxnj7qdC3c54iSBBiLHm5f07UM9Sfe
	 k02OkRuUu5SzidKICh1IJx90PoRBdknshAnxI3aBcRZaqKnV2RqChj21X5+rwAiPML
	 QZR4X87tIwokg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bee1cb370so56238661fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:31:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzqCBuCQlqbvj4c0fJwgK4AN4J71Nr7KW5bR4IGtYUa1v6crV0bwhPTrQeNO2k6iBpXKegGHR9EWMFNz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvCpwVjwpuLswF4UH2owUesDsWr42yT76d5aYzqGRd/Sd60wQ
	PtXl0xiRwmpvvsaaPREaM/oexuxfVLqwjNrxI6CxBCcD8EeeajYVEtaUa3m4kVblXwa7cujpCQP
	FwYq0nfVpOTMvSu5ANc3KFBJvmDM=
X-Google-Smtp-Source: AGHT+IGDlhz/9DCOLZddQNIZ0rT0sVsQQf16G2LQmYY/hcBf3yQv3A61MlKdEK7Sp80XPWVOmTw5+lpxP38HhyK2hjc=
X-Received: by 2002:a05:6512:2342:b0:545:3037:a73a with SMTP id
 2adb3069b0e04-54990e5d494mr6385071e87.13.1741764692205; Wed, 12 Mar 2025
 00:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312021154.102262-2-elsk@google.com>
In-Reply-To: <20250312021154.102262-2-elsk@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 12 Mar 2025 16:30:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRtmLBiU+-+O4-jzCz+1YamRwVgBXkBA=v5Vo5djRPpA@mail.gmail.com>
X-Gm-Features: AQ5f1Jo7C-9XBRWqWE-dODVI6hRdqlBYJ3KnLoLeW2-tT3IYS6mblgvoI5vDjmo
Message-ID: <CAK7LNARRtmLBiU+-+O4-jzCz+1YamRwVgBXkBA=v5Vo5djRPpA@mail.gmail.com>
Subject: Re: [PATCH v1] setlocalversion: use ${objtree}/include/config/auto.conf
To: HONG Yifan <elsk@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 11:12=E2=80=AFAM HONG Yifan <elsk@google.com> wrote=
:
>
> setlocalversion reads include/config/auto.conf, which is located below
> $(objtree) with commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to
> some in-kernel build artifacts").
>
> Hence, the setlocalversion script needs to use
> $(objtree)/include/config/auto.conf as well.
>
> Note that $(objtree) is not necessarily `.` when O (aka KBUILD_OUTPUT)
> is set, because of commit 13b25489b6f8 ("kbuild: change working
> directory to external module directory with M=3D").

Is this a real issue?
If so, please attach some commands to reproduce an issue.

setlocalversion is invoked only at line 1238 of the top-level Makefile,
within the check "ifeq ($(KBUILD_EXTMOD),)"
So, it is never called with external module builds.







> Signed-off-by: HONG Yifan <elsk@google.com>
> ---
> Implementation note: Should I test -z ${objtree} before using it? Otherwi=
se it
> looks at /include/config/auto.conf which is wrong.
> Or should I fall back to `.` if objtree is not found in the environment
> variables?
> I could also `exit 1` if $objtree is not set. Please let me know what you=
 think.
>
>  scripts/setlocalversion | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 28169d7e143b..88f54eb5a7c2 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -186,7 +186,7 @@ if ${no_local}; then
>         exit 0
>  fi
>
> -if ! test -e include/config/auto.conf; then
> +if ! test -e ${objtree}/include/config/auto.conf; then
>         echo "Error: kernelrelease not valid - run 'make prepare' to upda=
te it" >&2
>         exit 1
>  fi
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>


--=20
Best Regards
Masahiro Yamada

