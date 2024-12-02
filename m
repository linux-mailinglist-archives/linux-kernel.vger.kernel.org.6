Return-Path: <linux-kernel+bounces-428413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A59E0DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17942282143
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D91DEFF4;
	Mon,  2 Dec 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JymSMW4I"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82570800
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733175459; cv=none; b=kyLOwyLNSqNgT/QnDv0g9NJFmW5Rty2z8NqTTwZTZ87TdzvJUrM7UCRxv4sZVMc0h3QdD8iS4sVbMp+qNC68ORpA9zQwSBAwnA/UevHVdnm4KsF9k+Rr/ZXW6MobauPin+KkgfiFVFt1Si3RWEkgL2TDZsQHfxwMIxVM2cDJ3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733175459; c=relaxed/simple;
	bh=n7C8ENsI5uwMxz57pAdeu5FqrBr9TWc+c3w8ov1oqYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVWtRh2PyGKVbNtDHqfubRclKDLtHLR+tYuHQZVajmiCEYD3veYsdaOXt8lm/HcKlFh1/svWTCatS3gOEUsOOWdp74yIf+QdzAFPjb6VxQ1l/PnUIwM++1hTAHiiU00ZfXOS0qGhJu0DJexZSIaqRt8nsjw15bzDTSuXPpmeTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JymSMW4I; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Dec 2024 13:37:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733175453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rS/xTs1q2FTigZBKN3ODh3OSG4Flkh+mzg6839gOmpc=;
	b=JymSMW4IcCPLrqeskqJEQeEB2EbCtsbZ2AGUfXj3gnFYaFZpOQov2LYfv/sfMAcfDYhNJi
	EJGzBRHlBd/gVtjbUmk4128pEixg7E2vs9RtUK/5Y1+i8AyvEwrYvJIDCTRMgr5uTPXNCh
	Vukur/apyR5GmysnhiY7G9ntsOqIo4Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
Message-ID: <bgr4ihxolxxyx6bcyivzfb4p6ph5mp7qgbe7qnv6vuwvgbs7u3@faqkxjmmml7h>
References: <20241202184154.19321-1-ryncsn@gmail.com>
 <20241202184154.19321-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202184154.19321-2-ryncsn@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 03, 2024 at 02:41:51AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> mem_cgroup_uncharge_swap() implies a mem_cgroup_disabled() check,
> which is already checked by the caller here. Skip it by calling
> __mem_cgroup_uncharge_swap() directly.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

