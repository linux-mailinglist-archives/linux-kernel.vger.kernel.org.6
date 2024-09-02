Return-Path: <linux-kernel+bounces-310890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123B9968289
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44A12835CA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E731E48A;
	Mon,  2 Sep 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQupa5Ho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D4A170A24
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267418; cv=none; b=Dcn+xVLYjBqnW0SDTrkyhQzGplDC/OwDYGFzUQeSzFt4sDg9j33MLi1pHXGkUvaSB149GZ9Ydg7ppIxZqakWBu7SVfc2ak2qfR59KtlXBOM8mQryi6pVoH6OIw+BCcxGSAcBt9abZ7DLznZQgfd2kT1GGPQx5+MpO9FSKeJi708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267418; c=relaxed/simple;
	bh=0rpyOm0zg+8iU4qpvBMGbms7jc59/GQhpLhybk20r9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMjIRtUr+Ha5Dq9ofXAq082yrDoNeEPrFni2WYVHx77t3YKs4KNXOb1RehNxM0YL9LxjfC/SgBtLInelel6LplMEe8w4v76/+rLPiEoNypwlmIn2QWjWoHp45OR8IeDE3SruuWdW5D2H+rFlV6dw99F/bfflUFzmJgIlrXiP8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQupa5Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0423FC4CEC2;
	Mon,  2 Sep 2024 08:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725267417;
	bh=0rpyOm0zg+8iU4qpvBMGbms7jc59/GQhpLhybk20r9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQupa5HovbHXnntwazxbOidHpkeLdXaBM1Dv7TZsHj/4UZq03iE01c94l5TCoFe0z
	 PPCwme7EbYBadIC1NIZ8T4PXvcP/ABtpW+z4RjCxo2YJXOOnmn1gLOcTfEavk9C204
	 3srZh4OVHatwlVmW6iMpL0J7aQOX1aWCK2cNaE6RNM/m7e1SC8080xuty+FBkZXpWy
	 32HjAbbPnj+/D5Usgixtvw9G2V1b3dq5cT27pSbbHJsxhksSkSLjNQEfeVNnQP+TcE
	 5vbLQ5GI7QJ3k6jn6sM8QiBcWp8NaavgpyVFYKJWpj+lXBgSmIfPVwxKya1K+5MKgF
	 7vtpThheo374Q==
From: Christian Brauner <brauner@kernel.org>
To: R Sundar <prosunofficial@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH linux-next v2] mm: Removed @freeptr_offset to prevent doc warning
Date: Mon,  2 Sep 2024 10:56:04 +0200
Message-ID: <20240902-neumond-albern-71e76f6c9acc@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240902020555.11506-1-prosunofficial@gmail.com>
References: <20240902020555.11506-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=brauner@kernel.org; h=from:subject:message-id; bh=0rpyOm0zg+8iU4qpvBMGbms7jc59/GQhpLhybk20r9k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdrb24w5dbg3PDXU4ZibiXPq6WDNPZDwcveDVJP6unr drq/DyfjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIms+8/IsLQ0x3dlVvfTI003 ft46LsIhnvshwprHKjkidtP6GwsvOTAyPCsxnL/7j2rI9FWrcju23Jfmc+/e/s9kl2x7KuvEe1t fMwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 02 Sep 2024 07:35:55 +0530, R Sundar wrote:
> Removed @freeptr_offset to fix below doc warning.
> ./mm/slab_common.c:385: warning: Excess function parameter 'freeptr_offset' description in 'kmem_cache_create_usercopy'
> 
> 

(I just love documentation so much that I document things twice?)

---

Applied to the vfs.file branch of the vfs/vfs.git tree.
Patches in the vfs.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.file

[1/1] mm: Removed @freeptr_offset to prevent doc warning
      https://git.kernel.org/vfs/vfs/c/6e016babce7c

