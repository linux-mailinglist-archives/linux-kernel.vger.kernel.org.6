Return-Path: <linux-kernel+bounces-280803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F194CF6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406C91C20E5A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F81192B9E;
	Fri,  9 Aug 2024 11:37:52 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A22156C4B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723203471; cv=none; b=IX2dBj+o/Bm/nWZwuyyA1tDJDeF45WisbQ2ZR6lmQQYnLzOAyBWVfYdfFGax7MsyGC8k9lpaYgIQdChThTEXUv+h7+PTDqQd3duKZ96Oa5UGH0rb2NL44ngosOlkC7Gr09WTYer69L/VURFnaTS0jEW3oy+5i4JF3z6wU96H98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723203471; c=relaxed/simple;
	bh=UKnv3qt71TRUHAIEpx4ccSeQrdf9tjRuUQuaqL+d3iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8NnWcnyE8PI+1ackW/1nDliA7XOftmWL4f6CQ+yzT/1k6iC340eKjobhp+ym50BZMDOu9XEXnTa7aJrxxkykkGd6A5FKSFoLFSZ6xuq9bl9IcMc3gX/N1S4xPgJkvrAv32j6mKzwSqxdrp4mGs3Vj577oBjmRUZUfCdMIxvW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-492a76c0cfbso663058137.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 04:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723203469; x=1723808269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh16YITXTl9Eb01hzhlulxj1Oq5rdHWKSMLv+K8fuS8=;
        b=pVTguXJJPYTEh9dvWD2+Aju1zGIGZc6d1Y50U3JsmBHBgJI6CglE+JgENU+4Jq0+QA
         T0eXKNTysQVDvBauQ9ytWlxogpFaDkhboO4oDKUR8Je8qoMcG8RwnnEBngfJO2aPndWi
         YIDgmGXWfj+gU8qA3MjM7fDQ1cs50ZdQo2SEdfKemtRX9uCJ4JOWq/RXC8XK7987ixgU
         +lg2kDUkWOSvs5k2ilnDEnVHoHq16tPTxH3onmwi/dxzFwrfDfW0vs/jD/Rgaz9RcWmr
         u8oDLPQCZtp+0hE3xwq0FQzHNSQUsJ47N2kaXFecPmrnHGurhT+vc8zt0JEI6Pn9g6y4
         jiKg==
X-Forwarded-Encrypted: i=1; AJvYcCUNm2JJ8fmMpPyjRqpBbpNTBaYSgypLyjpgSqe4trX+3SH5/37I+9A2SRarKG54OtRBrFBOlneCy9wHaZjceR8BNNVmXWikq/6h4I8b
X-Gm-Message-State: AOJu0YwREw9ca2LL6LaWr+PpwBBOuDqgeYpObBPeOHgYsC2HkZEuPmWu
	RyPh0A/tM3CxyArN0nyjBuZn1PrDp+3KDbFnv7H7dvqNzWM1aEapGSDY2cnMGUs26ofAhSTv47L
	fdO136/QEk/q6jGtEqSrfKSUzIks=
X-Google-Smtp-Source: AGHT+IGJbcA9q6wuj6x571tLC8WmW/6VG8C06JLOVWDbR1QVH6G9ZAulwnK/EdbGrlhIT2Ef+s3PXXJbeihQGRqZErI=
X-Received: by 2002:a05:6102:3e8d:b0:48f:df3b:9827 with SMTP id
 ada2fe7eead31-495d860bf5bmr1362174137.31.1723203468665; Fri, 09 Aug 2024
 04:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808101700.571701-1-ryan.roberts@arm.com> <99b78488-c524-4269-b1fb-a13eaa4f274c@redhat.com>
 <CAGsJ_4z2D2yWWZhUM_yDSdn9=zpkYkHhzAKO8CQ1Xu3gDaECRA@mail.gmail.com>
 <75eb6e75-8a6d-460a-8e96-7496ed1396b7@redhat.com> <3c8f00ea-af28-46c7-9a5d-83c4b9462be3@arm.com>
In-Reply-To: <3c8f00ea-af28-46c7-9a5d-83c4b9462be3@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 9 Aug 2024 19:37:36 +0800
Message-ID: <CAGsJ_4wkQxAUxBtk2Wps_n07-3gSNrg0CkhL5RRDtu2E=Q+Wng@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 6:37=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 09/08/2024 10:32, David Hildenbrand wrote:
> > On 09.08.24 11:24, Barry Song wrote:
> >> On Fri, Aug 9, 2024 at 5:19=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>>
> >>> On 08.08.24 12:16, Ryan Roberts wrote:
> >>>> Add thp_anon=3D cmdline parameter to allow specifying the default
> >>>> enablement of each supported anon THP size. The parameter accepts th=
e
> >>>> following format and can be provided multiple times to configure eac=
h
> >>>> size:
> >>>>
> >>>> thp_anon=3D<size>[KMG]:<value>
> >>>>
> >>>> See Documentation/admin-guide/mm/transhuge.rst for more details.
> >>>>
> >>>> Configuring the defaults at boot time is useful to allow early user
> >>>> space to take advantage of mTHP before its been configured through
> >>>> sysfs.
> >>>
> >>> I suspect a khugeapged enhancement and/or kernel-config-dependant
> >>> defaults and/or early system settings will also be able to mitigate t=
hat
> >>> without getting kernel cmdlines involved in the future.
> >>>
> >>>>
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>
> >>>> Hi All,
> >>>>
> >>>> I've split this off from my RFC at [1] because Barry highlighted tha=
t he would
> >>>> benefit from it immediately [2]. There are no changes vs the version=
 in that
> >>>> series.
> >>>>
> >>>> It applies against today's mm-unstable (275d686abcb59). (although I =
had to
> >>>> fix a
> >>>> minor build bug in stackdepot.c due to MIN() not being defined in th=
is tree).
> >>>>
> >>>> Thanks,
> >>>> Ryan
> >>>>
> >>>>
> >>>>    .../admin-guide/kernel-parameters.txt         |  8 +++
> >>>>    Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
> >>>>    mm/huge_memory.c                              | 55 ++++++++++++++=
++++-
> >>>>    3 files changed, 82 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> >>>> b/Documentation/admin-guide/kernel-parameters.txt
> >>>> index bcdee8984e1f0..5c79b58c108ec 100644
> >>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>> @@ -6631,6 +6631,14 @@
> >>>>                        <deci-seconds>: poll all this frequency
> >>>>                        0: no polling (default)
> >>>>
> >>>> +     thp_anon=3D       [KNL]
> >>>> +                     Format: <size>[KMG]:always|madvise|never|inher=
it
> >>>> +                     Can be used to control the default behavior of=
 the
> >>>> +                     system with respect to anonymous transparent h=
ugepages.
> >>>> +                     Can be used multiple times for multiple anon T=
HP sizes.
> >>>> +                     See Documentation/admin-guide/mm/transhuge.rst=
 for more
> >>>> +                     details.
> >>>> +
> >>>>        threadirqs      [KNL,EARLY]
> >>>>                        Force threading of all interrupt handlers exc=
ept those
> >>>>                        marked explicitly IRQF_NO_THREAD.
> >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst
> >>>> b/Documentation/admin-guide/mm/transhuge.rst
> >>>> index 24eec1c03ad88..f63b0717366c6 100644
> >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>> @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would=
 block
> >>>> the collapse::
> >>>>
> >>>>    A higher value may increase memory footprint for some workloads.
> >>>>
> >>>> -Boot parameter
> >>>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +Boot parameters
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> -You can change the sysfs boot time defaults of Transparent Hugepage
> >>>> -Support by passing the parameter ``transparent_hugepage=3Dalways`` =
or
> >>>> -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dneve=
r``
> >>>> -to the kernel command line.
> >>>> +You can change the sysfs boot time default for the top-level "enabl=
ed"
> >>>> +control by passing the parameter ``transparent_hugepage=3Dalways`` =
or
> >>>> +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dneve=
r`` to the
> >>>> +kernel command line.
> >>>> +
> >>>> +Alternatively, each supported anonymous THP size can be controlled =
by
> >>>> +passing ``thp_anon=3D<size>[KMG]:<state>``, where ``<size>`` is the=
 THP size
> >>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
> >>>> +``inherit``.
> >>>> +
> >>>> +For example, the following will set 64K THP to ``always``::
> >>>> +
> >>>> +     thp_anon=3D64K:always
> >>>> +
> >>>> +``thp_anon=3D`` may be specified multiple times to configure all TH=
P sizes as
> >>>> +required. If ``thp_anon=3D`` is specified at least once, any anon T=
HP sizes
> >>>> +not explicitly configured on the command line are implicitly set to
> >>>> +``never``.
> >>>
> >>> I suggest documenting that "thp_anon=3D" will not effect the value of
> >>> "transparent_hugepage=3D", or any configured default.
>
> Did you see the previous conversation with Barry about whether or not to =
honour
> configured defaults when any thp_anon=3D is provided [1]? Sounds like you=
 also
> think we should honour the PMD "inherit" default if not explicitly provid=
ed on
> the command line? (see link for justification for the approach I'm curren=
tly
> taking).
>
> [1]
> https://lore.kernel.org/linux-mm/CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-D=
t7Ewt3ExqTw@mail.gmail.com/
>
> >>>
> >>> Wondering if a syntax like
> >>>
> >>> thp_anon=3D16K,32K,64K:always;1048K,2048K:madvise
>
> Are there examples of that syntax already or have you just made it up? I =
found
> examples with the colon (:) but nothing this fancy. I guess that's not a =
reason
> not to do it though (other than the risk of screwing up the parser in a s=
ubtle way).
>
> >>>
> >>> (one could also support ranges, like "16K-64K")
> >>>
> >>> Would be even better. Then, maybe only allow a single instance.
> >>>
> >>> Maybe consider it if it's not too crazy to parse ;)
> I'll take a look. I'm going to be out for 3 weeks from end of Monday thou=
gh, so
> probably won't get around to that until I'm back. I know Barry is keen to=
 get
> this merged, so Barry, if you'd like to take it over that's fine by me (I=
'm sure
> you have enough on your plate though).

Yes, this command line is definitely needed. However, I also agree with
David that it might be worth considering options like '16K-64K' or '16K,
32K, 64K' after further reflection. For example, if users want to enable
six sizes, having six separate commands could end up being quite
silly :-)

I can address this after the mTHP number counters series.

>
> >>
> >> I prefer the current approach because it effectively filters cases lik=
e this.
> >>
> >> [    0.000000] huge_memory: thp_anon=3D8K:inherit: cannot parse, ignor=
ed
> >> [    0.000000] Unknown kernel command line parameters
> >> "thp_anon=3D8K:inherit", will be passed to user space.
> >>
> >> if we put multiple sizes together, 8K,32K,64K:always
> >>
> >> We can't determine whether this command line is legal or illegal as it
> >> is partially legal and partially illegal.
> >
> > Besides: I wouldn't bother about this "user does something stupid" scen=
ario that
> > much.
> >
> > But yes, once we support more sizes a cmdline might turn invalid on an =
older
> > kernel.
> >
> > However, I don't see the problem here. User passed a non-existant size.=
 Ignore
> > that one but handle the others, like you would with multiple commands?
>
> Yep, the parser could emit a warning for the size and move on.
>
> >
> > It can be well defined and documented. The command line is legal, just =
one size
> > does not exist.
> >
> > The world will continue turning :)

Right.

Thanks
Barry

