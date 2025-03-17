Return-Path: <linux-kernel+bounces-563498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77EDA642ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515733A8A21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F021CC45;
	Mon, 17 Mar 2025 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kcumnzqJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4521CA03;
	Mon, 17 Mar 2025 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195225; cv=none; b=k+zEZkWtkoSGluDtjkZw5Ua46+mY/0e6elXujicQwi6aRZr8C+EZvRxjReGh2RNEXzuWR5fxf+8whv4LXjFCMmmzOKf2Ge4qB5jvPuNVZZ+hp6CkvXcZVzWApThHRM5PwEB/3ohE8xlDp9WAM5BTWY75zkiFWMHPDaF+jSfX3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195225; c=relaxed/simple;
	bh=qoEnaflf/R7m/dgmJFLBk7l9XFM0gYN2ZXjOHTW/VfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzeo+q7tAM5CKaaxSCW16zcNfaie244kF6+IaokZgovZ8GV8/Epvzl65heuSNFfOqYUCeBK87+JqaPq+BEdn9BzcGLfdUu3mHnmqLI92GftaDtV0CAJqzyJ+Hy0w5INi+iRVuF4cJMUvQJPOVGN9OLX4WlenCf3OyB5y9Ren79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kcumnzqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B360FC4CEE3;
	Mon, 17 Mar 2025 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742195225;
	bh=qoEnaflf/R7m/dgmJFLBk7l9XFM0gYN2ZXjOHTW/VfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcumnzqJxzdr8SeI2hcN0/c/nTFmRx6MUQPToPXqGhiB/4wwkr70uqKBEJ1Jl/byS
	 DaPgrNRkqk/yaQcHe6Jol5K+Ux4/JD0Oa/WXsxj4vFYSRUlohCjc4PEHLD+WfERwX2
	 rZtjPT5Ht6FPdNNOX/YyLFOS9ZcfXFiBbNA231aM=
Date: Mon, 17 Mar 2025 08:05:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, airlied@gmail.com, acourbot@nvidia.com,
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Auxiliary bus Rust abstractions
Message-ID: <2025031754-attribute-aching-7203@gregkh>
References: <20250313022454.147118-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313022454.147118-1-dakr@kernel.org>

On Thu, Mar 13, 2025 at 03:23:49AM +0100, Danilo Krummrich wrote:
> This series adds Rust abstractions for the auxiliary bus.
> 
> It implements the required abstractions to write auxiliary drivers and create
> auxiliary device registrations. A driver sample illustrates how the
> corresponding abstractions work.
> 
> The auxiliary abstractions are required for the Nova driver project, in order to
> connect nova-core with the nova-drm driver.
> 
> This patch series depends on [1] (taken through the nova tree for v6.15) and
> [2]; a branch containing the patches, including the dependency can be found in
> [3].
> 
> [1] https://lore.kernel.org/rust-for-linux/20250306222336.23482-2-dakr@kernel.org/
> [2] https://lore.kernel.org/lkml/20250313021550.133041-1-dakr@kernel.org/
> [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/auxiliary

As this seems to depend on different branches in different trees, I'll
hold off on applying these to my tree now.  But if you want to take
them sooner (i.e. before 6.15-rc1), that's fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

