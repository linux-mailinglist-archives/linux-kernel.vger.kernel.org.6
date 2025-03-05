Return-Path: <linux-kernel+bounces-547981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAC9A53E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582653AB91B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0979207673;
	Wed,  5 Mar 2025 23:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZE6dXrw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1F206F16;
	Wed,  5 Mar 2025 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217238; cv=none; b=iJKc7OpS9UduzXr2IohR5ZCSR89lLQl0R3Q9XEcvKdtWBlZsvPIcyspvbZTOC/QzDf0mFtW4shaBwVHCNiIbqGPhSBF6M6pm4qEp1P9jAEpEarARPXr4E+ehUHjJvEk+va9OPJ+FL48+ZHWQ9bQfZEZWX+9SqdqYs55KZVqTJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217238; c=relaxed/simple;
	bh=4fh6Y0LoqV2EukUiCVG7hWelHTK03gMvl8F2X28vwI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5A6CS6hrmmYakHcSc7SadCafyjsAK6jYfgf02ql2C6SS7zte0bUyilABLCzSBij2LArBR/UfMR7NRO1XKZOOwu86tcFmsR0Uqj69NAEfGj362JILXQeOTQVRx43GYccR+pKL1yOxbkciq2ry6c8JXY5UeSUuf9vQiS65CPzsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZE6dXrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D172EC4CEE7;
	Wed,  5 Mar 2025 23:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741217235;
	bh=4fh6Y0LoqV2EukUiCVG7hWelHTK03gMvl8F2X28vwI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZE6dXrwe10pt4rZ14rgh49zXXInCwjXV0e8Ct77UHguHJF31XXuPjDLkMLQJ+Xzw
	 4xehMU9SmUNLkM9hkGCKxaGzocL/CcRQyu55aWjy2rEbCAVhW8RV3KC6DEb69PFaIO
	 54Nq5LE4gGBRzlU7f0FHbnmAECHtzp6fZYS87MMqeQ6NW/HOPAM8bkHGh0Mu2EhbeW
	 1zLzft747iBe/SNvEBy1BlqblZN8f97rrAVUiXGfhO07Sq6fSfWng0C0B8kSPKLVTs
	 qBOT2pHthRv8TOM4+FmAbokSW1K5G/7mNnw9eg34TKHeeVn6P4v6GxBbWAzeV9IdX4
	 CqF+s+AZiXPbA==
Date: Wed, 5 Mar 2025 15:27:13 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
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
Message-ID: <Z8jd0evXjJtz1CRB@bombadil.infradead.org>
References: <20250304173555.2496-1-dakr@kernel.org>
 <Z8isev0gwQJPs7S9@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8isev0gwQJPs7S9@cassiopeiae>

On Wed, Mar 05, 2025 at 08:56:42PM +0100, Danilo Krummrich wrote:
> On Tue, Mar 04, 2025 at 06:34:47PM +0100, Danilo Krummrich wrote:
> > Danilo Krummrich (5):
> >   rust: module: add type `LocalModule`
> >   rust: firmware: introduce `firmware::ModInfoBuilder`
> >   rust: firmware: add `module_firmware!` macro
> 
> Greg, Luis, Russ, any objections on me taking the two firmware patches through
> the nova tree?

I don't speak Rust so I'd my recommendation would be to add the rust
firmware file under the firmware loader entry for maintainers provided
we get a volunteer from the rust community do help maintain *both* C and
the Rust version of the firmware loader.

  Luis

