Return-Path: <linux-kernel+bounces-288825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B84E953F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C6E28360E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FB92BD0D;
	Fri, 16 Aug 2024 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kckmUPhc"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F3B664
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773508; cv=none; b=kZUMqdQ9i5ODaXk5jaRX3ZnlHEMkdmCFxZoT6uDFMjf7XDuXp5vSj2ju1bIL5pJbhRvLx+TN90w2TRC1dJ3EkYVAsY8ch9lPREhCZhcdDCmQKgkmGx8B7pjZdawSG3+L/yQr2LuX2TIbZB4IcohX0Tk0y/fU9VXXNbUdYy8mbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773508; c=relaxed/simple;
	bh=qMx2P8h+zhbZXcKKGnrbVWuLyPK4/n3EYdMSDHq7pE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sySZQYsqCktculZ8v4QrmZ19KPfsx27w2kSYPE6fST6WxVF42PcRd42rRTd+iqhfSj1RMwBZ7Lh0sl4nwTFEmOuXWEepgH+uHlB6fITj0SJOUat9VGL2Bud+AmV3DIOz67jExuA+JK2jpLiO2cH6mh2bfv2EQ6ya4BbGIAqIQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kckmUPhc; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8430557e436so208512241.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723773506; x=1724378306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAgZgdZ6tdR/kq3Id/eEPEbSkIxjDL9T60LA8o7yEqo=;
        b=kckmUPhcpVDiir69JKgZd5C/699TYR27xgz6MyKEmVAZaToPojRUrh1Z/VxAUMALXJ
         dFXT0BV9PthC1vnuTih3OKzqSwVLDILEHIpsHMCJxL3FIRxvSq0PkXKn3UavUDGCkjea
         Ex6pZK3rVEq5mY56yXNKl4vCGeSvaj6WOO5lSuYKDryYxaR7kEgYl4LdoerSkubEKsZt
         tlDeWaL/PIGMW1cHa8hJS56A6+q1SZ/Z+D/yIkluQrkqldZ9Pn0q2qenCgVSd5EFs4ku
         OVzRHGuLa53yEAXIPU9d0zMIkOtMZi8ymabRzsO9QoqUwyXQ94LSq72ZLI5hZwkyIxFs
         FJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723773506; x=1724378306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAgZgdZ6tdR/kq3Id/eEPEbSkIxjDL9T60LA8o7yEqo=;
        b=Fpq4zn/ArEduoPguwkP2YjGwd80zpMSUl36s/fKZJ9fAA6PmCVPZkdCfK521RYK2GP
         1EPhBl+j0EVmX5l4ybRnGx4sAX1fZUzS/7sWGSxwf7MLKmsv+cxosc0wkz9YB3GxtSCn
         I1t5RLe9fpa5OgYXcDQKkS6VKqqm9J0Zfo810afkR8bABi5sM0G18BEIyxKHuxetC9at
         aDc9VhsoF4eqg11EfcMFEmiqRZVowRRwzPmeCM/pKLHavZlxvLCgHNBDgnseHWuA/kx2
         8tZO48PUfwO3p0BFtU+F3dQlqIi2/7/pulOzdTCuN9jrSe6nPUZiM1DKLVUMT/qPRgb0
         hdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlGVDjErHdo56Cdt6X1qlhi8tYpt6QEAVHKzgG1Wuh7+k3HBYDIofSYw36b1C/7zGqzP6Wfc32vPGz9W1tu3z4pLk7LXbxMoWC9spt
X-Gm-Message-State: AOJu0YwGAAPKPtvhPE7xdNeikioqt16EqiznyduZ5ngEpvPDidm6MGeC
	rGnATblZJQK7+etsgcskGzpEUjomA+bf+2a1k281vRcyLcjq8p9R/cE19IDnpTWyBSpC3wLaXFt
	ppRRr+hoztZ+2oku40d5/H0zsWnE=
X-Google-Smtp-Source: AGHT+IHDASiYuhpMCbXxbDWnm1ksdVAopUItKTYEdpJTS1ry85XYBxIHA/3mE5dqFyDzBZwEUq+VzJdETWu207GyQvk=
X-Received: by 2002:a05:6102:f0a:b0:497:5faa:af74 with SMTP id
 ada2fe7eead31-497799455b2mr2225033137.11.1723773505876; Thu, 15 Aug 2024
 18:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240808161226.b853642c0ecf530b5cef2ecc@linux-foundation.org>
 <CAKbZUD0_BSv6KOgaRuqjLWGnttzcprcUu5WysSZeX8FXAvui5w@mail.gmail.com>
 <CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo+-8MuRJ-g@mail.gmail.com> <CABi2SkUYAc557wwOriwUW3tfTc_U9MDPQ4bE-Q+tTdNgGT3UuQ@mail.gmail.com>
In-Reply-To: <CABi2SkUYAc557wwOriwUW3tfTc_U9MDPQ4bE-Q+tTdNgGT3UuQ@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 16 Aug 2024 02:58:14 +0100
Message-ID: <CAKbZUD3_3KN4fAyQsD+=p3PV8svAvVyS278umX40Ehsa+zkz3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Jeff Xu <jeffxu@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:10=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrot=
e:
>
> Hi Andrew, Pedro
>
> On Thu, Aug 8, 2024 at 6:03=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
> >
> > On Thu, Aug 8, 2024 at 5:34=E2=80=AFPM Pedro Falcato <pedro.falcato@gma=
il.com> wrote:
> > >
> > > On Fri, Aug 9, 2024 at 12:12=E2=80=AFAM Andrew Morton <akpm@linux-fou=
ndation.org> wrote:
> > > >
> > > > On Wed,  7 Aug 2024 22:13:03 +0100 Pedro Falcato <pedro.falcato@gma=
il.com> wrote:
> > > >
> > > > > This series also depends on (and will eventually very slightly co=
nflict with)
> > > > > the powerpc series that removes arch_unmap[2].
> > > >
> > > > That's awkward.  Please describe the dependency?
> > >
> > > One of the transformations done in this patch series (patch 2) assume=
s
> > > that arch_unmap either doesn't exist or does nothing.
> > > PPC is the only architecture with an arch_unmap implementation, and
> > > through the series I linked they're going to make it work via
> > > ->close().
> > >
> > > What's the easiest way to deal with this? Can the PPC series go
> > > through the mm tree?
> > >
> > This patch can't be merged until arch_unmap() is all removed (ppc chang=
e)
> >
> > Also I'm still doing a test/reviewing for this patch,  perhaps it is
> > better to wait till my test is done.
> >
> Sorry that I'm late for updating this thread.
>
> With removing arch_unmap() change landed , there is no dependency for
> the patch. However: I have other comments:
>
> 1. Testing
> Testing is 90% of work when I modify kernel code and send a patch.  So
> I'm a little disappointed that this patch doesn't have any test
> updates or add new tests. Which makes me less confident about the
> regression risk on mseal itself, i.e. a sealed mapping being
> overwritten by mprotect/mmap/mremap/munmap.  I have posted the comment
> in  [1], and I would like to repeat it to stress my point.
>
> The V2 series doesn't have selftest change which indicates lack of
> testing. The out-of-loop check is positioned nearer to the API entry
> point and separated from internal business logic, thereby minimizing
> the testing requirements. However, as we move the sealing check
> further inward and intertwine it with business logic, greater test
> coverage becomes necessary to ensure  the correctness of  sealing
> is preserved.

Sorry, cut the crap. Your backhanded concerns are very funny.
mseal was _your_ feature. You wrote the tests. You either didn't write
or didn't understand what kinds of tests need/should be done,
otherwise you would've done them. I wrote some code to fix the awful
performance hit. It is a _fix_, not a feature. Your previous mseal
tests should've covered this. If they didn't, that's okay (we all make
mistakes), but pushing your problems onto me is seriously laughable.

I want to stress this bit: There's no mseal feature, there's no
business logic. There's mmap, munmap, mprotect, madvise, mremap (among
others). These are the things people actually care about, and need to
stay fast. Memory management is a core part of the kernel. All of the
very pretty abstractions you're talking about aren't applicable to
kernel code (for any kernel, really) in general. No one wants to pay
the cost of walking through a data structure 2 or 3 times just to
"separate the business logic" for a random, minimally simple feature.

>
> Yes. I promised to run some tests, which I did, with the existing self
> test (that passed),  also I added more tests in the mremap selftest.
> However I'm bound by the time that I can spend on this  (my other
> duties and deliverables), I can't test it as much as I like to for
> in-loop change (in a time frame demanded by a dev in this ml). Because
> this patch is not getting tested as it should be, my confidence for
> the V2 patch is low .

Ok so you: tried to explain to me how to run selftests in v1 (when I
actively did _before sending_, and found a bug in your tests, and
wrote about it in-depth), pledge to "run some tests", never get back
to us, push the "the testsuite I wrote is lacking" concern onto me,
send a whole separate parallel patch set that tries to address _one_
of the regressions with complete disregard for the work done here,
complain about a lack of time, and now say a backhanded "your
confidence for the V2 patch is low".

I seriously have no words.
I want to stress I have no way to test real software that uses mseal
because APPARENTLY THERE IS NONE. THE FEATURE ADDED EXPLICITLY FOR
CHROMIUM IS NOT USED BY UPSTREAM CHROMIUM.

>
> 2 perf testing
> stress-ng is not stable in my test with Chromebook, and I'm requesting
>  Oliver to take more samples [2] . This due diligence assures that
> this patch accurately fulfills its purpose. The in-loop approach adds
> complexity to the code, i.e. future dev is harder to understand the
> sealing logic. Additionally, it sacrifices a security feature that
> makes it harder for an attacker to modify mapping (currently if an
> attacker uses munmap with a large address range, if one of the
> addresses is sealed, the entire range is not modified. In the in-loop
> approach,  memory will be unmapped till it hits the sealed memory).

Wrong. munmap is atomic and always has been. It's required by POSIX.

I would also ask you to back these partial mprotect (assuming that's
what you meant) concerns with a real attack that takes this into
account, instead of hand waving "security".
While noting that all of these operations can already partially fail,
this is not new (and is explicitly permitted by POSIX for
syscalls-not-named-munmap).

> Therefore, I would like to ascertain the gain.

The gain is real. I've proven it with will-it-scale, Oliver ran his
tests and found the regression to be gone (and they do seem to do
proper statistical analysis).
I would wager you to find a workload or hardware where *doing
substantially less work* makes for slower code.

>
> 3 mremap refactor work.

mremap refactoring is not related to these mmap regressions. In the v3
I'm cleaning up and sending out tomorrow, I minimally change mremap
(as Liam wanted).

--=20
Pedro

