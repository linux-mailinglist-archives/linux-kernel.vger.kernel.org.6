Return-Path: <linux-kernel+bounces-409340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E29C8B81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A65E1F24B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7C21FAF03;
	Thu, 14 Nov 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fnPvZd2J"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D421FAEE8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589889; cv=none; b=fDn+9iyutIt/3WlQ/crSwm8WUpSAOndnWkAmEwu3IZQ97LwZ5xIBh0s1rQyEoUzIlzirj9vOaH8V+QwUYQIneUZnVYXqGquO5lpxtXdrmLuSlmwz9Dku5m6kNjlc90upmmV6xyTAPywmJvVo+Oyl5djAXofoi6E0o5ZJlzA4CmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589889; c=relaxed/simple;
	bh=HFf8K4r6LJyu1LoALl9YJfBy5nNrpE6bVimuWFSCiF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3PtelzFq85tEdUbMhY7AKLupxS7Sji+R2nWW9ZxzUWSsz/hUnXQerbBNRZLhjmUbWgohx4OZ0vk1POVaj6TIwuFrOYzMMKcPiD/Jvj3lev3jC+cC0ZmcqNT80yPPogkbe4/ZJnGpJT5jFx+xc7waOAUAZP0kzstadwAOXyy5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=fnPvZd2J; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731589883;
	bh=mwVw1xeiq67pN0xhpzegghoLXiH3gNG3QWpIzQUKwmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fnPvZd2JPXpFBN2uNtf6Iqq1QJhroaf4gtXi2ToUVCbS/oW4gf7RjPakToO/8Wmfy
	 So+GrPZXL8U8lGiLdbUv09Qy/JruojkunnoC3Vt+FeXkQY90MYkaLzYwa8vV972BcO
	 5nVybBOKQ6T50w/BuwW0kim7Jrdj/Izhj64r17WuvkcDUryh6ik9OfRcKqqjTRBEDq
	 MFoPtWMhqYfLaJ95y/ssTQwcQlGqhUZlDdD7IHedmSBAiQjl/eDulQp+1p4wDUDrtO
	 Wa85JBpxf9cjFHgWuuZT814BL9pAV+VA9FuRkIqpUiGv7maBN76VGHBkulZgXzGbko
	 yNoJt0jmAA89Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0sR193Cz4x8C;
	Fri, 15 Nov 2024 00:11:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<geert@linux-m68k.org>,
	<arnd@arndb.de>
Subject: [RFC PATCH 04/10] powerpc/powermac: Remove machine_is(chrp) test
Date: Fri, 15 Nov 2024 00:11:07 +1100
Message-ID: <20241114131114.602234-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the chrp machine has been removed this test can never be
true, remove it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powermac/nvram.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index fe2e0249cbc2..23af93dcb212 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -589,13 +589,7 @@ int __init pmac_nvram_init(void)
 	}
 
 #ifdef CONFIG_PPC32
-	if (machine_is(chrp) && nvram_naddrs == 1) {
-		nvram_data = ioremap(r1.start, s1);
-		nvram_mult = 1;
-		ppc_md.nvram_read_val	= direct_nvram_read_byte;
-		ppc_md.nvram_write_val	= direct_nvram_write_byte;
-		ppc_md.nvram_size	= ppc32_nvram_size;
-	} else if (nvram_naddrs == 1) {
+	if (nvram_naddrs == 1) {
 		nvram_data = ioremap(r1.start, s1);
 		nvram_mult = (s1 + NVRAM_SIZE - 1) / NVRAM_SIZE;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
-- 
2.47.0


