Return-Path: <linux-kernel+bounces-342479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520B988F80
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B432C1F218C6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171C187FFA;
	Sat, 28 Sep 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="v4sy2/qO"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBD125DE
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531261; cv=none; b=ebUR+EaoWgdGn98NkCbbY6+hDUIcMzjpq08fl/KFTQHyCwqdk8ctQhfCYXD3spKg/pgO2OMgNp3XXThUFOEzmY40eq32fzFWx4EGybm3EIyoZycx+0M9BUQwsVP/nLK/X910kw3ucokfeHFV1T8+HbeIFTxd21YQGwT/O7ldTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531261; c=relaxed/simple;
	bh=wSyunZqT9eDOjHdRB52Grp3I0QIZsX3iSCetQ1JoP+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDANqBDAqHDsMFR6+zK4bFyskoIHwU1KxVPryE9I0oi56K1Rq//E/GB4+yIVM46mQ2kwpxL4ye+Nc5wJhGaR7/iLc6HGf6T/7UZBZcn+ommvGeoyJ1gV38hPQVo885C6ETMHVfvhPbupC16S6BhiY3CzJLdM+q6mUNocxLX5udU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=v4sy2/qO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45826431d4bso20557441cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727531258; x=1728136058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khoSGRl71etMO/s0bYkJkYQdhSsFb2b4yNg67LBVG4M=;
        b=v4sy2/qOrwnytwIZd/Y1ZvNam1bOaRc3i2gV8s4L0ShtUId024lObbSKo4AOQyi47S
         E1XBFLxFSgBK7JJw+/tcXpiYp4SSizI/iQSZjwoxeA01WmdoP7R8z7cZewhAK4yrIstP
         XRgdfwonygKArJWwJY1xtwd2fL7xDDFk2Ocl78+JEfD5KXg8n+Hvozpv404c2omBHcYg
         qhQ0HwzO+Genor+lD+/YxyGy4zF7zphDtC4gHUDshZJmbS1YIDRaDQJapfWZkK4KjugR
         lOtPQ5S+SHfJoNViM/9KQ6UCXluVe0OS48beHADWYmliTesRqRP38sELYf+WkgmnSJWv
         sAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727531258; x=1728136058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khoSGRl71etMO/s0bYkJkYQdhSsFb2b4yNg67LBVG4M=;
        b=wWSnEljR3TKUI/D7/mSmyWiio6e0jQwMGFiPsB/Q3jBvtYFGydXd/bI9JGpzD8g3mB
         ob8aRflluThEaWFaIdbWIYO5WyVcAK98Cjydv8wN5vVpFZGFoBYaZaO7meqz5MGclXtb
         DTz8s39RMOruBIbvDDkHXhUz92RxANy0XnItUArTqqOvPMJz841kveIzzy6uWsjGhhqT
         O/iVRjJoQXKzMF2WHknSsM2lZE6aFAGaMJbFg8D7yrpxaqm4wRYyg0vYszXc3Jarx079
         o0SMSaQudX0TMiFSl1Wdk9U9ssYikwAqJs5LKcAU/JbKWeKRVwjobPthk5yMEz4wEc8/
         zXYQ==
X-Gm-Message-State: AOJu0Yxux560iWaR3kWiB8waKokly0ff7O+E2GsyPuRbow5Xrg14lAEL
	dukYzYsLW2Nkt6qWxwnrYa6l1GCD3iJYXQWtSfhrBZ9h3KXrUE5LO/Tyb3lIu+o=
X-Google-Smtp-Source: AGHT+IG5cur4H7TXPCsaGrTV+Sv7uoqUUEnXnL5/Eewd6Rp/ABFkY9N4sX0YnP955vwj69c9o3rXvg==
X-Received: by 2002:ac8:7f07:0:b0:457:c74a:6384 with SMTP id d75a77b69052e-45c9f1e8b5fmr107843991cf.20.1727531258594;
        Sat, 28 Sep 2024 06:47:38 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f33b809sm17586391cf.65.2024.09.28.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 06:47:37 -0700 (PDT)
Date: Sat, 28 Sep 2024 09:47:36 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v8 3/8] mm: zswap: Rename zswap_pool_get() to
 zswap_pool_tryget().
Message-ID: <20240928134736.GC957841@cmpxchg.org>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928021620.8369-4-kanchana.p.sridhar@intel.com>

On Fri, Sep 27, 2024 at 07:16:15PM -0700, Kanchana P Sridhar wrote:
> Modify the name of the existing zswap_pool_get() to zswap_pool_tryget()
> to be representative of the call it makes to percpu_ref_tryget().
> A subsequent patch will introduce a new zswap_pool_get() that calls
> percpu_ref_get().
> 
> The intent behind this change is for higher level zswap API such as
> zswap_store() to call zswap_pool_tryget() to check upfront if the pool's
> refcount is "0" (which means it could be getting destroyed) and to handle
> this as an error condition. zswap_store() would proceed only if
> zswap_pool_tryget() returns success, and any additional pool refcounts that
> need to be obtained for compressing sub-pages in a large folio could simply
> call zswap_pool_get().
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

