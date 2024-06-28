Return-Path: <linux-kernel+bounces-233202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 144F691B443
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF95A1F231D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A783FF1;
	Fri, 28 Jun 2024 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BX1BovmO"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565563C7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535912; cv=none; b=Hw6SMqp9I565T83OchexWBliVKlA42/o5YuyLDMPHYJEKd7t1lk2A8lmpyciHJrjgHWr5I2/rKzlGR6M+ZGudIDddvCgM9aYYTGZs3qugICdTeAx4QX4Ik90LdchGx66DoM6+7sdt+1pVrav5gqlRTMMmfExYCGSNZIU/JAFxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535912; c=relaxed/simple;
	bh=HAcMqSWRpXnb7hghNoCW/tNV4CatF4R6iT4u7P51fec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvJqBfu7EOwZKg85gVIFlTIV5RnPBt+O1Cq/wN0+AeOSIrHK/cvV8vUX2nRWiuQb+HQHjcWjGJ+DBJirahWKLgXn7xGgtl4tjC/NXhSxCVGEHpC5vLNwRWGYlmqru626uBdJG1Sk6PC6aK6+oq15bb/4wKDEt2P5I5BQdxxcl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BX1BovmO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9e2affc8cso216685ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719535911; x=1720140711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnzBmmCKRy0nhaiLP7G/RPc65pcYOuyYQhVZ9ipQNkU=;
        b=BX1BovmO2IBHO4Rr7aRWigCLl3aSIkhzhEmejc9TNjKZxmfDPCHfNonOSYX/CGi1pq
         KVFfdChOZcya0XBKRiZQxNfhG6/CGwqHTBXuAi8PTN16obi9mZcOUULP23zcYKyrBQ3j
         7ZjpLKOar5tEFNV6Tk2dmx6y4Y7YN4WUCIC9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535911; x=1720140711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnzBmmCKRy0nhaiLP7G/RPc65pcYOuyYQhVZ9ipQNkU=;
        b=nozGgsLprIMCOLOMz0qIS/UWL0E6eT8/snAxzeC8tyk1WGGhmR8ImSBRuAdj6gQR2E
         r4BoGUo95hRk7UvUF/B4ddzwsGJIU2IDpC8AeGQWsp9OGJSso3wU8MTqbpIERLptm83G
         OI/F/9E5pDetk3W6lLLniEcDvqECt3EQc0VgQc0S4o3l9zSGtbZdp3yLHsEFHkjMyaGg
         WiNqPeq83aDvMoi+3uLpatHA8EkqnCuuUGEiGtMEHi0Uzno0nyOQnN0e7f5gFYdU0iba
         toVZY8DWftfpny5D/6awTxwfVDmO0/b2MHG4XuP+SNQeq+6BRsQKcxwjdzjZIhnqR2iw
         /U/g==
X-Forwarded-Encrypted: i=1; AJvYcCXjQ3piDsezkFlwRr0RGxabd91/hApi1Tk8X0kbhwjB6poSbhQhTwEemjTbLyQd7ZRAKlaoOF1XbkbRJWOapR3/cyHytDkj2NhlLTld
X-Gm-Message-State: AOJu0YwhluaLHs1pkMjgUO5w2gaWqiY26mKKzlUAUbN+6HSTyjEMysmq
	PaP/tXWOI/JPeryADF9mktc6p57piqoAMVLMCxs8anpHAE+KwrTlBz5lkfEoVlYOiCewuiyMKlf
	3EA==
X-Google-Smtp-Source: AGHT+IHH35u2G4jip6EB6h3GWOotvhw5tMMlHtmllGUCZ2Wyxam/1KcQqdMMTBa1nEbOTix8Ou4Fkw==
X-Received: by 2002:a17:903:1cf:b0:1f6:f298:e50 with SMTP id d9443c01a7336-1fa23f25727mr158396285ad.58.1719535910675;
        Thu, 27 Jun 2024 17:51:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c19a:b9a8:4bd1:72c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156957fsm3698755ad.228.2024.06.27.17.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 17:51:50 -0700 (PDT)
Date: Fri, 28 Jun 2024 09:51:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, minchan@kernel.org,
	senozhatsky@chromium.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
Message-ID: <20240628005146.GB15925@google.com>
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
 <20240627133330.7f8a82078725228585dbf2d3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627133330.7f8a82078725228585dbf2d3@linux-foundation.org>

On (24/06/27 13:33), Andrew Morton wrote:
> On Thu, 27 Jun 2024 15:59:58 +0800 Chengming Zhou <chengming.zhou@linux.dev> wrote:
> > We always use insert_zspage() and remove_zspage() to update zspage's
> > fullness location, which will account correctly.
> > 
> > But this special async free path use "splice" instead of remove_zspage(),
> > so the per-fullness zspage count for ZS_INUSE_RATIO_0 won't decrease.
> > 
> > Fix it by decreasing when iterate over the zspage free list.
> >
> > ...
> >
> > Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> > +++ b/mm/zsmalloc.c
> > @@ -1883,6 +1883,7 @@ static void async_free_zspage(struct work_struct *work)
> >  
> >  		class = zspage_class(pool, zspage);
> >  		spin_lock(&class->lock);
> > +		class_stat_dec(class, ZS_INUSE_RATIO_0, 1);
> >  		__free_zspage(pool, class, zspage);
> >  		spin_unlock(&class->lock);
> >  	}
> 
> What are the runtime effects of this bug?  Should we backport the fix
> into earlier kernels?  And are we able to identify the appropriate
> Fixes: target?

I don't think this has any run-time visible effects.  Class stats
(ZS_OBJS_ALLOCATED and ZS_OBJS_INUSE) play their role during compaction
(defragmentation), but ZS_INUSE_RATIO_0 is for zspage fullness type,
moreover for empty zspage, which we don't look at during compaction.

With CONFIG_ZSMALLOC_STAT enabled we show pool/class stats to the users
via zs_stats_size_show() but ZS_INUSE_RATIO_0 is ignored. So no one
(external) should know what value is there and ZS_INUSE_RATIO_0 should
never be of any importance to zsmalloc (internally).

Code in question (async_free_zspage()) was introduced by 48b4800a1c6af
in 2016-07-26, so it's been a long time.

