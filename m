Return-Path: <linux-kernel+bounces-434502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE699E678F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD12E1885FFC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA51DA0ED;
	Fri,  6 Dec 2024 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UoVE+gSa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324DBE46;
	Fri,  6 Dec 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468617; cv=none; b=NIOqzS/M1/q/dFHJFY+v80b6eu60CUvUXZdlxRQm2NdjCF3TtpT1um8mVh+cSoDaE3qclR9MKibVCHVQ0vaatphRlwo6srhsS0unH6fkyFZOLm8bb00ar4TRAxMuP33nT+fUVUFH4RaA6N7xtIFJ1QOFj8AYH8rTc4vdvomPB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468617; c=relaxed/simple;
	bh=4ZYBIwbL1Q/vZCwgV+w1mJqrN3fQLc89x91fNVIEaXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oETVQASk0U8sH3KFuxcUip8voEQ6mDgoO18MRc9NH6pZ8XkUfKBAmU0iTDu6M2IdvucuHGdBXsLZ4TnCT3UWSBTBEaZws4f2uIrlEfdN1AcWM1LZAnksXgNbVJK8Qh3VJtUsiXUyfUCXkBhyyMJtAkkoTN67JlvRj7ebOUf166I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UoVE+gSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77842C4CED1;
	Fri,  6 Dec 2024 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733468617;
	bh=4ZYBIwbL1Q/vZCwgV+w1mJqrN3fQLc89x91fNVIEaXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoVE+gSaOfwIFcABkPjqj5tmPNXTPk9p5o0ZOs0iEPjeY38k8zsjigLShWUjQh6vK
	 Hja42M/CvRw3llFbHxu4tXn0OWJMHX/V7N6nt8mWOI0q3iB3HM7fhEtf550YAWYyTj
	 1sLlnVSQb0grlZRwF/+dY6TQOjKdZ9R3IGomLzWk=
Date: Fri, 6 Dec 2024 08:03:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <2024120621-unlisted-unbalance-3220@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-4-lee@kernel.org>
 <2024120642-trend-omnivore-69d3@gregkh>
 <be74daeb-68af-4e6b-8091-7f9684fe424e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be74daeb-68af-4e6b-8091-7f9684fe424e@app.fastmail.com>

On Fri, Dec 06, 2024 at 07:52:46AM +0100, Arnd Bergmann wrote:
> On Fri, Dec 6, 2024, at 07:49, Greg KH wrote:
> > On Thu, Dec 05, 2024 at 04:25:20PM +0000, Lee Jones wrote:
> >> +
> >> +#[vtable]
> >> +impl MiscDevice for RustMiscDevice {
> >> +    type Ptr = KBox<Self>;
> >> +
> >> +    fn open() -> Result<KBox<Self>> {
> >> +        pr_info!("Opening Rust Misc Device Sample\n");
> >> +
> >> +        Ok(KBox::new(RustMiscDevice, GFP_KERNEL)?)
> >> +    }
> >> +
> >> +    fn ioctl(
> >> +        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
> >> +        cmd: u32,
> >> +        _arg: usize,
> >> +    ) -> Result<isize> {
> >> +        pr_info!("IOCTLing Rust Misc Device Sample\n");
> >> +
> >> +        match cmd {
> >> +            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
> >> +            _ => {
> >> +                pr_err!("IOCTL not recognised: {}\n", cmd);
> >> +                return Err(ENOIOCTLCMD);
> >
> > To quote errno.h:
> > 	These should never be seen by user programs
> >
> > The correct value here is ENOTTY.
> >
> > Yeah, fun stuff.  Not intuitive at all, sorry.
> 
> That should get handled by vfs_ioctl() converting the
> ENOIOCTLCMD to ENOTTY.

Ah, I always miss that, for some reason I thought that didn't happen
there, but happened in subsystems that did ENOIOCTLCMD for their
sub-ioctl handlers.  And yet it's always been that way, nevermind...

Anyway, I always recommend just using ENOTTY to be "safe", the usual way
people get this wrong is using EINVAL.

thanks,

greg k-h

