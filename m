Return-Path: <linux-kernel+bounces-261582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA593B960
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB199283A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31513D28F;
	Wed, 24 Jul 2024 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZkMBBFzh"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D192E639
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721862369; cv=none; b=h3hn4dXSRU/7DjwYS+x7G4inBAspLNxCpFJBuxFQwALqH/ps3NISnAIFAF2zQiGtqPhK4lL3w8DCf0QLcKbEPsxaeTDejxZQtDZWOURDGjbmGecrXw9H21dfppDBkW7KO7aou8VLfbiX/pNmR6BBS+9+fBlwrlCJI//efT1Vb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721862369; c=relaxed/simple;
	bh=rGk/ymb68rVvKryUgkGOCmFZhaR5JXQGAP6vW/0+hZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdJMOJhX7q0dWKeMT3lbpB2a1Qx8CFTmQKZmIU50eLzpEqCpIgpBEB7GfCYyq+U3IxazZnNjGKskdkGEzDDMmknVmTK2g1kA3uM+Ti5rWVQlRd6MofcsH5UclC13a0ABOKlNmnLzw8vjwhs9kUIfLy/ebwbjLyGURVYbwzkRgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZkMBBFzh; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 16:05:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721862364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCwW1B4j4daZChgkv/4PB5iP0RmvFspzyJbc3fZHbvs=;
	b=ZkMBBFzhdZrsmpw+0jWvtUWSbXctNHE7fSH9mtYTNYUA+/H1Qrow9cGOWySkOd3whfszQd
	DMPf6qLY4L1psXYnMmy1i3gFVNzHQTm7Pru1MybMpJMpNyLgyVzmvXpJ/cg4NEpzFIGWSY
	di60ZJxHNgufCdMlX8l+Mklez4GLjWE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 2/5] mm: page_counters: put
 page_counter_calculate_protection() under CONFIG_MEMCG
Message-ID: <judhtg6lth6zedqwzmskw354lti4dewcjj62mzln7kr7yyc43e@uy3qdzxxfbcw>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724202103.1210065-3-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 08:21:00PM GMT, Roman Gushchin wrote:
> Put page_counter_calculate_protection() under CONFIG_MEMCG.
> 
> The protection functionality (min/low limits) is not supported by any
> other cgroup subsystem, so page_counter_calculate_protection() and
> related static effective_protection() can be compiled out if
> CONFIG_MEMCG is not enabled.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

