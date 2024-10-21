Return-Path: <linux-kernel+bounces-373737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63E09A5B94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E0EB227F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADE1CF7B5;
	Mon, 21 Oct 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXNRwU2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB361EEE0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493577; cv=none; b=VCDgg7q+oSDQw5Ylek7nNyaobCM4rIXM91XztxFAHVz6vGNIlW5hIEIYs3rPo82l4tQsS2V67TA/I1eP0HWQiqTFUMWwPeAbF0g/KDMUTt66/px1oXk6gtJEGtzz45BvAkDwrtLn1dWnvYB3LiVWnP41u1Nyt5Mh+9d5JaW56Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493577; c=relaxed/simple;
	bh=shrWs5ZdC2pxJCkq1e3H8dJaoNXPUr1+2Lc68OLjoiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzhgrbEzFd5FOKuHCy8JYqUskPq7I7JeK6aNDTe6q0Q0NAvP5dCGbuLkeotbGGWvwhnqktUSVyZs+C4r580axP5doaeX7Y6q7DbU7iJRFGAOTJ4IlSDGP4qkqAwqR8FHr0XCdubpPQnQJdZNUdUcAUSpa6Fahb0v7r8V5/a+Yn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXNRwU2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8DEC4CEC3;
	Mon, 21 Oct 2024 06:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729493577;
	bh=shrWs5ZdC2pxJCkq1e3H8dJaoNXPUr1+2Lc68OLjoiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXNRwU2wn7bfygsfAOPH+VWCoffQkJS38RsAe1n20pnnn0ROoZlI4+pAyzWZFzCId
	 bbZs1R4Xp8lb7xRUgPxPsNxZdI/IyBnW081IWRM0BjGdRxGjxQNY3agVLAkQ0mhQxF
	 nFiFYvE7CFrnP20uElnFLtXcUrojOmYReDX1b0wzmQPy4tZn+BQYGfUzt+LQ/a59/h
	 6Jxungc8Ct6bwRGxMyoegl25uowxlUT1/1tD7lbw9ppwIHzOnHaYaBJCI8sLxbrvlc
	 eSXK1lKuNmaL2LM5f5WaSSArVInMV6gCWHI8yzDhnDSIZdALes59xv4hqMXO6KAFtI
	 gsg+X2qHjcs+Q==
From: Mike Rapoport <rppt@kernel.org>
To: akpm@linux-foundation.org,
	Hua Su <suhua.tanke@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE
Date: Mon, 21 Oct 2024 09:52:42 +0300
Message-ID: <172949345149.2327149.636551407707863142.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021051151.4664-1-suhua.tanke@gmail.com>
References: <20241021051151.4664-1-suhua.tanke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Mon, 21 Oct 2024 13:11:51 +0800, Hua Su wrote:
> Currently when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the reserved
> pages are initialized to MIGRATE_MOVABLE by default in memmap_init.
> 
> Reserved memory mainly store the metadata of struct page. When
> HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=Y and hugepages are allocated,
> the HVO will remap the vmemmap virtual address range to the page which
> vmemmap_reuse is mapped to. The pages previously mapping the range will
> be freed to the buddy system.
> 
> [...]

Applied to for-next branch of memblock.git tree, thanks!

[1/1] memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE
      commit: ad48825232a91a382f665bb7c3bf0044027791d4

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: for-next

--
Sincerely yours,
Mike.


