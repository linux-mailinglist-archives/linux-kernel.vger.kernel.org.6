Return-Path: <linux-kernel+bounces-271478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C33944ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342BB2842F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5D13C838;
	Thu,  1 Aug 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p083xwMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD080130A47;
	Thu,  1 Aug 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524950; cv=none; b=VJx4qBYuqpcJ+Z28kaqmfJcWppKVEyrxReMicpKdpX8aBIfK4TGau1VOL5s93lANeSdsJHdILt/yM4zmhvgzLAk0LROqkM+t+U8ioIGDNY/lwBRgSpdLy8n8bTpSid4g8rSQ45bvcFa63Bi48axI/URQcLZVlNgEAKahinPyezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524950; c=relaxed/simple;
	bh=39oRWrJ6tH5uFM0B512mIFUHDm4aZpg6Aw1BkANjRFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+j/1SQwGTIKizBrDa0J8A0yDTHa/yisaim2n+CGy961tDIZ1SyDTXQPxTbUw4SJPxn4rQIo9D/+Uyu3EXlhI95r7G5Z8ftBLgrDenv++GNfimkAHPLuk6JYBR8JSW5E2HybL02AZbI/6OcPIHg5lTn99xe17IUkXUmG2WGherg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p083xwMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F37C4AF09;
	Thu,  1 Aug 2024 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524949;
	bh=39oRWrJ6tH5uFM0B512mIFUHDm4aZpg6Aw1BkANjRFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p083xwMcsHvLOs1APEhBff7/XtssZGR+OVkKZnge104TTspWNeJR9M5yOIrcN7AfN
	 vHVufB0i7v3ufcS317/PADTNlLsQN05P0t6agaOpl3FLFoR4fgsWIke2FYcO2dK/ay
	 DiPw2+WeAXjAR5IMxubc6C8kI/3P2JGPblrsqdOiFr6B+ssaNAfOCvQUCsVY/4jFpj
	 0Bjf7uBVl61HE5r3tqoU1NSu/CdrYcqVWqBp8gTZL5OCEwU/jRIegSs3DjEoRpOaLh
	 Nz7eOj7mNfH7qG2Bj0XlfJwwZj72tMPTCIiURMbOiwXTYKxmQqUe8kbw8XbwgdbOVS
	 okBEDCzJi9Y8Q==
Date: Thu, 1 Aug 2024 17:09:01 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 01/25] rust: alloc: add `Allocator` trait
Message-ID: <ZqulDQx8Rid0F6fu@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-2-dakr@kernel.org>
 <CAH5fLgj5xf4QdDU7yWrqUjcmJw4Rqe0-UzesHLhfQRvPqAv8eA@mail.gmail.com>
 <Zqt_BuyoUk12m61Q@pollux>
 <CAH5fLgiSjwZetUm5WW9cjM8gTsCXPMB3byzKgvMRt-o_n24YKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiSjwZetUm5WW9cjM8gTsCXPMB3byzKgvMRt-o_n24YKg@mail.gmail.com>

On Thu, Aug 01, 2024 at 04:25:25PM +0200, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 2:27 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Thu, Aug 01, 2024 at 10:19:41AM +0200, Alice Ryhl wrote:
> > > On Thu, Aug 1, 2024 at 2:07 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > +    /// Free an existing memory allocation.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
> > > > +    /// instance.
> > > > +    unsafe fn free(ptr: NonNull<u8>) {
> > > > +        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
> > > > +        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
> > > > +        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
> > > > +    }
> > >
> > > At the very least, the provided implementation of `free` changes the
> > > alignment when it calls `realloc`.
> >
> > Yes, I think that's fine though. Hopefully no one attempts to use the memory
> > anymore once `free` is being called.
> 
> Sure, but if you require the alignment to remain constant throughout
> calls to realloc, then you have to word it in a way that allows a
> different alignment when the new size is zero.

Agreed, this case should be covered once I documented that the new alignment
must be equal to or smaller than the old alignment.

> 
> Alice
> 

