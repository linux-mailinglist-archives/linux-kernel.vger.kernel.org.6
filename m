Return-Path: <linux-kernel+bounces-323170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A049738E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0140B1C25034
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E882B192B96;
	Tue, 10 Sep 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNfNon9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340614F12C;
	Tue, 10 Sep 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975744; cv=none; b=Ij4bZKvbJGEro5Iwnk7ajb6nFxHR0Z9DdQrO1AL+DhH/hQzxhYiGiShVhlb9ye+FofeNPCqldtIe/qXfXfwT9qVtxL5dKA1es27Oht+HlLg+brzWD8hx+9K/XzsdvOgXwpfNS8HoEkMhcbmRxgi0qOCDCVJETVzd4YXTzcLh3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975744; c=relaxed/simple;
	bh=KK93TPLgHWuCzd2HybK4gg/j5sV+HKCgA/rwL5omCo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzcxEGAhwuCFibZ05sJA0K7FFag8SsCYJKGpE+j5tNFyZY2hLbWYaznx/uMmQGM3dA3+WCTUhcuJXr1Byb10qUbfOlt9DD17v+zyebJx5C4tecEhVG92LhAMH5y7c/Lwrrtoccgk5eUcaGkZmPWYtOE+865IFqM0hEnj61CQl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNfNon9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118C9C4CEC3;
	Tue, 10 Sep 2024 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725975743;
	bh=KK93TPLgHWuCzd2HybK4gg/j5sV+HKCgA/rwL5omCo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNfNon9vS9QvMtQaNOFsKFidBq1QWJ7FKlVyc3qU5fWYa9GPylD3YPshV1Xlb/8pQ
	 WV2nboQtLn83Osw7lvLitBZ8iiwADVbExdmBuU5tlFxPqs4K7u/VMG+jTBc75hONXU
	 THZnzImA2c/152ywbXsxQrZLZLHKG80EJrWyptW+4oQin7w4++hAxjvdaBpKH0vvuJ
	 dTXFE0Ml81YQ/deEAzs7/vew/v4usat2pNYR8PuEHGb+luex/7fmBuoplxsWejwpfI
	 9a9wsO7uv3wVEdGgSNDiDX95QKmKsqhiU2ElCuvF8ocstF/3fR1fqQ/euRw5eg0HM8
	 SCQAmpBjQSQNA==
Date: Tue, 10 Sep 2024 15:42:16 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 26/26] MAINTAINERS: add entry for the Rust `alloc`
 module
Message-ID: <ZuBMuHk-_DmGRQad@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-27-dakr@kernel.org>
 <20240831135712.0d7366b6.gary@garyguo.net>
 <Ztb6_XW3ccnHQDmw@pollux>
 <CAH5fLgjbnGstjzsudjavzt5+UwK_r8n8X3LPdw29QSkBzaygxQ@mail.gmail.com>
 <f99d8d3a-5b56-4555-a1fc-bd7685dcea40@proton.me>
 <CANiq72=MD8jmWb9EGA8yW6eMT6Prj8fYEiJM81-HTq3p4dKmGg@mail.gmail.com>
 <05abcf53-4997-4bdc-953b-30bbb5118639@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05abcf53-4997-4bdc-953b-30bbb5118639@proton.me>

On Tue, Sep 10, 2024 at 01:26:34PM +0000, Benno Lossin wrote:
> On 04.09.24 14:57, Miguel Ojeda wrote:
> > On Wed, Sep 4, 2024 at 2:51 PM Benno Lossin <benno.lossin@proton.me> wrote:
> >>
> >> I forgot the reason for not using it, does anyone remember?
> > 
> > One of the reasons argued was that `mod.rs` is the same name
> > everywhere, and thus it is hard to notice the difference in some
> > editors and may be harder to "jump into" in history/tabs/etc.
> 
> I don't usually open more than 2-4 files anyways, so it's not an issue
> for me. But of course people's workflow is different, does anyone have a
> problem with switching to `mod.rs`?

I'm also not against it. I'd appreciate if a potential change doesn't interfere
with this series too much though. :-)

> 
> I have another reason that it might be nicer, when I want to edit eg
> `init.rs` and I decide to directly open it with the editor from my
> shell, not using my fuzzy finder, then I need to press tab to select
> between `rust/kernel/init` and `rust/kernel/init.rs`.
> 
> ---
> Cheers,
> Benno
> 

