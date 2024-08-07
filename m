Return-Path: <linux-kernel+bounces-277918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46094A822
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8891C2119B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27981E6744;
	Wed,  7 Aug 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkm+kXSN"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771641E3CBE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035424; cv=none; b=O0gk7q6G/IeyngLi6eTe/xv6M8sE6mlt2huTelyyAo5nRfvlF9lXJNMsImn84zupncc/PXzodz3qL5AX49uyRCw2GOpkeplVCxEsFA4swEgCZDfxpO7V9u0wKhP0PmjCSq+mOwqWLQncihCt6N0q9mFJ1Nax86fTVB+LjP/Tr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035424; c=relaxed/simple;
	bh=nJpscCloadqh8oMZ8Z0W5A/zIdjdqcBBFyeGvFf5Nbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EusZj62v6Wyen2ifiTjFNs9opt4Cb9zA/Z86Oa6FkGeJzzLMSzuBfI+8GI8nL+74B+twM0HHZ9QfN0irK4qkioo+dbV3neiqeesSmJWl3LUEZOill0PCztbH6aKjZ5uh3D4xw1qHomQBh9ecFtU3Zj18sfWK9/qk3KLB5CwVFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qkm+kXSN; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f52cc4d3beso633121e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723035421; x=1723640221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJpscCloadqh8oMZ8Z0W5A/zIdjdqcBBFyeGvFf5Nbk=;
        b=Qkm+kXSNcNXMB8uleNzNAFp5N316a+rwnlOg4wkUpH+6FRavKw2FR0l9qZasezINk4
         x06DC1IU4A5avjmQtZAtD4W0V2coq5Daest/fFn3a8tv6IrP4XssDi7Pz8owIkcQ3mUM
         J8QINGt8JEAzzdQsFup1J+6YN6yQO8rNQTYsPtg6+XKEnFB98Hy1ik1PSc+mSg+biI1v
         YaK3FkQ5JpPEzDkBWFT+ucyOZBJDBBd6XNLXgxz3S2dl6ytKopXkiqxWswk411JTi8it
         AFqh57Qzp9gD2WjIFx+YzZNkXvETBWXnC6M8WB1EIeY5vYNwk3NSVQ1rZbFR+9PkJAKn
         Bdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035421; x=1723640221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJpscCloadqh8oMZ8Z0W5A/zIdjdqcBBFyeGvFf5Nbk=;
        b=WtPXJ7XmMQAN4TfMloiw+XMB3G6F/fi8Yx90oMRTdPQUbTq8Lg8rhlibARuIZKURuY
         61sfw0NnkhMFrfqYgT12QscKrqm8yJ35Zu7Wc/uZu/GUibMguoU2elLIdEXjHX5wsU4p
         xiH5n2/RwF+UxUj4srzcTntx5jUXnimJd2ufSRfmuNKVV9GJBNCPjFMAPyXGJiZhgfGF
         AxrrCURwS60cPN7EI2Tzc4lYc0ZJ1DFwCkhdo37VYNAbdjGrIhtMX3hgW0FCUMYdd6gd
         lxJFC9Ph5ofgu0YrS+B5fhV8b0M+XUF8dR+p2gU1Eylckkk5YsGZd9Ig2MCjxl/Nxq6A
         P4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHksTV/ffev6BrOWMBlNSJBhObBKMhE3oCAnbOxmpNEgnXGzc44C7evPyMBjVlueyH7xXTjxRZzqZhk/nPAQHxEgAFZoE9ZzY16jac
X-Gm-Message-State: AOJu0Yz5JuA32lY7iCgP7sjC6lT7ZqNJCKt7yOu3nYZmYBspjHsB84NI
	KqeUc3YqhyZPij0miO+3DZ14KiWL1XE0rSOZ9NVOy/1Zjn72wjQWSUvm7EkpAqP0mpv7KarxYp2
	OIMJhvrbSBlZnWoRmfDURN4994BfhLR64
X-Google-Smtp-Source: AGHT+IEYAah/EMgChNzZm9pSyElexdonSDmvyzB7atB5dyepypRgydyIhkfCoiy4LJRNfV8utL00pKkpQ2knNe+u80c=
X-Received: by 2002:a05:6122:da0:b0:4f5:c90:2556 with SMTP id
 71dfb90a1353d-4f89ff63394mr20294960e0c.4.1723035421225; Wed, 07 Aug 2024
 05:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
 <CALmYWFuN5SxCrkFfgeP_uFThz-a=+VExjy2eqn5tQZSyaCjswg@mail.gmail.com>
 <CAKbZUD1BGV5PMwtGwN1kLHTa6=bfEztrcBW7onzSgxwAAgTjXQ@mail.gmail.com> <CALmYWFvyOCbn=ug77ma95ypjXnkV0tzStHWTz1mjpS+iKqK8ww@mail.gmail.com>
In-Reply-To: <CALmYWFvyOCbn=ug77ma95ypjXnkV0tzStHWTz1mjpS+iKqK8ww@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 7 Aug 2024 13:56:49 +0100
Message-ID: <CAKbZUD0ABKRuKUcBM+LWUwcDBc1eo61hHuP1xTk5Z8bUL8=qzQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm: Optimize mseal checks
To: Jeff Xu <jeffxu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:40=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrote:
>
> On Tue, Aug 6, 2024 at 5:49=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
> >
> > On Tue, Aug 6, 2024 at 11:25=E2=80=AFPM Jeff Xu <jeffxu@google.com> wro=
te:
> > >
> > > On Tue, Aug 6, 2024 at 2:28=E2=80=AFPM Pedro Falcato <pedro.falcato@g=
mail.com> wrote:
> > > >
> > > > Optimize mseal checks by removing the separate can_modify_mm() step=
, and
> > > > just doing checks on the individual vmas, when various operations a=
re
> > > > themselves iterating through the tree. This provides a nice speedup=
.
> > > >
> > > > While I was at it, I found that is_madv_discard() was completely bo=
gus.
> > > >
> > > Thanks for catching this!
> > > Is it possible to separate this fix out from this series and send it
> > > separately and merge first ?
> >
> > Sure. This series is definitely too risky to catch this release, so
> > sending it out as a fix (tomorrow, it's late here) sounds ok.
> >
> Do you mind if I send out a fix ? (I will also include a test case to
> cover that )

No need, I'll handle it before the end of the day.

>
> > >
> > > > Note that my series ignores arch_unmap(), which seems to generally =
be what we're trending towards[2]. It should
> > > > be applied on top of any powerpc vdso ->close patch to avoid regres=
sions on the PPC architecture. No other
> > > > architecture seems to use arch_unmap.
> > > >
> > > > Note2: This series does not pass all mseal_tests on my end (test_se=
al_mremap_move_dontunmap_anyaddr fails twice). But the
> > > > top of Linus's tree does not pass these for me either (neither does=
 my Arch Linux 6.10.2 kernel),
> > > > for some reason (mremap regression?).
> > > >
> > > I just sync to Linus's main and I was able to run the test (except tw=
o
> > > pkeys related test are skipped because I m on VM)
> >
> > Okay. Fun bug.
> >
> > I was really confused as to why no one could repro this except me :)
> >
> > It looks like recently[1] glibc started consuming the new_address
> > variadic argument when MREMAP_DONTUNMAP. As to the why,
> > MREMAP_DONTUNMAP also seems to take new_address as a hint (this is not
> > documented in the man page, and strace also doesn't know this).
> > However, this trips up some checks that were always fine before
> > (because glibc always passed NULL, and musl still does):
> >
> > if (offset_in_page(new_addr))
> > if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> > if (addr + old_len > new_addr && new_addr + new_len > addr)
> >
> > ^^ These all look at the address without looking at MREMAP_FIXED, and
> > return -EINVAL if they fail.
> >
> > So, test_seal_mremap_move_dontunmap_anyaddr passes 0xdeadbeef For Some
> > Reason (why are you testing mremap in mseal_test.c??), it trips up
> > offset_in_page(new_addr) in mremap_to, and we crash and burn.
> >
> > As to why no one else could repro this: I guess you're not running a
> > glibc new enough ;)
> >
> That makes sense, mystery resolved.
>
> I added sys_ functions for mmap/munmap/mprotect, etc, so that the test
> does not depend on libc, but I didn't do that for mremap, I think the
> fix will be to add sys_mremap as well.

I disagree, I don't understand why you're doing this test. And even if
you are rightfully doing the test, the test is wrong (and
mremap_dontunmap.c tests agree, and always pass 0 as new_address).
The manpage needs to be updated to reflect this, and this test either
needs the 0xdeadbeef removed, or the whole thing.

Adding a sys_mremap wrapper is inconsequential here, because you'll
need to decide whether to pick up new_address from the flags argument
and, if you do, it'll fail with the same error, but for everyone.

--=20
Pedro

