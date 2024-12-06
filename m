Return-Path: <linux-kernel+bounces-435071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE49E6F25
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127161882CE0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7E206F3C;
	Fri,  6 Dec 2024 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGLKCNQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD3204096;
	Fri,  6 Dec 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490904; cv=none; b=tH+YFI0B03L31wxHyPSAVRD0AF6CDv5MMNusFLmJ6N2A3iGwjVfyhqAFXKlZbcnWETAeejkDQH02phP+KSRn/8AhuJxuhUiwlsKiCyJ5bY+iFZ7Eh9uic4zbWHJbMCsqik5EekQtt7CP1fgxVAS80wr940FVRD36tpnEInXQinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490904; c=relaxed/simple;
	bh=fQXAU0TQOuPbF2Wa28yRbR1+idMRyEFiJwXxesKJ1j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPTNOWuit3Jwx1pbKJK6k7O8meENL+xtSEzApmcRPZq4qzJaQDMefUgCpx2c7DxIoLGFjX3tM9hkG6oDGSmZ4ZMygTZ+oTleBkEJmZZNUhkiPAL9e+dYdbWYTHpL4KY1UTD3z76Ly95Cx5yQpGds/RNeod7aUsaDsDCtaMi5BWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGLKCNQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E390C4CED1;
	Fri,  6 Dec 2024 13:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490903;
	bh=fQXAU0TQOuPbF2Wa28yRbR1+idMRyEFiJwXxesKJ1j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGLKCNQn0SfQZyJaI4D7NHc6d0xvAn4lKlZtZ44bXy5zdnKtBLtOokjUHIrIS2Cp6
	 CKb/RdY2mGE61mCK6tKXlU4TheXFYaIvVaSxYW0dnUW5Oaz5fkYU5bHytKu6YDpqfz
	 KlsXCqvS397O33194VD1X4o43mB0VsV6XltA8yFpgNNPLo3mJs6oa0T6TeS3k+eWN3
	 xVnMhhnqP2jRXzHor7vik2y4X81093qZda/WZjZnYIxp+Y8NGdp8y7V7x6T71fxA0z
	 eHhU3aIkEnRpqMOpgSCfe2QoaK8ou1J6kuEbnmi97/4ePuqrze3H78CEq0wBnnV/rt
	 LVJD1sgom/wTw==
Date: Fri, 6 Dec 2024 13:14:45 +0000
From: Lee Jones <lee@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <20241206131445.GE7684@google.com>
References: <20241206124218.165880-1-lee@kernel.org>
 <Z1LzOORuFpO0MXAZ@pollux>
 <20241206125430.GB7684@google.com>
 <Z1L2tjNrIa2Q0Awf@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1L2tjNrIa2Q0Awf@pollux>

On Fri, 06 Dec 2024, Danilo Krummrich wrote:

> On Fri, Dec 06, 2024 at 12:54:30PM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Danilo Krummrich wrote:
> > 
> > > On Fri, Dec 06, 2024 at 12:42:11PM +0000, Lee Jones wrote:
> > > > It has been suggested that the driver should use dev_info() instead of
> > > > pr_info() however there is currently no scaffolding to successfully pull
> > > > a 'struct device' out from driver data post register().  This is being
> > > > worked on and we will convert this over in due course.
> > > 
> > > I think you're going too fast with this series.
> > > 
> > > Please address the comments you receive before sending out new versions.
> > > 
> > > Also, please document the changes you have made from one version to the next,
> > > otherwise it's gonna be very hard to review this.
> > 
> > I can add a change log.
> > 
> > What comments were missed?
> 
> I think MiscDevice should ideally use the generic `Registration` type from [1].

How can an in-tree driver use out-of-tree functionality?

> I see that you use `InPlaceModule` now, which is fine. But since this is just a
> sample, we could probably afford to wait until the generic type lands.
> 
> Also, there was a comment about how we can make use of the `dev_*` macros.
> 
> I really think we should fix those before we land a sample driver. It's gonna
> be hard to explain people later on that they shouldn't do what the example
> does...

We're authoring the sample based on what is available at the moment.

There will always be something better / more convenient coming down the
pipe.  We don't usually put off contributors pending acceptance of
out-of-tree functionality, sample or otherwise.

As I've already mentioned, I'd be _more than_ happy to keep improving
this over time as new and improved helpers / infra. arrives.

> [1] https://lore.kernel.org/rust-for-linux/20241205141533.111830-3-dakr@kernel.org/

-- 
Lee Jones [李琼斯]

