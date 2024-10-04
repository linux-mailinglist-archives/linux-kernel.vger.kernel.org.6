Return-Path: <linux-kernel+bounces-351341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FFF990FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080F61C23298
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4B1DF98D;
	Fri,  4 Oct 2024 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M1j5meyJ"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD81DF99F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070953; cv=none; b=JpJSBTv9xcTMbDAjZcGlqIAI65fM+zUi5YB6hP7TVvOAHdvMMXO7XuipdSiob2b6WLc7JMBMnxiENvRUSEjoh2T+C5j54Rj7eVeX9xH9M4+n9ddAJfSc0J0IZWWYHDvfWNoHU2CqkA/3gepS2E4hKGGwwZ99Eu0BoS0BoExs9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070953; c=relaxed/simple;
	bh=3/VrB9o+zhLDjzcxb9jnJ3WK84i1WOOkWl0GddOUpxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qDSPjvAtNMg3M3xzGu+eJDtsQ3rInKt7Hkpd61e2TfsJ8r80rtT1jVzCcDJdU4pH3h4Ho+ldoIPFEqKhXsJjn5pWjSjuD+eiOJMe1BhLeS/vwfQWvfAFq4Fzjc1uwEwU4g6vkq28PPICfXPyD1btYGuBHWoP9+pfYrlqG3BxKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M1j5meyJ; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728070948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6EzcXnrKJjq6UuWp+kgm49KbbcmUTLQ08qDVQkcSwYc=;
	b=M1j5meyJY2jcw/bOYM6ojGMrPY5f3uDR12gFSUTIFSZ2bowvRE4b51yA9OR/hNNsWy6w4v
	hwVB/FeaWwZSR0qPXDrH8HCr+uWX01WY1Jg9dCTGPbgPi5KOT1k0VusyMO0YFwIOBbv+l7
	ygH8ap4is79A3i69XWemC4AVts5niIE=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 0/3] Fix GPU virtual address collosion when CPU page size != GPU page size
Date: Sat,  5 Oct 2024 03:42:04 +0800
Message-Id: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Etnaviv assumes that GPU page size is 4KiB, however, when using
softpin capable GPUs on a different CPU page size configuration.
Userspace still doing the allocation with 4KiB page as unit. This
results in userspace allocated GPU virtual address ranges collision
and therefore unable to be inserted to the specified hole exactly.

The root cause is that kernel side BO takes up bigger address space
than userspace assumes when the size of it is not CPU page size aligned.

To solve it with no GPU VA range space wasting, we first track the size
of a buffer that userspace/GPU think of it is, then partially map and/or
unmap the tail physical page with respect to this 'user size'. Ensure
that GPU VA is fully mapped and/or unmapped.

Sui Jingfeng (3):
  drm/etnaviv: Track GPU VA size separately
  drm/etnaviv: Map and unmap the GPU VA range with respect to its user
    size
  drm/etnaviv: Print an error message if inserting IOVA range fails

 drivers/gpu/drm/etnaviv/etnaviv_gem.c |  8 +++--
 drivers/gpu/drm/etnaviv/etnaviv_gem.h |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 42 ++++++++++++---------------
 3 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.34.1


