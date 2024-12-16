Return-Path: <linux-kernel+bounces-446776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6A9F291A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656D4188498D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BBD1B4157;
	Mon, 16 Dec 2024 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gGd9+H1A"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05449191F8F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322071; cv=none; b=ndZtfVwmxdf4yqXpsu4TQQDvY3ObrMjrg1r+dLR+k0dtln3dhG9mSoKnRr2Ch/NapvyWviB2LO1R3I6hk+QOA8bOD0xmhwPk8gX5uhpTaverrHyqyIsd+srdsUi9bIPwXMrtzv7EOISRt67xC0IvF74TQo5oxgRppaI2MoxMhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322071; c=relaxed/simple;
	bh=lpG1ThR/8HH372NAoQFJS0Y3lxzTHbVf7kKGZfLomkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CN209aJz5y0uht1b85TO5RVJZd8j88Q61vnSsASwcEvxhzXdHtH5v/q4vmjKqZNz1A2d2WL8bh4Dd7heerHtd+J5GtaWz0jrtH1IGWx2S15IK02k4vmxKfNooKwY/9Aze8cHTQNFh5Ilz2NF64FcrDdt7P4ifknqSUyrSwEDG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gGd9+H1A; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734322066;
	bh=lpG1ThR/8HH372NAoQFJS0Y3lxzTHbVf7kKGZfLomkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gGd9+H1ADEHjqWuudOxcGRWSv2b2PyMpyuCg6o0S2WV84iWtSMSm2qvDLMOKolW2s
	 Q/IdNHRLHFasCV5+TH9zJ0w92nniDVTmM7DSprZY+5DHHkBolzN4cl7nfbpwnhmzKP
	 KfwSBonKXmHfb+mJUa7E/j/aKDoXJDzZ4CSw75z4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 05:07:45 +0100
Subject: [PATCH 3/5] powerpc/powernv/ultravisor: Constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-powerpc-v1-3-bbed8906f476@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734322065; l=1354;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lpG1ThR/8HH372NAoQFJS0Y3lxzTHbVf7kKGZfLomkc=;
 b=FR6JUSEBPQc3U3GGSnGW9IVHs/F4mGUD0E0I92qZILVDo9mi57GtkSXWbOOTSE0CLhtga7jBb
 uj4m3AdQMHfA7/3Q+odV/9RDms/AMYC661n9V0oi8z9qQYG0IepYkRi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/platforms/powernv/ultravisor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/ultravisor.c b/arch/powerpc/platforms/powernv/ultravisor.c
index 67c8c4b2d8b17c3662507121e97f48587d3ef82b..157d9a8134e445ed22be8ae58ff9181b45ac7ff0 100644
--- a/arch/powerpc/platforms/powernv/ultravisor.c
+++ b/arch/powerpc/platforms/powernv/ultravisor.c
@@ -32,15 +32,15 @@ int __init early_init_dt_scan_ultravisor(unsigned long node, const char *uname,
 static struct memcons *uv_memcons;
 
 static ssize_t uv_msglog_read(struct file *file, struct kobject *kobj,
-			      struct bin_attribute *bin_attr, char *to,
+			      const struct bin_attribute *bin_attr, char *to,
 			      loff_t pos, size_t count)
 {
 	return memcons_copy(uv_memcons, to, pos, count);
 }
 
-static struct bin_attribute uv_msglog_attr = {
+static struct bin_attribute uv_msglog_attr __ro_after_init = {
 	.attr = {.name = "msglog", .mode = 0400},
-	.read = uv_msglog_read
+	.read_new = uv_msglog_read
 };
 
 static int __init uv_init(void)

-- 
2.47.1


