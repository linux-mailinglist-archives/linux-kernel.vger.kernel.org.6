Return-Path: <linux-kernel+bounces-533487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF341A45B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419283AAD54
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A32238165;
	Wed, 26 Feb 2025 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgVsLb6a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C67258CE0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564453; cv=none; b=BIieRzYdKHgcRNThziDSvMQ1stYyX+Ljw60nL1ruf9bkgbR+Tblwtb/qYM8HhSwS7jRo57GIY73mhRtzJGI1qJ3OlMYZAipnrbjrWXWmQ4jwGCG3yXDa2mrDQXcnqHN58R2ISsYxhUXfvO1nmcvkK9jq7PvjtE9/TIeTWx+zH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564453; c=relaxed/simple;
	bh=AyAHIQeVxV7KJDnqLXHbeSFECRBR40Nsmn5QJdOcsts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDPSQZf1IhhHfVpvqpd7HTvACanybqpa3GpqmwZ5h80hTSt4857MaOveg1NDkrr2QelNJizl1izz1d6tvMZfu0XFqjX37FRXx8U+xUVRhk5DAcOVE4/ydFr5Ges3arHASKtDDYZqweP5fxOJRRmBzoxD1/nUoUJ9qHaQ691xqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgVsLb6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5892C4CEE2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740564452;
	bh=AyAHIQeVxV7KJDnqLXHbeSFECRBR40Nsmn5QJdOcsts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LgVsLb6ae+6LZxYgCVoI/D5XVgpm6Cz/p1SVdgYH18ndzrPdcLpBd+x3IDZU8Go8i
	 gGsnx3pAaSA8BxbaCutK6L5h9gBJkAwR7r38p/ljcw1QNlBMAVOhCjwkXg3KFr9lHi
	 Ul2GZK+GzGGoiuQYETJDEcBLGN3Z+m8s5dDA2AbmI1lDST3qmHUQHAEnNS28xYlYGX
	 Fmrv/oTt00u+8w/a8YOqJsUDnfXvXhxcchOxz+kZj1dvVJyq1AofUSoouMf7NhXs2x
	 X1q8NGBNLy+b1ojpKIQ4N9tH79OIMMsbRCsRT6go97QHSd9PL1iT3Ii8UqEsEkG/Yi
	 TNLsxJK37cyRQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3072f8dc069so68635861fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:07:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUt6Nqielxyhdswi+e8junSQ4vOpKOM/B18moLkx9SrUlKCk7k1RtjJSOGqb5YuWgC/Tghd4rlzPvJIqg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpceEmqzsZ+IWOPEzXFiYa2mMImh3Zd0wuOtn0725iXBQg3eqO
	jrSGCWiKnYVa6Eoz3qSTrvScivQpt8wYZOIuCeG7OAQMsKKndN1dsaq7BUalcp2YA51liRdx3yD
	JJIuVRWYfy4GLZH3LXgSmetPS7Og=
X-Google-Smtp-Source: AGHT+IH77s07/831v/UsWRW9X8Qt2tEO6lngODAKoum/ihUKwQXpXxPbkOfYTJKPMisMdLAWL73xuBPJxdwhVpBZ4kk=
X-Received: by 2002:a05:6512:234e:b0:543:e406:6363 with SMTP id
 2adb3069b0e04-5493c570ed1mr2417228e87.3.1740564451208; Wed, 26 Feb 2025
 02:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
 <CAMj1kXHNO+iB4vNFz-4tR_9CPzv96hn+RW=eqyZXMGy_AySDpw@mail.gmail.com>
 <20250226001047.GA24197@willie-the-truck> <CAMj1kXH=tPuM+irCsKgycUTbts8h9vD4m3tEtw51YFzWafdSUA@mail.gmail.com>
 <b0578d21-95cd-4d8a-add1-87299f36b491@arm.com> <CAMj1kXHJGC9aYCwwb2XTWfhAjH6GDKQptNdLwO+hfv6hazivHQ@mail.gmail.com>
 <b6b999c9-79cd-4945-9d7a-c5ee8158b7dc@arm.com> <CAMj1kXHesY77QhnW_U19UURGUqiBuQrNcL-kWQs7niaMa4nAng@mail.gmail.com>
 <2c465bdf-8028-4b05-8e18-3154735ce906@arm.com>
In-Reply-To: <2c465bdf-8028-4b05-8e18-3154735ce906@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 26 Feb 2025 11:07:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGQSFh9A_uK6-i1-sd59i+yKg3vZxD+cYQ_vyz-HZJZKg@mail.gmail.com>
X-Gm-Features: AQ5f1JqAlass0uE8mVVRnhELpOjzjIKuYqX8xCtGGpSz6emoBSwU3fQmwrmDzrg
Message-ID: <CAMj1kXGQSFh9A_uK6-i1-sd59i+yKg3vZxD+cYQ_vyz-HZJZKg@mail.gmail.com>
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Luiz Capitulino <luizcap@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 10:45, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 26/02/2025 09:04, Ard Biesheuvel wrote:
> > On Wed, 26 Feb 2025 at 09:55, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> On 26/02/2025 08:33, Ard Biesheuvel wrote:
> >>> On Wed, 26 Feb 2025 at 09:07, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>>>
> >>>> On 26/02/2025 06:59, Ard Biesheuvel wrote:
> >>>>> On Wed, 26 Feb 2025 at 01:10, Will Deacon <will@kernel.org> wrote:
> >>>>>>
> >>>>>> On Tue, Feb 25, 2025 at 07:05:35PM +0100, Ard Biesheuvel wrote:
> >>>>>>> Apologies for the breakage, and thanks for the fix.
> >>>>>>>
> >>>>>>> I have to admit that I was a bit overzealous here: there is no point
> >>>>>>> yet in using the sanitised value, given that we don't actually
> >>>>>>> override the PA range in the first place.
> >>>>
> >>>> But unless I've misunderstood something, parange is overridden; Commit
> >>>> 62cffa496aac (the same one we are fixing) adds an override to force parange to
> >>>> 48 bits when arm64.nolva is specified for LPA2 systems (see mmfr2_varange_filter()).
> >>>>
> >>>> I thought it would be preferable to honour that override, hence my use of
> >>>> arm64_apply_feature_override() in the fix. Are you saying we don't need to worry
> >>>> about that case?
> >>>>
> >>>
> >>> I wouldn't think so (but I'm glad you brought it up because this
> >>> didn't occur to me at all tbh)
> >>>
> >>> With arm64.nolva, both the VA and PA ranges will be reduced, and so
> >>> the range of the linear map will be 47 bits. So if the PA range is
> >>> being reduced from 52 to 48, it will still exceed the size of the
> >>> linear map, and so it should make no difference in this particular
> >>> case.
> >>
> >> OK, so I think you're saying it'll happen to work correctly even if we ignore
> >> that override? That sounds a bit fragile to me. Surely we should be consistent
> >> and either always honour the override or remove the override in the first place?
> >>
> >
> > I'm trying to walk a fine line here between consistent use of the
> > override, and fixing something that I broke in a nasty way all the way
> > back to 6.12.
> >
> > So yes, I agree that it would be better to use the override
> > consistently, and this is what we should do going forward. But the
> > purpose of the original patch was mainly to ensure that we
> > consistently program the MMU either in LPA2 or in non-LPA2 mode, and
> > not in a mix of the two. The linear mapping randomization change was
> > kind of secondary.
> >
> > So perhaps this should be two patches:
> > - backing out the use of the sanitised register, as proposed by Will,
> > with cc:stable
> > - a follow up based on your proposal, which can be backported later if
> > needed, but without tagging it for stable.
>
> I suspect I'm misunderstanding something crucial about the way the linear map
> randomization works (TBH the details of the signed comparisons went a little
> over my head).
>
> But my rough understanding is that there are 2 values you want to compare; the
> size of the linear map and the PA range. If the PA range is significantly bigger
> than the linear map size then we conclude we have enough room to randomize.

It is the other way around: the linear map should be able to cover all
system RAM that may appear anywhere in the PA space, and so if the PA
space is very large (and memory hotplug is enabled), no randomization
is possible, as it may end up mapping RAM that appears later past the
top of the VA space. Note that the same is fundamentally true for
running a 39-bit VA kernel on hardware that has a PA range that
exceeds that.

As for the signed arithmetic: the randomization works by substracting
from memstart_addr (aka PHYS_OFFSET). Normally, if system RAM starts
at 1G, memstart_addr will be 1G, and the linear map will associate
PAGE_OFFSET with PA 1G.

To randomize the linear mapping, the system RAM has to be moved up in
the linear map (as this is the only direction it can be moved), and so
PAGE_OFFSET needs to map to a lower value, and so memstart_addr may
wrap around and become negative.

> (I
> think this assumes that VA size is always GTE PA size). But if linear map size
> is based on an overridden VA and overridden PA size (which I assume it must be,
> given the pgtables will be limitted to the overridden VA size) and PA size is
> not overridden, isn't it possible to wrongly conclude that there is enough room
> to randomize when there really is not?
>

No, if the linear map is only 47 bits, and the PA space is either 52
or 48 bits, no randomization is possible. We might even run out of
space without randomization, but this is an existing problem for
non-LPA2 too.

