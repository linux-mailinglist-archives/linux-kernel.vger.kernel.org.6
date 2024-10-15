Return-Path: <linux-kernel+bounces-366019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92E299EFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161E51C22959
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED51FC7D6;
	Tue, 15 Oct 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4p1V+eY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63F1C07D2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003087; cv=none; b=WoE4+Pj3PYXwdbS59jfTcdnVAEHr2/qCZYLP9ixV1WAqJyVd8u8YwvZzXNPVLSv/Hru3p7P2SVOqiBz9hNpk/mbYuAyfwxOzIifo0V8NToVZBjEmJt9PwXovwT/UBdI2hgzWz90/DpsxIWk0j6MsfKLOUJLjXKx2sXevaUk/bKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003087; c=relaxed/simple;
	bh=pXY5HDulBu9WzpqPA82ZpCxM5nd0fGkApvrRszYu9ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JqloLqKXSFLMcKeAZr+gKurtkO76Ea46hT78rSMe/Bi5qmr4y/HNnABROnz2YIS5R229DrpDvGxgDY+dTwmdM1m/t3uhfGCTbfLHL1qCqRDq4h9xBCLZM8u8doC5dbkr0jJXyus3T/ZR+Tz/BCOiOVVt3ZZeX7Q0xXSWI0S8m7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4p1V+eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEF6C4CEC6;
	Tue, 15 Oct 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729003086;
	bh=pXY5HDulBu9WzpqPA82ZpCxM5nd0fGkApvrRszYu9ss=;
	h=From:To:Cc:Subject:Date:From;
	b=u4p1V+eYQzDjeUMgMIjGIdSXnV/wyEQEzIUIO7+OMW2BzfDhxVHYGHEMcnwLtjNpT
	 VeLWWMufhCnualbbqvotHiVYBFdhlLfLvWfgK8f2ybtlnawSgo8vTv3jmA1KB9xoPO
	 zEVzOQissVI8SjNYnhIaI3pCIqeORdfIsBhGKFCKlSt16HIBb2kpPNp479QwGi70xG
	 9u4zAycfiJysfR9q9cRhnovttqqfInvyJxJZ8PrAQhBPOsB8GTM3n7eonwGGgcslML
	 vmBq9AQq49rdCqUSH/H2a4qvifIhb7AuoPx44/g6WZrf3LdSInfDTinFDO2s9J1RCD
	 vdPf30XVrdKCQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bootmem: add bootmem_type stub function
Date: Tue, 15 Oct 2024 14:36:06 +0000
Message-Id: <20241015143802.577613-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_HAVE_BOOTMEM_INFO_NODE is disabled, the bootmem_type()
and bootmem_info() functions are not defined:

mm/sparse.c: In function 'free_map_bootmem':
mm/sparse.c:730:24: error: implicit declaration of function 'bootmem_type' [-Wimplicit-function-declaration]
  730 |                 type = bootmem_type(page);
      |                        ^~~~~~~~~~~~

mm/sparse.c: In function 'free_map_bootmem':
mm/sparse.c:735:39: error: implicit declaration of function 'bootmem_info'; did you mean 'bootmem_type'? [-Wimplicit-function-declaration]

Add trivial stub functions to make it build.

Fixes: 43d552a255a6 ("bootmem: stop using page->index")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
No idea if this is what we want, or if the return values make
any sense. Just treat this as a bug report.
---
 include/linux/bootmem_info.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index e2fe5de93dcc..d8a8d245824a 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -62,6 +62,16 @@ static inline void put_page_bootmem(struct page *page)
 {
 }
 
+static inline enum bootmem_type bootmem_type(const struct page *page)
+{
+	return SECTION_INFO;
+}
+
+static inline unsigned long bootmem_info(const struct page *page)
+{
+	return 0;
+}
+
 static inline void get_page_bootmem(unsigned long info, struct page *page,
 				    enum bootmem_type type)
 {
-- 
2.39.5


