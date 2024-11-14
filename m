Return-Path: <linux-kernel+bounces-409775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BCB9C9145
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9F11F23878
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE1418C930;
	Thu, 14 Nov 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt0JY8sK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF41C683
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607234; cv=none; b=lCpSgCMX8IJw3JpO5wBwYvkDujrVQEpHh32LLKgQPf92MoW54UqdZNn8UR9Z6QmbKE0r7Lum/7dsRg8kHsu76PHsBtwRoAUk4zx0gyH3EC+iyNFXkD16f9He1xsPvd4+PQvXal7NuNz8MJZQ2mTUwISl4nJhaDZJXgoW4PIWW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607234; c=relaxed/simple;
	bh=/IWFpM6Y53TPwB52PLE/0ScY+BYAIXmy0NSKjuRLYnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpnlim0PrfVKUcTu2kARSCD40lMLWwJyqVoHwzXgD9OPB9X4bc9MMIGAl5HtGxUegsZu3176HzgL8M6a19XaFDDMPJ6LYEHVq001qGrTp8uQTJ5kQIeX2d5tIeF25KQXy8QJ7NviKl649fQGnRiQRl+7s9p0HS7JBsk9aoSo5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt0JY8sK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A54C4CECD;
	Thu, 14 Nov 2024 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731607234;
	bh=/IWFpM6Y53TPwB52PLE/0ScY+BYAIXmy0NSKjuRLYnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bt0JY8sKE4W7aRU8aJOSlslWHLxLk4yRWhi10sR5AV10yNfZBsZkyQ1Dvo7tAC+Xx
	 5npP8/N56rNO23mmVBpb73J0NlezwRpvNKDiNqmQB1gDeN+YP1hw27/dTbrhV4Dnl/
	 jSKAlY0C6DvuIbkcwUSGvtBaotxD3/ITR0Bue5BfSF4XLb7+SJQzwKs1dlS+WmCKpu
	 AqypnWYvKYYjTPQOrMYdVddbmmlC/1XHMSRWJ/ypkW5v+MihpfCTQc8NIb54iGqJqF
	 D5D+zv2MYfsv+WIMvESw+6lxlC7Q7t/J9j+bS+ecYavuO0s8kmdObjRZb4GGOmkajY
	 HlrtnKxLY541Q==
Date: Thu, 14 Nov 2024 11:00:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzY6v4d71jliy78w@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>

On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> We initially put in a quick fix of limiting the queue depth to 1
> as experimentation showed that it fixed data corruption on 64GB
> steamdecks.
> 
> After further experimentation, it appears that the corruption
> is fixed by aligning the small dma pool segments to 512 bytes.
> Testing via desync image verification shows that it now passes
> thousands of verification loops, where previously
> it never managed above 7.
> 
> Currently it is not known why this fixes the corruption.
> Perhaps it is doing something nasty like using an mmc page
> as a cache for the prp lists (mmc min. page size is 512 bytes)
> and not invalidating properly, so that the dma pool change to
> treats segment list as a stack ends up giving a previous
> segment in the same cached page.
> 
> This fixes the previous queue depth limitation as it fixes
> the corruption without incurring a 37% tested performance
> degredation.
> 
> Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")

I had this queued up for the nvme-6.12 pull request, which I'm about to
send out, but I guess we should drop it until we conclude this
discussion. With 6.12 likely to be released on Sunday, this better
mitigation would need to target 6.13, then stable.

FWIW, given the current understanding with the last entry boundary
chaining idea, the QD1 mitigates that by always allocating a 0 page
offset prp list. So it effectively works around whatever errata we're
dealing with, albeit with an unsurprising performance penalty.

