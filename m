Return-Path: <linux-kernel+bounces-199993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8788FA8EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588901F2577E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48113D63D;
	Tue,  4 Jun 2024 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jJoEt2G6"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F1320C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717473545; cv=none; b=hx/Mm6PYiyWkB5g5v+qrO5BMMonOpTLBC2DdhUNmu4lJI//Kmz/bQGs6i55jBM7biUHW7AadvCXfnZhTt1NIHgmfT8SeAkx7/U32Dax02v+zXnDMyNyKQCnK4lYc/ZnFUM3/7KJiafQgCd+4aUZExYU2Xnoc/JqKlCb2ASfPMOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717473545; c=relaxed/simple;
	bh=DS2P1V1LkWB8mLDkp7hPHOFr0WGw528BByGZ+JLq07k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAk1RU9fxjl8EE98+vqDXxYBWYFly0ROL3RRJ75ZxWKa3rwiGd4AJ42IqjBFfYWhJwJZ+JnchZuMTlIgWO4tr82OcOprJcSsTx1vIq5w6kVKE4ifDU6ZD43i6c7w0DjYR8P6ZxZDb6neYwj8qkGArr0QxCjT/T7EHzbzb5r+8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jJoEt2G6; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shakeel.butt@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717473540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcIwdhXjgCXM5nAKh4wQoHGkD9HOZr/S7iJ4JQ/QrKI=;
	b=jJoEt2G6Y7Lkt3dwCjuVZIex2E0FeFcllXzKOAPkGQ/qS/qqoAC26s8l2BunW5KlwcG9hz
	pVmqcmMUZ6XblLZ6JWjzVrYMd+k40C0pFm6RWuMZUgN/j3tzyoF79zyVjFf3KONtG5Tj7i
	++byTWplnKkCN7+yU4f0rHB19zgtvJM=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 3 Jun 2024 20:58:55 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] mm: memcg: introduce memcontrol-v1.c
Message-ID: <Zl6Q__XlEGcI9GpW@P9FQF9L96D>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-2-roman.gushchin@linux.dev>
 <wzdqwjtlabf4w5tpjmkcg5xkdw3wngvth3pcx6gbug56vlvlvq@bgswx33kuaml>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wzdqwjtlabf4w5tpjmkcg5xkdw3wngvth3pcx6gbug56vlvlvq@bgswx33kuaml>
X-Migadu-Flow: FLOW_OUT

On Fri, May 31, 2024 at 11:42:26PM -0700, Shakeel Butt wrote:
> On Tue, May 28, 2024 at 01:20:53PM GMT, Roman Gushchin wrote:
> > This patch introduces the mm/memcontrol-v1.c source file which will be used for
> > all legacy (cgroup v1) memory cgroup code. It also introduces mm/memcontrol-v1.h
> > to keep declarations shared between mm/memcontrol.c and mm/memcontrol-v1.c.
> > 
> > As of now, let's compile it if CONFIG_MEMCG is set, similar to mm/memcontrol.c.
> > Later on it can be switched to use a separate config option, so that the legacy
> > code won't be compiled if not required.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thank you for reviewing the series!

