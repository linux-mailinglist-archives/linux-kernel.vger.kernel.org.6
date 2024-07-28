Return-Path: <linux-kernel+bounces-264485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138693E402
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC2C1C20FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5D6F9F8;
	Sun, 28 Jul 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpTpd6ro"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C18472;
	Sun, 28 Jul 2024 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722153807; cv=none; b=gwWJQjcGglP8d7YiwT/xRV/wHda5ZIIvhr/7DLgPY2XB/QAQhFrsedzGDTbprZRN/qdfHt1BVYHGThTrJQs6nrkpIWNXwsVHlvrOfXTJXJL+D7ZnbFAAFr9rAQM6Fma14Xw3Xj5jERI/15/5veAE5/mb3DXUuSfHry+XInrFIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722153807; c=relaxed/simple;
	bh=3uCbJ9uxasWwOS8Njpoa6UrCzyfjy1UZzndiEITIf6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl1WU/2NsdsunwcQW8aYqGszFnH3eq1uaGkx6WLipxAwI2KAUcUVXQg2TperMhOapNssw8g5U29cxdYGB9HoXeenSXE79A14R5tez3D0VJE0pYMaLjjK5hmnz0+V8jQeafpSe8tYi6Ian8NpjfUNpu85G68hGtsAAx+nQKQ4Qc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpTpd6ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA69C116B1;
	Sun, 28 Jul 2024 08:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722153804;
	bh=3uCbJ9uxasWwOS8Njpoa6UrCzyfjy1UZzndiEITIf6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZpTpd6roDcSzHR2sZE5xLjMjksRXEux0EOPHOSCxziURDkebE+xqeev/tu33+GzPf
	 wckj039FlDGVnNTvmG5n2MgIVG2N51aYF+iN3ID1EBHpWAihyHeuFx/Eji9+K/GNJh
	 HG+xKAKGn2acuAlBPi/rFVmA0YEKpUCrogkawx95pZrTQMkgo+3HxQTd+7zpo+XjzT
	 FForzpfn4wlJxFcmtkLO5s/HyGjTucWVlv4PcrJIbcHi8w8M4G6u89fol0DhrOx/Gl
	 1/72wp2tSBXmwzhhbYatXCmXthmuDqdq+NBU3fIue+Ay4mA81vwujd7GuSMbg/fO/P
	 ClB1h7Zyc8fPw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f01b8738dso2414021e87.1;
        Sun, 28 Jul 2024 01:03:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNbvpe5lWqi3QXmjD83VExwGUy9BuQ5Hx4MQxPz6NTQ7bN7RizOw9TbLF6NLborRZRGcymo/zukTq148+vE3B5gEau0uvB4K01y6zaLFOKCGTGiJs7iNzg0DpE3v8knm9Tdnms4XOt/EGbBik=
X-Gm-Message-State: AOJu0YwuDuErrwzw5nldXWKPxrOTx/x9UEs8mFa3SZskMJJgiLt17myx
	3vQ3fjWZOXhexB129OqyB9bTigC+XxCMMWz4fw9nsCJre/2+xJhzlQyIXyuwzUZNEmThGYglDf5
	GlkEcG9kbvxbKkpzG2ow+9VUUYDE=
X-Google-Smtp-Source: AGHT+IGczE0b9nWxkW1Xqibs6m6HgMKO+clVXA7gWdIXodoEae/xxzpv4Qah0gvf285Jy14NtCgvBoO3ak2vYR+ohAE=
X-Received: by 2002:a05:6512:2c95:b0:52c:cc38:592c with SMTP id
 2adb3069b0e04-5309b1ee533mr2841726e87.0.1722153803399; Sun, 28 Jul 2024
 01:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727140302.1806011-1-masahiroy@kernel.org> <CANiq72=4vX_tJMJLE6e+bg7ZECHkS-AQpm8GBzuK75G1EB7+Nw@mail.gmail.com>
In-Reply-To: <CANiq72=4vX_tJMJLE6e+bg7ZECHkS-AQpm8GBzuK75G1EB7+Nw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 28 Jul 2024 17:02:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBqcBEYvJQNMHgP7WfQmLbsj_j-wz4DpwQ4Cr3D1bj-w@mail.gmail.com>
Message-ID: <CAK7LNAQBqcBEYvJQNMHgP7WfQmLbsj_j-wz4DpwQ4Cr3D1bj-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: suppress error messages from CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 2:05=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Jul 27, 2024 at 4:03=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > The successful execution of 'command -v rustc' does not necessarily mea=
n
> > that 'rustc --version' will succeed.
>
> +1, it could also be e.g. non-executable.
>
> By the way, I was checking recently `pahole-version.sh` for a series I
> will send about `RUSTC_VERSION` and I saw that one has a `[ ! -x`
> check after the `command -v` for the non-executable case. But taking
> into account what you say here, I wonder if something needs to be done
> there too, e.g.
>
>     $ echo 'bad' > bad-pahole
>     $ chmod u+x bad-pahole
>     $ make PAHOLE=3D./bad-pahole defconfig
>     ...
>     ./bad-pahole: 1: bad: not found
>     init/Kconfig:112: syntax error
>     init/Kconfig:112: invalid statement
>
> So perhaps we can put in pahole-version.sh something like:
>
>     if output=3D$("$@" --version 2>/dev/null); then
>         echo $output | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'
>     else
>         echo 0
>         exit 1
>     fi
>
> i.e. similar to what you do here for `rustc`/`bindgen`.



Agree.
pahole-version.sh should be fixed too.




>
> > However, I did not understand the necessity of 'command -v $(RUSTC)'.
>
> I agree, I don't think it is needed.
>
> If you want to take it through your tree:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
>
> Otherwise, I can take it too.


Yes, please take this to your tree. Thanks.






--=20
Best Regards
Masahiro Yamada

