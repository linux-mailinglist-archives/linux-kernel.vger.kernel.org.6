Return-Path: <linux-kernel+bounces-435347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879F09E7660
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F17B166D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02741F3D2E;
	Fri,  6 Dec 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAEPZfD1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B220627F;
	Fri,  6 Dec 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503765; cv=none; b=W8hJBP2D8k0PCZWIq7NDqDfgftf0ZumHB8fRsvxwOkjhQhM53fufwCRgNOM3G8uWrFmwjMzguSV6a3kEdtDaR8rD5PuVKAdLxpr9h9ftZiNeszMsuxlr6zeU6SL/34u8hhIt1JXZGML9Wg6sByk+5DNYGgZVDCeGyJ1yIGqkCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503765; c=relaxed/simple;
	bh=UeKtN2BtVxO2wPZowv8deGBv035MOLPP/4qWZm6tNEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQLZZsejtLvwZi4yEP5X9Rg8cAO2o4+uCPMfZ7L7z10otMmhjqVmBIyDil078ghe/dQOSwsiFHc/QjgxJz1CkFWfC7USgb7AWa/pokPt1P7gOZ8WKj7CD/qOHttTf3fc9kAVSxmtQRWbVIAfZYOZcD4rumBBGvcdFnDiTnCTv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAEPZfD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2A7C4CEDE;
	Fri,  6 Dec 2024 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733503764;
	bh=UeKtN2BtVxO2wPZowv8deGBv035MOLPP/4qWZm6tNEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAEPZfD1MWRpDXbqvn2g1pA7KTG4zriOSMOp1tTDC6/23O/z5t9YkqWh+kHWvOGNn
	 PRsxVIlJL9u8CEFKpHLeXaGIRyHsR3KIn5AFslVEPmPQkraVkvYGIR090fLOgd6Y0A
	 oSc01N1bGBZIe6jfjbccoPQqT7clgP/+kYZqF8FKB0DeN8t5AXTOb2BOrsMaIr63Hc
	 xlaLfQZkxvMDbD7l/cbKW0zQ6QEmgHiQfBuBqYN0rt/ApAOQZ1S921Jt1oLB06/CB7
	 tNqzBlRSPTOy61L6nO4f9RL4VuRW67NtRaovCUbSL4gwTkcpY4YNKUcC4QcnEU2Sg+
	 gFnEbKgL1L58w==
Date: Fri, 6 Dec 2024 16:49:18 +0000
From: Lee Jones <lee@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <20241206164918.GA6336@google.com>
References: <20241206124218.165880-1-lee@kernel.org>
 <Z1LzOORuFpO0MXAZ@pollux>
 <20241206125430.GB7684@google.com>
 <Z1L2tjNrIa2Q0Awf@pollux>
 <20241206131445.GE7684@google.com>
 <Z1L9dLyLRmLcwMne@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1L9dLyLRmLcwMne@pollux>

On Fri, 06 Dec 2024, Danilo Krummrich wrote:

> On Fri, Dec 06, 2024 at 01:14:45PM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Danilo Krummrich wrote:
> > 
> > > On Fri, Dec 06, 2024 at 12:54:30PM +0000, Lee Jones wrote:
> > > > On Fri, 06 Dec 2024, Danilo Krummrich wrote:
> > > > 
> > > > > On Fri, Dec 06, 2024 at 12:42:11PM +0000, Lee Jones wrote:
> > > > > > It has been suggested that the driver should use dev_info() instead of
> > > > > > pr_info() however there is currently no scaffolding to successfully pull
> > > > > > a 'struct device' out from driver data post register().  This is being
> > > > > > worked on and we will convert this over in due course.
> > > > > 
> > > > > I think you're going too fast with this series.
> > > > > 
> > > > > Please address the comments you receive before sending out new versions.
> > > > > 
> > > > > Also, please document the changes you have made from one version to the next,
> > > > > otherwise it's gonna be very hard to review this.
> > > > 
> > > > I can add a change log.
> > > > 
> > > > What comments were missed?
> > > 
> > > I think MiscDevice should ideally use the generic `Registration` type from [1].
> > 
> > How can an in-tree driver use out-of-tree functionality?
> 
> AFAICT, this sample module is in the exact same stage as the generic device / driver
> infrastructure.
> 
> Both are on the mailing list in discussion for inclusion into the kernel.
> Labeling one as in-tree and the other one as out-of-tree is clearly misleading.

If I was saying that, I'd agree with you.

I was asking how MiscDevice (in-tree) could use Registration (out-of-free).

> I'm just saying it would be good to align this. If the sample driver is time
> critical, I have no problem if you go ahead with the current
> `MiscDeviceRegistration` and `InPlaceModule`, but again, why not align it from
> the get-go?

Because it's not available yet. :)

> > > I see that you use `InPlaceModule` now, which is fine. But since this is just a
> > > sample, we could probably afford to wait until the generic type lands.
> > > 
> > > Also, there was a comment about how we can make use of the `dev_*` macros.
> > > 
> > > I really think we should fix those before we land a sample driver. It's gonna
> > > be hard to explain people later on that they shouldn't do what the example
> > > does...
> > 
> > We're authoring the sample based on what is available at the moment.
> 
> Well, for this I have to disagree, not being able to use the `dev_*` macros is
> simply meaning that the abstraction is incomplete (in this aspect).
> 
> I don't see the need to land a sample driver that tells the user to do the wrong
> thing, i.e. use the `pr_*` macros.
> 
> As Alice mentioned, you can get the miscdevice pointer from the file private
> data in open() and then make it accessible in the other fops hooks. If we go for
> this solution it will change the callbacks of `MiscDevice` and maybe even some
> other architectural aspects.
> 
> This needs to be addressed first.

The issue about ever growing dependencies _can_ be that authors have
other priorities and are slow to turn things around, which may end up
with nothing being accepted and contributors getting frustrated.

However, taking into consideration how swift Alice is with these things,
I'd be happy to wait for this part if people are insistent.

> > There will always be something better / more convenient coming down the
> > pipe.  We don't usually put off contributors pending acceptance of
> > out-of-tree functionality, sample or otherwise.
> 
> No one asks for this here. But if the example reveals shortcomings, we shouldn't
> promote them as example.

IMHO it's reasonable for the sample to represent the current status of
the frameworks in use.  As advancements / adaptions are introduced we
can use them to continually improve the example.

-- 
Lee Jones [李琼斯]

