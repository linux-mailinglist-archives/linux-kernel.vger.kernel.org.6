Return-Path: <linux-kernel+bounces-325562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EED975B53
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8039D1F23595
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A416B1BB694;
	Wed, 11 Sep 2024 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uaeL/Img"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F701B7917;
	Wed, 11 Sep 2024 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085226; cv=none; b=WaTG8NMX3P34SZTdysaDzx1fkf1canTKGMUg257e5RIeMLPDUQdiZjn4QfYBeJz441f4HWp3Fv2NLA55mZ027yqlFkjf1mm8is2lDnDjAHiJN+uooJ8ErIDfkSTYx9yuUzJgLhCBwG8WigYfPp5VOzvRRo2Jd1rGt6nn5FdR5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085226; c=relaxed/simple;
	bh=I4BJLT6G+F0wLdMtohFskrraQnFUUj6Fg5Q8+RwPmXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mImakz/OzbtyVUZyTOM78aMchaiZ/AaFs6klam+zJO9p/xKmR6+0Z7lVPeibmNcxspkH1ZCsMwM2HQjy0Y91dr/D3r94XAFvKtMW4aEAGXisJ3QZXa0RVQ6Ud2BkuLRGMhv+xX45Oh7TcAR+6auYHpz/IY5bfpXkuT8ErrybDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uaeL/Img; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A8DC4CEC0;
	Wed, 11 Sep 2024 20:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726085225;
	bh=I4BJLT6G+F0wLdMtohFskrraQnFUUj6Fg5Q8+RwPmXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaeL/Img29qakLFRIxlhJcVZNDw7mlRWB+nv0ap2MGT+YdM3gXm0oEgSWfozHa+Lx
	 XvJ6mdoLIh2WXW0OdkMo2ojZGuTvOwq/M/inTuZEwj6wwut+FnmPuJgVrwcPjCBZz2
	 O6jenm5DjSaqhX9tsVcV8tb3RnFMWI2LlwYcDDzY=
Date: Wed, 11 Sep 2024 22:07:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Ayush Singh <ayush@beagleboard.org>, fabien.parent@linaro.org,
	d-gole@ti.com, lorforlinux@beagleboard.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] rust: kernel: Add Platform device and driver
 abstractions
Message-ID: <2024091158-cardinal-theorize-6efe@gregkh>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>
 <2024091106-scouring-smitten-e740@gregkh>
 <ZuHU5yrJUOKnJGrB@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuHU5yrJUOKnJGrB@pollux>

On Wed, Sep 11, 2024 at 07:35:35PM +0200, Danilo Krummrich wrote:
> On Wed, Sep 11, 2024 at 04:56:14PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 11, 2024 at 07:57:18PM +0530, Ayush Singh wrote:
> > > +/// An identifier for Platform devices.
> > > +///
> > > +/// Represents the kernel's [`struct of_device_id`]. This is used to find an appropriate
> > > +/// Platform driver.
> > > +///
> > > +/// [`struct of_device_id`]: srctree/include/linux/mod_devicetable.h
> > > +pub struct DeviceId(&'static CStr);
> > > +
> > > +impl DeviceId {
> > 
> > <snip>
> > 
> > I appreciate posting this, but this really should go on top of the
> > device driver work Danilo Krummrich has been doing.
> 
> If everyone agrees, I'd offer to just provide platform device / driver
> abstractions with my next patch series. This way you don't need to worry
> about aligning things with the rest of the abstractions yourself and throughout
> potential further versions of the series.

That sounds good to me, thanks!

> Just be aware that I probably won't get to work on it until after LPC.

We will not be able to review anything until after LPC either :)

thanks,

greg k-h

