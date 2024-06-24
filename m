Return-Path: <linux-kernel+bounces-227989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68B915973
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8849D284B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046DE1A0708;
	Mon, 24 Jun 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E5QYQsm+"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E412FF84
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266419; cv=none; b=fiKUwqt7JzMvG8PMyl83TPKW7dBBU0nXCYzO57fUvcwBaWMQeahCpBT58phA3PJ58CLYkkNOrsbt9mt1xM6E0kBQEjDzTUW5bQFIXyzq0KUf/JcrHclF6vt4+G84gvUgYVt/UvuhPR9PWPBndxH3Vp5zb9dWhvummzyti9lEqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266419; c=relaxed/simple;
	bh=sGLX8ANqfk13Aqpvatlj3ZsIXlkxmeR074PsHLYNWgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foNCYq3Lm7tL9xHQvfikFSVoC0U1eZcOLrgZ1mS1PF4kkhiksugSTzmQQ6TVmERji1EN7t0MDpxMJA/BfvPB96NWpDazuoVeBNRj2C+SK6ULQh/lLWz/WKkG+OxkqdnN7y42CY4mix/91SvspuvjO4XSjhPBDNpczW8KMLjPbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E5QYQsm+; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719266414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYDTl7welxlUK/fF0c1w0IHPiXkBBjJ3L8A3xBsmCXc=;
	b=E5QYQsm+XhjD5rxrYNeSoIqd3OnQ5IbC7UXcxOcx0xFx5oVaTNxjDNXwjPGacPgt7EAyfR
	wHKF8UyqyB5C8gEAAwU8WVdBoKPriUXQWUEmnpT1IDPhvZtO3eYAimXOG3JCHBJlUSSY9T
	+UuZoM+rxbKk0MkSScN+xR4yv9GCaEY=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 15:00:11 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <urejtto4e3zdo7tqosbh3xhle63a2frewfuc34sr5p7tpsxw6n@bgfkzfopefn4>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <b7qpa2ixaid7lucw6ebur5zljm3jmovpzhepf2rxjftg4zgj74@hr4rjh7uzyow>
 <ZmMxuuSRUsPPqCm7@P9FQF9L96D.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmMxuuSRUsPPqCm7@P9FQF9L96D.lan>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 07, 2024 at 09:13:46AM GMT, Roman Gushchin wrote:
> On Fri, Jun 07, 2024 at 08:29:20AM -0700, Shakeel Butt wrote:
> > Hi Andrew, can you please add this series to the mm-unstable? Roman and I
> > plan to add more stuff based on this series, so it would be good to get
> > some exposure for this series.
> 
> I've a v2 with 2 minor fixes (compilation issue with !CONFIG_MMU and a small
> comments fix). I can rebase it on top of the current mm-unstable and post, please,
> let me know when it's a good moment to do it.
> 

Please post the v2. I think we are already late for the next window but
let's request Andrew to add this to mm-unstable for the follow up planned
work. 

Shakeel

