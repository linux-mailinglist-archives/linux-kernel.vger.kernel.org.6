Return-Path: <linux-kernel+bounces-212034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E9905A47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F95B257A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B71822DB;
	Wed, 12 Jun 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVz/WX+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C98180A93
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214965; cv=none; b=kvcSZcRTfBcVJJyocoWt40xigAZ2BL1e9M9LSRyhzElFUJVxD9/IpgqGMy4Ktp89dKhGVtya3MeaOsoTUYlJeZ7RMRPB1q2yBErFfZgQWHFaJe0UZqtzUCaEd/AnW4Ht1bxpC4Fhpoif/q8wvNb2VNvuFjfGdmgNjIaTxkvfJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214965; c=relaxed/simple;
	bh=0d3+8+g7aWZezvgdfFmThFuo2jtRpJQdl8ZLC5g3Y7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PY0icXMKkvZr2vqUbF4QHqjek7MEaqlLmPUNlb9CzyeuWYOZZSeqeuWLbtdEDf5NO69AZDs2W6ztnOYNaG87wuqlEQwX76BudnQP/3np315JmOR8jyfEmlKL3kBUATd2nR84DMkRNjJPtf125+2Niw+/5Zsj3M1qJvubWVp6IXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVz/WX+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC1DC116B1;
	Wed, 12 Jun 2024 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718214965;
	bh=0d3+8+g7aWZezvgdfFmThFuo2jtRpJQdl8ZLC5g3Y7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVz/WX+KRiZiPVK3fU9zJaZupB95U7vjI6X8lE5M6glMUw4C9NOgQVuBAAc+8X+eJ
	 7Fnc6ixmEcwJXeV2tLGSd+Fuf1qKaLgMBHW4tuVqyqz7yk2jRvtwEoqmZV8mNOmN83
	 XbsytBvSQ/wFpNVrUPo7mRCNQvleGb5/Dzw1sFbWzWHZgegln9gqFWB8zTYSr2Ybmh
	 7r8XHXIZbvbXfI6yacWM4O6P57dHRnrWzEEMHf1kiW3uLTqd0tBcr8hGfBQp7Tr4OA
	 g1FvX1jVjzmB1fjumPgmEkAEmAxpq4OXKZjAt1YN81tLkGHEi/D9UQNdzmox8Lg/Mq
	 +AXpo37/J2COQ==
Date: Wed, 12 Jun 2024 11:56:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: always initialize cqe.result
Message-ID: <ZmnhMkqt7xch_4e-@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612-nvmet-always-init-v1-1-0c0fd94461f0@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-nvmet-always-init-v1-1-0c0fd94461f0@suse.de>

On Wed, Jun 12, 2024 at 04:11:59PM +0200, Daniel Wagner wrote:
> The spec doesn't mandate that the first two double words (aka results)
> for the command queue entry need to be set to 0 when they are not
> used (not specified). Though, the target implemention returns 0 for TCP
> and FC but not for RDMA.
> 
> Let's make RDMA behave the same and thus explicitly initializing the
> result field. This prevents leaking any data from the stack.

Thanks, applied to nvme-6.10.

