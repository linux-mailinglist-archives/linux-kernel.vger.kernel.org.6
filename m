Return-Path: <linux-kernel+bounces-403963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983109C3D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6C7B254DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0B19ABB7;
	Mon, 11 Nov 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="cmthzs6q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlCaaQ3v"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ACD199E94;
	Mon, 11 Nov 2024 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324409; cv=none; b=U/qyYt7GNPmxEb7Kpn/4+ObgbBdOZrkX8Q4oh7JaL/6prTtSfXbeV589JanGW4RrA6wez9yZ6XknStEay0RRxILjl/3/FATPJAmevnsOLvvlKwo2QzN7kRQh7FalKp4VoQdzR/lut3UwekDoErU2BnlR73P0ppJyUH4cSu3SASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324409; c=relaxed/simple;
	bh=GMuaS4QDIQEpCiX5szW+r4txCCG8ieqMcikkU2eW4U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzKetQJX02T0Bf/InOQIRiIAkkSw3UB+IyAPCXmpgyYQu9VShl575njma6b0JSdmYf5Sp86TvKICnBXO4HpJlbdS+5tsNQA5J7jygml9bKhr8tx/+3u/yq/kNF6wFb1qolDX10hDfQQ4KxTrNVvwVB0VtaSNanIt5FlFkoZRppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=cmthzs6q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlCaaQ3v; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B1544114011B;
	Mon, 11 Nov 2024 06:26:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 11 Nov 2024 06:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324406; x=
	1731410806; bh=/QZTLtT2lWye6dYH5xNL5OIi64neWskoWFOZUezPH64=; b=c
	mthzs6q6BIiYR/K361aC0qc4OAPnOy/KHfY5d6gIz+ke5zS2YXmHMEl+gj3xdeiX
	FCt/fbU0pQH9bwfZC1w7IDNYN1KryqPEvXf9I3Re7y5RmAxACNf4ulQWCJoQsm+N
	jFKp2mkR7cOLhSK666IbMei0j9cGjPQTUBgOlbTPcoperZ5RcIFTmLUkcrOFhu2h
	1MyLs1JSce5A1yOpTN60+dM9cyn8mXLTSIQI9Rly2wuZa/Wka0RGAsF4l4/OD6vw
	vOcYDIm1NJUFydzTkUaX8Tl4S1BMRoL3inNS783/7ZNESLy+SOV43ouNzfJ1oRb1
	z3RQtq7LtSirMha/CGARA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324406; x=1731410806; bh=/
	QZTLtT2lWye6dYH5xNL5OIi64neWskoWFOZUezPH64=; b=QlCaaQ3vMa5E9lkvV
	Zw8NAcn5KV7XQar0wPNPqXSSyRTdQWhEjHU0QtfZlgCi6Nxm5CwQIWO+synIyZ/U
	pcTG/8JJZROp80c+T/C8m2NhA6aku9DMCkogBwTyJUnLFSl3F8RUFExRDub6d0GO
	41pO20AvhUFwU2zmhvaBf60R9v+pSzvOEGLSzowrkv+uywmcjNijlEsdqo06rgFc
	IccAWBlj87LiaESS7thVTM2j+QaiJxoBRbhSg/qnYTBwvDCOEEsrbhKqQy57IvJi
	DKkMh7FO63WphZ+cLD5LZyXex758HuHhuAc/seBJ7ub83kXaPK01TwHfYAjxH+z4
	QsXGQ==
X-ME-Sender: <xms:9ukxZzlEK0TVbS-hnq1BIS5lDN5NwNkepzzxmtluslcTsn72qat02w>
    <xme:9ukxZ21eOYCGKeq1L4sGOqP6_VmQRH1oyUG0MD7VS0lpXrSh1Nm4njj2LvRohbFPH
    dVfB5MC9hbnGXYRTnA>
X-ME-Received: <xmr:9ukxZ5p6H62OJUvJve0oDOVqS_bsvA0HLr-y1nghwvVFFWY6W5gWqQXs06OnPEGC_yLdTdKm066U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehtmhhgrhhoshhssehumhhitg
    hhrdgvughupdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9ukxZ7n7aNWS3RXBQBlTFS2iwXvaMTcU2Rq4qbKg4JzVq4ed7f_QxQ>
    <xmx:9ukxZx0oq-goFlxhC-sWmrj7sw1rQqnhRxaRWFV71bUYOsvVGT6eRw>
    <xmx:9ukxZ6u-jHijT6tpi-OF9Yaxlep9TXFDJ4NZCO-E3UMSgSQ5fyrJaQ>
    <xmx:9ukxZ1VifEmqs_JApDs9V_Vlkzju4Yv-K9Bxj7QzX0tPRQG3Usab6A>
    <xmx:9ukxZw3eZZGs6wt3EECaUZHuNFeW0k47gdacWvtB8Tq6p0eQgIVjz430>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:26:42 -0500 (EST)
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
Subject: [PATCH v3 05/11] rust: helpers: Remove some page helpers
Date: Mon, 11 Nov 2024 21:26:09 +1000
Message-ID: <20241111112615.179133-6-alistair@alistair23.me>
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

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/page.c             | 5 -----
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index b4032d277e72..ded5b816f304 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -11,3 +11,5 @@
 --allowlist-function PTR_ERR
 
 --allowlist-function kunit_get_current_test
+
+--allowlist-function kmap_local_page
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 00b1c1c3ab76..452f8afc9b09 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
+#include <linux/highmem.h>
 #include <linux/jiffies.h>
 #include <kunit/test-bug.h>
 #include <linux/mdio.h>
diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index b3f2b8fbf87f..52ebec9d7186 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -8,11 +8,6 @@ struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
 	return alloc_pages(gfp_mask, order);
 }
 
-void *rust_helper_kmap_local_page(struct page *page)
-{
-	return kmap_local_page(page);
-}
-
 void rust_helper_kunmap_local(const void *addr)
 {
 	kunmap_local(addr);
-- 
2.47.0


