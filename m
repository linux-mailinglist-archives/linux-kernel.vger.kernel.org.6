Return-Path: <linux-kernel+bounces-524796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F30A3E73E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC10188924E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6633813AF2;
	Thu, 20 Feb 2025 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js8iXzQs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D061EEA56;
	Thu, 20 Feb 2025 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089314; cv=none; b=LeO4+qgXqUCKmDx8vkq+jpQu3V7rJ7EW4yd2JtCL9ZajADcbESP2gE959RBJqRWJh6z0DH26Oq0CptUayvPHEJTku+TSmxOb+l0tTOQkIPOYfNvzT9IVgg0chJ7eH0soDLvk+BlQC4ccujgu/dG58SDFw3cRkntKR60GgkL7deg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089314; c=relaxed/simple;
	bh=KNC8/ble1a51wEJCVVgUKrJKL/UmcG6qjNPA3yY3AFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAxSoEj7L2O6n7vmU93Yl/COaFaNOH69pI5A6VtdOpw5t5uB2b4wvEBcErLYp/jdk2+42G16R0mnaFwJjAvp3G5mQZiqlyXsqI1nj7xv++S2j97VJfKFKAqh7iBDre//22+F8w+WuySN1OHrlpmLEMSeGWmCmDkhy7IGzM7iZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js8iXzQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2260DC4CED1;
	Thu, 20 Feb 2025 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740089314;
	bh=KNC8/ble1a51wEJCVVgUKrJKL/UmcG6qjNPA3yY3AFE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=js8iXzQsnrwsQPyaQ06mGtfEgGiKIenWUNo0Kd5B/+FBImGB4NNtCGRGh22blFZaT
	 9SibicOYQ/JrmhmZHwTgwoMnNY4Pyyye3lGLxY565HtXJ++PzyfDSkWZGBb+s50qX4
	 y6FetYaYiakEwhwhgw60DwwtEjeLMYcPOcNZ0iwfJaawo4DuSjBpWm92vMHoESvDIO
	 V6IXyILiGtVY0lXZ3nO7myoFY2qDQ8Hm/zK+42TqfVr1vTf1mSH10pCbW8NZ+eNcRg
	 m9ZbTsAz4tl0FVMdm/BRhd1VgAqcp6ipNikIVbxCdad2v8A+WlRIb4Cu0r5g/S8UtY
	 FTQpvkSGAnj2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C4155CE0B34; Thu, 20 Feb 2025 14:08:33 -0800 (PST)
Date: Thu, 20 Feb 2025 14:08:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <f3d4bf70-699e-4a53-a40d-dd6de691cf50@paulmck-laptop>
Reply-To: paulmck@kernel.org
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
> 
> > 
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

Sadly, I must pick my battles extremely carefully.  So additional people
from the Linux-kernel community being involved in standards work would
be a very good thing from my viewpoint.

							Thanx, Paul

