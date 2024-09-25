Return-Path: <linux-kernel+bounces-339177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F0986116
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A185828A260
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C018871E;
	Wed, 25 Sep 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NQkNhNGM"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A326AF5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272437; cv=none; b=QhZcFExLKunppdtgKgIrVJeqpBevqkbKTs2p0SVmvM1xfEt2VjiHx+XJMej5mW31ZIdUyvS7f/QdIzD0CU+XfASbFZZlHx2ZzGhHn5+6UHpmgcnOLv+7oeLf4OlZopIx1gKPC4HMzbipCiKS7A0P+HPs8f2w63hXcb05d5cCLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272437; c=relaxed/simple;
	bh=XzKCdtlmW5Np3hHkg1/02JFijZkjDBawF1bEOfJlIqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6IqrAMYYHkEj/VE172tn+EK9jff1leWtKmCmzlq7qrxel7hILYyqSKoH8NW/O0c2xJzuwwS2SGMqQzCq+nGyA844sy7tTBkbZormQNzngj+NONXPyfw0cZBk5szTTVBNvyFXUWwHiSumd56fNo3U4sKmO2mthvXNGaHaJzt3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NQkNhNGM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb2c5128d5so2036526d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727272433; x=1727877233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5rfM4JbVf2FJw+jtjeUyKhsGkuYNtfAFedVvaBv/3w=;
        b=NQkNhNGM8F8gI2HkUC8dReO/slCs16Ja0mDMJVgoXE/A6RyNJ6y5Tn9yUJNfMgPmi9
         zHnPFFI2RteQTrNRd66yx+xwDTYT/wL5m9OymqjmVWYdTXJSgrkbBbFuSXb+rSgtFN8b
         gHgZpr+ssmx56cEJjADiM2Ulh1/VeG1iCictcY3AA+E1p+JKXdB2YixoLG9gD0ZZ7RJ4
         0zNyyKJ2U8tjZRutkGpY/lBzvFbQi485W5e96NdPjiQ1F6CbMvgJykUfQLc4pjesZSjv
         xZjU0K4n4hmvASahxnk0aOFqRY2jFjH/vFVgzf/lu/4w4AcyNIzJ3wYcowBo0Vto4A/F
         t+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727272433; x=1727877233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5rfM4JbVf2FJw+jtjeUyKhsGkuYNtfAFedVvaBv/3w=;
        b=RxZs7ytn0BHNSvpdjlIVAypR5rAQYZWbFr1maj0yTZdoKPSKQZ2Ef9GU9vg6A0WKqq
         f8JgdZSkWfIdnF9x0IOHsiy2+HHJ8ruJ2MNHQE/Ib8R217UUnc0l5iZ1ezZZxubdrYyM
         zJjp0eY39yWsDPDijClkSiBbRmg1fD8oqb1YPJNSrEyTHrShbLBQoS2/aaA/jt3kNjWq
         +PG000CsHn6+7PeI42WkI+1KvC+bmKhRGVzhpCMJsPHXPRbapktMKtOUgqv+ABH0TKT/
         3J410rUvNBr6kaJguXWhQQzK0tocCawMDKzXiC0viD2RdbWZzi3j838OCPyKVFNlNjq4
         oZgA==
X-Forwarded-Encrypted: i=1; AJvYcCU7h4fqPMXFNQXPmNf+AlT7IH1LO4s/IEJJ9xK0I8t65btTxYkZ54iMMgUARpOfU7xGdfgMVO6KoM/FY30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+7J+Eq1TT3ptsCJSJt99dvhI8yBRz5stCj4ANljpHmvt0uw0
	bqx8A7A1NnWJS1RpjWYZ6ARyyrGRF3/vIHgcKeH6cUg1qTATGU/REM+lW+d5VCo=
X-Google-Smtp-Source: AGHT+IHJqyXqdkePK3CZZGGmyrtJ+p/ACo/Iy9jG5PrYhxG0iafEwE9SELoDNXGFcFXpHUKwFp3/Ug==
X-Received: by 2002:a05:6214:5992:b0:6c5:7ed0:194a with SMTP id 6a1803df08f44-6cb1dd09a19mr46739536d6.2.1727272433156;
        Wed, 25 Sep 2024 06:53:53 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f554371sm16411466d6.80.2024.09.25.06.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:53:52 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:53:48 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in
 a folio.
Message-ID: <20240925135348.GB875661@cmpxchg.org>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-6-kanchana.p.sridhar@intel.com>
 <CAJD7tkacF3hCXiZHy7_+E7xmdojnsUewDeP=BsamcZReHxCTtg@mail.gmail.com>
 <SJ0PR11MB567887AF292EC178BEF1CF43C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbCB9iqRc1Y0287rZjQnJaV41DxN+GzZJFkqxM1FM8R4w@mail.gmail.com>
 <SJ0PR11MB5678EA6E0A41B0C83CB7F8F3C9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5678EA6E0A41B0C83CB7F8F3C9692@SJ0PR11MB5678.namprd11.prod.outlook.com>

On Wed, Sep 25, 2024 at 01:49:03AM +0000, Sridhar, Kanchana P wrote:
> > From: Yosry Ahmed <yosryahmed@google.com>
> > I think it's more correct and efficient to update the atomic once
> > after all the pages are successfully compressed and stored.
> 
> Actually this would need to co-relate with the limits checking strategy,
> because the atomic is used there and needs to be as accurate as possible.

For the limit checks, we use the zpool counters, not zswap_stored_pages.

zswap_stored_pages is used in the zswap shrinker to guesstimate
pressure, so it's likely a good thing to only count entries that are
expected to stay, and not account the ones that might fail just yet.

> As far as the vmstat 'zswpout', the reason I left it as-is in my patchset
> was to be more indicative of the actual zswpout compute events that
> occurred (for things like getting the compressions count), regardless
> of whether or not the overall mTHP store was successful. If this vmstat
> needs to reflect only successful zswpout events (i.e., represent the zswap
> usage), I can fix it by updating it once only if the mTHP is stored successfully.

Yeah, that's fine as well.

I would suggest batching them both at the end of zswap_store().

