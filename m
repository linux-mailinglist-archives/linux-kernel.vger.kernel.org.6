Return-Path: <linux-kernel+bounces-565224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B39CA663EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342613B070E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7432E628;
	Tue, 18 Mar 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tpDQgZeU"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4094D528
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258396; cv=none; b=c1YmKYP39jl9CKqv7cgppokp39voa0I7izrMoZ+43nmrDBaTC8mr17HcQiJD24Xc7eUy4bXFLX+J8xOVuKRrpw9/Bl8F/OvJrRLrEPNLNflTzRPW/a9/IoKc5SC81tWYW4HuKBfLxkNeoX5SQ2Gq/1lkpuYHsA2QvwlwWUa5haI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258396; c=relaxed/simple;
	bh=VDRgrq6SeDneb2tbHxKdELOf0YB2jemcAqQsWOIp2K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLKulfX99Uo5G47/KrkTdB2LwGnyB2I1DEyAR8JolzlxowdKVY7F1i2grGplisRk7A3wN1tC+nI4Pn8yYoFY/Wn/soiLkdvkIWlpaNOXN1geQ0HaXU2lZaues2QSuqrzGOdcIEfdvu1VDboz5jHbed3JbsQStu4OQSdWmEOTJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tpDQgZeU; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 00:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742258381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qPpSP6otarbWII6cyL7gSIoTwMVNkvwYtLOrfib4Z4=;
	b=tpDQgZeU8UCZw+cngpLMixmKOWekZnUpdCJ57M2vkEl1OxgpkhbDBJsGvO4ZwtBLYdLziu
	eBxOZ7oqGyq3Z9VqW/afj915cRf0V2Bex6Zc/G4V05QEObht+53yFfOJ9qbCJRmpMQBJWm
	3UkHzqw77Y1T73+5B2fR3mFgV3gBm+4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/9] memcg: remove root memcg check from refill_stock
Message-ID: <Z9jAyDIbNV87Ys6l@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-2-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:22AM -0700, Shakeel Butt wrote:
> refill_stock can not be called with root memcg, so there is no need to
> check it.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

