Return-Path: <linux-kernel+bounces-232772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB3291AE23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1CA1C23CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD31519E7CF;
	Thu, 27 Jun 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fLKsoOZf"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CD19D8B0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509595; cv=none; b=PHTv5LE1hg6nvMEYZNj9jABIt1V/QgUSNdrmgsoQ1sOuP17ECTCaNt+m/glXqdagfm0MTvYAPNFuACWl9OuSl2xeFOJCopsZdVoNBRevZL03gexsIcOoSBf3UiYln/Dvpek+/3PM45j32wSMuK7Zjx8LehdQsHLPJNc/4KTCC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509595; c=relaxed/simple;
	bh=ilNgfoUNhiqDFM7H9poy1i0P6oEaujTeCAqucYSt1cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V46GWiyYH147xtjcdcFJpjI5+XXsybDHQc6W3UqEigYhL1zHIIQpDHLVPwha2LF3JBSffC2JqRKSGoBnnxNZAfxzjVr7a+f4z0BmLkhUkqI5d+nc45biusIYOI/UA9nQlmbtUq6XUKCVr3ZFlcpqzki5NH/LNe2BIHcATj+h8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fLKsoOZf; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: maarten.lankhorst@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719509591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr0TR/1FJaHH3ED2Gg8EsjtN43r2N2jhIFfaVjK+ReM=;
	b=fLKsoOZfoseTaxxUSUzJuxD+k9IEgMWnvbjjxqtg/OrcnHyqUX9qp1tbvuE8zcJlwqiwQb
	84rRJrF4qI1qsDXzbtV+ThZCYs8lI+Ylmi1meFS5UblE2HzVtFJajNDNU+DdfCJqO9mafK
	np2J+8e1AKLwM0WPMmrijVaBEje7zWo=
X-Envelope-To: intel-xe@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: friedrich.vock@gmx.de
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
Date: Thu, 27 Jun 2024 17:33:05 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/6] mm/page_counter: Move calculating protection
 values to page_counter
Message-ID: <Zn2iUQ4xj0ANHHs6@google.com>
References: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
 <20240627154754.74828-2-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627154754.74828-2-maarten.lankhorst@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 27, 2024 at 05:47:20PM +0200, Maarten Lankhorst wrote:
> It's a lot of math, and there is nothing memcontrol specific about it.
> This makes it easier to use inside of the drm cgroup controller.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

LGTM and I believe it's a good thing to do even without taking the rest
of the series into account.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

