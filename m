Return-Path: <linux-kernel+bounces-403966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0699C3D32
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC88B25850
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3E219CC25;
	Mon, 11 Nov 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="G6iUsE6b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QGy2i3Ss"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B5E19C569;
	Mon, 11 Nov 2024 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324423; cv=none; b=Ftv7L0//OX6882APmzKLrL25QJPqUx/ZpQ4dbuNRjgI1l2k94xPBkz4LesMv5SsRUy5E+KQHi+gOd1AiEfGH0nlmOGag0aJzthYbLKUMreDpBrdqgpoN7ypWBrHkRO1y79jNBv2JcuJYKpQImr5ImK6ihQ06S/JDreJsBuQizdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324423; c=relaxed/simple;
	bh=Y4JvU57X6ir+1mDm/+JX72vbO9dSqe4/Crr+At5SFWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jETg9lf1hoiT1/gliRjcRPpXQIB1vD3ef8zv7Chima2H2Ezd+xqvz5mJnrMSmAdMG7cgLzzXFKraM8iw+bJAwR7tnjyeyjULG1F7Pag4oR6hFp9l52hVZDG9Q80pCSDoIwPlF5T9SU1lr46ug4tzt8+FdxHuUDM5WZCI0exDG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=G6iUsE6b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QGy2i3Ss; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5AA51140168;
	Mon, 11 Nov 2024 06:27:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 11 Nov 2024 06:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324420; x=
	1731410820; bh=6UEOUB01K36SAy7a4pudUqlYFbJ+kyQEawJpvVXUrAA=; b=G
	6iUsE6bdXWu6lXYl4YgYYvECwWv1EJkrCm5LjRdJJDdkufSK9I5xzaQ6nXUjltQZ
	4GqrJhc4a2hJt+HfV26cGiKPM6O14H6UpbkEYBxZGVEWbUgY5NusLFFKDI5Iq8qm
	cNU62aJE0PMM//jMGYi+mWLbW6ipGw+L9kjyb8ZvP/xU8McxYBVk7WuyIdnAOl+/
	6kn/JtO/GG632VCeFzTb65771rO8hB7QLpr3LQECnc4ITTIJWO+wFnws8nlmDnbc
	R+BNtSbFUys4GQfKZgUAdjD6Ul8KafLJCPcQeDxbkad5uQYe/xjkcHTCFAicSl8y
	zV9OAMGu1RijMBiDJtlmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324420; x=1731410820; bh=6
	UEOUB01K36SAy7a4pudUqlYFbJ+kyQEawJpvVXUrAA=; b=QGy2i3SsVhrmH8bXF
	nGX/ilK6ujGCTegBwTr5YWsXTC/LZlTipyuj5Nkg673AYxkrzgV+Jt1FJHzBMVc4
	agg4y0NVyK+PPbk+wAh1Jlm+xjQ+LBoLLPUKu0IdX8D1oUwEwIz1Fl6MGIpY2cnj
	RqMwKs5SRNt2dK9YDDhVawx6j+2OPhsM1liSNVRxIXvTSNrjLpXNqzeA+4mSz7hi
	PYM6v3VLkqE4BxQd41KYVaYvfBMVXm93/yhKlxWiL5D4FRx3umGQe7jSB/d1GA85
	tTy26wHQCSOiH8qoCeAaoLLktTnt3DLQ7CanMO9gdp+4Nfd0qysmpoOXFVAQJqHT
	lkfgg==
X-ME-Sender: <xms:BOoxZ8369W6PnY0qwIHdTZOyguPSj_iiIlIibLTLaIIR0FdsUeZqNw>
    <xme:BOoxZ3ETAoHKR0DKA_5ob2Xk4UGQZChBMSJ94ceMLHdVSjMfC55y-B-pwl04xl208
    S3LN49L0CO0Vc-Inms>
X-ME-Received: <xmr:BOoxZ04l5qy03WbgEnunBtQU37L2NIyMZxk2NBoPgvTpKOaaNgQf_Q-w3pFDz3gAW0wE-fhmT4wQ>
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
X-ME-Proxy: <xmx:BOoxZ11iTbCg9QZiNPm7JM3XNAIgtJJwgwxvQSz1p5dlRnrUYBBF2g>
    <xmx:BOoxZ_EzUieSJ3xyhMnwf8-N1KtTeASsHITKA-MYoS0dc8xw8CoDbg>
    <xmx:BOoxZ-8_vfnJl7OPjDb7-YYcc_orq9LJkpmL6TE1Sg5ScpoQnoSjKA>
    <xmx:BOoxZ0mE9gEE47v7NZAjH_9R34KzuI0sNRAOdVIBQHfBGVJEIeSTgA>
    <xmx:BOoxZ5EY7iIhv9Biqg687qOb50SbNE12zyilHDOgXkoQsb2fgKXQJcSg>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:26:56 -0500 (EST)
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
Subject: [PATCH v3 08/11] rust: helpers: Remove signal helper
Date: Mon, 11 Nov 2024 21:26:12 +1000
Message-ID: <20241111112615.179133-9-alistair@alistair23.me>
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
 rust/helpers/signal.c           | 8 --------
 4 files changed, 3 insertions(+), 9 deletions(-)
 delete mode 100644 rust/helpers/signal.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 9c40a867a64d..407dd091ddec 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -18,3 +18,5 @@
 
 --allowlist-function refcount_inc
 --allowlist-function refcount_dec_and_test
+
+--allowlist-function signal_pending
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d7591b709407..e21a5f260e3c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,7 @@
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 39adea78a647..ebe3a85c7210 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -13,7 +13,6 @@
 #include "mutex.c"
 #include "page.c"
 #include "refcount.c"
-#include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
deleted file mode 100644
index 1a6bbe9438e2..000000000000
--- a/rust/helpers/signal.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/sched/signal.h>
-
-int rust_helper_signal_pending(struct task_struct *t)
-{
-	return signal_pending(t);
-}
-- 
2.47.0


