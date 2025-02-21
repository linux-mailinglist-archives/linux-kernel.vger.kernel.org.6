Return-Path: <linux-kernel+bounces-525470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89755A3F069
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6473AE5D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9C201017;
	Fri, 21 Feb 2025 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="dBMVE34p"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C81FFC6A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130435; cv=none; b=C6Z3RI1xXoG13Yc/zMbzvfTJ7fmJjmF74AX6UtSlqhBecStuzvMppZ0JU5iR1VESTKimc5sMHBTybWYkuVxpr0cg27b8DGWCmvTAo37jdAb5IJrjn1w4lMMUh0l2P4qZ1L+AGoB2yRdyJ/xd6MneeF2zlfS3WXEW8s5tHhfs4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130435; c=relaxed/simple;
	bh=6L5GbYGVZnK3Pg8hKzvZ2mxC8upqxVdMUqXOcV0n5Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bC1VGRo0P/opeyhCxUhUM9ZQdw47i1+DGYikxPdcFnaRR1vR3ptM62IsDcNq39A0lXie94SytTKMarvAUXq/L9XNsO3IatUrXilD+Q1pCxnsP7l7q15dClRrnbSg6DSmynfyvoLqD33gp8ocWqJx9BM3DuTxlaDd+ikz3eyTZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=dBMVE34p; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1740129945;
	bh=x8sbwyIvDcpG5z1EJ3Q7rOK3biWGRso3LJ6nU4kWQlo=;
	h=From:To:Cc:Subject:Date:From;
	b=dBMVE34p4MAObvl1+w37smAr2xxxAYpf+mLROe8dXHv/4JSjIXxqpGL6YsV0iNCC3
	 2eoWoPzcjiRJ9RDV8Ab+ahddfYE2Bp1NjQdCiPG2DEiNuBMhrbUCnYUPIVfZW03GBK
	 7GGK160XWhP3qWFu4+loW3BlOW3AV9bQr3o7c64I=
Received: from stargazer.. (unknown [IPv6:240e:454:4311:1f25:535e:dcbe:c175:b1da])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id B3E5C1A3F59;
	Fri, 21 Feb 2025 04:25:39 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] LoongArch: vDSO: Remove --hash-style=sysv
Date: Fri, 21 Feb 2025 17:25:23 +0800
Message-ID: <20250221092523.85632-1-xry111@xry111.site>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
far before the first LoongArch CPU was taped.  Using
--hash-style=sysv might imply unaddressed issues and confuse readers.

In the past we really had an unaddressed issue: the vdso selftests did
not know how to process .gnu.hash.  But it has been addressed by commit
e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH") now.

Just drop the option and rely on the linker default, which is likely
"both" (AOSC) or "gnu" (Arch, Debian, Gentoo, LFS) on all LoongArch
distros.

Similar to commit 6b7e26547fad ("x86/vdso: Emit a GNU hash") and commit
48f6430505c0 ("arm64/vdso: Remove --hash-style=sysv").

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index fdde1bcd4e26..abaf87c58f9d 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -37,7 +37,7 @@ endif
 # VDSO linker flags.
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
-	--hash-style=sysv --build-id -T
+	--build-id -T
 
 #
 # Shared build commands.
-- 
2.48.1


