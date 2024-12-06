Return-Path: <linux-kernel+bounces-434523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C89E67CA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAA3162001
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39576199392;
	Fri,  6 Dec 2024 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cKUmO2d+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80F190470;
	Fri,  6 Dec 2024 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469641; cv=none; b=K+Z24QYGxMcyT3nDF6MkT2+/V3HygaCGBHQHGxLj563EK9LGoJE7/EFuAntD9fi8Pu8cL4IEK+pVvV3p1pFqUD2mgmkLAfnvk3oaI6RgNWg9zk112KJuyxPtMYSuTHF1i0HKVu0zm9ocMSyG52NH9nakb8MqPI0M017hstQqGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469641; c=relaxed/simple;
	bh=RigLpxdObOnsR/RJaY+Sq3GV1pD+3R0CKCWExco0V3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq7Gz/wB3oD+5DaHVTr0or8ySTdT2CgIUaxWu8aFo+joQV0vMGmMuufUIbkbpUGbP4WzyVtlktM+6MJbk3L6wx2SC2Yu3myTeqIppitwVOBZhuCyXjAnhSLnD/A+YWKcV986cuYJBWgvMYmKYsZ+zeM6MjtjIGsZulPHKYsX5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cKUmO2d+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E784BC4CED1;
	Fri,  6 Dec 2024 07:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733469641;
	bh=RigLpxdObOnsR/RJaY+Sq3GV1pD+3R0CKCWExco0V3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKUmO2d+dBWSc6WByFboGvtd60HAC0UCvLCx/riYGyPEWep+f1WH8uCEeLsga4HRv
	 NFVjKNdZQsuApWwwiY8NUxNHwoECEkE3DMN6S+NGjLyFn+fZUeaROMf9GVKNsT5kb2
	 Ozz9sYB0rsz8EBKN84xh6wu/OFvm+ud5vSTHdrik=
Date: Fri, 6 Dec 2024 08:20:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <2024120610-jailbreak-preschool-ff45@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-4-lee@kernel.org>
 <2024120604-diffusive-reach-6c99@gregkh>
 <20241206071430.GC8882@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206071430.GC8882@google.com>

On Fri, Dec 06, 2024 at 07:14:30AM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Greg KH wrote:
> > > +    fn open() -> Result<KBox<Self>> {
> > > +        pr_info!("Opening Rust Misc Device Sample\n");
> > 
> > I'd prefer this to be dev_info() to start with please.
> 
> This is not possible at the moment.  Please see the cover-letter.

Then why make the change to miscdevice.rs if that pointer provided there
doesn't work for you here?

confused,

greg k-h

