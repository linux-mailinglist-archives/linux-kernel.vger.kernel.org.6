Return-Path: <linux-kernel+bounces-300378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFCA95E2FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 12:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CC3281A12
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB413A89A;
	Sun, 25 Aug 2024 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="a8uAy1TB"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057EC2F34
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724583217; cv=none; b=SEF5//n/qLnkk2lH2GfH3iJFZpnXalvn8ZWRTpSB7vIwosJVaGjsacVPM/rt14+PM98BwJvyhOKcoLDZKZcJPtAAEiFKfE2q+y1ZxGX/AmCnrVn4pnvyfjBq33ZgtecbQah65167lxiD2jHiksTKyAteoczJiAfJQv8Eq/X/xPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724583217; c=relaxed/simple;
	bh=h//gVpOCG2CPlj20k2ValazWq1kISCg2yLClG5rKawQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UcDS0BTLo9jLA7TKIC00BQPe5/rE/vEqCua5odrR6O1k+ES+UBLswJ2B9+88LvSuetysNlTy0itOc8oDARQrLA/+dMy0Xovio9T2ekwo0VzI5I7in46tCaIubofu18aIALyTi7lfHoENr717U6kObmjSQxPjtztKap6tRl/G3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=a8uAy1TB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724583208;
	bh=h//gVpOCG2CPlj20k2ValazWq1kISCg2yLClG5rKawQ=;
	h=From:Date:Subject:To:Cc:From;
	b=a8uAy1TBBigBHNCPnbo+/YwVPVAIbFEpsAMXKGOefNw3Kg6rUfd5/mrvOkO12z7w5
	 q9oSFXh2B2MXQjPSjFtPHYHF+KLG+0BEjcZ9t9EMbBiZ7nfCNGAhuMaPBayi2DLlgU
	 vfw13kqM9HU9VrvhSsTrk4MtDdl3jiyb2f3Jvvis=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 25 Aug 2024 12:53:14 +0200
Subject: [PATCH] ucounts: constify sysctl table user_table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240825-sysctl-const-ucount-v1-1-b4e9277c62a1@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABkNy2YC/x3MMQqAMAxA0atIZgOxWBSvIg5SowaklaaKIt7d4
 viG/x9QjsIKXfFA5FNUgs+oygLcOvqFUaZsMGRqasmi3urShi54TXi4cPiEdhqpra2hpiHI5R5
 5luu/9sP7fht3OB1lAAAA
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724583208; l=968;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=h//gVpOCG2CPlj20k2ValazWq1kISCg2yLClG5rKawQ=;
 b=k4T0Ku3Lg26+aUrCCK+n3sw2rpEfkLLlanPQFKImCksUeNMaSlHtI5Hdxhxs0ksGvURIGDh+1
 p5AsKDlmPRsCRY/GBdatlXB4UbJe0Vs12KHUliiOjt69iWshGJ2jfaQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The data of user_table is never modified,
but only used as a template to create copies from.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
kernel/ucount.c has no proper maintainer.
This patch is meant for the sysctl tree.
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 8c07714ff27d..4f6dd1a30117 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -70,7 +70,7 @@ static long ue_int_max = INT_MAX;
 		.extra1		= &ue_zero,			\
 		.extra2		= &ue_int_max,			\
 	}
-static struct ctl_table user_table[] = {
+static const struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
 	UCOUNT_ENTRY("max_pid_namespaces"),
 	UCOUNT_ENTRY("max_uts_namespaces"),

---
base-commit: d2bafcf224f3911b183113b2fcb536c9e90684a3
change-id: 20240805-sysctl-const-ucount-5da084520770

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


