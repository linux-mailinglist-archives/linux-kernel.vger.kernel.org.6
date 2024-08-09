Return-Path: <linux-kernel+bounces-281327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1794D590
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC78F1C2163B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D897316E;
	Fri,  9 Aug 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WAX3bpE6"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD26EB7C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225231; cv=none; b=pBnHUEmgLtPMeQt1zaTxmGdEC3N33IYPPZcmJSlHIjEkQJw2WTkjRJfMndgJfLRUoMKgwcJaH5ZtU4bchMj+onpn2pSWIMmWYIySFetTL7tgdzw86Pb44mD+8lfdmbjkNXhyyVqQbMP55UAbEGMGoW5j6iF2t5MpaDfHgbt5glI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225231; c=relaxed/simple;
	bh=mF9Rk9UqbmddH2smTFIewfkoo/OxomFe3j12CQIP7dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0er7oe0C8RLJaHtaR/kbdey+iGPaym5RqLKTcMTEGu4YWQavr0K7XJTfxdz5jIEiqE0I9kdiIzZ9gr6xJdHud1+0OuwOAlSOQu1qY6Niv1/37pRlntE5wQFgQ+UK7ni58rj5PKszwhK7FLGANz/AYOebbtHYBKYWZxDkE3PYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WAX3bpE6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 9 Aug 2024 17:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723225227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZCWqUJK1VMH5hpb/vZy61pLLKoniqi353OrzQ8BqKc=;
	b=WAX3bpE6p029ttYrP+yP1vcSR460iwdajJcW2JfUHhq9a82JkEst55U6Eu+IDbmaYGQFr3
	JiLzr7LrNqvB05t+iEJYSshX6a9w+II7kLc06TESg9F32Zv0d2lnepiW4PwSGl/MqHhGL3
	B297zGfB7RPgraQ/Cm2OO+ViUKJgLE4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] memcg: replace memcg ID idr with xarray
Message-ID: <ZrZUhrqmvFsaEteu@google.com>
References: <20240809172618.2946790-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172618.2946790-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 09, 2024 at 10:26:18AM -0700, Shakeel Butt wrote:
> At the moment memcg IDs are managed through IDR which requires external
> synchronization mechanisms and makes the allocation code a bit awkward.
> Let's switch to xarray and make the code simpler.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Sweet!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

