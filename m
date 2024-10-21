Return-Path: <linux-kernel+bounces-374862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DFB9A713D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0071F23027
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDDB1F1304;
	Mon, 21 Oct 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5SNLYDn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3676F19342E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532533; cv=none; b=EW/rDsZ+Z1G7upQqd58zPgd7ZWPz8pFj6gRcMd7c5p34jxoVX59ifDti7/rSACLT5gS44HKP1y4jX4zigJ6sZI0GzgV8E7Ybqo0G7dPcnMNTOja1F6p7NvdHM3/aX5wEoU6X7XGthNbJqi2efoQiTX1D1T6zsvY+XCR4L5iAbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532533; c=relaxed/simple;
	bh=35eVnkLVGGFtkiYWb5znwaepAtKHLWAdVu2OnclhS7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZswqeGE2xu569rEsxUgOGc+ndBtuQtPexvAV+So2v7/eS6lsAyD9SWr8A+4ZIrAygHjdVdtGFa/5zqgjKPvIUx5u8+q/Sf7PUrkeoR76X4LkNw64md/m9xrjA/Y2QmqAFVY+jIQ6q0Ol1PL39VILKe0u9cN5zd92b9uZgzA3xU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5SNLYDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B9BC4CEC3;
	Mon, 21 Oct 2024 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729532532;
	bh=35eVnkLVGGFtkiYWb5znwaepAtKHLWAdVu2OnclhS7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5SNLYDnIaJ5EQhpzrFzKlbQD8KhTH+Nu6PyI/+ZRAhfqXhUoZsVO3yFc6lPXb9cQ
	 fqFdkp+2pUA7Zvi89tBb+K53mOsnt/aIEE5TQrQIj/v/0lm3aCBYWLSOEWNAI/c+bu
	 Rz0BnJNTcqQ/wQwqFfyS340GFZsp+i0SU/XzsRWmbvXiRLvowUlOfPsO94yifTV01a
	 GdbsCIBo7IDMPufgi0vNWpoJYWR2NAuFZs6VdrLGSdsCI0udwHBS3JD6Qk+ARG+cqH
	 HB9q3zOvo5np8lCU5PMFbGPBaPmVJlCU/DRYdzdT2czLAHoEVk3ZIsGwXSo0PtFJJW
	 dYC2N5zGxw4Aw==
From: SeongJae Park <sj@kernel.org>
To: James Houghton <jthoughton@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: Add missing mmu_notifier_clear_young for !MMU_NOTIFIER
Date: Mon, 21 Oct 2024 10:42:02 -0700
Message-Id: <20241021174202.13706-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241021160212.9935-1-jthoughton@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 16:02:12 +0000 James Houghton <jthoughton@google.com> wrote:

> Remove the now unnecessary ifdef in mm/damon/vaddr.c as well.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Notes:
>     This patch is originally from this series[1]. I've split up the MM and
>     KVM bits of the series, and I have already sent the MGLRU changes
>     here[2]. That leaves this small cleanup for DAMON.

Thank you James!

>     
>     [1]: https://lore.kernel.org/kvm/20240926013506.860253-1-jthoughton@google.com/
>     [2]: https://lore.kernel.org/kvm/20241019012940.3656292-1-jthoughton@google.com/
> 
>  include/linux/mmu_notifier.h | 7 +++++++
>  mm/damon/vaddr.c             | 2 --

For mm/damon/vaddr.c part,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

