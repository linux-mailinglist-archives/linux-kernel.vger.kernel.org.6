Return-Path: <linux-kernel+bounces-549186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B4A54EC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B372174967
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93518DF89;
	Thu,  6 Mar 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtn10E7B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCAFD299;
	Thu,  6 Mar 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274373; cv=none; b=KtysLQt/581yRQid8z5nXupwlYmfW6iFIq0X7FZt2zovlSM/uVf2CyjUOIl3itgKAXKoVvO5jwxhaAQ08cSwBIfDBsvMALD69hHWitiwkPaJmq3t0GSaWO8BDY/aK1Yc1c+99tjilwu3ysj6XB8NmHyosDZKqTi24GKKfcXvbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274373; c=relaxed/simple;
	bh=6QlmcIc2nD2jRS+7DaISjQLzs92eHSdVRUCSyvfiE+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0MSpedLGUJiijmsdhFZcWcFbw0CbgyvzrS2GnGuboxPQmuYPuYU367fTk/1lm0kuGws48H1x/ZkhhsXNRksbiWaMl+rlbgwZoqoQZOi1P+w0D+uG4SZGLkoYkIh331hbFeiiJrBkNjr+iU26LmJ3B2+ms8hOwPtCpFWnAXzq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtn10E7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BF6C4CEE0;
	Thu,  6 Mar 2025 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741274372;
	bh=6QlmcIc2nD2jRS+7DaISjQLzs92eHSdVRUCSyvfiE+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xtn10E7B3Flk/KudFeKjl5xJub3tkThiQhBBxKdUOSnCB1UmePvTjdYFkemRVZIM8
	 ySuyZtAVgG9Zz0GOkAp4MmDSiV4aFU9UHuTc+JpLC3TYAji3//6onGDYIpurzp8Y4B
	 yqf5Hj3L8ZfB+QhavnpGYjzyFSXFZCQnIIBhlbtek++GJ2G4sdc/0+ceT/va9rzUjT
	 dG90gSCKd9gYC/tJOZQI+uLolQ0BWS33zgG0mrrxmwbr/5uCrLCTM95z3qWcQVUAbn
	 u7B3eMXmpXAUlIS7w+hptHfOa2vXJn2lSq8/S1IfCNsfApCykhjxS2MiUx41NGDBd8
	 Rzlsj9B4ydgQA==
Date: Thu, 6 Mar 2025 08:19:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-nvme@lists.infradead.org,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: 6.13/regression/bisected - new nvme timeout errors
Message-ID: <Z8m9AbD3tjNpBt6p@kbusch-mbp>
References: <CABXGCsMcxu3pCF8jYPeqF_jN34saBwc8Fci+c-Dg2Lh7rqvuFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsMcxu3pCF8jYPeqF_jN34saBwc8Fci+c-Dg2Lh7rqvuFQ@mail.gmail.com>

On Wed, Jan 15, 2025 at 02:58:04AM +0500, Mikhail Gavrilov wrote:
> Hi,
> During 6.13 development cycle I spotted strange new nvme errors in the
> log which I never seen before.
> 
> [87774.010474] nvme nvme1: I/O tag 0 (3000) opcode 0x1 (I/O Cmd) QID 1 timeout, aborting req_op:WRITE(1) size:131072

...

> I still haven't found a stable way to reproduce this.
> But I'm pretty sure that if this error don't appearing within two
> days, then we can assume that the kernel isn't affected by the
> problem.
> So I made bisection with above assumption and found this commit:
> 
> beadf0088501d9dcf2454b05d90d5d31ea3ba55f is the first bad commit
> commit beadf0088501d9dcf2454b05d90d5d31ea3ba55f
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Nov 13 16:20:41 2024 +0100
> 
>     nvme-pci: reverse request order in nvme_queue_rqs

The patch here uses the order recieved to dispatch commands in
consequetive submission queue entries, which is supposed to be the
desired behavior for any device. I did some testing on mailine, and it
sure looks like the order the driver does this is optimal, so I'm not
sure what's going on with your observation.

Do you have a scheduler enabled on your device?

How are you generating IO? Is it a pattern I should be able to replicate
with 'fio'?

