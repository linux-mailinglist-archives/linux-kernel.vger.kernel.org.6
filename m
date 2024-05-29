Return-Path: <linux-kernel+bounces-194708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9A8D4056
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CE5282DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BCC1C9EAF;
	Wed, 29 May 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdaPSZFf"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4E315D5C4
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717018285; cv=none; b=YU/ugtAGuEnkRv1Iu0xXwHch2Tvdl1wMyYAj7faDniKzneL0EyJQ6F8NHugMI04Zy+J89a14Ywa/pH7yPzzTUiv64UkxUM9FAwZ7OHrdxqhd6R91iXpYJuEXMZ9sJBkUNbCIC814nO4fSh3MADpywLzBcQaoiOyXs2WenltZf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717018285; c=relaxed/simple;
	bh=W05mNXb0UrG3pIeEAflXGkFgca+10GQzjYeUMQhZlUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRpp3d4A/nz1OeHcx/Xc4pt0X/K2D8qtl4XKVG7jVRPDlhnFBFq8AQ5tmZsRzQrd9rreH3RfITbjgOwFyfYgRAzhN7oFpSEOgbc5YrijiFVvfq+allicoGeDciRfX2O85hcJlhpR2uaVQinNVB2KWpF4Hh34rOENHJwLiXlzK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdaPSZFf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so158a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717018282; x=1717623082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLiA1NhyieWQfcXd3ARNdY+JpVH2itsFMZIhqt+3Mg4=;
        b=jdaPSZFflkE7Q70yFfv9H0YtUbr3npbLsWRAqzwlHMgsuGKY+q/+r6mpOyOMVXSgzN
         +LeYrfWVnYvm78uxw6i4QStOnoMjxQQazP7pyzooRf0Knx+1Fv9r+tTJCoWe+EGjiVZj
         LcQYwRgLxQvLJtnhdIBR+rdYBsDG36B1mwZLiNm3wwsKhtBPnxbyuhCUzXJQWSPKYZ5W
         4EfOfcZe2uB6p0/154Euy7tiHQXACiYtHs6SO2SfOFSEfUOWB8sTxMoEsS2Zt+gpYTKA
         LOddoHThnP00yJebbrm1qNCXLNaUYADQYjtazseV1EwUDzkip/qycsqfaIrGlSSSCLEk
         a3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717018282; x=1717623082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLiA1NhyieWQfcXd3ARNdY+JpVH2itsFMZIhqt+3Mg4=;
        b=l52evjsFmw3rnZiqpXGHu5SDh1wvPZzMFF+bQHk4VoBamiO1xUYOxKeihUxnm3yPOE
         KZrJ/DpYZRGi4BUFwwdM2ZDYRfEZP5jkUwHhbsNwHQTE3SWpxAFEXn5y5qEi7l8RWHTg
         aqfg9fkNl3EwXMr+fc2R7B+P5yuBcDX7iPtvHjfWucHmteWIgf0MsuvcbmgVwboQuYiW
         bLQ+MpR7Yzy0PHj27GN2cOOXuSXVZafdrKqNb8SA31xlcvFZzZnRzEwnaKgj0QASp+4l
         H1L2SK5bxjOBTzwOc38LJilf8E/xg5zQVRDdhzEH5mg7PWzt2noaiGUxKA9tCVy47NY6
         7mhA==
X-Forwarded-Encrypted: i=1; AJvYcCUhlwORRXfYT04qTi3JxYDFtRqyt5nWZrdvtxEolOKVufaW+WgfqKux8FNjP5geLoX4vQtRVykZQHDazNGggb6BJZTFYDZ7z0bkKIh8
X-Gm-Message-State: AOJu0YxX/J2rFgJBNXoKLu5BbLn9L/TzENXyc3nhiDfBKAgV/+f4atNJ
	v2JE6Ud+txt0TfCSWjBwyZRTEa/Og9urKVbvgbBLiOLzfIySJoaeP2Xw6N7+b+ep4FxNUhhwCvI
	wfPqGs0i1UgqLfojQ7uJhDG33Zz+h25YFtcBM
X-Google-Smtp-Source: AGHT+IE+x8lFbKLlWU1Fq0CgkMn615w4ys1te7GNt5dz/IZuvIoJg4ejLZAvtFf70Zb8LZLZNTajFROLwUn0R5dzS2k=
X-Received: by 2002:aa7:c2ce:0:b0:576:b1a9:2960 with SMTP id
 4fb4d7f45d1cf-57a18c8ab10mr22904a12.5.1717018280000; Wed, 29 May 2024
 14:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033933.135049-1-jeffxu@google.com> <20240524033933.135049-2-jeffxu@google.com>
 <79b3aa3e-bc70-410e-9646-0b6880a4a74b@app.fastmail.com>
In-Reply-To: <79b3aa3e-bc70-410e-9646-0b6880a4a74b@app.fastmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 29 May 2024 14:30:41 -0700
Message-ID: <CALmYWFu61FkbboWkXUSKBGmXeiNtBwrgfizS5kNvPMx4ByUqPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
To: David Rheinsberg <david@readahead.eu>, =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, cyphar@cyphar.com, 
	dmitry.torokhov@gmail.com, Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, 
	jorgelo@chromium.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David and Barnab=C3=A1s

On Fri, May 24, 2024 at 7:15=E2=80=AFAM David Rheinsberg <david@readahead.e=
u> wrote:
>
> Hi
>
> On Fri, May 24, 2024, at 5:39 AM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > By default, memfd_create() creates a non-sealable MFD, unless the
> > MFD_ALLOW_SEALING flag is set.
> >
> > When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD created
> > with that flag is sealable, even though MFD_ALLOW_SEALING is not set.
> > This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
> > unless MFD_ALLOW_SEALING is explicitly set.
> >
> > This is a non-backward compatible change. However, as MFD_NOEXEC_SEAL
> > is new, we expect not many applications will rely on the nature of
> > MFD_NOEXEC_SEAL being sealable. In most cases, the application already
> > sets MFD_ALLOW_SEALING if they need a sealable MFD.
>
> This does not really reflect the effort that went into this. Shouldn't th=
is be something along the lines of:
>
>     This is a non-backward compatible change. However, MFD_NOEXEC_SEAL
>     was only recently introduced and a codesearch revealed no breaking
>     users apart from dbus-broker unit-tests (which have a patch pending
>     and explicitly support this change).
>
Actually, I think we might need to hold on to this change. With debian
code search, I found more codes that already use MFD_NOEXEC_SEAL
without MFD_ALLOW_SEALING. e.g. systemd [1], [2] [3]

I'm not sure if this  will break  more applications not-knowingly that
have started relying on MFD_NOEXEC_SEAL being sealable. The feature
has been out for more than a year.

Would you consider my augments in [4] to make MFD to be sealable by default=
 ?

At this moment, I'm willing to add a document to clarify that
MFD_NOEXEC_SEAL is sealable by default, and that an app that needs
non-sealable MFD can  set  SEAL_SEAL.  Because both MFD_NOEXEC_SEAL
and vm.memfd_noexec are new,  I don't think it breaks the existing
ABI, and vm.memfd_noexec=3D0 is there for backward compatibility
reasons. Besides, I honestly think there is little reason that MFD
needs to be non-sealable by default.  There might be few rare cases,
but the majority of apps don't need that.  On the flip side, the fact
that MFD is set up to be sealable by default is a nice bonus for an
app - it makes it easier for apps to use the sealing feature.

What do you think ?

Thanks
-Jeff

[1] https://codesearch.debian.net/search?q=3DMFD_NOEXEC_SEAL
[2] https://codesearch.debian.net/show?file=3Dsystemd_256~rc3-5%2Fsrc%2Fhom=
e%2Fhomed-home.c&line=3D1274
[3] https://sources.debian.org/src/elogind/255.5-1debian1/src/shared/serial=
ize.c/?hl=3D558#L558
[4] https://lore.kernel.org/lkml/CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=3DuO9OewMh=
GfhGCY66Hbw@mail.gmail.com/


> > Additionally, this enhances the useability of  pid namespace sysctl
> > vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel will
> > add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
> > MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the MFD
> > to be sealable. This means, any application that does not desire this
> > behavior will be unable to utilize vm.memfd_noexec =3D 1 or 2 to
> > migrate/enforce non-executable MFD. This adjustment ensures that
> > applications can anticipate that the sealable characteristic will
> > remain unmodified by vm.memfd_noexec.
> >
> > This patch was initially developed by Barnab=C3=A1s P=C5=91cze, and Bar=
nab=C3=A1s
> > used Debian Code Search and GitHub to try to find potential breakages
> > and could only find a single one. Dbus-broker's memfd_create() wrapper
> > is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries to
> > work around it [1]. This workaround will break. Luckily, this only
> > affects the test suite, it does not affect
> > the normal operations of dbus-broker. There is a PR with a fix[2]. In
> > addition, David Rheinsberg also raised similar fix in [3]
> >
> > [1]:
> > https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f26=
7d4a8784cb/src/util/misc.c#L114
> > [2]: https://github.com/bus1/dbus-broker/pull/366
> > [3]:
> > https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu=
/
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
> > Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > Reviewed-by: David Rheinsberg <david@readahead.eu>
>
> Looks good! Thanks!
> David

