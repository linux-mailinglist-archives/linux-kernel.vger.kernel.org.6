Return-Path: <linux-kernel+bounces-243970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE9929D35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1768F2816C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB5224E8;
	Mon,  8 Jul 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIpXkjGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405B224F6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424262; cv=none; b=ipM7anEfq+GMwWFoGU4nQXBq/zoLHPxW/KpBTOdkJmr+vQnHwXMLEwfv2HMnbje0eDG+rU6j8l2iD9AWIAR9HAz8f/4jRCG0RPHMlPcStFKzIGjbDVj/6O+hdVC+vJ3rqovqP94Jiwwy5xcpkT3AkEze6809SdNUNKSy5xpAwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424262; c=relaxed/simple;
	bh=0K9mUeoquePkBdTj1AKzZ4BkSOCOLKIg7fSO7Rbw1AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E65SJW5RweYwhGw9sp+MctjDy4aIuRtZ35InTZdZ33HRk73snLKTVYYo24rylW9+yMXtRbDT5+q9tFE+5lD6yqSbr6qn9vlD3V02AQUOB/5yvk2GGqgv6gimXukJViP6ZiHr3CJR1llVuaQC6zle3qv3+dblHmw54sALEqQdGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIpXkjGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0108C116B1;
	Mon,  8 Jul 2024 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720424261;
	bh=0K9mUeoquePkBdTj1AKzZ4BkSOCOLKIg7fSO7Rbw1AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIpXkjGgzXgG75tkN8T/XcAZHjFOsAgRcX/s2N+ZOYqnvNpJ5m8Pwg0lOqWeA/rtR
	 i4xEuKJxcxOyokCF5wvSvX99bnYULSNa+Jrz88H12WiFaCW6Xjnm/ljoKX7tT/g28x
	 Fmq/d+aam+tGE3/8maY1ZWSPg5DtVNQbr9Qk0cocIRp44VSgZgaOlSBeXo9UJGaNkM
	 TcqaVP/ditBggBIGFt/Keve6CR95tUJ27tVOEoUnih7rjwyX7/4jDRI1n5deN4bTxr
	 wL47c6gMOxkFblQe7F22BQvSi4cXClOWzoyNhGIFfL2u5HtAy++Ju/sf/01kJjLYGC
	 xz89EtdmSQCzQ==
From: alexs@kernel.org
To: alexs@kernel.org
Cc: 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	senozhatsky@chromium.org,
	vitaly.wool@konsulko.com,
	willy@infradead.org,
	yosryahmed@google.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] mm/zsmalloc: fix build warning from lkp testing
Date: Mon,  8 Jul 2024 15:42:23 +0800
Message-ID: <20240708074223.1113744-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708063344.1096626-18-alexs@kernel.org>
References: <20240708063344.1096626-18-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (Tencent)" <alexs@kernel.org>

LKP reported the following warning w/o CONFIG_DEBUG_VM:
	mm/zsmalloc.c:471:12: warning: function 'is_first_zpdesc' is not
	needed and will not be emitted [-Wunneeded-internal-declaration]
To remove this warning, better to incline the function is_first_zpdesc

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407052102.qbT7nLMK-lkp@intel.com/
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7f8e02df4e3e..64e523ae71f8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -468,7 +468,7 @@ static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
 	.lock	= INIT_LOCAL_LOCK(lock),
 };
 
-static int is_first_zpdesc(struct zpdesc *zpdesc)
+static inline bool is_first_zpdesc(struct zpdesc *zpdesc)
 {
 	return PagePrivate(zpdesc_page(zpdesc));
 }
-- 
2.43.0


