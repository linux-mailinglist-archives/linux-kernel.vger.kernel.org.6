Return-Path: <linux-kernel+bounces-529686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA0A429EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369243A7682
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA5F264A71;
	Mon, 24 Feb 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaRSPMYz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3F25B699;
	Mon, 24 Feb 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418311; cv=none; b=NYlKRX+PlpEznvp7epApFMIL7opDdjsenmh5uQNQUp6Yw5rhvqxeeXRGq/yhKr5nSxNUdDQ8WcU8i3hAOfRWTwxwL7PSfntHlTSoiJNurNgYvFapFSsZe7H96KSTyFyemsLBg5PAwFZ1FGtaLihyzRuYgb/qKRawIBE6vkXVHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418311; c=relaxed/simple;
	bh=HpZaOXLO3Z1G7wqrD9cPqVgbJ/VRy8RAVL3gxBCibuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcacQaiVH/XcFHHixuAJYVan+mxPWwk61F7o2ReY0SyeY0yeda9QyobUBhINf0J8Dca1yjrXH0y5dyEbmBaNvijs5xTu6UB5H4lxNmFSqFPOm22UWokFlpq5wJn9S0WuSyTNB8/hwuHJY9XQjlhYQdcUXeyuHnFB+N4Bv4euIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaRSPMYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2812C4CED6;
	Mon, 24 Feb 2025 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740418310;
	bh=HpZaOXLO3Z1G7wqrD9cPqVgbJ/VRy8RAVL3gxBCibuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oaRSPMYzGbq5Juqoadk/HwTdWlvLalUon0UeIcI0+C7wnoducvGg5zrN7FobbDVyW
	 c8Mg5TUEZj2lBxg+KJqdy1C0CwQff38pfmNTN/9QbCUTGtQjM8Kubpob1GObB1EvA+
	 4HXoVj/i9p5squ5JDXlbbquPR0rN6GkxPiwExW985Sw1w7YvmvW7GgMNC68Ff3cNdt
	 dv3n6hi2FEbegCFcwUwYoodZX6daaBYEl3seUTHBafIYjwzNrr4F8nAwsQGUHoBhQf
	 w+wFoVyXWT+wtd+AmgBbbx861kocawPVTYBbAmr+2pIalJ3wIRgtbDmMHMFALbLoR1
	 TfHHfu9uPHgJA==
Date: Mon, 24 Feb 2025 07:31:49 -1000
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
Message-ID: <Z7ytBYLKNabbm1m4@slm.duckdns.org>
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

Ah, you already sent v2.

  Acked-by: Tejun Heo <tj@kernel.org>

Again, let me know how you want route it.

Thanks.

-- 
tejun

