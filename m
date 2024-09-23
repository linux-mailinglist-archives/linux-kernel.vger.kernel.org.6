Return-Path: <linux-kernel+bounces-336046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 977A197EE75
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3941F226E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F519C56D;
	Mon, 23 Sep 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8XXLT/U"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E546B5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106464; cv=none; b=c+kxU1w4hReZHxezjBrr9msFRFhbYnzy4YfWKbGQVt3EgYvwfyelVj/V7YL4y+HvlC7KN7jDPRGyy5+5GfWhr4S5ysKX1QXjNifJMc4yMcv/tLufe5ociqEBSM4JE/aTJ2y8DUsz7ciKGpL8rmVQAnQevJT2QuEofr+cYWrKDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106464; c=relaxed/simple;
	bh=6tBsekOVEbL/u8BkiyRDO7LBWxHubMJp54aDy0+CCIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEbPVYHBaUf/gpTE9ZF2VHOftjCq0VuT7EmNnEevSZJiV2k7T/oyF8I8dtqMIc/P0cgEgxqEDwKe3r5zmExMCGNyHtoKHee+nREZzaWuyIs3PY17MECdzwm83nM0tWgGbibyC7NqmcUrDtdu3T5Q6N88DUXnWty+l9/6qtvdzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S8XXLT/U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-208e0a021cfso20076475ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727106463; x=1727711263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQvRJDTU5M/Q7YFtH2baTOj185sy5Qo5fxlt2UwlPLs=;
        b=S8XXLT/UDhfNEiKrS46JgCZVy5zEy4YniOJ+lmNOsla5rm/ZVFQqaePzBkZvrb+zRu
         3EpPhD1wiEwnPwnEzN0vD5QyTSPsq8TDYq3am4E5FmcFIDDEp3N53lBSPn5U6x/Usrn8
         /aB7VhcwPaI1NDPOQZkjqj/LEq/aB07pd0mf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106463; x=1727711263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQvRJDTU5M/Q7YFtH2baTOj185sy5Qo5fxlt2UwlPLs=;
        b=qbBShEvpLvT0bUV9eAQemVHNIgFFw4jt2rBuXjzJWJnD8Lp+9z9hceQIn6P3HbZy0r
         MxZD+CGy83mk6hzvS0Vc7E288ELEt1lpdt7RLxAvqeHNwJCExDAFQH0t4ROPWdnmcNex
         jKPoDJiAWcN98t/OyFiQSKGB3sz2MXcEUIbDLZpXBVvaO9VRNc+Mge9ESjtIQEHXJZnD
         /gYxx8RmMWELRMd7OO6cQ3UhntLHRqZpFWUn/ovA2nXizNDodxFblDVZH8kroxB1JePe
         CfciPTxemThX00PITeQZSpKhBWMb0V29iSnMC9NNQMXVxkKWed7pSCGIHc/kTUZXVK+1
         t1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXnWvwi8rZ0p6VhIX7QLVnAwNzjjXQnRR8f2LsA+wwDeYb+bWYs+l6c5rEYBjdDYQrf0mYTdGWzGgUNYug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/6gd6cGvzpzs2I+j1QhYLtpATP+blbZ0FKECU2DZdAraNU/7
	KdERePLZh+IyCG2Wg+sKMB1Fdoc4vCJil0wZ5YFohdmW82IelWmVrc26AaHEY+t8UrkepN3n2Qk
	=
X-Google-Smtp-Source: AGHT+IGUc2twRnaEQXb08Noipu97AHfEkG7UmGX3BFwRhuwwWRnJvapkHauas0XeVKCV6OmcnBRp7w==
X-Received: by 2002:a17:902:f650:b0:205:3bdb:553b with SMTP id d9443c01a7336-208d833d0d0mr198432615ad.16.1727106462945;
        Mon, 23 Sep 2024 08:47:42 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d1554sm134149685ad.144.2024.09.23.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:47:42 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:47:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: don't free statically defined names
Message-ID: <20240923154738.GE38742@google.com>
References: <20240923080211.820185-1-andrej.skvortzov@gmail.com>
 <20240923153449.GC38742@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923153449.GC38742@google.com>

** Re-sending properly, somehow I managed to badly mess up
   the headers the first time, sorry ***


On (24/09/24 00:34), Sergey Senozhatsky wrote:
> On (24/09/23 11:02), Andrey Skvortsov wrote:
> >     for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > -           kfree(zram->comp_algs[prio]);
> > +           /* Do not free statically defined compression algorithms */
>
> We probably don't really need this comment.
>
> > +           if (zram->comp_algs[prio] != default_compressor)
> > +                   kfree(zram->comp_algs[prio]);
> >             zram->comp_algs[prio] = NULL;
> >     }
>
> OK, so... I wonder how do you get a `default_compressor` on a
> non-ZRAM_PRIMARY_COMP prio.  May I ask what's your reproducer?
>
> I didn't expect `default_compressor` on ZRAM_SECONDARY_COMP
> and below.  As far as I can tell, we only do this:
>
>       comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
>
> in zram_reset_device() and zram_add().  So, how does it end up in
> ZRAM_SECONDARY_COMP...

Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
Yeah, that all makes sense now, I haven't thought about it.

Can you please send v2 (with the feedback resolved).

