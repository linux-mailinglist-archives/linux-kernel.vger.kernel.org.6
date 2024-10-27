Return-Path: <linux-kernel+bounces-383820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E0C9B208B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9DB1F232D7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CA91836FA;
	Sun, 27 Oct 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="b6hlERY2"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83231DFE8
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062057; cv=none; b=qjGondYwSZRdbrMY77fz1OS8fPaeYs99GdPmMybrIzjyYWq8i3Wtn/XzTO0cuiOOIpd27FClCwk/Q/ry3vWPpubXEj9z++cAYN4XesRAxZKiBIjd/72w5RP7ij/0XA1nVJafRxZsKySJfu1QFD/dtS91WMef5i3kCrF0mg2iJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062057; c=relaxed/simple;
	bh=QVv+kO+K37mWasdouIdj9CxXrDrFw2W1ckdgYYjW0JA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TKIh/Du87wOEHeJmZjndehuLiGe3jLH/rmnaL+KoqJItmT87nLJMffGr0Xem/ZKP2AjyYYenrKlMqfFVZkn1tqdKOiHXwRlCmVLPrwhvOUgWTVxmL3s2Ar6D5uWUzY67K1mgdDgiRnjjwIgQb5qcgATAMXqIOfSUkaKZ3zmjopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=b6hlERY2; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id B51B5177100; Sun, 27 Oct 2024 20:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730062049; bh=QVv+kO+K37mWasdouIdj9CxXrDrFw2W1ckdgYYjW0JA=;
	h=Date:From:To:Subject:From;
	b=b6hlERY2arOMNPwYBr5tN0uX7SCHCxjXvDafqF334YEGkmUPJOipuKyOUnfQ+bzUJ
	 IQ3tqB9BLHt7Ovc74b77Hwl7U3nQUSOu5hTumohAwPHEtc8pdTZdtAf8VZURaNYIAV
	 pJ3ptPVYqR/vFjFNxPohV/TB77IhFA1jyKW3z4IvaGT0zidzyt6hHsvayHiwosSHG1
	 RcyIY/MtN4P3w2K7v3PlT44S+x4USqDplzlQc0q01YDeuwaAmuwRPAg9cdQjbSHuJe
	 OYhUWNGjtSBUI3FXl/+6G2Ei7SKmJaP2gGnGkCgRRGr4qwUdR6yUl/27KfxoMxvmcW
	 p3HDfLUYqjuiw==
Date: Sun, 27 Oct 2024 20:47:29 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Fix breakpoint enable to be silent if already enabled
Message-ID: <20241027204729.GA907155@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the breakpoint enable command (be) to a logic that is inline with the
breakpoint disable command (bd) in which if the breakpoint is already in
an enabled state, do not print the message of enabled again to the user.

Also a small nit fix of the new line in a separate print.

Signed-off-by: Nir Lichtman <nir@lichtman.org>

---
 kernel/debug/kdb/kdb_bp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
index 372025cf1ca3..c0c2072f5452 100644
--- a/kernel/debug/kdb/kdb_bp.c
+++ b/kernel/debug/kdb/kdb_bp.c
@@ -460,13 +460,15 @@ static int kdb_bc(int argc, const char **argv)
 
 			break;
 		case KDBCMD_BE:
+			if (bp->bp_enabled)
+				break;
+
 			bp->bp_enabled = 1;
 
 			kdb_printf("Breakpoint %d at "
-				   kdb_bfd_vma_fmt " enabled",
+				   kdb_bfd_vma_fmt " enabled\n",
 				   i, bp->bp_addr);
 
-			kdb_printf("\n");
 			break;
 		case KDBCMD_BD:
 			if (!bp->bp_enabled)
-- 
2.39.2

