Return-Path: <linux-kernel+bounces-325476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E60975A19
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C9C28C7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C41B532A;
	Wed, 11 Sep 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNdt1hWe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EF1AE035
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078306; cv=none; b=pVYUFPgVov/ulJjNCGpk5fK4QVaAUZK2gD2FB2kYp68i5jeob2th89OXqBVEw/4zURrVeKb8g44UQwLku8bMMtSRyvcLuk6Xlti00c7AHKv80G+WFm49Zt0Y/bMX4p5Z7rBqngMSA5oz5ReFofKsoo3odjgV5K+3R2ALvEv6Pvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078306; c=relaxed/simple;
	bh=VnA3OdWtDX/4OYhP9tYJNJcq4pZ9CPstFnRscrbsGFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9fuJ7n00IfsZZ10OxJhS5tFERRQ67fXjgw/H5nVkhv/NHB2b/im5sebxO7R/rzy/Ez/t/+tN14uoQxELDjTbp+2NzzmS1Z1CDCWMqpqF75IWN8/FICaUSe9f7xkd/+ZHnNKGVzkF5ULllxmUHZU9CyfzdjGKcOZfspnqOlNo0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNdt1hWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796ABC4CEC0;
	Wed, 11 Sep 2024 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726078305;
	bh=VnA3OdWtDX/4OYhP9tYJNJcq4pZ9CPstFnRscrbsGFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNdt1hWeImlPduVRQKwGZIjIM+uIkzRhYM/P4zgbEWr9HDefE/XTnErOKFM32RyKs
	 EMYKhhaPPQ49LluisXQCGc2ykOzLcFtPAmTN3LlRp7/i4UXa9AkMznjvpZMlTDokii
	 OUj0Nsw6DfNEtRM4GSFQj4NxpbzzYK+JkUOmUe23ynwfAjY1RMUfFqbw0XLnkTSoXr
	 NbJKHsE4/WE26VMaxr/setTES8eso4YTv455KC+CwL/DbIFj2/eG0DBL9vdGw5ZRZr
	 cIW+2mJp/BTHfPF7IJInHfhmOpVRojxnsglfi/AxMrFKigfI2eJwUq2ZKBMTVqhPLc
	 Kc2TD+x6TjfXw==
Date: Wed, 11 Sep 2024 08:11:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	peterz@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCH] kernel/workqueue.c: fix DEFINE_PER_CPU_SHARED_ALIGNED
 expansion
Message-ID: <ZuHdYEncUmDee46Z@slm.duckdns.org>
References: <20240911050728.258817-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911050728.258817-1-bhe@redhat.com>

On Wed, Sep 11, 2024 at 01:07:28PM +0800, Baoquan He wrote:
> Make tags always produces below annoying warnings:
> 
> ctags: Warning: kernel/workqueue.c:470: null expansion of name pattern "\1"
> ctags: Warning: kernel/workqueue.c:474: null expansion of name pattern "\1"
> ctags: Warning: kernel/workqueue.c:478: null expansion of name pattern "\1"
> 
> In commit 25528213fe9f ("tags: Fix DEFINE_PER_CPU expansions"), codes in
> places have been adjusted including cpu_worker_pools definition. I noticed
> in commit 4cb1ef64609f ("workqueue: Implement BH workqueues to eventually
> replace tasklets"), cpu_worker_pools definition was unfolded back. Not
> sure if it was intentionally done or ignored carelessly.
> 
> Makes change to mute them specifically. 
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Applied to wq/for-6.12.

Thanks.

-- 
tejun

