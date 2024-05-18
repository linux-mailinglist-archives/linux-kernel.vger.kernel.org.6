Return-Path: <linux-kernel+bounces-182891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 742438C9167
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DC81F21FB4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D22BB1C;
	Sat, 18 May 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="d3oHzbDP"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B05E560
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716040823; cv=none; b=FnGEAaZEFVoJnDRQobeO57X5cE9o36EdyEujjjL+3QlQiIRR8H3YqLO7fk405ytV0+y8r5yrfsA8cJrG9L3ItK+tdXcVfs9Xbk0z6F1wRvolSN14hwJtLiWO6qGeSwnaJ1Isi/iXI7o/us7x+ZXf3WQNeb1n7s65g8Dkf9GEYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716040823; c=relaxed/simple;
	bh=61bJ2tqEF4n1McZZ9lfES2X9u82Av68XY/fmxSjnnHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TXAHksVtW5IVkylWDQNBQiWR6p245+53GKUR7u24qlu6zwQeQjXm8zDZIEWETXOs46p5aaRRDpp+5XCsKbFX6wrsPV5SPCbOMJMRdf1/962hHGX+ejxcdKh1D2dnZTtUKFwkQ775ZhhLNGFeAvxhnmc3FwyaDMjG0ajySxF/DSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=d3oHzbDP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716040819;
	bh=61bJ2tqEF4n1McZZ9lfES2X9u82Av68XY/fmxSjnnHw=;
	h=From:Date:Subject:To:Cc:From;
	b=d3oHzbDPuXyiPxXwyIkD0wYo5dxCSIOt4VaXpOLQBbeu0YVDPPfV2QrxFjtWWBiIJ
	 ec05tUXLqqjUR2UPES7usKst15os9tFW/AhGkgGACXd+5eFNcvUYNtpxPsu+vIkOD3
	 /B+9gQkHOFKMuUcJ0yfY+voDm+TfF+Z3h6xdlbH4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 18 May 2024 16:00:04 +0200
Subject: [PATCH] mm/hugetlb: constify ctl_table arguments of utility
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGO0SGYC/x3MQQqEMAxA0atI1gY0jlS8yuBijFEDpQ5NlRHx7
 pZZPvj8C0yiikFfXBDlUNMtZNRlAbx+wiKoUzZQRa+qrTu00zh55C1YwlxMXiKu+yLJj8jUucY
 xkWsZ8uIbZdbff/8e7vsB9MrC1W4AAAA=
To: Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joel Granados <j.granados@samsung.com>, 
 Luis Chamberlain <mcgrof@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716040818; l=3639;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=61bJ2tqEF4n1McZZ9lfES2X9u82Av68XY/fmxSjnnHw=;
 b=rR1MGhjRwrmAdI7KVzpkJ8wR2BDA/vbFj3Q+VN3FPM4Np3zANg44QwQMhTDWrDwThcSH4hjRo
 VCZKmbxyQyGCjExmpL9w5YLFn2Gguund5Y0dOqk6cWyeZcNsBs3tr7e
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
This patch(set) is meant to be applied through your subsystem tree.
Or at your preference through the sysctl tree.

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
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ce7be5c24442..53bb1bb86efa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4916,7 +4916,7 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 }
 
 #ifdef CONFIG_SYSCTL
-static int proc_hugetlb_doulongvec_minmax(struct ctl_table *table, int write,
+static int proc_hugetlb_doulongvec_minmax(const struct ctl_table *table, int write,
 					  void *buffer, size_t *length,
 					  loff_t *ppos, unsigned long *out)
 {
@@ -4933,7 +4933,7 @@ static int proc_hugetlb_doulongvec_minmax(struct ctl_table *table, int write,
 }
 
 static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
-			 struct ctl_table *table, int write,
+			 const struct ctl_table *table, int write,
 			 void *buffer, size_t *length, loff_t *ppos)
 {
 	struct hstate *h = &default_hstate;

---
base-commit: 4b377b4868ef17b040065bd468668c707d2477a5
change-id: 20240518-sysctl-const-handler-hugetlb-c28737c2275c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


