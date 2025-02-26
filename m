Return-Path: <linux-kernel+bounces-534440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441AA46702
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F111D1883AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E56222589;
	Wed, 26 Feb 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SSVOYE67"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309AEED7;
	Wed, 26 Feb 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588165; cv=none; b=kNwgUraK4K+sN3xV3sc8Hpcx3XdBbjdNpU/nn8oDFQbOYWx0Z0E0oxHDmKaNKUQtTtSJIFQAYQG+OYBSoGFoa63on3vBLeI8Jz/nRfxGMGQPe0PBe+boyLQT1w6wN0U80HTMaaoAu6eQyQNZyGP/LiQKdpDvNgWn0BKoYgTCePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588165; c=relaxed/simple;
	bh=j0Jdfh5ZTam2i9FjA30XjZbPHXQrlJPvw53xGy1ieHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uzju5iOhKsV7Gcv/AmfPdBSvg4S6fTdAZd1OOzyECHAlgua/B8xj/bTEdJjChp/e25VLFrGWfbqqgEQErbSMoC5IMr8U7oUL6fVzBXkbasCffiDNx3FCRd+TukPKQJQ1Ujffx2QR40dwUqoQuamCJondeLwc4ebHOB0YZ2LllwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=SSVOYE67; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740588162;
	bh=j0Jdfh5ZTam2i9FjA30XjZbPHXQrlJPvw53xGy1ieHs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=SSVOYE678KR2GDHy2EtEFvTuf7lqdjn0YzCHGpOE7neu1sCZRPwt6+RYEiOUwc12z
	 a1wd3W4LwHQEp24uq1XApSsz/FWC+LZ6mWbX+Na/1Dc75ze7IrPMiIef6w5JYnhfwr
	 cIOOqB8E7+7uzIBIDiVGDK4QVdIL7LXm7lQKmXOU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id E48171C0034;
	Wed, 26 Feb 2025 11:42:41 -0500 (EST)
Message-ID: <9c443013493f8f380f9c4d51b1eeeb9d29b208a3.camel@HansenPartnership.com>
Subject: Re: C aggregate passing (Rust kernel policy)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Ventura Jack <venturajack85@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, "H. Peter Anvin"
 <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com,  boqun.feng@gmail.com, david.laight.linux@gmail.com,
 hch@infradead.org,  ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Date: Wed, 26 Feb 2025 11:42:41 -0500
In-Reply-To: <20250226110033.53508cbf@gandalf.local.home>
References: 
	<CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
	 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
	 <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com>
	 <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
	 <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
	 <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
	 <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
	 <2025022611-work-sandal-2759@gregkh>
	 <16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
	 <20250226110033.53508cbf@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-26 at 11:00 -0500, Steven Rostedt wrote:
> On Wed, 26 Feb 2025 09:45:53 -0500
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > > From some other rust boot system work, I know that the quality of
> > > a  
> > simple backtrace in rust where you just pick out addresses you
> > think you know in the stack and print them as symbols can sometimes
> > be rather misleading, which is why you need an unwinder to tell you
> > exactly what happened.
> 
> One thing I learned at GNU Cauldron last year is that the kernel
> folks use the term "unwinding" incorrectly. Unwinding to the compiler
> folks mean having full access to all the frames and variables and
> what not for all the previous functions.
> 
> What the kernel calls "unwinding" the compiler folks call "stack
> walking". That's a much easier task than doing an unwinding, and that
> is usually all we need when something crashes.

Well, that's not the whole story.  We do have at least three unwinders
in the code base.  You're right in that we don't care about anything
other than the call trace embedded in the frame, so a lot of unwind
debug information isn't relevant to us and the unwinders ignore it.  In
the old days we just used to use the GUESS unwinder which looks for
addresses inside the text segment in the stack and prints them in
order.  Now we (at least on amd64) use the ORC unwinder because it
gives better traces:

https://docs.kernel.org/arch/x86/orc-unwinder.html

while we don't need full unwind in rust, we do need enough to get
traces working.

Regards,

James


