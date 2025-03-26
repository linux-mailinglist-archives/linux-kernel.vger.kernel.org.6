Return-Path: <linux-kernel+bounces-577650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA74A71FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81BF1890F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB5254AF6;
	Wed, 26 Mar 2025 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYsG9+uS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D21CD1F;
	Wed, 26 Mar 2025 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019792; cv=none; b=KhiIUC6H27MOl33tizM8El8dea6y87PAq0yqo/PTw3dmH6ueNkBnnuJ+a45H8c41uSTLwkZ8l83d+FFiSikZ4fouiHG/nFdyZ6CKTtj4arPTJNIhhIGXKCleMGxsFoYmvzg39tXeFAu6Jl09jC3XmWHMLQEO0L0orMK7inXb63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019792; c=relaxed/simple;
	bh=32KmifOOGoqSmOn9dvxSLSt7llFi98ixPAQF7D8wpcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTqyBoDh01k/isxrfRKRCNZHekgnktDcYIUhKDUrlkVzoQu0+8GiIA8Y9aLwNsFUsb0f9mYDZTJAs2rhaNP0zNnFRAEYbQKsBF1GfmidimYXDtSLxw4WNJ+jhXxOMDcFMPUGjCEy5u9khQonr8NIsJCvThcHvIw6RRaUKXb8ENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYsG9+uS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B221C4CEE2;
	Wed, 26 Mar 2025 20:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743019792;
	bh=32KmifOOGoqSmOn9dvxSLSt7llFi98ixPAQF7D8wpcc=;
	h=From:To:Cc:Subject:Date:From;
	b=tYsG9+uSmMlzNU68yDKOcPAH/hj4JOWVzXq05wujHeibPJoBIVKL9S4yYHTODlzDZ
	 IFRTG+PnoqYA4Usbc8NG/aNQxHO+STrtC1ZigYa9nImSe+EuSCEfE6Lv7BDfKg/bj/
	 T42+jYO2l3TzER4JMJPgChcE2/Hok1jo4irdYvYk95WAIYfM71aS9Fk2aOEmC9V924
	 X5wytt6w5QY+/0Ae0U73HRphlb9IfP5UU5UauAiat2suKcckK4SGgodnCaIbhZjDrL
	 BfTaYU3OD6AkHIGKpk4uJ7solP3YUGpggOYVG0TX9L/emUKA5aiC5bJDF22zQLWd1V
	 RDPL6mrJABKrQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	David Binderman <dcb314@hotmail.com>
Subject: [PATCH] arm64/crc-t10dif: fix use of out-of-scope array in crc_t10dif_arch()
Date: Wed, 26 Mar 2025 13:09:18 -0700
Message-ID: <20250326200918.125743-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Fix a silly bug where an array was used outside of its scope.

Fixes: 2051da858534 ("arm64/crc-t10dif: expose CRC-T10DIF function through lib")
Cc: stable@vger.kernel.org
Reported-by: David Binderman <dcb314@hotmail.com>
Closes: https://lore.kernel.org/r/AS8PR02MB102170568EAE7FFDF93C8D1ED9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/lib/crc-t10dif-glue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/lib/crc-t10dif-glue.c b/arch/arm64/lib/crc-t10dif-glue.c
index a007d0c5f3fed..bacd18f231688 100644
--- a/arch/arm64/lib/crc-t10dif-glue.c
+++ b/arch/arm64/lib/crc-t10dif-glue.c
@@ -43,13 +43,11 @@ u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 
 			kernel_neon_begin();
 			crc_t10dif_pmull_p8(crc, data, length, buf);
 			kernel_neon_end();
 
-			crc = 0;
-			data = buf;
-			length = sizeof(buf);
+			return crc_t10dif_generic(0, buf, sizeof(buf));
 		}
 	}
 	return crc_t10dif_generic(crc, data, length);
 }
 EXPORT_SYMBOL(crc_t10dif_arch);

base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
-- 
2.49.0


