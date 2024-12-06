Return-Path: <linux-kernel+bounces-435081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24649E6F5D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA62716BDAF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593841FCF5B;
	Fri,  6 Dec 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ooyj1zpO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39111F8EFF;
	Fri,  6 Dec 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492090; cv=none; b=B69mPJZviZco6osrk/kp1CvRbfMh19eYF+2YGLVMnkO83Msriu7aT0RWB/FzfsB73uYDiR6I6LK09WrA26nYc72ZOUHj3HF6GU3wOLrx9ybJ2qrwMT6a/r9Y/auJqaJATogbNjgQsbkxQskA3sl77xhW+nWUqv6XRKe93ElCWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492090; c=relaxed/simple;
	bh=Px5F81YeNSqDirNFTRpLwRGatcJ/pFI3iw494vD741Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srpTewrmWW4W16JRPjJ0G/O3kBa9C3ooTiG7oDCkwfQyXMeF66ZHFKmDmHQggBSD8amYS1f0wMKNrbvW4FJ7m+9GDCzbD8N9JddgPAcxBROpBBMU0F5lmh8S+SS/KdB64Ej6+gtIan4N3TMJAUuoOLx6HT7+n23N8wwKzN60dX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ooyj1zpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48163C4CED1;
	Fri,  6 Dec 2024 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733492090;
	bh=Px5F81YeNSqDirNFTRpLwRGatcJ/pFI3iw494vD741Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ooyj1zpOSC03qSu9+IRNJIhD217uuJIM8YELkts+lBdAOTw7BcD/5UqCJeYavhS6h
	 fjB29kCgAvSCYzvlvU7x+8bNfT46UM4nGbStNmSscA2xdqHfLyk8R/6RAbQlfap1E4
	 aGZSgalOHQrEpC7RnBzHjWayiX8tYaC4HVQ1jEexwWX2vKhE0oqeIDxkUcBiddt3yi
	 biHDIcZKP6YBYEoOHIBWJ0wbIOTNrdeNr30Qd5D42qclzlY+2/s1wWC87zbbrdyuKT
	 9ftjYWc0xWM/rCTotS0CWF9nF5qqKwsERL9PU6yFwGrHefhUC1nx+1MLLzdcjMvZG4
	 YsNMD1le/TWIA==
Date: Fri, 6 Dec 2024 14:34:44 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <Z1L9dLyLRmLcwMne@pollux>
References: <20241206124218.165880-1-lee@kernel.org>
 <Z1LzOORuFpO0MXAZ@pollux>
 <20241206125430.GB7684@google.com>
 <Z1L2tjNrIa2Q0Awf@pollux>
 <20241206131445.GE7684@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206131445.GE7684@google.com>

On Fri, Dec 06, 2024 at 01:14:45PM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Danilo Krummrich wrote:
> 
> > On Fri, Dec 06, 2024 at 12:54:30PM +0000, Lee Jones wrote:
> > > On Fri, 06 Dec 2024, Danilo Krummrich wrote:
> > > 
> > > > On Fri, Dec 06, 2024 at 12:42:11PM +0000, Lee Jones wrote:
> > > > > It has been suggested that the driver should use dev_info() instead of
> > > > > pr_info() however there is currently no scaffolding to successfully pull
> > > > > a 'struct device' out from driver data post register().  This is being
> > > > > worked on and we will convert this over in due course.
> > > > 
> > > > I think you're going too fast with this series.
> > > > 
> > > > Please address the comments you receive before sending out new versions.
> > > > 
> > > > Also, please document the changes you have made from one version to the next,
> > > > otherwise it's gonna be very hard to review this.
> > > 
> > > I can add a change log.
> > > 
> > > What comments were missed?
> > 
> > I think MiscDevice should ideally use the generic `Registration` type from [1].
> 
> How can an in-tree driver use out-of-tree functionality?

AFAICT, this sample module is in the exact same stage as the generic device / driver
infrastructure.

Both are on the mailing list in discussion for inclusion into the kernel.
Labeling one as in-tree and the other one as out-of-tree is clearly misleading.

I'm just saying it would be good to align this. If the sample driver is time
critical, I have no problem if you go ahead with the current
`MiscDeviceRegistration` and `InPlaceModule`, but again, why not align it from
the get-go?

> 
> > I see that you use `InPlaceModule` now, which is fine. But since this is just a
> > sample, we could probably afford to wait until the generic type lands.
> > 
> > Also, there was a comment about how we can make use of the `dev_*` macros.
> > 
> > I really think we should fix those before we land a sample driver. It's gonna
> > be hard to explain people later on that they shouldn't do what the example
> > does...
> 
> We're authoring the sample based on what is available at the moment.

Well, for this I have to disagree, not being able to use the `dev_*` macros is
simply meaning that the abstraction is incomplete (in this aspect).

I don't see the need to land a sample driver that tells the user to do the wrong
thing, i.e. use the `pr_*` macros.

As Alice mentioned, you can get the miscdevice pointer from the file private
data in open() and then make it accessible in the other fops hooks. If we go for
this solution it will change the callbacks of `MiscDevice` and maybe even some
other architectural aspects.

This needs to be addressed first.

> 
> There will always be something better / more convenient coming down the
> pipe.  We don't usually put off contributors pending acceptance of
> out-of-tree functionality, sample or otherwise.

No one asks for this here. But if the example reveals shortcomings, we shouldn't
promote them as example.

> 
> As I've already mentioned, I'd be _more than_ happy to keep improving
> this over time as new and improved helpers / infra. arrives.
> 
> > [1] https://lore.kernel.org/rust-for-linux/20241205141533.111830-3-dakr@kernel.org/
> 
> -- 
> Lee Jones [李琼斯]

