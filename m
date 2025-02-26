Return-Path: <linux-kernel+bounces-534733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3770A46A89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1172016DC30
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E300237709;
	Wed, 26 Feb 2025 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1uQITdA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18AB236A62
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596484; cv=none; b=CzJvWMuqLqLSSFaAeSnNdrBtgxyTA2UfM4GHB+TkcHpWINut63HCk/AUs4ThZH2eJ4GHq4/1Y8WeoJdY0THyVWWiDz2FTiPVHjrtcxe5gHo5ikvRzxcAKytsGq/MPDc2s/2MjxUqvm0BNYjiho6SNAsL0CKwy9A+EV+ahCSxyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596484; c=relaxed/simple;
	bh=0kkdoALIuJtnRdD0VGeHoioZvW3xnSmuK14UCzdeujg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/fG+rTQkSJl/QqALH/F3sx4aoe2gGgvF3Hyx4sJA4gMlvnAfuXg2Vd+/My3JW+cb9Haq4kPe6Iqkg3WA5rA9lmz907oOtwwHp85A/EJYMwQsKJMbwyKin+M0j9xnrd3R3t5dW7GsmEOUBMXA9EoVjK8ikAZxOYN37l6Vkmz8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1uQITdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149CBC4CED6;
	Wed, 26 Feb 2025 19:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740596484;
	bh=0kkdoALIuJtnRdD0VGeHoioZvW3xnSmuK14UCzdeujg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1uQITdAC3+186R9zg4n44vlpe0ZX1mbUXmAmkF7gr5p27fYfea3OCEUGCUeUq+/O
	 KjHYPLCl3Cs6j/u7sH2EXOumRPnV66/AzHeFXPiAO3+5lyzYpffXO69DJDj74axP08
	 7DsgTK7qYwjuj7CWgE+a+A/nByfw6bsehANca4B/SYQKuhZy3srZCGc4BZIFCVtw2D
	 PR9UDYqBFhhlEXS/K6ugUtjmcjy3FymqkDmp1vDk2TlO6PHuO1gFHb3L/E+a3rxzhl
	 953nujLSrrCmgAKFK4r0u6yTJTj+S9hZZj812RsB4db8XpjNzJrDBqlgch5fuMhVmI
	 29xYZlixnVl+Q==
Date: Wed, 26 Feb 2025 19:01:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
Message-ID: <20250226190122.GA3949421@google.com>
References: <20250226062841.60688-1-ebiggers@kernel.org>
 <03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>

On Wed, Feb 26, 2025 at 10:37:55AM +0100, Hannes Reinecke wrote:
> ... and it also eliminates a sporadic crash which we've seen
> where 'snd_hash' wasn't initialized when sending PDUs.
> Thanks for doing this!

I'm not sure how that could have happened, since the ahash was allocated when
'if (queue->hdr_digest || queue->data_digest)' which seemed to match the
conditions for when it was used.  But yeah, it's certainly nice to not have the
pointless allocation to worry about.

> (Note to self: check the nvme-tls code for crc32c usage ...)

I have patches for nvme-tls almost ready too.  Just been taking my time since
I've been updating all other users of "crc32" and "crc32c" in the kernel too.
And I need to decide what to do about skb_copy_and_hash_datagram_iter().

- Eric

