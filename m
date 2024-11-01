Return-Path: <linux-kernel+bounces-392886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191D79B994E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A368F284D05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B51D0F49;
	Fri,  1 Nov 2024 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="optB9GpO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059914D2A3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492304; cv=none; b=Og6Eq9EPeM22k9rfutZdb9lISA8+hXSG7uW6dAVD+YkYTIA4piWeuFzn0CNLiuDxax7FHgRY5Pym1PZd/TeWuddTsO7kOmoC1cel1qR80yc4cLClzBh7wPvskWeeqqhx66TNjIdmlsgQJu5Z3yC3iB+aksmIN6EVpsKF7pY7syQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492304; c=relaxed/simple;
	bh=3niQJRfeMAv1aG3UhC/TpWIF1y9l1iMs6JvNlIm3gMc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hdspJFUknMcoR8aHthfpQsj8QcDxPQnvjnNK1cpZVx0T+MHWjDhiO7wfbanjiDyWHZUpLUQSr6NxrFx9fEVkfB6nlrAhlWK7SZzGLs5xWqaa1w5K/l8ZFvGvEPeRZO9rGBjEqbWJTG4nkrzE+8QYLtHge5NyPDqIFFHFkXbwaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=optB9GpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E29AC4CECD;
	Fri,  1 Nov 2024 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730492304;
	bh=3niQJRfeMAv1aG3UhC/TpWIF1y9l1iMs6JvNlIm3gMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=optB9GpOpjFo6e5iBqp/A+Sq0fTtBaxYMCWO+5lsX/diiOk4zZ/r4NF+v9NtrS8WO
	 JF+p5xrdoODLebzBJ8Wzec9XKC47pFFTfR1x8K3hVWIPp454P6vhMbp5AxkkdoF6n6
	 zOItQwLfk5hwYwuKUqWSdiXZxateVF6Yf3jSwcDE=
Date: Fri, 1 Nov 2024 13:18:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: mengensun88@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 alexjlzheng@tencent.com, MengEn Sun <mengensun@tencent.com>
Subject: Re: [PATCH v2] vmstat: call fold_vm_zone_numa_events() before show
 per zone NUMA event
Message-Id: <20241101131823.03e5e3e643f3dd8077f9924e@linux-foundation.org>
In-Reply-To: <1730433998-10461-1-git-send-email-mengensun@tencent.com>
References: <1730433998-10461-1-git-send-email-mengensun@tencent.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 12:06:38 +0800 mengensun88@gmail.com wrote:

> Since 5.14-rc1, NUMA events will only be folded from per-CPU
> statistics to per zone and global statistics when the user
> actually needs it.
> 
> Currently, the kernel has performs the fold operation when reading
> /proc/vmstat, but does not perform the fold operation in
> /proc/zoneinfo. This can lead to inaccuracies in the following
> statistics in zoneinfo:
> - numa_hit
> - numa_miss
> - numa_foreign
> - numa_interleave
> - numa_local
> - numa_other

Maybe we should backport this.  Please tell us more about these
inaccuracies.  How large are they and what is the impact upon our
users?

