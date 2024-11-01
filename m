Return-Path: <linux-kernel+bounces-392679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7799B96FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1487E281F3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D31CDA35;
	Fri,  1 Nov 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dXNERkzy"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656B45016
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483969; cv=none; b=mNM0YYJToEluqMnqxK2/xrUKMV7EujUvHu5HbGW39OP6Li5/ge9fnN1RLYnSTYPgaCNkJaO4jWP81t58v3onabbFCVpxv0/HKspslhznspQi/2+Zfr+ImJ7q2vR3RXNeIhRu5tWCEcIYM8jQN3QZX/VvGLPdsjr3sT6snd7TehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483969; c=relaxed/simple;
	bh=UbgaeArJxEeaLS8DCoPVLztbE9TSjYcjzodPBB5CarA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlHwcRjreQXANn14j177yat3W7tl/wr412ZmLSE3t+VKaKNzZqDeIU/gF61bbIJbpjNtLug5AuZF9fjqTfOmPGi/sh4kIHL9UJoCN+uTkweG8NcGhhjg/iF15zkdHQgoUF7nbeSrOMXfrRAHFL5MLIgf7cdUDYujDIsNYR6f/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dXNERkzy; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so2094960276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730483967; x=1731088767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHFTRHafBa+64JSQGkZJwqdhjQhl87yn+cc0CQ/Umeo=;
        b=dXNERkzyvJTx49ZaXU39Z4k9AafyfxXEkZXUxRto3I87UECsQVq4n1BLWZzpHbSXT9
         /zHdx5yBqFPak9s687VX47s4/CiNjUD4OVbyfZ1uNfhQGDJjpaKACEzHi2FM/q2zK3Ul
         C7NHXxj6kFEGo0xI9T4uzitaSZcbmhRoXN17hlzA/ON4cWRhqMHJ0b+So9Ookc5z5zb2
         UPFl8QdsGsL0X40Nhh5yNNZO8HAInCjWXMORLX/lAlovqQ7bt2XF0/yy/edzk0t/UbDx
         pbLr1+lx/61tAHPMV50jvOi0snThkIOIOEnmHK3OItSV7WBw6iOiGshQC6BTvOKhtlSu
         sPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483967; x=1731088767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHFTRHafBa+64JSQGkZJwqdhjQhl87yn+cc0CQ/Umeo=;
        b=f36vFYctFDzmuV69MkvGPd449IVpSRWMCa7ehbLzxCC9Zi059d4oNMdWHMQRMj1ZXC
         26iDxZCwcdtqdGUXHrq9uJnneZVfj66Q75fm5ifV9VvQPYBjuLH9ggXPm6AgcQNgtg52
         6M7yeLTOgN2d/dRpfb2OcJqH2ks9cd/8bHITAj7NkR6R99qqy8WybjAZqlbzNTS7TaMg
         CK8LyDLNYtTQQYCuZbjlJvManAToiHvVe6uiZ0t/RXxGvhKOR9ESaDxrfZg5WZdXl4Cr
         W3FhKmVB3n6+zuZTjCXRb/1boVIiODMAFj4TZowhsS8OxvVJsP3AzGrOxzpESl3nw7K6
         IzNA==
X-Forwarded-Encrypted: i=1; AJvYcCWUnTGZLzA30BH9BsqszL71zceMyL/rVpHd1u7FRvn99SNs3oZQ1lugeB8pYULFU/xFqLDRsHMQy7L8lrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7vJooC0FQBObSmMI47b+WF2Da5B/hnMaEwygiWYdWspZve7t
	bfiFIuHqQAameW+nDpX2GCZbKPxOrJipv72ITXVO00AS7gXl0CTgopz1pBWBUSbUbMpUwbmHUJH
	lTd2fMNc0EIeTLFBfAPL7UWiNHqCN4ohWFkLQ
X-Google-Smtp-Source: AGHT+IEYCapNRD7ztbrSnudiiod9EpcctaQvgweIgnYm1vysGZdSjWf1HTc6ccTjHniL5WPjg92cjXpUQU0GOISoNXs=
X-Received: by 2002:a05:6902:2505:b0:e2b:e0ba:d50 with SMTP id
 3f1490d57ef6-e3087a48a2emr20973638276.5.1730483967029; Fri, 01 Nov 2024
 10:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
 <20241101095620.2526421-1-aliceryhl@google.com> <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
 <CANiq72kcvpEqpwFTNFmxfJsfBMeBNiDrrvFBf_iS7+ozaECJzw@mail.gmail.com>
 <CAHC9VhTQMo11s7mWg=zzDusJompOp01uJat-q9HjQCoEWzHRRQ@mail.gmail.com> <CAH5fLgi+JJHCA_XTPC0-kaacZC6=aGSa-+DiNt06GSJNFhKc3w@mail.gmail.com>
In-Reply-To: <CAH5fLgi+JJHCA_XTPC0-kaacZC6=aGSa-+DiNt06GSJNFhKc3w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 13:59:16 -0400
Message-ID: <CAHC9VhSv+ro9gOzanvPS1gZwLkqO7ZoZk7SOZ64FP+-sdmYs2Q@mail.gmail.com>
Subject: Re: [PATCH] rust: lsm: replace context+len with lsm_context
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, naresh.kamboju@linaro.org, 
	casey@schaufler-ca.com, anders.roxell@linaro.org, arnd@arndb.de, 
	brauner@kernel.org, dan.carpenter@linaro.org, kees@kernel.org, 
	linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, ojeda@kernel.org, 
	regressions@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, lkft@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:24=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> On Fri, Nov 1, 2024 at 6:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, Nov 1, 2024 at 1:04=E2=80=AFPM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > On Fri, Nov 1, 2024 at 5:56=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > >
> > > > Thanks Alice.  Would you like me to pull this in via the LSM tree w=
ith
> > > > the associated LSM changes, or would you prefer to do this some oth=
er
> > > > way?
> > > >
> > > > I'm going to merge this into lsm/dev for now so that we fix the iss=
ue
> > > > in linux-next, but I'm happy to drop it or do something else, let m=
e
> > > > know.
> > >
> > > Christian has the VFS side, and both are needed for this -- do you
> > > mean you will cross-merge vfs' branch too?
> >
> > I think our last emails crossed paths.  I'm not going to merge this
> > via the LSM tree as we don't have the Rust security.c helpers.
> > Ideally it would have been better to have the Rust LSM/security
> > helpers in the LSM tree for reasons like this, but it looks like it's
> > too late for that now.
>
> If Christian is okay with rewriting the vfs.rust.file tree, we can
> drop commit 94d356c0335f ("rust: security: add abstraction for
> secctx") from there and I'll update it and send it for inclusion in
> the LSM tree instead. I'll need to drop the piece that ties together
> `struct cred` and `secctx` from the patch, but I can follow up with a
> small patch for that for the 6.14 merge window.

I can only guess at what Chrisitian wants to do, but my guess is that
he isn't going to be very excited about rewriting a VFS tree at this
stage ... which is very understandable as far as I'm concerned.

I wouldn't worry too much about this right now, I'm going to plan on
holding Casey's patchset in a staging area until after the upcoming
merge window.

--=20
paul-moore.com

