Return-Path: <linux-kernel+bounces-290148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8E0955000
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8451C21593
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D003B1BE248;
	Fri, 16 Aug 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hBZ6JmZ5"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA32F43
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829420; cv=none; b=GcxRCJ5JzXfoLPOfPk25v/RJFDRD6OonBx5Kh/ouH6KMnwXB/VfOkdJgLTAG8J+yenSmTH6ZHKMll5NZDVUGUFaewLavHMB2nyU5I0fCC2nloe4aaovHDapJelXvkQVMGwHnzGqRwpFyEmjjSwSi4D/dCGNcAsxZarBXJ0xg2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829420; c=relaxed/simple;
	bh=1I3bnmGWZL1gf5zXo5GWBggWZylGzB49SHHRpbZBSPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQFQFuh41d3cZEHT7jvzzSmpnciLYMVbNfQUGuKyAa8lkYPwMhZtuskBkaT1LNhSNa46Ot0bT52PAqoSCnYzH9zKCfxC/nCcmBodFr2NDff+z3vG5x4HQHNEjR8gcWs8Zay7y7CRyVR6iSnUzmTrmb12Lqp7yNZlVUPpD4Z70Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hBZ6JmZ5; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5f24d9df8so1217929eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723829418; x=1724434218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tBYSxfHD+S5eb/sSL8twdBp0696qHHZqkJKClMzb6c=;
        b=hBZ6JmZ5Oz9AUqlSVkQ50AX3gtX+Jwq9m5XSl9WgfKMHQO7f8HZuNOCETfWJg9U+FW
         S7mJ2XAhv+rV/R1b9kv5J8L7d2jzNsHebQfEjSfMd/cQLHw1Rnzm4sWliTgQazsLCnJJ
         fou2ORCafkya0sS2FCS10QZceUeBMxi/h/YOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723829418; x=1724434218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tBYSxfHD+S5eb/sSL8twdBp0696qHHZqkJKClMzb6c=;
        b=dfp4Z85iZuOdOTkkvz/zKRWZUfddxx13rdfaMRBjfwW2VYGXkLrSuNtCefa/WsCBc6
         fbE2QuFwX0mAnU5YOFW7naaWntjoAXxtzlcWdyC1s5WHTyImdozY/qNrctHbAuzgFjSJ
         yXdQNTbCSdnpXqrBjugrM/bT/BzdZWcOW6hxe/VQoa8sX8B+JstInXmTimk46Sk1omJ5
         S2C0u3TGwDJiW4W4CHsuJAJFxZef/+J+N468p4M+jDDFTu2PZM0UQBnSpPp0yCqDvbHK
         uhv7dZzolhYdqf7yFGSSynwpdQW2SQ0gcFIS4PWL6E9ZrB4hbUO3Qf71FEgp4D49bWsT
         YOIg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/EmzBLlRLpHcb6FK3//Ijvqk98OaEyd8oYYJBrzA03Vw8THlJ7Z4B2cQBMkWMBPaEARNM4t/rMqwhVE902C8aM3FGqozCg7LQa+K
X-Gm-Message-State: AOJu0YweVoszRCR51K/XGqbiWzc+5qL4XuQi+Hz++34hiKJbO6d4xbhk
	KeRpKZRIUPk2tK27u+J6SPRH0Gb8H/bmaDP3grQsSKSv5kr77TRCAvBp+poHVM8iVP8iRu4XlFN
	B10BKXH3LzkFrLbmXgX56Cr5WNmQxap19IOM5
X-Google-Smtp-Source: AGHT+IF0/4D35MLAl7Lt1Htt30ECMQlvh/GhrvPH0xL3O7nAZsnfu2nsRYWw+OkQzmkX71BMt7chI5Bzp4LNPdxH6/w=
X-Received: by 2002:a05:6870:524f:b0:250:756b:b1ed with SMTP id
 586e51a60fabf-2701c394beamr4276459fac.19.1723829417706; Fri, 16 Aug 2024
 10:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240808161226.b853642c0ecf530b5cef2ecc@linux-foundation.org>
 <CAKbZUD0_BSv6KOgaRuqjLWGnttzcprcUu5WysSZeX8FXAvui5w@mail.gmail.com>
 <CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo+-8MuRJ-g@mail.gmail.com>
 <CABi2SkUYAc557wwOriwUW3tfTc_U9MDPQ4bE-Q+tTdNgGT3UuQ@mail.gmail.com> <CAKbZUD3_3KN4fAyQsD+=p3PV8svAvVyS278umX40Ehsa+zkz3w@mail.gmail.com>
In-Reply-To: <CAKbZUD3_3KN4fAyQsD+=p3PV8svAvVyS278umX40Ehsa+zkz3w@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 16 Aug 2024 10:30:05 -0700
Message-ID: <CABi2SkXPRr6Tc_=KQQO3swC78T18wd7S3E=EQ7eD4rbpBpqzNA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro,

(resent,  previous email has html link)

On Thu, Aug 15, 2024 at 6:58=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Aug 15, 2024 at 11:10=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wr=
ote:
> >
> > Hi Andrew, Pedro
> >
> > On Thu, Aug 8, 2024 at 6:03=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrot=
e:
> > >
> > > On Thu, Aug 8, 2024 at 5:34=E2=80=AFPM Pedro Falcato <pedro.falcato@g=
mail.com> wrote:
> > > >
> > > > On Fri, Aug 9, 2024 at 12:12=E2=80=AFAM Andrew Morton <akpm@linux-f=
oundation.org> wrote:
> > > > >
> > > > > On Wed,  7 Aug 2024 22:13:03 +0100 Pedro Falcato <pedro.falcato@g=
mail.com> wrote:
> > > > >
> > > > > > This series also depends on (and will eventually very slightly =
conflict with)
> > > > > > the powerpc series that removes arch_unmap[2].
> > > > >
> > > > > That's awkward.  Please describe the dependency?
> > > >
> > > > One of the transformations done in this patch series (patch 2) assu=
mes
> > > > that arch_unmap either doesn't exist or does nothing.
> > > > PPC is the only architecture with an arch_unmap implementation, and
> > > > through the series I linked they're going to make it work via
> > > > ->close().
> > > >
> > > > What's the easiest way to deal with this? Can the PPC series go
> > > > through the mm tree?
> > > >
> > > This patch can't be merged until arch_unmap() is all removed (ppc cha=
nge)
> > >
> > > Also I'm still doing a test/reviewing for this patch,  perhaps it is
> > > better to wait till my test is done.
> > >
> > Sorry that I'm late for updating this thread.
> >
> > With removing arch_unmap() change landed , there is no dependency for
> > the patch. However: I have other comments:
> >
> > 1. Testing
> > Testing is 90% of work when I modify kernel code and send a patch.  So
> > I'm a little disappointed that this patch doesn't have any test
> > updates or add new tests. Which makes me less confident about the
> > regression risk on mseal itself, i.e. a sealed mapping being
> > overwritten by mprotect/mmap/mremap/munmap.  I have posted the comment
> > in  [1], and I would like to repeat it to stress my point.
> >
> > The V2 series doesn't have selftest change which indicates lack of
> > testing. The out-of-loop check is positioned nearer to the API entry
> > point and separated from internal business logic, thereby minimizing
> > the testing requirements. However, as we move the sealing check
> > further inward and intertwine it with business logic, greater test
> > coverage becomes necessary to ensure  the correctness of  sealing
> > is preserved.
>
> Sorry, cut the crap. Your backhanded concerns are very funny.
> mseal was _your_ feature. You wrote the tests. You either didn't write
> or didn't understand what kinds of tests need/should be done,
> otherwise you would've done them. I wrote some code to fix the awful
> performance hit. It is a _fix_, not a feature. Your previous mseal
> tests should've covered this. If they didn't, that's okay (we all make
> mistakes), but pushing your problems onto me is seriously laughable.
>
I posted the comments about the lack of a test update in V2 last
monday, there is no response from you until Thursday night (which is
OK). If you were expecting me to update the test cases and to support
your patch series, you should explicitly call it out.

So your point here is that you wrote the code, passed  the existing
selftest, fixed the perf, and the job is done. If the test doesn't
cover the new  cases you added, it is not your problem, you only need
to care about perf part.

This is how regression happened in past, e.g.

commit 77795f900e2a07c1cbedc375789aefb43843b6c2
Author: Liam R. Howlett <Liam.Howlett@oracle.com>
Date:   Tue Jun 6 14:29:12 2023 -0400

    mm/mprotect: fix do_mprotect_pkey() limit check

    The return of do_mprotect_pkey() can still be incorrectly returned as
    success if there is a gap that spans to or beyond the end address passe=
d
    in.  Update the check to ensure that the end address has indeed been se=
en.

    Link: https://lore.kernel.org/all/CABi2SkXjN+5iFoBhxk71t3cmunTk-s=3DrB4=
T7qo0UQRh17s49PQ@mail.gmail.com/
    Link: https://lkml.kernel.org/r/20230606182912.586576-1-Liam.Howlett@or=
acle.com
    Fixes: 82f951340f25 ("mm/mprotect: fix do_mprotect_pkey() return on err=
or")
    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
    Reported-by: Jeff Xu <jeffxu@chromium.org>
    Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
    Acked-by: David Hildenbrand <david@redhat.com>
    Acked-by: Vlastimil Babka <vbabka@suse.cz>
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>


Had not I wrote selftest to discover this mprotect regression, it
would go unnoticed  and stay that way.

My point is: the existing selftest for mseal  is written for out-loop,
and will not fully test in-loop. Your patch has made a big change to
mseal, more tests are needed.

To move forward from this situation for your patch series, either you
or me will need to update the tests. How about sharing the load ?

> I want to stress this bit: There's no mseal feature, there's no
> business logic. There's mmap, munmap, mprotect, madvise, mremap (among
> others). These are the things people actually care about, and need to
> stay fast. Memory management is a core part of the kernel. All of the
> very pretty abstractions you're talking about aren't applicable to
> kernel code (for any kernel, really) in general. No one wants to pay
> the cost of walking through a data structure 2 or 3 times just to
> "separate the business logic" for a random, minimally simple feature.
>
The testing is about making sure that sealing is preserved after
mmap/mremap/munmap/mprotect call, there is no real software that will
do that kind of testing, even in the future, selftest is the only way.

Security features never come quickly, adding  syscall to the kernel is
the first step to allow apps to use it.

> >
> > Yes. I promised to run some tests, which I did, with the existing self
> > test (that passed),  also I added more tests in the mremap selftest.
> > However I'm bound by the time that I can spend on this  (my other
> > duties and deliverables), I can't test it as much as I like to for
> > in-loop change (in a time frame demanded by a dev in this ml). Because
> > this patch is not getting tested as it should be, my confidence for
> > the V2 patch is low .
>
> Ok so you: tried to explain to me how to run selftests in v1 (when I
> actively did _before sending_, and found a bug in your tests, and
> wrote about it in-depth), pledge to "run some tests", never get back
> to us, push the "the testsuite I wrote is lacking" concern onto me,
> send a whole separate parallel patch set that tries to address _one_
> of the regressions with complete disregard for the work done here,
> complain about a lack of time, and now say a backhanded "your
> confidence for the V2 patch is low".
>
> I seriously have no words.
> I want to stress I have no way to test real software that uses mseal
> because APPARENTLY THERE IS NONE. THE FEATURE ADDED EXPLICITLY FOR
> CHROMIUM IS NOT USED BY UPSTREAM CHROMIUM.
>
> >
> > 2 perf testing
> > stress-ng is not stable in my test with Chromebook, and I'm requesting
> >  Oliver to take more samples [2] . This due diligence assures that
> > this patch accurately fulfills its purpose. The in-loop approach adds
> > complexity to the code, i.e. future dev is harder to understand the
> > sealing logic. Additionally, it sacrifices a security feature that
> > makes it harder for an attacker to modify mapping (currently if an
> > attacker uses munmap with a large address range, if one of the
> > addresses is sealed, the entire range is not modified. In the in-loop
> > approach,  memory will be unmapped till it hits the sealed memory).
>
> Wrong. munmap is atomic and always has been. It's required by POSIX.
>
Please run this test on the latest kernel branch to verify:

static void test_munmap_free_multiple_ranges(bool seal)
{
        void *ptr;
        unsigned long page_size =3D getpagesize();
        unsigned long size =3D 8 * page_size;
        int ret;
        int prot;

        setup_single_address(size, &ptr);
        FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);

        /* unmap one page from beginning. */
        ret =3D sys_munmap(ptr, page_size);
        FAIL_TEST_IF_FALSE(!ret);

        /* unmap one page from middle. */
        ret =3D sys_munmap(ptr + 4 * page_size, page_size);
        FAIL_TEST_IF_FALSE(!ret);

        /* seal the last page */
        if (seal) {
                ret =3D sys_mseal(ptr + 7 * page_size, page_size);
                FAIL_TEST_IF_FALSE(!ret);
        }

        /* munmap all 8  pages from beginning */
        ret =3D sys_munmap(ptr, 8 * page_size);
        if (seal) {
                FAIL_TEST_IF_FALSE(ret < 0);

                /* verify none of existing pages in  the range are unmapped=
 */
                size =3D get_vma_size(ptr + page_size, &prot);
                FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
                FAIL_TEST_IF_FALSE(prot =3D=3D 4);

                size =3D get_vma_size(ptr +  5 * page_size, &prot);
                FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
                FAIL_TEST_IF_FALSE(prot =3D=3D 4);

                size =3D get_vma_size(ptr +  7 * page_size, &prot);
                FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
                FAIL_TEST_IF_FALSE(prot =3D=3D 4);
        } else {
                FAIL_TEST_IF_FALSE(!ret);

                /* verify all pages are unmapped */
                for (int i =3D 0; i < 8; i++) {
                        size =3D get_vma_size(ptr, &prot);
                        FAIL_TEST_IF_FALSE(size =3D=3D 0);
                }
        }

        REPORT_TEST_PASS();
}

test_munmap_free_multiple_ranges(true)
test_munmap_free_multiple_ranges(false)

> I would also ask you to back these partial mprotect (assuming that's
> what you meant) concerns with a real attack that takes this into
> account, instead of hand waving "security".
> While noting that all of these operations can already partially fail,
> this is not new (and is explicitly permitted by POSIX for
> syscalls-not-named-munmap).
>
As defence gets stronger, with seccomp,selinux,landlock, attackers now
have to find an easier route.

> > Therefore, I would like to ascertain the gain.
>
> The gain is real. I've proven it with will-it-scale, Oliver ran his
> tests and found the regression to be gone (and they do seem to do
> proper statistical analysis).
> I would wager you to find a workload or hardware where *doing
> substantially less work* makes for slower code.
>
> >
> > 3 mremap refactor work.
>
> mremap refactoring is not related to these mmap regressions. In the v3
> I'm cleaning up and sending out tomorrow, I minimally change mremap
> (as Liam wanted).
>
If the test issue is not resolved, V3 will be in the same situation as V2.

Best Regards,
-Jeff

> --
> Pedro

