Return-Path: <linux-kernel+bounces-403964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD19C3D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64C51C2200C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6C19B3EC;
	Mon, 11 Nov 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="EOjsD4Nl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hlSSU82p"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C341885B0;
	Mon, 11 Nov 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324413; cv=none; b=P4Hmux/Oq7EwfXviEFr9FDAOzo9NvUB8MVSZGQ6TbwZgvTbL8B5blPvCTvLxh4Iw0tuczIHGYBwPl+lTxP9ZsaB/Lckz1inSso8TtD7mfShkPdYU5ZT6QjU4S2dRHCiLhViojdiEhrXHxQVfCfqLUPJCW9g6RJ1QWJQRPVHXgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324413; c=relaxed/simple;
	bh=smkbaBTw/7e9dIxKPtuwy0mQ6QjLYCQpxHYDMsCZ7g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJZUzVumRWQycNwWaASDMAcGbz6NozNo+hmeUKBUFG/L6mVH7432JvN/xIR517Q226Abg7l09q8jH1tIVLaMqOnbWfmRLfk8rvKYAOqqFaDG8YkInzjqagJB+Mv4WHBY72NJITDd4moCZSzQI8hAE8ybAI3IQmGfOtglNl+6gbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=EOjsD4Nl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hlSSU82p; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B33C1140158;
	Mon, 11 Nov 2024 06:26:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 11 Nov 2024 06:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324411; x=
	1731410811; bh=d5wQn60NOuuq4X212FSUMcTjiXVPeanrUkv8HB5ANgE=; b=E
	OjsD4NlVQ+P+LC0jw7DPASHASfiplXiwSLooARW7T+L0ELnnmhw0gnZVKFfG+JP3
	dgZhmb/Y+xe5NoEpDjEXEIMBz/rWoPnMrwk1cjRGdK6b6OR21KbhR/DV7g9tG2Kb
	waKoajgSFRenBqc/D0kctsU4SmctaRw9tZyZ02eCv8FrMiARVnIUKOz9PHitqskH
	d/K1tYCnC2cj0ILstR7A9WVe8/YBQmaUm5EXrkHTGFJDUsjwUDDfBoffCfTu46S3
	rSW1dIWeXAcJ3aYbB7Z//oeMN+CjJeF6ho+mBmbYHkfU++gf4WfIuOlQwqBSA6rv
	KZLELqsgnkAdYDnYEsBtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324411; x=1731410811; bh=d
	5wQn60NOuuq4X212FSUMcTjiXVPeanrUkv8HB5ANgE=; b=hlSSU82pxBe5nMJ8P
	/tzfNJrBu4/Dr+LFSAW8HxDwMaQlEJlFvCTJ8fycsomlOIZEJXe/Y76ajTcbWvbO
	EGH0qQ80Fwn0CPqta5wlSMpK71pMLdn7XeeHQ3ViRlKXLFfqK4YMR5DivnAwWVMa
	1j1dGClas1NNhR4muwxj0RQwbsDgSD60vlIoOwscJnbGl7SnEjKPJptDgMKL2aj+
	IxuGMIpJ+HQ0vHI5NCdewu2dYfLLA3GzmYqI7GXbJTg74X/PySnlJ17aOUPfRNlj
	t6FU3tIFsQifB6pVQmZY0cu3M9HKlVv10u9KzA0DxC8f1YTh1JsykoCpoh/Y1P22
	M+C+g==
X-ME-Sender: <xms:--kxZ2o7hCd1tUAm1ac8D5WnglcmYh-nZJbLrtiAx9WS0LGd0z8RnA>
    <xme:--kxZ0qkXJoMcSSKjwwFEO6_WQ7pIVuX1tQwtHYte3-ezSg2JqJ_1gk_tZ2PELvyH
    VuDt5IDPNHRCsHfLNM>
X-ME-Received: <xmr:--kxZ7PHpIyy2d-DLPYin-aNYoxy5uLKhXnmtXIWCyNEntQRZ9rtyjDCg23OJ6_xqSNrF-GIt7fE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehtmhhgrhhoshhssehumhhitg
    hhrdgvughupdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:--kxZ15Fe4VUVCE2jSl83rG5xisbDizTj8KIDRiPq0EolYh0Hr9T2Q>
    <xmx:--kxZ17BukhC0vyuyN3DRBcXXlTHraJi9Ryeyln2nM-hyYeunnESfw>
    <xmx:--kxZ1hlzQiaQn2haija8ynIUYMoQ4-XM-vanCQcNF4v4i0wC8WyjQ>
    <xmx:--kxZ_7HPnjxbYC3_FSqLzpcbDJdXHOuAkg9_ZRIWoWVDSzNi1hQlA>
    <xmx:--kxZ8o7xZdVijmSb0LkBDo_cCDFmdK4fCSbR0xYK1Jb5yLQdL-f804b>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:26:46 -0500 (EST)
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
Subject: [PATCH v3 06/11] rust: helpers: Remove rbtree helper
Date: Mon, 11 Nov 2024 21:26:10 +1000
Message-ID: <20241111112615.179133-7-alistair@alistair23.me>
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


