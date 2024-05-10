Return-Path: <linux-kernel+bounces-175878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AAD8C268F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCED284843
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDEC12D1F9;
	Fri, 10 May 2024 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="iPWzhsRE"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F7127E05
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350697; cv=none; b=bOyf0DEwhg2ml0SveRuBajzN5Ef7E62m8sIN7oEy5+7GVYSj1T2PQAGsvrxcbzRhcL8y4yeMGRczj8yUNfsT70YLrIqRyxySvReIkqRMKvKJ0Z9DFJEtPPq83a+nnJ/2MkoAMlcI+2Q4yZeIpQDnoPsL0QJg97TSn/XXZWXQDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350697; c=relaxed/simple;
	bh=iny9NAYFkawb5vEejd8kZ3wAYfN4EbJIZcN7un0e330=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTcHuSBXWQdAg+9MlC7DV8F0xee+JuwFZhzUFfytPgh/ucoXMR3LvOte2cxVvYupJMKmpYzdiBENRO5p98jVMkFiVGxrdqhpP+dsIdA32aaDHWJzWvcZwuvmAVYM/rV2T+VYnQyb9Hd/cD553z+59Bvxr9nkNDR03oMdEWjgT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=iPWzhsRE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792bd1f5b38so162395785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715350694; x=1715955494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iny9NAYFkawb5vEejd8kZ3wAYfN4EbJIZcN7un0e330=;
        b=iPWzhsREhsiqbKcuyIdFOAAQd8vO0lEGxLWgWdBVydJkJEIjxp3dvPJ4fhHgxZuZ7C
         wmaoL3nUItcyk2jBKaNlVnlvkTdBGJmcxagQp7QqmmesY3XKL7NF4Hb5e3rAP4w1o1Cp
         kjcEPiRoXEa4BBVuSj6LPP0yU4QWxeHSPkr4YmEs4xNmCTDXpyU/OI7JKC9XXDJ6Ex6N
         6zWWLwSc2qmBVsmNtaQ5PK6KXaep+kcfzuZKYQV3+xqe72pSAglgjZLGs5KsPuU5cIhH
         rLzzklUkTSy2yrGPEJ1zao6FzYXsefHodYPYaPsEn6pnP25znF9XdNh4BS8EA96yLPUc
         GRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350694; x=1715955494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iny9NAYFkawb5vEejd8kZ3wAYfN4EbJIZcN7un0e330=;
        b=PCnlt2SSZiYm2cHDWwyVc7AAFDoD74NyL9eWnDsBR8DWlrH1wLeDCYC0foG1GocYDS
         tWZToM6issqp5DkbVUitxlF+R63XVQfvs3rs8Ml2ujm1ChYxHSQ1nb9Jgi/y3ynWo0bK
         wotU1o/qB7sJYlZbIaXjwZoBmIbtPxIdaVLJJZ9AayJjFYpxJteHQRVqHqmlwb7Ftjlk
         uHWybCa963MstEme3YyGI19DYrWLwUNkevQTMkz1KNLlCXvvuu2cPIt7NQdDrJdJMFgb
         QNhoO5z7uPpK5u5m9biL+Nl/RuY9XRCjXnFN2h7r1MHxlj9x6sJXVXxUULQTsn+TXk4r
         EAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqUfnQoYzaJwNU7CTfd7pVhWBi8scGeoS58sRx1oyMrvuuQPRdg8ntgATrpkBsOpCx137uOCfCOMQ9pxTsGp1JXQvI3/8EFjrvoTJc
X-Gm-Message-State: AOJu0Yz7THygx3c2wYAW2IgHMPOUUdVNJpGAS8ZGaXKGN/770pllOQAl
	uYm4dajzy2XyogkHhLbQaizApszgjSVgBg42q85B5JL29t4d2jxT8ziSW/0bL1w=
X-Google-Smtp-Source: AGHT+IGF8Hf6u75vxVzZlBEuOVkPdAAnVvnOkZHWQQVTs9nXF5wdtKiVEYG94zmAXPgqXYnf444mTw==
X-Received: by 2002:a05:6214:4343:b0:6a0:cd28:ffaa with SMTP id 6a1803df08f44-6a16816031amr35228036d6.25.1715350693964;
        Fri, 10 May 2024 07:18:13 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd3aasm17662896d6.84.2024.05.10.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:18:13 -0700 (PDT)
Date: Fri, 10 May 2024 10:18:12 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <20240510141812.GA1090700@cmpxchg.org>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <20240509142205.GC374370@cmpxchg.org>
 <20240509143635.GD374370@cmpxchg.org>
 <ZjzkWt-ut902Qa7N@P9FQF9L96D.corp.robot.car>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzkWt-ut902Qa7N@P9FQF9L96D.corp.robot.car>

On Thu, May 09, 2024 at 07:57:30AM -0700, Roman Gushchin wrote:
> So maybe mm/memcontrol-v1.h for definitions shared between v1 and v2
> and keep exported functions in include/linux/memcontrol.h? There are
> only few of them.

That sounds best to me.

