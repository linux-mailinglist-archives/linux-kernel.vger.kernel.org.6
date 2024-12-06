Return-Path: <linux-kernel+bounces-434541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E499E6807
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C999162F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB891DDC3F;
	Fri,  6 Dec 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewkFMbSa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DDF1DBB3A;
	Fri,  6 Dec 2024 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470624; cv=none; b=pzM7Jni1yRH+hAKmgzS8l6nFKw+x0aX62eNAP0oVwoGd05DIlOFLZXnYva10gt94YK3iVtaITAOQWbsHuIJWZYgLo00FNAEKvxxu0q8p3CwLz2LufBEQwwhRnMvO4CsdZSg/UFksD6oYnkTrxKW+P8SP2tpV1NC1vVRP2RFO2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470624; c=relaxed/simple;
	bh=o8DmKXDpKIzJn/lgSGEBQYxWkbyX1jqY4U0WSssTOAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oW6QdSGXG2lQ0Wa/JgfRyrIOzPTCMb2pVITyHAgebHRRYHutpkpBv05WpYXUOpWZT5It2gXUmnc4j2g/5BXTKI4DFSD5qolOtuWf9FaIDo8QituuPPeEYbQpCuxxfqsvzswdmJ7mdYGqk17T8a++mWOoX9+1janLU4Oigwu/dGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewkFMbSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63C9C4CED1;
	Fri,  6 Dec 2024 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733470624;
	bh=o8DmKXDpKIzJn/lgSGEBQYxWkbyX1jqY4U0WSssTOAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewkFMbSa0aZrwqtUjdgaoAEMrVdv1OLz/pg03VvIaxwYqpa8U1hhiUi0Ntc0tZ0wK
	 kX6mb9svGvPIbhJ9C5rc3TkMbagc43vx/ABnQ3mySTwQjDn8WO3yJpLBgmvGKSIHum
	 /FlNQSdTOWv497ZNA3/ZQv9jxcvw5XAx6hS4PXqISlH6BsKm3E5k+q+7dIAvZgxhyQ
	 GMPBZLbur/B3bve9xBnxJ8P2sYAEz3J0QynMLCjEQ9ny0ifVUnPbiWwgQfkB0eK4Wq
	 ymGPagqLYMic0gZzMyymtVFhwEDhhKQLJBxMSh/4z84epE4omBTwO7FpXP8UpAoVru
	 gVQwEpPhpZUdg==
Date: Fri, 6 Dec 2024 07:36:59 +0000
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
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
Message-ID: <20241206073659.GI8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-4-lee@kernel.org>
 <2024120642-trend-omnivore-69d3@gregkh>
 <be74daeb-68af-4e6b-8091-7f9684fe424e@app.fastmail.com>
 <2024120621-unlisted-unbalance-3220@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120621-unlisted-unbalance-3220@gregkh>

On Fri, 06 Dec 2024, Greg Kroah-Hartman wrote:

> On Fri, Dec 06, 2024 at 07:52:46AM +0100, Arnd Bergmann wrote:
> > On Fri, Dec 6, 2024, at 07:49, Greg KH wrote:
> > > On Thu, Dec 05, 2024 at 04:25:20PM +0000, Lee Jones wrote:
> > >> +
> > >> +#[vtable]
> > >> +impl MiscDevice for RustMiscDevice {
> > >> +    type Ptr = KBox<Self>;
> > >> +
> > >> +    fn open() -> Result<KBox<Self>> {
> > >> +        pr_info!("Opening Rust Misc Device Sample\n");
> > >> +
> > >> +        Ok(KBox::new(RustMiscDevice, GFP_KERNEL)?)
> > >> +    }
> > >> +
> > >> +    fn ioctl(
> > >> +        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
> > >> +        cmd: u32,
> > >> +        _arg: usize,
> > >> +    ) -> Result<isize> {
> > >> +        pr_info!("IOCTLing Rust Misc Device Sample\n");
> > >> +
> > >> +        match cmd {
> > >> +            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
> > >> +            _ => {
> > >> +                pr_err!("IOCTL not recognised: {}\n", cmd);
> > >> +                return Err(ENOIOCTLCMD);
> > >
> > > To quote errno.h:
> > > 	These should never be seen by user programs
> > >
> > > The correct value here is ENOTTY.
> > >
> > > Yeah, fun stuff.  Not intuitive at all, sorry.
> > 
> > That should get handled by vfs_ioctl() converting the
> > ENOIOCTLCMD to ENOTTY.
> 
> Ah, I always miss that, for some reason I thought that didn't happen
> there, but happened in subsystems that did ENOIOCTLCMD for their
> sub-ioctl handlers.  And yet it's always been that way, nevermind...
> 
> Anyway, I always recommend just using ENOTTY to be "safe", the usual way
> people get this wrong is using EINVAL.

No matter.  I can change it.

-- 
Lee Jones [李琼斯]

