Return-Path: <linux-kernel+bounces-403962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002FC9C3D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8524F1F233F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62506199256;
	Mon, 11 Nov 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="bfR/7cJ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FyHK8l00"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10CD18A925;
	Mon, 11 Nov 2024 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324404; cv=none; b=kwGshAprzv7hrCcNsGDyzF+LqBgqnmqRoNCkyHhonoervoOV7Qtib9bXbWbBSk+tYyneAWOSp+wiuZHuTH3bXIorj6t/3tJMHCEvYpG7UiIX4lVKnRDOmnWEKxn1jrjMQHly6wgXvdfds8ZldFinoAARyyvVfIIJoX/QitI3rJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324404; c=relaxed/simple;
	bh=KfYzRBx8hqlpoHlW7Rtc57+XWE2jcubBYr1j8iDL/k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKBOp5E/KwoKQZRU/aahyYo5oKbRlpHMRHfEsRkC2Vz5CobAwGbBrUqMJ7kykc4XPvyYc9QfWJ2SbNFOJxGj27L2+9dCu1xgaTLTWDkZmcWe1hqlnpXGabysT26q8n952FNoAGuDILQBclMCTTe9Q8euyvI/PRYTeRKspQWm5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=bfR/7cJ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FyHK8l00; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 051361140113;
	Mon, 11 Nov 2024 06:26:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 06:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324402; x=
	1731410802; bh=REkDqjw7otbgawUP+tllfahw6R9deuAH+VzUmIgzxcw=; b=b
	fR/7cJ8M1EOUjUUIBxO9cZ964OBzebSDIfvPKQEZ10MB0UiW1H7av2usrcZNU9S9
	RSnvL9MpOgI2z+URWnCG9e+hQhh0SaZ2X+KbSiIfEc5PYdlI9kVsfUucr96nzQkP
	VC1a3N7lUU/AVdBFaMju/gXGMtCUOStGumqeSXOZIF+C/bplSyLg5FfXVNE862z/
	jF7KFlEOmcwk+lyOicXuEFWifkXXccIcELDN4+u7Tu51nq302k6LKfGtvcCzHfZZ
	RSN5N0hCPogaMJbu2e0HTeBzXYJl2MvgE6SJ3mD4VvQ9YEqu2fHK2WyaXgI2XiLW
	F7tFfsdln59bo4e4e12dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324402; x=1731410802; bh=R
	EkDqjw7otbgawUP+tllfahw6R9deuAH+VzUmIgzxcw=; b=FyHK8l00ElvWlzBYJ
	p3ySaajcwzCAZ0TSmrXGLurH0nKf50ai05jPLJG0dpz3WQ3TA5VhC2dkaqDl3rSs
	AbmVk5S2A/600AGzg6jfv4jwbnXNoFCogDAuI4r+rASBQIl5b4heUTUTAKiQ2OtW
	ybosJgq1nmLN2AQrWbb57sP+BKB6w5BgRbGqR/cFOvbMDbkGeXCcXKiRMlyNMsr1
	zJ/l5Pq95CBdkBm3AmsWVfOMIm+/dG/qRfe9gwFtie3kcxNEohBn3v7FWiw/kmLX
	4dRWCFZYlp2Wu31yuz5r/5nL3k3bVKbWadeDJw0MNgiStSVnK+z+9X5v8B6xIn21
	Gjc0Q==
X-ME-Sender: <xms:8ekxZxS23tDzshbBa0b7bGMJZtpKkucFk6M4askQvH8KmYVIHl26Fg>
    <xme:8ekxZ6yaz4ASSxzpkB2pBXz8McEbROSuxtzPj6VCEQkmKHNXdWQ0JgJvZWAUev20B
    XcWuBkz3-SkvLTYITU>
X-ME-Received: <xmr:8ekxZ227SxMgR2nnWV2PlEkCW1CQlquMs38cZGySNqxF4NA1DMu00XOLAv3VAl6t1JcPaKb-WRiM>
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
X-ME-Proxy: <xmx:8ekxZ5AnAtUu7XSWis3xUKcjq3XO_8L0A5GGPJfCoe-Gtibt3S_2Yw>
    <xmx:8ekxZ6j8eTa8yKDovCK-vM85iwZ0FncV7fq2w4LpnXFYN19FdWqGIw>
    <xmx:8ekxZ9oftuaeBBsZce4IcuB0jWfZzcNocL1Yfs02HsnM6eO9HFUHLA>
    <xmx:8ekxZ1j9vrfjQo-bBDNPlFXg8LiGKq8mFAK1plORPjdW3ox2VZP1Nw>
    <xmx:8ekxZ-xIGT13sZ9faMmAbl7yHL2CazpyC25y34qL5XDXysnBuQns9kgW>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:26:37 -0500 (EST)
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
Subject: [PATCH v3 04/11] rust: helpers: Remove kunit helper
Date: Mon, 11 Nov 2024 21:26:08 +1000
Message-ID: <20241111112615.179133-5-alistair@alistair23.me>
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
 rust/helpers/kunit.c            | 8 --------
 4 files changed, 3 insertions(+), 9 deletions(-)
 delete mode 100644 rust/helpers/kunit.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 0269efa83c61..b4032d277e72 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -9,3 +9,5 @@
 --allowlist-function ERR_PTR
 --allowlist-function IS_ERR
 --allowlist-function PTR_ERR
+
+--allowlist-function kunit_get_current_test
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a80783fcbe04..00b1c1c3ab76 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -14,6 +14,7 @@
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
+#include <kunit/test-bug.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index e089ecdf091f..60b3fdc5c2de 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -10,7 +10,6 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-#include "kunit.c"
 #include "mutex.c"
 #include "page.c"
 #include "rbtree.c"
diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
deleted file mode 100644
index b85a4d394c11..000000000000
--- a/rust/helpers/kunit.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <kunit/test-bug.h>
-
-struct kunit *rust_helper_kunit_get_current_test(void)
-{
-	return kunit_get_current_test();
-}
-- 
2.47.0


