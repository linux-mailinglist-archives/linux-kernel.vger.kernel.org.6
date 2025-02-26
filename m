Return-Path: <linux-kernel+bounces-535049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563FAA46E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BA71886D41
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89B26D5B4;
	Wed, 26 Feb 2025 22:07:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A882561D6;
	Wed, 26 Feb 2025 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607655; cv=none; b=UnkjLOOy+eWBV6q4Av6y0/CuGmC3mh1RCOfbobfExv6CNAdPBHQWlK0RkrVzgHm35BsQ/Rp7tlOeG0VOhe3L8acDwubFIoVrpPmwfFyGk6PG4IsxL6ldwZe6bBXrAEW65WLWmrfXdfMoWoQ/Lvto2eGb35ODVFqfa2/meHQwYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607655; c=relaxed/simple;
	bh=NmZ5J1Vr/23S3P/3myBW0sfcjDxrYkDuy0Q+NITqLcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyEyKeDE9O5fmNR2JNRHbncS/lMfmOp+Ry2eXgyb4L8XT+cuV5XNHb0L5qEeCZCeENKJoAqvobghcczOkaQBWREOyZusyP1pIzt/zFCsb4dxUJgQlg/a5WdaVyr2UpPL/TCwz/n+IUZiDGt2jrPcvccBuVeD8o55aQ+WsN86HwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F6AC4CED6;
	Wed, 26 Feb 2025 22:07:34 +0000 (UTC)
Date: Wed, 26 Feb 2025 14:07:32 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ventura Jack <venturajack85@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Gary Guo <gary@garyguo.net>, airlied@gmail.com,
	boqun.feng@gmail.com, david.laight.linux@gmail.com,
	hch@infradead.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Ralf Jung <post@ralfj.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226220732.esiaz7jqskteitup@jpoimboe>
References: <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
 <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
 <2025022611-work-sandal-2759@gregkh>
 <16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
 <20250226110033.53508cbf@gandalf.local.home>
 <9c443013493f8f380f9c4d51b1eeeb9d29b208a3.camel@HansenPartnership.com>
 <ylsffirqsrogli5fqlyhklhy6s54ngolvk5hj5fnpn3ceglyii@cgcvtm4ohtra>
 <20250226115726.27530000@gandalf.local.home>
 <olxh7iwz5yjuuqwpbzgohrl3dkcurbmzij3o2dbha5mtkr2ipn@wtee4jjj7ope>
 <20250226124733.10b4b5fa@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226124733.10b4b5fa@gandalf.local.home>

On Wed, Feb 26, 2025 at 12:47:33PM -0500, Steven Rostedt wrote:
> On Wed, 26 Feb 2025 12:41:30 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > It's been awhile since I've looked at one, I've been just automatically
> > switching back to frame pointers for awhile, but - I never saw
> > inaccurate backtraces, just failure to generate a backtrace - if memory
> > serves.
> 
> OK, maybe if the bug was bad enough, it couldn't get access to the ORC
> tables for some reason.

ORC has been rock solid for many years, even for oopses.  Even if it
were to fail during an oops for some highly unlikely reason, it falls
back to the "guess" unwind which shows all the kernel text addresses on
the stack.

The only known thing that will break ORC is if objtool warnings are
ignored.  (BTW those will soon be upgraded to build errors by default)

ORC also gives nice clean stack traces through interrupts and
exceptions.  Frame pointers *try* to do that, but for async code flows
that's very much a best effort type thing.

So on x86-64, frame pointers are very much deprecated.  In fact we've
talked about removing the FP unwinder as there's no reason to use it
anymore.  Objtool is always enabled by default anyway.

-- 
Josh

