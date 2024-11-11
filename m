Return-Path: <linux-kernel+bounces-403969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4482F9C3D36
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360921C2297F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C1619DFA2;
	Mon, 11 Nov 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="ZReCH5hG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nKiGXhPs"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FB19D8B4;
	Mon, 11 Nov 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324437; cv=none; b=gLNKX2TcfeJBgLpbsO5zpwsxLwkiks8puvLT4V3xvh9jLnt65JOOV4kbqGdPChqspZKfH+rNSgcVisW6r9Ima9vKmxZ+ghstFZ8xJmEeC83YtcZLmzELcsWP+gx/LeQnbjLQXMB+HMoutn2iwOaeSLSTK3MwCKdNGT5I8nclkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324437; c=relaxed/simple;
	bh=zTGp2tNg+iUcSEL7U57VPmRiKo5PyUGyTr5Wzj3OZss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gARnDjP1jfPez5O8q5/J4XyiI2aEoKQpA9a9E+SMcs9v43ISHnDb4NFeB81WiiyWhDQocj5tFH/TJNIAW/ptZS6nGZD0tFASrqIQfJ1tLZrYzfJfOF+heY/WlYyXbc+IIc0wUqQv9dIpzefTSPWJBHyWG2Vfkr9aQcxn61TBE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=ZReCH5hG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nKiGXhPs; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 48A3E13806A2;
	Mon, 11 Nov 2024 06:27:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 Nov 2024 06:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324435; x=
	1731410835; bh=9Edqij0qmUbgqLwK4hO3iEBCcscgXfAGElwn+Vgc2xs=; b=Z
	ReCH5hGqvGAi93bmP6cpjuWqpanszsYw/m7Sa1hyX0UELdKzqqjX/KoIdVPIKzZl
	2catNhmsCuxb/hsR7pb2tjDD4Qc1sezaDubmuHYUYpid5YPbav7gziHpuZ2eJZ7e
	ZTwICaHRcGdqctoVDOh9UhzyIZB4smkK5Hgz4adsA6aTZmc1vBiYCYONRJReCbvB
	cUJCReH877LQ32yqxSW7JQuMnfAHLjXbSGh4ddx+8/GyftlfyuNs5HpOzkMS/Mw8
	jqfYzDXvzPPWg6YjR7JHn4kWXZAMZEKii7wSK8NKMoHOfEyHI61tYaspN0PN9bHX
	3VpHoimzhdJ2wheTBBSpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324435; x=1731410835; bh=9
	Edqij0qmUbgqLwK4hO3iEBCcscgXfAGElwn+Vgc2xs=; b=nKiGXhPsMfgugeJZ4
	OfYdf16mF/Opy6TyMKOPy7TiqnKiFk3ZM5S4hG484fNquwe1CUJl0UxxOUYcPajb
	b76Oyh95IGpIIVP/EUX+diAKfP7FupkYP7Zf3JQpkeyYNIDlTCEqcIaQkS0r9bwg
	Jc+i30BpuvnMy1hONPT6tVeSK3dUieDYWuOgR5wQDsu998iUSl6xe6vVZOn8jgjG
	4zPLPN/IvukqgcbVXeDjDJ/YgRbTJj/R/40GgevS/cks88PBg9qbZ6lXO26FADcE
	3TzeIk8d6SqYUqysebMU2+p3WeCOOIA2dwIDxBsXpvbPiwIZwe6JTx90BbwBEo++
	t3PkA==
X-ME-Sender: <xms:E-oxZ_rh9c1NLBeeN7qchYF6s98lZflwAGGC9E-Loedas6OgxIe4Zg>
    <xme:E-oxZ5rvJQGDJVkuDMjkT8UPDqyUC_kUpd2czht3x7T65L33iTleE1BKRGBQV4y35
    GkYS19qQpwQMDg9pIg>
X-ME-Received: <xmr:E-oxZ8O4w_dhFDB8IgIwUGZrLvlj_jD2YygGjgvkIveoi_aymPj7esbettB50yXK63CeuIAgSECM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehtmhhgrhhoshhssehumhhitg
    hhrdgvughupdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:E-oxZy5J_AiYqeXogcrkQnmmJU7G6dzW3X2ZFfchP0y11YqlfyP5rQ>
    <xmx:E-oxZ-5A1hNjKRRNaI_1Yh9h63C-kGql6cK0Xcgw5WDCZC9q-75B4g>
    <xmx:E-oxZ6gV3rAUIWKpfujbZEWlRk3gzcxzZchK9J5x9U5bWJMhKIAfAw>
    <xmx:E-oxZw66ge-WlBYW90WyqYuoA7n3AQgvs8W4h9WOiDhf_1O_TRYrKw>
    <xmx:E-oxZxqVcv3kUt4AB7OsI8LTInRAsD4GanpvBfuLUuNpwBvwOrDTLmbO>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:27:10 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	aliceryhl@google.com,
	gary@garyguo.net,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	alex.gaynor@gmail.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 11/11] rust: helpers: Remove uaccess helpers
Date: Mon, 11 Nov 2024 21:26:15 +1000
Message-ID: <20241111112615.179133-12-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111112615.179133-1-alistair@alistair23.me>
References: <20241111112615.179133-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
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


