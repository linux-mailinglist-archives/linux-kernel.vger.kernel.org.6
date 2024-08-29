Return-Path: <linux-kernel+bounces-307826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D88965364
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6001F24117
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD818EFE4;
	Thu, 29 Aug 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k+YqNVx4"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2F189F5B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973854; cv=none; b=enEYo2UygtKdcnRts+sWrBazxhYHokJjbo3vqBOJqo+89iNYU+omfFv5pPgqRxiLm9VFMXN+zfkw0bUW0zqj/M6LHJ9I2dWCm7ym4gehCKRizvHgAW5MdCr8jAHYnRtBGPv6H5cW6tB9LRnMcJ5bvtrRo0nB7VYKMBIw1Ol3Qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973854; c=relaxed/simple;
	bh=jKPDWeiMHKgVnYkY6yCN53N1ZWijhwk0Dn7fBxJTQRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtgBVrk501JR7BUvfY/rY+7ZfkrPOf6jSDCivpP1rkp3FYiLIqyuV3vSwphL3nz+BHuM1+ZY4z+nXSDcg7OFR+Hy+XeVTqcH6VreZfBQ05jA1mdRhV5Pny8zg7otOFpGLQG7oOFsRZV1lA4VwtuQ4hcfvPSLdw8EApUtdRjjoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k+YqNVx4; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 23:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724973848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jz8aSj9+dgbv2VArjp9TF1rZbfkiiiWz3UWEm0k+qwY=;
	b=k+YqNVx4Y9uwvaC+F9+Rfpdqycl+3CxlDLIUqmig643TyTRNicNIpmUcKoKOpZ7bz6O585
	RoSTghhDwseKVS2xJc+uweIvze1TT1UzPCjtK6ldGUcvw6W4Mi3qbJzwhlCSlu8TGMagVg
	RtG/f1K7smpmIl4gAiuU3v48iUVrEm8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Xingyu Li <xli399@ucr.edu>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>,
	Juefei Pu <jpu007@ucr.edu>
Subject: Re: BUG: general protection fault in get_mem_cgroup_from_objcg
Message-ID: <ZtEDEoL-fT2YKeGA@google.com>
References: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
 <Zs_gT7g9Dv-QAxfj@google.com>
 <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 10:20:04PM -0700, Xingyu Li wrote:
> Hi,
> 
> Here is the kernel config file:
> https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> 
> how long does it take to reproduce?
> Juefei will follow on this, and I just CC'ed him.

I ran the reproducer for several hours in a vm without much success.
So in order to make any progress I'd really need a help from your side.
If you can reproduce it consistently, can you, please, try to bisect it?

Thanks!

