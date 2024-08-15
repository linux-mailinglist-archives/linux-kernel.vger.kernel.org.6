Return-Path: <linux-kernel+bounces-288656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CAD953D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251DB1C24AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779BA1547CE;
	Thu, 15 Aug 2024 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nDMSicSY"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6224211
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759841; cv=none; b=t6e2drFADQOFidVUZNg1UhuxcPLLA6v4/1FrrqUH3ASj3VfAJ23q+EnT2w60HEn2LmUYzU0QNltBbk8oSksWSTxOMIdhkWObOXqEoar1t7CfqZK6GT61c55O/A1PGqdAWLpoQbpw/OaKv5ByD8sE0HMrlnxlNLOUm3tZWPY2uHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759841; c=relaxed/simple;
	bh=zLzj3dAJ8xa9yAsOtIyCZ3ab9mJsuh/Ogx7P9BpKDHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVSEgMjQsLaY0GbZrm8eWSu/3LfwQQXbfEyLwoiucSkWrZCQThCnXXVpS8brdU2B8bBZlWjzzx8VuyoX7DyGl93y28+AsNnOT880P/986/+ox88emIWzBcByFcAjSxRx3stYrYX6vBpew/5f4Wef4ycze3mjaUbIZxeDtVRTDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nDMSicSY; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5b22f97b7so1105474eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723759839; x=1724364639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/7nC3aPz88eLKXfHY4nGDT403RKERjytoDOA8SZsNk=;
        b=nDMSicSYVvhTzgvPWWG4GijoNOe+6bIhNwG+Sw/lCmctXDOTZyMUwY0c6ET1TRVPgn
         wpRxdJ67f63aO8HBT6gVNUINPc4LIg7bCbG5UQV2Zou4QXimi+9CdQiT5KUX/nkVedDw
         MpBA9/XctPv+l0+R+ht+g0GV57GVHuSNRccxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759839; x=1724364639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/7nC3aPz88eLKXfHY4nGDT403RKERjytoDOA8SZsNk=;
        b=G39eNfMNEigvFTLnBtSx2oAMwljiLhloX2JZbhO491nqEQs5hF6sIaGW1ObhHShZcF
         vc1Bho4BZixrxvzhZH1iKhodv6bsS8yN4dMvVRt0v9SLYymc8W3pWSoUn74JtBpTJnJF
         mUtyoIVvtLqTwSGDvrbpackhCB3NxxIjLhClL55qa7DIOzOe5+3rXk+LRnwv6LJ+30qR
         R7sk2NxxxItsEuo/9/i+7pKNGeUTFFpyxcGonKS7O0GwS5pWR/OLfNESkWodXaSd8yhx
         3hVig5lUOVqy0vuhFPkdvDo78vDeHoXNkNWH6oLLiV7Rc5szrJVGQrKuPziV0uGbsxi7
         KPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWPuUxpaNJNRZ79QphrkCrlstCjWC733wgyj2/UkBIHZotuz018XwqeuHm0Lb64Pd4Vv53+pIAWd5A8WzgpKHU3Q7IRDI6NhFG/pZ2
X-Gm-Message-State: AOJu0Yy4i8jaznDfrXlGZSwwq53NoB/1wkutvWw2Y9jtEX6xEWa0NucT
	Fw5iZtsT4PiA5L8uFUD8t+j23VdvUe5wvXLpUu0bmXs+BRr9P3fXnN2Ddqc8Wj6tv+e1qQeHOrw
	N4Zr9WcRbdF2o+XFPsEhKD/Fgaz/dMaf67XYj
X-Google-Smtp-Source: AGHT+IF5LJMV2jdY4Pyo/ZU+/INrJJp5kECqy7go8Kj+jdNivGAtJJE9PKTXPviz151/f4Pj9/aSiWwI85MX98NspuE=
X-Received: by 2002:a05:6870:961f:b0:261:87:fe1f with SMTP id
 586e51a60fabf-2701c566835mr1108430fac.44.1723759838875; Thu, 15 Aug 2024
 15:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240808161226.b853642c0ecf530b5cef2ecc@linux-foundation.org>
 <CAKbZUD0_BSv6KOgaRuqjLWGnttzcprcUu5WysSZeX8FXAvui5w@mail.gmail.com> <CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo+-8MuRJ-g@mail.gmail.com>
In-Reply-To: <CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo+-8MuRJ-g@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 15 Aug 2024 15:10:26 -0700
Message-ID: <CABi2SkUYAc557wwOriwUW3tfTc_U9MDPQ4bE-Q+tTdNgGT3UuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Jeff Xu <jeffxu@google.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew, Pedro

On Thu, Aug 8, 2024 at 6:03=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
>
> On Thu, Aug 8, 2024 at 5:34=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
> >
> > On Fri, Aug 9, 2024 at 12:12=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Wed,  7 Aug 2024 22:13:03 +0100 Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
> > >
> > > > This series also depends on (and will eventually very slightly conf=
lict with)
> > > > the powerpc series that removes arch_unmap[2].
> > >
> > > That's awkward.  Please describe the dependency?
> >
> > One of the transformations done in this patch series (patch 2) assumes
> > that arch_unmap either doesn't exist or does nothing.
> > PPC is the only architecture with an arch_unmap implementation, and
> > through the series I linked they're going to make it work via
> > ->close().
> >
> > What's the easiest way to deal with this? Can the PPC series go
> > through the mm tree?
> >
> This patch can't be merged until arch_unmap() is all removed (ppc change)
>
> Also I'm still doing a test/reviewing for this patch,  perhaps it is
> better to wait till my test is done.
>
Sorry that I'm late for updating this thread.

With removing arch_unmap() change landed , there is no dependency for
the patch. However: I have other comments:

1. Testing
Testing is 90% of work when I modify kernel code and send a patch.  So
I'm a little disappointed that this patch doesn't have any test
updates or add new tests. Which makes me less confident about the
regression risk on mseal itself, i.e. a sealed mapping being
overwritten by mprotect/mmap/mremap/munmap.  I have posted the comment
in  [1], and I would like to repeat it to stress my point.

The V2 series doesn't have selftest change which indicates lack of
testing. The out-of-loop check is positioned nearer to the API entry
point and separated from internal business logic, thereby minimizing
the testing requirements. However, as we move the sealing check
further inward and intertwine it with business logic, greater test
coverage becomes necessary to ensure  the correctness of  sealing
is preserved.

Yes. I promised to run some tests, which I did, with the existing self
test (that passed),  also I added more tests in the mremap selftest.
However I'm bound by the time that I can spend on this  (my other
duties and deliverables), I can't test it as much as I like to for
in-loop change (in a time frame demanded by a dev in this ml). Because
this patch is not getting tested as it should be, my confidence for
the V2 patch is low .

2 perf testing
stress-ng is not stable in my test with Chromebook, and I'm requesting
 Oliver to take more samples [2] . This due diligence assures that
this patch accurately fulfills its purpose. The in-loop approach adds
complexity to the code, i.e. future dev is harder to understand the
sealing logic. Additionally, it sacrifices a security feature that
makes it harder for an attacker to modify mapping (currently if an
attacker uses munmap with a large address range, if one of the
addresses is sealed, the entire range is not modified. In the in-loop
approach,  memory will be unmapped till it hits the sealed memory).
Therefore, I would like to ascertain the gain.

3 mremap refactor work.
I posted mremap refactor work [3] , which is aligned with the
direction that we want to do in-loop change, and it also (imo)  a
better version of handling error cases for mremap across multiple vma
boundaries. That patch set can be applied on its own, and the test
cases added also enhance the existing selftest. I hope my patch can be
reviewed, and if passing perf test/approved, applied to mm first.

Thanks
Best regards,
-Jeff

[1] https://lore.kernel.org/linux-mm/20240814071424.2655666-2-jeffxu@chromi=
um.org/
[2] https://lore.kernel.org/linux-mm/CABi2SkXtZLojx3AQU4C=3D41NtBPGjVB2+fv_=
KWziOqyXRQ8P7Bg@mail.gmail.com/
[3] https://lore.kernel.org/linux-mm/20240814071424.2655666-1-jeffxu@chromi=
um.org/

