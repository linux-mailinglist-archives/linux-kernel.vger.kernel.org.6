Return-Path: <linux-kernel+bounces-228291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D244915DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6341C2147A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C04113C9B8;
	Tue, 25 Jun 2024 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PUFYFf1q"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E1135A7F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290422; cv=none; b=INpGPHuevGZxE9J8a31tWjtSWoMzv4eH0QeaRKtAK8UnstA/Aihavuifeqx6WqXwPCbIpDBpQWN/qXxNXAq5JcWco7gtRdy/9cCL0jLiC3bQRDc+UoB03V55nDOwOR4eImpvmbRUwJiZfcwt6PESS1f1wQHWQC+nmNMQ+RGaB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290422; c=relaxed/simple;
	bh=O8QdBXxrsum2SV7qd5wRhBGHU0wBN+EES3FXqsIwH4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IMTmXRjex0YSAZjkidTjIslAP+Tis5wv9JpZBb4gexR9i7LxJP7mHSMwZms7owvd+f/xfVMQhZlBwpD4x4H94hykbMBn8RAL4+L2/+WaQnQ0yiMe/uqYte94SAoI2CuWX0Q9QHrzM6ms8TFklBUX+TPdVgYpiDmdnxAhEIpezQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PUFYFf1q; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: senozhatsky@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719290412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NWzsDJcE2ZGjLfrjR+FqTDXeK9M6Lj1WnqJTcUe3e3o=;
	b=PUFYFf1qc2nM+r11biw6TqJiZhTjk41sRs6H0tl8Rn5ZkTruvQCaSHxZYAphOFSCEDqIZP
	vSvzkcZSljrWJ6NriL1CyXCPvmoHfTOX6vTPPnaYBT+LoAruO8A08b4bDIH/Qu8Cb5dCRh
	JFeaJyoKnAP0y+GmpRlNirr8vmgJ7/g=
X-Envelope-To: yuzhao@google.com
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: minchan@kernel.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH v3 0/2] mm/zsmalloc: change back to per-size_class lock
Date: Tue, 25 Jun 2024 12:39:03 +0800
Message-Id: <20240625-zsmalloc-lock-mm-everything-v3-0-ad941699cb61@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOdJemYC/43NuxKCMBCF4VdxUrtOLnKz8j0ci0BW2BGCk2AGZ
 Hh3A5U2jsUW/xbfmZlHR+jZaTczh4E89TaG2u9Y1WhbI5CJzSSXR56KDF6+023bVxDvDl0HGNB
 NQ0O2BpVn2ugUla4KFoWHwxuNm365xm7ID72btrEg1u9/bhDAIcGE5wK1EKU6t2Sf48FgYKsb5
 IclxW9LRssojkVlZJkVX9ayLG/OhYCAEgEAAA==
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
 Nhat Pham <nphamcs@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>, Takero Funaki <flintglass@gmail.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719290409; l=2396;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=O8QdBXxrsum2SV7qd5wRhBGHU0wBN+EES3FXqsIwH4w=;
 b=p/LUsswEUWEnH8m8uFyE1N0ekUkhp2BHnwL2iMzDXn/O0I+Vb3N1x513aI0lVDCAmn3NjOwqO
 TS7CXqWCEE9B06S5BNzLLbEor1ddxpzRjMJLRyjvjPO3vn74NShyvY8
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=/XPhIutBo+zyUeQyf4Ni5JYk/PEIWxIeUQqy2DYjmhI=
X-Migadu-Flow: FLOW_OUT

Changes in v3:
- Fix error handling again in zswap_pool_create(), thanks Yosry.
- Add Reviewed-by tag from Sergey, thanks.
- Link to v2: https://lore.kernel.org/r/20240621-zsmalloc-lock-mm-everything-v2-0-d30e9cd2b793@linux.dev

Changes in v2:
- Fix error handling in zswap_pool_create(), thanks Dan Carpenter.
- Add Reviewed-by tag from Nhat, thanks.
- Improve changelog to explain about other backends, per Yu Zhao.
- Link to v1: https://lore.kernel.org/r/20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev

Commit c0547d0b6a4b ("zsmalloc: consolidate zs_pool's migrate_lock and
size_class's locks") changed per-size_class lock to pool spinlock to
prepare reclaim support in zsmalloc. Then reclaim support in zsmalloc
had been dropped in favor of LRU reclaim in zswap, but this locking
change had been left there.

Obviously, the scalability of pool spinlock is worse than per-size_class.
And we have a workaround that using 32 pools in zswap to avoid this
scalability problem, which brings its own problems like memory waste
and more memory fragmentation.

So this series changes back to use per-size_class lock and using testing
data in much stressed situation to verify that we can use only one pool
in zswap. Note we only test and care about the zsmalloc backend, which
makes sense now since zsmalloc became a lot more popular than other
backends.

Testing kernel build (make bzImage -j32) on tmpfs with memory.max=1GB,
and zswap shrinker enabled with 10GB swapfile on ext4.

				real	user    sys
6.10.0-rc3			138.18	1241.38 1452.73
6.10.0-rc3-onepool		149.45	1240.45 1844.69
6.10.0-rc3-onepool-perclass	138.23	1242.37 1469.71

We can see from "sys" column that per-size_class locking with only one
pool in zswap can have near performance with the current 32 pools.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (2):
      mm/zsmalloc: change back to per-size_class lock
      mm/zswap: use only one pool in zswap

 mm/zsmalloc.c | 85 +++++++++++++++++++++++++++++++++++------------------------
 mm/zswap.c    | 61 ++++++++++++++----------------------------
 2 files changed, 70 insertions(+), 76 deletions(-)
---
base-commit: 7c4c5a2ebbcea9031dbb130bb529c8eba025b16a
change-id: 20240617-zsmalloc-lock-mm-everything-387ada6e3ac9

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


