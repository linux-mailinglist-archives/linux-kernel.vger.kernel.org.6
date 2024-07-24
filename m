Return-Path: <linux-kernel+bounces-261522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F793B83D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08F11C21673
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B1513A878;
	Wed, 24 Jul 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="reyjS0CG"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C029139588
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721854269; cv=none; b=pkhYk4SEtm+LZl12R5bIGNjU6AutT+gACcZTye8IkXQq6FEaWaLvNx0A359/RlEEKyy4aSu69MUiR19jWBWFWDaTyVv5gUd0rWeIoZYNuc7Lo/4VmOq1FyiYgpKe/8mcaSljSKuhPN8Llezkov4LkcXhqjArhbscoCPU6AKsSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721854269; c=relaxed/simple;
	bh=vcBNtVbJq0cyA1bCH5rtXZRIzK5kfFE154DHBEggBpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqk4iFiuM7XesllJO/ostQO0NLcSjwzmJ+WZ2FgEKNNUw+aawAIiKUQUsznGkRAZHIO4yrPRxYFb3r1Xj9D6VVpqWZzpuvcHfD/y2krBQWKtZGC7lYtVWhyL2PBrcC4ctejpwylO1QJKjbhSX8pfj+JYa2HteA42SuKfDDMevnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=reyjS0CG; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 13:50:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721854264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0pNFmegU0XmQr4Ys2XdcaQR7r8bIi3cAPICsGOQcws=;
	b=reyjS0CGYs1l4OybR2jI0OOEUvIknZiGjy5an7+t6O0yAGPnQzQ7L+9CbRDHqZR/v1fbx6
	m5x/I1Ixgjx+itcHZeVVhHRRfkFik9SbC4oWRptsZxUeTg6qTEly+k8tBPDYiJNQiMLWo9
	yCjSSoPnT8NKe6OlPfyiQwTfQ7ZWo1k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 3/3] task_stack: uninline stack_not_used
Message-ID: <grznsm36eydexh7q3fpt57cd5w2g72mb57s7som3wf6c4jt2j6@komzdw3zm2lw>
References: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
 <20240724203322.2765486-4-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724203322.2765486-4-pasha.tatashin@soleen.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 08:33:22PM GMT, Pasha Tatashin wrote:
> Given that stack_not_used() is not performance critical function
> uninline it.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

