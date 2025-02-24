Return-Path: <linux-kernel+bounces-529671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AEAA429B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D0D17AA59
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CD2264FBE;
	Mon, 24 Feb 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbOX/TPF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEF7263F5F;
	Mon, 24 Feb 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417988; cv=none; b=j7+38S2MYe1s4IifTezueCS3NGBFh3OF2YbeZ3rXV+fCcUjlXKgUBqYe8+yGE7dwwY+2nEVRgi8ziIN8atoDFtErH0s2OiNYTSl2I90Wq0v4UCh6I8mWKvPeg3Z5AD7aLARNw1hFHAtNdi13fE9juVC17HJhyR3JVPL4obdxK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417988; c=relaxed/simple;
	bh=tZ+lB45WUACqJMBa1PQ9dGIjsqcHvzTG2FfmVJNzSp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXXHCIGwXzYWZ9SuL2Jbuc8N5C2wuMFeGStoYRiBxLNmw/cIwLGHaWPRJ2XtksRVyXFvxTq680zWEU0cv0ERpyVOPy8sNFBzdOviqHarwtiwzUj+9QmpzutuLdXnf70MbfP/c4ESe9lNqHLfZcHLMgHp9nfPzqGdRydZyYhay0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbOX/TPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5266AC4CEDD;
	Mon, 24 Feb 2025 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740417987;
	bh=tZ+lB45WUACqJMBa1PQ9dGIjsqcHvzTG2FfmVJNzSp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MbOX/TPF93uC83/U6DTN+NYOh5nm0n7qRe9uT5KOxKC06Lb6FI6fDwCY4Iiyxg5Gm
	 p6BmGfK3UzkigK8YC3+UdgErqqvilP8zS2CWcwTGwnoP42P8dkU4+YMdxjyXnx19+r
	 mTSEKryiACmQW2N6VIMJ5eZSkWu4wd2lYnnwvAXBmXfJLj3x3m6KDZzxL7MWufZqYd
	 ToF2mTibkMKlXhEqnrEXwy2igFgGRWY2ugReju56GxTOHG2opN4x1kg5v2d/alZ+ZK
	 URQXnoyD6iKTeevD9IKGtTVkf4p3pzUzNhgoF2FoRPUNdSifVn+JWWZYXyl6o4acRa
	 fGDs/oup4BN3g==
Date: Mon, 24 Feb 2025 07:26:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
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
Message-ID: <Z7yrwkGlJZPC99uL@slm.duckdns.org>
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
 <CANiq72nsDgRJeKk=B7C9Zo7HL12az+ZLR27qxckqi5H=cmuV5w@mail.gmail.com>
 <Z7lP5VA374-TuNZz@kernel.org>
 <Z7lUcq3PycSSHiXx@kernel.org>
 <Z7lVeWFX-8uQJaJC@Mac.home>
 <f9b783dff11a923b53cb654a843af7ae33478f30.camel@kernel.org>
 <CANiq72=c9EZOuwjBz7FjvAe0Hw4Wbyg0w6Za8rZV1kf3uWCtNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=c9EZOuwjBz7FjvAe0Hw4Wbyg0w6Za8rZV1kf3uWCtNQ@mail.gmail.com>

On Sat, Feb 22, 2025 at 12:57:03PM +0100, Miguel Ojeda wrote:
...
> Moreover, I do take issue with your social media post. You claim:
> 
>     "Rust kernel patches should really level up on commit messages and
> not merging random code with zero callers."
> 
> We do _not_ merge random code. In fact, my message above was Cc'ing
> workqueue precisely because we do not just randomly merge code.
> 
> Not just that -- if you had actually checked the Git log, you would
> have seen that Tejun himself merged the bulk of the content in that
> file. So it seems now you have just blamed two different subsystems
> entirely.
> 
> Regarding "zero callers": that is the usual rule, yes, but it can
> happen when there are expected users in the future, and in the end it
> is up to the judgement of the maintainers. For instance, in this file,
> there are other queues that do not have users yet.

FWIW, the commit message could be better but at the same time I'm not sure
commit message bar is any higher for C patches for something this trivial.
As for no-immediate-user policy, yes, generally true but again it's sometims
a necessity or just more convenient to merge these API patches separately -
e.g. features straddling across subsystems, straightforward prep patches and
so on. So, that's the *general* rule but rules without flexibility are often
silly things and it's not like culling these trivial wrappers afterwards is
difficult.

Thanks.

-- 
tejun

