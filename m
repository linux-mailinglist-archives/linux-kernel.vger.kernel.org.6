Return-Path: <linux-kernel+bounces-277168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D9949D6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B2DB232EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610915B98D;
	Wed,  7 Aug 2024 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pm9xirf0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C2B77F1B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722994813; cv=none; b=feGJfVlV0PUG9NGUM9peiQWDzrMSk17KKKehRPbRJrqdCsrHms22YdWPY9eF+DWq3AraeGIqP7dSz2XFZaNp46lMHAGM4oK5W9LzA/7cweTgKm+0pFtKiZ3dBFsa7daRFcHvr5z1AZpDfUsoIbtn8fRYgEoK8BAsTWyBzu92Vts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722994813; c=relaxed/simple;
	bh=GE3beB/OtRtOBMaV1ksbJHBWmrc70bMxxYhwQZCfzmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZMJtRAWkmmHLma9FOEbiQv+o52CcBpXXPNWVqQcr6h9Z37gu+f+4KsKnQLTlKAyw0a5DwjkbPiJhtrjGCJ5grhQkZI87QhK2/VmqHv3Ed6SI2x7S+HrRjzBaqovSA4MRogJAJ41zFI/mZwEDdLw1CL8DvgEsed904cQyyaQAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pm9xirf0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso112065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722994810; x=1723599610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE3beB/OtRtOBMaV1ksbJHBWmrc70bMxxYhwQZCfzmc=;
        b=pm9xirf0g2+Qi/B5ODTKy+BrmNSKYnRvhgEACs12oZXucjc75lkJBKFUtPiTtizPID
         K7X+98TF7YXVVkWZ+pku1HTCC2qb56cHFJpx8SUHxgyiCT7KlNQlJy0EdUa4D9qsFHri
         Q9bCGKsIRi6cK4KY8w954L94k1KZRORANobg3unwGpynU/iIRE/zIUbY/Zr5uhoHzCQg
         wse+O/H8qTyCIhZWJvn8EbVpejlFKylbYGFWM5d2Xp/eznNLQMP6RwbJXyU/x6sV3scZ
         fSQuDXrpe3IgzLqV089zaowiGTh3euYWktHK0Q41Eioj8sGfsysdFYWlg1ztnFlvEp98
         LF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722994810; x=1723599610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE3beB/OtRtOBMaV1ksbJHBWmrc70bMxxYhwQZCfzmc=;
        b=rIBRSf1seEeERwHHXAsebwsXYWNG4GB8ltIPmY3zCnmbpkY25pd+Otc9sF5/zK7tOr
         ZTgt4bQTrtcnRMKr5u+q4WX32d8nynHyOzyLMnGoMO4KImXSwxI85b6fvZzN4bp9Z4wx
         q1Z+/2NrffgI9xr1IplHsBATbnzEy2ZYnW/xMcLUihz1xYB4BR4hin296g8fijqMo+t1
         B1clVf5sNm4VLTUH4SoYIuiyUEbqXjF6a0XEbzF9fBBNpiuEGDYTjYFMnnRqI3M+26W+
         nRz3Dv7PcuRzR1HDASInJtVrLYvq+juQHLQXKWcMSaNbGygS+uwfDrx+jsDAkeKVqGFv
         tNVw==
X-Forwarded-Encrypted: i=1; AJvYcCVTDcVqx+s311ZheAGCB0L1pyS2ulLlOPsiBMqxPqAjGyKQUir8Ym8jkHj8D9Lknh1loT6uEvJsd9zWq2O6Eh46UAIsykGv/Mm7tcbx
X-Gm-Message-State: AOJu0YzWdVOzk2h5vX4Gz94jweHY7Va8z/pjix639pzNKNXGWUDniI5T
	K8uC5RU5s+VC2RxSJdKc/ai5dV2F7zcsd14mRiOMZAs5fzTSt5uB1RNs3Y+GhYDG67e8uy1MpWA
	DhD5E0oUoyN+YNHNLlgbVKTBdKjWl98El5+ez
X-Google-Smtp-Source: AGHT+IEz6ZL7fr26XrwTqBNgl+nGGCZAsB/XUqmfxUqQppZX/39no1JISlGP6uMZim9fjfj4Qeq8llntoqvWa+d403M=
X-Received: by 2002:a05:600c:3d87:b0:426:66fd:5fac with SMTP id
 5b1f17b1804b1-4290508ce7fmr517295e9.2.1722994810042; Tue, 06 Aug 2024
 18:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
 <CALmYWFuN5SxCrkFfgeP_uFThz-a=+VExjy2eqn5tQZSyaCjswg@mail.gmail.com> <CAKbZUD1BGV5PMwtGwN1kLHTa6=bfEztrcBW7onzSgxwAAgTjXQ@mail.gmail.com>
In-Reply-To: <CAKbZUD1BGV5PMwtGwN1kLHTa6=bfEztrcBW7onzSgxwAAgTjXQ@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 6 Aug 2024 18:39:32 -0700
Message-ID: <CALmYWFvyOCbn=ug77ma95ypjXnkV0tzStHWTz1mjpS+iKqK8ww@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm: Optimize mseal checks
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:49=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Tue, Aug 6, 2024 at 11:25=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote=
:
> >
> > On Tue, Aug 6, 2024 at 2:28=E2=80=AFPM Pedro Falcato <pedro.falcato@gma=
il.com> wrote:
> > >
> > > Optimize mseal checks by removing the separate can_modify_mm() step, =
and
> > > just doing checks on the individual vmas, when various operations are
> > > themselves iterating through the tree. This provides a nice speedup.
> > >
> > > While I was at it, I found that is_madv_discard() was completely bogu=
s.
> > >
> > Thanks for catching this!
> > Is it possible to separate this fix out from this series and send it
> > separately and merge first ?
>
> Sure. This series is definitely too risky to catch this release, so
> sending it out as a fix (tomorrow, it's late here) sounds ok.
>
Do you mind if I send out a fix ? (I will also include a test case to
cover that )

> >
> > > Note that my series ignores arch_unmap(), which seems to generally be=
 what we're trending towards[2]. It should
> > > be applied on top of any powerpc vdso ->close patch to avoid regressi=
ons on the PPC architecture. No other
> > > architecture seems to use arch_unmap.
> > >
> > > Note2: This series does not pass all mseal_tests on my end (test_seal=
_mremap_move_dontunmap_anyaddr fails twice). But the
> > > top of Linus's tree does not pass these for me either (neither does m=
y Arch Linux 6.10.2 kernel),
> > > for some reason (mremap regression?).
> > >
> > I just sync to Linus's main and I was able to run the test (except two
> > pkeys related test are skipped because I m on VM)
>
> Okay. Fun bug.
>
> I was really confused as to why no one could repro this except me :)
>
> It looks like recently[1] glibc started consuming the new_address
> variadic argument when MREMAP_DONTUNMAP. As to the why,
> MREMAP_DONTUNMAP also seems to take new_address as a hint (this is not
> documented in the man page, and strace also doesn't know this).
> However, this trips up some checks that were always fine before
> (because glibc always passed NULL, and musl still does):
>
> if (offset_in_page(new_addr))
> if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> if (addr + old_len > new_addr && new_addr + new_len > addr)
>
> ^^ These all look at the address without looking at MREMAP_FIXED, and
> return -EINVAL if they fail.
>
> So, test_seal_mremap_move_dontunmap_anyaddr passes 0xdeadbeef For Some
> Reason (why are you testing mremap in mseal_test.c??), it trips up
> offset_in_page(new_addr) in mremap_to, and we crash and burn.
>
> As to why no one else could repro this: I guess you're not running a
> glibc new enough ;)
>
That makes sense, mystery resolved.

I added sys_ functions for mmap/munmap/mprotect, etc, so that the test
does not depend on libc, but I didn't do that for mremap, I think the
fix will be to add sys_mremap as well.


> [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D6c40cb0e9f89=
3d49dc7caee580a055de53562206
>
> --
> Pedro

