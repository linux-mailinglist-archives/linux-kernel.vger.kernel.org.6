Return-Path: <linux-kernel+bounces-548004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF4FA53EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9567C1891461
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4DB207A3E;
	Wed,  5 Mar 2025 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlnekHAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291C1E7C20;
	Wed,  5 Mar 2025 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219047; cv=none; b=c+YOTES1J1/3FYoMAB1+b+qFYWFg/bDxgFn5WND5PcX0LVylzkIz/C6T/YDHjhhWsW1I7h+ZruB/elu6RBg8+4YuUUzEzypl5rYECQMp/BG/HYRYb0luETMxCRTOXvzU7jBep9Wza6NhwzeqNFCjIphYT3V+pVZUoGCyLiDBJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219047; c=relaxed/simple;
	bh=QRJv6AFPFNy75p7zfaZ2IXSyUSPhoWe5fwtItKMg7Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP429G8ajYrOs2ywGSQvsDHQlkjj4nEsmv2F8Ar0YgqA1AK9mggXAkfhXBh5bFZoJqrnnl9QT5s0SfxikrnRoII3eFAlsDxmKSCU62Iec9TXC8Egb3CdLkjTTOgy8dD9vxKt44aWPXg8uyhbiqFyF7e7kRA5EMX01E1juJv86sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlnekHAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B9FC4CED1;
	Wed,  5 Mar 2025 23:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741219047;
	bh=QRJv6AFPFNy75p7zfaZ2IXSyUSPhoWe5fwtItKMg7Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlnekHAYXRKnKt2JxmOVnfIz5RncxlJkMw1jFjdFoajqFchcIl4oNvJspBVLte/CK
	 b7iYMcyvyHaESdqBVRMROUG3lc/r0CzYUpEHHLCzx89rjFNBGit5Ef2baSZYshn/xj
	 xMn5+Q6CJDUo1Y4sco/dP4RikYTfhtDv84nWCxI5Bggqo00ciivFCze0rQPskIl+oh
	 aOw1Sbl/5ThhxOUyDV9bEjCNFmmBnkh5Zi/5YQVE8LSHKB+vTccBks+LEN45zbGhEn
	 IdbrAJJynzIZZL6wr6VTmNeXxwi2EHAjjC9Hk4ons0SlloVT8ES3QZ7bZt46sZqzhj
	 wxBfrWCvpCldQ==
Date: Thu, 6 Mar 2025 00:57:18 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, russ.weight@linux.dev,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 2/5] rust: firmware: introduce
 `firmware::ModInfoBuilder`
Message-ID: <Z8jk3qs6nCIJz-39@pollux>
References: <20250304173555.2496-1-dakr@kernel.org>
 <20250304173555.2496-3-dakr@kernel.org>
 <D88OSC9XJXZL.C5HXWFYCG9U6@proton.me>
 <Z8jSV5CpZDcXrviY@pollux>
 <D88Q7503C8FF.2TMMBSEMOGKU1@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D88Q7503C8FF.2TMMBSEMOGKU1@proton.me>

On Wed, Mar 05, 2025 at 11:36:54PM +0000, Benno Lossin wrote:
> On Wed Mar 5, 2025 at 11:38 PM CET, Danilo Krummrich wrote:
> > On Wed, Mar 05, 2025 at 10:30:31PM +0000, Benno Lossin wrote:
> >> On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
> >> > +    /// Push an additional path component.
> >> > +    ///
> >> > +    /// After a new [`ModInfoBuilder`] instance has been created, [`ModInfoBuilder::prepare`] must
> >> > +    /// be called before adding path components.
> >> > +    pub const fn push(self, s: &str) -> Self {
> >> > +        if N != 0 && self.n == 0 {
> >> > +            crate::build_error!("Must call prepare() before push().");
> >>
> >> This will only prevent the first `prepare` call being missed, right?
> >
> > Correct, unfortunately there's no way to detect subsequent ones.
> 
> Does it make sense to do that one in the constructor?
> 
> (After looking at the example below) Ah maybe you can't do that, since
> then you would have two `prepare()` calls for the example below...?

Exactly.

> >> If you always have to call this before `push`, why not inline it there?
> >
> > You can push() multiple times to compose the firmware path string (which is the
> > whole purpose :).
> 
> Ah I see, I only looked at the example you have in the next patch. All
> in all, I think this patch could use some better documentation, since I
> had to read a lot of the code to understand what everything is supposed
> to do...

I can expand the example in module_firmware! to make things a bit more obvious.

Otherwise, what information do you think is missing?

> 
> It might also make sense to make this more generic, since one probably
> also needs this in other places? Or do you think this will only be
> required for modinfo?

Currently, I don't think there's any more need for a generic const string
builder. For now, I think we're good. Let's factor it out, once we have actual
need for that.

