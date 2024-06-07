Return-Path: <linux-kernel+bounces-206461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C89900A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6CF1C222C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03E19A297;
	Fri,  7 Jun 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sI7CHx29"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88626D27A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776836; cv=none; b=PmT+tHc17qiu+sxc/GG8GPud3TYNwVIdzzCk975y9Hu69kifbmUwV8/lZwlLdSRmpk/bf3Fxlpvy5NpHD/ozRuxAAVUz7xFIvN/qJUTsR8bdn8oN4mlmTjwRwBiwBnVJaxzs4ox2eyIHf6PXBmIsMuthqPhGlEA4R2/UCgiqlIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776836; c=relaxed/simple;
	bh=i7kjmoK+upx4SspGahALtIRUuewZKTQR7de4N5fMVns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWT3fTdfO6dyWH92/uHTqoNN8WQ6CAdjXEbgZ0uiPsbCgTLCHxjWH6xsnIoMpy5Ecju62QsnpNlAFfoVlz1PtjwBbf6C6APBDHEkLgL7xP9jBWRNiXJiUeKKFJZ7cHkB5S5v3PdyouSLkalU/kJIJYMfyPTc1KCCW0MAagVMTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sI7CHx29; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shakeel.butt@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717776832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7kjmoK+upx4SspGahALtIRUuewZKTQR7de4N5fMVns=;
	b=sI7CHx29xX/mmuu4bb6nGsD5Z3zAUrrf4M0sWy1/LSzvJaddLcsm6aP7AuTwf5FHbnprTK
	WW1HfULVD4lAP+u1ko2RO2AFwAziRZAp6QUPaCavq2ljblgKj+FD7HhfN5O6eJu7lfUhVj
	UB9nqSZdNs2U6WkQsamCJVmZwHL3U0w=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 7 Jun 2024 09:13:46 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <ZmMxuuSRUsPPqCm7@P9FQF9L96D.lan>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <b7qpa2ixaid7lucw6ebur5zljm3jmovpzhepf2rxjftg4zgj74@hr4rjh7uzyow>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7qpa2ixaid7lucw6ebur5zljm3jmovpzhepf2rxjftg4zgj74@hr4rjh7uzyow>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 07, 2024 at 08:29:20AM -0700, Shakeel Butt wrote:
> Hi Andrew, can you please add this series to the mm-unstable? Roman and I
> plan to add more stuff based on this series, so it would be good to get
> some exposure for this series.

I've a v2 with 2 minor fixes (compilation issue with !CONFIG_MMU and a small
comments fix). I can rebase it on top of the current mm-unstable and post, please,
let me know when it's a good moment to do it.

Thanks!

