Return-Path: <linux-kernel+bounces-428414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2566E9E0DFF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BEE164D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F571DF26A;
	Mon,  2 Dec 2024 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RQ+SisV5"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2201DDA0C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733175549; cv=none; b=Lu374EruZWZXk086wvfwecXpimwnps7ZkXOfUm2DEuqE3gfCwAkRbUyywx3+c/zNNg6HESTov90HZBxKW/nFVwDoRgUV49M6EAqqeAkk9Q7QCxwYbzghKM37qCyON7FvkX8WAHUmJ0V5XLyeprH18BUZjN8ytw19Q9YS720SkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733175549; c=relaxed/simple;
	bh=4j4h8EoqsvdwtLD4ZCknnrCqthJ1qg0jsDlOPCY2IDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBwaLW/1S3+Uu3Xpgxu2rqeAwJBsD69QI4YsCZa2w9/YhVrIhptj1dxH+DD5P7/1Jb+Cc3s1JZMylPVfjK6LJxY9KRUWw2OtfZYtCHoykLYO20vbUWT9Cy4i6w9GpF6+sMslQwTyx9sytTIV90GbZKBap12ANUCoRvPp5OwOMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RQ+SisV5; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Dec 2024 13:38:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733175544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Oj2ByodmMewfyDU2dNKBCKE3h7rRHaDvbd9tHyUCf8=;
	b=RQ+SisV5FvlNb4JT+g+Ey2+T00fBiff7V4TsY/V1WUnemJirGA6/XkU4QGxChS8kAUYI0+
	kGl9bj4NBXzAuPq5lCyd3411gZlJMFHyh2EdOFwMVoodXX7Mr7rge2ZWgQN+YGtlrHaM//
	CzM6vxhHECCJz5/7rs5tgTmkn38FNqU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/swap_cgroup: remove swap_cgroup_cmpxchg
Message-ID: <sfzsr7ablihvyicftjatb4e2tffs4klyvh4vbgz6eyzpie2bop@6zdhpx5cjre5>
References: <20241202184154.19321-1-ryncsn@gmail.com>
 <20241202184154.19321-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202184154.19321-3-ryncsn@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 03, 2024 at 02:41:52AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> This function is never used after commit 6b611388b626
> ("memcg-v1: remove charge move code").
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

