Return-Path: <linux-kernel+bounces-523358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CE8A3D582
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067087A5943
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FE1F03D4;
	Thu, 20 Feb 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQijEXKe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6A101DE;
	Thu, 20 Feb 2025 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045326; cv=none; b=lIPwk/EjeNSWfa/EgR6bL1BHcI4DPbd++RFamg20VwoDx+ql1Wd50B+YXSByqOWQdFjumiKQ3ywdvb8IjYuXVJ6pir6BJjQCOcFoBqit0NxbK5X+So7Q57/jryHFDk/6jywdsJ2vis8UPOyRa6hXwPk3WA8FLUammKDNStzYZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045326; c=relaxed/simple;
	bh=xzS6h5KnBHNIoiPvclSQAAioVfZWDom2cKt1SBCr86w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JROAdKQB0WVRzoIqc5GsdByD/+p75oZCH/ffUPQDZI1a1EQBNULTe2Br4cDH2I1XlejiBd3UWmBZLZmfPD9MGfkyPqAbu+fGGKnFDhCRoaqlvRwUKV3MWVKrQwcPk0cGwq8QMRlC+1PePSr+SpNeNKYxPdk5tL2HnypsIxwJR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQijEXKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66189C4CED1;
	Thu, 20 Feb 2025 09:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740045325;
	bh=xzS6h5KnBHNIoiPvclSQAAioVfZWDom2cKt1SBCr86w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQijEXKeznE+q3VYmV/ySgRAcUNRB/51FmRor5HU8HyTJ3he5KdezGi+spOmHeliF
	 5WJztNXBI3+pRk/+clHPp1xkjFbR7mWFJTAaThQiRxU+Zokb/f9l6py4MrygtBJOIA
	 xY+LVJWNm3+LWMTNnzUZO4s9juml8nZRkdy+hYlrclOHP/TTI9LyaKcSDxl+Ex3k4k
	 b7kBy2G3zpcNHuQJQsWqLcuAZA0L3sqhqJLH0d/tsuqNCJTH6nm9a1mRNZ6eYPtEOz
	 hAWsjq8i2wLqcTjPxUmeZGMxdIHWnOiThX6P8ipeM5NHdIffN8pXboohgClckt0Y79
	 fzOmjWhuP9F/A==
Date: Thu, 20 Feb 2025 11:55:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250220095521.GP53094@unreal>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <20250219140821.27fa1e8a@gandalf.local.home>
 <202502191117.8E1BCD4615@keescook>
 <20250219202751.GA42073@nvidia.com>
 <20250219154610.30dc6223@gandalf.local.home>
 <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>

On Wed, Feb 19, 2025 at 12:52:14PM -0800, Bart Van Assche wrote:
> On 2/19/25 12:46 PM, Steven Rostedt wrote:
> > I do feel that new drivers written in Rust would help with the
> > vulnerabilities that new drivers usually add to the kernel.
> 
> For driver developers it is easier to learn C than to learn Rust. I'm
> not sure that all driver developers, especially the "drive by"
> developers, have the skills to learn Rust.

From what I saw, copy-paste is a classical development model for new
drivers. Copy-paste from C drivers is much more easy than from Rust
ones, simply because there are much more C drivers.

Thanks

> 
> Bart.
> 

