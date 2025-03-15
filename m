Return-Path: <linux-kernel+bounces-562614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD79A62E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98853BB337
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0F1FFC4B;
	Sat, 15 Mar 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTm43f3T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D1208D0;
	Sat, 15 Mar 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050223; cv=none; b=NVJr1Mkdbxbhb2fhmD+XKjhrZazM5HsLAOVSivy4/Y3rmYMkH3BuJshqOw5uRJDxLwR1xuEjrzwX3ra1OvIgmJWykzS+Gf5pwxS7rm4xknJ2v/WyCdJCZ3Yu/Q+BAO33f7RlW51Wz0DEP4fqc3tDpwblO/mPbsLveYLkKq2PykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050223; c=relaxed/simple;
	bh=FQUYiextVDgUYWXuF/yOc1G6zOZN1i3xz/ylkwvnuaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1GrzqvLTK0tByWcVYWz8Mu6kYo+rE0XmRCVyBpq1E/CGSj+uNgLtJwFMWcT9o0q1m0K3zATySIv7WsKakyp9Wg0Jad6Ulkl50OyInKO9+gCOOuCL16Pq8/y1+i38o56R2h5swQGbt6v1dzDw/hdOg+FhzL5CKTO7y3Nf2UvKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTm43f3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08541C4CEE5;
	Sat, 15 Mar 2025 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742050223;
	bh=FQUYiextVDgUYWXuF/yOc1G6zOZN1i3xz/ylkwvnuaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTm43f3TprM/O1OebuMSkny0gUTnQYZ7VIiozKjrXmmjsjSFki338r0rWavmIMw2j
	 oz6QJiJks32TavMMIiqUKhUrhbWe2mfnAjKzFZN0OCkipUL8KzA5syo+mVdQJFsY3O
	 bD7VB452AtKBkDf1JXl19T+iONzguOlsaxKB6aqB6k5ZsqddPT03JCaNcRGYPSxCUc
	 09fn56/0FXp4uzAMyO901WQjhPgtyOH2St60EyQRam3skiG7uvSD7WpJbREltoTHyL
	 KYeL2b5Jgy2fJvAQZh+xdO5ivVuEsRnSR1p01wbCo7yDec/82/IaKCKXAzWgzMibVw
	 yvnVLF16OIDcw==
Date: Sat, 15 Mar 2025 15:50:16 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	acourbot@nvidia.com, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] rust: alloc: add Vec::resize and Vec::truncate
Message-ID: <Z9WTqChNDG8GnXY0@cassiopeiae>
References: <20250315024235.5282-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315024235.5282-1-andrewjballance@gmail.com>

Hi Andrew,

On Fri, Mar 14, 2025 at 09:42:32PM -0500, Andrew Ballance wrote:
> This patch series implements the Vec::truncate and Vec::resize methods
> that were needed by the nova driver and removes the corresponding item
> from their task list
> 
> Andrew Ballance (3):
>   rust: alloc: add Vec::truncate method
>   rust: alloc: add Vec::resize method
>   gpu: nova-core: remove completed Vec extentions from task list

Thanks for picking this up!

Once ready, I will pick up the first two patches for alloc-next and take the
third one through the nova tree.

But you can keep them in the same series for subsequent submissions.

- Danilo

