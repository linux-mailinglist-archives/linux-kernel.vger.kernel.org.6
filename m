Return-Path: <linux-kernel+bounces-534453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D84A4671B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08611892A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065422424B;
	Wed, 26 Feb 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TpmnTXER"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF362904
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588437; cv=none; b=BQ374YTrIF9QR+WpfzpcBQ9eiMfYz9JdkI3NnurNBHihvMFBNeVdP2Ngy0sfL6Cb+Z6Ht+PQjMDRwdCA1mvp2z+OPO7aKLQYGTod1kv4UtsnclxVR8F7LH145YGMTZVlLlg8Cs66AjpnILOxq/Fly8YZqmtE7dGXXsUyMjRDbsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588437; c=relaxed/simple;
	bh=S4VxR7Vhf8rk0tZS2T+PwaCMIZ9stCZaz/RSe4aLrpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWPSZ8gkgMMlT7msVy+5D+QK5IZrwEaN+9wWVcYU9FeF45LgP1QzWMLqsBflBm7lXMV366NEThUO4foIoegJN/s9PrvXelsLns8wwNUXwn//zNrXo1jXYDLSVAjzaZJ5NRbmTlvRuMqmF9F/aQs/BgVokQGj3NAMv7tkeVtnq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TpmnTXER; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 11:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740588433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7aAkNywUHL55jFK3BpqTl06OGrbYbbBNckMZVwt+g0=;
	b=TpmnTXERH3UMlZdzRFC28VNQCaXAc6ct+0vqLsJZYRPJvqI/1SkTL7Xh4RZJNUa1M/o1gA
	F9VL0x82d1uUpILuZsIk8Zsvw3VFZMhEQIsQZIcY7L4v02jHNrWr/u7xVdnIe0UxJRB168
	Si6+DpcCBQQ22Ew+Lcp96UAjyL3LM1c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Ventura Jack <venturajack85@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Alice Ryhl <aliceryhl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, hch@infradead.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <ylsffirqsrogli5fqlyhklhy6s54ngolvk5hj5fnpn3ceglyii@cgcvtm4ohtra>
References: <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com>
 <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
 <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
 <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
 <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
 <2025022611-work-sandal-2759@gregkh>
 <16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
 <20250226110033.53508cbf@gandalf.local.home>
 <9c443013493f8f380f9c4d51b1eeeb9d29b208a3.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c443013493f8f380f9c4d51b1eeeb9d29b208a3.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 11:42:41AM -0500, James Bottomley wrote:
> On Wed, 2025-02-26 at 11:00 -0500, Steven Rostedt wrote:
> > On Wed, 26 Feb 2025 09:45:53 -0500
> > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > 
> > > > From some other rust boot system work, I know that the quality of
> > > > a  
> > > simple backtrace in rust where you just pick out addresses you
> > > think you know in the stack and print them as symbols can sometimes
> > > be rather misleading, which is why you need an unwinder to tell you
> > > exactly what happened.
> > 
> > One thing I learned at GNU Cauldron last year is that the kernel
> > folks use the term "unwinding" incorrectly. Unwinding to the compiler
> > folks mean having full access to all the frames and variables and
> > what not for all the previous functions.
> > 
> > What the kernel calls "unwinding" the compiler folks call "stack
> > walking". That's a much easier task than doing an unwinding, and that
> > is usually all we need when something crashes.
> 
> Well, that's not the whole story.  We do have at least three unwinders
> in the code base.  You're right in that we don't care about anything
> other than the call trace embedded in the frame, so a lot of unwind
> debug information isn't relevant to us and the unwinders ignore it.  In
> the old days we just used to use the GUESS unwinder which looks for
> addresses inside the text segment in the stack and prints them in
> order.  Now we (at least on amd64) use the ORC unwinder because it
> gives better traces:
> 
> https://docs.kernel.org/arch/x86/orc-unwinder.html

More accurate perhaps, but I still don't see it working reliably - I'm x
still having to switch all my test setups (and users) to frame pointers
if I want to be able to debug reliably.

