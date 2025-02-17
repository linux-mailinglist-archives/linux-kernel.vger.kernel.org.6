Return-Path: <linux-kernel+bounces-512998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DFDA3404B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E395D7A2E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238AF227EB3;
	Thu, 13 Feb 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFv5DZ/H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94723F417;
	Thu, 13 Feb 2025 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453185; cv=none; b=KFVSvtoaC2LqKu0jI6uuVh9Cdzk1H2fCMwTmWGccX7BDPQQlygwPwQfT4bPrqF4cDtEmTlWAPXgfoFeLtEN3s45SWxgNoijZgL/sXGTc05vrXLi0w68I85o1Ed50ZgCM6rxrclpXVlYqdgEot3vJ7R61JEW8Dxe9FefowPb9CJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453185; c=relaxed/simple;
	bh=QAeaR129c4R3fwn4Q9Lfhl3+6WKirmUB53yZflBZ2zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItA2g8xIfsYedeJFW+4TpdSGtQe6PpXTXjkxhsWyTPhUIxk42NuhTRzDU8qfWRbfhgLEnjaibg7oubEbMCu/2UJ81P6PYskrOqOV2ATcOOUEfZ5CuX7RB5zz8ZSceRDBUwKBXhkeHXEYhKr74prFqh6JK063dtzrpwGZjXWxXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFv5DZ/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49732C4CEE2;
	Thu, 13 Feb 2025 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739453184;
	bh=QAeaR129c4R3fwn4Q9Lfhl3+6WKirmUB53yZflBZ2zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFv5DZ/HqzrfRxHhWLS4zJGx05FXzx4149OOXKDH+jL69f+awyTCA0x2xo8nL0OHr
	 W7ZsdGkgRJpOrL1Qlb8M8CoTmojdEcPmozt1nD8GoMZ9ZmAGcJA6nUs4kvdlAOzuyM
	 FjJwvu3FoKWWPmT58tWSS8UctEZVPLtqirxBB7EuULCy4WpLu/nJh4DrS+LypVdLWn
	 MtkigOU+E/U/8Qo4qTsQ+KBpSVvX8fthG85aP2TLyvjsaFaZZ9e0nq82AFS3CcQ9nL
	 MvubrXOMUP8JzT+OMA/jkEYyFmwJZD/yCd0Wo04JhQID7obLeqdk9RWos6eD1QhvRf
	 T+qkg3XYug/Lg==
Date: Thu, 13 Feb 2025 15:26:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 1/1] RDMA/mana_ib: implement reg_user_mr_dmabuf
Message-ID: <20250213132620.GL17863@unreal>
References: <1739180908-2833-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1739180908-2833-1-git-send-email-kotaranov@linux.microsoft.com>

On Mon, Feb 10, 2025 at 01:48:28AM -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Add support of dmabuf MRs to mana_ib.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c  |  1 +
>  drivers/infiniband/hw/mana/mana_ib.h |  4 ++
>  drivers/infiniband/hw/mana/mr.c      | 77 ++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)

<...>

> +	ibdev_dbg(ibdev,
> +		  "dmabuf 0x%llx, iova 0x%llx length 0x%llx access_flags 0x%x",
> +		  start, iova, length, access_flags);

<...>

> +	ibdev_dbg(ibdev,
> +		  "created dma region for user-mr 0x%llx\n",
> +		  dma_region_handle);

Please reduce the amount of debug prints, especially copy-pasted one.

Thanks

