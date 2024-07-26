Return-Path: <linux-kernel+bounces-263829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA42993DB1C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2AA281995
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194614A0AE;
	Fri, 26 Jul 2024 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="j5XSaO5/"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF3FC1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722035474; cv=none; b=fRZQWvqBs/U2Bj0xifCDVFtPcVk21Em2uRtHe1MKNRRT6+NC+qbzHx7IALBiaUsMDFT8ogFUJIymQyWHk3gkGu1rFt9HJloQqishWvxJUPt7IA/dZ0dF+vcbRDq4DEGj5tMrGODI+gRfiJu+ydJZtT/QVwujJFOTH9RONEesOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722035474; c=relaxed/simple;
	bh=HFxo2Mz7oAV+eB47e8000AvxcZnOqxMleG6s8eGej7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0X5GoXQA57Lu4R4v4UqsozuJTuX+5gbNhyDfYFHYtznLLgh/Ws3gbIz4UsWznKwWfKz2nJ5Q1g0wNHCSDkuzDxRnL3q3YfAFPt8Aw4oQq7VGWiZtutRAUVj/wE3F4MtL3a+sa0lQR5xymg2Rf1PwhQIv7O8EARt7HWP20ONj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=j5XSaO5/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79f19f19059so72853085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722035471; x=1722640271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKUiRpqEhfz7p9xbs9wa5d6FKdY8BWsy5pnJnnSyuKo=;
        b=j5XSaO5/0ycBx5ibwAE7C9fOVqa1DaurFDZw2+2PWw7jtQFrEmjDkz6JNHZr18UC6X
         Yz+IazU144ULx658VikU56rKw/B3ykOjh5w310V8+UI5JpNEqOgZr3LzucID5i9EaYCW
         kkWZRsnD6pb4sNpLl8nvhFkzZdc1oR9y0XIORGNKYPZKuCXkrG6avG/y1BRA8UldSPQR
         tPfpENSO02MNVSLn2TnISaJOBAQ38x7PnMvAQDz7EcU2+0DFjCackik1/tTjN/6WtYZg
         8or9nEYdNgUS7EZdaibD1H0vh9k7YhJeUzzXksdJ1nUgEbq+Ka3zJsbjGIRmRhjkf2+P
         AAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722035471; x=1722640271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKUiRpqEhfz7p9xbs9wa5d6FKdY8BWsy5pnJnnSyuKo=;
        b=AxzAMTxE5IfAMNhUUJZ3FX3Ek/lTdaW7aHqnkPMg5uT1z0RrQpnHnPUL45EO08km8C
         8Mo9HOR/Zm43A8+yKEnA9aZXAXZxX1WY5LJZ+kNygR0nO9JSNgrq/DT8tTX3dVLrWP0B
         +yiW/ZdGGw/0qzsK8DZXnLm2ZumejCjpg50VI1vXyUFnQz7sjnzsZiMmc6aHqmFaUlYW
         U61gNpWCWCDmKbMjehOvJZlJoh6+RKOuRORI4U/k4gIKExIx5HiA7rTBBe08ZyhqrvvV
         WUphLeLq4FAJLhldO5eLgk318lUvTbiUIFX33QiEjcHljnL9d8B81F0PetQIqkVQFKe7
         yYIw==
X-Forwarded-Encrypted: i=1; AJvYcCUVGotnafTgJp9uWyA8/ntJ9xs0w8+zG/D8fcqkk6om/jNA7097Ynk+w262yCdR/M6PMnVS844Wsxgz6q9iU08egDyUDEl7J2Bvsj+t
X-Gm-Message-State: AOJu0Yx8Xd06qlpZ0dqFWm1hSMlGkIcrT9DpK/ddMgShtWFaIfuQX1oP
	xSnP1b6a07EDDLfoHmQk/xANO2z/oQIxFCXAyVWEzvmcwtg/hjKDqtLLkuppMu7y2g7mpN8km5q
	g
X-Google-Smtp-Source: AGHT+IFV4D8QxOdzvBSvtVsqYDXORNnK0U1s3NwwePOfYmSa3066deyt3dj9GGvXAs12nyufECM+OQ==
X-Received: by 2002:a05:620a:c53:b0:79f:b34:9edc with SMTP id af79cd13be357-7a1e52f2a36mr114500285a.66.1722035471570;
        Fri, 26 Jul 2024 16:11:11 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d739810bsm219982685a.16.2024.07.26.16.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 16:11:11 -0700 (PDT)
Date: Fri, 26 Jul 2024 19:11:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 3/3] mm: page_counters: initialize usage using
 ATOMIC_LONG_INIT() macro
Message-ID: <20240726231110.GF1702603@cmpxchg.org>
References: <20240726203110.1577216-1-roman.gushchin@linux.dev>
 <20240726203110.1577216-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726203110.1577216-4-roman.gushchin@linux.dev>

On Fri, Jul 26, 2024 at 08:31:10PM +0000, Roman Gushchin wrote:
> When a page_counter structure is initialized, there is no need to
> use an atomic set operation to initialize the usage counter because
> at this point the structure is not visible to anybody else.
> ATOMIC_LONG_INIT() is what should be used in such cases.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/page_counter.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index cf837d0f8ed1..5da11392b382 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -53,7 +53,7 @@ static inline void page_counter_init(struct page_counter *counter,
>  				     struct page_counter *parent,
>  				     bool protection_support)
>  {
> -	atomic_long_set(&counter->usage, 0);
> +	counter->usage = (atomic_long_t)ATOMIC_LONG_INIT(0);

Pretty cool that ATOMIC_LONG_INIT() return value needs a cast to
atomic_long_t! ^_^

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

