Return-Path: <linux-kernel+bounces-382601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4619B10F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD67F1C2127A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EFF21F24C;
	Fri, 25 Oct 2024 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frrwGO9D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8264521F242
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889035; cv=none; b=frH9XqYadPzn/3WvxG5EPbZNwFkeEf3dPu5juHUCDJdd3Elk18W9TfYRvioYDsk16D/K7gjGXj0J3uHuYQdVW6XzIt6pj4Gk+SQsqkm0nzU3MpWxI8synXe3nt+4M2wzu1XwHd41akZrVaYjGtHogDHmJYpd0556EPrRfykyY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889035; c=relaxed/simple;
	bh=l9JQPoh4+QDq75hTf/NlfhqorpdgktO/MOh9YCvECl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+eP4gtPjzDpCTSgOrL/7v/+22aVnAkRHJpc28YEZMTKqlz6QHvWEA046Zz1Ds4w/VpVUafBjiTmhEjFYeXRLf0uqQ7/3CJCM9JWDG5lFmgaF1yDvJlwr2bitPYv9XiW1nOCv1GIc3XNLbS9jiUzf/a+y5kkxbSngRiUCbWf+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frrwGO9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E143BC4CEC3;
	Fri, 25 Oct 2024 20:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729889035;
	bh=l9JQPoh4+QDq75hTf/NlfhqorpdgktO/MOh9YCvECl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frrwGO9Dm6/EqBqpB+nKWPneq3g/NRj//ykZRqKBIGIkERGNzDNvra4P8xAuk1LLU
	 m1vGRywq3l1PAEitN1bQdw72Y//v5L361tf5hWLaumLyhDGoQa77Ot3jsqM5hZBmLP
	 HDPJkHcbL6ecPtB6OUo6vSNl7EpmzaLVww1SKLgx0MAMt50hwwGnBF6FgAIQ04f/uW
	 tUxSLuWo0nX6X9MBOUeDraqCpkdXE0rURht5PRh8lGm9tpyEcMuYU5TgJvmxiFvNqg
	 uC7MCJUlI3xVOvd00ezBmKjDIWvcoPKTk5F+1dfbAHZMV1hP7smkN802re3EOBABPs
	 hkBzPpuBjr+nA==
Date: Fri, 25 Oct 2024 10:43:53 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scx: Fix raciness in scx_ops_bypass()
Message-ID: <ZxwDCUcyTABN8Exj@slm.duckdns.org>
References: <20241025203929.22839-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025203929.22839-1-void@manifault.com>

Hello,

This looks great overall. One nit below.

On Fri, Oct 25, 2024 at 03:39:29PM -0500, David Vernet wrote:
...
>  static void scx_ops_bypass(bool bypass)
>  {
> -	int depth, cpu;
> +	int cpu;
> +	unsigned long flags;
>  
> +	raw_spin_lock_irqsave(&__scx_ops_bypass_lock, flags);
>  	if (bypass) {
> -		depth = atomic_inc_return(&scx_ops_bypass_depth);
> -		WARN_ON_ONCE(depth <= 0);
> -		if (depth != 1)
> -			return;
> +		scx_ops_bypass_depth++;
> +		WARN_ON_ONCE(scx_ops_bypass_depth <= 0);
> +		if (scx_ops_bypass_depth != 1)
> +			goto unlock;
>  	} else {
> -		depth = atomic_dec_return(&scx_ops_bypass_depth);
> -		WARN_ON_ONCE(depth < 0);
> -		if (depth != 0)
> -			return;
> +		scx_ops_bypass_depth--;
> +		WARN_ON_ONCE(scx_ops_bypass_depth < 0);
> +		if (scx_ops_bypass_depth != 0)
> +			goto unlock;

Now that we know irq is disabled in the body, can you also please change
rq_lock_irqsave() to rq_lock?

Thanks.

-- 
tejun

