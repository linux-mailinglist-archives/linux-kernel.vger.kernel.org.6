Return-Path: <linux-kernel+bounces-400829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD79C12EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B03F1F2308C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7AF1FB4;
	Fri,  8 Nov 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwIHnxL2"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464518D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024836; cv=none; b=RwH3U5IG5eIVbXn3RaYsH5mWb488bXhzlziq7A+i2DAMjVoek9BjLTJ4g7oIzx3zgYeq7x3OFETGq082Mv1YKbtCXlwVyyfhyo1tbUmzN7KEuyJGWN9UZ9Q7YqabhoPn7w9OPdkyOgPVVm1oL39TZ8yKjv5crEFmmrpFY5HT1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024836; c=relaxed/simple;
	bh=NOMCMry9fM7muBAW3IdfEmyNmvqPVzwg+MGT8mPmCek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6oT28Czz1RD76P//pNPp3CPiH8JmHoCts9qleRs1yP5lfLMk+2u7fYRpNU0DUiSubYkc2XdChtOqnw6FJb2ctYIoM8NhphnWmt3W7VwrCC4fDVUlLMwnwqs4MKtx/xzb7PDncGeGKoh9xmXVQHL1/EQT1vNPd3BOQF94FHD9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwIHnxL2; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso61125ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731024834; x=1731629634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WArJZsg1N6vAqQam1Ti66Bn4ToK/NY0ZHWyQAcoQtDM=;
        b=gwIHnxL2e8wtRfo3a/fp+83Ix0jNvz88tfq2SObkEnYfxLJ3D3bxezTli4HYvw9mH5
         1F/uXzM4BAD7asY61+5B+etD+UJa98QMzMatwtBQLrH/UmThber6BhxO/IK3qxrkcV/Q
         RKs+TgC5L8eOK+7K2k2tJIk/d0ZtnZGNv23F/F9FNOQGob4VdbTb575BIDJRFBf2q7HZ
         ca9kOikYTZH7VizVQ2myydvgHwTYcDa+JbkhlBHXq6aWD/rMRkJmG6+DCwUl0gzqUC98
         vJuQRaR6BcQupTEGEvWNg0LJdYN2fUvQ2C7+FpTqyx5tglXX/w9uGIE864yGe/vuLZvD
         Pjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731024834; x=1731629634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WArJZsg1N6vAqQam1Ti66Bn4ToK/NY0ZHWyQAcoQtDM=;
        b=alDesJlliOqRbFQ/tj638aDCqVFCEOkxaT/fqgNJEczkSABQiV8AmXH1MwzN8y3eJx
         ZFS2lE979rrdap1L5DLhi+Qfl/uJbciw8Fy3UvqHUjVGVK1D0tbM93vBbVbDBqWassn/
         vfuJf20VHPMHNBkfsbmFMoI/iUEThZHgyBu64RPJzW1ikEeSZ+3XSUgnkam+X1iZTaVJ
         b172AbxXmufNxLNAa3l8vpyIuoc0GDcplBzfI4RstEmeqqCPlrKHzngdEOndpCsjXMx3
         w/Vc59rFwmmTHtPE0YLOADL67UGpll3OMI6I+QMQz35Dq7G+7Ddn14BSGi/aW3E6wuBG
         qrtw==
X-Forwarded-Encrypted: i=1; AJvYcCWg4kAGXWS35bx80xc2bypsiV3AxrqAVM4j4dj5VzYnFyvhipgAjJgbAnSsTQsSmhRUuEWKuCXD9L5dqjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEabO4mFThWoJVYAYjR6wxQLOLHmjz1oYsDLOilL2g/wS/VlB9
	ykPE7HwQHdqtIsykP8XfgQVQnALtvjBjd/SHjre4EoxyNmDnerq5BCLDa7r4uA==
X-Gm-Gg: ASbGnctUDRDw2dJscjuRiCaz3m/yB5AkQ4JIrWSDI2fy3KQa8fs7YJzYHD8h9B3nLix
	NtbSNLGnTkvIZ839JoD5bg2Brp00kXYNcbwUwoUqJoB7SIE6Wa1n8pjJpSlR59gDe01FvMENDdx
	vNDrZrENlxNwlo+t+N14oUTXRYodj5l680S3qvzYnpa3SL257fALnnKwVgnEEgWTu+d4epNuMTb
	+IA3u/L/EaapTXBy+mFJHGXCZwIZZv3HaoFT09e2NMh6+mLQJ+PgTvsDf2mSWIfjuo+gKhM1U48
	cF8XOgR5N+qL
X-Google-Smtp-Source: AGHT+IFli50z58Q8piVHDbT4N8joEA65iTon5BhGcKUq3FKRg2ka27CwgBMtgshOVs+Nbm7aTn91gg==
X-Received: by 2002:a05:6e02:12ea:b0:3a0:8cb6:3ad1 with SMTP id e9e14a558f8ab-3a6e7a62020mr8287555ab.20.1731024834208;
        Thu, 07 Nov 2024 16:13:54 -0800 (PST)
Received: from google.com (98.144.168.34.bc.googleusercontent.com. [34.168.144.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm4664987a91.35.2024.11.07.16.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:13:53 -0800 (PST)
Date: Fri, 8 Nov 2024 00:13:50 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: dev: Fix memory leak when underlying adapter does
 not support I2C
Message-ID: <Zy1Xvk9YKrjqc4S7@google.com>
References: <20241107014827.3962940-1-ipylypiv@google.com>
 <jc76qean5mqxba4nh5qdocxhl5aa7r4epryyviqkyktbu6grog@u43wzsaki23k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jc76qean5mqxba4nh5qdocxhl5aa7r4epryyviqkyktbu6grog@u43wzsaki23k>

On Thu, Nov 07, 2024 at 06:14:29PM +0100, Andi Shyti wrote:
> Hi Igor,
> 
> that's a good catch, but...
> 
> On Thu, Nov 07, 2024 at 01:48:27AM +0000, Igor Pylypiv wrote:
> > i2cdev_ioctl_rdwr() receives a buffer which is allocated by the caller.
> 
> This needs to be a bit re-written. In the commit log you should
> describe what the patch does. You are telling where the buffer is
> allocated.

I thought subject line covered what the patch does. Ack. I'll update
the commit message in v2.

> 
> > Fixes: 97ca843f6ad3 ("i2c: dev: Check for I2C_FUNC_I2C before calling i2c_transfer")
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/i2c/i2c-dev.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> > index 61f7c4003d2f..5d15519ef737 100644
> > --- a/drivers/i2c/i2c-dev.c
> > +++ b/drivers/i2c/i2c-dev.c
> > @@ -247,8 +247,10 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
> >  	int i, res;
> >  
> >  	/* Adapter must support I2C transfers */
> > -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > +		kfree(msgs);
> >  		return -EOPNOTSUPP;
> 
> Please, don't free it here, free it where it has been allocated,
> i.e. in compat_i2cdev_ioctl().
>

Sounds good. I'll move kfree() in v2.

Thanks,
Igor
 
> Andi
> 
> > +	}
> >  
> >  	data_ptrs = kmalloc_array(nmsgs, sizeof(u8 __user *), GFP_KERNEL);
> >  	if (data_ptrs == NULL) {
> > -- 
> > 2.47.0.277.g8800431eea-goog
> > 

