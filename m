Return-Path: <linux-kernel+bounces-549849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2FEA557D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CC23A6219
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDCE207E09;
	Thu,  6 Mar 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baishVGI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652925C71E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294275; cv=none; b=KEYjkqE51VE4gfwh4AvKcVMkLX+ww9oNft/AM8udnV5gErfXKLZz6lCDzBWKOwKMf0Dha1l0X6uO/Lq+EvdJpAddESzuMscP0VoaB45rZEAKCIYfQVHSPIpV9CQYUyuTXf7POiYfkZgNrJoq7QsYNOc/bxvLdZWsK3Dj7QCg9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294275; c=relaxed/simple;
	bh=q32HyuRlMQt1Zam2/ulOfhJfOp7xkCj4XPMi1zCZEjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miHE78deIPQGTKWrpUAhhDSvxwY1CF0gYSSy+vOOFierzCymov7FPdaV0g6oyihpcR00/ToPxHPjMkgSlfL6ul9nC5pPv2/Jtqy7vxXUO0Zgl2Tfm8i7Y+a9KnUsO6YbdNDl8CwwJ1G2WB+xIYxgINx0yYjUujRfXUVt3gnHu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baishVGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C68C4CEE5;
	Thu,  6 Mar 2025 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741294274;
	bh=q32HyuRlMQt1Zam2/ulOfhJfOp7xkCj4XPMi1zCZEjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baishVGIeMbGecP0VLrdbnIC+RPxyKDUZdMDZqwJTv2egrLtBkf9WbO9tiDIyb7qo
	 voZjjaeSkidXA5SlOt3tnzbC+DoHZup1icPVcoAXJ7etMVmRBFzF/l4FuKNP3sIKCs
	 0rxgXmD6sBlpEZwYaUpSxoYGkDU+iMknvwNEzF/HYVwJmmcL9x2MDVaQMO+s7iGoDQ
	 i753FoOFpCe14mwzaBzEfmtdP2UrfZc9Pl0oKY+81Aif3u9yPslZNmvY8iFQJjhFSU
	 QjlTh2BXDdWIUppksX9lAXPqVYZNVUtYJdGcwH3DLOzK/5UGwhGWwIkxW1PQQqLAGD
	 JjGDOSFBf6nPA==
Date: Thu, 6 Mar 2025 13:51:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [bug report] nvme: fio workload hangs on 16m random read
Message-ID: <Z8oKvwPd4UBY1awm@kbusch-mbp>
References: <87a59x6g5u.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a59x6g5u.fsf@kernel.org>

On Thu, Mar 06, 2025 at 09:46:37PM +0100, Andreas Hindborg wrote:
> Hi All,
> 
> My CI system has found an issue for the following fio workload:
> 
> root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme-core.ko
> root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme.ko poll_queues=1
> 
> "fio" "--group_reporting" "--name=default" "--filename=/dev/nvme0n1"
> "--readwrite=randread" "--blocksize=16777216" "--direct=1" "--numjobs=1"
> "--ioengine=io_uring" "--iodepth=1" "--hipri=1" "--time_based=1"
> "--runtime=3000"
> 
> fio will hang, some times immediately, some times after a few minutes.
> 
> I observed this on v6.14-rc1 and v6.14-rc5. It is not present in v6.13.
> 
> Can any of you reproduce this? I was able to reproduce this on real
> hardware and in qemu.

Could you try adding this patch to your kernel?

https://lore.kernel.org/io-uring/92b0a330-4782-45e9-8de7-3b90a94208c2@kernel.dk/

