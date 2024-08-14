Return-Path: <linux-kernel+bounces-286931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565DF95208E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8845E1C22E11
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786601BB69B;
	Wed, 14 Aug 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZBQo54L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AC1B1409;
	Wed, 14 Aug 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654626; cv=none; b=d8QsBlCcl7X3ER9kw81v1Xpvk+1TFPttYYsmXp1cRnD1kW+WmRdcVOLE0Dw8hyxI5n0qSNoc7pdSARFj1w7tEXgM4pQFkr8Kn/QE/Wv07Yar3IVnGX7XG9OmdijPk+OH9eyrY26EkIasT7q4HfL61PvPLJsMUkDCv+whB38gPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654626; c=relaxed/simple;
	bh=7qQlTpMuGngTf5mDhK/HSkbSaWAoRr/xpzL3hhsR3ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+fGV21lF3ZDbFaAVU/2NcX5zGYbYVcka2btj4x+E1PSxF/uW9h1QEgMdEbFotnT+JM/lrOUDLP2axLfSquWUnJIJxdKPmlk5uS+2hR34dynbt3yRga01WZANeLW8g0J+kXSq0VccebMIO7tmvHi7cazHMsraXxb51DuGVXfP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZBQo54L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52417C116B1;
	Wed, 14 Aug 2024 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723654626;
	bh=7qQlTpMuGngTf5mDhK/HSkbSaWAoRr/xpzL3hhsR3ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZBQo54Ldmxg87PkvleJ+POeP8Y6RZUQ2mkXVHmobhrQD65DrnnWvK4Cb4aFa4S5N
	 cIS+BStvKnBa1Olj3PHcE1We1HWsBgxaLJgBINGPxmNwSQL3i8OM1XdiXCSSWKWUir
	 keafaRtrdrgs8YFjRpVqWpUm1mSePfNn66Fndpqqbk63iVoTKZKPfgfvu2nzw491QW
	 POylZySURYJJLBBMsfh7dyxs3uDosjV3iAdGDcfJgm+n+crKhcSxZQC9WUj7Xibyaw
	 MDmpfPsUNBplRRLDz9hCfLMmEmJfdnpRHh7f6e+1LbNKw9g5K429dMwzjUxsomDCAC
	 r0KVLEV3Vydbw==
Date: Wed, 14 Aug 2024 18:56:58 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <Zrzh2g1AgDm9rfo8@cassiopeiae>
References: <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>
 <Zryy04DvEsnxsRCj@pollux>
 <CAH5fLghsONUtxFPgD6vC139H-Uj5LDju7w5eS0JB+BnDMmfngw@mail.gmail.com>
 <Zry1qwJnPDUtp2Nw@cassiopeiae>
 <CAH5fLgjNfJyyZygWzeTyrNi8TQNAquufxFxDgJHzq6dan=b9BQ@mail.gmail.com>
 <Zry4iOGtR0nd6lNP@cassiopeiae>
 <CANiq72nsSOaG=WhGP5GUQ=ygCh23iDQBc0kgjRP3B5MoF0CUjg@mail.gmail.com>
 <ZrzLHu5Ey9vLwNJg@cassiopeiae>
 <CANiq72=u5Nrz_NW3U3_VqywJkD8pECA07q2pFDd1wjtXOWdkAQ@mail.gmail.com>
 <CANiq72k-haQ5dnUcNx5h1bE1J6_K=K3X+aqv7qJ2K6nag8izyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k-haQ5dnUcNx5h1bE1J6_K=K3X+aqv7qJ2K6nag8izyA@mail.gmail.com>

On Wed, Aug 14, 2024 at 06:16:34PM +0200, Miguel Ojeda wrote:
> On Wed, Aug 14, 2024 at 6:02 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > I checked about `__must_check`, because it would be nice if it is used
> > by `bindgen`, and it turns out it already does, but behind
> > `--enable-function-attribute-detection` (apparently for performance
> > reasons):
> 
> I just tried, and the flag seems to work, gives us a bunch of
> `#[must_use]`s which are nice, and apparently no other change (in
> usual x86_64 config at least).

Cool! That's even better then.

> 
> I don't notice any significant performance difference in our case, so
> I will send a quick patch to see if others find an issue with it.
> 
> Cheers,
> Miguel
> 

