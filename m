Return-Path: <linux-kernel+bounces-408503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023ED9C7F98
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856B61F2310F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C0D52F71;
	Thu, 14 Nov 2024 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="jJTjMRxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDr6NiL4"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0F4CB47;
	Thu, 14 Nov 2024 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545836; cv=none; b=tpGQFlfrfEaH2JcPBb+b9hJ/F1yinJzqy7WHRPecHpAzB51KpjVLvmaTApLkgeapH5nN1f9ZqHvlyEMLbJVjYPYZ13Gw8m1mOdAr44CRK7nzJkWvGtwXCwWRlUtC45OCaKqxiFdUdoQtinbVKCsDQuA224BK6fUidlRPyamV9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545836; c=relaxed/simple;
	bh=b3G7TYn/khqwTZ5Rwoif9OCtQVXwntJH0+P/NfRT6Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGtQAJkmmpcZFaUGcw7zO2+7ndIIxk0cO3tl85Egt+ugqGTImHSw0a6KwynnIrHfCJl2C2U6H92iAmCQmE/NFx9Z9XBKqdlKV7dlmcUdUjyRbTbdldn7QwGEiyjF1KAOWl+zPA9/db5jZmZMB8D2wPSMu9KANIpAFWrPVs6gsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=jJTjMRxi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDr6NiL4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id B84311140215;
	Wed, 13 Nov 2024 19:57:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 13 Nov 2024 19:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545833; x=
	1731632233; bh=6nKfsGoXPcHA69T26BhjzU2l4D/x3cxlhbzWSMf5qAE=; b=j
	JTjMRxiPuzcgDORTao5nr8XgSWwfMSqHPwmvvlrn0C9d5KOiVAIjVvmgUZnoLYNm
	vuh7j5o61uypgDQAe0zzDoynfPGaJ5hd7VmAWxZi+ZmBQ2fEg8X0uDkyBS039GGh
	5XMTxOQgISnsPjqDvAm2QC7bIAEwgjKTbMSQeOguqH3lEwu+g2ipkVPo5/XvvxD8
	FTKdwIXElX7Z8VqkzF4SnBvnBEj0knlh4v9vk/NEQjsHDVlp7pfUHpqnZCco+gb0
	CT3m7wtlGxjCh9R/Zaf2ok+XisiEjKUG/HwQ6fvWNdbct9uY3OLzD2ihJ3YQj1Jq
	0g41jZsoktjwE3LCbnMtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545833; x=1731632233; bh=6
	nKfsGoXPcHA69T26BhjzU2l4D/x3cxlhbzWSMf5qAE=; b=CDr6NiL46muwkBYqJ
	ldi2JMTdR0c6fccuUeVlIbqwLjaxtVbc+yjz/xE3jHIshTXuk14boLWbFaeCLvJd
	ynq8UnKvS51+9YJvFV0r/U0mxYbifpWhg6evSlwKjQJ8ZukLB7m5x2xi45lmX/Oh
	qtmMD5L2/xra6abD9xaocGUXAXf37I/+JOkxM2BFL0cvYArjk1/SxCHjVVmPjaoM
	2ILO8wwJHxheykBS39e5kW8+sZpzfMOnso/iATULqUJ473xWZ7/eM8pqZGLTGDKB
	GW4FL9UaNrsGyy0nq/aR4QsybMwjvNC3hNZFKZnxyVDv75wEbItLsYGCCiZLXaD4
	uhHlg==
X-ME-Sender: <xms:6Uo1Z1Wu6OVhgLUW7mVTWqBLJJjVqI_VrqlxqK_WyUUS9hY74JWgqA>
    <xme:6Uo1Z1m0BKUEjyeCtXK44fZRYYVt9RGDFmTcRgMBqhjTrz6n62poPhQf6MChbWq3k
    ZXWZsXliv-rCc0pAwE>
X-ME-Received: <xmr:6Uo1ZxYYdeTotoxKNwNmrvxT-4j7G_XZYeRXjRznoRUovZKjFi96sshG-qxSJGHSSHqlNlW36AUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekteelvdelveevueeu
    jeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgvrhfuihiivgeptd
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
X-ME-Proxy: <xmx:6Uo1Z4VxqgYxUdT6Z8SKPb7HKoplKxIZjUj2PwN-FI0LUIaau-_KYQ>
    <xmx:6Uo1Z_mXbzHyfD7E1k57gGc-BQgz_NBpnHSkLJ-ttc0kS3Ceu3DMKw>
    <xmx:6Uo1Z1cHgNdSzVgUEyGZKH3El5vUDQRP5K2NqyWIKRXRUp9V6D01Cw>
    <xmx:6Uo1Z5Hb7HBwWC0i-wU9NagorKpX3o4RYoVrrOEpnlCOG_NPkv_QvQ>
    <xmx:6Uo1Zx2C9Q7_mf2rvaHZFzRt9ZBu35e3jrqc3aqHn9DXrr6VI-isNKUl>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:57:08 -0500 (EST)
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
Subject: [PATCH v4 06/11] rust: helpers: Remove rbtree helper
Date: Thu, 14 Nov 2024 10:56:26 +1000
Message-ID: <20241114005631.818440-7-alistair@alistair23.me>
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
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/helpers.c          | 1 -
 rust/helpers/rbtree.c           | 9 ---------
 4 files changed, 3 insertions(+), 10 deletions(-)
 delete mode 100644 rust/helpers/rbtree.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index ded5b816f304..e464dc1f5682 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -13,3 +13,5 @@
 --allowlist-function kunit_get_current_test
 
 --allowlist-function kmap_local_page
+
+--allowlist-function rb_link_node
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 452f8afc9b09..d7591b709407 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -18,6 +18,7 @@
 #include <kunit/test-bug.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 60b3fdc5c2de..39adea78a647 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,7 +12,6 @@
 #include "build_bug.c"
 #include "mutex.c"
 #include "page.c"
-#include "rbtree.c"
 #include "refcount.c"
 #include "signal.c"
 #include "slab.c"
diff --git a/rust/helpers/rbtree.c b/rust/helpers/rbtree.c
deleted file mode 100644
index 6d404b84a9b5..000000000000
--- a/rust/helpers/rbtree.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/rbtree.h>
-
-void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
-			      struct rb_node **rb_link)
-{
-	rb_link_node(node, parent, rb_link);
-}
-- 
2.47.0


