Return-Path: <linux-kernel+bounces-428474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B059E0EF3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A044BB24EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A1E1DF25C;
	Mon,  2 Dec 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qn9sRJku"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823491D9A66
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178878; cv=none; b=ikrMr/qDyEeByDeYBZE8nMz0mdcFKwxDBw1n0oXpd8o2wt0Fq6O9Uno559rcG0J/A3ZZ+ODXhCRMg/SdTcrJ2/VVbpx4W9nODerETWT0byWrAG33WJT3b8MA1BndnKTns4JL1h5n6iFEXMVRjVtmMEoTCJg9wawy1jPQp83G7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178878; c=relaxed/simple;
	bh=pem5nMsBafgfmcP4xk0Z+dmNlQcVqNzi9zuqcAwY36k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg8o+lOX8NKWP2VSTvhuXgCh7LBixPYvfhmQ3Lj50WbYVZHKsz3PIubmYBZVB6Y7WgWoHReHvwXwb/TIANcDhISbCok3/2/UOt7tLdGYMWwZ5UgI/LEKnFK5GIAs1exQ+LaPhC2k+4bQl2yAIqKMyb6olfFUta+sPa96NKvAzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qn9sRJku; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Dec 2024 22:34:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733178874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvQKDP8zKQB3VtJG2ovDH9nhW9dfc2QHBmy0Thx886A=;
	b=Qn9sRJkuiaVZ0k6XPwSZxxrfT9huo5/iiMggxNOQle/89PswbF2/zCepJ0eF/SoiP4KduN
	Z8lyul9u5jXHqLrdWiMdt7h03asoatNt2C1OTORDzCWAr000VhtXkXJ0ib/A1blxk8boWH
	go5ElbUKwXbN4kRqjAn5e43Pm8Af3XM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm/swap_cgroup: simplify swap cgroup definitions
Message-ID: <Z0418j_FHJ2V4fJC@google.com>
References: <20241202184154.19321-1-ryncsn@gmail.com>
 <20241202184154.19321-4-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202184154.19321-4-ryncsn@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 03, 2024 at 02:41:53AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Remove the intermediate struct swap_cgroup, it just a unsigned short
> wrapper, simplify the code.
> 
> Also zero the map on initialization to prevent unexpected behaviour as
> swap cgroup helpers are suppose to return 0 on error.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Please, merge this one into the next one, so it's easier to follow
how the end result looks like.

It seems like v2 is coming for the next patch in any case.

Thanks!

