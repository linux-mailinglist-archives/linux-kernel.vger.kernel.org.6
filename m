Return-Path: <linux-kernel+bounces-537191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76179A48908
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409261886C66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846DF234979;
	Thu, 27 Feb 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L5thVhER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A28BEC;
	Thu, 27 Feb 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684686; cv=none; b=HJEmBBYnATW0tbQmG2lZhcasLo2XrZi4oo4+qwDpcu96eLPmXXrBUuRqSIqgRNkUoDX1OyxFqEIKDDxnBIjnSIrPnbQCTEPSrOFCu70WHU5dKzWdjyeGdfOC+Fn4PHGC+gw4QrepVk/TKfokQ9YwSfxGR8NCZyQb5iUeiyXtmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684686; c=relaxed/simple;
	bh=4Fn5UhIhPYcL8P4sGtgmJOrflXe17/WSXKxIYHr+8XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKcVaoMxy55Hqh1xycEC8qotCUkd/Esk7X3OTq3zDgor/osohzt712fU1v8HKn49VNTzbaNIDTseAluZ6YT6nw9MHcLlVWQ1vwZ33yfKqnRQzhDkapdD60CMcSaDolFP6IW8go8k5E+9tBBcQjN3+zFBeLkz/W8CIjU4NwUG+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L5thVhER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28182C4CEDD;
	Thu, 27 Feb 2025 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740684686;
	bh=4Fn5UhIhPYcL8P4sGtgmJOrflXe17/WSXKxIYHr+8XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5thVhERB/7q2c3oBZZNuKv5cDoig05UugrwbeJRHuJZ2qLOvD42EEd9SZvIao0pu
	 trIAAm5aJDvF1DyZ+SIOJNlp/sHWBW7HR4c0hiG170s5VvUNpJ+FD+G8Krwy3DODU2
	 RvV9WJi7c0zqouAA/9LsM+s1RPheRzbJPOE3C7Ec=
Date: Thu, 27 Feb 2025 11:30:16 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] Check Rust signatures at compile time
Message-ID: <2025022714-specked-refocus-b701@gregkh>
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-export-macro-v1-0-948775fc37aa@google.com>

On Thu, Feb 27, 2025 at 05:01:58PM +0000, Alice Ryhl wrote:
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

It's a bit odd to sign off on a 0/X email with no patch or description
:)

Seriously, nice work!  This resolves the issues I had, and it looks like
you found a needed fix already where things were not quite defined
properly.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

