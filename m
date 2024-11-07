Return-Path: <linux-kernel+bounces-400482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C79C0E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B276B22F70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4941721733C;
	Thu,  7 Nov 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lt/XvT3v"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517CA16419
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005907; cv=none; b=EJuU5UPMCS5/nslD1JG/c0TESx3yCH4y0q2EtJl/75lBefoGMLHQxhtvdRuOn3RcUotF5gkawN4pwIN3HvNIulN3sxMg99cPuavPUKZRgfmYqOLzL9yizFTgxW19Zzycv/CaKiMHaXl9Oy4tGCR03KQo1lyu1EmKOda6UCwrPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005907; c=relaxed/simple;
	bh=9fMixngrHAM/325reFg6t7w02F445Bowh3c/p/itGUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJQJdGndnkciWk4LpGxR+HDAu+/7cH/+1ufvxekRHxl7rflH2Dqdb5NHyL/4h1vrVhSxhVDZdG+5VaZWplxhfRLM4oq9cWASW+LUcTopdcfLoo659uBnWe5ICeZoJQzuZ3uy0Fd1FSbpDonIbYbXKsnP15p09dsXg/AwyK/6l0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lt/XvT3v; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Nov 2024 10:58:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731005903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oOrEHRshDF9blVgV66yZ84VAGXSGB+VroUL5spNDfyI=;
	b=lt/XvT3viqqoO4qw155IHqD/uzvQ8lQGEBq4ok96xykQQflmLF+gKGfpOiwZ5o2M+/fmhd
	Znl3cQI/dA9BGrheuG8Y+SLtTNe+r1c/7gA04JpVWkmMQWGrOdk6Q8Ne0avPzFdgStcKPQ
	lWqD8OJVLsK7Ers/IZG4RfrL0k+Zk6E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/2] memcg/hugetlb: Deprecate hugetlb memcg
 try-commit-cancel charging
Message-ID: <sb56cs5tsnuwkfkfxvp34o2rt5r4z6b5l4jukrst2htvpvb62l@axbbmg4lpf5l>
References: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
 <20241106221434.2029328-3-joshua.hahnjy@gmail.com>
 <o7dpwewfztqpkidrhvpdm57ikid4yswygag5gkjplfwdfkl54l@bs6oh2t4jp7z>
 <CAN+CAwNSMXP-Z5PVL_Q129nN-aP80XB0Y-Sm+C-XdHBinvWoxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+CAwNSMXP-Z5PVL_Q129nN-aP80XB0Y-Sm+C-XdHBinvWoxw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 07, 2024 at 01:27:53PM -0500, Joshua Hahn wrote:
> On Wed, Nov 6, 2024 at 6:50 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Please cleanup mem_cgroup_cancel_charge() and mem_cgroup_commit_charge()
> > as well as there will be no users after this patch.
> >
> 
> Hi Shakeel,
> 
> Thank you for your feedback. Unfortunately, it seems like even after this
> patch removes the references from hugetlb.c, there are still some
> references from other files.
> 
> mem_cgroup_cancel_charge:
>   - memcontrol-v1.c~__mem_cgroup_clear_mc(void)

__mem_cgroup_clear_mc() is gone. No more reference to
mem_cgroup_cancel_charge after your patch.

> 
> mem_cgroup_commit_charge:
>   - memcontrol.c~charge_memcg(struct folio *folio, struct mem_cgroup...)
> 
> In fact, in my patch, I add an extra call to charge_memcg. I think for this
> case, it makes sense to just extract out the functionality from
> mem_cgroup_commit_charge (3 lines) and expand it out inside charge_memcg,
> and get rid of mem_cgroup_commit_charge.

Yup just inline mem_cgroup_commit_charge into charge_memcg and remove
mem_cgroup_commit_charge.


