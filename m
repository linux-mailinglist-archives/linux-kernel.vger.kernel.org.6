Return-Path: <linux-kernel+bounces-218721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B1B90C463
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB4F1F21EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634B13F459;
	Tue, 18 Jun 2024 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1Q0JQoS"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D94613F426
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694061; cv=none; b=HZbKc1tZmJ7TZrB+pjIA83KdqcN+dyQNH9Php0ZXNRZuH43wdPcCyKFrxy3/qspVYToakfhvn9C7dkFPWnRqbHRAsOV8aasa8byQjtvc/Yo1swUlSE94nlaIH0cT51uZ2aMZSnUE+ywIGtbUcy5oNu/wiOS3VEi4tpYDE7ke+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694061; c=relaxed/simple;
	bh=bygB13U/fPkTwSJhv17fEws+pWQHglyY/Xsdrm7v/+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYBIwSXBfzkfpc5NOwzCfJ8O2XsV3SuDlbsvlJyziWCILEWI0c7bujCYroeFINCGz7DOdiz9PA4xtvrPUtJ/9M/7BqUdu+mfQyt7nGzf1ZM60Xxy3/7y1JwpTZ6N3dwyX3EV25+4kGLNeI+7jc6ZDZe9xPGJxGCVFJNStRg2yno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1Q0JQoS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354b722fe81so4610738f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718694058; x=1719298858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0a5p1bD0AyssKGKB5WnIImRaJI9ITejqF9cQEG0YuY=;
        b=J1Q0JQoS4iJ1v/ozqpomg5/bsAU1zXtxV0sRI8h/AN7TmLBUNL0CDiL9iAQpOB2woJ
         b48GHcEvQ4zz0ZldQ/d5PHw09OOJuluH/qS7k8yYyMk0PwZOaCZyxaQOADpFG57Gc64w
         2aofrOki5kzfoyN822AGWWaTySQpP+12uB+MaGOKR8125OHtLT7jbDIbxLH9T+MzfArZ
         JUSdmeWWzM5MIROmEVMt8WffWW6GzMsQ1q1qdYwpRms7Oy++72s+L8+amXLwsq8Ao3eY
         G9HuGN2/HihoBL8wtN60dZnf6YEbOxxd/LtXzEC2f3KMVPCPKSE/7Xb8vbgSP/hsVdij
         0zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718694058; x=1719298858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0a5p1bD0AyssKGKB5WnIImRaJI9ITejqF9cQEG0YuY=;
        b=pvxthKLCH7sQJpn+o6u+Y9ot3hfph36CYI7idUXmm09bUZfnH6isaL8Fv5tEaXFW3C
         EM+DP7AjB3BOygrO1bwzazOzQVcwQzwQR68IOk4cHf/oaik3kQwjWNoBSJOLTZvUuiTW
         WqpH179f7Yuf67E9d3fGh3zwDYgmLm7Rk0LJeI3CzYofYGvTLeTIo0oUkL1vT5hHIFJu
         7YJgWos8gMmK7gdlN/i1vcPvIdNu0uka9kSUJ3a4YfT8LmVpckADNmRKYE5v70W1gR0U
         +a1fcogEIb+NpMmKE0BpxFT357zrtjRRHLItu9GeQ51v7V0coTz1UZFHW1KmyVyrI9Dd
         4UTA==
X-Forwarded-Encrypted: i=1; AJvYcCXJTdIuuSbzwzR/ugcFxZOyNMc0jgrI3a5InoR3xq+X24Jylj2odD0swH9hnyIuywLIj7FCRli9n0oyZhWpbhLpD9j9oqbCFh5jCQsl
X-Gm-Message-State: AOJu0Yxvdptw3O/bNA1HPPzD5jFprp+MqAORF5hSbwijwU+YJMpS9Bcd
	w4l3W+cpSi7eCx6R9PYYdP6r+omCHonv2dtK5lOBlSW6n++DTfmGjmqEBlA0ysM=
X-Google-Smtp-Source: AGHT+IENTRuaf3ngXVONzPwSYh1oRVgwzc4UC8HbyWW/rviR2sWOLdMBJeB9XSWba9XZVCRXPH2cZQ==
X-Received: by 2002:a05:6000:87:b0:361:bd3f:f89b with SMTP id ffacd0b85a97d-361bd3ff946mr527425f8f.50.1718694028568;
        Tue, 18 Jun 2024 00:00:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36077536f78sm13307498f8f.7.2024.06.18.00.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:00:27 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:00:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Karol Herbst <kherbst@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Use kmemdup_array() instead of kmemdup()
Message-ID: <ba70e0f2-c957-4235-aa51-b1a8c86034b6@moroto.mountain>
References: <a3e8cecc-77dd-4a4a-bb12-c1d6759d3efb@moroto.mountain>
 <a61d9781-7c6e-46b8-ab1b-cf4fc1c76ba3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61d9781-7c6e-46b8-ab1b-cf4fc1c76ba3@redhat.com>

On Mon, Jun 17, 2024 at 05:55:33PM +0200, Danilo Krummrich wrote:
> On 6/17/24 11:33, Dan Carpenter wrote:
> > Use kmemdup_array() because we're allocating an array.
> > 
> > The main difference between kmemdup() and kmemdup_array() is that the
> > kmemdup_array() function has integer overflow checking built it.  The
> > "args->in_sync.count" variable is a u32 so integer overflows would only
> > be a concern on 32bit systems.  Fortunately, however, the u_memcpya()
> > function has integer overflow checking which means that it is not an
> > issue.
> > 
> > Still using kmemdup_array() is more appropriate and makes auditing the
> > code easier.
> 
> Indeed, we shouldn't rely on the previous check here, good catch.
> 
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   drivers/gpu/drm/nouveau/nouveau_sched.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
> > index 32fa2e273965..53d8b0584a56 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_sched.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
> > @@ -45,10 +45,10 @@ nouveau_job_init(struct nouveau_job *job,
> >   		if (job->sync)
> >   			return -EINVAL;
> > -		job->in_sync.data = kmemdup(args->in_sync.s,
> > -					 sizeof(*args->in_sync.s) *
> > -					 args->in_sync.count,
> > -					 GFP_KERNEL);
> > +		job->in_sync.data = kmemdup_array(args->in_sync.s,
> > +					args->in_sync.count,
> > +					sizeof(*args->in_sync.s),
> > +					GFP_KERNEL);
> >   		if (!job->in_sync.data)
> >   			return -ENOMEM;
> 
> Not sure if this is what we want for kmemdup_array(). It just saturates the
> size. This doesn't prevent accessing the array out of bounds later on. I mean,
> it's rather unlikely to get such a huge amount of physically contiguous memory
> anyways, but wouldn't it be cleaner to let kmemdup_array() return
> ERR_PTR(-EOVERFLOW) on overflow, just like memdup_array_user()[1]?
> 
> AFAICS, there's just two users of kmemdup_array(), hence it should be an easy
> change. :-)
> 
> [1] https://elixir.bootlin.com/linux/latest/source/include/linux/string.h#L30
> 

We can't change the return values.

kmemdup_array() has to match kmemdup().  <-- returns NULL
memdup_array_user() has to match memdup_user().  <-- returns error pointer

regards,
dan carpenter


