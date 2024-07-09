Return-Path: <linux-kernel+bounces-246562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A45F92C390
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1AB1C229A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26140182A54;
	Tue,  9 Jul 2024 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sa5BsQzN"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB7180057
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551488; cv=none; b=LHNTo4Bgxw2e55TwLzYnWeMtwE1lz7tvfShVXMMTCw+JAGlFp+k2h1c3ntOYXJXTKoiAd5T2vIu/xbHWjHSPmpjJcLLDPFn4y4VSWC2o890OetP/lrnhBAKx/J89gVoe+r180GFIuLikRdInBQyu0v680l1CKdn4vgWu4WInSrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551488; c=relaxed/simple;
	bh=vgV3NNlzFKCiU3pBnrqOOxg16OSb3pUQ2G39Zbsbj1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFhEgNQwgJhNx8bJl5QMomKvBxjJSiNMYvipVgQLisb+nDInPgHILIo19EUGwMfjFQiqTBffLFNEIWL1tnHjvCRuju4cTH3LM/dxLV5nhdg4BmxW/Qm29OKb4dK61V4zpPvJyj1p9ynvlH7NDWHCDG9m1cq7LKMttmDdf4SGXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sa5BsQzN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso2301a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720551485; x=1721156285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAoQUSx9bhpcdjQTt+qmhPqP+zZAnIGtZqlOI0lzq4w=;
        b=sa5BsQzNzOOcSPF9OfoPAP207D5WndvlKepdTyJgMU8ybS4vX3ZOPl+9Hv9bzFYd/O
         XhaQdi6jl9KabAjFmVJT8ItjVBtHJhFYGNkFIJZAQTWcyc5lxNQ7lzhHoEgbuK4Le8Kn
         LSnYsZf0vlgpQjnhSd+7pwu3h0XC9zqEL3yh91FGpwDnsCCrlx/5AyS9jPRaavA2mdr7
         Bs5ySs7DjRQh+5GI+qbRdsHbr9bLvoDiG04oRQtVA+5Jj+WPw2rOBgoDQfdT4C+vJvP2
         dHDu3dewG3VaQZ06i/8DQUpQSAJOPqWpMXqneQjVwK8KmQJdt8sOpr1BKZYaJafXcPQ8
         HSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551485; x=1721156285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAoQUSx9bhpcdjQTt+qmhPqP+zZAnIGtZqlOI0lzq4w=;
        b=eL62Rtmgusd5vYqywBuji6sTx9mYxOYBJsBSUTEN0WLSH8FyoY8yqOXBg94SQgsdoz
         +K/bxUpBTNwgL457Kjw2r/6Iurks3HCTmT+PEF6+xUl+fDeWdlOoN/oA4yoWtFCem1uR
         f0lquDWYJkHnraimBkI3ZcrwxGzdYmGqHor7xBPV38ufGnmBYWDGWuaRyrtHVB5GmGwO
         BipNsK1COm3oYE3fEf+8F7rAQyiBiLvMyTlyLx5A4YMKbjWgHyyiVxGiRYL9prBc0cbq
         F7C5pgqYMcNVmaWR7azeFE+uChsUK2FxJDjBbZSHNWsR+YpZAscrQYSvMcM0F6IxFFxO
         rjlw==
X-Forwarded-Encrypted: i=1; AJvYcCXLX46MzDPUci/6eVVrvKMi/tLHWOWv4Gu15KgGgDOBUoEHgIfpOLCIvWKnfZYpHOltl96SCkf/uZQJnlsND0s3pWRghhP7b+2Aq7S4
X-Gm-Message-State: AOJu0Yw2VgfJMhEW22lx3iogvgh5A6Cfbfx6wNfYxk1gxnOE9qi+OPDR
	V8aGT1cqjypt02qybVqQu86E9f73lyg0UIDEqvdEqqoJxHWm5piIXJ3jTsniTMFJth0nxPnEn9k
	CsE6KWCGCilxMTpyd3Tkb//IG04osVEf0orAK
X-Google-Smtp-Source: AGHT+IECwTUCWfNd/m0r/4U5ddqq9szdLi7Tw8glyBT6PX7+eYxwo4Ic0ZuXywbnuTJaGnFDZBWSOOJzFKOrzR9sUWE=
X-Received: by 2002:a50:9f84:0:b0:58b:dfaa:a5ca with SMTP id
 4fb4d7f45d1cf-596d4daf533mr28844a12.6.1720551484754; Tue, 09 Jul 2024
 11:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com> <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
 <87ed83etpk.fsf@oldenburg.str.redhat.com> <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
 <87r0c3dc1c.fsf@oldenburg.str.redhat.com> <CALmYWFvA7VPz06Tg8E-R_Jqn2cxMiWPPC6Vhy+vgqnofT0GELg@mail.gmail.com>
 <20240709.gae4cu4Aiv6s@digikod.net>
In-Reply-To: <20240709.gae4cu4Aiv6s@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 9 Jul 2024 11:57:27 -0700
Message-ID: <CALmYWFsvKq+yN4qHhBamxyjtcy9myg8_t3Nc=5KErG=DDaDAEA@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 2:18=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> On Mon, Jul 08, 2024 at 10:52:36AM -0700, Jeff Xu wrote:
> > On Mon, Jul 8, 2024 at 10:33=E2=80=AFAM Florian Weimer <fweimer@redhat.=
com> wrote:
> > >
> > > * Jeff Xu:
> > >
> > > > On Mon, Jul 8, 2024 at 9:26=E2=80=AFAM Florian Weimer <fweimer@redh=
at.com> wrote:
> > > >>
> > > >> * Jeff Xu:
> > > >>
> > > >> > Will dynamic linkers use the execveat(AT_CHECK) to check shared
> > > >> > libraries too ?  or just the main executable itself.
> > > >>
> > > >> I expect that dynamic linkers will have to do this for everything =
they
> > > >> map.
> > > > Then all the objects (.so, .sh, etc.) will go through  the check fr=
om
> > > > execveat's main  to security_bprm_creds_for_exec(), some of them mi=
ght
> > > > be specific for the main executable ?
>
> Yes, we should check every executable code (including seccomp filters)
> to get a consistent policy.
>
> What do you mean by "specific for the main executable"?
>
I meant:

The check is for the exe itself, not .so, etc.

For example:  /usr/bin/touch is checked.
not the shared objects:
ldd /usr/bin/touch
linux-vdso.so.1 (0x00007ffdc988f000)
libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007f59b6757000)
/lib64/ld-linux-x86-64.so.2 (0x00007f59b6986000)

Basically, I asked if the check can be extended to shared-objects,
seccomp filters, etc, without modifying existing LSMs.
you pointed out "LSM should not need to be updated with this patch
series.", which already answered my question.

Thanks.
-Jeff

-Jeff

