Return-Path: <linux-kernel+bounces-523961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C3A3DD61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9557A1A56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D821FBEB0;
	Thu, 20 Feb 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BA25XDsT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC691CEADB;
	Thu, 20 Feb 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063234; cv=none; b=nZIiKmJgfwOSxhtQMRCRGMPlP9q1csU9Y1qAbm/fyrCE5RCnljbHguCVwvVMrn8WTaW3FakqlhKBL8ODJle+0MdRdH75tqcorAmB6C65RdZDW2YFQeYQ6KnXl323XeIVlpRUw2Jzn1sDCKs0qQYToK+GBbDGC+nSvHVvY6ZVNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063234; c=relaxed/simple;
	bh=Sh1gnYO1v4bmBmmM8gmqJJQ9lElifSTky1LxF8q7DSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvQIPFXcI0N6zDGSG69dFKBhfcBj/9Cc0VTUjWVsBV+RrKhn6C6ggbMpA9jTfb4dmhWKOMR7xvztMl0x5VMQ7DZ4CmIMOvrcibxk8DZ+rxiHB5mr9DnhxUEwjrj+4QkjpRMkOablqR9UQD1V/eXoEeTrdhHnDHMuewKlJmBBAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BA25XDsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40A4C4CEE2;
	Thu, 20 Feb 2025 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740063233;
	bh=Sh1gnYO1v4bmBmmM8gmqJJQ9lElifSTky1LxF8q7DSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BA25XDsTHuzE8WV26EB6hHzVvzvnh0My5vPGh0vwnZ43dfZoAO6vm6mV+mftFWKg6
	 zpi4orU+FK1lnsa4Gf3ASXKEHJyO9RD3Pf3kPLQh3/qcGtcJwilLABz6UbS5WgGosW
	 bZ24nZuq857KsCyn19jP3zfU5cRKIdYgEgU7xrNY=
Date: Thu, 20 Feb 2025 15:53:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <2025022042-jot-favored-e755@gregkh>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh>
 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>

On Thu, Feb 20, 2025 at 09:57:29AM +0100, Martin Uecker wrote:
> Am Donnerstag, dem 20.02.2025 um 08:10 +0100 schrieb Greg KH:
> > On Thu, Feb 20, 2025 at 08:03:02AM +0100, Martin Uecker wrote:
> > > Am Mittwoch, dem 19.02.2025 um 06:39 +0100 schrieb Greg KH:
> > > > On Tue, Feb 18, 2025 at 07:04:59PM -0800, Boqun Feng wrote:
> > > > > On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> > > > > [...]
> > > > > > > > 
> > > ...
> > > > 
> > > > 
> > > > I'm all for moving our C codebase toward making these types of problems
> > > > impossible to hit, the work that Kees and Gustavo and others are doing
> > > > here is wonderful and totally needed, we have 30 million lines of C code
> > > > that isn't going anywhere any year soon.  That's a worthy effort and is
> > > > not going to stop and should not stop no matter what.
> > > 
> > > It seems to me that these efforts do not see nearly as much attention
> > > as they deserve.
> > 
> > What more do you think needs to be done here?  The LF, and other
> > companies, fund developers explicitly to work on this effort.  Should we
> > be doing more, and if so, what can we do better?
> 
> Kees communicates with the GCC side and sometimes this leads to
> improvements, e.g. counted_by (I was peripherily involved in the
> GCC implementation). But I think much much more could be done,
> if there was a collaboration between compilers, the ISO C working
> group, and the kernel community to design and implement such
> extensions and to standardize them in ISO C.

Sorry, I was referring to the kernel work happening here by Kees and
Gustavo and others.  Not ISO C stuff, I don't know of any company that
wants to fund that :(

> > > I also would like to point out that there is not much investments
> > > done on C compiler frontends (I started to fix bugs in my spare time
> > > in GCC because nobody fixed the bugs I filed), and the kernel 
> > > community also is not currently involved in ISO C standardization.
> > 
> > There are kernel developers involved in the C standard committee work,
> > one of them emails a few of us short summaries of what is going on every
> > few months.  Again, is there something there that you think needs to be
> > done better, and if so, what can we do?
> > 
> > But note, ISO standards work is really rough work, I wouldn't recommend
> > it for anyone :)
> 
> I am a member of the ISO C working group. Yes it it can be painful, but
> it is also interesting and people a generally very nice.
> 
> There is currently no kernel developer actively involved, but this would
> be very helpful.
> 
> (Paul McKenney is involved in C++ regarding atomics and Miguel is
> also following what we do.)

Yes, some of us get reports from them and a few others at times as to
what's going on, but finding people, and companies, that want to do this
work is hard.  I recommend it for people that want to do this, and
applaud those that do, and am involved in other specification work at
the moment so I know the issues around all of this.

> > > I find this strange, because to me it is very obvious that a lot more
> > > could be done towards making C a lot safer (with many low hanging fruits),
> > > and also adding a memory safe subset seems possible.
> > 
> > Are there proposals to C that you feel we should be supporting more?
> 
> There are many things.
> 
> For example, there is an effort to remove cases of UB.  There are about
> 87 cases of UB in the core language (exlcuding preprocessor and library)
> as of C23, and we have removed 17 already for C2Y (accepted by WG14 into
> the working draft) and we have concrete propsoals for 12 more.  This
> currently focusses on low-hanging fruits, and I hope we get most of the
> simple cases removed this year to be able to focus on the harder issues.
> 
> In particulary, I have a relatively concrete plan to have a memory safe
> mode for C that can be toggled for some region of code and would make
> sure there is no UB or memory safety issues left (I am experimenting with
> this in the GCC FE).  So the idea is that one could start to activate this
> for certain critical regions of code to make sure there is no signed
> integer overflow or OOB access in it.   This is still in early stages, but
> seems promising. Temporal memory safety is harder and it is less clear
> how to do this ergonomically, but Rust shows that this can be done.

What do you mean by "memory safe" when it comes to C?  Any pointers to
that (pun intended)?

> I also have a proposal for a length-prefixed string type and for 
> polymorhic types / genericity, but this may not be so relevant to the
> kernel at this point.

We have a string type in the kernel much like this, it's just going to
take some work in plumbing it up everywhere.  Christoph touched on that
in one of his emails in this thread many messages ago.  Just grinding
out those patches is "all" that is needed, no need for us to wait for
any standard committee stuff.

> Even more important than ISO C proposals would be compiler extensions
> that can be tested before standardization.

We support a few already for gcc, and I don't think we've refused
patches to add more in the past, but I might have missed them.

thanks,

greg k-h

