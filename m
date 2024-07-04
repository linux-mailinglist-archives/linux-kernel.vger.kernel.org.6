Return-Path: <linux-kernel+bounces-240411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2C926D52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5401F22117
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B034101DB;
	Thu,  4 Jul 2024 02:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gb1sfqYr"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E123BB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720058814; cv=none; b=XGCx1VGHQefvog9nyK6ld2yiOLRjoxw9mUrpPuUz2FsL+o+9RysbR8PEYypr75baVkoL2HLjrnFPh2I0YW2NQDJSwhqr7H06/Uo14ndJ2jLOFwnJl/E0Fatj0OFadVNbFw+qdnK19LFX+wnZw6Ei5uVYnZeWIVTzqi8AaunKWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720058814; c=relaxed/simple;
	bh=E3d7l84lzNbDD2UP6qVkK0EGsQo5RiMCgO/zi1dIGgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFTfPkc3vjTvCZMIh/vcxZslszfweHXzi5zOZ/517V9g7jcrjYVtRELVH9RbBTDuXuAUWvcVYnH5EchPgNvp56cJGyYrIoDEnZiYqh/k06vR/4IblKkWhM/YyHCidvJnrRhn+48KwVIwZoGP/bbqkr6bPfHtoWNMWmnpdd6rveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gb1sfqYr; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720058808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKBv5U41uQIoh1OWg83ciI9iZQQe9QfjrQtrgnHXa08=;
	b=Gb1sfqYrGurbYP8fLRtjQPHiIaijHbvwaJw/MAg3uwREwJaMKru7WpzIaZHszeUc5HoR3C
	i3nGv8aSJhHyfU8Ozt5aNV4xGwacxzEMa5U70gc+j7j6pFzklDfcqOZ97MBT9JLK6+8sBR
	OdeVBqwH+biSdFTwmFeq+Na46V8qyak=
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Thu, 4 Jul 2024 02:06:44 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH] mm: memcg: move cgroup v1 oom handling code into
 memcontrol-v1.c: fixup
Message-ID: <ZoYDtLXte9OvUC9e@google.com>
References: <20240704002712.2077812-1-roman.gushchin@linux.dev>
 <20240703185250.ab96286a5e4747665520ddb0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703185250.ab96286a5e4747665520ddb0@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 03, 2024 at 06:52:50PM -0700, Andrew Morton wrote:
> On Thu,  4 Jul 2024 00:27:12 +0000 Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> > This is a small fixup for the commit
> > "mm: memcg: move cgroup v1 oom handling code into memcontrol-v1.c".
> > 
> > I forgot to actually move two functions mem_cgroup_node_nr_lru_pages()
> > and mem_cgroup_nr_lru_pages() into mm/memcontrol-v1.c, so that they remain
> > in mm/memcontrol.c and their commented out duplicated versions in
> > mm/memcontrol-v1.c.
> > 
> > Andrew, can you, please, squash it into the original commit?
> > 
> 
> Seems this wants to live behind "mm: memcg: move cgroup v1 interface
> files to memcontrol-v1.c" so that's where I placed it.

Right, this is the proper place for it.

Thank you!

