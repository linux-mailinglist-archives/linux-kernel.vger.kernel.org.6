Return-Path: <linux-kernel+bounces-342334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83327988DAD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 05:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901DE1C21648
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 03:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE53FBA5;
	Sat, 28 Sep 2024 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQDsPiQl"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD679FD
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727492441; cv=none; b=hEQk7GAXoULz6xp5SdLh/CcrEeCJ/EwldBtS4+FMDcEbh3YGr6ejNGxqqeBVFPqzmJYNvbQCG3HrK1RyI6wR7eb4agTh01QzIFguzkLJmhsg1qlDbr05ImvYIc4c61Nhq9fjxzP/zU9815LB+g6AWsKXqMF5Sr4svoMwvUHfJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727492441; c=relaxed/simple;
	bh=4pGQ2tVJeAk9UZ9dQMlOEjioHjCla2Ywx19fRFA4GXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsIy59A/UfHEAv0w2D2ya8MdpOdrcYQGcWy9SGY7i+AxDDy9LTE9lwUw+uT7ClhqnC4hDRfA66Z87jmtmuS2saQhNR8gftnbTiqEWYooX52ovMEiUSMyrEKTuiLs0oX5aaLW8c7p6ZNvJq2X84MEUTeTbzVrJFw7MBoGyqZpu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQDsPiQl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so387505066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727492438; x=1728097238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2k+I2VtZ/B8mr+jqBoJEI0QZjBBEFXXtfGznpaJkdZ0=;
        b=NQDsPiQlYtGoeZ0XB7Juz3eYVPW5Pwo9wT9A/aVoDuA3bEAsVLbu/7KM7DLWQF8/6E
         PPAQijNBj9RVlGgKzugBOU0UOniziEHh66R6sEewHLYlPb+8siOwHfCxndEkFGfbaDss
         nGzeanWT6nS6ufbp/MTkkbq9nqTmFS+ddEl6+fP61/SHSp9UiZVxUC9Qh9PyvItcJrSW
         x0QEZ4iCUXwg5VJoA4AMBnESAoM2Y3SuJWmNWhkUY+maNZIwQQltH6WTza4bNz/6VIVC
         tVhoISMQ97ja7l35LrIG7W1l/PDNQ+Eqr+5f1HkRicqKb2lPHx34DErOOXXBAVZz1UJW
         /dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727492438; x=1728097238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2k+I2VtZ/B8mr+jqBoJEI0QZjBBEFXXtfGznpaJkdZ0=;
        b=a0l91cpPL3UW5qMW5pselc5vCNYojzBhgLLVxuqb8QlLaj8HXK2KlHeOBm3Dds/X4r
         mMH5HfXESikd49FxnvJMTDmhtvdYPFtj/s/WEc6Y1NIYUZYxU/EhwGoaj/1E2Lr0g+yS
         wy1loviZXG7RgSJozsE7FMibE2BPJWflVZASjBPLmPLkUXUDulPeGVQWsEtxynWfsg5F
         nkaTc495r4SfL5gj8huZP7Ai/EYlDWy3sC/1thcN9ZEiUf3pTfKKyQTJIW+uSDZva5VC
         Hpc5W0hRQeA/O67C5bhtd0lhqo8fizioY1snhnaVNOvLj31OaAJ4QrfTGvFswjWHwtuV
         luqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdCOjKhSPXGFEuboosQNE1RBaqljUdYX6SQrbHqGeUtHDqTCzpWcoLIRUqePzBEhMPoO42/xqxVG7S6/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNX6fRt+zLBQBqU/KAb4IftvxXjgn9kMZMv8nvc/lRbmLD0P9
	vWzCPhnWmYJ8awVXesCgVKdhbhOENMlctgU5YbZKLELAoUTryoITDpw23Qksmr2Us0XQ6HKIm5E
	4oyBYDCnSj8+3lxhI9Ql488hyy5KxHFwX/XUN
X-Google-Smtp-Source: AGHT+IGZt4+wVCsVpg56gQBE9wdBJQWPEXP2IWOGKV8662NYWiK16ueqTIDEYhUO1aDDiCZNUqRuKRNGJA4KDP4HJyk=
X-Received: by 2002:a17:907:a0b:b0:a8d:2c3e:7ece with SMTP id
 a640c23a62f3a-a93c492d4e1mr473127066b.31.1727492438270; Fri, 27 Sep 2024
 20:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZ-+wdPuN3NMbT9J2WfKCn0dHThWV8GHFxhjuBxcqnTvQ@mail.gmail.com> <SJ0PR11MB567843ACD2B680D91096582AC9742@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB567843ACD2B680D91096582AC9742@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 27 Sep 2024 20:00:02 -0700
Message-ID: <CAJD7tkZ0NeGFoEH5wDU_WFPwJzDNLo8C-Y_ijaLr4eqMDEv6mg@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] mm: zswap swap-out of large folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> > > Performance Testing:
> > > ====================
> > >
> > > We list the data for 64K folios with before/after data per-compressor,
> > > followed by the same for 2M pmd-mappable folios.
> > >
> > >
> > >  -------------------------------------------------------------------------------
> > >  64K folios: zstd:
> > >  =================
> > >
> > >  zswap compressor                zstd          zstd         zstd      zstd v8
> > >                          before-case1  before-case2        after     vs.    vs.
> > >                                                                    case1  case2
> > >  -------------------------------------------------------------------------------
> > >  Total throughput (KB/s)    5,222,213     1,076,611    6,227,367     19%    478%
> > >  Average throughput (KB/s)    174,073        35,887      207,578     19%    478%
> > >  elapsed time (sec)            120.50        347.16       109.21      9%     69%
> >
> >
> > The diff here is supposed to be negative, right?
> > (Same for the below results)
>
> So this is supposed to be positive to indicate the throughput improvement
> [(new-old)/old] with v8 as compared to the before-case1 and before-case2.
> For latency, a positive value indicates the latency reducing, since I calculate
> [(old-new)/old]. This is the metric used throughout.
>
> Based on this convention, positive percentages are improvements in both,
> throughput and latency.

But you use negative percentages for sys time, we should at least be
consistent with this.

