Return-Path: <linux-kernel+bounces-371903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F769A41FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75EE9B225EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91B5200B93;
	Fri, 18 Oct 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpbA0ysE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BE76C61
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264281; cv=none; b=fMylkgaw7O/UDMMY/qfdZDbXE00RHFJOaC/WVCwrJaSMDb623iF4l3xoQHR8i5dN+SVnOth1/xUaGoEQv/qlAF3WG/xdoDnvG30PRlY6gnOzFOC7R34j7ShwAlwJB2WJs0ntbV0h5X3YcRFtVd9VBwVPOSGeVmrNsyYHYBmKrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264281; c=relaxed/simple;
	bh=CJ+jBXETEz+wfc5ePlLRU0j3ezHl8RQ8g2Sbi6vH+jI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CGAD5JEoy7zwrBOEkxJrbx3rVrgAaHWujiTHcyR4I2mBhGKf/yx+wuH4SpSSwdxs6PUw7q4nqcjwarx8lfwxZIrWT99X9VMJJSfQVHSwCrXhiuzJJM/+yd76G/cgnaGv9xtdhEOY3EGK+eSD/5x8CJnYjas37COaGMzuYWb/4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpbA0ysE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF18CC4CEC3;
	Fri, 18 Oct 2024 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264279;
	bh=CJ+jBXETEz+wfc5ePlLRU0j3ezHl8RQ8g2Sbi6vH+jI=;
	h=From:To:Cc:Subject:Date:From;
	b=tpbA0ysEob46Hw34JccUdzfg7lIdx9iZv4nYPQzMlm1ziBoHu66FUeky+qg+621Z1
	 1IWH5QU7Tz3pi69brkwzwKeDXdsTXh2BxgPPxTJCt8eYPIJa6cjKwI3qIRtLVVDhZn
	 SQfhH1G/1grERjA+UpZ6zEQGAr1ExQ/WXxfnz7T7/LyjHun6b/btoWg33KyDWqJWaI
	 wgPjO3m8eeZjHUIim5q2Kq9MD3wbZ/UoUMgo8Bk8/THvBppcATYU/14tPw1Uxao9kH
	 8ZGo8JmRcDw+BaOFxY0cMygzqenNfpdZ3j5PheqYp4CTQFJ2YKMFX1HQJHDwnmKC2k
	 fCaEFXIxtwr9w==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: export copy_to_kernel_nofault
Date: Fri, 18 Oct 2024 15:11:09 +0000
Message-Id: <20241018151112.3533820-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This symbol is now used on the kasan test module, so it needs to be
exported.

ERROR: modpost: "copy_to_kernel_nofault" [mm/kasan/kasan_test.ko] undefined!

Fixes: 44749130ffb4 ("kasan: migrate copy_user_test to kunit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/maccess.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/maccess.c b/mm/maccess.c
index 3ca55ec63a6a..8f0906180a94 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -82,6 +82,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 	pagefault_enable();
 	return -EFAULT;
 }
+EXPORT_SYMBOL_GPL(copy_to_kernel_nofault);
 
 long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 {
-- 
2.39.5


