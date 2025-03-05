Return-Path: <linux-kernel+bounces-545902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74020A4F349
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DB416ECC6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B00E86340;
	Wed,  5 Mar 2025 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJIJu1+P"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB72746B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137094; cv=none; b=d4QxQB5y4miz6JevsUw2w0abyBOloS2VI9muS9GrZLkwa5rEE23iNqE3ODUMVMcWZjA2HccmPX3fwUJOUNUiXG0626K1uB7s7God17XNoNt2jnrAl7vdwX0W6A5SCuFIsXDv+qwbjdPQNmuxJV2fKCFPUw+/1/tcE0QuaziUezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137094; c=relaxed/simple;
	bh=FNxvJ4i5f2XwuDmA6j1Sa8aqNIwlPZW0fGf9vRBkM4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cibnau8oCTKxldr/YYKJ/WIR9UfKje5e87CEcdNraqp5qcglNckWsEh2cvWT80hRp2fTEqahhEiMoA6UcaI63WnEIzQ5gNZdtR6+EMXAdwBj9PivcIRfWt4lu0owSpfjxRO4o6Dqk4htufEx2TtT/O0sG41PfCRczvcA2we74O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJIJu1+P; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741137088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RHS2qHcb2Sj4DUzb5BVeKI8CQswnw3nvUmflGuif8EA=;
	b=FJIJu1+P8A8CQmcUZXFpmID4+e+gh6xjVKgrXKKcfy+WtH5yRGaPIoGI/jkXx8unO6kmSj
	Dvmhg/O+yBBrp7NiEQ0zuYcDe9aT+XwCCDQVw1p3et/i+z1Hzt/5M0DPjVi/wFaRJ5Rpcr
	lmON1K4IAmZj6oRUnC2niGXM47rYIRg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: Replace deprecated strncpy() with strscpy()
Date: Wed,  5 Mar 2025 02:10:21 +0100
Message-ID: <20250305011020.160220-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/xfs/xfs_xattr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 0f641a9091ec..9f9a866ab803 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -243,9 +243,7 @@ __xfs_xattr_put_listent(
 	offset = context->buffer + context->count;
 	memcpy(offset, prefix, prefix_len);
 	offset += prefix_len;
-	strncpy(offset, (char *)name, namelen);			/* real name */
-	offset += namelen;
-	*offset = '\0';
+	strscpy(offset, (char *)name, namelen + 1);		/* real name */
 
 compute_size:
 	context->count += prefix_len + namelen + 1;
-- 
2.48.1


