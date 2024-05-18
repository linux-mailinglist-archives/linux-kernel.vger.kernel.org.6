Return-Path: <linux-kernel+bounces-182889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0658C9164
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A1F2823FD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F59F3B79F;
	Sat, 18 May 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ahTgwzsB"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846F79CC
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716040442; cv=none; b=TkfQd+RQQ9Ki6I7Vq2zqTCMscYMbm2Zh8WhsdKw1UuSU6jberPViIE5iJIhKGKLgVwVbPlCaLMPQpM8DD1b7c8G4SwtI21DLeK0xYpZEIaIwWStu060p36PuHRmSLYgI9wdeCaBy2HDUPgCK/cTdh6w3PkyVmOx1hpHIwA/0tUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716040442; c=relaxed/simple;
	bh=/KWxYpLd94BTwlVh5BYQvkcDNPM+X4xXUeUhBQVNxrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e0bssqsqzYIxjga01oQSXC1u00/ypxc8ZpCOxnlEx1fTwJW4F3rLeya2e8SWLdH1pgCB3bxPdlndh9+i8ZmpSnPqCO0rmZLYhTpkTXryE3/fkXFwJ9UVbqMRL6KPbD3Ld07DlPkeTmTO/v0bOdwaAKjQtnrlBqwCz6U+sQyOgzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ahTgwzsB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716040429;
	bh=/KWxYpLd94BTwlVh5BYQvkcDNPM+X4xXUeUhBQVNxrc=;
	h=From:Date:Subject:To:Cc:From;
	b=ahTgwzsBWZkitNWlbc48nbYPyH5zmQIxqCCR/0jZ3qgpwx24Eso9W7RaHGrfLeEmY
	 KIpTMn/XqlbC31xj41ZyeErdN9mEfR55bOsMg2POAsKBwR6rPWbrQP7pdynCRW/+WJ
	 4j2VokyjPhBzgSa8eV6pXZoQDOHb15PDSFmvT/AM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 18 May 2024 15:53:40 +0200
Subject: [PATCH] utsname: constify ctl_table arguments of utility function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240518-sysctl-const-handler-utsname-v1-1-27a6c8813620@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAOOySGYC/x3MQQqDMBBG4avIrDugRot4FelCJr91wEbJRLGId
 2/o8oPHu8gQFUZ9cVHEoaZryKgeBck8hjdYfTbVZd2UbdWxfU3SwrIGS5wLvyDyniyMH7CbHCA
 Nnl4c5cUWMen53w+v+/4BeY/u6G4AAAA=
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joel Granados <j.granados@samsung.com>, 
 Luis Chamberlain <mcgrof@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716040428; l=3200;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/KWxYpLd94BTwlVh5BYQvkcDNPM+X4xXUeUhBQVNxrc=;
 b=Iz+ws/xeZHtFVIFIejMDjbTWkbL0gCCEAV9cDbzSsziaEusvFOMoPOFCY1SWh2zADdUGrqH89
 9GXF+L6l4VcCGDR74bz+oh3Z3quSHAeYw2mw/3nD+OrjXbWWPcpSGoi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysctl core is preparing to only expose instances of
struct ctl_table as "const".
This will also affect the ctl_table argument of sysctl handlers.

As the function prototype of all sysctl handlers throughout the tree
needs to stay consistent that change will be done in one commit.

To reduce the size of that final commit, switch utility functions which
are not bound by "typedef proc_handler" to "const struct ctl_table".

No functional change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This patch is meant to be applied through the sysctl tree.
There doesn't seem to be formal maintainer for this file.

Motivation
==========

Moving structures containing function pointers into unmodifiable .rodata
prevents attackers or bugs from corrupting and diverting those pointers.

Also the "struct ctl_table" exposed by the sysctl core were never meant
to be mutated by users.

For this goal changes to both the sysctl core and "const" qualifiers for
various sysctl APIs are necessary.

Full Process
============

* Drop ctl_table modifications from the sysctl core ([0], in mainline)
* Constify arguments to ctl_table_root::{set_ownership,permissions}
  ([1], in mainline)
* Migrate users of "ctl_table_header::ctl_table_arg" to "const".
  (in mainline)
* Afterwards convert "ctl_table_header::ctl_table_arg" itself to const.
  (in mainline)
* Prepare helpers used to implement proc_handlers throughout the tree to
  use "const struct ctl_table *". ([2], in progress, this patch)
* Afterwards switch over all proc_handlers callbacks to use
  "const struct ctl_table *" in one commit. ([2], in progress)
  Only custom handlers will be affected, the big commit avoids a
  disruptive and messy transition phase.
* Switch over the internals of the sysctl core to "const struct ctl_table *" (to be done)
* Switch include/linux/sysctl.h to "const struct ctl_table *" (to be done)
* Transition instances of "struct ctl_table" through the tree to const (to be done)

A work-in-progress view containing all the outlined changes can be found at
https://git.sr.ht/~t-8ch/linux sysctl-constfy

[0] https://lore.kernel.org/lkml/20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net/
[1] https://lore.kernel.org/lkml/20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net/
[2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net/

Cc: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/utsname_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 76a772072557..04e4513f2985 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_PROC_SYSCTL
 
-static void *get_uts(struct ctl_table *table)
+static void *get_uts(const struct ctl_table *table)
 {
 	char *which = table->data;
 	struct uts_namespace *uts_ns;

---
base-commit: 4b377b4868ef17b040065bd468668c707d2477a5
change-id: 20240518-sysctl-const-handler-utsname-3f3eec4e6dc3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


