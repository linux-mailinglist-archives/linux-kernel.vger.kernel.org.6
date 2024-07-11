Return-Path: <linux-kernel+bounces-249341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E0692EA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987701C219CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12A9166317;
	Thu, 11 Jul 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxIVo3Zu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AA15ECE6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706900; cv=none; b=KmlPM/Mw0RvHiYe63jp9oOkwZ2JBeeNsghEEg83mLCEODUFtAXjw3pl67HA+xH2jPrgc8IH4QMhkwrAo6PHl2c3CKFOm32jtOGsJmxe5vacfl0WP8wIzMZ+E3407GKMWsXCRV5tN1m6OJV014BCyR0x80iEjsb8Dj9859Ob2fR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706900; c=relaxed/simple;
	bh=Jb9JnMiieeILvb3iq79QDI4ghaEx9ENNV87tSbXIO30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6wbpCzCwBBh2V52S1OoJzBSGkkoIymZ3e/iJbGi+o1pfPmSeEv+/FOo3YyQ2NydTA42oU+Ta3Jv3QA1Ol7o413OCkwhhcIiqRZ/2yahDBC63PvRIQmOHn5xBmn1DvR0wft5AnA6PiuKL3C00f0WZYbDqqv+Sl0/plWhhS/RqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxIVo3Zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C092AC4AF15
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720706899;
	bh=Jb9JnMiieeILvb3iq79QDI4ghaEx9ENNV87tSbXIO30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JxIVo3ZusX0rtXH16yosijmPc0RYiPMnR3w7xpHuDYV+ww1WbIpkZ/TRSis2rRoFx
	 cy+npKZrw///G6PjhK6BqlDLTLC6vvNlw+HayC6ifwXcLIo/we3/sN2FX9lXEFHi03
	 WEPNMB19P+XCusTTAmgCZVVesEYxm+jT0ckJfismAq68gri0YPFqjfTY4CsqzBlT6i
	 B4wR7aVO292c3fqe8NgCluSqWt3pYP0cCyY2gvpFU1pKblcu2ToRSFgBVNe0mPlJMs
	 T/Y5nfK+aHa3muyk3FMt0DWXqPRVCAWSwA8siF+HL0pf6gmmL3ML5OLNK5sAbynFnI
	 6j9mJTgxG1wAw==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-64b29539d86so8462317b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:08:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKYKnXTReYsADf+YikFu0IsG6MDGN+s50DAifC4+HO623mGo8ELJEBIlYOSUYZ0ciDIun/S8oJcqHvPw4Uc75FUNZ0bFZDfi0Qj0pz
X-Gm-Message-State: AOJu0YxD+Wy6TTr2deIdcJ80EMH+qoXu3Rqgpy+x9HOAlJrbSgA01d8B
	/6wrjgWOmHU3jh5ZtHzFXNN3Jx7FdhcNFSumou/uoM9vWxoBSkazyhVeUg5lcbf+5OzJaujaQlB
	PEtC+K7qKP9n2/lacsLG+BohNhTJLdCE22J9Z9A==
X-Google-Smtp-Source: AGHT+IHLoq/PTQeo3FQR4YjukSl2GTGwepIgYGhvIjDE5lql7zyOsHBtLjiLNAk1bE2UcXtQlFM7ZTdzXIb2GOt5kMk=
X-Received: by 2002:a81:6982:0:b0:627:a917:bae7 with SMTP id
 00721157ae682-658ef43fb82mr85019617b3.30.1720706899028; Thu, 11 Jul 2024
 07:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org> <ae6b4885-0590-4585-a1fd-39b64df2f902@arm.com>
In-Reply-To: <ae6b4885-0590-4585-a1fd-39b64df2f902@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 11 Jul 2024 07:08:07 -0700
X-Gmail-Original-Message-ID: <CACePvbX99r8BNZTkax=KGBx-XYP6WLxZKez3qsi+FfreC2TwGg@mail.gmail.com>
Message-ID: <CACePvbX99r8BNZTkax=KGBx-XYP6WLxZKez3qsi+FfreC2TwGg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm: swap: mTHP swap allocator base on swap cluster order
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 3:02=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> > Kernel compile under tmpfs with cgroup memory.max =3D 2G.
> > 12 core 24 hyperthreading, 32 jobs.
> >
> > HDD swap 3 runs average, 20G swap file:
> >
> > Without:
> > user  4186.290
> > system        421.743
> > real  597.317
> >
> > With:
> > user  4113.897
> > system        413.123
> > real  659.543
>
> If I've understood this correctly, this test is taking~10% longer in wall=
 time?

Most likely due to the high variance in measurement and fewer
measuring samples 3 vs 10. Most of that wall time is waiting for IO.
It is likely just noise.

> But your changes shouldn't affect HDD swap path? So what's the reason for=
 this?

The change did affect HDD swap path in the sense that it did not need
to check for si->cluster_info any more. A small gain there.

The wall clock time is more than double the SSD or zram. Which means
most of the time the system is waiting for HDD IO to complete (wait is
98%) , there will be much higher variance for sure. At this point the
wall clock we are measuring the wait mostly,  not the actual work. The
system time is quicker, that is good.

I now have a dedicated machine to run the HDD swap now. The HDD is
very very slow to swap. The point of the HDD test is being able to
complete the run without OOM. Because of the high latency in HDD,
there will be more memory pressure. It did catch some other bugs in my
internal version of the patch.

> I'm hoping to review this properly next week. It would be great to get th=
is in
> sooner rather than later IMHO.

Thank you. This new code path is much easier to work with than the
previous SSD and HDD mixed allocation path. I am able to implement the
cluster reservation experiment in the new allocator much quicker.

Chris

