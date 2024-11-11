Return-Path: <linux-kernel+bounces-403967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F489C3D33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7714B25983
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6619D065;
	Mon, 11 Nov 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="azhy4qns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQglz+yV"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ABB19CC27;
	Mon, 11 Nov 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324428; cv=none; b=V5cVWRhyxrVxcLjXYxsr9fuIijkH8ZSul2v7EQ9E0ijtteH4bCU2YJ360xiB5IZGt3u9Xfsikb51PXrkQjbXixWo/gsbpsrzLMTV7HHCb0o33Y2+TfIx6xEGILj9xqavszJlSWXuFeuV2UESl6Cl80X4+sAkf4Iu609CXm6oCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324428; c=relaxed/simple;
	bh=Cc9I2bfItF6VORRBhwQ+2yR1z/lvVBWvY0H7rJ+gQUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qip35CMAn5ZZApLz2RZlORPz5E39rYFAbs2BL4U5O2snvSMhtVYT8VGXQldufMK1QBF6p/5IWVl1bWJPY0sKaGEeXvlC70PtiLiLGqoPT9R0rkp93symZNwOUsNvVlPSiriYk/fLKxm4oUN7uLsxQ5OflklLwqrQ3Q/pEp+st8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=azhy4qns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQglz+yV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF5431140151;
	Mon, 11 Nov 2024 06:27:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 Nov 2024 06:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324425; x=
	1731410825; bh=PxwW2iqkZmOlBEA7liSszqDuU5+i9FamttGbAbW5ZYg=; b=a
	zhy4qnsEib2MIn/JC2OUMOHYvWV1E6qC7JqS6bJpkz8BqFdqKf6ogpL7jv4JxtqB
	qj+eJ3JhrfNlGR+X9nAH60GVqT93RePHhUA3xz/731a/J4FuJaqyvHsngk8OGWjp
	z6p4omewvMCGwpTFWmyty2RxzISl6gz5bCRumCPfpi0bE72inTwx/pY4S3S0njv2
	jmXWLen0Xhg5nfOZJlle0aPLcjJUIuJD+AfaBZ/+U/5/KPnD3lFU0VAuHkNwQgSj
	LCsWmGgRtsMhlAzrbVmYFCbbM5BlPLFe8jKoayoitgY/ha/FmSKrrCVe0qK1TLDl
	X7qqIErwGLne+ftoz3Cyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324425; x=1731410825; bh=P
	xwW2iqkZmOlBEA7liSszqDuU5+i9FamttGbAbW5ZYg=; b=DQglz+yVUQ8SAM65P
	YO+2njeU6nXxxAV0Q8q4gHcd1HNGqfVmpn63IS3SDMp/+89dEmsNZbNAs4iZuvJK
	hriMp29bERpB1ae/KosCOVfbPBhFcPWX/SsHGYaIv7sE+rbyYLxkkL/d5A1NZbiS
	gyLOQEVWhrPgIMtmqrSKjsNcNAYWb32EImBKiSjIctpFBXeV/2qsgVqIxvTYWOOo
	zg1jbbBHyCucSE01+OSU0r5E+bMP4+dYlHq+oIlLhRfIei2znYy4mgg09TXqn5Zi
	pzUpH+5K6XKylZl7ZxmVhWcLKJeTFdw7+oy00I+uL3S+aOtnoWSQIl/AyweliJHK
	118Kg==
X-ME-Sender: <xms:CeoxZ7-0W1uw8xYHscXsWI0IkE4nCYaDg77S7LYzQoacNevAB2h5dg>
    <xme:CeoxZ3uredSLoGasp0FTQEu54EW1o4LrSdu7LtafQySsqwA9kXOdL75OA7zvEcqSh
    pLraIev4qFpR05lMAM>
X-ME-Received: <xmr:CeoxZ5Ddon46KMkk05OeVUcT6TwZzob9mzO2TZ3-LwLN3XnH32hVkE-tGL715_ig2RZ7uC2uJTNE>
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
X-ME-Proxy: <xmx:CeoxZ3ciC6T-UpW_knUN-GOj2Odbf8OCcvieoC1hd7XGQE4_HYECwA>
    <xmx:CeoxZwNbrA3w75h9Az3e6NPmE10_i9J6Taxw_Ql8EWtjdH0fTZhdmQ>
    <xmx:CeoxZ5kO0q1pMYf-g6T0WtJq2Q2lhw_QwfDzZBDIMcusKR9bfm53xg>
    <xmx:CeoxZ6s-N1GYDdU9_vbtJRrjmxj7bTkehlkrdF_YQq8t4FUz3IRBlw>
    <xmx:CeoxZ1tOE_LBk1XclepxCXf0I8OsrTf7c03fAKvKKj4KswQ_1NcftgJ->
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:27:01 -0500 (EST)
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
Subject: [PATCH v3 09/11] rust: helpers: Remove some spinlock helpers
Date: Mon, 11 Nov 2024 21:26:13 +1000
Message-ID: <20241111112615.179133-10-alistair@alistair23.me>
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
 rust/bindgen_static_functions |  4 ++++
 rust/helpers/spinlock.c       | 15 ---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 407dd091ddec..9d6c44e277b5 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -20,3 +20,7 @@
 --allowlist-function refcount_dec_and_test
 
 --allowlist-function signal_pending
+
+--allowlist-function spin_lock
+--allowlist-function spin_unlock
+--allowlist-function spin_trylock
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index b7b0945e8b3c..1c47608c42ed 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -11,18 +11,3 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 	spin_lock_init(lock);
 #endif
 }
-
-void rust_helper_spin_lock(spinlock_t *lock)
-{
-	spin_lock(lock);
-}
-
-void rust_helper_spin_unlock(spinlock_t *lock)
-{
-	spin_unlock(lock);
-}
-
-int rust_helper_spin_trylock(spinlock_t *lock)
-{
-	return spin_trylock(lock);
-}
-- 
2.47.0


