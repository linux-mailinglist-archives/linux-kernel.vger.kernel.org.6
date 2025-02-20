Return-Path: <linux-kernel+bounces-524719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EAEA3E644
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B054517FFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4AF2144D0;
	Thu, 20 Feb 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfCEgNXM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440722087;
	Thu, 20 Feb 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085419; cv=none; b=mIvKPBzTAU/bPi1VfR0OaS2FcyjImRX7aIeZsF2Mqk53uq0/+Hbu2uWnZaYnQIu/kNQvVTbVWDLsskFjeZ2WUopx8eekTSHUaEQywGBOCr23l3OLo4vnLvvPdlvsdVatvGvT0qnnPy2kfB+1En2zkqKAs8lzroZGAhOdEttbz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085419; c=relaxed/simple;
	bh=1lEWNQw2QxR1fSbR0O+DjUoBzz4cKEriWifSC/6F4Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHq26SBiwdxJwRakTHSkmBbu4ULotiWLmKJyBIwyxsq+RUXUhjUgUmoPDSGwUuqmW7MKD5//SXGcI9RMbHG+MOrIo3CQNDVa8E+2ZXCiDkH14hW7GPMGABnZWOdd1zt4W7wpr7KCqoW/R16tz74vp4KuwRtRqYaDuzAVGF0AHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfCEgNXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21435C4CED6;
	Thu, 20 Feb 2025 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740085418;
	bh=1lEWNQw2QxR1fSbR0O+DjUoBzz4cKEriWifSC/6F4Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfCEgNXMQKkQLlWRQSpT1qNC7ESfqy8J6Ko1drBXAMA5A/NkLf1ijhGenTHdQKb7+
	 YbCXH/j+L+ZrjMyOs3VZ5QeAWZ0PYyuR+Xkh0PuB6SddcMqR0wDsyCaxxhyBHO0MPQ
	 JaWeXr6m7EEt9GFTHQDRcb+92lexvOjwA55XbFwtqw7xyVfYj7/aEw+v0H6WHdk7Vy
	 sTmoNEcS1X6aMqeIYBShxtyPiLoKYOI9HNkHsBUmE8nLooIzg7/mSzfECaCu77AFgy
	 Lw1b7UAzKrYFBkUNLJ2kIHt9njGyVQm7wyB7TpVzXtrHHWaPMaVK6r9xVjJz8ZX6IX
	 gckFPUPBfwsiw==
Date: Thu, 20 Feb 2025 22:03:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/14] hrtimer Rust API
Message-ID: <Z7eYp_vZo5yDVOdI@pavilion.home>
References: <aIJ0ymzdUceCN05hwJpth4erH5u2SHYzYl52wGeT3uiO9bdk92ZkEmEEq9a9NXsInJYSz9uziwq-1fvdsXoeDA==@protonmail.internalid>
 <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <877c5mci3p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c5mci3p.fsf@kernel.org>

Le Wed, Feb 19, 2025 at 12:02:50PM +0100, Andreas Hindborg a écrit :
> "Andreas Hindborg" <a.hindborg@kernel.org> writes:
> 
> > This series adds support for using the `hrtimer` subsystem from Rust code.
> >
> > The series adds support for timer mode and clock source configuration during
> > timer initialization. Examples and functionality to execute closures at timer
> > expiration has been removed, as these depend on either atomics [3] or
> > `SpinLockIrq` [4], which are still being worked on.
> >
> > This series is a dependency for unmerged features of the Rust null block driver
> > [1], and for rkvms [2].
> >
> 
> @ timer subsystem maintainers: did you discuss how you want to set up
> maintenance for this yet? As mentioned, I'm happy stepping up to
> maintain this, but if you want to handle it with existing resources that
> is perfectly fine as well.

You're the best candidate to maintain this code since you wrote it :-)

Also I personally have near zero skills in Rust as of today so all I can do
is to vaguely keep an eye on the binding's interface and keep in touch
with the changes.

So I suggest you to add a new entry with you as a maintainer (I suggested
something similar to Fujita for some other timer related things) but please
keep us Cc'ed for future changes.

> I was hoping we could merge the patches in the near future. The patches
> have been on list for quite a while now, and I am happy with the shape
> of them. They are in my critical path for merging dependent code in the
> rust null block driver.
> 
> Let me know if there is anything I can do to help move the process
> forward.

Let me have a last look...

Thanks.


> 
> 
> Best regards,
> Andreas Hindborg
> 
> 
> 
> 

