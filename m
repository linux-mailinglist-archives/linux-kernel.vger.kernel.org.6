Return-Path: <linux-kernel+bounces-337067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0869844E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D731F26FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8071A7040;
	Tue, 24 Sep 2024 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnLoO4kM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F812C7F9
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177632; cv=none; b=j1sHX+tbn65KHrKSECObjDgQxJkYoyuq0Lixt6UgAwZ2AE89COu3ejtJIHCSaHPGctrzJhrTMNVQdSfObjgnGGNe7YorWm6LRH8nKpPkcldx3Nc2eX+BNNjp3FnbAg+21Jbx/PQOqwsd/4d+JehoTyof/b6pPycfd2xhy+XuAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177632; c=relaxed/simple;
	bh=8G/AwMuPFWeIfpDvKPSLumJJ4v+oa4GpZ94o+TWeUa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QU8/ovyzgJeyfj4x93hn5jPjfznyKZgZIWoILgopYpTWJ2yVzFaJsi3fi72wbuxMms4xKe0OEWKWeq8c/KvEXkzUzDFEpQisSx4xkMNPhfdbvilQjLl5uxsOJQvdH++pho4mxwkoogfv4VrKDr33ZYMvsk7FGxeTtqckhHVZsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnLoO4kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89667C4CEC4;
	Tue, 24 Sep 2024 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727177632;
	bh=8G/AwMuPFWeIfpDvKPSLumJJ4v+oa4GpZ94o+TWeUa4=;
	h=From:To:Cc:Subject:Date:From;
	b=jnLoO4kMy2kpBEq5dzngf4PuSKwwF/MATTPFjp3zATglpp3GTf4B9Eo/u7tereUIH
	 7NrK9byrODwHzldZKzp+0n/GWqFoRgg2+Nm3SYYKupLclCWACKQTOPaMdgPEfr1X9V
	 2FI6ZEMuMZXTust9I8ZSeO3l8KgUHdGf9wf6nroGVlORN8pwnrzsfN9yUWM8EB2p8Q
	 GR5Dv9a3GlJjmI7PwW3N9O4TRM1cy2b+WvaaVn62gdtxRfGGNh90LLk/qZaor+uK1Y
	 m+XgfzbTjZx+DvPvpbmaaTfshhnxEyGSqe8pe2x5alOFK/V16tK7BP106/6ufvDt5L
	 mf9fqzvs5AQ4Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Ignat Korchagin <ignat@cloudflare.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: remove dependency on undefined CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
Date: Tue, 24 Sep 2024 20:33:40 +0900
Message-ID: <20240924113342.32530-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS is not defined anywhere.

In the submitted patch set [1], the first patch "um/kconfig: introduce
CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS" was not applied.

Only 2/3 and 3/3 were applied, which are now:

 - 730586ff7fad ("um: Allow static linking for non-glibc implementations")
 - 5e1121cd43d4 ("um: Some fixes to build UML with musl")

Given that nobody has noticed the missing first patch for many years,
it seems it was unnecessary.

[1]: https://lore.kernel.org/lkml/20200719210222.2811-1-ignat@cloudflare.com/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/um/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index dca84fd6d00a..71b592b49240 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -95,7 +95,7 @@ config MAY_HAVE_RUNTIME_DEPS
 
 config STATIC_LINK
 	bool "Force a static link"
-	depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || !MAY_HAVE_RUNTIME_DEPS
+	depends on !MAY_HAVE_RUNTIME_DEPS
 	help
 	  This option gives you the ability to force a static link of UML.
 	  Normally, UML is linked as a shared binary.  This is inconvenient for
-- 
2.43.0


