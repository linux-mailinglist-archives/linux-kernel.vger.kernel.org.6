Return-Path: <linux-kernel+bounces-269813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B149943717
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3569D1F22BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268B1607B5;
	Wed, 31 Jul 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="puEscK9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51538DE9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457706; cv=none; b=jzRGO3NdmPtx1F2mTH6TSFRpId7An5l3q7Gq/VjlGDSKK/x++/YxQJzEt8CLCuk3YR/uCf4cGw+bndh377OfNfhvs10n0YDHxLDm6HmYjOaKZZmWA3j9emMZnD1xkHy1f5KhBdkPN7ViPGuMm8dqk7pNoanEEUo3E9A1fLZxd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457706; c=relaxed/simple;
	bh=sjfnzrIaOBEDmgDxDGYx/ikjnMnZq3as0W+ndBUgLes=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FZ2dBaTqrNV/XAMJkf1iRSM05DRx4IEnM1wd+rGLOczqld3nzQyAu2HVIE74n5Bt7htwTG6n2NHGhsUMjITOB+e/T7oBZi5P02nkPa9f7GY5PhdU6r8d0HisvnDlCBlK/lxVgF4odGn0JIW1N3akIHjWwOhAusAD+IRzcL9cnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=puEscK9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC61CC116B1;
	Wed, 31 Jul 2024 20:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722457706;
	bh=sjfnzrIaOBEDmgDxDGYx/ikjnMnZq3as0W+ndBUgLes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=puEscK9/cc6dAhH5b46Y1zJJ4ujkuYILWwYuUEymnaYmaStTnpfl8QREXkgGWBlSt
	 PeEIUmnvh00G61c2G8lYsRso6mYFXLFCrMHqvVPKg5+SiNp7mEC9LQTpW04QY7AkcB
	 cUa0QkzxqwVK8W6CBcLOY2o6BTHKbbNWhUHzWyhE=
Date: Wed, 31 Jul 2024 13:28:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, muchun.song@linux.dev, nphamcs@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Vlastimil Babka
 <vbabka@suse.cz>, shakeel.butt@linux.dev
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
Message-Id: <20240731132825.1fb29122d35997a425368b32@linux-foundation.org>
In-Reply-To: <20240718083607.42068-1-songmuchun@bytedance.com>
References: <20240718083607.42068-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 16:36:07 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
> lock or cgroup_mutex or others which could prevent returned memcg
> from being freed. Fix it by adding missing rcu read lock.
> 

Well I grabbed this, but the review led me to expect a v2.

Should it have cc:stable?

