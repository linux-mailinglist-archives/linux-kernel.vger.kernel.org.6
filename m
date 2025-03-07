Return-Path: <linux-kernel+bounces-550758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C8CA563BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9511D16A205
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE8201010;
	Fri,  7 Mar 2025 09:28:29 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375C1FC0E3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339709; cv=none; b=qvQiAtK4r432m+G6JKIR8nU7M7AxjaQQs6EDdC4QI0O+/f1Dyex2QGvUZQWRp062MNo71srLGHQJ5peKLJtEKl8e4ozpLOftQTjYYK7NmF8PkL3/BaJ2+W2YNqUU5jsl3a0/Qc68UXr0Ztu8W7r+tT0Y7Zjaw5qEC9wIPsW+Hjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339709; c=relaxed/simple;
	bh=BN+8eHwcafa3VqJK7m3MNsMWlXODH7acNS4IpcPbG1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nK9vZnrJw6DKXbNLiNJJxCh98GaW/wpmvX6g2wDMB8oCo4hTUuoeyr3ST2OKyaT+rX+rdKLX7fH7Gcya5F15uH+65uTTaG46bebcFyoKOD5rsZQ7XEeTzNtNxJ64AFG1BM/x1t46U1w7FXm1uNo6qW7cJ4tPdG7dC4Fp8iSpQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523dc190f95so645243e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339705; x=1741944505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoQKfUSlRz0+YvdMZUS1l/LJsywoVzRWedSGJvmjWs8=;
        b=Y39ilsDoNmC0KRastxb5Zc4Dfme16gOBLA93mFGXC8RhqIg0VJdayvaNcheWybh+3Y
         Y+p3oimwv3RTBoMoxkR9Pzsa7FlO1N7SEetUOzb6sWd58i4VEXBKWtLUHCr7rz9DuJRK
         5nn3fRLeoq0yS6hw4RKKM4Ywy1i/jaSYP5lC5UpMsycKS66BiAaRUM2Hs+VxpkxPvlGl
         t0hwaupZIc6sf68ro8z8B0jgI1Qu1ZYhJz6G2QuZbm0n2E3GqwKP7AcxKJ0ZGDdMNts5
         kSsxQ70wfVGpI3zb6yWONI17kz6iilSBCFCnDsRECV9MCzNgOFqJ1S+qQKd6QmJ8HNyp
         j4+A==
X-Forwarded-Encrypted: i=1; AJvYcCVhQz7CwY+xNxKorGaqcQYWt0X3J8FDHFhNHh5C2+9G+CoI7LuR5UixcQqkfjcICahENtiQ43aU6OeCLsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nFZug20U51/MSjFNhSS9ITUfRiAOHvnkggDXiwH+lWVMOMVd
	1EmkkFrY9acy/jaremz5YILr1XMgy3w2U3ImpP4sih0hvmGIYXGhNzKa46uTiPY=
X-Gm-Gg: ASbGnct5spVWOzOyqQpT6Vd23XOZZPcagvaPUPp1iwXxltJTAbeZqp5aksSTy1Kdhwc
	NSroSKcOp2UU/6mjqF1YBSXQkqwI6J/SPcuFiJQUuij/USnWZ9BQQLbV6EC7g/4MFW5UkAnQUD+
	wHCmXvOF8CAhjEf9joFbDvqegHxwAAkgMmMfGM4mOQpYgFFCf+zEXcrRi1xZjgTptNHUjKIUDpl
	6afdEWCqT3BBs8eWEtBOtBaszUIEhzItkH/s0ga4GGPap0r3XRWc4VptcRJbTZU93pizvrVIpTO
	ibsnT0qBUr2G8RL1Aw15lg+kpvbiOo8NSXsw3GNU5ixDm+3EE/Mvgmat3C5kED5hRavdiXNcp3N
	ZgoEdwQA9HZM=
X-Google-Smtp-Source: AGHT+IGcOzfxIMf9zClyoXgWlFgqEIqjhu+ED+n9m6MJHmioov6bcinvVbpPkFss9ZW9wFYSgIgCtg==
X-Received: by 2002:a05:6122:c86:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-523e4138662mr2144227e0c.2.1741339705457;
        Fri, 07 Mar 2025 01:28:25 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523ed215797sm23743e0c.39.2025.03.07.01.28.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:28:25 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-52378c0c2b1so749420e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:28:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlKDcqj2DTzd3oTXrV1oQvXKOxQQD4M2/cp4HGQET3XYHyHBgFy9iJxWBn1Ymc0q6Mymvx7ivo3zfZojg=@vger.kernel.org
X-Received: by 2002:a05:6102:3c9f:b0:4c1:86a7:74e9 with SMTP id
 ada2fe7eead31-4c30a5abef0mr1501844137.10.1741339704649; Fri, 07 Mar 2025
 01:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302230532.245884-2-thorsten.blum@linux.dev>
 <CAMuHMdUonC54g-XSt-EkNbEGxhkOWMxBc87Qtw0MyeXoPqDD4A@mail.gmail.com>
 <e5e10808-5cca-243b-304f-4aa8db1d30b6@linux-m68k.org> <CAMuHMdWjOkUXy+jf0yghs2_SQM3UWY3e8or3T11=fXYYD-VJEw@mail.gmail.com>
 <dd1425d0-6d46-86a7-b508-ff0a646d61c0@linux-m68k.org>
In-Reply-To: <dd1425d0-6d46-86a7-b508-ff0a646d61c0@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 10:28:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX=2FnC1OzxcQp4RMG=Bk3aiQ4OprYjLde3qUP6XH7yog@mail.gmail.com>
X-Gm-Features: AQ5f1Jolhp06vsDYkRjEdux0qCD5TaknfsVx0Aii3j3HwQ68d1rTYnRPVv095nY
Message-ID: <CAMuHMdX=2FnC1OzxcQp4RMG=Bk3aiQ4OprYjLde3qUP6XH7yog@mail.gmail.com>
Subject: Re: [PATCH] m68k: mm: Remove size argument when calling strscpy()
To: Finn Thain <fthain@linux-m68k.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, 
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

On Fri, 7 Mar 2025 at 09:58, Finn Thain <fthain@linux-m68k.org> wrote:
> On Fri, 7 Mar 2025, Geert Uytterhoeven wrote:
> > On Fri, 7 Mar 2025 at 00:24, Finn Thain <fthain@linux-m68k.org> wrote:
> > > On Thu, 6 Mar 2025, Geert Uytterhoeven wrote:
> > > > On Mon, 3 Mar 2025 at 00:07, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > > > > The size parameter of strscpy() is optional and specifying the
> > > > > size of the destination buffer is unnecessary. Remove it to
> > > > > simplify the code.
> > > > >
> > > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > >
> > > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org> i.e. will
> > > > queue in the m68k tree for v6.15.
> > >
> > > The commit message says "simplify the code" which is only true if you
> > > never scratch the surface (i.e. it's simple code if the reader is
> > > simple too...)
> >
> > The code is simpler in the sense that the API is simpler to use, and
> > harder to abuse (i.e. to get it wrong).
> >
> > > Commit 30035e45753b ("string: provide strscpy()") was a good idea. It
> > > was easily auditable. But that's not what we have now.
> > >
> > > Patches like this one (which appear across the whole tree) need
> > > reviewers (lots of them) that know what kind of a bounds check you end
> > > up with when you ask an arbitary compiler to evaluate this:
> > >
> > > sizeof(dst) + __must_be_array(dst) + __must_be_cstr(dst) +
> > > __must_be_cstr(src)
> > >
> > > Frankly, I can't be sure. But it's a serious question, and not what
> > > I'd call a "simple" one.
> >
> > All the __must_be_*() macros evaluate to zero when true, and cause a
> > build failure when false.
>
> It seems to me that the code review problem could be solved either by not
> churning the whole tree, or if we must have the churn, by short-circuiting
> the recursive search by reviewers for macro definitions.
>
> Can we do something like this?
>
> sizeof(dst) * !!__must_be_array(dst) * !!__must_be_cstr(dst) * !!__must_be_cstr(src)

x * !!0 = 0

So either the above should be changed to

    sizeof(dst) * !__must_be_array(dst) * !__must_be_cstr(dst) *
!__must_be_cstr(src)

or all __must_be_*() macros should be changed to invert their return values...

> At first glance multiplication appears to be safe (unlike all the addition
> terms that we have) because the limit of the string copy is either
> unchanged or zeroed.
>
> Yes, I know you said "zero when true". That looks like another design flaw
> to me. But maybe I'm missing something that's more important than
> readability and ease of review.

We had

    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
__must_be_array(arr))

for ages...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

