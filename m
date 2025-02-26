Return-Path: <linux-kernel+bounces-534151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8029A46371
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DA9189E6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79F7226188;
	Wed, 26 Feb 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="w9uE/21M"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C5225397;
	Wed, 26 Feb 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581158; cv=none; b=jAoDLfkYbA2P2kc3UYxPAHdcdeuRpZhTMANdUEyms18KrTWWN7rgA+yL1nNb+vAoAD/QiQbWfE1lK4Kp5hdl1yuv+fYkKF9ZGsFx+sSmfQsx67cIFXNLJOenFn2TQ+k5SLNqshbMHnIopRJj78Wh6ZJp38IjqkrfFQOFgZYVbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581158; c=relaxed/simple;
	bh=yYTySIEW2vyb9fQfSiWDrhePMMoxgZdjZmmJCBzHfiY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1U6WW/+vGmGarr9Y7c0o9/JfxKsYHjgm4CxAtw6X8/DQE7MHH7O13NFF5azsooLQf4prHvAf2wFo6lcU7DhTWKpVQ3Lu7tDkzyU6AZDTS7piEPr4TM0G9YYYvKoqkyXHVUASvS//6S3BFtuwqkw/QNAITX09Ki5OJtoNsTPXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=w9uE/21M; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740581155;
	bh=yYTySIEW2vyb9fQfSiWDrhePMMoxgZdjZmmJCBzHfiY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=w9uE/21MKYo/CoH4yc5VHQq6YGVeHHWbTNNKbhNNdrX9KqyIy/wXk0Uyklhy75xJ/
	 iB4lyacb/CYp0iZkOFcg/HD/X3vWJ/fRK68u/yagIywyDmIYKdkM/LvKouBw+AYcgO
	 7Q8t1o6+jr69ac9BOgdqOVJ8T/veh8YMlNsjcd6A=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 838361C0993;
	Wed, 26 Feb 2025 09:45:54 -0500 (EST)
Message-ID: <16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
Subject: Re: C aggregate passing (Rust kernel policy)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ventura Jack
 <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, "H.
 Peter Anvin" <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com,  boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, hch@infradead.org,  ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org,  rust-for-linux@vger.kernel.org, Ralf Jung
 <post@ralfj.de>
Date: Wed, 26 Feb 2025 09:45:53 -0500
In-Reply-To: <2025022611-work-sandal-2759@gregkh>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-26 at 15:39 +0100, Greg KH wrote:
> On Wed, Feb 26, 2025 at 09:26:50AM -0500, James Bottomley wrote:
> > On Wed, 2025-02-26 at 14:53 +0100, Miguel Ojeda wrote:
> > > On Wed, Feb 26, 2025 at 2:03 PM Ventura Jack
> > > <venturajack85@gmail.com> wrote:
> > [...]
> > > > Exception/unwind safety may be another subject that increases
> > > > the difficulty of writing unsafe Rust.
> > > 
> > > Note that Rust panics in the kernel do not unwind.
> > 
> > I presume someone is working on this, right?  While rust isn't
> > pervasive enough yet for this to cause a problem, dumping a
> > backtrace is one of the key things we need to diagnose how
> > something went wrong, particularly for user bug reports where they
> > can't seem to bisect.
> 
> The backtrace is there, just like any other call to BUG() provides,
> which is what the rust framework calls for this.

From some other rust boot system work, I know that the quality of a
simple backtrace in rust where you just pick out addresses you think
you know in the stack and print them as symbols can sometimes be rather
misleading, which is why you need an unwinder to tell you exactly what
happened.

Regards,

James


