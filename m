Return-Path: <linux-kernel+bounces-400386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4497A9C0CC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CF4280F69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE4215F72;
	Thu,  7 Nov 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MAdYMJm1"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E7216DE3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000048; cv=none; b=IJ+ORgDIpKS17D36Ov89yLf2GJeVQ9MiizgmdN7d5A3uVgK8GOVx8aqaHGm68npU39kpcPaOwqdm2bNfQfQusGHfbBrPx7y03PXBFjUSYCuUAi80xJKbJWD+vcYunc+gRAgcussPtfxMXPeNafJTEjJ2k1+5CDcyWWOhme7w1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000048; c=relaxed/simple;
	bh=NWy1k2ajGecxUgECeWiryokr5VaLgiZuNpJFls/bP2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACyV7UpYMZjgICqMt9FhFmoOqk6JhqXObInwwmp7ijOaKkrHcKF5olDIrOxt+XVOsvJvsp+oDmE+WoMZY97doJ5YlGGfQVgB4i+7B8cbvL0TlvLFaYK2xlZYTWLdmGXIsQfhD/92SYi6MJFyKsx5B9sl0aMoBxd+Ovm9BwHqNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MAdYMJm1; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Nov 2024 17:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731000044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XoHYpA8iXkJZMGQIiPzYVfYCnRL1iJl3BQzdgU5nsiA=;
	b=MAdYMJm1p1sccNMtQagg8R/IwIAMpGR1nt0c/ub84+i8L3H5Y47qRxb6kEbMWouK283wcT
	18OOBnsphHRc8URbqAADkyeuMV2IGnOf4sEEds5rPal5ZYBQAa5WgVKL+bACfCDCoJIn1+
	5fDY2sjd/dGnbu99fjyT1djeNeeLVZE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Keren Sun <kerensun@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: Replace simple_strtoul() with kstrtoul()
Message-ID: <Zyz25iRusud8K664@google.com>
References: <20241104222737.298130-1-kerensun@google.com>
 <20241104222737.298130-5-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104222737.298130-5-kerensun@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 02:27:37PM -0800, Keren Sun wrote:
> simple_strtoul() has caveat and is obsolete, use kstrtoul() instead in mmcg.
                                                                         ^^^^
									  ?
Btw, did you test this code? Shakeel was poiting out that kstrtoul() might not
work here, is it false?

Thanks!

