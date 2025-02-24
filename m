Return-Path: <linux-kernel+bounces-529790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1188CA42AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6091689DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995592673A3;
	Mon, 24 Feb 2025 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHjmj3oG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76526738C;
	Mon, 24 Feb 2025 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420868; cv=none; b=ZmhpL+8V1O0aDDS1bo/qf7S6pfADylxpgFbtnGAQXeJlUc4tmsWr1ltk4CbWVldVuznhTBvKQt87KPL/cPIhUVLGBNkbipGh1K/bEcJQL5j2fcBrfjlmjgghc1E4CIAm8s+bILEhtDjz9jAwIlKBe802WUIBEQ49Y95mBUEStgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420868; c=relaxed/simple;
	bh=hFPRyUJbs65KNbBZUSueh2s4dZ0XB5ZCJFjGcueXZw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTwtX3EVm0QLjJ6k8Ff9UdoB5cxAWyLXValoFJe8olB2VZRjq8ZgGNivw5QzmkFYomqAonZXrl0finJZ5gX2aLmY+hBbGGkFz0EmKM3zrKsmjMhNboeN8tmGNPC7WtcLQG14NvBwVyvrEYN8Gcx4/0RMK6wWYHNfmQLgEytbzh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHjmj3oG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F0DC4CEDD;
	Mon, 24 Feb 2025 18:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740420867;
	bh=hFPRyUJbs65KNbBZUSueh2s4dZ0XB5ZCJFjGcueXZw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHjmj3oGX3kwfes8q67wonM+ZPOrPKjM55jBh1ORPoo6+vz/SaGq1w046M0hvmcyI
	 ivFBmHRKfF8iaaLYs+BscTapKGyB97y9OPune5jtFccpM/yODqUocbIu4AP390dlXa
	 7hewkkpkj/DAGIc2LBmxfqief0Uf0QLOq+x3o55+FKFxGm7mYB1YcAsKkeXkz42Bz9
	 2EM7DbTl2Ge4OPoO6OK6m7/rDEBDa83COS4Dxk59o8BvDQ8Sj6nHb/t2/f9Prle2e7
	 PE7RAso/xAU5IExPkITfieiweubB1wIam5K7oDIkdV1r2cd9Hipx4feh7w65Lk9Q1c
	 ZD2lKFlG5XLrw==
Date: Mon, 24 Feb 2025 08:14:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: rust-for-linux@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: workqueue: define built-in bh queues
Message-ID: <Z7y3AknAD8aWjHWz@slm.duckdns.org>
References: <20250224142326.38396-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224142326.38396-1-hamzamahfooz@linux.microsoft.com>

On Mon, Feb 24, 2025 at 09:23:23AM -0500, Hamza Mahfooz wrote:
> Provide safe getters to the system bh work queues. They will be used
> to reimplement the Hyper-V VMBus in rust.
> 
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Applied to wq/for-6.15.

Thanks.

-- 
tejun

