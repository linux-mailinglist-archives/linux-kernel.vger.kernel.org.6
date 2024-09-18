Return-Path: <linux-kernel+bounces-332857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7001797BFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB8EB20DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A917A1C9DFE;
	Wed, 18 Sep 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQ3OEi6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E241ACE0F;
	Wed, 18 Sep 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726681173; cv=none; b=XhasENx7KzkhN51V1n+uev8F1hz4sbBomzLbyncTKGi7eMWHVHj5aTu9WAJ1bNveO0S3Haf557POx1sMEvXVH2mYPs8h/lAs9dDA7iDfD52D12CAye4X6TkR+1/G0VlOaipchQ/6m+4zYCoHILUuPZ7xF7Jeeka+Y4xj+KVauNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726681173; c=relaxed/simple;
	bh=6fvGOTYPpuxD1CfR1yv0PU9tWs8bxTCP6YOL9Y+thPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozXc6xAaijDXCnh6fUVJ42uO9hvRSNcn17wPQsQ+9G6JHlrg6FOtqi7l3J5n1mSk0UlELtuTeObaclpCrZB7/HgjSB7I5hHujPctLf5Fh5Zirf0HX/Rp8oKmb7B5TCh9FrFz6bXBmbiIahRIhn9Gq+RXBzc0hWNvUTUl1tJSwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQ3OEi6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C27C4CEC2;
	Wed, 18 Sep 2024 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726681170;
	bh=6fvGOTYPpuxD1CfR1yv0PU9tWs8bxTCP6YOL9Y+thPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQ3OEi6iVKmBcu4BXzJVHl2FKsTMlM/S1tXhInU+mvobRVRzwc9L3NkmfMMbarvpd
	 Vg6RqkZVf/71p4X11ixduN0fovtgJ536vmubTa4SxKoPERhQK9NumAM0AzRbpr9E5N
	 LHivkx31jGC5OR6bWV9LS423/HNhzK/P+Rg25lUw=
Date: Wed, 18 Sep 2024 19:39:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: add untrusted data abstraction
Message-ID: <2024091812-baffle-cubbyhole-34b9@gregkh>
References: <20240913112643.542914-1-benno.lossin@proton.me>
 <20240913112643.542914-2-benno.lossin@proton.me>
 <ZuRbSxwlz1xWT1pG@phenom.ffwll.local>
 <cf0d6189-e81c-4b7c-ab50-7a297c69b132@proton.me>
 <ZuhTdwCqz61bQEgq@phenom.ffwll.local>
 <26534d80-989d-4b77-9720-84575275890f@proton.me>
 <2024091858-surrender-broadcast-e11f@gregkh>
 <af028585-d253-4460-acdc-99b349f49d47@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af028585-d253-4460-acdc-99b349f49d47@proton.me>

On Wed, Sep 18, 2024 at 05:33:33PM +0000, Benno Lossin wrote:
> On 18.09.24 19:09, Greg KH wrote:
> > On Wed, Sep 18, 2024 at 03:40:54PM +0000, Benno Lossin wrote:
> >>>> Yeah, we need more users of this to know the full way to express this
> >>>> correctly. I would like to avoid huge refactorings in the future.
> >>>
> >>> I think adding it to the copy_*_user functions we already have in
> >>> upstream, and then asking Alice to rebase binder should be a really solid
> >>> real-world testcase. And I think currently for the things in-flight
> >>> copy*user is going to be the main source of untrusted data anyway, not so
> >>> much page cache folios.
> >>
> >> Sure. I chose tarfs as the use-case, because Greg mentioned to me that
> >> it would benefit from adding this API. (I have no prior linux kernel
> >> experience, so you giving me some pointers where this will be useful is
> >> very helpful!)
> > 
> > I just had tarfs as an easy example where we were reading data off the
> > disk and acting on it, in a way just like C where if the data is
> > corrupted we can do "not normal" things.  Sorry it got tied up with
> 
> No worries! I was just under the impression that this would be common
> (maybe it's common for filesystems?), so just having that clarification
> now makes more sense.

Yes, this would be common for filesystems.

