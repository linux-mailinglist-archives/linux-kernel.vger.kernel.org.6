Return-Path: <linux-kernel+bounces-377877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EF9AC7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6FC1C20B33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A51A0AFA;
	Wed, 23 Oct 2024 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KYZFKdtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA0186E40
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679266; cv=none; b=R8w9hhTCoSNtYosUaOfxWrrSfjYWtdtYjev9VfMpLZozZOP+0CSnZIj17JDkWk2DkTN5i1gRNt7NRnZRztA2styy9ud9VkMLrQ9vwGg9A+oBmSZKb7AgRV+GtbtEnftO3jv+enGdMw2KcDhXKZ9HuHSS4TNnYqfAOEvYDeoU+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679266; c=relaxed/simple;
	bh=+a2THu3k5g0s7vgeFB0G4UC22zi05HNxEYaMBCxse0k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MxfchrDRTE7UybgsBcToUv37gB5rpIJU9uuax6waAUP0JrfRtGGdeLbHHdijW4yDBwumdA8+m90HCb5ENsaj3tSP5RngQ+vOg9Pq+GY3ITCVkLgG7r/EuUiGYC68GFHabJSca0ZqlGQx876F6dKfyHR/dsrE73nbPFfItEkGYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KYZFKdtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABA7C4CEC6;
	Wed, 23 Oct 2024 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729679265;
	bh=+a2THu3k5g0s7vgeFB0G4UC22zi05HNxEYaMBCxse0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KYZFKdtEBKZdLVzJq71uEWbaA9sb5ynU8TiUmzammXaISDadlOc2r92Ppxi/JAD8m
	 z0fYUi8v8ajy1yw54tzLeFELQ527m6kGryNk8i8zY9c8yH4IS+QgSBLKgBYmcaO4uh
	 oHwRYd3bh5KmC05qo6td2vmFDMk3b5cQZPNpBIm8=
Date: Wed, 23 Oct 2024 03:27:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <kasong@tencent.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, Chris Li
 <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, Yosry Ahmed
 <yosryahmed@google.com>, "Huang, Ying" <ying.huang@intel.com>, Tim Chen
 <tim.c.chen@linux.intel.com>, Nhat Pham <nphamcs@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] mm, swap: rework of swap allocator locks
Message-Id: <20241023032744.84a6a9f6f5f1e3aa1fe5f0d9@linux-foundation.org>
In-Reply-To: <20241022192451.38138-1-ryncsn@gmail.com>
References: <20241022192451.38138-1-ryncsn@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 03:24:38 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> After this series, lock contention on si->lock is nearly unobservable
> with `perf lock` with the same test above :
> 
>   contended   total wait     max wait     avg wait         type   caller
>   ... snip ...
>          91    204.62 us      4.51 us      2.25 us     spinlock   cluster_move+0x2e
>   ... snip ...
>          47    125.62 us      4.47 us      2.67 us     spinlock   cluster_move+0x2e
>   ... snip ...
>          23     63.15 us      3.95 us      2.74 us     spinlock   cluster_move+0x2e
>   ... snip ...
>          17     41.26 us      4.58 us      2.43 us     spinlock   cluster_isolate_lock+0x1d
>   ... snip ...

Were any overall runtime benefits observed?

