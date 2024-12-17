Return-Path: <linux-kernel+bounces-449724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE5E9F5543
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3180B174F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD951FC11F;
	Tue, 17 Dec 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fH9xRZDk"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080A1FBE9C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457688; cv=none; b=HgZ4+N1xSHNfcf3dMN7zuZIbzt99rwJEQLLf6wn266WJfRa7Av8jhTw/yB+ZnPAnBFEdJJ7pXvHsLugfOMYBLGgUJYsv9bfhFI9jcVf3QYmWIcUUKKScHGq/uiHRPyvnk5K6gF8amtnr8MmfWP16YL4sLgULkpSN+EtaMxnzZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457688; c=relaxed/simple;
	bh=bU9kVcUsKePcvigwedGvucpKD4obOjOWqJAu+K1QXWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRN3Zh/ut3nrS2gVBUXK97B5oUoIetyqr6Kz4AyZNQ2mQ2LywXx7JvKsuGtCmRXiuY1Ohqtv6oaudFg1VOvdNjtJl6b+Z0oR2VqjmeQ0O4n82yWKtQka0HSWcmBWg/Q1aGDDUmkN1JfQZM27Z7bgbaMYSJE7fglSHH+oI5J5z0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fH9xRZDk; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 17 Dec 2024 09:47:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734457682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efnYIenBfJcT4zbjbUdusYKdPVtUJ13mjfZw0f3fRRI=;
	b=fH9xRZDkXZ1XJHghzlEPi3AXTRpW+CTSdj+Cj9d1lcBApm4zr6uOMCdQu0fRy72Axz13q8
	U9PP4HejLIIfRSdazBr0XfagLapij+ZVhrMVU+zqMkqF6WeD17BfreuAjcGPFx13lSD/XU
	yzyQ6XFf9LLzRL2tBlrhJEPyoRMlRl0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [next -v1 2/5] memcg: call the free function when allocation of
 pn fails
Message-ID: <jhxvqez42uun6chdhftvnaezpmgbn2ab34cfmhrirxc6pcovpv@kc33zutsybl4>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206013512.2883617-3-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 06, 2024 at 01:35:09AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The 'free_mem_cgroup_per_node_info' function is used to free
> the 'mem_cgroup_per_node' struct. Using 'pn' as the input for the
> free_mem_cgroup_per_node_info function will be much clearer.
> Call 'free_mem_cgroup_per_node_info' when 'alloc_mem_cgroup_per_node_info'
> fails, to free 'pn' as a whole, which makes the code more cohesive.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

