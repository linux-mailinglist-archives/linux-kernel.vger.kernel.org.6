Return-Path: <linux-kernel+bounces-340937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31B198793D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83F61C21576
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4A1714B3;
	Thu, 26 Sep 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xq0zJf1s"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD813777E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376193; cv=none; b=B6rCL8OJJYcZpdJD7z9Kl2J5Lnx6AzvbCTzslGLZNTDUCWXWbfU6atQhYsXKp2Llu7JP4+XQM2FdaZ8ZBTQ29qYXdUK7Q3pahk7zWELLe+YpB+NzIJCu4vmkNWmOMzifARr/FbV3vyQ5jx7729JPtvIt4JnHbu8GZbtmT+/42uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376193; c=relaxed/simple;
	bh=6apcyRjHAlEfiRdDkFRiLnxMOOdeyJ6eoqAeJ5VTlQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuDaichkutsD/FUhUl6WsMP9X3aeR2/5hND7Qg8usBy2E4OkA5g71JoTtN1q6I8fQQKmUw65cfQbyMBWUT/FmElaA/gjJ5J4hVJ1r/m03Jnv28AdMZE7PFS+zA0ncduSjM+upfLcqAm8MbP1Gggcbt/BAA/4p7LJYDWjhVakwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=xq0zJf1s; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9a30a0490so129020385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727376189; x=1727980989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWABK7jevZz6PaZEJkjW9C/kJozsqZzz0c8Gpnqfp4o=;
        b=xq0zJf1sf1QVcsxGG6e2RecFYfs6KBEdItKD9prRSJ/ByyvnElEohgsjkjLMuHSp7U
         u8xm3DpC6SVtkEIJu0nlRK9/nZE1K2ySWU9L9t2iWH2HAq4yyGMp/ehhJ+NdWaBVrk5O
         Fg5cI/+29gqgKBpDEMzTV3R4mqwFuiahAsB21ZOt9GR/ONKCNXm2IeY9Or8LHchYJqGQ
         rQYlbBpVSzDoo7fmTICU9qRQx08ucpHdpWu+cPIdut/xu8OukuFhOCrFRl0+i+5oD/wD
         oXOme7/qCP5FLgkVjyAatBiAS5X/6urDkc6sWjf6jmTwcd/2C/4a7nHjMiyOTCPAkEMu
         c7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727376189; x=1727980989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWABK7jevZz6PaZEJkjW9C/kJozsqZzz0c8Gpnqfp4o=;
        b=JNWUmlLHHazTWlaSHIP4C+oUzdhBHAtWKKYCLS9JApoCfM9+RJ+lQu1JvdHBbB/c91
         AJ0pcPDLO8GTxIJKtXkE8VMtogjJhXlybEJ9WV4SR5v+La9mJ66XDPxltD17lj/+Ad86
         66zbUoFQZUv1rus9+EDcdn0hTrK5N2E+8vmnVF5u3fWWpfKYvKCrZO2GT0lmy22yOQHO
         YIpOXwAyoPPzWNWbsECy+sD3xz9E8guXYxrV/wBcnbb7OX5PZcE+YFXSborXUm+Y6xdY
         XOR35bVvg4IAcRiaFUSbQF4v35ksPtMuxeJpIuaYRUXBIP3ZmCZJoPlOlXhPTEotdrIw
         1WiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX61iLdB912MwsjQJyN/kgMgY/f7+Cnm3wl/NrAl8CfdxL4yCAE4Gx/thEfxMuoUy7+2l8hXIbZTsScexA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eZWR7IKnxZKp3C9d+FF42VcI+4JQF1aDgGGMGwJCFjVvFfly
	lbOS5nXlFhoKizVRf0YWbaziQr5O/7MNu+4Lx2c2i2Eesis4i51rzxzxtIBwZ7k=
X-Google-Smtp-Source: AGHT+IHlDIyeTzt5qrb/mt8UJBp4ewh+Zi6tjiab4F3KqBIB1hz93JrCVMgux1Kls/nP3C6CgkJDFw==
X-Received: by 2002:a05:620a:2956:b0:7a9:c146:a9e9 with SMTP id af79cd13be357-7ae3783b6d1mr78752785a.15.1727376189046;
        Thu, 26 Sep 2024 11:43:09 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2f5e89sm1346751cf.55.2024.09.26.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:43:07 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:43:01 -0400
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
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Message-ID: <20240926184301.GA883850@cmpxchg.org>
References: <20240925192006.GB876370@cmpxchg.org>
 <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org>
 <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
 <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com>
 <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaRjrPTdCCAA0zSVyAZ2sCKiJUC36J0fsajdtp1i_JZeg@mail.gmail.com>
 <SJ0PR11MB56781678BE55278052EB590CC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB56781678BE55278052EB590CC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>

On Thu, Sep 26, 2024 at 05:29:30PM +0000, Sridhar, Kanchana P wrote:
> > > 3) Keep the approach in v7 where obj_cgroup_get/put is localized to
> > >     zswap_store_page for both success and error conditions, and any
> > unwinding
> > >     state in zswap_store will take care of dropping references obtained from
> > >     prior successful writes (from this or prior invocations of zswap_store).
> > 
> > I am also fine with doing that and doing the reference batching as a follow up.
> 
> I think so too! We could try and improve upon (3) with reference batching
> in a follow-up patch.

Yeah, I agree. The percpu-refcounts are not that expensive, we should
be able to live with per-page ops for now.

One thing you *can* do from the start is tryget a pool reference in
zswap_store(), to prevent the pools untimely demise while you work on
it, and then in zswap_store_page() you can do gets instead of trygets.

You'd have to rename zswap_pool_get() to zswap_pool_tryget() (which is
probably for the best) and implement the trivial new zswap_pool_get().

