Return-Path: <linux-kernel+bounces-252943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00365931A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E76283178
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FBF7172F;
	Mon, 15 Jul 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zds8VmKg"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBFE17BB5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067794; cv=none; b=doqSzAEeswQu/uTOOsCDQxqhaJOqiK3LKPosLw0c+hpO33fLbja/BdFnwD8S8oTAlrUpZE9EyT9Lr3rWalja1afZMA3Mv5ie+j1o1AzkCNX2BTDuqycZvm2AUYtmbzPo9KImQD9cpjCLVbklv6gKS+fVLwSPgEuT5RcW6xS7AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067794; c=relaxed/simple;
	bh=kOGtCnRXJDIdiFlRsoNKmF9dG3hEfqEnWrIucwqY1H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK/njUaXa/y51LgTSGzJrqS/pr54+FpmDEXKjbmKZ0KlkrnOeW6MXzdZiFZyQDYeLdRmJqB7XIz1OGMyHhmmE4GfJ8TGC1t9T09R1yJFkFTjpprhYpqz/9HAMZZ/T43hKK0bS76toy6G3Y5aAzDoGRC5yGAswrEbAmZ5YLkQAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zds8VmKg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7515437ff16so3244651a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721067792; x=1721672592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uaJXsC4DqRnv7LMu77kb08Ap8axL2ZAP1S64KpqVH8=;
        b=Zds8VmKgxFuQW42DR+/rXIoQqS3sQXYxHaI05ilBQmFz9mRMJ56Sw3XpwrxsdLcfCh
         LsOVwySL0X1WvsjtNY40r7HQZ66Dph/vXevVgOQj0iPUsmIHmrxw9aTCjjHMD8yzZ2hu
         tOzUf85pLjLQ3qLwOHhnt1hCVy5CeaAx9Kjfj3znZlw54yjW14M9jd/sw+8dUKAknKNQ
         3J2IR8iEAkqgNxciwobTeddcLNPSE3ltURWchoVfixm511Wt8SqESccaHdbtz2uKGm7W
         wO5+8GLwWFSVml7wOL8+VTvtDlQg47FGidS5ZYG9hSz96544Qa/oA2XymNchbTokvue2
         y+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721067792; x=1721672592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uaJXsC4DqRnv7LMu77kb08Ap8axL2ZAP1S64KpqVH8=;
        b=PIsuDaJNyrQQ7BMQOpsQJZ4ik1xEYW6YMdTL6WOBgkDX+XUOdBd8m4uwtiu4UnPaew
         uDMj7AqP3rp70/wbNTT6nctINfVfLqB2hITDVMWZ7HtIsU+CrASMJ50iws8/oOwkzkbL
         vC+wP/Mon6SYBtRyA1JIm8hESnEhXQOdzKk1dHpcBWbhQYKn1qtavG8L0SqqFWjqFjhS
         GhCYAGh90b/dTR/QWGvwPTOc3KK9ZAUgaQwYt5+C4GX6qp14TxjIKz58EiPxkecYwIai
         eN4iDFuyZhzdr2upSFGh7B1nK/3r7XTAPD7L+iWfMKN4KVKaezt2rLLbK0eYnECuVQ4t
         oTtg==
X-Gm-Message-State: AOJu0Yxfve7sLTrDZote97DrOaoKHPNbuoKHC3XBLYCvg1aPaPZwDs1A
	pU/7W2LKJujNPEEjlSOYegzwyT9UIm7W2Mvb35+BZG6ZNVuKJq65
X-Google-Smtp-Source: AGHT+IGMSnNo+Sz0uF1Ru9QahcFsaMXfRCx2ZNRm4Jyda45CncD4M23vnUIocWkk7Tc1TuIGI/iO3Q==
X-Received: by 2002:a05:6a20:6a2c:b0:1c2:8bf8:e7ab with SMTP id adf61e73a8af0-1c3ee491fb1mr937820637.9.1721067792305;
        Mon, 15 Jul 2024 11:23:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca7a7bsm4678628b3a.152.2024.07.15.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 11:23:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 15 Jul 2024 08:23:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] workqueue: Remove unneeded lockdep_assert_cpus_held()
Message-ID: <ZpVpDqhO8B8_iKL5@slm.duckdns.org>
References: <20240715172931.2260-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715172931.2260-1-jiangshanlai@gmail.com>

Hello,

On Tue, Jul 16, 2024 at 01:29:31AM +0800, Lai Jiangshan wrote:
> @@ -6906,7 +6898,6 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
>  	if (affn == WQ_AFFN_DFL)
>  		return -EINVAL;
>  
> -	cpus_read_lock();
>  	mutex_lock(&wq_pool_mutex);
>  
>  	wq_affn_dfl = affn;
> @@ -6917,7 +6908,6 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
>  	}
>  
>  	mutex_unlock(&wq_pool_mutex);
> -	cpus_read_unlock();

This part isn't explained in the patch description. Can you separate it out
to a separate patch or add description in this patch?

Thanks.

-- 
tejun

