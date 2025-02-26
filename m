Return-Path: <linux-kernel+bounces-534135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A323A4633D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F0C1897227
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8E3221739;
	Wed, 26 Feb 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jr1myXsi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDC218AB4;
	Wed, 26 Feb 2025 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580865; cv=none; b=bQ0FTKSlxzPAU3+SalojnXkRVKkN5xTEoJQqPyw1crLzAMHDtAaY7lD03bJ9LnA6TG7TgyLxs7e/UL0LLLpQDlqigT1T8GSHMRcdq2dPBYKaHYtfOr7ufaFQtKM1utarTSW1HB6OzZpyBtAlGtyCsMIdTr8djcmNVFPlyww2hMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580865; c=relaxed/simple;
	bh=dOP2dcP5LkPteIoJKkZnEyzxHLh8A49a4WMWgI8Lm7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RycvrD0jPzs4eLeNVEkHro0kRquKY6hLn9pNqAAcv6XZyE4ekoLom1yn1Zq6Af8fjWXC/FuNPNXmhBShisJf9gGy91eMAPSkIc7bUpvIzaAjiC4tT25kcS/vkgVfX+utAPCDf0lxVEp2muK0So0Cu3jZJ8WPHjyhsYTRYu0fmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jr1myXsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC63DC4CED6;
	Wed, 26 Feb 2025 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740580864;
	bh=dOP2dcP5LkPteIoJKkZnEyzxHLh8A49a4WMWgI8Lm7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jr1myXsiGvZ8q6GhrRymFNao7q0S8bAp+ULSltXsZwmrDscA6uHlHMyTAaLQ0US0t
	 eabAx3g5Xe4x+GRICKAQacyyU1C9G2rZ5P+hV++h3rebNRjynLj+SrNbYfN8GbAIp5
	 ELIuv2dvRQFcU22HIKksEDG2PFTPBMdSH1m1BwAE=
Date: Wed, 26 Feb 2025 15:39:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ventura Jack <venturajack85@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"H. Peter Anvin" <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Gary Guo <gary@garyguo.net>, airlied@gmail.com,
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de,
	hch@infradead.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Ralf Jung <post@ralfj.de>
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <2025022611-work-sandal-2759@gregkh>
References: <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com>
 <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
 <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
 <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
 <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>

On Wed, Feb 26, 2025 at 09:26:50AM -0500, James Bottomley wrote:
> On Wed, 2025-02-26 at 14:53 +0100, Miguel Ojeda wrote:
> > On Wed, Feb 26, 2025 at 2:03 PM Ventura Jack
> > <venturajack85@gmail.com> wrote:
> [...]
> > > Exception/unwind safety may be another subject that increases
> > > the difficulty of writing unsafe Rust.
> > 
> > Note that Rust panics in the kernel do not unwind.
> 
> I presume someone is working on this, right?  While rust isn't
> pervasive enough yet for this to cause a problem, dumping a backtrace
> is one of the key things we need to diagnose how something went wrong,
> particularly for user bug reports where they can't seem to bisect.

The backtrace is there, just like any other call to BUG() provides,
which is what the rust framework calls for this.

Try it and see!

