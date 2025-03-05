Return-Path: <linux-kernel+bounces-547487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F418A50A14
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7FC3ABE40
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83D25333D;
	Wed,  5 Mar 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvkVF1Gc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D525290F;
	Wed,  5 Mar 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199952; cv=none; b=inAQwom+2IwJaF/uJmPaaY8yEITG1hZsDJvAtQNxJPH94ml1MLtfGbw6fIsFrcfsquv7x/3njnjQW9/zHTxwT2roQAABYSdeUsLm9cRdCRS0nM1I/kNNCShGYDvzETXvvf7XQvvE2w9h4fUOaarcaHxLISyQpV1rszB8nthI3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199952; c=relaxed/simple;
	bh=grH0RhVhc4eOiVhfXSf0JaS0A7IAc62nPyeEwfK6Y14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwzfa4fiXdu2kZCdseykZtYvUzAO3VZ+MPmhxOLLRi9QqeNm4Y5YtxzXLLtxgaN//RaLkMdvNPjwk+bVB3gfECKZX/u9UC4le7kfj1amB7rziOBn6UjiUGo3Y1XVGGww8VQyrlVLRgGrD4jIq18fQMgiyZZ0jgNdN2wfqfesBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvkVF1Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8445C4CEE8;
	Wed,  5 Mar 2025 18:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199951;
	bh=grH0RhVhc4eOiVhfXSf0JaS0A7IAc62nPyeEwfK6Y14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvkVF1Gcn2xVAVy+dRci1AFs7Pm6G4S1szXVBwYXnjhyGT2Juz2KDr8bYgShpw3Ly
	 agEK3dIgTD0yz7JmGk7a9T6cUmEFNJ5uR8frxcz4wnbUieh69sZWNfH/D4CES2blbO
	 eT/qXta75KJdQK0DdYYFhnlRYrxufD8YmMvXGY3ve4dmyojglcjX6CMzqaHUB2UV5t
	 ZV1nuLAIV79V4oxlqQwuhXyYQqG66SDbuCx/frW93wAz3mHqY5PtgC9m7qBXN3/gJT
	 UuLbnrl0RlV2BwcR86FMxUbnnqNQhk1KVK1SZ6eu+d7RSI1sDWgEElffrS3XFNQJX6
	 Eb03ecfRs8v7g==
Date: Wed, 5 Mar 2025 11:39:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
Message-ID: <Z8iaTC4aGPRuZSfI@kbusch-mbp>
References: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>

On Wed, Mar 05, 2025 at 06:52:59PM +0300, Dan Carpenter wrote:
> The kernel_recvmsg() function returns an int which could be either
> negative error codes or the number of bytes received.  The problem is
> that the condition:
> 
>         if (ret < sizeof(*icresp)) {
> 
> is type promoted to type unsigned long and negative values are treated
> as high positive values which is success, when they should be treated as
> failure.  Handle invalid positive returns separately from negative
> error codes to avoid this problem.

Thanks, applied to nvme-6.14.

I had v1 applied previously, and it was the top commit in that tree;
force pushed this version to replace it.

