Return-Path: <linux-kernel+bounces-173284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C86C8BFE33
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CDD1C20F48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04D85929;
	Wed,  8 May 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFT551bp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5373189;
	Wed,  8 May 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174015; cv=none; b=VpERhSXbicenUhsaPjsSLuLcj0dvyKNUbB0XCc+BQr21kjthZiZKDh0daTS6dNZcoeDgHAp8ksmGVrr6JbraPvG1CnDXxFSL0rQw9k5lUvUG3/lmnhs4pC20jPQrpFw12Nnxzz6O4DVBd5ahXUWHaEJez+PO+Ww1//J6CO5rNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174015; c=relaxed/simple;
	bh=S+L+g5yIhWlIr/9ZvbAOYclCZ1IhRvX6JyjpcHE5Uh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuAeVtjfKOwdJvOVW2wQReYXSgN1WhVEkweYDfghXu2YYCjw/FGHJDRH0Wr8SNehV0vQsST+13N2hcseOJ3pAO38kbU78PYUuAQGQ4xCuqsKH1TNED2f65bB9m886QQlZ6BcEH+eoNJqsgT9DDgzgByvdGmu+OBM2vn3OwXnrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFT551bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26FDC113CC;
	Wed,  8 May 2024 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174015;
	bh=S+L+g5yIhWlIr/9ZvbAOYclCZ1IhRvX6JyjpcHE5Uh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFT551bpIoawyrVHM6fj4ijVIne3bwjA9xNpjJ1QfejFj+ceOSqTntplF2gJq/BEY
	 U7X0fc60ZODbiXO8VXY/5WPVX02fM6F6NgzTEv912OO/3Rr4Y4wKGwOJ5H9E/irAx5
	 m4NjuijYppdoQ7LLzV/+bfUjC9FqJQ5hT4OSDrXfhWpvH5E0EJG5ySQGWJn4KV0vA9
	 5byfDbQOu12uvtUPasQHFNTRkmSRCZ+Ln8b0IW7ufUQRTPe+TGuTfkukaeRlxdlAIC
	 NosoGU04EP3kGw1oDGh25exqHUg1PsY5q2xCJ4mtxlwZ4yHdGFg7bG/mDLJ2gFRUd8
	 5Api71VsrTP/w==
Date: Wed, 8 May 2024 07:13:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvmet: prevent sprintf() overflow in
 nvmet_subsys_nsid_exists()
Message-ID: <Zjt6fDIxLupGfglV@kbusch-mbp.dhcp.thefacebook.com>
References: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e9c58d-d192-4a91-ad40-4c2ea01fbdf5@moroto.mountain>

On Wed, May 08, 2024 at 10:43:04AM +0300, Dan Carpenter wrote:
> The nsid value is a u32 that comes from nvmet_req_find_ns().  It's
> endian data and we're on an error path and both of those raise red
> flags.  So let's make this safer.
> 
> 1) Make the buffer large enough for any u32.
> 2) Remove the unnecessary initialization.
> 3) Use snprintf() instead of sprintf() for even more safety.
> 4) The sprintf() function returns the number of bytes printed, not
>    counting the NUL terminator. It is impossible for the return value to
>    be <= 0 so delete that.
> 
> Fixes: 505363957fad ("nvmet: fix nvme status code when namespace is disabled")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, applied to nvme-6.9.

