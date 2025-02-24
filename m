Return-Path: <linux-kernel+bounces-529296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70907A422DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E0644443D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C945515A842;
	Mon, 24 Feb 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP8fuQDN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C06155756;
	Mon, 24 Feb 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406306; cv=none; b=Kicv04Js6Y8bIVAb/dNrc5xVLw4+3wQUXbR+ao0Ab/OudHhXZtFv0ZBAV5ha6WAf3gKQ9NhHRdUJGb2Mhk15INyfRWv4H7NKeVQAp5bmy6j8v1VTkktc6zqtQK2qgWuksusWSMEmACKlM6ckEU09nbirZZE+eRdLBmxM40LEYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406306; c=relaxed/simple;
	bh=P+1IoKn7bZFna+Dvhn79iyuL/7QRo0aRpzyot3u6GY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dO/oNS/3us8NCT7f1xDsGh8W2gPyKeaKJByr6QJXz1NNGyNjR8bAqMXRiHpfw4Y/9Ch9YC06QxrkH4f5Y7KD6wQz8AJ+ekN00KxmY6PWtHmmhcinfCQJhQF8tDADcQJOAQ4R6uZYBwMWSDtv0qOLg5rpF1ZEgyYJcjRiFbd/5RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP8fuQDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA9BC4CEEA;
	Mon, 24 Feb 2025 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740406305;
	bh=P+1IoKn7bZFna+Dvhn79iyuL/7QRo0aRpzyot3u6GY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pP8fuQDNB6qo4ZApjtvIMekhCQWKdasRAz6o4PmCHpMKk77semF4l01rB60J8L+PA
	 gfX5Sjbfaxm0fxN185wvji8xUFMXdO82x79T/Zymi/gMXk+GEnuL36E/f3SXucicd/
	 7DRAHddWWINUkGHn51BTAzazfoKQeYOrXNg24foCXAK59Xddey5u5YcPbLjhuuC2wd
	 TTId/UcA52x8RxOObRoMdQQ8z4DxczZgjO5sBqbp5/wv4PhDSeTlTQGKuf/FfZKpRK
	 fxBbIswIpZI1NHJXFNncWvfseTOCfWEn2Ng1NvEU0SteU7uKr35Kizqjw6jJJLono1
	 gypPYWuz/H4JA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Frank van der Linden <fvdl@google.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/2] mm, cma: use literal printf format string
Date: Mon, 24 Feb 2025 15:07:36 +0100
Message-Id: <20250224141120.1240534-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224141120.1240534-1-arnd@kernel.org>
References: <20250224141120.1240534-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Using a variable string as a printf format can be a security issue
that clang warns about when extra warnings are enabled:

mm/cma.c:239:37: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
  239 |                 snprintf(cma->name, CMA_MAX_NAME, name);
      |                                                   ^~~~

This one does not appear to be a security issue since the string is
not user controlled, but it's better to avoid the warning.
Use "%s" as the format instead and just pass the name as the argument.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index ef0206c0f16d..09322b8284bd 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -236,7 +236,7 @@ static int __init cma_new_area(const char *name, phys_addr_t size,
 	cma_area_count++;
 
 	if (name)
-		snprintf(cma->name, CMA_MAX_NAME, name);
+		snprintf(cma->name, CMA_MAX_NAME, "%s", name);
 	else
 		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
 
-- 
2.39.5


