Return-Path: <linux-kernel+bounces-240030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A58C926827
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD65BB26584
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2B187543;
	Wed,  3 Jul 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhLI4RBW"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72E185095
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031295; cv=none; b=Uwe/aI5J5QbTVEH3HGDchgGUzfo2Fo/goqH9QYZA6EbknbjGohhB55g5JUlvxfM1N4B5aBD0n+Kw8rg4CBUCUjSLhjYX8eShoOX3Ah2Qp6zLD/HGGuIUacIZIRiueV6rrx2CLb7gJK/hXjSFLo+XrI2BfRGfo7RCPP5sPFSRNO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031295; c=relaxed/simple;
	bh=6tsXGpthgUBuugRs7v2nm2gS/0/cfVBFms+/0Jeqjv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjstpoJzo5cyVlJQbM//fjxtG/TX0RU5pUUxvlM/dkLO66cvSXpgFzwIi+IHmzGOVfnezNdpeGgCTMuVXBbC0jF2TIxVcuS6j/XvT9x8CNRkqE6iltwzo20Or+hNzisEr+/DKZMwOsLl6RMjOTNjmy2bZ2hCmegAkU5iGWv8XEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhLI4RBW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-754d2b05db5so1387278a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720031294; x=1720636094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40SsS8n7KKyG4ofXQIno3NG75myhezZa7l0i78+zzxI=;
        b=FhLI4RBWxCSQiNY1soiMaI011qgxiB1jrZV2E+xUP6E1bX2CbDGrXApxvjbPTeP7xm
         zBFkwkOpPuV7M/OIqYxgKoBHATBiA0Ofx76Nrb7NZCNIcmlX2B+uNdtaTADWgjVhf8uM
         5QxRxUp50A8Mam79508bMSwPwUP7KsO7mwgmNvhyOaIiOV4iJpt+FmE4zibyZFN57EmN
         yHu5f4ixDAQjlGxOhxygb0zd/uzsKk1Fhl5TOHTVLSfEcbVYDq9MSKwYqNft0gkENhKd
         ayKNRgAeaWmxZigmRWyUz9b/oL+A33XSIqHfmZoR/jnW6jsFoPm5bhB/R5KjWE4u9P8U
         6iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720031294; x=1720636094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40SsS8n7KKyG4ofXQIno3NG75myhezZa7l0i78+zzxI=;
        b=FmM4BGeSwD6l45oss3gAzokhEATae6ibgKdOpMHE53HWRa9mGN30KmmsBNFIvzrSNN
         a4/GwHvWw8HrLKp4gAldT8rlTNg7N2rk77tjOKlwqwWCLMnrwYMR0I/FqsWelyahpA43
         5b9y4yb1QiRLCVYqEGfz2pGX0bVnNlmqmZWJtH+lWQc+x5dmYImYwRId+cQZZwkO6/Gv
         /272j1QxqRlz0E0FCAiVOv0a+8JASHUWvn5Z5VWMj42v3Lk+iHFjy98N6FN38+whhhA5
         0Y1BEXtySq5yxZ4PgDHswDG6vt38+1OHe98r8h6pAsJ7V/UPmblYfGD/h0xNWso8sVlm
         EqIw==
X-Gm-Message-State: AOJu0YyLv3VvrRu7pXsZklPoYQJhJ/kPm14sodbUk6jzd1mOSz9+1CGV
	QKFfDEIZ3Xk1Keg9ghezA5gyxgsugtxXZ5L+XVWL8+CM2Q1ekB19sq9XJA==
X-Google-Smtp-Source: AGHT+IFyixljs2L7AYRlMCxe0rYHSiUNiXGb3nvMHBLfww3FJxD6LZX0kKWz1W1KCzmeUYB5SmbYdQ==
X-Received: by 2002:a05:6a20:748a:b0:1be:c753:dc65 with SMTP id adf61e73a8af0-1bef613f465mr13102454637.18.1720031293546;
        Wed, 03 Jul 2024 11:28:13 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535cbdsm106932925ad.134.2024.07.03.11.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:28:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 08:28:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/6] workqueue: Protect wq_unbound_cpumask with
 wq_pool_attach_mutex in init_rescuer()
Message-ID: <ZoWYPMGVIvOV4o8x@slm.duckdns.org>
References: <20240703033855.3373-1-jiangshanlai@gmail.com>
 <20240703033855.3373-3-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703033855.3373-3-jiangshanlai@gmail.com>

Hello, Lai.

On Wed, Jul 03, 2024 at 11:38:51AM +0800, Lai Jiangshan wrote:
> @@ -5533,6 +5533,9 @@ static int init_rescuer(struct workqueue_struct *wq)
>  		return ret;
>  	}
>  
> +	/* lock wq_pool_attach_mutex for wq_unbound_cpumask */
> +	mutex_lock(&wq_pool_attach_mutex);
> +
>  	wq->rescuer = rescuer;
>  	if (wq->flags & WQ_UNBOUND)
>  		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
> @@ -5540,6 +5543,8 @@ static int init_rescuer(struct workqueue_struct *wq)
>  		kthread_bind_mask(rescuer->task, cpu_possible_mask);
>  	wake_up_process(rescuer->task);
>  
> +	mutex_unlock(&wq_pool_attach_mutex);
> +

Isn't that just protecting the reads on wq_unbound_cpumask? I don't
understand what this protects against. Shouldn't the interlocking be
something like "either new rescuer reads the updated cpumask or the
workqueue is already on the workqueue list"?

Thanks.

-- 
tejun

