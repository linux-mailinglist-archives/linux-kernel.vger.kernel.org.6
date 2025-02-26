Return-Path: <linux-kernel+bounces-534987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0186A46D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993D516C675
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7925C6FA;
	Wed, 26 Feb 2025 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE7ISIiE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA625B672;
	Wed, 26 Feb 2025 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605857; cv=none; b=NxUIHjoXviA0iFLqg9Vi1QFEAPnJOnM+YRNZlBZ8uql7GXyBwnRtz3jKMUzN8QqiWq/B4UZYTg3/IXkjneO95XoLy+MVFHBXER67GSfOPm/mIRKJSQozwSMrEuOssNqVdYs2RNdjLYckVEEkpLs2Oq0ARU//06uy/VWAtTNhvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605857; c=relaxed/simple;
	bh=RlkJX0MrhsJeOtYwbzKz9uU11pc4QQCMS9xkZOpuwfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXNOZfi/6aKvbR5Nlh8KuRTtsBqfOnnIt81vrQDAW1WKA7k/ui8BytzJoqJHESXfZ514NeBjYo/2XnL2TRIX3H8i6RjWm6LpvNmrWLcb+UQBQk+rn7qeZzoptbmzNKWLqwjouMv9A1WqZe2BBxQiYehYDWka506M9l3jRZZ5ZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE7ISIiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C017BC4CEE7;
	Wed, 26 Feb 2025 21:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740605857;
	bh=RlkJX0MrhsJeOtYwbzKz9uU11pc4QQCMS9xkZOpuwfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CE7ISIiEN2Hji+NgktAwqWFB07Os68S3dsCqnBgMW8k5xkOo5gWM6ysoxNTbFa+o/
	 XSEC8UUczGK2nqzN+qXaVnVkdvoqFi9YjqEGo5nrwC87gjPNHiBK90Q4qO1Xihv3c4
	 ZmNI3Y7tUf/rvLd8cevbn949rbxKouDFTZF82gH/WTXDLvrGkwunrR/ngFLYdJmjoC
	 a7fzjlv7IkJzofmfb4iXE3nKwVGBuHcT24stYO7p86P2tq6fimGaoybjN28LiZsk8r
	 61asg/oLuTd0VrDPKhjLbDZro7leV5fV/mzDbhNvV5vukRnQYGSReTZxCjLObwyPIh
	 30sCj1B/Pcu4Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 01/10] x86/Kconfig: Geode CPU has cmpxchg8b
Date: Wed, 26 Feb 2025 22:37:05 +0100
Message-Id: <20250226213714.4040853-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226213714.4040853-1-arnd@kernel.org>
References: <20250226213714.4040853-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

An older cleanup of mine inadvertently removed geode-gx1 and geode-lx
from the list of CPUs that are known to support a working cmpxchg8b.

Fixes: 88a2b4edda3d ("x86/Kconfig: Rework CONFIG_X86_PAE dependency")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..42e6a40876ea 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -368,7 +368,7 @@ config X86_HAVE_PAE
 
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
+	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7 || MGEODEGX1 || MGEODE_LX
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
-- 
2.39.5


