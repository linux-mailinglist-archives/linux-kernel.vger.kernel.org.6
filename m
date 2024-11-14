Return-Path: <linux-kernel+bounces-409582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984B9C8EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B082866D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A21A3035;
	Thu, 14 Nov 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbrTtIq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826818D65F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599204; cv=none; b=EuzdFf6dhQiaH2VQdknXcY2Yat8xD+wENtBQ9TomlQ906HyM3HoGtoHYoj4UrKHKHCGZnsOR1VL74QXFLZkqjLE4Rbc+FXEQQBAmfW5ePqlYzePT6l2LfjQQ2vUIGoY9QMobuhnd5PTXGdH4yqWahjj8CzCM0zuYyovXJvr3GU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599204; c=relaxed/simple;
	bh=ACn7OzEQUASlWmmsTog2lco7stO6Qltx2th3qYoOkoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDN+EMZo6JinSqUzrw7x45TAxowESGTkSyHGKOYOEJYdZNslc5gu1Oultqa/C3EPS8y6un9s4kN3/c8b/aL7nZnoF0wUHoMg93Xddv1lMWvckdjtQllxhmKd2Fu7CWXwIgghwqnrcw74uT5NpNSoglZ4gQIFhBGePb9MxLHtGl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbrTtIq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EF1C4CECD;
	Thu, 14 Nov 2024 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731599204;
	bh=ACn7OzEQUASlWmmsTog2lco7stO6Qltx2th3qYoOkoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbrTtIq6U+SkHk4LIfsoahzxfRPjE2rDkDkuOKvNkbtCHPbzKb/dSztCQRqMuN3ea
	 soL5aYPJCv0h3VPhbqswHg9jc9ThHyVMu/3TCmYwsihE8fBjO3q6U6JCa8j466D9Yg
	 PaVM7uXNubCK+EGJfkvUA9eOOyzJtjMFRfu5sjKmCuW5+II+Uc0A6T/CLArC4BAegC
	 DHGFOcM9i3jRBhQ+RySEH8Srckl2WTrwnps5yWi1xD4e7/7yWYCUKE1UF3hBLA7tim
	 /IEo6gw76E+jBe1uuLKp2n+NUAlkWovfqVBl1lYb/2cRA9g8aSzWfMaO+sKYXmnCEd
	 KjpfrN/Op76Uw==
Date: Thu, 14 Nov 2024 08:46:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?Q?Pawel?= Anikiel <panikiel@google.com>
Cc: bob.beckett@collabora.com, axboe@kernel.dk, hch@lst.de,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzYbYSTiMddjuVjF@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241114113803.3571128-1-panikiel@google.com>

On Thu, Nov 14, 2024 at 11:38:03AM +0000, Pawel Anikiel wrote:
> I've been tracking down an issue that seems to be related (identical?) to
> this one, and I would like to propose a different fix.
> 
> I have a device with the aforementioned NVMe-eMMC bridge, and I was
> experiencing nvme read timeouts after updating the kernel from 5.15 to
> 6.6. Doing a kernel bisect, I arrived at the same dma pool commit as
> Robert in the original thread.
> 
> After trying out some changes in the nvme-pci driver, I came up with the
> same fix as in this thread: change the alignment of the small pool to
> 512. However, I wanted to get a deeper understanding of what's going on.
> 
> After a lot of analysis, I found out why the nvme timeouts were happening:
> The bridge incorrectly implements PRP list chaining.
> 
> When doing a read of exactly 264 sectors, and allocating a PRP list with
> offset 0xf00, the last PRP entry in that list lies right before a page
> boundary.  The bridge incorrectly (?) assumes that it's a pointer to a
> chained PRP list, tries to do a DMA to address 0x0, gets a bus error,
> and crashes.
> 
> When doing a write of 264 sectors with PRP list offset of 0xf00,
> the bridge treats data as a pointer, and writes incorrect data to
> the drive. This might be why Robert is experiencing fs corruption.

This sounds very plausible, great analysis. Curious though, even without
the dma pool optimizations, you could still allocate a PRP list at that
offset. I wonder why the problem only showed up once we optimized the
pool allocator.
 
> So if my findings are right, the correct quirk would be "don't make PRP
> lists ending on a page boundary".

Coincidently enough, the quirk in this patch achieves that. But it's
great to understand why it was successful.

> Changing the small dma pool alignment to 512 happens to fix the issue
> because it never allocates a PRP list with offset 0xf00. Theoretically,
> the issue could still happen with the page pool, but this bridge has
> a max transfer size of 64 pages, which is not enough to fill an entire
> page-sized PRP list.

Thanks, this answers my question in the other thread: MDTS is too small
to hit the same bug with the large pool.

