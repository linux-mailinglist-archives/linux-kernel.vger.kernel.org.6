Return-Path: <linux-kernel+bounces-517119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17046A37C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8B2188316E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8FC198A36;
	Mon, 17 Feb 2025 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mmq7ri2s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPyjybcc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7888F5C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777886; cv=none; b=iegJV3ZK6qrLx7FZJIn1VyyecLE2Gf8eHcgxvgRk57nceKL+QMGvJzk2oGY4viUEUQomryaM5+V/w2LtsGf84R+nJ2Zm1d0D4sJlBzR2U0vLe6USuGEEVBYqC9vgLO+5NMqxyfKaz+RLitvVZ5DO2J5BdK7K3fuyVxbzpOVW5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777886; c=relaxed/simple;
	bh=HbY7o1txWSoh2feuXDu+61H2EnR68libmL0CyHKvVmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uki9S14WC5DvR/eKMqBk8onDEVXZ3eKlK/AWiyUtcW/U42aRQs6vm6u2hLNERwTaachzq1QrKKIq7Nqz/1eMnNfZzfoYAb8mDlVsQy55jxxBLmZ6cbVENPyeq+uVS5u7PgXihx6o3FMS8lR3lVD4JyX4g4E7MpYe/fWaLv5pgJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mmq7ri2s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HPyjybcc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739777883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/e6hxVPR8O3eSw41KB/yWx13z8cE7qxMOk6uwUqRyOI=;
	b=mmq7ri2soJnIuk80hlfk7lJDIEg5d+slMqE4lwALxZWl8x2hViKdViCeO4pv1gHrpxxe7b
	vVglNQC1ZoCX+tQ0LI1KcWgwbSm/DQq6H6IDG8EgQ1wBtXXwuaRnthS78vzCM3CHs1jgzJ
	sks0ohCLKT82SdgzS+gykqzcqLEwkxg/1pwFeddcvM5D6NZ5aJclWpILpfrDVqs4bmhAJj
	BX8Jc9ABu6fnLwcvp27o6SMENppq/VcEb0lBye3YiSuNDHeysjK289fbouq0j/JXuaxCV4
	3Q/5MWUdTaqQnzK7nrxaV5JhUiDhPUUtubcrcXZZ6DDdvuoQcjKpjXFAzf6IKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739777883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/e6hxVPR8O3eSw41KB/yWx13z8cE7qxMOk6uwUqRyOI=;
	b=HPyjybccJt0z38iBCnAO9Ze7hTvZidli6j+szvSACKwrnjiQCHVPmKwxUx+5cOZAmFQsDE
	fpsRM3SVpVjiEqBw==
Date: Mon, 17 Feb 2025 08:37:58 +0100
Subject: [PATCH] riscv: mm: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-restricted-pointers-riscv-v1-1-72a078076a76@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAFXnsmcC/x3MPQqAMAxA4atIZgNt8Qe8ijhom2qWVpIignh3i
 +M3vPeAkjApTM0DQhcr51Rh2wb8saadkEM1OON64+yIQlqEfaGAZ+ZUSBSF1V84OL8OoY9btB3
 U/hSKfP/veXnfD1ZIhOdrAAAA
X-Change-ID: 20250217-restricted-pointers-riscv-62ca6d5fbf14
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739777883; l=1258;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HbY7o1txWSoh2feuXDu+61H2EnR68libmL0CyHKvVmQ=;
 b=9CoJwe1ivfUZhZ0Du4FieuXxCrYW629ahO+fL6dRstjmrXvuC/0QbTI7562oIjXixrE6e52sx
 S0WFfyrgan5A96bzlywW5jyteRl7ZQpvXeOnpxIMeztDZgRh+Kecapx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/mm/physaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index 18706f457da7ecf84591510ea26789f7ae3e9abf..559d291fac5c62271a0e793321c97b87bf4e1b3c 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -12,7 +12,7 @@ phys_addr_t __virt_to_phys(unsigned long x)
 	 * Boundary checking aginst the kernel linear mapping space.
 	 */
 	WARN(!is_linear_mapping(x) && !is_kernel_mapping(x),
-	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
+	     "virt_to_phys used for non-linear address: %p (%pS)\n",
 	     (void *)x, (void *)x);
 
 	return __va_to_pa_nodebug(x);

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-restricted-pointers-riscv-62ca6d5fbf14

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


