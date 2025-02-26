Return-Path: <linux-kernel+bounces-534551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3DAA46861
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B5E3A6DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFCC225775;
	Wed, 26 Feb 2025 17:46:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB72253EA;
	Wed, 26 Feb 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592015; cv=none; b=gO3ivZnfRd5o/BuV4Wnp1gfj8yXNDI7RBrSakWTu09b5EJjqN2Vt0u+E2D0p+Afb6cgZTlo5yE88XW7w91Ar0P5gaHJLtWkSsVYXAczBdJBA30q7+oPbjieLGYOcVI/CghWS4elJ9/x9JykiiXUL1b8hq7C2A1PKDHwVW9hJ0k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592015; c=relaxed/simple;
	bh=s28fAAtrCsEV8LWpIpCCPdesX6uySksYcloQ5mjso0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDr3tKOzhOQR4NhkkBccAsA+EnI3QTjRQ92NCQYdKAroErwedNnzkUbJspax2vizCOdQreKKbRj0te8+ce+2Xj+Is6q1xf5Kql1UCq6GLSF4xkh2eMKXak7FEUVKUKS5MsJeAfju67OtCpu3uOGFkJkYwhhr501OafAOYVP3TAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DC4C4CED6;
	Wed, 26 Feb 2025 17:46:52 +0000 (UTC)
Date: Wed, 26 Feb 2025 12:47:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Greg KH
 <gregkh@linuxfoundation.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Ventura Jack <venturajack85@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 hch@infradead.org, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226124733.10b4b5fa@gandalf.local.home>
In-Reply-To: <olxh7iwz5yjuuqwpbzgohrl3dkcurbmzij3o2dbha5mtkr2ipn@wtee4jjj7ope>
References: <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
	<CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
	<CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
	<f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
	<2025022611-work-sandal-2759@gregkh>
	<16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
	<20250226110033.53508cbf@gandalf.local.home>
	<9c443013493f8f380f9c4d51b1eeeb9d29b208a3.camel@HansenPartnership.com>
	<ylsffirqsrogli5fqlyhklhy6s54ngolvk5hj5fnpn3ceglyii@cgcvtm4ohtra>
	<20250226115726.27530000@gandalf.local.home>
	<olxh7iwz5yjuuqwpbzgohrl3dkcurbmzij3o2dbha5mtkr2ipn@wtee4jjj7ope>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 12:41:30 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> It's been awhile since I've looked at one, I've been just automatically
> switching back to frame pointers for awhile, but - I never saw
> inaccurate backtraces, just failure to generate a backtrace - if memory
> serves.

OK, maybe if the bug was bad enough, it couldn't get access to the ORC
tables for some reason. Not having a backtrace on crash is not as bad as
incorrect back traces, as the former is happening when the system is dieing
and live kernel patching doesn't help with that.

> 
> When things die down a bit more I might be able to switch back and see
> if I get something reportable, I'm still in bug crunching mode :)

Appreciate it.

Thanks,

-- Steve

