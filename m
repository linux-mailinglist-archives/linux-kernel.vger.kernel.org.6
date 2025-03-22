Return-Path: <linux-kernel+bounces-572154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB733A6C76C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 04:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44199189819F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437213635E;
	Sat, 22 Mar 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mUYVwEye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6F33D8;
	Sat, 22 Mar 2025 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614392; cv=none; b=k/a9AiBLsMPLvsGD2JKuw+guS9kA3ay4epLxHiIY05GKwuDPRfFDTaeI+9g5RHHnkRiAAqTNypKTtnpmzIOZsjYEhSai4LQ1/xo4BN6xxsOSmP68vbyZXa/EjX5vdHpGhvGU3yHdeJChRnogCSxEqK9Yzk8DMl74LzDPu8aaFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614392; c=relaxed/simple;
	bh=ceGLH2OtSdendbouHLsqHGgZ+QIApJ9DTY98Efe95Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSZSc3X9TkA9bCa8ybWL3bk38WKTuC4Od7RvZK2KpVJ1pbNczPLfM2aQGtOcN7tIjJt5nyZANZcjrIM0ldBud0tSjksNfNgKubew/eRFZcwv5T6pIVzi5aVX9MWPF7+/QCmjUE7D+664XQ1zVM5LwRfKBw9u0hCVddkkf4k1mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mUYVwEye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ED9C4CEDD;
	Sat, 22 Mar 2025 03:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742614391;
	bh=ceGLH2OtSdendbouHLsqHGgZ+QIApJ9DTY98Efe95Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUYVwEyeG7U805rVloJImuzfUgeuOHtqFrcsMTFLpCD8BjC7PYHtEM59/P+Yjka3Y
	 qdWJBqw8VX0MnVfwNBM2xKhUpnw3pDwefzhyFDoW9i7WHC5T2fn5ELv/6Cgi8RM8WX
	 PW4iAnvbgWnIzYy3JxZFxQKnFgq5LdgN8zdCrK2k=
Date: Fri, 21 Mar 2025 20:31:49 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lyude Paul <lyude@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com, Alice Ryhl <aliceryhl@google.com>,
	Simona Vetter <sima@ffwll.ch>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 10/33] rust: drm/kms: Add
 ConnectorGuard::add_modes_noedid()
Message-ID: <2025032142-handsaw-gumming-40db@gregkh>
References: <20250305230406.567126-1-lyude@redhat.com>
 <20250305230406.567126-11-lyude@redhat.com>
 <20250314-observant-cyber-chowchow-bfe5f9@houat>
 <dea3218eb31f3e91d2a10f93a7bc6cfa674546e6.camel@redhat.com>
 <2d39187892737438c35791aa59681b1af7e62de7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d39187892737438c35791aa59681b1af7e62de7.camel@redhat.com>

On Fri, Mar 21, 2025 at 07:52:23PM -0400, Lyude Paul wrote:
> On Fri, 2025-03-21 at 19:50 -0400, Lyude Paul wrote:
> > On Fri, 2025-03-14 at 13:02 +0100, Maxime Ripard wrote:
> > > On Wed, Mar 05, 2025 at 05:59:26PM -0500, Lyude Paul wrote:
> > > > A simple binding for drm_add_modes_noedid() using the ConnectorGuard type
> > > > we just added.
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > ---
> > > >  rust/bindings/bindings_helper.h  |  1 +
> > > >  rust/kernel/drm/kms/connector.rs | 11 +++++++++++
> > > >  2 files changed, 12 insertions(+)
> > > > 
> > > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > > > index 27828dd36d4f2..846eb6eb8fc4c 100644
> > > > --- a/rust/bindings/bindings_helper.h
> > > > +++ b/rust/bindings/bindings_helper.h
> > > > @@ -13,6 +13,7 @@
> > > >  #include <drm/drm_crtc.h>
> > > >  #include <drm/drm_device.h>
> > > >  #include <drm/drm_drv.h>
> > > > +#include <drm/drm_edid.h>
> > > >  #include <drm/drm_encoder.h>
> > > >  #include <drm/drm_file.h>
> > > >  #include <drm/drm_fbdev_dma.h>
> > > > diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
> > > > index 14de3b0529f89..855a47b189a91 100644
> > > > --- a/rust/kernel/drm/kms/connector.rs
> > > > +++ b/rust/kernel/drm/kms/connector.rs
> > > > @@ -446,6 +446,17 @@ fn deref(&self) -> &Self::Target {
> > > >      }
> > > >  }
> > > >  
> > > > +impl<'a, T: DriverConnector> ConnectorGuard<'a, T> {
> > > > +    /// Add modes for a [`ConnectorGuard`] without an EDID.
> > > > +    ///
> > > > +    /// Add the specified modes to the connector's mode list up to the given maximum resultion.
> > > > +    /// Returns how many modes were added.
> > > > +    pub fn add_modes_noedid(&self, (max_h, max_v): (i32, i32)) -> i32 {
> > > 
> > > Why do we need a tuple of i32 there instead of two u32/usize parameter?
> > > 
> > > And the return type should be unsigned as well.
> > 
> > I think I was just copying C (or whatever the bindings here translate the C
> > type to), but I don't see any issue with changing this to u32.
> 
> ...wait. Now I remember why I did this: it's not that we expect it to be
> unsigned, it's that the largest possible u32 value cannot be expressed in a
> i32, and I think the C side of things uses i32. Days like this I really wish
> we had a u31...
> 
> think it would be OK for us to convert this to unsigned on the C side of
> things?

Yes please.

