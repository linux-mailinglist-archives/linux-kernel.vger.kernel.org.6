Return-Path: <linux-kernel+bounces-339613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7560F9867C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A71C2122F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72C146A68;
	Wed, 25 Sep 2024 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="LKcmytil"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095FD18637
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297379; cv=none; b=hgCayROHmGYd5ui3fgrLLgTH1dT8smaooAhqyqbCfCOKMv7lTw/BS8yo0TAu1tK7ubekRJqZNjnVvZKQ6/VOZHgQoihkQtnxSZZfpfHRh4qhT0tPAkiM4lKdqIE9cu/f83fIJUUnLyZdYpIIrNY+M43gyRJygRsjgq4W1oobLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297379; c=relaxed/simple;
	bh=2i8ZoZIJkJQHMlzNYeOPTF1gDHtejspirdDbtWvFjIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjQmMxCwDrhvsBokRUDYggzXplrtMNAgMV64tjCpvPwpZfwBJBrokHm09BKYdpkXZ9sY5NQ0pdr2pUlMD9xE0gbgdC+7Hae4mpQH+y9mtxIgyc5bEZuLAG2ewKuT8g8A6knt+BoJiKKPJedec0o+oe5mljEUYnYM1UHDvILusAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=LKcmytil; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a99fde9f1dso22546285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727297374; x=1727902174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEmeQDIoad1UaQtwjYZoQ08K0EfNMPugxIPzMhoStyA=;
        b=LKcmytiln80sSd7/gYuuzqImyWI00FGob0116Euka0uUSmv0bZlW5Pknm99U5QmbP+
         30xB5OlzyPpvuhfBkc/+ZmeeUVyI51g3ab/3X6sTVNVVoBD84uigp7JOpn6WWbk9rSwZ
         MaNIfwD7gzoA+J2ZMeHnCS5UnZiHRrmLREgqYJH8Ijsue+XGurggfrZAxqyOrcA4qctP
         qJ/b9d2ESiA3cvm0R5bYrZhIAxA0Gr+/uDEU1UR5Pn/9eevcwZDjZaWNhSD6AAYdv3sq
         A9mP7Amfz/JGFqQ10uvcmmpmSSRpHgEyikbiAf97Y59m4GVEhdeAMLwC0vuwv0kX1PgK
         LWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727297374; x=1727902174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEmeQDIoad1UaQtwjYZoQ08K0EfNMPugxIPzMhoStyA=;
        b=vkuqSpnmQJfSufmeZ+6UDCLlVI+r2XlBCJ4q+8xv4JEmHRxm/RD0x0kpVPK/0yYL6X
         X6Y9w6LIZJJRFPvGEqNYvC1mJBvJh0WKipvY/doNSadstWXhKVTksKuPpvNEpxCm3S0t
         NgA7rWGFQANm3YEqQ6dt/MK5FuxHci5c/RnPEopwlF+B0km6FTuEGSD8znq3P/GH01d0
         /qaVQvPa3MdgTr37GZvImFaO6NQimsh5V71vcD/12OS2DLVkEo4N5BQKHOqxxaz3Zauv
         7NJ4tRNul9oh0ZxGA7affckB0C0Neh502831f42/EP01Qn1D6IuivkC5c5oE2KgB5c/z
         QCfg==
X-Forwarded-Encrypted: i=1; AJvYcCVs5T/ZcXdlm7KLp9H3t86w2EA0BU0wzc5yjyVurtVSs04J0dOl+EuvvmBmrgQft2CtZ8132t28Yb1gfAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWZOIpvsptmIunRlxNbDUt4njhjJx78Re5fxM5vv28TMh1gWQ
	XlFRImceABQfnKAVBeATkWAMBE1GYFCA2O5exOg+vPA8s1f3kavNzIK+S7/JkiQ=
X-Google-Smtp-Source: AGHT+IGAG5WENP6E3voq5W3LGdqINSFxDHU4H+x4Vg/h6h2rZ5ugMsP62oKLnr7J1eWj5EzxkxK5vg==
X-Received: by 2002:a05:620a:371e:b0:7ab:34c7:10b4 with SMTP id af79cd13be357-7ace744d5e5mr574033185a.47.1727297374549;
        Wed, 25 Sep 2024 13:49:34 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde625367sm205555485a.129.2024.09.25.13.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 13:49:33 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:49:26 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
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
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Message-ID: <20240925204926.GB880690@cmpxchg.org>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org>
 <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <SJ0PR11MB56784B0D0EC2348A0ED7542CC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkapj+Wb7BMGZ=2AGi2NTXJbZBCnoJkZuBAkkF8NDZDKjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkapj+Wb7BMGZ=2AGi2NTXJbZBCnoJkZuBAkkF8NDZDKjA@mail.gmail.com>

On Wed, Sep 25, 2024 at 12:49:13PM -0700, Yosry Ahmed wrote:
> Kanchana wrote:
> > The main question in my mind about using the EWMA checks is,
> > will it add overhead to the normal zswap reclaim path; and if so,
> > would a simple limit check at the start of zswap_store as suggested
> > by Johannes suffice. I can run a few experiments to quantify this
> > overhead, and maybe we can revisit this?
> 
> If you look at ewma_##name##_add() in include/linux/average.h, it's
> really just a bunch of bit shifts, so I am not concerned about runtime
> overhead. My discussion with Johannes is more about if the complexity
> is justified, I'd wait for that discussion to settle.

Sorry to be blunt, but "precision" in a non-atomic check like this
makes no sense. The fact that it's not too expensive is irrelevant.
This discussion around this honestly has gone off the rails.

Just leave the limit checks exactly as they are. Check limits and
cgroup_may_zswap() once up front. Compress the subpages. Acquire
references and bump all stats in batches of folio_nr_pages(). You can
add up the subpage compressed bytes in the for-loop and do the
obj_cgroup_charge_zswap() in a single call at the end as well.

That's my suggestion. If that's no good, please ELI5.

