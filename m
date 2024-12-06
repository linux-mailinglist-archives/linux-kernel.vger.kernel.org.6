Return-Path: <linux-kernel+bounces-434562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C380E9E6843
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31405281BB3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677371DD88F;
	Fri,  6 Dec 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8HOp+bG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76C1DDC38;
	Fri,  6 Dec 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471510; cv=none; b=Jmymk0Z590sc7C6SfsJELDT74CMRL/e2RYMJIupKoVEo5kKsQCXsb4bxx8bwmhx0VmaigGQM3zhCQhbczbpRJZLJTq7TWHMk7J/QKXfRrgcYJy5mnQ9naWRGkZvkjyeIkb4laEo3xQPARs5MYU5P5IIqnDHLRY7huoiXvaI0n+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471510; c=relaxed/simple;
	bh=cmzLmtLRzRT/qEEFhlaRxykCWCgaePm9ZX8X9BfHYH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3WzLgzHLa6UCooAYcABZBvx9j0NpwV+Fmp4uIk9/VtU9wbfYCr7Do8pQh6ywDnhLn2/viWWISWHe8GRdEP6tQXGDSfFn8N3u67/ao+atLqq+iTS8L7NVXvnZFCRRbr4wcsnjJKmJQrlJEjdnyK6zt/rorvjD+e9Y7cacmImT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8HOp+bG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08881C4CED1;
	Fri,  6 Dec 2024 07:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733471510;
	bh=cmzLmtLRzRT/qEEFhlaRxykCWCgaePm9ZX8X9BfHYH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8HOp+bGFHYrEmba3R3CnP+9F1QMjiTgOi2D4REd5Pv9LIob3wrVcJprOybiPXiUw
	 +7xjP5wfY/kyNG5D3gRmKMQxWt4ufd7bEbRiREZ88IuLx8Y6azK5aqXJwqy0esqcGo
	 LVUy8xqGMCbJ0wmb1VND9ly1fsVLjwSAcPSo4ZX4Es8VfUXNxymeev1pz2+5oGPwwL
	 FzKAkZlpankKwV62s9DEIJo3ZrEM9uySuPh99L2e1Fe2sLJ/VMaczHusDnccbZ0T7B
	 8BrMmRrrmTcEgQxNcJI+bm2wwd5LOJRKyNIQwitxBQ1LIVWSWlQk/Po32O7xWSsIhq
	 R1FpzEMNK1OsQ==
Date: Fri, 6 Dec 2024 07:51:45 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <20241206075145.GM8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-4-lee@kernel.org>
 <2024120604-diffusive-reach-6c99@gregkh>
 <20241206071430.GC8882@google.com>
 <2024120610-jailbreak-preschool-ff45@gregkh>
 <20241206073558.GH8882@google.com>
 <2024120654-constable-clavicle-d2f6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120654-constable-clavicle-d2f6@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Fri, Dec 06, 2024 at 07:35:58AM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Greg KH wrote:
> > 
> > > On Fri, Dec 06, 2024 at 07:14:30AM +0000, Lee Jones wrote:
> > > > On Fri, 06 Dec 2024, Greg KH wrote:
> > > > > > +    fn open() -> Result<KBox<Self>> {
> > > > > > +        pr_info!("Opening Rust Misc Device Sample\n");
> > > > > 
> > > > > I'd prefer this to be dev_info() to start with please.
> > > > 
> > > > This is not possible at the moment.  Please see the cover-letter.
> > > 
> > > Then why make the change to miscdevice.rs if that pointer provided there
> > > doesn't work for you here?
> > 
> > It's half the puzzle to get it working.  We're waiting on the other
> > (more complex) part from Alice before we can make use of it.  Would you
> > like me to remove it from the set until we have all of the pieces?
> 
> I'm confused, if you have the reference here, what is preventing it from
> being used?
> 
> And yes, if it doesn't work, it shouldn't be part of this series :)

It works - we can use dev_*() in .init, but not after (i.e. in open(),
ioctl(), etc).

I'll pull it from the series and let Alice re-post it when we have all
of the parts.

-- 
Lee Jones [李琼斯]

