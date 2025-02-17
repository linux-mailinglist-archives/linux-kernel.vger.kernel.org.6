Return-Path: <linux-kernel+bounces-510266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72771A31A78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2135F166DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86FC4C85;
	Wed, 12 Feb 2025 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cLrGgEw7"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F315A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320184; cv=none; b=QKfEpsqYTzRI83ebHT2NgTwvsvcDtw5pKGWxYG3cwKPFtQKHx62XISmzKo5OLCuOpUr8gerqF8r4P6/w8PmQw3LwC17UapPCpViH6LoS4qaUKVg43ckKEmd6gtCQWJtzTSB19RWnBS6g/Qkk/wkvtTsMSZLt4bSlUwMBR1Mkp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320184; c=relaxed/simple;
	bh=jq7uTPn+Iv4Xm5aVRvpQt4SSgigZZlT+HInGRWEapas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7MMfWX1yFKMW4Tw7D/DnPgmbLTbV4jCCTRoJE2ajxr5My53+tlfSF9YLZwxOctT/8z7RsjQmwfV6IDS1+XxHMfL74flEPQVmTn1oGa8AmKzWospKj+hnTlHAlEEGj7ipOFuQUi0ymw0Lzya3M9Xrf/8QmXES1YPHW0oPL/nOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cLrGgEw7; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Feb 2025 16:29:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739320179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Qe89LtFFrDTAdD/f3HzKX0QL5OVcJ2KZ0CqRO/I52o=;
	b=cLrGgEw7xHtISE4cNFN/zCLSIMPAt5jzelKswaFPczelMde5Uo+XWDR7Exry0QwvQXjcV3
	nHjysNULme+ssxC2SLiQcQKkCxXBhfNn8MzYpBYV0H/zAh2/XI+BvrroJz0j4VXxqfkxCn
	66BMWHAM4YyW+Dr7LVCFSW4zKIg8IVA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH] memcg: avoid dead loop when setting memory.max
Message-ID: <24u7qp3ln2qaenzsdf6y4wimj4cbsylgs37ppex2jbq2hnonnv@m5hnbr7bz2t3>
References: <20250211081819.33307-1-chenridong@huaweicloud.com>
 <gf5pqage6o7azhzdlp56q6fvlfg52gbi47d43ro7r6n2hys54i@aux77hoig5j2>
 <Z6u0o_xr9Lo7nwh-@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6u0o_xr9Lo7nwh-@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 11, 2025 at 09:35:47PM +0100, Michal Hocko wrote:
> On Tue 11-02-25 11:04:21, Shakeel Butt wrote:
> > On Tue, Feb 11, 2025 at 08:18:19AM +0000, Chen Ridong wrote:
> [...]
> > Wouldn't it be more robust if we put an upper bound on the else case of
> > above condition i.e. fix number of retries? As you have discovered there
> > is a hidden dependency on the forward progress of oom_reaper and this
> > check/code-path which I think is not needed. 
> 
> Any OOM path has a dependency on oom_reaper or task exiting.

Personally I would say any allocation (or charge) has a dependency on
oom_reaper making progress (but not arguing on this point).

> Is there
> any reason why this path should be any special? With cond_resched we can
> look for a day where this will be just removed and the code will still
> work. With a number of retries we will have a non-deterministic time
> dependent behavior because number of retries rather than fwd progress
> would define the failure mode.

I am not against adding cond_resched() which might/will be removed in
future. To me it is just that we are leaving our fate to cpu scheduler
here which maybe is ok as we (MM) do it all over the place. Anyways no
objection from me.

