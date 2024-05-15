Return-Path: <linux-kernel+bounces-180197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB608C6B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB1A1F24145
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A93B2A1;
	Wed, 15 May 2024 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KSVXwOoB"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E024C3CD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793513; cv=none; b=FlghVU5Y3IXCowZo/SezpDzoIX5cBSISDmECB5ikGyYo6mWUWKVu1NIT15m9VJSQgjZPy8p2TaMxt36XHBO3eiDuA1rAL1eCz6NYXJbJ8AmUwK5rwgYW2vZAQ7e/MZ5grqJDIbzgLnuiukhLj+r4a7AYi1ZV/yPX7oizVIhwEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793513; c=relaxed/simple;
	bh=aL2nK/i3BB6X5qzvnzSRJ8P+ee8WR1poImdpf7guM7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bB6UFBphFlb+S+ABMpfIbc/1qbMbsCXkaGGeVbSJz7ebl5wkbUtbwOXtX9/W7a+Jll9oX2CaWWtU2eSHbH2Fo3oIuG2toeC7m+AjJSppfowWOUwMOfIPYrbxAT7MPn4HsR8Ajn5YF321YEgPW/PI3EKRm2o/uSxSIz5jPE/tSP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KSVXwOoB; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f0277767fbso3233549a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715793510; x=1716398310; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kSpx0TF7V8XRznvBi6NaCxQRB6qASfwSCeSNwtytn4=;
        b=KSVXwOoBbOKvr4dpGSj7ofuhSvhALgzT3M07RBk2KWFu5vt6X9nTqYaHTrT2W/HySO
         eg18p8DNFKYpvAmG3LVUyEmiaBxONBIWcCkQM79BmbvTvouJUtTpcVi8hbuLVgM/lc3P
         JqjEDvOMtwsnjulT3SQfrAQNuY/96LGW/xeRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793510; x=1716398310;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kSpx0TF7V8XRznvBi6NaCxQRB6qASfwSCeSNwtytn4=;
        b=OFPZRYQzfhE37mvDxi2TIIdPmkZ0EP2SUpNkH0Q2nIwsdvMG/KeFb4A442dA/iVOWZ
         S7PLvXdoR2A8wrXTSYxmaszr5Npme2qVnCc5Ljy6111uxWd/WUbvyyd+OboSOrSsjTOF
         hUugT/eYh6TOKRT5X0BpcygWnpxGBebAmvQMCT4ENUbnvSYHhSpG47+ZY0z0SRmSmZbe
         sepT/aEU6au6q2BCeO2HLKAyD7a+Up2pf9rNt05Dw6tN3CLDxLc+Rp5eS/82gKXqVS93
         p3h1+UiGyOD8q4CGt4xOIyCRKRNKfydDBatLQtA+elqQWKsZkyS5Kmj6+1m6XyXqh0pp
         /l0A==
X-Forwarded-Encrypted: i=1; AJvYcCVjMUNAnnsi4FycO1jH7bhn0Y9tkfCKeuVp/apOcB6Oz68sqt+gjtyX0yWnIsQs/2b1G2wZ3YnicgQdoy/yGt5i3Vfi015UGahwGxx0
X-Gm-Message-State: AOJu0YzZluaBpfdeL73HaR4i8jqAEjtZvxaA8ydA3mFzVwL15B+cohxh
	wN29KBrztmEKuJneGM1LugGoQHYVIJqGr64SemPFDNNW4pCLsY0sRke3mox3kk9iyy4fqo2g04a
	T+yrU7M4FtWOpgzh7CRFb7XfEkbFB0NLjzEC/
X-Google-Smtp-Source: AGHT+IFvQPJjrTXcLK6Kyq6tdjLmP8vEcUBjvGZaxJF6agN8oYjhXCIwg9mxXl8wWfcwew7PtMbJ6rHwa7uDq/2mAtQ=
X-Received: by 2002:a05:6870:4692:b0:23c:eddc:65a2 with SMTP id
 586e51a60fabf-2417bb8119cmr18599425fac.43.1715793510070; Wed, 15 May 2024
 10:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <d46qb2rkfsagw22u6ishgagsvsmqsu5nrmf5up5mhi6xrwolyt@6ir6g2v63of7>
In-Reply-To: <d46qb2rkfsagw22u6ishgagsvsmqsu5nrmf5up5mhi6xrwolyt@6ir6g2v63of7>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 15 May 2024 10:18:17 -0700
Message-ID: <CABi2SkXBpL8qdSMTwe5njWasqidsWDkhme6xw2_38JARrhPRwA@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	jeffxu@chromium.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 2:28=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Andrew Morton <akpm@linux-foundation.org> [240514 13:47]:
> > On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> >
> > > This patchset proposes a new mseal() syscall for the Linux kernel.
> >
> > I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> > of the total lack of Reviewed-by:s and Acked-by:s.
> >
> > The code appears to be stable enough for a merge.
> >
> > It's awkward that we're in conference this week, but I ask people to
> > give consideration to the desirability of moving mseal() into mainline
> > sometime over the next week, please.
>
> I have looked at this code a fair bit at this point, but I wanted to get
> some clarification on the fact that we now have mseal doing checks
> upfront while others fail in the middle.
>
> mbind:
>                 /*
>                  * If any vma in the range got policy other than MPOL_BIN=
D
>                  * or MPOL_PREFERRED_MANY we return error. We don't reset
>                  * the home node for vmas we already updated before.
>                  */
>
>
> mlock:
> mlock will abort (through one path), when it sees a gap in mapped areas,
> but will not undo what it did so far.
>
> mlock_fixup can fail on vma_modify_flags(), but previous vmas are not
> updated.  This can fail due to allocation failures on the splitting of
> VMAs (or failed merging).  The allocations could happen before, but this
> is more work (but doable, no doubt).
>
> userfaultfd is... complicated.
>
> And even munmap() can fail and NOT undo the previous split(s).
> mmap.c:
>                         /*
>                          * If userfaultfd_unmap_prep returns an error the=
 vmas
>                          * will remain split, but userland will get a
>                          * highly unexpected error anyway. This is no
>                          * different than the case where the first of the=
 two
>                          * __split_vma fails, but we don't undo the first
>                          * split, despite we could. This is unlikely enou=
gh
>                          * failure that it's not worth optimizing it for.
>                          */
>
>
> But this one is different form the others..
> madvise:
>         /*
>          * If the interval [start,end) covers some unmapped address
>          * ranges, just ignore them, but return -ENOMEM at the end.
>          * - different from the way of handling in mlock etc.
>          */
>
Thanks.

The current mseal patch does up-front checking in two different situations:
1 when applying mseal()
   Checking for unallocated memory in the given memory range.

2 When checking mseal flag during mprotect/unmap/remap/mmap
  Checking mseal flag is placed ahead of the main business logic, and
treated the same as input arguments check.

> Either we are planning to clean this up and do what we can up-front, or
> just move the mseal check with the rest.  Otherwise we are making a
> larger mess with more technical dept for a single user, and I think this
> is not an acceptable trade-off.
>
The sealing use case  is different  from regular mm API and this
didn't create additional technical debt.  Please allow me to explain
those separately.

The main use case and threat model is that an attacker exploits a
vulnerability and has arbitrary write access to the process, and can
manipulate some arguments to syscalls from some threads. Placing the
checking of mseal flag ahead of mprotect main business logic is
stricter compared with doing it in-place. It is meant to be harder for
the attacker, e.g. blocking the  opportunistically attempt of munmap
by modifying the size argument.

The legit app code won't call mprotect/munmap on sealed memory.  It is
irrelevant for both precheck and in-place check approaches, from a
legit app code point of view.

The regular mm API (other than sealing)'s user-case is  for legit
code, a legit code knows the whole picture of memory mappings and is
unlikely to rely on the opportunist return.

The user-cases are different, I hope we look into the difference and
not force them into one direction.

About tech debt, code-wise , placing pre-check ahead of the main
business logic of mprotect/munmap APIs, reduces the size of code
change, and is easy to carry from release to release, or backporting.

But let's compare  the alternatives - doing it in-place without precheck.
- munmap
munmap calls arch_unmap(mm, start, end) ahead of main business logic,
the checking of sealing flags would need to be architect specific. In
addition, if arch_unmap return fails due to sealing, the code should
still proceed, till the main business logic fails again.

- mremap/mmap
The check of sealing would be scattered, e.g. checking the src address
range in-place, dest arrange in-place, unmap in-place, etc. The code
is complex and prone to error.

-mprotect/madvice
Easy to change to in-place.

- mseal
mseal() check unallocated memory in the given memory range in the
pre-check. Easy to change to in-place (same as mprotect)

The situation in munmap and mremap/mmap make in-place checks less desirable=
 imo.

> Considering the benchmarks that were provided, performance arguments
> seem like they are not a concern.
>
Yes. Performance is not a factor in making a design choice on this.

> I want to know if we are planning to sort and move existing checks if we
> proceed with this change?
>
I would argue that we should not change the existing mm code. mseal is
new and no backward compatible problem. That is not the case for
mprotect and other mm api. E.g. if we were to change mprotect to add a
precheck for memory gap, some badly written application might break.

The 'atomic' approach is also really difficult to enforce to the whole
MM area, mseal() doesn't claim it is atomic. Most regular mm API might
go deeper in mm data structure to update page tables and HW, etc. The
rollback in handling those error cases, and performance cost. I'm not
sure if the benefit is worth the cost. However, atomicity is another
topic to discuss unrelated to mm sealing.  The current design of mm
sealing is due to its use case and practical coding reason.

Thanks
-Jeff

> Thanks,
> Liam

