Return-Path: <linux-kernel+bounces-260263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D30193A522
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9FB1C20B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09297158206;
	Tue, 23 Jul 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pzv7MCOl"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B948381B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757172; cv=none; b=O5PQDFgKOIcjTNywUfzy1ZWqifkucoAGkpyMnVR3GIRxQ+IzeuHEt/3DI+OuqoYwiCvSW8t4TPakcm+PiLB8qVxl0fgZoIJ26OXSl3qdUFa5KZw3ZO6aVUh2jZ+07FDTrLXU1VrSHWE84LhcRNC7APhfTGeQ5LvNk2GyeTpN+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757172; c=relaxed/simple;
	bh=mfoP2knn51sYFAt04IF9o4HdkHWPSVa7roiea8R3jwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf1yItryTM2BaN3NuZFYebLnav+CtI40dN6SNJF5OKmb0PGqhNn80+RVEjpxg20WzMIys0uEmwdMUuAb4UAqPXFLwRzxdYdvEJCS421atlvgZ0ODnZAkSTJRZXA4tDAoLxzcbGrE+5R6BNUnyq8RsINMZh+rr20QcTVplFuHX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pzv7MCOl; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: songmuchun@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721757167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZbuquas1x4ekbGGCHs5sl0uYWYOmkZYmxi5weGyLHg=;
	b=pzv7MCOlKa3poeF9ON9PQQt6Jbxsr+ATv6w5NP7DoQTF/P1VHJQpdDot/z1yron/pqLvYZ
	JdYBz/piBlBkq8sXfu23Wxx6J7UZXQ9Pkun7tZrbVUCnuUKudlbvMcEdRQYvlJWvGE62QJ
	1jXS75c8pLk/OM1rZEemTcNAjLjyeJQ=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 23 Jul 2024 10:52:42 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev, 
	nphamcs@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
Message-ID: <nrtjxxhblvuzkv6sytcjay7qr64jozdbp2klipoo2a4ddqe7dp@gufvv4uen76q>
References: <20240718083607.42068-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718083607.42068-1-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 18, 2024 at 04:36:07PM GMT, Muchun Song wrote:
> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
> lock or cgroup_mutex or others which could prevent returned memcg
> from being freed. Fix it by adding missing rcu read lock.
> 
> Fixes: 0a97c01cd20bb ("list_lru: allow explicit memcg and NUMA node selection)
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Yup I noticed these as well while reviewing Kairui's patches.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

