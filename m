Return-Path: <linux-kernel+bounces-293868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D7C9585FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD602837F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247518E75E;
	Tue, 20 Aug 2024 11:40:47 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1C18C02C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154047; cv=none; b=pBRlbX99PEifEbXViM+Tjl6GIp3amqKdWwqcv8djNdAJYGq4Jkuj6Hp8S8ehMSNnJ1AW/+HtsdahiPZkipJEoSI85Pw5XzdSrsix5m1hyahAY1hFDyMAJGAP/+iGnP6J+3oAtHTnEaLKaFI8LmMtHdJ7ZSdKpD2R5/vsO6DYL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154047; c=relaxed/simple;
	bh=sNZnO963yhICLYGHbjGEhCFD+XwsO9GHKveVXpyesMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXExz5mPqnP2wem/8AMRp4aDwCuKnNDt1BRqcEw6gv8FISHgtzoJEf7TTRh0wFRtA81RktwpSh1HTCP2C01Qdi/dNTKN613jFaJK7/p/nQZJM9Lh9zQ6+OMD9SgNq5fM/mNpoXEVr2zd80WB8HJ0h3DhSlK99F5S+IsUq1P04yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.165])
	by sina.com (10.185.250.22) with ESMTP
	id 66C480AA00005667; Tue, 20 Aug 2024 19:40:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8943967602894
X-SMAIL-UIID: 49D8552ADB774E50A605928CFC916084-20240820-194028-1
From: Hillf Danton <hdanton@sina.com>
To: NeilBrown <neilb@suse.de>
Cc: Dave Chinner <david@fromorbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] Block: switch bd_prepare_to_claim to use ___wait_var_event()
Date: Tue, 20 Aug 2024 19:40:16 +0800
Message-Id: <20240820114016.873-1-hdanton@sina.com>
In-Reply-To: <20240819053605.11706-6-neilb@suse.de>
References: <20240819053605.11706-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 19 Aug 2024 15:20:39 +1000 NeilBrown <neilb@suse.de>
> 
> @@ -535,33 +535,23 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
>  		const struct blk_holder_ops *hops)
>  {
>  	struct block_device *whole = bdev_whole(bdev);
> +	int err = 0;
>  
>  	if (WARN_ON_ONCE(!holder))
>  		return -EINVAL;
> -retry:
> -	mutex_lock(&bdev_lock);
> -	/* if someone else claimed, fail */
> -	if (!bd_may_claim(bdev, holder, hops)) {
> -		mutex_unlock(&bdev_lock);
> -		return -EBUSY;
> -	}
> -
> -	/* if claiming is already in progress, wait for it to finish */
> -	if (whole->bd_claiming) {
> -		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
> -		DEFINE_WAIT(wait);
>  
> -		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
> -		mutex_unlock(&bdev_lock);
> -		schedule();
> -		finish_wait(wq, &wait);
> -		goto retry;
> -	}
> +	mutex_lock(&bdev_lock);
> +	___wait_var_event(&whole->bd_claiming,
> +			  (err = bd_may_claim(bdev, holder, hops)) != 0 || !whole->bd_claiming,
> +			  TASK_UNINTERRUPTIBLE, 0, 0,
> +			  mutex_unlock(&bdev_lock); schedule(); mutex_lock(&bdev_lock));
>  
At the first glance you add the coding pattern not recommended for the block
directory. Second, you abuse ___wait_var_event() simply because it is available.

> -	/* yay, all mine */
> -	whole->bd_claiming = holder;
> +	/* if someone else claimed, fail */
> +	if (!err)
> +		/* yay, all mine */
> +		whole->bd_claiming = holder;
>  	mutex_unlock(&bdev_lock);
> -	return 0;
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
>  
> @@ -571,7 +561,8 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
>  	/* tell others that we're done */
>  	BUG_ON(whole->bd_claiming != holder);
>  	whole->bd_claiming = NULL;
> -	wake_up_bit(&whole->bd_claiming, 0);
> +	smp_mb();
> +	wake_up_var(&whole->bd_claiming);

Third, worse, you have no real idea why mb is needed.
>  }
>  
>  /**
> -- 
> 2.44.0

