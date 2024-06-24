Return-Path: <linux-kernel+bounces-226904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E191457E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BD4281280
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACCE84D03;
	Mon, 24 Jun 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NIlm3K+p"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB97346C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219406; cv=none; b=L2ZnOe9Vld+WRlmkMgp4E7garwN1xeKQSDAt7oT//YQNUJjIIBXaWq5mL406tz29swL0vz5zj6bB1jWFrfplplP54FzTZSRgJKdJnL8Mfl8ATKHabhTtdd9R/NIdG5uL/2RfkFmfG0mSAbe0nzN5FB6NMqdx5Ul3v/X7e5G122c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219406; c=relaxed/simple;
	bh=60jgSJ9BsP2kpjwq4csRJWDIIPPwj35/L6vDezVPoxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAD4JjYOs/MAU2sZAMr44RWbkR6U58NAO8DkgeVCgePmRb2GFaIeFrEFN7X+Rm3KnT7TmAq3eDjTxiB7gCUI33UiLqxVXFcom0+1s0NZOcqhCsWlYTl63HJo8Ew7a5xNs5FL5lQXhgggGjOEOnyqAtrqJLxIRmogJxe2J5r/o48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NIlm3K+p; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7178727da84so1602977a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719219404; x=1719824204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfhjqO2J81Ssb/Fuz1ky6uYbmEEWMBrkgz3wOJNpA9M=;
        b=NIlm3K+pzORHUe9l6BwvSACfmcVH+ETinoVmZpIIXh8GFbToUyF4UGFDERi1mg4V+O
         5Tcj4b0eSdACEvPUq7ySlnNbRUnWdKN4dRUf/mCt+oEUA1abW8aBIsdey4CdmB1vszlO
         Aa4eLADdgFZKnqAGVrFJPS7lHduO+5/9XHzIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219404; x=1719824204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfhjqO2J81Ssb/Fuz1ky6uYbmEEWMBrkgz3wOJNpA9M=;
        b=loXRo7h/zm8b0Bw1yompts02w3T4IrDtz9qaF8uE2BAXssAQPkGKsiLGI/bS6DvT1V
         S21/cZ/zmj5e7WFJ+CrgqIK+gQH9/cQa11SJnphGp0XvWbt4pQzDF6s9H7oNn576mamK
         GtEAsUUEpdQZ93Mz7pIDfBgqcpaH0FiXCBXt+JjUgRB2I7Z11/+svu+Nx/UMkj65ShE0
         k2jMo/rmr8BTiAjRIbISqa8y0cm3h/aHIt0icGzMgK1m5Ahczr5n1xLHnHgnqVNaL3rT
         1jg9t/2xSVc2MwMMRKbQbLWdn1JOYAZoq9VozQqlJVKiowqdTyt7Xa2v6cg8Arh4HKkZ
         5rCg==
X-Forwarded-Encrypted: i=1; AJvYcCW216Fc+7x5bMGGJ894PSPgcpggmohvwsI131JGRKQOOaWyJXtKqclPPsW8cMjI68wYj8/bNtRTiZ5Ntv7NNIJxOO5JC4WNbJ/3pwlK
X-Gm-Message-State: AOJu0YzjGedHKHJjz7o5ceczwpo0x3f0k7U8QvnrSQRs3wtUBuKmAib2
	zPKUSbaz4KD8vzneZ/rZFZPaaFHfp6Oh6ZJ08FgnOxuee/wUj3J034L755G82A==
X-Google-Smtp-Source: AGHT+IGOeL/QpfdM2r7m71ruASfasUfxopdj8Y8nJxGoGfAwF6tdeiBa/gyu/JEFhpZfPCnU8+m2MQ==
X-Received: by 2002:a17:90a:9af:b0:2c7:e24d:f688 with SMTP id 98e67ed59e1d1-2c8504c7bc5mr3043128a91.7.1719219404223;
        Mon, 24 Jun 2024 01:56:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4e6:bef0:f574:7d51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e64a1300sm8214557a91.48.2024.06.24.01.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:56:43 -0700 (PDT)
Date: Mon, 24 Jun 2024 17:56:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Yu Zhao <yuzhao@google.com>, Takero Funaki <flintglass@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/zsmalloc: change back to per-size_class lock
Message-ID: <20240624085638.GB3130923@google.com>
References: <20240621-zsmalloc-lock-mm-everything-v2-0-d30e9cd2b793@linux.dev>
 <20240621-zsmalloc-lock-mm-everything-v2-1-d30e9cd2b793@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-zsmalloc-lock-mm-everything-v2-1-d30e9cd2b793@linux.dev>

On (24/06/21 15:15), Chengming Zhou wrote:
> This patch is almost the revert of the commit c0547d0b6a4b ("zsmalloc:
> consolidate zs_pool's migrate_lock and size_class's locks"), which
> changed to use a global pool->lock instead of per-size_class lock and
> pool->migrate_lock, was preparation for suppporting reclaim in zsmalloc.
> Then reclaim in zsmalloc had been dropped in favor of LRU reclaim in
> zswap.
> 
> In theory, per-size_class is more fine-grained than the pool->lock,
> since a pool can have many size_classes. As for the additional
> pool->migrate_lock, only free() and map() need to grab it to access
> stable handle to get zspage, and only in read lock mode.
> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

