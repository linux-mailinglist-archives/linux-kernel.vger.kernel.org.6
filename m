Return-Path: <linux-kernel+bounces-529660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDAEA42980
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DA43A801D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137DA264A74;
	Mon, 24 Feb 2025 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOJUVlp3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA20263F41;
	Mon, 24 Feb 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417587; cv=none; b=Pte2mj/VoMc2dcvIJLeKTcEqLOMSJuc5L57kKAqbO7ucT02QxMuUsioBnt2EYNQHIut+tDYr2sWHJw+rO/3WNT0uTJW7tuR1B/JVtvkIlfWiclYcLEfGyuXtIm6dxM1BMQ5Exj7/uKAWljpDLK5fM3911rVcPzkSiQ+gova0nJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417587; c=relaxed/simple;
	bh=2JkK49D5kslLlDTcfz9RF/ZSparlD8LgrmourQdVShA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX5TxT1YL3vzC+DLWzvhzt/f6QU0Y+aBwqzcTLHg4Snb16tEOW4s52NmIDsjb+O7yfD7kfm6FT2iCB+u15AxAT66aaTLwSCGoCrUf/NmZRYMfRfdoTNnU+6aZxYoa/2mqbQkUJl/l1utybyeWzhtrpx5boTapHK6C7YUa2HcTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOJUVlp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC333C4CEDD;
	Mon, 24 Feb 2025 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740417586;
	bh=2JkK49D5kslLlDTcfz9RF/ZSparlD8LgrmourQdVShA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOJUVlp3PCeLeXKfAgaxYqH3gEnUCpfY404RUTwpVGha2NTheRr9Ag3dIDNx2Mr7r
	 6qY91wkz0nPwviqnND1BrIGwiU9/8vvr2OAofkAxq5XNuRg8pG/vQyncjJuSF5P+jW
	 L8gyhnZQ7grIVEv1g3QYlIeZp3C48DLb78pI5H7KjJCf6Pb/eu5xo6U1nMLatQiMlQ
	 C4+L4DqHsCwIjKC4Z2gGDoZXhcSPhGV3Y70W7sCS1rzoDYxSEg3w2B0b1kTr9CCL9y
	 7u8Amqd/ZxwzNX+N3OrjNtbmha9qBNLe0VltK4pJXXXJOCS92CJtAJrIXa/xBdVvFI
	 hhWXopQfJJDlw==
Date: Mon, 24 Feb 2025 07:19:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Nell Shamrell-Harrington <nells@linux.microsoft.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: workqueue: define built-in bh queues
Message-ID: <Z7yqMdOGeOUzZ7um@slm.duckdns.org>
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>

On Fri, Feb 21, 2025 at 05:35:31PM -0500, Hamza Mahfooz wrote:
> We provide these methods because it lets us access these queues from
> Rust without using unsafe code.
> 
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route it through rust tree. If you'd prefer it to be
routed to workqueue tree, please let me know.

Thanks.

-- 
tejun

