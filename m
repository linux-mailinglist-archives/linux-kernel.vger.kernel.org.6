Return-Path: <linux-kernel+bounces-343191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C0C989797
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F4C1C20CB8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9577346F;
	Sun, 29 Sep 2024 21:21:38 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B468B65C
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727644898; cv=none; b=B7N/bA0CDtF9GASxR00k/DqZl1GFoh19v1i5CETnnmD7mj1X2De11JqUHXQWPJhQ4VY6CdhCe0IX5AUwKAvYZHVnr6qv65hEzwhvlr06MtJ5IcxlScVRJc3Svneb9nAgRYP635cu0qMUinvE8+lutoDC2dLOLbAM+ywhRV0Bl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727644898; c=relaxed/simple;
	bh=AVp6EyGhbA+RQ4K2FJ+mwm1DNxsQfli7ptB9xX1hWy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewUEUvAwLzq8IAWH6Vrpgvp7jZDOM5TY567s0GPmjFSQGLbVeDYg9BOKWVwbC1c5AiHCjsqrKBnfk9QFMc0WoXBzXLR7cfdqVqmkq7jN56x6o+v91WYuHPOMgSR0t8HhQrhdA/ejEHofNnwlghR60DESUio5KnK2tLPLVNN6a34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 3D7BB1F0004D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:21:31 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 59191A608D1; Sun, 29 Sep 2024 21:21:30 +0000 (UTC)
X-Spam-Level: *
Received: from localhost.localdomain (unknown [192.168.1.64])
	by laika.paulk.fr (Postfix) with ESMTP id 08828A608BA;
	Sun, 29 Sep 2024 21:21:27 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] ARM: atags: Be silent about missing ATAGs
Date: Sun, 29 Sep 2024 23:21:22 +0200
Message-ID: <20240929212122.701125-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Kocialkowski <contact@paulk.fr>

While the ATAGs functionality is still available in the kernel, it has
been deprecated for a long time already and probably has very few users
left.

Stop printing a message when ATAGs are not found since this is now the
situation most users will expect.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/kernel/atags_proc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index cd09f8ab93e3..6643fffecfb7 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -41,10 +41,8 @@ static int __init init_atags_procfs(void)
 	struct buffer *b;
 	size_t size;
 
-	if (tag->hdr.tag != ATAG_CORE) {
-		pr_info("No ATAGs?\n");
+	if (tag->hdr.tag != ATAG_CORE)
 		return -EINVAL;
-	}
 
 	for (; tag->hdr.size; tag = tag_next(tag))
 		;
-- 
2.46.2


