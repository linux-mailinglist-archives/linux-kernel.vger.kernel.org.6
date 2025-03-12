Return-Path: <linux-kernel+bounces-558514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD9A5E6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1773F1898CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D6E1EE7D9;
	Wed, 12 Mar 2025 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aSM/I7sz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE6800
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817053; cv=none; b=on77s4BI8hfOZ3qVg6QJHuhhsekXC7Om17ensh62qWghTYpz72sC/099u1heEut23oW+rwE087idBY6o1lRC8O+nI2kZlDZggQXNelag48dxQaGQ7azwSeMRCo5TnnF+8CNDPiQs+pPG7dJesf0vfiNnFanTQZs8kP4p9Y0gbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817053; c=relaxed/simple;
	bh=q7CxZcfZDMZ1MshmmrMaaEZTfn95aPXhl6ugjT4WvEc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dyMLU2eVTauoxIAPUv9sr8J8K/tniz7RlY9Q6ki5Y3iYz+r2O9PPZBFR9Cws9VK5YnP98r36pZE4LIuzbwcMoqIubPKaRtPfmTkzt4p/VVbdN9qzQtyL+9Ihobov+FglKI0hcGfSn+0v7QMjndvG+c2/BLnMhY4NfzPkdiS+cVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aSM/I7sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4460DC4CEDD;
	Wed, 12 Mar 2025 22:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741817052;
	bh=q7CxZcfZDMZ1MshmmrMaaEZTfn95aPXhl6ugjT4WvEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSM/I7szR+8FJOMRcznJG2VoqJxSryCaOUfcmTfD7X4vQIcWZyDIfWBSX2ljEQiJ+
	 zjN31ndVUhzrg7wGmOy2oNPIla8OcqurfBd00hOc5kP8hPLXBxIdjnDVrOZkMF96PF
	 5O+PI3K8XmzAaTgzdFMFzZybm9llA10Fiy33b7S4=
Date: Wed, 12 Mar 2025 15:04:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Mike Rapoport <rppt@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Axel Rasmussen <axelrasmussen@google.com>, Pavel
 Emelyanov <xemul@virtuozzo.com>, Jinjiang Tu <tujinjiang@huawei.com>,
 Dimitris Siakavaras <jimsiak@cslab.ece.ntua.gr>, Andrea Arcangeli
 <aarcange@redhat.com>
Subject: Re: [PATCH] mm/userfaultfd: Fix release hang over concurrent GUP
Message-Id: <20250312150411.f4a5b406600742a49b46d04e@linux-foundation.org>
In-Reply-To: <20250312145131.1143062-1-peterx@redhat.com>
References: <20250312145131.1143062-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 10:51:31 -0400 Peter Xu <peterx@redhat.com> wrote:

> This patch should fix a possible userfaultfd release() hang during
> concurrent GUP.
> 
> This problem was initially reported by Dimitris Siakavaras in July 2023 [1]
> in a firecracker use case.  Firecracker has a separate process handling
> page faults remotely, and when the process releases the userfaultfd it can
> race with a concurrent GUP from KVM trying to fault in a guest page during
> the secondary MMU page fault process.
> 
> A similar problem was reported recently again by Jinjiang Tu in March 2025
> [2], even though the race happened this time with a mlockall() operation,
> which does GUP in a similar fashion.
> 
> In 2017, commit 656710a60e36 ("userfaultfd: non-cooperative: closing the
> uffd without triggering SIGBUS") was trying to fix this issue.  AFAIU, that
> fixes well the fault paths but may not work yet for GUP.  In GUP, the issue
> is NOPAGE will be almost treated the same as "page fault resolved" in
> faultin_page(), then the GUP will follow page again, seeing page missing,
> and it'll keep going into a live lock situation as reported.
> 
> This change makes core mm return RETRY instead of NOPAGE for both the GUP
> and fault paths, proactively releasing the mmap read lock.  This should
> guarantee the other release thread make progress on taking the write lock
> and avoid the live lock even for GUP.
> 
> When at it, rearrange the comments to make sure it's uptodate.

It would be good to have a Fixes: target but this bug seems to be so
old that a bare cc:stable should be OK?


