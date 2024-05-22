Return-Path: <linux-kernel+bounces-186554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A3C8CC58D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D4D285538
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A521422B8;
	Wed, 22 May 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFGm248Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948E537E9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399126; cv=none; b=BhkTGDgJMuXi5e2Th4+uF9BHlKBjY4cgvmhcZDA80dwEx9GcWyTDeBgb5Kma9ijJzJXXdS9qIma3h2rr5afRrzZRO8hEgI9Yd2TEQ04cHxd3rEW6FWAzCyZCS9/LrTe/vRjtOXKnyJeZlIyWmt9I5LD8UHOt9gTojpEAQoFt530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399126; c=relaxed/simple;
	bh=I+AChwZfVTk45NPTsJRvNFZS+ouhd83TRXjEA8ib4gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtvtik6i7oe19LQ9jf5b3q6nSyO0dtEUkvuDPN0xhY+vp6iSOkkZFYmRpZHFTgKCQVHCU7ntYB3aqFDqGrkJSEOKrx4rbqWnxofNWDqpcpjHXDf4BvduEXMR6VWBZioPV5Ylf9jzRJmQyzn+fY/3KfYYZBDOPzHb3P06Qo2UEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFGm248Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8139DC2BBFC;
	Wed, 22 May 2024 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716399126;
	bh=I+AChwZfVTk45NPTsJRvNFZS+ouhd83TRXjEA8ib4gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFGm248Z9VYQr4F0y8aSFiKQ2z3YMHuCWAiL02RBAa5m58/t6fsXhu3J5zQ6NsEDF
	 R/FmZJznQf09LdE0vzQBO1VdvsRFuPIoQSse2Vq8wPBqc0D2r9ZvgzVkOg/nr4VDaf
	 GW+EMCZI4hiGXWO8ZQfxSu49IUBbvrANXIhrf14WROFY64oesTph1DrsCsEQ0s8TKf
	 h8W861CjY03eVLCpBcVnmU3v4VKdUiN53qKhQhodQKvAc6pq6Di//6o496WOnuJzGU
	 nsTTj+HaIm9GQnThV1nd/wVxsERACqj+gRsMIquh6fzZM7ZAO979Js42MBs91/8k5Y
	 pl+cnDmYHgXCQ==
Date: Wed, 22 May 2024 11:32:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522165406.702362-1-jmeneghi@redhat.com>

On Wed, May 22, 2024 at 12:54:06PM -0400, John Meneghini wrote:
> From: "Ewan D. Milne" <emilne@redhat.com>
> 
> The round-robin path selector is inefficient in cases where there is a
> difference in latency between paths.  In the presence of one or more
> high latency paths the round-robin selector continues to use the high
> latency path equally. This results in a bias towards the highest latency
> path and can cause a significant decrease in overall performance as IOs
> pile on the highest latency path. This problem is acute with NVMe-oF
> controllers.
> 
> The queue-depth policy instead sends I/O requests down the path with the
> least amount of requests in its request queue. Paths with lower latency
> will clear requests more quickly and have less requests in their queues
> compared to higher latency paths. The goal of this path selector is to
> make more use of lower latency paths which will bring down overall IO
> latency and increase throughput and performance.

I'm okay with this as-is, though I don't think you need either
atomic_set() calls.

Christoph, Sagi, 6.10 merge window is still open and this has been
iterating long before that. Any objection?

