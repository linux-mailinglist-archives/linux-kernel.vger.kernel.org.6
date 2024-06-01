Return-Path: <linux-kernel+bounces-197740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FA8D6E91
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1298D283F30
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EDE14267;
	Sat,  1 Jun 2024 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GKQjlWQx"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D792134BC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224523; cv=none; b=iuSq79fzE7q+O9Wid3ADbkEYkwYJh+f9BmcZHpga66Vy88qRNSPLRKJoVXnS0EUjXaHyOUdjpB4NWoThmDMNmjHA9ojqJhVolwVGN7TC4MBpC1MslUhsnoormcqHJZ1VOA1MFbiBG9+DmtfJ6X75YJME24jLGsguxOJfMbELZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224523; c=relaxed/simple;
	bh=Nk71eLU871Feie6hrDkuP5dbhlusx7WUZKLXxN8oyPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7Amcciuunbvgqs9NrDPIDYngK96PruvOWuUwnB2ZkNR5Pe5RCNGWiPOfbCJOea31kpXMWN+sKaTlTQFKzKeYU3I0IQRfPfvtn9gd3BSNFme3oWLjw7+qexxsQJvbVc3Rv1NiJqmagv4toUAfT6U0bHkjXvnY4ru8nlYm4kzZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GKQjlWQx; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YiUL2R29JoxdNM8UlUnf8ZJvKxjaajYhyu88LjrF9qs=;
	b=GKQjlWQxRZOnEWcHhLQyY+ukIPZUZESR3UXduwz/C2SEq7C5XcP3e7Qv61wCiEjECVw1+f
	YIDt3W/kSDpOVbDzaWFI3FH/ohcR3PgtLw6PNOteCjQNpjDEc1RGhgqrPZAP9NgQL/beFT
	R3fynSdiLXqt7DGhvYHs3qS+sXN93MU=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:48:36 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/14] mm: memcg: move cgroup v1 interface files to
 memcontrol-v1.c
Message-ID: <mtfsd2ua6qtunatp5gl7f35q7xqzx4djbdfpvnbftk7aflkbpg@ugambtdqktxx>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528214435.3125304-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 02:44:31PM GMT, Roman Gushchin wrote:
> Move legacy cgroup v1 memory controller interfaces and corresponding
> code into memcontrol-v1.c.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

