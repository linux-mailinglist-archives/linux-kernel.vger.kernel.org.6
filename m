Return-Path: <linux-kernel+bounces-319305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7C796FA67
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FC91F2305E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4B1D6792;
	Fri,  6 Sep 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8Rn1WWF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52A1D6183
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646046; cv=none; b=MhmYZcpytFeLgTjKN0ti/N4H5EaXDurzF+8M2nWpYw4TGMVPEsVDPz/uS0i1WXJtb9VxNJSYSkaN3JJaSpXb4EMwpCans0DQLoTlM/Mr9mKOO35LkktPzPmGtUdCv7urjZqDhKBbq5vUW78+8mhlNP/9GuI6XGUJm/lX12BQ2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646046; c=relaxed/simple;
	bh=Afw3DB2KotuAbwG4IJBHjNy8qlGgNB/EnUFgiAsjLuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7t7LaCsFSxkTc6Cy5IqRvn319Q5uTzWLdXGBmfBgtQXMgXg5svEX5n0vpaPOBaZMMW5Cp5naSeSu8Z/9laTyd4Jefo+CpJQd1+M3qh+gaXIq7appuosaAuTkGYC+ja7Bj4G2cXAyAtfo3V/T2zbzGnn0oZyDBFJB2f5DxFA6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8Rn1WWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F8CC4CED6;
	Fri,  6 Sep 2024 18:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725646046;
	bh=Afw3DB2KotuAbwG4IJBHjNy8qlGgNB/EnUFgiAsjLuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8Rn1WWFunoirpPXGZiEF4rJqJs6PIqlEO2n40iNV02u8AFjnMgHVQAiSmbsVmN08
	 0WbZY8BB8DfjhPUEGvPmMh1vqlGTjtiUfmROZM9DB1bwvQNDN8axeMlk0ykDjcjCYy
	 Sh6Wul0oeNPP9LAdQFQZMjZv+sz/+MDzqdtFO++C3ieHDu6pGFDrCVnZINpRh9ruPW
	 jKVzth2j5vIyKTreUrXsweetsT31rl61/2rcWspQCf8pJXBAQGW47vEBsmMTb52/lc
	 tVG33fhzKQNUv6vrx9MTP1tVC4zNBfw6B2v63VTG6Cfv+uocb5x+agB7pshIPL6VsP
	 jNO+Mf/YGEekA==
Date: Fri, 6 Sep 2024 12:07:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <ZttE3H199lIjN3ki@kbusch-mbp.mynextlight.net>
References: <20240827121701.48792-1-pjy@amazon.com>
 <20240827121955.GB1607@lst.de>
 <mb61pjzg2gneq.fsf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61pjzg2gneq.fsf@amazon.com>

On Tue, Aug 27, 2024 at 12:28:45PM +0000, Puranjay Mohan wrote:
> 
> P.S. - It looks like we will need manual backports for stable kernels as
> this won't apply directly. I will send them after this is accepted.

BTW, the reason for your bug observation on older stable but not on
newer ones looks like was originally "fixed" with:

  d4aa57a1cac3c99 ("block: don't bother iter advancing a fully done bio")

So while your change is fine, the above commit possibly inadvertently
fixes the inappropriate "advance" because all successful nvme
completions are "fully done".

It still probably doesn't make sense to attempt metadata on request
queues that didn't register with the interface though, so your patch is
also fine.

