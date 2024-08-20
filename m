Return-Path: <linux-kernel+bounces-293238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16633957C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22F62852EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7994D8C8;
	Tue, 20 Aug 2024 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aF+P/nbC"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854238DE4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724127522; cv=none; b=N3i+fpk2qO6KZDB5tMb9a5LAlz2fULfdVYn8kaF8i/b1kM4sjUegnCTnYxPQlBUXChb3OT3qt7F+QQESdkyseHPGVEaJPfnYfE3xWDYBz4/+FEMJ0MMPa9c9OSnbcAI4KUn4JUYuj5z9vAsxjguWs6eqxoyerGl31zCvIciteFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724127522; c=relaxed/simple;
	bh=uX/4xLND3iYe1trl0SGCel7lq8DqmRBeuIc/+EifGhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odqqeXx9VVu9ARUqWZTuqbZ3nntx/oNz32CzK+cqGc46MxK12JIMjXKhiNMeDououElW/m4mnEx4pNhmwEBLRG9jBY7xkF+r0yKk6BgVkGNsBaXPOseN8w9EOXiLwkdkvUZU2V7/CPVC70nKSz+JMcgy86W/41SFpVQAonmfQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aF+P/nbC; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70949118d26so4153480a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724127520; x=1724732320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JbD5SE6Q7q5YCcsa82LQakSAiKJCXCQ2OC9wwaTCyk=;
        b=aF+P/nbCWI17+jYU+218QVA2o4Efgbs5Uo4zjdyNhZABVVJYodvREQNIMWaIgtlfLW
         r5KtjqXoW50GqRs1HyNii7k66eMiAdxML4M5hjOD1L1e6EHupsaDBgqajr9WtN0j6OgD
         xQqRfc2lHN1rRLwW7inDjowmautMqXcM8/UXXGtV/rIISmB1eRjWLx6chUq2HCk3haLD
         a4ZN6MbqxZs0Aaz18lSi5C58qtEViw7EJyeEcOdCrA7ulU3IGhAdbF3uIcu/d4NoUM6X
         o+Y1t9CP4A2ZVMtjCmkfkGmM+QjaZiTDMZ6BqY+dH4FnYuLVmFt0QQQruJo9iWx4gAmQ
         Canw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724127520; x=1724732320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JbD5SE6Q7q5YCcsa82LQakSAiKJCXCQ2OC9wwaTCyk=;
        b=FH39HMV3LLdUCTyKzF9Tp3T1pXawsmU6hFqd+BhgTB4evcvmmuZ2BAKNUVkOiDNZy6
         U8fyMnzFvCzs5GF+XOKkxRUBqgRkOjpLc9sJ7b/Tjd9vnKryFN73KF+XbjZTtDr+mcxk
         8vDI2fKVdnEoBA8u9518smBGSBX9hmNLbirpoEjSbf8YdhcKgRUEZR5aCdVEgswSbP7r
         W3wGW+f7eQ4lqumOEFHlOEWg83/kHUApZFShXMAzrPOVyTS6Pq9iU+0tRIjY0dcARPJf
         +2A+LuOU6RJv/Xd2H/56pZQO76odb4evZGJSL/czpck3jLSFQ+krkilwgLKQJ8vjFeGR
         jgCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7xOZbkW5KY/gOTT71ZaZAC0jsJozGnwimbNKfW0DKKJJdjsQuq1/oerkfUAKgy0WGc9yKu3k499lbo0C/HK81yzvkUgtwfxFz3XoH
X-Gm-Message-State: AOJu0YxmN2QXqY84wyfOtx9nXBNSQvWDs+HT0uBhEgIjLICraXsFiuQG
	v4E/nrsrvdeEVmt0Pt87rUYlgE7hLZdonwxfJOPXO915hqt9TNkOvsVCpD3Y10s=
X-Google-Smtp-Source: AGHT+IGg18Y7npnNWDO/miILZdYIps6Nu5REZe4XsVVtM0YVvphG2+O6isSW1QQaIwmhpW4jPHXmtA==
X-Received: by 2002:a05:6870:31c2:b0:25d:4f3c:c072 with SMTP id 586e51a60fabf-2701c380feemr14405647fac.17.1724127520108;
        Mon, 19 Aug 2024 21:18:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af16635sm7582851b3a.147.2024.08.19.21.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:18:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sgGKL-005rda-1E;
	Tue, 20 Aug 2024 14:18:37 +1000
Date: Tue, 20 Aug 2024 14:18:37 +1000
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/9] Block: switch bd_prepare_to_claim to use
 ___wait_var_event()
Message-ID: <ZsQZHZ0y6qMJGaLQ@dread.disaster.area>
References: <20240819053605.11706-1-neilb@suse.de>
 <20240819053605.11706-6-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819053605.11706-6-neilb@suse.de>

On Mon, Aug 19, 2024 at 03:20:39PM +1000, NeilBrown wrote:
> bd_prepare_to_claim() current uses a bit waitqueue with a matching
> wake_up_bit() in bd_clear_claiming().  However it is really waiting on a
> "var", not a "bit".
> 
> So change to wake_up_var(), and use ___wait_var_event() for the waiting.
> Using the triple-underscore version allows us to drop the mutex across
> the schedule() call.
....
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

That's not an improvement. Instead of nice, obvious, readable code,
I now have to go look at a macro and manually substitute the
parameters to work out what this abomination actually does.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

