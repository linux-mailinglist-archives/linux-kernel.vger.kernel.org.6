Return-Path: <linux-kernel+bounces-254714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC1E9336C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E471F23C08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C350C14A96;
	Wed, 17 Jul 2024 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNl0nQxX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCEB13ACC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197119; cv=none; b=jRkUtyolpR/FHAEsSw6/mlKKzPi9GQtyVFd78gOu3M0QPxiQPr8Plw8AMf9HLBVeasbLzily1v334TJngA5QQWCkLgVcLKV8z35zWO9ZoWpGkw2zYY3naIflz03UrY/XxsvJEbPXe9vSOZlBtNAvd7MhyH7MBEet+aY7fsj1S3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197119; c=relaxed/simple;
	bh=it8zaNArr4+M3krejY0KN4JNzbwgmTtwIXbDSZYvnfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uljuD/W2T9ZI2W6sU3mY4jKg8d0OfR0qTwGbrhLVz+BV9NovwBCtcO8Mt0cprR2OoWEwEnakdBusMMnSjGN0VqsCQgMwCAgcvOUqBjOnjIu1zcPfX83qVjKhK5/3XiorFy8LII1p8fXqURoW/TstQJk4UoqLjKHVQr1fi+JsVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNl0nQxX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9f863c46so7066536e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721197114; x=1721801914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ft3uDiuXc9eH9qPA+tznvZpzXYRNDs/NnXbEjvWw+aE=;
        b=KNl0nQxX1tITBddLTMOIorl+UXja5NMQjsM3kZZXNmt8p8klTxoZmpE2kbl3+daTER
         oE3ewUcYV1JfuNS31E7SVtOqkRvS6tvidhonWrN3pR+NcyCtHrLcCxLLkCvaZoj6sYn0
         8366Y1dFRb3YJIa0VwxsC8LYzFyyI2U2TsQMFI3fr06RcdaCHNtDiuxnEKAcD4HE3tWP
         fxkxcVToJzqmvczuiXvyHeRodQQj6MQRPx1dfckTIke7AZT+rWCYa3bL9nmszb3eXIl4
         q/GH/2sgqfinFIj+NiS07u+uyY+eJGMf+nQ3kJx+VwjtLZTWckmeAuqhtrcrY4MfzIeg
         Yj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197114; x=1721801914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft3uDiuXc9eH9qPA+tznvZpzXYRNDs/NnXbEjvWw+aE=;
        b=lG4cf99Kg3tpUP/a+XKtaRvdQWSH0Tm9t0aT7Lb6mU1eE7s9UP8Y76M5/O4CGTLA7B
         z2uXXlJi1q+1uG3/9k9IgGdfgjUgLjdtRVUJ1hFZ8qihoTLFrDN8fC39U/FXOBpGgAp7
         qiYbWaqk3QuQPv3gXCUq0fIif/yvipi954yha19iUlAs7zYdcIyFq2hApDooaqqnXV4y
         TUbXqUKw8ORPgTET1tGee3P09bNE7Y5Cfi1nqBKNDUCtSY4YR+ZfLmla0+8rk87rHnHy
         qK88OQ1FTjQowKezmlgq5QMD/1Q2NaYYNXEzumIiPbhVnlWQX5pISeZMMIrYOpuI4BTM
         T9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDzeNhXtUlqt2lz518tIuEMVU3IyoYaSRRnZY55l5dDdVcLGtW2+Y4Wx4nZ3Y6HUj6d4J1LlMPKA6h9z2UmpDssktfXpy4cfhL4/mu
X-Gm-Message-State: AOJu0YyRJOMETLVXIMi4VACoNr3jd7LS1nHglIATg5epjP+HowqXZTEk
	5YMngFJHWBboFAB/7g3cXGIpQ9PNVDcHrEwajDdgN3yGwfdcBF5w5A00uDDQ0es=
X-Google-Smtp-Source: AGHT+IGgWbb2IPkjfEDoNx2g+eoVjB/B6K526lBWKCCRxuVqxHJLxM76gIzPizZ7r48jQdJZprEGsA==
X-Received: by 2002:a05:6512:3d08:b0:52e:9951:7891 with SMTP id 2adb3069b0e04-52ee544b0d6mr376783e87.53.1721197114165;
        Tue, 16 Jul 2024 23:18:34 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5ea482sm410071566b.92.2024.07.16.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:18:33 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:18:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, nao.horiguchi@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hwpoison: reset hwpoison filter parameters in
 pfn_inject_exit()
Message-ID: <ZpdiOAjdSJfkpbr7@tiehlicka>
References: <20240716033516.606582-1-linmiaohe@huawei.com>
 <ZpYxkH1EFB65tEzt@tiehlicka>
 <c81031da-2722-dea4-0118-9f4911035cae@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81031da-2722-dea4-0118-9f4911035cae@huawei.com>

On Wed 17-07-24 10:23:06, Miaohe Lin wrote:
> On 2024/7/16 16:38, Michal Hocko wrote:
> > On Tue 16-07-24 11:35:16, Miaohe Lin wrote:
> >> When hwpoison_inject module is removed, hwpoison_filter_* parameters
> >> should be reset. Otherwise these parameters will have non-default values
> >> at next insmod time.
> > 
> > There is a clear layering broken here. We have mm/memory-failure.c using
> > values and mm/hwpoison-inject.c defining the values. Both with a
> > potentially different life time. Shouldn't that be fix instead?
> 
> In fact, we have mm/memory-failure.c defining and using these values while they can
> only be modified through mm/hwpoison-inject.c from userspace.

Yes, this is exactly what I mean by broken layering that should be
fixed.

> The common usecase should be:
> 
> 1. User set hwpoison filter parameters first through mm/hwpoison-inject.c.
> 2. Then doing memory hwpoison test through mm/hwpoison-inject.c.

Why does this need to be done through different modules? Why it cannot
be part of the memory-filure.c?
-- 
Michal Hocko
SUSE Labs

