Return-Path: <linux-kernel+bounces-272273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C3945986
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E50289972
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB41C2300;
	Fri,  2 Aug 2024 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zu8xKyMF"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D51EB4B6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586000; cv=none; b=MVuYm36ZxvdWG39E/0gty8/TNOg6aytrrzH1I/ubGQ49DvslinAYt/7lsPumj1d4W/BroBCGeWLaEpXNPO1RL+R7X3FZp0h8CnOgnyhGMKnSZ3P6jbWDPRV37H1Jlt5Mvx4Ll+axS2TTuXY6xl+AqvotklYSy3aTz/JJDOopDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586000; c=relaxed/simple;
	bh=6cMBfD5kjRag/G5FrO4ndWtO6DYGR6S9UjSiNNo+5fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnf83mTpH6JEMNCnHUMB1WIqI7zYfvXeRfzD0viJGXOe/pLPr5R00tzSBlT07SwxB+UVskC35i18DqnKtzolAjz2/6A3i2fQs/zYfHymi3t8OjEPzV/AiPPh9ZFH4NQy3ePEANGtfthxqnowJRjHl5CZWVf/fIqwq05zMxn2X+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zu8xKyMF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42803bbf842so69140995e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722585997; x=1723190797; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MPJE7ezvPCHFVJoWU7UFGAwm++u4dc+Z2RK0PA0V7w=;
        b=Zu8xKyMFiuOv0bzVEFqy+klNAS4+ogFrVhaZnm8S3G9K0lZu4i79kYLXI3RfObu1fx
         2L9YISfWqXYPxupSdcaurulsMcS46936qNCm3hnpXdavQw24A1BAj8DAB+Mvwd6nKQT8
         W1x0RSBgbVwpycOVT10x6bksGZ+yaJycStRD+rD8j9Zw02SAiIHjsU9DDGgk0/h42R9N
         jJVMriQzLhNlhArRaBRLi4WlZVlgLtrHIIxuE6nK+5ocKaJ2TK4XoYfbqStpoR3gEdFa
         +yjIACHy0nQ4jxRW+UuNCthBEzNca7aT0m2VbSb63TMRHt7Ip4hlSId7y6e3yelMZxL5
         wdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585997; x=1723190797;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MPJE7ezvPCHFVJoWU7UFGAwm++u4dc+Z2RK0PA0V7w=;
        b=jpvtDIw7+RV86+2hFTjvi9eju1ld+5YK+wKAogDoanQ37QyuFg2X/tTSRi9xIAaUMb
         A1wGCGe+ZhxgsiwgP9RTbSrmd+T/4VwJ7IQcrG9A2ISVihnlWYpyG+t6UZA7Rjul4W5M
         05Iip3OZULIq92thQPu5MtXGiqJU7S+Lf4OglC716dytQW+Xlp09FibRzBOirvpoc8/x
         tj+qh9i0I6K2YUKYeM+jGMAlAEHSAnaiqQWb9Y8AO22IJh5Y4rAMVBdIiY+Y+NNmEfIV
         kNgF4II8UQNd5+kli+Q+NLD6xsSZMXjmDssDNMKUIiiw+IX3mWrxIFGC4lcGlG1Z3zR2
         XQgw==
X-Forwarded-Encrypted: i=1; AJvYcCWUX33qgjj2XAp2Qj8pjJy6+WWb1jcg75m79uOXSwWrrL8Mw4nfjsoQkzOtRSkmoWBQo1SRIi8LxEuHIrNhK9JO4T2JkRo+pV1jV/uK
X-Gm-Message-State: AOJu0YxzHfauwg1UGXBMcwbVZpL7/E7V/omZYprRoD2f6mSVAGRa/ECL
	JSseSFeXtum3WybDddMYDG/8FvcOee3DAy+fDytNmPEnRyji2b/8X6y3Nv/P0Q==
X-Google-Smtp-Source: AGHT+IE2r5i5jqlUiPhe41D1Hu14GbCiBTHqSiEMaIv/ubJ9Q/G0LSsrLG2AuQT408lpdC0qzPikxA==
X-Received: by 2002:a05:600c:4588:b0:428:15b0:c8dd with SMTP id 5b1f17b1804b1-428e6b2f14emr22464585e9.20.1722585996403;
        Fri, 02 Aug 2024 01:06:36 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:6639:aad1:e65e:e31a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428eabb660esm10591795e9.31.2024.08.02.01.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:06:35 -0700 (PDT)
Date: Fri, 2 Aug 2024 10:06:30 +0200
From: Marco Elver <elver@google.com>
To: Jann Horn <jannh@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
Message-ID: <ZqyThs-o85nqueaF@elver.google.com>
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Jul 30, 2024 at 01:06PM +0200, Jann Horn wrote:
[...]
> +#ifdef CONFIG_SLUB_RCU_DEBUG
> +	if ((s->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_delay) {
> +		struct rcu_delayed_free *delayed_free;
> +
> +		delayed_free = kmalloc(sizeof(*delayed_free), GFP_NOWAIT);

This may well be allocated by KFENCE.

[...]
> +#ifdef CONFIG_SLUB_RCU_DEBUG
> +static void slab_free_after_rcu_debug(struct rcu_head *rcu_head)
> +{
> +	struct rcu_delayed_free *delayed_free =
> +			container_of(rcu_head, struct rcu_delayed_free, head);
> +	void *object = delayed_free->object;
> +	struct slab *slab = virt_to_slab(object);
> +	struct kmem_cache *s;
> +
> +	if (WARN_ON(is_kfence_address(rcu_head)))
> +		return;

syzbot found this warning to trigger (because see above comment):
https://lore.kernel.org/all/00000000000052aa15061eaeb1fd@google.com/

Should this have been `is_kfence_address(object)`?

