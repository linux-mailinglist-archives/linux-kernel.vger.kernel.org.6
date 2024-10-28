Return-Path: <linux-kernel+bounces-386025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3786B9B3E47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4931C22095
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2271F76B2;
	Mon, 28 Oct 2024 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxpyGVe8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771918C02D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156456; cv=none; b=g5aVped67MOX+k8T04Cns0FL2w/MzcNWucKmTZ4jOc9A5uDLWew2JS2bkIvP0ibwgaXjlXPf10W09bdhVtzVdyIDj86NVLuiPM2x8y1ixOsKehejLtH230kv4GEHB3e6bF56hYGCzV2URls9l9w+b6MdAYuPJrYXowvWZ6d38R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156456; c=relaxed/simple;
	bh=pvsYqFnCG+hOE26m9YhNNqKJGnCofp4oo9NVw1Ivhb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3FJPgPnfDpvF+5zDOKd/YUw51SeSnw4dTf/homsZ8w7KDkXWr2tIIoOONahkPqmSJZgRsNOJ7t9higYF/QVRD8MSDJquq9rrQhCsfmV9mosIx/YeyXthR1mH+NR1JlGytz69phhZdvjyif6tZ8jIQZbD76s6vorXAkwEq2Tg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxpyGVe8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730156452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRxJgB3YgSnw1yTqaH+7yOrW0eKlxXbG1X2H8gPR5g0=;
	b=NxpyGVe8YkLoDOibWb+jhSdfuw7n9ZRAOr9lk/7vygQfalzsls6tS9XQNrbH3FdzefI3Bc
	qjApWAKrU2VDtCdez0KW2Q333ZP8cf392ZryF9D2cj4kegTMRjUn+ERxweRXsVJXf5Mqbc
	p1iSsKMuMoM2Dq9KSBglN4/cHoLu9U4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Jl8aBhEnM7q5YcUG_UtTWg-1; Mon, 28 Oct 2024 19:00:42 -0400
X-MC-Unique: Jl8aBhEnM7q5YcUG_UtTWg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbceb26182so78978966d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730156442; x=1730761242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRxJgB3YgSnw1yTqaH+7yOrW0eKlxXbG1X2H8gPR5g0=;
        b=qSxOi2LMtSraHNJ5gib8smo9OZtYulNutcJlmrdYA15KeYFg9ObBF5yo5pPbztwu+n
         ZaJK7gkyPOfVLEGbTogypYwrkKgcNPDyczGV8EQyn9fnYOweDFqj6bYy/3i2+QIx79vm
         YiRaFKgXz0/tCgY+DmIVP87LmYV/VXP3RQpBEE1Xy6TaqLFoeGmipweLsCj0otynV5Oo
         0m8kY0czoQZXkFXsfwKjAKNwnT1bNKOoZ+/9q6JNn1WCp2XG2vPg7a+3fkUXWPPMLsIH
         MafXnAjW6Lx+xUrtVdz4XLX3fbj3ehyWeO0dm+cnqsoUn64Zlz1qTMp+kCK4/q/5l3SJ
         xPGw==
X-Forwarded-Encrypted: i=1; AJvYcCVIWUv+vMjNQQ4sHHY2iGjLBVk7nfIRTriyycui8xPJwxfa94XF1flmZkC30+q9W8qe3HQ8JCq9Cs5Gtc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywva68ZIKp82x4sdW2WEsgSJ3ez3mplru7H2UH1Hla5yJOOkPir
	NAuraPdcIWzp/Qle4prq567sJqhA3LAbDGDRGefhb+7cQIzRZraqgeRfTGw7gLUErqTDrdp2xe2
	aKcgMcqwx421Zu/XXci7m6f/OlRZrJB7Hr+xFSg6SFNRvvq/ZEcHM3Dh+E83xwWbyJUM7wqH8
X-Received: by 2002:a05:6214:498c:b0:6cd:f6de:8ad2 with SMTP id 6a1803df08f44-6d18585e41amr177057776d6.45.1730156441973;
        Mon, 28 Oct 2024 16:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcjYmJlGC5rsL/bxk9haeN8uptv3mv86VmY+o/GSBPiJW8iqGYHl6BkHsr0flDiyYo77g/1g==
X-Received: by 2002:a05:6214:498c:b0:6cd:f6de:8ad2 with SMTP id 6a1803df08f44-6d18585e41amr177057486d6.45.1730156441631;
        Mon, 28 Oct 2024 16:00:41 -0700 (PDT)
Received: from [192.168.1.165] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2b533sm36964306d6.116.2024.10.28.16.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 16:00:41 -0700 (PDT)
Message-ID: <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
Date: Mon, 28 Oct 2024 19:00:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn:
 inconsistent returns '&pool->lock'.
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 Mike Snitzer <snitzer@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This should be addressed upstream by commit 
872564c501b72ae0c84af51084753e8652e4a84b ("dm vdo data-vio: silence 
sparse warnings about locking context imbalances")

That commit is from February. Would it be possible for these checks to 
use a more up-to-date version of the code before warning us about things 
that have already been addressed?

Matt

On 10/21/24 3:19 AM, Dan Carpenter wrote:
> Hi Mike,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3d5ad2d4eca337e80f38df77de89614aa5aaceb9
> commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
> config: x86_64-randconfig-161-20241019 (https://download.01.org/0day-ci/archive/20241019/202410191209.osrd8z9H-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410191209.osrd8z9H-lkp@intel.com/
> 
> smatch warnings:
> drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn: inconsistent returns '&pool->lock'.
> 
> vim +976 drivers/md/dm-vdo/data-vio.c
> 
> 79535a7881c0cb Matthew Sakai 2023-11-16  958  void vdo_launch_bio(struct data_vio_pool *pool, struct bio *bio)
> 79535a7881c0cb Matthew Sakai 2023-11-16  959  {
> 79535a7881c0cb Matthew Sakai 2023-11-16  960  	struct data_vio *data_vio;
> 79535a7881c0cb Matthew Sakai 2023-11-16  961
> 79535a7881c0cb Matthew Sakai 2023-11-16  962  	ASSERT_LOG_ONLY(!vdo_is_state_quiescent(&pool->state),
> 79535a7881c0cb Matthew Sakai 2023-11-16  963  			"data_vio_pool not quiescent on acquire");
> 79535a7881c0cb Matthew Sakai 2023-11-16  964
> 79535a7881c0cb Matthew Sakai 2023-11-16  965  	bio->bi_private = (void *) jiffies;
> 79535a7881c0cb Matthew Sakai 2023-11-16  966  	spin_lock(&pool->lock);
> 79535a7881c0cb Matthew Sakai 2023-11-16  967  	if ((bio_op(bio) == REQ_OP_DISCARD) &&
> 79535a7881c0cb Matthew Sakai 2023-11-16  968  	    !acquire_permit(&pool->discard_limiter, bio))
> 79535a7881c0cb Matthew Sakai 2023-11-16  969  		return;
>                                                          ^^^^^^
> 
> 79535a7881c0cb Matthew Sakai 2023-11-16  970
> 79535a7881c0cb Matthew Sakai 2023-11-16  971  	if (!acquire_permit(&pool->limiter, bio))
> 79535a7881c0cb Matthew Sakai 2023-11-16  972  		return;
>                                                          ^^^^^^
> Still holding pool->lock on these paths.
> 
> 79535a7881c0cb Matthew Sakai 2023-11-16  973
> 79535a7881c0cb Matthew Sakai 2023-11-16  974  	data_vio = get_available_data_vio(pool);
> 79535a7881c0cb Matthew Sakai 2023-11-16  975  	spin_unlock(&pool->lock);
> 79535a7881c0cb Matthew Sakai 2023-11-16 @976  	launch_bio(pool->completion.vdo, data_vio, bio);
> 79535a7881c0cb Matthew Sakai 2023-11-16  977  }
> 79535a7881c0cb Matthew Sakai 2023-11-16  978
> 


