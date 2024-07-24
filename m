Return-Path: <linux-kernel+bounces-261569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3E93B925
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3404DB24000
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D8913C827;
	Wed, 24 Jul 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mmr7L5Ue"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E0200B7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721860229; cv=none; b=OLSRDxDV6VQXamLy0adcoC+Sx6TlFZufwLUOixb1wLNME+P+fSkoJ4+kdmy/1g/VrVhfly7bq/7dCdzcgmldT2fBZ9ZZ2t1ZeeHLEDcZW/A+cQjdAZI6FKycpTAjSl0v7rRBO7tIgKymJi/qkSTkFfX3PqVG8AaNiXVn4hBUV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721860229; c=relaxed/simple;
	bh=bvi9mK+EPThkHTU/y8w5kznnYPEhSuJG0yLC5ttT2M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlWe6QMUh73JG7XPdJBZjTdQjlVdvhGYz3Yl/bCpNbgY0iv9zterh/q3CpFPoMDdsJTlTOYB2mXlzvCljfGvKJqq6cOkgVKsYIxWQ+UBpz9VYtj42SHcXaeSA7gBQ+pZItqqnkistgdBvnqApK7CwLG7LzUzTM5Jlv/ds+Qvhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mmr7L5Ue; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 22:30:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721860224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1+7tb1zJfVKXYFl1W/OBxgR3CK0WzX6eMljJr7VTIQ=;
	b=mmr7L5UesEKCeuh5HNhue1UoJ2koptmUqTF63POEost+NjHXzZGCV3nb6hDplpa8QoaPb1
	0yaS34pheIj8q9txcFoULAsq2Gvulm8YIFGVEMnDD5//UsESvAvHQrCvbiAMyImvA2GsRF
	B5a2kX+kqzUqw2A2Ohc76f/WYdsPTvQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 0/5] This patchset reorganizes page_counter structures
 which helps to make
Message-ID: <ZqGAehI3Fjr3EpMH@google.com>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <ZqFmu9qmRiVJfRg3@google.com>
 <xjrklql4khu6csizw63kznudhiwithh5k5fqw6krscu36mwac7@ufivi4ivxumm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xjrklql4khu6csizw63kznudhiwithh5k5fqw6krscu36mwac7@ufivi4ivxumm>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 03:17:43PM -0700, Shakeel Butt wrote:
> On Wed, Jul 24, 2024 at 08:40:27PM GMT, Roman Gushchin wrote:
> > Ooops, there was a formatting error in the cover letter, my apologies.
> > 
> > Here is a fixed version:
> > 
> 
> Hi Roman, what is the base of this series? Is it linus tree or
> mm-unstable?
> 

Hi Shakeel!

It's a today's snapshot of mm-unstable (d8492982371a). It had some
conflicts with the recent memory.peak series, which I resolved today.

The whole series can be found here:
https://github.com/rgushchin/linux/tree/page_counters.2 .

Thanks!

