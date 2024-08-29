Return-Path: <linux-kernel+bounces-306764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48528964337
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03107286A44
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09CA1922EA;
	Thu, 29 Aug 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dCMAb7hQ"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD2191F97
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931473; cv=none; b=bzdzeZvXTUAhSv45mFmEpSoScraIUkHO5SaPZvqVJ9d2pe/xSyv0IObAcKcJznQd9g/CYTtiFk4EBo3f0kuf2VFC5PqRX3AXcOJRsw7K4lCxVrHkw9I0fS4l8uyHQrUEym1YnIjRG58u1VGscGANpet0Yilwhx84llro5LsA9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931473; c=relaxed/simple;
	bh=cNzbsA+TbK++Ak183JvAbBvIZCIt69jGcDVpJSPxpEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adr4ygL/zLnX7PwK2iczxEdPYVEv67uEre7Dh/VY27M6zOuw1zC4sXV9uuEHKXZVBkUa98J73sDCnLa38uiwSKRFYJqfrte7hPZCRFuyDKKMNWmMpla1g8UqeLFwBpTJDYx8I0f1QlJMvx8H857dxPuVjrgm70r9wBvY0VUp1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dCMAb7hQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso388397a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724931469; x=1725536269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uwnGCH/YIzPLaHUb/2waUJ87bIA5++OGLa9jaJO7I8=;
        b=dCMAb7hQ5kGZLBBW5BJup3+L4zEz2hiCjVacfHWmJslYHpeGLp6nhbOsgHFm5Ak6u+
         Mp03g30F8H/uHSXuXLvQmzt+lkrro6xkFE6VnFXg6/I2/5g2qjJ15r9o0PxDdAfJpZpB
         OyM0Lk02J22rA4+EMfALbLXmjLaNKNKZjSIzMm1B997Txf1SpqmAGj4w95NR8HcWhyM5
         6q9Y0vV+pSA8kfVRXe07KNo1aDHHtPfowVkvCqUjEmWuXukMkgtRRKTmLvcGRoCWu17i
         NstFa8aniz3kpZHUDEjgXizqbYSBHARPFCyt2hn6u3WDXL+hFhsxXd8RbRVdyp/dxNop
         esqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931469; x=1725536269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uwnGCH/YIzPLaHUb/2waUJ87bIA5++OGLa9jaJO7I8=;
        b=GvHgdE0XP8CAOvQ8F6GAGm4Ed5ggYRh03gfPLFONvLolQWqpUEWV9H28KLsJL7+mty
         3U3cXcoI5bfZzsVPhUK35JpiGnsGsyc8p/SGM3WXwpvmr2gDLeTaw8sileK6meKlp4k0
         e0XWP0DgoSQvXblyiwj7de/H4bQZXnd8iy6rHeTz6VBJx1bqIJfZFPmbXVluuONFVaO6
         07z49YNQk7ok4fNM9lBQuMErCVPT/un6BeCbdIT1W604koic4LVVyWfEA+cMrGxjg/T5
         vzf4UCdaw+T5ZzpAf5yoO60wjyBvfL2nWNtxcn3lFCJ3DOM2ir5gQd7Z/QIkW+j+vpby
         juTw==
X-Forwarded-Encrypted: i=1; AJvYcCWnXmucFbFtPFVf+4V7DGHCGRH89DmEuMnZ1tKmBJRwA+GcXE8rgL9ZdgNpm/uMGao44IzchzocUeHp9Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWePYue6sLYSVrP5GBC49MwxhejTrR521oDZS4hvn0IZaeOkw
	d9nftzGRRp+ylQPZc2Ht0Ku/GIrXJEUyv2jN7qhzh/iAs6rUgWBJpHkbnHN2OmU=
X-Google-Smtp-Source: AGHT+IFCzL8y6Y0fPNCJTLQKLePeR4IrAq+Gu1W+X4VnQGS0d3COJICgpMgUCJOuCGUPlJhD/q5ZmQ==
X-Received: by 2002:a17:903:40c6:b0:202:35a8:42 with SMTP id d9443c01a7336-2050c46ca2bmr26184035ad.49.1724931468980;
        Thu, 29 Aug 2024 04:37:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152d6a82sm9666505ad.73.2024.08.29.04.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 04:37:48 -0700 (PDT)
Message-ID: <e5e97bad-075a-4d78-af78-3bbc124c06b1@kernel.dk>
Date: Thu, 29 Aug 2024 05:37:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] bdev: add support for CPU latency PM QoS tuning
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
 <20240829075423.1345042-2-tero.kristo@linux.intel.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240829075423.1345042-2-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/24 1:18 AM, Tero Kristo wrote:
> diff --git a/block/bio.c b/block/bio.c
> index e9e809a63c59..6c46d75345d7 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -282,6 +282,8 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>  	bio->bi_max_vecs = max_vecs;
>  	bio->bi_io_vec = table;
>  	bio->bi_pool = NULL;
> +
> +	bdev_update_cpu_latency_pm_qos(bio->bi_bdev);
>  }
>  EXPORT_SYMBOL(bio_init);

This is entirely the wrong place to do this, presumably it should be
done at IO dispatch time, not when something initializes a bio.

And also feels like entirely the wrong way to go about this, adding
overhead to potentially each IO dispatch, of which there can be millions
per second.

-- 
Jens Axboe


