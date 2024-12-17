Return-Path: <linux-kernel+bounces-449722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D19F553D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5456188D3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED641FC0E2;
	Tue, 17 Dec 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ThbVEsqV"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDC1527B1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457662; cv=none; b=lPoQSrAlcG4euEGGt5NgSzJ3/PJfwY87Dw90NxyxGssEnKt3jcigIxRMpXPFiR9oPoz2xBZ/QvJdUkmEOlwVIR2lLtil1pL6sT82YZ7t+kWqy4G48ZUvDsNfKssDoGkIqJA579c40OufqUoyfgSZHrK0ymiYJdF5Grz68GoOVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457662; c=relaxed/simple;
	bh=nAhnRDYH5N9e9AsjkG0LCK1Ez9FQFMjqHZOKdMPC40k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw6R/igIZ0X3MIoT+Od1CoyldAWru6wrxYsGg/p1cCVUYutD5bvYRc/yY9LVmgq2GmYszBzL19kwFQIGgFf9Fad/WtE1ICzqJG2RWAC4I5GhbTTDzrIOnFIf/33kYqiritvHgSbUq/0DztFVH40t3INHTAg+I+Dw8ah84IjjwaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ThbVEsqV; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 17 Dec 2024 09:47:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734457648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oT6qdtt4X2SclLzmcXRZduUzcDzTjo2eXbPGBENWVY=;
	b=ThbVEsqVkf95WzUk5bKSc72HXekSTw1guo5ila3Hxv9wAGBxCFf+KtMqCN6YnrUFSJSdan
	hF5KxuRSidKFxoNAex0UIz2d8/n0f1WDG2IpZzPt5UafxBgKJ0Tox2KTBEVZ461kXNBiwR
	7LzftM+UoYgn4VD2dCj5QSJmKnW//Co=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [next -v1 1/5] memcg: use OFP_PEAK_UNSET instead of -1
Message-ID: <axqbyleou7rovp6ib4urclqlxca6sotwopmtf6gxyezbeaom4q@t3s23xq3ecjl>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206013512.2883617-2-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 06, 2024 at 01:35:08AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The 'OFP_PEAK_UNSET' has been defined, use it instead of '-1'.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

