Return-Path: <linux-kernel+bounces-446451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB4D9F2472
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916121620AA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9A51922F0;
	Sun, 15 Dec 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eWO3aJxh"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17710189F56
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734274159; cv=none; b=t+ZNwq/ieKl/dyQE8a4BA5HNzO60Mazf5zb9k23Z6e+0hlQYTNjBEQsAX8yRTbwuZMXrj44SbFwX1J2BGRrQrs4i1pypKtOrHrqtviII6y7xjqrWWikH5vG9M/SsMSHdM4LMDRi1ICDRJfxNpCa09s5WXU1ikVjy6gekuwMCFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734274159; c=relaxed/simple;
	bh=OD/lWja0joVP9SVburnkmOGS1hQtirbqWB+jWss8JFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdNxD2ZU5+tKILPBK1NkjtYBMIwU3a7Z6azYTm8ojAi/tswZVH49HAduzrUuxDYYhXwtVHrVH+1Y8U90q1C+WfmfSFSukemplic2dVVbcK7pEWMP1C+vFGVK4vvzrjeWSJIW4JTDNbSOU7VbLd1z1TWeUmCn5pwqerVa3WMKVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eWO3aJxh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734274154;
	bh=OD/lWja0joVP9SVburnkmOGS1hQtirbqWB+jWss8JFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eWO3aJxhDiFpDpZ7akFcpN4b6hIZ1NSOM5B9SaMNeEk/xFyHqqGvg0eTRfxZQaN5j
	 R7h0H1q/bGqkMu5Q3nVSAxZYspFMmTcm4NfVDSnGVRtckHi7T14dgXh1yBy3K8ts0N
	 /qs+tBA7XEq6G5ttrL0wktU7451yhQLDnJKebcgw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 15:49:10 +0100
Subject: [PATCH 2/4] firmware: google: gsmi: Constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-google-v1-2-e5c2808f5833@weissschuh.net>
References: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
In-Reply-To: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734274153; l=1375;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OD/lWja0joVP9SVburnkmOGS1hQtirbqWB+jWss8JFI=;
 b=zoty251LisZOy9nkLs5RVC6Mdj1bppEadFFAktrMHWMQjivkuIrddKYlBft+ziH7xs15NyFr4
 oSrUsxQqMavA2cs+mZtwNc6Edz2U9UR/vI3/qyuaD80ezUQF1ZUtphJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/firmware/google/gsmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 24e666d5c3d1a231d611ad3c20816c1d223a0dc5..e8fb00dcaf65bc593dd15562f20aeea482ccfc3e 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -488,7 +488,7 @@ static const struct efivar_operations efivar_ops = {
 #endif /* CONFIG_EFI */
 
 static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
+			       const struct bin_attribute *bin_attr,
 			       char *buf, loff_t pos, size_t count)
 {
 	struct gsmi_set_eventlog_param param = {
@@ -528,9 +528,9 @@ static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 
 }
 
-static struct bin_attribute eventlog_bin_attr = {
+static const struct bin_attribute eventlog_bin_attr = {
 	.attr = {.name = "append_to_eventlog", .mode = 0200},
-	.write = eventlog_write,
+	.write_new = eventlog_write,
 };
 
 static ssize_t gsmi_clear_eventlog_store(struct kobject *kobj,

-- 
2.47.1


