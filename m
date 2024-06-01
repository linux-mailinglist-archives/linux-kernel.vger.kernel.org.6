Return-Path: <linux-kernel+bounces-197742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39088D6E93
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DCE1F28710
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCB31400A;
	Sat,  1 Jun 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DxyqmQxD"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11617C9E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224565; cv=none; b=bHPCetyRy+xybVS+TYThZDt9q4zUIJgeATaoPep5DP79blikr+mWhEwv3702AdLtdHlkxk0Uk5KP4dhZjhhNHuVSM+K9JAK6oSbxsNv7b7W1huTmkglVca50pgGgCNcEBT38OgP8bcmwXvh9hdOgVy9wFDXWKaCnY2Xt5cn+xQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224565; c=relaxed/simple;
	bh=wCefhD2srO7xg/h8vn0cb2zyIuJXAzC2b0N+uBH4/aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsjmRW4vHHpyrMjkF+lofzANDQ1qndVwvcocbJKietZ7QzHERmC1J3ANcLJ2VpY+wRW9TLXl/AnnKtfo3XzaDrw+N2g733nbtAPq62+D1ICpevY7pVPMItPfwAMaIp5lXxjtvpLAKK598fdOxw5o48CQdSV0UtQlrqwpPsFah1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DxyqmQxD; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFeVHAVe3QyyFy3gh1qZrlzcbYqqcFF34o919TbhEYM=;
	b=DxyqmQxDsUFhdVL38NzSb6GiBJ0xn38DRQgfZd+2Dfrjm9ClJgrC0rxuMnMGNStIagh2uE
	SFcdEtD9ms0sbxhN2Sy5BY8b+h4ZRAe+F6JRnST/qDiEpOEIw5zPHr1LMlmknLDauRVBg0
	oWHMYNl35P9G9rrRkc4rUnDtV/dHbWc=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:49:18 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/14] mm: memcg: group cgroup v1 memcg related
 declarations
Message-ID: <tii3atomncglrc7bao7qyrgmyhlka3m57qm22o6ycb3aegbvma@4v4nsaja77ev>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528214435.3125304-3-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 02:44:33PM GMT, Roman Gushchin wrote:
> Group all cgroup v1-related declarations at the end of memcontrol.h
> and mm/memcontrol-v1.h with an intention to put them all together
> under a config option later on. It should make things easier to
> follow and maintain too.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

