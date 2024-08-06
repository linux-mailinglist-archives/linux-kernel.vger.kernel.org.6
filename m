Return-Path: <linux-kernel+bounces-275537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A3B9486F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100DA1F23788
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B3A947;
	Tue,  6 Aug 2024 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2K1vJSa"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E93D7A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722907414; cv=none; b=e8UkGUDwenmV98gBrhZlTbnbz40YVIYgEriOxIbiF7aP3RGURUDg67AtZzF6R1dGQWNTGa6hZd34wCBgJtfv6gFoBUHv96O7KCa244dqWchV84DhwgixpU42iSIEKSq40dpBgyV4ORDoAVwAeYlHYVHKHt8nsERLXfsM5tHwaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722907414; c=relaxed/simple;
	bh=vA4qaSs5vwrQoFaoWs6qaP6dAmPJ7PdCG5HHaDna8EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cF/xYDFH+d8QbOC9j5+2doIMP3O3EMiGw9UbBE0Ralexi2qDNxEKr/21qpBYThTrnMfWrw5hDkfxklq7Ojlk016YalckEi0Npc9FRLEQjsyll1bWxK8WBd9j48AXDgHOo5La8WbDrybtq4hNUPjzk2zFts6MjWiwTE/5NtV7O8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2K1vJSa; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efdefce48so1476e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722907411; x=1723512211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2zr5Jw8aSSrppFuky4osrxPL34Y2hdQ6m0LCpom6O0=;
        b=f2K1vJSaR4TFJzpntUMJ8+7DmjtOLHYCBBpF5iXazjlCBjJkS3V90QGi10RVuzuhAt
         WuPvFsTTUgz399kxIYMcrtC0MnP2EUv4oTOVlagyfcotQvvBYGqqz9qiRoT2eZHt+XEu
         D+Qhu7OY5CdKu12j4WVvPGqrhNChX0nTrr70cNG6CJaYcAZuwujiZPFd4DTzmBuoo6w/
         Wb25DlCZsDjTwnWHO4hUd1GwErfcFMzr1H9lgPNMs+5BSS0O52o7zY7yPINm80JDGcfU
         Z+yfqcwSjhX1rS7SEWOG2v7lX6b74kHbDIL1M+4htNIO1XO3P0j8haZ2Zp14WEa23FqB
         oLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722907411; x=1723512211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2zr5Jw8aSSrppFuky4osrxPL34Y2hdQ6m0LCpom6O0=;
        b=NjwOcJCss+dQpBm0CokQXW8FiK+3mCz2AGaQ9Xs/EjE8iGaWyqC3clpQUgWYRnX3Xh
         msfFWRhFNCUrm5Y34+KT+8BQGfE+tZ9jNA1DXPlXs09Xz1MNmAU3iqEppHSWfHNeXMw8
         FvQIxeI/d67JM3/TcaKjoYSxditUO9v6d8ICNju3mcrdtiH2hM2UPo4qcbBUiWl1XuFL
         Z7BRDiqqJUvpri5OAuhoAfdNl86ZbCnq9K/YKmjEUGyosI3Z4CqJwq+LQqfcMdS5Or0W
         uBdeDze+qn9oyyoE/yGuBvWmLYTWRmNJVlOMChXOjm9N+aLqKY2JJK6xE6+DfJDfol6T
         1NSA==
X-Forwarded-Encrypted: i=1; AJvYcCVM9IM83Xu7YiBHvMMDWAWYhQwHuwLQmdz/KCNBXh3MxUSM4oLXO1Kpt9C+rECc0yXIW+vAkeas7byehDulihMCu19sudC1sioToWnY
X-Gm-Message-State: AOJu0YzJ+6XLwgpgVPhKNWFfqMEvlJU0CeJ7yM897VfrRKnWa/Ge52J3
	xjxNlTSsKTNg9QBGNeyEzFSvj2A2pLjofOMhGkt/mWq5Eo8jyBw7ZIOID4ewBjGvi8SSH2R1TRn
	E2wFv2dpBYqBQuljBNN5cTDMYbrPHcq0d5l/B
X-Google-Smtp-Source: AGHT+IHDKybFd7xjBRooCMWNn/w6NoQhtyT6dyera+RHZ8++MzQjx2qRg4C4mrmTqvpJKMndQwKboNUTLGvAKAJR9gQ=
X-Received: by 2002:a05:6512:b94:b0:52c:b243:cd02 with SMTP id
 2adb3069b0e04-530d593c470mr35192e87.1.1722907410501; Mon, 05 Aug 2024
 18:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
 <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
 <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com> <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 5 Aug 2024 18:22:51 -0700
Message-ID: <CALmYWFuXTd5qYLa=rEkoFbzSk07PjdKExgKsUkgMkT2E1Pjrtg@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:13=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 5 Aug 2024 at 16:25, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Can userspace on other archs not unmap their vdsos?
>
> I think they can, and nobody cares. The "context.vdso" value stays at
> some stale value, and anybody who tries to use it will just fail.
>
I want to seal the vdso :-), so I also care (not having it changeable
from userspace)

For the restore scenario, if vdso is sealed,  I guess CRIU won't be
able to relocate the vdso from userspace, I 'm interested in hearing
vdso dev's input on this , e.g. is that possible to make CRIU
compatible with memory sealing.

> So what makes powerpc special is not "you can unmap the vdso", but
> "powerpc cares".
>
> I just don't quite know _why_ powerpc cares.
>
> Judging by the comments and a quick 'grep', the reason may be
>
>     arch/powerpc/perf/callchain_32.c
>
> which seems to have some vdso knowledge.
>
> But x86 does something kind of like that at signal frame generation
> time, and doesn't care.
>
> I really think it's an issue of "if you screw with the vdso, you get
> to keep both broken pieces".
>
>            Linus

