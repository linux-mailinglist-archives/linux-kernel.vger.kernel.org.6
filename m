Return-Path: <linux-kernel+bounces-442211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F519ED95C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3001885D80
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931EE1F0E5A;
	Wed, 11 Dec 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qv5X/xPv"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0811F0E59
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954794; cv=none; b=maVeDqnVc6ufaKS+bdjc2qt+JkfJsgekmelkkT1XGyHyJPmHRqxCiZSqwwa+gU2oBG5pz1azcSqxrdWpZZkMTZm0Z5jJncvKEY6+O9ywzK1nccDMsRWlO6aniCE/nzMMc+Mw+75CZ3adQkdf5mkl+vJh8lMreMwO+8VfOzYPiHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954794; c=relaxed/simple;
	bh=4Y3BkeZQ8i8Lo7CakpEfxhL7Ipz+fw24L2kNf5tu4mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iE5Wq7l4CEm55RXXBJxMBWGfu0/RR0R9OkyfHFmgP5vxIfhBdL8rAcHaMX/PEZKe2Q//tHYpY+aswDwTiOHb5dQJ31cVlPPnl5Rl+bu4MErHWnn7U3lourtYidEhwc8XIS2El1Z1EKTFTppJAF3cN2bsMCIsofP1OKrMl69Zkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qv5X/xPv; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 14:06:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733954780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VOfl11aVQjjQ03B4nJjzJwNXXBd1opTt5mcv9gYqzc=;
	b=qv5X/xPvFcNThlC4whgtE5EK7P/ICRK4K9ngyzwR/+55o2KfZZv+DejqlzqwCMHPg5gn1a
	CWuw9DDMMvxLNQGUjCwOxR/yf6OpRmXKiQFjVoKjzIgYpvm5/20GkeNKPrel56IAUrmNJv
	m7iakyyuA9HPbe785cfT4HR4bJZ1+pA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, sj@kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [v3 PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Message-ID: <bjsf7brb3i5fc4druf6k5bctmolii3af5bvhcyshjbx7zgwxcx@oa2gsqcyaacl>
References: <20241211203951.764733-1-joshua.hahnjy@gmail.com>
 <20241211203951.764733-3-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211203951.764733-3-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 12:39:50PM -0800, Joshua Hahn wrote:
> This patch introduces mem_cgroup_charge_hugetlb which combines the logic
> of mem_cgroup_hugetlb_try_charge / mem_cgroup_hugetlb_commit_charge and
> removes the need for mem_cgroup_hugetlb_cancel_charge. It also reduces
> the footprint of memcg in hugetlb code and consolidates all memcg
> related error paths into one.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

