Return-Path: <linux-kernel+bounces-265640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF1D93F3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF5CB22116
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3942A155A26;
	Mon, 29 Jul 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1CgdvR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38315574C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252086; cv=none; b=QjwrlgL7tdI1cmFgRcvbVJqvcsEcL9xJtaq8zymX/bi+MlHJAaYHkeglL/N6ffm3qbs2x+i7vmTt1ayUkjOkQeK8bsntJ1RMBb/ZM9GKWk0OVEcE07tdw42acTMykdMz5BkLEJvvctVIIXvQ4fTyuk/xN8anb3iRFRK9l0PnEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252086; c=relaxed/simple;
	bh=lHz4+kv9JsOYqs60tdoZ6ATt9ROlCYt2854vH8gmrb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9kkTaMlhGlUdSEF2W+VQLqM4coXK7bsOmyA63qD+FN74nrk2lYeGgIv6cUF9ajH/yiuD8dnXDRJDeqjQvedlTr+ygcYA2Ogye0UGrXJKtxfs1sDEqxf8s7gi5/wRiEA4Dyvu9npI4fGPneG+qyVEWOUS/aTNirDxbi5Nzdc+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1CgdvR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707BAC4AF07;
	Mon, 29 Jul 2024 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252086;
	bh=lHz4+kv9JsOYqs60tdoZ6ATt9ROlCYt2854vH8gmrb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1CgdvR29F1u5T1ro7OnwYP8ZI6Z8m5hqoCiuU6o2r6/Llckc5OZClzt+xtMn3slx
	 AFvT91UPiTj2FxS6Alp1vxaZ3e++kWdf5oS7M3Sj3DUCwEoJth7Ceb7JnkuabRtR0l
	 R5iECzCnEGJmmx8aarCKgA4UNXSt71i1vHs3BXW+pArZP4RaS+ZMO6PZT+855B6LaB
	 9BGgI25HnzxXeJBvgkW+SHFyRqJ+tu43jYM6AEzD62G+fWy02YX00rzqkL0+2y4ACp
	 7UEsjmUXSG3nhoO+rx5BV2wgsV31LrkbcwddZpOqClNWsrD/liVk7o5QAksSAwuHQZ
	 Db5SyjD/FlHIA==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: Alex Shi <alexs@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4 21/22] mm/zsmalloc: fix build warning from lkp testing
Date: Mon, 29 Jul 2024 19:25:33 +0800
Message-ID: <20240729112534.3416707-22-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729112534.3416707-1-alexs@kernel.org>
References: <20240729112534.3416707-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

LKP reported the following warning w/o CONFIG_DEBUG_VM:
	mm/zsmalloc.c:471:12: warning: function 'is_first_zpdesc' is not
	needed and will not be emitted [-Wunneeded-internal-declaration]
To remove this warning, better to incline the function is_first_zpdesc

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407052102.qbT7nLMK-lkp@intel.com/
Signed-off-by: Alex Shi <alexs@kernel.org>
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


