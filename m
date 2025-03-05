Return-Path: <linux-kernel+bounces-547991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66ADA53E94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5BC3A59AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7466207A14;
	Wed,  5 Mar 2025 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Voks/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2E2E3365;
	Wed,  5 Mar 2025 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218054; cv=none; b=dDHIfWi4CWTlDE4q768rw4Zo29CE2tCsZg1t2S8QKdmHPKcpOWIZl2XS+GmbZYlAc54OMMpiUnZTqU6OT0GXzQhEFIUbPR+DWn3ytiZLyfGXDIMioROXiJzZ60XJd1+C5Q37F7+J2R3lIC1uvCYfcegtrEBH0pk8okPxl7IWUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218054; c=relaxed/simple;
	bh=Jvgd6Vxhn2iQaQ4MOAQsSTwAjHHbOpXxX726+Hdaoy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/6Z2OD1tYrSgLD1U7Eay3wMQEWI2J1WDO3nFNDXiBsrXjw2dsgu5kAocQ+8K+O9hfpei+e7OSzacqrYuKhYoPolxCV5fphxXgmLsDHHEkKHQLIKdvl28pkbKEq9iYqQP/GQQoUVTKLCChxLi2bzTF/EoULhiLUkzkXvCzR6YSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Voks/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E023C4CED1;
	Wed,  5 Mar 2025 23:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741218053;
	bh=Jvgd6Vxhn2iQaQ4MOAQsSTwAjHHbOpXxX726+Hdaoy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7Voks/4JqAn565twhIKIPLuQwijN0099cEH4dkKyGkZveaDI6LoTQqSvC1IBtnXr
	 kol1I4cTzT/DKC7TeXlQASieui4zRsTh2ZtojG3xPH02AUhkBBRJc8x+skpXtNbtnO
	 vJIuAcSY8N3AgjjAPhSnP76TrBQ/8t4VSPkWfKH1ObbOfepdY8uLOAjD1bDAbEEuHC
	 8Z+R+II8Exn3abUo953QGJRSBkxar+6kNS6YszA9Z1CJY8WLVfayiFCI6vkqWnhwyK
	 f+AIorZyYx2bJl5spMzqiPGDhAvn0uvYNDc+4IdYodVN99XUgqC0mCcM3F3wwNqRJm
	 kfEKk+kpPu5Jg==
Date: Thu, 6 Mar 2025 00:40:44 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, russ.weight@linux.dev, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, airlied@gmail.com,
	simona@ffwll.ch, corbet@lwn.net, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, ajanulgu@redhat.com,
	lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com,
	acurrid@nvidia.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Initial Nova Core series
Message-ID: <Z8jg_OokbtQ_WDS8@pollux>
References: <20250304173555.2496-1-dakr@kernel.org>
 <Z8isev0gwQJPs7S9@cassiopeiae>
 <Z8jd0evXjJtz1CRB@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8jd0evXjJtz1CRB@bombadil.infradead.org>

On Wed, Mar 05, 2025 at 03:27:13PM -0800, Luis Chamberlain wrote:
> On Wed, Mar 05, 2025 at 08:56:42PM +0100, Danilo Krummrich wrote:
> > On Tue, Mar 04, 2025 at 06:34:47PM +0100, Danilo Krummrich wrote:
> > > Danilo Krummrich (5):
> > >   rust: module: add type `LocalModule`
> > >   rust: firmware: introduce `firmware::ModInfoBuilder`
> > >   rust: firmware: add `module_firmware!` macro
> > 
> > Greg, Luis, Russ, any objections on me taking the two firmware patches through
> > the nova tree?
> 
> I don't speak Rust so I'd my recommendation would be to add the rust
> firmware file under the firmware loader entry for maintainers provided
> we get a volunteer from the rust community do help maintain *both* C and
> the Rust version of the firmware loader.

Yeah, you suggested that when I sent the first firmware loader abstraction more
than half a year ago and since I'm doing exactly that. :-)

