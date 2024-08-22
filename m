Return-Path: <linux-kernel+bounces-296653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7F95AD44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF561C22729
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D5B1369B6;
	Thu, 22 Aug 2024 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TpbQDpsA"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389713A244
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307277; cv=none; b=SCprq0OK9SoVpvABZqHkQqn5V3fdPCXiu3PIiEJgS6Dc0dcyU9Xtef+irSJeEeC9mf8tmjPdMobh5hWw6Gm1qNpfOQHRlmQtrTHKh/O2S11deWax54YtkC8bpzZDIDq2+gIqjDGSe3HgLjNWVJ0OmHlngi6zTpDjMqTnpPaEhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307277; c=relaxed/simple;
	bh=/rSdYOdYMeRqOaO+TMmGEdD7Qe8n8BJwDT81AivhzJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObfQPL90w9qu5qCMNGyVaH63/ImdkcBjFnvBGFzogFX6ZxnSBJuuR+a5CXwitfS/OSCwllb/6lVUhSE31Df/MZZI1vSIEWvTQXJxyYYMhbL/zhnBAZy75jathEV18ASX2ofd+y73vRvLiCv0SeDKxMnh17eTlmTwDZ4RrnRtmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TpbQDpsA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86910caf9cso51055766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724307273; x=1724912073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZPEC44IJXWEDzAV+m0lCiYSNN0EEVhCrFU2ANliNvBA=;
        b=TpbQDpsAal9HUVUJqmR2wWYipfddmUCry88vrgQ101+nogjbGRd2gDnabNAE1BAIOA
         18NPJigdlBeF5awisoTBien3c3a7FLCFTSJKKpFj5SNpIhq0hoo9uLljqvKmUFeH+wD3
         Q4QoMe+O6bs0zXZRyTsxG7SRpVQdJWp7p/SVX6AtP4jztOCBfC04J9P1XB55TTvo6zgi
         HMHzSd5Z9YKejPIr8tToYLRyaj7ngAIS2VIg+ojEv4OfJw/nzlbEpks7tOSvHy82ucha
         Q7DaBBir8PUfRgtqvQ9P3kwHqAqlA8VASADiOkZw0hiuMOuPIAsj2ewqZ6+AOS78XYIV
         k3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307273; x=1724912073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPEC44IJXWEDzAV+m0lCiYSNN0EEVhCrFU2ANliNvBA=;
        b=swEf+o/xc+Z/QK53hJS6jtH5Ny4gji5sN4dxiCAqsbXH7SNBuStGTYXh/M4291nwo6
         sHN2B93VvKbvILAeb39o6ByZ6b++Y/ydb+0Fxco0NHUGqUrTzrc1YnqeoV/gHPC4Cu1u
         eG5Z3hAcCKOdUcPCoIW4SPtG0f7/Jk1YsQwqFBWGmFfhkvTetGNhiH2GHT/OFxc5N3GM
         TPkqN5Ar6nLx9FGi9H8gshAk0RxWexKh/VR1y1mIvgmVTw/Clw0hNk4lasKUQSuEiYXX
         aibJI1zMqVUSqyGDiSKjM1pEU21g05NrcSD5Ak4FH44xt3sE97ETsD6VQB69DZuyR5wJ
         lkOA==
X-Forwarded-Encrypted: i=1; AJvYcCW3km4eOAwZEGfPYo7OTZ1VJHDSs9Ggi/zOPUyZwz/FFGa1F411eiIFqHCA1ab898Kzkkj0mCsSooB9vQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl11yFnojzMk4iK77ihDwrhocdlVzvk1jpbq7z/TZF1wYk/wDN
	D0qdXPm0SyGvlSIvi+aUl80jq6hWR2bcUa1f7wtPgJqGwU3PFWKi4rZrRN3i6+Hpo2ecYamrzVj
	8
X-Google-Smtp-Source: AGHT+IGoLzPDcFTYqAS6S4eK/IBENCXHYmzic40/YCA5fIAJ5izoag2uuC/jERmcYTsVI2KRI/6zOw==
X-Received: by 2002:a17:907:7f25:b0:a80:c0ed:2145 with SMTP id a640c23a62f3a-a868a7dd834mr186424866b.2.1724307272752;
        Wed, 21 Aug 2024 23:14:32 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a5d0sm65466566b.159.2024.08.21.23.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:14:32 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:14:31 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"yosryahmed@google.com" <yosryahmed@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not
 defined.
Message-ID: <ZsbXR6NKM7yOLODb@tiehlicka>
References: <20240820195005.5941-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=N-xuQume6C+xq0LfhVNOaK9rOiz_0c39GfoBB-4+6eng@mail.gmail.com>
 <SJ0PR11MB5678BCBBA46F1AA205A274F2C98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB5678BCBBA46F1AA205A274F2C98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>

On Wed 21-08-24 19:40:42, Sridhar, Kanchana P wrote:
> 
> > -----Original Message-----
> > From: Nhat Pham <nphamcs@gmail.com>
> > Sent: Wednesday, August 21, 2024 12:24 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; yosryahmed@google.com; ryan.roberts@arm.com;
> > Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is
> > not defined.
> > 
> > On Tue, Aug 20, 2024 at 3:50 PM Kanchana P Sridhar
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > > This resolves an issue with obj_cgroup_get() not being defined
> > > if CONFIG_MEMCG is not defined. This causes build errors if
> > > obj_cgroup_get() is called from code that is agnostic of CONFIG_MEMCG.
> > >
> > > The patch resolves this.
> > >
> > > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > > ---
> > 
> > This is only exposed because of your zswap mTHP patch series right?
> > Could you include this patch as part of that series (since we don't
> > need this without that patch series), or make it clear in the change
> > log?
> 
> That's correct, Nhat. Although, it might be useful to have obj_cgroup_get()
> defined in the case where CONFIG_MEMCG is not defined. memcontrol.h
> handles obj_cgroup_put() similarly. Would it be Ok if I included a reference
> to the zswap mTHP patch series in the change log?

I would just fold it into the patch which exposes use without
CONFIG_MEMCG. We currently do not have any such user. That's why I've
asked what is this patch based on.
-- 
Michal Hocko
SUSE Labs

