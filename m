Return-Path: <linux-kernel+bounces-562651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C273A62F9D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E2D3BFBAE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D762204F8E;
	Sat, 15 Mar 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0CFswUd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E9204C27
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053568; cv=none; b=NXA2RKfieRrFHau5n9k1ZjzR2efJFz2Ze+X79lNHZcgfbNASmPMnuPFdcRSzOyCU0jYK/kHPxjO3hgPLHsSr58vqrvvUrnVx8qr7sJQ0TG60GC7GTjA3lW0zu4ZyCTkK6ZSFu8lcbtkhIkTMNSc3wbLiyJriQZ6UDoWys7Rl7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053568; c=relaxed/simple;
	bh=kz73YBVQfpSiUgqd7459ZI0e5TbEl4pLYaiBSKt0Q+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAXomxj2/gim85FzzJNKfWyAjJwcobgNcqq7WT6n2/9gjLvGFQY2Dmx4Kfed+WGQCm/Li0LgnZUulTTV7RXjHxD2VGr2A8CynHNfT4yNqM9BPEGB2aGDfbu0jZxx7t4v3K1u1etfG5WRl2nQp5sV2HavXk0oBNQDwPwtOPYfy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0CFswUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7E7C4CEE5;
	Sat, 15 Mar 2025 15:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742053567;
	bh=kz73YBVQfpSiUgqd7459ZI0e5TbEl4pLYaiBSKt0Q+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0CFswUdcZzk+WnlFwu88MaAYx5XWjP9TuZGc5gYBK4HJLVgkkehqTok70yj9ggVu
	 oWs+2VWoc8HJoOn6+34RlRNJsH5sdwK6Ddz6M1zg9CxWSYXtC60PmrLuzjwyRz7PGS
	 kgTlGYt8PP0xbtDpZ9MOJu/HotmTNEh1+kGSdwDVlx9uHdQceKspZvGzXvsSTx9YYs
	 awTP8FweC+Jlo/SuZa3L0kcNPrj0gTHPI4xhbnQS1k0+Tn6mulyVOHXjUXlEEnkiHq
	 QFXg9p47u6ZMlovYerGRuuQvtYDhzr3LfZLA2eb5or1IuTifgwLkVbWHhd1aIY7zBb
	 rxv5RnXWV/1RQ==
Date: Sat, 15 Mar 2025 05:46:06 -1000
From: Tejun Heo <tj@kernel.org>
To: xie.ludan@zte.com.cn
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] workqueue: use sysfs_emit() instead of
 scnprintf().
Message-ID: <Z9WgvgHYr1A6S3K6@slm.duckdns.org>
References: <20250315141758672YYVCK97SOzH7bky44hoBe@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315141758672YYVCK97SOzH7bky44hoBe@zte.com.cn>

On Sat, Mar 15, 2025 at 02:17:58PM +0800, xie.ludan@zte.com.cn wrote:
> From: XieLudan <xie.ludan@zte.com.cn>
> 
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
> ---
>  kernel/workqueue.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index bfe030b443e2..648e89dd3ef1 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -6463,10 +6463,10 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
>  			 */
>  			if (worker->desc[0] != '\0') {
>  				if (worker->current_work)
> -					scnprintf(buf + off, size - off, "+%s",
> +					sysfs_emit(buf + off, "+%s",
>  						  worker->desc);
>  				else
> -					scnprintf(buf + off, size - off, "-%s",
> +					sysfs_emit(buf + off, "-%s",
>  						  worker->desc);
>  			}
>  			raw_spin_unlock_irq(&pool->lock);

How did you verify your changes? wq_worker_comm() is used from procfs not
sysfs. @buf is on-stack 64byte buffer from proc_task_name() which is not
page aligned and will most likely trigger WARN() path in sysfs_emit().

Thanks.

-- 
tejun

