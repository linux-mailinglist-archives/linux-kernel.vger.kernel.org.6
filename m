Return-Path: <linux-kernel+bounces-446112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F329F2001
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D631667C2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D47D3F4;
	Sat, 14 Dec 2024 17:09:56 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB12E62B;
	Sat, 14 Dec 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734196196; cv=none; b=IomSm2C51SvKz5cWRNcXACggAboTOUbn4hRVMh9JKbSPqdCRRo4BoaoVEPe8zuw5ITpnVBfN5bNCjaM7YQWIwXt9JMK4hTCBkETw1Kzdqfzc8WvwXGNv1XSUWXyJjX1tNYLiaOgCniU+IISqdNx/z0VM/mKckBTZQajokCE1uv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734196196; c=relaxed/simple;
	bh=sVoEF06w0uwW668Gd/gZop7mzXj5pAnHzHScpumaj/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GedKHtfGLtPw7OxuG2SIx/WZbCwDnJ+p1Kv1IvlEVtg3LnHc5clWdf6pttcQbuqSWc3aZyZZ7nyfpmKtVSk8/XAhe0CBTCAM7PWMfn4aqfe8edvuP/WCA2V4URY1NA3SE9xC+lVR1YWqzfJvbLlWIPB6+eV0ezpLwHCgB58qKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4BEH9TZ8013015;
	Sat, 14 Dec 2024 18:09:29 +0100
Date: Sat, 14 Dec 2024 18:09:29 +0100
From: Willy Tarreau <w@1wt.eu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Rust fixes for 6.13
Message-ID: <20241214170929.GA12917@1wt.eu>
References: <20241214065217.195385-1-ojeda@kernel.org>
 <CAHk-=wgXdJswe7JWZ2G6m11rL4Yxatrz_iFBKpqCO5xHPwMyJA@mail.gmail.com>
 <CAHk-=wiHC9ATW72NVqM64kFjcO9BhMR+Hh1oLJrn0PZ7xcK3LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHC9ATW72NVqM64kFjcO9BhMR+Hh1oLJrn0PZ7xcK3LA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Dec 14, 2024 at 08:59:04AM -0800, Linus Torvalds wrote:
> On Sat, 14 Dec 2024 at 08:54, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. Is it just me, or has github become almost unusably slow lately?
> 
> Just to clarify: it did end up working in the end. But even an empty
> pull - when I retried the pull after merging - took two and a half
> minutes.

Same here trying from your github mirror. It took 30s before even
starting the transfer of a few objects but the transfer itself was
fast. Probably a transient backend issue.

Willy

