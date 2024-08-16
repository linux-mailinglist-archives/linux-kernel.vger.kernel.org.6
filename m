Return-Path: <linux-kernel+bounces-290113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7A1954F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D94B1F22F44
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07561C0DE7;
	Fri, 16 Aug 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mxoqSsZM"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34A6F2F8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828048; cv=none; b=LPUJ9OwPJPUlaD1uFb4vCvHe9ht5kSVuFr69UOo0tdL2DFBbMB3keNRvgrPjXUfTGT/dkJuS/i2Y3m6T1soQ/QGTdk0JlQfaMJhvm31/FwBd9419zMjFvyFTkrLsjO0PB5sFTi0vopV6UTa9/UzJUbG6w7pNL9CRWXWFxlhHcBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828048; c=relaxed/simple;
	bh=isNJGRP0ihiseBW/EO/MM9gm/YXxyHWyicj78sCaOqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+cvjiDHu8rYWK86CyUev3lFfj5Q6KSFBfrRZyGe/pU+NRMJurty0GfB1GhFQneCO+fcjsOSQHHyEV9d6UGzMoI+PV2oF/EWohxoZ30rqP3RtfbpIAFIruEgjQ4YQTBPMPajIXANSR1TubkP6ByFsEwu260jV8/Qk3D4yyDYgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mxoqSsZM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2681941eae0so1332469fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723828045; x=1724432845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/TbnC7SDugjkAEdThzf4HRCowQ6gi7ofcD1sIuLidM=;
        b=mxoqSsZM6Zwpo3BozA5zcirijNuRFyXCh1/TcVJvlLR+Ejv8PhHPy0Y+uVtdQdI8nS
         NnLu+ek2zjLme3wATJNrOVmrVX1u1873aDQzPWulehVscsaIQa+EfLffn9AvjlvZjhWD
         5mPyPccnT2ezakAakQvIWS+5lADBUVNRKZijE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723828045; x=1724432845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/TbnC7SDugjkAEdThzf4HRCowQ6gi7ofcD1sIuLidM=;
        b=HTTpI44oQ+GwJ7aQIhwIl/QbwpxPHLBIg78yxMdHRtQCxXQWDoXGbhtkXyG0KX5HEe
         EyvqBcxt5tbMcThA2o3b1U3lXE4bPwAtdRKvAKnfNr1LlRBpad842SevO2eS8bintvwb
         0aoxeBCSWf2kVyoh68+5Ak06j9EsMoOty8nYmVdsfaEmiiwQOpZoTc7mvp4ZHwvc9873
         4t/uHxgnmQuZV6PC+KBBeWRwFwyydfO3S+IxIT6ei+wduiF7y4bLoWw+WQsFJEtfOQq9
         C4MvKKfd6h4CWuGQwGewn3SWxzomTPLh6WIhTi/azd9+Z7Hxd4f/dNLfDtHynYwvM8/z
         O9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV9trk+FGhjzXhyohwxOznKuz4QgAh46+2FOX4ebpu0n7NNiPsJVQW5OWrDQEIvgOT46FbzQs7OSiyIkQkhkzxNj8Q2dD/yLJlssaCh
X-Gm-Message-State: AOJu0YwSyJ2duQnjEVUxl+WtSXC9nbYXtIZL4I4M4FtYQg82lCIB20nM
	os30NWzdmjog9BNVDuCzBvxAfPcGnEDOhIdaFZLeYO1MLW3WnBqZ0a22dzSKVHL3wS92/jA9o03
	wItLAgo4PZW6fycYSjfLYkzimH/yZLZos5Izb
X-Google-Smtp-Source: AGHT+IGn2rF9eff35N4MIjswWFYWfxqOZA2OskqRvJPd4hifLbnwIUjs8vvvZEV8UAYhKGuOWprvlQZbMLz2YSLnemc=
X-Received: by 2002:a05:6870:524f:b0:250:756b:b1ed with SMTP id
 586e51a60fabf-2701c394beamr4195068fac.19.1723828044686; Fri, 16 Aug 2024
 10:07:24 -0700 (PDT)
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
Date: Fri, 16 Aug 2024 10:07:12 -0700
Message-ID: <CABi2SkVrEHbWa4AsffX9RXv_a-KjwZajkscZ3Bi4JWzJ4fr6wQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

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

> I seriously have no words.
> I want to stress I have no way to test real software that uses mseal
> because APPARENTLY THERE IS NONE. THE FEATURE ADDED EXPLICITLY FOR
> CHROMIUM IS NOT USED BY UPSTREAM CHROMIUM.
>
The testing is about making sure that sealing is preserved after
mmap/mremap/munmap/mprotect call, there is no real software that will
do that kind of testing, even in the future, selftest is the only way.

Security features never come quickly, adding  syscall to the kernel is
the first step to allow apps to use it.

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

