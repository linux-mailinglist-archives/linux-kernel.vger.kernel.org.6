Return-Path: <linux-kernel+bounces-435724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2579E7B66
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7701886193
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F71A1F3D4C;
	Fri,  6 Dec 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgrRyGvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4B1B87D6;
	Fri,  6 Dec 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522776; cv=none; b=LsJFF3cDPlO2bAW9dxCrSVv6sURcbRgb1C8eD3tjP//OATrWvwufzjwXEpUZl/vM/ePt01qaU+eIJDbIISCKxQwpFUgVdN2fMQP/C5v8AriFSGQsSryzQLlnM6FKDXF/wnKppxMmbFmM2K8MaMT+daszShXRJHKc9uk7gL1etKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522776; c=relaxed/simple;
	bh=+dNj1CoVpM81sbl1XakslMW0j842w/mtXHSFKE6yxyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osi6oIdWClH3rr/pm2UppHPvBRhbM6A213f4rRazJ/T6YhEu5jtWG5bZQyl9X73dprz7x0ZEHXHuBY0rgisSMX7a0acMTFKcPPJMqxOmVezE+LjeCKdNO95qVUxdFxi22V+w6IJ9Tvp5GYXJQ2ZH/yesu5q9qNR1Mwa3p9F9dHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgrRyGvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43A7C4CEDE;
	Fri,  6 Dec 2024 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733522775;
	bh=+dNj1CoVpM81sbl1XakslMW0j842w/mtXHSFKE6yxyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgrRyGvzbUTInjjm2bwjvvqmyTsOD71iuXcTcqQKNf9ZRTe4yIbyWT+aUWa6pdJWV
	 QOb8/vVlCMEaHdh9bhKMce3yTj4ofkRPlYQ208aH3w3bv/OhIkJa6Y8o9V9/Bbkm5P
	 qV2FO2m8B/m62YaxhjQYVnmUd/cXkNvjn8P80I9R1UX2mNQgIDUNvAYgjZyIA8lvh5
	 cYTeO5ZV8OvtSac3J43WGGAbQMIe9+8JOr7WhaDBItQqL78GHHaFF21dQvchcmDz5s
	 YwPuneDhhxQMw1t4OPz4LstCDR2+vZMnUvN98RKtfVPB67OFuBKcbPRXrUS6lR/e9f
	 U8YUaqyStqIcg==
Date: Fri, 6 Dec 2024 22:06:09 +0000
From: Lee Jones <lee@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <20241206220609.GA6126@google.com>
References: <20241206124218.165880-1-lee@kernel.org>
 <Z1LzOORuFpO0MXAZ@pollux>
 <20241206125430.GB7684@google.com>
 <Z1L2tjNrIa2Q0Awf@pollux>
 <20241206131445.GE7684@google.com>
 <Z1L9dLyLRmLcwMne@pollux>
 <20241206164918.GA6336@google.com>
 <Z1NCcGOwarDhU8GB@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1NCcGOwarDhU8GB@pollux>

On Fri, 06 Dec 2024, Danilo Krummrich wrote:

> On Fri, Dec 06, 2024 at 04:49:18PM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Danilo Krummrich wrote:
> > > > > Also, there was a comment about how we can make use of the `dev_*` macros.
> > > > > 
> > > > > I really think we should fix those before we land a sample driver. It's gonna
> > > > > be hard to explain people later on that they shouldn't do what the example
> > > > > does...
> > > > 
> > > > We're authoring the sample based on what is available at the moment.
> > > 
> > > Well, for this I have to disagree, not being able to use the `dev_*` macros is
> > > simply meaning that the abstraction is incomplete (in this aspect).
> > > 
> > > I don't see the need to land a sample driver that tells the user to do the wrong
> > > thing, i.e. use the `pr_*` macros.
> > > 
> > > As Alice mentioned, you can get the miscdevice pointer from the file private
> > > data in open() and then make it accessible in the other fops hooks. If we go for
> > > this solution it will change the callbacks of `MiscDevice` and maybe even some
> > > other architectural aspects.
> > > 
> > > This needs to be addressed first.
> > 
> > The issue about ever growing dependencies _can_ be that authors have
> > other priorities and are slow to turn things around, which may end up
> > with nothing being accepted and contributors getting frustrated.
> 
> I would share your argumentation if
> 
> 1) we'd talk about a real driver, where people are actually waiting for,
> 2) it'd be about a new feature, performance improvement, etc.
> 
> What we have here is different:
> 
> You wrote a sample implementation for a new and just landed abstraction that
> reveals a shortcoming. (Which is great, because it means the sample already
> served an important purpose.)
> 
> IMHO, the consequence should not be to merge the sample as is anyways, because
> another purpose of the sample implementation is to tell people "look, this is
> exactly how it should look like, please do it the same way".
> 
> Instead, we should fix the shortcoming, adjust the sample implementation and
> merge it then.
> 
> Just to make it clear, for a real driver I think it would be reasonable to just
> go ahead, but for a sample that should educate, we should fix things first.

Provided that we stay within certain tolerances, I don't see any of
what you've said as particularly unreasonable.  I'll have an out-of-band
chat with Alice on Monday with a view to conjuring up a game plan.

-- 
Lee Jones [李琼斯]

