Return-Path: <linux-kernel+bounces-192443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A785A8D1D51
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6297B2819A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A59116F27B;
	Tue, 28 May 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lrd4nMk0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7817C7F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903895; cv=none; b=mhGZUcHnfqysOSYNLm9o3s50hCkgWVmtE3I/ZW8cfMEFPPv+fj4u1l4gHaYOHJ41Ya1vsjRZYnZlVt4uFBY1IGTNNDlP1UODM/S+u+2jhqGrIfaT4EmdE4rNf0P1GnSNufQtcIhXVrsYKMCk1MT9yvH1zUHiJAEiS2/3fJhkRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903895; c=relaxed/simple;
	bh=9EqkoHYcuTnYOItA/g9YcyP8U6j3EYnq+T+pjK+6TR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKWhARMBo1QO3BmrL3ZnFZGaMPHGRUaBwnGgxsEMfKD6DF+uwdqAqI72VfM+DQFits3uoVFCcj+6iD8AOsyWH1YA3adZXzTCvjlxiUixDv/CFb6LPIFdFCGbx1zNNg2euNOPK4trGxRb5gqN7bFa+D51HOOSIRNb4IrTE8d37gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lrd4nMk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5539AC3277B;
	Tue, 28 May 2024 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716903895;
	bh=9EqkoHYcuTnYOItA/g9YcyP8U6j3EYnq+T+pjK+6TR0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lrd4nMk0sOgxul8v1Wq8ot+mopcU135atLvoBZLPdoY0QyJoRv3I9nK5Ghm9NMPZF
	 Y4nLBLlFe7ZKNzFTy7iyh7Qu0im5K6U/UsGHhkaZwVPVP4LNDACZszrFEA2tWZu+6G
	 U04QCPmaglotlnB5eby69bI2Dbrzbl9w/+8fmCvOOsTqGFleMGFq/xpd0E4O/7QtWm
	 13FHqFC0CpVofcYjt+aXqHMujeCx+URtEIfARZw7ZFugolZUo89C9OeSKSrGCR2+Wu
	 25+GIyCYQTbiEwtjQu5fpispaumM0Sar2GVpxafXKEuutDFZjpvWmGOjfE7Qlq2rwq
	 dRjE/7S+h3SLQ==
Message-ID: <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>
Date: Tue, 28 May 2024 15:44:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: Remove the lockdep assert from
 __mod_objcg_mlstate().
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
 <20240528134027.OxDASsS3@linutronix.de>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240528134027.OxDASsS3@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 3:40 PM, Sebastian Andrzej Siewior wrote:
> On 2024-05-28 14:34:55 [+0200], Vlastimil Babka (SUSE) wrote:
>> > The safety of the counter update is already ensured by
>> > VM_WARN_ON_IRQS_ENABLED() which is part of memcg_stats_lock() and does
>> > not require yet another check.
>> 
>> I think here it's __mod_memcg_lruvec_state() doing the VM_WARN_ON_ as we
>> don't go through memcg_stats_lock()?
> 
> It is either VM_WARN_ON_IRQS_ENABLED() directly as in
> __mod_memcg_lruvec_state() (which is special) or memcg_stats_lock().
> 
> Do you want me to rephrase this part?

I think just s/memcg_stats_lock()/__mod_memcg_lruvec_state()/ in your
phrasing, since we are removing the lockdep assert from path that calls
__mod_memcg_lruvec_state() and not memcg_stats_lock()?
Or am I missing something?

> Sebastian


