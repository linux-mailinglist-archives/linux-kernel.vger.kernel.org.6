Return-Path: <linux-kernel+bounces-403161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E68FD9C31C8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 12:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F7D1F21141
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 11:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCEA155A34;
	Sun, 10 Nov 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1UCTa46"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C161552FA
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731237721; cv=none; b=Q3jW043vHtgUEjyrBQoPKsNPY7Xd2vu+dgEVkmRAY8tHwp7BDSqoi/TS2sxeaIADBG5Q7HD0EvQHdMnloSdQ8Ad5tESZElzO2yLKGWnRvlv3wQslX5IGEtJFrg5WcgvZE5arph+qIYrWWAJLeqbf+zILX06oGD1nuML9O/Li0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731237721; c=relaxed/simple;
	bh=JUqkrn9jPewf9BFWwFBdsAz3L3TMLh2vheUxwewIS5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvlwyKKSkUaEIhTxeLxvtNGlBw41iw4GJfO9wCgLtU25KEADq6ES2BKZocmNTYz0Cw6ECcT5DgHsX3wDGfwkj+UZ7VoJsTD/AUFTlG9VjtGDR07/ukIMqk4JSyQXBTf8wPJiovGJ/TyBS0EoPgRPdX6TxUQ9B8zIO27+lM5dDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1UCTa46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816B6C4AF0B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731237719;
	bh=JUqkrn9jPewf9BFWwFBdsAz3L3TMLh2vheUxwewIS5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K1UCTa46qjx98YPoqOY4wB9C/EEAn+oYsXOhw9hGJubioKaVTuGuBAdEX2ru7maG9
	 p+sk3pDBgHf0zg/m5/HBGXDRrEnqq+kEpf8c3H5cO2bv5mV6T7dqzdiZEINFuT55K3
	 OZ9/q5jbtL1PRwlcGefGX2UIx5iGoqWZ4h0XuXBFBn+iqJLCtbSH0lUd0UcWKTCC0m
	 gx3vSxpO4kqiPp3/e2J0D8WxGl/aaIF8HcK4PLd8yDyyht1r8Tnk7iMezm7aZFUZj+
	 LpAFdh2ZpyXJOWHoIGd4AjUfJrthhJbVyPwxb946FNCvyRhXTWIFbtVXg7Pp8GAZzt
	 clmtRycpP4g8A==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso36336241fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 03:21:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWo3VsHB8DA4E5+pYc5lq23ulhBQkL0Q/WiGl3QuW90TbmU1PkH0LTTH5HsUzBYnqn9UwyBpfIl5KeJX+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKUUA01SFNouNpinHEByfG9WB/B4l74CUSVBPwrnx+NlOdXls6
	p1mYBGdFs/N6wESOEwUixf3NSwVngNmbMdvIrZ5dKANmeYWy+Vr86uLbWel2qwtSKfNI7jkn3pe
	q5KNg5zVZaidfu2xk01pVKSgKO4M=
X-Google-Smtp-Source: AGHT+IF7cr2MzWW2j3ApwK6puLRorAKWJWJnleqhEg06/p0lDRgb1Ai/0+0+SeKWwx2+Hl7y94pMm+PoZq5aT+OTAXw=
X-Received: by 2002:a05:651c:515:b0:2fb:3881:35be with SMTP id
 38308e7fff4ca-2ff2096433bmr30664511fa.9.1731237718177; Sun, 10 Nov 2024
 03:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005831.15434-1-elsk@google.com> <CAK7LNAQFk1UNARu4HMcAfpykpw6u3ex_PHOLzfnAo2CoOzBT8w@mail.gmail.com>
In-Reply-To: <CAK7LNAQFk1UNARu4HMcAfpykpw6u3ex_PHOLzfnAo2CoOzBT8w@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 10 Nov 2024 20:21:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATm3n3FVqmbRA-U3GWeCW_X0L8Twy6zgVYC3Tdz3xwTcA@mail.gmail.com>
Message-ID: <CAK7LNATm3n3FVqmbRA-U3GWeCW_X0L8Twy6zgVYC3Tdz3xwTcA@mail.gmail.com>
Subject: Re: [PATCH v1] kheaders: prevent `find` from seeing perl temp files
To: HONG Yifan <elsk@google.com>
Cc: enh@google.com, ccross@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Matthias Maennich <maennich@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 8:18=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Nov 7, 2024 at 9:58=E2=80=AFAM HONG Yifan <elsk@google.com> wrote=
:
> >
> > Symptom:
> >
> > The command
> >
> >     find ... | xargs ... perl -i
> >
> > occasionally triggers error messages like the following, with the build
> > still succeeding:
> >
> >     Can't open <redacted>/kernel/.tmp_cpio_dir/include/dt-bindings/cloc=
k/XXNX4nW9: No such file or directory.
>
>
> I tested this patch on Alpine Linux
> with "for i in $(seq 100); do" loop.

FWIW, I used Docker for testing.


This is the Dockerfile for my setup.

---------->8------------
ARG FROM=3Dalpine

FROM ${FROM}

RUN \
apk add \
bash \
bison \
diffutils \
elfutils-dev \
emacs \
flex \
gcc \
git \
linux-headers \
make \
# c library
musl-dev \
nano \
openssl-dev \
perl \
python3 \
# useradd
shadow \
sudo \
tar
---------->8------------


I used linux-next-20241108 for the test kernel.


--=20
Best Regards
Masahiro Yamada

