Return-Path: <linux-kernel+bounces-287591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E14D9529A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F9AB2368B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40346179967;
	Thu, 15 Aug 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jcUA6C/x"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BC3BB21
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723705746; cv=none; b=mR7n+hfbko6Aol0DEyIAg9RckSPpbWY6r+pN7OQ2EboPyqbzzZ5MMu/7r6AiIsPjiuxDEecGihB04MvP0L++pGZeq7HjXdzQRMuEyX+LLA3wDy1BshQiiKr7mSD8gEbjC2qLjlTTmNRk2f0JJJbdV2ONjUlt0Zm+Yr4pE3N5wO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723705746; c=relaxed/simple;
	bh=+3ZC608fRYqs0E75krOR339bZDArr6fJWlVWkXXY/PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNjNVbFWDQwvVFkcRlt3qTsX3l/ivSeRBYkT0vKcuiGfs3ahnCxqyg8qja8iUl1X1YzbH4kJaRhOF67nepeipGFBN9OUekJbLDdFFRc7mKtHZO6JIvjkVssiJz6zhl7XvrnAAOGRn4kHF8Gv3poZXwXRWqO7hqFkrXgEeCeUfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jcUA6C/x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc52394c92so6170945ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723705744; x=1724310544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eEubBv7YlyYmifwGtDH1r/SzpbLMAGHxulPar3OQYok=;
        b=jcUA6C/xc3hf6eMONR//hUVWGx9YRLVNVUQY2OhVaKjgli/nl6xC6/s607ebLjAkTC
         cOB1PyCnZsP9PFhQLmHjOP/UGfaH7jaGXcvl/e/fsn2xcgC6h9tce28/eu3XRjq054O8
         Lscn/V9ArvwQE6bi8FCmk03+IpbGmP3lZ5d2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723705744; x=1724310544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEubBv7YlyYmifwGtDH1r/SzpbLMAGHxulPar3OQYok=;
        b=xUGNYn/BgtZuSwTnynAgEbIq+HtpsG7ECjW9ufm9ex5S92dD0vYW0TK8GacFbdRpON
         pAvAe5dlNv9ok+ZtPw4N4lPIuZNfLC9GSVJP6uAkYu5rexoAVHwdivcKJYOahc+sNJY9
         u6YS1xMHqkClPyOO2b5tpqPWuWlvT2d0UIV4GCocfXEaQdhSQIK0pazOg75zAxEhyoxb
         7y/kO+aJ3BuHPjv9pQGTXL2hN7jIvhBmgz4vQhBMC8wYyxCMR1xdY1Z4tzqk4thKz8kA
         48l83RR1pqoIvzKXeSayNIZwnwPgmvKNAcufy4pMr0zoLNMjZQoOrFreIyyb6ikykR0v
         tjQg==
X-Forwarded-Encrypted: i=1; AJvYcCVgzxrNRAYpk1WPWO7apxrlD5iyWpc5q1g6+CS5uqrDGgtrnXHEcKS8P9cCnFX8OvJImF7SUQbGMChaL7KZYYt6laHwmPKfneoU87s8
X-Gm-Message-State: AOJu0YwT+OzJwV9+pUXDgGMwMAcWGKbh5/A56HzqPbfMyO7EcsqyKBmB
	BJCnvZslXtHJ5keeoeEbcy1CqWcVi/bOzmsNrsyw/8b52VbL7phsmceMg9E83w==
X-Google-Smtp-Source: AGHT+IHty7AVsv8iu9zjRNVg8ahQtN5cBsQwSxGtQ6826Wh/7FAYIUG9X1y964/vg/3Sqyj+vXG+ew==
X-Received: by 2002:a17:902:ce84:b0:1fd:6581:f69f with SMTP id d9443c01a7336-201d63b00a1mr72599205ad.22.1723705744296;
        Thu, 15 Aug 2024 00:09:04 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7dc:2307:3c4b:963e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0378973sm5643665ad.160.2024.08.15.00.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:09:03 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:09:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <20240815070900.GB12106@google.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815070339.346160-1-senozhatsky@chromium.org>

On (24/08/15 16:02), Sergey Senozhatsky wrote:
> wq->lockdep_map is set only after __alloc_workqueue()
> successfully returns. However, on its error path
> __alloc_workqueue() may call destroy_workqueue() which
> expects wq->lockdep_map to be already set, which results
> in a null-ptr-deref in touch_wq_lockdep_map().
> 
> Add a simple NULL-check to touch_wq_lockdep_map().
> 
> Oops: general protection fault, probably for non-canonical address
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> RIP: 0010:__lock_acquire+0x81/0x7800
> [..]
> Call Trace:
>  <TASK>
>  ? __die_body+0x66/0xb0
>  ? die_addr+0xb2/0xe0
>  ? exc_general_protection+0x300/0x470
>  ? asm_exc_general_protection+0x22/0x30
>  ? __lock_acquire+0x81/0x7800
>  ? mark_lock+0x94/0x330
>  ? __lock_acquire+0x12fd/0x7800
>  ? __lock_acquire+0x3439/0x7800
>  lock_acquire+0x14c/0x3e0
>  ? __flush_workqueue+0x167/0x13a0
>  ? __init_swait_queue_head+0xaf/0x150
>  ? __flush_workqueue+0x167/0x13a0
>  __flush_workqueue+0x17d/0x13a0
>  ? __flush_workqueue+0x167/0x13a0
>  ? lock_release+0x50f/0x830
>  ? drain_workqueue+0x94/0x300
>  drain_workqueue+0xe3/0x300
>  destroy_workqueue+0xac/0xc40
>  ? workqueue_sysfs_register+0x159/0x2f0
>  __alloc_workqueue+0x1506/0x1760
>  alloc_workqueue+0x61/0x150
> ...
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  kernel/workqueue.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index bfeeefeee332..59bd2c1e55af 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3870,6 +3870,9 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
>  static void touch_wq_lockdep_map(struct workqueue_struct *wq)
>  {
>  #ifdef CONFIG_LOCKDEP
> +	if (unlikely(!wq->lockdep_map))
> +		return;
> +
>  	if (wq->flags & WQ_BH)
>  		local_bh_disable();

Oh, okay, so this is related to [1]

	workqueue: Split alloc_workqueue into internal function and lockdep init

Cc-ing Matthew on this.

[1] https://lore.kernel.org/all/20240809222827.3211998-2-matthew.brost@intel.com/

