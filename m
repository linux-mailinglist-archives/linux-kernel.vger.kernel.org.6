Return-Path: <linux-kernel+bounces-286739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB813951E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4701F22855
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315C01B4C2B;
	Wed, 14 Aug 2024 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwzuGb4R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E21B3F15;
	Wed, 14 Aug 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648807; cv=none; b=cnQagAApNRaP2Krmd1zA2Cg4yrT4Ck7mD8JYOznyD6dMWlnwT+dUZxpibpiIUh2cXJDQD0vHt69LKNGmxIeCzXEKoQ95FDiBC2KW7IkP43+g+wELCE8F87tpOitKjACcM1iXCbtb0wetoyDhnY5KYOxdu71TiRQWodmx+ArKSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648807; c=relaxed/simple;
	bh=Rj0Ty5Riptip5Jd6/pl5u26hdJH9Oacy9vcIguusznY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfU0IkgpGLFVWL00vzcbjRBkAmXjYrxqDF8Dd6RbGBCGCuQiHHA3Q9Neryxp0fH5DbTbTI6OEG9denErxpsfPOKFf/Oc5pph05PCuKEKq4c5U2SyDVg7OqgtAcZVB1Iu877Ajddf6ugP0rNEW7sw9X6N8e22oHqY228roHWSGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwzuGb4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B85C116B1;
	Wed, 14 Aug 2024 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723648807;
	bh=Rj0Ty5Riptip5Jd6/pl5u26hdJH9Oacy9vcIguusznY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwzuGb4RYXXSBBwDYYQ3d26EADzhf+ugxhNL103SL+RZj7UIOG9khQhOYi+pW3aOT
	 qZcw0NR4y0Kw4cBsAcYXpqWesVbytbZrkpWNwbEkeTtli59pH87TC660QZipopc1/4
	 ufTLRjFfd5bVY8CAYBUpI/S8ToCqmsnO/U1zLUK5hRWnQNhRaIYnU9U9Y2RzAWQVZx
	 YpHJDN9ahuE+yOZWFX3BzTeAZqLs/EqK2QDltCotWcVMVMc6LbbJojCZKohrx3LHwG
	 gRdRlko+D2WJC3W7FJz3iFsaEaTccPbGrA1lOF1RWAuiZQ9yOG58waHK+yDTh5yVNu
	 PNVG/RWB6/0Dw==
Date: Wed, 14 Aug 2024 17:19:58 +0200
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
Message-ID: <ZrzLHu5Ey9vLwNJg@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-5-dakr@kernel.org>
 <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>
 <Zryy04DvEsnxsRCj@pollux>
 <CAH5fLghsONUtxFPgD6vC139H-Uj5LDju7w5eS0JB+BnDMmfngw@mail.gmail.com>
 <Zry1qwJnPDUtp2Nw@cassiopeiae>
 <CAH5fLgjNfJyyZygWzeTyrNi8TQNAquufxFxDgJHzq6dan=b9BQ@mail.gmail.com>
 <Zry4iOGtR0nd6lNP@cassiopeiae>
 <CANiq72nsSOaG=WhGP5GUQ=ygCh23iDQBc0kgjRP3B5MoF0CUjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nsSOaG=WhGP5GUQ=ygCh23iDQBc0kgjRP3B5MoF0CUjg@mail.gmail.com>

On Wed, Aug 14, 2024 at 05:03:21PM +0200, Miguel Ojeda wrote:
> On Wed, Aug 14, 2024 at 4:00 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > If we keep them, we'd consequently also need to add them for vrealloc() and
> > kvrealloc(). But again, they don't do anything for us, and hence are more
> > misleading than helpful IMO.
> 
> In general, they could do something (e.g. `noreturn`), perhaps in the future.

Indeed, and I think once they're honored we should add them again.

It's just that I think as long as compiler attributes aren't honored, we should
not have them in the first place to avoid confusion about whether they do or do
not have any effect.

> 
> Apart from being potentially misleading, do we gain something by
> removing them?

It's not so much that I want to remove them for krealloc(), it's that I don't
want to intentionally add them for the vrealloc() and kvrealloc() helpers,
knowing that they don't do anything (yet).

And I think it's even more confusing if the krealloc() helper has those compiler
attributes, but the vrealloc() and kvrealloc() helpers do not.

> I guess simplicity in the file, but it is also simpler
> to keep them aligned to the C side (which I guess is Alice's point),
> and avoids having to keep track of what could have a present or future
> impact in `bindgen`.
> 
> Cheers,
> Miguel
> 

