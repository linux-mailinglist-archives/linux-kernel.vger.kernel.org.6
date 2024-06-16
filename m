Return-Path: <linux-kernel+bounces-216229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B1909CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A201F212F3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB641186E20;
	Sun, 16 Jun 2024 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ee6SY7Cs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6138FB9
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718532172; cv=none; b=BsyAlWuksxoMRp317zMQNvZ6lOSA6racX1crjYToYIBrnrEgR3tlO8WaCjSUTlLgzz4jSEzV19NY/ZuWrxsuiOjoFPIplofJoGKg+sp8U5qLodnQOmGhM9N5sRqItE5CqLAYMpozeU+aG7MFdxc1ixAb2Si15LgKAqtyzYBClnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718532172; c=relaxed/simple;
	bh=yXIjGttonwU+6Q+ZK3eNhYRfgLvdtg0GGxDoUfkvkao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMJuWeHkMtGvQo72YwqBod18bwk6emT1siKAmryKCmoLwIDWouPshCFXwgDlVNkmUEPkON6qP9Uf1CpNDrMj7jrV9Me3r0FSZNfWWN8kRQ5bV13GyCrxzoivKJY05KVMxZL4rj4y2qSKpiu1h8WAgX2NW4BX36IZOPhQiLyhUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ee6SY7Cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F451C2BBFC;
	Sun, 16 Jun 2024 10:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718532171;
	bh=yXIjGttonwU+6Q+ZK3eNhYRfgLvdtg0GGxDoUfkvkao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ee6SY7CsDK/d/l6Bi0U8xO8VqTxqZWceN9Nwa/fl4SymAl51HTqtdZ6qYmdRnKsDj
	 L23L0Fu4VksdsePOMxV9vPN/NVAx7Pm+ps1XyMS39iHN2LwxSpKg769hg2XGP7ra+H
	 nkLbdwrrX1p5idxjZz32fS6m6zJ6dlnyxDrwhDCg=
Date: Sun, 16 Jun 2024 12:02:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] devres: Fix devm_krealloc() allocating memory with
 wrong size
Message-ID: <2024061609-breezy-magnitude-8edf@gregkh>
References: <1718531655-29761-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718531655-29761-1-git-send-email-quic_zijuhu@quicinc.com>

On Sun, Jun 16, 2024 at 05:54:15PM +0800, Zijun Hu wrote:
> Kernel API devm_krealloc() calls alloc_dr() with wrong argument
> @total_new_size, and it will cause more memory to be allocated
> than required, fixed by using @new_size as alloc_dr()'s argument.
> 
> Fixes: f82485722e5d ("devres: provide devm_krealloc()")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/devres.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 3df0025d12aa..1cf87ddf1f55 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -898,7 +898,7 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
>  	 * taking the lock as most probably the caller uses GFP_KERNEL.
>  	 */
>  	new_dr = alloc_dr(devm_kmalloc_release,
> -			  total_new_size, gfp, dev_to_node(dev));
> +			  new_size, gfp, dev_to_node(dev));

Wait, are you sure?  Did you properly test this?  What is the actual
savings and how do you handle the fact that you are now not allocating
the space reserved for the devres structure itself?

thanks,

greg k-h

