Return-Path: <linux-kernel+bounces-523095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F870A3D1E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75B83BC3ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AA21E9B14;
	Thu, 20 Feb 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mqrh5pfM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F31E570E;
	Thu, 20 Feb 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035497; cv=none; b=mhC4BLwwKiyakoPit40R6v4zhv3O0s5MqqbqIESl6ws05rRtphAUbwryNyGfYOODSJzSUqGy4Rj620iqEfbY23lSxRN6Eptmz4rl+rnasDyHly7o+2KdsvQw26jlIbWVXryxXoMIeVi2cKY/TlDuyG5LeL8pXeC3mN3+GvMR7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035497; c=relaxed/simple;
	bh=yJHO1PaNC8g2DPCaWf9rnGUVCdZUT02r79hZMVr9kkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkaOD68dQ4wD7sphzIF9oJ+oj5AqMt3/RU+3hMpQtbS3ujYio9an9njgbFrcWaXazKUBeDuUZnMpVxQfLlbYEzUhsyAnGYPHybCpbs06nCXUhZN+Oj4scN+2fjWVnnIgX92sW0BI5Z7dttjl6uOrld3laj7gVjMnf7MN8vXUCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mqrh5pfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF8DC4CED1;
	Thu, 20 Feb 2025 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740035497;
	bh=yJHO1PaNC8g2DPCaWf9rnGUVCdZUT02r79hZMVr9kkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mqrh5pfMEQ1CyttegJ5g2f/mxzUWo1h7PLMLE+EdEt29ORRds8VqNJ8TNkK3u7A4I
	 QneAARZ0YqhbZVuFMdhZcIvlFtu8kFy40IcO40JIeanFUlU/YwrpzRVMZzNzEBB6hE
	 ngRijb2hVXx6orNmPzErRmnP9doI2NQtnUz4gkM8=
Date: Thu, 20 Feb 2025 08:10:30 +0100
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
Message-ID: <2025022024-blooper-rippling-2667@gregkh>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>

On Thu, Feb 20, 2025 at 08:03:02AM +0100, Martin Uecker wrote:
> Am Mittwoch, dem 19.02.2025 um 06:39 +0100 schrieb Greg KH:
> > On Tue, Feb 18, 2025 at 07:04:59PM -0800, Boqun Feng wrote:
> > > On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> > > [...]
> > > > > > 
> ...
> > 
> > 
> > I'm all for moving our C codebase toward making these types of problems
> > impossible to hit, the work that Kees and Gustavo and others are doing
> > here is wonderful and totally needed, we have 30 million lines of C code
> > that isn't going anywhere any year soon.  That's a worthy effort and is
> > not going to stop and should not stop no matter what.
> 
> It seems to me that these efforts do not see nearly as much attention
> as they deserve.

What more do you think needs to be done here?  The LF, and other
companies, fund developers explicitly to work on this effort.  Should we
be doing more, and if so, what can we do better?

> I also would like to point out that there is not much investments
> done on C compiler frontends (I started to fix bugs in my spare time
> in GCC because nobody fixed the bugs I filed), and the kernel 
> community also is not currently involved in ISO C standardization.

There are kernel developers involved in the C standard committee work,
one of them emails a few of us short summaries of what is going on every
few months.  Again, is there something there that you think needs to be
done better, and if so, what can we do?

But note, ISO standards work is really rough work, I wouldn't recommend
it for anyone :)

> I find this strange, because to me it is very obvious that a lot more
> could be done towards making C a lot safer (with many low hanging fruits),
> and also adding a memory safe subset seems possible.

Are there proposals to C that you feel we should be supporting more?

thanks,

greg k-h

