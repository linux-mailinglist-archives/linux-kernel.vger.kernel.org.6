Return-Path: <linux-kernel+bounces-243094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88E692918C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749A1283013
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C311CD02;
	Sat,  6 Jul 2024 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="b6WX5LNN"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251F28DC3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720251578; cv=none; b=RLSNvVi6Y8DxuYqmgR9iQJar1flcfDhdwSFRwYBdI9OANeJx1F67JMOrWSBxgot4+Da6o4RrhDQha8UCt8bazXIxP9Q+TUmYnU6hJRwswQoceRsXEGrL3Oy3ys2otiboIJoluZFK3sFmgeAbeDcZt8WfNKZ0hxOTNNXCigDkLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720251578; c=relaxed/simple;
	bh=N4/m+0jGHRB86snyK/T2jGaCvfmvKZViPfJsuSYxi7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IL2uHtrjhLtu/QLy9zcDbpEhgDnBWfE+igcx18HODDSe4C5HHyAwTZTjoPF0Jet960e0jcOgLtcRhUsn6M87EQRcelOiC1b+1MkNvahHSKIPMjIiQY+gglRfaCt7w6mVfrvO7MBSoqllJvNpNRzaxCbD/MJrdFAnABjJo3tmG18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=b6WX5LNN; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1720251575;
	bh=N4/m+0jGHRB86snyK/T2jGaCvfmvKZViPfJsuSYxi7I=;
	h=From:To:Cc:Subject:Date:From;
	b=b6WX5LNN8du7D3Rrd6R93aeLuG5YFcsL5639i61K3spvEniJo05Sy16bkiYrRcG38
	 Bro3mlwgnrP6hQpdp6u//ZsS6PvBfvsJxP0fEeFQCIepBtx8+dwNI6hW9XMwL9cN1b
	 rohZGQoRGEb8gcuN+TBb5g2DHl25bP5Hs4y0S31c=
Received: from stargazer.. (unknown [IPv6:240e:358:11fb:d500:dc73:854d:832e:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 2C4F81A411C;
	Sat,  6 Jul 2024 03:39:28 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: Jinyang He <hejinyang@loongson.cn>,
	Youling Tang <tangyouling@kylinos.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Fangrui Song <maskray@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 1/2] LoongArch: Remove a redundant checking in relocator
Date: Sat,  6 Jul 2024 15:38:57 +0800
Message-ID: <20240706073858.161035-1-xry111@xry111.site>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With our linker script "relocated_addr >= VMLINUX_LOAD_ADDRESS" should
be always true.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/kernel/relocate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 1acfa704c8d0..69d73dc7326a 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -34,9 +34,7 @@ static inline void __init relocate_relative(void)
 		if (rela->r_info != R_LARCH_RELATIVE)
 			continue;
 
-		if (relocated_addr >= VMLINUX_LOAD_ADDRESS)
-			relocated_addr = (Elf64_Addr)RELOCATED(relocated_addr);
-
+		relocated_addr = (Elf64_Addr)RELOCATED(relocated_addr);
 		*(Elf64_Addr *)RELOCATED(addr) = relocated_addr;
 	}
 }
-- 
2.45.2


