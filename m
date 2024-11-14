Return-Path: <linux-kernel+bounces-409081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816599C8774
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF7FB2E069
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90741F9ABF;
	Thu, 14 Nov 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="P8NbYm2E"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC081F8194
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579021; cv=none; b=MOGhJPXFU6w4sgR+Sx5Mub2aehtC/PSsdk7WRCODGZZq/b48iYmuYwasPkQFnsbk7Ezyu3y/ufQOYqoeLLtFLlP3hkRcQfiHjJ0dx2jx9H7SKgJn+WSgn+XYOpewr6bb5JB8qE0HSC01Nk4BIa3nXPTwmT/4QSJSAwBNWBCXNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579021; c=relaxed/simple;
	bh=lDluijp/Trjr23oTS6A0JZzjxVYqimWqvpNYQqVtjDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=USmk/Gx6ppcNkHppwC+tO72bYdvpgZfhriQO+MtFmtzTxozPsNIYLny31C8SU18liQCqAa9S0GWCEudVh36yvVRgNrb3OP/CtzNjBsPrfTfwrUJ90qjkhRZd8sEjewdRXr87aAy6lOcjFLHq3hoQaSA2Xqscfv7d1G9OlG6oxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=P8NbYm2E; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.kanapka.home.arpa (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 51C7B635B045;
	Thu, 14 Nov 2024 11:01:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1731578501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b6kOasXKOb7vqjNpZjqu3R9kaf6Rf+hRFr9lWZXsLb4=;
	b=P8NbYm2E/CHhWSOLEm0J6zGlrzJhFpPwpzB1XyFmpk9rnGi1ZAl1BLwov23ZZbn1PTECts
	ChUkCbV+Cw4YbkXHGaFxlSCHd3HK4eEzc0LlPznjsHYMlCu8bKnLkbsOO7CJPxbGni2SCr
	5CVSXHvvNfXIIhcYWL8fPB35EVTHlRY=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Wladislav Wiebe <wladislav.kw@gmail.com>
Subject: [PATCH] tools/mm: fix show_page() build error
Date: Thu, 14 Nov 2024 11:01:40 +0100
Message-ID: <20241114100140.406416-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

At one point I needed mm tools for debugging but couldn't compile them due to the
following error:

gcc -Wall -Wextra -I../lib/ -pthread -o page-types page-types.c ../lib/api/libapi.a -pthread
page-types.c: In function ‘show_page’:
page-types.c:423:49: error: expected ‘;’ before ‘if’
  423 |                 printf("@%" PRIu64 "\t", cgroup)
      |                                                 ^
      |                                                 ;
  424 |         if (opt_list_mapcnt)
      |         ~~
page-types.c:416:65: warning: unused parameter ‘mapcnt’ [-Wunused-parameter]
  416 |                       uint64_t flags, uint64_t cgroup, uint64_t mapcnt)
      |                                                        ~~~~~~~~~^~~~~~
make: *** [Makefile:23: page-types] Error 1

Trailing ; was forgotten, so add it.

Fixes: ece5897e5a10 ("tools/mm: -Werror fixes in page-types/slabinfo")
Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 tools/mm/page-types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index 6eb17cc1a06c5..bcac7ebfb51fd 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -420,7 +420,7 @@ static void show_page(unsigned long voffset, unsigned long offset,
 	if (opt_file)
 		printf("%lx\t", voffset);
 	if (opt_list_cgroup)
-		printf("@%" PRIu64 "\t", cgroup)
+		printf("@%" PRIu64 "\t", cgroup);
 	if (opt_list_mapcnt)
 		printf("%" PRIu64 "\t", mapcnt);
 
-- 
2.47.0


