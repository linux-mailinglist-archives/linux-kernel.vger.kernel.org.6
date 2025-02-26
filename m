Return-Path: <linux-kernel+bounces-533383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C93EA4595F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A763F1897529
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29B421018A;
	Wed, 26 Feb 2025 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpY84Sbr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E04A1E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560671; cv=none; b=YhnbmTjJy8GinG0YXCnjB2YidMPRSXnPqiOS9+bfOG12+dCdqde0IWWmObmijojLcJktL6YJQ6Zdsq4OrgGotUA2ermYU3JdLQw8KKjE+P6KlCTvD9n6EOSoE4bfOvEs2VTuL5nh0wBbTHrAnxvmz2mwod81qoF4NJQ3qmhJlnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560671; c=relaxed/simple;
	bh=MD0s8HGGD8J7+lciKNl/Dj0IVQMHtZI/veSSn91yDAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzXaqi2PQgu2002Xy0H4EuRmvxQ32aRTnz9cGHo4NaurLDMad3UKZ1gWxdktlSOSwihWrDp4o/I6VH3uqTn/beFJMuUehVieIB9rfmAALh+kue9KTFIr/XNzPdSufGFVzcIVPI8FvsS3a/flnV0s1WclskcHZsU7HBhWBjJcebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpY84Sbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FD8C4CEEA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740560670;
	bh=MD0s8HGGD8J7+lciKNl/Dj0IVQMHtZI/veSSn91yDAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qpY84Sbr9g2qMB5LpdWBYhYb86hEqiaZfFe8Pul97DbGo4arUpU0VqK6XJuR0yacG
	 xg/0dhrviLlfnNoowf2MLLdyN/LYA7dAoNKQDJiC0PbdjyE7QaKM+pBuLLfaKPSmyw
	 BTYXASKJViFxl8fW0Rmcv1soBmpW3LVkgTMBJKwBQihLvpnOT24ZxOykrxtrun6Xqi
	 dRPG9ETqyuuuS1mckMGI3vIhkMHFUoB+1pafBzFAvXEE0/GEvNS4UlW/FeTfrPC9YD
	 uXPnOIhxvnMMz5QVTwesDxdzzDn78ZUbkxDFiRodt8ObVncAJQ5CMzf4NIXMG0lucc
	 oMVZcy8NNB+Ow==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30762598511so60475541fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:04:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMaNB+x5a+vs+VXfu8o0W47w3mqaKUv0bU+Y7e9L28+lE3Ila63Je1/HB891mqhp8l9KZfTiFVl9f0V5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGoCPLqHZGuy+YY0m+hRoZkkUYB1nPRIXk4C7fHwaNPOu1n0l
	iOb+r8sUtaBcUPJhnmo6oOggRNyaS/l6GZrw/Q8wc5BfDQVCJKwFaEuE5io1XyPAuQvQhu7u3PD
	pNgavJ6pceocpyPf9yJos0oQOhN4=
X-Google-Smtp-Source: AGHT+IFHUd8UZ5R1CLstTqMjiedgx3Q3D8X50coztIK4yq6AvKMcncp/jJN6WT7urLudiLMShTcy6Zi/2hNgC+d8sm4=
X-Received: by 2002:a19:5f0e:0:b0:545:2e90:8dd7 with SMTP id
 2adb3069b0e04-548510ed6eamr3922564e87.45.1740560669010; Wed, 26 Feb 2025
 01:04:29 -0800 (PST)
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
 <b6b999c9-79cd-4945-9d7a-c5ee8158b7dc@arm.com>
In-Reply-To: <b6b999c9-79cd-4945-9d7a-c5ee8158b7dc@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 26 Feb 2025 10:04:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHesY77QhnW_U19UURGUqiBuQrNcL-kWQs7niaMa4nAng@mail.gmail.com>
X-Gm-Features: AQ5f1JrFPO-oVdrkA8BHx4fjAtsnwSoQhhBMdSRuNrnZUrJasIlp_A81Niyew-Q
Message-ID: <CAMj1kXHesY77QhnW_U19UURGUqiBuQrNcL-kWQs7niaMa4nAng@mail.gmail.com>
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Luiz Capitulino <luizcap@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 09:55, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 26/02/2025 08:33, Ard Biesheuvel wrote:
> > On Wed, 26 Feb 2025 at 09:07, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> On 26/02/2025 06:59, Ard Biesheuvel wrote:
> >>> On Wed, 26 Feb 2025 at 01:10, Will Deacon <will@kernel.org> wrote:
> >>>>
> >>>> On Tue, Feb 25, 2025 at 07:05:35PM +0100, Ard Biesheuvel wrote:
> >>>>> Apologies for the breakage, and thanks for the fix.
> >>>>>
> >>>>> I have to admit that I was a bit overzealous here: there is no point
> >>>>> yet in using the sanitised value, given that we don't actually
> >>>>> override the PA range in the first place.
> >>
> >> But unless I've misunderstood something, parange is overridden; Commit
> >> 62cffa496aac (the same one we are fixing) adds an override to force parange to
> >> 48 bits when arm64.nolva is specified for LPA2 systems (see mmfr2_varange_filter()).
> >>
> >> I thought it would be preferable to honour that override, hence my use of
> >> arm64_apply_feature_override() in the fix. Are you saying we don't need to worry
> >> about that case?
> >>
> >
> > I wouldn't think so (but I'm glad you brought it up because this
> > didn't occur to me at all tbh)
> >
> > With arm64.nolva, both the VA and PA ranges will be reduced, and so
> > the range of the linear map will be 47 bits. So if the PA range is
> > being reduced from 52 to 48, it will still exceed the size of the
> > linear map, and so it should make no difference in this particular
> > case.
>
> OK, so I think you're saying it'll happen to work correctly even if we ignore
> that override? That sounds a bit fragile to me. Surely we should be consistent
> and either always honour the override or remove the override in the first place?
>

I'm trying to walk a fine line here between consistent use of the
override, and fixing something that I broke in a nasty way all the way
back to 6.12.

So yes, I agree that it would be better to use the override
consistently, and this is what we should do going forward. But the
purpose of the original patch was mainly to ensure that we
consistently program the MMU either in LPA2 or in non-LPA2 mode, and
not in a mix of the two. The linear mapping randomization change was
kind of secondary.

So perhaps this should be two patches:
- backing out the use of the sanitised register, as proposed by Will,
with cc:stable
- a follow up based on your proposal, which can be backported later if
needed, but without tagging it for stable.

