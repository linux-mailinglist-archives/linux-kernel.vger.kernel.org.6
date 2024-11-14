Return-Path: <linux-kernel+bounces-408508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307529C7F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F41282626
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9A14A611;
	Thu, 14 Nov 2024 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="l8tasvGm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNjGWWU1"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551982B2D7;
	Thu, 14 Nov 2024 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545864; cv=none; b=qz0RJEOv4oMOcnjeU9OH8RhQR86NLhaupaiX63leI/C+GCl1syKQMXj9ejblyfql9gVMSiUh/yhRHw+kubk8yiC/Y0pwoh4Jc7FpymYrwvyCaiIAiLtWgTKuNt7dpS+HgAbGikUmsW0RsVUdl0LD8GfYzv7NEJ+pnRRGPfOcw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545864; c=relaxed/simple;
	bh=WjC01+sS6nKTi7io9kauOjUhdDFeBAC7nscRHge7Vs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ20Ys3Z5T0gC8eyHqxdtgLxfKbOoZORPGxsPuZXyo2ZIqgOihF9w7ZIw1bJWRYS8uGCn9fDIRnQq57Yu5PPxUriDbLkHQze6m/G1Ez6/igKRWAfGLiZDT+3JUhImvSbWbcoY2k9a5ULwVBCfvbFTYbAo5w4Z8mkarDJVJQhtlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=l8tasvGm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNjGWWU1; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id F13DC11400AC;
	Wed, 13 Nov 2024 19:57:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 13 Nov 2024 19:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545861; x=
	1731632261; bh=+cKsHqUdRIqVh7tWBD/bK/cAI6O3Bzd18FXNBICgPtk=; b=l
	8tasvGmgCTw5hQX6fWvxRwJLvEDSSBSGnUYGRiGjK1vp4k2VAlVTkyFcvLOKY9qy
	FaXYA7R7lCD8lOqcwNerKhOr2uiHQweRLeJBBaGGnrIK2m5xglFUrFe6NVwZ+bAr
	AfwHmMIjJ7yBVLzSMMk9T1WY8K9Yo+t28cRLy9aZY34ekWdZbqvcIhbzrAlYF2fL
	w3GeeSEj96fjGYpXKuf7HPlQd54Wwotu8HD7G8Rqgx03xMI25PfdUUPfeStgkhT0
	INEdR7xIX/B1yQRTogVBScfq9JPlgj8l+3GjQUxk7KTe6t98jOxd6NEpVc0TI7dV
	ooYMUTRzV1pdD7et8GisA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545861; x=1731632261; bh=+
	cKsHqUdRIqVh7tWBD/bK/cAI6O3Bzd18FXNBICgPtk=; b=fNjGWWU1iN9ZHk43O
	Hks6z+3cOYVcXAjpniPMvOc3hZAvqdgk9fNLHJwXpn12e7d/CUXazibwUc7m8ME7
	WVQPDmYIlAiuxTH/p50g2iMisnfd2GJPwwQf8cZepZ10iNL/oHX6VV/OklEKDeuj
	Vk8pPugHpTEgnxc80eMO3/Tqr2WawbGRJ0U0qsyFy3thfXIjUClRAQkubiniz2Tc
	Zm54dOA4K3f1rORJylKgm1CShI1ULsM5PMk7rTji6De/ojHFSOQfqzcYLTTXD7Ly
	mu/UJ+nn9r6QJVHCOkdf4LScZ6Lk6cKcG4UbzCJ/wTCjpPPjk3iDtiWlbLnGHbyf
	oj91g==
X-ME-Sender: <xms:BUs1Z-Lap-l1rchG5AGJfVquaRUyRiPDLISQ7awOZMQ4EyDz485IGg>
    <xme:BUs1Z2JabVcgna0cVtvOJ7UKWLXljMVOWEICIEpi9GaWvUPGMcbxlOMGxp-LAFQPQ
    c_nx4SNZfCCmoDSvxk>
X-ME-Received: <xmr:BUs1Z-vfe74kNm-Xjb1K4geZrVpBghzWPENl7ZgHPCrvk6JioOZloEgcxxNfc3xpSzW13Kl12zRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekteelvdelveevueeu
    jeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgvrhfuihiivgepud
    enucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdv
    fedrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsg
    hoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehklhhovghn
    khdruggvvhdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishes
    figutgdrtghomh
X-ME-Proxy: <xmx:BUs1ZzblcuH1WFB3A_o7oUUu2GRqoLf3RFMSD7IkiYJ3hcoeRzWZEA>
    <xmx:BUs1Z1bg5ZWSHSd4afgYGahn3lkDdcRx9MDAV3W1TO2G6TczBjsFrA>
    <xmx:BUs1Z_BknD4ua4OA_QGZfi8PI-RJd_WQHgmuDfprX8sEIR-o2zc8sA>
    <xmx:BUs1Z7YrJMs0oUg85J9DXY7dH1qpvN0xaF6ovCYP1mybjs7YhSDjpw>
    <xmx:BUs1Z9LWXYP7ZEKXluYIZ2frCnbllkqIjdqkRwrFDt7rf8LbCGqexqBH>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:57:37 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	me@kloenk.dev,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v4 11/11] rust: helpers: Remove uaccess helpers
Date: Thu, 14 Nov 2024 10:56:31 +1000
Message-ID: <20241114005631.818440-12-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114005631.818440-1-alistair@alistair23.me>
References: <20241114005631.818440-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 rust/bindgen_static_functions   |  3 +++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/helpers.c          |  6 ++----
 rust/helpers/uaccess.c          | 15 ---------------
 4 files changed, 6 insertions(+), 19 deletions(-)
 delete mode 100644 rust/helpers/uaccess.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 8bc291a7a799..ec48ad2e8c78 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -27,3 +27,6 @@
 
 --allowlist-function get_task_struct
 --allowlist-function put_task_struct
+
+--allowlist-function copy_from_user
+--allowlist-function copy_to_user
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 63b78a833303..7847b2b3090b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -24,6 +24,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index ebe3a85c7210..42c28222f6c2 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Non-trivial C macros cannot be used in Rust. Similarly, inlined C functions
- * cannot be called either. This file explicitly creates functions ("helpers")
- * that wrap those so that they can be called from Rust.
+ * Non-trivial C macros cannot be used in Rust. This file explicitly creates
+ * functions ("helpers") that wrap those so that they can be called from Rust.
  *
  * Sorted alphabetically.
  */
@@ -16,7 +15,6 @@
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
-#include "uaccess.c"
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
deleted file mode 100644
index f49076f813cd..000000000000
--- a/rust/helpers/uaccess.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/uaccess.h>
-
-unsigned long rust_helper_copy_from_user(void *to, const void __user *from,
-					 unsigned long n)
-{
-	return copy_from_user(to, from, n);
-}
-
-unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
-				       unsigned long n)
-{
-	return copy_to_user(to, from, n);
-}
-- 
2.47.0


