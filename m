Return-Path: <linux-kernel+bounces-382761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD89B130A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6CE1F22298
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6815821A;
	Fri, 25 Oct 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eH+aBNnp"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5BD217F53
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729897685; cv=none; b=mz7+VfPNLY41+QyWrRbTHIn1GJ1Hoi1xrdIYJ1ek8Tbysggka4DUVzeaTKfpIUd8JsS/4Qvl9SO97yu6w/o4Cn7fsRBWQ0Cxxj2ppZRRf5m/m8Enl++b2F/pgmXMx3iKZqUG8r1LIOv5N52rgx7gihopkZpYpWaGYCjrC+VSOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729897685; c=relaxed/simple;
	bh=dioHOgspXgn8WBLfYm3IB9/0M031QZWat5JanbwHpNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lB5lG/FmrR7SkGSs1vzbUeRgXR6VgXXTFWFYBqkxOS3ocgTx3Bg252EdBSdDNosT8IckCZC3UOWOrh1y+omNa6j0a+PDKsDZfBUC6+yF3b8LfF/NmQ16XH0Xp490cySw+IqOzS6EColqqz9Q0HsHre2+bsNyQkci11P1A5NHAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eH+aBNnp; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so39225ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729897682; x=1730502482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dioHOgspXgn8WBLfYm3IB9/0M031QZWat5JanbwHpNI=;
        b=eH+aBNnp2mAjnqIo6v8nwz2nPN7h1q7zqgDkuW12I6uUapoKNFtqfhUgAsyE7vrge5
         HAC6WLp5GXTEqzv9G5lZ7m2bOCd4mXw9Wq/xsHmi9DbMbM8bTXusL3RN8Vn3Az/HDe6X
         55aNK9AWtTdg3pJztXuRy4QaNoSmrss4iz6dk7mF4d306LlDGfeefOWy6e1kyyxfJ9oP
         n6amvU2dhmhQv5Nkvuq20lbZX9jUMLtqAq/WzxEe3TC7VEUMBZX79/A2b6tkJzJ8jVpy
         JHFABTJ3AEEZAapiM++2BtIg+IoF+UpzU2+cvBEHfHb7AMOBhUyVhBRltUBig3+qyxvA
         Km6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729897682; x=1730502482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dioHOgspXgn8WBLfYm3IB9/0M031QZWat5JanbwHpNI=;
        b=ddcyKRqNhZLxPuTSq2pmC0Bru0n0CSjPWXJ44N7A61TiYiHtkWwe+Wnlxw/ZHPmJrE
         G0VJym8LryUveYO9CJ4reBeBjna+0OAOjlbmtjAAtb1/muxJrbQsNUpwodg0+9iY7itw
         tX78cb/mZRsXUhHeFy3bplo7jEqcii3U09amvgYvUyOQgmiw43TUgvUzKmiHABZX2EYm
         voNguI11Ev9sCyBoIOldDF9DQ/O64j6gPDWvilgMQFegGBKMP3mtBIvJ8cQwXKCMqnXS
         rJFDn6sD3UBkl1Wuttjm20f4KAkh/Nr7Mb+TAIJ2TOI0rShl6JlC1oTooJvtK0hP4djM
         ZgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiTO6x1b/Ov1KgpfMz7M5LZ7UWaJeIUZv1m+I9p+5h47jDAT/PvnWCikNdlzSat5GKjDgL9jM4SOkW18E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPjCBc/UalMuaNhJWQDo/UiDXFBf+TOl6CgyykfO8Kaq/53XUP
	ZfpfByw3KRkFBLeGJT/83t6z+76NX6CsEZuXRefmo+TgQD+QvcT5U1/YTv6AqOJuIQVH0PlToUZ
	/d0/lE7WCBDsaMaeJDxVQrK2eJB++a+1+gce2
X-Google-Smtp-Source: AGHT+IFb2ltxix2BSNSfZxBJX543I/rzUf5h1gVm9KDMgl/8hLScyQ2v0KoDvVFfkgXjgleKOyLAXfjoWQ+NNdaXFmk=
X-Received: by 2002:a05:6e02:1b0f:b0:3a0:b0dc:abfc with SMTP id
 e9e14a558f8ab-3a4edfba94emr518235ab.7.1729897681833; Fri, 25 Oct 2024
 16:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022180623.463131-1-irogers@google.com> <Zxm5w6wXLxpbERZx@google.com>
 <CAP-5=fXfyd9b7Ns-SL5F+iffc7oy4NFHBsT3oj3CRMbBa1QCfg@mail.gmail.com>
 <Zxp4mbzsFyO5nUh7@google.com> <CAP-5=fWP-T57-Bb60eixhgO3m7f_v3y-tWmV=ypuR52iNSAQvQ@mail.gmail.com>
 <ZxvVuFqef2CLwtCs@google.com> <CAP-5=fVTU8nUfadXgpUd4my9emsY4c_7znMa9_RWD6VZbGYhZA@mail.gmail.com>
 <ZxwHHWbjIbGh1RU8@x1>
In-Reply-To: <ZxwHHWbjIbGh1RU8@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Oct 2024 16:07:47 -0700
Message-ID: <CAP-5=fX+m3KOR_c8v5=tzSbrsfE-C7_5B83ORjRoH2SQuJNA-g@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Hwmon PMUs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 2:01=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Oct 25, 2024 at 11:26:26AM -0700, Ian Rogers wrote:
> > On Fri, Oct 25, 2024 at 10:30=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > On Thu, Oct 24, 2024 at 06:33:27PM -0700, Ian Rogers wrote:
> > > > So I think moving the enum declarations into one patch is okay. But=
 as
> > > > the enum values have no bearing on hardware constants, or something
> > > > outside of the code that uses them it smells strange to me. Ultimat=
ely
> > > > this is going to do little to the lines of code count but damage
> > > > readability. I'm not sure why we're doing this given the kernel mod=
el
> > > > for adding a driver is to add it as a large chunk. For example, her=
e
> > > > is adding the intel PT driver:
> > > > https://lore.kernel.org/all/1422614392-114498-1-git-send-email-alex=
ander.shishkin@linux.intel.com/T/#u
>
> > > Maybe others can understand a big patch easily, but I'm not.
>
> > My understanding is that we make small patches so that the codebase is
> > more bisectable. When there is something new, like a driver or here a
>
> That is super important, having patches being super small and doing just
> one thing helps in bisecting problems.
>
> If two things are done in one patch, and one of them causes a problem,
> then bisection is a very effective way of finding out what exactly
> caused a problem.
>
> But bisection is not the only benefit from breaking down larger patches
> into smaller ones.
>
> We want to have more people joining our ranks, doing low level tooling
> and kernel work.
>
> Writing new functionality in a series of patches, growing in complexity
> is a way to reduce the cognitive load on understantind how something
> works.
>
> As much as trying to emulate how the kernel community works is a good
> model as that community has been producing a lot of good code in a
> frantic, athletic pace, and as much as I can agree with you that adding
> a new piece of code will not affect bisectability as its new code, I
> think having it broken down in multiple patches benefits revieweing.

Can you explain how, as asked, can separating the declaration of a
function from its definition aid in reviewing? As a reviewer, I want
to know the scope of a function and its documentation. Placing them in
2 separate patches doesn't benefit my reviewing.

> Reviewing is something we should do more, but its very taxing.
>
> One would rather try to write as much code as possible, leaving to
> others the reviewing part.
>
> But its a balancing act.
>
> Whatever we can do to help reviewers, like taking into account what they
> say they would prefer as a way to submit our work, even if it isn't
> exactly of our liking, is one such thing.
>
> So if Namhyung says that it would be best for you to try to break down
> your patches into smaller ones, like I did say to you in the past, even
> taking the trouble to do it myself, in the process introducing problems,
> later fixed, I think you should try to do what he says.
>
> He is the maintainer, try to address his comments.

I think I've written long emails addressing the comments. Just saying
too big (1) doesn't match how existing drivers are added (although
I've split the code many times so the addition is the smallest it can
be) (2) as I've pointed out makes the code harder to bisect, work with
compilers and understand.

I think there is far too much developer push back going on, it feels
capricious, I'm lucky as I'll just go push into Google's tree. I'm
only persisting here for upstream's benefit and ultimately my benefit
when I pull from upstream. Perfect shouldn't be the enemy of good, but
frequently (more often than not for me) reviewer comments aren't
improving the code they are significantly stalling it:

1) parallel testing
https://lore.kernel.org/lkml/20241025192109.132482-1-irogers@google.com/
1.1) pushed back because it used an #ifdef __linux__ to maintain some
posix library code (a now dropped complaint)
1.2) pushed back for improvements in test numbering, addressed in:
https://lore.kernel.org/lkml/20241025192109.132482-11-irogers@google.com/
not an unreasonable thing to do but feature creep. Hey we'll only take
your work helping us if you also add feature xyz

2) libdw clean up
https://lore.kernel.org/lkml/20241017002520.59124-1-irogers@google.com/
Pushed back as more cross architecture output would make the commit
messages better. Doesn't sound crazily unreasonable until you realize
the function that is being called and needing cross platform testing
is 6 lines long and only applies when you do analysis of x86 perf.data
files on non-x86 platforms. We heavily test the code on x86 and the
chance that cross platform testing will show anything is very small.

On the other hand I can point at unreviewed maintainer code going into
the tree and code where I've pointed out it is broken, from a
fundamental CS perspective, it is also taken into the tree.

RISC-V has been damaged and now in the driver they are trying to
workaround the perf tool. There were already comments to this effect
in ARM breakpoint driver's code.

On Intel we now have TPEBS (which took far far too long to land)
behind a flag which means we've made accurate top-down analysis
require an additional flag on all newer Intel models, something I
pushed against.

So the reviewing is inconsistent, damages the code (a maintainer may
disagree with the reviewer and developers saying otherwise but the
maintainer has to be followed to land) and is constantly stalling
development. Fixing reference counting took years to land because of
endless stalling, any reasonable developer would have just given up.
It is hard to imagine the state the code base would be in without it.

Of the patches I've mentioned how many are code health and how many
are a feature I can say working on is part of my day job? I see a
deliberate lack of understanding of what a developer needs. To say
I've not tried to address comments, I'd say 90% of the noise on
linux-perf-users is me resending patches, mine and others, to address
comments. Here I've made the patches a size that makes sense. I can
move the enums, which feels like a compiler error along the lines of
"static function defined but not used" but beside this, changing
evsel's name meaning to make it part of the event encoding is imo
wrong, having separate patches for a function declaration and then 1
for its definition, can you imagine taking this to its extreme and
what the patches would look like if you did this? In making things
smaller, as has happened already in this series, it is never clear you
will hit a magical maintainer happy threshold. Knowing how to make a
"right" patch is even harder when it is inconsistent with the rest of
Linux development.

Thanks,
Ian

