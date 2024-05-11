Return-Path: <linux-kernel+bounces-176700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D798C336E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20146B210CF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 19:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6F41CD2D;
	Sat, 11 May 2024 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jcNEqXsK"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911A1C2AF
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455701; cv=none; b=koOsDYqDoGuOSSpJkSS27kgPDleJkAMyeushJi83rK3ZIf3bUSkyeoA7lGmyPwtyOUmUFnsRe8KvUeKJhZ7nEszRIWWLWE6WkY2cnyDMFR6WxZnbRlJIs49oP8QRZ4FcVOPTklRia/HhovwVB1SL13j7ihpwh91yaiLzgnUevHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455701; c=relaxed/simple;
	bh=SgKxXa6mqbN5ukWsVqTXTS575TJrw64ZeSxfAyYN3Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U6IXk2SXsbiJ+sY5T+jTw5xIsYem0lqwHoIV7OSDTf/b3RnIJbQcynT2LIo1kBWKuue3fzfAMbFoZluGpWWMt30i+9QKs1e+GfXyplxbgkBybM0AQJhKuQzgwGtm/lulGgz2xSRAjFxAI8mTbrflJZS388UH1PI9OYg3cAKk6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jcNEqXsK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715455694;
	bh=SgKxXa6mqbN5ukWsVqTXTS575TJrw64ZeSxfAyYN3Wg=;
	h=From:Date:Subject:To:Cc:From;
	b=jcNEqXsK47oX7Sw3INC1VGA/jaRQZxxXSip114BgCq2HdJIXtIJnlWI9p1HrYiNQz
	 WKtqVthQunspX2LY+/5MnuytIoJkaZNK2E34JTOioSHDQvdWYulFoT331fxjb9b5Rf
	 9I87W00zwC2O7ItNZVH/v0904lBvDUU+T/DnVoz0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 11 May 2024 21:28:10 +0200
Subject: [PATCH] ucounts: constify usage of ctl_table_header::ctl_table_arg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240511-sysctl-const-table-arg-ucount-v1-1-a00ad8f6f233@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAMnGP2YC/x3MwQqDMAwA0F+RnA20VRH2K+KhZqkLSCtNlQ3x3
 y07vsu7QDkLK7yaCzKfopJihW0boI+PK6O8q8EZ15vBWtSfUtmQUtSCxS8bo88rHpSOWHAcjBu
 ZurCEHuqxZw7y/f/TfN8P65Kiom8AAAA=
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joel Granados <j.granados@samsung.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, 
 "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715455694; l=2859;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SgKxXa6mqbN5ukWsVqTXTS575TJrw64ZeSxfAyYN3Wg=;
 b=IwKeUruqM/0hN2erb0tF9ZLZ/oP8tl6kVN8SmiJWTO5WbabTuDHdZ/vcCsVqPt80iDb6VrROl
 nWrCawWCcQlAkuIgiDC5soxbVoYnhrOWB5BcswS8Lu1D4tvifDW4yTB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysctl core is preparing to only expose instances of
struct ctl_table as "const".
This will also affect the member
ctl_table_header::ctl_table_arg.

Prepare for that change to "struct ctl_table_header",
and already constify the usage of ctl_table_arg.

No functional change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Motivation
==========

Moving structures containing function pointers into unmodifiable .rodata
prevents attackers or bugs from corrupting and diverting those pointers.

Also the "struct ctl_table" exposed by the sysctl core were never meant
to be mutated by users.

Process
=======

* Drop ctl_table modifications from the sysctl core ([0], in -next)
* Constify arguments to ctl_table_root::{set_ownership,permissions}
  ([1], in -next)
* Migrate users of "ctl_table_header::ctl_table_arg" to "const".
  (in progress, this patch)
* Afterwards convert "ctl_table_header::ctl_table_arg" itself to const.
  (to be done)
* Prepare helpers used to implement proc_handlers throughout the tree to
  use "const struct ctl_table *". ([2], in progress)
* Afterwards switch over all proc_handlers callbacks to use
  "const struct ctl_table *" in one commit. ([2], in progress)
  Only custom handlers will be affected, the big commit avoids a
  disruptive and messy transition phase.
* Switch over the internals of the sysctl core to "const struct ctl_table *" (to be done)
* Switch include/linux/sysctl.h to "const struct ctl_table *" (to be done)
* Transition instances of "struct ctl_table" through the tree to const (to be done)

A work-in-progress view containging all the outlined changes can be found at
https://git.sr.ht/~t-8ch/linux sysctl-constfy

[0] https://lore.kernel.org/lkml/20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net/
[1] https://lore.kernel.org/lkml/20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net/
[2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net/

Cc: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4aa6166cb856..d9e283600f5c 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -119,7 +119,7 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 void retire_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = ns->sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->sysctls);

---
base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
change-id: 20240511-sysctl-const-table-arg-ucount-75027ec3fbf4

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


