Return-Path: <linux-kernel+bounces-349134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED0E98F17C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB30B228EC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451C19F13C;
	Thu,  3 Oct 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjHBq23T"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FFB1E515
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965924; cv=none; b=XBwS8QBK9TOmZwt+6hE14d+1kVj+Kg9FHP574GmOCCZb14a5J9qVkQJbNhariP2sbLePiWBIOTKy3H11IO6YI8SmKjn43Oo6eHSSuMrkNY33KqfwRWz/Zciz4hhaLQvEGned8RnNAsyFmKxxp6vz0nNgW3pqBedUJ/w53+C7QR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965924; c=relaxed/simple;
	bh=KT4wxf5eAijH7GEBqTLb1dsKcH58j0cYtgWI80Hfo98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ynz3gDSMZxqhKgnoGB88HO7fvK5WS28vRWacIAcSmIXhfgjYWIFRFV5kbQi9/6BzwyAjiLjy4fi2JOK5jFKETTsXAptiXoBCVtjqXJbFKLnoDnlvwAGHSuJ5CXiUrSDvcAdvpiBsiF4qLMNvhuCq//9jV0UoXW88Ek6U1Jj96JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjHBq23T; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so8683065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727965921; x=1728570721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RVajOVWsOfO8XEUrv4orE56kvY5Og/6yTj5Q+VfXTA=;
        b=bjHBq23T/Eo5B4IAFAZ1B8sgVoBfT8ov8WAe1ImKSMTpcryoIfPC0Pb+jVqkul9xvv
         4ONw8PzNTz7vGA6nz3mRowSE/FZdP+pM/p0dVy91p2Ienvs8u26s01cbPd7ZjYXYWzdA
         s0dY/Wjt1Kkl+C7+uSlbgNMdznLqP8s/67vvi5YPZT0Ce4SogCR8r5ca8JPkbxrbBzAe
         wfns1EpWfI/M1eHFH1GgpxMM5cSjM1yIPsvmoWzwuu6qsst30qXi7EBEVnsHK3Abp/CV
         h2W6ctgAVl+UWndHZmedfJZ/bp5B6AR/4MLVK4ybWaSbBL1XuAZiayoJ0CDbSfbppspl
         Yo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965921; x=1728570721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RVajOVWsOfO8XEUrv4orE56kvY5Og/6yTj5Q+VfXTA=;
        b=GkgQQFwsP8QPn/GyYF2w4FuzO+sA+20HSycphVi1aX8GtdheoWUzElduQHsriYmU6V
         m29vUnpKyMIMepmaBwozKDF+zCOcIOBhaBpLda1cqbUd4JksN91Qfo297jeqfHmtStjE
         LvXjmNgse0kxeW9SZ2tMlylklZmnrCUjybQsT+UnzqQv1/FCr9n6rNwzMGjuQna7weB2
         3bqL3eF5Bnrml6uN0Wt0ibDOTqsiW68rZotqfXeXN/tGJeqXSI0xRvv8FAIBdY6YRpsT
         I2rh1O9sv+qjRZyLqoMJH2YozrOrRxEnK4ea9cgoL3KIcG8R+idSzq6fFNnYf7SUbRSQ
         jMfA==
X-Forwarded-Encrypted: i=1; AJvYcCWIIqHkHbmfcssW/hDiD2OwBCcuJ9HrjtecUfXfI+n4bykMk6m2xAu66tSc6PKE1MbDjWnXmLZzRyNm0Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZU5+arYyJA+foVkBNosSPKSFK+OhdeLBjtKD5u/LaP/I1Q/c
	wyaERCs5Vk7kHGMYDolrop06475vNBicmlbtefDBe3JHDZYluHadneo3UA3LiJs=
X-Google-Smtp-Source: AGHT+IH13q3IC/QY1YZWkQjnVz9kQdjJo+gYRjabyv/Axphxp5+OqFLv6g4amWkLK2R4efSCLdMcbQ==
X-Received: by 2002:a05:600c:350b:b0:42c:bcc8:5877 with SMTP id 5b1f17b1804b1-42f777b8a2bmr47756745e9.13.1727965921068;
        Thu, 03 Oct 2024 07:32:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eadd04sm46070935e9.20.2024.10.03.07.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:32:00 -0700 (PDT)
Date: Thu, 3 Oct 2024 17:31:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Waiman Long <longman@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
Message-ID: <68f3e5f8-895e-416b-88cf-284a263bd954@stanley.mountain>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
 <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
 <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>

On Thu, Oct 03, 2024 at 07:21:25AM -0600, Jens Axboe wrote:
> On 10/3/24 6:03 AM, Dan Carpenter wrote:
> >   3117                                  ioc_now(iocg->ioc, &now);
> >   3118                                  weight_updated(iocg, &now);
> >   3119                                  spin_unlock(&iocg->ioc->lock);
> >   3120                          }
> >   3121                  }
> >   3122                  spin_unlock_irq(&blkcg->lock);
> >   3123  
> >   3124                  return nbytes;
> >   3125          }
> >   3126  
> >   3127          blkg_conf_init(&ctx, buf);
> >   3128  
> >   3129          ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
> >   3130          if (ret)
> >   3131                  goto err;
> >   3132  
> >   3133          iocg = blkg_to_iocg(ctx.blkg);
> >   3134  
> >   3135          if (!strncmp(ctx.body, "default", 7)) {
> >   3136                  v = 0;
> >   3137          } else {
> >   3138                  if (!sscanf(ctx.body, "%u", &v))
> >   3139                          goto einval;
> >   3140                  if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
> >   3141                          goto einval;
> >   3142          }
> >   3143  
> >   3144          spin_lock(&iocg->ioc->lock);
> > 
> > But why is this not spin_lock_irq()?  I haven't analyzed this so maybe it's
> > fine.
> 
> That's a bug.
> 

I could obviously write this patch but I feel stupid writing the commit message.
My level of understanding is Monkey See Monkey do.  Could you take care of this?

So somewhere we're taking a lock in the IRQ handler and this can lead to a
deadlock? I thought this would have been caught by lockdep?

regards,
dan carpenter

