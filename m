Return-Path: <linux-kernel+bounces-327046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3708C977029
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A25A1C21EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298471BF7FA;
	Thu, 12 Sep 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YP0X0jAn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15011AD259;
	Thu, 12 Sep 2024 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164752; cv=none; b=kF9bv7qdl/REFbYAeeE3MW/H54069bU70NRADCJtlr6If43A6CWqrogFITceDzXR949LQTLjMmV+QSXrP4Z/tA6mT8Zh1SopDOywqNn0iwsuNGL3tqyeyFF07RYTJNn/q2O5zHiUoGO7RKnk3J46vFy5cXNkhlKOnUMevhmKqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164752; c=relaxed/simple;
	bh=5xw5wcKw0bx/SehfWnLI3WPXlhxSxpz6OpGObcpVw3M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U888s/zA93Z480WcpKnOJy1Bvix99v6F6ITC0/YJfmhWGh7lHv8+43datEahCbshS6ed2XkExnb+lZce9sK+53NAJtFwqwDTW+7/sE9/MovYQNppiE+76l5CyTO8cD6HhuyyZXiIGTJFO3fJdOIq5gX4UHKfja0BaTZkktUkMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YP0X0jAn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZWg4fzThkUAPtUZdkubgnYlit17W1nPn1wzF4GRd7HY=; b=YP0X0jAn5B/h6rYRUbg74qSeSv
	hC5NSHhc3oeweoY0PYld9DNROHmpGoGOdjuhI+F8rZW+FtBvrzWGoHnMDljJGBP/UeSi4q+mqVNuC
	4RprVkjhORPKjwr74TLYNqIbw25rtj/RM9G+k3rQALnY6XlP2qQR9BK+8O1Apx/nijKtiYrUKmH5k
	tDTh7BvIKj0cchoKuCWbDd8KSWwizzYq9vQjAXSpksnKpu8Ar/B6elOIVwlXicbO8huzV0FT85kQz
	LjArul3CYuvw03+lcKFbgdcut+pedd5DmO6ef+e6y4tWAwBOwSOINv1NVepsm+UDcZEn7KbMRLL/G
	Ry+ZsCbg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sooIs-00000009miL-1WYU;
	Thu, 12 Sep 2024 18:12:26 +0000
Date: Thu, 12 Sep 2024 19:12:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Helge Deller <deller@gmx.de>, Yang Shi <shy828301@gmail.com>,
	Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable
 stack
Message-ID: <ZuMvCjS8G5ggz6Hy@casper.infradead.org>
References: <ZuHtb43Ar21ZptNz@p100>
 <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
 <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
 <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
 <x2d4kyyeclp5fgeug2l3bjalp773ozgkl5vr5o7dpqcbopampg@5a3x2cr456qp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x2d4kyyeclp5fgeug2l3bjalp773ozgkl5vr5o7dpqcbopampg@5a3x2cr456qp>

On Wed, Sep 11, 2024 at 09:32:29PM -0400, Liam R. Howlett wrote:
> * Helge Deller <deller@gmx.de> [240911 20:51]:
> > On 9/12/24 01:05, Liam R. Howlett wrote:
> > > If someone is using MAP_STACK to avoid having a huge page, they will
> > > also get a mapping that grows - which is different than what happens
> > > today.
> > > 
> > > I'm not saying that's right, but someone could be abusing the existing
> > > flag and this will change the behaviour.
> > 
> > Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exactly that?
> > Why abusing MAP_STACK for that?
> 
> I can think of two answers:
> 1. An error that has worked without issues so far
> 2. One less system call
> 
> I'm not saying this really is a blocker, but the change is not without
> risk as it does change behaviour the user could see.
> 
> Interestingly enough, the man page is incorrect as it is written because
> the flag is not strictly a no-op; it ensures no huge pages.  So the
> feature of applying VM_NOHUGEPAGE with the use of MAP_STACK is not
> documented today.

It's a recent change and I don't think it's something we necessarily
want to document.  It was c4608d1bf7c6 which was December 2023.


