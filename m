Return-Path: <linux-kernel+bounces-344410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B00498A93B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79E91F21999
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60B1940B2;
	Mon, 30 Sep 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnWkkvkK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD1194C86
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711727; cv=none; b=MeCCFfP0QOMvrP0mnzFjNByMDtJRcOdIlPTtqoAuEWdjBwHxSdPrn7Y847D5eZWuPNhQRe7qaubeaHPOupZowCNdzueiEX485OVeF0kFL2hWbKScQTIHdNm2B70ZuuZDldvxGTSEu+Sr0gy3D4rM8HDLt2b9Qnmg38JsM3k9xhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711727; c=relaxed/simple;
	bh=XtVyC1hr0DtWNi4Nuac6rbXEXeymJVGjtZRrIAKO+mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snINo8rcDwpUlJHU2poQfyUzwDUwhuJ3rqU7hybwFKIjkF1aefgPH1e12XSQuKdQ1Tw8uQ4eVHEwyyhEFcJcFB8JE5qokcTEtoRtLF4Ws7HJBWllQN6++qShOglYNgMihlFosDTSsAPN2HQLroZwkhz01umHAGb3WuYhTCBhBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnWkkvkK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso41549735e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727711724; x=1728316524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNK1EtvrtSuJZNw3V4pGuR2ZltFiSb+JZRUloyhSBAM=;
        b=DnWkkvkKeeF3KOdLGbhymraX5pB1qJIFb4ExFL70aVD0ycuWWnBcJxiU2NUDWZJqIz
         pO5Qa7fADTKnMuktCVxHn/ashZPUJHoC2cr20SShiuS+AGKMttCMj43QvRf5O4td17hE
         4Y6gYUbjTQegpR1HDAcWrwhIBDBU68fA36LYEhEaEmemRvrGoGbG3+JqYzwEdqlF2E37
         0QvEDw6RwZs2nxe7Gbcaf64Aorr6efdGeKuBrHmzczVMYiBElJRNkGhzRZwjeyZV4YQw
         mQhe08n3kMZtI315tzk635vMngKQPfVsewfh4Yn3wScFptJuWlrJZ0WOQeig2TJWOZzv
         RXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727711724; x=1728316524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNK1EtvrtSuJZNw3V4pGuR2ZltFiSb+JZRUloyhSBAM=;
        b=efKHzpkwyC6dlOvmW8iG9MdV6BF0yr7W2qOH12A/1lzPr+ATrAghtYjBQJVuciyiIZ
         LNSOcDso0g0Iz2KldSta5PKhkfSmequaE64g5b34NeYbhKvDHIKt9JdiWEa5cDN2t95Y
         rmNZen2w4VreDBmAjHQ7dWIJhL8BqtbFF/uRyLS1viNd51+VUQ8NLlqRzRbm+rR1vJum
         9m2nyV25YkhZNfRT4BujLi7BuClsw+4JJ0xfgXjzi+wnwUPmmvZAjnYGUipYa+tlr/+D
         w8wPSViWyA+kcWVJagJZQnm+ikkWJYyNhNZVBEKcpUoMiQmV0LZ5XPIbUJ2r7AO8P2vJ
         NOkA==
X-Forwarded-Encrypted: i=1; AJvYcCU4W5CR8uaxSd0rM3X3uPUwqQ94xJMl/74J7CnGiFZ6J15m8k1LdHIoVs8zXV/YnIcbluqNQU2QQUkSlx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdv2lM1kY4HnIbj4hIsacXHbs4gWpD1KQFzmDHGa+yNowweZy
	odcTR2KjJ7nAvPNn0lZfv7qbrxmDnpRHEp0nLAhO5/VcChqKvB0EM+UuT0QV9fCWHyQ5g9WmaDF
	3AZsjPaKOtvJwag6O/49WP5N/L5MKOjdyLFhZ
X-Google-Smtp-Source: AGHT+IFb7z0xdg6BY2AALOSh4J0RUQARy5JDY1gnkDZORwK5i5EF0tMyCsYhRRUNu3IzoyETf8svRp9h0k8sb7MnNRQ=
X-Received: by 2002:a05:600c:3513:b0:42c:c4c8:7090 with SMTP id
 5b1f17b1804b1-42f584335d8mr91991565e9.9.1727711723399; Mon, 30 Sep 2024
 08:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930144328.51098-1-trintaeoitogc@gmail.com>
 <20240930144328.51098-2-trintaeoitogc@gmail.com> <2024093044-violator-voice-8d97@gregkh>
 <CAM_RzfbJ5qsHKfNxV1EzhYEDdCmXP0THH=g1MX1yHiRP=9tYFA@mail.gmail.com>
In-Reply-To: <CAM_RzfbJ5qsHKfNxV1EzhYEDdCmXP0THH=g1MX1yHiRP=9tYFA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 30 Sep 2024 17:55:10 +0200
Message-ID: <CAH5fLgjMGwBNYkOEbiSLzQ5+G0gTz+gbvsRSoRsRizAETLpLeQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
To: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, mcgrof@kernel.org, 
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:58=E2=80=AFPM Guilherme Gi=C3=A1como Sim=C3=B5es
<trintaeoitogc@gmail.com> wrote:
>
> Greg KH <gregkh@linuxfoundation.org> writes:
> >
> > On Mon, Sep 30, 2024 at 11:43:27AM -0300, Guilherme Giacomo Simoes wrot=
e:
> > > This function increments the refcount by a call to
> > > "bindings::get_device(ptr)". This can be confused because, the functi=
on
> > > Arch::from_raw() from standard library, don't increments the refcount=
.
> > > Hence, rename "Device::from_raw()" to avoid confusion with other
> > > "from_raw" semantics.
> > >
> > > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> > > ---
> > >  rust/kernel/device.rs   | 2 +-
> > >  rust/kernel/firmware.rs | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> >
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent hi=
m
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> >
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> >
> > - This looks like a new version of a previously submitted patch, but yo=
u
> >   did not list below the --- line any changes from the previous version=
.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/process/submitting-patches.rst for what
> >   needs to be done here to properly describe this.
> >
> > If you wish to discuss this problem further, or you have questions abou=
t
> > how to resolve this issue, please feel free to respond to this email an=
d
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> >
> > thanks,
> >
> > greg k-h's patch email bot
>
> Yeah, I was think that only in 0/1 I should explain the changes ..
> I'm was wrong.   I'll put the changelog in 1/1 too.

You can use one of my patches as an example. E.g.:
https://lore.kernel.org/all/20240930-static-mutex-v4-1-c59555413127@google.=
com/

Here, the commit message itself has:
1. Motivation for why we should add global lock support. (To replace a
hack I had to use in the Binder driver.)
2. Explanation for why I implemented it in a certain way. (Why
separate initialization step?)

Then, below the --- line and not part of the commit message, I have:
1. Information about which patches it depends on.
2. A changelog and links to previous versions.

Anything below the --- line will not be part of the commit history
when your change is merged. So you should think about what people
would want to see when they look at your patch in the commit history.
They care about why the change was made, and why it was implemented
that way. What other things need to be merged first are not relevant
to people who see the final version after it has been merged.

Similarly, the changelog is important for reviewers so they can
compare with the previous version, but for people who just see the
final version, they don't care about which bugs you had in previous
versions of the patch. Of course, if you change the implementation
approach, then they might care about why you chose that approach over
some other approach, but that explanation should be in the commit
message (and the changelog should just say you changed the approach).

Alice

