Return-Path: <linux-kernel+bounces-389445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C92C9B6D31
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115B61F229C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22C01D0E00;
	Wed, 30 Oct 2024 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxAjStk3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B701D0B81
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318218; cv=none; b=bhFw493NbkPQK2edKXweTEZ7wfFI9i2csgeU43ub/wUIpWedsjKOuOxtFqIDVNpxlCJ89y0zMZ4BEFYNF+zjR1f/xP7Tq6MSrVu9HL6j6RI/x6Fy4KgXzLYLuhgsUddmsqR9d8NPKtPYHIqb2V6LG7vtClGfRgsaXdZFs6h6170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318218; c=relaxed/simple;
	bh=ycBA5rQ633qHtrgsH/1UuH4lcA9FLFSnQ1HGmzbyy/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cE748VWkBIt/L6gCIhSjySi7/gu+ZvrDVX7zqfmPuM1f6+h/II7liSZWDRz8R+9jvfkx1qjxMoIwNSYYH42wsICiPBNqEnMNOUQEAPCu/t2nqS0PEWa+2/tJOhZ6iKulUs8aeq7/Sqdp/XWczRdbP6BrssIelx6eh9TWHeUPn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxAjStk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C23BC4CECE;
	Wed, 30 Oct 2024 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730318217;
	bh=ycBA5rQ633qHtrgsH/1UuH4lcA9FLFSnQ1HGmzbyy/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxAjStk3NRHbwgxtP4Xu9QCLn1WSKnikydeH/as344Dy+uAUjbiDlK1OjCjuRhNR4
	 H+fVqzpmPoJHtYm+7Adjhe9wFk1gVTh7brSffpzqG2J+6sXRlnDuz5saaROzPybqQQ
	 1zRu466XcdAHGY+anFQDZbmY+A/PZzEJe5m4iAZ7XJjnWB2WAM7jQg1pn4ljIXhI+a
	 GEmB/BhdK87ApE7dc+AxtJCR2vlmHj8escxses/b1Mf/hiYtj8MMQ1A2NR3/fsSjDU
	 M2Tw8Px/oGVD852DFa5H9KTwma0rO/M/B6pPc1mrvupa0vV34/IgwVeUYWhPkVG2LQ
	 SipedeRmhh23g==
From: Arnd Bergmann <arnd@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] m68k: select 68020 as fallback for classic
Date: Wed, 30 Oct 2024 20:56:14 +0100
Message-Id: <20241030195638.22542-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030195638.22542-1-arnd@kernel.org>
References: <20241030195638.22542-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building without a CPU selected does not work.

Change the Kconfig logic slightly to make sure we always pick
68020 if nothing else is enabled. There are still some
intentional warnings for builds with all platforms disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/Kconfig.cpu | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index e7b5f6b55947..c9a7e602d8a4 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -21,6 +21,7 @@ choice
 config M68KCLASSIC
 	bool "Classic M68K CPU/machine family support"
 	select HAVE_ARCH_PFN_VALID
+	select M68020 if MMU && !(M68030 || M68040 || M68060)
 
 config COLDFIRE
 	bool "Coldfire CPU family support"
-- 
2.39.5


