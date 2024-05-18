Return-Path: <linux-kernel+bounces-182790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D878C8FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BBD283147
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86682DDA9;
	Sat, 18 May 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ulqVIej+"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B97D51C
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716017587; cv=none; b=alzkp0VRjPakBwzXvqQfU3Jk3jo0bqMMMcyT6tgcF3AlPFiL1g1j7oHJX1nymeFVg6eotRP2ZEe+G4i6bj7ZV6PQvco9XIkdo56I6uWcZS6rGa5iWccNJleN2uW0AjynyXo05y/bFNalD9IQ3XIsStATZQmGuW9eBuDC+PUW+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716017587; c=relaxed/simple;
	bh=2bvL15eNALwn6baM/WUVHgL0dyYkw1ubeeQnda7LtZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn/pIq9dpEnZZjbtlPC1IqCvFGBXV2pLNsPVk4FPFnreWLuMEdpPa0kM2QJDRoaZTBYoU8aJsTjqb86odMBcxPuNHgQJZOxw6IbONhFflmf719cF97cGycXg2x5+NWWesa4jPsFROO0TPie2Q+wGRiBcLhKUaaC6MfruJhFoayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ulqVIej+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: laoar.shao@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716017579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqPyvdWYTMHcHihrv+EK/h7p68sko7PuO9n/H1g00I0=;
	b=ulqVIej+JwhAAQkqV7OUeeEqnGOoh4rkXTdANOPQOyyoA+fW23umXjRuhWZ81N2O1RAarh
	i/7tc2pyx+R/X4runtP5kLsQhBj4+3JeXMJbGK3G3d3MWT8z15HheiFp2DcV1fIWLbRyWX
	UNRHz7L2KtPtUEd7abcQ7zVAk4XQ8wg=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: gthelen@google.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: chrisl@kernel.org
X-Envelope-To: ivan@cloudflare.com
Date: Sat, 18 May 2024 00:32:53 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gthelen@google.com, rientjes@google.com, 
	Chris Li <chrisl@kernel.org>, Ivan Babrou <ivan@cloudflare.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <jllnyxah2czkca4bpbaqshksdjqk7lapgviee6gyajlqx3pcon@qwrf5ooxzrim>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
 <CALOAHbC0AATe5iMAm84Y_obOs4ePZYEW3X2a2OmjTCt_A3xXMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbC0AATe5iMAm84Y_obOs4ePZYEW3X2a2OmjTCt_A3xXMQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 16, 2024 at 11:35:57AM +0800, Yafang Shao wrote:
> On Thu, May 9, 2024 at 2:33 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> 
[...]
> Hi Shakeel,
> 
> Hopefully I'm not too late.  We are currently using memcg v1.
> 
> One specific feature we rely on in v1 is skmem accounting. In v1, we
> account for TCP memory usage without charging it to memcg v1, which is
> useful for monitoring the TCP memory usage generated by tasks running
> in a container. However, in memcg v2, monitoring TCP memory requires
> charging it to the container, which can easily cause OOM issues. It
> would be better if we could monitor skmem usage without charging it in
> the memcg v2, allowing us to account for it without the risk of
> triggering OOM conditions.
> 

Hi Yafang,

No worries. From what I understand, you are not really using skmem
charging of v1 but just the network memory usage stats and you are
worried that charging network memory to cgroup memory may cause OOMs. Is
that correct? Have you tried charging network memory to cgroup memory
before and saw OOMs? If yes then I would really like to see OOM reports.

I have two examples where the v2's skmem charging is working fine in
production namely Google and Meta. Google is still on v1 but for skmem
charging, they have moved to v2 semantics. Actually I have another
report from Cloudflare [0] where the tcp throttling mechanism for v2's
tcp memory accounting is too much conservative for their production
traffic.

Anyways this just means that we need a more flexible way to provide
and enforce semantics for tcp memory pressure with a decent default
behavior. I will followup on this separately.

[0] https://lore.kernel.org/lkml/CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP0tfNkXUE+Uw@mail.gmail.com/

thanks,
Shakeel

