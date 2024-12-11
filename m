Return-Path: <linux-kernel+bounces-440650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083CD9EC251
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8881885767
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A671FC7FC;
	Wed, 11 Dec 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elvqFIqK"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7001BD9E6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884743; cv=none; b=al4mvGh5Ylu6hhcb4UNqt+sVuqhQo06vftcVNQAFXd/G6fXRqfxuA/HtAsicxkLdJ85fGWUlTIxEPdrOmeenjVAS7RATQJLnTI4JSCqry5A+HaoqL9VUbGnyAElBPU2Xdv9L21NndU5si+Yl2at6x/nZa3bIVhWoc1wd5ueavr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884743; c=relaxed/simple;
	bh=Vma5UC4Up8IXip1IFD7Lr4sLcxtr+U7Nv0cS4zQrrMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqKj6Y4Ya7Q/G6ZFDh01lNIOIRSCJUL+E5mMR0648YDSxzqSZpNF2mj7gVWsoS/tODZx0tUte09t/vAZ0FMDertpwd8FqkdpWDZiPhoqfiLQk8sAeTfWdq/QeTJHVGGvJyjWJMaHOnQrOB6vBWqT+nYBzsOWqrZzVFpZLPWvh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=elvqFIqK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71dea329591so377715a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733884740; x=1734489540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vma5UC4Up8IXip1IFD7Lr4sLcxtr+U7Nv0cS4zQrrMg=;
        b=elvqFIqKGZXtgC2BzASSqlZtibqeAxvW39cMuWPduhXasC8Nvat76fDs3+RqGgLNOD
         Mo5fLltKzfQMehw6TAc0n672HDMywA0nkfDdBS+LYuX9o/Zhmwz5mAdwEJZRJRN8ArTy
         icxV+dXzrBqOLtXhM/Dj4VXpJWnrjoWP1JYUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733884740; x=1734489540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vma5UC4Up8IXip1IFD7Lr4sLcxtr+U7Nv0cS4zQrrMg=;
        b=qP/UrefqsR8DT/sDNU3tjr8LtSnTzNVcaZUQSet/1ew5LS5PSzCEqRyDWvmrt9h+w7
         6ZHkVgUA3fhPE1Mvz2zQ8EI4PMbecNgefgGlFgymyux+nRYDIqRi1mSb/2WoaJ3c6NBU
         4xIb6MrGinWeu8aRol+qTeG7IPdtF/oGNByBuHVrgHqrJiQaqowB8wPCq0O564Gad86U
         S3I68bYPKu/aZj0Igwo5wlp6aTwf8VtfvKKWkedy2FaUUNz3UDiNGyeMtwA0lu/Trpt/
         jap8gw6MhjTm97pVxjzh4c0OdzttejTRCgUKJYwys4xo02xng2QkuWZdv1au/NRFYUqn
         aA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVszJbKY0ilpDhYOIUdXgsfCrAt44ZzcG+eniZMbF0BP1ICmsQiJnwfNWeEZav4p+HCctKeUaL4lkK8KOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSu6M5OoDy90Xs0AnYtcCkFC0RYO//ksdzi0O95Nc80EoZ7VJg
	5IRK5ECB/aWEJHT1dYVGKPQ/6fSXHNTwwhmYLPT6mAdP3+3EAdFcZesvHn4NoF9ryWVX3wJ+9+I
	WZv0RMH3+77TrIAW4VqsjhpXBSpOt3qkEsa0U
X-Gm-Gg: ASbGncsrfykwNvMLWmA1/ccTzEUlw3fDgSV8d6AUWIgUdvR5meoK3HjBJjYLeLs80c4
	ZCFDplT0t3tIK5QlHeRv9e6HuoxSVb+jjMfMIvd9Pr04/fW6LnC0Eb4CwpMZiBl0N
X-Google-Smtp-Source: AGHT+IEZFASK6PUZ+4WyunObGGitl8fk62QLOo0Za5h2KjoAHplUqp/QgRz8ZkDfBfQe8U5z7n2k0R9zDrd7o2X6lIk=
X-Received: by 2002:a05:6870:b48a:b0:29e:5525:f4fd with SMTP id
 586e51a60fabf-2a012f874bdmr271231fac.14.1733884740297; Tue, 10 Dec 2024
 18:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206013934.2782793-1-jeffxu@google.com> <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
 <d710d812-3dc0-406f-ac47-a782673d3d07@lucifer.local> <CABi2SkWkUmBdsUYhr-cE181oh=medLG0iXgHk6TYEuPgztxqOw@mail.gmail.com>
 <f4c704bc-3b9a-48bb-b1dc-8a73d181223c@lucifer.local>
In-Reply-To: <f4c704bc-3b9a-48bb-b1dc-8a73d181223c@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 10 Dec 2024 18:38:49 -0800
Message-ID: <CABi2SkV+jVgg5Q=XCTC3+J7WtyvgFbHfP-sGTrzfJA0oteRPLQ@mail.gmail.com>
Subject: Re: [PATCH v1] mseal: move can_do_mseal to mseal.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

Regarding your proposal of moving mseal.c to vma.c for unit testing.

On Fri, Dec 6, 2024 at 9:04=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> > >
> > > An aside - I actually think we need to move the bulk of this code to
> > > mm/vma.c - it makes absolutely no sense to keep the internals in this=
 file,
> > > and that way we can userland test mseal functionality.
> > >
> > Is there a past discussion to read ? That will help me understand your
> > strategy of unit testing mm code.
> > Moving everything to vma.c, will lose log history, e.g. blame no
> > longer helps, did we consider alternatives ?
>
> Re; git blame - I'm not sure what alternative you think exists, and I've
> moved brk(), mmap(), etc. with a history spanning >30 years, so I'm not
> sure what blame history you're concerned about given how recent mseal is =
:)
>
> There is always code that gets moved or changed. You can't stay attached =
to
> your name appearing on a git blame line.
>
> Re: discussion, there's dozens of discussions and patch sets totalling ~3=
k
> lines of code... just search lore for vma testing, or search through my
> commits in mm/vma.c and you can see.
>
> I can put together links if you really need, but I think say [0] is a goo=
d
> motivating example of how I was able to actually write unit tests for VMA
> merge functionality which previously could not exist.
>
> In any case you can use the git blame -C option to 'see through' things l=
ike
> code moves.
>
> The whole point of this is to be able to _unit_ test functionality under
> circumstances that might be otherwise improbable/incredibly difficult to
> obtain if run as part of a kernel and self testing.
>
> Importantly it allows us to conduct fuzzing testing in future, something
> key and fundamental to security testing.
>
> I would say for somebody who has clearly stated his huge commitment to
> testing and how critically vital it is especially in the security realm,
> this is entirely something that is beneficial to the kernel and to mseal
> stability and security.
>
> If you want to see it 'in action', you can run the tests in
> tools/testing/vma via:
>
> $ make && ./vma
>
I want to express my support for unit testing and agree that more
testing would benefit mm. However, I'm unsure about the reasoning
behind moving code to vma.c in bulk. Could you please clarify this for
me?

In my understanding, unit tests can be conducted regardless of the
code's location once dependencies are addressed with stubs. Have you
considered adding mseal.c to the unittest makefile at the same level
as vma.c? Since mseal.c doesn't introduce new dependencies, i.e. it
operates directly on the vm_area_struct, so I would start with that.

I guess, for UT, you might need to change some functions' signatures,
e.g. remove static, if you want to test an internal function (e.g
mseal_fixup) , from your unit-test, but this is the same even after
moving them to vma.c.

There will be additional work of clean up including header (".h"),
still I believe this is the same work even after moving the code into
vma.c. You might still need to move the prototype of some functions
into vma.h or vma_internal.h (e.g. definition of MADV_FREE). But I
think this work is also orthogonal to where the mseal business logic
is located.

I understand the logic behind the current vma.c (on the linux_main
branch) and the unit test for the VMA merge functionality. However, if
your plan is to move all VMA-related code into vma.c, that means more
stubs are needed (depending on the boundary of the proposed unit
testing), and I don't understand how moving the code can help reduce
the amount of work or stubs (if that is the motivation).

To avoid spending too much of your time, if there are previous
discussions on this topic, please share links or a brief summary, so I
can study them first.

Thanks!
Best Regards,
-Jeff


> [0]https://lore.kernel.org/linux-mm/1c7a0b43cfad2c511a6b1b52f3507696478ff=
51a.1725040657.git.lorenzo.stoakes@oracle.com/
>
> Thanks, Lorenzo

