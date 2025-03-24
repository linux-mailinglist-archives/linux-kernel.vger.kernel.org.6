Return-Path: <linux-kernel+bounces-574584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60547A6E727
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58ADF3B7619
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16CA1F0980;
	Mon, 24 Mar 2025 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpmUpssB"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945651C84DD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742857916; cv=none; b=Z/SEInxJ4poNLSU4Z1WS3tV3ixnFOfhHMXlSwcCuorlwYP+o7IRffD2ORbaoSldyxTH7g99BqF3vKtdsIyX6pxca+SFjObFVR57lW95DoGNmjfT8eFzkNHRkSMMeqxj/nxF3rW968l+hwEgznegKQU0AgvvCqB7hLQNurtq4Ihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742857916; c=relaxed/simple;
	bh=UVmRs3bYGScvrHgB+BGHT+iW8qVERiXQPeTLlzF5fmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8ZpxkivsJdCwNIAgUfZ8vx6BqjmpBYZMcX/z88YQlCWqd+QTJVjAVJPaJaWe3J/pNOVElj/53md4EC+zHvkKtKNU2U2/dEvZ770kTJlecZpa4mJ5Xi3uHOITeoffzXa2zDApVrvzb9eW2OcFL9zxNnJvBJbSXrw3UH3YX2qSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpmUpssB; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e904f53151so43996616d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742857913; x=1743462713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkj6QkECa4CD36kvKgGe9iRvn6HR5BzVpIl4rWm98lU=;
        b=ZpmUpssBLSOudSu0MvNaNQC+wJp3Q+ilJOJk4vZbFbTiYzLP2J/ac2Sqy+Nlri2lgt
         NuTNrHa8/Gk8z8cGrrU7rEBQzzql794SZRK6AVnVgQAbkAzD/zHhY9FwRlBt8K/fev1A
         TmfDkAOXUIArGi5JA0gCxBMHG6rSkXPCKwxPUZgRyQPO4WOsXcLNuibbt1bCnZUdz12/
         aDo6EjBvuLa/f54JkdqEB2FSie6aQcfA/hB9deupGsPgjV6gQudS3W+zNPK4c4mYRFvG
         4DXv5sabtISDWQ1rB3MAQPkSYLJsAvhbEFeu9iUb3Lb7acCIzxSqzB0gvx5dKj9/YNoh
         Ypew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742857913; x=1743462713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkj6QkECa4CD36kvKgGe9iRvn6HR5BzVpIl4rWm98lU=;
        b=HEsvGnHFJnnP6EMdr1NlyYFhPn2ZcyJnGYa6ZLsHlDQeEVDK1y7JLPVdiRe5YJeNbh
         Df+xyx+X1UjsDoXzSfE0mXiQ5LRrOMK0geCyQLmVfEHJW3mkZmNGXwoso1uDB2xxZOyY
         4K9dcK+XQmVYPqbR/RA/1RFef1Lkk9IpcWyhGhqKu8mdHOis0UXy+TCKdXS44a6mIuVC
         8fFXIwDWf2L12eYZpsxy2derRFXEWG4c3IrYeOcz9w9wLW/Ek6jVJIZvZLccQ/br2iZS
         9V33EYmBZpsoghN5yzjDQKtVKLxYRXHZGKyRU8kxlvpn38XPv9fz9aTz842oB0fGZ140
         GPVA==
X-Forwarded-Encrypted: i=1; AJvYcCWstaj2K8aHdGJqy9Jy0WAqOtFdSDwM9mYFXcJsC4tCvUk3N6Jeni+sl9dJODpim42Rqzt16NCsVxh5/C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgvs0e1y/PWsxqBhmhFeRfmxZNzvKKWa7CnjQVB++2iU6SOili
	bolbNgO2RtfqJqGsbvTGNccPQNSYOQlg2Q6U3SdJLIKDDbHoEmnieWWGSpyFKcprrVu0VqRO9tu
	38EOmi+zKDMPqVk3uPpkM6gGLXLpNdBEVmLT+IvtItBmuZsKQvPKTxm0=
X-Gm-Gg: ASbGncsCsSKkDqwCyjes4DTh7CrmMLyM60x3a3o7BWkr/3k+vVElskpNKzMj0pabEn2
	q6l2kd9PyHmzXyn4MAjvp5bhRvMvMnYLIwdrByhArGYKzkDddMJA7HaI/CCDr8ApokphgspjKR4
	Iw8oEiX9xay6WLZZZyIPoyB/iNlqtziUyEjJg3dgxV9mjWzesI+y/WIcaj84s=
X-Google-Smtp-Source: AGHT+IEJ1CeRLcj1VMqx3q3nImIKDIkeWrUnimMjMU822zMevgFAT/4fccs2gjd9TEPJdv7+7FVKXucqJ32FkY7ON9g=
X-Received: by 2002:a05:6214:21e8:b0:6e6:6ba9:9e84 with SMTP id
 6a1803df08f44-6eb3f2e89e9mr178026576d6.26.1742857913037; Mon, 24 Mar 2025
 16:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNASqYkDTPNo20Bj1knwsJMrp=nbQyh__=Do67eWq4CKU3A@mail.gmail.com>
 <20250318005900.2256921-1-elsk@google.com> <CAK7LNARA7_3W5CRhW+sKXuqdANjczVbaTO+y1tGTRzAxiJGUzA@mail.gmail.com>
In-Reply-To: <CAK7LNARA7_3W5CRhW+sKXuqdANjczVbaTO+y1tGTRzAxiJGUzA@mail.gmail.com>
From: "Hong, Yifan" <elsk@google.com>
Date: Mon, 24 Mar 2025 16:11:17 -0700
X-Gm-Features: AQ5f1JqRG3t3ca9Zcj8fijWJ_qWOAC6GoYQ2Bj0MsWhAIccheI5kcJd5jq9HCxA
Message-ID: <CAABy=s1JOV+5DjXMAz4DSkvO=xyVipkZE7HqcZ6eq612vxkn5Q@mail.gmail.com>
Subject: Re: [PATCH v2] setlocalversion: use ${objtree}/include/config/auto.conf
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux@rasmusvillemoes.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 8:15=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Tue, Mar 18, 2025 at 9:59=E2=80=AFAM HONG Yifan <elsk@google.com> wrot=
e:
> >
> > setlocalversion reads include/config/auto.conf, which is located below
> > $(objtree) with commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to
> > some in-kernel build artifacts").
> >
> > To be consistent, the setlocalversion script should use
>
> "To be consistent" is too weak because we do not add
> $(objtree)/ to include/config/auto.conf
>
> Just run "git grep include/config/auto.conf"
>
> You will see more include/config/auto.conf instances
> that lack $(objtree)/ prefix.
>
> So, "To be consistent" is not a reason.
>
> You described why Google needs to have this
> specifically scripts/setlocalversion.
>
> Without that explained, I do not understand _why_.
>

Without the context of Google's out-of-tree patch, I can't really
think of any good reason other than "To be consistent". Would it be
better if I quote
https://lore.kernel.org/all/20210121213641.3477522-1-willmcvicker@google.co=
m/
("[PATCH v6] modules: introduce the MODULE_SCMVERSION config") in the
commit message, explaining that "prepending $(objtree)/ is required
for this other patch to work"?

>
>
> > ${objtree}/include/config/auto.conf as well.
> >
> > Signed-off-by: HONG Yifan <elsk@google.com>
> > ---
> > v1: https://lore.kernel.org/lkml/20250312021154.102262-2-elsk@google.co=
m/
> > v1 -> v2: fixed the other two locations of include/config/auto.conf in
> > setlocalversion script; also removed incorrect claim in commit message.
> >
> >  scripts/setlocalversion | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> > index 28169d7e143b..c13fe6e585e9 100755
> > --- a/scripts/setlocalversion
> > +++ b/scripts/setlocalversion
> > @@ -186,16 +186,16 @@ if ${no_local}; then
> >         exit 0
> >  fi
> >
> > -if ! test -e include/config/auto.conf; then
> > +if ! test -e ${objtree}/include/config/auto.conf; then
>
>
> Please quote
>
> "${objtree}/include/config/auto.conf"
>
> to avoid a shellcheck warning.
>
>
>
>
> >         echo "Error: kernelrelease not valid - run 'make prepare' to up=
date it" >&2
> >         exit 1
> >  fi
> >
> >  # version string from CONFIG_LOCALVERSION
> > -config_localversion=3D$(sed -n 's/^CONFIG_LOCALVERSION=3D\(.*\)$/\1/p'=
 include/config/auto.conf)
> > +config_localversion=3D$(sed -n 's/^CONFIG_LOCALVERSION=3D\(.*\)$/\1/p'=
 ${objtree}/include/config/auto.conf)
> >
> >  # scm version string if not at the kernel version tag or at the file_l=
ocalversion
> > -if grep -q "^CONFIG_LOCALVERSION_AUTO=3Dy$" include/config/auto.conf; =
then
> > +if grep -q "^CONFIG_LOCALVERSION_AUTO=3Dy$" ${objtree}/include/config/=
auto.conf; then
> >         # full scm version string
> >         scm_version=3D"$(scm_version)"
> >  elif [ "${LOCALVERSION+set}" !=3D "set" ]; then
> > --
> > 2.49.0.rc1.451.g8f38331e32-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada

