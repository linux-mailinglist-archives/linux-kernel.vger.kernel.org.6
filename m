Return-Path: <linux-kernel+bounces-386419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6495F9B433B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222921F23422
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D8202F60;
	Tue, 29 Oct 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CeXSmqJY"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A53202654
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187495; cv=none; b=XumxqGU5nhdaTRp6ulI7Yb6kg1YyTJfZU4f1zZ3gs6qTyOWEkZovVr6ySjSEGMHczD6GVk31CxYu5y0MeansmI0+QIQ3I/FYDdwnzRTtCNHt9ZHyiWvW2GZAPnFmUAh2QeM7WBFMYz1UsS0B23OpuRIeaWm2tajF4iRFx4D0dbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187495; c=relaxed/simple;
	bh=8tO57yzbepSW3GqmEVB8NsDZtxXUlFlQ/nEWfs4Fl4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI1gE8PSga4Di9hMZppzKcQP0KYmLAswKLBkMd0XVkhkTEuvWEbZwJ8v9HbWfIOBvs9ADQAdTdkNQ37yREeapjRUE/FX7X80f5XuvSc39ulvGSEuYglLLEw/o3IVyyxgVAjzdvhrKNeBKYA/J4APHCKoUAaE92WUPr7kSZ0QI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CeXSmqJY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c94861ee25so2919591a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730187492; x=1730792292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cV9yDfIVAjckEzAdmwXTwTo2IzjdqwOl2D1fRgidvv4=;
        b=CeXSmqJYbvBN2vL61cqtCpE8CZoWECMEUlI6jDZzYj+Mnd1PSFQrPm5PymwNwl7A1M
         xpsDmC2zVYkbcKsAelixb4K4Mqn/YrWPyZTY3W/Lvzg4PuI2JUXLCHRZwisdetFmdPAb
         uQCJ8bXrmzXMLA54/dUp46oyy1SETCu5OXsM7s6tsvb1kEr5W/G+DYSy1NDD4sfPesNV
         hHO6ssxXlv0BvaMnW+k0E3/jPWl/NLIXSKaDwftO+T7jPdw+KFiy/RFxtRT+qKVvpCwq
         EkgI7uG+TW0tGVsx2xf/veynd3et+nARAC1vJIdUP4CCyUuVeuFL42clEvRaHPljV4OH
         S4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187492; x=1730792292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV9yDfIVAjckEzAdmwXTwTo2IzjdqwOl2D1fRgidvv4=;
        b=tYTQ9gF4+iKYKnrKwWVKJtOu/uKEfIlV+XXWCyPoEm2I/tjpVk/N3qElsAxtNUqYJP
         lEBzCmeOSKoIdOQUGeEX9xgdRqf4se5cLvDy2xqQZvZg/l2QaKk02qScJXN+R0AhOiwN
         kn78lY1xu08jdWCO5qvGd0g811l77CKRigbTLmG8EfBzlumnwbWpm6jMYnsndpY8sK7Y
         1rqNi8f5DNDCkKj0VZMTHJqTZ4Dsb93/7jNqWsb2rhmLLARwVI7+kvtoWJoxsVSW0pi3
         G9DvFYPC6EUll0l9vEgcP7fKM9W+z/ZQRDx0ejw4JMefMYuPW+ryuUjJJuzNs+ImF5sM
         xQbg==
X-Forwarded-Encrypted: i=1; AJvYcCVvd9meL+GftCG7Z5dihHOctEih1xSOcXXYriUOqBGC1cOIRnZINdkqQTf9MxOykiXBZqKkcmVEz2Lt1c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPm0y+6fEVgBgV1U6C6SIg6bUIndWAm7vxC69ZvrbaewYxB17W
	gSWxzaISNs0TOLsAcZSWX9HhhGRyYGd56Cul/Xwz1frZ4HVtUnSTTUCeqMcxKTk=
X-Google-Smtp-Source: AGHT+IF47bz1F7DhgPoiWr+IviDyyt9/wcQ7nPRiMlBiRDx7vWXP2gLN6e2f8LT8h/R+Iygma5dhDg==
X-Received: by 2002:a05:6402:1e93:b0:5c9:40f5:1518 with SMTP id 4fb4d7f45d1cf-5cbbfafd4d9mr12319081a12.35.1730187491686;
        Tue, 29 Oct 2024 00:38:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c14c4sm3706291a12.44.2024.10.29.00.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:38:11 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:38:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Sakai <msakai@redhat.com>, oe-kbuild@lists.linux.dev,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev
Cc: Mike Snitzer <snitzer@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn:
 inconsistent returns '&pool->lock'.
Message-ID: <fb2df01d-07d5-482b-af6c-1ff53129f7c4@stanley.mountain>
References: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
 <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>

On Mon, Oct 28, 2024 at 07:00:40PM -0400, Matthew Sakai wrote:
> This should be addressed upstream by commit
> 872564c501b72ae0c84af51084753e8652e4a84b ("dm vdo data-vio: silence sparse
> warnings about locking context imbalances")
> 
> That commit is from February. Would it be possible for these checks to use a
> more up-to-date version of the code before warning us about things that have
> already been addressed?
> 

Sorry, these emails are auto generated by kbuild.  I don't get a lot of
context outside of what's in the email so I didn't realize it had already
been fixed. 

I looked at today's linux-next and that doesn't trigger the warning any more.

regards,
dan carpenter

> Matt
> 
> On 10/21/24 3:19 AM, Dan Carpenter wrote:
> > Hi Mike,
> > 
> > First bad commit (maybe != root cause):
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3d5ad2d4eca337e80f38df77de89614aa5aaceb9
> > commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
> > config: x86_64-randconfig-161-20241019 (https://download.01.org/0day-ci/archive/20241019/202410191209.osrd8z9H-lkp@intel.com/config)
> > compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202410191209.osrd8z9H-lkp@intel.com/
> > 
> > smatch warnings:
> > drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn: inconsistent returns '&pool->lock'.
> > 
> > vim +976 drivers/md/dm-vdo/data-vio.c
> > 
> > 79535a7881c0cb Matthew Sakai 2023-11-16  958  void vdo_launch_bio(struct data_vio_pool *pool, struct bio *bio)
> > 79535a7881c0cb Matthew Sakai 2023-11-16  959  {
> > 79535a7881c0cb Matthew Sakai 2023-11-16  960  	struct data_vio *data_vio;
> > 79535a7881c0cb Matthew Sakai 2023-11-16  961
> > 79535a7881c0cb Matthew Sakai 2023-11-16  962  	ASSERT_LOG_ONLY(!vdo_is_state_quiescent(&pool->state),
> > 79535a7881c0cb Matthew Sakai 2023-11-16  963  			"data_vio_pool not quiescent on acquire");
> > 79535a7881c0cb Matthew Sakai 2023-11-16  964
> > 79535a7881c0cb Matthew Sakai 2023-11-16  965  	bio->bi_private = (void *) jiffies;
> > 79535a7881c0cb Matthew Sakai 2023-11-16  966  	spin_lock(&pool->lock);
> > 79535a7881c0cb Matthew Sakai 2023-11-16  967  	if ((bio_op(bio) == REQ_OP_DISCARD) &&
> > 79535a7881c0cb Matthew Sakai 2023-11-16  968  	    !acquire_permit(&pool->discard_limiter, bio))
> > 79535a7881c0cb Matthew Sakai 2023-11-16  969  		return;
> >                                                          ^^^^^^
> > 
> > 79535a7881c0cb Matthew Sakai 2023-11-16  970
> > 79535a7881c0cb Matthew Sakai 2023-11-16  971  	if (!acquire_permit(&pool->limiter, bio))
> > 79535a7881c0cb Matthew Sakai 2023-11-16  972  		return;
> >                                                          ^^^^^^
> > Still holding pool->lock on these paths.
> > 
> > 79535a7881c0cb Matthew Sakai 2023-11-16  973
> > 79535a7881c0cb Matthew Sakai 2023-11-16  974  	data_vio = get_available_data_vio(pool);
> > 79535a7881c0cb Matthew Sakai 2023-11-16  975  	spin_unlock(&pool->lock);
> > 79535a7881c0cb Matthew Sakai 2023-11-16 @976  	launch_bio(pool->completion.vdo, data_vio, bio);
> > 79535a7881c0cb Matthew Sakai 2023-11-16  977  }
> > 79535a7881c0cb Matthew Sakai 2023-11-16  978
> > 

